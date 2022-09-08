Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041955B1B7D
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Sep 2022 13:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbiIHLcF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Sep 2022 07:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiIHLcC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Sep 2022 07:32:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08704CCE3E
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Sep 2022 04:32:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B092B820C2
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Sep 2022 11:31:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D647EC433D6
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Sep 2022 11:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662636717;
        bh=1dcnhihuLkxjdcmLP9XO05x0/nM52zMO9Z7sHowtOV0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PuTQKKrizTYlvgYdEX6F43veIhoGMOlvdXMz9JNOApQvh5MNMA3v/BSJ//12F1NUa
         EzlP7wpZNdbExrMVvTSTuhVHU096OqrAsNFosdnoEHgxKTIdquYBe3lI52B5cicU4b
         aeR3BeHz8RhK5htF6FqqRYpvnBHeBzYqhuGe6DRczD+MdeKc+kTRb5stfBw2DeCoG1
         XJKhZhiM/GWx/fA3St8vhEHORLgnqqXJJvucov/7cG+ZNmm9RBHPU3h/XPj2PykAYO
         fZk1CIfjElSHOl2UHAlJpr0RSZFNWzym88hwzQyfEkuD17QXhWlR+pDJKUm2Qrfzpn
         cHH1+kIBzdSFQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: fix hang during unmount when stopping a space reclaim worker
Date:   Thu,  8 Sep 2022 12:31:51 +0100
Message-Id: <b0dcdbf247a39547cab403ee5e34a60960831fd0.1662636489.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1662636489.git.fdmanana@suse.com>
References: <cover.1662636489.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Often when running generic/562 from fstests we can hang during unmount,
resulting in a trace like this:

    Sep 07 11:52:00 debian9 unknown: run fstests generic/562 at 2022-09-07 11:52:00
    Sep 07 11:55:32 debian9 kernel: INFO: task umount:49438 blocked for more than 120 seconds.
    Sep 07 11:55:32 debian9 kernel:       Not tainted 6.0.0-rc2-btrfs-next-122 #1
    Sep 07 11:55:32 debian9 kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
    Sep 07 11:55:32 debian9 kernel: task:umount          state:D stack:    0 pid:49438 ppid: 25683 flags:0x00004000
    Sep 07 11:55:32 debian9 kernel: Call Trace:
    Sep 07 11:55:32 debian9 kernel:  <TASK>
    Sep 07 11:55:32 debian9 kernel:  __schedule+0x3c8/0xec0
    Sep 07 11:55:32 debian9 kernel:  ? rcu_read_lock_sched_held+0x12/0x70
    Sep 07 11:55:32 debian9 kernel:  schedule+0x5d/0xf0
    Sep 07 11:55:32 debian9 kernel:  schedule_timeout+0xf1/0x130
    Sep 07 11:55:32 debian9 kernel:  ? lock_release+0x224/0x4a0
    Sep 07 11:55:32 debian9 kernel:  ? lock_acquired+0x1a0/0x420
    Sep 07 11:55:32 debian9 kernel:  ? trace_hardirqs_on+0x2c/0xd0
    Sep 07 11:55:32 debian9 kernel:  __wait_for_common+0xac/0x200
    Sep 07 11:55:32 debian9 kernel:  ? usleep_range_state+0xb0/0xb0
    Sep 07 11:55:32 debian9 kernel:  __flush_work+0x26d/0x530
    Sep 07 11:55:32 debian9 kernel:  ? flush_workqueue_prep_pwqs+0x140/0x140
    Sep 07 11:55:32 debian9 kernel:  ? trace_clock_local+0xc/0x30
    Sep 07 11:55:32 debian9 kernel:  __cancel_work_timer+0x11f/0x1b0
    Sep 07 11:55:32 debian9 kernel:  ? close_ctree+0x12b/0x5b3 [btrfs]
    Sep 07 11:55:32 debian9 kernel:  ? __trace_bputs+0x10b/0x170
    Sep 07 11:55:32 debian9 kernel:  close_ctree+0x152/0x5b3 [btrfs]
    Sep 07 11:55:32 debian9 kernel:  ? evict_inodes+0x166/0x1c0
    Sep 07 11:55:32 debian9 kernel:  generic_shutdown_super+0x71/0x120
    Sep 07 11:55:32 debian9 kernel:  kill_anon_super+0x14/0x30
    Sep 07 11:55:32 debian9 kernel:  btrfs_kill_super+0x12/0x20 [btrfs]
    Sep 07 11:55:32 debian9 kernel:  deactivate_locked_super+0x2e/0xa0
    Sep 07 11:55:32 debian9 kernel:  cleanup_mnt+0x100/0x160
    Sep 07 11:55:32 debian9 kernel:  task_work_run+0x59/0xa0
    Sep 07 11:55:32 debian9 kernel:  exit_to_user_mode_prepare+0x1a6/0x1b0
    Sep 07 11:55:32 debian9 kernel:  syscall_exit_to_user_mode+0x16/0x40
    Sep 07 11:55:32 debian9 kernel:  do_syscall_64+0x48/0x90
    Sep 07 11:55:32 debian9 kernel:  entry_SYSCALL_64_after_hwframe+0x63/0xcd
    Sep 07 11:55:32 debian9 kernel: RIP: 0033:0x7fcde59a57a7
    Sep 07 11:55:32 debian9 kernel: RSP: 002b:00007ffe914217c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
    Sep 07 11:55:32 debian9 kernel: RAX: 0000000000000000 RBX: 00007fcde5ae8264 RCX: 00007fcde59a57a7
    Sep 07 11:55:32 debian9 kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000055b57556cdd0
    Sep 07 11:55:32 debian9 kernel: RBP: 000055b57556cba0 R08: 0000000000000000 R09: 00007ffe91420570
    Sep 07 11:55:32 debian9 kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
    Sep 07 11:55:32 debian9 kernel: R13: 000055b57556cdd0 R14: 000055b57556ccb8 R15: 0000000000000000
    Sep 07 11:55:32 debian9 kernel:  </TASK>

What happens is the following:

1) The cleaner kthread tries to start a transaction to delete an unused
   block group, but the metadata reservation can not be satisfied right
   away, so a reservation ticket is created and it starts the async
   metadata reclaim task (fs_info->async_reclaim_work);

2) Writeback for all the filler inodes with an i_size of 2K starts
   (generic/562 creates a lot of 2K files with the goal of filling
   metadata space). We try to create an inline extent for them, but we
   fail when trying to insert the inline extent with -ENOSPC (at
   cow_file_range_inline()) - since this is not critical, we fallback
   to non-inline mode (back to cow_file_range()), reserve extents, create
   extent maps and create the ordered extents;

3) An unmount starts, enters close_ctree();

4) The async reclaim task is flushing stuff, entering the flush states one
   by one, until it reaches RUN_DELAYED_IPUTS. There it runs all current
   delayed iputs.

   After running the delayed iputs and before calling
   btrfs_wait_on_delayed_iputs(), one or more ordered extents complete,
   and btrfs_add_delayed_iput() is called for each one through
   btrfs_finish_ordered_io() -> btrfs_put_ordered_extent(). This results
   in bumping fs_info->nr_delayed_iputs from 0 to some positive value.

   So the async reclaim task blocks at btrfs_wait_on_delayed_iputs() waiting
   for fs_info->nr_delayed_iputs to become 0;

5) The current transaction is committed by the transaction kthread, we then
   start unpinning extents and end up calling btrfs_try_granting_tickets()
   through unpin_extent_range(), since we released some space.
   This results in satisfying the ticket created by the cleaner kthread at
   step 1, waking up the cleaner kthread;

6) At close_ctree() we ask the cleaner kthread to park;

7) The cleaner kthread starts the transaction, deletes the unused block
   group, and then calls kthread_should_park(), which returns true, so it
   parks. And at this point we have the delayed iputs added by the
   completion of the ordered extents still pending;

8) Then later at close_ctree(), when we call:

       cancel_work_sync(&fs_info->async_reclaim_work);

   We hang forever, since the cleaner was parked and no one else can run
   delayed iputs after that, while the reclaim task is waiting for the
   remaining delayed iputs to be completed.

Fix this by waiting for all ordered extents to complete and running the
delayed iputs before attempting to stop the async reclaim tasks. Note that
we can not wait for ordered extents with btrfs_wait_ordered_roots() (or
other similar functions) because that waits for the BTRFS_ORDERED_COMPLETE
flag to be set on an ordered extent, but the delayed iput is added after
that, when doing the final btrfs_put_ordered_extent(). So instead wait for
the work queues used for executing ordered extent completion to be empty,
which works because we do the final put on an ordered extent at
btrfs_finish_ordered_io() (while we are in the unmount context).

Fixes: d6fd0ae25c6495 ("Btrfs: fix missing delayed iputs on unmount")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 928adde1963d..fab9c981de8d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4539,6 +4539,31 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	/* clear out the rbtree of defraggable inodes */
 	btrfs_cleanup_defrag_inodes(fs_info);
 
+	/*
+	 * After we parked the cleaner kthread, ordered extents may have
+	 * completed and created new delayed iputs. If one of the async reclaim
+	 * tasks is running and in the RUN_DELAYED_IPUTS flush state, then we
+	 * can hang forever trying to stop it, because if a delayed iput is
+	 * added after it ran btrfs_run_delayed_iputs() and before it called
+	 * btrfs_wait_on_delayed_iputs(), it will hang forever since there is
+	 * no one else to run iputs.
+	 *
+	 * So wait for all ongoing ordered extents to complete and then run
+	 * delayed iputs. This works because once we reach this point no one
+	 * can neither create new ordered extents nor create delayed iputs
+	 * through some other means.
+	 *
+	 * Also note that btrfs_wait_ordered_roots() is not safe here, because
+	 * it waits for BTRFS_ORDERED_COMPLETE to be set on an ordered extent,
+	 * but the delayed iput for the respective inode is made only when doing
+	 * the final btrfs_put_ordered_extent() (which must happen at
+	 * btrfs_finish_ordered_io() when we are unmounting).
+	 */
+	btrfs_flush_workqueue(fs_info->endio_write_workers);
+	/* Ordered extents for free space inodes. */
+	btrfs_flush_workqueue(fs_info->endio_freespace_worker);
+	btrfs_run_delayed_iputs(fs_info);
+
 	cancel_work_sync(&fs_info->async_reclaim_work);
 	cancel_work_sync(&fs_info->async_data_reclaim_work);
 	cancel_work_sync(&fs_info->preempt_reclaim_work);
-- 
2.35.1

