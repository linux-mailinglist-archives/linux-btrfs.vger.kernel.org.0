Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C233D7EAD
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 21:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbhG0TsB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 15:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbhG0TsB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 15:48:01 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A1FC061757
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 12:48:00 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id g6so306580qvj.8
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 12:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4KyVTRd7qEyv6D5nTjVW/0zDvrm1Q09bquFiGsy/K5U=;
        b=v05xH5JGvICW1p+eN5KZ78F5crAbjGCGYvbKNQwxPYqBf8X2WzIoPlPWuSg2O8+gbB
         t+781i4RHT+UDar/lCa8D85icDFvizflVA56vUxjAWSAsuRBmmGj/3yDaqwAsa20VoJR
         Wbj2RZU5IzFzEY8/wYZG4ZEiYfkmFKp9Vn4jVWelTnmZrRhjPZZV+rPk90AW3DSmE8eV
         8lXymvUwUAJ9I1EHTMUNFogyNrhNBLHVFpQcfOZcaZol0ALYD+uOLAem+b+v4GblpWrx
         /LjBkSyYp/RyG1qDhhbQEG8ccpuVfdudwPklA57Yw/j3o2gRUHbQp6dgIFTfhMv6ehc6
         hcUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4KyVTRd7qEyv6D5nTjVW/0zDvrm1Q09bquFiGsy/K5U=;
        b=YcpLTCiEAitujrau6VRAwE6O85nskRX9Xi+bJDeoILXgMomOLX51OwaiZgeyfZWT5/
         ejDoGu6la6wo41AHpVJvXzpDpxgqdhG7O4TVgiIyx8TzQMDHS/Br3cZGyKePHY1OHxzN
         gE2wrsLlljP+dw0X4qD9JMf+Xd4U6ouGi0BgNXb9mJ5cSoelmWny7mtSUECFdWIOUm9S
         1BbMdtN9wwXEGDnQOLhyoGSen0duhuuSXI2J8xCPjmLCEu+7Vo1gpR17cVcFwQLaHcdN
         rTQ28N3aLTMUl1pW1Anfu7CD72Z6VRoVO0cOsETM9iGHRdAnQh5W149Tfl9afrJAVTap
         au5Q==
X-Gm-Message-State: AOAM532BfqWlMSSdUDCkx+xpsP/fqQQAQUeQ+nirNsGhBulOTz31LXLx
        GYsC3yfXKRvgOUyM3u4kGWS6bZUL3PA4s39p
X-Google-Smtp-Source: ABdhPJzAHtseBwOREyyxeWs6FqQXatea6jFapi7OMFJehX+G7QwPYhFuwITG6ja+coJi1E7IGR/Zeg==
X-Received: by 2002:ad4:5c49:: with SMTP id a9mr23966142qva.27.1627415278926;
        Tue, 27 Jul 2021 12:47:58 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o1sm1737392qta.87.2021.07.27.12.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 12:47:58 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/6] btrfs: delay blkdev_put until after the device remove
Date:   Tue, 27 Jul 2021 15:47:47 -0400
Message-Id: <f9de39651916feb6923c2ff71e6619089365185f.1627414703.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1627414703.git.josef@toxicpanda.com>
References: <cover.1627414703.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When removing the device we call blkdev_put() on the device once we've
removed it, and because we have an EXCL open we need to take the
->open_mutex on the block device to clean it up.  Unfortunately during
device remove we are holding the sb writers lock, which results in the
following lockdep splat

======================================================
WARNING: possible circular locking dependency detected
5.14.0-rc2+ #407 Not tainted
------------------------------------------------------
losetup/11595 is trying to acquire lock:
ffff973ac35dd138 ((wq_completion)loop0){+.+.}-{0:0}, at: flush_workqueue+0x67/0x5e0

but task is already holding lock:
ffff973ac9812c68 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x41/0x660 [loop]

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
       blkdev_put+0x3a/0x220
       btrfs_rm_device.cold+0x62/0xe5
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

1 lock held by losetup/11595:
 #0: ffff973ac9812c68 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x41/0x660 [loop]

stack backtrace:
CPU: 0 PID: 11595 Comm: losetup Not tainted 5.14.0-rc2+ #407
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
RIP: 0033:0x7fc21255d4cb

So instead save the bdev and do the put once we've dropped the sb
writers lock in order to avoid the lockdep recursion.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c   | 17 ++++++++++++++---
 fs/btrfs/volumes.c | 19 +++++++++++++++----
 fs/btrfs/volumes.h |  3 ++-
 3 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 0ba98e08a029..fabbfdfa56f5 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3205,6 +3205,8 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
 	struct inode *inode = file_inode(file);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_ioctl_vol_args_v2 *vol_args;
+	struct block_device *bdev = NULL;
+	fmode_t mode;
 	int ret;
 	bool cancel = false;
 
@@ -3237,9 +3239,11 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
 	/* Exclusive operation is now claimed */
 
 	if (vol_args->flags & BTRFS_DEVICE_SPEC_BY_ID)
-		ret = btrfs_rm_device(fs_info, NULL, vol_args->devid);
+		ret = btrfs_rm_device(fs_info, NULL, vol_args->devid, &bdev,
+				      &mode);
 	else
-		ret = btrfs_rm_device(fs_info, vol_args->name, 0);
+		ret = btrfs_rm_device(fs_info, vol_args->name, 0, &bdev,
+				      &mode);
 
 	btrfs_exclop_finish(fs_info);
 
@@ -3255,6 +3259,8 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
 	kfree(vol_args);
 err_drop:
 	mnt_drop_write_file(file);
+	if (bdev)
+		blkdev_put(bdev, mode);
 	return ret;
 }
 
@@ -3263,6 +3269,8 @@ static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
 	struct inode *inode = file_inode(file);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_ioctl_vol_args *vol_args;
+	struct block_device *bdev = NULL;
+	fmode_t mode;
 	int ret;
 	bool cancel;
 
@@ -3284,7 +3292,8 @@ static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
 	ret = exclop_start_or_cancel_reloc(fs_info, BTRFS_EXCLOP_DEV_REMOVE,
 					   cancel);
 	if (ret == 0) {
-		ret = btrfs_rm_device(fs_info, vol_args->name, 0);
+		ret = btrfs_rm_device(fs_info, vol_args->name, 0, &bdev,
+				      &mode);
 		if (!ret)
 			btrfs_info(fs_info, "disk deleted %s", vol_args->name);
 		btrfs_exclop_finish(fs_info);
@@ -3294,6 +3303,8 @@ static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
 out_drop_write:
 	mnt_drop_write_file(file);
 
+	if (bdev)
+		blkdev_put(bdev, mode);
 	return ret;
 }
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 27df367db7d8..1162e5c5b917 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2076,7 +2076,7 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
 }
 
 int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
-		    u64 devid)
+		    u64 devid, struct block_device **bdev, fmode_t *mode)
 {
 	struct btrfs_device *device;
 	struct btrfs_fs_devices *cur_devices;
@@ -2186,15 +2186,26 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
 	mutex_unlock(&fs_devices->device_list_mutex);
 
 	/*
-	 * at this point, the device is zero sized and detached from
+	 * At this point, the device is zero sized and detached from
 	 * the devices list.  All that's left is to zero out the old
 	 * supers and free the device.
+	 *
+	 * We cannot call btrfs_close_bdev() here because we're holding the sb
+	 * write lock, and blkdev_put() will pull in the ->open_mutex on the
+	 * block device and it's dependencies.  Instead just flush the device
+	 * and let the caller do the final blkdev_put.
 	 */
-	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state))
+	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
 		btrfs_scratch_superblocks(fs_info, device->bdev,
 					  device->name->str);
+		if (device->bdev) {
+			sync_blockdev(device->bdev);
+			invalidate_bdev(device->bdev);
+		}
+	}
 
-	btrfs_close_bdev(device);
+	*bdev = device->bdev;
+	*mode = device->mode;
 	synchronize_rcu();
 	btrfs_free_device(device);
 out:
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 70c749eee3ad..cc70e54cb901 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -472,7 +472,8 @@ struct btrfs_device *btrfs_alloc_device(struct btrfs_fs_info *fs_info,
 					const u8 *uuid);
 void btrfs_free_device(struct btrfs_device *device);
 int btrfs_rm_device(struct btrfs_fs_info *fs_info,
-		    const char *device_path, u64 devid);
+		    const char *device_path, u64 devid,
+		    struct block_device **bdev, fmode_t *mode);
 void __exit btrfs_cleanup_fs_uuids(void);
 int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len);
 int btrfs_grow_device(struct btrfs_trans_handle *trans,
-- 
2.26.3

