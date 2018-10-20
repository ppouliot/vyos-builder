   cd /tmp
    logger "import vyos keys"
    key=0x0694A9230F5139BF834BA458FD220285A0FE6D7E
    gpg --keyserver pgp.mit.edu --recv-keys $key
    gpg --armor --export $key >./vyos.maintainers.key
    apt-key add ./vyos.maintainers.key

    logger "these dependencies were discovered building lithum on debian 6"
    logger "we assume they have not changed much for debian 8"

    logger "install build dependencies"
    apt-get -y install git autoconf automake dpkg-dev syslinux genisoimage devscripts

    logger "install undocumented dependencies found by submod-clean"
    apt-get -y install autogen bison cdbs flex gawk gcc-multilib \
        hardening-wrapper indent iptables-dev libapt-pkg-dev libatm1-dev \
        libattr1-dev libboost-filesystem-dev libcap-dev \
        libc-ares-dev libcurl4-openssl-dev \
        libdaemon-dev libdb-dev libdb-dev libdevmapper-dev libedit-dev \
        libexpat1-dev libfreetype6-dev libglib2.0-dev libgmp3-dev libkrb5-dev \
        libldap2-dev libncurses5-dev libnetfilter-conntrack-dev \
        libnfnetlink-dev libpam0g-dev libpcap0.8-dev libpci-dev \
        libperl-dev libpgm-dev libpopt-dev libreadline-dev libsensors4-dev \
        libsnmp-dev libssl-dev libtool libusb-dev \
        libwrap0-dev libxml2-dev libzmq-dev lynx pkg-config python-all-dev \
        python-setuptools quilt ruby uuid-dev xfonts-unifont zlib1g-dev

    logger "install undocumented dependencies found by build attempts"
    logger "keep the local version of the kernel config file"
    apt-get -y install kernel-package dkms doxygen libcunit1-dev libdumbnet-dev \
        libfuse-dev libgtk2.0-dev libgtkmm-3.0-dev libicu-dev libnotify-dev \
        libx11-dev libxinerama-dev libxss-dev libxtst-dev dh-autoreconf \
        xmlto mscgen graphviz python-pygments xmlstarlet asciidoc source-highlight

    logger "install undocumented dependencies found by lithium build attempts"
    apt-get -y install libcluster-glue-dev cluster-glue-dev libbz2-dev swig \
        libgnutls28-dev libopenhpi-dev libopenipmi-dev liblzo2-dev \
        libpkcs11-helper1-dev libsqlite3-dev \
        libsysfs-dev libpcsclite-dev

    logger "install documented dependencies for vyos 1.2 builds"
    apt-get -y install live-build pbuilder python3-pystache

    logger "install undocumented dependencies found by previous build attempts"
    apt-get -y install squashfs-tools module-init-tools dh-systemd subversion \
        acl adduser dmsetup insserv libaudit-common libaudit1 \
        libbz2-1.0 libcap2 libcap2-bin libcryptsetup4 libdb5.3 libdebconfclient0 \
        libdevmapper1.02.1 libgcrypt20 libgpg-error0 libkmod2 libncursesw5 \
        libprocps3 libsemanage-common libsemanage1 libslang2 libsystemd0 \
        libudev1 libustr-1.0-1 procps systemd systemd-sysv udev \
        debian-archive-keyring gnupg gpgv libapt-pkg4.12 libreadline6 libstdc++6 \
        libusb-0.1-4 readline-common \
        python3-setuptools python3-lxml

    logger "add backports"
    echo "deb http://ftp.debian.org/debian jessie-backports main" >>/etc/apt/sources.list
    apt-get update

    logger "add dependencies for building system packages modified for vyos"
    apt-get -y install gnat gprbuild
    apt-get -y install libpcap-dev libpq-dev libmysqlclient-dev libgeoip-dev librabbitmq-dev libjansson-dev librdkafka-dev libnetfilter-log-dev
    apt-get -y install libgtkmm-2.4-dev libprocps-dev libmspack-dev libxerces-c-dev libxml-security-c-dev
    apt-get -y install libmysqld-dev
    apt-get -y install libmnl-dev libnetfilter-cthelper0-dev libnetfilter-cttimeout-dev libnetfilter-queue-dev
    apt-get -y install default-libmysqlclient-dev
    apt-get -y install libnl-3-dev libnl-genl-3-dev
    apt-get -y install libfcgi-dev clearsilver-dev libgcrypt20-dev network-manager-dev libnm-glib-vpn-dev libnm-util-dev gperf
    apt-get -y install python3-git

    logger "look for pending upgrades"
    apt-get upgrade
}

function phase2 {
    arch=$(dpkg --print-architecture)
    flavor=amd64-vyos
    [ $arch == "i386" ] && flavor=586-vyos

    logger "look for pending upgrades for arch $arch"
    apt-get -y install libnl-3-dev libnl-genl-3-dev
    apt-get -y install libfcgi-dev clearsilver-dev libgcrypt20-dev network-manager-dev libnm-glib-vpn-dev libnm-util-dev gperf
    apt-get -y install python3-git
    apt-get upgrade

    logger "setup git clone, building flavor $flavor from branch $branch"
    git clone https://github.com/vyos/vyos-build.git
    cd vyos-build
    git checkout $branch

    p=vyos-build
    if [ -f ../updates/$p.git.patch ]; then
        logger "patch package $p"
        git apply ../updates/$p.git.patch
    fi

    logger "add missing submodules"
    git submodule add https://github.com/vyos/conntrack-tools packages/conntrack-tools
    git submodule add https://github.com/vyos/ddclient packages/ddclient
    git submodule add https://github.com/vyos/eventwatchd packages/eventwatchd
    git submodule add https://github.com/vyos/hvinfo packages/hvinfo
    git submodule add https://github.com/vyos/igmpproxy packages/igmpproxy
    git submodule add https://github.com/vyos/live-boot packages/live-boot
    git submodule add https://github.com/vyos/net-snmp packages/net-snmp
    git submodule add https://github.com/vyos/pmacct packages/pmacct
    git submodule add https://github.com/vyos/radvd packages/radvd
    git submodule add https://github.com/vyos/vyatta-biosdevname packages/vyatta-biosdevname
    git submodule add https://github.com/vyos/vyatta-quagga packages/vyatta-quagga
    git submodule add https://github.com/vyos/vyos-opennhrp packages/vyos-opennhrp
    git submodule add https://github.com/vyos/vyos-replace packages/vyos-replace
    git submodule add https://github.com/vyos/vyos-strongswan packages/vyos-strongswan
    git submodule add https://github.com/vyos/xl2tpd packages/xl2tpd
    ./configure

    logger "fetch source from vyos"
    git submodule init
    git submodule update
    for i in packages/*; do
        if [ -e "$i/.git" ]; then
            p=$(basename "$i")
            logger "select branch $branch for package $p"
            pushd "$i"
            git checkout $branch
            if [ $? -eq 1 ]; then
                git checkout master
            fi
            if [ -f ../../../updates/$p.git.patch ]; then
                logger "patch package $p"
                git apply ../../../updates/$p.git.patch
            fi
            popd
        fi
    done

    logger "new kernel not yet on branch current"
    pushd packages/vyos-kernel
    git checkout linux-vyos-4.14.y
    popd

    logger "show active branches"
    for i in packages/*; do
        if [ -e "$i/.git" ]; then
            (cd $i; b=$(git branch | grep '^\*'); echo $i "$b")
        fi
    done

    logger "kill off packages that would be built, but not part of the iso"
    for i in vyatta-cron; do
        [ -d packages/$i ] && rm -rf packages/$i && echo "remove package $i"
    done

    logger "rebuild some packages needed to build the rest"
    apt-get -y remove libsnmp-dev
    for i in packages/net-snmp; do
        p=$(basename $i)
        if [ -e "$i/.git" ]; then
            pushd $i
            b=$(git branch | grep '^\*' | cut -c3-)
            logger "building source package $p on branch $b"
            dpkg-buildpackage -us -uc -b >vyos.build.log 2>&1
            cat vyos.build.log
            pp=$(grep 'dpkg-deb: building package' vyos.build.log | awk '{print $6}' | cut -c5- | rev | cut -c3- | rev)
            for pb in $pp; do
                if [ -f "../$pb" ]; then
                    echo "built binary $pb from source $p"
                else
                    echo "failed to build binary $pb from source $p"
                fi
            done
            [ -z "$pp" ] && echo "failed to build binary from source $p"
            popd
        fi
    done

    logger "kill off the debug packages"
    echo packages/*-dbg_*.deb
    rm -f packages/*-dbg_*.deb

    logger "install some rebuilt packages"
    PKGS="
        packages/*snmp*.deb
    "
    dpkg -i $PKGS

    logger "rebuild all packages from source"
    for i in packages/*; do
        p=$(basename $i)
        if [ -e "$i/.git" ]; then
            pushd $i
            b=$(git branch | grep '^\*' | cut -c3-)
            logger "building source package $p on branch $b"
            if [ "$p" == "vyos-kernel" ]; then
                # https://wiki.vyos.net/wiki/Rebuild_VyOS_kernel_Step#VyOS_1.2.x
                make x86_64_vyos_defconfig
                ls -al debian
                emp=/tmp/empty
                echo "" >$emp
                for i in {1..200}; do echo "" >>$emp; done
                rev=4.4.95-1+vyos1+current1
                rev=$(grep 'Kernel Configuration' .config |  awk '{print $3}')
                echo "kernel config says rev = $rev"
                rev=4.14.26-1+vyos1+current1
                # building kernel_manual per the above wiki article fails
                mods="kernel_source kernel_headers kernel_image"
                mods="kernel_image"
                LOCALVERSION="" make-kpkg --rootcmd fakeroot --initrd \
                    --append_to_version -$flavor --revision=$rev $mods >vyos.build.log <$emp 2>&1
            else
                dpkg-buildpackage -us -uc -b >vyos.build.log 2>&1
            fi
            cat vyos.build.log
            pp=$(grep 'dpkg-deb: building package' vyos.build.log | awk '{print $6}' | cut -c5- | rev | cut -c3- | rev)
            for pb in $pp; do
                if [ -f "../$pb" ]; then
                    echo "built binary $pb from source $p"
                else
                    echo "failed to build binary $pb from source $p"
                fi
            done
            [ -z "$pp" ] && echo "failed to build binary from source $p"
            popd
        fi
    done

    logger "kill off the debug packages"
    echo packages/*-dbg_*.deb
    rm -f packages/*-dbg_*.deb

    logger "build the new iso"
    ./configure
    make iso >iso.build.log 2>&1
    cat iso.build.log

    logger "find vyos packages that were not built from source"
    pushd build
        fn=chroot.packages.install
        egrep 'vyos|vyatta' $fn | while read p v; do
            pp=$(echo $p | cut -d: -f1)
            deb=$(ls ../packages/${pp}_*.deb 2>/dev/null)
            [ -z "$deb" ] && echo "need source for $pp"
        done
    popd
    grep '^Get.*packages.vyos.net' iso.build.log | egrep -v 'InRelease| Packages '

    logger "done, iso in $(pwd)/build"
    ls -al build/*iso
}


case "$1" in
    phase*)
        branch=current
        $1 2>&1 | tee /tmp/$1.log.txt
        ;;
esac

vyatta-cfg-firewall.git.patch 2017-12-26

From e21c1c13426c9ccc03c20a224500156cc4cb51d4 Mon Sep 17 00:00:00 2001
From: Carl Byington <carl@five-ten-sg.com>
Date: Tue, 26 Dec 2017 11:04:38 -0800
Subject: [PATCH 1/1] Revert "Revert "Added support for local PBR to gen-interface-policy-templates.pl""

This reverts commit c48f11fa1b0d6a7b196f9750ef82625dea1aba58.
This adds local PBR again.
---
 gen-interface-policy-templates.pl |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/gen-interface-policy-templates.pl b/gen-interface-policy-templates.pl
index a86c5d6..afea8cf 100755
--- a/gen-interface-policy-templates.pl
+++ b/gen-interface-policy-templates.pl
@@ -107,12 +107,16 @@ sub gen_firewall_template {
 #
 my %table_help_hash = (
     "route"      => "IPv4 policy route",
+    "local-route" => "IPv4 policy route of local traffic",
     "ipv6-route" => "IPv6 policy route",
+    "ipv6-local-route" => "IPv6 policy route of local traffic",
 );
 
 my %config_association_hash = (
     "route"      => "\"policy route\"",
+    "local-route" => "\"policy local-route\"",
     "ipv6-route" => "\"policy ipv6-route\"",
+    "ipv6-local-route" => "\"policy ipv6-local-route\"",
 );
 
 # Generate the template file at the leaf of the per-interface firewall tree.
@@ -120,10 +124,10 @@ my %config_association_hash = (
 # ruleset on an interface for a particular ruleset type and direction.
 #
 sub gen_template {
-    my ( $if_tree, $table, $if_name ) = @_;
+    my ( $if_tree, $direction, $table, $if_name ) = @_;
 
     if ($debug) {
-        print "debug: table=$table\n";
+        print "debug: table=$table direction=$direction\n";
     }
 
     my $template_dir =
@@ -147,16 +151,16 @@ allowed: local -a params
 	echo -n "\${params[@]}"
 create: ifname=$if_name
 	sudo /opt/vyatta/sbin/vyatta-firewall.pl --update-interfaces \\
-		update \$ifname in \$VAR(@) $config_association_hash{$table}
+		update \$ifname $direction \$VAR(@) $config_association_hash{$table}
 
 update:	ifname=$if_name
 	sudo /opt/vyatta/sbin/vyatta-firewall.pl --update-interfaces \\
-		update \$ifname in \$VAR(@) $config_association_hash{$table}
+		update \$ifname $direction \$VAR(@) $config_association_hash{$table}
 
 
 delete:	ifname=$if_name
 	sudo /opt/vyatta/sbin/vyatta-firewall.pl --update-interfaces \\
-		delete \$ifname in \$VAR(@) $config_association_hash{$table}
+		delete \$ifname $direction \$VAR(@) $config_association_hash{$table}
 EOF
 
     close $tp
@@ -173,8 +177,10 @@ foreach my $if_tree ( keys %interface_hash ) {
     }
 
     gen_firewall_template($if_tree);
-    gen_template( $if_tree, "route", $if_name );
-    gen_template( $if_tree, "ipv6-route", $if_name );
+    gen_template( $if_tree, "in", "route", $if_name );
+    gen_template( $if_tree, "out", "local-route", $if_name );
+    gen_template( $if_tree, "in", "ipv6-route", $if_name );
+    gen_template( $if_tree, "out", "ipv6-local-route", $if_name );
 }
 
 print "Done.\n";
-- 
1.7.1
