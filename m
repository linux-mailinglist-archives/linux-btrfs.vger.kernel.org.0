Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C0C24ADE6
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Aug 2020 06:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbgHTEgz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Aug 2020 00:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgHTEgy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Aug 2020 00:36:54 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502F7C061757
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Aug 2020 21:36:54 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id s14so474080plp.4
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Aug 2020 21:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wd5qcM6+L0aSnAi+Xitztn7H7GpviG91Hwx1DQjoglE=;
        b=BCNkQD6elB1pgI58+PKTOgGwQ/Ikkc7x6mxEzzJ+EUduWThVWzyXU0f+sJUaBB2iOk
         HD1M8DSEyqWxBOotf6l5O7QjpaljnXFSpWhhdZk74XuJ279uLrVyRyZSB7yVtV/ZG+4q
         ZJGmhsoLCzOJCF+CfvSPrB602WCY0LwpCVbhJTf9KOxsbQxpVrHNj3M194ymhs/MyyDG
         LppUHRb5cCzoTUyJICI2xoHZ5XpAVfO5LgBgKy4smRvd/X4CoE2fE5deEQTPHZBSnTpM
         9Yd2aRlqqI0pFB0YmFcHKOCFiKyjWOLqHcvZYeDcN9IShQ3JRs+CtXG51ZakZ94RMsQU
         EyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wd5qcM6+L0aSnAi+Xitztn7H7GpviG91Hwx1DQjoglE=;
        b=G4Ly9g2Eg0ZbIAucwjpb6s0MTOTYbihJ41A+aWOKe1N3ti/8VnL7lHc8+FEkZNaWeX
         HXQvJS1znRVfYB1A2gH2koOkJP236/pEQldXkYA4x4y/0n8RPjFTYK2PtnbC5nJ/4AD+
         OeunddYmWDkL41/2r5XJXa+PhA9V0/zLNrK6gvpu6PGbO8hmqT4tgP9UUH0Gk8hzd5q6
         cWl042HRDu1whMHQhJ6DuMmDrdY8TLdvDuDrSlZ9pfE71EkHMmdz4v0fhMH6epHGSZ1Z
         lM7IZYJ/qdnRrMKnyfZciZa3NFWlt8hPi3jNU3v5tc/ZgDnb3Pa5b6HgG+5TJjvtry5g
         1MPg==
X-Gm-Message-State: AOAM531WgKgcZBBsU64ovizyWAxGsaZNebUogd6AjHi1jWoXTNPIY8GY
        MPewfGTwIaxXWgU+qK6vXUZ8u/WuAB8=
X-Google-Smtp-Source: ABdhPJySWuBxCzM0mOI0pVSXL18wJzAwnEJAgNbYrm0tMIcD+BEDWlNI3ZqhdkZZI/tgptV82fpcbQ==
X-Received: by 2002:a17:902:ea8c:: with SMTP id x12mr1292548plb.60.1597898213208;
        Wed, 19 Aug 2020 21:36:53 -0700 (PDT)
Received: from dell.circlecvi.com (S010664777d4a88b3.cg.shawcable.net. [70.77.224.58])
        by smtp.gmail.com with ESMTPSA id k29sm913180pfp.142.2020.08.19.21.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 21:36:52 -0700 (PDT)
From:   Sheng Mao <shngmao@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Neal Gompa <ngompa13@gmail.com>, Sheng Mao <shngmao@gmail.com>
Subject: [PATCH v2] btrfs-progs: btrfsutil: add pkg-config files for btrfsutil
Date:   Wed, 19 Aug 2020 22:36:18 -0600
Message-Id: <20200820043618.51575-1-shngmao@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAEg-Je8L+KUx93im15DPGvczpvw8TfvhN752itm88w9Qwkg+sg@mail.gmail.com>
References: <CAEg-Je8L+KUx93im15DPGvczpvw8TfvhN752itm88w9Qwkg+sg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add pc file for btrfsutil libraries. Users can use
pkg-config to set up compilation and linking flags.

The paths in pc file depend on prefix variable but
ignore DESTDIR. DESTDIR is used for packaging and
it should not affect the paths in pc file.

Signed-off-by: Sheng Mao <shngmao@gmail.com>
---
 .gitignore                      |  1 +
 Makefile                        |  9 +++++++-
 Makefile.inc.in                 |  1 +
 configure.ac                    | 12 ++++++++++
 libbtrfsutil/libbtrfsutil.pc.in | 11 +++++++++
 tests/pkg-config-tests.sh       | 41 +++++++++++++++++++++++++++++++++
 6 files changed, 74 insertions(+), 1 deletion(-)
 create mode 100644 libbtrfsutil/libbtrfsutil.pc.in
 create mode 100644 tests/pkg-config-tests.sh

diff --git a/.gitignore b/.gitignore
index 1c70ec94..67404361 100644
--- a/.gitignore
+++ b/.gitignore
@@ -97,3 +97,4 @@
 /Documentation/mkfs.btrfs.8
 
 *.patch
+*.pc
diff --git a/Makefile b/Makefile
index c788b91b..42ba9d7f 100644
--- a/Makefile
+++ b/Makefile
@@ -436,13 +436,18 @@ test-clean:
 	@echo "Cleaning tests"
 	$(Q)bash tests/clean-tests.sh
 
+test-pkg-config:
+	@echo "Test pkg-config settings"
+	export libdir incdir
+	$(Q)bash tests/pkg-config-tests.sh
+
 test-inst: all
 	@tmpdest=`mktemp --tmpdir -d btrfs-inst.XXXXXX` && \
 		echo "Test installation to $$tmpdest" && \
 		$(MAKE) $(MAKEOPTS) DESTDIR=$$tmpdest install && \
 		$(RM) -rf -- $$tmpdest
 
-test: test-check test-check-lowmem test-mkfs test-misc test-cli test-convert test-fuzz
+test: test-check test-check-lowmem test-mkfs test-misc test-cli test-convert test-fuzz test-pkg-config
 
 testsuite: btrfs-corrupt-block btrfs-find-root btrfs-select-super fssum
 	@echo "Export tests as a package"
@@ -779,6 +784,8 @@ endif
 	$(INSTALL) -m755 -d $(DESTDIR)$(incdir)/btrfs
 	$(INSTALL) -m644 $(libbtrfs_headers) $(DESTDIR)$(incdir)/btrfs
 	$(INSTALL) -m644 libbtrfsutil/btrfsutil.h $(DESTDIR)$(incdir)
+	$(INSTALL) -m755 -d $(DESTDIR)$(pkgconfigdir)
+	$(INSTALL) -m644 libbtrfsutil/libbtrfsutil.pc $(DESTDIR)$(pkgconfigdir)
 endif
 
 ifeq ($(PYTHON_BINDINGS),1)
diff --git a/Makefile.inc.in b/Makefile.inc.in
index f3cd2733..9f493371 100644
--- a/Makefile.inc.in
+++ b/Makefile.inc.in
@@ -41,6 +41,7 @@ libdir ?= @libdir@
 incdir = @includedir@
 udevdir = @UDEVDIR@
 udevruledir = ${udevdir}/rules.d
+pkgconfigdir = @pkgconfigdir@
 
 # external libs required by various binaries; for btrfs-foo,
 # specify btrfs_foo_libs = <list of libs>; see $($(subst...)) rules in Makefile
diff --git a/configure.ac b/configure.ac
index 7c2c9b8d..a693ad4e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -12,6 +12,10 @@ LIBBTRFS_MAJOR=0
 LIBBTRFS_MINOR=1
 LIBBTRFS_PATCHLEVEL=2
 
+BTRFS_UTIL_VERSION_MAJOR=1
+BTRFS_UTIL_VERSION_MINOR=2
+BTRFS_UTIL_VERSION_PATCH=0
+
 CFLAGS=${CFLAGS:-"-g -O1 -Wall -D_FORTIFY_SOURCE=2"}
 AC_SUBST([CFLAGS])
 
@@ -300,18 +304,25 @@ AC_SUBST([LZO2_LIBS])
 AC_SUBST([LZO2_LIBS_STATIC])
 AC_SUBST([LZO2_CFLAGS])
 
+dnl call PKG_INSTALLDIR from pkg.m4 to set pkgconfigdir
+m4_ifdef([PKG_INSTALLDIR], [PKG_INSTALLDIR], [AC_MSG_ERROR([please install pkgconf])])
 
 dnl library stuff
 AC_SUBST([LIBBTRFS_MAJOR])
 AC_SUBST([LIBBTRFS_MINOR])
 AC_SUBST([LIBBTRFS_PATCHLEVEL])
 
+AC_SUBST([BTRFS_UTIL_VERSION_MAJOR])
+AC_SUBST([BTRFS_UTIL_VERSION_MINOR])
+AC_SUBST([BTRFS_UTIL_VERSION_PATCH])
+
 AC_CONFIG_HEADERS([config.h])
 
 AC_CONFIG_FILES([
 Makefile.inc
 Documentation/Makefile
 version.h
+libbtrfsutil/libbtrfsutil.pc
 ])
 
 AC_OUTPUT
@@ -325,6 +336,7 @@ AC_MSG_RESULT([
 	bindir:             ${bindir}
 	libdir:             ${libdir}
 	includedir:         ${includedir}
+	pkgconfigdir:       ${pkgconfigdir}
 
 	compiler:           ${CC}
 	cflags:             ${CFLAGS}
diff --git a/libbtrfsutil/libbtrfsutil.pc.in b/libbtrfsutil/libbtrfsutil.pc.in
new file mode 100644
index 00000000..81e66622
--- /dev/null
+++ b/libbtrfsutil/libbtrfsutil.pc.in
@@ -0,0 +1,11 @@
+prefix=@prefix@
+exec_prefix=@exec_prefix@
+libdir=@libdir@
+includedir=@includedir@
+
+Name: libbtrfsutil
+Description: libbtrfsutil library
+Version: @BTRFS_UTIL_VERSION_MAJOR@.@BTRFS_UTIL_VERSION_MINOR@.@BTRFS_UTIL_VERSION_PATCH@
+URL: http://btrfs.wiki.kernel.org
+Cflags: -I${includedir}
+Libs: -L${libdir} -lbtrfsutil
diff --git a/tests/pkg-config-tests.sh b/tests/pkg-config-tests.sh
new file mode 100644
index 00000000..faf15956
--- /dev/null
+++ b/tests/pkg-config-tests.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+#
+# test pkg-config can find libbtrfsutil
+
+SCRIPT_DIR=$(dirname $(readlink -f "$0"))
+TOP=$(readlink -f "$SCRIPT_DIR/../")
+if [ ! -f "$TOP/configure.ac" ]; then
+    exit 0
+fi
+
+export PKG_CONFIG_PATH="$TOP/libbtrfsutil"
+PKG_CONFIG=pkg-config
+LIBNAME=libbtrfsutil
+
+die() {
+	echo "ERROR: $@"
+	exit 1
+}
+
+test-exists() {
+    ${PKG_CONFIG} --exists $1 || die "$1 doesn't exist"
+}
+
+test-pkg-config() {
+    if [ "$#" != "3" ]; then
+        echo "$0 needs 3 arguments"
+        exit 1
+    fi
+    libname="$1"
+    flags="$2"
+    actual="$(${PKG_CONFIG} $flags $libname | awk '{gsub(/^\s+|\s+$/,"")}1')"
+    expected="$3"
+
+    if [ "$actual" != "$expected" ]; then
+        die "pkg-config $flags failed on $libname: '$actual' != '$expected'"
+    fi
+}
+
+test-exists "$LIBNAME"
+test-pkg-config "$LIBNAME" "--cflags" "-I${incdir}"
+test-pkg-config "$LIBNAME" "--libs"  "-L${libdir} -lbtrfsutil"
-- 
2.25.1

