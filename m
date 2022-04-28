Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB42F513601
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 16:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbiD1OEU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 10:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348166AbiD1ODw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 10:03:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630CAB6E64
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 06:59:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC8E661778
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 13:59:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1972C385A0
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 13:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651154391;
        bh=BvspJ38yXaq7lbjhx0Wm0VS9aAHOKAE281nhk+faF3Y=;
        h=From:To:Subject:Date:From;
        b=GvVCsG2oEeYGSQuy/fn9j4TGQjlqVecRpvEiDIzB18bJD2ji10trcHVtar4s2VWU2
         wwxXPm4hWWP8ylEZqHv+sUBGurSKRqjoQ425cq+h/kgTEusHqZCxm++NLP/XUpO/AH
         vSdbtYOfpbtHIphMXxkXfzZLzgFsy8bcY/SRhGmhGAbHW0HYm551uFPDEKs6vU7cJ3
         djAfqQlWuygFlwSRMeF6Ybsc05nRa+kJ4pWeVIE0iVcv4u796AkLCUbz5KDEtxJdoI
         iyecKyZXzxBqPEtPUJoxfzSZ+VAoKmPa0/mTlMsH7sqHr+7JbHbwY6KKdaJ7wEoKOn
         ImDdbFX/ihPkg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix deadlock between concurrent dio writes when low on free data space
Date:   Thu, 28 Apr 2022 14:59:46 +0100
Message-Id: <ca54a0f0251d2f77c51747de0e096f7f29542feb.1651154066.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When reserving data space for a direct IO write we can end up deadlocking
if we have multiple tasks attempting a write to the same file range, there
are multiple extents covered by that file range, we are low on available
space for data and the writes don't expand the inode's i_size.

The deadlock can happen like this:

1) We have a file with an i_size of 1M, at offset 0 it has an extent with
   a size of 128K and at offset 128K it has another extent also with a
   size of 128K;

2) Task A does a direct IO write against file range [0, 256K[, and because
   the write is within the i_size boundary, it takes the inode's lock (VFS
   level) in shared mode;

3) Task A locks the file range [0, 256K[ at btrfs_dio_iomap_begin(), and
   then gets the extent map for the extent covering the range [0, 128K[.
   At btrfs_get_blocks_direct_write(), it creates an ordered extent for
   that file range ([0, 128K[);

4) Before returning from btrfs_dio_iomap_begin(), it unlocks the file
   range [0, 256K[;

5) Task A executes btrfs_dio_iomap_begin() again, this time for the file
   range [128K, 256K[, and locks the file range [128K, 256K[;

6) Task B starts a direct IO write against file range [0, 256K[ as well.
   It also locks the inode in shared mode, as it's within the i_size limit,
   and then tries to lock file range [0, 256K[. It is able to lock the
   subrange [0, 128K[ but then blocks waiting for the range [128K, 256K[,
   as it is currently locked by task A;

7) Task A enters btrfs_get_blocks_direct_write() and tries to reserve data
   space. Because we are low on available free space, it triggers the
   async data reclaim task, and waits for it to reserve data space;

8) The async reclaim task decides to wait for all existing ordered extents
   to complete (through btrfs_wait_ordered_roots()).
   It finds the ordered extent previously created by task A for the file
   range [0, 128K[ and waits for it to complete;

9) The ordered extent for the file range [0, 128K[ can not complete
   because it blocks at btrfs_finish_ordered_io() when trying to lock the
   file range [0, 128K[.

   This results in a deadlock, because:

   - task B is holding the file range [0, 128K[ locked, waiting for the
     range [128K, 256K[ to be unlocked by task A;

   - task A is holding the file range [128K, 256K[ locked and it's waiting
     for the async data reclaim task to satisfy its space reservation
     request;

   - the async data reclaim task is waiting for ordered extent [0, 128K[
     to complete, but the ordered extent can not complete because the
     file range [0, 128K[ is currently locked by task B, which is waiting
     on task A to unlock file range [128K, 256K[ and task A waiting
     on the async data reclaim task.

   This results in a deadlock between 4 task: task A, task B, the async
   data reclaim task and the task doing ordered extent completion (a work
   queue task).

This type of deadlock can sporadically be triggered by the test case
generic/300 from fstests, and results in a stack trace like the following:

[12084.033689] INFO: task kworker/u16:7:123749 blocked for more than 241 seconds.
[12084.034877]       Not tainted 5.18.0-rc2-btrfs-next-115 #1
[12084.035562] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[12084.036548] task:kworker/u16:7   state:D stack:    0 pid:123749 ppid:     2 flags:0x00004000
[12084.036554] Workqueue: btrfs-flush_delalloc btrfs_work_helper [btrfs]
[12084.036599] Call Trace:
[12084.036601]  <TASK>
[12084.036606]  __schedule+0x3cb/0xed0
[12084.036616]  schedule+0x4e/0xb0
[12084.036620]  btrfs_start_ordered_extent+0x109/0x1c0 [btrfs]
[12084.036651]  ? prepare_to_wait_exclusive+0xc0/0xc0
[12084.036659]  btrfs_run_ordered_extent_work+0x1a/0x30 [btrfs]
[12084.036688]  btrfs_work_helper+0xf8/0x400 [btrfs]
[12084.036719]  ? lock_is_held_type+0xe8/0x140
[12084.036727]  process_one_work+0x252/0x5a0
[12084.036736]  ? process_one_work+0x5a0/0x5a0
[12084.036738]  worker_thread+0x52/0x3b0
[12084.036743]  ? process_one_work+0x5a0/0x5a0
[12084.036745]  kthread+0xf2/0x120
[12084.036747]  ? kthread_complete_and_exit+0x20/0x20
[12084.036751]  ret_from_fork+0x22/0x30
[12084.036765]  </TASK>
[12084.036769] INFO: task kworker/u16:11:153787 blocked for more than 241 seconds.
[12084.037702]       Not tainted 5.18.0-rc2-btrfs-next-115 #1
[12084.038540] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[12084.039506] task:kworker/u16:11  state:D stack:    0 pid:153787 ppid:     2 flags:0x00004000
[12084.039511] Workqueue: events_unbound btrfs_async_reclaim_data_space [btrfs]
[12084.039551] Call Trace:
[12084.039553]  <TASK>
[12084.039557]  __schedule+0x3cb/0xed0
[12084.039566]  schedule+0x4e/0xb0
[12084.039569]  schedule_timeout+0xed/0x130
[12084.039573]  ? mark_held_locks+0x50/0x80
[12084.039578]  ? _raw_spin_unlock_irq+0x24/0x50
[12084.039580]  ? lockdep_hardirqs_on+0x7d/0x100
[12084.039585]  __wait_for_common+0xaf/0x1f0
[12084.039587]  ? usleep_range_state+0xb0/0xb0
[12084.039596]  btrfs_wait_ordered_extents+0x3d6/0x470 [btrfs]
[12084.039636]  btrfs_wait_ordered_roots+0x175/0x240 [btrfs]
[12084.039670]  flush_space+0x25b/0x630 [btrfs]
[12084.039712]  btrfs_async_reclaim_data_space+0x108/0x1b0 [btrfs]
[12084.039747]  process_one_work+0x252/0x5a0
[12084.039756]  ? process_one_work+0x5a0/0x5a0
[12084.039758]  worker_thread+0x52/0x3b0
[12084.039762]  ? process_one_work+0x5a0/0x5a0
[12084.039765]  kthread+0xf2/0x120
[12084.039766]  ? kthread_complete_and_exit+0x20/0x20
[12084.039770]  ret_from_fork+0x22/0x30
[12084.039783]  </TASK>
[12084.039800] INFO: task kworker/u16:17:217907 blocked for more than 241 seconds.
[12084.040709]       Not tainted 5.18.0-rc2-btrfs-next-115 #1
[12084.041398] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[12084.042404] task:kworker/u16:17  state:D stack:    0 pid:217907 ppid:     2 flags:0x00004000
[12084.042411] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
[12084.042461] Call Trace:
[12084.042463]  <TASK>
[12084.042471]  __schedule+0x3cb/0xed0
[12084.042485]  schedule+0x4e/0xb0
[12084.042490]  wait_extent_bit.constprop.0+0x1eb/0x260 [btrfs]
[12084.042539]  ? prepare_to_wait_exclusive+0xc0/0xc0
[12084.042551]  lock_extent_bits+0x37/0x90 [btrfs]
[12084.042601]  btrfs_finish_ordered_io.isra.0+0x3fd/0x960 [btrfs]
[12084.042656]  ? lock_is_held_type+0xe8/0x140
[12084.042667]  btrfs_work_helper+0xf8/0x400 [btrfs]
[12084.042716]  ? lock_is_held_type+0xe8/0x140
[12084.042727]  process_one_work+0x252/0x5a0
[12084.042742]  worker_thread+0x52/0x3b0
[12084.042750]  ? process_one_work+0x5a0/0x5a0
[12084.042754]  kthread+0xf2/0x120
[12084.042757]  ? kthread_complete_and_exit+0x20/0x20
[12084.042763]  ret_from_fork+0x22/0x30
[12084.042783]  </TASK>
[12084.042798] INFO: task fio:234517 blocked for more than 241 seconds.
[12084.043598]       Not tainted 5.18.0-rc2-btrfs-next-115 #1
[12084.044282] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[12084.045244] task:fio             state:D stack:    0 pid:234517 ppid:234515 flags:0x00004000
[12084.045248] Call Trace:
[12084.045250]  <TASK>
[12084.045254]  __schedule+0x3cb/0xed0
[12084.045263]  schedule+0x4e/0xb0
[12084.045266]  wait_extent_bit.constprop.0+0x1eb/0x260 [btrfs]
[12084.045298]  ? prepare_to_wait_exclusive+0xc0/0xc0
[12084.045306]  lock_extent_bits+0x37/0x90 [btrfs]
[12084.045336]  btrfs_dio_iomap_begin+0x336/0xc60 [btrfs]
[12084.045370]  ? lock_is_held_type+0xe8/0x140
[12084.045378]  iomap_iter+0x184/0x4c0
[12084.045383]  __iomap_dio_rw+0x2c6/0x8a0
[12084.045406]  iomap_dio_rw+0xa/0x30
[12084.045408]  btrfs_do_write_iter+0x370/0x5e0 [btrfs]
[12084.045440]  aio_write+0xfa/0x2c0
[12084.045448]  ? __might_fault+0x2a/0x70
[12084.045451]  ? kvm_sched_clock_read+0x14/0x40
[12084.045455]  ? lock_release+0x153/0x4a0
[12084.045463]  io_submit_one+0x615/0x9f0
[12084.045467]  ? __might_fault+0x2a/0x70
[12084.045469]  ? kvm_sched_clock_read+0x14/0x40
[12084.045478]  __x64_sys_io_submit+0x83/0x160
[12084.045483]  ? syscall_enter_from_user_mode+0x1d/0x50
[12084.045489]  do_syscall_64+0x3b/0x90
[12084.045517]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[12084.045521] RIP: 0033:0x7fa76511af79
[12084.045525] RSP: 002b:00007ffd6d6b9058 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
[12084.045530] RAX: ffffffffffffffda RBX: 00007fa75ba6e760 RCX: 00007fa76511af79
[12084.045532] RDX: 0000557b304ff3f0 RSI: 0000000000000001 RDI: 00007fa75ba4c000
[12084.045535] RBP: 00007fa75ba4c000 R08: 00007fa751b76000 R09: 0000000000000330
[12084.045537] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
[12084.045540] R13: 0000000000000000 R14: 0000557b304ff3f0 R15: 0000557b30521eb0
[12084.045561]  </TASK>

Fix this issue by always reserving data space before locking a file range
at btrfs_dio_iomap_begin(). If we can't reserve the space, then we don't
error out immediately - instead after locking the file range, check if we
can do a NOCOW write, and if we can we don't error out since we don't need
to allocate a data extent, however if we can't NOCOW then error out with
-ENOSPC. This also implies that we may end up reserving space when it's
not needed because the write will end up being done in NOCOW mode - in that
case we just release the space after we noticed we did a NOCOW write - this
is the same type of logic that is done in the path for buffered IO writes.

Fixes: f0bfa76a11e93d ("btrfs: fix ENOSPC failure when attempting direct IO write into NOCOW range")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 82 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 65 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 99d8cf519550..b697f314c4c9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -64,6 +64,8 @@ struct btrfs_iget_args {
 struct btrfs_dio_data {
 	ssize_t submitted;
 	struct extent_changeset *data_reserved;
+	bool data_space_reserved;
+	bool nocow_done;
 };
 
 struct btrfs_rename_ctx {
@@ -7481,6 +7483,8 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 			ret = PTR_ERR(em2);
 			goto out;
 		}
+
+		dio_data->nocow_done = true;
 	} else {
 		/* Our caller expects us to free the input extent map. */
 		free_extent_map(em);
@@ -7489,10 +7493,19 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		if (nowait)
 			return -EAGAIN;
 
-		/* We have to COW, so need to reserve metadata and data space. */
-		ret = btrfs_delalloc_reserve_space(BTRFS_I(inode),
-						   &dio_data->data_reserved,
-						   start, len);
+		/*
+		 * If we could not allocate data space before locking the file
+		 * range and we can't do a NOCOW write, then we have to fail.
+		 */
+		if (!dio_data->data_space_reserved)
+			return -ENOSPC;
+
+		/*
+		 * We have to COW and we have already reserved data space before,
+		 * so now we reserve only metadata.
+		 */
+		ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode), len, len,
+						      false);
 		if (ret < 0)
 			goto out;
 		space_reserved = true;
@@ -7505,10 +7518,8 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		*map = em;
 		len = min(len, em->len - (start - em->start));
 		if (len < prev_len)
-			btrfs_delalloc_release_space(BTRFS_I(inode),
-						     dio_data->data_reserved,
-						     start + len, prev_len - len,
-						     true);
+			btrfs_delalloc_release_metadata(BTRFS_I(inode),
+							prev_len - len, true);
 	}
 
 	/*
@@ -7526,15 +7537,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 out:
 	if (ret && space_reserved) {
 		btrfs_delalloc_release_extents(BTRFS_I(inode), len);
-		if (can_nocow) {
-			btrfs_delalloc_release_metadata(BTRFS_I(inode), len, true);
-		} else {
-			btrfs_delalloc_release_space(BTRFS_I(inode),
-						     dio_data->data_reserved,
-						     start, len, true);
-			extent_changeset_free(dio_data->data_reserved);
-			dio_data->data_reserved = NULL;
-		}
+		btrfs_delalloc_release_metadata(BTRFS_I(inode), len, true);
 	}
 	return ret;
 }
@@ -7551,6 +7554,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	const bool write = !!(flags & IOMAP_WRITE);
 	int ret = 0;
 	u64 len = length;
+	const u64 data_alloc_len = length;
 	bool unlock_extents = false;
 
 	if (!write)
@@ -7603,6 +7607,25 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 
 	iomap->private = dio_data;
 
+	/*
+	 * We always try to allocate data space and must do it before locking
+	 * the file range, to avoid deadlocks with concurrent writes to the same
+	 * range if the range has several extents and the writes don't expand the
+	 * current i_size (the inode lock is taken in shared mode). If we fail to
+	 * allocate data space here we continue and later, after locking the
+	 * file range, we fail with ENOSPC only if we figure out we can not do a
+	 * NOCOW write.
+	 */
+	if (write && !(flags & IOMAP_NOWAIT)) {
+		ret = btrfs_check_data_free_space(BTRFS_I(inode),
+						  &dio_data->data_reserved,
+						  start, data_alloc_len);
+		if (!ret)
+			dio_data->data_space_reserved = true;
+		else if (ret && !(BTRFS_I(inode)->flags &
+				  (BTRFS_INODE_NODATACOW | BTRFS_INODE_PREALLOC)))
+			goto err;
+	}
 
 	/*
 	 * If this errors out it's because we couldn't invalidate pagecache for
@@ -7677,6 +7700,24 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 		unlock_extents = true;
 		/* Recalc len in case the new em is smaller than requested */
 		len = min(len, em->len - (start - em->start));
+		if (dio_data->data_space_reserved) {
+			u64 release_offset;
+			u64 release_len = 0;
+
+			if (dio_data->nocow_done) {
+				release_offset = start;
+				release_len = data_alloc_len;
+			} else if (len < data_alloc_len) {
+				release_offset = start + len;
+				release_len = data_alloc_len - len;
+			}
+
+			if (release_len > 0)
+				btrfs_free_reserved_data_space(BTRFS_I(inode),
+							       dio_data->data_reserved,
+							       release_offset,
+							       release_len);
+		}
 	} else {
 		/*
 		 * We need to unlock only the end area that we aren't using.
@@ -7721,6 +7762,13 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	unlock_extent_cached(&BTRFS_I(inode)->io_tree, lockstart, lockend,
 			     &cached_state);
 err:
+	if (dio_data->data_space_reserved) {
+		btrfs_free_reserved_data_space(BTRFS_I(inode),
+					       dio_data->data_reserved,
+					       start, data_alloc_len);
+		extent_changeset_free(dio_data->data_reserved);
+	}
+
 	kfree(dio_data);
 
 	return ret;
-- 
2.35.1

