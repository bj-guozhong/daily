Install acme.sh(前提有域名),生成证书

#安装acme.sh
curl https://get.acme.sh | sh

#生成证书: 
/root/.acme.sh/acme.sh  --issue  --standalone  -d passwd.313390.xyz
yum install socat
/root/.acme.sh/acme.sh  --issue  --standalone  -d passwd.313390.xyz
systemctl stop nginx
/root/.acme.sh/acme.sh  --issue  --standalone  -d passwd.313390.xyz

/root/.acme.sh/acme.sh --register-account -m bj.guozhong@gmail.com

/root/.acme.sh/acme.sh  --issue  --standalone  -d passwd.313390.xyz  --force

#以下说明证书生成成功：

[Thu Jun  1 15:23:17 CST 2023] Your cert is in: /root/.acme.sh/passwd.20081014.xyz_ecc/passwd.20081014.xyz.cer
[Thu Jun  1 15:23:17 CST 2023] Your cert key is in: /root/.acme.sh/passwd.20081014.xyz_ecc/passwd.20081014.xyz.key
[Thu Jun  1 15:23:17 CST 2023] The intermediate CA cert is in: /root/.acme.sh/passwd.20081014.xyz_ecc/ca.cer
[Thu Jun  1 15:23:17 CST 2023] And the full chain certs is there: /root/.acme.sh/passwd.20081014.xyz_ecc/fullchain.cer

[Mon Jun  5 17:06:49 CST 2023] Your cert is in: /root/.acme.sh/www.313390.xyz_ecc/www.313390.xyz.cer
[Mon Jun  5 17:06:49 CST 2023] Your cert key is in: /root/.acme.sh/www.313390.xyz_ecc/www.313390.xyz.key
[Mon Jun  5 17:06:49 CST 2023] The intermediate CA cert is in: /root/.acme.sh/www.313390.xyz_ecc/ca.cer
[Mon Jun  5 17:06:49 CST 2023] And the full chain certs is there: /root/.acme.sh/www.313390.xyz_ecc/fullchain.cer


#将生成的证书文件配置在nginx中:conf.d/20081014.xyz.conf

[root@ip-172-26-2-136 conf.d]# vi 20081014.xyz.conf 

server
    {
        listen 443 ssl http2;
        #listen [::]:443 ssl http2;
        server_name passwd.20081014.xyz;
        ssl_certificate /root/.acme.sh/passwd.20081014.xyz_ecc/passwd.20081014.xyz.cer;
        ssl_certificate_key /root/.acme.sh/passwd.20081014.xyz_ecc/passwd.20081014.xyz.key;
        ssl_session_timeout 5m;
        ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
        ssl_prefer_server_ciphers on;
        ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:ECDHE:ECDH:AES:HIGH:!NULL:!aNULL:!MD5:!ADH:!RC4;
        ssl_session_cache builtin:1000 shared:SSL:10m;

        # openssl dhparam -out /usr/local/nginx/conf/ssl/dhparam.pem 2048
        # ssl_dhparam /etc/nginx/dhparam.pem;

		add_header Strict-Transport-Security "max-age=63072000; includeSubdomains; preload";
		add_header X-Frame-Options DENY;
		add_header X-Content-Type-Options nosniff;

		location / {
				proxy_pass http://127.0.0.1:8001;
				proxy_redirect off;
				proxy_set_header X-Real-IP $remote_addr;
				proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
		}

		location /notifications/hub {
				proxy_pass http://127.0.0.1:3012;
				proxy_set_header Upgrade $http_upgrade;
				proxy_set_header Connection "upgrade";
		}

		location /notifications/hub/negotiate {
				proxy_pass http://127.0.0.1:8001;
				proxy_set_header Upgrade $http_upgrade;
				proxy_set_header Connection "upgrade";

		}
    }
#证书自动更新：
/root/.acme.sh/acme.sh --upgrade  --auto-upgrade
