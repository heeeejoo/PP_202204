#!/bin/bash

scp 192.168.1.101:/var/log/httpd/access_log ~/log/web-01_log
scp 192.168.1.101:/var/log/httpd/access_log ~/log/web-02_log

goaccess -f ~/log/* --log-format='%h %^[%d:%t %^] "%r" %s %b "%R" "%u" %^' --date-format=%d/%b/%Y --time-format=%T -a > ~/report.html
#goaccess -f ~/log/* -a > ~/report.html

scp ~/report.html 192.168.1.101:/var/www/html/
scp ~/report.html 192.168.1.102:/var/www/html/
