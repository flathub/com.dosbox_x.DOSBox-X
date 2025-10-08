#!/usr/bin/env bash

if ! [[ $(type -P flatpak-builder) ]]; then
	echo "Please install 'flatpak-builder'"
	exit 1
fi

clear

runtime=$(grep runtime-version com.dosbox_x.DOSBox-X.yaml|awk '{print $2}'|tr -d "'")
flatpak --user install flathub org.freedesktop.Sdk//${runtime} -y

if ! flatpak-builder --repo=testing-repo --force-clean build-dir com.dosbox_x.DOSBox-X.yaml;
then
	echo "flatpak build failed."
	exit 1
fi

flatpak --user remote-delete dos-testing-repo
flatpak --user remote-add --if-not-exists --no-gpg-verify dos-testing-repo testing-repo
flatpak --user install dos-testing-repo com.dosbox_x.DOSBox-X -y
#flatpak --user install dos-testing-repo com.dosbox_x.DOSBox-X.Debug -y
flatpak update -y
