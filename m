Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D712C5E145
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2019 11:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfGCJp5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jul 2019 05:45:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:45856 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726951AbfGCJp4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Jul 2019 05:45:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A0DD1AFBC;
        Wed,  3 Jul 2019 09:45:54 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     stable@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: Ensure replaced device doesn't have pending chunk allocation
Date:   Wed,  3 Jul 2019 12:45:52 +0300
Message-Id: <20190703094552.15833-5-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Recent FITRIM work, namely bbbf7243d62d ("btrfs: combine device update
operations during transaction commit") combined the way certain
operations are recoded in a transaction. As a result an ASSERT was added
in dev_replace_finish to ensure the new code works correctly.
Unfortunately I got reports that it's possible to trigger the assert,
meaning that during a device replace it's possible to have an unfinished
chunk allocation on the source device.

This is supposed to be prevented by the fact that a transaction is
committed before finishing the replace oepration and alter acquiring the
chunk mutex. This is not sufficient since by the time the transaction is
committed and the chunk mutex acquired it's possible to allocate a chunk
depending on the workload being executed on the replaced device. This
bug has been present ever since device replace was introduced but there
was never code which checks for it.

The correct way to fix is to ensure that there is no pending device
modification operation when the chunk mutex is acquire and if there is
repeat transaction commit. Unfortunately it's not possible to just
exclude the source device from btrfs_fs_devices::dev_alloc_list since
this causes ENOSPC to be hit in transaction commit.

Fixing that in another way would need to add special cases to handle the
last writes and forbid new ones. The looped transaction fix is more
obvious, and can be easily backported. The runtime of dev-replace is
long so there's no noticeable delay caused by that.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
Hello Greg, 

Please merge the following backport of upstream commit debd1c065d2037919a7da67baf55cc683fee09f0
to 5.1 stable branch. 

 fs/btrfs/dev-replace.c | 26 +++++++++++++++++---------
 fs/btrfs/volumes.c     |  5 ++++-
 fs/btrfs/volumes.h     |  5 +++++
 3 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index ee193c5222b2..a69c3b14f2b1 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -603,17 +603,25 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 	}
 	btrfs_wait_ordered_roots(fs_info, U64_MAX, 0, (u64)-1);
 
-	trans = btrfs_start_transaction(root, 0);
-	if (IS_ERR(trans)) {
-		mutex_unlock(&dev_replace->lock_finishing_cancel_unmount);
-		return PTR_ERR(trans);
+	while (1) {
+		trans = btrfs_start_transaction(root, 0);
+		if (IS_ERR(trans)) {
+			mutex_unlock(&dev_replace->lock_finishing_cancel_unmount);
+			return PTR_ERR(trans);
+		}
+		ret = btrfs_commit_transaction(trans);
+		WARN_ON(ret);
+		/* keep away write_all_supers() during the finishing procedure */
+		mutex_lock(&fs_info->fs_devices->device_list_mutex);
+		mutex_lock(&fs_info->chunk_mutex);
+		if (src_device->has_pending_chunks) {
+			mutex_unlock(&root->fs_info->chunk_mutex);
+			mutex_unlock(&root->fs_info->fs_devices->device_list_mutex);
+		} else {
+			break;
+		}
 	}
-	ret = btrfs_commit_transaction(trans);
-	WARN_ON(ret);
 
-	/* keep away write_all_supers() during the finishing procedure */
-	mutex_lock(&fs_info->fs_devices->device_list_mutex);
-	mutex_lock(&fs_info->chunk_mutex);
 	down_write(&dev_replace->rwsem);
 	dev_replace->replace_state =
 		scrub_ret ? BTRFS_IOCTL_DEV_REPLACE_STATE_CANCELED
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index db934ceae9c1..62c32779bdea 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5222,9 +5222,11 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	if (ret)
 		goto error_del_extent;
 
-	for (i = 0; i < map->num_stripes; i++)
+	for (i = 0; i < map->num_stripes; i++) {
 		btrfs_device_set_bytes_used(map->stripes[i].dev,
 				map->stripes[i].dev->bytes_used + stripe_size);
+		map->stripes[i].dev->has_pending_chunks = true;
+	}
 
 	atomic64_sub(stripe_size * map->num_stripes, &info->free_chunk_space);
 
@@ -7716,6 +7718,7 @@ void btrfs_update_commit_device_bytes_used(struct btrfs_transaction *trans)
 		for (i = 0; i < map->num_stripes; i++) {
 			dev = map->stripes[i].dev;
 			dev->commit_bytes_used = dev->bytes_used;
+			dev->has_pending_chunks = false;
 		}
 	}
 	mutex_unlock(&fs_info->chunk_mutex);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 3ad9d58d1b66..fb51ec810cf9 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -54,6 +54,11 @@ struct btrfs_device {
 
 	spinlock_t io_lock ____cacheline_aligned;
 	int running_pending;
+	/* When true means this device has pending chunk alloc in
+	 * current transaction. Protected by chunk_mutex.
+	 */
+	bool has_pending_chunks;
+
 	/* regular prio bios */
 	struct btrfs_pending_bios pending_bios;
 	/* sync bios */
-- 
2.17.1

