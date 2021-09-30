Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A2941D951
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Sep 2021 14:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350693AbhI3MIW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Sep 2021 08:08:22 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58176 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350668AbhI3MIV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Sep 2021 08:08:21 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AD10520025;
        Thu, 30 Sep 2021 12:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633003598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C6Hss5OwdLUVMpak32pytdyu292G2L/1BdOVwywNfmM=;
        b=vWrmM+mMDAzvLTmEr/7r2HCIh7IDKQ7Xd7Ep3oNAzPaFSuH5KdiaPY7Y+IR4InLf5fPsqI
        36ooay49SRhbeulXEfofDByiAsQB6sH2+OqiKmV+tae8K7PvxWVmz0gaTv56ng0Bk0BUuq
        bFeiqXnq4dFCwUWD9pPONmtZ7oKpZ5A=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7BFDF13B05;
        Thu, 30 Sep 2021 12:06:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kEzuG06oVWHDLwAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 30 Sep 2021 12:06:38 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 1/3] btrfs-progs: Add optional dependency on libudev
Date:   Thu, 30 Sep 2021 15:06:32 +0300
Message-Id: <20210930120634.632946-2-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210930120634.632946-1-nborisov@suse.com>
References: <20210930120634.632946-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is needed for future code which will make btrfs-progs' device
scanning logic a little smarter by filtering out path device in
multipath setups. libudev is added as an optional dependency since the
library doesn't have a static version so making it a hard dependency
means forfeiting static build support. To alleviate this a fallback code
will be added for the static build case which doesn't rely on libudev.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 Makefile        | 2 +-
 Makefile.inc.in | 2 +-
 configure.ac    | 9 +++++++++
 3 files changed, 11 insertions(+), 2 deletions(-)

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

