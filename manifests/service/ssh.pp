# define vyatta::service::ssh
define vyatta::service::ssh (
  $configuration = {},
  $ensure = present,
  $ssh = $name,
) {
  concat::fragment { "ssh_${ssh}":
    target  => $vyatta::vyos_configuration_file,
    content => template('vyatta/ssh.erb'),
    order   => 401,
  }
}
