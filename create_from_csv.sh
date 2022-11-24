#!/bin/bash

for i in $(awk -F "," '{print $1}' hosts.csv)
do
  echo $i
  sed 's/.*hostname.*/set hostname '$i'/' user_updates/clish_hostntpdns.txt > user_updates/clish_hostntpdns-$i.txt
done

for i in $(awk -F "," '{print $2}' hosts.csv)
do
  echo $i
  sed 's/.*ipv4-address.*/set interface eth3.150 ipv4-address '$i' mask-length 28/' user_updates/clish_mgmt.txt > user_updates/clish_mgmt-$i.txt
done
