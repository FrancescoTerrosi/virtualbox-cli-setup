#!/bin/bash

#VBoxManage list ostypes


#Create VM
VBoxManage createvm --name=vm-test --platform-architecture=x86 --basefolder=$HOME/virtual_machines/test/ --default --ostype=Ubuntu24_LTS_64 --register

#Set CPU, RAM, VRAM
VBoxManage modifyvm vm-test --cpus 2 --memory 2048 --vram 12

#Set Network Interface to "Bridged". You need the real name of your NI
VBoxManage modifyvm vm-test --nic1 bridged --bridgeadapter1 enp2s0

#Create HDD
#--variant [Standard | Fixed]
VBoxManage createhd --filename $HOME/virtual_machines/test/vm-test/vm-test.vdi --size 10240

#FROM DOCS - but I get an error on this so it's commented - looks like it's handled by default in newer versions
#VBoxManage storagectl OracleLinux6Test --name "SATA Controller" --add sata --bootable on
#VBoxManage storagectl OracleLinux6Test --name "IDE Controller" --add ide

#Attach hdd to SATA port
VBoxManage storageattach vm-test --storagectl "SATA" --port 0 --device 0 --type hdd --medium $HOME/virtual_machines/test/vm-test/vm-test.vdi

#Use this if you want to map this port to the REAL dvd driver on the host
#VBoxManage storageattach vm-test --storagectl "IDE" --port 0 --device 0 --type dvddrive --medium host:/dev/dvd
VBoxManage storageattach vm-test --storagectl "IDE" --port 0 --device 0 --type dvddrive --medium $HOME/virtual_machines/imgs/ubuntu-24.04.3-live-server-amd64.iso

#Remove IDE Controller after installation
#VBoxManage storageattach vm-test --storagectl "IDE" --port 0 --device 0 --type dvddrive --medium none >


#Start VM with GUI
#VBoxManage startvm vm-test

#Start VM headless
#VBoxManage startvm vm-test --type headless

