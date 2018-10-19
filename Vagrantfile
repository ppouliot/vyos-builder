# -*- mode: ruby -*-
# vi: set ft=ruby :
[
  { :name => "vagrant-scp", :version => ">= 0.5.7" },
  { :name => "vagrant-puppet-install", :version => ">= 5.0.0" },
  { :name => "vagrant-vbguest", :version => ">= 0.15.1" }
].each do |plugin|
  if not Vagrant.has_plugin?(plugin[:name], plugin[:version])
#    raise "#{plugin[:name]} #[plugin[:version]} is required. Please run `vagrant plugin install #{plugin[:name]}`"
    system "vagrant plugin install #{plugin}"
  end
end

Vagrant.configure("2") do |config|
  config.vm.synced_folder ".", "/etc/puppetlabs/code/modules/vyos_builder", :mount_options => ['dmode=775','fmode=777']
  config.vm.synced_folder "./files/hiera", "/etc/puppetlabs/code/environments/production/data", :mount_options => ['dmode=775','fmode=777']
  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--memory", "2048"]
    v.linked_clone = true
  config.puppet_install.puppet_version = :latest
  config.vm.provision "shell", path: "apt-get update -y && apt-get install -y wget curl rsync screen"
  config.vm.provision "shell", inline: "/opt/puppetlabs/puppet/bin/gem install r10k hiera-eyaml"
  config.vm.provision "shell", inline: "curl -o /etc/puppetlabs/code/environments/production/Puppetfile https://raw.githubusercontent.com/ppouliot/puppet-vyos_builder/puppet/Puppetfile"
  config.vm.provision "shell", inline: "curl -o  /etc/puppetlabs/puppet/hiera.yaml https://raw.githubusercontent.com/ppouliot/puppet-vyos_builder/puppet/files/hiera/hiera.yaml"
#  config.vm.provision "shell", inline: "cd /etc/puppetlabs/code/environments/production && /opt/puppetlabs/puppet/bin/r10k puppetfile install --verbose DEBUG2"
#  config.vm.provision "shell", inline: "/opt/puppetlabs/bin/puppet module list --tree"
#  config.vm.provision "shell", inline: "/opt/puppetlabs/bin/puppet apply --debug --trace --verbose --modulepath=/etc/puppetlabs/code/environments/production/modules:/etc/puppetlabs/code/modules /etc/puppetlabs/code/modules/vyos_builder/examples/init.pp"
# Advanced Puppet Example
#config.vm.provision :shell, :privileged => false do |shell|
#  shell.inline = "puppet apply --debug --modulepath '/vagrant/#{ENV.fetch('MODULES_PATH', 'modules')}' --detailed-exitcodes '/vagrant/#{ENV.fetch('MANIFESTS_PATH', 'manifests')}/#{ENV.fetch('MANIFEST_FILE', 'site.pp')}'"
#end

  end
  config.vm.define "vyos-builder" do |v|
    v.vm.box = "debian/jessie64"
    v.vm.hostname = "vyos-builder.contoso.ltd"
  end
end
