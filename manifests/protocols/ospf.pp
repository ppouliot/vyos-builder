# define vyatta::protocols::ospf
define vyatta::protocols::ospf (
  $configuration,
  $ensure = present,
  $ospf = $name,
) {
  concat::fragment { "ospf_${ospf}":
    target  => $vyatta::vyos_configuration_file,
    content => template('vyatta/ospf.erb'),
    order   => 621,
  }
}
