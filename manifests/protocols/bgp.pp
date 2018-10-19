# define vyatta::protocols::bgp
define vyatta::protocols::bgp (
  $configuration,
  $ensure = present,
  $bgp = $name,
) {
  concat::fragment { "bgp_${bgp}":
    target  => $vyatta::vyos_configuration_file,
    content => template('vyatta/bgp.erb'),
    order   => 621,
  }
}
