
https://unix.stackexchange.com/questions/36477/how-do-i-prevent-gnome-suspending-while-i-finish-a-compilation-job



gsettings get org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout
=> 1200

gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0

gsettings get org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout
=> 0


In `/etc/fstab`
```editorconfig
# For Gnome-desktop
proc                    /proc   procfs  rw              0       0
```

To use "Gnome Shell extensions" (https://extensions.gnome.org)
It is necessary to install `chrome-gnome-shell`:

```shell
sudo pkg install chrome-gnome-shell
```
