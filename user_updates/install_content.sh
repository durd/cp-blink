#!/bin/bash

log_file="/var/log/user_main_script.log"
our_log="/var/log/out_blink.log"
FILES="/mnt/usb/*-blink_image*.tgz"
BLINK="blink_image-r8040jumbo.tgz"
DIR="/mnt/usb/"
DEV="/dev/sdd1"

echo "Configuring management interface..." >> $log_file >> $our_log
clish -i -s -f "clish_mgmt.txt" >> $log_file >> $our_log
echo "Configuring hostname, dns, ntp..." >> $log_file >> $our_log
clish -i -s -f "clish_hostntpdns.txt" >> $log_file >> $our_log
echo "Configuring syslog..." >> $log_file >> $our_log
clish -i -s -f "clish_syslog.txt" >> $log_file >> $our_log

echo "Preparing for the next appliance to blink..." >> $log_file >> $our_log
echo "Mounting $DEV to $DIR..." >> $log_file >> $our_log
mkdir $DIR >> $log_file >> $our_log
mount $DEV $DIR >> $log_file >> $our_log
for f in $FILES
do
  echo "Removing old blink image $DIR$BLINK..." >> $log_file >> $our_log
  rm $DIR$BLINK >> $log_file >> $our_log
  echo "Renaming $f to $DIR$BLINK..." >> $log_file >> $our_log
  mv $f $DIR$BLINK >> $log_file >> $our_log
  echo "Prepared for next device!" >> $log_file >> $our_log
  break
done
echo "Copy $our_log contents to the USB..." >> $log_file >> $our_log
cat $our_log >> ${DIR}our_log.txt >> $log_file >> $our_log
echo "Syncing the drives..." >> $log_file >> $our_log
sync
echo "Un-mounting $DEV and clean-up /mnt..." >> $log_file >> $our_log
umount $DIR >> $log_file >> $our_log
rm -d $DIR >> $log_file >> $our_log

#echo "Installing private RPMs..."
#rpm -ihv some_private_RPM.rpm
exit 0
