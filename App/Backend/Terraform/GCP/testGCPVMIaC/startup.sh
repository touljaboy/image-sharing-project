# Research gcp cloud-init capabilities in the future, because this sucks
#!/bin/bash
apt-get update -y
apt-get upgrade -y
apt-get install -y apache2
systemctl enable apache2
systemctl start apache2