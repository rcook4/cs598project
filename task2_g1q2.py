from __future__ import print_function
import boto3
import base64
from json import loads

dynamodb_client = boto3.client('dynamodb')

# The block below creates the DDB table with the specified column names.
try:
    response = dynamodb_client.create_table(
        AttributeDefinitions=[
            {
                'AttributeName': 'airline',
                'AttributeType': 'S'
            }
        ],
        TableName='task2_g1q2',
        KeySchema=[
            {
                'AttributeName': 'airline',
                'KeyType': 'HASH'
            }
        ],
        ProvisionedThroughput={
            'ReadCapacityUnits': 5,
            'WriteCapacityUnits': 500,
        }
    )
except dynamodb_client.exceptions.ResourceInUseException:
    # Table is created, skip
    pass

def lambda_handler(event, context):
    payload = event['records']
    output = []
    success = 0
    failure = 0

    for record in payload:
        try:
            # # This block parses the record, and writes it to the DDB table.
            payload = base64.b64decode(record['data'])
            data_item = loads(payload)
            dynamodb_client.put_item(
                TableName='task2_g1q2',
                Item={
                    'airline': {
                        'S': str(data_item['airline'])
                    },
                    'good_percentage': {
                        'N': str(data_item['good_percentage'])
                    }
                }
                )
            success += 1
            output.append({'recordId': record['recordId'], 'result': 'Ok'})
        except Exception:
            failure += 1
            output.append({'recordId': record['recordId'], 'result': 'DeliveryFailed'})

    print('Successfully delivered {0} records, failed to deliver {1} records'.format(success, failure))
    return {'records': output}
