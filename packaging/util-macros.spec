Name:	 util-macros
Summary: X.Org build utilities
Version: 1.19.0
Release: 1
License: MIT/X11
Group:   Development/System
URL:     http://www.x.org
Source: util-macros-%{version}.tar.bz2
Source1001: 	util-macros.manifest

%if !%{with x}
ExclusiveArch:
%endif

%description
 This package provides build utilties tha ship with the X Window System, including:
  - util-macros, autotools macros for X.Org

%prep
%setup -q -n util-macros-%{version}
cp %{SOURCE1001} .

%build
%autogen
make

%install
%make_install

%remove_docs
rm -rf %{buildroot}/usr/share/util-macros/INSTALL

%files
%manifest %{name}.manifest
%license COPYING
%{_datadir}/aclocal/*
%{_datadir}/pkgconfig/*

