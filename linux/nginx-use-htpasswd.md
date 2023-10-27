nginx use htpasswd	

nginx加密,安装htpasswd
	
yum install -y httpd-tools下载htpasswd
	
	htpasswd -c /etc/nginx/.htpasswd gz
	New password: 
	Re-type new password: 
	Adding password for user gz

	ls -a 可查看密码文件 
	
	之后在nginx.conf中配置：
	server {
		listen 80;
		server_name  localhost;
		.......
		#新增下面两行
		auth_basic "Please input password"; #这里是验证时的提示信息
		auth_basic_user_file /usr/local/src/nginx/passwd;
		location /{
		.......
    	}
