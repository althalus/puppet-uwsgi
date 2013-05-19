class uwsgi (
  $package         = $uwsgi::params::package,
  $package_version = 'installed',
  $python          = undef,
  $ruby18          = undef,
  $ruby191         = undef,
  $erlang          = undef
) inherits uwsgi::params {

  include uwsgi::install
  include uwsgi::service
}
