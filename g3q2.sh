sudo mkdir -p /wip/dms
sudo chown root:ec2-user -R /wip/
sudo chmod 777 -R /wip
aws s3 sync s3://cs598project/answers/g3q2/ /wip/dms/
gunzip /wip/dms/*/*.gz
aws s3 sync /wip/dms/  s3://cs598project/dms
