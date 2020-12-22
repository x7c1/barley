# Barley

[Electron](https://github.com/electron/electron) sample built with [Yew](https://github.com/yewstack/yew).

## Goal

This repository aims to contain:

* [x] Yew [sample](https://yew.rs/docs/en/getting-started/build-a-sample-app).
* [x] Electron sample using wasm.
* Basic samples most apps will need:
  * [ ] [Tray](https://www.electronjs.org/docs/api/tray)
  * [ ] [Notification](https://www.electronjs.org/docs/tutorial/notifications)

## How to build

[1] Build Docker images:

```
$ make images
```

[2] Build project:

```
$ make up
```

## Requirements

* To use Electron.Tray on GNOME
  * [AppIndicator and KStatusNotifierItem Support - GNOME Shell Extensions](https://extensions.gnome.org/extension/615/appindicator-support/)
