Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A734B15F3
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 20:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343721AbiBJTKc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 14:10:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343710AbiBJTKb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 14:10:31 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61F210BA
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:32 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id c5-20020a17090a1d0500b001b904a7046dso8012377pjd.1
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uOABk8mNzBKfgcWHyLCqTK+OXP9+oV+Aq9izhbHg64Q=;
        b=V0p1ePfjpZ7FSs49PS6VmQzcdHMQoEK0IXwS6Yjox3GLNfNM8Hzil+TvU5a6JTmBjd
         Ygo5B6xmzYd0yO89/z4p+yR8Ge+DFwTD+C9mBaks2yx12erVU5PFqqvKCeLsKXJxpYRX
         6U3IYt4pT16djU3ZzrvgEVE8KURXLbN3cm1dsBNSOCV3ZDzRtPOLjjk0EeyYppAF+dK3
         +WeecVq8FnpUTEYEK0qcBO01JCagsmVehBDI7HL/TzImXWwcHNYyovKLd922G+e2FYKQ
         3ESV4D6Ft+2z2nqibN6BgWCjufs1BRI3T7uHTvgP7P5qI80WYTL+t25BzTiY6u4bCTE1
         IN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uOABk8mNzBKfgcWHyLCqTK+OXP9+oV+Aq9izhbHg64Q=;
        b=EHlEiYRnBHulJfNVwOakWIqSypBwMFMjNJvH5ukoodFQ5yyIfPhOFUvWmTwqqRaDPw
         AktVbqOdP6hcy9R51QneiM8C1YwtGurGJBewWgCwK+cudrnIAH80uPHIFWTiUR419xKf
         KrhUu5IDy3Ovc69056cRlMOD5qcbEUB3p1bMPBIZ+kUKTYIXakCOlUss/lpr/1zEqsBb
         SOiEllhln8vuxgEbRLBNKgQjYiNwKMOLvBh++iB6tr8bn2xLwz6bL7W9mP+w4GwdPOs9
         8Ue0mQ8nZKjbU8YK9g7ZWewIGDLLdF9bzIB3BBKPCPuw2E8D09QIkTnAI0CQ0Xe32FYn
         6XgQ==
X-Gm-Message-State: AOAM530GMv78UUf+G5LxzNEKtF9JKtiCJH6kPYQ/YVmJQqLV43hptbCe
        9JBnb2CUHaFCGLhZIZxouy+ghdU6nfUGvQ==
X-Google-Smtp-Source: ABdhPJw0oMLy3q5Y5HJpwHL0N5ip3O/txBx8ukVa2+JFPlbV6SPwf0bkSFylYQD1772PRWonC8RwDA==
X-Received: by 2002:a17:902:ce02:: with SMTP id k2mr5463858plg.93.1644520231898;
        Thu, 10 Feb 2022 11:10:31 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:1975])
        by smtp.gmail.com with ESMTPSA id n5sm8315898pgt.22.2022.02.10.11.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 11:10:31 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v13 02/17] fs: export variant of generic_write_checks without iov_iter
Date:   Thu, 10 Feb 2022 11:09:52 -0800
Message-Id: <f4ce2d153924ddc34fc46494332fdf92cf8cccf6.1644519257.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1644519257.git.osandov@fb.com>
References: <cover.1644519257.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 4deb42c326ba..ce5aabb609cd 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3130,6 +3130,7 @@ extern int sb_min_blocksize(struct super_block *, int);
 extern int generic_file_mmap(struct file *, struct vm_area_struct *);
 extern int generic_file_readonly_mmap(struct file *, struct vm_area_struct *);
 extern ssize_t generic_write_checks(struct kiocb *, struct iov_iter *);
+extern int generic_write_checks_count(struct kiocb *iocb, loff_t *count);
 extern int generic_write_check_limits(struct file *file, loff_t pos,
 		loff_t *count);
 extern int generic_file_rw_checks(struct file *file_in, struct file *file_out);
-- 
2.35.1

