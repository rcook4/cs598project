sudo rm -rf /wip/answers/$1/*
cd /wip/answers/$1/
aws s3 sync s3://cs598project/answers/$1 .
sudo chown root:ec2-user -R .
sudo chmod 777 -R .
gunzip *.gz
sudo find . -type f -name "2019*" -and ! -name "*.gz" -print0 | xargs -0 -I{} sudo split -l 25 {}
sudo chown root:ec2-user -R /wip/
sudo chmod 777 -R /wip/
if [ ! -f ./xaa ]; then
    sudo find . -type f -name "2019*" -and ! -name "*.gz" -print0 | xargs -0 -I{} sudo cp {} ./xaa
    sudo chown root:ec2-user -R ./xaa
    sudo chmod 777 -R ./xaa
fi
sudo find . -type f -name "x*" -and ! -name "*.json" -print0 | xargs -0 -I{} /wip/answers/loadbatch.sh $1 {}
fi
sudo chown root:ec2-user -R /wip/
sudo chmod 777 -R /wip/
sudo find /wip/answers/$1/. -type f -name "x*" -and ! -name "*.json" -print0 | xargs -0 -I{} /wip/answers/loadbatch.sh $1 {}