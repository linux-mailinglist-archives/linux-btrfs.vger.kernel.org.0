Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594673FE096
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Sep 2021 19:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344736AbhIARC3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Sep 2021 13:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345423AbhIARC1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Sep 2021 13:02:27 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5004C061760
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Sep 2021 10:01:30 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id e1so25983plt.11
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Sep 2021 10:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y9iz1c5kvfAlFb0XK67PiD8+iPNSn7y4pBIWpoLMm9I=;
        b=MOTiVasA/tz+vCW0/CmcQiDQYSr+ANvgNl9rOT31I7bypAyov/pEtGuKL/0mLs32X9
         tEm0R8pz65RTxC2GUc/NbNNlShQcfKRPJf/ISUBEHV+HnKHTw4zK2YkDO7qRQKanpJd1
         ZFEaJlyP/8faQ9w/+FaI6gunzNQ6nfRmD+IQvYzw0qKe5fS6YBT6DVonKmRRnd6UFTsU
         4NJqxULvhESWjqgHj3M7xXp2d3VdGr/eYyiipBYOf5d4zYXgJBQ3RUkkJ9iLKEfx6CLy
         igmRstrcYoFLl+2wLoQIxvPCGel0ZnntQLpUx2rcQAAhiTDUIynnNgvhB2SJXIxMnDpR
         3yow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y9iz1c5kvfAlFb0XK67PiD8+iPNSn7y4pBIWpoLMm9I=;
        b=cJZPWNcsna+QP/OqgA/0O0GW0I9/1oqshfr6XgLWJltpn9e9WIcW20O3js6qPf3oJW
         or3wbkq0IldnF+2EB6xLRRIdxUsVmpqLxZDEel2bWDaXbiKAkXAwQuoIfGTRa5S965uK
         7gs/fZCrcpWtaRwfINLFly5ixn90gl39iz0ic9MDePeHHTBrGJUm/eNjP7Sl/RiaN3TJ
         DaEuaZ+W9OcDBChVACcBxp+QsCXw0SFVmrs8GN1QQy6Cffmhdfdd9yevAXlYKMWwQjMb
         FBFq75LLSz5OcnWMYYxO151pPZvro0tm8Ryumqcmnzid7AcOae8M2TlfKGUydQIxub2j
         9sIg==
X-Gm-Message-State: AOAM532kF0/BG5Svs5Y6b0Q+5+9gwomhwJMDSXzsi0k9lyrIyC/q0fFy
        QW9lq7VOjlTKtZdsc9oZLNyI7Nujg4ujOQ==
X-Google-Smtp-Source: ABdhPJwuy0UwC3576wg4xw79Ac6xY+uoolWoTb/rWctuLpXqBZMhBG1RNGnxeSS8xWGZGV/wi12dAg==
X-Received: by 2002:a17:90a:ec0a:: with SMTP id l10mr334583pjy.26.1630515689937;
        Wed, 01 Sep 2021 10:01:29 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:a2b2])
        by smtp.gmail.com with ESMTPSA id y7sm58642pff.206.2021.09.01.10.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 10:01:29 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [PATCH v11 02/14] fs: export variant of generic_write_checks without iov_iter
Date:   Wed,  1 Sep 2021 10:00:57 -0700
Message-Id: <119d77ad1d63aac1c02e88d750e7e35721c67c97.1630514529.git.osandov@fb.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1630514529.git.osandov@fb.com>
References: <cover.1630514529.git.osandov@fb.com>
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

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/read_write.c    | 33 ++++++++++++++++++++-------------
 include/linux/fs.h |  1 +
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 0029ff2b0ca8..46b3dcff3b24 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1633,24 +1633,16 @@ int generic_write_check_limits(struct file *file, loff_t pos, loff_t *count)
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
@@ -1660,8 +1652,23 @@ ssize_t generic_write_checks(struct kiocb *iocb, struct iov_iter *from)
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
index 0de4d75339b9..3a2ff5306236 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3227,6 +3227,7 @@ extern int sb_min_blocksize(struct super_block *, int);
 extern int generic_file_mmap(struct file *, struct vm_area_struct *);
 extern int generic_file_readonly_mmap(struct file *, struct vm_area_struct *);
 extern ssize_t generic_write_checks(struct kiocb *, struct iov_iter *);
+extern int generic_write_checks_count(struct kiocb *iocb, loff_t *count);
 extern int generic_write_check_limits(struct file *file, loff_t pos,
 		loff_t *count);
 extern int generic_file_rw_checks(struct file *file_in, struct file *file_out);
-- 
2.33.0

