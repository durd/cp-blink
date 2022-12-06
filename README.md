# cp-blink
Generates from a CSV-file, with hostnames and IP-addresses, blink files. When these are run clish-files are generated with commands for NTP, DNS, hostname and an interface for Management. Then it's packaged to one or more tgz-file that can be copied to a USB-drive. More configuration and interfaces can easily be added, either from the CSV-file or directly editing the .txt-files before creating the blink files. I used this repo to add the minimal config to access the appliance remotely, and then my other repo `cp-interface` to add interfaces read from phpIPAM.

## Why
Installing and configuring 14 gates at once is quite tedious. isoMorphic can do the job, but I didn't have the serialnumbers/MAC-addresses at my disposal, so I couldn't create a running order for the gates and therefore neither the configuration for each appliance. I also probably missed isoMorphics documenation and really just don't know how to add more configuration than just the first interface :)

## To do
Describe how to generate passwords for `answers.xml`, how is available sk120193, but it'd be good to have it here too.

## Requirements
For this to work, the following is required.
* **ONLY WORKS FOR GATEWAYS, NOT Management or MDS** - See [Gateways](#gateways)
* an OS based on Linux (bash/zsh, tar, mv, rm, awk, sed, echo)
* latest blink-image from CheckPoints webpage
* a clean appliance or openserver (not tested), it must not be blinked or upgraded since before. E.g clean install it from ISO or out-of-the-box.
* version >r80.20

### How
1) git-clone this repo, or download the files one by one
2) extract blink-image to the cloned directory, or the same directory you downloaded the files to
3) go to the directory that contains the extracted files and the files from this repo
4) edit `hosts.cvs` with hostname and IP
5) edit `clish_hostntpdns.txt` and `clish_syslog.txt` and change the values to fit your environment
6) run `create_from_csv.sh`, this reads from `hosts.csv` and adds files in the directory `user_updates` that came from the blink image
7) run `create_blink.sh`, this renames the files in step #4 above and creates the tgz-files
8) rename the first tgz-file to `blink_image-r8040jumbo.tgz`, any name is fine as long as the prefix is `blink_image`
9) copy the created tgz-files to an unencrypted USB-drive, preferably fast
10) with the appliance running, log in to clish
11) plug in the USB-drive, Blink will start automatically
12) (4800 only) When Blink is done and umounts the filesystem, remove the USB-drive
13) (4800 only) When the appliance has rebooted, and waiting for "Press any key to view boot menu" (right after an audible beep), plug in the drive again
14) Let the appliance start, the last thing run is `install_content.sh`-script that runs `clish`-commands, removes the old and renames the next tgz-file so that the USB-drive can be used on the next appliance. It also copies a log-file to the USB-drive and then umounts itself.
15) Start again on the next appliance

### Gateways
The script is currently only adapted for gateways, not standalone, mgmt or mds. This is however easily changed in `answers.xml`. Read more at CheckPoints sk120193 for Blink installations.
