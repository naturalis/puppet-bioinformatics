# make function
# runs configure make and make install
#

define bioinformatics::utils::make(
  $configure_arguments = '',
  $make_install        = true,
  $timeout             = 600,
  $logoutput          = false,
  ) {

    $configure_cmd = "${name}/configure ${configure_arguments}"

    Exec {
      cwd        => $name,
      timeout    => $timeout,
      logoutput => $logoutput
    }

    exec {"${name} - configure" :
      command => $configure_cmd,
    }

    exec {"${name} - make" :
      command => '/usr/bin/make',
      require => Exec["${name} - configure"],
    }

    if ($make_install) {
      exec {"${name} - make install" :
        command => '/usr/bin/make install',
        require => Exec["${name} - make"],
      }
    }
}
