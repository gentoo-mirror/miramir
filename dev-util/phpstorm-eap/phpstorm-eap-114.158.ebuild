inherit eutils
EAPI=4
HOMEPAGE="http://www.jetbrains.com/phpstorm/"

if [ "${PN}" = "phpstorm-eap" ]; then
	DESCRIPTION="PhpStorm (Eap version)"
	SRC_URI="http://download.jetbrains.com/webide/PhpStorm-EAP-${PV}.tar.gz"
	KEYWORDS="~x86 ~amd64"
	PROGNAME="PHP Storm EAP"
else
	DESCRIPTION="PhpStorm"
	SRC_URI="http://download.jetbrains.com/webide/PhpStorm-${PV}.tar.gz"
	KEYWORDS="x86 amd64"
	PROGNAME="PHP Storm"
fi

RESTRICT="strip mirror"
DEPEND=">=virtual/jre-1.6"
SLOT="0"
S=${WORKDIR}
src_install() {
	dodir /opt/${PN}

	cd PhpStorm*/
	insinto /opt/${PN}
	doins -r *

	fperms a+x /opt/${PN}/bin/phpstorm.sh || die "Chmod failed"
	fperms a+x /opt/${PN}/bin/fsnotifier || die "Chmod failed"
	fperms a+x /opt/${PN}/bin/fsnotifier64 || die "Chmod failed"
	dosym /opt/${PN}/bin/phpstorm.sh /usr/bin/${PN}
	
	mv "bin/webide.png" "bin/${PN}.png"
	doicon "bin/${PN}.png"
	make_desktop_entry ${PN} "${PROGNAME}" "${PN}"
}
pkg_postinst() {
    elog "Run /usr/bin/${PN}"
}

