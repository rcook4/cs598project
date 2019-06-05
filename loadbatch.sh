sudo cat $2 | tr -d '\n' > $2.json
sudo chown root:ec2-user $2.json
sudo chmod 777 $2.json
sed -i 's/{/{"PutRequest":{"Item":{/g' $2.json
sed -i 's/}/}}},/g' $2.json
sed -i 's/":/":~/g' $2.json
sed -i 's/,"/~,"/g' $2.json
sed -i 's/}}}/~}}}/g' $2.json
sed -i 's/:~"/:{"S":"/g' $2.json
sed -i 's/"~,/"},/g' $2.json
sed -i 's/:~{/:{/g' $2.json
sed -i 's/:~/:{"N":"/g' $2.json
sed -i 's/~/"}/g' $2.json
sed -i '$ s/.$//' $2.json
echo -e "{~$1~:[$(cat $2.json)" > $2.json
sed -i 's/~/"/g' $2.json
echo -e "$(cat $2.json)]}" > $2.json
aws dynamodb batch-write-item --request-items file://$2.json