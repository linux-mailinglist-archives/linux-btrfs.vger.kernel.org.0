Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9999A28E82F
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Oct 2020 23:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbgJNVB5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Oct 2020 17:01:57 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:41258 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730579AbgJNVBz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Oct 2020 17:01:55 -0400
Received: by mail-qv1-f67.google.com with SMTP id t20so231672qvv.8
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Oct 2020 14:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Otu5ZWOx7VRl4QAh+hCSYlAPrDDstJgrx/BHzc/wK6Q=;
        b=qgwg4zB1Pm26xtNFDIOf2AHF6UwmZ7xYzJfgCy0B8D63kkvG5SpzWI7MBeyaYXfnD/
         0J4BMz982oNQBbQax8qvBxzl7L4ByVfOt28N1UdoFaaxxYQ0lSqIW4ZuiXMvWWpQdEJf
         vGH6T6MgfmT+GwGGLfnEpntVVKIX5EfB4bYc7WuE2E4qn0oCnA7iTxY3j6dlwMVWF8nt
         gjLeAFDxWD22KdjTJRT/GhFy56UZqX7MoweI5GdXQpw4gYQSTQp2rLZOmLn+YKk+Z/3W
         aJAiJmQHSWRHe0LDT2J7Dm8FO/+bkNi0m7SXMmsBS5PodnQsRVDyROOW4x0dFXKsDV8K
         KNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Otu5ZWOx7VRl4QAh+hCSYlAPrDDstJgrx/BHzc/wK6Q=;
        b=L6KluwzExK6iIlhN8GCVFP2jShCwNWwayh2Rhg/O89IC/hTTwGQkQfVh2mSyV2+/hs
         acumXr+I5LfKlxw3wf/t9s/RQG4UooZ3u6JpIe5Mz5d/ocalFeFz+6dF6SaYg6hl+hcY
         xjotZ7fll6UO3Wo+wo87whl4nAqxwCUFEZFOFM1F8P9LBhkNtqqzbNfCIX11kgKrGvFr
         O+D1c+m946g72/ht+lrk/0GU3rzQy+PKfYbaF5AxwfwVYz/+U6kK3j1IeSJSB389IqYV
         LosYPBG/o9Y6CwS84rd5aQ/9kitniQRyq8ZWMi5y0y4y4s4hpLdxv5kOsPvolFoqgdk5
         PrvQ==
X-Gm-Message-State: AOAM532rrhBrhtxKc8976W22U68eciggMReW/8dHYbQjjCei+5LCA7dq
        MnEn9cJMAP4vxBvwWv8Ja3eQeV8qh4LI8GIL
X-Google-Smtp-Source: ABdhPJy95bO7QSl9E6VU7v74bQFd4guKjLALayvaPXxr3IpYolwGYdqeB/maQkBKgJE3tkBL2/5Slg==
X-Received: by 2002:ad4:59cf:: with SMTP id el15mr1247542qvb.17.1602709253304;
        Wed, 14 Oct 2020 14:00:53 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e39sm319817qtk.32.2020.10.14.14.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 14:00:52 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: drop the path before adding blockgroup sysfs files
Date:   Wed, 14 Oct 2020 17:00:51 -0400
Message-Id: <03a94ec83095d00b19dcb65fda1b58f1b41f1297.1602709223.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dave reported a problem with my rwsem conversion patch where we got the
following lockdep splat

======================================================
WARNING: possible circular locking dependency detected
5.9.0-default+ #1297 Not tainted
------------------------------------------------------
kswapd0/76 is trying to acquire lock:
ffff9d5d25df2530 (&delayed_node->mutex){+.+.}-{3:3}, at: __btrfs_release_delayed_node.part.0+0x3f/0x320 [btrfs]

but task is already holding lock:
ffffffffa40cbba0 (fs_reclaim){+.+.}-{0:0}, at: __fs_reclaim_acquire+0x5/0x30

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #4 (fs_reclaim){+.+.}-{0:0}:
       __lock_acquire+0x582/0xac0
       lock_acquire+0xca/0x430
       fs_reclaim_acquire.part.0+0x25/0x30
       kmem_cache_alloc+0x30/0x9c0
       alloc_inode+0x81/0x90
       iget_locked+0xcd/0x1a0
       kernfs_get_inode+0x1b/0x130
       kernfs_get_tree+0x136/0x210
       sysfs_get_tree+0x1a/0x50
       vfs_get_tree+0x1d/0xb0
       path_mount+0x70f/0xa80
       do_mount+0x75/0x90
       __x64_sys_mount+0x8e/0xd0
       do_syscall_64+0x2d/0x70
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #3 (kernfs_mutex){+.+.}-{3:3}:
       __lock_acquire+0x582/0xac0
       lock_acquire+0xca/0x430
       __mutex_lock+0xa0/0xaf0
       kernfs_add_one+0x23/0x150
       kernfs_create_dir_ns+0x58/0x80
       sysfs_create_dir_ns+0x70/0xd0
       kobject_add_internal+0xbb/0x2d0
       kobject_add+0x7a/0xd0
       btrfs_sysfs_add_block_group_type+0x141/0x1d0 [btrfs]
       btrfs_read_block_groups+0x1f1/0x8c0 [btrfs]
       open_ctree+0x981/0x1108 [btrfs]
       btrfs_mount_root.cold+0xe/0xb0 [btrfs]
       legacy_get_tree+0x2d/0x60
       vfs_get_tree+0x1d/0xb0
       fc_mount+0xe/0x40
       vfs_kern_mount.part.0+0x71/0x90
       btrfs_mount+0x13b/0x3e0 [btrfs]
       legacy_get_tree+0x2d/0x60
       vfs_get_tree+0x1d/0xb0
       path_mount+0x70f/0xa80
       do_mount+0x75/0x90
       __x64_sys_mount+0x8e/0xd0
       do_syscall_64+0x2d/0x70
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #2 (btrfs-extent-00){++++}-{3:3}:
       __lock_acquire+0x582/0xac0
       lock_acquire+0xca/0x430
       down_read_nested+0x45/0x220
       __btrfs_tree_read_lock+0x35/0x1c0 [btrfs]
       __btrfs_read_lock_root_node+0x3a/0x50 [btrfs]
       btrfs_search_slot+0x6d4/0xfd0 [btrfs]
       check_committed_ref+0x69/0x200 [btrfs]
       btrfs_cross_ref_exist+0x65/0xb0 [btrfs]
       run_delalloc_nocow+0x446/0x9b0 [btrfs]
       btrfs_run_delalloc_range+0x61/0x6a0 [btrfs]
       writepage_delalloc+0xae/0x160 [btrfs]
       __extent_writepage+0x262/0x420 [btrfs]
       extent_write_cache_pages+0x2b6/0x510 [btrfs]
       extent_writepages+0x43/0x90 [btrfs]
       do_writepages+0x40/0xe0
       __writeback_single_inode+0x62/0x610
       writeback_sb_inodes+0x20f/0x500
       wb_writeback+0xef/0x4a0
       wb_do_writeback+0x49/0x2e0
       wb_workfn+0x81/0x340
       process_one_work+0x233/0x5d0
       worker_thread+0x50/0x3b0
       kthread+0x137/0x150
       ret_from_fork+0x1f/0x30

-> #1 (btrfs-fs-00){++++}-{3:3}:
       __lock_acquire+0x582/0xac0
       lock_acquire+0xca/0x430
       down_read_nested+0x45/0x220
       __btrfs_tree_read_lock+0x35/0x1c0 [btrfs]
       __btrfs_read_lock_root_node+0x3a/0x50 [btrfs]
       btrfs_search_slot+0x6d4/0xfd0 [btrfs]
       btrfs_lookup_inode+0x3a/0xc0 [btrfs]
       __btrfs_update_delayed_inode+0x93/0x2c0 [btrfs]
       __btrfs_commit_inode_delayed_items+0x7de/0x850 [btrfs]
       __btrfs_run_delayed_items+0x8e/0x140 [btrfs]
       btrfs_commit_transaction+0x367/0xbc0 [btrfs]
       btrfs_mksubvol+0x2db/0x470 [btrfs]
       btrfs_mksnapshot+0x7b/0xb0 [btrfs]
       __btrfs_ioctl_snap_create+0x16f/0x1a0 [btrfs]
       btrfs_ioctl_snap_create_v2+0xb0/0xf0 [btrfs]
       btrfs_ioctl+0xd0b/0x2690 [btrfs]
       __x64_sys_ioctl+0x6f/0xa0
       do_syscall_64+0x2d/0x70
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #0 (&delayed_node->mutex){+.+.}-{3:3}:
       check_prev_add+0x91/0xc60
       validate_chain+0xa6e/0x2a20
       __lock_acquire+0x582/0xac0
       lock_acquire+0xca/0x430
       __mutex_lock+0xa0/0xaf0
       __btrfs_release_delayed_node.part.0+0x3f/0x320 [btrfs]
       btrfs_evict_inode+0x3cc/0x560 [btrfs]
       evict+0xd6/0x1c0
       dispose_list+0x48/0x70
       prune_icache_sb+0x54/0x80
       super_cache_scan+0x121/0x1a0
       do_shrink_slab+0x16d/0x3b0
       shrink_slab+0xb1/0x2e0
       shrink_node+0x230/0x6a0
       balance_pgdat+0x325/0x750
       kswapd+0x206/0x4d0
       kthread+0x137/0x150
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

3 locks held by kswapd0/76:
 #0: ffffffffa40cbba0 (fs_reclaim){+.+.}-{0:0}, at: __fs_reclaim_acquire+0x5/0x30
 #1: ffffffffa40b8b58 (shrinker_rwsem){++++}-{3:3}, at: shrink_slab+0x54/0x2e0
 #2: ffff9d5d322390e8 (&type->s_umount_key#26){++++}-{3:3}, at: trylock_super+0x16/0x50

stack backtrace:
CPU: 2 PID: 76 Comm: kswapd0 Not tainted 5.9.0-default+ #1297
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
Call Trace:
 dump_stack+0x77/0x97
 check_noncircular+0xff/0x110
 ? save_trace+0x50/0x470
 check_prev_add+0x91/0xc60
 validate_chain+0xa6e/0x2a20
 ? save_trace+0x50/0x470
 __lock_acquire+0x582/0xac0
 lock_acquire+0xca/0x430
 ? __btrfs_release_delayed_node.part.0+0x3f/0x320 [btrfs]
 __mutex_lock+0xa0/0xaf0
 ? __btrfs_release_delayed_node.part.0+0x3f/0x320 [btrfs]
 ? __lock_acquire+0x582/0xac0
 ? __btrfs_release_delayed_node.part.0+0x3f/0x320 [btrfs]
 ? btrfs_evict_inode+0x30b/0x560 [btrfs]
 ? __btrfs_release_delayed_node.part.0+0x3f/0x320 [btrfs]
 __btrfs_release_delayed_node.part.0+0x3f/0x320 [btrfs]
 btrfs_evict_inode+0x3cc/0x560 [btrfs]
 evict+0xd6/0x1c0
 dispose_list+0x48/0x70
 prune_icache_sb+0x54/0x80
 super_cache_scan+0x121/0x1a0
 do_shrink_slab+0x16d/0x3b0
 shrink_slab+0xb1/0x2e0
 shrink_node+0x230/0x6a0
 balance_pgdat+0x325/0x750
 kswapd+0x206/0x4d0
 ? finish_wait+0x90/0x90
 ? balance_pgdat+0x750/0x750
 kthread+0x137/0x150
 ? kthread_mod_delayed_work+0xc0/0xc0
 ret_from_fork+0x1f/0x30

This happens because we are still holding the path open when we start
adding the sysfs files for the block groups, which creates a dependency
on fs_reclaim via the tree lock.  Fix this by dropping the path before
we start doing anything with sysfs.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index c0f1d6818df7..3ba6f3839d39 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2024,6 +2024,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 		key.offset = 0;
 		btrfs_release_path(path);
 	}
+	btrfs_release_path(path);
 
 	list_for_each_entry(space_info, &info->space_info, list) {
 		int i;
-- 
2.26.2

