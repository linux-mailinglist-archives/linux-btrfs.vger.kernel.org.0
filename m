Return-Path: <linux-btrfs+bounces-19895-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25429CCF90B
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 12:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 908403030387
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 11:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1AA31196F;
	Fri, 19 Dec 2025 11:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHdVwies"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5A030FF04
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Dec 2025 11:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766143568; cv=none; b=sgPbIt9NfU8sDxKiy+qtW7il3MftMSJz4zmSxLOtYKTQB7FG/7DBkzNCyIjz5Vr9sEgESv+H+BdRboGzlRYwuWw26dcTB4pZDk4YSl4MFsZmcBx4ivJye0uqGWTOb1h1sxMGXlaeHjBgb9NgSOy8iRDOEOosNoKpRwzpTq5+z40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766143568; c=relaxed/simple;
	bh=Pw99vbCK2/Z4qbWsk694q2mAhfa15iqItE8am4TeJ4c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Y7Wy/ac/VQy9+skweE1u8xEkmZfEuEltIWAIbn8FVQeUdkQkLtPCpNh9zjIIwLEeN5XrDwZXIqAfuMHA7amyOOntac47llZFgz0YzRXoDy9bk5qrmwopIgTkNBIMcWxAd12U+S2yxIqy072tHuzrPUYwfE/UAVAcMHwW7YWRT+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHdVwies; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92067C4CEF1
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Dec 2025 11:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766143568;
	bh=Pw99vbCK2/Z4qbWsk694q2mAhfa15iqItE8am4TeJ4c=;
	h=From:To:Subject:Date:From;
	b=BHdVwiesiLCfD7qJ/CwT8EoeZsbSCeRN9UZu05ZKO4zA+w43wwY21+tT6qTe400wJ
	 7i52B6LULPGIUKrwr02F1rDhbnNrngnZq9U8jc1MSUnYB5z0gzRp36NDEAZ5ue35Mr
	 N8RgVid2rbHUHOdZPy468e73lFGdofJULFBPU59oSeGHvfhUTrEIUncvCuWYdrli4y
	 PDjC29g/6YLsen6xSJRSENvY+eF0wj+LT3t08k0aDfAefy79Hx8adM6INYjorSF3Kc
	 CYUeCNS3ESgx9ez4QR1CNq88LtrOBo4R8rAiGj7P3JFW818wxNxmPJxVudCSPah6HJ
	 a3J0zsUxanUFQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: release path before iget_failed() in btrfs_read_locked_inode()
Date: Fri, 19 Dec 2025 11:26:02 +0000
Message-ID: <08d3bfec635a318d7bf7af84d2153c2f64513204.1766143542.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

In btrfs_read_locked_inode() if we fail to lookup the inode, we jump to
the 'out' label with a path that has a read locked leaf and then we call
iget_failed(). This can result in a ABBA deadlock, since iget_failed()
triggers inode eviction and that causes the release of the delayed inode,
which must lock the delayed inode's mutex, and a task updating a delayed
inode starts by taking the node's mutex and then modifying the inode's
subvolume btree.

Syzbot reported the following lockdep splat for this:

   ======================================================
   WARNING: possible circular locking dependency detected
   syzkaller #0 Not tainted
   ------------------------------------------------------
   btrfs-cleaner/8725 is trying to acquire lock:
   ffff0000d6826a48 (&delayed_node->mutex){+.+.}-{4:4}, at: __btrfs_release_delayed_node+0xa0/0x9b0 fs/btrfs/delayed-inode.c:290

   but task is already holding lock:
   ffff0000dbeba878 (btrfs-tree-00){++++}-{4:4}, at: btrfs_tree_read_lock_nested+0x44/0x2ec fs/btrfs/locking.c:145

   which lock already depends on the new lock.

   the existing dependency chain (in reverse order) is:

   -> #1 (btrfs-tree-00){++++}-{4:4}:
          __lock_release kernel/locking/lockdep.c:5574 [inline]
          lock_release+0x198/0x39c kernel/locking/lockdep.c:5889
          up_read+0x24/0x3c kernel/locking/rwsem.c:1632
          btrfs_tree_read_unlock+0xdc/0x298 fs/btrfs/locking.c:169
          btrfs_tree_unlock_rw fs/btrfs/locking.h:218 [inline]
          btrfs_search_slot+0xa6c/0x223c fs/btrfs/ctree.c:2133
          btrfs_lookup_inode+0xd8/0x38c fs/btrfs/inode-item.c:395
          __btrfs_update_delayed_inode+0x124/0xed0 fs/btrfs/delayed-inode.c:1032
          btrfs_update_delayed_inode fs/btrfs/delayed-inode.c:1118 [inline]
          __btrfs_commit_inode_delayed_items+0x15f8/0x1748 fs/btrfs/delayed-inode.c:1141
          __btrfs_run_delayed_items+0x1ac/0x514 fs/btrfs/delayed-inode.c:1176
          btrfs_run_delayed_items_nr+0x28/0x38 fs/btrfs/delayed-inode.c:1219
          flush_space+0x26c/0xb68 fs/btrfs/space-info.c:828
          do_async_reclaim_metadata_space+0x110/0x364 fs/btrfs/space-info.c:1158
          btrfs_async_reclaim_metadata_space+0x90/0xd8 fs/btrfs/space-info.c:1226
          process_one_work+0x7e8/0x155c kernel/workqueue.c:3263
          process_scheduled_works kernel/workqueue.c:3346 [inline]
          worker_thread+0x958/0xed8 kernel/workqueue.c:3427
          kthread+0x5fc/0x75c kernel/kthread.c:463
          ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844

   -> #0 (&delayed_node->mutex){+.+.}-{4:4}:
          check_prev_add kernel/locking/lockdep.c:3165 [inline]
          check_prevs_add kernel/locking/lockdep.c:3284 [inline]
          validate_chain kernel/locking/lockdep.c:3908 [inline]
          __lock_acquire+0x1774/0x30a4 kernel/locking/lockdep.c:5237
          lock_acquire+0x14c/0x2e0 kernel/locking/lockdep.c:5868
          __mutex_lock_common+0x1d0/0x2678 kernel/locking/mutex.c:598
          __mutex_lock kernel/locking/mutex.c:760 [inline]
          mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:812
          __btrfs_release_delayed_node+0xa0/0x9b0 fs/btrfs/delayed-inode.c:290
          btrfs_release_delayed_node fs/btrfs/delayed-inode.c:315 [inline]
          btrfs_remove_delayed_node+0x68/0x84 fs/btrfs/delayed-inode.c:1326
          btrfs_evict_inode+0x578/0xe28 fs/btrfs/inode.c:5587
          evict+0x414/0x928 fs/inode.c:810
          iput_final fs/inode.c:1914 [inline]
          iput+0x95c/0xad4 fs/inode.c:1966
          iget_failed+0xec/0x134 fs/bad_inode.c:248
          btrfs_read_locked_inode+0xe1c/0x1234 fs/btrfs/inode.c:4101
          btrfs_iget+0x1b0/0x264 fs/btrfs/inode.c:5837
          btrfs_run_defrag_inode fs/btrfs/defrag.c:237 [inline]
          btrfs_run_defrag_inodes+0x520/0xdc4 fs/btrfs/defrag.c:309
          cleaner_kthread+0x21c/0x418 fs/btrfs/disk-io.c:1516
          kthread+0x5fc/0x75c kernel/kthread.c:463
          ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844

   other info that might help us debug this:

    Possible unsafe locking scenario:

          CPU0                    CPU1
          ----                    ----
     rlock(btrfs-tree-00);
                                  lock(&delayed_node->mutex);
                                  lock(btrfs-tree-00);
     lock(&delayed_node->mutex);

    *** DEADLOCK ***

   1 lock held by btrfs-cleaner/8725:
    #0: ffff0000dbeba878 (btrfs-tree-00){++++}-{4:4}, at: btrfs_tree_read_lock_nested+0x44/0x2ec fs/btrfs/locking.c:145

   stack backtrace:
   CPU: 0 UID: 0 PID: 8725 Comm: btrfs-cleaner Not tainted syzkaller #0 PREEMPT
   Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/03/2025
   Call trace:
    show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
    __dump_stack+0x30/0x40 lib/dump_stack.c:94
    dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
    dump_stack+0x1c/0x28 lib/dump_stack.c:129
    print_circular_bug+0x324/0x32c kernel/locking/lockdep.c:2043
    check_noncircular+0x154/0x174 kernel/locking/lockdep.c:2175
    check_prev_add kernel/locking/lockdep.c:3165 [inline]
    check_prevs_add kernel/locking/lockdep.c:3284 [inline]
    validate_chain kernel/locking/lockdep.c:3908 [inline]
    __lock_acquire+0x1774/0x30a4 kernel/locking/lockdep.c:5237
    lock_acquire+0x14c/0x2e0 kernel/locking/lockdep.c:5868
    __mutex_lock_common+0x1d0/0x2678 kernel/locking/mutex.c:598
    __mutex_lock kernel/locking/mutex.c:760 [inline]
    mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:812
    __btrfs_release_delayed_node+0xa0/0x9b0 fs/btrfs/delayed-inode.c:290
    btrfs_release_delayed_node fs/btrfs/delayed-inode.c:315 [inline]
    btrfs_remove_delayed_node+0x68/0x84 fs/btrfs/delayed-inode.c:1326
    btrfs_evict_inode+0x578/0xe28 fs/btrfs/inode.c:5587
    evict+0x414/0x928 fs/inode.c:810
    iput_final fs/inode.c:1914 [inline]
    iput+0x95c/0xad4 fs/inode.c:1966
    iget_failed+0xec/0x134 fs/bad_inode.c:248
    btrfs_read_locked_inode+0xe1c/0x1234 fs/btrfs/inode.c:4101
    btrfs_iget+0x1b0/0x264 fs/btrfs/inode.c:5837
    btrfs_run_defrag_inode fs/btrfs/defrag.c:237 [inline]
    btrfs_run_defrag_inodes+0x520/0xdc4 fs/btrfs/defrag.c:309
    cleaner_kthread+0x21c/0x418 fs/btrfs/disk-io.c:1516
    kthread+0x5fc/0x75c kernel/kthread.c:463
    ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844

Fix this by releasing the path before calling iget_failed().

Reported-by: syzbot+c1c6edb02bea1da754d8@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/694530c2.a70a0220.207337.010d.GAE@google.com/
Fixes: 69673992b1ae ("btrfs: push cleanup into btrfs_read_locked_inode()")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index cf452eaf0672..247b373bf5cf 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4214,6 +4214,15 @@ static int btrfs_read_locked_inode(struct btrfs_inode *inode, struct btrfs_path
 
 	return 0;
 out:
+	/*
+	 * We may have a read locked leaf and iget_failed() triggers inode
+	 * eviction which needs to release the delayed inode and that needs
+	 * to lock the delayed inode's mutex. This can cause a ABBA deadlock
+	 * with a task running delayed items, as that require first locking
+	 * the delayed inode's mutex and then modifying its subvolume btree.
+	 * So release the path before iget_failed().
+	 */
+	btrfs_release_path(path);
 	iget_failed(vfs_inode);
 	return ret;
 }
-- 
2.47.2


