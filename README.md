# vyos-builder - Build the build system for custom VyOS images

## Ansible

* [ppouliot.vyos-builder](https://github.com/ppouliot/vyos-builder/tree/ansible)

## Puppet

* [ppouliot-vyos_builder](https://github.com/ppouliot/vyos-builder/tree/puppet)



##  The Process
1. Download [vyos-build](https://github.com/vyos/vyos-build)
2. Build the Dockerfile  \
3. Use the Docker image just created to run bin/get_packages.sh <your package>
   and get all the dependencies.
4. bin/build_vyos.sh creates an iso with the additional packages.


