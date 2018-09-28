#!/bin/bash
timeout=300
time=0
kubectl create -f redis-cluster.yml
while [ $time -lt $timeout ];do
   output=$(kubectl get pods -n default|awk -F'[ /]+' '$1=="redis-cluster-5"{print $2}')
     if [ -n "$output" ] && [ $output -eq 1 ];then
        ips=$(kubectl get pods -l app=redis-cluster -o jsonpath='{range.items[*]}{.status.podIP}:6379 ')
        echo yes | kubectl exec -i redis-cluster-5 -- /usr/local/bin/redis-trib.rb create --replicas 1 $ips
        exit
     else
        echo "Please Wait a moment"
        sleep 10
        time=$[$time+10]
     fi
done
if [ $? -ne 0 ];then
   echo "JOB is Failed "
   elif [ $time -lt $timeout ];then
     echo "JOB is Successed"
   else
     echo "JOB is Timeout,Failed"
   fi
fi
