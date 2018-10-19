define vyatta::system::system (
  $ensure = present,
  $configuration,
  $system = $name,
) {
  concat::fragment { "system_${system}":
    target  => "${vyatta::vyos_configuration_file}",
    content => template('vyatta/system.erb'),
    order   => 502,
  }
}
