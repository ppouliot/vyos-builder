# define vyatta::service::webproxy
define vyatta::service::webproxy (
  $configuration = {},
  $ensure = present,
  $webproxy = $name,
) {
  concat::fragment { "webproxy_${webproxy}":
    target  => $vyatta::vyos_configuration_file,
    content => template('vyatta/webproxy.erb'),
    order   => 403,
  }
}
