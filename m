Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B610F3D8067
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 23:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbhG0VDw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 17:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbhG0VDp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 17:03:45 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717E3C08EAE4
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 14:01:26 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id w10so10606047qtj.3
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 14:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Iwz24A9y6D9IPXgx/O1O3x9zzBC08PIX9v/36E/kZms=;
        b=zznqIxl5RPtUtz/zjuSCjbv/ZUcj1zViNhEVq42rDOipmv8sEv3IbCUJwhnW4DJoyL
         XvSWBAQommQSCKALyN0TBFdDp43M7fswc84FSuY8SZsTk/lSN08jRPP9voNuikWWz2G1
         dd4uszTFuFKgk1cHCjUDbS6fvnzljwGCefn4a/xVKdtjEGliRz581HX67RmP3vJPS053
         vU3n+EhQMWa8O2F9oT+y0M6tXAdhs89tTBUyMfJQ9tDs3xGJoZDBf3dLKfO9n/2Gz9Cc
         clQ5mRGk5l+7LWGYVNa0uwfJfiSMtK/pnJo5zKXrKWLffgA8xdMafQ4VxGu//0cTrtWY
         ncGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Iwz24A9y6D9IPXgx/O1O3x9zzBC08PIX9v/36E/kZms=;
        b=goQTWyps7fo7gpaw3GxL+AGpBgqFVe5BVYMRX2Ote9T9GRSiNBo9svmzBMphrghBN7
         ixaxHlPiWtgqwNdeBb4cN7GXBM54q9+N+mieKDG565C6mEkkSzXnjy6j7WTNKZauKRBK
         VNM9nkZ5kWkVVtjnFkGrEvw5pUIjoVV4HazFc11MMDPtTO0e58g6UyN0SxAM8HXSsC2d
         1LWS385Td0VgGSaMC0PkzzUn08iV4RRFXafNVDwEKpohszcBm8kwPop8lkTE9Fv2WHbf
         58jkgi81DXOWGKgpPHlFJ/x4SxFt1HvSulDvQ+Lfcxdvv2Exdccx/XM0PzuN8CnrnQ1C
         nBhQ==
X-Gm-Message-State: AOAM533HMne7DjhcafeZygn0X8kXMy93KpknUgVag9gNK7PXNcVGGVmx
        GEzBCr2gqaUf9DNrGtQQ1S1Jz5MhwHk+CQO7
X-Google-Smtp-Source: ABdhPJy2FmkpOQGukt8QBJ78yvXveL7whFlSRBl/g5KuYRRivQdl/orGbRPzsSkkjtBww8PvEvQPVA==
X-Received: by 2002:ac8:7f93:: with SMTP id z19mr21143445qtj.328.1627419685157;
        Tue, 27 Jul 2021 14:01:25 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d192sm2296667qkc.51.2021.07.27.14.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:01:24 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 3/7] btrfs: do not read super look for a device path
Date:   Tue, 27 Jul 2021 17:01:15 -0400
Message-Id: <26639cd9f337a84b432b6627cd7c17b3d6d51e34.1627419595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1627419595.git.josef@toxicpanda.com>
References: <cover.1627419595.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For device removal and replace we call btrfs_find_device_by_devspec,
which if we give it a device path and nothing else will call
btrfs_find_device_by_path, which opens the block device and reads the
super block and then looks up our device based on that.

However this is completely unnecessary because we have the path stored
in our device on our fsdevices.  All we need to do if we're given a path
is look through the fs_devices on our file system and use that device if
we find it, reading the super block is just silly.

This fixes the case where we end up with our sb write "lock" getting the
dependency of the block device ->open_mutex, which resulted in the
following lockdep splat

======================================================
WARNING: possible circular locking dependency detected
5.14.0-rc2+ #405 Not tainted
------------------------------------------------------
losetup/11576 is trying to acquire lock:
ffff9bbe8cded938 ((wq_completion)loop0){+.+.}-{0:0}, at: flush_workqueue+0x67/0x5e0

but task is already holding lock:
ffff9bbe88e4fc68 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x41/0x660 [loop]

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
       blkdev_get_by_path+0x98/0xa0
       btrfs_get_bdev_and_sb+0x1b/0xb0
       btrfs_find_device_by_devspec+0x12b/0x1c0
       btrfs_rm_device+0x127/0x610
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

1 lock held by losetup/11576:
 #0: ffff9bbe88e4fc68 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x41/0x660 [loop]

stack backtrace:
CPU: 0 PID: 11576 Comm: losetup Not tainted 5.14.0-rc2+ #405
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
RIP: 0033:0x7f31b02404cb

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 61 +++++++++++++++++-----------------------------
 1 file changed, 23 insertions(+), 38 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 0e7372f637eb..bf2449cdb2ab 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2313,37 +2313,22 @@ void btrfs_destroy_dev_replace_tgtdev(struct btrfs_device *tgtdev)
 	btrfs_free_device(tgtdev);
 }
 
-static struct btrfs_device *btrfs_find_device_by_path(
-		struct btrfs_fs_info *fs_info, const char *device_path)
+static struct btrfs_device *find_device_by_path(
+					struct btrfs_fs_devices *fs_devices,
+					const char *path)
 {
-	int ret = 0;
-	struct btrfs_super_block *disk_super;
-	u64 devid;
-	u8 *dev_uuid;
-	struct block_device *bdev;
 	struct btrfs_device *device;
+	bool missing = !strcmp(path, "missing");
 
-	ret = btrfs_get_bdev_and_sb(device_path, FMODE_READ,
-				    fs_info->bdev_holder, 0, &bdev, &disk_super);
-	if (ret)
-		return ERR_PTR(ret);
-
-	devid = btrfs_stack_device_id(&disk_super->dev_item);
-	dev_uuid = disk_super->dev_item.uuid;
-	if (btrfs_fs_incompat(fs_info, METADATA_UUID))
-		device = btrfs_find_device(fs_info->fs_devices, devid, dev_uuid,
-					   disk_super->metadata_uuid);
-	else
-		device = btrfs_find_device(fs_info->fs_devices, devid, dev_uuid,
-					   disk_super->fsid);
-
-	btrfs_release_disk_super(disk_super);
-	if (!device)
-		device = ERR_PTR(-ENOENT);
-	blkdev_put(bdev, FMODE_READ);
-	return device;
+	list_for_each_entry(device, &fs_devices->devices, dev_list) {
+		if (missing && test_bit(BTRFS_DEV_STATE_IN_FS_METADATA,
+					&device->dev_state) && !device->bdev)
+			return device;
+		if (!missing && device_path_matched(path, device))
+			return device;
+	}
+	return NULL;
 }
-
 /*
  * Lookup a device given by device id, or the path if the id is 0.
  */
@@ -2351,6 +2336,7 @@ struct btrfs_device *btrfs_find_device_by_devspec(
 		struct btrfs_fs_info *fs_info, u64 devid,
 		const char *device_path)
 {
+	struct btrfs_fs_devices *seed_devs;
 	struct btrfs_device *device;
 
 	if (devid) {
@@ -2364,18 +2350,17 @@ struct btrfs_device *btrfs_find_device_by_devspec(
 	if (!device_path || !device_path[0])
 		return ERR_PTR(-EINVAL);
 
-	if (strcmp(device_path, "missing") == 0) {
-		/* Find first missing device */
-		list_for_each_entry(device, &fs_info->fs_devices->devices,
-				    dev_list) {
-			if (test_bit(BTRFS_DEV_STATE_IN_FS_METADATA,
-				     &device->dev_state) && !device->bdev)
-				return device;
-		}
-		return ERR_PTR(-ENOENT);
-	}
+	device = find_device_by_path(fs_info->fs_devices, device_path);
+	if (device)
+		return device;
 
-	return btrfs_find_device_by_path(fs_info, device_path);
+	list_for_each_entry(seed_devs, &fs_info->fs_devices->seed_list,
+			    seed_list) {
+		device = find_device_by_path(seed_devs, device_path);
+		if (device)
+			return device;
+	}
+	return ERR_PTR(-ENOENT);
 }
 
 /*
-- 
2.26.3

