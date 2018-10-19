define vyatta::interfaces::ethernet (
  $ensure = present,
  $configuration,
  $ethernet = $name
) {

  include vyatta

  concat::fragment { "interfaces_${ethernet}":
    target  => "${vyatta::vyos_configuration_file}",
    content => template('vyatta/ethernet.erb'),
    order   => 201,
  }
}
