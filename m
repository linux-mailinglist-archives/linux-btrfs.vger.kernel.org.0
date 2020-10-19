Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A476292F12
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Oct 2020 22:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgJSUCj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Oct 2020 16:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgJSUCi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Oct 2020 16:02:38 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5E8C0613CE
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Oct 2020 13:02:38 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id a23so757744qkg.13
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Oct 2020 13:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=c5m1L8oH6oATq0CIdT1D+cCkC2hwJmiql8OHjhRJGJA=;
        b=bKBUUF24RcnGmJINVI28wJIDwFaoeptQTa7cG6/HSLB38+SnCerLNBKu5zKWFoO/WC
         vaC81A8vgGFQOgWQfWgRp4dvmal9B5+6W6y3KCLy9nUdNhyNZmMV8VEZp2PJcSre2Wv5
         6X+Ey4hEjt2kriC0jFco8RWNw9ivX5e4SAy8Uf/UslSN+f/xBKIrz5nLjejihXh6Yb10
         hNzL5e35KFGe5hHJ6fNsY8UhaV0lSfxFDLS3Nywi7FvSqTeJXlYubEy6S9VuCqUzhmo9
         o9/1XikPcjduWyPbDiyP/zf2wRbYblmrb+cGLDjReRGKD3VxCbqCxw8QNdVql6mzrRjI
         s7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c5m1L8oH6oATq0CIdT1D+cCkC2hwJmiql8OHjhRJGJA=;
        b=C1ZfA5/WhogPaA1XFpLQ1QHqwHs2+iHM/nMhFGQh1PfMQgRWvd9RIGAtj8sH21tVxT
         qcCUoYti7GIlvbiE/TKNOl4c7JyW0jSKpdPd4KRvWVU7nxxeSAJ9WAsmHp1+PF/Slio1
         RKKk/JtW+7V8PD+H8ERr0icW5nM058QhXsbPt8MVAtNBxDm3KMhbZ22WZbjybF2d34nG
         Hq2bORYzGxRvBXWKf9BB7gSbEWwSULVERu943TVJpUT39gDCC1pl96Iwb6E7dFIeRJN0
         GhxSJLHGd+EyJp4I2HDs7Ewyh5pwF8vw1Yw7wkE6n/TVZ1NELNUk/WPhm37Q1dho1gXB
         NOew==
X-Gm-Message-State: AOAM531+vcfil/2rPkNmGjiWG53wQh6AHsld0TWTJn0soAQAFiHYDD5x
        XLEOgX7GBTW9EZwIRt0dyQorC9fdcehcAmc1
X-Google-Smtp-Source: ABdhPJwitLGxQIIjDWFNF7wwdkG1lxs1/Czz19Y9tOVqdUOg8R9o0VZCeir7ZXRCsA1JD8dAGDbI/w==
X-Received: by 2002:a37:e212:: with SMTP id g18mr1254425qki.366.1603137756816;
        Mon, 19 Oct 2020 13:02:36 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t1sm461259qkh.19.2020.10.19.13.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 13:02:36 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/3] btrfs: protect the fs_info->caching_block_groups differently
Date:   Mon, 19 Oct 2020 16:02:30 -0400
Message-Id: <64816a7abd985112ddd7c44998753f72b5775a1a.1603137558.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603137558.git.josef@toxicpanda.com>
References: <cover.1603137558.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I got the following lockdep splat

======================================================
WARNING: possible circular locking dependency detected
5.9.0+ #101 Not tainted
------------------------------------------------------
btrfs-cleaner/3445 is trying to acquire lock:
ffff89dbec39ab48 (btrfs-root-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x32/0x170

but task is already holding lock:
ffff89dbeaf28a88 (&fs_info->commit_root_sem){++++}-{3:3}, at: btrfs_find_all_roots+0x41/0x80

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #2 (&fs_info->commit_root_sem){++++}-{3:3}:
       down_write+0x3d/0x70
       btrfs_cache_block_group+0x2d5/0x510
       find_free_extent+0xb6e/0x12f0
       btrfs_reserve_extent+0xb3/0x1b0
       btrfs_alloc_tree_block+0xb1/0x330
       alloc_tree_block_no_bg_flush+0x4f/0x60
       __btrfs_cow_block+0x11d/0x580
       btrfs_cow_block+0x10c/0x220
       commit_cowonly_roots+0x47/0x2e0
       btrfs_commit_transaction+0x595/0xbd0
       sync_filesystem+0x74/0x90
       generic_shutdown_super+0x22/0x100
       kill_anon_super+0x14/0x30
       btrfs_kill_super+0x12/0x20
       deactivate_locked_super+0x36/0xa0
       cleanup_mnt+0x12d/0x190
       task_work_run+0x5c/0xa0
       exit_to_user_mode_prepare+0x1df/0x200
       syscall_exit_to_user_mode+0x54/0x280
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #1 (&space_info->groups_sem){++++}-{3:3}:
       down_read+0x40/0x130
       find_free_extent+0x2ed/0x12f0
       btrfs_reserve_extent+0xb3/0x1b0
       btrfs_alloc_tree_block+0xb1/0x330
       alloc_tree_block_no_bg_flush+0x4f/0x60
       __btrfs_cow_block+0x11d/0x580
       btrfs_cow_block+0x10c/0x220
       commit_cowonly_roots+0x47/0x2e0
       btrfs_commit_transaction+0x595/0xbd0
       sync_filesystem+0x74/0x90
       generic_shutdown_super+0x22/0x100
       kill_anon_super+0x14/0x30
       btrfs_kill_super+0x12/0x20
       deactivate_locked_super+0x36/0xa0
       cleanup_mnt+0x12d/0x190
       task_work_run+0x5c/0xa0
       exit_to_user_mode_prepare+0x1df/0x200
       syscall_exit_to_user_mode+0x54/0x280
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #0 (btrfs-root-00){++++}-{3:3}:
       __lock_acquire+0x1167/0x2150
       lock_acquire+0xb9/0x3d0
       down_read_nested+0x43/0x130
       __btrfs_tree_read_lock+0x32/0x170
       __btrfs_read_lock_root_node+0x3a/0x50
       btrfs_search_slot+0x614/0x9d0
       btrfs_find_root+0x35/0x1b0
       btrfs_read_tree_root+0x61/0x120
       btrfs_get_root_ref+0x14b/0x600
       find_parent_nodes+0x3e6/0x1b30
       btrfs_find_all_roots_safe+0xb4/0x130
       btrfs_find_all_roots+0x60/0x80
       btrfs_qgroup_trace_extent_post+0x27/0x40
       btrfs_add_delayed_data_ref+0x3fd/0x460
       btrfs_free_extent+0x42/0x100
       __btrfs_mod_ref+0x1d7/0x2f0
       walk_up_proc+0x11c/0x400
       walk_up_tree+0xf0/0x180
       btrfs_drop_snapshot+0x1c7/0x780
       btrfs_clean_one_deleted_snapshot+0xfb/0x110
       cleaner_kthread+0xd4/0x140
       kthread+0x13a/0x150
       ret_from_fork+0x1f/0x30

other info that might help us debug this:

Chain exists of:
  btrfs-root-00 --> &space_info->groups_sem --> &fs_info->commit_root_sem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&fs_info->commit_root_sem);
                               lock(&space_info->groups_sem);
                               lock(&fs_info->commit_root_sem);
  lock(btrfs-root-00);

 *** DEADLOCK ***

3 locks held by btrfs-cleaner/3445:
 #0: ffff89dbeaf28838 (&fs_info->cleaner_mutex){+.+.}-{3:3}, at: cleaner_kthread+0x6e/0x140
 #1: ffff89dbeb6c7640 (sb_internal){.+.+}-{0:0}, at: start_transaction+0x40b/0x5c0
 #2: ffff89dbeaf28a88 (&fs_info->commit_root_sem){++++}-{3:3}, at: btrfs_find_all_roots+0x41/0x80

stack backtrace:
CPU: 0 PID: 3445 Comm: btrfs-cleaner Not tainted 5.9.0+ #101
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-2.fc32 04/01/2014
Call Trace:
 dump_stack+0x8b/0xb0
 check_noncircular+0xcf/0xf0
 __lock_acquire+0x1167/0x2150
 ? __bfs+0x42/0x210
 lock_acquire+0xb9/0x3d0
 ? __btrfs_tree_read_lock+0x32/0x170
 down_read_nested+0x43/0x130
 ? __btrfs_tree_read_lock+0x32/0x170
 __btrfs_tree_read_lock+0x32/0x170
 __btrfs_read_lock_root_node+0x3a/0x50
 btrfs_search_slot+0x614/0x9d0
 ? find_held_lock+0x2b/0x80
 btrfs_find_root+0x35/0x1b0
 ? do_raw_spin_unlock+0x4b/0xa0
 btrfs_read_tree_root+0x61/0x120
 btrfs_get_root_ref+0x14b/0x600
 find_parent_nodes+0x3e6/0x1b30
 btrfs_find_all_roots_safe+0xb4/0x130
 btrfs_find_all_roots+0x60/0x80
 btrfs_qgroup_trace_extent_post+0x27/0x40
 btrfs_add_delayed_data_ref+0x3fd/0x460
 btrfs_free_extent+0x42/0x100
 __btrfs_mod_ref+0x1d7/0x2f0
 walk_up_proc+0x11c/0x400
 walk_up_tree+0xf0/0x180
 btrfs_drop_snapshot+0x1c7/0x780
 ? btrfs_clean_one_deleted_snapshot+0x73/0x110
 btrfs_clean_one_deleted_snapshot+0xfb/0x110
 cleaner_kthread+0xd4/0x140
 ? btrfs_alloc_root+0x50/0x50
 kthread+0x13a/0x150
 ? kthread_create_worker_on_cpu+0x40/0x40
 ret_from_fork+0x1f/0x30

while testing another lockdep fix.  This happens because we're using the
commit_root_sem to protect fs_info->caching_block_groups, which creates
a dependency on the groups_sem -> commit_root_sem, which is problematic
because we will allocate blocks while holding tree roots.  Fix this by
making the list itself protected by the fs_info->block_group_cache_lock.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 12 ++++++------
 fs/btrfs/extent-tree.c |  2 ++
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 3ba6f3839d39..a8240913e6fc 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -796,10 +796,10 @@ int btrfs_cache_block_group(struct btrfs_block_group *cache, int load_cache_only
 		return 0;
 	}
 
-	down_write(&fs_info->commit_root_sem);
+	spin_lock(&fs_info->block_group_cache_lock);
 	refcount_inc(&caching_ctl->count);
 	list_add_tail(&caching_ctl->list, &fs_info->caching_block_groups);
-	up_write(&fs_info->commit_root_sem);
+	spin_unlock(&fs_info->block_group_cache_lock);
 
 	btrfs_get_block_group(cache);
 
@@ -1043,7 +1043,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	if (block_group->cached == BTRFS_CACHE_STARTED)
 		btrfs_wait_block_group_cache_done(block_group);
 	if (block_group->has_caching_ctl) {
-		down_write(&fs_info->commit_root_sem);
+		spin_lock(&fs_info->block_group_cache_lock);
 		if (!caching_ctl) {
 			struct btrfs_caching_control *ctl;
 
@@ -1057,7 +1057,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 		}
 		if (caching_ctl)
 			list_del_init(&caching_ctl->list);
-		up_write(&fs_info->commit_root_sem);
+		spin_unlock(&fs_info->block_group_cache_lock);
 		if (caching_ctl) {
 			/* Once for the caching bgs list and once for us. */
 			btrfs_put_caching_control(caching_ctl);
@@ -3307,14 +3307,14 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 	struct btrfs_caching_control *caching_ctl;
 	struct rb_node *n;
 
-	down_write(&info->commit_root_sem);
+	spin_lock(&info->block_group_cache_lock);
 	while (!list_empty(&info->caching_block_groups)) {
 		caching_ctl = list_entry(info->caching_block_groups.next,
 					 struct btrfs_caching_control, list);
 		list_del(&caching_ctl->list);
 		btrfs_put_caching_control(caching_ctl);
 	}
-	up_write(&info->commit_root_sem);
+	spin_unlock(&info->block_group_cache_lock);
 
 	spin_lock(&info->unused_bgs_lock);
 	while (!list_empty(&info->unused_bgs)) {
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 5fd60b13f4f8..ff2b5c132a70 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2738,6 +2738,7 @@ void btrfs_prepare_extent_commit(struct btrfs_fs_info *fs_info)
 
 	down_write(&fs_info->commit_root_sem);
 
+	spin_lock(&fs_info->block_group_cache_lock);
 	list_for_each_entry_safe(caching_ctl, next,
 				 &fs_info->caching_block_groups, list) {
 		cache = caching_ctl->block_group;
@@ -2749,6 +2750,7 @@ void btrfs_prepare_extent_commit(struct btrfs_fs_info *fs_info)
 			cache->last_byte_to_unpin = caching_ctl->progress;
 		}
 	}
+	spin_unlock(&fs_info->block_group_cache_lock);
 
 	up_write(&fs_info->commit_root_sem);
 
-- 
2.26.2

