class tools {

  # package install list
  $packages = [
    "curl",
    "emacs",
    "git-core",
    "htop",
    "vim"
  ]

  # install packages
  package { $packages:
    ensure => present,
    require => Exec["apt-get update"]
  }
}
