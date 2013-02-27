class erlang::elixir{
  include erlang::params
  class{"erlang::elixir::dependencies":}
  -> class{"erlang::elixir::download":}
  -> class{"erlang::elixir::adjust_path":}
}

class erlang::elixir::dependencies{
  erlang::elixir::package{["wget", "unzip", "build-essential"]:}
}

define erlang::elixir::package{
  if ! defined(Package[$name])    { package { $name: ensure => installed } }
}

class erlang::elixir::download{
  exec{"elixir::download":
    command => "wget $erlang::params::elixir_url",
    cwd     => "/var/tmp",
    unless  => "test -e $erlang::params::elixir_file"
  }
  -> exec{"elixir::unzip":
    command => "unzip $erlang::params::elixir_file -d /opt/$erlang::params::elixir_folder",
    cwd     => "/var/tmp",
    unless  => "test -e /opt/$erlang::params::elixir_folder"
  }
  -> file{"/opt/elixir":
    target => "/opt/$erlang::params::elixir_folder"
  }
}

class erlang::elixir::adjust_path{
  exec{"elixir::adjust_path":
    command => "echo 'PATH=/opt/elixir/bin:\$PATH' >> /etc/profile && source /etc/profile",
    unless  => "grep elixir /etc/profile"
  }
}