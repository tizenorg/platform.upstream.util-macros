dnl $XdotOrg: $
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

AC_MSG_CHECKING([if $RAWCPP requires -traditional])
AC_LANG_CONFTEST([Does cpp preserve   "whitespace"?])
if test `${RAWCPP} < conftest.$ac_ext | grep -c 'preserve   \"'` -eq 1 ; then
	AC_MSG_RESULT([no])
else
	if test `${RAWCPP} -traditional < conftest.$ac_ext | grep -c 'preserve   \"'` -eq 1 ; then
		RAWCPPFLAGS=-traditional
		AC_SUBST(RAWCPPFLAGS)
		AC_MSG_RESULT([yes])
	else
		AC_MSG_ERROR([${CPP} does not preserve whitespace with or without -traditional.  I don't know what to do.])
	fi
fi
rm -f conftest.$ac_ext
]) # XORG_PROG_RAWCPP

# XORG_MANPAGE_SECTIONS()
# -----------------------
# Determine which sections man pages go in for the different man page types
# on this OS - replaces *ManSuffix settings in old Imake *.cf per-os files.
# Not sure if there's any better way than just hardcoding by OS name.
# TODO:  Add way to override settings for distros that don't use defaults.
AC_DEFUN([XORG_MANPAGE_SECTIONS],[
AC_REQUIRE([AC_CANONICAL_HOST])

case $host_os in
	linux*)
		APP_MAN_SUFFIX=1x
		LIB_MAN_SUFFIX=3x
		FILE_MAN_SUFFIX=5x
		MISC_MAN_SUFFIX=7x
		DRIVER_MAN_SUFFIX=4x
	;;
	solaris*)
		APP_MAN_SUFFIX=1
		FILE_MAN_SUFFIX=4
		MISC_MAN_SUFFIX=5
		DRIVER_MAN_SUFFIX=7
		ADMIN_MAN_SUFFIX=1m
	;;
esac

# Default settings - classic BSD style
if test x$APP_MAN_SUFFIX = x    ; then    APP_MAN_SUFFIX=1 ; fi
if test x$LIB_MAN_SUFFIX = x    ; then    LIB_MAN_SUFFIX=3 ; fi
if test x$FILE_MAN_SUFFIX = x   ; then   FILE_MAN_SUFFIX=5 ; fi
if test x$MISC_MAN_SUFFIX = x   ; then   MISC_MAN_SUFFIX=7 ; fi
if test x$DRIVER_MAN_SUFFIX = x ; then DRIVER_MAN_SUFFIX=4 ; fi
if test x$ADMIN_MAN_SUFFIX = x  ; then  ADMIN_MAN_SUFFIX=8 ; fi

AC_SUBST([APP_MAN_SUFFIX])
AC_SUBST([LIB_MAN_SUFFIX])
AC_SUBST([FILE_MAN_SUFFIX])
AC_SUBST([MISC_MAN_SUFFIX])
AC_SUBST([DRIVER_MAN_SUFFIX])
AC_SUBST([ADMIN_MAN_SUFFIX])
]) # XORG_MANPAGE_SECTIONS

	
