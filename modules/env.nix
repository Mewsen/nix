{ ... }: {
  environment.sessionVariables = rec {
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_CACHE_HOME = "$HOME/.cache";
    WORKSPACE = "$HOME/workspace";
    PERSONAL = "$HOME/personal";

    DOCKER_HOST = "unix://$XDG_RUNTIME_DIR/docker.sock";

    CARGO_HOME = "${WORKSPACE}/cargo";
    RUSTUP_HOME = "${WORKSPACE}/rustup";

    GOPATH = "${WORKSPACE}/go";
    GOBIN = "${GOPATH}/bin/";

    ZDOTDIR = "${XDG_CONFIG_HOME}/zsh";

    LANG = "en_US.UTF-8";
    EDITOR = "nvim";

    TERM = "xterm-256color";

    PATH =
      [ "${WORKSPACE}/go/bin" "${WORKSPACE}/cargo/bin" "$HOME/.local/bin" ];
  };
}
