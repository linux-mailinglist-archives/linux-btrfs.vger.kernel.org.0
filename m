Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99776240A9F
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Aug 2020 17:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgHJPmz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Aug 2020 11:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgHJPmx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Aug 2020 11:42:53 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33ADC061756
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 08:42:53 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id x69so8756499qkb.1
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 08:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VkdOMbTiqpLWHmTFgXc+wmvEXcUOIj2zQSHJd/KI+TU=;
        b=CbQQW/BTJ04n6gOKJendWp8GzHeoSQ6z6W0z4rRuJC1Jv4IykTF86TpIg7L3TFpAan
         XLmcpJm8f4I2l/efQnR+gWTJAih+6QFEJLYez8Yw8MMsHrRdrA/SFh7PyAX/FFZ3L6Y/
         hVQT9lIox0C+DKYsC886+UJvHxn2STuiuIZXZwzJ1eGyWsMPrEaypKMm3Rt+8n7seQb5
         nNeaCdNqIVztO2Mw+wgQutJCNycCsm6Y3MtLJFDKoKCTYnd11+Gets0g/nLFoNpGvnP+
         TYqm5WSmwHT6wpwCY+EO0AGE7+tQCmPlQrTVPifjlIA8Q787A43YxOyHZVVm6yAvf4+2
         rXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VkdOMbTiqpLWHmTFgXc+wmvEXcUOIj2zQSHJd/KI+TU=;
        b=nZTbwtcT40EiuSCrr+MuZ1VZ8aQ5HCDDRcAKQjjyOtgBOuVnScFNrwJtGpk81DkxYX
         6hglXkYqt2Akqw+OG+6WAZdvRdKcCES+QHpMdc0Hx87/uEFdyJVHXzeW8ixNpkRB34rN
         udJc6RxLybNFSi0XJ0mnZZTfnAIVRmpMqOFLtorgAlviYVh+0Ib+mU4TVTbDzbZYOiHF
         8GA8NSlmYKxL5VAAZb4gxr1L+Cg+FoMSxUfsDyhQIJcaC1qUpFbvkYv19ltyXeU6Ytfh
         e3H8a/83j19lwBc1w9a49BucoI7GrHHv/G/LJuhEvsbgtE3b9tep4+6+j3O1o5K+lNZZ
         zNnA==
X-Gm-Message-State: AOAM531+D3SzopUJbf5DFQOXbB1soGQhfUJhbIIehXVu8N2lmQb7quP9
        QcIA6GHOEPNm04FJVSi/Ry+f5PDJWopBvg==
X-Google-Smtp-Source: ABdhPJzY06rTU0w2Y4vgzoP5r6aI4oIlyw865/X81+7bgaw3n+Qm5SWTdqLqLKBlX1+18mxqJI9Fbg==
X-Received: by 2002:a37:709:: with SMTP id 9mr25315248qkh.261.1597074171052;
        Mon, 10 Aug 2020 08:42:51 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j190sm13922862qkd.22.2020.08.10.08.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 08:42:50 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 03/17] btrfs: do not hold device_list_mutex when closing devices
Date:   Mon, 10 Aug 2020 11:42:28 -0400
Message-Id: <20200810154242.782802-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200810154242.782802-1-josef@toxicpanda.com>
References: <20200810154242.782802-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The following lockdep splat

======================================================
WARNING: possible circular locking dependency detected
5.8.0-rc7-00169-g87212851a027-dirty #929 Not tainted
------------------------------------------------------
fsstress/8739 is trying to acquire lock:
ffff88bfd0eb0c90 (&fs_info->reloc_mutex){+.+.}-{3:3}, at: btrfs_record_root_in_trans+0x43/0x70

but task is already holding lock:
ffff88bfbd16e538 (sb_pagefaults){.+.+}-{0:0}, at: btrfs_page_mkwrite+0x6a/0x4a0

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #10 (sb_pagefaults){.+.+}-{0:0}:
       __sb_start_write+0x129/0x210
       btrfs_page_mkwrite+0x6a/0x4a0
       do_page_mkwrite+0x4d/0xc0
       handle_mm_fault+0x103c/0x1730
       exc_page_fault+0x340/0x660
       asm_exc_page_fault+0x1e/0x30

-> #9 (&mm->mmap_lock#2){++++}-{3:3}:
       __might_fault+0x68/0x90
       _copy_to_user+0x1e/0x80
       perf_read+0x141/0x2c0
       vfs_read+0xad/0x1b0
       ksys_read+0x5f/0xe0
       do_syscall_64+0x50/0x90
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #8 (&cpuctx_mutex){+.+.}-{3:3}:
       __mutex_lock+0x9f/0x930
       perf_event_init_cpu+0x88/0x150
       perf_event_init+0x1db/0x20b
       start_kernel+0x3ae/0x53c
       secondary_startup_64+0xa4/0xb0

-> #7 (pmus_lock){+.+.}-{3:3}:
       __mutex_lock+0x9f/0x930
       perf_event_init_cpu+0x4f/0x150
       cpuhp_invoke_callback+0xb1/0x900
       _cpu_up.constprop.26+0x9f/0x130
       cpu_up+0x7b/0xc0
       bringup_nonboot_cpus+0x4f/0x60
       smp_init+0x26/0x71
       kernel_init_freeable+0x110/0x258
       kernel_init+0xa/0x103
       ret_from_fork+0x1f/0x30

-> #6 (cpu_hotplug_lock){++++}-{0:0}:
       cpus_read_lock+0x39/0xb0
       kmem_cache_create_usercopy+0x28/0x230
       kmem_cache_create+0x12/0x20
       bioset_init+0x15e/0x2b0
       init_bio+0xa3/0xaa
       do_one_initcall+0x5a/0x2e0
       kernel_init_freeable+0x1f4/0x258
       kernel_init+0xa/0x103
       ret_from_fork+0x1f/0x30

-> #5 (bio_slab_lock){+.+.}-{3:3}:
       __mutex_lock+0x9f/0x930
       bioset_init+0xbc/0x2b0
       __blk_alloc_queue+0x6f/0x2d0
       blk_mq_init_queue_data+0x1b/0x70
       loop_add+0x110/0x290 [loop]
       fq_codel_tcf_block+0x12/0x20 [sch_fq_codel]
       do_one_initcall+0x5a/0x2e0
       do_init_module+0x5a/0x220
       load_module+0x2459/0x26e0
       __do_sys_finit_module+0xba/0xe0
       do_syscall_64+0x50/0x90
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #4 (loop_ctl_mutex){+.+.}-{3:3}:
       __mutex_lock+0x9f/0x930
       lo_open+0x18/0x50 [loop]
       __blkdev_get+0xec/0x570
       blkdev_get+0xe8/0x150
       do_dentry_open+0x167/0x410
       path_openat+0x7c9/0xa80
       do_filp_open+0x93/0x100
       do_sys_openat2+0x22a/0x2e0
       do_sys_open+0x4b/0x80
       do_syscall_64+0x50/0x90
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #3 (&bdev->bd_mutex){+.+.}-{3:3}:
       __mutex_lock+0x9f/0x930
       blkdev_put+0x1d/0x120
       close_fs_devices.part.31+0x84/0x130
       btrfs_close_devices+0x44/0xb0
       close_ctree+0x296/0x2b2
       generic_shutdown_super+0x69/0x100
       kill_anon_super+0xe/0x30
       btrfs_kill_super+0x12/0x20
       deactivate_locked_super+0x29/0x60
       cleanup_mnt+0xb8/0x140
       task_work_run+0x6d/0xb0
       __prepare_exit_to_usermode+0x1cc/0x1e0
       do_syscall_64+0x5c/0x90
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #2 (&fs_devs->device_list_mutex){+.+.}-{3:3}:
       __mutex_lock+0x9f/0x930
       btrfs_run_dev_stats+0x49/0x480
       commit_cowonly_roots+0xb5/0x2a0
       btrfs_commit_transaction+0x516/0xa60
       sync_filesystem+0x6b/0x90
       generic_shutdown_super+0x22/0x100
       kill_anon_super+0xe/0x30
       btrfs_kill_super+0x12/0x20
       deactivate_locked_super+0x29/0x60
       cleanup_mnt+0xb8/0x140
       task_work_run+0x6d/0xb0
       __prepare_exit_to_usermode+0x1cc/0x1e0
       do_syscall_64+0x5c/0x90
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #1 (&fs_info->tree_log_mutex){+.+.}-{3:3}:
       __mutex_lock+0x9f/0x930
       btrfs_commit_transaction+0x4bb/0xa60
       sync_filesystem+0x6b/0x90
       generic_shutdown_super+0x22/0x100
       kill_anon_super+0xe/0x30
       btrfs_kill_super+0x12/0x20
       deactivate_locked_super+0x29/0x60
       cleanup_mnt+0xb8/0x140
       task_work_run+0x6d/0xb0
       __prepare_exit_to_usermode+0x1cc/0x1e0
       do_syscall_64+0x5c/0x90
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #0 (&fs_info->reloc_mutex){+.+.}-{3:3}:
       __lock_acquire+0x1272/0x2310
       lock_acquire+0x9e/0x360
       __mutex_lock+0x9f/0x930
       btrfs_record_root_in_trans+0x43/0x70
       start_transaction+0xd1/0x5d0
       btrfs_dirty_inode+0x42/0xd0
       file_update_time+0xc8/0x110
       btrfs_page_mkwrite+0x10c/0x4a0
       do_page_mkwrite+0x4d/0xc0
       handle_mm_fault+0x103c/0x1730
       exc_page_fault+0x340/0x660
       asm_exc_page_fault+0x1e/0x30

other info that might help us debug this:

Chain exists of:
  &fs_info->reloc_mutex --> &mm->mmap_lock#2 --> sb_pagefaults

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sb_pagefaults);
                               lock(&mm->mmap_lock#2);
                               lock(sb_pagefaults);
  lock(&fs_info->reloc_mutex);

 *** DEADLOCK ***

3 locks held by fsstress/8739:
 #0: ffff88bee66eeb68 (&mm->mmap_lock#2){++++}-{3:3}, at: exc_page_fault+0x173/0x660
 #1: ffff88bfbd16e538 (sb_pagefaults){.+.+}-{0:0}, at: btrfs_page_mkwrite+0x6a/0x4a0
 #2: ffff88bfbd16e630 (sb_internal){.+.+}-{0:0}, at: start_transaction+0x3da/0x5d0

stack backtrace:
CPU: 17 PID: 8739 Comm: fsstress Kdump: loaded Not tainted 5.8.0-rc7-00169-g87212851a027-dirty #929
Hardware name: Quanta Tioga Pass Single Side 01-0030993006/Tioga Pass Single Side, BIOS F08_3A18 12/20/2018
Call Trace:
 dump_stack+0x78/0xa0
 check_noncircular+0x165/0x180
 __lock_acquire+0x1272/0x2310
 ? btrfs_get_alloc_profile+0x150/0x210
 lock_acquire+0x9e/0x360
 ? btrfs_record_root_in_trans+0x43/0x70
 __mutex_lock+0x9f/0x930
 ? btrfs_record_root_in_trans+0x43/0x70
 ? lock_acquire+0x9e/0x360
 ? join_transaction+0x5d/0x450
 ? find_held_lock+0x2d/0x90
 ? btrfs_record_root_in_trans+0x43/0x70
 ? join_transaction+0x3d5/0x450
 ? btrfs_record_root_in_trans+0x43/0x70
 btrfs_record_root_in_trans+0x43/0x70
 start_transaction+0xd1/0x5d0
 btrfs_dirty_inode+0x42/0xd0
 file_update_time+0xc8/0x110
 btrfs_page_mkwrite+0x10c/0x4a0
 ? handle_mm_fault+0x5e/0x1730
 do_page_mkwrite+0x4d/0xc0
 ? __do_fault+0x32/0x150
 handle_mm_fault+0x103c/0x1730
 exc_page_fault+0x340/0x660
 ? asm_exc_page_fault+0x8/0x30
 asm_exc_page_fault+0x1e/0x30
RIP: 0033:0x7faa6c9969c4

Was seen in testing.  The fix is similar to that of

  btrfs: open device without device_list_mutex

where we're holding the device_list_mutex and then grab the bd_mutex,
which pulls in a bunch of dependencies under the bd_mutex.  We only ever
call btrfs_close_devices() on mount failure or unmount, so we're save to
not have the device_list_mutex here.  We're already holding the
uuid_mutex which keeps us safe from any external modification of the
fs_devices.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 3ac44dad58bb..97ec9c0a91aa 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1155,11 +1155,8 @@ static int close_fs_devices(struct btrfs_fs_devices *fs_devices)
 	if (--fs_devices->opened > 0)
 		return 0;
 
-	mutex_lock(&fs_devices->device_list_mutex);
-	list_for_each_entry_safe(device, tmp, &fs_devices->devices, dev_list) {
+	list_for_each_entry_safe(device, tmp, &fs_devices->devices, dev_list)
 		btrfs_close_one_device(device);
-	}
-	mutex_unlock(&fs_devices->device_list_mutex);
 
 	WARN_ON(fs_devices->open_devices);
 	WARN_ON(fs_devices->rw_devices);
-- 
2.24.1

