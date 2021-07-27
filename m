Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E573D8065
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 23:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbhG0VDv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 17:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbhG0VDq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 17:03:46 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD570C08EAEC
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 14:01:27 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id d3so430800qvq.6
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 14:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5rMIw2iXQ+ZslafDm4rxX6vuabpT8K8FLSsrZItpAlo=;
        b=ni2mvTyBjhw50tNkDG1KoQur+Girhf+7kSu+940UGb+qHBJvMeFaM4/yVSfaaGSWUH
         WeYrf71mm50QV9dHuOGq9NGIIBwGljo0HNhMNHvY7uMW4ht//25h2iBzcGmgHqSHco5O
         fUnnFGc09+15N/tlY3gLxQY61dIDphZWULUTEtw4U7LsRBguscZLIeqWbooZ7wpmlqzJ
         sHip0LlzL+AXnxDzOlyrtCacGpibSzunz9sS1IlDGXW5SuCnYVd0EOB0ezFPn10jFONz
         tVk8y/waGoXGkdhzOIIcY274tv9/sYuIE8acftzrtHeI+Gu8gY08Pkvtvre7bDO3fzhB
         c8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5rMIw2iXQ+ZslafDm4rxX6vuabpT8K8FLSsrZItpAlo=;
        b=AFUv2SqpLTZ7iCoeqWfqcZfv7Kvx3LsRLmw1JYW1C2v/4dNtO4eUxLDYoZjGa3D+u8
         LlyHWrA1YZDYFqldwph1OK9L/FFChib6Y4KU/9sIIMcBNctK48ie4TcVg0X90GTv7aPc
         U+SPIZuDB7/M3G3NJ+SJhY2B6Je3tbmW4FG1mQo37Wdodv8YFH5rF5beEhVhfU5vF8Ul
         NEfHrzkEIVi0PiwNSjpcWnHthkcnAzvTbZyVJ+gZI0Ca4/yUUdGuYN1X2x2jV/ce3DTL
         QPvwhTk4l/+gxGm4T2dQc7ql93cFWcxKe5Omld/cVVYnS6Q2866OzaeBxbpOi9hEpvaf
         0jZw==
X-Gm-Message-State: AOAM531BvueusjxmRZ3gnnY1g7vYyUGV3kTFeF43Xi8DtqpuDrcsVUB5
        zZDlNm69IUwKuqAPAdEqK4cj3NaDSnl+32ED
X-Google-Smtp-Source: ABdhPJzRy+V3aKFomsCVdqvTE77EZ+yYbvg3creSjCDsNhaQ/KvCBzTBHOZ77+Qe4CE3+D3pTm4nJg==
X-Received: by 2002:a05:6214:21ec:: with SMTP id p12mr7731958qvj.8.1627419686723;
        Tue, 27 Jul 2021 14:01:26 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l11sm2335077qke.23.2021.07.27.14.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:01:26 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 4/7] btrfs: update the bdev time directly when closing
Date:   Tue, 27 Jul 2021 17:01:16 -0400
Message-Id: <7a02499fac5a53031b333ce58d84089c8ce9e329.1627419595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1627419595.git.josef@toxicpanda.com>
References: <cover.1627419595.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We update the ctime/mtime of a block device when we remove it so that
blkid knows the device changed.  However we do this by re-opening the
block device and calling filp_update_time.  This is more correct because
it'll call the inode->i_op->update_time if it exists, but the block dev
inodes do not do this.  Instead call generic_update_time() on the
bd_inode in order to avoid the blkdev_open path and get rid of the
following lockdep splat

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

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index bf2449cdb2ab..3ab6c78e6eb2 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1882,15 +1882,17 @@ static int btrfs_add_dev_item(struct btrfs_trans_handle *trans,
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
+	generic_update_time(inode, &now, S_MTIME|S_CTIME);
 }
 
 static int btrfs_rm_dev_item(struct btrfs_device *device)
@@ -2070,7 +2072,7 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
 	btrfs_kobject_uevent(bdev, KOBJ_CHANGE);
 
 	/* Update ctime/mtime for device path for libblkid */
-	update_dev_time(device_path);
+	update_dev_time(bdev);
 }
 
 int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
@@ -2711,7 +2713,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	btrfs_forget_devices(device_path);
 
 	/* Update ctime/mtime for blkid or udev */
-	update_dev_time(device_path);
+	update_dev_time(bdev);
 
 	return ret;
 
-- 
2.26.3

