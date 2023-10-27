docker & docker-compose install

FROM:
[how to install and use docker][1]
[how to install and use docker compose][2]

docker:

    sudo yum check-update

    curl -fsSL https://get.docker.com/ | sh

    sudo systemctl start docker
    sudo systemctl status docker
    sudo systemctl enable docker

docker-compose:

Check the [Releases][3] and if necessary, update it in the command below:

    sudo curl -L "https://github.com/docker/compose/releases/download/v2.18.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    
    sudo chmod +x /usr/local/bin/docker-compose

    docker-compose --version


  [1]: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-centos-7
  [2]: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-centos-7
  [3]: https://github.com/docker/compose/releases
