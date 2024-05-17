{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "tomasz";
  home.homeDirectory = "/home/tomasz";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  targets.genericLinux.enable = true;
  xdg.mime.enable = true;

  home.activation = {
    linkDesktopApplications = {
      after = [ "writeBoundary" "createXdgUserDirectories" ];
      before = [ ];
      data = "/usr/bin/sudo /usr/bin/chmod -R 777 $HOME/.nix-profile/share/applications && /usr/bin/update-desktop-database $HOME/.nix-profile/share/applications";
    };
  };

  nixpkgs.config = {
    allowUnfreePredicate = _: true;
    permittedInsecurePackages = [
      "electron-25.9.0"
      "electron-24.8.6"
    ];
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [

    # terminal tools
    pkgs.nixpkgs-fmt
    pkgs.jq
    pkgs.ripgrep
    pkgs.bat
    pkgs.eza
    pkgs.neovim

    # git
    pkgs.diff-so-fancy
    pkgs.lazygit

    # programming
    pkgs.rustup
    pkgs.nodejs_20

    # applications
    pkgs.slack
    pkgs._1password-gui
    pkgs.obsidian
    pkgs.bruno

    # fonts
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

  ];
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/nvim" = { source = ./../nvim; recursive = true; };
    ".config/nix/nix.conf".source = ./nix.conf;
    ".config/zellij" = { source = ./../zellij; recursive = true; };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    oh-my-zsh = {
      enable = true;
    };
    shellAliases = {
      ls = "eza";
      cat = "bat";
      lg = "lazygit";

      vim = "nvim";
      v = "nvim .";
      # Git 
      gdc = "git diff --cached";
      glog = "git log --oneline";

      # Gradle
      gb = "./gradlew build";
      gkf = "./gradlew ktlintFormat";
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  # Git Configuration 
  programs.git = {
    enable = true;
    userName = "Tomasz Bawor";
    userEmail = "bawortomasz@gmail.com";
  };

  programs.java = {
    enable = true;
    package = pkgs.temurin-bin-21;
  };

  programs.go.enable = true;

  programs.chromium.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
  };

}
