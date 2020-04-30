Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC561C02EB
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Apr 2020 18:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgD3QoJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Apr 2020 12:44:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:42678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgD3QoJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Apr 2020 12:44:09 -0400
Received: from debian6.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08C892070B;
        Thu, 30 Apr 2020 16:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588265048;
        bh=itlGEbCpJRZA7y4n3grFoRm1zB9iiGXPu4z23uNwDaE=;
        h=From:To:Cc:Subject:Date:From;
        b=QMukbhm6RIftUESyOKjXUPksCi/OK4aij4VRxzQsIhTBu67PvefnnDHGCzdmnPe6g
         OQLEmidF/IHfzAm2M42AyQlQR2scMLcLw5a2T6m71kz2GhTq1EMxRELnmRa8yo0eOW
         Zmf9mSCCaI6FkGOZ/7zKFcz+0xugg+u2qUVH5byE=
From:   fdmanana@kernel.org
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, akpm@linux-foundation.org,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] percpu: make pcpu_alloc() aware of current gfp context
Date:   Thu, 30 Apr 2020 17:43:56 +0100
Message-Id: <20200430164356.15543-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Since 5.7-rc1, on btrfs we have a percpu counter initialization for which
we always pass a GFP_KERNEL gfp_t argument (this happens since commit
2992df73268f78 ("btrfs: Implement DREW lock")).  That is safe in some
contextes but not on others where allowing fs reclaim could lead to a
deadlock because we are either holding some btrfs lock needed for a
transaction commit or holding a btrfs transaction handle open.  Because
of that we surround the call to the function that initializes the percpu
counter with a NOFS context using memalloc_nofs_save() (this is done at
btrfs_init_fs_root()).

However it turns out that this is not enough to prevent a possible
deadlock because percpu_alloc() determines if it is in an atomic context
by looking exclusively at the gfp flags passed to it (GFP_KERNEL in this
case) and it is not aware that a NOFS context is set.  Because it thinks
it is in a non atomic context it locks the pcpu_alloc_mutex, which can
result in a btrfs deadlock when pcpu_balance_workfn() is running, has
acquired that mutex and is waiting for reclaim, while the btrfs task that
called percpu_counter_init() (and therefore percpu_alloc()) is holding
either the btrfs commit_root semaphore or a transaction handle (done at
fs/btrfs/backref.c:iterate_extent_inodes()), which prevents reclaim from
finishing as an attempt to commit the current btrfs transaction will
deadlock.

Lockdep reports this issue with the following trace:

[ 1402.960494] ======================================================
[ 1402.961610] WARNING: possible circular locking dependency detected
[ 1402.962711] 5.6.0-rc7-btrfs-next-77 #1 Not tainted
[ 1402.963639] ------------------------------------------------------
[ 1402.964686] kswapd0/91 is trying to acquire lock:
[ 1402.965505] ffff8938a3b3fdc8 (&delayed_node->mutex){+.+.}, at: __btrfs_release_delayed_node.part.0+0x3f/0x320 [btrfs]
[ 1402.966904]
               but task is already holding lock:
[ 1402.967641] ffffffffb4f0dbc0 (fs_reclaim){+.+.}, at: __fs_reclaim_acquire+0x5/0x30
[ 1402.968580]
               which lock already depends on the new lock.

[ 1402.969581]
               the existing dependency chain (in reverse order) is:
[ 1402.970542]
               -> #4 (fs_reclaim){+.+.}:
[ 1402.971339]        fs_reclaim_acquire.part.0+0x25/0x30
[ 1402.972055]        __kmalloc+0x5f/0x3a0
[ 1402.972691]        pcpu_create_chunk+0x19/0x230
[ 1402.973493]        pcpu_balance_workfn+0x56a/0x680
[ 1402.974346]        process_one_work+0x235/0x5f0
[ 1402.975150]        worker_thread+0x50/0x3b0
[ 1402.975862]        kthread+0x120/0x140
[ 1402.976518]        ret_from_fork+0x3a/0x50
[ 1402.977228]
               -> #3 (pcpu_alloc_mutex){+.+.}:
[ 1402.978203]        __mutex_lock+0xa9/0xaf0
[ 1402.978909]        pcpu_alloc+0x480/0x7c0
[ 1402.979561]        __percpu_counter_init+0x50/0xd0
[ 1402.980176]        btrfs_drew_lock_init+0x22/0x70 [btrfs]
[ 1402.980855]        btrfs_get_fs_root+0x29c/0x5c0 [btrfs]
[ 1402.981610]        resolve_indirect_refs+0x120/0xa30 [btrfs]
[ 1402.982342]        find_parent_nodes+0x50b/0xf30 [btrfs]
[ 1402.983021]        btrfs_find_all_leafs+0x60/0xb0 [btrfs]
[ 1402.983702]        iterate_extent_inodes+0x139/0x2f0 [btrfs]
[ 1402.984410]        iterate_inodes_from_logical+0xa1/0xe0 [btrfs]
[ 1402.985158]        btrfs_ioctl_logical_to_ino+0xb4/0x190 [btrfs]
[ 1402.985906]        btrfs_ioctl+0x165a/0x3130 [btrfs]
[ 1402.986521]        ksys_ioctl+0x87/0xc0
[ 1402.987001]        __x64_sys_ioctl+0x16/0x20
[ 1402.987599]        do_syscall_64+0x5c/0x260
[ 1402.988157]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 1402.988957]
               -> #2 (&fs_info->commit_root_sem){++++}:
[ 1402.989990]        down_write+0x38/0x70
[ 1402.990516]        btrfs_cache_block_group+0x2ec/0x500 [btrfs]
[ 1402.991262]        find_free_extent+0xc6a/0x1600 [btrfs]
[ 1402.991934]        btrfs_reserve_extent+0x9b/0x180 [btrfs]
[ 1402.992623]        btrfs_alloc_tree_block+0xc1/0x350 [btrfs]
[ 1402.993335]        alloc_tree_block_no_bg_flush+0x4a/0x60 [btrfs]
[ 1402.994092]        __btrfs_cow_block+0x122/0x5a0 [btrfs]
[ 1402.994755]        btrfs_cow_block+0x106/0x240 [btrfs]
[ 1402.995398]        commit_cowonly_roots+0x55/0x310 [btrfs]
[ 1402.996081]        btrfs_commit_transaction+0x509/0xb20 [btrfs]
[ 1402.996813]        sync_filesystem+0x74/0x90
[ 1402.997339]        generic_shutdown_super+0x22/0x100
[ 1402.997962]        kill_anon_super+0x14/0x30
[ 1402.998536]        btrfs_kill_super+0x12/0x20 [btrfs]
[ 1402.999265]        deactivate_locked_super+0x31/0x70
[ 1402.999877]        cleanup_mnt+0x100/0x160
[ 1403.000386]        task_work_run+0x93/0xc0
[ 1403.000896]        exit_to_usermode_loop+0xf9/0x100
[ 1403.001499]        do_syscall_64+0x20d/0x260
[ 1403.002028]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 1403.002714]
               -> #1 (&space_info->groups_sem){++++}:
[ 1403.003484]        down_read+0x3c/0x140
[ 1403.004021]        find_free_extent+0xef6/0x1600 [btrfs]
[ 1403.004742]        btrfs_reserve_extent+0x9b/0x180 [btrfs]
[ 1403.005473]        btrfs_alloc_tree_block+0xc1/0x350 [btrfs]
[ 1403.006207]        alloc_tree_block_no_bg_flush+0x4a/0x60 [btrfs]
[ 1403.006991]        __btrfs_cow_block+0x122/0x5a0 [btrfs]
[ 1403.007705]        btrfs_cow_block+0x106/0x240 [btrfs]
[ 1403.008454]        btrfs_search_slot+0x50c/0xd60 [btrfs]
[ 1403.009154]        btrfs_lookup_inode+0x3a/0xc0 [btrfs]
[ 1403.009924]        __btrfs_update_delayed_inode+0x90/0x280 [btrfs]
[ 1403.010797]        __btrfs_commit_inode_delayed_items+0x81f/0x870 [btrfs]
[ 1403.011649]        __btrfs_run_delayed_items+0x8e/0x180 [btrfs]
[ 1403.012391]        btrfs_commit_transaction+0x31b/0xb20 [btrfs]
[ 1403.013126]        iterate_supers+0x87/0xf0
[ 1403.013713]        ksys_sync+0x60/0xb0
[ 1403.014263]        __ia32_sys_sync+0xa/0x10
[ 1403.014909]        do_syscall_64+0x5c/0x260
[ 1403.015622]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 1403.016733]
               -> #0 (&delayed_node->mutex){+.+.}:
[ 1403.017644]        __lock_acquire+0xef0/0x1c80
[ 1403.018194]        lock_acquire+0xa2/0x1d0
[ 1403.018744]        __mutex_lock+0xa9/0xaf0
[ 1403.019274]        __btrfs_release_delayed_node.part.0+0x3f/0x320 [btrfs]
[ 1403.020211]        btrfs_evict_inode+0x40d/0x560 [btrfs]
[ 1403.021071]        evict+0xd9/0x1c0
[ 1403.021627]        dispose_list+0x48/0x70
[ 1403.022209]        prune_icache_sb+0x54/0x80
[ 1403.022781]        super_cache_scan+0x124/0x1a0
[ 1403.023469]        do_shrink_slab+0x176/0x440
[ 1403.024245]        shrink_slab+0x23a/0x2c0
[ 1403.024984]        shrink_node+0x188/0x6e0
[ 1403.025702]        balance_pgdat+0x31d/0x7f0
[ 1403.026445]        kswapd+0x238/0x550
[ 1403.027066]        kthread+0x120/0x140
[ 1403.027533]        ret_from_fork+0x3a/0x50
[ 1403.028043]
               other info that might help us debug this:

[ 1403.029024] Chain exists of:
                 &delayed_node->mutex --> pcpu_alloc_mutex --> fs_reclaim

[ 1403.030359]  Possible unsafe locking scenario:

[ 1403.031335]        CPU0                    CPU1
[ 1403.031866]        ----                    ----
[ 1403.032459]   lock(fs_reclaim);
[ 1403.032840]                                lock(pcpu_alloc_mutex);
[ 1403.033462]                                lock(fs_reclaim);
[ 1403.034030]   lock(&delayed_node->mutex);
[ 1403.034466]
                *** DEADLOCK ***

[ 1403.035053] 3 locks held by kswapd0/91:
[ 1403.035505]  #0: ffffffffb4f0dbc0 (fs_reclaim){+.+.}, at: __fs_reclaim_acquire+0x5/0x30
[ 1403.036964]  #1: ffffffffb4ef6ce8 (shrinker_rwsem){++++}, at: shrink_slab+0x12f/0x2c0
[ 1403.038120]  #2: ffff8938ae0490d8 (&type->s_umount_key#43){++++}, at: trylock_super+0x16/0x50
[ 1403.039284]
               stack backtrace:
[ 1403.040092] CPU: 1 PID: 91 Comm: kswapd0 Not tainted 5.6.0-rc7-btrfs-next-77 #1
[ 1403.041024] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
[ 1403.042441] Call Trace:
[ 1403.042784]  dump_stack+0x8f/0xd0
[ 1403.043224]  check_noncircular+0x170/0x190
[ 1403.043968]  __lock_acquire+0xef0/0x1c80
[ 1403.044762]  lock_acquire+0xa2/0x1d0
[ 1403.045476]  ? __btrfs_release_delayed_node.part.0+0x3f/0x320 [btrfs]
[ 1403.046685]  __mutex_lock+0xa9/0xaf0
[ 1403.047402]  ? __btrfs_release_delayed_node.part.0+0x3f/0x320 [btrfs]
[ 1403.048639]  ? __lock_acquire+0x126e/0x1c80
[ 1403.049472]  ? __btrfs_release_delayed_node.part.0+0x3f/0x320 [btrfs]
[ 1403.050672]  ? find_held_lock+0x2b/0x80
[ 1403.051419]  ? __btrfs_release_delayed_node.part.0+0x3f/0x320 [btrfs]
[ 1403.052655]  __btrfs_release_delayed_node.part.0+0x3f/0x320 [btrfs]
[ 1403.053872]  btrfs_evict_inode+0x40d/0x560 [btrfs]
[ 1403.054876]  evict+0xd9/0x1c0
[ 1403.055452]  dispose_list+0x48/0x70
[ 1403.056118]  prune_icache_sb+0x54/0x80
[ 1403.056842]  super_cache_scan+0x124/0x1a0
[ 1403.057576]  do_shrink_slab+0x176/0x440
[ 1403.058227]  shrink_slab+0x23a/0x2c0
[ 1403.058912]  shrink_node+0x188/0x6e0
[ 1403.059592]  balance_pgdat+0x31d/0x7f0
[ 1403.060372]  kswapd+0x238/0x550
[ 1403.060972]  ? finish_wait+0x90/0x90
[ 1403.061649]  ? balance_pgdat+0x7f0/0x7f0
[ 1403.062391]  kthread+0x120/0x140
[ 1403.062725]  ? kthread_create_worker_on_cpu+0x70/0x70
[ 1403.063226]  ret_from_fork+0x3a/0x50

This could be fixed by making btrfs pass GFP_NOFS instead of GFP_KERNEL to
percpu_counter_init() in contextes where it is not reclaim safe, however
that type of approach is discouraged since memalloc_[nofs|noio]_save()
were introduced.  Therefore this change makes pcpu_alloc() look up into
an existing nofs/noio context before deciding whether it is in an atomic
context or not.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 mm/percpu.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index e9844086b236..f5258d5a9c16 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -80,6 +80,7 @@
 #include <linux/workqueue.h>
 #include <linux/kmemleak.h>
 #include <linux/sched.h>
+#include <linux/sched/mm.h>
 
 #include <asm/cacheflush.h>
 #include <asm/sections.h>
@@ -1557,10 +1558,9 @@ static struct pcpu_chunk *pcpu_chunk_addr_search(void *addr)
 static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
 				 gfp_t gfp)
 {
-	/* whitelisted flags that can be passed to the backing allocators */
-	gfp_t pcpu_gfp = gfp & (GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN);
-	bool is_atomic = (gfp & GFP_KERNEL) != GFP_KERNEL;
-	bool do_warn = !(gfp & __GFP_NOWARN);
+	gfp_t pcpu_gfp;
+	bool is_atomic;
+	bool do_warn;
 	static int warn_limit = 10;
 	struct pcpu_chunk *chunk, *next;
 	const char *err;
@@ -1569,6 +1569,12 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
 	void __percpu *ptr;
 	size_t bits, bit_align;
 
+	gfp = current_gfp_context(gfp);
+	/* whitelisted flags that can be passed to the backing allocators */
+	pcpu_gfp = gfp & (GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN);
+	is_atomic = (gfp & GFP_KERNEL) != GFP_KERNEL;
+	do_warn = !(gfp & __GFP_NOWARN);
+
 	/*
 	 * There is now a minimum allocation size of PCPU_MIN_ALLOC_SIZE,
 	 * therefore alignment must be a minimum of that many bytes.
-- 
2.11.0

