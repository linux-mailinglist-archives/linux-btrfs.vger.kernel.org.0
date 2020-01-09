Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3952F135793
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2020 12:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730506AbgAILCP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jan 2020 06:02:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:37320 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728635AbgAILCO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Jan 2020 06:02:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 180A76A2F2;
        Thu,  9 Jan 2020 11:02:12 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     jth@kernel.org, dsterba@suse.de,
        Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Fix UAF during concurrent mount and device scan
Date:   Thu,  9 Jan 2020 13:02:10 +0200
Message-Id: <20200109110210.30671-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Johannes' recent device close cleanup patches uncovered an UAF which was
triggered during device rescan, in device_list_add. In particular,
device_list_add was seeing a struct btrfs_device with a stale
fs_info member but valid bdev one. This caused btrfs_info_in_rcu to
crash inside btrfs_printk when the latter was dereferencing
device->fs_info. Kasan report looks like:

==================================================================
BUG: KASAN: use-after-free in device_list_add+0xf60/0x10e0 [btrfs]
BTRFS info (device dm-0): has skinny extents
Read of size 8 at addr ffff88810c70a348 by task systemd-udevd/10461

CPU: 3 PID: 10461 Comm: systemd-udevd Tainted: G        W    L    5.5.0-rc5-default #842
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
Call Trace:
 dump_stack+0x75/0xa0
 ? device_list_add+0xf60/0x10e0 [btrfs]
 print_address_description.constprop.8+0x92/0x3c2
 ? device_list_add+0xf60/0x10e0 [btrfs]
 ? device_list_add+0xf60/0x10e0 [btrfs]
 __kasan_report.cold.10+0x1a/0x3b
 ? iput+0x40/0x600
 ? device_list_add+0xf60/0x10e0 [btrfs]
 kasan_report+0xe/0x20
 device_list_add+0xf60/0x10e0 [btrfs]
 ? btrfs_alloc_device+0x680/0x680 [btrfs]
 ? blkdev_get+0x166/0x220
 ? btrfs_scan_one_device+0x38f/0x530 [btrfs]
 btrfs_scan_one_device+0x38f/0x530 [btrfs]
 ? device_list_add+0x10e0/0x10e0 [btrfs]
 ? __mutex_lock_slowpath+0x10/0x10
 ? _copy_from_user+0x70/0xa0
 btrfs_control_ioctl+0xb8/0x210 [btrfs]
 do_vfs_ioctl+0x190/0xf10
 ? may_open_dev+0xc0/0xc0
 ? ___slab_alloc+0x4af/0x4f0
 ? compat_ioctl_preallocate+0x1b0/0x1b0
 ? __fsnotify_inode_delete+0x20/0x20
 ? __kasan_slab_free+0x1da/0x270
 ? do_sys_open+0x16b/0x350
 ? kmem_cache_free+0xab/0x330
 ksys_ioctl+0x3a/0x70
 __x64_sys_ioctl+0x6f/0xb0
 do_syscall_64+0x8c/0x3a0
 ? prepare_exit_to_usermode+0x1d/0x1a0
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f3bca9caf47
RSP: 002b:00007ffd418e45b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f3bca9caf47
RDX: 00007ffd418e45d0 RSI: 0000000090009427 RDI: 0000000000000007
RBP: 00007ffd418e45d0 R08: 302d6d642f766564 R09: 0000000000000003
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000007
R13: 0000000000000000 R14: 000055c30563ab70 R15: 000055c305636870

Allocated by task 10425:
 save_stack+0x19/0x80
 __kasan_kmalloc.constprop.8+0xc1/0xd0
 kvmalloc_node+0x40/0x70
 btrfs_mount_root+0xc6/0xee0 [btrfs]
 legacy_get_tree+0xed/0x1d0
 vfs_get_tree+0x7d/0x230
 fc_mount+0xf/0x80
 vfs_kern_mount.part.44+0x5c/0x80
 btrfs_mount+0x220/0x1310 [btrfs]
 legacy_get_tree+0xed/0x1d0
 vfs_get_tree+0x7d/0x230
 do_mount+0xfbf/0x1560
 __x64_sys_mount+0x162/0x1b0
 do_syscall_64+0x8c/0x3a0
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 10454:
 save_stack+0x19/0x80
 __kasan_slab_free+0x1c5/0x270
 kfree+0xc9/0x2a0
 deactivate_locked_super+0x74/0xc0
 deactivate_super+0x123/0x140
 cleanup_mnt+0x204/0x450
 task_work_run+0x104/0x180
 exit_to_usermode_loop+0xfa/0x120
 do_syscall_64+0x2d7/0x3a0
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Memory state around the buggy address:
 ffff88810c70a200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88810c70a280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88810c70a300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                              ^
 ffff88810c70a380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88810c70a400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

Instrumenting the code proved the theory:

mount-1231  [002] ....    46.498558: btrfs_init_devices_late: Updating fs_info for ffff888114e14400: old = 0000000000000000 new=ffff888110f2a000
umount-1271  [001] ....    46.562981: close_fs_devices.part.34: set bdev to NULL for ffff888114e14400 (STALE FS_DEVICES), fs_info= ffff888110f2a000
umount-1271  [001] ....    46.563317: btrfs_kill_super: Freeing fs_info: ffff888110f2a000
mount-1280  [001] ....    46.586577: open_fs_devices: Setting valid bdev to ffff888114e14400 (fs_info = ffff888110f2a000
systemd-udevd-1282  [003] ....    46.595672: device_list_add: found device with bdev: ffff888114e14400 fs_info: ffff888110f2a000
systemd-udevd-1282  [003] ....    46.603702: device_list_add: device: dm-0
systemd-udevd-1282  [003] ....    46.611201: device_list_add: found device with bdev: ffff888114e14400 fs_info: ffff888110f2a000
systemd-udevd-1282  [003] ....    46.611204: device_list_add: device: dm-0
systemd-udevd-1287  [003] .N..    46.646134: device_list_add: found device with bdev: ffff888114e14400 fs_info: ffff888110f2a000
systemd-udevd-1287  [003] .N..    46.646138: device_list_add: device: dm-0
systemd-udevd-1287  [003] ....    46.653470: device_list_add: found device with bdev: ffff888114e14400 fs_info: ffff888110f2a000
systemd-udevd-1287  [003] ....    46.653473: device_list_add: device: dm-0
mount-1280  [001] ....    46.696126: btrfs_init_devices_late: Updating fs_info for ffff888114e14400: old = ffff888110f2a000 new=ffff888111662000

This log shows how an fs  is being unmounted which causes device close
routine to be invoked. It sets bdev to NULL but doesn't reset fs_info.
Afterwards the fs_info itself is freed from btrfs_kill_super at the same
time the device is still anchored at fs_devices list. Subsequently a
mount is triggered which sets btrfs_fs_device::bdev to a valid value, yet
btrfs_fs_device::fs_info is still stale/freed. Before btrfs_fill_super
is called and re-initializes btrfs_fs_device::fs_info a concurrent device
scan is triggered, it finds the device with its ->bdev pointer set to
valid value and eventually calls btrfs_info_in_rcu in device_list_add
which causes the crash.

Simply setting btrfs_fs_device::fs_info to NULL prevents the crash but
doesn't fix the race. In fact the race cannot be solved because device
scan is asynchronous in its nature so it makes no sense to try and
synchronize it with pending mounts.

Fixes: cc1824fcd334 ("btrfs: reset device back to allocation state when removing")
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---

With this fix I can no longer get generic/085 to crash/generate the KASAN warning,
even with  an mdelay added in btrfs_mount_root which triggered the issue reliably.

 fs/btrfs/volumes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 65e78e59d5c4..ad8944cc4dd1 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1086,6 +1086,7 @@ static void btrfs_close_one_device(struct btrfs_device *device)

 	atomic_set(&device->dev_stats_ccnt, 0);
 	extent_io_tree_release(&device->alloc_state);
+	device->fs_info = NULL;

 	/* Verify the device is back in a pristine state  */
 	ASSERT(!test_bit(BTRFS_DEV_STATE_FLUSH_SENT, &device->dev_state));
--
2.17.1

