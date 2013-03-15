node default{
  #include basic
  class{'basic':
    stage => first
  }
   -> class{"erlang":}
   -> class{"erlang::elixir":}
}