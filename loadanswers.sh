echo "start timings... $(date)"
aws dynamodb delete-table --table-name g1q1 >/dev/null 2>&1
aws dynamodb delete-table --table-name g1q2 >/dev/null 2>&1
aws dynamodb delete-table --table-name g1q3 >/dev/null 2>&1
aws dynamodb delete-table --table-name g2q1 >/dev/null 2>&1
aws dynamodb delete-table --table-name g2q2 >/dev/null 2>&1
aws dynamodb delete-table --table-name g2q3 >/dev/null 2>&1
aws dynamodb delete-table --table-name g2q4 >/dev/null 2>&1
echo "sleep for dynamodb delete tables..."
sleep 5
aws dynamodb create-table --table-name g1q1 --attribute-definitions AttributeName=airport,AttributeType=S --key-schema AttributeName=airport --billing-mode PAY_PER_REQUEST >/dev/null 2>&1
aws dynamodb create-table --table-name g1q2 --attribute-definitions AttributeName=airline,AttributeType=S --key-schema AttributeName=airline --billing-mode PAY_PER_REQUEST >/dev/null 2>&1
aws dynamodb create-table --table-name g1q3 --attribute-definitions AttributeName=day_of_week,AttributeType=S --key-schema AttributeName=day_of_week --billing-mode PAY_PER_REQUEST >/dev/null 2>&1
aws dynamodb create-table --table-name g2q1 --attribute-definitions AttributeName=airport,AttributeType=S AttributeName=airline,AttributeType=S --key-schema AttributeName=airport,KeyType=HASH AttributeName=airline,KeyType=RANGE --billing-mode PAY_PER_REQUEST >/dev/null 2>&1
aws dynamodb create-table --table-name g2q2 --attribute-definitions AttributeName=airport,AttributeType=S AttributeName=destination,AttributeType=S --key-schema AttributeName=airport,KeyType=HASH AttributeName=destination,KeyType=RANGE --billing-mode PAY_PER_REQUEST >/dev/null 2>&1
aws dynamodb create-table --table-name g2q3 --attribute-definitions AttributeName=flighthop,AttributeType=S AttributeName=airline,AttributeType=S --key-schema AttributeName=flighthop,KeyType=HASH AttributeName=airline,KeyType=RANGE --billing-mode PAY_PER_REQUEST >/dev/null 2>&1
aws dynamodb create-table --table-name g2q4 --attribute-definitions AttributeName=airport,AttributeType=S AttributeName=destination,AttributeType=S --key-schema AttributeName=airport,KeyType=HASH AttributeName=destination,KeyType=RANGE --billing-mode PAY_PER_REQUEST >/dev/null 2>&1
echo "sleep for dynamodb create tables..."
sleep 10
/wip/answers/loadtable.sh g2q1 >/dev/null 2>&1
/wip/answers/loadtable.sh g2q2 >/dev/null 2>&1
/wip/answers/loadtable.sh g2q3 >/dev/null 2>&1
echo "stop timings... $(date)"
