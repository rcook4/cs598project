sudo chown root:ec2-user -R /wip/answers
sudo chmod 777 -R /wip/answers
sudo mkdir -p /wip/answers/$1/
sudo rm -rf /wip/answers/$1/*
aws s3 sync s3://cs598project/answers/$1 /wip/answers/$1/
gunzip *.gz
sudo find . -type f -name "2019*" -and ! -name "*.gz" -print0 | xargs -0 -I{} sudo split -l 25 {}
if [ ! -f /wip/answers/$1/xaa ]; then
    sudo find /wip/answers/$1/ -type f -name "2019*" -and ! -name "*.gz" -print0 | xargs -0 -I{} sudo cp {} /wip/answers/$1/xaa
    sudo chown root:ec2-user -R /wip/answers/$1/xaa
    sudo chmod 777 -R /wip/answers/$1/xaa
fi
sudo find /wip/answers/$1/ -type f -name "x*" -and ! -name "*.json" -print0 | xargs -0 -I{} /wip/answers/loadbatch.sh $1 {}
