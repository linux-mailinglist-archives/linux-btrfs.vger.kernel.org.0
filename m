Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C5325A0E6
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Sep 2020 23:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbgIAVkx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Sep 2020 17:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729633AbgIAVks (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Sep 2020 17:40:48 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE23AC061246
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Sep 2020 14:40:47 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id n10so2136592qtv.3
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Sep 2020 14:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5VSFYOsDHd2RCkTdW+95XiomggfzBXm6DzQAtakMrhc=;
        b=DGPzuaioXIxPNBzXZsGS45u9UNavFaVlmrcwBOQs5xFhwnZR8CVqhdnOp6v4bV/LQK
         OlOe1X4G9otH0mIyJOyMmXDyS55ezjrFImWt6nel1TkakwohruSDW99fDbTP3wKJ/HSe
         B8TLy+P12WHp451qv0xUfL/u8DokbBv1aFbfDJ52ZHlIOKEDjeIFAhWqhNS52Ath//Ca
         w4Kd+RpgeVxww5ASJsociZjvE76boxAsVsFmoAiIQxw+3ar+RRWSuNDLW6CmaSMTZbbx
         CNvupEnm+D7LvYoyFv4FXKDZ9wCHZfYdcaScyFMKh4mNgQCQA6lE/UypexDsfduDXBAY
         45uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5VSFYOsDHd2RCkTdW+95XiomggfzBXm6DzQAtakMrhc=;
        b=TA3TaZa85SXEM43xXhcmAP5K2Z9sUZ9ihSquFiU/bXfV/ltJMSohjCHrU518G+3OLz
         ykA1Qu5L7mErik5r52zfZpqmzsti0Z4kfQUHjmnX/V2bA5J7wtXUc3ESjPUmyCiavqDV
         2pN0KX65fyPsHTQzpbTlZ0rO7odomVPCX7GnIx5OoijrOuKCGb9vm6QgjtYWicFDdWy2
         82NOpouz+CM+6UTJOu2L7RXKCGeBdSRh00eGWJRlgJF3nzGg7hafUy+c8vLC4lCDv5Bd
         1yqSUMMXLkIBytyn1hE0i9/evn3XLNNcta3eXf+JgayPqZo+u3JXkf/owrUjYbERYeLe
         yGrw==
X-Gm-Message-State: AOAM530Gj+Bqi0PtlZMe2KgQapjXsgFyRd/ZB8iTPGZBwwfn7iKlmrdP
        D551c65/K9p3QRSFMu0qFUvVNFI2ppW5yI3u
X-Google-Smtp-Source: ABdhPJyxapj57rEae1xcVTMAwUpjW44cPxt2+ngsHnca/HGnvhcFGIoyTZyy+NNbHTL/nnhDw0aMRA==
X-Received: by 2002:aed:2767:: with SMTP id n94mr4068598qtd.237.1598996446472;
        Tue, 01 Sep 2020 14:40:46 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w36sm3130108qtc.48.2020.09.01.14.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 14:40:45 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/4] btrfs: do not create raid sysfs entries under any locks
Date:   Tue,  1 Sep 2020 17:40:38 -0400
Message-Id: <2f140cd79a9738e72fc6da6ef4ba3635962dbf9c.1598996236.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1598996236.git.josef@toxicpanda.com>
References: <cover.1598996236.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While running xfstests btrfs/177 I got the following lockdep splat

======================================================
WARNING: possible circular locking dependency detected
5.9.0-rc3+ #5 Not tainted
------------------------------------------------------
kswapd0/100 is trying to acquire lock:
ffff97066aa56760 (&delayed_node->mutex){+.+.}-{3:3}, at: __btrfs_release_delayed_node.part.0+0x3f/0x330

but task is already holding lock:
ffffffff9fd74700 (fs_reclaim){+.+.}-{0:0}, at: __fs_reclaim_acquire+0x5/0x30

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #3 (fs_reclaim){+.+.}-{0:0}:
       fs_reclaim_acquire+0x65/0x80
       slab_pre_alloc_hook.constprop.0+0x20/0x200
       kmem_cache_alloc+0x37/0x270
       alloc_inode+0x82/0xb0
       iget_locked+0x10d/0x2c0
       kernfs_get_inode+0x1b/0x130
       kernfs_get_tree+0x136/0x240
       sysfs_get_tree+0x16/0x40
       vfs_get_tree+0x28/0xc0
       path_mount+0x434/0xc00
       __x64_sys_mount+0xe3/0x120
       do_syscall_64+0x33/0x40
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #2 (kernfs_mutex){+.+.}-{3:3}:
       __mutex_lock+0x7e/0x7e0
       kernfs_add_one+0x23/0x150
       kernfs_create_dir_ns+0x7a/0xb0
       sysfs_create_dir_ns+0x60/0xb0
       kobject_add_internal+0xc0/0x2c0
       kobject_add+0x6e/0x90
       btrfs_sysfs_add_block_group_type+0x102/0x160
       btrfs_make_block_group+0x167/0x230
       btrfs_alloc_chunk+0x54f/0xb80
       btrfs_chunk_alloc+0x18e/0x3a0
       find_free_extent+0xdf6/0x1210
       btrfs_reserve_extent+0xb3/0x1b0
       btrfs_alloc_tree_block+0xb0/0x310
       alloc_tree_block_no_bg_flush+0x4a/0x60
       __btrfs_cow_block+0x11a/0x530
       btrfs_cow_block+0x104/0x220
       btrfs_search_slot+0x52e/0x9d0
       btrfs_insert_empty_items+0x64/0xb0
       btrfs_new_inode+0x225/0x730
       btrfs_create+0xab/0x1f0
       lookup_open.isra.0+0x52d/0x690
       path_openat+0x2a7/0x9e0
       do_filp_open+0x75/0x100
       do_sys_openat2+0x7b/0x130
       __x64_sys_openat+0x46/0x70
       do_syscall_64+0x33/0x40
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #1 (&fs_info->chunk_mutex){+.+.}-{3:3}:
       __mutex_lock+0x7e/0x7e0
       btrfs_chunk_alloc+0x125/0x3a0
       find_free_extent+0xdf6/0x1210
       btrfs_reserve_extent+0xb3/0x1b0
       btrfs_alloc_tree_block+0xb0/0x310
       alloc_tree_block_no_bg_flush+0x4a/0x60
       __btrfs_cow_block+0x11a/0x530
       btrfs_cow_block+0x104/0x220
       btrfs_search_slot+0x52e/0x9d0
       btrfs_lookup_inode+0x2a/0x8f
       __btrfs_update_delayed_inode+0x80/0x240
       btrfs_commit_inode_delayed_inode+0x119/0x120
       btrfs_evict_inode+0x357/0x500
       evict+0xcf/0x1f0
       do_unlinkat+0x1a9/0x2b0
       do_syscall_64+0x33/0x40
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #0 (&delayed_node->mutex){+.+.}-{3:3}:
       __lock_acquire+0x119c/0x1fc0
       lock_acquire+0xa7/0x3d0
       __mutex_lock+0x7e/0x7e0
       __btrfs_release_delayed_node.part.0+0x3f/0x330
       btrfs_evict_inode+0x24c/0x500
       evict+0xcf/0x1f0
       dispose_list+0x48/0x70
       prune_icache_sb+0x44/0x50
       super_cache_scan+0x161/0x1e0
       do_shrink_slab+0x178/0x3c0
       shrink_slab+0x17c/0x290
       shrink_node+0x2b2/0x6d0
       balance_pgdat+0x30a/0x670
       kswapd+0x213/0x4c0
       kthread+0x138/0x160
       ret_from_fork+0x1f/0x30

other info that might help us debug this:

Chain exists of:
  &delayed_node->mutex --> kernfs_mutex --> fs_reclaim

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(kernfs_mutex);
                               lock(fs_reclaim);
  lock(&delayed_node->mutex);

 *** DEADLOCK ***

3 locks held by kswapd0/100:
 #0: ffffffff9fd74700 (fs_reclaim){+.+.}-{0:0}, at: __fs_reclaim_acquire+0x5/0x30
 #1: ffffffff9fd65c50 (shrinker_rwsem){++++}-{3:3}, at: shrink_slab+0x115/0x290
 #2: ffff9706629780e0 (&type->s_umount_key#36){++++}-{3:3}, at: super_cache_scan+0x38/0x1e0

stack backtrace:
CPU: 1 PID: 100 Comm: kswapd0 Not tainted 5.9.0-rc3+ #5
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
Call Trace:
 dump_stack+0x8b/0xb8
 check_noncircular+0x12d/0x150
 __lock_acquire+0x119c/0x1fc0
 lock_acquire+0xa7/0x3d0
 ? __btrfs_release_delayed_node.part.0+0x3f/0x330
 __mutex_lock+0x7e/0x7e0
 ? __btrfs_release_delayed_node.part.0+0x3f/0x330
 ? __btrfs_release_delayed_node.part.0+0x3f/0x330
 ? lock_acquire+0xa7/0x3d0
 ? find_held_lock+0x2b/0x80
 __btrfs_release_delayed_node.part.0+0x3f/0x330
 btrfs_evict_inode+0x24c/0x500
 evict+0xcf/0x1f0
 dispose_list+0x48/0x70
 prune_icache_sb+0x44/0x50
 super_cache_scan+0x161/0x1e0
 do_shrink_slab+0x178/0x3c0
 shrink_slab+0x17c/0x290
 shrink_node+0x2b2/0x6d0
 balance_pgdat+0x30a/0x670
 kswapd+0x213/0x4c0
 ? _raw_spin_unlock_irqrestore+0x41/0x50
 ? add_wait_queue_exclusive+0x70/0x70
 ? balance_pgdat+0x670/0x670
 kthread+0x138/0x160
 ? kthread_create_worker_on_cpu+0x40/0x40
 ret_from_fork+0x1f/0x30

This happens because when we link in a block group with a new raid index
type we'll create the corresponding sysfs entries for it.  This is
problematic because while restriping we're holding the chunk_mutex, and
while mounting we're holding the tree locks.

Fixing this isn't pretty, we move the call to the sysfs stuff into the
btrfs_create_pending_block_groups() work, where we're not holding any
locks.  This creates a slight race where other threads could see that
there's no sysfs kobj for that raid type, and race to create the
syfsdir.  Fix this by wrapping the creation in space_info->lock, so we
only get one person calling kobject_add() for the new directory.  We
don't worry about the lock on cleanup as it only gets deleted on
unmount.

On mount it's more straightforward, we loop through the space_info's
already, just check every raid index in each space_info and added the
sysfs entries for the corresponding block groups.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 31 +++++++++++++++++++++++++------
 fs/btrfs/sysfs.c       | 25 +++++++++++++++++++++++--
 2 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index a3b27204371c..2dbdf6ef568e 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1766,16 +1766,10 @@ static void link_block_group(struct btrfs_block_group *cache)
 {
 	struct btrfs_space_info *space_info = cache->space_info;
 	int index = btrfs_bg_flags_to_raid_index(cache->flags);
-	bool first = false;
 
 	down_write(&space_info->groups_sem);
-	if (list_empty(&space_info->block_groups[index]))
-		first = true;
 	list_add_tail(&cache->list, &space_info->block_groups[index]);
 	up_write(&space_info->groups_sem);
-
-	if (first)
-		btrfs_sysfs_add_block_group_type(cache);
 }
 
 static struct btrfs_block_group *btrfs_create_block_group_cache(
@@ -2032,6 +2026,17 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 	}
 
 	list_for_each_entry(space_info, &info->space_info, list) {
+		int i;
+
+		for (i = 0; i < BTRFS_NR_RAID_TYPES; i++) {
+			if (list_empty(&space_info->block_groups[i]))
+				continue;
+			cache = list_first_entry(&space_info->block_groups[i],
+						 struct btrfs_block_group,
+						 list);
+			btrfs_sysfs_add_block_group_type(cache);
+		}
+
 		if (!(btrfs_get_alloc_profile(info, space_info->flags) &
 		      (BTRFS_BLOCK_GROUP_RAID10 |
 		       BTRFS_BLOCK_GROUP_RAID1_MASK |
@@ -2091,12 +2096,16 @@ void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
 		return;
 
 	while (!list_empty(&trans->new_bgs)) {
+		int index;
+
 		block_group = list_first_entry(&trans->new_bgs,
 					       struct btrfs_block_group,
 					       bg_list);
 		if (ret)
 			goto next;
 
+		index = btrfs_bg_flags_to_raid_index(block_group->flags);
+
 		ret = insert_block_group_item(trans, block_group);
 		if (ret)
 			btrfs_abort_transaction(trans, ret);
@@ -2105,6 +2114,16 @@ void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
 		if (ret)
 			btrfs_abort_transaction(trans, ret);
 		add_block_group_free_space(trans, block_group);
+
+		/*
+		 * If we restriped we may have added a new raid type, so now add
+		 * the sysfs entries when it is safe to do so.  We don't have to
+		 * worry about locking here as it's handled in
+		 * btrfs_sysfs_add_block_group_type.
+		 */
+		if (block_group->space_info->block_group_kobjs[index] == NULL)
+			btrfs_sysfs_add_block_group_type(block_group);
+
 		/* Already aborted the transaction if it failed. */
 next:
 		btrfs_delayed_refs_rsv_release(fs_info, 1);
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 190e59152be5..89005f51bab8 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1077,17 +1077,38 @@ void btrfs_sysfs_add_block_group_type(struct btrfs_block_group *cache)
 
 	rkobj->flags = cache->flags;
 	kobject_init(&rkobj->kobj, &btrfs_raid_ktype);
+
+	/*
+	 * We call this either on mount, or if we've created a block group for a
+	 * new index type while running (i.e. when restriping).  The running
+	 * case is tricky because we could race with other threads, so we need
+	 * to have this check to make sure we didn't already init the kobject.
+	 *
+	 * We don't have to protect on the free side because it only happens on
+	 * unmount.
+	 */
+	spin_lock(&space_info->lock);
+	if (space_info->block_group_kobjs[index]) {
+		spin_unlock(&space_info->lock);
+		kobject_put(&rkobj->kobj);
+		return;
+	} else {
+		space_info->block_group_kobjs[index] = &rkobj->kobj;
+	}
+	spin_unlock(&space_info->lock);
+
 	ret = kobject_add(&rkobj->kobj, &space_info->kobj, "%s",
 			  btrfs_bg_type_to_raid_name(rkobj->flags));
 	memalloc_nofs_restore(nofs_flag);
 	if (ret) {
+		spin_lock(&space_info->lock);
+		space_info->block_group_kobjs[index] = NULL;
+		spin_unlock(&space_info->lock);
 		kobject_put(&rkobj->kobj);
 		btrfs_warn(fs_info,
 			"failed to add kobject for block cache, ignoring");
 		return;
 	}
-
-	space_info->block_group_kobjs[index] = &rkobj->kobj;
 }
 
 /*
-- 
2.26.2

