Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABAF61D2B22
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 May 2020 11:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgENJTb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 May 2020 05:19:31 -0400
Received: from mail.synology.com ([211.23.38.101]:46482 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725878AbgENJTb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 May 2020 05:19:31 -0400
Received: from localhost.localdomain (unknown [10.17.32.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id 3C7B6CE837BC;
        Thu, 14 May 2020 17:19:29 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1589447969; bh=7o1EvNZfCBmVyaVN97ASp0bEnfZw25Xdp8eNB1L1IeU=;
        h=From:To:Cc:Subject:Date;
        b=D77v2JK+DJR5u9gwsAQ9bwvkbI2csaE/ycNNGx94qY1ilid+gxNKQuUlpLMJi3AId
         xea8n8Meb7kN1s+MI3bnW0tlBJLbWAxubTuTmffpX7IkEN7uv4ctcpCpkpPnP012mL
         qX+5C3ewaTsEsUN/L9iygpV8CCYEzz4mOtGmUa1g=
From:   robbieko <robbieko@synology.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Robbie Ko <robbieko@synology.com>
Subject: [PATCH] Btrfs: reduce lock contention when create snapshot
Date:   Thu, 14 May 2020 17:19:18 +0800
Message-Id: <20200514091918.30294-1-robbieko@synology.com>
X-Mailer: git-send-email 2.17.1
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Robbie Ko <robbieko@synology.com>

When creating a snapshot, it takes a long time because
flush dirty data is required.

But we have taken two resources as shown below:
1. Destination directory inode lock
2. Global subvol semaphore

This will cause subvol destroy/create/setflag blocked,
until the snapshot is created.

We fix by flush dirty data first to reduce the time of
the critical section, and then lock the relevant resources.

Signed-off-by: Robbie Ko <robbieko@synology.com>
---
 fs/btrfs/ioctl.c | 70 ++++++++++++++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 40b729dce91c..d0c1598dc51e 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -748,7 +748,6 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 	struct btrfs_pending_snapshot *pending_snapshot;
 	struct btrfs_trans_handle *trans;
 	int ret;
-	bool snapshot_force_cow = false;
 
 	if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
 		return -EINVAL;
@@ -771,27 +770,6 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 		goto free_pending;
 	}
 
-	/*
-	 * Force new buffered writes to reserve space even when NOCOW is
-	 * possible. This is to avoid later writeback (running dealloc) to
-	 * fallback to COW mode and unexpectedly fail with ENOSPC.
-	 */
-	btrfs_drew_read_lock(&root->snapshot_lock);
-
-	ret = btrfs_start_delalloc_snapshot(root);
-	if (ret)
-		goto dec_and_free;
-
-	/*
-	 * All previous writes have started writeback in NOCOW mode, so now
-	 * we force future writes to fallback to COW mode during snapshot
-	 * creation.
-	 */
-	atomic_inc(&root->snapshot_force_cow);
-	snapshot_force_cow = true;
-
-	btrfs_wait_ordered_extents(root, U64_MAX, 0, (u64)-1);
-
 	btrfs_init_block_rsv(&pending_snapshot->block_rsv,
 			     BTRFS_BLOCK_RSV_TEMP);
 	/*
@@ -806,7 +784,7 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 					&pending_snapshot->block_rsv, 8,
 					false);
 	if (ret)
-		goto dec_and_free;
+		goto free_pending;
 
 	pending_snapshot->dentry = dentry;
 	pending_snapshot->root = root;
@@ -848,11 +826,6 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 fail:
 	btrfs_put_root(pending_snapshot->snap);
 	btrfs_subvolume_release_metadata(fs_info, &pending_snapshot->block_rsv);
-dec_and_free:
-	if (snapshot_force_cow)
-		atomic_dec(&root->snapshot_force_cow);
-	btrfs_drew_read_unlock(&root->snapshot_lock);
-
 free_pending:
 	kfree(pending_snapshot->root_item);
 	btrfs_free_path(pending_snapshot->path);
@@ -983,6 +956,45 @@ static noinline int btrfs_mksubvol(const struct path *parent,
 	return error;
 }
 
+static noinline int btrfs_mksnapshot(const struct path *parent,
+				   const char *name, int namelen,
+				   struct btrfs_root *root,
+				   bool readonly,
+				   struct btrfs_qgroup_inherit *inherit)
+{
+	int ret;
+	bool snapshot_force_cow = false;
+
+	/*
+	 * Force new buffered writes to reserve space even when NOCOW is
+	 * possible. This is to avoid later writeback (running dealloc) to
+	 * fallback to COW mode and unexpectedly fail with ENOSPC.
+	 */
+	btrfs_drew_read_lock(&root->snapshot_lock);
+
+	ret = btrfs_start_delalloc_snapshot(root);
+	if (ret)
+		goto out;
+
+	/*
+	 * All previous writes have started writeback in NOCOW mode, so now
+	 * we force future writes to fallback to COW mode during snapshot
+	 * creation.
+	 */
+	atomic_inc(&root->snapshot_force_cow);
+	snapshot_force_cow = true;
+
+	btrfs_wait_ordered_extents(root, U64_MAX, 0, (u64)-1);
+
+	ret = btrfs_mksubvol(parent, name, namelen,
+			     root, readonly, inherit);
+out:
+	if (snapshot_force_cow)
+		atomic_dec(&root->snapshot_force_cow);
+	btrfs_drew_read_unlock(&root->snapshot_lock);
+	return ret;
+}
+
 /*
  * When we're defragging a range, we don't want to kick it off again
  * if it is really just waiting for delalloc to send it down.
@@ -1762,7 +1774,7 @@ static noinline int __btrfs_ioctl_snap_create(struct file *file,
 			 */
 			ret = -EPERM;
 		} else {
-			ret = btrfs_mksubvol(&file->f_path, name, namelen,
+			ret = btrfs_mksnapshot(&file->f_path, name, namelen,
 					     BTRFS_I(src_inode)->root,
 					     readonly, inherit);
 		}
-- 
2.17.1

