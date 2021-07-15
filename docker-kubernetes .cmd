# Kubernetes both master&worker cmd

sudo apt-get update -y
sudo apt-get install -y apt-transport-https
sudo -i
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
modprobe br_netfilter
sysctl -p
sudo sysctl net.bridge.bridge-nf-call-iptables=1
apt install docker.io -y
usermod -aG docker ubuntu
service docker restart
systemctl enable docker.service
apt-get install -y kubelet kubeadm kubectl kubernetes-cni
systemctl deamon-reload
systemctl daemon-reexec
systemctl start kubelet
systemctl enable kubelet.service


# Kubernetes-Masternode CMD
kubeadm init
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubectl get nodes
kubectl apply -f"https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
kubectl get nodes
kubectl get pods --all-namespaces
