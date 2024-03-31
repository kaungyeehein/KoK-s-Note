# Red Hat Enterprise Linux 9 Installation

<div style="text-align: right;">KaungYeeHein's Note<br/>2024-Mar-29</div>

## Table of Contents
- [Chapter 1: Installation Setup](#chapter-1-installation-setup)
- [Chapter 2: Enabling SSH login as Root](#chapter-2-enabling-ssh-login-as-root)
- [Chapter 3: Configure Network](#chapter-3-configure-network)
- [Chapter 4: Disable IPv6 Permanently](#chapter-4-disable-ipv6-permanently)
- [Chapter 5: Attach Subscription](#chapter-5-attach-subscription)
- [Chapter 6: Update Latest](#chapter-6-update-latest)
- [Chapter 7: Monitoring with (sar, sa1, sa2)](#chapter-7-monitoring-with-sar-sa1-sa2)
- [Chapter 8: Enable Firewall](#chapter-8-enable-firewall)
- [Chapter 9: Check Port Working](#chapter-9-check-port-working)

---

## Chapter 1: Installation Setup

#### Hardware Capacity for VM

- CPU: 2 Core
- Memory: 2048 MB
- Network: Shared Network
- Hard Disk: 64 GB

#### rhel-9.3

- Localization
	- Keyboard: English (US)
	- Language: English (United States)
	- Time & Date: Asia/Yangon
- Software
	- Connect to Red Hat: Not registered
	- Installation Source: Local media
	- Software Selection: Minimal Install (Additional: Standard)
- System
	- Installation Destination
		- Automatic partition
		- Custom partition
	- KDUMP: KDUMP is disabled
	- Hostname: rhel-9.parallel
- User Settings
	- `root` : `root`
		- [ ] Lock root account
		- [x] Allow root SSH login with password
	- `kok` : `Kaung123.`
		- [ ] Make this user administrator
		- [x] Require a password to use this account

#### Custom partition

| Device | Mount | Size     | Type               | File System |
|--------|-------|----------|--------------------|-------------|
| sda1	 | /boot | 1024 MiB | Standard Partition | xfs         |
| sda2   |  	   | 3 GiB    | Standard Partition | swap        |
| sda3   | /     | 40 GiB   | Standard Partition | xfs         |
| sda4   | /home | 20 GiB   | Standard Partition | xfs         |

#### Check Automatic partition
```SHELL
[root@server ~]# lsblk
NAME          MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda             8:0    0   64G  0 disk 
├─sda1          8:1    0    1G  0 part /boot
└─sda2          8:2    0   63G  0 part 
  ├─rhel-root 253:0    0   41G  0 lvm  /
  ├─rhel-swap 253:1    0    2G  0 lvm  [SWAP]
  └─rhel-home 253:2    0   20G  0 lvm  /home
sr0            11:0    1 1024M  0 rom  

[root@server ~]# lsblk -f
NAME          FSTYPE      FSVER    LABEL UUID                                   FSAVAIL FSUSE% MOUNTPOINTS
sda                                                                                            
├─sda1        xfs                        44cc2607-0f1d-4766-8d82-d6005dd217b5    707.7M    26% /boot
└─sda2        LVM2_member LVM2 001       vUSTRE-Xi3r-ZEzE-OA0j-tsGg-srEZ-OcwZBY                
  ├─rhel-root xfs                        891d27ed-dc6a-4eac-836c-3e9fea93d2b5       39G     5% /
  ├─rhel-swap swap        1              41246be1-fc7b-422f-a6da-f75514b9412b                  [SWAP]
  └─rhel-home xfs                        c005abd0-b560-43f0-b496-5f1af82e376a     19.8G     1% /home
sr0 

[root@server ~]# df -h
Filesystem             Size  Used Avail Use% Mounted on
devtmpfs               4.0M     0  4.0M   0% /dev
tmpfs                  879M     0  879M   0% /dev/shm
tmpfs                  352M  5.2M  347M   2% /run
/dev/mapper/rhel-root   41G  1.9G   40G   5% /
/dev/mapper/rhel-home   20G  175M   20G   1% /home
/dev/sda1              960M  253M  708M  27% /boot
tmpfs                  176M     0  176M   0% /run/user/0
```

---

## Chapter 2: Enabling SSH login as Root

```SHELL
ssh root@myhostname
root@myhostname password:
Permission denied, please try again.
```

Add permission at ssh config
```SHELL
echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config.d/01-permitrootlogin.conf
systemctl restart sshd.service
```

---

## Chapter 3: Configure Network

```SHELL
ip address show
nmcli connection show			# Show current connection
nmcli connection show enp0s5	# Show current setting

# Using DHCP
nmcli connection modify enp0s5 ipv4.method auto

# Using Static IP
nmcli connection modify enp0s5 ipv4.method manual ipv4.addresses 10.211.55.50/24 ipv4.gateway 10.211.55.1 ipv4.dns "8.8.8.8,8.8.4.4"

# Restart network and Check status
nmcli connection down enp0s5
nmcli device status
nmcli connection up enp0s5
nmcli device status

ip route show
```

Configure by text based user interface
```
nmtui
```

Change hostname if you want
```SHELL
nmcli general hostname server.ansible
```

If vm cloned, remove SSH host key.
```
rm /etc/ssh/ssh_host_*
shutdown -r now
```

---

## Chapter 4: Disable IPv6 Permanently

```SHELL
ip a | grep -i inet6	# Check IPv6

# Disable for all interface
echo "net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf

# Disable for one interface
echo "net.ipv6.conf.enp0s5.disable_ipv6 = 1" >> /etc/sysctl.conf

sysctl -p 				# Reflect the changes

echo "AddressFamily inet" >> /etc/ssh/sshd_config
systemctl restart sshd

ip a | grep -i inet6
```

Do not disable IPv6 on `localhost` as it's important for multiple components.
```SHELL
nmcli connection modify enp0s5 ipv6.method = "disabled"
nmcli con up id enp0s5

ip a | grep -i inet6
```

---

## Chapter 5: Attach Subscription

```SHELL
sudo bash
subscription-manager register --auto-attach
# OR
subscription-manager register --username=kaungyeehein@gmail.com --password=04530405Kk --auto-attach
```

---

## Chapter 6: Update Latest

Updating packages
```SHELL
dnf check-update
dnf upgrade
reboot

sudo yum remove --oldinstallonly
reboot
```

Updating security-related packages
```SHELL
dnf upgrade --security
dnf upgrade-minimal --security
```

---

## Chapter 7: Monitoring with (sar, sa1, sa2)

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

## Chapter 8: Enable Firewall

```SHELL
systemctl status sshd
systemctl start sshd
systemctl enable sshd

firewall-cmd --zone=public --permanent --add-service=ssh
ssh root@10.0.2.15
```

---

## Chapter 9: Check Port Working

```SHELL
netstat -an or lsof -i

firewall-cmd --zone=public --permanent --add-service=http
firewall-cmd --permanent --add-port 8080/tcp
```

