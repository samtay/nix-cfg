{ config, pkgs, lib, ... }:

let name = "Sam Tay";
    user = "samtay";
    email = "samctay@pm.me"; in
{
  # Shared shell configuration
  zsh = {
    enable = true;
  };

  git = {
    enable = true;
    userName = name;
    userEmail = email;
    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILSOyLI6M+OWZsE10mkZMcbnQ1a/wnjPgX1eNHJ6iYYo";
      signByDefault = true;
    };
    ignores = [ "*.swp" ".DS_Store" ];
    extraConfig = {
      gpg = {
        format = "ssh";
      };
      "gpg \"ssh\"" = {
        program = "${pkgs._1password-gui}/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
        # program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
        # program = "/opt/1Password/op-ssh-sign";
      };
      column = {
        ui = "auto";
      };
      help = {
        autocorrect = "prompt";
      };
      core = {
        fsmonitor = true;
        untrackedCache = true;
      };
      merge = {
        conflictstyle = "zdiff3";
      };
      commit = {
        verbose = true;
      };
      rerere = {
        enabled = true;
        autoupdate= true;
      };
      branch = {
        autosetuprebase = "always";
        rebase = true;
        sort = "-committerdate";
      };
      tag = {
        sort = "version:refname";
      };
      advice = {
        detachedHead = false;
      };
      init = {
        defaultBranch = "main";
      };
      rebase = {
        autoSquash = true;
        autoStash = true;
        updateRefs = true;
      };
      push = {
        default = "simple";
        autoSetupRemote = true;
        followTags = true;
      };
      pull = {
        rebase = true;
      };
      fetch = {
        prune = true;
        pruneTags = true;
        all = true;
      };
      diff = {
        algorithm = "histogram";
        mnemonicPrefix = true;
        colorMoved = "plain";
        renames = true;
      };
    };
    attributes = ["*.pdf diff=pdf"];
    delta = {
      enable = true;
      options = {
        navigate = true;
        side-by-side = false;
        line-numbers = true;
        syntax-theme = "gruvbox-light";
        whitespace-error-style = "22 reverse"; # ?
      };
    };
    maintenance = {
      enable = true;
      repositories = ["${config.home.homeDirectory}/code/mwb" "${config.home.homeDirectory}/code/mwb-2"];
    };
    aliases = {
      # List commits in short form, with colors and branch/tag annotations
      ls = "log --pretty=format:\"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]\" --decorate";

      # List commits showing changes files
      ll = "log --pretty=format:\"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]\" --decorate --numstat";

      # List oneline commits showing dates
      lds = "log --pretty=format:\"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]\" --decorate --date=short";

      # List oneline commits showing relative dates
      ld = "log --pretty=format:\"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]\" --decorate --date=relative";

      # Basic oneline
      le = "log --oneline --decorate";

      # Better git log
      lg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";

      # Display a log tree
      logtree = "log --graph --oneline --decorate --all";

      # Show repository contributers
      who = "shortlog -n -s --no-merges";

      # Information about the current commit
      whatis = "show -s --pretty='tformat:%h (%s, %ad)' --date=short";

      # See all commits related to a file
      filelog = "log -u";
      fl = "log -u";

      # Concise commits related to file
      follow = "log --follow --stat";

      # Show modified files in last commit
      dl = "\"!git ll -1\"";

      # Show a diff of the last commit
      dlc = "show HEAD^";

      # Show content (full diff) of a commit given a revision
      dr  = "\"!f() { git diff \"$1\"^..\"$1\"; }; f\"";
      lc  = "\"!f() { git ll \"$1\"^..\"$1\"; }; f\"";
      diffr  = "\"!f() { git diff \"$1\"^..\"$1\"; }; f\"";

      # Find a file path in codebase
      f = "\"!git ls-files | grep -i\"";

      # Search/grep your entire codebase for a string
      grep = "grep -Ii";
      gr = "grep -Ii";

      # Grep from root folder
      gra = "\"!f() { A=$(pwd) && TOPLEVEL=$(git rev-parse --show-toplevel) && cd $TOPLEVEL && git grep --full-name -In $1 | xargs -I{} echo $TOPLEVEL/{} && cd $A; }; f\"";

      # Output your aliases
      la = "!git config --get-regexp 'alias.*' | colrm 1 6 | sed 's/[ ]/ = /'";

      # Assume a file as unchanged
      assume = "update-index --assume-unchanged";

      # Unassume a file
      unassume = "update-index --no-assume-unchanged";

      # Show assumed files
      assumed = "\"!git ls-files -v | grep ^h | cut -c 3-\"";

      # Unassume all assumed files
      unassumeall = "\"!git assumed | xargs git update-index --no-assume-unchanged\"";

      # Assume all
      assumeall = "\"!git st -s | awk {'print $2'} | xargs git assume\"";

      # Show the last tag
      lasttag = "describe --tags --abbrev=0";
      lt = "describe --tags --abbrev=0";

      # Shows a list of files that have a merge conflict
      conflicts = "diff --name-only --diff-filter=U";

      # Unstages a file. Use like 'git unstage filename'
      unstage = "reset HEAD --";

      # Resets all uncomitted changes and files
      abort = "reset --hard HEAD";

      # Undo last commit
      undo = "reset HEAD~1";

      # Change last commit message
      recommit = "commit --amend";

      # Get the current branch name (not so useful in itself, but used in
      # other aliases)
      branch-name = "\"!git rev-parse --abbrev-ref HEAD\"";

      # List all commits that have not been pushed to origin
      unpushed = "log --branches --not --remotes --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";

      # See what's new since the last command
      new = "!sh -c 'git log $1@{1}..$1@{0} \"$@\"'";

      # Completely delete a branch (local and origin)
      rmb = "!sh -c 'git branch -D $1 && git push origin $1 --delete' -";

      # Merging
      ours = "\"!f() { git co --ours $@ && git add $@; }; f\"";
      theirs = "\"!f() { git co --theirs $@ && git add $@; }; f\"";

      # Basic shortcuts
      cp = "cherry-pick";
      st = "status -s";
      cl = "clone";
      ci = "commit";
      co = "checkout";
      br = "branch";
      diff = "diff --word-diff";
      dc = "diff --cached";
      fixup = "!git log -n 50 --pretty=format:'%h %s' --no-merges | fzf | cut -c -7 | xargs -o git commit --fixup";

      # Reset commands
      r = "reset";
      r1 = "reset HEAD^";
      r2 = "reset HEAD^^";
      rh = "reset --hard";
      rh1 = "reset HEAD^ --hard";
      rh2 = "reset HEAD^^ --hard";

      # Stash operations
      sl = "stash list";
      sa = "stash apply";
      pop = "stash pop";
      ss = "stash save";
    };
  };

  neovim = {
    enable = true;
  };

  kitty = {
    enable = true;
    extraConfig = builtins.readFile ./config/kitty/kitty.conf;
    themeFile = "GruvboxMaterialLightMedium";
  };

  tmux = {
    enable = true;
    # TODO: bring in old tmux config
  };

  direnv = {
    enable = true;
    config = {
       global = {
          hide_env_diff = true;
          warn_timeout = "30s";
      };
    };
  };
}
