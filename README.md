# docker-centos
My docker image of centos including container and cloud tools.

* Container tools
  * docker(cli)
  * docker-compose
  * docui
  * kubectl
  * helm
  * kubectx
  * kubens
  * k3d
  * k9s
  * stern
  * kubeval
  * hadolint
  * kube-score
  * kube-ps1 (default is off. exec kubeon to enable)
  * crane

* Cloud
  * az
  * aws
  * eksctl
  * awless

* Others
  * git 2.24
  * vim wget openssh-clients net-tools bind-utils tcpdump iproute iputils ethtool bridge-utils iptables nmap-ncat less screen tmux strace ltrace bash-completion bash-completion-extras yum-utils jq stress-ng expect psmisc openssl kbd unzip

This image has these repositories for yum.

* epel
* ius (for git 2.24)
* kubernetes (for kubectl)
* azure cli (for az)
* vscode (yum install code)
* google cloud sdk
