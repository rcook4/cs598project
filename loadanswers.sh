echo "start timings... $(date)"
[ "$HOSTNAME" == "ip-172-31-44-141" ] && aws dynamodb delete-table --table-name g1q1 >/dev/null 2>&1
[ "$HOSTNAME" == "ip-172-31-44-141" ] && aws dynamodb delete-table --table-name g1q2 >/dev/null 2>&1
[ "$HOSTNAME" == "ip-172-31-44-141" ] && aws dynamodb delete-table --table-name g1q3 >/dev/null 2>&1
[ "$HOSTNAME" == "ip-172-31-46-45" ] && aws dynamodb delete-table --table-name g2q1 >/dev/null 2>&1
[ "$HOSTNAME" == "ip-172-31-33-86" ] && aws dynamodb delete-table --table-name g2q2 >/dev/null 2>&1
[ "$HOSTNAME" == "ip-172-31-37-87" ] && aws dynamodb delete-table --table-name g2q3 >/dev/null 2>&1
[ "$HOSTNAME" == "ip-172-31-44-141" ] && aws dynamodb delete-table --table-name g2q4 >/dev/null 2>&1
sleep 15
[ "$HOSTNAME" == "ip-172-31-44-141" ] && aws dynamodb create-table --table-name g1q1 --attribute-definitions AttributeName=airport,AttributeType=S AttributeName=airport_most_popular_rank,AttributeType=N  --key-schema AttributeName=airport,KeyType=HASH AttributeName=airport_most_popular_rank,KeyType=RANGE  --billing-mode PAY_PER_REQUEST >/dev/null 2>&1
[ "$HOSTNAME" == "ip-172-31-44-141" ] && aws dynamodb create-table --table-name g1q2 --attribute-definitions AttributeName=airline,AttributeType=S AttributeName=airline_best_arrival_performance_rank,AttributeType=N  --key-schema AttributeName=airline,KeyType=HASH AttributeName=airline_best_arrival_performance_rank,KeyType=RANGE  --billing-mode PAY_PER_REQUEST >/dev/null 2>&1
[ "$HOSTNAME" == "ip-172-31-44-141" ] && aws dynamodb create-table --table-name g1q3 --attribute-definitions AttributeName=dayofweek,AttributeType=S AttributeName=dayofweek_best_arrival_performance_rank,AttributeType=N  --key-schema AttributeName=dayofweek,KeyType=HASH AttributeName=dayofweek_best_arrival_performance_rank,KeyType=RANGE  --billing-mode PAY_PER_REQUEST >/dev/null 2>&1
[ "$HOSTNAME" == "ip-172-31-46-45" ] && aws dynamodb create-table --table-name g2q1 --attribute-definitions AttributeName=airport,AttributeType=S AttributeName=airport_airline_best_departure_performance_rank,AttributeType=N --key-schema AttributeName=airport,KeyType=HASH AttributeName=airport_airline_best_departure_performance_rank,KeyType=RANGE --billing-mode PAY_PER_REQUEST >/dev/null 2>&1
[ "$HOSTNAME" == "ip-172-31-33-86" ] && aws dynamodb create-table --table-name g2q2 --attribute-definitions AttributeName=airport,AttributeType=S AttributeName=airport_destination_best_departure_performance_rank,AttributeType=N --key-schema AttributeName=airport,KeyType=HASH AttributeName=airport_destination_best_departure_performance_rank,KeyType=RANGE --billing-mode PAY_PER_REQUEST >/dev/null 2>&1
[ "$HOSTNAME" == "ip-172-31-37-87" ] && aws dynamodb create-table --table-name g2q3 --attribute-definitions AttributeName=flighthop,AttributeType=S AttributeName=flighthop_airline_best_arrival_performance_rank,AttributeType=N --key-schema AttributeName=flighthop,KeyType=HASH AttributeName=flighthop_airline_best_arrival_performance_rank,KeyType=RANGE --billing-mode PAY_PER_REQUEST >/dev/null 2>&1
[ "$HOSTNAME" == "ip-172-31-44-141" ] && aws dynamodb create-table --table-name g2q4 --attribute-definitions AttributeName=airport,AttributeType=S AttributeName=flighthop_mean_arrival_delay_minutes,AttributeType=N --key-schema AttributeName=airport,KeyType=HASH AttributeName=flighthop_mean_arrival_delay_minutes,KeyType=RANGE --billing-mode PAY_PER_REQUEST >/dev/null 2>&1
sleep 30
[ "$HOSTNAME" == "ip-172-31-44-141" ] && /wip/answers/loadtable.sh g1q1 >/dev/null 2>&1
[ "$HOSTNAME" == "ip-172-31-44-141" ] && /wip/answers/loadtable.sh g1q2 >/dev/null 2>&1
[ "$HOSTNAME" == "ip-172-31-44-141" ] && /wip/answers/loadtable.sh g1q3 >/dev/null 2>&1
[ "$HOSTNAME" == "ip-172-31-46-45" ] && /wip/answers/loadtable.sh g2q1 >/dev/null 2>&1
[ "$HOSTNAME" == "ip-172-31-33-86" ] && /wip/answers/loadtable.sh g2q2 >/dev/null 2>&1
[ "$HOSTNAME" == "ip-172-31-37-87" ] && /wip/answers/loadtable.sh g2q3 >/dev/null 2>&1
[ "$HOSTNAME" == "ip-172-31-44-141" ] && /wip/answers/loadtable.sh g2q4 >/dev/null 2>&1
echo "stop timings... $(date)"
