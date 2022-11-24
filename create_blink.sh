#!/bin/bash

for i in $(awk -F "," '{print $1","$2}' hosts.csv)
do
  echo $i
  hostname=$(echo $i | awk -F "," '{print $1}')
  ip=$(echo $i | awk -F "," '{print $2}')
  echo $hostname
  echo $ip
  rm user_updates/clish_mgmt.txt
  rm user_updates/clish_hostntpdns.txt
  mv user_updates/clish_mgmt.txt-$ip.txt user_updates/clish_mgmt.txt
  mv user_updates/clish_hostntpdns.txt-$hostname.txt user_updates/clish_hostntpdns.txt
  tar zcvf $hostname-blink_image-r8040jumbo-$hostname.tgz .
done
