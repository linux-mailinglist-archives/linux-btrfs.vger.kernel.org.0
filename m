Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D8A2D81B5
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Dec 2020 23:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406156AbgLKWNj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Dec 2020 17:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406172AbgLKWNg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Dec 2020 17:13:36 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE142C0613CF
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Dec 2020 14:12:55 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id u21so7632397qtw.11
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Dec 2020 14:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M/glmiomu31aJFMF74vOG+5pIqcrzr8R+gVSjN7brAw=;
        b=pLw8eJFFdYVM+Iu79HDpSq8ZPL+ERBok0aw6aNhsXYWEF2ZhqFPHyTVeXJoLjjudtj
         z04HxF443QRJ9d7NcUFcl4w723b1qB4Jt2Fy9LJOesRLoPK4pywe/XD6mVdWPmH6kPGN
         DsoO6qSmvYJHeivcyWOD22xhJwNtqTbrAZ9IwAg8N+EgEJkli8OPVooFT7VybqbSby+A
         LrYLV7v4NSszYAjgkLzD5ZDu0DCib8+c/PAPy+VpLCksefxvK8J8vJ5pZKPdTxDM6Dbz
         kx8AJ9ybefq9ZSe0AB6DfKkjgRMtWyNguJG3acV9NunIwl51a5QutX0f8ikT3ottvYm+
         oY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M/glmiomu31aJFMF74vOG+5pIqcrzr8R+gVSjN7brAw=;
        b=XXIraZ0vescoOdDu9EIrUcYzc4TIdvG/5bGKpSKEu8oeGYEhrK69n5Baph/fAtfwh2
         dfk1v+RVaMrKtpuNNLgxwvMMY9MLrW6xHMKNhYLFUBF6OUdExtiF4BYGS/y7rxnRkvgS
         YXKEzL10/YnNDxCpAihYNq7mmnnwE0+8Dp035shR9dm/hCvwaHhQ4zBad3ZFEG58neb7
         SMksUt19eKe0NlBd+QKIm6Shlfy3xfQqcboHsSkcJDBs2ksM/VMhWiIKF0oSG8SRaD7h
         yeQlk26KNd3hzxuaOQNmfwiqGPSOfsYfNgr+JYIsgoHrXn7uIg5i0/f+gkr4b8orSEPb
         pzkg==
X-Gm-Message-State: AOAM530jWnqvT4xB1WAYlah56PopnIErjgq114p4iWDBNUmjEPLGMJyh
        bjw5RQY/t+AaMU5YDZyzxAwTDCMLUCE0zXbb
X-Google-Smtp-Source: ABdhPJx/jMC936xl+qQZgkUimLgq4e7DaiKpJi4eyBkflFXI59yg5N+vGi05RceDCymkS+aynwhHDw==
X-Received: by 2002:ac8:670e:: with SMTP id e14mr17930446qtp.68.1607724773845;
        Fri, 11 Dec 2020 14:12:53 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z125sm8686298qke.18.2020.12.11.14.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 14:12:53 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH][RFC] btrfs: fix race between dedupe and mmap
Date:   Fri, 11 Dec 2020 17:12:52 -0500
Message-Id: <afdc2109f83fff1a925d7a66a6a047d4400721d4.1607724668.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Darrick asked how btrfs currently protects against mmap modifying a page
during dedupe, and when I checked I realized it doesn't.  Previously we
did the following dance

lock page ranges in both files
  lock extent
    flush ordered
      validate pages are the same
        dedupe

However Filipe moved us to use the generic checks, which instead does
this dance

lock inode
  flush everything, check for ordered extents
  lock page in both corresponding inodes
    validate pages are the same
  unlock pages
  lock extent
  dedupe

The problem here is we're not doing our normal page lock -> extent lock
-> validate check.  The generic checks assume we've blocked everybody
from modifying the file, which we have with the exception of mmap.

There are two ways we can fix this, and I've chosen the simplest.

The more complicated way is to add a flag to the generic checks to tell
it that we'll do the page verification ourselves.  Then we add back the
checks to btrfs_extent_same() to do the proper lock ordering in order to
validate the pages.

The simpler way to do this is to simply add a mechanism to block mmap
from happening while we're doing dedupe.  I've opted for this strategy,
because it's more straightforward and allows us to continue using the
generic infrastructure.

Ext4 and xfs do not have this problem because they have an inode lock
that they use to block mmap from happening, the i_mmap_sem in ext4's
case and the ilock for xfs.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
This is an RFC because there's two clear ways to fix this, and I'm not really
married to either solution.  This is the solution I coded because it involves
only touching Btrfs, which may be better for pushing out first to backport to
stable.  The other solution is obviously to make the generic code skip the
verification and do it ourselves in btrfs_extent_same().  If we want to do that
instead I'll rework this patch to do it that way.

 fs/btrfs/btrfs_inode.h | 33 +++++++++++++++++++++++++++++++++
 fs/btrfs/inode.c       | 15 +++++++++++++++
 fs/btrfs/reflink.c     | 31 +++++++++++++++++++++++++++----
 3 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index d9bf53d9ff90..2cadefb3736e 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -51,6 +51,17 @@ enum {
 	 * the file range, inode's io_tree).
 	 */
 	BTRFS_INODE_NO_DELALLOC_FLUSH,
+	/*
+	 * Set when we are dedupe'ing a file in order to block any mmap writes
+	 * from occurring.  This is because we use the generic checking to
+	 * validate that the pages are the same, but we do not have the extent
+	 * locked at this point to block mmaps.  The trade-off of using the
+	 * generic code is we need a separate mechanism to block mmaps in this
+	 * case, otherwise we could race and modify pages in between checking if
+	 * the pages are the same and locking the extents to do the
+	 * deduplication.
+	 */
+	BTRFS_INODE_DEDUPE,
 };
 
 /* in memory btrfs inode */
@@ -299,6 +310,28 @@ static inline void btrfs_mod_outstanding_extents(struct btrfs_inode *inode,
 						  mod);
 }
 
+static inline void btrfs_inode_dedupe(struct btrfs_inode *inode)
+{
+	set_bit(BTRFS_INODE_DEDUPE, &inode->runtime_flags);
+}
+
+static inline int btrfs_inode_dedupe_wait(struct btrfs_inode *inode)
+{
+	return wait_on_bit(&inode->runtime_flags, BTRFS_INODE_DEDUPE,
+			   TASK_INTERRUPTIBLE);
+}
+
+static inline void btrfs_inode_dedupe_done(struct btrfs_inode *inode)
+{
+	clear_bit(BTRFS_INODE_DEDUPE, &inode->runtime_flags);
+	/*
+	 * This is necessary because clear_bit doesn't imply a memory barrier,
+	 * and we need the memory barrier for wake_up_bit().
+	 */
+	smp_mb__after_atomic();
+	wake_up_bit(&inode->runtime_flags, BTRFS_INODE_DEDUPE);
+}
+
 static inline int btrfs_inode_in_log(struct btrfs_inode *inode, u64 generation)
 {
 	int ret = 0;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7a8d89e1b73f..85f85649c011 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8348,7 +8348,22 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 
 	ret = VM_FAULT_NOPAGE; /* make the VM retry the fault */
 again:
+	/* We must wait on dedupes to complete. */
+	if (btrfs_inode_dedupe_wait(BTRFS_I(inode)))
+		goto out;
 	lock_page(page);
+
+	/*
+	 * If we raced and dedupe got set before we locked then we need to retry.
+	 * If dedup comes in after this point we're OK because the verification
+	 * step must lock this page for the filemap_flush(), so we will block
+	 * that step of the dedup until we exit mkwrite, at which point we will
+	 * be written out and marked clean again.
+	 */
+	if (test_bit(BTRFS_INODE_DEDUPE, &BTRFS_I(inode)->runtime_flags)) {
+		unlock_page(page);
+		goto again;
+	}
 	size = i_size_read(inode);
 
 	if ((page->mapping != inode->i_mapping) ||
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index b03e7891394e..5f4a806c445c 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -815,10 +815,26 @@ loff_t btrfs_remap_file_range(struct file *src_file, loff_t off,
 	if (remap_flags & ~(REMAP_FILE_DEDUP | REMAP_FILE_ADVISORY))
 		return -EINVAL;
 
-	if (same_inode)
+	/*
+	 * We use btrfs_inode_dedup here to block concurrent mmaps during dedup.
+	 * We do this because we use the generic helpers to validate that the
+	 * ranges are indeed the same, however the appropriate locking is not
+	 * done which makes it racy for us.  The alternative is to stop using
+	 * the generic checks and do the pages are the same checks internally
+	 * inside btrfs, but since mmap is the only issue here simply block
+	 * concurrent mmaps.
+	 */
+	if (same_inode) {
 		inode_lock(src_inode);
-	else
+		if (remap_flags & REMAP_FILE_DEDUP)
+			btrfs_inode_dedupe(BTRFS_I(src_inode));
+	} else {
 		lock_two_nondirectories(src_inode, dst_inode);
+		if (remap_flags & REMAP_FILE_DEDUP) {
+			btrfs_inode_dedupe(BTRFS_I(src_inode));
+			btrfs_inode_dedupe(BTRFS_I(dst_inode));
+		}
+	}
 
 	ret = btrfs_remap_file_range_prep(src_file, off, dst_file, destoff,
 					  &len, remap_flags);
@@ -831,10 +847,17 @@ loff_t btrfs_remap_file_range(struct file *src_file, loff_t off,
 		ret = btrfs_clone_files(dst_file, src_file, off, len, destoff);
 
 out_unlock:
-	if (same_inode)
+	if (same_inode) {
 		inode_unlock(src_inode);
-	else
+		if (remap_flags & REMAP_FILE_DEDUP)
+			btrfs_inode_dedupe_done(BTRFS_I(src_inode));
+	} else {
 		unlock_two_nondirectories(src_inode, dst_inode);
+		if (remap_flags & REMAP_FILE_DEDUP) {
+			btrfs_inode_dedupe_done(BTRFS_I(src_inode));
+			btrfs_inode_dedupe_done(BTRFS_I(dst_inode));
+		}
+	}
 
 	return ret < 0 ? ret : len;
 }
-- 
2.26.2

