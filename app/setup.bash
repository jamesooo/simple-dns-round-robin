#!/bin/bash
sudo yum makecache
sudo yum install -y httpd

cat <<EOF | sudo tee /usr/share/httpd/noindex/index.html
<!DOCTYPE html>
<html>
  <head>
    <title>$(hostname -s)</title>
  </head>
  <body>
    <h1>$(hostname -s)</h1>
  </body>
</html>
EOF

sudo systemctl start httpd
sudo systemctl enable httpd
