define vyatta::interfaces::loopback (
  $ensure = present,
  $configuration,
  $loopback = $name
) {
  concat::fragment { "loopback_${loopback}":
    target  => "${vyatta::vyos_configuration_file}",
    content => template('vyatta/loopback.erb'),
    order   => 201,
  }
}
