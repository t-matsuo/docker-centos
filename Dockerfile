FROM library/centos:7

COPY ./kubernetes.repo /etc/yum.repos.d/
RUN yum -y update && yum -y install epel-release && rpm -ivh https://repo.ius.io/ius-release-el7.rpm
RUN yum install -y vim wget openssh-clients net-tools bind-utils tcpdump iproute iputils ethtool bridge-utils iptables nmap-ncat less screen tmux strace ltrace bash-completion bash-completion-extras yum-utils kubectl jq stress-ng expect && \
    yum --enablerepo=ius-archive install -y git216 && \
    yum clean all
RUN rm -f /root/anaconda-ks.cfg && \
    echo "alias vi='vim'" >> /root/.bashrc && \
    echo "alias k='kubectl'" >> /root/.bashrc && \
    echo "alias ssh='ssh -o ServerAliveInterval=20 -o ServerAliveCountMax=20'" >> /root/.bashrc && \
    echo "complete -o default -F __start_kubectl k" >> /root/.bashrc && \
    echo -e 'if [ "$TERM" == "screen" ]; then\n   export PS1='\''[\u@\h:$WINDOW:\w]\$ '\''\nelse\n   export PS1='\''[\u@\h:\w]\$ '\''\n   cd $HOME\nfi' >> /root/.bashrc && \
    echo "escape ^Oo" >> /root/.screenrc && \
    echo 'shell "/bin/bash"' >> /root/.screenrc && \
    echo "set background=dark" >> /root/.vimrc && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    kubectl completion bash >> /etc/bash_completion.d/kubectl && \
    mkdir /root/.kube

CMD ["/bin/bash"]
