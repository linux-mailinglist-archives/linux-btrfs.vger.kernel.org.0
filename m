Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E00221F87F
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jul 2020 19:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgGNRtK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jul 2020 13:49:10 -0400
Received: from gateway30.websitewelcome.com ([50.116.125.1]:44733 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725883AbgGNRtK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jul 2020 13:49:10 -0400
X-Greylist: delayed 1457 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Jul 2020 13:49:09 EDT
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 7D4CBFE0F
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jul 2020 12:24:40 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id vOfYjusfAQyTQvOfYjnVBB; Tue, 14 Jul 2020 12:24:40 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1CtBMPEe29OKwBRGG1//gIE0NBYUQq+62c7jTnJzYGk=; b=d9Csjgur+xjTzsaYvEQy/LC1A/
        JEoUFUzalHffjQ9AcpmtEBMxePI2LY6Q0AX+BqLt9CgQZN7hr+sHg2iQNzizqmwSeHEMSDqID2nGN
        u8PhDPr8X+UKY8fPmbMlRycvW8ZZD0xly2UJjLIHQoSxx4kXRQmdCRESXpjUGulbNIfjYOVj7nPzh
        1bT4JbreoPSbruH5FLAnjKDpAFlXHXK/3BIAa3Eiw1mEWKYB7O4Z1VCckD33hhgtuBTtrfA33be/5
        ywONoVSBdthwD72xmWftPVbUMIY+q7JAs9s8WCQSGIFOC2idvJY30cBGNls3YZjlfmAnLlrqyO5JX
        E7C3/Kkw==;
Received: from 200.146.48.208.dynamic.dialup.gvt.net.br ([200.146.48.208]:55792 helo=hephaestus.suse.de)
        by br540.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <marcos@mpdesouza.com>)
        id 1jvOfX-001vV6-Gb; Tue, 14 Jul 2020 14:24:39 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        Nokolay Borisov <nborisov@suse.com>
Subject: [RFC] btrfs: volumes: Drop chunk_mutex lock/unlock on btrfs_read_chunk_tree
Date:   Tue, 14 Jul 2020 14:21:53 -0300
Message-Id: <20200714172153.12956-1-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 200.146.48.208
X-Source-L: No
X-Exim-ID: 1jvOfX-001vV6-Gb
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 200.146.48.208.dynamic.dialup.gvt.net.br (hephaestus.suse.de) [200.146.48.208]:55792
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 4
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

There is a lockdep report when running xfstests btrfs/161 (seed + sprout
devices) related to chunk_mutex:

======================================================
WARNING: possible circular locking dependency detected
5.8.0-rc4-default #504 Not tainted
------------------------------------------------------
mount/454 is trying to acquire lock:
ffff8881133058e8 (&fs_devs->device_list_mutex){+.+.}-{3:3}, at: clone_fs_devices+0x4d/0x340

but task is already holding lock:
ffff888112010988 (&fs_info->chunk_mutex){+.+.}-{3:3}, at: btrfs_read_chunk_tree+0xcc/0x600

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (&fs_info->chunk_mutex){+.+.}-{3:3}:
       __mutex_lock+0x139/0x13e0
       btrfs_init_new_device+0x1ed1/0x3c50
       btrfs_ioctl+0x19b4/0x8130
       ksys_ioctl+0xa9/0xf0
       __x64_sys_ioctl+0x6f/0xb0
       do_syscall_64+0x50/0xd0
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #0 (&fs_devs->device_list_mutex){+.+.}-{3:3}:
       __lock_acquire+0x2df6/0x4da0
       lock_acquire+0x176/0x820
       __mutex_lock+0x139/0x13e0
       clone_fs_devices+0x4d/0x340
       read_one_dev+0xa5c/0x13e0
       btrfs_read_chunk_tree+0x480/0x600
       open_ctree+0x244b/0x450d
       btrfs_mount_root.cold.80+0x10/0x129
       legacy_get_tree+0xff/0x1f0
       vfs_get_tree+0x83/0x250
       fc_mount+0xf/0x90
       vfs_kern_mount.part.47+0x5c/0x80
       btrfs_mount+0x215/0xbcf
       legacy_get_tree+0xff/0x1f0
       vfs_get_tree+0x83/0x250
       do_mount+0x106d/0x16f0
       __x64_sys_mount+0x162/0x1b0
       do_syscall_64+0x50/0xd0
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&fs_info->chunk_mutex);
                               lock(&fs_devs->device_list_mutex);
                               lock(&fs_info->chunk_mutex);
  lock(&fs_devs->device_list_mutex);

 *** DEADLOCK ***

3 locks held by mount/454:
 #0: ffff8881119340e8 (&type->s_umount_key#41/1){+.+.}-{3:3}, at: alloc_super.isra.21+0x183/0x990
 #1: ffffffff83b260d0 (uuid_mutex){+.+.}-{3:3}, at: btrfs_read_chunk_tree+0xb6/0x600
 #2: ffff888112010988 (&fs_info->chunk_mutex){+.+.}-{3:3}, at: btrfs_read_chunk_tree+0xcc/0x600

stack backtrace:
CPU: 3 PID: 454 Comm: mount Not tainted 5.8.0-rc4-default #504
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
Call Trace:
 dump_stack+0x9d/0xe0
 check_noncircular+0x351/0x410
 ? print_circular_bug.isra.41+0x360/0x360
 ? mark_lock+0x12d/0x14d0
 ? rcu_read_unlock+0x40/0x40
 ? sched_clock+0x5/0x10
 ? sched_clock_cpu+0x18/0x170
 ? sched_clock_cpu+0x18/0x170
 __lock_acquire+0x2df6/0x4da0
 ? lockdep_hardirqs_on_prepare+0x540/0x540
 ? _raw_spin_unlock_irqrestore+0x3e/0x50
 ? trace_hardirqs_on+0x20/0x170
 ? stack_depot_save+0x260/0x470
 lock_acquire+0x176/0x820
 ? clone_fs_devices+0x4d/0x340
 ? btrfs_mount_root.cold.80+0x10/0x129
 ? rcu_read_unlock+0x40/0x40
 ? vfs_kern_mount.part.47+0x5c/0x80
 ? btrfs_mount+0x215/0xbcf
 ? legacy_get_tree+0xff/0x1f0
 ? vfs_get_tree+0x83/0x250
 ? do_mount+0x106d/0x16f0
 ? __x64_sys_mount+0x162/0x1b0
 ? do_syscall_64+0x50/0xd0
 __mutex_lock+0x139/0x13e0
 ? clone_fs_devices+0x4d/0x340
 ? clone_fs_devices+0x4d/0x340
 ? mark_held_locks+0xb7/0x120
 ? mutex_lock_io_nested+0x12a0/0x12a0
 ? rcu_read_lock_sched_held+0xa1/0xd0
 ? lockdep_init_map_waits+0x29f/0x810
 ? lockdep_init_map_waits+0x29f/0x810
 ? debug_mutex_init+0x31/0x60
 ? clone_fs_devices+0x4d/0x340
 clone_fs_devices+0x4d/0x340
 ? read_extent_buffer+0x15b/0x2a0
 read_one_dev+0xa5c/0x13e0
 ? split_leaf+0xef0/0xef0
 ? read_one_chunk+0xb20/0xb20
 ? btrfs_get_token_32+0x730/0x730
 ? memcpy+0x38/0x60
 ? read_extent_buffer+0x15b/0x2a0
 btrfs_read_chunk_tree+0x480/0x600
 ? btrfs_check_rw_degradable+0x340/0x340
 ? btrfs_root_node+0x2d/0x240
 ? memcpy+0x38/0x60
 ? read_extent_buffer+0x15b/0x2a0
 ? btrfs_root_node+0x2d/0x240
 open_ctree+0x244b/0x450d
 ? close_ctree+0x61c/0x61c
 ? sget+0x328/0x400
 btrfs_mount_root.cold.80+0x10/0x129
 ? parse_rescue_options+0x260/0x260
 ? rcu_read_lock_sched_held+0xa1/0xd0
 ? rcu_read_lock_bh_held+0xb0/0xb0
 ? kfree+0x2e2/0x330
 ? parse_rescue_options+0x260/0x260
 legacy_get_tree+0xff/0x1f0
 vfs_get_tree+0x83/0x250
 fc_mount+0xf/0x90
 vfs_kern_mount.part.47+0x5c/0x80
 btrfs_mount+0x215/0xbcf
 ? check_object+0xb3/0x2c0
 ? btrfs_get_subvol_name_from_objectid+0x7f0/0x7f0
 ? ___slab_alloc+0x4e5/0x570
 ? vfs_parse_fs_string+0xc0/0x100
 ? rcu_read_lock_sched_held+0xa1/0xd0
 ? rcu_read_lock_bh_held+0xb0/0xb0
 ? kfree+0x2e2/0x330
 ? btrfs_get_subvol_name_from_objectid+0x7f0/0x7f0
 ? legacy_get_tree+0xff/0x1f0
 legacy_get_tree+0xff/0x1f0
 vfs_get_tree+0x83/0x250
 do_mount+0x106d/0x16f0
 ? lock_downgrade+0x720/0x720
 ? copy_mount_string+0x20/0x20
 ? _copy_from_user+0xbe/0x100
 ? memdup_user+0x47/0x70
 __x64_sys_mount+0x162/0x1b0
 do_syscall_64+0x50/0xd0
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f82dd1583ca
Code: Bad RIP value.
RSP: 002b:00007ffcf6935fc8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000562f10678500 RCX: 00007f82dd1583ca
RDX: 0000562f1067f8e0 RSI: 0000562f1067b3f0 RDI: 0000562f106786e0
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000c0ed0000 R11: 0000000000000202 R12: 0000562f106786e0
R13: 0000562f1067f8e0 R14: 0000000000000000 R15: 00007f82dd6798a4

In volumes.c there are comments stating that chunk_mutex is used to
protect add/remove chunks, trim or add/remove devices. Since
btrfs_read_chunk_tree is only called on mount, and trim and chunk alloc
cannot happen at mount time, it's safe to remove this lock/unlock.

Also, btrfs_ioctl_{add|rm}_dev calls set BTRFS_FS_EXCL_OP, which should
be safe.

Dropping the mutex lock/unlock solves the lockdep warning.

Suggested-by: Nokolay Borisov <nborisov@suse.com>
Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 fs/btrfs/volumes.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c7a3d4d730a3..94cbdadd9d26 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7033,7 +7033,6 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
 	 * otherwise we don't need it.
 	 */
 	mutex_lock(&uuid_mutex);
-	mutex_lock(&fs_info->chunk_mutex);
 
 	/*
 	 * Read all device items, and then all the chunk items. All
@@ -7100,7 +7099,6 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
 	}
 	ret = 0;
 error:
-	mutex_unlock(&fs_info->chunk_mutex);
 	mutex_unlock(&uuid_mutex);
 
 	btrfs_free_path(path);
-- 
2.27.0

