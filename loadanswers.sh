echo "start timings... $(date)"
aws dynamodb delete-table --table-name g2q1 >/dev/null 2>&1
aws dynamodb delete-table --table-name g2q2 >/dev/null 2>&1
aws dynamodb delete-table --table-name g2q3 >/dev/null 2>&1
echo "sleep for dynamodb delete tables..."
sleep 5
aws dynamodb create-table --table-name g2q1 --attribute-definitions AttributeName=airport_airline,AttributeType=S AttributeName=airport,AttributeType=S --key-schema AttributeName=airport_airline,KeyType=HASH AttributeName=airport,KeyType=RANGE --billing-mode PAY_PER_REQUEST >/dev/null 2>&1
aws dynamodb create-table --table-name g2q2 --attribute-definitions AttributeName=airport_destination,AttributeType=S AttributeName=airport,AttributeType=S --key-schema AttributeName=airport_destination,KeyType=HASH AttributeName=airport,KeyType=RANGE --billing-mode PAY_PER_REQUEST >/dev/null 2>&1
aws dynamodb create-table --table-name g2q3 --attribute-definitions AttributeName=flighthop_airline,AttributeType=S AttributeName=flighthop,AttributeType=S --key-schema AttributeName=flighthop_airline,KeyType=HASH AttributeName=flighthop,KeyType=RANGE --billing-mode PAY_PER_REQUEST >/dev/null 2>&1
echo "sleep for dynamodb create tables..."
sleep 10
/wip/answers/loadtable.sh g2q1 >/dev/null 2>&1
/wip/answers/loadtable.sh g2q2 >/dev/null 2>&1
/wip/answers/loadtable.sh g2q3 >/dev/null 2>&1
echo "stop timings... $(date)"
