Return-Path: <linux-btrfs+bounces-14461-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 537A8ACE212
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 18:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85976189B546
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 16:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC981DE4E3;
	Wed,  4 Jun 2025 16:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnPb5U2d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A2C339A1
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Jun 2025 16:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749053897; cv=none; b=MCRecADIobBVTEzXHkTbgHNWKtJ5LlUBZPN7nBXPlU2cTRYVAU4cTSc8xD0d2E7R8QklAhxTnF/IyLYqXWKkKXI7hzGWfsSMwi7HYQC/597cwZhmh/lRTffGs2KPKqMcLQfgISNGLhsJR8602tp7/J7Ne69nIUgkJJRpl2XYK1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749053897; c=relaxed/simple;
	bh=jnWgCgiGMXouwcC8SMxazoohUOwl7KCdc5BSw6MgCa8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dSJ/LT0aNMjArqbtz3dvvppM72j2eNABEA8Zc80NsqAbNAQ8w6uPWaaqbDeC9aYSuxvCRQdFqbfLQx6GXqB//YTH7diI6ZY5ACrHdp83gNnPTXbPg/kWdQlIrUZ5Sv9j9lv2rUGeGseeuLmAvZuzkWcMyBJ8Y+UsjyHKUjb47TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnPb5U2d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5172DC4CEE4
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Jun 2025 16:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749053895;
	bh=jnWgCgiGMXouwcC8SMxazoohUOwl7KCdc5BSw6MgCa8=;
	h=From:To:Subject:Date:From;
	b=WnPb5U2dhw2x3vmwIW3F6TwSB/eCfbsLIV4VX8QfzwxE3TDKP4etk1qULY7fLbD36
	 LtDdkAYATU1wGnXHfgcA3Pgme7g0pS7/r9nPUXVV8gvKBlVBQ07DhBRfAOLolPFmmJ
	 brnkHiS7A4EtAtr2ZFJjFvMWH41ydyHUsCcQcEJ/nyY/U/AvyIyYo9rSpA7JxgGfI4
	 sExBOVGi3WOmKDu/g1hY5gzmINoZUOLvAjk7li3VfgeTcN8EMummzWzADpAnddwmks
	 5n364JztNl1HvSB3YLGylxmkLjs1Mu+jyAinq5IZgNf8Z0UhkPQNL8R8rWVGKQJWE6
	 qGL2a+zcEHKzw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix race between async reclaim worker and close_ctree()
Date: Wed,  4 Jun 2025 17:18:11 +0100
Message-ID: <59c8f858b893a9d37b76d4b3bdf985c904b4c8fe.1749052938.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
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
extra warning if delayed iput is added when it's not allowed") and we
didn't have any assertion failure, crash or inode leak in this described
scenario because before that commit since btrfs_commit_super(), called
later at close_ctree(), runs delayed iputs again, and there was no such
assertion about BTRFS_FS_STATE_NO_DELAYED_IPUT at btrfs_add_delayed_iput()
of course.

Reported-by: syzbot+0ed30ad435bf6f5b7a42@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/6840481c.a00a0220.d4325.000c.GAE@google.com/T/#u
Fixes: 19e60b2a95f5 ("btrfs: add extra warning if delayed iput is added when it's not allowed")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3def93016963..84c8f9f19649 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
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


