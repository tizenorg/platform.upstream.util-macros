Name:	 util-macros
Summary: X.Org build utilities
Version: 1.17
Release: 1
License: MIT/X11
Group:   Development/System
URL:     http://www.x.org
Source: util-macros-%{version}.tar.bz2

%description
 This package provides build utilties tha ship with the X Window System, including:
  - util-macros, autotools macros for X.Org

%prep
%setup -q -n util-macros-%{version}

%build
%configure
make

%install
%make_install

%remove_docs
rm -rf %{buildroot}/usr/share/util-macros/INSTALL

%files
%{_datadir}/aclocal/*
%{_datadir}/pkgconfig/*

