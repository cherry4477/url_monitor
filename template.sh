#!/bin/bash
metric="metricname"
host=`hostname`
ts=`date +%s`
url="urlname"

function send {
    curl -X POST -d "[{\"metric\": \"$1\", \"endpoint\": \"$2\", \"timestamp\": $3,\"step\": 60,\"value\": $4,\"counterType\": \"GAUGE\",\"tags\": \"open\"}]" http://127.0.0.1:1988/v1/push
}

res=`curl -k  -L --connect-timeout 3 -w %{http_code} -o /dev/null -s $url`
if [ $res -eq "000" ]; then
    res=0
fi
echo $res
send "url-monitor:"$metric  $host $ts $res
