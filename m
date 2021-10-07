Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC234251A5
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Oct 2021 13:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbhJGLGD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Oct 2021 07:06:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:51372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232665AbhJGLGA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 Oct 2021 07:06:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6567861130
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Oct 2021 11:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633604646;
        bh=TMJk4zx85HHjOgUisB3Rh2yzm7HKVwWqLV1vCmAZkRo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=u3bdTCJjx9rzRHtEhenVGh94kR5Q0F/QEc3dq8+BQqh4HvhYbeIv/AWP5NBx/xiJR
         /KzvJEqLZFbMLaUOtJuSJgyv6Ug5v68yMXDTPLYuDx1K7J9itdH4lGVh0OHHuIBUH1
         PUodaND70RlpmDUwWcdQC+jQ6aA9gi7pLgFGzHnCZg63MDNrh5leEzoyNs+hCl6tzw
         GFp6WJNSVZLLMesvHV2qSF1/H/f+aQyQLer5ypb9lhTPNANrTh3widz2PtHxZhw6JF
         6vPBWgpQsgAjk3KnC3C02O9O+SvOtB0DhB3sZp2QMz3BY+OXBJ/ot/cxoylxi4MqiK
         2le28lmHIBibg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: fix deadlock between chunk allocation and chunk btree modifications
Date:   Thu,  7 Oct 2021 12:03:59 +0100
Message-Id: <89514486a5383cb7e4f86d4c9950bc009f05469f.1633604360.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633604360.git.fdmanana@suse.com>
References: <cover.1633604360.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When a task is doing some modification to the chunk btree and it is not in
the context of a chunk allocation or a chunk removal, it can deadlock with
another task that is currently allocating a new data or metadata chunk.

These contextes are the following:

* When relocating a system chunk, when we need to COW the extent buffers
  that belong to the chunk btree;

* When adding a new device (ioctl), where we need to add a new device item
  to the chunk btree;

* When removing a device (ioctl), where we need to remove a device item
  from the chunk btree;

* When resizing a device (ioctl), where we need to update a device item in
  the chunk btree and may need to relocate a system chunk that lies beyond
  the new device size when shrinking a device.

The problem happens due to a sequence of steps like the following:

1) Task A starts a data or metadata chunk allocation and it locks the
   chunk mutex;

2) Task B is relocating a system chunk, and when it needs to COW an extent
   buffer of the chunk btree, it has locked both that extent buffer as
   well as its parent extent buffer;

3) Since there is not enough available system space, either because none
   of the existing system block groups have enough free space or because
   the only one with enough free space is in RO mode due to the relocation,
   task B triggers a new system chunk allocation. It blocks when trying to
   acquire the chunk mutex, currently held by task A;

4) Task A enters btrfs_chunk_alloc_add_chunk_item(), in order to insert
   the new chunk item into the chunk btree and update the existing device
   items there. But in order to do that, it has to lock the extent buffer
   that task B locked at step 2, or its parent extent buffer, but task B
   is waiting on the chunk mutex, which is currently locked by task A,
   therefore resulting in a deadlock.

One example report when the deadlock happens with system chunk relocation:

  INFO: task kworker/u9:5:546 blocked for more than 143 seconds.
        Not tainted 5.15.0-rc3+ #1
  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
  task:kworker/u9:5    state:D stack:25936 pid:  546 ppid:     2 flags:0x00004000
  Workqueue: events_unbound btrfs_async_reclaim_metadata_space
  Call Trace:
   context_switch kernel/sched/core.c:4940 [inline]
   __schedule+0xcd9/0x2530 kernel/sched/core.c:6287
   schedule+0xd3/0x270 kernel/sched/core.c:6366
   rwsem_down_read_slowpath+0x4ee/0x9d0 kernel/locking/rwsem.c:993
   __down_read_common kernel/locking/rwsem.c:1214 [inline]
   __down_read kernel/locking/rwsem.c:1223 [inline]
   down_read_nested+0xe6/0x440 kernel/locking/rwsem.c:1590
   __btrfs_tree_read_lock+0x31/0x350 fs/btrfs/locking.c:47
   btrfs_tree_read_lock fs/btrfs/locking.c:54 [inline]
   btrfs_read_lock_root_node+0x8a/0x320 fs/btrfs/locking.c:191
   btrfs_search_slot_get_root fs/btrfs/ctree.c:1623 [inline]
   btrfs_search_slot+0x13b4/0x2140 fs/btrfs/ctree.c:1728
   btrfs_update_device+0x11f/0x500 fs/btrfs/volumes.c:2794
   btrfs_chunk_alloc_add_chunk_item+0x34d/0xea0 fs/btrfs/volumes.c:5504
   do_chunk_alloc fs/btrfs/block-group.c:3408 [inline]
   btrfs_chunk_alloc+0x84d/0xf50 fs/btrfs/block-group.c:3653
   flush_space+0x54e/0xd80 fs/btrfs/space-info.c:670
   btrfs_async_reclaim_metadata_space+0x396/0xa90 fs/btrfs/space-info.c:953
   process_one_work+0x9df/0x16d0 kernel/workqueue.c:2297
   worker_thread+0x90/0xed0 kernel/workqueue.c:2444
   kthread+0x3e5/0x4d0 kernel/kthread.c:319
   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
  INFO: task syz-executor:9107 blocked for more than 143 seconds.
        Not tainted 5.15.0-rc3+ #1
  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
  task:syz-executor    state:D stack:23200 pid: 9107 ppid:  7792 flags:0x00004004
  Call Trace:
   context_switch kernel/sched/core.c:4940 [inline]
   __schedule+0xcd9/0x2530 kernel/sched/core.c:6287
   schedule+0xd3/0x270 kernel/sched/core.c:6366
   schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6425
   __mutex_lock_common kernel/locking/mutex.c:669 [inline]
   __mutex_lock+0xc96/0x1680 kernel/locking/mutex.c:729
   btrfs_chunk_alloc+0x31a/0xf50 fs/btrfs/block-group.c:3631
   find_free_extent_update_loop fs/btrfs/extent-tree.c:3986 [inline]
   find_free_extent+0x25cb/0x3a30 fs/btrfs/extent-tree.c:4335
   btrfs_reserve_extent+0x1f1/0x500 fs/btrfs/extent-tree.c:4415
   btrfs_alloc_tree_block+0x203/0x1120 fs/btrfs/extent-tree.c:4813
   __btrfs_cow_block+0x412/0x1620 fs/btrfs/ctree.c:415
   btrfs_cow_block+0x2f6/0x8c0 fs/btrfs/ctree.c:570
   btrfs_search_slot+0x1094/0x2140 fs/btrfs/ctree.c:1768
   relocate_tree_block fs/btrfs/relocation.c:2694 [inline]
   relocate_tree_blocks+0xf73/0x1770 fs/btrfs/relocation.c:2757
   relocate_block_group+0x47e/0xc70 fs/btrfs/relocation.c:3673
   btrfs_relocate_block_group+0x48a/0xc60 fs/btrfs/relocation.c:4070
   btrfs_relocate_chunk+0x96/0x280 fs/btrfs/volumes.c:3181
   __btrfs_balance fs/btrfs/volumes.c:3911 [inline]
   btrfs_balance+0x1f03/0x3cd0 fs/btrfs/volumes.c:4301
   btrfs_ioctl_balance+0x61e/0x800 fs/btrfs/ioctl.c:4137
   btrfs_ioctl+0x39ea/0x7b70 fs/btrfs/ioctl.c:4949
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:874 [inline]
   __se_sys_ioctl fs/ioctl.c:860 [inline]
   __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x44/0xae

So fix this by making sure that whenever we try to modify the chunk btree
and we are neither in a chunk allocation context nor in a chunk remove
context, we reserve system space before modifying the chunk btree.

Reported-by: Hao Sun <sunhao.th@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/CACkBjsax51i4mu6C0C3vJqQN3NR_iVuucoeG3U1HXjrgzn5FFQ@mail.gmail.com/
Fixes: 79bd37120b1495 ("btrfs: rework chunk allocation to avoid exhaustion of the system chunk array")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 119 +++++++++++++++++++++++++++--------------
 fs/btrfs/block-group.h |   2 +
 fs/btrfs/ctree.c       |  14 +++++
 fs/btrfs/transaction.h |   1 +
 4 files changed, 96 insertions(+), 40 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 46fdef7bbe20..c4ffb267a9b3 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2373,6 +2373,7 @@ void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
 	struct btrfs_block_group *block_group;
 	int ret = 0;
 
+	trans->creating_pending_block_groups = true;
 	while (!list_empty(&trans->new_bgs)) {
 		int index;
 
@@ -2414,6 +2415,7 @@ void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
 		btrfs_delayed_refs_rsv_release(fs_info, 1);
 		list_del_init(&block_group->bg_list);
 	}
+	trans->creating_pending_block_groups = false;
 	btrfs_trans_release_chunk_metadata(trans);
 }
 
@@ -3403,25 +3405,6 @@ static int do_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags)
 		goto out;
 	}
 
-	/*
-	 * If this is a system chunk allocation then stop right here and do not
-	 * add the chunk item to the chunk btree. This is to prevent a deadlock
-	 * because this system chunk allocation can be triggered while COWing
-	 * some extent buffer of the chunk btree and while holding a lock on a
-	 * parent extent buffer, in which case attempting to insert the chunk
-	 * item (or update the device item) would result in a deadlock on that
-	 * parent extent buffer. In this case defer the chunk btree updates to
-	 * the second phase of chunk allocation and keep our reservation until
-	 * the second phase completes.
-	 *
-	 * This is a rare case and can only be triggered by the very few cases
-	 * we have where we need to touch the chunk btree outside chunk allocation
-	 * and chunk removal. These cases are basically adding a device, removing
-	 * a device or resizing a device.
-	 */
-	if (flags & BTRFS_BLOCK_GROUP_SYSTEM)
-		return 0;
-
 	ret = btrfs_chunk_alloc_add_chunk_item(trans, bg);
 	/*
 	 * Normally we are not expected to fail with -ENOSPC here, since we have
@@ -3598,11 +3581,27 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 	if (trans->allocating_chunk)
 		return -ENOSPC;
 	/*
-	 * If we are removing a chunk, don't re-enter or we would deadlock.
-	 * System space reservation and system chunk allocation is done by the
-	 * chunk remove operation (btrfs_remove_chunk()).
+	 * Allocation of system chunks can not happen through this path, as we
+	 * could end up in a deadlock if we are allocating a data or metadata
+	 * chunk and there is another task modifying the chunk btree
+	 *
+	 * This is because while we are holding the chunk mutex, we will attempt
+	 * to add the new chunk item to the chunk btree or update an existing
+	 * device item in the chunk btree, while the other task that is modifying
+	 * the chunk btree is attempting to COW an extent buffer while holding a
+	 * lock on it and on its parent - if the COW operation triggers a system
+	 * chunk allocation, then we can deadlock because we are holding the
+	 * chunk mutex and we may need to access that extent buffer or its parent
+	 * in order to add the chunk item or update a device item.
+	 *
+	 * Tasks that want to modify the chunk tree should reserve system space
+	 * before updating the chunk btree, by calling either
+	 * btrfs_reserve_chunk_space_for_cow() or check_system_chunk().
+	 * It's possible that after a task reserves the space, it still ends up
+	 * here - this happens in the cases described above at do_chunk_alloc().
+	 * The task will have to either retry or fail.
 	 */
-	if (trans->removing_chunk)
+	if (flags & BTRFS_BLOCK_GROUP_SYSTEM)
 		return -ENOSPC;
 
 	space_info = btrfs_find_space_info(fs_info, flags);
@@ -3701,17 +3700,14 @@ static u64 get_profile_num_devs(struct btrfs_fs_info *fs_info, u64 type)
 	return num_dev;
 }
 
-/*
- * Reserve space in the system space for allocating or removing a chunk
- */
-void check_system_chunk(struct btrfs_trans_handle *trans, u64 type)
+static void reserve_chunk_space(struct btrfs_trans_handle *trans,
+				u64 bytes,
+				u64 type)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_space_info *info;
 	u64 left;
-	u64 thresh;
 	int ret = 0;
-	u64 num_devs;
 
 	/*
 	 * Needed because we can end up allocating a system chunk and for an
@@ -3724,19 +3720,13 @@ void check_system_chunk(struct btrfs_trans_handle *trans, u64 type)
 	left = info->total_bytes - btrfs_space_info_used(info, true);
 	spin_unlock(&info->lock);
 
-	num_devs = get_profile_num_devs(fs_info, type);
-
-	/* num_devs device items to update and 1 chunk item to add or remove */
-	thresh = btrfs_calc_metadata_size(fs_info, num_devs) +
-		btrfs_calc_insert_metadata_size(fs_info, 1);
-
-	if (left < thresh && btrfs_test_opt(fs_info, ENOSPC_DEBUG)) {
+	if (left < bytes && btrfs_test_opt(fs_info, ENOSPC_DEBUG)) {
 		btrfs_info(fs_info, "left=%llu, need=%llu, flags=%llu",
-			   left, thresh, type);
+			   left, bytes, type);
 		btrfs_dump_space_info(fs_info, info, 0, 0);
 	}
 
-	if (left < thresh) {
+	if (left < bytes) {
 		u64 flags = btrfs_system_alloc_profile(fs_info);
 		struct btrfs_block_group *bg;
 
@@ -3768,12 +3758,61 @@ void check_system_chunk(struct btrfs_trans_handle *trans, u64 type)
 	if (!ret) {
 		ret = btrfs_block_rsv_add(fs_info->chunk_root,
 					  &fs_info->chunk_block_rsv,
-					  thresh, BTRFS_RESERVE_NO_FLUSH);
+					  bytes, BTRFS_RESERVE_NO_FLUSH);
 		if (!ret)
-			trans->chunk_bytes_reserved += thresh;
+			trans->chunk_bytes_reserved += bytes;
 	}
 }
 
+/*
+ * Reserve space in the system space for allocating or removing a chunk.
+ * The caller must be holding fs_info->chunk_mutex.
+ */
+void check_system_chunk(struct btrfs_trans_handle *trans, u64 type)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	const u64 num_devs = get_profile_num_devs(fs_info, type);
+	u64 thresh;
+
+	/* num_devs device items to update and 1 chunk item to add or remove. */
+	thresh = btrfs_calc_metadata_size(fs_info, num_devs) +
+		btrfs_calc_insert_metadata_size(fs_info, 1);
+
+	reserve_chunk_space(trans, thresh, type);
+}
+
+/*
+ * Reserve space in the system space, if needed, for doing a modification to the
+ * chunk btree.
+ *
+ * The chunk mutex (fs_info->chunk_mutex) must be held and this is used in a
+ * context where we need to update the chunk btree outside block group allocation
+ * and removal, to avoid a deadlock with a concurrent task that is allocating a
+ * metadata or data block group and therefore needs to update the chunk btree
+ * while holding the chunk mutex. After the update to chunk btree is done, the
+ * caller should call btrfs_trans_release_chunk_metadata().
+ *
+ * @trans:		A transaction handle.
+ * @is_item_insertion:	Indicate if the modification is for inserting a new item
+ *			in the chunk btree or if it's for the deletion or update
+ *			of an existing item.
+ */
+void btrfs_reserve_chunk_btree_space(struct btrfs_trans_handle *trans,
+				     bool is_item_insertion)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	u64 bytes;
+
+	if (is_item_insertion)
+		bytes = btrfs_calc_insert_metadata_size(fs_info, 1);
+	else
+		bytes = btrfs_calc_metadata_size(fs_info, 1);
+
+	mutex_lock(&fs_info->chunk_mutex);
+	reserve_chunk_space(trans, bytes, BTRFS_BLOCK_GROUP_SYSTEM);
+	mutex_unlock(&fs_info->chunk_mutex);
+}
+
 void btrfs_put_block_group_cache(struct btrfs_fs_info *info)
 {
 	struct btrfs_block_group *block_group;
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index f751b802b173..5e8f8aaabadc 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -293,6 +293,8 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 		      enum btrfs_chunk_alloc_enum force);
 int btrfs_force_chunk_alloc(struct btrfs_trans_handle *trans, u64 type);
 void check_system_chunk(struct btrfs_trans_handle *trans, const u64 type);
+void btrfs_reserve_chunk_btree_space(struct btrfs_trans_handle *trans,
+				     bool is_item_insertion);
 u64 btrfs_get_alloc_profile(struct btrfs_fs_info *fs_info, u64 orig_flags);
 void btrfs_put_block_group_cache(struct btrfs_fs_info *info);
 int btrfs_free_block_groups(struct btrfs_fs_info *info);
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 74c8e18f3720..b897c79a74b9 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -8,6 +8,7 @@
 #include <linux/rbtree.h>
 #include <linux/mm.h>
 #include "ctree.h"
+#include "block-group.h"
 #include "disk-io.h"
 #include "transaction.h"
 #include "print-tree.h"
@@ -1693,6 +1694,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	u8 lowest_level = 0;
 	int min_write_lock_level;
 	int prev_cmp;
+	bool reserved_chunk_space = false;
 
 	lowest_level = p->lowest_level;
 	WARN_ON(lowest_level && ins_len > 0);
@@ -1723,6 +1725,14 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 
 	min_write_lock_level = write_lock_level;
 
+	if (cow && root == root->fs_info->chunk_root &&
+	    !trans->allocating_chunk &&
+	    !trans->removing_chunk &&
+	    !trans->creating_pending_block_groups) {
+		btrfs_reserve_chunk_btree_space(trans, (ins_len > 0));
+		reserved_chunk_space = true;
+	}
+
 again:
 	prev_cmp = -1;
 	b = btrfs_search_slot_get_root(root, p, write_lock_level);
@@ -1917,6 +1927,10 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 done:
 	if (ret < 0 && !p->skip_release_on_error)
 		btrfs_release_path(p);
+
+	if (reserved_chunk_space)
+		btrfs_trans_release_chunk_metadata(trans);
+
 	return ret;
 }
 ALLOW_ERROR_INJECTION(btrfs_search_slot, ERRNO);
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index ba45065f9451..fb1163c09040 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -133,6 +133,7 @@ struct btrfs_trans_handle {
 	bool adding_csums;
 	bool allocating_chunk;
 	bool removing_chunk;
+	bool creating_pending_block_groups;
 	bool reloc_reserved;
 	bool in_fsync;
 	struct btrfs_root *root;
-- 
2.33.0

