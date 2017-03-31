#these are very rude but uniform
#way of installing plyslocec
#required R 3.3.0 or higher
#requires puppet and puppetlabs stdlib
# in practise runs:
# wget https://raw.githubusercontent.com/joey711/phyloseq/master/inst/scripts/installer.R -O /tmp/phyloseq_installer.R ;\
# Rscript -e "source('/tmp/phyloseq_installer.R',local = TRUE);install_phyloseq(branch = 'github')" ;\
# libss-dev libcurl4-openss-dev curl
class bioinformatics::phyloseq(){

  ensure_packages(['curl','libssl-dev','libcurl4-openssl-dev'])

  exec { 'check R version > 3.3' :
    command => '/usr/bin/r --version | grep 3.3',
  }

  file {'phyloseq install script' :
    path   => '/tmp/phyloseq_installer.R',
    source => 'https://raw.githubusercontent.com/joey711/phyloseq/master/inst/scripts/installer.R',
  }

  exec { 'compile phyloseq (takes some time)' :
    command => '/usr/bin/Rscript -e "source(\'/tmp/phyloseq_installer.R\',local = TRUE); install_phyloseq(branch = \'github\')" ',
    timeout => 1800,
    require => Exec['check R version > 3.3'],
  }


}
