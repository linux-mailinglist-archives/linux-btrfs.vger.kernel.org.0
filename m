Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7362D2281C9
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 16:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbgGUORy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 10:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728850AbgGUORx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 10:17:53 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A26DC061794
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:17:53 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 11so9895163qkn.2
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ia6xcRzQQ8szxspcAt/2GCSS9YWgk3q70ABuQw6Jd2E=;
        b=g3aKedxg0wNYADH5/4nAiK/3t2P60TdQ4PRyH/q6fPXKw+1WDs8Sg46G+rOx9oCqIF
         I6amOtML/CsC/5kM8MC9z3FNnVpNvoO+Zel7PZfqFGm6sNIh/WoECCaqm7xtIVFMi52Y
         gm7XRzUBFrg1GX3Ck8qE0anTbKjGlstyJqDIOe83wqep7kz9C4BWAE555s0myngIjhfR
         rp3Xr0pAr04Z2gnuYECJTbBodvB4QEEzge/iT1cWanQnxUwcQ2LTl+SV3g5PKkUrDDWu
         TQtAr/pxcL7N/Hb5eL/OHRhvZzKmRfOI54tmAxbQNzahEP28BMS2Zc4Xswibqs7KcSwW
         ZJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ia6xcRzQQ8szxspcAt/2GCSS9YWgk3q70ABuQw6Jd2E=;
        b=IEeIioZRb5Rq56GpkQD/WzkO0QjS57P2Ye8xLPGCvK8gQkurc54+OOiAgFkkj6P0oD
         TjksC4JFQYnC0VedRduMOOV9JaNEFVoq5zP+wfiP/5Dc7gu2E1d1qlVVPnPL5B9rHt0n
         mj9/OCYrEeNZKuNjobV5N27UcoeGl0gmCGi9XxwbGZU1EouscDxVqGJG9eyGcO+NhrdR
         xQDdiV6s7BhTmIRg/A1ybv/UmtpBuEVWLj2er3dsaag7cV/GWsX4is5tg4gTnZDgXHxo
         KQCVV4/T7+usrz4erxaboOyGX9YpEapxLdjXnkLWrRkqVEam7VUFf8RHZqp03fA/ZWlr
         taHg==
X-Gm-Message-State: AOAM532t9GFz63K6fSakIGSERmlk0wPvCc4dVl1qEzP/f/WWqfD5G7k0
        20gjAPhEK47nala4bB32VPorI4uW2/IUuQ==
X-Google-Smtp-Source: ABdhPJx/dBRA87B+sLr0XP0ol2FtTlhw9DyBzORSzrXkfhohp+i+eVoSwbP1MG5suh9TiF5fv+nk4A==
X-Received: by 2002:a37:62d4:: with SMTP id w203mr14927762qkb.463.1595341072336;
        Tue, 21 Jul 2020 07:17:52 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w8sm2644284qka.52.2020.07.21.07.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 07:17:51 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: use nofs for device sysfs creation
Date:   Tue, 21 Jul 2020 10:17:50 -0400
Message-Id: <20200721141750.1793-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dave hit this splat during testing btrfs/078

======================================================
WARNING: possible circular locking dependency detected
5.8.0-rc6-default+ #1191 Not tainted
------------------------------------------------------
kswapd0/75 is trying to acquire lock:
ffffa040e9d04ff8 (&delayed_node->mutex){+.+.}-{3:3}, at: __btrfs_release_delayed_node.part.0+0x3f/0x310 [btrfs]

but task is already holding lock:
ffffffff8b0c8040 (fs_reclaim){+.+.}-{0:0}, at: __fs_reclaim_acquire+0x5/0x30

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #2 (fs_reclaim){+.+.}-{0:0}:
       __lock_acquire+0x56f/0xaa0
       lock_acquire+0xa3/0x440
       fs_reclaim_acquire.part.0+0x25/0x30
       __kmalloc_track_caller+0x49/0x330
       kstrdup+0x2e/0x60
       __kernfs_new_node.constprop.0+0x44/0x250
       kernfs_new_node+0x25/0x50
       kernfs_create_link+0x34/0xa0
       sysfs_do_create_link_sd+0x5e/0xd0
       btrfs_sysfs_add_devices_dir+0x65/0x100 [btrfs]
       btrfs_init_new_device+0x44c/0x12b0 [btrfs]
       btrfs_ioctl+0xc3c/0x25c0 [btrfs]
       ksys_ioctl+0x68/0xa0
       __x64_sys_ioctl+0x16/0x20
       do_syscall_64+0x50/0xe0
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #1 (&fs_info->chunk_mutex){+.+.}-{3:3}:
       __lock_acquire+0x56f/0xaa0
       lock_acquire+0xa3/0x440
       __mutex_lock+0xa0/0xaf0
       btrfs_chunk_alloc+0x137/0x3e0 [btrfs]
       find_free_extent+0xb44/0xfb0 [btrfs]
       btrfs_reserve_extent+0x9b/0x180 [btrfs]
       btrfs_alloc_tree_block+0xc1/0x350 [btrfs]
       alloc_tree_block_no_bg_flush+0x4a/0x60 [btrfs]
       __btrfs_cow_block+0x143/0x7a0 [btrfs]
       btrfs_cow_block+0x15f/0x310 [btrfs]
       push_leaf_right+0x150/0x240 [btrfs]
       split_leaf+0x3cd/0x6d0 [btrfs]
       btrfs_search_slot+0xd14/0xf70 [btrfs]
       btrfs_insert_empty_items+0x64/0xc0 [btrfs]
       __btrfs_commit_inode_delayed_items+0xb2/0x840 [btrfs]
       btrfs_async_run_delayed_root+0x10e/0x1d0 [btrfs]
       btrfs_work_helper+0x2f9/0x650 [btrfs]
       process_one_work+0x22c/0x600
       worker_thread+0x50/0x3b0
       kthread+0x137/0x150
       ret_from_fork+0x1f/0x30

-> #0 (&delayed_node->mutex){+.+.}-{3:3}:
       check_prev_add+0x98/0xa20
       validate_chain+0xa8c/0x2a00
       __lock_acquire+0x56f/0xaa0
       lock_acquire+0xa3/0x440
       __mutex_lock+0xa0/0xaf0
       __btrfs_release_delayed_node.part.0+0x3f/0x310 [btrfs]
       btrfs_evict_inode+0x3bf/0x560 [btrfs]
       evict+0xd6/0x1c0
       dispose_list+0x48/0x70
       prune_icache_sb+0x54/0x80
       super_cache_scan+0x121/0x1a0
       do_shrink_slab+0x175/0x420
       shrink_slab+0xb1/0x2e0
       shrink_node+0x192/0x600
       balance_pgdat+0x31f/0x750
       kswapd+0x206/0x510
       kthread+0x137/0x150
       ret_from_fork+0x1f/0x30

other info that might help us debug this:

Chain exists of:
  &delayed_node->mutex --> &fs_info->chunk_mutex --> fs_reclaim

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(&fs_info->chunk_mutex);
                               lock(fs_reclaim);
  lock(&delayed_node->mutex);

 *** DEADLOCK ***

3 locks held by kswapd0/75:
 #0: ffffffff8b0c8040 (fs_reclaim){+.+.}-{0:0}, at: __fs_reclaim_acquire+0x5/0x30
 #1: ffffffff8b0b50b8 (shrinker_rwsem){++++}-{3:3}, at: shrink_slab+0x54/0x2e0
 #2: ffffa040e057c0e8 (&type->s_umount_key#26){++++}-{3:3}, at: trylock_super+0x16/0x50

stack backtrace:
CPU: 2 PID: 75 Comm: kswapd0 Not tainted 5.8.0-rc6-default+ #1191
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
Call Trace:
 dump_stack+0x78/0xa0
 check_noncircular+0x16f/0x190
 check_prev_add+0x98/0xa20
 validate_chain+0xa8c/0x2a00
 __lock_acquire+0x56f/0xaa0
 lock_acquire+0xa3/0x440
 ? __btrfs_release_delayed_node.part.0+0x3f/0x310 [btrfs]
 __mutex_lock+0xa0/0xaf0
 ? __btrfs_release_delayed_node.part.0+0x3f/0x310 [btrfs]
 ? __lock_acquire+0x56f/0xaa0
 ? __btrfs_release_delayed_node.part.0+0x3f/0x310 [btrfs]
 ? lock_acquire+0xa3/0x440
 ? btrfs_evict_inode+0x138/0x560 [btrfs]
 ? btrfs_evict_inode+0x2fe/0x560 [btrfs]
 ? __btrfs_release_delayed_node.part.0+0x3f/0x310 [btrfs]
 __btrfs_release_delayed_node.part.0+0x3f/0x310 [btrfs]
 btrfs_evict_inode+0x3bf/0x560 [btrfs]
 evict+0xd6/0x1c0
 dispose_list+0x48/0x70
 prune_icache_sb+0x54/0x80
 super_cache_scan+0x121/0x1a0
 do_shrink_slab+0x175/0x420
 shrink_slab+0xb1/0x2e0
 shrink_node+0x192/0x600
 balance_pgdat+0x31f/0x750
 kswapd+0x206/0x510
 ? _raw_spin_unlock_irqrestore+0x3e/0x50
 ? finish_wait+0x90/0x90
 ? balance_pgdat+0x750/0x750
 kthread+0x137/0x150
 ? kthread_stop+0x2a0/0x2a0
 ret_from_fork+0x1f/0x30

This is because we're holding the chunk_mutex while adding this device
and adding its sysfs entries.  We actually hold different locks in
different places when calling this function, the dev_replace semaphore
for instance in dev replace, so instead of moving this call around
simply wrap it's operations in nofs.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 38c0b95e0e7f..1e0c215bfbcf 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1278,7 +1278,9 @@ int btrfs_sysfs_add_devices_dir(struct btrfs_fs_devices *fs_devices,
 {
 	int error = 0;
 	struct btrfs_device *dev;
+	unsigned long nofs_flag;
 
+	nofs_flag = memalloc_nofs_save();
 	list_for_each_entry(dev, &fs_devices->devices, dev_list) {
 
 		if (one_device && one_device != dev)
@@ -1306,6 +1308,7 @@ int btrfs_sysfs_add_devices_dir(struct btrfs_fs_devices *fs_devices,
 			break;
 		}
 	}
+	memalloc_nofs_restore(nofs_flag);
 
 	return error;
 }
-- 
2.24.1

