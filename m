Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFE3423165
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Oct 2021 22:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbhJEUOt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Oct 2021 16:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhJEUOs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Oct 2021 16:14:48 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D7CC061749
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Oct 2021 13:12:57 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id b16so314316qtt.7
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Oct 2021 13:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W0dvs6KcXnhnRn+ERR+ELmawu7u/7AIDV83w04SQT1g=;
        b=EgRKQS91Iros/P1ReCgBjPc7xMAddDZ6VbCVdx40pNow/iE2RUhORu/W0Amg413PlH
         As6xnCcvtzuyS0smrkApr+9qe/6xxfqyl9tbtO0y2gYtEgKl6uTKH5LSBlUbOtSyfUxS
         MIV91hMfA4GKYiDmKPJ+nP+/LcLpQZFsDIo3axuo6LCOBnnwkkpIMBlJlkQNxOgJE+xL
         u++827d9jIgkegEKXAmqSKdckVAW4btmDga723tOxVuhroUnZtgU8wkiHXGF/VBPPFQO
         afmItK8FCCcEyO6niar1kja5jwhXzjBXdeaMG7ognC99SXhQYEQsNfuqqGPIuzCnQ0Vm
         VS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W0dvs6KcXnhnRn+ERR+ELmawu7u/7AIDV83w04SQT1g=;
        b=yDAJ8Ed3b8Xcg2Po02Fe3EzZ7IC8CqrkOTgdO9yD/erjrCfWZ0NJZFZB7Qs6+oWI7j
         kLAGjrCJsQGH9O9qLlFeNH822dUCjjNyPhL9SfLuyZDLa96P1r3OUuP/0gIpbuK8TLPb
         yLlGD8I55QiXME0/hK/9x6OGW0mDgKBtG+6DLa2K67XW3mNRYslkYk++kQ0icndEEvtu
         oDYHh6DqYlF/6MyIIcVGMi+m6aukWb61zj6rT4eBenRXbQLuJgI6rGV1GOKUnmt74Nh9
         3hRKYFRjIJikkabwxDhC/PjAuEg2csJcdn77MHpFR0U3WIBVOXAU7EEJmvYQtdpkjGbp
         te0g==
X-Gm-Message-State: AOAM532hNHGcJXjN9pfWc2Vpn3lgK4FRbcjBdeQV3FmIbyqFkEevVs3X
        BnVjlh8C9lUzh0m6SpZsYc0UN6Ux3o5gHw==
X-Google-Smtp-Source: ABdhPJwnXGLUo4v8XKaApbUKq7ct2g1C99ft4Xqq2KlOLV+NIDgSfr+Lu3rs7SYUKiIC0tFfeun8Xg==
X-Received: by 2002:ac8:1306:: with SMTP id e6mr3602133qtj.179.1633464776467;
        Tue, 05 Oct 2021 13:12:56 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s185sm10025936qke.93.2021.10.05.13.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 13:12:56 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v4 6/6] btrfs: use btrfs_get_dev_args_from_path in dev removal ioctls
Date:   Tue,  5 Oct 2021 16:12:44 -0400
Message-Id: <78f4669e469232db2d8675fd7b4fd06028f2eef5.1633464631.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1633464631.git.josef@toxicpanda.com>
References: <cover.1633464631.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For device removal and replace we call btrfs_find_device_by_devspec,
which if we give it a device path and nothing else will call
btrfs_get_dev_args_from_path, which opens the block device and reads the
super block and then looks up our device based on that.

However at this point we're holding the sb write "lock", so reading the
block device pulls in the dependency of ->open_mutex, which produces the
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

Instead what we want to do is populate our device lookup args before we
grab any locks, and then pass these args into btrfs_rm_device().  From
there we can find the device and do the appropriate removal.

Suggested-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c   | 67 +++++++++++++++++++++++++++-------------------
 fs/btrfs/volumes.c | 15 +++++------
 fs/btrfs/volumes.h |  2 +-
 3 files changed, 48 insertions(+), 36 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index b8508af4e539..c9d3f375df83 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3160,6 +3160,7 @@ static long btrfs_ioctl_add_dev(struct btrfs_fs_info *fs_info, void __user *arg)
 
 static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
 {
+	BTRFS_DEV_LOOKUP_ARGS(args);
 	struct inode *inode = file_inode(file);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_ioctl_vol_args_v2 *vol_args;
@@ -3171,35 +3172,39 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	ret = mnt_want_write_file(file);
-	if (ret)
-		return ret;
-
 	vol_args = memdup_user(arg, sizeof(*vol_args));
 	if (IS_ERR(vol_args)) {
 		ret = PTR_ERR(vol_args);
-		goto err_drop;
+		goto out;
 	}
 
 	if (vol_args->flags & ~BTRFS_DEVICE_REMOVE_ARGS_MASK) {
 		ret = -EOPNOTSUPP;
 		goto out;
 	}
+
 	vol_args->name[BTRFS_SUBVOL_NAME_MAX] = '\0';
-	if (!(vol_args->flags & BTRFS_DEVICE_SPEC_BY_ID) &&
-	    strcmp("cancel", vol_args->name) == 0)
+	if (vol_args->flags & BTRFS_DEVICE_SPEC_BY_ID) {
+		args.devid = vol_args->devid;
+	} else if (!strcmp("cancel", vol_args->name)) {
 		cancel = true;
+	} else {
+		ret = btrfs_get_dev_args_from_path(fs_info, &args, vol_args->name);
+		if (ret)
+			goto out;
+	}
+
+	ret = mnt_want_write_file(file);
+	if (ret)
+		goto out;
 
 	ret = exclop_start_or_cancel_reloc(fs_info, BTRFS_EXCLOP_DEV_REMOVE,
 					   cancel);
 	if (ret)
-		goto out;
-	/* Exclusive operation is now claimed */
+		goto err_drop;
 
-	if (vol_args->flags & BTRFS_DEVICE_SPEC_BY_ID)
-		ret = btrfs_rm_device(fs_info, NULL, vol_args->devid, &bdev, &mode);
-	else
-		ret = btrfs_rm_device(fs_info, vol_args->name, 0, &bdev, &mode);
+	/* Exclusive operation is now claimed */
+	ret = btrfs_rm_device(fs_info, &args, &bdev, &mode);
 
 	btrfs_exclop_finish(fs_info);
 
@@ -3211,17 +3216,19 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
 			btrfs_info(fs_info, "device deleted: %s",
 					vol_args->name);
 	}
-out:
-	kfree(vol_args);
 err_drop:
 	mnt_drop_write_file(file);
 	if (bdev)
 		blkdev_put(bdev, mode);
+out:
+	btrfs_put_dev_args_from_path(&args);
+	kfree(vol_args);
 	return ret;
 }
 
 static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
 {
+	BTRFS_DEV_LOOKUP_ARGS(args);
 	struct inode *inode = file_inode(file);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_ioctl_vol_args *vol_args;
@@ -3233,32 +3240,38 @@ static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	ret = mnt_want_write_file(file);
-	if (ret)
-		return ret;
-
 	vol_args = memdup_user(arg, sizeof(*vol_args));
-	if (IS_ERR(vol_args)) {
-		ret = PTR_ERR(vol_args);
-		goto out_drop_write;
-	}
+	if (IS_ERR(vol_args))
+		return PTR_ERR(vol_args);
+
 	vol_args->name[BTRFS_PATH_NAME_MAX] = '\0';
-	cancel = (strcmp("cancel", vol_args->name) == 0);
+	if (!strcmp("cancel", vol_args->name)) {
+		cancel = true;
+	} else {
+		ret = btrfs_get_dev_args_from_path(fs_info, &args, vol_args->name);
+		if (ret)
+			goto out;
+	}
+
+	ret = mnt_want_write_file(file);
+	if (ret)
+		goto out;
 
 	ret = exclop_start_or_cancel_reloc(fs_info, BTRFS_EXCLOP_DEV_REMOVE,
 					   cancel);
 	if (ret == 0) {
-		ret = btrfs_rm_device(fs_info, vol_args->name, 0, &bdev, &mode);
+		ret = btrfs_rm_device(fs_info, &args, &bdev, &mode);
 		if (!ret)
 			btrfs_info(fs_info, "disk deleted %s", vol_args->name);
 		btrfs_exclop_finish(fs_info);
 	}
 
-	kfree(vol_args);
-out_drop_write:
 	mnt_drop_write_file(file);
 	if (bdev)
 		blkdev_put(bdev, mode);
+out:
+	btrfs_put_dev_args_from_path(&args);
+	kfree(vol_args);
 	return ret;
 }
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index e490414e8987..3262e75fbb1c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2076,8 +2076,9 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
 	update_dev_time(bdev);
 }
 
-int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
-		    u64 devid, struct block_device **bdev, fmode_t *mode)
+int btrfs_rm_device(struct btrfs_fs_info *fs_info,
+		    struct btrfs_dev_lookup_args *args,
+		    struct block_device **bdev, fmode_t *mode)
 {
 	struct btrfs_device *device;
 	struct btrfs_fs_devices *cur_devices;
@@ -2096,14 +2097,12 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
 	if (ret)
 		goto out;
 
-	device = btrfs_find_device_by_devspec(fs_info, devid, device_path);
-
-	if (IS_ERR(device)) {
-		if (PTR_ERR(device) == -ENOENT &&
-		    device_path && strcmp(device_path, "missing") == 0)
+	device = btrfs_find_device(fs_info->fs_devices, args);
+	if (!device) {
+		if (args->missing)
 			ret = BTRFS_ERROR_DEV_MISSING_NOT_FOUND;
 		else
-			ret = PTR_ERR(device);
+			ret = -ENOENT;
 		goto out;
 	}
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 3fe5ac683f98..223c390ec057 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -527,7 +527,7 @@ struct btrfs_device *btrfs_alloc_device(struct btrfs_fs_info *fs_info,
 void btrfs_put_dev_args_from_path(struct btrfs_dev_lookup_args *args);
 void btrfs_free_device(struct btrfs_device *device);
 int btrfs_rm_device(struct btrfs_fs_info *fs_info,
-		    const char *device_path, u64 devid,
+		    struct btrfs_dev_lookup_args *args,
 		    struct block_device **bdev, fmode_t *mode);
 void __exit btrfs_cleanup_fs_uuids(void);
 int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len);
-- 
2.26.3

