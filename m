Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D777E47D8
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2019 11:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407198AbfJYJw7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Oct 2019 05:52:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390193AbfJYJw7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Oct 2019 05:52:59 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73AD921929
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Oct 2019 09:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571997177;
        bh=guxlartcXSR6ZLO6CSiHrsygvG4IamOBX1DtDhtP7dQ=;
        h=From:To:Subject:Date:From;
        b=CPISfsO9Bhrtwz3vHCcwMNILRHx0iKpXXio7lOZ1GgQm6u3VBG1+OhKlV44LZFcTC
         FoxlHMODyAMz8Mtngw41y1IGOozVmIyH/Rd6H0jdnksabzsAvUUzFeWcNrPZgtSql3
         xd81LPY+bLOGO69SoGQjmcP4fqPUGE50uGlyeVQs=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs: remove unnecessary delalloc mutex for inodes
Date:   Fri, 25 Oct 2019 10:52:42 +0100
Message-Id: <20191025095242.15996-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The inode delalloc mutex was added a long time ago by commit f248679e86fea
("Btrfs: add a delalloc mutex to inodes for delalloc reservations"), and
the reason for its introduction is not very clear from the change log. It
claims it solves bogus warnings from lockdep, however it lacks an example
report/warning from lockdep, or any explanation.

Since we have enough concurrentcy protection from the locks of the space
info and block reserve objects, and such lockdep warnings don't seem to
exist anymore (at least on a 5.3 kernel I couldn't get them with fstests,
ltp, fs_mark, etc), remove it, simplifying things a bit and decreasing
the size of the btrfs_inode structure. With some quick fio tests doing
direct IO and mmap writes I couldn't observe any significant performance
increase either (direct IO writes that don't increase the file's size
don't hold the inode's lock for their entire duration and mmap writes
don't hold the inode's lock at all), which are the only type of writes
that could see any performance gain due to less serialization.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/btrfs_inode.h    |  3 ---
 fs/btrfs/delalloc-space.c | 21 +++++----------------
 fs/btrfs/inode.c          |  1 -
 3 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index f853835c409c..4e12a477d32e 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -63,9 +63,6 @@ struct btrfs_inode {
 	/* held while logging the inode in tree-log.c */
 	struct mutex log_mutex;
 
-	/* held while doing delalloc reservations */
-	struct mutex delalloc_mutex;
-
 	/* used to order data wrt metadata */
 	struct btrfs_ordered_inode_tree ordered_tree;
 
diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index fe68d0e078bd..4ed9ed3ff917 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -307,7 +307,6 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
 	unsigned nr_extents;
 	enum btrfs_reserve_flush_enum flush = BTRFS_RESERVE_FLUSH_ALL;
 	int ret = 0;
-	bool delalloc_lock = true;
 
 	/*
 	 * If we are a free space inode we need to not flush since we will be in
@@ -320,7 +319,6 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
 	 */
 	if (btrfs_is_free_space_inode(inode)) {
 		flush = BTRFS_RESERVE_NO_FLUSH;
-		delalloc_lock = false;
 	} else {
 		if (current->journal_info)
 			flush = BTRFS_RESERVE_FLUSH_LIMIT;
@@ -329,9 +327,6 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
 			schedule_timeout(1);
 	}
 
-	if (delalloc_lock)
-		mutex_lock(&inode->delalloc_mutex);
-
 	num_bytes = ALIGN(num_bytes, fs_info->sectorsize);
 
 	/*
@@ -348,10 +343,12 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
 				&qgroup_reserve);
 	ret = btrfs_qgroup_reserve_meta_prealloc(root, qgroup_reserve, true);
 	if (ret)
-		goto out_fail;
+		return ret;
 	ret = btrfs_reserve_metadata_bytes(root, block_rsv, meta_reserve, flush);
-	if (ret)
-		goto out_qgroup;
+	if (ret) {
+		btrfs_qgroup_free_meta_prealloc(root, qgroup_reserve);
+		return ret;
+	}
 
 	/*
 	 * Now we need to update our outstanding extents and csum bytes _first_
@@ -375,15 +372,7 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
 	block_rsv->qgroup_rsv_reserved += qgroup_reserve;
 	spin_unlock(&block_rsv->lock);
 
-	if (delalloc_lock)
-		mutex_unlock(&inode->delalloc_mutex);
 	return 0;
-out_qgroup:
-	btrfs_qgroup_free_meta_prealloc(root, qgroup_reserve);
-out_fail:
-	if (delalloc_lock)
-		mutex_unlock(&inode->delalloc_mutex);
-	return ret;
 }
 
 /**
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f23b14ec743a..b894517d1e0e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9312,7 +9312,6 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	ei->io_failure_tree.track_uptodate = true;
 	atomic_set(&ei->sync_writers, 0);
 	mutex_init(&ei->log_mutex);
-	mutex_init(&ei->delalloc_mutex);
 	btrfs_ordered_inode_tree_init(&ei->ordered_tree);
 	INIT_LIST_HEAD(&ei->delalloc_inodes);
 	INIT_LIST_HEAD(&ei->delayed_iput);
-- 
2.11.0

