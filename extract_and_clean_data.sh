sudo mkdir /snapshot
sudo mount /dev/xvdb /snapshot
sudo mkdir -p /data/raw
sudo chown root:ec2-user -R /data/
sudo chmod 777 -R /data/
[ "$HOSTNAME" == "ip-172-31-46-45" ] && sudo find /snapshot/aviation/airline_ontime/. -type f -name "*1988*.zip" -or -name "*1989*.zip" -or -name "*1990*.zip" -or -name "*1991*.zip" -or -name "*1992*.zip" -print0 | xargs -0 -I{} sudo unzip {} -x readme.html -d /data/raw
[ "$HOSTNAME" == "ip-172-31-33-86" ] && sudo find /snapshot/aviation/airline_ontime/. -type f -name "*1993*.zip" -or -name "*1994*.zip" -or -name "*1995*.zip" -or -name "*1996*.zip" -or -name "*1997*.zip" -print0 | xargs -0 -I{} sudo unzip {} -x readme.html -d /data/raw
[ "$HOSTNAME" == "ip-172-31-37-87" ] && sudo find /snapshot/aviation/airline_ontime/. -type f -name "*1998*.zip" -or -name "*1999*.zip" -or -name "*2000*.zip" -or -name "*2001*.zip" -or -name "*2002*.zip" -print0 | xargs -0 -I{} sudo unzip {} -x readme.html -d /data/raw
[ "$HOSTNAME" == "ip-172-31-44-141" ] && sudo find /snapshot/aviation/airline_ontime/. -type f -name "*2003*.zip" -or -name "*2004*.zip" -or -name "*2005*.zip" -or -name "*2006*.zip" -or -name "*2007*.zip" -print0 | xargs -0 -I{} sudo unzip {} -x readme.html -d /data/raw
sudo chown root:ec2-user -R /data/raw
sudo chmod 777 -R /data/raw
sudo find /data/raw/ -name '*.csv' -print0 | xargs -0 -I{} sudo sed -i 's/, /-/g' {}
sudo find /data/raw/ -name '*.csv' -print0 | xargs -0 -I{} sudo sed -i 's/\"//g' {}
aws configure
aws s3 sync /data/raw s3://cs598project/data/scrubbed
