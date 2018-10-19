# define vyatta::system::system
define vyatta::system::system (
  $configuration,
  $ensure = present,
  $system = $name,
) {
  concat::fragment { "system_${system}":
    target  => $vyatta::vyos_configuration_file,
    content => template('vyatta/system.erb'),
    order   => 502,
  }
}
