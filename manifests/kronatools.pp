#
#
#
class bioinformatics::kronatools(){

  ### KRONATOOLS
  #RUN curl -L https://github.com/marbl/Krona/releases/download/v2.7/KronaTools-2.7.tar | tar -xC /opt/ ;\
  #    perl /opt/KronaTools-2.7/install.pl
  archive {'download \'n extract kronatools' :
    path         => '/tmp/KronaTools-2.7.tar',
    source       => 'https://github.com/marbl/Krona/releases/download/v2.7/KronaTools-2.7.tar',
    extract_path => '/opt',
    cleanup      => true,
    extract      => true,
  } ->

  exec {'install kronatools' :
    command => '/usr/bin/perl /opt/KronaTools-2.7/install.pl',
    cwd     => '/opt/KronaTools-2.7'
  }

}
