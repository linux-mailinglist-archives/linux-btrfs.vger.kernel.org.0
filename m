Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D201133DDFF
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Mar 2021 20:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240669AbhCPTqG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Mar 2021 15:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240616AbhCPTpC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Mar 2021 15:45:02 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E7CC0613DD
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Mar 2021 12:44:39 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so64211pjb.0
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Mar 2021 12:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fuAw0ppT0ABvcb7CD6nxV0FbeYlL2sIG10J+yY2raCU=;
        b=ztqOvQUthnoojW1c4C5JqRJk0YckO3BPtl5/hMvtBD3/GNsDPIwfazyld3BbiRGdwC
         E0loKHEIiJ6N31sXfk+LxGOxDdgXnRM0l3r0hpklJ6P/d8fMc2Ox9tsb0Z1O11sDKUqn
         juMFavGAu9dONm/5NPSUJW1SBJwIslofq3lLpW2T66UTF+Dx4SkBg0iGQ0en9NfINIDa
         /aiGC54mei1nF/hDK1giqhpfTpXSgtN2I04hkx3hFMI5/FMexuD1gi1QQI7ku7JrlYju
         vI2yKnN+YYqk4WgnUZtTJBqAE1NO0xeIBMRMgJty4ze27g49WLiH5qI/wCw9xwB7EPAq
         aqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fuAw0ppT0ABvcb7CD6nxV0FbeYlL2sIG10J+yY2raCU=;
        b=UBQig6OJ+G8YttIp/zeSze4tW12NPo4joo/RJPqfZ76VI3jqXVoZVFiw0zj2y455LV
         mrfVFIvkJ2TNR9myOqYaD5h7acOlHX1Qb9SoQIXcNAHKH0FvHNGjmZT6oY3hguX04oLU
         c0iV+ntIJIRux8JYPpT24z+naCwHJMO7pdbZyox7ML/VBMaw9HAiG8GgA88OG57EyVQM
         AdXppiRLCFY8tw+kEzjpxmWyyDh16r5MzLyA8yKiPjFiSJ/wugWQkMkGtdZu2xZUJt9k
         cDJ+er2eyplcdBlWyO3oamvPtiGgq2y1b6WROApreH9fGZLcnzxdMsE1QzQzAmUOkqpw
         dUwg==
X-Gm-Message-State: AOAM531MTsfm7UY2gnchngx+O3Uoub5L1HG955fHpaNp0q2rDzyT+Olt
        5pWDIwk8quizsc0loGvRz7NBfghM4EsDMw==
X-Google-Smtp-Source: ABdhPJzwOvxll0bc3dCRKvFwG94j5cEcrVnjYBlSnyRXrEmITN+aTln6aLaxs/NBjTH1aekjVGqX6g==
X-Received: by 2002:a17:90a:d907:: with SMTP id c7mr611393pjv.45.1615923878427;
        Tue, 16 Mar 2021 12:44:38 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:532])
        by smtp.gmail.com with ESMTPSA id w22sm16919104pfi.133.2021.03.16.12.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 12:44:37 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 05/11] btrfs-progs: receive: add stub implementation for pwritev2
Date:   Tue, 16 Mar 2021 12:43:58 -0700
Message-Id: <e6817cbd8ba926eb5b4e0d19e10ac6a2af6ad05b.1615922859.git.osandov@osandov.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1615922753.git.osandov@fb.com>
References: <cover.1615922753.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Boris Burkov <borisb@fb.com>

Encoded writes in receive will use pwritev2. It is possible that the
system libc does not export this function, so we stub it out and detect
whether to build the stub code with autoconf.

This syscall has special semantics in x32 (no hi lo, just takes loff_t)
so we have to detect that case and use the appropriate arguments.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 Makefile     |  4 ++--
 configure.ac |  1 +
 stubs.c      | 24 ++++++++++++++++++++++++
 stubs.h      | 11 +++++++++++
 4 files changed, 38 insertions(+), 2 deletions(-)
 create mode 100644 stubs.c
 create mode 100644 stubs.h

diff --git a/Makefile b/Makefile
index 498588cd..b91daeb6 100644
--- a/Makefile
+++ b/Makefile
@@ -173,12 +173,12 @@ libbtrfs_objects = common/send-stream.o common/send-utils.o kernel-lib/rbtree.o
 		   kernel-lib/raid56.o kernel-lib/tables.o \
 		   common/device-scan.o common/path-utils.o \
 		   common/utils.o libbtrfsutil/subvolume.o libbtrfsutil/stubs.o \
-		   crypto/hash.o crypto/xxhash.o $(CRYPTO_OBJECTS)
+		   crypto/hash.o crypto/xxhash.o $(CRYPTO_OBJECTS) stubs.o
 libbtrfs_headers = common/send-stream.h common/send-utils.h send.h kernel-lib/rbtree.h btrfs-list.h \
 	       crypto/crc32c.h kernel-lib/list.h kerncompat.h \
 	       kernel-lib/radix-tree.h kernel-lib/sizes.h kernel-lib/raid56.h \
 	       common/extent-cache.h kernel-shared/extent_io.h ioctl.h \
-	       kernel-shared/ctree.h btrfsck.h version.h
+	       kernel-shared/ctree.h btrfsck.h version.h stubs.h
 libbtrfsutil_major := $(shell sed -rn 's/^\#define BTRFS_UTIL_VERSION_MAJOR ([0-9])+$$/\1/p' libbtrfsutil/btrfsutil.h)
 libbtrfsutil_minor := $(shell sed -rn 's/^\#define BTRFS_UTIL_VERSION_MINOR ([0-9])+$$/\1/p' libbtrfsutil/btrfsutil.h)
 libbtrfsutil_patch := $(shell sed -rn 's/^\#define BTRFS_UTIL_VERSION_PATCH ([0-9])+$$/\1/p' libbtrfsutil/btrfsutil.h)
diff --git a/configure.ac b/configure.ac
index aa3f7824..4e85436f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -57,6 +57,7 @@ AC_CHECK_FUNCS([openat], [],
 	[AC_MSG_ERROR([cannot find openat() function])])
 
 AC_CHECK_FUNCS([reallocarray])
+AC_CHECK_FUNCS([pwritev2])
 
 m4_ifndef([PKG_PROG_PKG_CONFIG],
   [m4_fatal([Could not locate the pkg-config autoconf
diff --git a/stubs.c b/stubs.c
new file mode 100644
index 00000000..ab68a411
--- /dev/null
+++ b/stubs.c
@@ -0,0 +1,24 @@
+#if HAVE_PWRITEV2 != 1
+
+#include "stubs.h"
+
+#include "kerncompat.h"
+
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <sys/uio.h>
+
+ssize_t pwritev2(int fd, const struct iovec *iov, int iovcnt, off_t offset,
+		 int flags)
+{
+/* these conditions indicate an x32 system, which has a different pwritev2 */
+#if defined(__x86_64__) && defined(__ILP32__)
+	return syscall(SYS_pwritev2, fd, iov, iovcnt, offset, flags);
+#else
+	unsigned long hi = offset >> (BITS_PER_LONG / 2) >> (BITS_PER_LONG / 2);
+	unsigned long lo = offset;
+
+	return syscall(SYS_pwritev2, fd, iov, iovcnt, lo, hi, flags);
+#endif // X32
+}
+#endif /* HAVE_PWRIVEV2 */
diff --git a/stubs.h b/stubs.h
new file mode 100644
index 00000000..b39f8a69
--- /dev/null
+++ b/stubs.h
@@ -0,0 +1,11 @@
+#ifndef _BTRFS_STUBS_H
+#define _BTRFS_STUBS_H
+
+#include <sys/types.h>
+
+struct iovec;
+
+ssize_t pwritev2(int fd, const struct iovec *iov, int iovcnt, off_t offset,
+		 int flags);
+
+#endif
-- 
2.30.2

