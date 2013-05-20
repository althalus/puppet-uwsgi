define uwsgi::plugin (
    $ensure = present
) {
    include uwsgi

    if ! defined(Package["${plugin_prefix}${name}"]) {
        package { "${plugin_prefix}${name}":
            ensure  => $ensure,
            notify => Service['uwsgi']
        }
    }
}