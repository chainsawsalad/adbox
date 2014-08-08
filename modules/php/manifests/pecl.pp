class php::pecl {
  include php

  # upgrade Xdebug, newer version available than apt-get, but still want apt-get to do it's thing with config files
  exec { "pecl install xdebug":
    require => [Package["php5"], Package["php5-cli"], Package["php5-dev"]],
    #notify  => Service['apache2'],
    #logoutput => true
  }
}
