FROM library/centos:7

ENV HOME=/root

COPY ./kubernetes.repo /etc/yum.repos.d/
COPY ./fzf /usr/local/bin/fzf
COPY ./k3d/* /usr/local/bin/

RUN rpm --import https://packages.microsoft.com/keys/microsoft.asc && \
    echo -e "[azure-cli]\nname=Azure CLI\nbaseurl=https://packages.microsoft.com/yumrepos/azure-cli\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo && \
    echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo && \
    echo -e "[google-cloud-sdk]\nname=Google Cloud SDK\nbaseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el7-x86_64\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg\n       https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg" > /etc/yum.repos.d/google-cloud-sdk.repo && \
    yum -y update && yum -y install epel-release && \
    rpm -ivh https://repo.ius.io/ius-release-el7.rpm && \
    rpm -ivh https://download.docker.com/linux/centos/7/x86_64/stable/Packages/docker-ce-cli-19.03.9-3.el7.x86_64.rpm && \
    yum install -y vim wget openssh-clients net-tools bind-utils tcpdump iproute iputils ethtool bridge-utils iptables nmap-ncat less screen tmux strace ltrace bash-completion bash-completion-extras yum-utils kubectl jq stress-ng expect psmisc openssl && \
    yum --enablerepo=ius-archive install -y git224 && \
    curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash && \
    curl -L -o /usr/local/bin/kubectx https://github.com/ahmetb/kubectx/releases/download/`curl -s https://api.github.com/repos/ahmetb/kubectx/releases | jq .[].name | grep -v rc | head -1 | sed 's/"//g'`/kubectx && \
    curl -L -o /usr/local/bin/kubens https://github.com/ahmetb/kubectx/releases/download/`curl -s https://api.github.com/repos/ahmetb/kubectx/releases | jq .[].name | grep -v rc | head -1 | sed 's/"//g'`/kubens && \
    chmod 755 /usr/local/bin/kubectx && \
    chmod 755 /usr/local/bin/kubens && \
    curl -L -o /etc/bash_completion.d/kubectx https://github.com/ahmetb/kubectx/raw/master/completion/kubectx.bash && \
    curl -L -o /etc/bash_completion.d/kubens https://github.com/ahmetb/kubectx/raw/master/completion/kubens.bash && \
    curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | TAG=v3.0.1 bash && \
    curl -L "https://github.com/docker/compose/releases/download/`curl -s https://api.github.com/repos/docker/compose/releases | jq .[].name | grep -v rc | head -1 | sed 's/"//g'`/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod 755 /usr/local/bin/docker-compose && \
    curl -L  "https://github.com/hadolint/hadolint/releases/download/`curl -s https://api.github.com/repos/hadolint/hadolint/releases | jq .[].name | grep -v rc | head -1 | sed 's/"//g'`/hadolint-Linux-x86_64" -o /usr/local/bin/hadolint && \
    chmod 755 /usr/local/bin/hadolint && \
    curl -L "https://github.com/skanehira/docui/releases/download/`curl -s https://api.github.com/repos/skanehira/docui/releases | jq .[].name | grep -v rc | head -1 | sed 's/"//g'`/docui_`curl -s https://api.github.com/repos/skanehira/docui/releases | jq .[].name | grep -v rc | head -1 | sed 's/"//g'`_Linux_x86_64.tar.gz" -o /tmp/docui.tar.gz && \
    tar zxvf /tmp/docui.tar.gz -O docui > /usr/local/bin/docui && \
    chmod 755 /usr/local/bin/docui && \
    rm -f /tmp/docui.tar.gz && \
    rm -f /root/anaconda-ks.cfg && \
    echo "alias vi='vim'" >> /root/.bashrc && \
    echo "alias la='ls -la'" >> /root/.bashrc && \
    echo "alias k='kubectl'" >> /root/.bashrc && \
    echo "alias ssh='ssh -o ServerAliveInterval=20 -o ServerAliveCountMax=20'" >> /root/.bashrc && \
    echo "complete -o default -F __start_kubectl k" >> /root/.bashrc && \
    echo -e 'echo $TERM | grep -q "^screen"\nif [ $? -eq 0 ]; then\n   export PS1='\''[\u@\h:$WINDOW:\w]\$ '\''\nelse\n   export PS1='\''[\u@\h:\w]\$ '\''\n   cd $HOME\nfi' >> /root/.bashrc && \
    echo "escape ^Oo" >> /root/.screenrc && \
    echo 'shell "/bin/bash"' >> /root/.screenrc && \
    echo "set background=dark" >> /root/.vimrc && \
    echo "set pastetoggle=<f11>" >> /root/.vimrc && \
    echo "set tabstop=4" >> /root/.vimrc && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    kubectl completion bash >> /etc/bash_completion.d/kubectl && \
    mkdir /root/.kube && \
    yum clean all

CMD ["/bin/bash"]
