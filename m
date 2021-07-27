Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51463D7EAA
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 21:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbhG0Tr4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 15:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbhG0Trz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 15:47:55 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FA4C061757
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 12:47:55 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id s14so321055qvm.4
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 12:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2kubtjNM3KzLdLgSZBUH7ufu+3tYX8uKBc9UmWhB2ik=;
        b=XsaotHYk6BVwBG1WpKGiFXyy/Ad0iw2RNQQmqXqE+TepMUGpQYCYkq/JUjjipm1ebH
         H32RZSiCsc1YHqzaQ0gyUg88zGMCPOQZ4xwgD+PtlHVCc1evknIlqt+oZ+nCcpazyUXU
         pqZmWM1M+bkBjXtcAaSuN2RTd7gwY92bYdhTi4QJF/0Rt8kOFKTjHnuTiyrgzycvToV6
         ueO73+dcDqkx+iQTVz1cPGqqpQYX8V1pvuZlQZBHvWCZ7XCPzxpO+fd6GgVJX0VNX6d4
         gWYAeSoI7/2sOlwK7JwIJw/VS3/XpZB4E0LSwlLvX+ajsZ8MJCGJIS+bNcfVvNojsl/9
         d7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2kubtjNM3KzLdLgSZBUH7ufu+3tYX8uKBc9UmWhB2ik=;
        b=O9ASkvBH9Zkvk7L9UBQChc/Fyf+ca5MYQ7OQqqiVtGnbvBg7Q40H6mTGCFIMVnWDo9
         nYKNspDhPlF/kKmD6y6L1xQw4Z4YPc9T6JF2DmP5YktB7yBGvHXMUkWuDgxF/L/MoADn
         44vqECpldDfmfTKtt/hNoM6GbHQ9/MTFJIZOGOBIbx/gIvwOhWKFnH6q+3yP2We1XgIu
         cfXSj229kRmpv8J2lol/xKse0l4I8LVxPSXGWdaTYLKNPlADsR34dODMTJUdSPmgZMQD
         Ayqmj8kcjRlKaPAN0YXnDohbW53pXq/rSh1tFnU29IYkyKhVun1gJzcUH/+QrlQG0NhD
         9zzQ==
X-Gm-Message-State: AOAM533mC56aYCb3ea7zo3aEDbtBrmAj8l23ueCgOi2oR7TkQ0WMrPy1
        JNEKrO9d0zYmmLnJOR5tEwM5TVcDVUbErS2R
X-Google-Smtp-Source: ABdhPJx3bZiaVVrjnHoFE3ccrf01zloB13ZW3UGZW+6nQxTWB34QBCDuTuDXgrlFiY8FVqLy0ThU3Q==
X-Received: by 2002:a05:6214:10c8:: with SMTP id r8mr24621935qvs.28.1627415273971;
        Tue, 27 Jul 2021 12:47:53 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 67sm2180067qkm.134.2021.07.27.12.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 12:47:53 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/6] btrfs: do not take the uuid_mutex in btrfs_rm_device
Date:   Tue, 27 Jul 2021 15:47:44 -0400
Message-Id: <bb8ebd37d7ca60bc78fab5368274c99a03004fe5.1627414703.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1627414703.git.josef@toxicpanda.com>
References: <cover.1627414703.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We got the following lockdep splat while running xfstests (specifically
btrfs/003 and btrfs/020 in a row) with the new rc.  This was uncovered
by 87579e9b7d8d ("loop: use worker per cgroup instead of kworker") which
converted loop to using workqueues, which comes with lockdep
annotations that don't exist with kworkers.  The lockdep splat is as
follows

======================================================
WARNING: possible circular locking dependency detected
5.14.0-rc2-custom+ #34 Not tainted
------------------------------------------------------
losetup/156417 is trying to acquire lock:
ffff9c7645b02d38 ((wq_completion)loop0){+.+.}-{0:0}, at: flush_workqueue+0x84/0x600

but task is already holding lock:
ffff9c7647395468 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x41/0x650 [loop]

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #5 (&lo->lo_mutex){+.+.}-{3:3}:
       __mutex_lock+0xba/0x7c0
       lo_open+0x28/0x60 [loop]
       blkdev_get_whole+0x28/0xf0
       blkdev_get_by_dev.part.0+0x168/0x3c0
       blkdev_open+0xd2/0xe0
       do_dentry_open+0x163/0x3a0
       path_openat+0x74d/0xa40
       do_filp_open+0x9c/0x140
       do_sys_openat2+0xb1/0x170
       __x64_sys_openat+0x54/0x90
       do_syscall_64+0x3b/0x90
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #4 (&disk->open_mutex){+.+.}-{3:3}:
       __mutex_lock+0xba/0x7c0
       blkdev_get_by_dev.part.0+0xd1/0x3c0
       blkdev_get_by_path+0xc0/0xd0
       btrfs_scan_one_device+0x52/0x1f0 [btrfs]
       btrfs_control_ioctl+0xac/0x170 [btrfs]
       __x64_sys_ioctl+0x83/0xb0
       do_syscall_64+0x3b/0x90
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #3 (uuid_mutex){+.+.}-{3:3}:
       __mutex_lock+0xba/0x7c0
       btrfs_rm_device+0x48/0x6a0 [btrfs]
       btrfs_ioctl+0x2d1c/0x3110 [btrfs]
       __x64_sys_ioctl+0x83/0xb0
       do_syscall_64+0x3b/0x90
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #2 (sb_writers#11){.+.+}-{0:0}:
       lo_write_bvec+0x112/0x290 [loop]
       loop_process_work+0x25f/0xcb0 [loop]
       process_one_work+0x28f/0x5d0
       worker_thread+0x55/0x3c0
       kthread+0x140/0x170
       ret_from_fork+0x22/0x30

-> #1 ((work_completion)(&lo->rootcg_work)){+.+.}-{0:0}:
       process_one_work+0x266/0x5d0
       worker_thread+0x55/0x3c0
       kthread+0x140/0x170
       ret_from_fork+0x22/0x30

-> #0 ((wq_completion)loop0){+.+.}-{0:0}:
       __lock_acquire+0x1130/0x1dc0
       lock_acquire+0xf5/0x320
       flush_workqueue+0xae/0x600
       drain_workqueue+0xa0/0x110
       destroy_workqueue+0x36/0x250
       __loop_clr_fd+0x9a/0x650 [loop]
       lo_ioctl+0x29d/0x780 [loop]
       block_ioctl+0x3f/0x50
       __x64_sys_ioctl+0x83/0xb0
       do_syscall_64+0x3b/0x90
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
1 lock held by losetup/156417:
 #0: ffff9c7647395468 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x41/0x650 [loop]

stack backtrace:
CPU: 8 PID: 156417 Comm: losetup Not tainted 5.14.0-rc2-custom+ #34
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
Call Trace:
 dump_stack_lvl+0x57/0x72
 check_noncircular+0x10a/0x120
 __lock_acquire+0x1130/0x1dc0
 lock_acquire+0xf5/0x320
 ? flush_workqueue+0x84/0x600
 flush_workqueue+0xae/0x600
 ? flush_workqueue+0x84/0x600
 drain_workqueue+0xa0/0x110
 destroy_workqueue+0x36/0x250
 __loop_clr_fd+0x9a/0x650 [loop]
 lo_ioctl+0x29d/0x780 [loop]
 ? __lock_acquire+0x3a0/0x1dc0
 ? update_dl_rq_load_avg+0x152/0x360
 ? lock_is_held_type+0xa5/0x120
 ? find_held_lock.constprop.0+0x2b/0x80
 block_ioctl+0x3f/0x50
 __x64_sys_ioctl+0x83/0xb0
 do_syscall_64+0x3b/0x90
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f645884de6b

Usually the uuid_mutex exists to protect the fs_devices that map
together all of the devices that match a specific uuid.  In rm_device
we're messing with the uuid of a device, so it makes sense to protect
that here.

However in doing that it pulls in a whole host of lockdep dependencies,
as we call mnt_may_write() on the sb before we grab the uuid_mutex, thus
we end up with the dependency chain under the uuid_mutex being added
under the normal sb write dependency chain, which causes problems with
loop devices.

We don't need the uuid mutex here however.  If we call
btrfs_scan_one_device() before we scratch the super block we will find
the fs_devices and not find the device itself and return EBUSY because
the fs_devices is open.  If we call it after the scratch happens it will
not appear to be a valid btrfs file system.

We do not need to worry about other fs_devices modifying operations here
because we're protected by the exclusive operations locking.

So drop the uuid_mutex here in order to fix the lockdep splat.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 373be4e54f28..62cb7d39435c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2082,8 +2082,6 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
 	u64 num_devices;
 	int ret = 0;
 
-	mutex_lock(&uuid_mutex);
-
 	num_devices = btrfs_num_devices(fs_info);
 
 	ret = btrfs_check_raid_min_devices(fs_info, num_devices - 1);
@@ -2127,11 +2125,9 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
 		mutex_unlock(&fs_info->chunk_mutex);
 	}
 
-	mutex_unlock(&uuid_mutex);
 	ret = btrfs_shrink_device(device, 0);
 	if (!ret)
 		btrfs_reada_remove_dev(device);
-	mutex_lock(&uuid_mutex);
 	if (ret)
 		goto error_undo;
 
@@ -2200,7 +2196,6 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
 	synchronize_rcu();
 	btrfs_free_device(device);
 out:
-	mutex_unlock(&uuid_mutex);
 	return ret;
 
 error_undo:
-- 
2.26.3

