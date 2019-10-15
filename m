Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2C5D7F47
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2019 20:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389247AbfJOSnK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Oct 2019 14:43:10 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33012 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389233AbfJOSnG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Oct 2019 14:43:06 -0400
Received: by mail-pl1-f194.google.com with SMTP id d22so10015417pls.0
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Oct 2019 11:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9l37TEfFlzhTfHVa66tfBgwHt/VTzXtSVqtmEbzs7eE=;
        b=qwvRKY8G7/gL4SfZSNPxA6dy1LMYJGZ/ItULRzAWltUQqj1sVgb4xdK7EahNb/GJcm
         OLwqoX8BbhHcUXU+Uavo96qf9TdJnjVH+nxC/3zcTOtUjzvnn9DAKvm9lBeY7/Cnk5C6
         6f9aLedRJKTC+xKHFwIgZfM2qMkSff6XaaNPBYbhQEM1WNo10P56ajpqhMDcXD8R2ial
         RIElKXxmhSNVxvspd1KmZ+WWlpvv/WE8tZSmH4GW5EkTo77HfTeFLBKVdObSnSxgWiVQ
         A/u0KdVd4Y02p/I6KuG5wbYiOXL6OGMD7q/B4ho9iGYdoQtW9CsKP+KnpuKkQsnBsk5B
         YvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9l37TEfFlzhTfHVa66tfBgwHt/VTzXtSVqtmEbzs7eE=;
        b=Bqnj1swQ6bbJZ541QSnDvcqooNRVp0YGsGiEi6HjN0LmLWN3qw/zf0BDZCNhkwuOTQ
         h3GG5Pw8KqMyP1cnVK81vw/7PB2Vg2SWa/QFy/RfdN4v1viiFLhFxWOxpnY1JeezsHVu
         Jv/XAxzD6s+CSCDGKf8xKf6fk/QHyhpU6WQfZSscvz5lYtpiYR+n0OnNv7jlGCVTsvJa
         iXTNjq6W3nU3I3sCcBGG2wX+7/x7HjnF8atIHri8TFLbBPXXLD3G8/xKd+zLySMnLD6A
         hrGX6MrcgrzC5YvC6y83Ihm+Z8RcbPWwYVobBCoqwOxl3m9aB4K8P4FHb57mtZ07upQl
         i2Ig==
X-Gm-Message-State: APjAAAXjGtGFYsXHQYqHsdZfJ48hS2MSiEi1E3TeLGVs1PIfCAHTbwLG
        M0REQEwvVaCg9MRjN1joTOw9hw==
X-Google-Smtp-Source: APXvYqyLtvWxp26Xv9CtcVp5dVzaWDL6cEFLB9J2UGemIDCxXQfEvqh2cCj87czzgbgwy125zWcJGg==
X-Received: by 2002:a17:902:7d98:: with SMTP id a24mr36822291plm.8.1571164985304;
        Tue, 15 Oct 2019 11:43:05 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:200::2:3e5e])
        by smtp.gmail.com with ESMTPSA id z3sm40396pjd.25.2019.10.15.11.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 11:43:04 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        linux-api@vger.kernel.org, kernel-team@fb.com
Subject: [RFC PATCH v2 1/5] fs: add O_ENCODED open flag
Date:   Tue, 15 Oct 2019 11:42:39 -0700
Message-Id: <c4d2e911b7b04df9aa8418c8b11bc4c194e3808c.1571164762.git.osandov@fb.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1571164762.git.osandov@fb.com>
References: <cover.1571164762.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

The upcoming RWF_ENCODED operation introduces some security concerns:

1. Compressed writes will pass arbitrary data to decompression
   algorithms in the kernel.
2. Compressed reads can leak truncated/hole punched data.

Therefore, we need to require privilege for RWF_ENCODED. It's not
possible to do the permissions checks at the time of the read or write
because, e.g., io_uring submits IO from a worker thread. So, add an open
flag which requires CAP_SYS_ADMIN. It can also be set and cleared with
fcntl(). The flag is not cleared in any way on fork or exec; it should
probably be used with O_CLOEXEC in most cases.

Note that the usual issue that unknown open flags are ignored doesn't
really matter for O_ENCODED; if the kernel doesn't support O_ENCODED,
then it doesn't support RWF_ENCODED, either.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/fcntl.c                       | 10 ++++++++--
 fs/namei.c                       |  4 ++++
 include/linux/fcntl.h            |  2 +-
 include/uapi/asm-generic/fcntl.h |  4 ++++
 4 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 3d40771e8e7c..45ebc6df078e 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -30,7 +30,8 @@
 #include <asm/siginfo.h>
 #include <linux/uaccess.h>
 
-#define SETFL_MASK (O_APPEND | O_NONBLOCK | O_NDELAY | O_DIRECT | O_NOATIME)
+#define SETFL_MASK (O_APPEND | O_NONBLOCK | O_NDELAY | O_DIRECT | O_NOATIME | \
+		    O_ENCODED)
 
 static int setfl(int fd, struct file * filp, unsigned long arg)
 {
@@ -49,6 +50,11 @@ static int setfl(int fd, struct file * filp, unsigned long arg)
 		if (!inode_owner_or_capable(inode))
 			return -EPERM;
 
+	/* O_ENCODED can only be set by superuser */
+	if ((arg & O_ENCODED) && !(filp->f_flags & O_ENCODED) &&
+	    !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
 	/* required for strict SunOS emulation */
 	if (O_NONBLOCK != O_NDELAY)
 	       if (arg & O_NDELAY)
@@ -1031,7 +1037,7 @@ static int __init fcntl_init(void)
 	 * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
 	 * is defined as O_NONBLOCK on some platforms and not on others.
 	 */
-	BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=
+	BUILD_BUG_ON(22 - 1 /* for O_RDONLY being 0 */ !=
 		HWEIGHT32(
 			(VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
 			__FMODE_EXEC | __FMODE_NONOTIFY));
diff --git a/fs/namei.c b/fs/namei.c
index 671c3c1a3425..ae86b125888a 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2978,6 +2978,10 @@ static int may_open(const struct path *path, int acc_mode, int flag)
 	if (flag & O_NOATIME && !inode_owner_or_capable(inode))
 		return -EPERM;
 
+	/* O_ENCODED can only be set by superuser */
+	if ((flag & O_ENCODED) && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
 	return 0;
 }
 
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index d019df946cb2..5fac02479639 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -9,7 +9,7 @@
 	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | \
 	 O_APPEND | O_NDELAY | O_NONBLOCK | O_NDELAY | __O_SYNC | O_DSYNC | \
 	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
-	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
+	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | O_ENCODED)
 
 #ifndef force_o_largefile
 #define force_o_largefile() (!IS_ENABLED(CONFIG_ARCH_32BIT_OFF_T))
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 9dc0bf0c5a6e..8c5cbd5942e3 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -97,6 +97,10 @@
 #define O_NDELAY	O_NONBLOCK
 #endif
 
+#ifndef O_ENCODED
+#define O_ENCODED	040000000
+#endif
+
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
 #define F_SETFD		2	/* set/clear close_on_exec */
-- 
2.23.0

