Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B8C2D9ED2
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Dec 2020 19:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440725AbgLNSUa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Dec 2020 13:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440718AbgLNSU0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Dec 2020 13:20:26 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84964C0613D6
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Dec 2020 10:19:46 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id c14so12566902qtn.0
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Dec 2020 10:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wdcl2xtzih8VI306oUh2SKwkge0xZ3P7J5fl8vyUtg0=;
        b=v8UskHRW9OMgP6TmR2CiH+wYWaK0JyNt2PdGo7cJlaVXzOGT4q55wMXmIbuUsk9gsg
         SSV9oMLBNr5S7ZMnTqENCD9TH3qL0xy4qZDL+uoy622sEWocVV8B1WGpd1EyFRslGZhS
         sSvNEBEbRLvOAx6X2HpJblFPYsQx3zkw7KtHFdQFLSmS85xYHOFO0sGG7VRa1MzKf3xC
         NNpZlbq24SfvKIhS1NyRfcJQ/UT4YR4ASq/Uugj4gvx1jbNKyr6gXttkI19bcMcJg39y
         n/kEyInvBCMrgKYEPLztUlNzNwakMSGkQiioVAcNCeKlAJLkLklmNOS24R6yNQWUG968
         lE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wdcl2xtzih8VI306oUh2SKwkge0xZ3P7J5fl8vyUtg0=;
        b=YsA8gHZyGHx7c/dmMTel47WhGn0z04v6KiIIWIoRHbqPHZteL1k7+agPF5iGkuUrK2
         wCQrSn8ghdLB0c+A2ToZGP80q/lYbHsWm378ebC8J1rENhlDuYaehNpokZOnZSrwrZPr
         KlI3h1AGRjxbse7wa5v2rZr3k4NcM5qDLcN1Xdyn73tGiRg65z141RjlvTgrSovdR5gS
         SMB0Z9oNpmQZlrsnTQDh1fU29q9KgbC4Lc2IN+Jbsxt30mUTJNRooCloDLGhGV6V9BxX
         ewdyPlPWXDoyg1NqpIAV1ipB1xcA4xUUpMrLaajTJAQbOAdaFEIUH2+w3rmVyBIo7ZJU
         lzKA==
X-Gm-Message-State: AOAM5315oX8xaUW/hsHupNHiU4h0eo9EJU9KUPQjpVXk1QmdfIBgDRrR
        SS3+gl6BtV2G2vEj9ygxyIaFHOIWUQRSoZgS
X-Google-Smtp-Source: ABdhPJyzz9VyeBpXimytqfzuBFyNm7TcYt+hIpTd7ZEyxmajfKpHOdOJqb9GqHBcOXA2CiEZSM2pjQ==
X-Received: by 2002:a05:622a:182:: with SMTP id s2mr31650704qtw.147.1607969985349;
        Mon, 14 Dec 2020 10:19:45 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w7sm15271756qkd.92.2020.12.14.10.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 10:19:44 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/4] btrfs: add a i_mmap_lock to our inode
Date:   Mon, 14 Dec 2020 13:19:38 -0500
Message-Id: <7322b31fb9e7a2c27b9fbca528904c163997ffa9.1607969636.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607969636.git.josef@toxicpanda.com>
References: <cover.1607969636.git.josef@toxicpanda.com>
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

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/btrfs_inode.h |  1 +
 fs/btrfs/ctree.h       |  1 +
 fs/btrfs/inode.c       | 10 ++++++++++
 3 files changed, 12 insertions(+)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index d9bf53d9ff90..66cec5c13396 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -220,6 +220,7 @@ struct btrfs_inode {
 	/* Hook into fs_info->delayed_iputs */
 	struct list_head delayed_iput;
 
+	struct rw_semaphore i_mmap_lock;
 	struct inode vfs_inode;
 };
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 3935d297d198..e2bebb3318cc 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3147,6 +3147,7 @@ extern const struct iomap_dio_ops btrfs_dio_ops;
 /* Inode locking type flags, by default the exclusive lock is taken */
 #define BTRFS_ILOCK_SHARED	(1U << 0)
 #define BTRFS_ILOCK_TRY 	(1U << 1)
+#define BTRFS_ILOCK_MMAP	(1U << 2)
 
 int btrfs_inode_lock(struct inode *inode, unsigned int ilock_flags);
 void btrfs_inode_unlock(struct inode *inode, unsigned int ilock_flags);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 070716650df8..a5ee4d45ee02 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -101,6 +101,7 @@ static void __endio_write_update_ordered(struct btrfs_inode *inode,
  * BTRFS_ILOCK_SHARED - acquire a shared lock on the inode
  * BTRFS_ILOCK_TRY - try to acquire the lock, if fails on first attempt
  *		     return -EAGAIN
+ * BTRFS_ILOCK_MMAP - acquire a write lock on the i_mmap_lock
  */
 int btrfs_inode_lock(struct inode *inode, unsigned int ilock_flags)
 {
@@ -121,6 +122,8 @@ int btrfs_inode_lock(struct inode *inode, unsigned int ilock_flags)
 		}
 		inode_lock(inode);
 	}
+	if (ilock_flags & BTRFS_ILOCK_MMAP)
+		down_write(&BTRFS_I(inode)->i_mmap_lock);
 	return 0;
 }
 
@@ -132,6 +135,8 @@ int btrfs_inode_lock(struct inode *inode, unsigned int ilock_flags)
  */
 void btrfs_inode_unlock(struct inode *inode, unsigned int ilock_flags)
 {
+	if (ilock_flags & BTRFS_ILOCK_MMAP)
+		up_write(&BTRFS_I(inode)->i_mmap_lock);
 	if (ilock_flags & BTRFS_ILOCK_SHARED)
 		inode_unlock_shared(inode);
 	else
@@ -8344,6 +8349,7 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 
 	ret = VM_FAULT_NOPAGE; /* make the VM retry the fault */
 again:
+	down_read(&BTRFS_I(inode)->i_mmap_lock);
 	lock_page(page);
 	size = i_size_read(inode);
 
@@ -8367,6 +8373,7 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 		unlock_extent_cached(io_tree, page_start, page_end,
 				     &cached_state);
 		unlock_page(page);
+		up_read(&BTRFS_I(inode)->i_mmap_lock);
 		btrfs_start_ordered_extent(ordered, 1);
 		btrfs_put_ordered_extent(ordered);
 		goto again;
@@ -8424,6 +8431,7 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	BTRFS_I(inode)->last_log_commit = BTRFS_I(inode)->root->last_log_commit;
 
 	unlock_extent_cached(io_tree, page_start, page_end, &cached_state);
+	up_read(&BTRFS_I(inode)->i_mmap_lock);
 
 	btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE);
 	sb_end_pagefault(inode->i_sb);
@@ -8432,6 +8440,7 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 
 out_unlock:
 	unlock_page(page);
+	up_read(&BTRFS_I(inode)->i_mmap_lock);
 out:
 	btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE);
 	btrfs_delalloc_release_space(BTRFS_I(inode), data_reserved, page_start,
@@ -8680,6 +8689,7 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	INIT_LIST_HEAD(&ei->delalloc_inodes);
 	INIT_LIST_HEAD(&ei->delayed_iput);
 	RB_CLEAR_NODE(&ei->rb_node);
+	init_rwsem(&ei->i_mmap_lock);
 
 	return inode;
 }
-- 
2.26.2

