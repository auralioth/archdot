<!--toc:start-->

- [Before Install](#before-install)
- [Fast Recovery](#fast-recovery)
  - [Priority](#priority)
    - [Good Internet](#good-internet)
    - [Add repo](#add-repo)
  - [Install](#install)
- [More things](#more-things)
<!--toc:end-->

# Before Install

> **Warning**  
> This is my own [Hyprland](https://github.com/hyprwm/Hyprland) based dotfile. So make sure you have at least skimmed throuth my [installation process](https://github.com/auryouth/archInstall) to check if satisfying some basic requirements.

# Fast Recovery

There is a script at [pkglist/scripts/install.sh](https://github.com/auryouth/archdot/blob/Hyprland/pkglist/scripts/install.sh) which can help you complete almost everything.

> **Note**  
> Before running the script, make sure of two things. One is you have **`Good Network`**, the other is to `add my own repo`
> because there some packages for my own use. Otherwise refer to **[Priority](#priority)** first.

## Priority

### Good Internet

Suppose you have just finished the basic installation and now in the `tty`.

I would recommend [dae](https://github.com/daeuniverse/dae).

```bash
$ sudo pacman -S dae
```

Refer to [dae](https://github.com/daeuniverse/dae) to set config.

### Add repo

Add the below lines to `/etc/pacman.conf`. Make sure it is above the core repo.

```bash
[auryouth]
SigLevel = Optional TrustAll
Server = https://github.com/auryouth/archbuild/releases/latest/download
```

## Install

At lease download the `pkglist` directory somewhere.

```bash
$ cd pkglist/scripts
$ ./install.sh
```

**Reboot to enjoy your arch journey!**

# More things

Refer to [after_install.md](https://github.com/auryouth/archdot/blob/Hyprland/after_install.md) for more info.
