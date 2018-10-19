# define vyatta::policy::access_list
define vyatta::policy::access_list (
  $configuration,
  $ensure = present,
  $access_list = $name,
) {
  concat::fragment { "access_list_${access_list}":
    target  => $vyatta::vyos_configuration_file,
    content => template('vyatta/access_list.erb'),
    order   => 301,
  }
}
