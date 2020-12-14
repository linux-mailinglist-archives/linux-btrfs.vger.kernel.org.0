Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF7F2D9596
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Dec 2020 10:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732156AbgLNJ5i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Dec 2020 04:57:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:58732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729399AbgLNJ5i (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Dec 2020 04:57:38 -0500
From:   fdmanana@kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 2/2] btrfs: fix race between fallocate and memory mapped writes leading to deadlock
Date:   Mon, 14 Dec 2020 09:56:42 +0000
Message-Id: <d67c9f972913bca4e2cc9958a03b85a1accd5587.1607939569.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1607939569.git.fdmanana@suse.com>
References: <cover.1607939569.git.fdmanana@suse.com>
In-Reply-To: <cover.1607939569.git.fdmanana@suse.com>
References: <cover.1607939569.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When doing a fallocate operation we lock the inode, flush delalloc within
the target range, wait for any ordered extents to complete and then lock
the file range. Before we lock the range and after we flush delalloc,
there is a time window where another task can come in and do a memory
mapped write for a page within the fallocate range.

This means that after fallocate locks the range, there can be a dirty page
in the range. More often than not, this does not cause any problem.
The exception is when we are low on available metadata space, because an
fallocate operation needs to start a transaction while holding the file
range locked, either through btrfs_prealloc_file_range() or through the
call to btrfs_fallocate_update_isize(). If that's the case, we can end up
in a deadlock. The following list of steps explains how that happens:

1) A fallocate operation starts, locks the inode, flushes delalloc in the
   range and waits for ordered extents in the range to complete;

2) Before the fallocate task locks the file range, another task does a
   memory mapped write for a page in the fallocate target range. This is
   possible since memory mapped writes do not (and can not) lock the
   inode;

3) The fallocate task locks the file range. At this point there is one
   dirty page in the range (due to the memory mapped write);

4) When the fallocate task attempts to start a transaction, it blocks when
   attempting to reserve metadata space, since we are low on available
   metadata space. Before blocking (wait on its reservation ticket), it
   starts the async reclaim task (if not running already);

5) The async reclaim task is not able to release space through any other
   means, so it decides to flush delalloc for inodes with dirty pages.
   It finds that the inode used in the fallocate operation has a dirty
   page and therefore queues a job (fs_info->flushs_workers workqueue) to
   flush delalloc for that inode and waits on that job to complete;

6) The flush job blocks when attempting to lock the file range because
   it is currently locked by the fallocate task;

7) The fallocate task keeps waiting for its metadata reservation, waiting
   for a wakeup on its reservation ticket. The async reclaim task is
   waiting on the flush job, which in turn is waiting for locking the file
   range that is currently locked by the fallocate task. So unless some
   other task is able to release enough metadata space, for example an
   ordered extent for some other inode completes, we end up in a deadlock
   between all these tasks.

When this happens stack traces like the following showup in dmesg/syslog:

 INFO: task kworker/u16:11:1810830 blocked for more than 120 seconds.
       Tainted: G    B   W         5.10.0-rc4-btrfs-next-73 #1
 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 task:kworker/u16:11  state:D stack:    0 pid:1810830 ppid:     2 flags:0x00004000
 Workqueue: btrfs-flush_delalloc btrfs_work_helper [btrfs]
 Call Trace:
  __schedule+0x5d1/0xcf0
  schedule+0x45/0xe0
  lock_extent_bits+0x1e6/0x2d0 [btrfs]
  ? finish_wait+0x90/0x90
  btrfs_invalidatepage+0x32c/0x390 [btrfs]
  ? __mod_memcg_state+0x8e/0x160
  __extent_writepage+0x2d4/0x400 [btrfs]
  extent_write_cache_pages+0x2b2/0x500 [btrfs]
  ? lock_release+0x20e/0x4c0
  ? trace_hardirqs_on+0x1b/0xf0
  extent_writepages+0x43/0x90 [btrfs]
  ? lock_acquire+0x1a3/0x490
  do_writepages+0x43/0xe0
  ? __filemap_fdatawrite_range+0xa4/0x100
  __filemap_fdatawrite_range+0xc5/0x100
  btrfs_run_delalloc_work+0x17/0x40 [btrfs]
  btrfs_work_helper+0xf1/0x600 [btrfs]
  process_one_work+0x24e/0x5e0
  worker_thread+0x50/0x3b0
  ? process_one_work+0x5e0/0x5e0
  kthread+0x153/0x170
  ? kthread_mod_delayed_work+0xc0/0xc0
  ret_from_fork+0x22/0x30
 INFO: task kworker/u16:1:2426217 blocked for more than 120 seconds.
       Tainted: G    B   W         5.10.0-rc4-btrfs-next-73 #1
 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 task:kworker/u16:1   state:D stack:    0 pid:2426217 ppid:     2 flags:0x00004000
 Workqueue: events_unbound btrfs_async_reclaim_metadata_space [btrfs]
 Call Trace:
  __schedule+0x5d1/0xcf0
  ? kvm_clock_read+0x14/0x30
  ? wait_for_completion+0x81/0x110
  schedule+0x45/0xe0
  schedule_timeout+0x30c/0x580
  ? _raw_spin_unlock_irqrestore+0x3c/0x60
  ? lock_acquire+0x1a3/0x490
  ? try_to_wake_up+0x7a/0xa20
  ? lock_release+0x20e/0x4c0
  ? lock_acquired+0x199/0x490
  ? wait_for_completion+0x81/0x110
  wait_for_completion+0xab/0x110
  start_delalloc_inodes+0x2af/0x390 [btrfs]
  btrfs_start_delalloc_roots+0x12d/0x250 [btrfs]
  flush_space+0x24f/0x660 [btrfs]
  btrfs_async_reclaim_metadata_space+0x1bb/0x480 [btrfs]
  process_one_work+0x24e/0x5e0
  worker_thread+0x20f/0x3b0
  ? process_one_work+0x5e0/0x5e0
  kthread+0x153/0x170
  ? kthread_mod_delayed_work+0xc0/0xc0
  ret_from_fork+0x22/0x30
(...)
several tasks waiting for the inode lock held by the fallocate task below
(...)
 RIP: 0033:0x7f61efe73fff
 Code: Unable to access opcode bytes at RIP 0x7f61efe73fd5.
 RSP: 002b:00007ffc3371bbe8 EFLAGS: 00000202 ORIG_RAX: 000000000000013c
 RAX: ffffffffffffffda RBX: 00007ffc3371bea0 RCX: 00007f61efe73fff
 RDX: 00000000ffffff9c RSI: 0000560fbd5d90a0 RDI: 00000000ffffff9c
 RBP: 00007ffc3371beb0 R08: 0000000000000001 R09: 0000000000000003
 R10: 0000560fbd5d7ad0 R11: 0000000000000202 R12: 0000000000000001
 R13: 000000000000005e R14: 00007ffc3371bea0 R15: 00007ffc3371beb0
 task:fdm-stress        state:D stack:    0 pid:2508243 ppid:2508153 flags:0x00000000
 Call Trace:
  __schedule+0x5d1/0xcf0
  ? _raw_spin_unlock_irqrestore+0x3c/0x60
  schedule+0x45/0xe0
  __reserve_bytes+0x4a4/0xb10 [btrfs]
  ? finish_wait+0x90/0x90
  btrfs_reserve_metadata_bytes+0x29/0x190 [btrfs]
  btrfs_block_rsv_add+0x1f/0x50 [btrfs]
  start_transaction+0x2d1/0x760 [btrfs]
  btrfs_replace_file_extents+0x120/0x930 [btrfs]
  ? btrfs_fallocate+0xdcf/0x1260 [btrfs]
  btrfs_fallocate+0xdfb/0x1260 [btrfs]
  ? filename_lookup+0xf1/0x180
  vfs_fallocate+0x14f/0x440
  ioctl_preallocate+0x92/0xc0
  do_vfs_ioctl+0x66b/0x750
  ? __do_sys_newfstat+0x53/0x60
  __x64_sys_ioctl+0x62/0xb0
  do_syscall_64+0x33/0x80
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

So fix this by making fallocate use btrfs_lock_and_flush_ordered_range(),
passing it a value of true for the flush delalloc parameter. This way we
are guaranteed that we end up without any dirty pages in the range after
we have locked it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 36 ++++--------------------------------
 1 file changed, 4 insertions(+), 32 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index dd2d5d73804d..6528725d1a29 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3383,38 +3383,10 @@ static long btrfs_fallocate(struct file *file, int mode,
 	}
 
 	locked_end = alloc_end - 1;
-	while (1) {
-		struct btrfs_ordered_extent *ordered;
-
-		/* the extent lock is ordered inside the running
-		 * transaction
-		 */
-		lock_extent_bits(&BTRFS_I(inode)->io_tree, alloc_start,
-				 locked_end, &cached_state);
-		ordered = btrfs_lookup_first_ordered_extent(BTRFS_I(inode),
-							    locked_end);
-
-		if (ordered &&
-		    ordered->file_offset + ordered->num_bytes > alloc_start &&
-		    ordered->file_offset < alloc_end) {
-			btrfs_put_ordered_extent(ordered);
-			unlock_extent_cached(&BTRFS_I(inode)->io_tree,
-					     alloc_start, locked_end,
-					     &cached_state);
-			/*
-			 * we can't wait on the range with the transaction
-			 * running or with the extent lock held
-			 */
-			ret = btrfs_wait_ordered_range(inode, alloc_start,
-						       alloc_end - alloc_start);
-			if (ret)
-				goto out;
-		} else {
-			if (ordered)
-				btrfs_put_ordered_extent(ordered);
-			break;
-		}
-	}
+	ret = btrfs_lock_and_flush_ordered_range(BTRFS_I(inode), alloc_start,
+						 locked_end, true, &cached_state);
+	if (ret)
+		goto out;
 
 	/* First, check if we exceed the qgroup limit */
 	INIT_LIST_HEAD(&reserve_list);
-- 
2.28.0

