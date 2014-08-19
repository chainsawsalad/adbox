# Enable XDebug ("0" | "1")
$use_xdebug = "1"

# default path
Exec {
  path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin", "/usr/local/bin", "/usr/local/sbin"]
}

# setting these environment variables allows for PhpStorm debugging with CL PHP scripts
$environmentFile = file('/etc/environment')
$nanigansVars = 'SVN_ROOT=/var/www
XDEBUG_CONFIG="remote_enable=1 remote_port=9001 remote_autostart=1 remote_connect_back=1 idekey=nanigans-xdebug remote_host=192.168.56.1 remote_log=/var/log/xdebug.log"
PHP_IDE_CONFIG="serverName=AdboxCentral"'

file { "/etc/environment":
  content => inline_template("<%= @environmentFile %><%= @nanigansVars %>")
}

# create a simple hostname and ip host entry
host { 'tinbox.nanigans.com':
  ip => '192.168.56.102',
  host_aliases => 'tinbox',
}

host { 'localstats.nanigans.com':
  ip => '192.168.56.1',
  host_aliases => 'localstats',
}

include bootstrap
include tools
include apache
include php
include php::pear
include php::pecl
include mysql
include memcached
include svn

