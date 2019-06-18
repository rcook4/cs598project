sudo chown root:ec2-user -R /wip/answers
sudo chmod 777 -R /wip/answers
sudo mkdir -p /wip/answers/$1/
sudo rm -rf /wip/answers/$1/*
aws s3 sync s3://cs598project/answers/$1 /wip/answers/$1/
gunzip *.gz
sudo find . -type f -name "2019*" -and ! -name "*.gz" -print0 | xargs -0 -I{} sudo split -l 25 {} {}. -a 5
batchcount=`ls -1 2019*.a* 2>/dev/null | wc -l`
if [ $batchcount -eq 0 ]; then
    sudo find /wip/answers/$1/ -type f -name "2019*" -and ! -name "*.gz" -print0 | xargs -0 -I{} sudo cp {} /wip/answers/$1/{}.aaaaa
fi
sudo find /wip/answers/$1/ -type f -name "2019*.a*" -and ! -name "*.json" -print0 | xargs -0 -I{} /wip/answers/loadbatch.sh $1 {}
