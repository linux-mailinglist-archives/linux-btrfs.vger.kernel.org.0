Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745C031731B
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Feb 2021 23:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbhBJWQJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Feb 2021 17:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbhBJWPs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Feb 2021 17:15:48 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B470C061788
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Feb 2021 14:14:45 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id u20so3401229qku.7
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Feb 2021 14:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oZgMHv3lnXbZpiNm7FRfKFXA7Wzot+u+i1VVa5WD74E=;
        b=LJxSOxlius42ZFM78MCqabdIL3I4u86Stg1pclcfhjndgRdgAXSxwfUj3CeWxNiGyF
         IUGf+bb/jg4+ipJZT1lhwyPH1jLKj6CMLg5ZO+y+ya/Kz4MeMyVFFYVig1XjT+OENVrw
         AYPwE8keP2zjAVEMOMVEl10l2zjMGmkB7SIJDteha3o9/yWHgDfjCKSOSTUSjFb8JGxE
         sVDMgt8cOqV78GfOg2gWhw81iQc2IxdJVcWQ5ZeMZTsL4lcfwKJWf7UO3PcP19U9Ow4/
         YqKtAU4JHBhsKWSjla+cDvRY9iuK+GdohzYNciH1umK3z+MsKBZ51yqI54TopTkkggu3
         COeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oZgMHv3lnXbZpiNm7FRfKFXA7Wzot+u+i1VVa5WD74E=;
        b=NaNktPzTK7ApIdR7nJWjWO6+8qBVcPztAFgjDSQ25/yZxfqeHDgI2pFP9xF1bUgQis
         CNLM2CwU3Jta9Nn/j86tSjU3vuBj+WIWdA6iGXZdL1+z3FFU43zNQyDy4oNTUG+6J/kW
         wuzJqqK3WhI4ZbhcnlUa37Z04z+6EugI4abq+z9De5d2Zsr2jCwyZDiQjOQI2lG8ZrM4
         LtlFM6IULw0IXsiBblQZbalQw5eT3fu1Ce3xNAvGl9K82YE9hPqfwz5YwxqbdnCZv7+s
         qQkFn60BtGOlYIYNoQMqCU9heV6qF+U0FAhPiYdKiUWeK8QqBbkFVY804K3ubcL4P6WZ
         5+Mw==
X-Gm-Message-State: AOAM533+Qr13Sk2oZMT6pNWJoNdc71Bh/5TtuGkrb83amIu8rlp/+6z0
        aojKyOHUJZdv4O0yBKQVSCqdV/B/E40qK+Lx
X-Google-Smtp-Source: ABdhPJyOghA8Vvwafc4DTRmFIx7pRZwR9UVA9CSsQOzSd0L7zpmFK1z2opHrPIrv6LOM0bGerHA91w==
X-Received: by 2002:a05:620a:b86:: with SMTP id k6mr5670184qkh.200.1612995284224;
        Wed, 10 Feb 2021 14:14:44 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a25sm2130105qtw.87.2021.02.10.14.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 14:14:43 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2 3/4] btrfs: exclude mmaps while doing remap
Date:   Wed, 10 Feb 2021 17:14:35 -0500
Message-Id: <78f6c599aea8e4b887583736670f9d61a8cc4b3c.1612995212.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1612995212.git.josef@toxicpanda.com>
References: <cover.1612995212.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Darrick reported a potential issue to me where we could allow mmap
writes after validating a page range matched in the case of dedupe.
Generally we rely on lock page -> lock extent with the ordered flush to
protect us, but this is done after we check the pages because we use the
generic helpers, so we could modify the page in between doing the check
and locking the range.

There also exists a deadlock, as described by Filipe

"""
When cloning a file range, we lock the inodes, flush any delalloc within
the respective file ranges, wait for any ordered extents and then lock the
file ranges in both inodes. This means that right after we flush delalloc
and before we lock the file ranges, memory mapped writes can come in and
dirty pages in the file ranges of the clone operation.

Most of the time this is harmless and causes no problems. However, if we
are low on available metadata space, we can later end up in a deadlock
when starting a transaction to replace file extent items. This happens if
when allocating metadata space for the transaction, we need to wait for
the async reclaim thread to release space and the reclaim thread needs to
flush delalloc for the inode that got the memory mapped write and has its
range locked by the clone task.

Basically what happens is the following:

1) A clone operation locks inodes A and B, flushes delalloc for both
   inodes in the respective file ranges and waits for any ordered extents
   in those ranges to complete;

2) Before the clone task locks the file ranges, another task does a
   memory mapped write (which does not lock the inode) for one of the
   inodes of the clone operation. So now we have a dirty page in one of
   the ranges used by the clone operation;

3) The clone operation locks the file ranges for inodes A and B;

4) Later, when iterating over the file extents of inode A, the clone
   task attempts to start a transaction. There's not enough available
   free metadata space, so the async reclaim task is started (if not
   running already) and we wait for someone to wake us up on our
   reservation ticket;

5) The async reclaim task is not able to release space by any other
   means and decides to flush delalloc for the inode of the clone
   operation;

6) The workqueue job used to flush the inode blocks when starting
   delalloc for the inode, since the file range is currently locked by
   the clone task;

7) But the clone task is waiting on its reservation ticket and the async
   reclaim task is waiting on the flush job to complete, which can't
   progress since the clone task has the file range locked. So unless
   some other task is able to release space, for example an ordered
   extent for some other inode completes, we have a deadlock between all
   these tasks;

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
several other tasks blocked on inode locks held by the clone task below
(...)
 RIP: 0033:0x7f61efe73fff
 Code: Unable to access opcode bytes at RIP 0x7f61efe73fd5.
 RSP: 002b:00007ffc3371bbe8 EFLAGS: 00000202 ORIG_RAX: 000000000000013c
 RAX: ffffffffffffffda RBX: 00007ffc3371bea0 RCX: 00007f61efe73fff
 RDX: 00000000ffffff9c RSI: 0000560fbd604690 RDI: 00000000ffffff9c
 RBP: 00007ffc3371beb0 R08: 0000000000000002 R09: 0000560fbd5d75f0
 R10: 0000560fbd5d81f0 R11: 0000000000000202 R12: 0000000000000002
 R13: 000000000000000b R14: 00007ffc3371bea0 R15: 00007ffc3371beb0
 task: fdm-stress        state:D stack:    0 pid:2508234 ppid:2508153 flags:0x00004000
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
  ? lock_release+0x20e/0x4c0
  btrfs_clone+0x3e4/0x7e0 [btrfs]
  ? btrfs_lookup_first_ordered_extent+0x8e/0x100 [btrfs]
  btrfs_clone_files+0xf6/0x150 [btrfs]
  btrfs_remap_file_range+0x324/0x3d0 [btrfs]
  do_clone_file_range+0xd4/0x1f0
  vfs_clone_file_range+0x4d/0x230
  ? lock_release+0x20e/0x4c0
  ioctl_file_clone+0x8f/0xc0
  do_vfs_ioctl+0x342/0x750
  __x64_sys_ioctl+0x62/0xb0
  do_syscall_64+0x33/0x80
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
"""

Fix both of these issues by excluding mmaps from happening we are doing
any sort of remap, which prevents this race completely.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/reflink.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 12df3ee84e93..bb87f4037cf6 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -590,6 +590,20 @@ static void btrfs_double_extent_lock(struct inode *inode1, u64 loff1,
 	lock_extent(&BTRFS_I(inode2)->io_tree, loff2, loff2 + len - 1);
 }
 
+static void btrfs_double_mmap_lock(struct inode *inode1, struct inode *inode2)
+{
+	if (inode1 < inode2)
+		swap(inode1, inode2);
+	down_write(&BTRFS_I(inode1)->i_mmap_lock);
+	down_write_nested(&BTRFS_I(inode2)->i_mmap_lock, SINGLE_DEPTH_NESTING);
+}
+
+static void btrfs_double_mmap_unlock(struct inode *inode1, struct inode *inode2)
+{
+	up_write(&BTRFS_I(inode1)->i_mmap_lock);
+	up_write(&BTRFS_I(inode2)->i_mmap_lock);
+}
+
 static int btrfs_extent_same_range(struct inode *src, u64 loff, u64 len,
 				   struct inode *dst, u64 dst_loff)
 {
@@ -818,10 +832,12 @@ loff_t btrfs_remap_file_range(struct file *src_file, loff_t off,
 	if (remap_flags & ~(REMAP_FILE_DEDUP | REMAP_FILE_ADVISORY))
 		return -EINVAL;
 
-	if (same_inode)
-		btrfs_inode_lock(src_inode, 0);
-	else
+	if (same_inode) {
+		btrfs_inode_lock(src_inode, BTRFS_ILOCK_MMAP);
+	} else {
 		lock_two_nondirectories(src_inode, dst_inode);
+		btrfs_double_mmap_lock(src_inode, dst_inode);
+	}
 
 	ret = btrfs_remap_file_range_prep(src_file, off, dst_file, destoff,
 					  &len, remap_flags);
@@ -834,10 +850,12 @@ loff_t btrfs_remap_file_range(struct file *src_file, loff_t off,
 		ret = btrfs_clone_files(dst_file, src_file, off, len, destoff);
 
 out_unlock:
-	if (same_inode)
-		btrfs_inode_unlock(src_inode, 0);
-	else
+	if (same_inode) {
+		btrfs_inode_unlock(src_inode, BTRFS_ILOCK_MMAP);
+	} else {
+		btrfs_double_mmap_unlock(src_inode, dst_inode);
 		unlock_two_nondirectories(src_inode, dst_inode);
+	}
 
 	return ret < 0 ? ret : len;
 }
-- 
2.26.2

