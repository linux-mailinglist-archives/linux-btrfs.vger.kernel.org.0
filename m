Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3124725A0E4
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Sep 2020 23:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbgIAVkv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Sep 2020 17:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729624AbgIAVko (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Sep 2020 17:40:44 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85389C061245
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Sep 2020 14:40:44 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id o64so2468917qkb.10
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Sep 2020 14:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=X3icFpv4MZ7BFuk/N7WqVemM3OsYZe1RmrGTB7OHI0k=;
        b=xLsOUcXhAXuM/ON3H1eaj5+zYdD9dEhpNU9iTmGGKCJ6vjICbzvKGQ0Pbyy0WJhVvN
         PiIMTC/rfolNmnDN+HcSTmFil34f+wuDpbpLWHROs5yljjtg3UoRquD2MgdehNC3gmqv
         VcyB9/PEstLskwJRJcEr/miT+qymiWjorFJ5WEVPhfVxm4I1ElcIaQgLOcDeHD8wg4N3
         JK8cqDQZ4wl1u/X7ety+SiP+0Aeb8/Jk06Dpo/cc9wI72umogKatKN/fgE/sIrO9GS2c
         S9Bug1UmAVKhrsp8kymHPVbFkP8y/xlAzcVS6sblJ5O2i+x4U7sfUgJpCubvmmAsoJro
         GtMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X3icFpv4MZ7BFuk/N7WqVemM3OsYZe1RmrGTB7OHI0k=;
        b=rqS48YuRJI8Xc168Gt1X6ctpquP9boAHH3SgAlmODA0tQqB9/hk5R8Mzej8xnBB+Q9
         JHJ3WtfH42wKbnn91EshSMMGiABslyxxVr26cFcJPNzI51U48jfT0NaTWAvuw4/9Rnit
         /dOAMUWe6jX2cLUuAqPj/L2MyUZkvj7jCELej2m4Pf4iJQrgWFmOLRvIta6LvicToBlK
         QTeZQCMww8PoJIJe52EHbWZ9etXVMgThuNXMgP6e8BdqEXwuZLbSIkamwe9d4nIL3Y/s
         KPHE1LiyEwuByCHmM13XoJVslgAeUuI86F/crVN39pxvOG/w8cVEYTeDnWa9NweoQ/n/
         +x3g==
X-Gm-Message-State: AOAM531/JrQeHEpgctU/ejXxWnm/J4d2s9cynXyNu3zzBx9Ap+Dq02Va
        yncowP7XY5hOkdEh1b4663yQvysr+YVdvG88
X-Google-Smtp-Source: ABdhPJyjBRRFoCH/5f8qH63VFs20xGHtkDB1pu6CLiMBbcdA1H04mETw5bB/vnr3+a1dHDpbwNnIEg==
X-Received: by 2002:a37:e508:: with SMTP id e8mr3843765qkg.380.1598996443198;
        Tue, 01 Sep 2020 14:40:43 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y18sm3025699qkf.93.2020.09.01.14.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 14:40:42 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/4] btrfs: init sysfs for devices outside of the chunk_mutex
Date:   Tue,  1 Sep 2020 17:40:36 -0400
Message-Id: <5dccee8f9d7fe7b5072090327854fcbfdbd45b28.1598996236.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1598996236.git.josef@toxicpanda.com>
References: <cover.1598996236.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While running btrfs/187 I hit the following lockdep splat

======================================================
WARNING: possible circular locking dependency detected
5.9.0-rc3+ #4 Not tainted
------------------------------------------------------
kswapd0/100 is trying to acquire lock:
ffff96ecc22ef4a0 (&delayed_node->mutex){+.+.}-{3:3}, at: __btrfs_release_delayed_node.part.0+0x3f/0x330

but task is already holding lock:
ffffffff8dd74700 (fs_reclaim){+.+.}-{0:0}, at: __fs_reclaim_acquire+0x5/0x30

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #3 (fs_reclaim){+.+.}-{0:0}:
       fs_reclaim_acquire+0x65/0x80
       slab_pre_alloc_hook.constprop.0+0x20/0x200
       kmem_cache_alloc+0x37/0x270
       alloc_inode+0x82/0xb0
       iget_locked+0x10d/0x2c0
       kernfs_get_inode+0x1b/0x130
       kernfs_get_tree+0x136/0x240
       sysfs_get_tree+0x16/0x40
       vfs_get_tree+0x28/0xc0
       path_mount+0x434/0xc00
       __x64_sys_mount+0xe3/0x120
       do_syscall_64+0x33/0x40
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #2 (kernfs_mutex){+.+.}-{3:3}:
       __mutex_lock+0x7e/0x7e0
       kernfs_add_one+0x23/0x150
       kernfs_create_link+0x63/0xa0
       sysfs_do_create_link_sd+0x5e/0xd0
       btrfs_sysfs_add_devices_dir+0x81/0x130
       btrfs_init_new_device+0x67f/0x1250
       btrfs_ioctl+0x1ef/0x2e20
       __x64_sys_ioctl+0x83/0xb0
       do_syscall_64+0x33/0x40
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #1 (&fs_info->chunk_mutex){+.+.}-{3:3}:
       __mutex_lock+0x7e/0x7e0
       btrfs_chunk_alloc+0x125/0x3a0
       find_free_extent+0xdf6/0x1210
       btrfs_reserve_extent+0xb3/0x1b0
       btrfs_alloc_tree_block+0xb0/0x310
       alloc_tree_block_no_bg_flush+0x4a/0x60
       __btrfs_cow_block+0x11a/0x530
       btrfs_cow_block+0x104/0x220
       btrfs_search_slot+0x52e/0x9d0
       btrfs_insert_empty_items+0x64/0xb0
       btrfs_insert_delayed_items+0x90/0x4f0
       btrfs_commit_inode_delayed_items+0x93/0x140
       btrfs_log_inode+0x5de/0x2020
       btrfs_log_inode_parent+0x429/0xc90
       btrfs_log_new_name+0x95/0x9b
       btrfs_rename2+0xbb9/0x1800
       vfs_rename+0x64f/0x9f0
       do_renameat2+0x320/0x4e0
       __x64_sys_rename+0x1f/0x30
       do_syscall_64+0x33/0x40
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #0 (&delayed_node->mutex){+.+.}-{3:3}:
       __lock_acquire+0x119c/0x1fc0
       lock_acquire+0xa7/0x3d0
       __mutex_lock+0x7e/0x7e0
       __btrfs_release_delayed_node.part.0+0x3f/0x330
       btrfs_evict_inode+0x24c/0x500
       evict+0xcf/0x1f0
       dispose_list+0x48/0x70
       prune_icache_sb+0x44/0x50
       super_cache_scan+0x161/0x1e0
       do_shrink_slab+0x178/0x3c0
       shrink_slab+0x17c/0x290
       shrink_node+0x2b2/0x6d0
       balance_pgdat+0x30a/0x670
       kswapd+0x213/0x4c0
       kthread+0x138/0x160
       ret_from_fork+0x1f/0x30

other info that might help us debug this:

Chain exists of:
  &delayed_node->mutex --> kernfs_mutex --> fs_reclaim

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(kernfs_mutex);
                               lock(fs_reclaim);
  lock(&delayed_node->mutex);

 *** DEADLOCK ***

3 locks held by kswapd0/100:
 #0: ffffffff8dd74700 (fs_reclaim){+.+.}-{0:0}, at: __fs_reclaim_acquire+0x5/0x30
 #1: ffffffff8dd65c50 (shrinker_rwsem){++++}-{3:3}, at: shrink_slab+0x115/0x290
 #2: ffff96ed2ade30e0 (&type->s_umount_key#36){++++}-{3:3}, at: super_cache_scan+0x38/0x1e0

stack backtrace:
CPU: 0 PID: 100 Comm: kswapd0 Not tainted 5.9.0-rc3+ #4
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
Call Trace:
 dump_stack+0x8b/0xb8
 check_noncircular+0x12d/0x150
 __lock_acquire+0x119c/0x1fc0
 lock_acquire+0xa7/0x3d0
 ? __btrfs_release_delayed_node.part.0+0x3f/0x330
 __mutex_lock+0x7e/0x7e0
 ? __btrfs_release_delayed_node.part.0+0x3f/0x330
 ? __btrfs_release_delayed_node.part.0+0x3f/0x330
 ? lock_acquire+0xa7/0x3d0
 ? find_held_lock+0x2b/0x80
 __btrfs_release_delayed_node.part.0+0x3f/0x330
 btrfs_evict_inode+0x24c/0x500
 evict+0xcf/0x1f0
 dispose_list+0x48/0x70
 prune_icache_sb+0x44/0x50
 super_cache_scan+0x161/0x1e0
 do_shrink_slab+0x178/0x3c0
 shrink_slab+0x17c/0x290
 shrink_node+0x2b2/0x6d0
 balance_pgdat+0x30a/0x670
 kswapd+0x213/0x4c0
 ? _raw_spin_unlock_irqrestore+0x41/0x50
 ? add_wait_queue_exclusive+0x70/0x70
 ? balance_pgdat+0x670/0x670
 kthread+0x138/0x160
 ? kthread_create_worker_on_cpu+0x40/0x40
 ret_from_fork+0x1f/0x30

This happens because we are holding the chunk_mutex at the time of
adding in a new device.  However we only need to hold the
device_list_mutex, as we're going to iterate over the fs_devices
devices.  Move the sysfs init stuff outside of the chunk_mutex to get
rid of this lockdep splat.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d6bbbe1986bb..77b7da42c651 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2599,9 +2599,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	btrfs_set_super_num_devices(fs_info->super_copy,
 				    orig_super_num_devices + 1);
 
-	/* add sysfs device entry */
-	btrfs_sysfs_add_devices_dir(fs_devices, device);
-
 	/*
 	 * we've got more storage, clear any full flags on the space
 	 * infos
@@ -2609,6 +2606,10 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	btrfs_clear_space_info_full(fs_info);
 
 	mutex_unlock(&fs_info->chunk_mutex);
+
+	/* add sysfs device entry */
+	btrfs_sysfs_add_devices_dir(fs_devices, device);
+
 	mutex_unlock(&fs_devices->device_list_mutex);
 
 	if (seeding_dev) {
-- 
2.26.2

