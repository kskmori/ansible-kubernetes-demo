***Note: This repository is still in progress.***

TODO:
* permanent swapoff / disable SELinux / firewalld
* no idempotency for some tasks (always changed)
* remove temporary token after join nodes

# Kubernetes setup playbook example

## Configuration overview
* 1 master (VM)
* 2 workers (VM)
* Container: Docker
* CNI: Flannel
* all VMs running on the same host node
* all VMs/host have the Internet access via proxy
* use kubeadm to bootstrap

## Versions
* OS
  * CentOS 7.5.1804
* Kubernetes
  * kubeadm/kubectl/kubelet: v1.11.2
* Docker
  * docker-ce-18.06.1.ce-3.el7.x86_64
  * (newer version than CentOS bundled version)
* Flannel
  * kube-flannel.yml add-on: v0.10.0
* Ansible
  * ansible-2.5.5

## Prerequisite
* All VMs must have completed the OS installatin and the network configuration
* all VM hostnames should be configured in /etc/hosts on each VMs
* SSH root login with no password from the ansible host

## Parameters

* copy and customize the inventory file based on hosts.sample
* copy and customize group_vars/all file based on group_vars/all.yml.sample

## Reference documents
* 1. Installing kubeadm
  * https://kubernetes.io/docs/setup/independent/install-kubeadm/
  * playbooks:
    * 10-os-config.yml
    * 11-docker-ce-install.yml
    * 12-kubernetes-install.yml
* 2. Creating a single master cluster with kubeadm
  * https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/
  * playbooks:
    * 13-kube-single-master.yml
    * 14-kube-join-workers.yml
* Tear down / uninstall
  * https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/
  * playbooks:
    * 90-kube-teardown.yml
    * 91-kubernetes-uninstall.yml
    * shutdown all node

## Troubleshooting
* 11-docker-ce-install.yml failed as: ```Error: docker-ce conflicts with 2:docker-1.13.1-74.git6e3bb8e.el7.centos.x86_64\n"```
  * Remove the CentOS bundled version of docker first or use ' --tags remove-old-docker,all' option when running the playbook which will do that.

* kubctl cluster-info dump failed as: ```error: missing apiVersion or kind and cannot assign it; no kind is registered for the type core.NodeList```
  * known issue in v1.11: https://github.com/kubernetes/kubernetes/issues/65221
