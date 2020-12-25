Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4024A2E299F
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Dec 2020 05:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbgLYExM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Dec 2020 23:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729154AbgLYExM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Dec 2020 23:53:12 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CDCC061575
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Dec 2020 20:52:32 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id f14so1974950pju.4
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Dec 2020 20:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YJIk1OC7nXqpXAlGqKd5hJWSjnbi0ZJxjcmY9QMPFBM=;
        b=L6y5CCJ/ha9G8gYdA7E9Gxu1Eb38n1KD3sw+sNXQq2p0fNKVLCQIT+9wQlzsXThRpm
         nw0VrtpwTf+JNiaT6ouM2vZJGUcVVNQ8qqSgFeZte1L1viV4rOhvMvPOVoH9OHCHpL3n
         Kl3L2XJWMtXlauzPiKgUSBjqyTW9XZYpiXZ07ZMryRuz/D48KmWC/KSTFSX1xJT6UETq
         YnuEXWszJdXuENMF5rGp0tXxDK8qzXhbNYwSPPBf2jha7GfJV/LlCRL99odNQ8NyFz6E
         sYKf8eVHTv1dV6d0N6LRpGnRdG3F/nTw1wSMBfFLwvkAkxdMnPjWUXHZcxK697q09TZY
         XlfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=YJIk1OC7nXqpXAlGqKd5hJWSjnbi0ZJxjcmY9QMPFBM=;
        b=huDKesKP8aJZwpcizOPdSzxkpiT//nx0YGSjc13J9p0HBt9jkidoHMjzrEKb6Ha4gm
         GX4lVX61HWu3ATa9KM6Z4AnzF1soMcHBlAm4TO0stJC72dMdnO6npHY3K67iYNQQav7z
         AaWpjrs1lfMmpGlSz/CH0hBm1pjIovqPAFwaCwUft0av55Msho/m4WUKuJEdivtx8pDi
         v6EmLBX+lKFacWfZBCfHE6NYW+O84jQ8hMX1Fuvh2P9v76DCWESO78FSJau92OYc/y1P
         T2X7uVK8M7h4jOTgDkAv7IOLQBxtDONxS5So5abIgtnNwX3nE85jS7/JSg5o3vviU02T
         zA8g==
X-Gm-Message-State: AOAM532coxn+c1wwWk5EZ+v2cV9ekC/UNZNSTbL9aiOmabytJw5EcK8a
        G0jHXM6HgZmt1sX0O83N77pXntbf3FU=
X-Google-Smtp-Source: ABdhPJx+lx23+HhNuSADejGaG6vMg2T6MwtuX2QehrH9aDM+qarIHf1tHhvL49yoGsFp0TZUDmG+SQ==
X-Received: by 2002:a17:90a:674c:: with SMTP id c12mr7056593pjm.98.1608871951789;
        Thu, 24 Dec 2020 20:52:31 -0800 (PST)
Received: from hasee.home (S010664777d4a88b3.cg.shawcable.net. [70.77.224.58])
        by smtp.gmail.com with ESMTPSA id i25sm24308426pfo.137.2020.12.24.20.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Dec 2020 20:52:31 -0800 (PST)
Sender: Sheng Mao <ks8xntk9mds5i@gmail.com>
From:   shngmao@gmail.com
To:     linux-btrfs@vger.kernel.org
Cc:     Sheng Mao <shngmao@gmail.com>
Subject: [PATCH 2/3] btrfs-progs: add build support for ktls feature
Date:   Thu, 24 Dec 2020 21:50:36 -0700
Message-Id: <20201225045037.185537-2-shngmao@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201225045037.185537-1-shngmao@gmail.com>
References: <20201225045037.185537-1-shngmao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Sheng Mao <shngmao@gmail.com>

Enable building ktls by default. Require GnuTLS 3.4.0
for handshake process.

Issue: #326
Signed-off-by: Sheng Mao <shngmao@gmail.com>
---
 INSTALL         |  5 +++++
 Makefile        |  6 ++++++
 Makefile.inc.in |  6 ++++--
 configure.ac    | 15 +++++++++++++++
 4 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/INSTALL b/INSTALL
index 470ceebd..ae244616 100644
--- a/INSTALL
+++ b/INSTALL
@@ -22,6 +22,11 @@ dependencies are not desired.
 - libsodium
 - libkcapi
 
+GnuTLS 3.4.0 is needed to enable kernel TLS in btrfs send/receive. OpenSSL
+does not have a similar feature like gnutls_record_get_state (issue #8844).
+GnuTLS handles TLS 1.2/1.3 handshake and passes encryption parameters to
+kernel TLS.
+
 Generating documentation:
 
 - asciidoc - text document format tool
diff --git a/Makefile b/Makefile
index 381b630d..2a3212a5 100644
--- a/Makefile
+++ b/Makefile
@@ -96,6 +96,7 @@ CFLAGS = $(SUBST_CFLAGS) \
 	 -I$(TOPDIR) \
 	 -I$(TOPDIR)/libbtrfsutil \
 	 $(CRYPTO_CFLAGS) \
+	 $(KTLS_SEND_RECV_FLAGS) \
 	 $(DISABLE_WARNING_FLAGS) \
 	 $(ENABLE_WARNING_FLAGS) \
 	 $(EXTRAWARN_CFLAGS) \
@@ -159,6 +160,11 @@ cmds_objects = cmds/subvolume.o cmds/filesystem.o cmds/device.o cmds/scrub.o \
 	       cmds/property.o cmds/filesystem-usage.o cmds/inspect-dump-tree.o \
 	       cmds/inspect-dump-super.o cmds/inspect-tree-stats.o cmds/filesystem-du.o \
 	       mkfs/common.o check/mode-common.o check/mode-lowmem.o
+
+ifeq ($(KTLS_SEND_RECV),1)
+cmds_objects += common/ktls.o
+endif
+
 libbtrfs_objects = common/send-stream.o common/send-utils.o kernel-lib/rbtree.o btrfs-list.o \
 		   kernel-lib/radix-tree.o common/extent-cache.o kernel-shared/extent_io.o \
 		   crypto/crc32c.o common/messages.o \
diff --git a/Makefile.inc.in b/Makefile.inc.in
index 9f493371..aede2edd 100644
--- a/Makefile.inc.in
+++ b/Makefile.inc.in
@@ -18,6 +18,8 @@ BUILD_STATIC_LIBRARIES = @BUILD_STATIC_LIBRARIES@
 BTRFSCONVERT_EXT2 = @BTRFSCONVERT_EXT2@
 BTRFSCONVERT_REISERFS = @BTRFSCONVERT_REISERFS@
 BTRFSRESTORE_ZSTD = @BTRFSRESTORE_ZSTD@
+KTLS_SEND_RECV = @KTLS_SEND_RECV@
+KTLS_SEND_RECV_FLAGS = -DKTLS_SEND_RECV=@KTLS_SEND_RECV@
 PYTHON_BINDINGS = @PYTHON_BINDINGS@
 PYTHON = @PYTHON@
 PYTHON_CFLAGS = @PYTHON_CFLAGS@
@@ -28,11 +30,11 @@ SUBST_CFLAGS = @CFLAGS@
 SUBST_LDFLAGS = @LDFLAGS@
 
 LIBS_BASE = @UUID_LIBS@ @BLKID_LIBS@ -L. -pthread
-LIBS_COMP = @ZLIB_LIBS@ @LZO2_LIBS@ @ZSTD_LIBS@
+LIBS_COMP = @ZLIB_LIBS@ @LZO2_LIBS@ @ZSTD_LIBS@ @KTLS_LIBS@
 LIBS_PYTHON = @PYTHON_LIBS@
 LIBS_CRYPTO = @GCRYPT_LIBS@ @SODIUM_LIBS@ @KCAPI_LIBS@
 STATIC_LIBS_BASE = @UUID_LIBS_STATIC@ @BLKID_LIBS_STATIC@ -L. -pthread
-STATIC_LIBS_COMP = @ZLIB_LIBS_STATIC@ @LZO2_LIBS_STATIC@ @ZSTD_LIBS_STATIC@
+STATIC_LIBS_COMP = @ZLIB_LIBS_STATIC@ @LZO2_LIBS_STATIC@ @ZSTD_LIBS_STATIC@ @KTLS_LIBS_STATIC@
 
 prefix ?= @prefix@
 exec_prefix = @exec_prefix@
diff --git a/configure.ac b/configure.ac
index dd4adedf..f87b24ae 100644
--- a/configure.ac
+++ b/configure.ac
@@ -278,6 +278,21 @@ fi
 AS_IF([test "x$enable_zstd" = xyes], [BTRFSRESTORE_ZSTD=1], [BTRFSRESTORE_ZSTD=0])
 AC_SUBST(BTRFSRESTORE_ZSTD)
 
+dnl Use GnuTLS to handle TLS handshake. OpenSSL cannot provide record state
+dnl to caller and thus cannot handle handshake
+AC_ARG_ENABLE([ktls],
+	AS_HELP_STRING([--disable-ktls], [build without ktls support]),
+	[], [enable_ktls=yes]
+)
+
+if test "x$enable_ktls" = xyes; then
+	PKG_CHECK_MODULES(KTLS, [gnutls >= 3.4.0])
+	PKG_STATIC(KTLS_LIBS_STATIC, [gnutls])
+fi
+
+AS_IF([test "x$enable_ktls" = xyes], [KTLS_SEND_RECV=1], [KTLS_SEND_RECV=0])
+AC_SUBST(KTLS_SEND_RECV)
+
 AC_ARG_ENABLE([python],
 	AS_HELP_STRING([--disable-python], [do not build libbtrfsutil Python bindings]),
 	[], [enable_python=$enable_shared]
-- 
2.29.2

