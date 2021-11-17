Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4ACB454E61
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Nov 2021 21:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239482AbhKQUXH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Nov 2021 15:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239434AbhKQUXC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Nov 2021 15:23:02 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FECC061570
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:03 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id bu11so2959401qvb.0
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/XGzVuim02psWU08/3cLBhWlbJSU0KoiFU34gYkJx0g=;
        b=6vAtGrpYVz7rJviUpZuRQnzXmIuRL54QcGpYYkTLAlQPJiqpzsHhoDGH4mxuPPCqrZ
         cKzUWj0kbO0pLOdEJIW1jmSWpJQhF7msH190DofUVipBxTRBkFDLrNyJMd3ok/cU3yH3
         fo5Y5CgqwC/32cDV75FvtnuLdeLILOBTT1c9BgkcJjmJAF4HCSkrEFSc2PtToL+dshl/
         Ev/MMFa3dszxvdpDRep6UsO6NB8y9ggGui3ejOizEd+rLKNwxdj8KL0JuIY4hDS0L0pY
         QmfKs0vV7knwp8Sh4fPTg8rfmGoaIgQYUghgZm/0pYEQ7lzkL0Hfg63glqwOnDErQ7ag
         0Xcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/XGzVuim02psWU08/3cLBhWlbJSU0KoiFU34gYkJx0g=;
        b=LoR2QFGNPXs6gxhYJT5NukR5OX+JlNnlVv5DPgxPiinGxIZpBmG2HTmNWqQHB4WJzT
         wBfFT26oba71KJgG4NUE3heCLp8g7VAFae74WluzGFocflM0LO4i5R7fkNQELuG1lalZ
         ydo5/3nnsPHVZdA5ewuf4aNG0ja57aBNCh7dgFVWxaCxu+L+q0UtHvZf+oetn4ylgPz1
         N55k4Tdhd1hai9fXaSq/VQSYrdMPbK7+S0tWIC+CzS1PD2brB2pvZ8LOVIM3QkYhr85C
         3LHPfKEorc8ctTwP97e4pRLaL/jOsHaa2xR5WlXAaapz4VsGrJo3rB/NpYhziKOfc2h5
         K3Gg==
X-Gm-Message-State: AOAM530VuxFflym0yxQRisJKHzDuyd2BJHePHKMBBZ+vZIAurJveEWtc
        4hqUyN46iYkbeZPBIqKVjy7na7F14dYn2g==
X-Google-Smtp-Source: ABdhPJw1ISYEQ5gZ1/0+g3rxWkESzUBSRG6YAERm1IUyuTqXbfwR5NpzmabTRcYnBT2/aBc5I2e/qQ==
X-Received: by 2002:a05:6214:1ccb:: with SMTP id g11mr51610270qvd.31.1637180402768;
        Wed, 17 Nov 2021 12:20:02 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c091:480::1:153e])
        by smtp.gmail.com with ESMTPSA id bj1sm438074qkb.75.2021.11.17.12.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 12:20:02 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v12 02/17] fs: export variant of generic_write_checks without iov_iter
Date:   Wed, 17 Nov 2021 12:19:12 -0800
Message-Id: <6116cb20426370265251d18f2ccfbd7632bb5462.1637179348.git.osandov@fb.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <cover.1637179348.git.osandov@fb.com>
References: <cover.1637179348.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Encoded I/O in Btrfs needs to check a write with a given logical size
without an iov_iter that matches that size (because the iov_iter we have
is for the compressed data). So, factor out the parts of
generic_write_check() that don't need an iov_iter into a new
generic_write_checks_count() function and export that.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/read_write.c    | 33 ++++++++++++++++++++-------------
 include/linux/fs.h |  1 +
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 4d60146243df..dc5000173b80 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1618,24 +1618,16 @@ int generic_write_check_limits(struct file *file, loff_t pos, loff_t *count)
 	return 0;
 }
 
-/*
- * Performs necessary checks before doing a write
- *
- * Can adjust writing position or amount of bytes to write.
- * Returns appropriate error code that caller should return or
- * zero in case that write should be allowed.
- */
-ssize_t generic_write_checks(struct kiocb *iocb, struct iov_iter *from)
+/* Like generic_write_checks(), but takes size of write instead of iter. */
+int generic_write_checks_count(struct kiocb *iocb, loff_t *count)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_mapping->host;
-	loff_t count;
-	int ret;
 
 	if (IS_SWAPFILE(inode))
 		return -ETXTBSY;
 
-	if (!iov_iter_count(from))
+	if (!*count)
 		return 0;
 
 	/* FIXME: this is for backwards compatibility with 2.4 */
@@ -1645,8 +1637,23 @@ ssize_t generic_write_checks(struct kiocb *iocb, struct iov_iter *from)
 	if ((iocb->ki_flags & IOCB_NOWAIT) && !(iocb->ki_flags & IOCB_DIRECT))
 		return -EINVAL;
 
-	count = iov_iter_count(from);
-	ret = generic_write_check_limits(file, iocb->ki_pos, &count);
+	return generic_write_check_limits(iocb->ki_filp, iocb->ki_pos, count);
+}
+EXPORT_SYMBOL(generic_write_checks_count);
+
+/*
+ * Performs necessary checks before doing a write
+ *
+ * Can adjust writing position or amount of bytes to write.
+ * Returns appropriate error code that caller should return or
+ * zero in case that write should be allowed.
+ */
+ssize_t generic_write_checks(struct kiocb *iocb, struct iov_iter *from)
+{
+	loff_t count = iov_iter_count(from);
+	int ret;
+
+	ret = generic_write_checks_count(iocb, &count);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 364940c6a299..368d537409ab 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3201,6 +3201,7 @@ extern int sb_min_blocksize(struct super_block *, int);
 extern int generic_file_mmap(struct file *, struct vm_area_struct *);
 extern int generic_file_readonly_mmap(struct file *, struct vm_area_struct *);
 extern ssize_t generic_write_checks(struct kiocb *, struct iov_iter *);
+extern int generic_write_checks_count(struct kiocb *iocb, loff_t *count);
 extern int generic_write_check_limits(struct file *file, loff_t pos,
 		loff_t *count);
 extern int generic_file_rw_checks(struct file *file_in, struct file *file_out);
-- 
2.34.0

