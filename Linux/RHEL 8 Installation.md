# Red Hat Enterprise Linux 8 Installation

<div style="text-align: right;">KaungYeeHein's Note<br/>2024-Mar-3</div>

## Table of Contents
- [Chapter 1: Installation Setup](#chapter-1-installation-setup)
- [Chapter 2: Configure Network](#chapter-2-configure-network)
- [Chapter 3: Attach Subscription](#chapter-3-attach-subscription)
- [Chapter 4: Update Latest](#chapter-4-update-latest)
- [Chapter 5: Enable SSH](#chapter-5-enable-ssh)
- [Chapter 6: Monitoring with (sar, sa1, sa2)](#chapter-6-monitoring-with-sar-sa1-sa2)
- [Chapter 7: Check Port Working](#chapter-7-check-port-working)
- [Chapter 8: Disable IPv6 Permanently](#chapter-8-disable-ipv6-permanently)

---

## Chapter 1: Installation Setup

rhel-8.8

- English (US)
- KDUMP is disabled
- Asia/Yangon
- Minimal Install (Additional: Standard)
- rhel-8.parallel
- root:root
- kok:Kaung123.

---

## Chapter 2: Configure Network

```SHELL
sudo vim /etc/sysconfig/network-scripts/ifcfg-enp0s3
ONBOOT=yes
```

Change hostname if you want
```SHELL
nmcli general hostname rhel-8.home
```

---

## Chapter 3: Attach Subscription

```SHELL
sudo bash
subscription-manager register --auto-attach
# subscription-manager register --username=kaungyeehein@gmail.com --password=04530405Kk
```

---

## Chapter 4: Update Latest

```SHELL
sudo yum repolist
sudo yum update
reboot

sudo yum remove --oldinstallonly
reboot
```

---

## Chapter 5: Enable SSH

```SHELL
systemctl status sshd
systemctl start sshd
systemctl enable sshd

firewall-cmd --zone=public --permanent --add-service=ssh
ssh root@10.0.2.15
```

---

## Chapter 6: Monitoring with (sar, sa1, sa2)

```SHELL
yum install sysstat

vi /etc/sysconfig/sysstat

vi /etc/cron.d/sysstat

# run system activity accounting tool every 10 minutes
*/10 * * * * root /usr/lib64/sa/sa1 -I -d 1 1
# generate a daily summary of process accounting at 23:53
53 23 * * * root /usr/lib64/sa/sa2 -A 

systemctl enable sysstat
systemctl start sysstat.service
systemctl status sysstat.service
```

```
sar -u 3 10 	# CPU
sar -P ALL 		# All CPU stats
sar -P 1 3 10 	# Only 1st CPU stats
sar -c 3 10 	# Process	###
sar -b 3 10 	# I/O
sar -B 3 10 	# Paging
sar -d 3 10 	# Block device
sar -I XALL 3 10 	# Interrupt	###
sar -n DEV 3 10 	# Network
sar -n EDEV 3 10	# Network
sar -q 3 10 	# Queue length & load
sar -r 3 10 	# Memory
sar -R 3 10 	# Swap		###
sar -v 3 10 	# Inode, file & other kernel
sar -w 3 10 	# Process Switching
sar -W 3 10 	# Process Swapping
sar -x 1202 3 10 	# Process Check ###

LC_ALL=C sar -A > /tmp/sar.data.txt
```

---

## Chapter 7: Check Port Working

```SHELL
netstat -an or lsof -i

firewall-cmd --zone=public --permanent --add-service=http
firewall-cmd --permanent --add-port 8080/tcp
```

---

## Chapter 8: Disable IPv6 Permanently

```SHELL
grub2-editenv - list | grep kernelopts
grub2-editenv - set "kernelopts=root=/dev/mapper/rhel-root ro crashkernel=auto resume=/dev/mapper/rhel-swap rd.lvm.lv=rhel/root rd.lvm.lv=rhel/swap rhgb quiet ipv6.disable=1"
```

