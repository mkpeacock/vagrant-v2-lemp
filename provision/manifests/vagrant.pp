class {
    'nginx':
        file => 'default'
}

class {
    'php':
        nginx => true
}

host { 'lemp-stack.local':
    ip => '127.0.0.1',
    host_aliases => 'localhost',
}

package { "postfix":
    ensure => present
}

package { "mailutils":
    ensure => present
}

$databases = {
  'lemp' => {
    ensure  => 'present',
    charset => 'utf8'
  },
}

# password = password
$users = {
  'lemp@localhost' => {
    ensure                   => 'present',
    max_connections_per_hour => '0',
    max_queries_per_hour     => '0',
    max_updates_per_hour     => '0',
    max_user_connections     => '0',
    password_hash            => '*2470C0C06DEE42FD1618BB99005ADCA2EC9D1E19',
  },
}

$grants = {
  'lemp@localhost/lemp.*' => {
    ensure     => 'present',
    options    => ['GRANT'],
    privileges => ['ALL'],
    table      => 'lemp.*',
    user       => 'lemp@localhost',
  },
}

class { '::mysql::server':
  root_password    => 'lemp-root-password',
  override_options => { 'mysqld' => { 'max_connections' => '1024' } },
  databases => $databases,
  users => $users,
  grants => $grants,
  restart => true
}

include '::mysql::client'

class { '::mysql::bindings':
  php_enable => true
}

