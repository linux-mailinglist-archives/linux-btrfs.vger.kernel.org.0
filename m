Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD7131731F
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Feb 2021 23:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbhBJWQR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Feb 2021 17:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbhBJWPs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Feb 2021 17:15:48 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9DBC06178A
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Feb 2021 14:14:47 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id e15so2768561qte.9
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Feb 2021 14:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ia1yV7Vl7z3+95kkI7KZb6y6VoQu9ir2RgF0eVsZwgY=;
        b=lysIitfU8842e0tIkwOBFo7BORKFSLzyck4ryyD3+8hrtGS5bPCFEvqE4xPxy6SMnq
         QT1h1FtblICZoCtpMKjde6ejcf3W1/BB2b2aUKIev9+CnE3KqS6ZBh76o7pbRbGvUu4h
         q58NJoM8TP/6sd8A+XYhzFFM9g5U/0hShJCydFFEK0zlp6ybuBv8wC0gP9uaU7hBL0nV
         +TamPvSOzt3uQLZAvsQpawJgquxjGbcksKTHxM+FYSkz6LEcEoX/4S0dQMIlcoiXq3nR
         +zQUa+ZUkBQ0i7aUDu9wKFckEJFKsoOVEyBUKcDKYmgZVCFRNygINNc+BP4E4IpeUcY5
         ouWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ia1yV7Vl7z3+95kkI7KZb6y6VoQu9ir2RgF0eVsZwgY=;
        b=egM949wRg2rw0XeW68lX6lg880FaFzLKHkTXsBc0pNZrELWvepTvc1+Ht7TeuO0mwX
         xHNjtRd+w4l0Y9Q8Z0kRbefo6RJxCAbaXpCb+Hoi/y+bzRSmxO0VxS4DQAH41x0qRLak
         5MM5S6GxQNnKRitLX0GlgWTuiGMW5kSyFqByWtoXn21lDmyGa0zZPUNFYRM8JCs8btRf
         xbcPf+Qrhglr+pFdJwZAiV49u45KBbpLb25UpSzh4a51EkqfS/bM2S7Lnv5oNhYHdm5i
         MdPN+GbP9byOZxtcwA1rXJc7jGFPsk6rN4xxu6xC3NQcwHdctIzS4EAxqMXP6TRCDwc9
         nMcQ==
X-Gm-Message-State: AOAM531/tcA6fD3i3KnehzKZfzOhE6oyOkCiHL4Apx/E4eyHfYCKG2uz
        4S9q7NH29xuR1bTS89rYy4boDCOUz5tR562O
X-Google-Smtp-Source: ABdhPJwFj7byehZDbybv9os4Itf4yG9bXysks4gf9I77MhwSW1gWmQlI1BSX7dqOBoWLE6nmxD+UPw==
X-Received: by 2002:ac8:59c1:: with SMTP id f1mr4817348qtf.310.1612995285957;
        Wed, 10 Feb 2021 14:14:45 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s9sm2555482qke.67.2021.02.10.14.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 14:14:45 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2 4/4] btrfs: exclude mmap from happening during all fallocate operations
Date:   Wed, 10 Feb 2021 17:14:36 -0500
Message-Id: <74e3efcc0f2a011b0caed71a0480c24e8739586d.1612995212.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1612995212.git.josef@toxicpanda.com>
References: <cover.1612995212.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There's a small window where a deadlock can happen between fallocate and
mmap.  This is described in detail by Filipe

"""
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
"""

Fix this by disallowing mmaps from happening while we're doing any of
the fallocate operations on this inode.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/file.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 728736e3d4b8..3a2928749349 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2868,7 +2868,7 @@ static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 	if (ret)
 		return ret;
 
-	btrfs_inode_lock(inode, 0);
+	btrfs_inode_lock(inode, BTRFS_ILOCK_MMAP);
 	ino_size = round_up(inode->i_size, fs_info->sectorsize);
 	ret = find_first_non_hole(BTRFS_I(inode), &offset, &len);
 	if (ret < 0)
@@ -2908,7 +2908,7 @@ static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 		truncated_block = true;
 		ret = btrfs_truncate_block(BTRFS_I(inode), offset, 0, 0);
 		if (ret) {
-			btrfs_inode_unlock(inode, 0);
+			btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
 			return ret;
 		}
 	}
@@ -3009,7 +3009,7 @@ static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 				ret = ret2;
 		}
 	}
-	btrfs_inode_unlock(inode, 0);
+	btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
 	return ret;
 }
 
@@ -3332,7 +3332,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 			return ret;
 	}
 
-	btrfs_inode_lock(inode, 0);
+	btrfs_inode_lock(inode, BTRFS_ILOCK_MMAP);
 
 	if (!(mode & FALLOC_FL_KEEP_SIZE) && offset + len > inode->i_size) {
 		ret = inode_newsize_ok(inode, offset + len);
@@ -3374,7 +3374,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 
 	if (mode & FALLOC_FL_ZERO_RANGE) {
 		ret = btrfs_zero_range(inode, offset, len, mode);
-		btrfs_inode_unlock(inode, 0);
+		btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
 		return ret;
 	}
 
@@ -3484,7 +3484,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 	unlock_extent_cached(&BTRFS_I(inode)->io_tree, alloc_start, locked_end,
 			     &cached_state);
 out:
-	btrfs_inode_unlock(inode, 0);
+	btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
 	/* Let go of our reservation. */
 	if (ret != 0 && !(mode & FALLOC_FL_ZERO_RANGE))
 		btrfs_free_reserved_data_space(BTRFS_I(inode), data_reserved,
-- 
2.26.2

