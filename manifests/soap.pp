#
#
#
### SOAP
# mkdir /opt/SOAPdenovo ;\
#curl -L https://sourceforge.net/projects/soapdenovotrans/files/latest/download?source=files | tar -xzC /opt/SOAPdenovo/ ;\
#ln -s /opt/SOAPdenovo/SOAPdenovo-Trans-127mer /usr/local/bin
class bioinformatics::soap(){

  file {'/opt/SOAPdenovo' :
    ensure => directory,
  } ->

  archive { 'SOAPdenovo' :
    path         => '/tmp/SOAPdenovo.tar.gz',
    source       => 'https://sourceforge.net/projects/soapdenovotrans/files/latest/download?source=files',
    extract      => true,
    extract_path => '/opt/SOAPdenovo',
    cleanup      => true,
  } ->

  file {'/usr/local/bin/SOAPdenovo-Trans-127mer' :
    ensure => link,
    target => '/opt/SOAPdenovo/SOAPdenovo-Trans-127mer'
  }

}
