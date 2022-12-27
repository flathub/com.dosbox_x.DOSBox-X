# Flatpak for DOSBox-X

Official Flatpak support is available for [DOSBox-X](https://dosbox-x.com/), a cross-platform x86/DOS emulation package.

## Installation

This Flatpak is available on
[Flathub](https://flathub.org/apps/details/com.dosbox_x.DOSBox-X).
After following the [Flatpak setup guide](https://flatpak.org/setup/),
you can install it by entering the following command in a terminal:

```bash
flatpak install flathub com.dosbox_x.DOSBox-X -y
```

Once the Flatpak is installed, you can run DOSBox-X using your desktop environment's
application launcher or by running `flatpak run com.dosbox_x.DOSBox-X` in a terminal.

## Updating

This Flatpak follows the latest stable DOSBox-X version.
To update it, run the following command in a terminal:

```bash
flatpak update
```

## Limitations

- For security reasons, this Flatpak is sandboxed and only has access to the
  user's Home folder. You should place any files you need within DOSBox-X in
  that folder (or in a subfolder). Alternatively you can allow additional access
  with the override command. But note that this does not work for all directories
  as some (like ``/usr``) have special restrictions. For instance, to allow access
   to ``/run/media`` where USB devices are typically mounted, run the following command:
    - ``flatpak override --filesystem=/run/media com.dosbox_x.DOSBox-X``
- Likewise, there is no way to access system installed MIDI soundfonts under ``/usr``.
  If you want to use such soundfonts, copy them into your home directory and
  specify the location in your DOSBox-X config file.
- There is support for NE2000 network adapter emulation using the libslirp backend. The libpcap backend is not supported due to Flatpak sandbox security restrictions, as it requires low-level device access.
- On Wayland, DOSBox-X will by default run via XWayland. This is because there are some issues with running in fullscreen mode which should be fixed in a future SDL2 or DOSBox-X release.
- There is no support for 3dfx Glide pass-through (Hardware 3dfx Voodoo emulation does work, but is very slow). This is being blocked by issue: [Glide SDL2 segfault](https://github.com/joncampbell123/dosbox-x/issues/2126).
- The SDL2 libraries against which DOSBox-X is built are provided by flatpak. This build only supports PulseAudio and dummy sound options, and likewise only supports X11, Wayland and dummy video options.
  - You will need a working PulseAudio (or PipeWire) setup on the host, or DOSBox-X will not start. If you don't care for audio, you can use the dummy SDL audio driver once you installed the flatpak by running:
    - ``flatpak override --env=SDL_AUDIODRIVER=dummy com.dosbox_x.DOSBox-X``
  - You will need a working X or XWayland setup on the host. Running from a console will not work, as the SDL2 build does not have kms or directfb output enabled. 

Please [create an issue](https://github.com/flathub/com.dosbox_x.DOSBox-X/issues/new)
if you find any other limitations specific to flatpak that should be documented here.

## Configuration files

Under the default Flatpak configuration, the DOSBox-X configuration files are
located in `~/.var/app/com.dosbox_x.DOSBox-X/config/dosbox-x/`. To access it with a
graphical file manager, you'll have to make hidden folders visible.

The config file will not initially exist after installing DOSBox-X, or upgrading to
a new version. You can create one from the DOSBox-X command line by running ``config -wcd``.
To write all config options, type ``config -wcd -all``.

## Building from source

Install Git, follow the
[flatpak-builder setup guide](https://docs.flatpak.org/en/latest/first-build.html)
then enter the following commands in a terminal:

```bash
git clone --recursive https://github.com/flathub/com.dosbox_x.DOSBox-X.git
cd com.dosbox_x.DOSBox-X
flatpak install flathub org.freedesktop.Sdk//22.08 -y
flatpak-builder --force-clean --install --user -y build-dir com.dosbox_x.DOSBox-X.yaml
```

If all goes well, the Flatpak will be installed after building. You can then
run it using your desktop environment's application launcher.

You can speed up incremental builds by installing [ccache](https://ccache.dev/)
and specifying `--ccache` in the flatpak-builder command line (before `build-dir`).
