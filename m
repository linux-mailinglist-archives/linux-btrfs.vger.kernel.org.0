Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793EF40A009
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 00:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348788AbhIMWgZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Sep 2021 18:36:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:50606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348400AbhIMWfr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Sep 2021 18:35:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B937461214;
        Mon, 13 Sep 2021 22:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631572470;
        bh=mnRX1d7Mm03vcqyNiGgdKuP9HG1VZKPJGIZdkDaUQzM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ihak6FCbj9YLpJ7sYt1aE7D0iGS1Hs+s5YmsJgQDrakt7pDkNAhuwtPuIxq9oyKBf
         dJoEZJx4gGuKiFdkr6TITDF8Lunxegg7oqsSCWud97uiW1/R6wzK3NzCjxJNwEpah+
         O6qQbaNfZlqM/fyLdZzWR3WZkS1w0Tz0bfM39LbzhVtQA5WtzEn8c7+jkeWZSmX46M
         mCIjMEg9nQ8dDE9dQ6cS4QmGqasGTObeapx4g1TUTbyF8kvsap7H7HlL1pAz0l8Jdz
         4mXTCf2hsywoj+H/gDCB50DrPPElsCJGSzqPJMI+WTSxyIuRAEBqtgRA6W1tVmYGGj
         fyHRC/bcg+a+w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.13 11/19] btrfs: update the bdev time directly when closing
Date:   Mon, 13 Sep 2021 18:34:07 -0400
Message-Id: <20210913223415.435654-11-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913223415.435654-1-sashal@kernel.org>
References: <20210913223415.435654-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 8f96a5bfa1503e0a5f3c78d51e993a1794d4aff1 ]

We update the ctime/mtime of a block device when we remove it so that
blkid knows the device changed.  However we do this by re-opening the
block device and calling filp_update_time.  This is more correct because
it'll call the inode->i_op->update_time if it exists, but the block dev
inodes do not do this.  Instead call generic_update_time() on the
bd_inode in order to avoid the blkdev_open path and get rid of the
following lockdep splat:

======================================================
WARNING: possible circular locking dependency detected
5.14.0-rc2+ #406 Not tainted
------------------------------------------------------
losetup/11596 is trying to acquire lock:
ffff939640d2f538 ((wq_completion)loop0){+.+.}-{0:0}, at: flush_workqueue+0x67/0x5e0

but task is already holding lock:
ffff939655510c68 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x41/0x660 [loop]

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #4 (&lo->lo_mutex){+.+.}-{3:3}:
       __mutex_lock+0x7d/0x750
       lo_open+0x28/0x60 [loop]
       blkdev_get_whole+0x25/0xf0
       blkdev_get_by_dev.part.0+0x168/0x3c0
       blkdev_open+0xd2/0xe0
       do_dentry_open+0x161/0x390
       path_openat+0x3cc/0xa20
       do_filp_open+0x96/0x120
       do_sys_openat2+0x7b/0x130
       __x64_sys_openat+0x46/0x70
       do_syscall_64+0x38/0x90
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #3 (&disk->open_mutex){+.+.}-{3:3}:
       __mutex_lock+0x7d/0x750
       blkdev_get_by_dev.part.0+0x56/0x3c0
       blkdev_open+0xd2/0xe0
       do_dentry_open+0x161/0x390
       path_openat+0x3cc/0xa20
       do_filp_open+0x96/0x120
       file_open_name+0xc7/0x170
       filp_open+0x2c/0x50
       btrfs_scratch_superblocks.part.0+0x10f/0x170
       btrfs_rm_device.cold+0xe8/0xed
       btrfs_ioctl+0x2a31/0x2e70
       __x64_sys_ioctl+0x80/0xb0
       do_syscall_64+0x38/0x90
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #2 (sb_writers#12){.+.+}-{0:0}:
       lo_write_bvec+0xc2/0x240 [loop]
       loop_process_work+0x238/0xd00 [loop]
       process_one_work+0x26b/0x560
       worker_thread+0x55/0x3c0
       kthread+0x140/0x160
       ret_from_fork+0x1f/0x30

-> #1 ((work_completion)(&lo->rootcg_work)){+.+.}-{0:0}:
       process_one_work+0x245/0x560
       worker_thread+0x55/0x3c0
       kthread+0x140/0x160
       ret_from_fork+0x1f/0x30

-> #0 ((wq_completion)loop0){+.+.}-{0:0}:
       __lock_acquire+0x10ea/0x1d90
       lock_acquire+0xb5/0x2b0
       flush_workqueue+0x91/0x5e0
       drain_workqueue+0xa0/0x110
       destroy_workqueue+0x36/0x250
       __loop_clr_fd+0x9a/0x660 [loop]
       block_ioctl+0x3f/0x50
       __x64_sys_ioctl+0x80/0xb0
       do_syscall_64+0x38/0x90
       entry_SYSCALL_64_after_hwframe+0x44/0xae

other info that might help us debug this:

Chain exists of:
  (wq_completion)loop0 --> &disk->open_mutex --> &lo->lo_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&lo->lo_mutex);
                               lock(&disk->open_mutex);
                               lock(&lo->lo_mutex);
  lock((wq_completion)loop0);

 *** DEADLOCK ***

1 lock held by losetup/11596:
 #0: ffff939655510c68 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x41/0x660 [loop]

stack backtrace:
CPU: 1 PID: 11596 Comm: losetup Not tainted 5.14.0-rc2+ #406
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
Call Trace:
 dump_stack_lvl+0x57/0x72
 check_noncircular+0xcf/0xf0
 ? stack_trace_save+0x3b/0x50
 __lock_acquire+0x10ea/0x1d90
 lock_acquire+0xb5/0x2b0
 ? flush_workqueue+0x67/0x5e0
 ? lockdep_init_map_type+0x47/0x220
 flush_workqueue+0x91/0x5e0
 ? flush_workqueue+0x67/0x5e0
 ? verify_cpu+0xf0/0x100
 drain_workqueue+0xa0/0x110
 destroy_workqueue+0x36/0x250
 __loop_clr_fd+0x9a/0x660 [loop]
 ? blkdev_ioctl+0x8d/0x2a0
 block_ioctl+0x3f/0x50
 __x64_sys_ioctl+0x80/0xb0
 do_syscall_64+0x38/0x90
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/volumes.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 7d5875824be7..22a8a5a0959b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1925,15 +1925,17 @@ static int btrfs_add_dev_item(struct btrfs_trans_handle *trans,
  * Function to update ctime/mtime for a given device path.
  * Mainly used for ctime/mtime based probe like libblkid.
  */
-static void update_dev_time(const char *path_name)
+static void update_dev_time(struct block_device *bdev)
 {
-	struct file *filp;
+	struct inode *inode = bdev->bd_inode;
+	struct timespec64 now;
 
-	filp = filp_open(path_name, O_RDWR, 0);
-	if (IS_ERR(filp))
+	/* Shouldn't happen but just in case. */
+	if (!inode)
 		return;
-	file_update_time(filp);
-	filp_close(filp, NULL);
+
+	now = current_time(inode);
+	generic_update_time(inode, &now, S_MTIME | S_CTIME);
 }
 
 static int btrfs_rm_dev_item(struct btrfs_device *device)
@@ -2113,7 +2115,7 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
 	btrfs_kobject_uevent(bdev, KOBJ_CHANGE);
 
 	/* Update ctime/mtime for device path for libblkid */
-	update_dev_time(device_path);
+	update_dev_time(bdev);
 }
 
 int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
@@ -2766,7 +2768,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	btrfs_forget_devices(device_path);
 
 	/* Update ctime/mtime for blkid or udev */
-	update_dev_time(device_path);
+	update_dev_time(bdev);
 
 	return ret;
 
-- 
2.30.2

