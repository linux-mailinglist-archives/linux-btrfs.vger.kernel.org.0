Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8AE525A0E3
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Sep 2020 23:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbgIAVkp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Sep 2020 17:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgIAVkm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Sep 2020 17:40:42 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BB0C061244
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Sep 2020 14:40:42 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id g3so2058550qtq.10
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Sep 2020 14:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=eDkCZu+J6jKYH2Fv3IahLylbsshyZByVuff6an4iGio=;
        b=f46umhaKGdOGB3Xeyc4Ka+oRL5wvNUGKKhFSf/YvWztj8M5sum4w+Rkjj4s+2zxt0s
         l77tunGdrYhr+iFb32ThBwWecYjFH8/3W6rhlM4lJQi+hveLqVWRlizf/MTEtRRFxmrn
         dBkJ/kLcaoV6RvqefuarSmjjXcmp152oecAXbI6z2UPsjvZZjkaxra/fkeN2Rk/7LNcQ
         0DkBd8Y4SQlaW3/cWvvJH0NLz9sbwMUVPvBUjXiHLQmpNCfafZytlQ8pJ3YKLplBeQqW
         ZAS47ZTHBd/6HWJJ+66tymGNwuDICp0WyXQdelT/RGt6Dcj1p7D/6N3M2vrMGPQoar5v
         UbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eDkCZu+J6jKYH2Fv3IahLylbsshyZByVuff6an4iGio=;
        b=mFCU4uo5MlkPF4f04rbZGCLoXQarxOvL+2jQV30Ni9wMlmuvlO1fDjw56PN4WMJX7f
         mRLkTn6P2bVnjzyHLdTGCAoEVww6HE4GNWX/hhT+eJyBryo/86Hbl3bVleoZSvp0dK0J
         vQJTb1TKN/jBOsFzx3JF6zN7vYEy3C4bu78/Qmxl9L9Z5Z4h9CBQfoihUfqovv8p60jx
         s5qY0sGTbkiphi5nh45ZPnsp0jasA7pX9JXxVuBRDx+8amN2j7oYYin6B4sYjZj6izcW
         TqQLdEtBDSYRLQBDNFc13/a08ah1a+UIx2/gAwj17qUTfEvJwxQ9SILfteK3tlH+xDwE
         bLHQ==
X-Gm-Message-State: AOAM5326aFAQS76FDhPqg8JA6l1hGxMmU62jel24Y2Z6M2T+u7FcSi04
        3UEcBQwPiaFKguiqYkMFjXjOiJY4YlelPPZz
X-Google-Smtp-Source: ABdhPJzMvU8n6CFsUBsjFgRbuGwUoKIHouVsZEkguOraFZxXX9a2Irwj2YiJoMtsQd3N/OxWOLtdJQ==
X-Received: by 2002:ac8:6c6:: with SMTP id j6mr4069649qth.129.1598996441486;
        Tue, 01 Sep 2020 14:40:41 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q26sm3307627qtq.91.2020.09.01.14.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 14:40:40 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/4] btrfs: fix lockdep splat in add_missing_dev
Date:   Tue,  1 Sep 2020 17:40:35 -0400
Message-Id: <8cad21a9f0bcc2bd29a2b0e89e475687c44b3a59.1598996236.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1598996236.git.josef@toxicpanda.com>
References: <cover.1598996236.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Nikolay reported a lockdep splat that I could reproduce with btrfs/187.

======================================================
WARNING: possible circular locking dependency detected
5.9.0-rc2+ #1 Tainted: G        W
------------------------------------------------------
kswapd0/100 is trying to acquire lock:
ffff9e8ef38b6268 (&delayed_node->mutex){+.+.}-{3:3}, at: __btrfs_release_delayed_node.part.0+0x3f/0x330

but task is already holding lock:
ffffffffa9d74700 (fs_reclaim){+.+.}-{0:0}, at: __fs_reclaim_acquire+0x5/0x30

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #2 (fs_reclaim){+.+.}-{0:0}:
       fs_reclaim_acquire+0x65/0x80
       slab_pre_alloc_hook.constprop.0+0x20/0x200
       kmem_cache_alloc_trace+0x3a/0x1a0
       btrfs_alloc_device+0x43/0x210
       add_missing_dev+0x20/0x90
       read_one_chunk+0x301/0x430
       btrfs_read_sys_array+0x17b/0x1b0
       open_ctree+0xa62/0x1896
       btrfs_mount_root.cold+0x12/0xea
       legacy_get_tree+0x30/0x50
       vfs_get_tree+0x28/0xc0
       vfs_kern_mount.part.0+0x71/0xb0
       btrfs_mount+0x10d/0x379
       legacy_get_tree+0x30/0x50
       vfs_get_tree+0x28/0xc0
       path_mount+0x434/0xc00
       __x64_sys_mount+0xe3/0x120
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
       btrfs_lookup_inode+0x2a/0x8f
       __btrfs_update_delayed_inode+0x80/0x240
       btrfs_commit_inode_delayed_inode+0x119/0x120
       btrfs_evict_inode+0x357/0x500
       evict+0xcf/0x1f0
       vfs_rmdir.part.0+0x149/0x160
       do_rmdir+0x136/0x1a0
       do_syscall_64+0x33/0x40
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #0 (&delayed_node->mutex){+.+.}-{3:3}:
       __lock_acquire+0x1184/0x1fa0
       lock_acquire+0xa4/0x3d0
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
  &delayed_node->mutex --> &fs_info->chunk_mutex --> fs_reclaim

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(&fs_info->chunk_mutex);
                               lock(fs_reclaim);
  lock(&delayed_node->mutex);

 *** DEADLOCK ***

3 locks held by kswapd0/100:
 #0: ffffffffa9d74700 (fs_reclaim){+.+.}-{0:0}, at: __fs_reclaim_acquire+0x5/0x30
 #1: ffffffffa9d65c50 (shrinker_rwsem){++++}-{3:3}, at: shrink_slab+0x115/0x290
 #2: ffff9e8e9da260e0 (&type->s_umount_key#48){++++}-{3:3}, at: super_cache_scan+0x38/0x1e0

stack backtrace:
CPU: 1 PID: 100 Comm: kswapd0 Tainted: G        W         5.9.0-rc2+ #1
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
Call Trace:
 dump_stack+0x92/0xc8
 check_noncircular+0x12d/0x150
 __lock_acquire+0x1184/0x1fa0
 lock_acquire+0xa4/0x3d0
 ? __btrfs_release_delayed_node.part.0+0x3f/0x330
 __mutex_lock+0x7e/0x7e0
 ? __btrfs_release_delayed_node.part.0+0x3f/0x330
 ? __btrfs_release_delayed_node.part.0+0x3f/0x330
 ? lock_acquire+0xa4/0x3d0
 ? btrfs_evict_inode+0x11e/0x500
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
 ? _raw_spin_unlock_irqrestore+0x46/0x60
 ? add_wait_queue_exclusive+0x70/0x70
 ? balance_pgdat+0x670/0x670
 kthread+0x138/0x160
 ? kthread_create_worker_on_cpu+0x40/0x40
 ret_from_fork+0x1f/0x30

This is because we are holding the chunk_mutex when we call
btrfs_alloc_device, which does a GFP_KERNEL allocation.  We don't want
to switch that to a GFP_NOFS lock because this is the only place where
it matters.  So instead use memalloc_nofs_save() around the allocation
in order to avoid the lockdep splat.

References: https://github.com/btrfs/fstests/issues/6
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 3f8bd1af29eb..d6bbbe1986bb 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/sched.h>
+#include <linux/sched/mm.h>
 #include <linux/bio.h>
 #include <linux/slab.h>
 #include <linux/blkdev.h>
@@ -6480,8 +6481,17 @@ static struct btrfs_device *add_missing_dev(struct btrfs_fs_devices *fs_devices,
 					    u64 devid, u8 *dev_uuid)
 {
 	struct btrfs_device *device;
+	unsigned int nofs_flag;
 
+	/*
+	 * We call this under the chunk_mutex, so we want to use NOFS for this
+	 * allocation, however we don't want to change btrfs_alloc_device() to
+	 * always do NOFS because we use it in a lot of other GFP_KERNEL safe
+	 * places.
+	 */
+	nofs_flag = memalloc_nofs_save();
 	device = btrfs_alloc_device(NULL, &devid, dev_uuid);
+	memalloc_nofs_restore(nofs_flag);
 	if (IS_ERR(device))
 		return device;
 
-- 
2.26.2

