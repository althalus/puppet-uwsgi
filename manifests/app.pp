define uwsgi::app (
  $ensure         = 'present',
  $enabled        = true,
  $vhost          = true,
  $plugins       = 'python',
  $http_socket    = undef,
  $socket         = undef,
  $master         = true,
  $enable_threads = true,
  $processes      = 2,
  $env            = undef,
  $pythonpath     = undef,
  $wsgi_file      = undef,
  $touch_reload   = undef,
  $virtualenv     = undef,
  $chdir          = undef,
  $uid            = undef,
  $gid            = undef,
  $module         = undef,
  $home           = undef,
) {

  validate_re($ensure, '^(present|absent)$',
    'ensure must be "present" or "absent".')

  validate_bool($enabled)


  $available_path = "${uwsgi::app_dir}/apps-available/${name}.ini"
  $enabled_path = "${uwsgi::app_dir}/apps-enabled/${name}.ini"

  file { $available_path:
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('uwsgi/app.erb'),
  }

  $enable_ensure = $ensure ? {
    'present' => $enabled ? {
        true => 'link',
        false => 'absent'
    },
    default => 'absent'
  }

  file { $enabled_path:
    ensure => $enable_ensure,
    target => $available_path,
    require => File[$available_path],
    notify => Service['uwsgi'],
  }

}
