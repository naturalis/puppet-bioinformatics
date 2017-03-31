#
#
#
class bioinformatics::biopython() {

  ensure_packages(['python-pip'])
  exec {'install numpy' :
    command => '/usr/bin/pip install numpy',
  } ->

  exec {'install biopython' :
    command => '/usr/bin/pip install biopython',
  }

}
