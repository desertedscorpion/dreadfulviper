Name:           test-phonetic
Version:        VERSION
Release:        RELEASE
Summary:        tests the phonetic package

Group:          Administrative
License:        GNU/GPL3
URL:            git@github.com:desertedscorpion/whitevenus.git
Source:         %{name}-%{version}.tar.gz
Prefix:         %{_prefix}
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)

Requires:       coreutils
%define debug_package %{nil}


%description
This program tests the phonetic program.

%prep
%setup -q


%build


%install
rm -rf ${RPM_BUILD_ROOT}
mkdir --parents ${RPM_BUILD_ROOT}/usr/sbin
cp test-phonetic.sh ${RPM_BUILD_ROOT}/usr/sbin/test-phonetic


%clean
rm -rf ${RPM_BUILD_ROOT}


%files
%attr(0555,root,root) /usr/sbin/test-phonetic
