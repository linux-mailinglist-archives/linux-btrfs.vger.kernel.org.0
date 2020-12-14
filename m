Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8449E2D9ED7
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Dec 2020 19:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440748AbgLNSVE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Dec 2020 13:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440735AbgLNSUd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Dec 2020 13:20:33 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C10C06179C
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Dec 2020 10:19:53 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id bd6so8225288qvb.9
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Dec 2020 10:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=AeN6ivgHC82uEJDuVzIm5oYCOM9gnft3Ccr9v+xSQSo=;
        b=HC/yoEqYxkZjt368DHgUhfdqZhne/cf763oVLWxJP/N6PlZtdNpmEB63st+Ligs949
         HC5eAuzhOEZnK2lLIXgDxqjDFA74dBiIyIH8/9njsQr7zliVJQuIAYDt04qr8GRan91U
         cZB7+upCMukWm2DKWTJOgKAkT4BBk+XWBAmqQ/iXaOLo/gkOF+Lez3hNHTJV6QvlV01T
         bqYI5Y2pdCe4Y4ZQpstTUlX+bo1vzcSvEdazk3/V8Ou/2o4US6knQvcv0iXwBDJs3C3V
         n/QbdmXj5/ktSkeShxKc5MCJg/AMrdfGvxOozTE0k5BeyMyCsORQi8EO6r8iyritg6Oa
         TNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AeN6ivgHC82uEJDuVzIm5oYCOM9gnft3Ccr9v+xSQSo=;
        b=n0i0WFsjVAzTVr1hdOmqieVBffrQ66QAXUNUFhtigkuoXNOOHOSWxVeMJLViIfmHUP
         sB1qXNWSaGS+h/22ko19T0kRtLa5UkXP8Uz3Mv+YcTT4f9OWbFahto/PV1BCLZPMnV5q
         I/BhLDtV2vbOZSlc2HG+NsJ4MFQCIMAeqgskrlq3i3sgKpYUiJPVHHjrT6UdhKFbx4Wz
         MmT46X2T+xU/Hm2fcgmCTVK1ygrCwmIXqVPwz+xa9p6wMywCa1qwqOWDsGBfZBQ4BzhJ
         g1zhWWKC2jar0ifOHE8me7WzNipr1PrNtVN6y9jh/Jv+40PgZeZgtBfJLKW9J93tlLpp
         hGBA==
X-Gm-Message-State: AOAM531u2daV6aZaTDVUz8ZllQnqoRaW4aoBBbw3+HIezMQtLOACyJ9a
        2Zj2piRdA+CislFc5sg95bhpl18QoM0Z/bFK
X-Google-Smtp-Source: ABdhPJyZAgzRnFjb6ulf/7zERsrWvjxIygG3KLs88/TWUoPr2a39BZaH69/mu18ctE7vPlWXY2jFjA==
X-Received: by 2002:a05:6214:1110:: with SMTP id e16mr32784135qvs.57.1607969991816;
        Mon, 14 Dec 2020 10:19:51 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g28sm9285209qtm.91.2020.12.14.10.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 10:19:50 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/4] btrfs: exclude mmap from happening during all fallocate operations
Date:   Mon, 14 Dec 2020 13:19:41 -0500
Message-Id: <0598524d659ea05c5ed1fe2fb80326a04be83324.1607969636.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607969636.git.josef@toxicpanda.com>
References: <cover.1607969636.git.josef@toxicpanda.com>
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

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/file.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index ed633ae87e06..d573ffcbd626 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2872,7 +2872,7 @@ static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 	if (ret)
 		return ret;
 
-	btrfs_inode_lock(inode, 0);
+	btrfs_inode_lock(inode, BTRFS_ILOCK_MMAP);
 	ino_size = round_up(inode->i_size, fs_info->sectorsize);
 	ret = find_first_non_hole(BTRFS_I(inode), &offset, &len);
 	if (ret < 0)
@@ -2912,7 +2912,7 @@ static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 		truncated_block = true;
 		ret = btrfs_truncate_block(BTRFS_I(inode), offset, 0, 0);
 		if (ret) {
-			btrfs_inode_unlock(inode, 0);
+			btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
 			return ret;
 		}
 	}
@@ -3013,7 +3013,7 @@ static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 				ret = ret2;
 		}
 	}
-	btrfs_inode_unlock(inode, 0);
+	btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
 	return ret;
 }
 
@@ -3336,7 +3336,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 			return ret;
 	}
 
-	btrfs_inode_lock(inode, 0);
+	btrfs_inode_lock(inode, BTRFS_ILOCK_MMAP);
 
 	if (!(mode & FALLOC_FL_KEEP_SIZE) && offset + len > inode->i_size) {
 		ret = inode_newsize_ok(inode, offset + len);
@@ -3378,7 +3378,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 
 	if (mode & FALLOC_FL_ZERO_RANGE) {
 		ret = btrfs_zero_range(inode, offset, len, mode);
-		btrfs_inode_unlock(inode, 0);
+		btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
 		return ret;
 	}
 
@@ -3488,7 +3488,7 @@ static long btrfs_fallocate(struct file *file, int mode,
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

