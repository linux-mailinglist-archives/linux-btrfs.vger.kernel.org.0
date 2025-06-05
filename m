Return-Path: <linux-btrfs+bounces-14504-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37458ACF806
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 21:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88FC7189DA27
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 19:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD2527F72E;
	Thu,  5 Jun 2025 19:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlHeGzzM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2262027EC7D
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Jun 2025 19:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749151848; cv=none; b=Vv3H9qOJx3kllbxXtLrHVMIgG374XrxI7IjJxZudiMCr2jAQ4gh28s8P9Ex+QLqfO1jh10B9gcqAvZmDfJOkvv9Tl3tbF1PJRCVO/NoXJ0fy4rwVbwt0vL2B4b0yrdbFxHlyqnbofJSB4XkGO6lcRDAhjfYBpjEOvJthRbf61Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749151848; c=relaxed/simple;
	bh=UI7TJ+Gqv5HTr1WK+6+mXdwhnuobmwFBMW+Qi+Ijyk0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X9dRbygkfXnys4pauS4V4DPN0LD6E7WU7+6+0GlWatReawwkrSMw8NQbOHZWRX9JNtTRNvjUct+RUG8o2JokF0Suax/f9Mbje+M3pOQQf8RhUT8SwzxHvvHEBuicTit9Xkcn4vnuJ+/mkZ2GMvzcQ60bKSBZ0J3L2GFRywH94Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlHeGzzM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22CF8C4CEF1
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Jun 2025 19:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749151847;
	bh=UI7TJ+Gqv5HTr1WK+6+mXdwhnuobmwFBMW+Qi+Ijyk0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MlHeGzzMq7eKroGKtNcVBlwGXpLo5Dvq7+fKxbXqCGWZDIJuycPSQRU/KmOHtOrxZ
	 rTjrLXmAsJr0vnvYlXLAM7gwzKGHYxjEQveRc1cCzp1WK2TnV+rppyi+cXJ+lrAogz
	 hMIYxA0jIbkjvLRw9Fr8OlWky+0FGCeTmB6ezBtHBuGQoMOdbCPpQXCCweRjlj+9yQ
	 6y26QeojuougnWFYxvl7WylauKHuX9rlmMTCdnE1j00CB20TZsnOBD7oZBHFWO/G0l
	 ZHoo56zx//qt7PEp1if/DZZYK6ow64U5Ase/8eEsKm1EQxtgaDpS/gcw1zSIp950y8
	 jzfZvP+fnxslA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: fix race between async reclaim worker and close_ctree()
Date: Thu,  5 Jun 2025 20:30:43 +0100
Message-ID: <382977e88a4b43286d11c9ec96e9d9b5bda9e3c9.1749151642.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <59c8f858b893a9d37b76d4b3bdf985c904b4c8fe.1749052938.git.fdmanana@suse.com>
References: <59c8f858b893a9d37b76d4b3bdf985c904b4c8fe.1749052938.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Syzbot reported an assertion failure due to an attempt to add a delayed
iput after we have set BTRFS_FS_STATE_NO_DELAYED_IPUT in the fs_info
state:

   WARNING: CPU: 0 PID: 65 at fs/btrfs/inode.c:3420 btrfs_add_delayed_iput+0x2f8/0x370 fs/btrfs/inode.c:3420
   Modules linked in:
   CPU: 0 UID: 0 PID: 65 Comm: kworker/u8:4 Not tainted 6.15.0-next-20250530-syzkaller #0 PREEMPT(full)
   Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
   Workqueue: btrfs-endio-write btrfs_work_helper
   RIP: 0010:btrfs_add_delayed_iput+0x2f8/0x370 fs/btrfs/inode.c:3420
   Code: 4e ad 5d (...)
   RSP: 0018:ffffc9000213f780 EFLAGS: 00010293
   RAX: ffffffff83c635b7 RBX: ffff888058920000 RCX: ffff88801c769e00
   RDX: 0000000000000000 RSI: 0000000000000100 RDI: 0000000000000000
   RBP: 0000000000000001 R08: ffff888058921b67 R09: 1ffff1100b12436c
   R10: dffffc0000000000 R11: ffffed100b12436d R12: 0000000000000001
   R13: dffffc0000000000 R14: ffff88807d748000 R15: 0000000000000100
   FS:  0000000000000000(0000) GS:ffff888125c53000(0000) knlGS:0000000000000000
   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
   CR2: 00002000000bd038 CR3: 000000006a142000 CR4: 00000000003526f0
   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
   Call Trace:
    <TASK>
    btrfs_put_ordered_extent+0x19f/0x470 fs/btrfs/ordered-data.c:635
    btrfs_finish_one_ordered+0x11d8/0x1b10 fs/btrfs/inode.c:3312
    btrfs_work_helper+0x399/0xc20 fs/btrfs/async-thread.c:312
    process_one_work kernel/workqueue.c:3238 [inline]
    process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
    worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
    kthread+0x70e/0x8a0 kernel/kthread.c:464
    ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
    </TASK>

This can happen due to a race with the async reclaim worker like this:

1) The async metadata reclaim worker enters shrink_delalloc(), which calls
   btrfs_start_delalloc_roots() with an nr_pages argument that has a value
   less than LONG_MAX, and that in turn enters start_delalloc_inodes(),
   which sets the local variable 'full_flush' to false because
   wbc->nr_to_write is less than LONG_MAX;

2) There it finds inode X in a root's delalloc list, grabs a reference for
   inode X (with igrab()), and triggers writeback for it with
   filemap_fdatawrite_wbc(), which creates an ordered extent for inode X;

3) The unmount sequence starts from another task, we enter close_ctree()
   and we flush the workqueue fs_info->endio_write_workers, which waits
   for the ordered extent for inode X to complete and when dropping the
   last reference of the ordered extent, with btrfs_put_ordered_extent(),
   when we call btrfs_add_delayed_iput() we don't add the inode to the
   list of delayed iputs because it has a refcount of 2, so we decrement
   it to 1 and return;

4) Shortly after at close_ctree() we call btrfs_run_delayed_iputs() which
   runs all delayed iputs, and then we set BTRFS_FS_STATE_NO_DELAYED_IPUT
   in the fs_info state;

5) The async reclaim worker, after calling filemap_fdatawrite_wbc(), now
   calls btrfs_add_delayed_iput() for inode X and there we trigger an
   assertion failure since the fs_info state has the flag
   BTRFS_FS_STATE_NO_DELAYED_IPUT set.

Fix this by setting BTRFS_FS_STATE_NO_DELAYED_IPUT only after we wait for
the async reclaim workers to finish, after we call cancel_work_sync() for
them at close_ctree(), and by running delayed iputs after wait for the
reclaim workers to finish and before setting the bit.

This race was recently introduced by commit 19e60b2a95f5 ("btrfs: add
extra warning if delayed iput is added when it's not allowed"). Without
the new validation at btrfs_add_delayed_iput(), this described scenario
was safe because close_ctree() later calls btrfs_commit_super(). That
will run any final delayed iputs added by reclaim workers in the window
between the btrfs_run_delayed_iputs() and the the reclaim workers being
shut down.

Reported-by: syzbot+0ed30ad435bf6f5b7a42@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/6840481c.a00a0220.d4325.000c.GAE@google.com/T/#u
Fixes: 19e60b2a95f5 ("btrfs: add extra warning if delayed iput is added when it's not allowed")
Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

V2: Updated a comment and rephrased a paragraph of the change log.

 fs/btrfs/disk-io.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3def93016963..f48f9d924a62 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4312,8 +4312,8 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	 *
 	 * So wait for all ongoing ordered extents to complete and then run
 	 * delayed iputs. This works because once we reach this point no one
-	 * can either create new ordered extents nor create delayed iputs
-	 * through some other means.
+	 * can create new ordered extents, but delayed iputs can still be added
+	 * by a reclaim worker (see comments further below).
 	 *
 	 * Also note that btrfs_wait_ordered_roots() is not safe here, because
 	 * it waits for BTRFS_ORDERED_COMPLETE to be set on an ordered extent,
@@ -4324,15 +4324,29 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	btrfs_flush_workqueue(fs_info->endio_write_workers);
 	/* Ordered extents for free space inodes. */
 	btrfs_flush_workqueue(fs_info->endio_freespace_worker);
+	/*
+	 * Run delayed iputs in case an async reclaim worker is waiting for them
+	 * to be run as mentioned above.
+	 */
 	btrfs_run_delayed_iputs(fs_info);
-	/* There should be no more workload to generate new delayed iputs. */
-	set_bit(BTRFS_FS_STATE_NO_DELAYED_IPUT, &fs_info->fs_state);
 
 	cancel_work_sync(&fs_info->async_reclaim_work);
 	cancel_work_sync(&fs_info->async_data_reclaim_work);
 	cancel_work_sync(&fs_info->preempt_reclaim_work);
 	cancel_work_sync(&fs_info->em_shrinker_work);
 
+	/*
+	 * Run delayed iputs again because an async reclaim worker may have
+	 * added new ones if it was flushing delalloc:
+	 *
+	 * shrink_delalloc() -> btrfs_start_delalloc_roots() ->
+	 *    start_delalloc_inodes() -> btrfs_add_delayed_iput()
+	 */
+	btrfs_run_delayed_iputs(fs_info);
+
+	/* There should be no more workload to generate new delayed iputs. */
+	set_bit(BTRFS_FS_STATE_NO_DELAYED_IPUT, &fs_info->fs_state);
+
 	/* Cancel or finish ongoing discard work */
 	btrfs_discard_cleanup(fs_info);
 
-- 
2.47.2


