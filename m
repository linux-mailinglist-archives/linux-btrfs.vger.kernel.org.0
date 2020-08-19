Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E0724A8B6
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Aug 2020 23:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgHSVqg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Aug 2020 17:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgHSVq2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Aug 2020 17:46:28 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD8BC061757
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Aug 2020 14:46:27 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id m34so110803pgl.11
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Aug 2020 14:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sVyW5Xabtefzd7zTMqZaEPFf2R4d4i4RvCtJp5McWHw=;
        b=CGT85+Wk3OfRe3guW79zejEdorSHatZXDpFp2VNd1lMNOzdX48xfLLfu+0Gz5LixQj
         0bQ3BaT09VMTHDZq53YGlIhsNu0eIWE6RP36zmDMFXyLQQezBYXAp/51QYP7I6wVetCP
         9zABdM4Ce9yK0C4BlpNE5MqEQAeDcWnvU7E2Vuk6gbtSIekYiLCUcqjLLwRTmUzRJbyc
         0imxuHm+1B80t7+hjrm2iKKQ6fraM+hLChJFkOnD78CP6ehkrP/GmI9h+c0JKDA2axMQ
         53JRkus5YzddBHUJy/fCpJpiED1eQSLh+rMNw2ZXMs3UgFdHRWtaJg8A5j8KE/7ve5Zy
         LtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sVyW5Xabtefzd7zTMqZaEPFf2R4d4i4RvCtJp5McWHw=;
        b=ZTXiZpNtkzG3JkWvSKMVFJKR66IXpesqGlHK/oTozckwfiwlHQLVfkKs+sBPFP6EW8
         ZVNEn0gJHh+aOlww/npJQVAtu5APCSHvsA1kF6rEsDHcIFS79Muk0gXShQffejkPs9Y0
         ZkOZjeJGnybdXHkI9BVzpfRT1ho7sex+InfcbmpwtO1RXXGnRteV2LzQKsH97R5aaqfR
         U+iaBbhy7WSkcpUd04dpCAOQ30lsjUSapvszjV9OfmICzYQOvbSkz8Nw++5YOqqyh7ix
         PaZWy8pkvlvRcnMMTdrFH6F/5jMpvxsls+tYygACy8qoDfa3GOmBAmvs/ELlLr2yuGNR
         iaog==
X-Gm-Message-State: AOAM5300TKw/O/KND+wQ71YJndvvKJp9AVlX1Q5ciW6Gx/eIQ7Ur/u4R
        aK19geRWQyCIgDb/PYSFWaPMID/KdHo=
X-Google-Smtp-Source: ABdhPJxf09nJXjQg4vMnrHuLFNC4MjrY/CVMWNDPbYplBT361zPA7PXZntHJTc5wYbnZfpONOfgUXA==
X-Received: by 2002:a63:26c6:: with SMTP id m189mr311000pgm.68.1597873586429;
        Wed, 19 Aug 2020 14:46:26 -0700 (PDT)
Received: from dell.circlecvi.com (S010664777d4a88b3.cg.shawcable.net. [70.77.224.58])
        by smtp.gmail.com with ESMTPSA id v2sm3973552pjd.18.2020.08.19.14.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 14:46:25 -0700 (PDT)
From:   Sheng Mao <shngmao@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Sheng Mao <shngmao@gmail.com>
Subject: [PATCH] btrfs-progs: btrfsutil: add pkg-config files for btrfsutil
Date:   Wed, 19 Aug 2020 15:45:58 -0600
Message-Id: <20200819214558.531259-1-shngmao@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add pc files for dynamic and static btrfsutil
libraries. Users can use pkg-config to set up
compilation and linking flags.

The paths in pc files depend on prefix variable but
ignore DESTDIR. DESTDIR is used for packaging and
it should not affect the paths in pc files.

Signed-off-by: Sheng Mao <shngmao@gmail.com>
---
 .gitignore                             |  1 +
 Makefile                               | 10 +++++-
 Makefile.inc.in                        |  1 +
 configure.ac                           | 13 ++++++++
 libbtrfsutil/libbtrfsutil-static.pc.in | 11 +++++++
 libbtrfsutil/libbtrfsutil.pc.in        | 11 +++++++
 tests/pkg-config-tests.sh              | 45 ++++++++++++++++++++++++++
 7 files changed, 91 insertions(+), 1 deletion(-)
 create mode 100644 libbtrfsutil/libbtrfsutil-static.pc.in
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
index c788b91b..ecb00389 100644
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
@@ -779,6 +784,9 @@ endif
 	$(INSTALL) -m755 -d $(DESTDIR)$(incdir)/btrfs
 	$(INSTALL) -m644 $(libbtrfs_headers) $(DESTDIR)$(incdir)/btrfs
 	$(INSTALL) -m644 libbtrfsutil/btrfsutil.h $(DESTDIR)$(incdir)
+	$(INSTALL) -m755 -d $(DESTDIR)$(pkgconfigdir)
+	$(INSTALL) -m644 libbtrfsutil/libbtrfsutil.pc $(DESTDIR)$(pkgconfigdir)
+	$(INSTALL) -m644 libbtrfsutil/libbtrfsutil-static.pc $(DESTDIR)$(pkgconfigdir)
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
index 7c2c9b8d..80dd2077 100644
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
 
@@ -300,18 +304,26 @@ AC_SUBST([LZO2_LIBS])
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
+libbtrfsutil/libbtrfsutil-static.pc
 ])
 
 AC_OUTPUT
@@ -325,6 +337,7 @@ AC_MSG_RESULT([
 	bindir:             ${bindir}
 	libdir:             ${libdir}
 	includedir:         ${includedir}
+	pkgconfigdir:       ${pkgconfigdir}
 
 	compiler:           ${CC}
 	cflags:             ${CFLAGS}
diff --git a/libbtrfsutil/libbtrfsutil-static.pc.in b/libbtrfsutil/libbtrfsutil-static.pc.in
new file mode 100644
index 00000000..071b2594
--- /dev/null
+++ b/libbtrfsutil/libbtrfsutil-static.pc.in
@@ -0,0 +1,11 @@
+prefix=@prefix@
+exec_prefix=@exec_prefix@
+libdir=@libdir@
+includedir=@includedir@
+
+Name: libbtrfsutil-static
+Description: libbtrfsutil static library
+Version: @BTRFS_UTIL_VERSION_MAJOR@.@BTRFS_UTIL_VERSION_MINOR@.@BTRFS_UTIL_VERSION_PATCH@
+URL: http://btrfs.wiki.kernel.org
+Cflags: -I${includedir}
+Libs: @libdir@/libbtrfsutil.a
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
index 00000000..63f614e4
--- /dev/null
+++ b/tests/pkg-config-tests.sh
@@ -0,0 +1,45 @@
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
+SHARED_LIBNAME=libbtrfsutil
+STATIC_LIBNAME=libbtrfsutil-static
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
+    actual="$(${PKG_CONFIG} $flags $libname)"
+    expected="$3"
+
+    if [ "$actual" != "$expected" ]; then
+        die "pkg-config $flags failed on $libname: $actual != $expected"
+    fi
+}
+
+test-exists "$SHARED_LIBNAME"
+test-exists "$STATIC_LIBNAME"
+test-pkg-config "$SHARED_LIBNAME" "--cflags" "-I${incdir}"
+test-pkg-config "$STATIC_LIBNAME" "--cflags"  "-I${incdir}"
+test-pkg-config "$SHARED_LIBNAME" "--libs"  "-L${libdir} -lbtrfsutil"
+test-pkg-config "$STATIC_LIBNAME" "--libs" "${libdir}/libbtrfsutil.a"
-- 
2.25.1

