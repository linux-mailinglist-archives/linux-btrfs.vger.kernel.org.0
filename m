Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F1B78C259
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Aug 2023 12:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbjH2Kfb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Aug 2023 06:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbjH2KfA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Aug 2023 06:35:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA2218F
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Aug 2023 03:34:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D90A62BE0
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Aug 2023 10:34:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75EE3C433C8
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Aug 2023 10:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693305297;
        bh=0j0gM3iv6zCa+xuZzC19EJ3+lqjuL1NkXrozQS3Si1Y=;
        h=From:To:Subject:Date:From;
        b=rb0t0l7QNLNEj1GXOT4D4d1iEm04a746PWo35vWTsymr8TTLeoqVNX5fTwAiJ8YDS
         B9+atjAehn+AFdphP4VjDZYnFNh1dGGrIWvT7BnWIWSIFn5EdDMGIBJA+BXdommVe4
         0WyQw1PoK/FpCXQ37jFHwFODZv60r9BMw8gPsVGWPoOO0zmGCy9eRcPBu+2enN7JHX
         NLH1dopyGwS0xofEMPF4rDxY2xbdI7XKVeJuIqXRbirTr0OqAC8hTg/c0/dCmKjCuK
         e4549vuKY6liq91CjtH8U8y/RdEZ7IFOemwE7/wwW4vM7QdQE4FEjk+3EkHTaXrBpe
         G+SuUbxcbaRRA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix lockdep splat and potential deadlock after failure running delayed items
Date:   Tue, 29 Aug 2023 11:34:52 +0100
Message-Id: <23466c29fcce890e0ab16b3b6b072b3c5deb652d.1693304938.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When running delayed items we are holding a delayed node's mutex and then
we will attempt to modify a subvolume btree to insert/update/delete the
delayed items. However if have an error during the insertions for example,
btrfs_insert_delayed_items() may return with a path that has locked extent
buffers (a leaf at the very least), and then we attempt to release the
delayed node at __btrfs_run_delayed_items(), which requires taking the
delayed node's mutex, causing an ABBA type of deadlock. This was reported
by syzbot and the lockdep splat is the following:

  WARNING: possible circular locking dependency detected
  6.5.0-rc7-syzkaller-00024-g93f5de5f648d #0 Not tainted
  ------------------------------------------------------
  syz-executor.2/13257 is trying to acquire lock:
  ffff88801835c0c0 (&delayed_node->mutex){+.+.}-{3:3}, at: __btrfs_release_delayed_node+0x9a/0xaa0 fs/btrfs/delayed-inode.c:256

  but task is already holding lock:
  ffff88802a5ab8e8 (btrfs-tree-00){++++}-{3:3}, at: __btrfs_tree_lock+0x3c/0x2a0 fs/btrfs/locking.c:198

  which lock already depends on the new lock.

  the existing dependency chain (in reverse order) is:

  -> #1 (btrfs-tree-00){++++}-{3:3}:
         __lock_release kernel/locking/lockdep.c:5475 [inline]
         lock_release+0x36f/0x9d0 kernel/locking/lockdep.c:5781
         up_write+0x79/0x580 kernel/locking/rwsem.c:1625
         btrfs_tree_unlock_rw fs/btrfs/locking.h:189 [inline]
         btrfs_unlock_up_safe+0x179/0x3b0 fs/btrfs/locking.c:239
         search_leaf fs/btrfs/ctree.c:1986 [inline]
         btrfs_search_slot+0x2511/0x2f80 fs/btrfs/ctree.c:2230
         btrfs_insert_empty_items+0x9c/0x180 fs/btrfs/ctree.c:4376
         btrfs_insert_delayed_item fs/btrfs/delayed-inode.c:746 [inline]
         btrfs_insert_delayed_items fs/btrfs/delayed-inode.c:824 [inline]
         __btrfs_commit_inode_delayed_items+0xd24/0x2410 fs/btrfs/delayed-inode.c:1111
         __btrfs_run_delayed_items+0x1db/0x430 fs/btrfs/delayed-inode.c:1153
         flush_space+0x269/0xe70 fs/btrfs/space-info.c:723
         btrfs_async_reclaim_metadata_space+0x106/0x350 fs/btrfs/space-info.c:1078
         process_one_work+0x92c/0x12c0 kernel/workqueue.c:2600
         worker_thread+0xa63/0x1210 kernel/workqueue.c:2751
         kthread+0x2b8/0x350 kernel/kthread.c:389
         ret_from_fork+0x2e/0x60 arch/x86/kernel/process.c:145
         ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

  -> #0 (&delayed_node->mutex){+.+.}-{3:3}:
         check_prev_add kernel/locking/lockdep.c:3142 [inline]
         check_prevs_add kernel/locking/lockdep.c:3261 [inline]
         validate_chain kernel/locking/lockdep.c:3876 [inline]
         __lock_acquire+0x39ff/0x7f70 kernel/locking/lockdep.c:5144
         lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5761
         __mutex_lock_common+0x1d8/0x2530 kernel/locking/mutex.c:603
         __mutex_lock kernel/locking/mutex.c:747 [inline]
         mutex_lock_nested+0x1b/0x20 kernel/locking/mutex.c:799
         __btrfs_release_delayed_node+0x9a/0xaa0 fs/btrfs/delayed-inode.c:256
         btrfs_release_delayed_node fs/btrfs/delayed-inode.c:281 [inline]
         __btrfs_run_delayed_items+0x2b5/0x430 fs/btrfs/delayed-inode.c:1156
         btrfs_commit_transaction+0x859/0x2ff0 fs/btrfs/transaction.c:2276
         btrfs_sync_file+0xf56/0x1330 fs/btrfs/file.c:1988
         vfs_fsync_range fs/sync.c:188 [inline]
         vfs_fsync fs/sync.c:202 [inline]
         do_fsync fs/sync.c:212 [inline]
         __do_sys_fsync fs/sync.c:220 [inline]
         __se_sys_fsync fs/sync.c:218 [inline]
         __x64_sys_fsync+0x196/0x1e0 fs/sync.c:218
         do_syscall_x64 arch/x86/entry/common.c:50 [inline]
         do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
         entry_SYSCALL_64_after_hwframe+0x63/0xcd

  other info that might help us debug this:

   Possible unsafe locking scenario:

         CPU0                    CPU1
         ----                    ----
    lock(btrfs-tree-00);
                                 lock(&delayed_node->mutex);
                                 lock(btrfs-tree-00);
    lock(&delayed_node->mutex);

   *** DEADLOCK ***

  3 locks held by syz-executor.2/13257:
   #0: ffff88802c1ee370 (btrfs_trans_num_writers){++++}-{0:0}, at: spin_unlock include/linux/spinlock.h:391 [inline]
   #0: ffff88802c1ee370 (btrfs_trans_num_writers){++++}-{0:0}, at: join_transaction+0xb87/0xe00 fs/btrfs/transaction.c:287
   #1: ffff88802c1ee398 (btrfs_trans_num_extwriters){++++}-{0:0}, at: join_transaction+0xbb2/0xe00 fs/btrfs/transaction.c:288
   #2: ffff88802a5ab8e8 (btrfs-tree-00){++++}-{3:3}, at: __btrfs_tree_lock+0x3c/0x2a0 fs/btrfs/locking.c:198

  stack backtrace:
  CPU: 0 PID: 13257 Comm: syz-executor.2 Not tainted 6.5.0-rc7-syzkaller-00024-g93f5de5f648d #0
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
  Call Trace:
   <TASK>
   __dump_stack lib/dump_stack.c:88 [inline]
   dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
   check_noncircular+0x375/0x4a0 kernel/locking/lockdep.c:2195
   check_prev_add kernel/locking/lockdep.c:3142 [inline]
   check_prevs_add kernel/locking/lockdep.c:3261 [inline]
   validate_chain kernel/locking/lockdep.c:3876 [inline]
   __lock_acquire+0x39ff/0x7f70 kernel/locking/lockdep.c:5144
   lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5761
   __mutex_lock_common+0x1d8/0x2530 kernel/locking/mutex.c:603
   __mutex_lock kernel/locking/mutex.c:747 [inline]
   mutex_lock_nested+0x1b/0x20 kernel/locking/mutex.c:799
   __btrfs_release_delayed_node+0x9a/0xaa0 fs/btrfs/delayed-inode.c:256
   btrfs_release_delayed_node fs/btrfs/delayed-inode.c:281 [inline]
   __btrfs_run_delayed_items+0x2b5/0x430 fs/btrfs/delayed-inode.c:1156
   btrfs_commit_transaction+0x859/0x2ff0 fs/btrfs/transaction.c:2276
   btrfs_sync_file+0xf56/0x1330 fs/btrfs/file.c:1988
   vfs_fsync_range fs/sync.c:188 [inline]
   vfs_fsync fs/sync.c:202 [inline]
   do_fsync fs/sync.c:212 [inline]
   __do_sys_fsync fs/sync.c:220 [inline]
   __se_sys_fsync fs/sync.c:218 [inline]
   __x64_sys_fsync+0x196/0x1e0 fs/sync.c:218
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x63/0xcd
  RIP: 0033:0x7f3ad047cae9
  Code: 28 00 00 00 75 (...)
  RSP: 002b:00007f3ad12510c8 EFLAGS: 00000246 ORIG_RAX: 000000000000004a
  RAX: ffffffffffffffda RBX: 00007f3ad059bf80 RCX: 00007f3ad047cae9
  RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
  RBP: 00007f3ad04c847a R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
  R13: 000000000000000b R14: 00007f3ad059bf80 R15: 00007ffe56af92f8
   </TASK>
  ------------[ cut here ]------------

Fix this by releasing the path before relasing the delayed node in the
error path at __btrfs_run_delayed_items().

Reported-by: syzbot+a379155f07c134ea9879@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/000000000000abba27060403b5bd@google.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-inode.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 8534285f760d..e4828fc15f57 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1157,20 +1157,33 @@ static int __btrfs_run_delayed_items(struct btrfs_trans_handle *trans, int nr)
 		ret = __btrfs_commit_inode_delayed_items(trans, path,
 							 curr_node);
 		if (ret) {
-			btrfs_release_delayed_node(curr_node);
-			curr_node = NULL;
 			btrfs_abort_transaction(trans, ret);
 			break;
 		}
 
 		prev_node = curr_node;
 		curr_node = btrfs_next_delayed_node(curr_node);
+		/*
+		 * See the comment below about releasing path before releasing
+		 * node. If the commit of delayed items was successful the path
+		 * should always be released, but in case of an error, it may
+		 * point to locked extent buffers (a leaf at the very least).
+		 */
+		ASSERT(path->nodes[0] == NULL);
 		btrfs_release_delayed_node(prev_node);
 	}
 
+	/*
+	 * Release the path to avoid a potential deadlock and lockdep splat when
+	 * releasing the delayed node, as that requires taking the delayed node's
+	 * mutex. If another task starts running delayed items before we take
+	 * the mutex, it will first lock the mutex and then it may try to lock
+	 * the same btree path (leaf).
+	 */
+	btrfs_free_path(path);
+
 	if (curr_node)
 		btrfs_release_delayed_node(curr_node);
-	btrfs_free_path(path);
 	trans->block_rsv = block_rsv;
 
 	return ret;
-- 
2.40.1

