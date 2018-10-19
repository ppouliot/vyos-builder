# define vyatta::policy::prefix_list
define vyatta::policy::prefix_list (
  $configuration,
  $ensure = present,
  $prefix_list = $name,
) {
  concat::fragment { "prefix_list_${prefix_list}":
    target  => $vyatta::vyos_configuration_file,
    content => template('vyatta/prefix_list.erb'),
    order   => 301,
  }
}
