#!/bin/bash

RPM_TOPDIR="${RPM_TOPDIR-~/rpmbuild}"


GIT_REV=$(grep -E "^%define gitrev" mcollective-plugins.spec | awk '{print $3}')

mkdir -p ${RPM_TOPDIR}/{BUILD,RPMS,SOURCES,SPECS,SRPMS}

[ -f ${RPM_TOPDIR}/SOURCES/puppetlabs-mcollective-plugins-${GIT_REV}.tar.gz ] || wget -O \
	${RPM_TOPDIR}/SOURCES/puppetlabs-mcollective-plugins-${GIT_REV}.tar.gz \
	https://github.com/puppetlabs/mcollective-plugins/tarball/${GIT_REV}

cp -v mcollective-plugins.spec ${RPM_TOPDIR}/SPECS/

rpmbuild --define "_topdir `readlink -f ${RPM_TOPDIR}`" --clean  --rmsource  \
  -bb "${RPM_TOPDIR}/SPECS/mcollective-plugins.spec"

