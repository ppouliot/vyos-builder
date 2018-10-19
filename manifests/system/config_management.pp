define vyatta::system::config_management (
  $ensure = present,
  $configuration,
  $config_management = $name,
) {
  concat::fragment { "config_management_${config_management}":
    target  => "${vyatta::vyos_configuration_file}",
    content => template('vyatta/config_management.erb'),
    order   => 506,
  }
}
