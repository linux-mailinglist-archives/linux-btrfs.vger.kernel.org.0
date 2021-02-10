Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9729C317315
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Feb 2021 23:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhBJWP0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Feb 2021 17:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbhBJWPW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Feb 2021 17:15:22 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF075C0613D6
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Feb 2021 14:14:41 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id o193so3374951qke.11
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Feb 2021 14:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mEHNIYeLl7iOw3nd1CdxJKtufXh4H/Rnl9mCb/QuHtg=;
        b=ct+AxeqwF+/RHWdDfJGyS9kDrNaThi0eX0ctTdnW461NS1Sr3J21GIju2bwetP40JM
         jnKRI7zqUkvdNO8apgm1nivD2I8HAsb1nVrWbf6/gzQ80Pca7AJCPvGEsb7jFxyHnzGi
         Vhv+rJQZMAZCeIaETfEPEQSiu3CxKg9EXQy8iYj9pUWAmKltVQj02CviCn76Y7+rZVbF
         aMI3U3j5Hz9biOtpvjgWSq0usuT9C9Ap+8PaMrH0Ij7O0UCB4qmy4kQmUxNLc4/26vgN
         AaXpRD0TBhvdvotnNrTCqN04gQoEb10oVnOWBFcizgK1sT9pbmCUO5N5xtYKw2cCChjI
         GQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mEHNIYeLl7iOw3nd1CdxJKtufXh4H/Rnl9mCb/QuHtg=;
        b=LM8SI0Qf/TA1ZE1MJd14wU9yTyY9hrmRf7PakvTIT+HupjfGsDMlNEDESUfbV5P+77
         imLzBCv1EBQERKqRJbSV5Uz8AYxV52r6HTzVz2YX+2gAh1tM73WGRUNOzMBiHhf2BfUz
         aYx6Rs3kitMzZaOqlmfr4XTrQfe0zx3o+vxuKXENi2gCprV71dBNdRw1B68nnvYQrh1F
         cH3f2K0fU2dfZYgTgxxv+t1rgt0t1JeIV9liMS4eUkZx7urV3h9Bexcin8CNIplrM7uL
         c9AxV0rPYJWtA2lcYMT+Z0yMVEaz8HsoXnMd7zeMniRlAQrCz5arFWMZnkAG//5QmEPp
         rZCw==
X-Gm-Message-State: AOAM533COv1OqJfH0HkqIwfpxJoJLQLZ1opehdJzh6Nsr+4aZ6R8riwa
        TrzyDMqFkIGGdwjIFDNlAtlku4qAKSbbDaoE
X-Google-Smtp-Source: ABdhPJzX+Pk3E3LhsZQFcK8TOgqmlGRPknuGu6HxbpchctfPkbj4bsUdpQfbl86m4P+syZo+qXRZXA==
X-Received: by 2002:a05:620a:959:: with SMTP id w25mr4673782qkw.345.1612995280705;
        Wed, 10 Feb 2021 14:14:40 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i5sm2458810qkg.32.2021.02.10.14.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 14:14:40 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2 1/4] btrfs: add a i_mmap_lock to our inode
Date:   Wed, 10 Feb 2021 17:14:33 -0500
Message-Id: <1963d741dfcd35e9585e1d7f96d1e45a44288125.1612995212.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1612995212.git.josef@toxicpanda.com>
References: <cover.1612995212.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We need to be able to exclude page_mkwrite from happening concurrently
with certain operations.  To facilitate this, add a i_mmap_lock to our
inode, down_read() it in our mkwrite, and add a new ILOCK flag to
indicate that we want to take the i_mmap_lock as well.  I used pahole to
check the size of the btrfs_inode, the sizes are as follows

no lockdep:
before: 1120 (3 per 4k page)
after: 1160 (3 per 4k page)

lockdep:
before: 2072 (1 per 4k page)
after: 2224 (1 per 4k page)

We're slightly larger but it doesn't change how many objects we can fit
per page.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/btrfs_inode.h |  1 +
 fs/btrfs/ctree.h       |  1 +
 fs/btrfs/inode.c       | 10 ++++++++++
 3 files changed, 12 insertions(+)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 28e202e89660..26837c3ca7f6 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -220,6 +220,7 @@ struct btrfs_inode {
 	/* Hook into fs_info->delayed_iputs */
 	struct list_head delayed_iput;
 
+	struct rw_semaphore i_mmap_lock;
 	struct inode vfs_inode;
 };
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 3bc00aed13b2..5a410c812978 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3174,6 +3174,7 @@ extern const struct iomap_dio_ops btrfs_dio_ops;
 /* Inode locking type flags, by default the exclusive lock is taken */
 #define BTRFS_ILOCK_SHARED	(1U << 0)
 #define BTRFS_ILOCK_TRY 	(1U << 1)
+#define BTRFS_ILOCK_MMAP	(1U << 2)
 
 int btrfs_inode_lock(struct inode *inode, unsigned int ilock_flags);
 void btrfs_inode_unlock(struct inode *inode, unsigned int ilock_flags);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 535abf898225..4c3ba0a3e0e6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -102,6 +102,7 @@ static void __endio_write_update_ordered(struct btrfs_inode *inode,
  * BTRFS_ILOCK_SHARED - acquire a shared lock on the inode
  * BTRFS_ILOCK_TRY - try to acquire the lock, if fails on first attempt
  *		     return -EAGAIN
+ * BTRFS_ILOCK_MMAP - acquire a write lock on the i_mmap_lock
  */
 int btrfs_inode_lock(struct inode *inode, unsigned int ilock_flags)
 {
@@ -122,6 +123,8 @@ int btrfs_inode_lock(struct inode *inode, unsigned int ilock_flags)
 		}
 		inode_lock(inode);
 	}
+	if (ilock_flags & BTRFS_ILOCK_MMAP)
+		down_write(&BTRFS_I(inode)->i_mmap_lock);
 	return 0;
 }
 
@@ -133,6 +136,8 @@ int btrfs_inode_lock(struct inode *inode, unsigned int ilock_flags)
  */
 void btrfs_inode_unlock(struct inode *inode, unsigned int ilock_flags)
 {
+	if (ilock_flags & BTRFS_ILOCK_MMAP)
+		up_write(&BTRFS_I(inode)->i_mmap_lock);
 	if (ilock_flags & BTRFS_ILOCK_SHARED)
 		inode_unlock_shared(inode);
 	else
@@ -8538,6 +8543,7 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 
 	ret = VM_FAULT_NOPAGE; /* make the VM retry the fault */
 again:
+	down_read(&BTRFS_I(inode)->i_mmap_lock);
 	lock_page(page);
 	size = i_size_read(inode);
 
@@ -8566,6 +8572,7 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 		unlock_extent_cached(io_tree, page_start, page_end,
 				     &cached_state);
 		unlock_page(page);
+		up_read(&BTRFS_I(inode)->i_mmap_lock);
 		btrfs_start_ordered_extent(ordered, 1);
 		btrfs_put_ordered_extent(ordered);
 		goto again;
@@ -8623,6 +8630,7 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	BTRFS_I(inode)->last_log_commit = BTRFS_I(inode)->root->last_log_commit;
 
 	unlock_extent_cached(io_tree, page_start, page_end, &cached_state);
+	up_read(&BTRFS_I(inode)->i_mmap_lock);
 
 	btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE);
 	sb_end_pagefault(inode->i_sb);
@@ -8631,6 +8639,7 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 
 out_unlock:
 	unlock_page(page);
+	up_read(&BTRFS_I(inode)->i_mmap_lock);
 out:
 	btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE);
 	btrfs_delalloc_release_space(BTRFS_I(inode), data_reserved, page_start,
@@ -8882,6 +8891,7 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	INIT_LIST_HEAD(&ei->delalloc_inodes);
 	INIT_LIST_HEAD(&ei->delayed_iput);
 	RB_CLEAR_NODE(&ei->rb_node);
+	init_rwsem(&ei->i_mmap_lock);
 
 	return inode;
 }
-- 
2.26.2

