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



