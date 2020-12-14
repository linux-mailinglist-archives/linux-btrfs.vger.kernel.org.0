Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81DBD2D9626
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Dec 2020 11:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbgLNKLl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Dec 2020 05:11:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:33416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbgLNKLh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Dec 2020 05:11:37 -0500
From:   fdmanana@kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/5] btrfs: fix race between RO remount and the cleaner task
Date:   Mon, 14 Dec 2020 10:10:47 +0000
Message-Id: <0cdeb6930fef756b8a59dcf28bde6c8f51a4747a.1607940240.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1607940240.git.fdmanana@suse.com>
References: <cover.1607940240.git.fdmanana@suse.com>
In-Reply-To: <cover.1607940240.git.fdmanana@suse.com>
References: <cover.1607940240.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When we are remounting a filesystem in RO mode we can race with the cleaner
task and result in leaking a transaction if the filesystem is unmounted
shortly after, before the transaction kthread had a chance to commit that
transaction. That also results in a crash during unmount, due to a
use-after-free, if hardware acceleration is not available for crc32c.

The following sequence of steps explains how the race happens.

1) The filesystem is mounted in RW mode and the cleaner task is running.
   This means that currently BTRFS_FS_CLEANER_RUNNING is set at
   fs_info->flags;

2) The cleaner task is currently running delayed iputs for example;

3) A filesystem RO remount operation starts;

4) The RO remount task calls btrfs_commit_super(), which commits any
   currently open transaction, and it finishes;

5) At this point the cleaner task is still running and it creates a new
   transaction by doing one of the following things:

   * When running the delayed iput() for an inode with a 0 link count,
     in which case at btrfs_evict_inode() we start a transaction through
     the call to evict_refill_and_join(), use it and then release its
     handle through btrfs_end_transaction();

   * When deleting a dead root through btrfs_clean_one_deleted_snapshot(),
     a transaction is started at btrfs_drop_snapshot() and then its handle
     is released through a call to btrfs_end_transaction_throttle();

   * When the remount task was still running, and before the remount task
     called btrfs_delete_unused_bgs(), the cleaner task also called
     btrfs_delete_unused_bgs() and it picked and removed one block group
     from the list of unused block groups. Before the cleaner task started
     a transaction, through btrfs_start_trans_remove_block_group() at
     btrfs_delete_unused_bgs(), the remount task had already called
     btrfs_commit_super();

6) So at this point the filesystem is in RO mode and we have an open
   transaction that was started by the cleaner task;

7) Shortly after a filesystem unmount operation starts. At close_ctree()
   we stop the transaction kthread before it had a chance to commit the
   transaction, since less than 30 seconds (the default commit interval)
   have elapsed since the last transaction was committed;

8) We end up calling iput() against the btree inode at close_ctree() while
   there is an open transaction, and since that transaction was used to
   update btrees by the cleaner, we have dirty pages in the btree inode
   due to COW operations on metadata extents, and therefore writeback is
   triggered for the btree inode.

   So btree_write_cache_pages() is invoked to flush those dirty pages
   during the final iput() on the btree inode. This results in creating a
   bio and submitting it, which makes us end up at
   btrfs_submit_metadata_bio();

9) At btrfs_submit_metadata_bio() we end up at the if-then-else branch
   that calls btrfs_wq_submit_bio(), because check_async_write() returned
   a value of 1. This value of 1 is because we did not have hardware
   acceleration available for crc32c, so BTRFS_FS_CSUM_IMPL_FAST was not
   set in fs_info->flags;

10) Then at btrfs_wq_submit_bio() we call btrfs_queue_work() against the
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

So fix this by making the remount path to wait for the cleaner task before
calling btrfs_commit_super(). The remount path now waits for the bit
BTRFS_FS_CLEANER_RUNNING to be cleared from fs_info->flags before calling
btrfs_commit_super() and this ensures the cleaner can not start a
transaction after that, because it sleeps when the filesystem is in RO
mode and we have already flagged the filesystem as RO before waiting for
BTRFS_FS_CLEANER_RUNNING to be cleared.

This also introduces a new flag BTRFS_FS_STATE_RO to be used for
fs_info->fs_state when the filesystem is in RO mode. This is because we
were doing the RO check using the flags of the superblock and setting the
RO mode simply by ORing into the superblock's flags - those operations are
not atomic and could result in the cleaner not see the update from the
remount task after it clears BTRFS_FS_CLEANER_RUNNING.

Tested-by: Fabian Vogt <fvogt@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.h   | 20 +++++++++++++++++++-
 fs/btrfs/disk-io.c |  5 ++++-
 fs/btrfs/super.c   | 22 +++++++++++++++++++---
 fs/btrfs/volumes.c |  4 ++--
 4 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 3935d297d198..0225c5208f44 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -132,6 +132,8 @@ enum {
 	 * defrag
 	 */
 	BTRFS_FS_STATE_REMOUNTING,
+	/* Filesystem in RO mode */
+	BTRFS_FS_STATE_RO,
 	/* Track if a transaction abort has been reported on this filesystem */
 	BTRFS_FS_STATE_TRANS_ABORTED,
 	/*
@@ -2892,10 +2894,26 @@ static inline int btrfs_fs_closing(struct btrfs_fs_info *fs_info)
  * If we remount the fs to be R/O or umount the fs, the cleaner needn't do
  * anything except sleeping. This function is used to check the status of
  * the fs.
+ * We check for BTRFS_FS_STATE_RO to avoid races with a concurrent remount,
+ * since setting and checking for SB_RDONLY in the superblock's flags is not
+ * atomic.
  */
 static inline int btrfs_need_cleaner_sleep(struct btrfs_fs_info *fs_info)
 {
-	return fs_info->sb->s_flags & SB_RDONLY || btrfs_fs_closing(fs_info);
+	return test_bit(BTRFS_FS_STATE_RO, &fs_info->fs_state) ||
+		btrfs_fs_closing(fs_info);
+}
+
+static inline void btrfs_set_sb_rdonly(struct super_block *sb)
+{
+	sb->s_flags |= SB_RDONLY;
+	set_bit(BTRFS_FS_STATE_RO, &btrfs_sb(sb)->fs_state);
+}
+
+static inline void btrfs_clear_sb_rdonly(struct super_block *sb)
+{
+	sb->s_flags &= ~SB_RDONLY;
+	clear_bit(BTRFS_FS_STATE_RO, &btrfs_sb(sb)->fs_state);
 }
 
 /* tree mod log functions from ctree.c */
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index e941cbae3991..e7bcbd0b93ef 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1729,7 +1729,7 @@ static int cleaner_kthread(void *arg)
 		 */
 		btrfs_delete_unused_bgs(fs_info);
 sleep:
-		clear_bit(BTRFS_FS_CLEANER_RUNNING, &fs_info->flags);
+		clear_and_wake_up_bit(BTRFS_FS_CLEANER_RUNNING, &fs_info->flags);
 		if (kthread_should_park())
 			kthread_parkme();
 		if (kthread_should_stop())
@@ -2830,6 +2830,9 @@ static int init_mount_fs_info(struct btrfs_fs_info *fs_info, struct super_block
 		return -ENOMEM;
 	btrfs_init_delayed_root(fs_info->delayed_root);
 
+	if (sb_rdonly(sb))
+		set_bit(BTRFS_FS_STATE_RO, &fs_info->fs_state);
+
 	return btrfs_alloc_stripe_hash_table(fs_info);
 }
 
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index b24fa62375e0..38740cc2919f 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -175,7 +175,7 @@ void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function
 	btrfs_discard_stop(fs_info);
 
 	/* btrfs handle error by forcing the filesystem readonly */
-	sb->s_flags |= SB_RDONLY;
+	btrfs_set_sb_rdonly(sb);
 	btrfs_info(fs_info, "forced readonly");
 	/*
 	 * Note that a running device replace operation is not canceled here
@@ -1953,7 +1953,7 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 		/* avoid complains from lockdep et al. */
 		up(&fs_info->uuid_tree_rescan_sem);
 
-		sb->s_flags |= SB_RDONLY;
+		btrfs_set_sb_rdonly(sb);
 
 		/*
 		 * Setting SB_RDONLY will put the cleaner thread to
@@ -1964,6 +1964,20 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 		 */
 		btrfs_delete_unused_bgs(fs_info);
 
+		/*
+		 * The cleaner task could be already running before we set the
+		 * flag BTRFS_FS_STATE_RO (and SB_RDONLY in the superblock).
+		 * We must make sure that after we finish the remount, i.e. after
+		 * we call btrfs_commit_super(), the cleaner can no longer start
+		 * a transaction - either because it was dropping a dead root,
+		 * running delayed iputs or deleting an unused block group (the
+		 * cleaner picked a block group from the list of unused block
+		 * groups before we were able to in the previous call to
+		 * btrfs_delete_unused_bgs()).
+		 */
+		wait_on_bit(&fs_info->flags, BTRFS_FS_CLEANER_RUNNING,
+			    TASK_UNINTERRUPTIBLE);
+
 		btrfs_dev_replace_suspend_for_unmount(fs_info);
 		btrfs_scrub_cancel(fs_info);
 		btrfs_pause_balance(fs_info);
@@ -2014,7 +2028,7 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 		if (ret)
 			goto restore;
 
-		sb->s_flags &= ~SB_RDONLY;
+		btrfs_clear_sb_rdonly(sb);
 
 		set_bit(BTRFS_FS_OPEN, &fs_info->flags);
 	}
@@ -2036,6 +2050,8 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 	/* We've hit an error - don't reset SB_RDONLY */
 	if (sb_rdonly(sb))
 		old_flags |= SB_RDONLY;
+	if (!(old_flags & SB_RDONLY))
+		clear_bit(BTRFS_FS_STATE_RO, &fs_info->fs_state);
 	sb->s_flags = old_flags;
 	fs_info->mount_opt = old_opts;
 	fs_info->compress_type = old_compress_type;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 7930e1c78c45..2c0aa03b6437 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2593,7 +2593,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
 
 	if (seeding_dev) {
-		sb->s_flags &= ~SB_RDONLY;
+		btrfs_clear_sb_rdonly(sb);
 		ret = btrfs_prepare_sprout(fs_info);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
@@ -2729,7 +2729,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
 error_trans:
 	if (seeding_dev)
-		sb->s_flags |= SB_RDONLY;
+		btrfs_set_sb_rdonly(sb);
 	if (trans)
 		btrfs_end_transaction(trans);
 error_free_zone:
-- 
2.28.0

