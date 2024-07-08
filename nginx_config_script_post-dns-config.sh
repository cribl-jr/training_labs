#!/bin/bash
curl -o /etc/nginx/sites-available/www.floss.pub.conf "https://raw.githubusercontent.com/cribl-jr/training_labs/main/www.floss.pub.conf"
curl -o /etc/nginx/sites-available/floss.pub.conf "https://raw.githubusercontent.com/cribl-jr/training_labs/main/floss.pub.conf"
sudo ln -s /etc/nginx/sites-available/www.floss.pub.conf /etc/nginx/sites-enabled/www.floss.pub.conf
sudo ln -s /etc/nginx/sites-available/floss.pub.conf /etc/nginx/sites-enabled/floss.pub.conf
sudo systemctl restart nginx
certbot --nginx --non-interactive --agree-tos --domains floss.pub --email jr@cribl.io
certbot --nginx --non-interactive --agree-tos --domains www.floss.pub --email jr@cribl.io
mkdir -p /opt/docker/apache/html/
echo "this is a test" | touch -a /opt/docker/apache/html/index.html
docker run -dit --name my-apache-app -p 8080:80 -v "/opt/docker/apache/html/":"/usr/local/apache2/htdocs/" --ip 172.17.0.2 httpd:2.4
