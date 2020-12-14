Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9182D9625
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Dec 2020 11:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbgLNKLl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Dec 2020 05:11:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:33406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbgLNKLg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Dec 2020 05:11:36 -0500
From:   fdmanana@kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/5] btrfs: fix transaction leak and crash after cleaning up orphans on RO mount
Date:   Mon, 14 Dec 2020 10:10:46 +0000
Message-Id: <d18713e258daa60e986e6ee7c22b4479e0d396c4.1607940240.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1607940240.git.fdmanana@suse.com>
References: <cover.1607940240.git.fdmanana@suse.com>
In-Reply-To: <cover.1607940240.git.fdmanana@suse.com>
References: <cover.1607940240.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When we delete a root (subvolume or snapshot), at the very end of the
operation, we attempt to remove the root's orphan item from the root tree,
at btrfs_drop_snapshot(), by calling btrfs_del_orphan_item(). We ignore any
error from btrfs_del_orphan_item() since it is not a serious problem and
the next time the filesystem is mounted we remove such stray orphan items
at btrfs_find_orphan_roots().

However if the filesystem is mounted RO and we have stray orphan items for
any previously deleted root, we can end up leaking a transaction and other
data structures when unmounting the filesystem, as well as crashing if we
do not have hardware acceleration for crc32c available.

The steps that lead to the transaction leak are the following:

1) The filesystem is mounted in RW mode;

2) A subvolume is deleted;

3) When the cleaner kthread runs btrfs_drop_snapshot() to delete the root,
   it gets a failure at btrfs_del_orphan_item(), which is ignored, due to
   a -ENOMEM when allocating a path for example. So the orphan item for
   the root remains in the root tree;

4) The filesystem is unmounted;

5) The filesystem is mounted RO (-o ro). During the mount path we call
   btrfs_find_orphan_roots(), which iterates the root tree searching for
   orphan items. It finds the orphan item for our deleted root, and since
   it can not find the root, it starts a transaction to delete the orphan
   item (by calling btrfs_del_orphan_item());

6) The RO mount completes;

7) Before the transaction kthread commits the transaction created for
   deleting the orphan item (i.e. less than 30 seconds elapsed since the
   mount, the default commit interval), a filesystem unmount operation is
   started;

8) At close_ctree(), we stop the transaction kthread, but we still have a
   transaction open with at least one dirty extent buffer, a leaf for the
   tree root which was COWed when deleting the orphan item;

9) We then proceed to destroy the work queues, free the roots and block
   groups, etc. After that we drop the last reference on the btree inode by
   calling iput() on it. Since there are dirty pages for the btree inode,
   corresponding to the COWed extent buffer, btree_write_cache_pages() is
   invoked to flush those dirty pages. This results in creating a bio and
   submitting it, which makes us end up at btrfs_submit_metadata_bio();

10) At btrfs_submit_metadata_bio() we end up at the if-then-else branch
    that calls btrfs_wq_submit_bio(), because check_async_write() returned
    a value of 1. This value of 1 is because we did not have hardware
    acceleration available for crc32c, so BTRFS_FS_CSUM_IMPL_FAST was not
    set in fs_info->flags;

11) Then at btrfs_wq_submit_bio() we call btrfs_queue_work() against the
    workqueue at fs_info->workers, which was already freed before by the
    call to btrfs_stop_all_workers() at close_ctree(). This results in an
    invalid memory access due to a use-after-free, leading to a crash.

When this happens, before the crash there are several warnings triggered,
since we have reserved metadata space in a block group, the delayed refs
reservation, etc:

 ------------[ cut here ]------------
 WARNING: CPU: 4 PID: 1729896 at fs/btrfs/block-group.c:125 btrfs_put_block_group+0x63/0xa0 [btrfs]
 Modules linked in: btrfs dm_snapshot dm_thin_pool (...)
 CPU: 4 PID: 1729896 Comm: umount Tainted: G    B   W         5.10.0-rc4-btrfs-next-73 #1
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 RIP: 0010:btrfs_put_block_group+0x63/0xa0 [btrfs]
 Code: f0 01 00 00 48 39 c2 75 (...)
 RSP: 0018:ffffb270826bbdd8 EFLAGS: 00010206
 RAX: 0000000000000001 RBX: ffff947ed73e4000 RCX: ffff947ebc8b29c8
 RDX: 0000000000000001 RSI: ffffffffc0b150a0 RDI: ffff947ebc8b2800
 RBP: ffff947ebc8b2800 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000001 R12: ffff947ed73e4110
 R13: ffff947ed73e4160 R14: ffff947ebc8b2988 R15: dead000000000100
 FS:  00007f15edfea840(0000) GS:ffff9481ad600000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f37e2893320 CR3: 0000000138f68001 CR4: 00000000003706e0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  btrfs_free_block_groups+0x17f/0x2f0 [btrfs]
  close_ctree+0x2ba/0x2fa [btrfs]
  generic_shutdown_super+0x6c/0x100
  kill_anon_super+0x14/0x30
  btrfs_kill_super+0x12/0x20 [btrfs]
  deactivate_locked_super+0x31/0x70
  cleanup_mnt+0x100/0x160
  task_work_run+0x68/0xb0
  exit_to_user_mode_prepare+0x1bb/0x1c0
  syscall_exit_to_user_mode+0x4b/0x260
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
 RIP: 0033:0x7f15ee221ee7
 Code: ff 0b 00 f7 d8 64 89 01 48 (...)
 RSP: 002b:00007ffe9470f0f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
 RAX: 0000000000000000 RBX: 00007f15ee347264 RCX: 00007f15ee221ee7
 RDX: ffffffffffffff78 RSI: 0000000000000000 RDI: 000056169701d000
 RBP: 0000561697018a30 R08: 0000000000000000 R09: 00007f15ee2e2be0
 R10: 000056169701efe0 R11: 0000000000000246 R12: 0000000000000000
 R13: 000056169701d000 R14: 0000561697018b40 R15: 0000561697018c60
 irq event stamp: 0
 hardirqs last  enabled at (0): [<0000000000000000>] 0x0
 hardirqs last disabled at (0): [<ffffffff8bcae560>] copy_process+0x8a0/0x1d70
 softirqs last  enabled at (0): [<ffffffff8bcae560>] copy_process+0x8a0/0x1d70
 softirqs last disabled at (0): [<0000000000000000>] 0x0
 ---[ end trace dd74718fef1ed5c6 ]---
 ------------[ cut here ]------------
 WARNING: CPU: 2 PID: 1729896 at fs/btrfs/block-rsv.c:459 btrfs_release_global_block_rsv+0x70/0xc0 [btrfs]
 Modules linked in: btrfs dm_snapshot dm_thin_pool (...)
 CPU: 2 PID: 1729896 Comm: umount Tainted: G    B   W         5.10.0-rc4-btrfs-next-73 #1
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 RIP: 0010:btrfs_release_global_block_rsv+0x70/0xc0 [btrfs]
 Code: 48 83 bb b0 03 00 00 00 (...)
 RSP: 0018:ffffb270826bbdd8 EFLAGS: 00010206
 RAX: 000000000033c000 RBX: ffff947ed73e4000 RCX: 0000000000000000
 RDX: 0000000000000001 RSI: ffffffffc0b0d8c1 RDI: 00000000ffffffff
 RBP: ffff947ebc8b7000 R08: 0000000000000001 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000001 R12: ffff947ed73e4110
 R13: ffff947ed73e5278 R14: dead000000000122 R15: dead000000000100
 FS:  00007f15edfea840(0000) GS:ffff9481aca00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000561a79f76e20 CR3: 0000000138f68006 CR4: 00000000003706e0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  btrfs_free_block_groups+0x24c/0x2f0 [btrfs]
  close_ctree+0x2ba/0x2fa [btrfs]
  generic_shutdown_super+0x6c/0x100
  kill_anon_super+0x14/0x30
  btrfs_kill_super+0x12/0x20 [btrfs]
  deactivate_locked_super+0x31/0x70
  cleanup_mnt+0x100/0x160
  task_work_run+0x68/0xb0
  exit_to_user_mode_prepare+0x1bb/0x1c0
  syscall_exit_to_user_mode+0x4b/0x260
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
 RIP: 0033:0x7f15ee221ee7
 Code: ff 0b 00 f7 d8 64 89 01 (...)
 RSP: 002b:00007ffe9470f0f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
 RAX: 0000000000000000 RBX: 00007f15ee347264 RCX: 00007f15ee221ee7
 RDX: ffffffffffffff78 RSI: 0000000000000000 RDI: 000056169701d000
 RBP: 0000561697018a30 R08: 0000000000000000 R09: 00007f15ee2e2be0
 R10: 000056169701efe0 R11: 0000000000000246 R12: 0000000000000000
 R13: 000056169701d000 R14: 0000561697018b40 R15: 0000561697018c60
 irq event stamp: 0
 hardirqs last  enabled at (0): [<0000000000000000>] 0x0
 hardirqs last disabled at (0): [<ffffffff8bcae560>] copy_process+0x8a0/0x1d70
 softirqs last  enabled at (0): [<ffffffff8bcae560>] copy_process+0x8a0/0x1d70
 softirqs last disabled at (0): [<0000000000000000>] 0x0
 ---[ end trace dd74718fef1ed5c7 ]---
 ------------[ cut here ]------------
 WARNING: CPU: 2 PID: 1729896 at fs/btrfs/block-group.c:3377 btrfs_free_block_groups+0x25d/0x2f0 [btrfs]
 Modules linked in: btrfs dm_snapshot dm_thin_pool (...)
 CPU: 5 PID: 1729896 Comm: umount Tainted: G    B   W         5.10.0-rc4-btrfs-next-73 #1
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 RIP: 0010:btrfs_free_block_groups+0x25d/0x2f0 [btrfs]
 Code: ad de 49 be 22 01 00 (...)
 RSP: 0018:ffffb270826bbde8 EFLAGS: 00010206
 RAX: ffff947ebeae1d08 RBX: ffff947ed73e4000 RCX: 0000000000000000
 RDX: 0000000000000001 RSI: ffff947e9d823ae8 RDI: 0000000000000246
 RBP: ffff947ebeae1d08 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000001 R12: ffff947ebeae1c00
 R13: ffff947ed73e5278 R14: dead000000000122 R15: dead000000000100
 FS:  00007f15edfea840(0000) GS:ffff9481ad200000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f1475d98ea8 CR3: 0000000138f68005 CR4: 00000000003706e0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  close_ctree+0x2ba/0x2fa [btrfs]
  generic_shutdown_super+0x6c/0x100
  kill_anon_super+0x14/0x30
  btrfs_kill_super+0x12/0x20 [btrfs]
  deactivate_locked_super+0x31/0x70
  cleanup_mnt+0x100/0x160
  task_work_run+0x68/0xb0
  exit_to_user_mode_prepare+0x1bb/0x1c0
  syscall_exit_to_user_mode+0x4b/0x260
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
 RIP: 0033:0x7f15ee221ee7
 Code: ff 0b 00 f7 d8 64 89 (...)
 RSP: 002b:00007ffe9470f0f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
 RAX: 0000000000000000 RBX: 00007f15ee347264 RCX: 00007f15ee221ee7
 RDX: ffffffffffffff78 RSI: 0000000000000000 RDI: 000056169701d000
 RBP: 0000561697018a30 R08: 0000000000000000 R09: 00007f15ee2e2be0
 R10: 000056169701efe0 R11: 0000000000000246 R12: 0000000000000000
 R13: 000056169701d000 R14: 0000561697018b40 R15: 0000561697018c60
 irq event stamp: 0
 hardirqs last  enabled at (0): [<0000000000000000>] 0x0
 hardirqs last disabled at (0): [<ffffffff8bcae560>] copy_process+0x8a0/0x1d70
 softirqs last  enabled at (0): [<ffffffff8bcae560>] copy_process+0x8a0/0x1d70
 softirqs last disabled at (0): [<0000000000000000>] 0x0
 ---[ end trace dd74718fef1ed5c8 ]---
 BTRFS info (device sdc): space_info 4 has 268238848 free, is not full
 BTRFS info (device sdc): space_info total=268435456, used=114688, pinned=0, reserved=16384, may_use=0, readonly=65536
 BTRFS info (device sdc): global_block_rsv: size 0 reserved 0
 BTRFS info (device sdc): trans_block_rsv: size 0 reserved 0
 BTRFS info (device sdc): chunk_block_rsv: size 0 reserved 0
 BTRFS info (device sdc): delayed_block_rsv: size 0 reserved 0
 BTRFS info (device sdc): delayed_refs_rsv: size 524288 reserved 0

And the crash, which only happens when we do not have crc32c hardware
acceleration, produces the following trace immediately after those
warnings:

 stack segment: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC PTI
 CPU: 2 PID: 1749129 Comm: umount Tainted: G    B   W         5.10.0-rc4-btrfs-next-73 #1
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 RIP: 0010:btrfs_queue_work+0x36/0x190 [btrfs]
 Code: 54 55 53 48 89 f3 (...)
 RSP: 0018:ffffb27082443ae8 EFLAGS: 00010282
 RAX: 0000000000000004 RBX: ffff94810ee9ad90 RCX: 0000000000000000
 RDX: 0000000000000001 RSI: ffff94810ee9ad90 RDI: ffff947ed8ee75a0
 RBP: a56b6b6b6b6b6b6b R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000007 R11: 0000000000000001 R12: ffff947fa9b435a8
 R13: ffff94810ee9ad90 R14: 0000000000000000 R15: ffff947e93dc0000
 FS:  00007f3cfe974840(0000) GS:ffff9481ac600000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f1b42995a70 CR3: 0000000127638003 CR4: 00000000003706e0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  btrfs_wq_submit_bio+0xb3/0xd0 [btrfs]
  btrfs_submit_metadata_bio+0x44/0xc0 [btrfs]
  submit_one_bio+0x61/0x70 [btrfs]
  btree_write_cache_pages+0x414/0x450 [btrfs]
  ? kobject_put+0x9a/0x1d0
  ? trace_hardirqs_on+0x1b/0xf0
  ? _raw_spin_unlock_irqrestore+0x3c/0x60
  ? free_debug_processing+0x1e1/0x2b0
  do_writepages+0x43/0xe0
  ? lock_acquired+0x199/0x490
  __writeback_single_inode+0x59/0x650
  writeback_single_inode+0xaf/0x120
  write_inode_now+0x94/0xd0
  iput+0x187/0x2b0
  close_ctree+0x2c6/0x2fa [btrfs]
  generic_shutdown_super+0x6c/0x100
  kill_anon_super+0x14/0x30
  btrfs_kill_super+0x12/0x20 [btrfs]
  deactivate_locked_super+0x31/0x70
  cleanup_mnt+0x100/0x160
  task_work_run+0x68/0xb0
  exit_to_user_mode_prepare+0x1bb/0x1c0
  syscall_exit_to_user_mode+0x4b/0x260
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
 RIP: 0033:0x7f3cfebabee7
 Code: ff 0b 00 f7 d8 64 89 01 (...)
 RSP: 002b:00007ffc9c9a05f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
 RAX: 0000000000000000 RBX: 00007f3cfecd1264 RCX: 00007f3cfebabee7
 RDX: ffffffffffffff78 RSI: 0000000000000000 RDI: 0000562b6b478000
 RBP: 0000562b6b473a30 R08: 0000000000000000 R09: 00007f3cfec6cbe0
 R10: 0000562b6b479fe0 R11: 0000000000000246 R12: 0000000000000000
 R13: 0000562b6b478000 R14: 0000562b6b473b40 R15: 0000562b6b473c60
 Modules linked in: btrfs dm_snapshot dm_thin_pool (...)
 ---[ end trace dd74718fef1ed5cc ]---

Finally when we remove the btrfs module (rmmod btrfs), there are several
warnings about objects that were allocated from our slabs but were never
freed, consequence of the transaction that was never committed and got
leaked:
 =============================================================================
 BUG btrfs_delayed_ref_head (Tainted: G    B   W        ): Objects remaining in btrfs_delayed_ref_head on __kmem_cache_shutdown()
 -----------------------------------------------------------------------------

 INFO: Slab 0x0000000094c2ae56 objects=24 used=2 fp=0x000000002bfa2521 flags=0x17fffc000010200
 CPU: 5 PID: 1729921 Comm: rmmod Tainted: G    B   W         5.10.0-rc4-btrfs-next-73 #1
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 Call Trace:
  dump_stack+0x8d/0xb5
  slab_err+0xb7/0xdc
  ? lock_acquired+0x199/0x490
  __kmem_cache_shutdown+0x1ac/0x3c0
  ? lock_release+0x20e/0x4c0
  kmem_cache_destroy+0x55/0x120
  btrfs_delayed_ref_exit+0x11/0x35 [btrfs]
  exit_btrfs_fs+0xa/0x59 [btrfs]
  __x64_sys_delete_module+0x194/0x260
  ? fpregs_assert_state_consistent+0x1e/0x40
  ? exit_to_user_mode_prepare+0x55/0x1c0
  ? trace_hardirqs_on+0x1b/0xf0
  do_syscall_64+0x33/0x80
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
 RIP: 0033:0x7f693e305897
 Code: 73 01 c3 48 8b 0d f9 f5 (...)
 RSP: 002b:00007ffcf73eb508 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
 RAX: ffffffffffffffda RBX: 0000559df504f760 RCX: 00007f693e305897
 RDX: 000000000000000a RSI: 0000000000000800 RDI: 0000559df504f7c8
 RBP: 00007ffcf73eb568 R08: 0000000000000000 R09: 0000000000000000
 R10: 00007f693e378ac0 R11: 0000000000000206 R12: 00007ffcf73eb740
 R13: 00007ffcf73ec5a6 R14: 0000559df504f2a0 R15: 0000559df504f760
 INFO: Object 0x0000000050cbdd61 @offset=12104
 INFO: Allocated in btrfs_add_delayed_tree_ref+0xbb/0x480 [btrfs] age=1894 cpu=6 pid=1729873
        __slab_alloc.isra.0+0x109/0x1c0
        kmem_cache_alloc+0x7bb/0x830
        btrfs_add_delayed_tree_ref+0xbb/0x480 [btrfs]
        btrfs_free_tree_block+0x128/0x360 [btrfs]
        __btrfs_cow_block+0x489/0x5f0 [btrfs]
        btrfs_cow_block+0xf7/0x220 [btrfs]
        btrfs_search_slot+0x62a/0xc40 [btrfs]
        btrfs_del_orphan_item+0x65/0xd0 [btrfs]
        btrfs_find_orphan_roots+0x1bf/0x200 [btrfs]
        open_ctree+0x125a/0x18a0 [btrfs]
        btrfs_mount_root.cold+0x13/0xed [btrfs]
        legacy_get_tree+0x30/0x60
        vfs_get_tree+0x28/0xe0
        fc_mount+0xe/0x40
        vfs_kern_mount.part.0+0x71/0x90
        btrfs_mount+0x13b/0x3e0 [btrfs]
 INFO: Freed in __btrfs_run_delayed_refs+0x1117/0x1290 [btrfs] age=4292 cpu=2 pid=1729526
        kmem_cache_free+0x34c/0x3c0
        __btrfs_run_delayed_refs+0x1117/0x1290 [btrfs]
        btrfs_run_delayed_refs+0x81/0x210 [btrfs]
        commit_cowonly_roots+0xfb/0x300 [btrfs]
        btrfs_commit_transaction+0x367/0xc40 [btrfs]
        sync_filesystem+0x74/0x90
        generic_shutdown_super+0x22/0x100
        kill_anon_super+0x14/0x30
        btrfs_kill_super+0x12/0x20 [btrfs]
        deactivate_locked_super+0x31/0x70
        cleanup_mnt+0x100/0x160
        task_work_run+0x68/0xb0
        exit_to_user_mode_prepare+0x1bb/0x1c0
        syscall_exit_to_user_mode+0x4b/0x260
        entry_SYSCALL_64_after_hwframe+0x44/0xa9
 INFO: Object 0x0000000086e9b0ff @offset=12776
 INFO: Allocated in btrfs_add_delayed_tree_ref+0xbb/0x480 [btrfs] age=1900 cpu=6 pid=1729873
        __slab_alloc.isra.0+0x109/0x1c0
        kmem_cache_alloc+0x7bb/0x830
        btrfs_add_delayed_tree_ref+0xbb/0x480 [btrfs]
        btrfs_alloc_tree_block+0x2bf/0x360 [btrfs]
        alloc_tree_block_no_bg_flush+0x4f/0x60 [btrfs]
        __btrfs_cow_block+0x12d/0x5f0 [btrfs]
        btrfs_cow_block+0xf7/0x220 [btrfs]
        btrfs_search_slot+0x62a/0xc40 [btrfs]
        btrfs_del_orphan_item+0x65/0xd0 [btrfs]
        btrfs_find_orphan_roots+0x1bf/0x200 [btrfs]
        open_ctree+0x125a/0x18a0 [btrfs]
        btrfs_mount_root.cold+0x13/0xed [btrfs]
        legacy_get_tree+0x30/0x60
        vfs_get_tree+0x28/0xe0
        fc_mount+0xe/0x40
        vfs_kern_mount.part.0+0x71/0x90
 INFO: Freed in __btrfs_run_delayed_refs+0x1117/0x1290 [btrfs] age=3141 cpu=6 pid=1729803
        kmem_cache_free+0x34c/0x3c0
        __btrfs_run_delayed_refs+0x1117/0x1290 [btrfs]
        btrfs_run_delayed_refs+0x81/0x210 [btrfs]
        btrfs_write_dirty_block_groups+0x17d/0x3d0 [btrfs]
        commit_cowonly_roots+0x248/0x300 [btrfs]
        btrfs_commit_transaction+0x367/0xc40 [btrfs]
        close_ctree+0x113/0x2fa [btrfs]
        generic_shutdown_super+0x6c/0x100
        kill_anon_super+0x14/0x30
        btrfs_kill_super+0x12/0x20 [btrfs]
        deactivate_locked_super+0x31/0x70
        cleanup_mnt+0x100/0x160
        task_work_run+0x68/0xb0
        exit_to_user_mode_prepare+0x1bb/0x1c0
        syscall_exit_to_user_mode+0x4b/0x260
        entry_SYSCALL_64_after_hwframe+0x44/0xa9
 kmem_cache_destroy btrfs_delayed_ref_head: Slab cache still has objects
 CPU: 5 PID: 1729921 Comm: rmmod Tainted: G    B   W         5.10.0-rc4-btrfs-next-73 #1
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 Call Trace:
  dump_stack+0x8d/0xb5
  kmem_cache_destroy+0x119/0x120
  btrfs_delayed_ref_exit+0x11/0x35 [btrfs]
  exit_btrfs_fs+0xa/0x59 [btrfs]
  __x64_sys_delete_module+0x194/0x260
  ? fpregs_assert_state_consistent+0x1e/0x40
  ? exit_to_user_mode_prepare+0x55/0x1c0
  ? trace_hardirqs_on+0x1b/0xf0
  do_syscall_64+0x33/0x80
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
 RIP: 0033:0x7f693e305897
 Code: 73 01 c3 48 8b 0d f9 f5 0b (...)
 RSP: 002b:00007ffcf73eb508 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
 RAX: ffffffffffffffda RBX: 0000559df504f760 RCX: 00007f693e305897
 RDX: 000000000000000a RSI: 0000000000000800 RDI: 0000559df504f7c8
 RBP: 00007ffcf73eb568 R08: 0000000000000000 R09: 0000000000000000
 R10: 00007f693e378ac0 R11: 0000000000000206 R12: 00007ffcf73eb740
 R13: 00007ffcf73ec5a6 R14: 0000559df504f2a0 R15: 0000559df504f760
 =============================================================================
 BUG btrfs_delayed_tree_ref (Tainted: G    B   W        ): Objects remaining in btrfs_delayed_tree_ref on __kmem_cache_shutdown()
 -----------------------------------------------------------------------------

 INFO: Slab 0x0000000011f78dc0 objects=37 used=2 fp=0x0000000032d55d91 flags=0x17fffc000010200
 CPU: 3 PID: 1729921 Comm: rmmod Tainted: G    B   W         5.10.0-rc4-btrfs-next-73 #1
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 Call Trace:
  dump_stack+0x8d/0xb5
  slab_err+0xb7/0xdc
  ? lock_acquired+0x199/0x490
  __kmem_cache_shutdown+0x1ac/0x3c0
  ? lock_release+0x20e/0x4c0
  kmem_cache_destroy+0x55/0x120
  btrfs_delayed_ref_exit+0x1d/0x35 [btrfs]
  exit_btrfs_fs+0xa/0x59 [btrfs]
  __x64_sys_delete_module+0x194/0x260
  ? fpregs_assert_state_consistent+0x1e/0x40
  ? exit_to_user_mode_prepare+0x55/0x1c0
  ? trace_hardirqs_on+0x1b/0xf0
  do_syscall_64+0x33/0x80
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
 RIP: 0033:0x7f693e305897
 Code: 73 01 c3 48 8b 0d f9 f5 (...)
 RSP: 002b:00007ffcf73eb508 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
 RAX: ffffffffffffffda RBX: 0000559df504f760 RCX: 00007f693e305897
 RDX: 000000000000000a RSI: 0000000000000800 RDI: 0000559df504f7c8
 RBP: 00007ffcf73eb568 R08: 0000000000000000 R09: 0000000000000000
 R10: 00007f693e378ac0 R11: 0000000000000206 R12: 00007ffcf73eb740
 R13: 00007ffcf73ec5a6 R14: 0000559df504f2a0 R15: 0000559df504f760
 INFO: Object 0x000000001a340018 @offset=4408
 INFO: Allocated in btrfs_add_delayed_tree_ref+0x9e/0x480 [btrfs] age=1917 cpu=6 pid=1729873
        __slab_alloc.isra.0+0x109/0x1c0
        kmem_cache_alloc+0x7bb/0x830
        btrfs_add_delayed_tree_ref+0x9e/0x480 [btrfs]
        btrfs_free_tree_block+0x128/0x360 [btrfs]
        __btrfs_cow_block+0x489/0x5f0 [btrfs]
        btrfs_cow_block+0xf7/0x220 [btrfs]
        btrfs_search_slot+0x62a/0xc40 [btrfs]
        btrfs_del_orphan_item+0x65/0xd0 [btrfs]
        btrfs_find_orphan_roots+0x1bf/0x200 [btrfs]
        open_ctree+0x125a/0x18a0 [btrfs]
        btrfs_mount_root.cold+0x13/0xed [btrfs]
        legacy_get_tree+0x30/0x60
        vfs_get_tree+0x28/0xe0
        fc_mount+0xe/0x40
        vfs_kern_mount.part.0+0x71/0x90
        btrfs_mount+0x13b/0x3e0 [btrfs]
 INFO: Freed in __btrfs_run_delayed_refs+0x63d/0x1290 [btrfs] age=4167 cpu=4 pid=1729795
        kmem_cache_free+0x34c/0x3c0
        __btrfs_run_delayed_refs+0x63d/0x1290 [btrfs]
        btrfs_run_delayed_refs+0x81/0x210 [btrfs]
        btrfs_commit_transaction+0x60/0xc40 [btrfs]
        create_subvol+0x56a/0x990 [btrfs]
        btrfs_mksubvol+0x3fb/0x4a0 [btrfs]
        __btrfs_ioctl_snap_create+0x119/0x1a0 [btrfs]
        btrfs_ioctl_snap_create+0x58/0x80 [btrfs]
        btrfs_ioctl+0x1a92/0x36f0 [btrfs]
        __x64_sys_ioctl+0x83/0xb0
        do_syscall_64+0x33/0x80
        entry_SYSCALL_64_after_hwframe+0x44/0xa9
 INFO: Object 0x000000002b46292a @offset=13648
 INFO: Allocated in btrfs_add_delayed_tree_ref+0x9e/0x480 [btrfs] age=1923 cpu=6 pid=1729873
        __slab_alloc.isra.0+0x109/0x1c0
        kmem_cache_alloc+0x7bb/0x830
        btrfs_add_delayed_tree_ref+0x9e/0x480 [btrfs]
        btrfs_alloc_tree_block+0x2bf/0x360 [btrfs]
        alloc_tree_block_no_bg_flush+0x4f/0x60 [btrfs]
        __btrfs_cow_block+0x12d/0x5f0 [btrfs]
        btrfs_cow_block+0xf7/0x220 [btrfs]
        btrfs_search_slot+0x62a/0xc40 [btrfs]
        btrfs_del_orphan_item+0x65/0xd0 [btrfs]
        btrfs_find_orphan_roots+0x1bf/0x200 [btrfs]
        open_ctree+0x125a/0x18a0 [btrfs]
        btrfs_mount_root.cold+0x13/0xed [btrfs]
        legacy_get_tree+0x30/0x60
        vfs_get_tree+0x28/0xe0
        fc_mount+0xe/0x40
        vfs_kern_mount.part.0+0x71/0x90
 INFO: Freed in __btrfs_run_delayed_refs+0x63d/0x1290 [btrfs] age=3164 cpu=6 pid=1729803
        kmem_cache_free+0x34c/0x3c0
        __btrfs_run_delayed_refs+0x63d/0x1290 [btrfs]
        btrfs_run_delayed_refs+0x81/0x210 [btrfs]
        commit_cowonly_roots+0xfb/0x300 [btrfs]
        btrfs_commit_transaction+0x367/0xc40 [btrfs]
        close_ctree+0x113/0x2fa [btrfs]
        generic_shutdown_super+0x6c/0x100
        kill_anon_super+0x14/0x30
        btrfs_kill_super+0x12/0x20 [btrfs]
        deactivate_locked_super+0x31/0x70
        cleanup_mnt+0x100/0x160
        task_work_run+0x68/0xb0
        exit_to_user_mode_prepare+0x1bb/0x1c0
        syscall_exit_to_user_mode+0x4b/0x260
        entry_SYSCALL_64_after_hwframe+0x44/0xa9
 kmem_cache_destroy btrfs_delayed_tree_ref: Slab cache still has objects
 CPU: 5 PID: 1729921 Comm: rmmod Tainted: G    B   W         5.10.0-rc4-btrfs-next-73 #1
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 Call Trace:
  dump_stack+0x8d/0xb5
  kmem_cache_destroy+0x119/0x120
  btrfs_delayed_ref_exit+0x1d/0x35 [btrfs]
  exit_btrfs_fs+0xa/0x59 [btrfs]
  __x64_sys_delete_module+0x194/0x260
  ? fpregs_assert_state_consistent+0x1e/0x40
  ? exit_to_user_mode_prepare+0x55/0x1c0
  ? trace_hardirqs_on+0x1b/0xf0
  do_syscall_64+0x33/0x80
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
 RIP: 0033:0x7f693e305897
 Code: 73 01 c3 48 8b 0d f9 f5 (...)
 RSP: 002b:00007ffcf73eb508 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
 RAX: ffffffffffffffda RBX: 0000559df504f760 RCX: 00007f693e305897
 RDX: 000000000000000a RSI: 0000000000000800 RDI: 0000559df504f7c8
 RBP: 00007ffcf73eb568 R08: 0000000000000000 R09: 0000000000000000
 R10: 00007f693e378ac0 R11: 0000000000000206 R12: 00007ffcf73eb740
 R13: 00007ffcf73ec5a6 R14: 0000559df504f2a0 R15: 0000559df504f760
 =============================================================================
 BUG btrfs_delayed_extent_op (Tainted: G    B   W        ): Objects remaining in btrfs_delayed_extent_op on __kmem_cache_shutdown()
 -----------------------------------------------------------------------------

 INFO: Slab 0x00000000f145ce2f objects=22 used=1 fp=0x00000000af0f92cf flags=0x17fffc000010200
 CPU: 5 PID: 1729921 Comm: rmmod Tainted: G    B   W         5.10.0-rc4-btrfs-next-73 #1
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 Call Trace:
  dump_stack+0x8d/0xb5
  slab_err+0xb7/0xdc
  ? lock_acquired+0x199/0x490
  __kmem_cache_shutdown+0x1ac/0x3c0
  ? __mutex_unlock_slowpath+0x45/0x2a0
  kmem_cache_destroy+0x55/0x120
  exit_btrfs_fs+0xa/0x59 [btrfs]
  __x64_sys_delete_module+0x194/0x260
  ? fpregs_assert_state_consistent+0x1e/0x40
  ? exit_to_user_mode_prepare+0x55/0x1c0
  ? trace_hardirqs_on+0x1b/0xf0
  do_syscall_64+0x33/0x80
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
 RIP: 0033:0x7f693e305897
 Code: 73 01 c3 48 8b 0d f9 f5 (...)
 RSP: 002b:00007ffcf73eb508 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
 RAX: ffffffffffffffda RBX: 0000559df504f760 RCX: 00007f693e305897
 RDX: 000000000000000a RSI: 0000000000000800 RDI: 0000559df504f7c8
 RBP: 00007ffcf73eb568 R08: 0000000000000000 R09: 0000000000000000
 R10: 00007f693e378ac0 R11: 0000000000000206 R12: 00007ffcf73eb740
 R13: 00007ffcf73ec5a6 R14: 0000559df504f2a0 R15: 0000559df504f760
 INFO: Object 0x000000004cf95ea8 @offset=6264
 INFO: Allocated in btrfs_alloc_tree_block+0x1e0/0x360 [btrfs] age=1931 cpu=6 pid=1729873
        __slab_alloc.isra.0+0x109/0x1c0
        kmem_cache_alloc+0x7bb/0x830
        btrfs_alloc_tree_block+0x1e0/0x360 [btrfs]
        alloc_tree_block_no_bg_flush+0x4f/0x60 [btrfs]
        __btrfs_cow_block+0x12d/0x5f0 [btrfs]
        btrfs_cow_block+0xf7/0x220 [btrfs]
        btrfs_search_slot+0x62a/0xc40 [btrfs]
        btrfs_del_orphan_item+0x65/0xd0 [btrfs]
        btrfs_find_orphan_roots+0x1bf/0x200 [btrfs]
        open_ctree+0x125a/0x18a0 [btrfs]
        btrfs_mount_root.cold+0x13/0xed [btrfs]
        legacy_get_tree+0x30/0x60
        vfs_get_tree+0x28/0xe0
        fc_mount+0xe/0x40
        vfs_kern_mount.part.0+0x71/0x90
        btrfs_mount+0x13b/0x3e0 [btrfs]
 INFO: Freed in __btrfs_run_delayed_refs+0xabd/0x1290 [btrfs] age=3173 cpu=6 pid=1729803
        kmem_cache_free+0x34c/0x3c0
        __btrfs_run_delayed_refs+0xabd/0x1290 [btrfs]
        btrfs_run_delayed_refs+0x81/0x210 [btrfs]
        commit_cowonly_roots+0xfb/0x300 [btrfs]
        btrfs_commit_transaction+0x367/0xc40 [btrfs]
        close_ctree+0x113/0x2fa [btrfs]
        generic_shutdown_super+0x6c/0x100
        kill_anon_super+0x14/0x30
        btrfs_kill_super+0x12/0x20 [btrfs]
        deactivate_locked_super+0x31/0x70
        cleanup_mnt+0x100/0x160
        task_work_run+0x68/0xb0
        exit_to_user_mode_prepare+0x1bb/0x1c0
        syscall_exit_to_user_mode+0x4b/0x260
        entry_SYSCALL_64_after_hwframe+0x44/0xa9
 kmem_cache_destroy btrfs_delayed_extent_op: Slab cache still has objects
 CPU: 3 PID: 1729921 Comm: rmmod Tainted: G    B   W         5.10.0-rc4-btrfs-next-73 #1
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 Call Trace:
  dump_stack+0x8d/0xb5
  kmem_cache_destroy+0x119/0x120
  exit_btrfs_fs+0xa/0x59 [btrfs]
  __x64_sys_delete_module+0x194/0x260
  ? fpregs_assert_state_consistent+0x1e/0x40
  ? exit_to_user_mode_prepare+0x55/0x1c0
  ? trace_hardirqs_on+0x1b/0xf0
  do_syscall_64+0x33/0x80
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
 RIP: 0033:0x7f693e305897
 Code: 73 01 c3 48 8b 0d f9 (...)
 RSP: 002b:00007ffcf73eb508 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
 RAX: ffffffffffffffda RBX: 0000559df504f760 RCX: 00007f693e305897
 RDX: 000000000000000a RSI: 0000000000000800 RDI: 0000559df504f7c8
 RBP: 00007ffcf73eb568 R08: 0000000000000000 R09: 0000000000000000
 R10: 00007f693e378ac0 R11: 0000000000000206 R12: 00007ffcf73eb740
 R13: 00007ffcf73ec5a6 R14: 0000559df504f2a0 R15: 0000559df504f760
 BTRFS: state leak: start 30408704 end 30425087 state 1 in tree 1 refs 1

So fix this by calling btrfs_find_orphan_roots() in the mount path only if
we are mounting the filesystem in RW mode. It's pointless to have it called
for RO mounts anyway, since despite adding any deleted roots to the list of
dead roots, we will never have the roots deleted until the filesystem is
remounted in RW mode, as the cleaner kthread does nothing when we are
mounted in RO - btrfs_need_cleaner_sleep() always returns true and the
cleaner spends all time sleeping, never cleaning dead roots.

This is accomplished by moving the call to btrfs_find_orphan_roots() from
open_ctree() to btrfs_start_pre_rw_mount(), which also guarantees that
if later the filesystem is remounted RW, we populate the list of dead
roots and have the cleaner task delete the dead roots.

Tested-by: Fabian Vogt <fvogt@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 765deefda92b..e941cbae3991 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2969,6 +2969,7 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info)
 		}
 	}
 
+	ret = btrfs_find_orphan_roots(fs_info);
 out:
 	return ret;
 }
@@ -3383,10 +3384,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		}
 	}
 
-	ret = btrfs_find_orphan_roots(fs_info);
-	if (ret)
-		goto fail_qgroup;
-
 	fs_info->fs_root = btrfs_get_fs_root(fs_info, BTRFS_FS_TREE_OBJECTID, true);
 	if (IS_ERR(fs_info->fs_root)) {
 		err = PTR_ERR(fs_info->fs_root);
-- 
2.28.0

