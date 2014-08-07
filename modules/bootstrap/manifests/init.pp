class bootstrap {

  # silence puppet and vagrant annoyance about the puppet group
  group { 'puppet':
    ensure => 'present'
  }

  # ensure local apt cache index is up to date before beginning
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update'
  }
  
  exec { 'apt-get upgrade': 
    command => '/usr/bin/apt-get upgrade -y',
    require => Exec["apt-get update"]
  }
}
