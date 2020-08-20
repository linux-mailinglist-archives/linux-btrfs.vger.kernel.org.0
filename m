Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2C124C201
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Aug 2020 17:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbgHTPTT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Aug 2020 11:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbgHTPSt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Aug 2020 11:18:49 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6B5C061343
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 08:18:48 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id p25so1837522qkp.2
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 08:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0ZjOivmnyPj7JVaRx7Cqa+bdFnRbdKg6ZwaaWhyiSw0=;
        b=Fxdbp4goxzSGE2wFtYHWLzaAdJU/NMCv5ndzTL5so9EfEwlx5RLM/l/YU6lFDDGI1w
         AyRey5Akfp7pPTeyh5E9kqKIIIGho2EPIFRo4oKN1F/9aUlp+VGdrngj2l1EC5jJ/2Sv
         xmdYKo18E9Q7tapoSNYzeT1zPgbbclRDIyJcidHydLExeDR3OKV6+U8L0yGKD99gExjF
         D6SgIS2e+pKJQUBPFrIw2gJR3x1qHxTPjX8er4YCdQNQpynwVW0gcs9MdB2ZsAk6kE+8
         jr4EpZGKpCqZF/ZSlpsT5g57lIoVfBbIB263Bw82caBkF2nEb1LYdw4H53rK9Opc0cgl
         sPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0ZjOivmnyPj7JVaRx7Cqa+bdFnRbdKg6ZwaaWhyiSw0=;
        b=QsMCRke6lszDtDEPnN6nM7S7J9toqUOSgnOc6vrdK5p+WJ4I61fMswgQEHbCZhTHgJ
         +0Jycgd6xutMlownPQTX83ezejrgF7azwkTxmi1Q8VklVEdyRqGV9v5QBmf6b228ZG7i
         dHEp94QvwRzrsnvuxMuRLbQt7Gr2b36aAHFSnG0Cevc60YkF5n3vNoNblbT7cM7TbXwx
         FMm2RTMt0bVaB26XOYBy6DFIl3d4ZB/3w+B4Z1ZZX++LbRdXWlc6aE5gCOROLItKdLPm
         b1h0/Bc953RrYSdiiWEr7IIxrFx8Nb02OsnxKsIJEjYANUGuUvZA3gDy+M3yifDaROGf
         9Fvg==
X-Gm-Message-State: AOAM532a1KSSxtKbK0HkuH8uTbsBggG9NVxUpRue0DwlBxAwMW5Zm1zm
        jjucUrgFcaQg7zu9aqS7BAK9+/ZL7de3JwbK
X-Google-Smtp-Source: ABdhPJyOmsBkE2Tp/fzF82UyZ/5Naqu4O866vVAqefz5VD3IUuLwgYVsEP7RZypugXTcdJtFrE83oA==
X-Received: by 2002:a37:8203:: with SMTP id e3mr3046168qkd.437.1597936726276;
        Thu, 20 Aug 2020 08:18:46 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x12sm3557627qta.67.2020.08.20.08.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 08:18:45 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 6/8] btrfs: allocate scrub workqueues outside of locks
Date:   Thu, 20 Aug 2020 11:18:29 -0400
Message-Id: <0322006cb85bb7fd03e94c5458a3c2b2b41e4d14.1597936173.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1597936173.git.josef@toxicpanda.com>
References: <cover.1597936173.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I got the following lockdep splat while testing

======================================================
WARNING: possible circular locking dependency detected
5.8.0-rc7-00172-g021118712e59 #932 Not tainted
------------------------------------------------------
btrfs/229626 is trying to acquire lock:
ffffffff828513f0 (cpu_hotplug_lock){++++}-{0:0}, at: alloc_workqueue+0x378/0x450

but task is already holding lock:
ffff889dd3889518 (&fs_info->scrub_lock){+.+.}-{3:3}, at: btrfs_scrub_dev+0x11c/0x630

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #7 (&fs_info->scrub_lock){+.+.}-{3:3}:
       __mutex_lock+0x9f/0x930
       btrfs_scrub_dev+0x11c/0x630
       btrfs_dev_replace_by_ioctl.cold.21+0x10a/0x1d4
       btrfs_ioctl+0x2799/0x30a0
       ksys_ioctl+0x83/0xc0
       __x64_sys_ioctl+0x16/0x20
       do_syscall_64+0x50/0x90
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #6 (&fs_devs->device_list_mutex){+.+.}-{3:3}:
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

-> #5 (&fs_info->tree_log_mutex){+.+.}-{3:3}:
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

-> #4 (&fs_info->reloc_mutex){+.+.}-{3:3}:
       __mutex_lock+0x9f/0x930
       btrfs_record_root_in_trans+0x43/0x70
       start_transaction+0xd1/0x5d0
       btrfs_dirty_inode+0x42/0xd0
       touch_atime+0xa1/0xd0
       btrfs_file_mmap+0x3f/0x60
       mmap_region+0x3a4/0x640
       do_mmap+0x376/0x580
       vm_mmap_pgoff+0xd5/0x120
       ksys_mmap_pgoff+0x193/0x230
       do_syscall_64+0x50/0x90
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #3 (&mm->mmap_lock#2){++++}-{3:3}:
       __might_fault+0x68/0x90
       _copy_to_user+0x1e/0x80
       perf_read+0x141/0x2c0
       vfs_read+0xad/0x1b0
       ksys_read+0x5f/0xe0
       do_syscall_64+0x50/0x90
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #2 (&cpuctx_mutex){+.+.}-{3:3}:
       __mutex_lock+0x9f/0x930
       perf_event_init_cpu+0x88/0x150
       perf_event_init+0x1db/0x20b
       start_kernel+0x3ae/0x53c
       secondary_startup_64+0xa4/0xb0

-> #1 (pmus_lock){+.+.}-{3:3}:
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

-> #0 (cpu_hotplug_lock){++++}-{0:0}:
       __lock_acquire+0x1272/0x2310
       lock_acquire+0x9e/0x360
       cpus_read_lock+0x39/0xb0
       alloc_workqueue+0x378/0x450
       __btrfs_alloc_workqueue+0x15d/0x200
       btrfs_alloc_workqueue+0x51/0x160
       scrub_workers_get+0x5a/0x170
       btrfs_scrub_dev+0x18c/0x630
       btrfs_dev_replace_by_ioctl.cold.21+0x10a/0x1d4
       btrfs_ioctl+0x2799/0x30a0
       ksys_ioctl+0x83/0xc0
       __x64_sys_ioctl+0x16/0x20
       do_syscall_64+0x50/0x90
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

other info that might help us debug this:

Chain exists of:
  cpu_hotplug_lock --> &fs_devs->device_list_mutex --> &fs_info->scrub_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&fs_info->scrub_lock);
                               lock(&fs_devs->device_list_mutex);
                               lock(&fs_info->scrub_lock);
  lock(cpu_hotplug_lock);

 *** DEADLOCK ***

2 locks held by btrfs/229626:
 #0: ffff88bfe8bb86e0 (&fs_devs->device_list_mutex){+.+.}-{3:3}, at: btrfs_scrub_dev+0xbd/0x630
 #1: ffff889dd3889518 (&fs_info->scrub_lock){+.+.}-{3:3}, at: btrfs_scrub_dev+0x11c/0x630

stack backtrace:
CPU: 15 PID: 229626 Comm: btrfs Kdump: loaded Not tainted 5.8.0-rc7-00172-g021118712e59 #932
Hardware name: Quanta Tioga Pass Single Side 01-0030993006/Tioga Pass Single Side, BIOS F08_3A18 12/20/2018
Call Trace:
 dump_stack+0x78/0xa0
 check_noncircular+0x165/0x180
 __lock_acquire+0x1272/0x2310
 lock_acquire+0x9e/0x360
 ? alloc_workqueue+0x378/0x450
 cpus_read_lock+0x39/0xb0
 ? alloc_workqueue+0x378/0x450
 alloc_workqueue+0x378/0x450
 ? rcu_read_lock_sched_held+0x52/0x80
 __btrfs_alloc_workqueue+0x15d/0x200
 btrfs_alloc_workqueue+0x51/0x160
 scrub_workers_get+0x5a/0x170
 btrfs_scrub_dev+0x18c/0x630
 ? start_transaction+0xd1/0x5d0
 btrfs_dev_replace_by_ioctl.cold.21+0x10a/0x1d4
 btrfs_ioctl+0x2799/0x30a0
 ? do_sigaction+0x102/0x250
 ? lockdep_hardirqs_on_prepare+0xca/0x160
 ? _raw_spin_unlock_irq+0x24/0x30
 ? trace_hardirqs_on+0x1c/0xe0
 ? _raw_spin_unlock_irq+0x24/0x30
 ? do_sigaction+0x102/0x250
 ? ksys_ioctl+0x83/0xc0
 ksys_ioctl+0x83/0xc0
 __x64_sys_ioctl+0x16/0x20
 do_syscall_64+0x50/0x90
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

This happens because we're allocating the scrub workqueues under the
scrub and device list mutex, which brings in a whole host of other
dependencies.  Fix this by moving the actual allocation outside of the
scrub lock, and then only take the lock once we're ready to actually
assign them to the fs_info.  We'll now have to cleanup the workqueues in
a few more places, so I've added a helper to do the refcount dance to
safely free the workqueues.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/scrub.c | 122 +++++++++++++++++++++++++++--------------------
 1 file changed, 70 insertions(+), 52 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 5a6cb9db512e..7f7098e3110e 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3716,50 +3716,84 @@ static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
 	return 0;
 }
 
+static void scrub_workers_put(struct btrfs_fs_info *fs_info)
+{
+	if (refcount_dec_and_mutex_lock(&fs_info->scrub_workers_refcnt,
+					&fs_info->scrub_lock)) {
+		struct btrfs_workqueue *scrub_workers = NULL;
+		struct btrfs_workqueue *scrub_wr_comp = NULL;
+		struct btrfs_workqueue *scrub_parity = NULL;
+
+		scrub_workers = fs_info->scrub_workers;
+		scrub_wr_comp = fs_info->scrub_wr_completion_workers;
+		scrub_parity = fs_info->scrub_parity_workers;
+
+		fs_info->scrub_workers = NULL;
+		fs_info->scrub_wr_completion_workers = NULL;
+		fs_info->scrub_parity_workers = NULL;
+		mutex_unlock(&fs_info->scrub_lock);
+
+		btrfs_destroy_workqueue(scrub_workers);
+		btrfs_destroy_workqueue(scrub_wr_comp);
+		btrfs_destroy_workqueue(scrub_parity);
+	}
+}
+
 /*
  * get a reference count on fs_info->scrub_workers. start worker if necessary
  */
 static noinline_for_stack int scrub_workers_get(struct btrfs_fs_info *fs_info,
 						int is_dev_replace)
 {
+	struct btrfs_workqueue *scrub_workers = NULL;
+	struct btrfs_workqueue *scrub_wr_comp = NULL;
+	struct btrfs_workqueue *scrub_parity = NULL;
 	unsigned int flags = WQ_FREEZABLE | WQ_UNBOUND;
 	int max_active = fs_info->thread_pool_size;
+	int ret = -ENOMEM;
 
-	lockdep_assert_held(&fs_info->scrub_lock);
+	if (refcount_inc_not_zero(&fs_info->scrub_workers_refcnt))
+		return 0;
 
-	if (refcount_read(&fs_info->scrub_workers_refcnt) == 0) {
-		ASSERT(fs_info->scrub_workers == NULL);
-		fs_info->scrub_workers = btrfs_alloc_workqueue(fs_info, "scrub",
-				flags, is_dev_replace ? 1 : max_active, 4);
-		if (!fs_info->scrub_workers)
-			goto fail_scrub_workers;
-
-		ASSERT(fs_info->scrub_wr_completion_workers == NULL);
-		fs_info->scrub_wr_completion_workers =
-			btrfs_alloc_workqueue(fs_info, "scrubwrc", flags,
-					      max_active, 2);
-		if (!fs_info->scrub_wr_completion_workers)
-			goto fail_scrub_wr_completion_workers;
+	scrub_workers = btrfs_alloc_workqueue(fs_info, "scrub", flags,
+					      is_dev_replace ? 1 : max_active,
+					      4);
+	if (!scrub_workers)
+		goto fail_scrub_workers;
 
-		ASSERT(fs_info->scrub_parity_workers == NULL);
-		fs_info->scrub_parity_workers =
-			btrfs_alloc_workqueue(fs_info, "scrubparity", flags,
+	scrub_wr_comp = btrfs_alloc_workqueue(fs_info, "scrubwrc", flags,
 					      max_active, 2);
-		if (!fs_info->scrub_parity_workers)
-			goto fail_scrub_parity_workers;
+	if (!scrub_wr_comp)
+		goto fail_scrub_wr_completion_workers;
 
+	scrub_parity = btrfs_alloc_workqueue(fs_info, "scrubparity", flags,
+					     max_active, 2);
+	if (!scrub_parity)
+		goto fail_scrub_parity_workers;
+
+	mutex_lock(&fs_info->scrub_lock);
+	if (refcount_read(&fs_info->scrub_workers_refcnt) == 0) {
+		ASSERT(fs_info->scrub_workers == NULL &&
+		       fs_info->scrub_wr_completion_workers == NULL &&
+		       fs_info->scrub_parity_workers == NULL);
+		fs_info->scrub_workers = scrub_workers;
+		fs_info->scrub_wr_completion_workers = scrub_wr_comp;
+		fs_info->scrub_parity_workers = scrub_parity;
 		refcount_set(&fs_info->scrub_workers_refcnt, 1);
-	} else {
-		refcount_inc(&fs_info->scrub_workers_refcnt);
+		mutex_unlock(&fs_info->scrub_lock);
+		return 0;
 	}
-	return 0;
+	refcount_inc(&fs_info->scrub_workers_refcnt);
+	mutex_unlock(&fs_info->scrub_lock);
 
+	ret = 0;
+	btrfs_destroy_workqueue(scrub_parity);
 fail_scrub_parity_workers:
-	btrfs_destroy_workqueue(fs_info->scrub_wr_completion_workers);
+	btrfs_destroy_workqueue(scrub_wr_comp);
 fail_scrub_wr_completion_workers:
-	btrfs_destroy_workqueue(fs_info->scrub_workers);
+	btrfs_destroy_workqueue(scrub_workers);
 fail_scrub_workers:
-	return -ENOMEM;
+	return ret;
 }
 
 int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
@@ -3770,9 +3804,6 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 	int ret;
 	struct btrfs_device *dev;
 	unsigned int nofs_flag;
-	struct btrfs_workqueue *scrub_workers = NULL;
-	struct btrfs_workqueue *scrub_wr_comp = NULL;
-	struct btrfs_workqueue *scrub_parity = NULL;
 
 	if (btrfs_fs_closing(fs_info))
 		return -EAGAIN;
@@ -3819,13 +3850,17 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 	if (IS_ERR(sctx))
 		return PTR_ERR(sctx);
 
+	ret = scrub_workers_get(fs_info, is_dev_replace);
+	if (ret)
+		goto out_free_ctx;
+
 	mutex_lock(&fs_info->fs_devices->device_list_mutex);
 	dev = btrfs_find_device(fs_info->fs_devices, devid, NULL, NULL, true);
 	if (!dev || (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state) &&
 		     !is_dev_replace)) {
 		mutex_unlock(&fs_info->fs_devices->device_list_mutex);
 		ret = -ENODEV;
-		goto out_free_ctx;
+		goto out;
 	}
 
 	if (!is_dev_replace && !readonly &&
@@ -3834,7 +3869,7 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 		btrfs_err_in_rcu(fs_info, "scrub: device %s is not writable",
 				rcu_str_deref(dev->name));
 		ret = -EROFS;
-		goto out_free_ctx;
+		goto out;
 	}
 
 	mutex_lock(&fs_info->scrub_lock);
@@ -3843,7 +3878,7 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 		mutex_unlock(&fs_info->scrub_lock);
 		mutex_unlock(&fs_info->fs_devices->device_list_mutex);
 		ret = -EIO;
-		goto out_free_ctx;
+		goto out;
 	}
 
 	down_read(&fs_info->dev_replace.rwsem);
@@ -3854,17 +3889,10 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 		mutex_unlock(&fs_info->scrub_lock);
 		mutex_unlock(&fs_info->fs_devices->device_list_mutex);
 		ret = -EINPROGRESS;
-		goto out_free_ctx;
+		goto out;
 	}
 	up_read(&fs_info->dev_replace.rwsem);
 
-	ret = scrub_workers_get(fs_info, is_dev_replace);
-	if (ret) {
-		mutex_unlock(&fs_info->scrub_lock);
-		mutex_unlock(&fs_info->fs_devices->device_list_mutex);
-		goto out_free_ctx;
-	}
-
 	sctx->readonly = readonly;
 	dev->scrub_ctx = sctx;
 	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
@@ -3917,24 +3945,14 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 
 	mutex_lock(&fs_info->scrub_lock);
 	dev->scrub_ctx = NULL;
-	if (refcount_dec_and_test(&fs_info->scrub_workers_refcnt)) {
-		scrub_workers = fs_info->scrub_workers;
-		scrub_wr_comp = fs_info->scrub_wr_completion_workers;
-		scrub_parity = fs_info->scrub_parity_workers;
-
-		fs_info->scrub_workers = NULL;
-		fs_info->scrub_wr_completion_workers = NULL;
-		fs_info->scrub_parity_workers = NULL;
-	}
 	mutex_unlock(&fs_info->scrub_lock);
 
-	btrfs_destroy_workqueue(scrub_workers);
-	btrfs_destroy_workqueue(scrub_wr_comp);
-	btrfs_destroy_workqueue(scrub_parity);
+	scrub_workers_put(fs_info);
 	scrub_put_ctx(sctx);
 
 	return ret;
-
+out:
+	scrub_workers_put(fs_info);
 out_free_ctx:
 	scrub_free_ctx(sctx);
 
-- 
2.24.1

