FROM library/centos:7

RUN yum -y update
RUN yum -y install epel-release
RUN yum install -y vim wget openssh-clients net-tools bind-utils tcpdump iproute iputils ethtool bridge-utils iptables nmap-ncat less screen strace ltrace bash-completion bash-completion-extras yum-utils && yum clean all
RUN echo "alias vi='vim'" >> /root/.bashrc
RUN echo "export TERM=xterm" >> /root/.bashrc
RUN echo "escape ^Oo" > ~/.screenrc
RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

CMD ["/bin/bash"]
