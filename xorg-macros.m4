dnl $Id$
dnl
dnl Copyright 2005 Sun Microsystems, Inc.  All rights reserved.
dnl 
dnl Permission to use, copy, modify, distribute, and sell this software and its
dnl documentation for any purpose is hereby granted without fee, provided that
dnl the above copyright notice appear in all copies and that both that
dnl copyright notice and this permission notice appear in supporting
dnl documentation.
dnl 
dnl The above copyright notice and this permission notice shall be included
dnl in all copies or substantial portions of the Software.
dnl 
dnl THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
dnl OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
dnl MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
dnl IN NO EVENT SHALL THE OPEN GROUP BE LIABLE FOR ANY CLAIM, DAMAGES OR
dnl OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
dnl ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
dnl OTHER DEALINGS IN THE SOFTWARE.
dnl 
dnl Except as contained in this notice, the name of the copyright holders shall
dnl not be used in advertising or otherwise to promote the sale, use or
dnl other dealings in this Software without prior written authorization
dnl from the copyright holders.
dnl 

# XORG_PROG_RAWCPP()
# ------------------
# Find cpp program and necessary flags for use in pre-processing text files
# such as man pages and config files
AC_DEFUN([XORG_PROG_RAWCPP],[
AC_REQUIRE([AC_PROG_CPP])
AC_PATH_PROGS(RAWCPP, [cpp], [${CPP}], 
   [$PATH:/bin:/usr/bin:/usr/lib:/usr/libexec:/usr/ccs/lib:/usr/ccs/lbin:/lib])

# Check for flag to avoid builtin definitions - assumes unix is predefined,
# which is not the best choice for supporting other OS'es, but covers most
# of the ones we need for now.
AC_MSG_CHECKING([if $RAWCPP requires -undef])
AC_LANG_CONFTEST([Does cpp redefine unix ?])
if test `${RAWCPP} < conftest.$ac_ext | grep -c 'unix'` -eq 1 ; then
	AC_MSG_RESULT([no])
else
	if test `${RAWCPP} -undef < conftest.$ac_ext | grep -c 'unix'` -eq 1 ; then
		RAWCPPFLAGS=-undef
		AC_MSG_RESULT([yes])
	else
		AC_MSG_ERROR([${RAWCPP} defines unix with or without -undef.  I don't know what to do.])
	fi
fi
rm -f conftest.$ac_ext

AC_MSG_CHECKING([if $RAWCPP requires -traditional])
AC_LANG_CONFTEST([Does cpp preserve   "whitespace"?])
if test `${RAWCPP} < conftest.$ac_ext | grep -c 'preserve   \"'` -eq 1 ; then
	AC_MSG_RESULT([no])
else
	if test `${RAWCPP} -traditional < conftest.$ac_ext | grep -c 'preserve   \"'` -eq 1 ; then
		RAWCPPFLAGS="${RAWCPPFLAGS} -traditional"
		AC_MSG_RESULT([yes])
	else
		AC_MSG_ERROR([${RAWCPP} does not preserve whitespace with or without -traditional.  I don't know what to do.])
	fi
fi
rm -f conftest.$ac_ext
AC_SUBST(RAWCPPFLAGS)
]) # XORG_PROG_RAWCPP

# XORG_MANPAGE_SECTIONS()
# -----------------------
# Determine which sections man pages go in for the different man page types
# on this OS - replaces *ManSuffix settings in old Imake *.cf per-os files.
# Not sure if there's any better way than just hardcoding by OS name.
# Override default settings by setting environment variables

AC_DEFUN([XORG_MANPAGE_SECTIONS],[
AC_REQUIRE([AC_CANONICAL_HOST])

if test x$APP_MAN_SUFFIX = x    ; then
    case $host_os in
	linux*)	APP_MAN_SUFFIX=1x ;;
	*)	APP_MAN_SUFFIX=1  ;;
    esac
fi
if test x$APP_MAN_DIR = x    ; then
    case $host_os in
	linux*)	APP_MAN_DIR='$(mandir)/man1' ;;
	*)	APP_MAN_DIR='$(mandir)/man$(APP_MAN_SUFFIX)' ;;
    esac
fi

if test x$LIB_MAN_SUFFIX = x    ; then
    case $host_os in
	linux*)	LIB_MAN_SUFFIX=3x ;;
	*)	LIB_MAN_SUFFIX=3  ;;
    esac
fi
if test x$LIB_MAN_DIR = x    ; then
    case $host_os in
	linux*)	LIB_MAN_DIR='$(mandir)/man3' ;;
	*)	LIB_MAN_DIR='$(mandir)/man$(LIB_MAN_SUFFIX)' ;;
    esac
fi

if test x$FILE_MAN_SUFFIX = x    ; then
    case $host_os in
	linux*)		FILE_MAN_SUFFIX=5x ;;
	solaris*)	FILE_MAN_SUFFIX=4  ;;
	*)		FILE_MAN_SUFFIX=5  ;;
    esac
fi
if test x$FILE_MAN_DIR = x    ; then
    case $host_os in
	linux*)	FILE_MAN_DIR='$(mandir)/man5' ;;
	*)	FILE_MAN_DIR='$(mandir)/man$(FILE_MAN_SUFFIX)' ;;
    esac
fi

# In Imake's linux.cf, the misc man suffix & dir was only changed for 
# LinuxDebian, not other Linuxes, so we leave it unchanged here
if test x$MISC_MAN_SUFFIX = x    ; then
    case $host_os in
#	linux*)		MISC_MAN_SUFFIX=7x ;;
	solaris*)	MISC_MAN_SUFFIX=5  ;;
	*)		MISC_MAN_SUFFIX=7  ;;
    esac
fi
if test x$MISC_MAN_DIR = x    ; then
    case $host_os in
#	linux*)	MISC_MAN_DIR='$(mandir)/man7' ;;
	*)	MISC_MAN_DIR='$(mandir)/man$(MISC_MAN_SUFFIX)' ;;
    esac
fi

# In Imake's linux.cf, the driver man suffix & dir was only changed for 
# LinuxDebian, not other Linuxes, so we leave it unchanged here
if test x$DRIVER_MAN_SUFFIX = x    ; then
    case $host_os in
#	linux*)		DRIVER_MAN_SUFFIX=4x ;;
	solaris*)	DRIVER_MAN_SUFFIX=7  ;;
	*)		DRIVER_MAN_SUFFIX=4  ;;
    esac
fi
if test x$DRIVER_MAN_DIR = x    ; then
    case $host_os in
#	linux*)	DRIVER_MAN_DIR='$(mandir)/man4' ;;
	*)	DRIVER_MAN_DIR='$(mandir)/man$(DRIVER_MAN_SUFFIX)' ;;
    esac
fi

if test x$ADMIN_MAN_SUFFIX = x    ; then
    case $host_os in
	solaris*)	ADMIN_MAN_SUFFIX=1m ;;
	*)		ADMIN_MAN_SUFFIX=8  ;;
    esac
fi
if test x$ADMIN_MAN_DIR = x    ; then
    ADMIN_MAN_DIR='$(mandir)/man$(ADMIN_MAN_SUFFIX)'
fi


AC_SUBST([APP_MAN_SUFFIX])
AC_SUBST([LIB_MAN_SUFFIX])
AC_SUBST([FILE_MAN_SUFFIX])
AC_SUBST([MISC_MAN_SUFFIX])
AC_SUBST([DRIVER_MAN_SUFFIX])
AC_SUBST([ADMIN_MAN_SUFFIX])
AC_SUBST([APP_MAN_DIR])
AC_SUBST([LIB_MAN_DIR])
AC_SUBST([FILE_MAN_DIR])
AC_SUBST([MISC_MAN_DIR])
AC_SUBST([DRIVER_MAN_DIR])
AC_SUBST([ADMIN_MAN_DIR])
]) # XORG_MANPAGE_SECTIONS

# XORG_CHECK_LINUXDOC
# -------------------
# Defines the variable MAKE_TEXT if the necessary tools and
# files are found. $(MAKE_TEXT) blah.sgml will then produce blah.txt.
# Whether or not the necessary tools and files are found can be checked
# with the AM_CONDITIONAL "BUILD_LINUXDOC"
AC_DEFUN([XORG_CHECK_LINUXDOC],[
AC_CHECK_FILE(
	[$prefix/share/X11/sgml/defs.ent], 
	[DEFS_ENT_PATH=$prefix/share/X11/sgml],
	[DEFS_ENT_PATH=]
)

AC_PATH_PROG(LINUXDOC, linuxdoc)

AC_MSG_CHECKING([Whether to build documentation])

if [[ ! -z $DEFS_ENT_PATH ] && [ ! -z $LINUXDOC ]] ; then
   BUILDDOC=yes
else
   BUILDDOC=no
fi

AM_CONDITIONAL(BUILD_LINUXDOC, [test x$BUILDDOC = xyes])

AC_MSG_RESULT([$BUILDDOC])

MAKE_TEXT="SGML_SEARCH_PATH=$DEFS_ENT_PATH $LINUXDOC -B txt"

AC_SUBST(MAKE_TEXT)
]) # XORG_CHECK_LINUXDOC
