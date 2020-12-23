# Barley

[Electron](https://github.com/electron/electron) sample built with [Yew](https://github.com/yewstack/yew).

## Goal

This repository aims to contain:

* [x] Yew [sample](https://yew.rs/docs/en/getting-started/build-a-sample-app) to generate wasm.
* [x] Electron sample using them.
* Basic samples most apps will need:
  * [ ] [Tray](https://www.electronjs.org/docs/api/tray)
  * [ ] [Notification](https://www.electronjs.org/docs/tutorial/notifications)

## Requirements

* To use Electron.Tray on GNOME
  * [AppIndicator and KStatusNotifierItem Support - GNOME Shell Extensions](https://extensions.gnome.org/extension/615/appindicator-support/)

## How to build

[1] Build Docker images:

```
$ make images
```

[2] Build project:

```
$ make up
...
js-builder_1  | + ls -lh out/make/deb/x64
js-builder_1  | total 55M
js-builder_1  | -rw-r--r-- 1 root root 55M Dec 22 15:51 barley_0.0.1_amd64.deb
barley_js-builder_1 exited with code 0
```

## Run app

```
$ make npm-run
...
> electron-forge start

✔ Checking your system
✔ Locating Application
✔ Preparing native dependencies
✔ Launching Application
```

Or install the app directly through deb.

```
$ sudo apt-get --reinstall install ./project-js/out/make/deb/x64/barley_0.0.1_amd64.deb
```

You can launch and remove it from command line:

```
# useful to watch logs of main process.
$ /lib/barley/barley

# to uninstall app after debugging.
$ sudo apt remove barley
...
Removing barley (0.0.1) ...
...
```
