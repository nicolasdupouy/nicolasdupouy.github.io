https://docs.freebsd.org/en/articles/fonts/

https://forums.freebsd.org/threads/adding-font-path-to-xorg.60609/


https://www.google.com/search?q=gnome+freebsd+other+ttys+weird+characters&client=firefox-b-d&sxsrf=APwXEdfWHFcyG37DUGdJIImYZUsnbjnTXg:1684926034867&source=lnms&tbm=isch&sa=X&ved=2ahUKEwiCmp_O5o3_AhVsXqQEHRfZDEIQ_AUoAXoECCsQAw&biw=1963&bih=1682&dpr=1#imgrc=Gydx7CstzAaM4M
https://forums.freebsd.org/threads/tty-nvidia-error.78331/
https://www.micski.dk/2022/01/06/fix-small-font-in-freebsd-virtual-terminal-system-console/

```shell
$ vidfont -p
kbdcontrol: getting keymap: Inappropriate ioctl for device
You are not on a virtual console - expect certain strange side-effects
lang_default = en
dialect = C.UTF-8
lang_abk = C.UTF-8
Gallant Character set, 12x22
Terminus BSD Console, size 32
VGAROM, 16x32
VGAROM, 8x8
VGAROM, 8x8 (thin)
VGAROM, 8x14
VGAROM, 8x16
VGAROM, 8x16 (thin)
tom-thumb Character set, 4x6
```
==> /usr/share/vt/fonts/



 - https://www.micski.dk/2022/01/06/fix-small-font-in-freebsd-virtual-terminal-system-console/
 - https://forums.freebsd.org/threads/adding-font-path-to-xorg.60609/
 - https://docs.freebsd.org/en/articles/fonts/
 - https://www.reddit.com/r/freebsd/comments/euzx0k/any_extra_fonts_for_vt/
 - https://github.com/fcambus/spleen
 - https://github.com/emaste/fontstuff
 - https://docs.freebsd.org/en/books/handbook/x11/#x-fonts
 - https://forums.freebsd.org/threads/installing-truetype-fonts-on-freebsd.65261/
 - https://forums.freebsd.org/threads/changing-font-in-command-line.67126/
 - https://forums.freebsd.org/threads/console-resolution-in-freebsd-12.72060/
 - https://forums.freebsd.org/threads/changing-font-in-command-line.67126/
 - https://github.com/LionyxML/freebsd-terminus
 - https://www.freshports.org/x11-fonts/spleen/
 - https://man.freebsd.org/cgi/man.cgi?query=vtfontcvt&sektion=8&manpath=freebsd-release-ports
 - https://www.cambus.net/
 - https://forums.freebsd.org/threads/font-size-in-vt.49601/
 - https://man.freebsd.org/cgi/man.cgi?query=vt&sektion=4
 - https://forums.freebsd.org/threads/nvidia-modeset-problems-at-boot.83580/
 - https://www.nvidia.com/Download/driverResults.aspx/188879/en-us/
 - 