Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892C83D7EAC
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 21:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbhG0TsA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 15:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbhG0Tr7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 15:47:59 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F72C061757
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 12:47:58 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id h10so10421265qth.5
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 12:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vYlZ9Nyi9u5aLhFPlnOyom5/00pjCJ2mGWMWTqbq988=;
        b=TBCbCKr87I9Z2pWqE/s/tXLUviaQg6Qy9Rp95sXC9yjOEEwVI+bZseduJstWa+gibD
         Z27NhEVtKoP5JdBj+4KHc6xaNXVjfnEcBSCqYGOUStrJOyhtHHg+O2TxMPJVMSG+lvvq
         O5AqNiw6OUytjc+quTakejGHfEAfsqCH7MmoR/uCJRY9uyyhO50zcZIO4aurLQeSTCdA
         yOo4zHAiPO/vULg7iH6RWsQWbqX+SaSt60yrGW6ZUYcmEYRvYh0pOvDQoSNTwfHBfkwU
         0yEjsDErTK6LBS9uPt/UBqHTD5KYlM+kKr3MwI0Poq23iIHg9BHMLVib9qhlBvaiAckc
         v6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vYlZ9Nyi9u5aLhFPlnOyom5/00pjCJ2mGWMWTqbq988=;
        b=qii9mmSZZwknPPbqej5QcBtB2bJYZ9pxj8xn1sQHcYRuIoLKsVVmbCXf96SpEJnYby
         qkZttqn5BaI3EZ52nO4vzkDH5S9AgLbWNW04/rAOUAuAKWUeYvx7yjQosqeto/wkkNnP
         RQn9i9luVnxw7Spj0nlL2SRp8jG1AHP4HGWGLj395FuA0YYUTobBwUUzIy0P+OXjLyFv
         8QBTkeRmTEc+dJpseowUx5DWcdvtt2re32HdILgLId5iLMX+LxbuuVRtJC177TXtcUAr
         h1eZ71dTD1BT5fYcx4gWh0D0SImiAJk/Isi+1G2Ot9E8wgnY53ghnEmM4hUM4W7vGM00
         YWoQ==
X-Gm-Message-State: AOAM530CBwhKf2F/yfRD6sNTJmaMNxr/arjubKd0CB0q6pDOSZ0ldopQ
        KTByiZiCo2PiqLgFyFcrqFo6Qb/Eau7CicMf
X-Google-Smtp-Source: ABdhPJzuGqXTO4A8+rxsblwWkNmruR/bPPQvxOK5HKOvnlFhFfxogAc0cDxvoKFSIXhNvZElXOI+WQ==
X-Received: by 2002:ac8:5254:: with SMTP id y20mr20310203qtn.279.1627415277292;
        Tue, 27 Jul 2021 12:47:57 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y10sm297366qta.16.2021.07.27.12.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 12:47:56 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/6] btrfs: update the bdev time directly when closing
Date:   Tue, 27 Jul 2021 15:47:46 -0400
Message-Id: <64b928956d1d9c8165842988a17105d0970fd2e8.1627414703.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1627414703.git.josef@toxicpanda.com>
References: <cover.1627414703.git.josef@toxicpanda.com>
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
index cf4b9978963e..27df367db7d8 100644
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
@@ -2696,7 +2698,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	btrfs_forget_devices(device_path);
 
 	/* Update ctime/mtime for blkid or udev */
-	update_dev_time(device_path);
+	update_dev_time(bdev);
 
 	return ret;
 
-- 
2.26.3

