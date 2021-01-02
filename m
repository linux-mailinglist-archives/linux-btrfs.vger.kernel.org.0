Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6352E863E
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Jan 2021 04:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbhABDvh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Jan 2021 22:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbhABDvg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Jan 2021 22:51:36 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3400C0613C1
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Jan 2021 19:50:35 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id t8so13167428pfg.8
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Jan 2021 19:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YJIk1OC7nXqpXAlGqKd5hJWSjnbi0ZJxjcmY9QMPFBM=;
        b=e3xiWeC6cXsMokBPw+IZFLimHZ4uhevyolPnH+GNBDyhX6cVJDtgntWbONQd35ClBd
         tqAtpkI0esnX5ggWxRcjwBxTZ44+B56C1B3Ld7rGi+ojSeo2AnuM7SzKOQEnKUHQAs2m
         Q0fsrozUD4fMAlfmEE+RUoc0eJht7wubRlYZJ2scU775BJM8BQ8896jqpOVVx8sFH9RK
         Q/c1DhuRZ33n6F/+xR4UwcjstmfYS/BjCnJnUkN91YdRebUW6H5U57gSBmE1zIGXbSs6
         WsRPmQFKD/PTHunS2QxvrsMjQBMz35NsctGHVBJYjaD8mQvmohZjwUhw3WXGo4t4nvZj
         iEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=YJIk1OC7nXqpXAlGqKd5hJWSjnbi0ZJxjcmY9QMPFBM=;
        b=jegzlec7OQAbbGxIcRjC/zOyIt8YMkjllX1H9WUU2ENtsJnXeP+ERxJPY45ll6kcGR
         XLcyxdnhpn6kw31z+u92bLBozkuZnphLb6Cop2mYiyEnvI4rW+H3XO3Kw/cayfrcDYAY
         yKOJF6MITh/W0yeVtCKExlgpsj5iQ0f+kCykHGVUADTwR0wgNmlLVs/UiJ1TgpW6/bTG
         UKh9ZubpmwLRhRWi1gVjJxVc48ZeEDMZiQ+GY6rg1QKXqXXA72X+hDRi9Vm9KotnqEkk
         G3l+wc6Vo5LHD8qYOv6wFCQ9AJi0rXETfQjReSMKTRbQMXWHP/U/JgGEdcKfH2PmKhwZ
         8SrQ==
X-Gm-Message-State: AOAM531ZM5/JUlxmxvkelGI8gup+c5+zmqgaWJLL/Tld/0MG2sUqY7nZ
        BH6g0sNs7YuJj2oemwCsdDY=
X-Google-Smtp-Source: ABdhPJzx6gTTUDMgecQ1Fc0eGHDd8rAmgVewaCytiN4UsxXSDszbJqL5SfFUJ/ZgSiR4bNbRT2XuOw==
X-Received: by 2002:a63:4f04:: with SMTP id d4mr63179073pgb.225.1609559435313;
        Fri, 01 Jan 2021 19:50:35 -0800 (PST)
Received: from localhost.localdomain (S010664777d4a88b3.cg.shawcable.net. [70.77.224.58])
        by smtp.gmail.com with ESMTPSA id x15sm49823522pfa.80.2021.01.01.19.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jan 2021 19:50:34 -0800 (PST)
Sender: Sheng Mao <ks8xntk9mds5i@gmail.com>
From:   shngmao@gmail.com
To:     wangyugui@e16-tech.com
Cc:     linux-btrfs@vger.kernel.org, Sheng Mao <shngmao@gmail.com>
Subject: [PATCH v2 2/3] btrfs-progs: add build support for ktls feature
Date:   Fri,  1 Jan 2021 20:49:56 -0700
Message-Id: <20210102034957.2825531-2-shngmao@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210102034957.2825531-1-shngmao@gmail.com>
References: <20210101135350.AD49.409509F4@e16-tech.com>
 <20210102034957.2825531-1-shngmao@gmail.com>
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

