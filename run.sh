#!/usr/bin/env bash

clear
flatpak-builder --repo=testing-repo --force-clean build-dir com.dosbox_x.DOSBox-X.yaml
flatpak --user remote-delete dos-testing-repo
flatpak --user remote-add --if-not-exists --no-gpg-verify dos-testing-repo testing-repo
flatpak --user install dos-testing-repo com.dosbox_x.DOSBox-X -y
#flatpak --user install dos-testing-repo com.dosbox_x.DOSBox-X.Debug -y
flatpak update -y
