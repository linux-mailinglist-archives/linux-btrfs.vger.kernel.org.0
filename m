Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24BD2B8497
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Nov 2020 20:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgKRTSm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 14:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbgKRTSm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 14:18:42 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE7AC0613D6
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Nov 2020 11:18:41 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id 81so1882685pgf.0
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Nov 2020 11:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m7uYqXPNxmB3NJk85TLjUTUGKHsEBU0JHVgTNlvuKfk=;
        b=MEITxHKBEVp5VQOUtUnxBIxrhvNItdX+33pUOiZv7z+jsw0CJ0zx30t92E7hiP05Cy
         Rg4W/lFeFgZengS8oq3sVWns2X6IYBgxP5o7aKoKqrp6zGFxKiW3To02WsasxS79RsfX
         0vqLnbZ2hE004FFjJSvjJTQEHFV/JIh4wkrGdUUTztYX6sSxX/XydQFu3xXKNQz+KOko
         H8lDqC775NEg4YWx20VLawXI/Kag65sC/Z7eE+kNd1Jj+QclJJzq5kzUX1EDlwubsGze
         qHZUzRuaCQHuhYRz3RF1dsn1IztM6xOrIG9OWjbSNvYjKiNK/+g7ke/B36lxZ0pnBIaj
         fFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m7uYqXPNxmB3NJk85TLjUTUGKHsEBU0JHVgTNlvuKfk=;
        b=t4gd/XzVbc6V2UAFYX8NTM2L/edoPyitaBz2dcDICljFAkWjf1wUIwAeZd0N+61bkb
         wwMlmwL3Ha9wfI8fGzMxLBj6f8AK2cN8Q/5dwy8z0/o2av80+5nc/FNKmyEV4tJx2+1S
         +yTQ1nK5V5R84dfKffwgwqbAYBkKfa+vOjiKBHm1K4kCiP6vcdcfrSDbiFnKzRCdJYYv
         xFlyNMcuIba06gj0Igk1mC1i/kRgPmVjVpCqLIYio3lXqJK7gNyNx4cXTd6Aw4MAk3p6
         eodAofxt2yx5bcpaePsnscQ/JJd0D4Y2fDZBR4z8EjnmhcfW2iEi9l6EDSsSahJL6SA9
         5PTw==
X-Gm-Message-State: AOAM530AMR/6aGIWgSyY3WP2uQwTX7dozUQiee7SlqxbHkT9Y8Gh8O9t
        QN1Je+GnaN01TVAJIIKSXE8YuQ==
X-Google-Smtp-Source: ABdhPJxRmGhnAdEblWauTa3klfdsSMqiSeTacprWs3MefG3RQwxUWrLRO1LNmuoC8/sMagh0dN8LgA==
X-Received: by 2002:a17:90a:a891:: with SMTP id h17mr505257pjq.149.1605727121477;
        Wed, 18 Nov 2020 11:18:41 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:8b43])
        by smtp.gmail.com with ESMTPSA id c22sm19491863pfo.211.2020.11.18.11.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 11:18:40 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v6 04/11] btrfs: fix btrfs_write_check()
Date:   Wed, 18 Nov 2020 11:18:11 -0800
Message-Id: <b096cecce8277b30e1c7e26efd0450c0bc12ff31.1605723568.git.osandov@fb.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605723568.git.osandov@fb.com>
References: <cover.1605723568.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

btrfs_write_check() has two related bugs:

1. It gets the iov_iter count before calling generic_write_checks(), but
   generic_write_checks() may truncate the iov_iter.
2. It returns the count or negative errno as a size_t, which the callers
   cast to an int. If the count is greater than INT_MAX, this overflows.

To fix both of these, pull the call to generic_write_checks() out of
btrfs_write_check(), use the new iov_iter count returned from
generic_write_checks(), and have btrfs_write_check() return 0 or a
negative errno as an int instead of the count. This rearrangement also
paves the way for RWF_ENCODED write support.

Fixes: f945968ff64c ("btrfs: introduce btrfs_write_check()")
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/file.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index d217b739b164..7225b63b62a9 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1583,21 +1583,17 @@ static void update_time_for_write(struct inode *inode)
 		inode_inc_iversion(inode);
 }
 
-static size_t btrfs_write_check(struct kiocb *iocb, struct iov_iter *from)
+static int btrfs_write_check(struct kiocb *iocb, struct iov_iter *from,
+			     size_t count)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	loff_t pos = iocb->ki_pos;
-	size_t count = iov_iter_count(from);
 	int err;
 	loff_t oldsize;
 	loff_t start_pos;
 
-	err = generic_write_checks(iocb, from);
-	if (err <= 0)
-		return err;
-
 	if (iocb->ki_flags & IOCB_NOWAIT) {
 		size_t nocow_bytes = count;
 
@@ -1639,7 +1635,7 @@ static size_t btrfs_write_check(struct kiocb *iocb, struct iov_iter *from)
 		}
 	}
 
-	return count;
+	return 0;
 }
 
 static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
@@ -1656,7 +1652,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 	u64 lockend;
 	size_t num_written = 0;
 	int nrptrs;
-	int ret = 0;
+	ssize_t ret;
 	bool only_release_metadata = false;
 	bool force_page_uptodate = false;
 	loff_t old_isize = i_size_read(inode);
@@ -1669,10 +1665,14 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 	if (ret < 0)
 		return ret;
 
-	ret = btrfs_write_check(iocb, i);
+	ret = generic_write_checks(iocb, i);
 	if (ret <= 0)
 		goto out;
 
+	ret = btrfs_write_check(iocb, i, ret);
+	if (ret < 0)
+		goto out;
+
 	pos = iocb->ki_pos;
 	nrptrs = min(DIV_ROUND_UP(iov_iter_count(i), PAGE_SIZE),
 			PAGE_SIZE / (sizeof(struct page *)));
@@ -1904,7 +1904,7 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	ssize_t written = 0;
 	ssize_t written_buffered;
 	loff_t endbyte;
-	int err;
+	ssize_t err;
 	unsigned int ilock_flags = 0;
 	struct iomap_dio *dio = NULL;
 
@@ -1920,8 +1920,14 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	if (err < 0)
 		return err;
 
-	err = btrfs_write_check(iocb, from);
+	err = generic_write_checks(iocb, from);
 	if (err <= 0) {
+		btrfs_inode_unlock(inode, ilock_flags);
+		return err;
+	}
+
+	err = btrfs_write_check(iocb, from, err);
+	if (err < 0) {
 		btrfs_inode_unlock(inode, ilock_flags);
 		goto out;
 	}
-- 
2.29.2

