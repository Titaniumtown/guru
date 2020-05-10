# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop eutils xdg

DESCRIPTION="All-in-one voice and text chat"

HOMEPAGE="https://discordapp.com/"

SRC_URI="https://dl-canary.discordapp.net/apps/linux/${PV}/discord-canary-${PV}.tar.gz"
RESTRICT="mirror bindist"
KEYWORDS="~amd64"

SLOT="0"
LICENSE="all-rights-reserved"
RDEPEND=""
DEPEND="${RDEPEND}
	sys-libs/libcxx
	dev-libs/expat
	dev-libs/nss
	gnome-base/gconf
	media-gfx/graphite2
	media-libs/alsa-lib
	media-libs/libpng
	net-print/cups
	net-libs/gnutls
	sys-libs/zlib
	x11-libs/gtk+
	x11-libs/libnotify
	x11-libs/libxcb
	x11-libs/libXtst
	media-libs/opus"

S=${WORKDIR}/DiscordCanary

QA_PREBUILT="
	opt/discord-canary/DiscordCanary
	opt/discord-canary/libEGL.so
	opt/discord-canary/libGLESv2.so
	opt/discord-canary/swiftshader/libEGL.so
	opt/discord-canary/swiftshader/libGLESv2.so
	opt/discord-canary/libVkICD_mock_icd.so
	opt/discord-canary/libffmpeg.so
"

src_install() {
	local destdir="/opt/${PN}"

	insinto $destdir
	doins -r locales resources
	doins \
		*.pak \
		*.png \
		*.dat \
		*.bin \
		*.so

	exeinto $destdir
	doexe DiscordCanary

	dosym $destdir/DiscordCanary /usr/bin/discord-canary
	make_desktop_entry discord Discord \
		"/opt/discord-canary/discord.png" \
		Network
}