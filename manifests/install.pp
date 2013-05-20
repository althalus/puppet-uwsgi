class uwsgi::install {
  package { $uwsgi::package:
    ensure => $uwsgi::package_version,
  }
  if $uwsgi::python != undef {
    uwsgi::plugin { 'python':
      ensure => $uwsgi::python
    }
  }
  if $uwsgi::ruby18 != undef {
    uwsgi::plugin { 'rack-ruby1.8':
      ensure => $uwsgi::ruby18
    }
  }
  if $uwsgi::ruby191 != undef {
    uwsgi::plugin { 'rack-ruby1.9.1':
      ensure => $uwsgi::ruby191
    }
  }
  if $uwsgi::erlang != undef {
    uwsgi::plugin { 'erlang':
      ensure => $uwsgi::erlang
    }
  }
}
