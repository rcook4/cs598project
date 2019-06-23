echo "start timings... $(date)"
sudo mkdir /snapshot >/dev/null 2>&1
sudo mount /dev/xvdb /snapshot >/dev/null 2>&1
sudo mkdir -p /data/raw >/dev/null 2>&1
sudo chown root:ec2-user -R /data/ >/dev/null 2>&1
sudo chmod 777 -R /data/ >/dev/null 2>&1
[ "$HOSTNAME" == "ip-172-31-46-45" ] && sudo find /snapshot/aviation/airline_ontime/. -type f -name "*0_*.zip" -print0 | xargs -0 -I{} sudo unzip {} -x readme.html -d /data/raw >/dev/null 2>&1
[ "$HOSTNAME" == "ip-172-31-46-45" ] && sudo find /snapshot/aviation/airline_ontime/. -type f -name "*1_*.zip" -print0 | xargs -0 -I{} sudo unzip {} -x readme.html -d /data/raw >/dev/null 2>&1
[ "$HOSTNAME" == "ip-172-31-46-45" ] && sudo find /snapshot/aviation/airline_ontime/. -type f -name "*2_*.zip" -print0 | xargs -0 -I{} sudo unzip {} -x readme.html -d /data/raw >/dev/null 2>&1
[ "$HOSTNAME" == "ip-172-31-33-86" ] && sudo find /snapshot/aviation/airline_ontime/. -type f -name "*3_*.zip" -print0 | xargs -0 -I{} sudo unzip {} -x readme.html -d /data/raw >/dev/null 2>&1
[ "$HOSTNAME" == "ip-172-31-33-86" ] && sudo find /snapshot/aviation/airline_ontime/. -type f -name "*4_*.zip" -print0 | xargs -0 -I{} sudo unzip {} -x readme.html -d /data/raw >/dev/null 2>&1
[ "$HOSTNAME" == "ip-172-31-33-86" ] && sudo find /snapshot/aviation/airline_ontime/. -type f -name "*5_*.zip" -print0 | xargs -0 -I{} sudo unzip {} -x readme.html -d /data/raw >/dev/null 2>&1
[ "$HOSTNAME" == "ip-172-31-37-87" ] && sudo find /snapshot/aviation/airline_ontime/. -type f -name "*6_*.zip" -print0 | xargs -0 -I{} sudo unzip {} -x readme.html -d /data/raw >/dev/null 2>&1
[ "$HOSTNAME" == "ip-172-31-37-87" ] && sudo find /snapshot/aviation/airline_ontime/. -type f -name "*7_*.zip" -print0 | xargs -0 -I{} sudo unzip {} -x readme.html -d /data/raw >/dev/null 2>&1
[ "$HOSTNAME" == "ip-172-31-44-141" ] && sudo find /snapshot/aviation/airline_ontime/. -type f -name "*8_*.zip" -print0 | xargs -0 -I{} sudo unzip {} -x readme.html -d /data/raw >/dev/null 2>&1
[ "$HOSTNAME" == "ip-172-31-44-141" ] && sudo find /snapshot/aviation/airline_ontime/. -type f -name "*9_*.zip" -print0 | xargs -0 -I{} sudo unzip {} -x readme.html -d /data/raw >/dev/null 2>&1
sudo chown root:ec2-user -R /data/raw >/dev/null 2>&1
sudo chmod 777 -R /data/raw >/dev/null 2>&1
sudo find /data/raw/ -name '*.csv' -print0 | xargs -0 -I{} sudo sed -i 's/, /-/g' {} >/dev/null 2>&1
sudo find /data/raw/ -name '*.csv' -print0 | xargs -0 -I{} sudo sed -i 's/\"//g' {} >/dev/null 2>&1
sudo gzip /data/raw/*.csv
aws s3 sync /data/raw s3://cs598project/data/raw/scrubbed >/dev/null 2>&1
echo "end timings... $(date)"
