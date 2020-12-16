Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED1E2DC76E
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 20:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgLPT4p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 14:56:45 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:48826 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbgLPT4p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 14:56:45 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 24F058FD3FB; Wed, 16 Dec 2020 14:56:04 -0500 (EST)
Date:   Wed, 16 Dec 2020 14:56:03 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v7 00/38] Cleanup error handling in relocation
Message-ID: <20201216195603.GP31381@hungrycats.org>
References: <cover.1608135849.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1608135849.git.josef@toxicpanda.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 16, 2020 at 11:26:16AM -0500, Josef Bacik wrote:
> v6->v7:
> - Broke up the series into 3 series, 1 for cosmetic things, 1 for all the major
>   issues (including those reported on v6 of this set), and this new set which is
>   solely the error handling related patches for relocation.  It's still a lot of
>   patches, sorry about that.

So far it lockdepped, but it is still running:

	[Wed Dec 16 13:30:45 2020] irq event stamp: 5875656

	[Wed Dec 16 13:30:45 2020] ======================================================
	[Wed Dec 16 13:30:45 2020] hardirqs last  enabled at (5875655): [<ffffffff98a82e37>] _raw_spin_unlock_irqrestore+0x47/0x50
	[Wed Dec 16 13:30:45 2020] WARNING: possible circular locking dependency detected
	[Wed Dec 16 13:30:45 2020] hardirqs last disabled at (5875656): [<ffffffff98a8368d>] _raw_spin_lock_irqsave+0x7d/0xa0
	[Wed Dec 16 13:30:45 2020] softirqs last  enabled at (5874382): [<ffffffff98e0044f>] __do_softirq+0x44f/0x5a7
	[Wed Dec 16 13:30:45 2020] 5.10.0-39fbe74d1bbc-josef+ #1 Tainted: G        W        
	[Wed Dec 16 13:30:45 2020] softirqs last disabled at (5874369): [<ffffffff98c01122>] asm_call_irq_on_stack+0x12/0x20
	[Wed Dec 16 13:30:45 2020] ------------------------------------------------------
	[Wed Dec 16 13:30:45 2020] btrfs/6366 is trying to acquire lock:
	[Wed Dec 16 13:30:45 2020] ffff88816f146a28 (btrfs-treloc-03){+.+.}-{3:3}, at: __btrfs_tree_lock+0x29/0x190
	[Wed Dec 16 13:30:45 2020]
				   but task is already holding lock:
	[Wed Dec 16 13:30:45 2020] ffff88810167c598 (btrfs-tree-02){++++}-{3:3}, at: __btrfs_tree_lock+0x29/0x190
	[Wed Dec 16 13:30:45 2020]
				   which lock already depends on the new lock.

	[Wed Dec 16 13:30:45 2020]
				   the existing dependency chain (in reverse order) is:
	[Wed Dec 16 13:30:45 2020]
				   -> #1 (btrfs-tree-02){++++}-{3:3}:
	[Wed Dec 16 13:30:45 2020]        down_write_nested+0xa6/0x2d0
	[Wed Dec 16 13:30:45 2020]        __btrfs_tree_lock+0x29/0x190
	[Wed Dec 16 13:30:45 2020]        btrfs_tree_lock+0x10/0x20
	[Wed Dec 16 13:30:45 2020]        btrfs_search_slot+0x474/0x1090
	[Wed Dec 16 13:30:45 2020]        do_relocation+0x2a0/0xc20
	[Wed Dec 16 13:30:45 2020]        relocate_tree_blocks+0x733/0xb90
	[Wed Dec 16 13:30:45 2020]        relocate_block_group+0x2eb/0x780
	[Wed Dec 16 13:30:45 2020]        btrfs_relocate_block_group+0x26e/0x4c0
	[Wed Dec 16 13:30:45 2020]        btrfs_relocate_chunk+0x52/0x120
	[Wed Dec 16 13:30:45 2020]        btrfs_balance+0xe2e/0x1900
	[Wed Dec 16 13:30:45 2020]        btrfs_ioctl_balance+0x1f9/0x460
	[Wed Dec 16 13:30:45 2020]        btrfs_ioctl+0xe9c/0x4360
	[Wed Dec 16 13:30:45 2020]        __x64_sys_ioctl+0xc3/0x100
	[Wed Dec 16 13:30:45 2020]        do_syscall_64+0x37/0x80
	[Wed Dec 16 13:30:45 2020]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
	[Wed Dec 16 13:30:45 2020]
				   -> #0 (btrfs-treloc-03){+.+.}-{3:3}:
	[Wed Dec 16 13:30:45 2020]        __lock_acquire+0x1ebb/0x2880
	[Wed Dec 16 13:30:45 2020]        lock_acquire+0x192/0x550
	[Wed Dec 16 13:30:45 2020]        down_write_nested+0xa6/0x2d0
	[Wed Dec 16 13:30:45 2020]        __btrfs_tree_lock+0x29/0x190
	[Wed Dec 16 13:30:45 2020]        btrfs_lock_root_node+0x5b/0x190
	[Wed Dec 16 13:30:45 2020]        btrfs_search_slot+0xc8d/0x1090
	[Wed Dec 16 13:30:45 2020]        replace_path.isra.36+0x8a2/0xee0
	[Wed Dec 16 13:30:45 2020]        merge_reloc_root+0x58c/0xc10
	[Wed Dec 16 13:30:45 2020]        merge_reloc_roots+0x1e6/0x4a0
	[Wed Dec 16 13:30:45 2020]        relocate_block_group+0x3d2/0x780
	[Wed Dec 16 13:30:45 2020]        btrfs_relocate_block_group+0x26e/0x4c0
	[Wed Dec 16 13:30:45 2020]        btrfs_relocate_chunk+0x52/0x120
	[Wed Dec 16 13:30:45 2020]        btrfs_balance+0xe2e/0x1900
	[Wed Dec 16 13:30:45 2020]        btrfs_ioctl_balance+0x1f9/0x460
	[Wed Dec 16 13:30:45 2020]        btrfs_ioctl+0xe9c/0x4360
	[Wed Dec 16 13:30:45 2020]        __x64_sys_ioctl+0xc3/0x100
	[Wed Dec 16 13:30:45 2020]        do_syscall_64+0x37/0x80
	[Wed Dec 16 13:30:45 2020]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
	[Wed Dec 16 13:30:45 2020]
				   other info that might help us debug this:

	[Wed Dec 16 13:30:45 2020]  Possible unsafe locking scenario:

	[Wed Dec 16 13:30:45 2020]        CPU0                    CPU1
	[Wed Dec 16 13:30:45 2020]        ----                    ----
	[Wed Dec 16 13:30:45 2020]   lock(btrfs-tree-02);
	[Wed Dec 16 13:30:45 2020]                                lock(btrfs-treloc-03);
	[Wed Dec 16 13:30:45 2020]                                lock(btrfs-tree-02);
	[Wed Dec 16 13:30:45 2020]   lock(btrfs-treloc-03);
	[Wed Dec 16 13:30:45 2020]
				    *** DEADLOCK ***

	[Wed Dec 16 13:30:45 2020] 5 locks held by btrfs/6366:
	[Wed Dec 16 13:30:45 2020]  #0: ffff888128318498 (sb_writers#13){.+.+}-{0:0}, at: btrfs_ioctl_balance+0x71/0x460
	[Wed Dec 16 13:30:45 2020]  #1: ffff88810d2f22c8 (&fs_info->delete_unused_bgs_mutex){+.+.}-{3:3}, at: btrfs_balance+0xa54/0x1900
	[Wed Dec 16 13:30:45 2020]  #2: ffff88810d2f08f0 (&fs_info->cleaner_mutex){+.+.}-{3:3}, at: btrfs_relocate_block_group+0x266/0x4c0
	[Wed Dec 16 13:30:45 2020]  #3: ffff8881283186b8 (sb_internal#2){.+.+}-{0:0}, at: btrfs_start_transaction+0x1e/0x20
	[Wed Dec 16 13:30:45 2020]  #4: ffff88810167c598 (btrfs-tree-02){++++}-{3:3}, at: __btrfs_tree_lock+0x29/0x190
	[Wed Dec 16 13:30:45 2020]
				   stack backtrace:
	[Wed Dec 16 13:30:45 2020] CPU: 0 PID: 6366 Comm: btrfs Tainted: G        W         5.10.0-39fbe74d1bbc-josef+ #1
	[Wed Dec 16 13:30:45 2020] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
	[Wed Dec 16 13:30:45 2020] Call Trace:
	[Wed Dec 16 13:30:45 2020]  dump_stack+0xbc/0xf9
	[Wed Dec 16 13:30:45 2020]  print_circular_bug.isra.42.cold.67+0x146/0x14b
	[Wed Dec 16 13:30:45 2020]  check_noncircular+0x219/0x250
	[Wed Dec 16 13:30:45 2020]  ? print_circular_bug.isra.42+0x230/0x230
	[Wed Dec 16 13:30:45 2020]  ? pvclock_clocksource_read+0xeb/0x190
	[Wed Dec 16 13:30:45 2020]  ? __kasan_check_write+0x14/0x20
	[Wed Dec 16 13:30:45 2020]  ? lockdep_lock+0xaa/0x160
	[Wed Dec 16 13:30:45 2020]  __lock_acquire+0x1ebb/0x2880
	[Wed Dec 16 13:30:45 2020]  ? register_lock_class+0x8f0/0x8f0
	[Wed Dec 16 13:30:45 2020]  ? rcu_read_lock_sched_held+0xa1/0xd0
	[Wed Dec 16 13:30:45 2020]  ? rcu_read_lock_bh_held+0xb0/0xb0
	[Wed Dec 16 13:30:45 2020]  lock_acquire+0x192/0x550
	[Wed Dec 16 13:30:45 2020]  ? __btrfs_tree_lock+0x29/0x190
	[Wed Dec 16 13:30:45 2020]  ? check_flags+0x30/0x30
	[Wed Dec 16 13:30:45 2020]  ? ___might_sleep+0x10f/0x1e0
	[Wed Dec 16 13:30:46 2020]  ? __might_sleep+0x71/0xe0
	[Wed Dec 16 13:30:46 2020]  down_write_nested+0xa6/0x2d0
	[Wed Dec 16 13:30:46 2020]  ? __btrfs_tree_lock+0x29/0x190
	[Wed Dec 16 13:30:46 2020]  ? btrfs_root_node+0x23/0x200
	[Wed Dec 16 13:30:46 2020]  ? _down_write_nest_lock+0x2c0/0x2c0
	[Wed Dec 16 13:30:46 2020]  ? rcu_read_lock_sched_held+0xd0/0xd0
	[Wed Dec 16 13:30:46 2020]  __btrfs_tree_lock+0x29/0x190
	[Wed Dec 16 13:30:46 2020]  btrfs_lock_root_node+0x5b/0x190
	[Wed Dec 16 13:30:46 2020]  btrfs_search_slot+0xc8d/0x1090
	[Wed Dec 16 13:30:46 2020]  ? __kasan_check_read+0x11/0x20
	[Wed Dec 16 13:30:46 2020]  ? check_flags.part.50+0x6c/0x1e0
	[Wed Dec 16 13:30:46 2020]  ? split_leaf+0xa20/0xa20
	[Wed Dec 16 13:30:46 2020]  ? _raw_spin_unlock+0x22/0x30
	[Wed Dec 16 13:30:46 2020]  ? release_extent_buffer+0x225/0x280
	[Wed Dec 16 13:30:46 2020]  ? __kasan_check_write+0x14/0x20
	[Wed Dec 16 13:30:46 2020]  ? free_extent_buffer.part.53+0x90/0x140
	[Wed Dec 16 13:30:46 2020]  ? free_extent_buffer+0x13/0x20
	[Wed Dec 16 13:30:46 2020]  replace_path.isra.36+0x8a2/0xee0
	[Wed Dec 16 13:30:46 2020]  ? describe_relocation.isra.30+0xf0/0xf0
	[Wed Dec 16 13:30:46 2020]  ? check_setget_bounds+0x2a/0x60
	[Wed Dec 16 13:30:46 2020]  ? btrfs_get_64+0x1e8/0x200
	[Wed Dec 16 13:30:46 2020]  ? btrfs_get_token_64+0x350/0x350
	[Wed Dec 16 13:30:46 2020]  ? memcpy+0x4d/0x60
	[Wed Dec 16 13:30:46 2020]  merge_reloc_root+0x58c/0xc10
	[Wed Dec 16 13:30:46 2020]  ? prepare_to_merge+0x660/0x660
	[Wed Dec 16 13:30:46 2020]  ? btrfs_lookup_fs_root+0x113/0x180
	[Wed Dec 16 13:30:46 2020]  ? btrfs_end_super_write+0x3c0/0x3c0
	[Wed Dec 16 13:30:46 2020]  ? mutex_lock_io_nested+0xc20/0xc20
	[Wed Dec 16 13:30:46 2020]  ? btrfs_get_root_ref+0x24a/0x470
	[Wed Dec 16 13:30:46 2020]  ? __mutex_unlock_slowpath+0xb2/0x400
	[Wed Dec 16 13:30:46 2020]  ? btrfs_find_highest_objectid+0x1b0/0x1b0
	[Wed Dec 16 13:30:46 2020]  ? btrfs_init_reloc_root+0x370/0x370
	[Wed Dec 16 13:30:46 2020]  ? __kasan_check_write+0x14/0x20
	[Wed Dec 16 13:30:46 2020]  merge_reloc_roots+0x1e6/0x4a0
	[Wed Dec 16 13:30:46 2020]  ? merge_reloc_root+0xc10/0xc10
	[Wed Dec 16 13:30:46 2020]  ? btrfs_block_rsv_release+0x3a7/0x620
	[Wed Dec 16 13:30:46 2020]  relocate_block_group+0x3d2/0x780
	[Wed Dec 16 13:30:46 2020]  ? btrfs_defrag_leaves+0x250/0x650
	[Wed Dec 16 13:30:46 2020]  ? merge_reloc_roots+0x4a0/0x4a0
	[Wed Dec 16 13:30:46 2020]  btrfs_relocate_block_group+0x26e/0x4c0
	[Wed Dec 16 13:30:46 2020]  btrfs_relocate_chunk+0x52/0x120
	[Wed Dec 16 13:30:46 2020]  btrfs_balance+0xe2e/0x1900
	[Wed Dec 16 13:30:46 2020]  ? pvclock_clocksource_read+0xeb/0x190
	[Wed Dec 16 13:30:46 2020]  ? btrfs_relocate_chunk+0x120/0x120
	[Wed Dec 16 13:30:46 2020]  ? lock_acquired+0x7f/0x5e0
	[Wed Dec 16 13:30:46 2020]  ? do_raw_spin_lock+0x1e0/0x1e0
	[Wed Dec 16 13:30:46 2020]  ? do_raw_spin_unlock+0xa8/0x140
	[Wed Dec 16 13:30:46 2020]  btrfs_ioctl_balance+0x1f9/0x460
	[Wed Dec 16 13:30:46 2020]  btrfs_ioctl+0xe9c/0x4360
	[Wed Dec 16 13:30:46 2020]  ? __kasan_check_read+0x11/0x20
	[Wed Dec 16 13:30:46 2020]  ? check_chain_key+0x1f4/0x2f0
	[Wed Dec 16 13:30:46 2020]  ? __asan_loadN+0xf/0x20
	[Wed Dec 16 13:30:46 2020]  ? btrfs_ioctl_get_supported_features+0x30/0x30
	[Wed Dec 16 13:30:46 2020]  ? kvm_sched_clock_read+0x18/0x30
	[Wed Dec 16 13:30:46 2020]  ? check_chain_key+0x1f4/0x2f0
	[Wed Dec 16 13:30:46 2020]  ? lock_downgrade+0x3f0/0x3f0
	[Wed Dec 16 13:30:46 2020]  ? handle_mm_fault+0xad6/0x2150
	[Wed Dec 16 13:30:46 2020]  ? do_vfs_ioctl+0xfc/0x9d0
	[Wed Dec 16 13:30:46 2020]  ? ioctl_file_clone+0xe0/0xe0
	[Wed Dec 16 13:30:46 2020]  ? check_flags.part.50+0x6c/0x1e0
	[Wed Dec 16 13:30:46 2020]  ? check_flags.part.50+0x6c/0x1e0
	[Wed Dec 16 13:30:46 2020]  ? check_flags+0x26/0x30
	[Wed Dec 16 13:30:46 2020]  ? lock_is_held_type+0xc3/0xf0
	[Wed Dec 16 13:30:46 2020]  ? syscall_enter_from_user_mode+0x1b/0x60
	[Wed Dec 16 13:30:46 2020]  ? do_syscall_64+0x13/0x80
	[Wed Dec 16 13:30:46 2020]  ? rcu_read_lock_sched_held+0xa1/0xd0
	[Wed Dec 16 13:30:46 2020]  ? __kasan_check_read+0x11/0x20
	[Wed Dec 16 13:30:46 2020]  ? __fget_light+0xae/0x110
	[Wed Dec 16 13:30:46 2020]  __x64_sys_ioctl+0xc3/0x100
	[Wed Dec 16 13:30:46 2020]  do_syscall_64+0x37/0x80
	[Wed Dec 16 13:30:46 2020]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
	[Wed Dec 16 13:30:46 2020] RIP: 0033:0x7f7c98b07427
	[Wed Dec 16 13:30:46 2020] Code: 00 00 90 48 8b 05 69 aa 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 aa 0c 00 f7 d8 64 89 01 48
	[Wed Dec 16 13:30:46 2020] RSP: 002b:00007fff0cb87938 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
	[Wed Dec 16 13:30:46 2020] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7c98b07427
	[Wed Dec 16 13:30:46 2020] RDX: 00007fff0cb87948 RSI: 00000000c4009420 RDI: 0000000000000003
	[Wed Dec 16 13:30:46 2020] RBP: 0000000000000003 R08: 0000000000000003 R09: 0000000000000078
	[Wed Dec 16 13:30:46 2020] R10: fffffffffffff59d R11: 0000000000000202 R12: 0000000000000002
	[Wed Dec 16 13:30:46 2020] R13: 00007fff0cb89a3f R14: 0000557c21f8c119 R15: 0000000000000000
	[Wed Dec 16 13:31:03 2020] BTRFS info (device dm-0): found 2 extents, loops 2, stage: update data pointers
	[Wed Dec 16 13:31:59 2020] BTRFS info (device dm-0): relocating block group 981598208000 flags data
