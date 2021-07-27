Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE433D7EAB
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 21:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbhG0Tr6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 15:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbhG0Tr5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 15:47:57 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D133FC061757
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 12:47:56 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id k13so10385729qth.10
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 12:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PISkRJhDqXRBEIihoGP0QIj2y1+9abNv/L/wpdNP5To=;
        b=iEl1WxklDSCXfe/DpV2gRWnVHlcDKvCcE9FesQTpJU9+t6gGh76x7wIwBm8dLHU5n/
         Mu8SNuttl7CojOKlGossISaJGDc/FjzySRhPuoh9pp0baMDJos3G2MM/viYE5HW48u6t
         E44Qs4e5qiHgY/2ai34Oa4jX8Q6lPVIsQ9oxNfUQTvWFVSM7L4IEQ6raXYrh7iZxu8X4
         7PgeAW9LLj6ATUJFdFcdeA5tZD52WT4Hpfn0ILoZ55Yes049b+vIXXa/cBf5TzHjPaGc
         GaCaGLJ8lzZ3KWG4f2huMb/OooQysHnHSEeeejN1EjzgcHTTxiLih1IQiXbcZ0hTipr2
         pA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PISkRJhDqXRBEIihoGP0QIj2y1+9abNv/L/wpdNP5To=;
        b=dm4tQXcAZ3ZmxRpK80LlkOpONgggIkA9MeBR9aek546Ff/81WX3uRjP1KZOncem+4B
         0tq+Yh/hMYify+0wQ9/VnCtpFBuAILnfRR/HYWBJ+vxLJVl9zsEiiDbVQQQV0g292ZSK
         5NpBTTb7dtkpixmcm2q44FOe0CHARPm9oZJMMhtyRzrNG/Cj5ZBkWHXsvl3MQanf0DjT
         4BPSrWXF5izSI5urQfZ7PfMV69h609z7d//0iPITZLLlSxqGKMB8B9EVS23kfm2mWv4y
         3vDwu+z/FVtH8npA6IQ0/O1dzN/HlYJQpxeMciHH8KsT19b7fkkDlicbgWyQPeScse/k
         ZiSg==
X-Gm-Message-State: AOAM530ql6QLhoBj9G2E06Olv1uNP/MD9B5Noo1Z7a5hx1AcAp+meUOf
        hKVgjSlRHw5CHA7s5EraP7+J6pgRCBMD0st5
X-Google-Smtp-Source: ABdhPJybvN6+t//ppFbgbxyGMn7Rku2yas+p/KXt55HU45MizviJx4XdNLZ8YYs7nx3nlm4SBlUKfQ==
X-Received: by 2002:a05:622a:15c1:: with SMTP id d1mr21210289qty.93.1627415275604;
        Tue, 27 Jul 2021 12:47:55 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h8sm1831177qtj.57.2021.07.27.12.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 12:47:55 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/6] btrfs: do not read super look for a device path
Date:   Tue, 27 Jul 2021 15:47:45 -0400
Message-Id: <75797cc0faa8110ac13658a050e6ccc7dce0809b.1627414703.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1627414703.git.josef@toxicpanda.com>
References: <cover.1627414703.git.josef@toxicpanda.com>
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
index 62cb7d39435c..cf4b9978963e 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2298,37 +2298,22 @@ void btrfs_destroy_dev_replace_tgtdev(struct btrfs_device *tgtdev)
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
@@ -2336,6 +2321,7 @@ struct btrfs_device *btrfs_find_device_by_devspec(
 		struct btrfs_fs_info *fs_info, u64 devid,
 		const char *device_path)
 {
+	struct btrfs_fs_devices *seed_devs;
 	struct btrfs_device *device;
 
 	if (devid) {
@@ -2349,18 +2335,17 @@ struct btrfs_device *btrfs_find_device_by_devspec(
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

