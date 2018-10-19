define vyatta::protocols::bgp (
  $ensure = present,
  $bgp = $name,
  $configuration,
) {
  concat::fragment { "bgp_${bgp}":
    target  => "${vyatta::vyos_configuration_file}",
    content => template('vyatta/bgp.erb'),
    order   => 621,
  }
}
