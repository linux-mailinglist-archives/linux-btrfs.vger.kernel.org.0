Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B283D8064
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 23:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbhG0VDt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 17:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbhG0VDo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 17:03:44 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C37C08EAD3
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 14:01:24 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d2so10606481qto.6
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 14:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=TSxGs4nd9z8DEFhlm7hGFkjft6ArcCzfy8pJxrgbMTU=;
        b=TvVlgRCARN0WbPa70Sdy6vkV1obVfzrA+U+lWB5R7LKHrTOWeV0XDrg3oO7qL/+2O9
         +ksSpQ+Isu2i7PvzicH2Eq/wyiMni0oIqZCV7E2e8ahnbwTwU/CElg/y2MyzuAacRNXA
         PEiNEUxeLKZK8OnOPRthkRNhmqxmQDpqem3JqPtVmjyXuRWK+qbZ1MuGYqwIOa/AgIDP
         4weyOqYjSdwFPXkiLVpwBe2HDqJLoGWz0IIlQlNHkNMw7GMNdA72E9aLEecxSiOznDat
         dv5EwpxFwTmog6hFT6GhSFXwQvIbPgukfmRjnDJGCKMxgYsga5rBin+gaVPftvM0UPsL
         DzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TSxGs4nd9z8DEFhlm7hGFkjft6ArcCzfy8pJxrgbMTU=;
        b=VM5UAGNdaeFfHxG+AYBqmmmZvOeV+Ha1pLlGCsclDaOV6qg64JLwokqkN2dlzQnuNN
         vzC4dZ+U6Bs/uVxipCGUWeUzZn/tfbugpTiwkXYcw6CRuNBQlFZ9f+5NHuNMeM9yjDha
         ZrL3MVD9wXuxlf1dF1qgYC4eRov3af/0lSe96myb2AqyBhPuzDVJID0kYkpreOPiaObu
         sJ7yBylamlmf3FJkvqb+CM5q8iXm1btbtY9hIzVkng22KoBRYRdPLOoUKoq/HVLwQFgc
         YA+xtyqOUIN/1w/oWWtd729sbkKpt9QVp3n6/Rp2GY6CKfXHT6hfIfFlHoc5r4lKkBKh
         N5PA==
X-Gm-Message-State: AOAM531R1DK80Hz95Ye0dSgi+UOYIToditi6TwdnK1mGzZhRsDzX6E79
        c9Zh9JeCu2YDW7gfKIEgdIolryqhR6PEX8rf
X-Google-Smtp-Source: ABdhPJxqG3wkMBaLznpUh2OqgUMa5EhTPMXNZjhuwSVjEdDgmcIrPvJ0yoGRF5nF1BpBy422a+kVmw==
X-Received: by 2002:ac8:5d07:: with SMTP id f7mr21619120qtx.384.1627419683715;
        Tue, 27 Jul 2021 14:01:23 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g13sm1968359qtj.2.2021.07.27.14.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:01:23 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 2/7] btrfs: do not take the uuid_mutex in btrfs_rm_device
Date:   Tue, 27 Jul 2021 17:01:14 -0400
Message-Id: <4f7529acd33594df9b0b06f7011d8cd4d195fc29.1627419595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1627419595.git.josef@toxicpanda.com>
References: <cover.1627419595.git.josef@toxicpanda.com>
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
index 5217b93172b4..0e7372f637eb 100644
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
 
@@ -2215,7 +2211,6 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
 	}
 
 out:
-	mutex_unlock(&uuid_mutex);
 	return ret;
 
 error_undo:
-- 
2.26.3

