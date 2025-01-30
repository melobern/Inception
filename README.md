# root
su
apt-get install sudo make git curl ufw ssh zsh vim neovim -y
echo "mbernard ALL=(ALL) ALL" >> /etc/sudoers

su -
usermod -aG sudo mbernard
usermod -aG docker mbernard

# user mbernard (with sudo)
sudo ufw enable
sudo ufw allow 22 #if not allowed

# AFTER SSH IS CONFIGURED 

# ZSH INSTALLATION
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# DOCKER INSTALLATION
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update****
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin](https://docs.docker.com/engine/install/debian/)
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
# (source === https://docs.docker.com/engine/install/debian/)

# TEST WITH THE DOCKER FIRST CONTAINER WEBSITE
docker run -d -p 8080:80 docker/welcome-to-docker
#(source === https://docs.docker.com/get-started/docker-concepts/the-basics/what-is-a-container/)

# Generate key ssh
ssh-keygen

# TO SHUTDOWN DEBIAN :
sudo poweroff
