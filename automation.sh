#!/bin/bash                                                                                                           
# Variables   
name="krishna"
s3_bucket="upgrad-krishna" 

apt update -y

if  [[ apache2 != $(dpkg --get-selection apache2 | awk '{print $1}') ]]; then 
 apt install apache2 -y 
fi  

running=$(systemctl status apache2 |grep active |awk '{print $3}' | tr -d '()')
if [[ running !=  ${running} ]]; then                                                                                                                                                                                                            
systemctl start apache2  
fi

enabled=$(systemctl is-enabled apache2 | grep "enabled") 

if  [[ enabled != ${enabled} ]]; then  
  systemctl enable apache2 
fi

timestamp=$(date '+%d%m%Y-%H%M%S') 
cd /var/log/apache2 
tar -cf  /tmp/${krishna}-http-logs-${timestamps}.tar *.log

if [[ -f /tem/${krishna}-httpd-logs-${timestamps}.tar ]] ;then
 aws s3 cp/temp/${krishna}-http-logs-${timestamps}.tar s3://${upgrad-krishna}/${krishna}-http-logs-${timestamps}.tar   

fi

