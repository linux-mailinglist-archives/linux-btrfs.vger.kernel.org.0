Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9124641AF22
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Sep 2021 14:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240565AbhI1MjQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Sep 2021 08:39:16 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54904 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240526AbhI1MjP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Sep 2021 08:39:15 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2B2292020D;
        Tue, 28 Sep 2021 12:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632832652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=and9OUsHOkZzh9uebY2xZ3KhJqUc0TtsR1SA265fTh0=;
        b=krogiX13cuq5uaaj3o92rFwEH+ga1CwsQhnOJL+CEKbDEsy7RRDb4xUxxMi5E3wnDAmSMU
        V6noQsY+zbhzdKdkn4ZiGBY1fT7w0SGIUD6fqunV4jLFhTEoYK3ouH3788bDOqSMwJRhlD
        F6+Q2IrQNNzAud4PoEqiSpjpKwSrTkg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F044C13A82;
        Tue, 28 Sep 2021 12:37:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9KUSOIsMU2GLCwAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 28 Sep 2021 12:37:31 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/2] btrfs-progs: Ignore path device during device scan
Date:   Tue, 28 Sep 2021 15:37:29 +0300
Message-Id: <20210928123730.393551-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently btrfs-progs will happily enumerate any device which has a
btrfs filesystem on it. For the majority of use cases that's fine and
there haven't been any problems with that. However, there was a recent
report that in multipath scenario when running "btrfs fi show" after a
path flap instead of the multipath device being show the path device is
shown. So a multipath filesystem might look like:

Label: none  uuid: d3c1261f-18be-4015-9fef-6b35759dfdba
	Total devices 1 FS bytes used 192.00KiB
	devid    1 size 10.00GiB used 536.00MiB path /dev/mapper/3600140501cc1f49e5364f0093869c763

/dev/mapper/xxx can actually be backed by an arbitrary number of path,
which in turn are presented to the system as ordinary scsi devices i.e
/dev/sdd. If a path flaps and a user re-runs 'btrfs fi show' the output
would look like:

Label: none  uuid: d3c1261f-18be-4015-9fef-6b35759dfdba
	Total devices 1 FS bytes used 192.00KiB
	devid    1 size 10.00GiB used 536.00MiB path /dev/sdd

Turns out the output of this command is consumed by libraries and the
presence of a path device rather than the actual multipath one can cause
issues.

Fix this by relying on the fact that path devices are tagged with the
DM_MULTIPATH_DEVICE_PATH attribute by the respective udev scripts. In
order to access it an optional dependency on libudev is added, if the
library can't be found then device enumeration will continue working
as it was before the commit. Since libudev doesn't have static library
for now support for this behavior in case of static builds is going to
be disabled. Fallback code for static builds will come in a future
commit.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 Makefile             |  2 +-
 Makefile.inc.in      |  2 +-
 common/device-scan.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 configure.ac         |  9 +++++++++
 4 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 93fe4c2b3e08..e96f66a36b46 100644
--- a/Makefile
+++ b/Makefile
@@ -129,7 +129,7 @@ LIBS = $(LIBS_BASE) $(LIBS_CRYPTO)
 LIBBTRFS_LIBS = $(LIBS_BASE) $(LIBS_CRYPTO)
 
 # Static compilation flags
-STATIC_CFLAGS = $(CFLAGS) -ffunction-sections -fdata-sections
+STATIC_CFLAGS = $(CFLAGS) -ffunction-sections -fdata-sections -DSTATIC_BUILD
 STATIC_LDFLAGS = -static -Wl,--gc-sections
 STATIC_LIBS = $(STATIC_LIBS_BASE)
 
diff --git a/Makefile.inc.in b/Makefile.inc.in
index 9f49337147b8..c995aef97219 100644
--- a/Makefile.inc.in
+++ b/Makefile.inc.in
@@ -27,7 +27,7 @@ CRYPTO_CFLAGS = @GCRYPT_CFLAGS@ @SODIUM_CFLAGS@ @KCAPI_CFLAGS@
 SUBST_CFLAGS = @CFLAGS@
 SUBST_LDFLAGS = @LDFLAGS@
 
-LIBS_BASE = @UUID_LIBS@ @BLKID_LIBS@ -L. -pthread
+LIBS_BASE = @UUID_LIBS@ @BLKID_LIBS@ @LIBUDEV_LIBS@ -L. -pthread
 LIBS_COMP = @ZLIB_LIBS@ @LZO2_LIBS@ @ZSTD_LIBS@
 LIBS_PYTHON = @PYTHON_LIBS@
 LIBS_CRYPTO = @GCRYPT_LIBS@ @SODIUM_LIBS@ @KCAPI_LIBS@
diff --git a/common/device-scan.c b/common/device-scan.c
index b5bfe844104b..2ed0e34d3664 100644
--- a/common/device-scan.c
+++ b/common/device-scan.c
@@ -14,6 +14,10 @@
  * Boston, MA 021110-1307, USA.
  */
 
+#ifdef STATIC_BUILD
+#undef HAVE_LIBUDEV
+#endif
+
 #include "kerncompat.h"
 #include <sys/ioctl.h>
 #include <stdlib.h>
@@ -25,6 +29,10 @@
 #include <dirent.h>
 #include <blkid/blkid.h>
 #include <uuid/uuid.h>
+#ifdef HAVE_LIBUDEV
+#include <sys/stat.h>
+#include <libudev.h>
+#endif
 #include "kernel-lib/overflow.h"
 #include "common/path-utils.h"
 #include "common/device-scan.h"
@@ -364,6 +372,37 @@ void free_seen_fsid(struct seen_fsid *seen_fsid_hash[])
 	}
 }
 
+#ifdef HAVE_LIBUDEV
+static bool is_path_device(char *device_path)
+{
+	struct udev *udev = NULL;
+	struct udev_device *dev = NULL;
+	struct stat dev_stat;
+	const char *val;
+	bool ret = false;
+
+	if (stat(device_path, &dev_stat) < 0)
+		return false;
+
+	udev = udev_new();
+	if (!udev)
+		goto out;
+
+	dev = udev_device_new_from_devnum(udev, 'b', dev_stat.st_rdev);
+	if (!dev)
+		goto out;
+
+	val = udev_device_get_property_value(dev, "DM_MULTIPATH_DEVICE_PATH");
+	if (val && atoi(val) > 0)
+		ret = true;
+out:
+	udev_device_unref(dev);
+	udev_unref(udev);
+
+	return ret;
+}
+#endif
+
 int btrfs_scan_devices(int verbose)
 {
 	int fd = -1;
@@ -394,6 +433,11 @@ int btrfs_scan_devices(int verbose)
 		/* if we are here its definitely a btrfs disk*/
 		strncpy_null(path, blkid_dev_devname(dev));
 
+#ifdef HAVE_LIBUDEV
+		if (is_path_device(path))
+			continue;
+#endif
+
 		fd = open(path, O_RDONLY);
 		if (fd < 0) {
 			error("cannot open %s: %m", path);
diff --git a/configure.ac b/configure.ac
index 038c2688421c..d0ceb0d70d16 100644
--- a/configure.ac
+++ b/configure.ac
@@ -304,6 +304,15 @@ PKG_STATIC(UUID_LIBS_STATIC, [uuid])
 PKG_CHECK_MODULES(ZLIB, [zlib])
 PKG_STATIC(ZLIB_LIBS_STATIC, [zlib])
 
+PKG_CHECK_EXISTS([libudev], [pkg_config_libudev=yes], [pkg_config_libudev=no])
+if test "x$pkg_config_libudev" = xyes; then
+	PKG_CHECK_MODULES([LIBUDEV], [libudev])
+	AC_DEFINE([HAVE_LIBUDEV], [1], [Define to 1 if libudev is available])
+else
+	AC_MSG_CHECKING([for LIBUDEV])
+	AC_MSG_RESULT([no])
+fi
+
 AC_ARG_ENABLE([zstd],
 	AS_HELP_STRING([--disable-zstd], [build without zstd support]),
 	[], [enable_zstd=yes]
-- 
2.17.1

