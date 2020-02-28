Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 375A61737D6
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2020 14:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgB1NEk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Feb 2020 08:04:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:34618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbgB1NEk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Feb 2020 08:04:40 -0500
Received: from debian6.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87E4B222C4
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Feb 2020 13:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582895079;
        bh=jCnzCWdNg41v6sxSvQbyaa9185s9GzcZuflQiYPJGLs=;
        h=From:To:Subject:Date:From;
        b=Z5Aq9wnWvnEMvwtCfUZnvXhfa5j10wHUAhHvtDV94SudlBIiidPi/kKyzSrW51tqO
         +YvZbbDV9AFeiZkjbX+TOONImvG0VHwumQugd51IM1lCQ3L8T7UH7Mv6kp8ZmieWZz
         iJlNAbXjF29ZVoX4qkNHvnpErZdqWrpRnR08B8qU=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs: fix crash during unmount due to race with delayed inode workers
Date:   Fri, 28 Feb 2020 13:04:36 +0000
Message-Id: <20200228130436.26128-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

During unmount we can have a job from the delayed inode items work queue
still running, that can lead to at least two bad things_

1) A crash, because the worker can try to create a transaction just
   after the fs roots were freed;

2) A transaction leak, because the worker can create a transaction
   before the fs roots are freed and just after we committed the last
   transaction and after we stopped the transaction kthread.

A stack trace example of the crash:

 [79011.691214] kernel BUG at lib/radix-tree.c:982!
 [79011.692056] invalid opcode: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC PTI
 [79011.693180] CPU: 3 PID: 1394 Comm: kworker/u8:2 Tainted: G        W         5.6.0-rc2-btrfs-next-54 #2
 (...)
 [79011.696789] Workqueue: btrfs-delayed-meta btrfs_work_helper [btrfs]
 [79011.697904] RIP: 0010:radix_tree_tag_set+0xe7/0x170
 (...)
 [79011.702014] RSP: 0018:ffffb3c84a317ca0 EFLAGS: 00010293
 [79011.702949] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
 [79011.704202] RDX: ffffb3c84a317cb0 RSI: ffffb3c84a317ca8 RDI: ffff8db3931340a0
 [79011.705463] RBP: 0000000000000005 R08: 0000000000000005 R09: ffffffff974629d0
 [79011.706756] R10: ffffb3c84a317bc0 R11: 0000000000000001 R12: ffff8db393134000
 [79011.708010] R13: ffff8db3931340a0 R14: ffff8db393134068 R15: 0000000000000001
 [79011.709270] FS:  0000000000000000(0000) GS:ffff8db3b6a00000(0000) knlGS:0000000000000000
 [79011.710699] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 [79011.711710] CR2: 00007f22c2a0a000 CR3: 0000000232ad4005 CR4: 00000000003606e0
 [79011.712958] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 [79011.714205] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 [79011.715448] Call Trace:
 [79011.715925]  record_root_in_trans+0x72/0xf0 [btrfs]
 [79011.716819]  btrfs_record_root_in_trans+0x4b/0x70 [btrfs]
 [79011.717925]  start_transaction+0xdd/0x5c0 [btrfs]
 [79011.718829]  btrfs_async_run_delayed_root+0x17e/0x2b0 [btrfs]
 [79011.719915]  btrfs_work_helper+0xaa/0x720 [btrfs]
 [79011.720773]  process_one_work+0x26d/0x6a0
 [79011.721497]  worker_thread+0x4f/0x3e0
 [79011.722153]  ? process_one_work+0x6a0/0x6a0
 [79011.722901]  kthread+0x103/0x140
 [79011.723481]  ? kthread_create_worker_on_cpu+0x70/0x70
 [79011.724379]  ret_from_fork+0x3a/0x50
 (...)
 [79011.734135] ---[ end trace 2c87e34fb6707574 ]---

The following diagram shows a sequence of steps that lead to the crash
during ummount of the filesystem:

        CPU 1                                             CPU 2                                CPU 3

 btrfs_punch_hole()
   btrfs_btree_balance_dirty()
     btrfs_balance_delayed_items()
       --> sees
           fs_info->delayed_root->items
           with value 200, which is greater
           than
           BTRFS_DELAYED_BACKGROUND (128)
           and smaller than
           BTRFS_DELAYED_WRITEBACK (512)
       btrfs_wq_run_delayed_node()
         --> queues a job for
             fs_info->delayed_workers to run
             btrfs_async_run_delayed_root()

                                                                                            btrfs_async_run_delayed_root()
                                                                                              --> job queued by CPU 1

                                                                                              --> starts picking and running
                                                                                                  delayed nodes from the
                                                                                                  prepare_list list

                                                 close_ctree()

                                                   btrfs_delete_unused_bgs()

                                                   btrfs_commit_super()

                                                     btrfs_join_transaction()
                                                       --> gets transaction N

                                                     btrfs_commit_transaction(N)
                                                       --> set transaction state
                                                        to TRANTS_STATE_COMMIT_START

                                                                                             btrfs_first_prepared_delayed_node()
                                                                                               --> picks delayed node X through
                                                                                                   the prepared_list list

                                                       btrfs_run_delayed_items()

                                                         btrfs_first_delayed_node()
                                                           --> also picks delayed node X
                                                               but through the node_list
                                                               list

                                                         __btrfs_commit_inode_delayed_items()
                                                            --> runs all delayed items from
                                                                this node and drops the
                                                                node's item count to 0
                                                                through call to
                                                                btrfs_release_delayed_inode()

                                                         --> finishes running any remaining
                                                             delayed nodes

                                                       --> finishes transaction commit

                                                   --> stops cleaner and transaction threads

                                                   btrfs_free_fs_roots()
                                                     --> frees all roots and removes them
                                                         from the radix tree
                                                         fs_info->fs_roots_radix

                                                                                             btrfs_join_transaction()
                                                                                               start_transaction()
                                                                                                 btrfs_record_root_in_trans()
                                                                                                   record_root_in_trans()
                                                                                                     radix_tree_tag_set()
                                                                                                       --> crashes because
                                                                                                           the root is not in
                                                                                                           the radix tree
                                                                                                           anymore

If the worker is able to call btrfs_join_transaction() before the unmount
task frees the fs roots, we end up leaking a transaction and all its
resources, since after the call to btrfs_commit_super() and stopping the
transaction kthread, we don't expect to have any transaction open anymore.

When this situation happens the worker has a delayed node that has no
more items to run, since the task calling btrfs_run_delayed_items(),
which is doing a transaction commit, picks the same node and runs all
its items first.

We can not wait for the worker to complete when running delayed items
through btrfs_run_delayed_items(), because we call that function in
several phases of a transaction commit, and that could cause a deadlock
because the worker calls btrfs_join_transaction() and the task doing the
transaction commit may have already set the transaction state to
TRANS_STATE_COMMIT_DOING.

Also it's not possible to get into a situation where only some of the
items of a delayed node are added to the fs/subvolume tree in the current
transaction and the remaining ones in the next transaction, because when
running the items of a delayed inode we lock its mutex, effectively
waiting for the worker if the worker is running the items of the delayed
node already.

Since this can only cause issues when unmounting a filesystem, fix it in
a simple way by waiting for any jobs on the delayed workers queue before
calling btrfs_commit_supper() at close_ctree(). This works because at this
point no one can call btrfs_btree_balance_dirty() or
btrfs_balance_delayed_items(), and if we end up waiting for any worker to
complete, btrfs_commit_super() will commit the transaction created by the
worker.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/async-thread.c |  8 ++++++++
 fs/btrfs/async-thread.h |  1 +
 fs/btrfs/disk-io.c      | 13 +++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/fs/btrfs/async-thread.c b/fs/btrfs/async-thread.c
index 1d32a07bb2d1..309516e6a968 100644
--- a/fs/btrfs/async-thread.c
+++ b/fs/btrfs/async-thread.c
@@ -395,3 +395,11 @@ void btrfs_set_work_high_priority(struct btrfs_work *work)
 {
 	set_bit(WORK_HIGH_PRIO_BIT, &work->flags);
 }
+
+void btrfs_flush_workqueue(struct btrfs_workqueue *wq)
+{
+	if (wq->high)
+		flush_workqueue(wq->high->normal_wq);
+
+	flush_workqueue(wq->normal->normal_wq);
+}
diff --git a/fs/btrfs/async-thread.h b/fs/btrfs/async-thread.h
index a4434301d84d..3204daa51b95 100644
--- a/fs/btrfs/async-thread.h
+++ b/fs/btrfs/async-thread.h
@@ -44,5 +44,6 @@ void btrfs_set_work_high_priority(struct btrfs_work *work);
 struct btrfs_fs_info * __pure btrfs_work_owner(const struct btrfs_work *work);
 struct btrfs_fs_info * __pure btrfs_workqueue_owner(const struct __btrfs_workqueue *wq);
 bool btrfs_workqueue_normal_congested(const struct btrfs_workqueue *wq);
+void btrfs_flush_workqueue(struct btrfs_workqueue *wq);
 
 #endif
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index e1e111c8b08b..cd5c82b8459f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4034,6 +4034,19 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 		 */
 		btrfs_delete_unused_bgs(fs_info);
 
+		/*
+		 * There might be existing delayed inode workers still running
+		 * and holding an empty delayed inode item. We must wait for
+		 * them to complete first because they can create a transaction.
+		 * This happens when someone calls btrfs_balance_delayed_items()
+		 * and then a transaction commit runs the same delayed nodes
+		 * before any delayed worker has done something with the nodes.
+		 * We must wait for any worker here and not at transaction
+		 * commit time since that could cause a deadlock.
+		 * This is a very rare case.
+		 */
+		btrfs_flush_workqueue(fs_info->delayed_workers);
+
 		ret = btrfs_commit_super(fs_info);
 		if (ret)
 			btrfs_err(fs_info, "commit super ret %d", ret);
-- 
2.11.0

