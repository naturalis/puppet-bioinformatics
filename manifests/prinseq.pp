#
#
#
class bioinformatics::prinseq(){

  ensure_packages(['libgraphics-primitive-driver-cairo-perl',
                    'libjson-perl','cpanminus'])
  ### PRINSEQ #requires libgraphics-primitive-driver-cairo-perl libjson-perl cpanminus
  # cpanm Statistics::PCA ; \
  # curl -L http://downloads.sourceforge.net/project/prinseq/standalone/prinseq-lite-0.20.4.tar.gz | tar -xzC /opt/ ; \
  # ln -s /opt/prinseq-lite-0.20.4/prinseq-lite.pl /usr/bin/prinseq-lite ; \
  # ln -s /opt/prinseq-lite-0.20.4/prinseq-graphs.pl /usr/bin/prinseq-graphs ; \
  # chmod +x /opt/prinseq-lite-0.20.4/*.pl


  archive {'prinseq-lite-0.20.4.tar.gz' :
    source       => 'http://downloads.sourceforge.net/project/prinseq/standalone/prinseq-lite-0.20.4.tar.gz',
    path         => '/tmp/prinseq-lite-0.20.4.tar.gz',
    extract      => true,
    extract_path => '/opt',
  }

  exec {'make pinseq executable' :
    command => '/usr/bin/chmod +x /opt/prinseq-lite-0.20.4/*.pl',
    require => Archive['prinseq-lite-0.20.4.tar.gz']
  }

  file {'/usr/bin/prinseq-lite' :
    ensure => link,
    target => '/opt/prinseq-lite-0.20.4/prinseq-lite.pl'
  }

  file {'/usr/bin/prinseq-graphs' :
    ensure => link,
    target => '/opt/prinseq-lite-0.20.4/prinseq-graphs.pl'
  }

  exec {'install Statistics::PCA' :
    command => '/usr/bin/cpanm Statistics::PCA'
  }

}
