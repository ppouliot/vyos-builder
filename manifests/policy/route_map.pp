# define vyatta::policy::route_map
define vyatta::policy::route_map (
  $configuration,
  $ensure = present,
  $route_map = $name,
) {
  concat::fragment { "route_map_${route_map}":
    target  => $vyatta::vyos_configuration_file,
    content => template('vyatta/route_map.erb'),
    order   => 301,
  }
}
