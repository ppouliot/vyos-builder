# https://github.com/DNH-Computing/puppet-vyos/tree/master/templates
configure
set system package repository squeeze components 'main contrib non-free'
set system package repository squeeze distribution 'squeeze'
set system package repository squeeze url 'http://mirrors.kernel.org/debian'
set system package repository squeeze-backports components main
set system package repository squeeze-backports distribution squeeze-backports
set system package repository squeeze-backports url 'http://backports.debian.org/debian-backports'
set system package repository puppetlabs components main
set system package repository puppetlabs distribution squeeze
set system package repository puppetlabs url 'http://apt.puppetlabs.com'
set system package repository puppetlabs-dependencies components dependencies
set system package repository puppetlabs-dependencies distribution squeeze
set system package repository puppetlabs-dependencies url http://apt.puppetlabs.com
commit
save
exit
sudo apt-get update
