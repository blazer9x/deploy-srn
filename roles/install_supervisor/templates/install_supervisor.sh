#!/bin/bash
echo "Cleaning Up!!"
rm -f /etc/rc.d/init.d/supervisord /etc/supervisord.conf

echo "Starting Install"; sleep 1
# yum install python-setuptools python-pip python-meld3 -y

#installing supervisor
pip install supervisor

# Create default supervisor configuration file
echo_supervisord_conf > /etc/supervisord.conf

# Create directory /etc/supervisor.d/
mkdir -p /etc/supervisord.d/

# Create set supervisor configuration load all file
echo "[include]" >> /etc/supervisord.conf
echo "files = /etc/supervisord.d/*.conf" >> /etc/supervisord.conf

# Add service script
# Convert it to base64 using decoder, here's a sample https://www.base64decode.org/
SUPERVISORD64="IyEvYmluL3NoCiMKIyAvZXRjL3JjLmQvaW5pdC5kL3N1cGVydmlzb3JkCiMKIyBTdXBlcnZpc29yIGlzIGEgY2xpZW50L3NlcnZlciBzeXN0ZW0gdGhhdAojIGFsbG93cyBpdHMgdXNlcnMgdG8gbW9uaXRvciBhbmQgY29udHJvbCBhCiMgbnVtYmVyIG9mIHByb2Nlc3NlcyBvbiBVTklYLWxpa2Ugb3BlcmF0aW5nCiMgc3lzdGVtcy4KIwojIGNoa2NvbmZpZzogLSA2NCAzNgojIGRlc2NyaXB0aW9uOiBTdXBlcnZpc29yIFNlcnZlcgojIHByb2Nlc3NuYW1lOiBzdXBlcnZpc29yZAoKIyBTb3VyY2UgaW5pdCBmdW5jdGlvbnMKLiAvZXRjL3JjLmQvaW5pdC5kL2Z1bmN0aW9ucwoKcHJvZz0ic3VwZXJ2aXNvcmQiCgpwcmVmaXg9Ii91c3IvIgpleGVjX3ByZWZpeD0iJHtwcmVmaXh9Igpwcm9nX2Jpbj0iJHtleGVjX3ByZWZpeH0vYmluL3N1cGVydmlzb3JkIgpQSURGSUxFPSIvdmFyL3J1bi8kcHJvZy5waWQiCgpzdGFydCgpCnsKICAgICAgIGVjaG8gLW4gJCJTdGFydGluZyAkcHJvZzogIgogICAgICAgZGFlbW9uICRwcm9nX2JpbiAtLXBpZGZpbGUgJFBJREZJTEUKICAgICAgIFsgLWYgJFBJREZJTEUgXSAmJiBzdWNjZXNzICQiJHByb2cgc3RhcnR1cCIgfHwgZmFpbHVyZSAkIiRwcm9nIHN0YXJ0dXAiCiAgICAgICBlY2hvCn0KCnN0b3AoKQp7CiAgICAgICBlY2hvIC1uICQiU2h1dHRpbmcgZG93biAkcHJvZzogIgogICAgICAgWyAtZiAkUElERklMRSBdICYmIGtpbGxwcm9jICRwcm9nIHx8IHN1Y2Nlc3MgJCIkcHJvZyBzaHV0ZG93biIKICAgICAgIGVjaG8KfQoKY2FzZSAiJDEiIGluCgogc3RhcnQpCiAgIHN0YXJ0CiA7OwoKIHN0b3ApCiAgIHN0b3AKIDs7Cgogc3RhdHVzKQogICAgICAgc3RhdHVzICRwcm9nCiA7OwoKIHJlc3RhcnQpCiAgIHN0b3AKICAgc3RhcnQKIDs7CgogKikKICAgZWNobyAiVXNhZ2U6ICQwIHtzdGFydHxzdG9wfHJlc3RhcnR8c3RhdHVzfSIKIDs7Cgplc2FjCg=="

SUPERVISORD64DECODE=$(echo $SUPERVISORD64 | base64 --decode)

# Write decoded string into file to create service function
echo "$SUPERVISORD64DECODE" >> /etc/rc.d/init.d/supervisord

# Set permission and add supervisor as a service
chmod +x /etc/rc.d/init.d/supervisord
chkconfig --add supervisord
chkconfig supervisord on

cd /etc/supervisord.d
service supervisord stop
service supervisord start
