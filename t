nano /etc/hostname
nano /etc/hosts

reboot

sudo apt install samba krb5-config winbind smbclient

sudo mv /etc/samba/smb.conf /etc/samba/smb.conf.original

sudo samba-tool domain provision

sudo cp /var/lib/samba/private/krb5.conf /etc/krb5.conf


sudo systemctl disable --now smbd nmbd winbind systemd-resolved
sudo systemctl unmask samba-ad-dc
sudo systemctl enable --now samba-ad-dc
sudo samba-tool domain level show


sudo rm /etc/resolv.conf


sudo nano /etc/resolv.conf

sudo samba-tool user create FCTuser01

sudo apt install isc-dhcp-serve

sudo nano /etc/default/isc-dhcp-server


sudo nano /etc/dhcp/dhcpd.conf


subnet 172.16.0.0 netmask 255.255.255.0 {
  range 172.16.0.20 172.16.0.100;
  option routers 172.16.0.1;
  option domain-name-servers 172.16.0.10;
  option domain-name "fct.kel.ac.lk";
  default-lease-time 600;
  max-lease-time 7200;
}

sudo systemctl restart isc-dhcp-server

sudo systemctl enable isc-dhcp-server

sudo systemctl status isc-dhcp-server


# 1. Display Date and Time every minute
* * * * * date >> /home/user/time.log

# 2. System Update daily at 11:30 PM
30 23 * * * sudo apt update && sudo apt upgrade -y

# 3. Clear Temporary Files every Sunday at 2 AM
0 2 * * 0 rm -rf /tmp/*

# 4. Backup a Folder daily at midnight
0 0 * * * tar -czf /home/user/Documents_backup_$(date +\%F).tar.gz /home/user/Documents

# 5. Disk Usage Report daily at 6 PM
0 18 * * * df -h >/home/user/disk_report.txt

# 6. Check System Uptime every hour
0 * * * * uptime >/home/user/uptime.log

# 7. Monitor a Service every 10 minutes
*/10 * * * * systemctl is-active --quiet apache2 || systemctl restart apache2

# 8. Database Backup every night at 1 AM
0 1 * * * mysqldump -u root -pYourPassword dbname > /home/user/db_backup_$(date +\%F).sql

# 9. Email System Status every morning at 9 AM
0 9 * * * top -bn1 | head -20 | mail -s "Daily System Report" user@example.com

# 10. Sync Files with Cloud Storage daily at 3 AM
0 3 * * * rclone sync /home/user/backup remote:backup


