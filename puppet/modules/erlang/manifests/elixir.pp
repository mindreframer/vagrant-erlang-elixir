class erlang::elixir{
  class{"erlang::params":}
  -> class{"erlang::elixir::dependencies":}
  -> class{"erlang::elixir::download":}
}

class erlang::elixir::dependencies{
  erlang::elixir::package{["wget", "unzip"]:}
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
    command => "unzip $erlang::params::elixir_file -d $erlang::params::elixir_folder",
    cwd     => "/var/tmp",
    unless  => "test -e $erlang::params::elixir_folder"
  }
}