Install fail2ban

centos8 intall happend error:

Error: 
 Problem: problem with installed package selinux-policy-targeted-3.14.3-80.el8_5.2.noarch
  - package fail2ban-server-1.0.2-3.el8.noarch requires (fail2ban-selinux if selinux-policy-targeted), but none of the providers can be installed
  - package fail2ban-1.0.2-3.el8.noarch requires fail2ban-server = 1.0.2-3.el8, but none of the providers can be installed
  - conflicting requests
  - nothing provides selinux-policy >= 3.14.3-108.el8_7.1 needed by fail2ban-selinux-1.0.2-3.el8.noarch
  - nothing provides selinux-policy-base >= 3.14.3-108.el8_7.1 needed by fail2ban-selinux-1.0.2-3.el8.noarch
(try to add '--skip-broken' to skip uninstallable packages or '--nobest' to use not only best candidate packages)

.解决方式：yum install --allowerasing fail2ban

ubuntu install:apt-get install fail2ban
.
安装成功后增加规则文件：/etc/fail2ban/filter.d/shadowsocks-libev.conf 

配置jail.local文件：

[DEFAULT]

bantime = 36000
findtime = 600
banaction = iptables-multiport
destemail = bj.guozhong@gmail.com

[sshd]
enabled = true
port = 22
filter = sshd
logpath = /var/log/auth.log
maxretry = 5

[shadowsocks-libev]
enabled = true
port = 3381
filter = shadowsocks-libev
logpath = /var/log/auth.log
maxretry = 3
bantime = 36000
findtime = 3600

systemctl start fail2ban
systemctl status fail2ban
systemctl enable fail2ban

--查看日志和监狱内容

tail -f /var/log/fail2ban.log

fail2ban-client status

查看某个规则下的baned状态：
fail2ban-client status sshd

解除限制：fail2ban-client set sshd unbanip  ****



