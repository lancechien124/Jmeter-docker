#!/bin/bash
pwd
echo "Current workspace"
current_time=$(TZ="Asia/Taipei" date "+%m%d%H%M%S")
timestamp=`date +%Y%m%d%H%M%S`
pwd
exec_time=$current_time
echo "Execution Time =" $exec_time

docker run --rm --name Jmeter5.4 -w /test -v `pwd`/test:/test jmeter /bin/bash -c "jmeter -n -t ./VNSearch.jmx -j /test/report/$exec_time/Jmeter.log -l /test/report/$exec_time/Jmeter.jtl -e -o /test/report/$exec_time-HTML"