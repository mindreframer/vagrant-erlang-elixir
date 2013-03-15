class erlang{
  include erlang::params
  class{"erlang::sources":}
  -> class{"erlang::install":}
}

class erlang::sources{
  exec{"erlang::sources":
    command => "echo deb http://binaries.erlang-solutions.com/debian $::lsbdistcodename contrib >> /etc/apt/sources.list",
    unless  => "grep erlang-solutions /etc/apt/sources.list"
  }
  ->
  exec{"erlang::source_auth_key":
    command => "wget -O - http://binaries.erlang-solutions.com/debian/erlang_solutions.asc \
 | sudo apt-key add -",
    unless  => "apt-key list|grep erlang-solutions"
  }
  ->exec{"erlang::apt_get_update":
    command => "apt-get update && touch /var/tmp/.erlang_apt_get_update",
    unless  => "test -e /var/tmp/.erlang_apt_get_update"
  }
}

class erlang::install{
  package{"esl-erlang": ensure => installed}
}
