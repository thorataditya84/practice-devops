# ----- ----- ----- html hosting ----- ----- -----
sudo yum update -y
sudo yum install httpd unzip wget -y
sudo systemctl start httpd
sudo systemctl enable httpd
cd /tmp/

sudo wget https://www.tooplate.com/zip-templates/2121_wave_cafe.zip
sudo unzip -o 2121_wave_cafe.zip
cd 2121_wave_cafe

sudo cp -r * /var/www/html
sudo systemctl restart httpd
