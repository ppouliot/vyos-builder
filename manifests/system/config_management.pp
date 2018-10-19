# define vyatta::system::config_management
define vyatta::system::config_management (
  $configuration,
  $ensure = present,
  $config_management = $name,
) {
  concat::fragment { "config_management_${config_management}":
    target  => $vyatta::vyos_configuration_file,
    content => template('vyatta/config_management.erb'),
    order   => 506,
  }
}
