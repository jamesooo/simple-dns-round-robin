#!/bin/bash
sudo yum makecache
# install dns server
sudo yum install -y bind bind-utils
# configure dns server
cat <<EOF | sudo tee /etc/named.conf
options {
  listen-on port 53 { 127.0.0.1; 192.168.33.10; };
  listen-on-v6 port 53 { ::1; };
  allow-query { trusted; };
};

acl "trusted" {
  192.168.33.1;
  192.168.33.10;
  192.168.33.11;
  192.168.33.12;
  192.168.33.13;
};
include "/etc/named/named.conf.local";
EOF

cat <<EOF | sudo tee /etc/named/named.conf.local
zone "pdx1.jamesooo.space" {
  type master;
  file "/etc/named/zones/db.pdx1.jamesooo.space";
};
zone "33.168.192.in-addr.arpa" {
  type master;
  file "/etc/named/zones/db.192.168.33";
};
EOF

sudo chmod 755 /etc/named
sudo mkdir -p /etc/named/zones

cat <<EOF | sudo tee /etc/named/zones/db.pdx1.jamesooo.space
\$TTL 30
@    IN    SOA    ns1.pdx1.jamesooo.space. admin.pdx1.jamesooo.space. (
                         3           ; Serial
        604800  ; Refresh
         86400  ; Retry
       2419200  ; Expire
        604800 ); Negative Cache TTL

; name servers - NS records
    IN    NS    ns1.pdx1.jamesooo.space.

; name servers - A records
ns1.pdx1.jamesooo.space.        IN    A    192.168.33.10

; host servers - A records
host1.pdx1.jamesooo.space.    IN    A    192.168.33.11
host2.pdx1.jamesooo.space.    IN    A    192.168.33.12
host3.pdx1.jamesooo.space.    IN    A    192.168.33.13
app.pdx1.jamesooo.space.      IN    A    192.168.33.11
app.pdx1.jamesooo.space.      IN    A    192.168.33.12
app.pdx1.jamesooo.space.      IN    A    192.168.33.13
EOF

cat <<EOF | sudo tee /etc/named/zones/db.192.168.33
\$TTL 30
@    IN    SOA    pdx1.jamesooo.space. admin.pdx1.jamesooo.space. (
                         3           ; Serial
                    604800           ; Refresh
                     86400           ; Retry
                   2419200           ; Expire
                    604800  )        ; Negative Cache TTL
; name servers - NS records
    IN    NS    ns1.pdx1.jamesooo.space.
; PTR Records
10    IN    PTR    ns1.pdx1.jamesooo.space.    ; 192.168.33.10
11    IN    PTR    host1.pdx1.jamesooo.space.  ; 192.168.33.11
12    IN    PTR    host2.pdx1.jamesooo.space.  ; 192.168.33.12
13    IN    PTR    host3.pdx1.jamesooo.space.  ; 192.168.33.13
EOF

sudo systemctl start named
sudo systemctl enable named
