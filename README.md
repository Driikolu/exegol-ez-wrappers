# exegol-ez-wrappers
i3 &amp; dmenu wrappers for easily managing multiple exegols containers

# How does it works
This repo contains a set of wrappers scripts & configuration to select a execution environment (host, or a specific exegol container) through i3 bindings & dmenu.

# How to install it

You can either install it manually or through the automatic script

## With the script

You can execute the `install.sh` script, made to configure a vanilla installation.
```bash
./install.sh
```

It will automaticaly move the scripts to `~/.local/bin/` and set up the i3 & i3status configurations.

## Manual installation


First of all, you have to copy the scripts/wrappers into a executable path. 
The default installation is in `~/.local/bin/`

```bash
cp scripts/* ~/.local/bin/
chmod +x ~/.local/bin/*.sh #To ensure the scripts are executable
```

Then you have to modify i3status configuration with the one in `./confs/i3status_config`

```bash
cp confs/i3status_config ~/.config/i3status/config
```

However, **if you already have a custom i3status config**, you only have to set the `colors` and `output_format` options.
```
general {
        colors = true
        interval = 1
 output_format = i3bar
}
```


The wrappers use some files in the `/tmp/` like `/tmp/.current_env`, to ensure this file is existing, you need to add the `confs/xprofile` content to your one `~/.xprofile`.

Lastly you have to modify you i3 bindings, is `~/.config/i3/config` to add the wrappers & call the right script.

### The terminal

We will use the `shell_wrapper.sh` to determinate if you are opening a shell on your host or on the exegol container.
So modify the corresponding binding, by default :
```
bindsym $mod+Return exec i3-sensible-terminal
```
and add the shell_wrapper instead
```
bindsym $mod+Return exec shell_wrapper.sh
```

Do not hesitate to modify the `shell_wrapper.sh` script to call your prefered terminal instead of `i3-sensible-terminal`

### The i3status

The i3statusbar is defined in the section `bar` at the bottom of the default configuration.
Instead of `i3status` we will use the `i3status_wrapper.sh` script, that will call i3status with added custom data (the running exegol names + *host*)

So the following
```
bar {
  status_command i3status
}
```
will become
```
bar {
  status_command i3status_wrapper.sh
}
```
