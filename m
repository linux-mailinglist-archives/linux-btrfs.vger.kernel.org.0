Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A3F203C62
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jun 2020 18:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbgFVQUq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Jun 2020 12:20:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:46370 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729484AbgFVQUp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Jun 2020 12:20:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4CB97C220;
        Mon, 22 Jun 2020 16:20:43 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 7/8] btrfs: Remove dio_sem
Date:   Mon, 22 Jun 2020 11:20:16 -0500
Message-Id: <20200622162017.21773-8-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200622162017.21773-1-rgoldwyn@suse.de>
References: <20200622162017.21773-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Since we handle all synchronization using inode_lock()/unlock(), we
don't need dio_sem to handle the race with btrfs_sync_file()

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/btrfs_inode.h | 10 ----------
 fs/btrfs/file.c        | 14 --------------
 fs/btrfs/inode.c       |  1 -
 3 files changed, 25 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index aeff56a0e105..86c5482e0fdd 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -187,16 +187,6 @@ struct btrfs_inode {
 	/* Hook into fs_info->delayed_iputs */
 	struct list_head delayed_iput;
 
-	/*
-	 * To avoid races between lockless (i_mutex not held) direct IO writes
-	 * and concurrent fsync requests. Direct IO writes must acquire read
-	 * access on this semaphore for creating an extent map and its
-	 * corresponding ordered extent. The fast fsync path must acquire write
-	 * access on this semaphore before it collects ordered extents and
-	 * extent maps.
-	 */
-	struct rw_semaphore dio_sem;
-
 	struct inode vfs_inode;
 };
 
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index c446a4aeb867..c8127406fcc6 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1984,10 +1984,8 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	if (is_sync_kiocb(iocb))
 		flags |= IOMAP_DIOF_WAIT_FOR_COMPLETION;
 
-	down_read(&BTRFS_I(inode)->dio_sem);
 	written = iomap_dio_rw(iocb, from, &btrfs_dio_iomap_ops, &btrfs_dops,
 			       flags);
-	up_read(&BTRFS_I(inode)->dio_sem);
 
 	if (written < 0 || !iov_iter_count(from)) {
 		err = written;
@@ -2165,13 +2163,6 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 
 	inode_lock(inode);
 
-	/*
-	 * We take the dio_sem here because the tree log stuff can race with
-	 * lockless dio writes and get an extent map logged for an extent we
-	 * never waited on.  We need it this high up for lockdep reasons.
-	 */
-	down_write(&BTRFS_I(inode)->dio_sem);
-
 	atomic_inc(&root->log_batch);
 
 	/*
@@ -2209,7 +2200,6 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 */
 	ret = start_ordered_ops(inode, start, end);
 	if (ret) {
-		up_write(&BTRFS_I(inode)->dio_sem);
 		inode_unlock(inode);
 		goto out;
 	}
@@ -2223,7 +2213,6 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 */
 	ret = btrfs_wait_ordered_range(inode, start, (u64)end - (u64)start + 1);
 	if (ret) {
-		up_write(&BTRFS_I(inode)->dio_sem);
 		inode_unlock(inode);
 		goto out;
 	}
@@ -2247,7 +2236,6 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 		 * checked called fsync.
 		 */
 		ret = filemap_check_wb_err(inode->i_mapping, file->f_wb_err);
-		up_write(&BTRFS_I(inode)->dio_sem);
 		inode_unlock(inode);
 		goto out;
 	}
@@ -2266,7 +2254,6 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	trans = btrfs_start_transaction(root, 0);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
-		up_write(&BTRFS_I(inode)->dio_sem);
 		inode_unlock(inode);
 		goto out;
 	}
@@ -2287,7 +2274,6 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 * file again, but that will end up using the synchronization
 	 * inside btrfs_sync_log to keep things safe.
 	 */
-	up_write(&BTRFS_I(inode)->dio_sem);
 	inode_unlock(inode);
 
 	if (ret != BTRFS_NO_LOG_SYNC) {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 31ac8c682f19..7e71f42e7ec0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8433,7 +8433,6 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	INIT_LIST_HEAD(&ei->delalloc_inodes);
 	INIT_LIST_HEAD(&ei->delayed_iput);
 	RB_CLEAR_NODE(&ei->rb_node);
-	init_rwsem(&ei->dio_sem);
 
 	return inode;
 }
-- 
2.25.0

