Server config info

1.创建新的实例
2.绑定原IP或者使用新的IP，如绑定原IP需要先将原IP在原实例中解绑，然后在HOME-Networking中将原IP绑定到新的实例中。
3.connect using SSH --> sudo su
4.passwd,修改root口令,创建appadmin用户
5.打开SSH配置文件/etc/ssh/sshd_config，使用root权限进行编辑：
# vim /etc/ssh/sshd_config
 	PermitRootLogin yes                      	 //允许root登录      
 	PasswordAuthentication yes                 //设置是否使用口令验证
 # service sshd reload
6.升级软件和系统内核：
	yum -y update
7.上传下载口令安装：
	yum -y install lrzsz

	#安装EPEL软件源：
	yum install epel-release -y
	
8.安装各类软件:docker|nginx|tomcat|java|
https://www.freesion.com/article/44341414194/

9.proxy:
 
 cd /etc
 
 mkdir shadowsocks
 
 cd shadowsocks/
 
 vi config.json
 
 ssserver -c /etc/shadowsocks/config.json 
 
 nohup ssserver -c /etc/shadowsocks/config.json &
 
 ps -ef|grep sss
 
 tail nohup.out 

10.执行优化脚本：
 bash vmupgrade_.sh 
 

sudo curl -L "https://github.com/docker/compose/releases/download/v2.18.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose


./bwdata/env/global.override.env


INSTALLATION ID:6301ec03-113d-4fd2-a2e4-b014002a6a13

INSTALLATION KEY:JTbjUEvESChQF6tjzTrP

11.安装acme.sh(前提有域名),生成证书

#安装acme.sh
curl https://get.acme.sh | sh

#生成证书:
/root/.acme.sh/acme.sh  --issue  --standalone  -d 20081014.xyz
yum install socat
/root/.acme.sh/acme.sh  --issue  --standalone  -d 20081014.xyz
systemctl stop nginx
/root/.acme.sh/acme.sh  --issue  --standalone  -d 20081014.xyz
acme.sh --register-account -m bj.guozhong@gmail.com
/root/.acme.sh/acme.sh --register-account -m bj.guozhong@gmail.com

/root/.acme.sh/acme.sh  --issue  --standalone  -d passwd.20081014.xyz
/root/.acme.sh/acme.sh  --issue  --standalone  -d www.313390.xyz -d 313390.xyz --force
#以下说明证书生成成功：

[Thu Jun  1 15:23:17 CST 2023] Your cert is in: /root/.acme.sh/passwd.20081014.xyz_ecc/passwd.20081014.xyz.cer
[Thu Jun  1 15:23:17 CST 2023] Your cert key is in: /root/.acme.sh/passwd.20081014.xyz_ecc/passwd.20081014.xyz.key
[Thu Jun  1 15:23:17 CST 2023] The intermediate CA cert is in: /root/.acme.sh/passwd.20081014.xyz_ecc/ca.cer
[Thu Jun  1 15:23:17 CST 2023] And the full chain certs is there: /root/.acme.sh/passwd.20081014.xyz_ecc/fullchain.cer

#将生成的证书文件配置在nginx中:conf.d/20081014.xyz.conf

[root@ip-172-26-2-136 conf.d]# vi 20081014.xyz.conf 

server
    {
        listen 443 ssl http2;
        #listen [::]:443 ssl http2;
        server_name passwd.20081014.xyz;
        ssl_certificate /root/.acme.sh/passwd.20081014.xyz_ecc/passwd.20081014.xyz.cer;
        ssl_certificate_key /root/.acme.sh/passwd.20081014.xyz_ecc/passwd.20081014.xyz.key;
        ssl_session_timeout 5m;
        ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
        ssl_prefer_server_ciphers on;
        ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:ECDHE:ECDH:AES:HIGH:!NULL:!aNULL:!MD5:!ADH:!RC4;
        ssl_session_cache builtin:1000 shared:SSL:10m;

        # openssl dhparam -out /usr/local/nginx/conf/ssl/dhparam.pem 2048
        # ssl_dhparam /etc/nginx/dhparam.pem;

		add_header Strict-Transport-Security "max-age=63072000; includeSubdomains; preload";
		add_header X-Frame-Options DENY;
		add_header X-Content-Type-Options nosniff;

		location / {
				proxy_pass http://127.0.0.1:8001;
				proxy_redirect off;
				proxy_set_header X-Real-IP $remote_addr;
				proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
		}

		location /notifications/hub {
				proxy_pass http://127.0.0.1:3012;
				proxy_set_header Upgrade $http_upgrade;
				proxy_set_header Connection "upgrade";
		}

		location /notifications/hub/negotiate {
				proxy_pass http://127.0.0.1:8001;
				proxy_set_header Upgrade $http_upgrade;
				proxy_set_header Connection "upgrade";

		}
    }


#证书自动更新：
/root/.acme.sh/acme.sh --upgrade  --auto-upgrade

#更新升级bitwarden
$ cd ~/bitwarden
$ docker-compose down
$ docker pull vaultwarden/server:latest
$ docker-compose up -d

12.安装ufw&fail2ban，防止暴力攻击：

	yum install fail2ban

	yum install ufw

	ufw参考:https://devcoops.com/install-ufw-on-centos-7/

	ufw allow ssh
	ufw allow http
	ufw allow https
	ufw allow 80/tcp
	ufw allow 443/tcp
	ufw enable
	ufw status
	

#默认情况下，UFW默认策略设置为阻止所有传入流量并允许所有传出流量，你可以使用以下命令来设置自己的默认策略：
ufw default allow outgoing 
ufw default deny incoming
ufw status

systemctl status fail2ban

cd /etc/fail2ban/

vi jail.local 

#输入以下内容:
[DEFAULT]
# Ban hosts for one hour:
bantime = 3600
​
# Override /etc/fail2ban/jail.d/00-firewalld.conf:
banaction = iptables-multiport
​
[sshd]
enabled = true
​
[nginx-http-auth]
enabled = true


systemctl restart fail2ban
systemctl status fail2ban.
systemctl status fail2ban
fail2ban status
fail2ban-client status

--查看日志
tail -f /var/log/fail2ban.log


13.nginx加密,安装htpasswd
	yum install -y httpd-tools下载htpasswd
	
	htpasswd -c /etc/nginx/.htpasswd gz
	New password: 
	Re-type new password: 
	Adding password for user gz

	ls -a 可查看密码文件
	
	之后在nginx.conf中配置：
	server {
		listen 80;
		server_name  localhost;
		.......
		#新增下面两行
		auth_basic "Please input password"; #这里是验证时的提示信息
		auth_basic_user_file /usr/local/src/nginx/passwd;
		location /{
		.......
    }
14.查看docker容器运行的日志：
	docker logs -f -t --tail 行数 容器名[containerID]  

15.关于防火墙：

您可以使用以下命令检查CentOS使用的防火墙是iptables还是firewalld：
sudo firewall-cmd --state

如果输出结果为“running”，则表示CentOS使用的是firewalld。 如果该命令未返回任何内容，则表示CentOS使用的是iptables。 
另外，您还可以使用以下命令来检查防火墙服务的状态：

如果输出结果包含“inactive”，则表示CentOS使用的是iptables：

sudo systemctl status iptables.service


如果输出结果包含“active (running)”或“active (exited)”，则表示CentOS使用的是firewalld：

sudo systemctl status firewalld.service




如果您的防火墙使用的是firewalld，则可以使用以下命令查看允许通过的端口：

sudo firewall-cmd --list-ports 列出允许通过的端口列表：

sudo firewall-cmd --list-ports

输出将显示所有允许通过的端口。

要查看特定区域的端口，可以使用以下命令：

sudo firewall-cmd --list-ports --zone=public

您可以将“public”替换为您想要查看其允许端口的区域名称。

ufw allow ssh
ufw allow http
ufw allow https

使用命令sudo firewall-cmd --list-ports列出允许通过的端口列表：

结果为空

ufw allow 80/tcp
ufw allow 443/tcp

结果为:80/tcp 443/tcp

16.域名服务器更新IP之后，本地还是访问原IP地址，需要清理本地DNS缓存：

对于 Windows 系统，清空 DNS 缓存的方法如下：

打开命令提示符，以管理员身份运行。

输入以下命令清空 DNS 缓存：

ipconfig /flushdns

如果您的网络使用了代理服务器，您还可以尝试清空代理服务器的缓存。输入以下命令清空代理服务器的缓存：

netsh winhttp reset proxy

最后，您可以尝试在 Web 浏览器中清除缓存和 Cookie。清除缓存和 Cookie 的方法因浏览器而异，您可以在浏览器的设置菜单中找到相关选项。

清空 DNS 缓存后，您尝试重新访问域名，应该可以正确显示新 IP 地址。


AWS:$6nK7w#R6x&u3!
