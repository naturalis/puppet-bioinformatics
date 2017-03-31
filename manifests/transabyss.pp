#
#
#
  #  pip install python-igraph ;\
  #   curl -L http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/blat/blat > /usr/bin/blat ;\
  #   chmod +x /usr/bin/blat ;\
  #   curl -L https://sourceforge.net/projects/libpng/files/libpng12/1.2.57/libpng-1.2.57.tar.gz/download | tar -xzC /opt/ ;\
  #   cd /opt/libpng-1.2.57 && ./configure && make && make install && ln -s /usr/local/lib/libpng12.so.0 /lib/x86_64-linux-gnu/libpng12.so.0 ;\
  #     curl http://ftp.us.debian.org/debian/pool/main/o/openmpi/libopenmpi1.6_1.6.5-9.1_amd64.deb > /opt/libopenmpi1.6_1.6.5-9.1_amd64.deb && dpkg -i /opt/libopenmpi1.6_1.6.5-9.1_amd64.deb ;\
  #   curl http://ftp.us.debian.org/debian/pool/non-free/a/abyss/abyss_1.5.2-1_amd64.deb > /opt/abyss_1.5.2-1_amd64.deb && dpkg -i /opt/abyss_1.5.2-1_amd64.deb ;\
  #   curl -L http://www.bcgsc.ca/platform/bioinfo/software/trans-abyss/releases/1.5.5/transabyss-1.5.5.zip > /opt/transabyss-1.5.5.zip ;\
  #   cd /opt && unzip transabyss-1.5.5.zip
class bioinformatics::transabyss(){

  ensure_packages(['python',
                  'libxml2',
                  'python-libxml2',
                  'libxml2-dev',
                  'libcr0',
                  'python-igraph',
                  'libhwloc5',
                  'libibverbs1'])


  file {'blat' :
    path   => '/usr/bin/blat',
    source => 'http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/blat/blat',
    mode   => '0775',
  }

  archive { 'libpng-1.2.57.tar.gz' :
    source       => 'https://sourceforge.net/projects/libpng/files/libpng12/1.2.57/libpng-1.2.57.tar.gz/download',
    path         => '/tmp/libpng-1.2.57.tar.gz',
    extract      => true,
    extract_path => '/opt',
    cleanup      => true,
  }

  ::bioinformatics::utils::make {'/opt/libpng-1.2.57' :
    require => Archive['libpng-1.2.57.tar.gz'],
    before  => File['/lib/x86_64-linux-gnu/libpng12.so.0'],
  }

  file {'/lib/x86_64-linux-gnu/libpng12.so.0' :
    ensure => link,
    target => '/usr/local/lib/libpng12.so.0',
  }

  archive {'install openmpi1.6' :
    path            => '/tmp/libopenmpi1.6_1.6.5-9.1_amd64.deb',
    source          => 'http://ftp.us.debian.org/debian/pool/main/o/openmpi/libopenmpi1.6_1.6.5-9.1_amd64.deb',
    extract         => true,
    extract_flags   => '',
    extract_path    => '/tmp',
    extract_command => '/usr/bin/dpkg -i %s',
    cleanup         => true,
  }


  archive {'install abyss 1.5.2' :
    path            => '/tmp/abyss_1.5.2-1_amd64.deb',
    source          => 'http://ftp.us.debian.org/debian/pool/non-free/a/abyss/abyss_1.5.2-1_amd64.deb',
    extract         => true,
    extract_flags   => '',
    extract_path    => '/tmp',
    extract_command => '/usr/bin/dpkg -i %s',
    cleanup         => true,
  }


  archive { 'install transabyss' :
    source       => 'http://www.bcgsc.ca/platform/bioinfo/software/trans-abyss/releases/1.5.5/transabyss-1.5.5.zip',
    path         => '/tmp/transabyss-1.5.5.zip',
    extract      => true,
    extract_path => '/opt',
    cleanup      => true,
  }


  file {'/usr/bin/transabyss' :
    ensure => link,
    target => '/opt/transabyss-1.5.5/transabyss',
  }

  file {'/usr/bin/transabyss-merge' :
    ensure => link,
    target => '/opt/transabyss-1.5.5/transabyss-merge',
  }

}
