RELEASE=$(shell git describe --tags)

test-phonetic-${VERSION}.spec : test-phonetic.spec
	sed -e "s#VERSION#${VERSION}#" -e "s#RELEASE#${RELEASE}#" -e "w${@}" ${<}

test-phonetic-${VERSION} :
	git -C ${@} init
	git -C ${@} remote add origin git@github.com:desertedscorpion/remotesunshine.git
	git -C ${@} fetch origin

test-phonetic-${VERSION}.tar : test-phonetic-${VERSION}
	git -C ${<} archive --prefix test-phonetic-${VERSION}/ tags/${VERSION} > ${@}

test-phonetic-${VERSION}.tar.gz : test-phonetic-${VERSION}.tar
	gzip --to-stdout ${<} > ${@}

buildsrpm/test-phonetic-${VERSION}-${RELEASE}.src.rpm : test-phonetic-${VERSION}.spec test-phonetic-${VERSION}.tar.gz
	mkdir --parents buildsrpm
	mock --buildsrpm --spec test-phonetic-${VERSION}.spec --sources test-phonetic-${VERSION}.tar.gz --resultdir buildsrpm

rebuild/test-phonetic-${VERSION}-${RELEASE}.x86_64.rpm : buildsrpm/test-phonetic-${VERSION}-${RELEASE}.src.rpm
	mkdir --parents rebuild
	mock --rebuild buildsrpm/test-phonetic-${VERSION}-${RELEASE}.src.rpm --resultdir rebuild
