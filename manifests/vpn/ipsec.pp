define vyatta::vpn::ipsec (
  $ensure = present,
  $configuration,
  $ipsec = $name,
) {
  concat::fragment { "ipsec_${ipsec}":
    target  => "${vyatta::vyos_configuration_file}",
    content => template('vyatta/ipsec.erb'),
    order   => 701,
  }
}
