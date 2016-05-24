#!/bin/bash
#!/bin/bash

# GetContiv fetches k8s binaries from the contiv release repo
function GetContiv {

  # fetch contiv binaries
  pushd .
  mkdir -p $top_dir/contiv_bin
  if [ -f $top_dir/contiv_bin/netplugin-$contivVer.tar.bz2 ]; then
    echo "netplugin-$contivVer.tar.bz2 found, not fetching."
  else
    cd $top_dir/contiv_bin
    wget https://github.com/contiv/netplugin/releases/download/$contivVer/netplugin-$contivVer.tar.bz2
    tar xvfj netplugin-$contivVer.tar.bz2
  fi
  popd

  if [ ! -f $top_dir/contiv_bin/contivk8s ]; then
    echo "Error contivk8s not found after fetch/extraction"
    exit 1
  fi
}

# contiv version
: ${contivVer:=v0.1-05-02-2016.23-10-27.UTC}

top_dir=$PWD

GetContiv

invFile=.vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory
clusterFile=openshift-ansible/playbooks/common/openshift-cluster/contiv_nw.yml
# run ansible
ansible-playbook -i $top_dir/$invFile $top_dir/../$clusterFile -e "networking=contiv contiv_bin_path=$top_dir/contiv_bin etcd_peers_group=masters ansible_ssh_user=vagrant https_proxy=$https_proxy http_proxy=$http_proxy no_proxy=$no_proxy"

