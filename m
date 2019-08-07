Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC2E84954
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2019 12:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfHGKVv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Aug 2019 06:21:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:32934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbfHGKVv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 7 Aug 2019 06:21:51 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EE2421E6C
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Aug 2019 10:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565173309;
        bh=iFTr9BMONw9vxohI0pveVSJ2404ByGS/KZKrvg3vJ48=;
        h=From:To:Subject:Date:From;
        b=LnBhV0EF1ElPbm8vq89ZTUWmpZAZrFerOamHATXAOzZAShGMsz5aMD15WC4PXIjds
         ALpjHPMBZB6tzzZsp1ajjB76TBpz5gJvvR8s3Rs8k5PXkFn5YSRhqE2WJtumEHUJqt
         cIKX/HwGgQ87stkKd9TGnznoHO6soAChbsMfhGtU=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs: fix sysfs warning and missing raid sysfs directories
Date:   Wed,  7 Aug 2019 11:21:46 +0100
Message-Id: <20190807102146.28008-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

In the 5.3 merge window, commit 7c7e301406d0a9 ("btrfs: sysfs: Replace
default_attrs in ktypes with groups"), we started using the member
"defaults_groups" for the kobject type "btrfs_raid_ktype". That leads
to a series of warnings when running some test cases of fstests, such
as btrfs/027, btrfs/124 and btrfs/176. The traces produced by those
warnings are like the following:

  [116648.059212] kernfs: can not remove 'total_bytes', no directory
  [116648.060112] WARNING: CPU: 3 PID: 28500 at fs/kernfs/dir.c:1504 kernfs_remove_by_name_ns+0x75/0x80
  (...)
  [116648.066482] CPU: 3 PID: 28500 Comm: umount Tainted: G        W         5.3.0-rc3-btrfs-next-54 #1
  (...)
  [116648.069376] RIP: 0010:kernfs_remove_by_name_ns+0x75/0x80
  (...)
  [116648.072385] RSP: 0018:ffffabfd0090bd08 EFLAGS: 00010282
  [116648.073437] RAX: 0000000000000000 RBX: ffffffffc0c11998 RCX: 0000000000000000
  [116648.074201] RDX: ffff9fff603a7a00 RSI: ffff9fff603978a8 RDI: ffff9fff603978a8
  [116648.074956] RBP: ffffffffc0b9ca2f R08: 0000000000000000 R09: 0000000000000001
  [116648.075708] R10: ffff9ffe1f72e1c0 R11: 0000000000000000 R12: ffffffffc0b94120
  [116648.076434] R13: ffffffffb3d9b4e0 R14: 0000000000000000 R15: dead000000000100
  [116648.077143] FS:  00007f9cdc78a2c0(0000) GS:ffff9fff60380000(0000) knlGS:0000000000000000
  [116648.077852] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [116648.078546] CR2: 00007f9fc4747ab4 CR3: 00000005c7832003 CR4: 00000000003606e0
  [116648.079235] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  [116648.079907] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  [116648.080585] Call Trace:
  [116648.081262]  remove_files+0x31/0x70
  [116648.081929]  sysfs_remove_group+0x38/0x80
  [116648.082596]  sysfs_remove_groups+0x34/0x70
  [116648.083258]  kobject_del+0x20/0x60
  [116648.083933]  btrfs_free_block_groups+0x405/0x430 [btrfs]
  [116648.084608]  close_ctree+0x19a/0x380 [btrfs]
  [116648.085278]  generic_shutdown_super+0x6c/0x110
  [116648.085951]  kill_anon_super+0xe/0x30
  [116648.086621]  btrfs_kill_super+0x12/0xa0 [btrfs]
  [116648.087289]  deactivate_locked_super+0x3a/0x70
  [116648.087956]  cleanup_mnt+0xb4/0x160
  [116648.088620]  task_work_run+0x7e/0xc0
  [116648.089285]  exit_to_usermode_loop+0xfa/0x100
  [116648.089933]  do_syscall_64+0x1cb/0x220
  [116648.090567]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
  [116648.091197] RIP: 0033:0x7f9cdc073b37
  (...)
  [116648.100046] ---[ end trace 22e24db328ccadf8 ]---
  [116648.100618] ------------[ cut here ]------------
  [116648.101175] kernfs: can not remove 'used_bytes', no directory
  [116648.101731] WARNING: CPU: 3 PID: 28500 at fs/kernfs/dir.c:1504 kernfs_remove_by_name_ns+0x75/0x80
  (...)
  [116648.105649] CPU: 3 PID: 28500 Comm: umount Tainted: G        W         5.3.0-rc3-btrfs-next-54 #1
  (...)
  [116648.107461] RIP: 0010:kernfs_remove_by_name_ns+0x75/0x80
  (...)
  [116648.109336] RSP: 0018:ffffabfd0090bd08 EFLAGS: 00010282
  [116648.109979] RAX: 0000000000000000 RBX: ffffffffc0c119a0 RCX: 0000000000000000
  [116648.110625] RDX: ffff9fff603a7a00 RSI: ffff9fff603978a8 RDI: ffff9fff603978a8
  [116648.111283] RBP: ffffffffc0b9ca41 R08: 0000000000000000 R09: 0000000000000001
  [116648.111940] R10: ffff9ffe1f72e1c0 R11: 0000000000000000 R12: ffffffffc0b94120
  [116648.112603] R13: ffffffffb3d9b4e0 R14: 0000000000000000 R15: dead000000000100
  [116648.113268] FS:  00007f9cdc78a2c0(0000) GS:ffff9fff60380000(0000) knlGS:0000000000000000
  [116648.113939] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [116648.114607] CR2: 00007f9fc4747ab4 CR3: 00000005c7832003 CR4: 00000000003606e0
  [116648.115286] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  [116648.115966] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  [116648.116649] Call Trace:
  [116648.117326]  remove_files+0x31/0x70
  [116648.117997]  sysfs_remove_group+0x38/0x80
  [116648.118671]  sysfs_remove_groups+0x34/0x70
  [116648.119342]  kobject_del+0x20/0x60
  [116648.120022]  btrfs_free_block_groups+0x405/0x430 [btrfs]
  [116648.120707]  close_ctree+0x19a/0x380 [btrfs]
  [116648.121396]  generic_shutdown_super+0x6c/0x110
  [116648.122057]  kill_anon_super+0xe/0x30
  [116648.122702]  btrfs_kill_super+0x12/0xa0 [btrfs]
  [116648.123335]  deactivate_locked_super+0x3a/0x70
  [116648.123961]  cleanup_mnt+0xb4/0x160
  [116648.124586]  task_work_run+0x7e/0xc0
  [116648.125210]  exit_to_usermode_loop+0xfa/0x100
  [116648.125830]  do_syscall_64+0x1cb/0x220
  [116648.126463]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
  [116648.127080] RIP: 0033:0x7f9cdc073b37
  (...)
  [116648.135923] ---[ end trace 22e24db328ccadf9 ]---

These happen because, during the unmount path, we call kobject_del() for
raid kobjects that are not fully initialized, meaning that we set their
ktype (as btrfs_raid_ktype) through link_block_group() but we didn't set
their parent kobject, which is done through btrfs_add_raid_kobjects().

We have this split raid kobject setup since commit 75cb379d263521
("btrfs: defer adding raid type kobject until after chunk relocation") in
order to avoid triggering reclaim during contextes where we can not
(either we are holding a transaction handle or some lock required by
the transaction commit path), so that we do the calls to kobject_add(),
which triggers GFP_KERNEL allocations, through btrfs_add_raid_kobjects()
in contextes where it is safe to trigger reclaim. That change expected
that a new raid kobject can only be created either when mounting the
filesystem or after raid profile conversion through the relocation path.
However, we can have new raid kobject created in other two cases at least:

1) During device replace (or scrub) after adding a device a to the
   filesystem. The replace procedure (and scrub) do calls to
   btrfs_inc_block_group_ro() which can allocate a new block group
   with a new raid profile (because we now have more devices). This
   can be triggered by test cases btrfs/027 and btrfs/176.

2) During a degraded mount trough any write path. This can be triggered
   by test case btrfs/124.

Fixing this by adding extra calls to btrfs_add_raid_kobjects(), not only
makes things more complex and fragile, can also introduce deadlocks with
reclaim the following way:

1) Calling btrfs_add_raid_kobjects() at btrfs_inc_block_group_ro() or
   anywhere in the replace/scrub path will cause a deadlock with reclaim
   because if reclaim happens and a transaction commit is triggered,
   the transaction commit path will block at btrfs_scrub_pause().

2) During degraded mounts it is essentially impossible to figure out where
   to add extra calls to btrfs_add_raid_kobjects(), because allocation of
   a block group with a new raid profile can happen anywhere, which means
   we can't safely figure out which contextes are safe for reclaim, as
   we can either hold a transaction handle or some lock needed by the
   transaction commit path.

So it is too complex and error prone to have this split setup of raid
kobjects. So fix the issue by consolidating the setup of the kobjects in a
single place, at link_block_group(), and setup a nofs context there in
order to prevent reclaim being triggered by the memory allocations done
through the call chain of kobject_add().

Besides fixing the sysfs warnings during kobject_del(), this also ensures
the sysfs directories for the new raid profiles end up created and visible
to users (a bug that existed before the 5.3 commit 7c7e301406d0a9
("btrfs: sysfs: Replace default_attrs in ktypes with groups")).

Fixes: 75cb379d263521 ("btrfs: defer adding raid type kobject until after chunk relocation")
Fixes: 7c7e301406d0a9 ("btrfs: sysfs: Replace default_attrs in ktypes with groups")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.h       |  4 ----
 fs/btrfs/disk-io.c     |  2 --
 fs/btrfs/extent-tree.c | 57 +++++++++++++++++++++-----------------------------
 fs/btrfs/volumes.c     | 13 ------------
 4 files changed, 24 insertions(+), 52 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index da97ff10f421..670973025048 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -401,7 +401,6 @@ struct btrfs_dev_replace {
 struct raid_kobject {
 	u64 flags;
 	struct kobject kobj;
-	struct list_head list;
 };
 
 /*
@@ -915,8 +914,6 @@ struct btrfs_fs_info {
 	u32 thread_pool_size;
 
 	struct kobject *space_info_kobj;
-	struct list_head pending_raid_kobjs;
-	spinlock_t pending_raid_kobjs_lock; /* uncontended */
 
 	u64 total_pinned;
 
@@ -2708,7 +2705,6 @@ int btrfs_can_relocate(struct btrfs_fs_info *fs_info, u64 bytenr);
 int btrfs_make_block_group(struct btrfs_trans_handle *trans,
 			   u64 bytes_used, u64 type, u64 chunk_offset,
 			   u64 size);
-void btrfs_add_raid_kobjects(struct btrfs_fs_info *fs_info);
 struct btrfs_trans_handle *btrfs_start_trans_remove_block_group(
 				struct btrfs_fs_info *fs_info,
 				const u64 chunk_offset);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5f7ee70b3d1a..97beb351a10c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2683,8 +2683,6 @@ int open_ctree(struct super_block *sb,
 	INIT_LIST_HEAD(&fs_info->delayed_iputs);
 	INIT_LIST_HEAD(&fs_info->delalloc_roots);
 	INIT_LIST_HEAD(&fs_info->caching_block_groups);
-	INIT_LIST_HEAD(&fs_info->pending_raid_kobjs);
-	spin_lock_init(&fs_info->pending_raid_kobjs_lock);
 	spin_lock_init(&fs_info->delalloc_root_lock);
 	spin_lock_init(&fs_info->trans_lock);
 	spin_lock_init(&fs_info->fs_roots_radix_lock);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index d3b58e388535..25b2c9d7fa7f 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/sched.h>
+#include <linux/sched/mm.h>
 #include <linux/sched/signal.h>
 #include <linux/pagemap.h>
 #include <linux/writeback.h>
@@ -7888,33 +7889,6 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 	return 0;
 }
 
-/* link_block_group will queue up kobjects to add when we're reclaim-safe */
-void btrfs_add_raid_kobjects(struct btrfs_fs_info *fs_info)
-{
-	struct btrfs_space_info *space_info;
-	struct raid_kobject *rkobj;
-	LIST_HEAD(list);
-	int ret = 0;
-
-	spin_lock(&fs_info->pending_raid_kobjs_lock);
-	list_splice_init(&fs_info->pending_raid_kobjs, &list);
-	spin_unlock(&fs_info->pending_raid_kobjs_lock);
-
-	list_for_each_entry(rkobj, &list, list) {
-		space_info = btrfs_find_space_info(fs_info, rkobj->flags);
-
-		ret = kobject_add(&rkobj->kobj, &space_info->kobj,
-				"%s", btrfs_bg_type_to_raid_name(rkobj->flags));
-		if (ret) {
-			kobject_put(&rkobj->kobj);
-			break;
-		}
-	}
-	if (ret)
-		btrfs_warn(fs_info,
-			   "failed to add kobject for block cache, ignoring");
-}
-
 static void link_block_group(struct btrfs_block_group_cache *cache)
 {
 	struct btrfs_space_info *space_info = cache->space_info;
@@ -7929,18 +7903,36 @@ static void link_block_group(struct btrfs_block_group_cache *cache)
 	up_write(&space_info->groups_sem);
 
 	if (first) {
-		struct raid_kobject *rkobj = kzalloc(sizeof(*rkobj), GFP_NOFS);
+		struct raid_kobject *rkobj;
+		unsigned int nofs_flag;
+		int ret;
+
+		/*
+		 * Setup a NOFS context because kobject_add(), deep in its call
+		 * chain, does GFP_KERNEL allocations, and we are often called
+		 * in a context where if reclaim is triggered we can deadlock
+		 * (we are either holding a transaction handle or some lock
+		 * required for a transaction commit).
+		 */
+		nofs_flag = memalloc_nofs_save();
+		rkobj = kzalloc(sizeof(*rkobj), GFP_KERNEL);
 		if (!rkobj) {
+			memalloc_nofs_restore(nofs_flag);
 			btrfs_warn(cache->fs_info,
 				"couldn't alloc memory for raid level kobject");
 			return;
 		}
 		rkobj->flags = cache->flags;
 		kobject_init(&rkobj->kobj, &btrfs_raid_ktype);
-
-		spin_lock(&fs_info->pending_raid_kobjs_lock);
-		list_add_tail(&rkobj->list, &fs_info->pending_raid_kobjs);
-		spin_unlock(&fs_info->pending_raid_kobjs_lock);
+		ret = kobject_add(&rkobj->kobj, &space_info->kobj, "%s",
+				  btrfs_bg_type_to_raid_name(rkobj->flags));
+		memalloc_nofs_restore(nofs_flag);
+		if (ret) {
+			kobject_put(&rkobj->kobj);
+			btrfs_warn(fs_info,
+			   "failed to add kobject for block cache, ignoring");
+			return;
+		}
 		space_info->block_group_kobjs[index] = &rkobj->kobj;
 	}
 }
@@ -8206,7 +8198,6 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 			inc_block_group_ro(cache, 1);
 	}
 
-	btrfs_add_raid_kobjects(info);
 	btrfs_init_global_block_rsv(info);
 	ret = check_chunk_block_group_mappings(info);
 error:
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d74b74ca07af..a447d3ec48d5 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3087,16 +3087,6 @@ static int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
 	if (ret)
 		return ret;
 
-	/*
-	 * We add the kobjects here (and after forcing data chunk creation)
-	 * since relocation is the only place we'll create chunks of a new
-	 * type at runtime.  The only place where we'll remove the last
-	 * chunk of a type is the call immediately below this one.  Even
-	 * so, we're protected against races with the cleaner thread since
-	 * we're covered by the delete_unused_bgs_mutex.
-	 */
-	btrfs_add_raid_kobjects(fs_info);
-
 	trans = btrfs_start_trans_remove_block_group(root->fs_info,
 						     chunk_offset);
 	if (IS_ERR(trans)) {
@@ -3223,9 +3213,6 @@ static int btrfs_may_alloc_data_chunk(struct btrfs_fs_info *fs_info,
 			btrfs_end_transaction(trans);
 			if (ret < 0)
 				return ret;
-
-			btrfs_add_raid_kobjects(fs_info);
-
 			return 1;
 		}
 	}
-- 
2.11.0

