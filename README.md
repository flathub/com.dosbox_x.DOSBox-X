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
  that folder (or in a subfolder).
- Likewise there is no way to access system installed MIDI soundfonts under /usr
  if you want to use such soundfonts, copy them into your home directory and
  specify the location in your DOSBox-X config file.
- There is no support for NE2000 network adapter emulation due to Flatpak security reasons as it requires low-level (root) access.
- On Wayland, DOSBox-X will run via XWayland. This is due to SDL2 not supporting client-side-decorations (see https://bugzilla.libsdl.org/show_bug.cgi?id=5194). This will be a limitation until a new SDL2 version is released with these patches, and this new SDL2 version is available in flatpak.
- There is no support for 3dfx Glide pass-through (Hardware 3dfx Voodoo emulation does work, but is very slow). This is being blocked by issue: [Glide SDL2 segfault](https://github.com/joncampbell123/dosbox-x/issues/2126[Glide SDL2 segfault). Once that is resolved, we can try to see if [OpenGlide](https://github.com/voyageur/openglide) will work in a Flatpak environment.

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
flatpak install flathub org.freedesktop.Sdk//20.08 -y
flatpak-builder --force-clean --install --user -y builddir com.dosbox_x.DOSBox-X.yaml
```

If all goes well, the Flatpak will be installed after building. You can then
run it using your desktop environment's application launcher.

You can speed up incremental builds by installing [ccache](https://ccache.dev/)
and specifying `--ccache` in the flatpak-builder command line (before `builddir`).
