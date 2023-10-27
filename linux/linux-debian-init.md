linux-debian init

debian初始化:

connect using SSH --> sudo su
passwd,修改root口令,创建appadmin用户
打开SSH配置文件/etc/ssh/sshd_config，使用root权限进行编辑：

vim /etc/ssh/sshd_config
 PermitRootLogin yes                           //允许root登录      
 PasswordAuthentication yes                 //设置是否使用口令验证
service sshd reload


在root账号下，执行如下命令安装sudo。
apt install sudo -y
添加你的本地用户到 sudo 组，可以使用 usermod 命令，如下：
usermod -aG sudo linux265

校正日期和时间:
cp /usr/share/zoneinfo/Asia/ShangHai  /etc/localtime     #时区为亚洲/上海
# 网络校时
apt-get install ntpdate
ntpdate 210.72.145.44        # 中国国家时间服务器: 210.72.145.44

# 手动校时
sudo date -s 11/13/2019                #2019年11月13日
sudo date -s 10:05:30                  #10点05分30秒

进行系统更新:
sudo apt update
sudo apt upgrade -y

完成后安装常用软件:
sudo apt-get install zsh wget curl zip git vim -y


1.没有ls命令：

vi /root/.bashrc 
. /root/.bashrc 

2.创建shadowsock:

wget https://github.com/shadowsocks/shadowsocks-rust/releases/download/v1.16.1/shadowsocks-v1.16.1.x86_64-unknown-linux-gnu.tar.xz

解压：tar -xf shadowsocks-v1.16.1.x86_64-unknown-linux-gnu.tar.xz 

mv ss* /usr/local/bin/.

cd /etc

mkdir shadowsocks

cd shadowsocks/

vi config.json

ssserver -c /etc/shadowsocks/config.json

nohup ssserver -c /etc/shadowsocks/config.json &

ps -ef|grep sss

加入系统服务：

cd /etc/systemd/system/

cp shadowsocks.service .

systemctl status shadowsocks.service
systemctl enable shadowsocks.service
systemctl start shadowsocks.service
systemctl stop shadowsocks.service

3.安装fail2ban:

apt-get install fail2ban

systemctl status fail2ban
cd /etc/fail2ban/
cp jail.local .

systemctl start fail2ban

