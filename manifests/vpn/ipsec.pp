# define vyatta::vpn::ipsec
define vyatta::vpn::ipsec (
  $configuration,
  $ensure = present,
  $ipsec = $name,
) {
  concat::fragment { "ipsec_${ipsec}":
    target  => $vyatta::vyos_configuration_file,
    content => template('vyatta/ipsec.erb'),
    order   => 701,
  }
}
