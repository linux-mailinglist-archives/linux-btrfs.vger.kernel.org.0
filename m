Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D232B31A3
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Nov 2020 01:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgKOAiP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 14 Nov 2020 19:38:15 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:43374 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgKOAiO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 14 Nov 2020 19:38:14 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id AC3A08A7444; Sat, 14 Nov 2020 19:37:57 -0500 (EST)
Date:   Sat, 14 Nov 2020 19:37:57 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 00/42] Cleanup error handling in relocation
Message-ID: <20201115003756.GD31381@hungrycats.org>
References: <cover.1605215645.git.josef@toxicpanda.com>
 <20201113035342.GB31381@hungrycats.org>
 <1658d318-3434-3e27-bcf5-00060233f10c@toxicpanda.com>
 <20201113143925.GC31381@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20201113143925.GC31381@hungrycats.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 13, 2020 at 09:39:26AM -0500, Zygo Blaxell wrote:
> On Fri, Nov 13, 2020 at 06:03:39AM -0500, Josef Bacik wrote:
> > On 11/12/20 10:53 PM, Zygo Blaxell wrote:
> > > On Thu, Nov 12, 2020 at 04:18:27PM -0500, Josef Bacik wrote:
> > > > Hello,
> > > > 
> > > > Relocation is the last place that is not able to handle errors at all, which
> > > > results in all sorts of lovely panics if you encounter corruptions or IO errors.
> > > > I'm going to start cleaning up relocation, but before I move code around I want
> > > > the error handling to be somewhat sane, so I'm not changing behavior and error
> > > > handling at the same time.
> > > > 
> > > > These patches are purely about error handling, there is no behavior changing
> > > > other than returning errors up the chain properly.  There is a lot of room for
> > > > follow up cleanups, which will happen next.  However I wanted to get this series
> > > > done today and out so we could get it merged ASAP, and then the follow up
> > > > cleanups can happen later as they are less important and less critical.
> > > > 
> > > > The only exception to the above is the patch to add the error injection sites
> > > > for btrfs_cow_block and btrfs_search_slot, and a lockdep fix that I discovered
> > > > while running my tests, those are the first two patches in the series.
> > > > 
> > > > I tested this with my error injection stress test, where I keep track of all
> > > > stack traces that have been tested and only inject errors when we have a new
> > > > stack trace, which means I should have covered all of the various error
> > > > conditions.  With this patchset I'm no longer panicing while stressing the error
> > > > conditions.  Thanks,
> > > 
> > > I just threw this patch set on top of kdave/for-next
> > > (a12315094469d573e41fe3eee91c99a83cec02df) and I got something that
> > > looks like runaway balances:
> > > 
> > 
> > Yup I hit this with my xfstests run that I started after I sent these out, I
> > got a little happy with deleting things for one of the patches, this time
> > I'm running xfstests _before_ I send the next version.  Thanks,
> 
> Well, the good news is you killed the BUG_ON I was hitting every few hours
> while running a test that sends a SIGINT to balance:
> 
> 	https://lore.kernel.org/linux-btrfs/20200904155359.GC5890@hungrycats.org/
> 
> so I'm looking forward to the next version.

OK, I've run the next version, and...the SIGINT test is still failing,
just not in the original place, because the original place doesn't exist
any more.

This happened once:

	[48401.882283][T11825] BTRFS info (device dm-0): balance: start -mlimit=1 -slimit=1
	[48401.889294][T11825] BTRFS info (device dm-0): relocating block group 37267716440064 flags metadata|raid1
	[48423.523596][T11825] BTRFS info (device dm-0): balance: canceled
	[48553.928742][ T1426] BTRFS info (device dm-0): balance: start -mlimit=1 -slimit=1
	[48553.952356][ T1426] BTRFS info (device dm-0): relocating block group 37267716440064 flags metadata|raid1
	[48626.179977][ T4548] avg_delayed_ref_runtime = 5084522, time = 780837759114, count = 153571
	[48639.557809][ T1426] ==================================================================
	[48639.559006][ T1426] BUG: KASAN: null-ptr-deref in select_reloc_root+0x1b0/0x6a0
	[48639.560146][ T1426] Read of size 8 at addr 0000000000000000 by task btrfs/1426
	[48639.561274][ T1426] 
	[48639.561618][ T1426] CPU: 1 PID: 1426 Comm: btrfs Tainted: G        W         5.10.0-87fa69f8a71b-for-next+ #14
	[48639.563076][ T1426] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
	[48639.564382][ T1426] Call Trace:
	[48639.564909][ T1426]  dump_stack+0xbc/0xf9
	[48639.565504][ T1426]  ? select_reloc_root+0x1b0/0x6a0
	[48639.566238][ T1426]  ? select_reloc_root+0x1b0/0x6a0
	[48639.566980][ T1426]  kasan_report.cold.10+0x5/0x37
	[48639.567685][ T1426]  ? select_reloc_root+0x1b0/0x6a0
	[48639.568599][ T1426]  __asan_load8+0x69/0x90
	[48639.569481][ T1426]  select_reloc_root+0x1b0/0x6a0
	[48639.570199][ T1426]  ? __kasan_slab_free+0xf3/0x140
	[48639.570926][ T1426]  ? relocate_data_extent+0x1a0/0x1a0
	[48639.571710][ T1426]  ? btrfs_ioctl+0x24c8/0x4380
	[48639.572400][ T1426]  ? do_syscall_64+0x37/0x80
	[48639.573062][ T1426]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
	[48639.573934][ T1426]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
	[48639.574953][ T1426]  ? free_extent_buffer.part.52+0xb1/0x140
	[48639.575786][ T1426]  ? do_raw_spin_unlock+0xa8/0x140
	[48639.576528][ T1426]  do_relocation+0x23c/0xc10
	[48639.577187][ T1426]  ? free_extent_buffer.part.52+0xd7/0x140
	[48639.578020][ T1426]  ? __list_add_valid+0x33/0x70
	[48639.578711][ T1426]  ? select_reloc_root+0x6a0/0x6a0
	[48639.579441][ T1426]  ? btrfs_backref_finish_upper_links+0x419/0x7d0
	[48639.580358][ T1426]  ? walk_up_backref+0x91/0xd0
	[48639.581039][ T1426]  ? __asan_loadN+0xf/0x20
	[48639.581664][ T1426]  ? select_one_root+0x11d/0x2d0
	[48639.582373][ T1426]  ? lock_downgrade+0x3f0/0x3f0
	[48639.583068][ T1426]  ? do_raw_spin_unlock+0xa8/0x140
	[48639.583802][ T1426]  ? _raw_spin_unlock+0x22/0x30
	[48639.584503][ T1426]  ? btrfs_block_rsv_refill+0x50/0xa0
	[48639.585280][ T1426]  relocate_tree_blocks+0x853/0xb60
	[48639.586030][ T1426]  ? do_relocation+0xc10/0xc10
	[48639.586709][ T1426]  ? kasan_kmalloc+0x9/0x10
	[48639.587356][ T1426]  ? kmem_cache_alloc_trace+0x6a3/0xcb0
	[48639.588147][ T1426]  ? free_extent_buffer.part.52+0xd7/0x140
	[48639.588983][ T1426]  ? rb_insert_color+0x342/0x360
	[48639.589687][ T1426]  ? add_tree_block.isra.36+0x236/0x2b0
	[48639.590478][ T1426]  relocate_block_group+0x2eb/0x780
	[48639.591223][ T1426]  ? merge_reloc_roots+0x470/0x470
	[48639.591972][ T1426]  btrfs_relocate_block_group+0x26e/0x4c0
	[48639.592945][ T1426]  btrfs_relocate_chunk+0x52/0x120
	[48639.593668][ T1426]  btrfs_balance+0xe2e/0x18f0
	[48639.594311][ T1426]  ? __kasan_check_read+0x11/0x20
	[48639.594962][ T1426]  ? lock_acquire+0xd0/0x550
	[48639.595597][ T1426]  ? btrfs_relocate_chunk+0x120/0x120
	[48639.596372][ T1426]  ? kasan_unpoison_task_stack+0xf/0x20
	[48639.597168][ T1426]  ? kmem_cache_alloc_trace+0x6a3/0xcb0
	[48639.597969][ T1426]  ? _copy_from_user+0x83/0xc0
	[48639.598648][ T1426]  btrfs_ioctl_balance+0x3a7/0x460
	[48639.599383][ T1426]  btrfs_ioctl+0x24c8/0x4380
	[48639.600060][ T1426]  ? __kasan_check_read+0x11/0x20
	[48639.600769][ T1426]  ? lock_release+0xc8/0x640
	[48639.601429][ T1426]  ? lru_cache_add+0x178/0x250
	[48639.602102][ T1426]  ? btrfs_ioctl_get_supported_features+0x30/0x30
	[48639.603004][ T1426]  ? lock_downgrade+0x3f0/0x3f0
	[48639.603681][ T1426]  ? handle_mm_fault+0x159e/0x2150
	[48639.604408][ T1426]  ? __kasan_check_read+0x11/0x20
	[48639.605108][ T1426]  ? lock_release+0xc8/0x640
	[48639.605750][ T1426]  ? do_user_addr_fault+0x299/0x5a0
	[48639.606481][ T1426]  ? do_raw_spin_unlock+0xa8/0x140
	[48639.607198][ T1426]  ? lock_downgrade+0x3f0/0x3f0
	[48639.607880][ T1426]  ? _raw_spin_unlock+0x22/0x30
	[48639.608557][ T1426]  ? handle_mm_fault+0xad6/0x2150
	[48639.609262][ T1426]  ? do_vfs_ioctl+0xfc/0x9d0
	[48639.609907][ T1426]  ? ioctl_file_clone+0xe0/0xe0
	[48639.610584][ T1426]  ? __kasan_check_write+0x14/0x20
	[48639.611301][ T1426]  ? up_read+0x176/0x4f0
	[48639.611901][ T1426]  ? down_write_nested+0x2d0/0x2d0
	[48639.612612][ T1426]  ? vmacache_find+0xc9/0x120
	[48639.613274][ T1426]  ? __kasan_check_read+0x11/0x20
	[48639.613977][ T1426]  ? __fget_light+0xae/0x110
	[48639.614620][ T1426]  __x64_sys_ioctl+0xc3/0x100
	[48639.615280][ T1426]  do_syscall_64+0x37/0x80
	[48639.615905][ T1426]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
	[48639.616726][ T1426] RIP: 0033:0x7ffb3753c427
	[48639.617349][ T1426] Code: 00 00 90 48 8b 05 69 aa 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 aa 0c 00 f7 d8 64 89 01 48
	[48639.620089][ T1426] RSP: 002b:00007ffddaf08558 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
	[48639.621268][ T1426] RAX: ffffffffffffffda RBX: 00007ffddaf085f8 RCX: 00007ffb3753c427
	[48639.622380][ T1426] RDX: 00007ffddaf085f8 RSI: 00000000c4009420 RDI: 0000000000000003
	[48639.623492][ T1426] RBP: 0000000000000003 R08: 0000000000000003 R09: 0000000000000078
	[48639.624606][ T1426] R10: fffffffffffff59d R11: 0000000000000202 R12: 0000000000000001
	[48639.625719][ T1426] R13: 0000000000000000 R14: 00007ffddaf09a34 R15: 0000000000000001
[48639.626841][ T1426] ==================================================================

	(gdb) list *(select_reloc_root+0x1b0)
	0xffffffff8194db20 is in select_reloc_root (fs/btrfs/relocation.c:2145).
	2140                    ret = btrfs_record_root_in_trans(trans, root);
	2141                    if (ret)
	2142                            return ERR_PTR(ret);
	2143                    root = root->reloc_root;
	2144
	2145                    if (next->new_bytenr != root->node->start) {
	2146                            /*
	2147                             * We just created the reloc root, so we shouldn't have
	2148                             * ->new_bytenr set and this shouldn't be in the changed
	2149                             *  list.  If it is then we have multiple roots pointing

The following sequence has happened 3 times since yesterday:

	[ 3252.939619][ T8472] BTRFS info (device dm-0): balance: resume -musage=90,limit=1 -susage=90,limit=1
	[ 3253.962086][ T8472] BTRFS info (device dm-0): relocating block group 37252147183616 flags metadata|raid1
	[ 3279.938601][ T8472] 
	[ 3279.938977][ T8472] ======================================================
	[ 3279.939993][ T8472] WARNING: possible circular locking dependency detected
	[ 3279.941020][ T8472] 5.10.0-87fa69f8a71b-for-next+ #14 Tainted: G        W        
	[ 3279.942201][ T8472] ------------------------------------------------------
	[ 3279.943481][ T8472] btrfs/8472 is trying to acquire lock:
	[ 3279.944615][ T8472] ffff888040a3ba28 (btrfs-tree-00){++++}-{3:3}, at: __btrfs_tree_lock+0x29/0x190
	[ 3279.946631][ T8472] 
	[ 3279.946631][ T8472] but task is already holding lock:
	[ 3279.947819][ T8472] ffff88812c69eeb8 (btrfs-extent-01){++++}-{3:3}, at: __btrfs_tree_read_lock+0x49/0x240
	[ 3279.949266][ T8472] 
	[ 3279.949266][ T8472] which lock already depends on the new lock.
	[ 3279.949266][ T8472] 
	[ 3279.950909][ T8472] 
	[ 3279.950909][ T8472] the existing dependency chain (in reverse order) is:
	[ 3279.952357][ T8472] 
	[ 3279.952357][ T8472] -> #1 (btrfs-extent-01){++++}-{3:3}:
	[ 3279.953462][ T8472]        lock_release+0x28c/0x640
	[ 3279.954184][ T8472]        up_read+0x7d/0x4f0
	[ 3279.954833][ T8472]        btrfs_tree_read_unlock+0xbc/0x1b0
	[ 3279.955861][ T8472]        btrfs_search_slot+0xd84/0xfb0
	[ 3279.956639][ T8472]        btrfs_lookup_extent_info+0x165/0x5b0
	[ 3279.957508][ T8472]        do_walk_down+0x29c/0xc00
	[ 3279.958230][ T8472]        walk_down_tree+0x1af/0x210
	[ 3279.958973][ T8472]        btrfs_drop_snapshot+0x44f/0xda0
	[ 3279.959779][ T8472]        clean_dirty_subvols+0x1bd/0x220
	[ 3279.960592][ T8472]        btrfs_recover_relocation+0x60d/0x940
	[ 3279.961464][ T8472]        btrfs_mount_rw+0x12e/0x200
	[ 3279.962236][ T8472]        open_ctree+0x2149/0x2507
	[ 3279.962986][ T8472]        btrfs_mount_root.cold.74+0xe/0xea
	[ 3279.963816][ T8472]        legacy_get_tree+0x89/0xd0
	[ 3279.964547][ T8472]        vfs_get_tree+0x52/0x150
	[ 3279.965257][ T8472]        fc_mount+0x14/0x60
	[ 3279.965903][ T8472]        vfs_kern_mount.part.38+0x61/0xa0
	[ 3279.966717][ T8472]        vfs_kern_mount+0x13/0x20
	[ 3279.967435][ T8472]        btrfs_mount+0x1f0/0x5d0
	[ 3279.968147][ T8472]        legacy_get_tree+0x89/0xd0
	[ 3279.968938][ T8472]        vfs_get_tree+0x52/0x150
	[ 3279.969652][ T8472]        path_mount+0xa53/0xf00
	[ 3279.970411][ T8472]        do_mount+0xd2/0xf0
	[ 3279.971063][ T8472]        __x64_sys_mount+0x100/0x120
	[ 3279.971833][ T8472]        do_syscall_64+0x37/0x80
	[ 3279.972586][ T8472]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
	[ 3279.973564][ T8472] 
	[ 3279.973564][ T8472] -> #0 (btrfs-tree-00){++++}-{3:3}:
	[ 3279.974673][ T8472]        __lock_acquire+0x1dce/0x28a0
	[ 3279.975509][ T8472]        lock_acquire+0x192/0x550
	[ 3279.976287][ T8472]        down_write_nested+0xa6/0x2d0
	[ 3279.977131][ T8472]        __btrfs_tree_lock+0x29/0x190
	[ 3279.977972][ T8472]        btrfs_tree_lock+0x10/0x20
	[ 3279.978764][ T8472]        btrfs_search_slot+0x462/0xfb0
	[ 3279.979614][ T8472]        relocate_tree_blocks+0x8cd/0xb60
	[ 3279.980506][ T8472]        relocate_block_group+0x2eb/0x780
	[ 3279.981368][ T8472]        btrfs_relocate_block_group+0x26e/0x4c0
	[ 3279.982285][ T8472]        btrfs_relocate_chunk+0x52/0x120
	[ 3279.983093][ T8472]        btrfs_balance+0xe2e/0x18f0
	[ 3279.983924][ T8472]        btrfs_ioctl_balance+0x1f9/0x460
	[ 3279.984729][ T8472]        btrfs_ioctl+0x24c8/0x4380
	[ 3279.985472][ T8472]        __x64_sys_ioctl+0xc3/0x100
	[ 3279.986327][ T8472]        do_syscall_64+0x37/0x80
	[ 3279.987058][ T8472]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
	[ 3279.987999][ T8472] 
	[ 3279.987999][ T8472] other info that might help us debug this:
	[ 3279.987999][ T8472] 
	[ 3279.989509][ T8472]  Possible unsafe locking scenario:
	[ 3279.989509][ T8472] 
	[ 3279.990577][ T8472]        CPU0                    CPU1
	[ 3279.991346][ T8472]        ----                    ----
	[ 3279.992116][ T8472]   lock(btrfs-extent-01);
	[ 3279.992751][ T8472]                                lock(btrfs-tree-00);
	[ 3279.993722][ T8472]                                lock(btrfs-extent-01);
	[ 3279.994718][ T8472]   lock(btrfs-tree-00);
	[ 3279.995333][ T8472] 
	[ 3279.995333][ T8472]  *** DEADLOCK ***
	[ 3279.995333][ T8472] 
	[ 3279.996497][ T8472] 5 locks held by btrfs/8472:
	[ 3279.997172][ T8472]  #0: ffff888113010498 (sb_writers#13){.+.+}-{0:0}, at: mnt_want_write_file+0x43/0x90
	[ 3279.998557][ T8472]  #1: ffff888106cc2318 (&fs_info->delete_unused_bgs_mutex){+.+.}-{3:3}, at: btrfs_balance+0xa54/0x18f0
	[ 3280.000165][ T8472]  #2: ffff888106cc08f0 (&fs_info->cleaner_mutex){+.+.}-{3:3}, at: btrfs_relocate_block_group+0x266/0x4c0
	[ 3280.001823][ T8472]  #3: ffff8881130106b8 (sb_internal#2){.+.+}-{0:0}, at: start_transaction+0x6a3/0x910
	[ 3280.003355][ T8472]  #4: ffff88812c69eeb8 (btrfs-extent-01){++++}-{3:3}, at: __btrfs_tree_read_lock+0x49/0x240
	[ 3280.004829][ T8472] 
	[ 3280.004829][ T8472] stack backtrace:
	[ 3280.005671][ T8472] CPU: 3 PID: 8472 Comm: btrfs Tainted: G        W         5.10.0-87fa69f8a71b-for-next+ #14
	[ 3280.007129][ T8472] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
	[ 3280.008438][ T8472] Call Trace:
	[ 3280.008915][ T8472]  dump_stack+0xbc/0xf9
	[ 3280.009562][ T8472]  print_circular_bug.isra.42.cold.67+0x146/0x14b
	[ 3280.010491][ T8472]  check_noncircular+0x219/0x250
	[ 3280.011207][ T8472]  ? print_circular_bug.isra.42+0x1c0/0x1c0
	[ 3280.012059][ T8472]  ? pvclock_clocksource_read+0xeb/0x190
	[ 3280.012873][ T8472]  ? __kasan_check_write+0x14/0x20
	[ 3280.013606][ T8472]  ? lockdep_lock+0xa7/0x160
	[ 3280.014269][ T8472]  __lock_acquire+0x1dce/0x28a0
	[ 3280.014973][ T8472]  ? register_lock_class+0x8f0/0x8f0
	[ 3280.015734][ T8472]  ? rcu_read_lock_sched_held+0xa1/0xd0
	[ 3280.016535][ T8472]  ? rcu_read_lock_bh_held+0xb0/0xb0
	[ 3280.017300][ T8472]  lock_acquire+0x192/0x550
	[ 3280.017950][ T8472]  ? __btrfs_tree_lock+0x29/0x190
	[ 3280.018725][ T8472]  ? check_flags+0x30/0x30
	[ 3280.019366][ T8472]  ? ___might_sleep+0x10f/0x1e0
	[ 3280.020062][ T8472]  ? __might_sleep+0x71/0xe0
	[ 3280.020716][ T8472]  down_write_nested+0xa6/0x2d0
	[ 3280.021413][ T8472]  ? __btrfs_tree_lock+0x29/0x190
	[ 3280.022135][ T8472]  ? _down_write_nest_lock+0x2c0/0x2c0
	[ 3280.022911][ T8472]  ? balance_node_right+0x3c0/0x3c0
	[ 3280.023649][ T8472]  ? rcu_read_lock_bh_held+0x70/0xb0
	[ 3280.024402][ T8472]  ? rcu_read_lock_bh_held+0xb0/0xb0
	[ 3280.025157][ T8472]  __btrfs_tree_lock+0x29/0x190
	[ 3280.025852][ T8472]  btrfs_tree_lock+0x10/0x20
	[ 3280.026524][ T8472]  btrfs_search_slot+0x462/0xfb0
	[ 3280.027261][ T8472]  ? split_leaf+0x9a0/0x9a0
	[ 3280.027941][ T8472]  ? walk_up_backref+0xd0/0xd0
	[ 3280.028652][ T8472]  ? do_raw_spin_lock+0x1e0/0x1e0
	[ 3280.029445][ T8472]  ? do_raw_spin_unlock+0xa8/0x140
	[ 3280.030222][ T8472]  ? _raw_spin_unlock+0x22/0x30
	[ 3280.030960][ T8472]  ? btrfs_block_rsv_refill+0x50/0xa0
	[ 3280.031772][ T8472]  relocate_tree_blocks+0x8cd/0xb60
	[ 3280.032567][ T8472]  ? do_relocation+0xc10/0xc10
	[ 3280.033294][ T8472]  ? kmem_cache_alloc_trace+0xa06/0xcb0
	[ 3280.034144][ T8472]  ? free_extent_buffer.part.52+0xd7/0x140
	[ 3280.035039][ T8472]  ? rb_insert_color+0x342/0x360
	[ 3280.035842][ T8472]  ? add_tree_block.isra.36+0x236/0x2b0
	[ 3280.036707][ T8472]  relocate_block_group+0x2eb/0x780
	[ 3280.037544][ T8472]  ? merge_reloc_roots+0x470/0x470
	[ 3280.038371][ T8472]  btrfs_relocate_block_group+0x26e/0x4c0
	[ 3280.039289][ T8472]  btrfs_relocate_chunk+0x52/0x120
	[ 3280.040114][ T8472]  btrfs_balance+0xe2e/0x18f0
	[ 3280.040867][ T8472]  ? pvclock_clocksource_read+0xeb/0x190
	[ 3280.041775][ T8472]  ? btrfs_relocate_chunk+0x120/0x120
	[ 3280.042655][ T8472]  ? lock_contended+0x620/0x6e0
	[ 3280.043490][ T8472]  ? do_raw_spin_lock+0x1e0/0x1e0
	[ 3280.044303][ T8472]  ? do_raw_spin_unlock+0xa8/0x140
	[ 3280.045051][ T8472]  btrfs_ioctl_balance+0x1f9/0x460
	[ 3280.045980][ T8472]  btrfs_ioctl+0x24c8/0x4380
	[ 3280.047029][ T8472]  ? __kasan_check_read+0x11/0x20
	[ 3280.047851][ T8472]  ? check_chain_key+0x1f4/0x2f0
	[ 3280.048644][ T8472]  ? __asan_loadN+0xf/0x20
	[ 3280.049360][ T8472]  ? btrfs_ioctl_get_supported_features+0x30/0x30
	[ 3280.050469][ T8472]  ? kvm_sched_clock_read+0x18/0x30
	[ 3280.051598][ T8472]  ? check_chain_key+0x1f4/0x2f0
	[ 3280.052378][ T8472]  ? lock_downgrade+0x3f0/0x3f0
	[ 3280.053141][ T8472]  ? handle_mm_fault+0xad6/0x2150
	[ 3280.053934][ T8472]  ? do_vfs_ioctl+0xfc/0x9d0
	[ 3280.054654][ T8472]  ? ioctl_file_clone+0xe0/0xe0
	[ 3280.055421][ T8472]  ? check_flags.part.50+0x6c/0x1e0
	[ 3280.056240][ T8472]  ? check_flags.part.50+0x6c/0x1e0
	[ 3280.057060][ T8472]  ? check_flags+0x26/0x30
	[ 3280.057749][ T8472]  ? lock_is_held_type+0xc3/0xf0
	[ 3280.058573][ T8472]  ? syscall_enter_from_user_mode+0x1b/0x60
	[ 3280.059553][ T8472]  ? do_syscall_64+0x13/0x80
	[ 3280.060294][ T8472]  ? rcu_read_lock_sched_held+0xa1/0xd0
	[ 3280.061149][ T8472]  ? __kasan_check_read+0x11/0x20
	[ 3280.061924][ T8472]  ? __fget_light+0xae/0x110
	[ 3280.062631][ T8472]  __x64_sys_ioctl+0xc3/0x100
	[ 3280.063352][ T8472]  do_syscall_64+0x37/0x80
	[ 3280.064036][ T8472]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
	[ 3280.064941][ T8472] RIP: 0033:0x7f18ca415427
	[ 3280.065619][ T8472] Code: 00 00 90 48 8b 05 69 aa 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 aa 0c 00 f7 d8 64 89 01 48
	[ 3280.068691][ T8472] RSP: 002b:00007ffcd1fed6b8 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
	[ 3280.070070][ T8472] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f18ca415427
	[ 3280.071348][ T8472] RDX: 00007ffcd1fed6c8 RSI: 00000000c4009420 RDI: 0000000000000003
	[ 3280.072750][ T8472] RBP: 0000000000000003 R08: 0000000000000003 R09: 0000000000000078
	[ 3280.073998][ T8472] R10: fffffffffffff59d R11: 0000000000000206 R12: 0000000000000002
	[ 3280.075238][ T8472] R13: 00007ffcd1fefa39 R14: 0000560042d94119 R15: 0000000000000000
	[ 3280.222230][ T8472] ------------[ cut here ]------------
	[ 3280.223530][ T8472] WARNING: CPU: 3 PID: 8472 at fs/btrfs/backref.c:2627 btrfs_backref_add_tree_node+0xfa4/0x11d0
	[ 3280.226859][ T8472] Modules linked in:
	[ 3280.228422][ T8472] CPU: 3 PID: 8472 Comm: btrfs Tainted: G        W         5.10.0-87fa69f8a71b-for-next+ #14
	[ 3280.231521][ T8472] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
	[ 3280.233746][ T8472] RIP: 0010:btrfs_backref_add_tree_node+0xfa4/0x11d0
	[ 3280.234776][ T8472] Code: 89 e7 4d 8d 66 30 e8 db 3e f3 ff 49 8d 46 2c 48 89 45 c0 e9 da f1 ff ff 49 8d 46 2c bb 8b ff ff ff 48 89 45 c0 e9 c8 f1 ff ff <0f> 0b 49 8d 46 2c bb fe ff ff ff 4d 8d 66 30 48 89 45 c0 e9 b0 f1
	[ 3280.237631][ T8472] RSP: 0018:ffffc9000769f4c0 EFLAGS: 00010246
	[ 3280.238626][ T8472] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 1ffff92000ed3e85
	[ 3280.239826][ T8472] RDX: 0000000000000000 RSI: dffffc0000000000 RDI: ffff88805ef475e8
	[ 3280.241013][ T8472] RBP: ffffc9000769f598 R08: ffffed100bde8ebe R09: ffffed100bde8ebe
	[ 3280.242197][ T8472] R10: ffff88805ef475eb R11: ffffed100bde8ebd R12: ffff88805ef47020
	[ 3280.243428][ T8472] R13: 0000217411380000 R14: ffff888126976b80 R15: 0000000000000000
	[ 3280.244679][ T8472] FS:  00007f18ca3228c0(0000) GS:ffff8881f5e00000(0000) knlGS:0000000000000000
	[ 3280.246099][ T8472] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	[ 3280.247102][ T8472] CR2: 000055b5c456ab00 CR3: 000000012c08e002 CR4: 00000000001706e0
	[ 3280.248455][ T8472] Call Trace:
	[ 3280.249018][ T8472]  build_backref_tree+0xc5/0x700
	[ 3280.249845][ T8472]  ? _raw_spin_unlock+0x22/0x30
	[ 3280.250576][ T8472]  ? release_extent_buffer+0x225/0x280
	[ 3280.251381][ T8472]  ? free_extent_buffer.part.52+0xd7/0x140
	[ 3280.252253][ T8472]  relocate_tree_blocks+0x2a6/0xb60
	[ 3280.253044][ T8472]  ? kasan_unpoison_shadow+0x35/0x50
	[ 3280.253841][ T8472]  ? do_relocation+0xc10/0xc10
	[ 3280.254559][ T8472]  ? kasan_kmalloc+0x9/0x10
	[ 3280.255227][ T8472]  ? kmem_cache_alloc_trace+0x6a3/0xcb0
	[ 3280.256063][ T8472]  ? free_extent_buffer.part.52+0xd7/0x140
	[ 3280.256939][ T8472]  ? rb_insert_color+0x342/0x360
	[ 3280.257685][ T8472]  ? add_tree_block.isra.36+0x236/0x2b0
	[ 3280.258519][ T8472]  relocate_block_group+0x2eb/0x780
	[ 3280.259332][ T8472]  ? merge_reloc_roots+0x470/0x470
	[ 3280.260223][ T8472]  btrfs_relocate_block_group+0x26e/0x4c0
	[ 3280.261169][ T8472]  btrfs_relocate_chunk+0x52/0x120
	[ 3280.262199][ T8472]  btrfs_balance+0xe2e/0x18f0
	[ 3280.263146][ T8472]  ? pvclock_clocksource_read+0xeb/0x190
	[ 3280.264035][ T8472]  ? btrfs_relocate_chunk+0x120/0x120
	[ 3280.264851][ T8472]  ? lock_contended+0x620/0x6e0
	[ 3280.265587][ T8472]  ? do_raw_spin_lock+0x1e0/0x1e0
	[ 3280.266334][ T8472]  ? do_raw_spin_unlock+0xa8/0x140
	[ 3280.267103][ T8472]  btrfs_ioctl_balance+0x1f9/0x460
	[ 3280.267896][ T8472]  btrfs_ioctl+0x24c8/0x4380
	[ 3280.268599][ T8472]  ? __kasan_check_read+0x11/0x20
	[ 3280.269377][ T8472]  ? check_chain_key+0x1f4/0x2f0
	[ 3280.270149][ T8472]  ? __asan_loadN+0xf/0x20
	[ 3280.270875][ T8472]  ? btrfs_ioctl_get_supported_features+0x30/0x30
	[ 3280.271894][ T8472]  ? kvm_sched_clock_read+0x18/0x30
	[ 3280.272716][ T8472]  ? check_chain_key+0x1f4/0x2f0
	[ 3280.273503][ T8472]  ? lock_downgrade+0x3f0/0x3f0
	[ 3280.274258][ T8472]  ? handle_mm_fault+0xad6/0x2150
	[ 3280.275053][ T8472]  ? do_vfs_ioctl+0xfc/0x9d0
	[ 3280.275796][ T8472]  ? ioctl_file_clone+0xe0/0xe0
	[ 3280.276575][ T8472]  ? check_flags.part.50+0x6c/0x1e0
	[ 3280.277393][ T8472]  ? check_flags.part.50+0x6c/0x1e0
	[ 3280.278222][ T8472]  ? check_flags+0x26/0x30
	[ 3280.278943][ T8472]  ? lock_is_held_type+0xc3/0xf0
	[ 3280.279734][ T8472]  ? syscall_enter_from_user_mode+0x1b/0x60
	[ 3280.280672][ T8472]  ? do_syscall_64+0x13/0x80
	[ 3280.281394][ T8472]  ? rcu_read_lock_sched_held+0xa1/0xd0
	[ 3280.282276][ T8472]  ? __kasan_check_read+0x11/0x20
	[ 3280.283084][ T8472]  ? __fget_light+0xae/0x110
	[ 3280.283826][ T8472]  __x64_sys_ioctl+0xc3/0x100
	[ 3280.284576][ T8472]  do_syscall_64+0x37/0x80
	[ 3280.285268][ T8472]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
	[ 3280.286198][ T8472] RIP: 0033:0x7f18ca415427
	[ 3280.286912][ T8472] Code: 00 00 90 48 8b 05 69 aa 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 aa 0c 00 f7 d8 64 89 01 48
	[ 3280.289939][ T8472] RSP: 002b:00007ffcd1fed6b8 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
	[ 3280.291265][ T8472] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f18ca415427
	[ 3280.292520][ T8472] RDX: 00007ffcd1fed6c8 RSI: 00000000c4009420 RDI: 0000000000000003
	[ 3280.293776][ T8472] RBP: 0000000000000003 R08: 0000000000000003 R09: 0000000000000078
	[ 3280.295056][ T8472] R10: fffffffffffff59d R11: 0000000000000206 R12: 0000000000000002
	[ 3280.296340][ T8472] R13: 00007ffcd1fefa39 R14: 0000560042d94119 R15: 0000000000000000
	[ 3280.297670][ T8472] CPU: 3 PID: 8472 Comm: btrfs Tainted: G        W         5.10.0-87fa69f8a71b-for-next+ #14
	[ 3280.299320][ T8472] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
	[ 3280.300804][ T8472] Call Trace:
	[ 3280.301338][ T8472]  dump_stack+0xbc/0xf9
	[ 3280.302022][ T8472]  ? btrfs_backref_add_tree_node+0xfa4/0x11d0
	[ 3280.302979][ T8472]  __warn.cold.11+0xe/0x53
	[ 3280.303672][ T8472]  ? btrfs_backref_add_tree_node+0xfa4/0x11d0
	[ 3280.304627][ T8472]  report_bug+0xf4/0x130
	[ 3280.305301][ T8472]  handle_bug+0x41/0x80
	[ 3280.305959][ T8472]  exc_invalid_op+0x18/0x40
	[ 3280.306666][ T8472]  asm_exc_invalid_op+0x12/0x20
	[ 3280.307429][ T8472] RIP: 0010:btrfs_backref_add_tree_node+0xfa4/0x11d0
	[ 3280.308481][ T8472] Code: 89 e7 4d 8d 66 30 e8 db 3e f3 ff 49 8d 46 2c 48 89 45 c0 e9 da f1 ff ff 49 8d 46 2c bb 8b ff ff ff 48 89 45 c0 e9 c8 f1 ff ff <0f> 0b 49 8d 46 2c bb fe ff ff ff 4d 8d 66 30 48 89 45 c0 e9 b0 f1
	[ 3280.311594][ T8472] RSP: 0018:ffffc9000769f4c0 EFLAGS: 00010246
	[ 3280.312577][ T8472] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 1ffff92000ed3e85
	[ 3280.313872][ T8472] RDX: 0000000000000000 RSI: dffffc0000000000 RDI: ffff88805ef475e8
	[ 3280.315142][ T8472] RBP: ffffc9000769f598 R08: ffffed100bde8ebe R09: ffffed100bde8ebe
	[ 3280.316417][ T8472] R10: ffff88805ef475eb R11: ffffed100bde8ebd R12: ffff88805ef47020
	[ 3280.317664][ T8472] R13: 0000217411380000 R14: ffff888126976b80 R15: 0000000000000000
	[ 3280.318924][ T8472]  build_backref_tree+0xc5/0x700
	[ 3280.319696][ T8472]  ? _raw_spin_unlock+0x22/0x30
	[ 3280.320459][ T8472]  ? release_extent_buffer+0x225/0x280
	[ 3280.321321][ T8472]  ? free_extent_buffer.part.52+0xd7/0x140
	[ 3280.322237][ T8472]  relocate_tree_blocks+0x2a6/0xb60
	[ 3280.323056][ T8472]  ? kasan_unpoison_shadow+0x35/0x50
	[ 3280.323897][ T8472]  ? do_relocation+0xc10/0xc10
	[ 3280.324707][ T8472]  ? kasan_kmalloc+0x9/0x10
	[ 3280.325406][ T8472]  ? kmem_cache_alloc_trace+0x6a3/0xcb0
	[ 3280.326258][ T8472]  ? free_extent_buffer.part.52+0xd7/0x140
	[ 3280.327176][ T8472]  ? rb_insert_color+0x342/0x360
	[ 3280.327970][ T8472]  ? add_tree_block.isra.36+0x236/0x2b0
	[ 3280.328825][ T8472]  relocate_block_group+0x2eb/0x780
	[ 3280.329621][ T8472]  ? merge_reloc_roots+0x470/0x470
	[ 3280.330443][ T8472]  btrfs_relocate_block_group+0x26e/0x4c0
	[ 3280.331348][ T8472]  btrfs_relocate_chunk+0x52/0x120
	[ 3280.332179][ T8472]  btrfs_balance+0xe2e/0x18f0
	[ 3280.332951][ T8472]  ? pvclock_clocksource_read+0xeb/0x190
	[ 3280.333844][ T8472]  ? btrfs_relocate_chunk+0x120/0x120
	[ 3280.334711][ T8472]  ? lock_contended+0x620/0x6e0
	[ 3280.335562][ T8472]  ? do_raw_spin_lock+0x1e0/0x1e0
	[ 3280.336383][ T8472]  ? do_raw_spin_unlock+0xa8/0x140
	[ 3280.337215][ T8472]  btrfs_ioctl_balance+0x1f9/0x460
	[ 3280.338026][ T8472]  btrfs_ioctl+0x24c8/0x4380
	[ 3280.338743][ T8472]  ? __kasan_check_read+0x11/0x20
	[ 3280.339530][ T8472]  ? check_chain_key+0x1f4/0x2f0
	[ 3280.340326][ T8472]  ? __asan_loadN+0xf/0x20
	[ 3280.341065][ T8472]  ? btrfs_ioctl_get_supported_features+0x30/0x30
	[ 3280.342069][ T8472]  ? kvm_sched_clock_read+0x18/0x30
	[ 3280.342890][ T8472]  ? check_chain_key+0x1f4/0x2f0
	[ 3280.343670][ T8472]  ? lock_downgrade+0x3f0/0x3f0
	[ 3280.344440][ T8472]  ? handle_mm_fault+0xad6/0x2150
	[ 3280.345257][ T8472]  ? do_vfs_ioctl+0xfc/0x9d0
	[ 3280.346010][ T8472]  ? ioctl_file_clone+0xe0/0xe0
	[ 3280.346801][ T8472]  ? check_flags.part.50+0x6c/0x1e0
	[ 3280.347640][ T8472]  ? check_flags.part.50+0x6c/0x1e0
	[ 3280.348542][ T8472]  ? check_flags+0x26/0x30
	[ 3280.349322][ T8472]  ? lock_is_held_type+0xc3/0xf0
	[ 3280.350180][ T8472]  ? syscall_enter_from_user_mode+0x1b/0x60
	[ 3280.351128][ T8472]  ? do_syscall_64+0x13/0x80
	[ 3280.351872][ T8472]  ? rcu_read_lock_sched_held+0xa1/0xd0
	[ 3280.352819][ T8472]  ? __kasan_check_read+0x11/0x20
	[ 3280.353604][ T8472]  ? __fget_light+0xae/0x110
	[ 3280.354321][ T8472]  __x64_sys_ioctl+0xc3/0x100
	[ 3280.355050][ T8472]  do_syscall_64+0x37/0x80
	[ 3280.355733][ T8472]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
	[ 3280.356645][ T8472] RIP: 0033:0x7f18ca415427
	[ 3280.357332][ T8472] Code: 00 00 90 48 8b 05 69 aa 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 aa 0c 00 f7 d8 64 89 01 48
	[ 3280.360434][ T8472] RSP: 002b:00007ffcd1fed6b8 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
	[ 3280.361741][ T8472] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f18ca415427
	[ 3280.362962][ T8472] RDX: 00007ffcd1fed6c8 RSI: 00000000c4009420 RDI: 0000000000000003
	[ 3280.364165][ T8472] RBP: 0000000000000003 R08: 0000000000000003 R09: 0000000000000078
	[ 3280.365366][ T8472] R10: fffffffffffff59d R11: 0000000000000206 R12: 0000000000000002
	[ 3280.366570][ T8472] R13: 00007ffcd1fefa39 R14: 0000560042d94119 R15: 0000000000000000
	[ 3280.367904][ T8472] irq event stamp: 4498529
	[ 3280.368608][ T8472] hardirqs last  enabled at (4498529): [<ffffffff83a60905>] irqentry_exit+0x35/0x80
	[ 3280.370128][ T8472] hardirqs last disabled at (4498527): [<ffffffff83e00506>] __do_softirq+0x506/0x5a7
	[ 3280.371656][ T8472] softirqs last  enabled at (4498528): [<ffffffff83e0044f>] __do_softirq+0x44f/0x5a7
	[ 3280.373173][ T8472] softirqs last disabled at (4498521): [<ffffffff83c01122>] asm_call_irq_on_stack+0x12/0x20
	[ 3280.374833][ T8472] ---[ end trace 0689b357dfaddeab ]---

	(gdb) list *(btrfs_backref_add_tree_node+0xfa4)
	0xffffffff81970194 is in btrfs_backref_add_tree_node (fs/btrfs/backref.c:2627).
	2622
	2623                    cur->is_reloc_root = 1;
	2624                    /* Only reloc backref cache cares about a specific root */
	2625                    if (cache->is_reloc) {
	2626                            root = find_reloc_root(cache->fs_info, cur->bytenr);
	2627                            if (WARN_ON(!root))
	2628                                    return -ENOENT;
	2629                            cur->root = root;
	2630                    } else {
	2631                            /*

	[ 3280.375749][ T8472] ------------[ cut here ]------------
	[ 3280.376711][ T8472] kernel BUG at fs/btrfs/backref.c:2545!
	[ 3280.377576][ T8472] invalid opcode: 0000 [#1] SMP KASAN PTI
	[ 3280.378401][ T8472] CPU: 3 PID: 8472 Comm: btrfs Tainted: G        W         5.10.0-87fa69f8a71b-for-next+ #14
	[ 3280.379966][ T8472] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
	[ 3280.381287][ T8472] RIP: 0010:btrfs_backref_cleanup_node+0x5f7/0x600
	[ 3280.382376][ T8472] Code: 5f 5d c3 48 89 df e8 08 e2 fa ff 49 8d 7f 70 e8 0f c8 b9 ff 41 80 67 71 fb 4c 89 e7 e8 b2 c9 b9 ff 49 8b 5f 68 e9 b2 fc ff ff <0f> 0b 0f 0b 0f 0b 0f 0b 90 0f 1f 44 00 00 55 48 89 e5 41 57 41 56
	[ 3280.385743][ T8472] RSP: 0018:ffffc9000769f4c8 EFLAGS: 00010283
	[ 3280.386689][ T8472] RAX: ffff8880436bc880 RBX: ffff8880436bc180 RCX: ffffffff8296ec9b
	[ 3280.387966][ T8472] RDX: dffffc0000000000 RSI: dffffc0000000000 RDI: ffff8881ebd43f40
	[ 3280.389242][ T8472] RBP: ffffc9000769f520 R08: 0000000000000000 R09: 0000000000000000
	[ 3280.390503][ T8472] R10: ffffffff8533ba03 R11: fffffbfff0a67740 R12: ffff8880436bc190
	[ 3280.391763][ T8472] R13: ffff8881ebd43900 R14: ffff8880436bc190 R15: ffff8881ebd43f00
	[ 3280.393123][ T8472] FS:  00007f18ca3228c0(0000) GS:ffff8881f5e00000(0000) knlGS:0000000000000000
	[ 3280.394562][ T8472] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	[ 3280.395950][ T8472] CR2: 000055b5c456ab00 CR3: 000000012c08e002 CR4: 00000000001706e0
	[ 3280.397253][ T8472] Call Trace:
	[ 3280.399029][ T8472]  btrfs_backref_error_cleanup+0x4df/0x530
	[ 3280.399997][ T8472]  build_backref_tree+0x1a5/0x700
	[ 3280.400814][ T8472]  ? _raw_spin_unlock+0x22/0x30
	[ 3280.401597][ T8472]  ? release_extent_buffer+0x225/0x280
	[ 3280.402532][ T8472]  ? free_extent_buffer.part.52+0xd7/0x140
	[ 3280.403470][ T8472]  relocate_tree_blocks+0x2a6/0xb60
	[ 3280.404295][ T8472]  ? kasan_unpoison_shadow+0x35/0x50
	[ 3280.405146][ T8472]  ? do_relocation+0xc10/0xc10
	[ 3280.405987][ T8472]  ? kasan_kmalloc+0x9/0x10
	[ 3280.407291][ T8472]  ? kmem_cache_alloc_trace+0x6a3/0xcb0
	[ 3280.408229][ T8472]  ? free_extent_buffer.part.52+0xd7/0x140
	[ 3280.409188][ T8472]  ? rb_insert_color+0x342/0x360
	[ 3280.409969][ T8472]  ? add_tree_block.isra.36+0x236/0x2b0
	[ 3280.410985][ T8472]  relocate_block_group+0x2eb/0x780
	[ 3280.411805][ T8472]  ? merge_reloc_roots+0x470/0x470
	[ 3280.412546][ T8472]  btrfs_relocate_block_group+0x26e/0x4c0
	[ 3280.413436][ T8472]  btrfs_relocate_chunk+0x52/0x120
	[ 3280.414302][ T8472]  btrfs_balance+0xe2e/0x18f0
	[ 3280.415022][ T8472]  ? pvclock_clocksource_read+0xeb/0x190
	[ 3280.415922][ T8472]  ? btrfs_relocate_chunk+0x120/0x120
	[ 3280.416842][ T8472]  ? lock_contended+0x620/0x6e0
	[ 3280.417598][ T8472]  ? do_raw_spin_lock+0x1e0/0x1e0
	[ 3280.418394][ T8472]  ? do_raw_spin_unlock+0xa8/0x140
	[ 3280.419208][ T8472]  btrfs_ioctl_balance+0x1f9/0x460
	[ 3280.420016][ T8472]  btrfs_ioctl+0x24c8/0x4380
	[ 3280.420734][ T8472]  ? __kasan_check_read+0x11/0x20
	[ 3280.421523][ T8472]  ? check_chain_key+0x1f4/0x2f0
	[ 3280.423328][ T8472]  ? __asan_loadN+0xf/0x20
	[ 3280.424033][ T8472]  ? btrfs_ioctl_get_supported_features+0x30/0x30
	[ 3280.425042][ T8472]  ? kvm_sched_clock_read+0x18/0x30
	[ 3280.425858][ T8472]  ? check_chain_key+0x1f4/0x2f0
	[ 3280.426632][ T8472]  ? lock_downgrade+0x3f0/0x3f0
	[ 3280.427401][ T8472]  ? handle_mm_fault+0xad6/0x2150
	[ 3280.428192][ T8472]  ? do_vfs_ioctl+0xfc/0x9d0
	[ 3280.428920][ T8472]  ? ioctl_file_clone+0xe0/0xe0
	[ 3280.429667][ T8472]  ? check_flags.part.50+0x6c/0x1e0
	[ 3280.430463][ T8472]  ? check_flags.part.50+0x6c/0x1e0
	[ 3280.431252][ T8472]  ? check_flags+0x26/0x30
	[ 3280.431928][ T8472]  ? lock_is_held_type+0xc3/0xf0
	[ 3280.432681][ T8472]  ? syscall_enter_from_user_mode+0x1b/0x60
	[ 3280.433574][ T8472]  ? do_syscall_64+0x13/0x80
	[ 3280.434278][ T8472]  ? rcu_read_lock_sched_held+0xa1/0xd0
	[ 3280.435122][ T8472]  ? __kasan_check_read+0x11/0x20
	[ 3280.435886][ T8472]  ? __fget_light+0xae/0x110
	[ 3280.436586][ T8472]  __x64_sys_ioctl+0xc3/0x100
	[ 3280.437300][ T8472]  do_syscall_64+0x37/0x80
	[ 3280.438040][ T8472]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
	[ 3280.438932][ T8472] RIP: 0033:0x7f18ca415427
	[ 3280.439595][ T8472] Code: 00 00 90 48 8b 05 69 aa 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 aa 0c 00 f7 d8 64 89 01 48
	[ 3280.442689][ T8472] RSP: 002b:00007ffcd1fed6b8 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
	[ 3280.444023][ T8472] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f18ca415427
	[ 3280.445292][ T8472] RDX: 00007ffcd1fed6c8 RSI: 00000000c4009420 RDI: 0000000000000003
	[ 3280.446601][ T8472] RBP: 0000000000000003 R08: 0000000000000003 R09: 0000000000000078
	[ 3280.448014][ T8472] R10: fffffffffffff59d R11: 0000000000000206 R12: 0000000000000002
	[ 3280.449397][ T8472] R13: 00007ffcd1fefa39 R14: 0000560042d94119 R15: 0000000000000000
	[ 3280.450805][ T8472] Modules linked in:
	[ 3280.451530][ T8472] ---[ end trace 0689b357dfaddeac ]---

	(gdb) list *(btrfs_backref_cleanup_node+0x5f7)
	0xffffffff8196f037 is in btrfs_backref_cleanup_node (fs/btrfs/backref.c:2545).
	2540                    list_del(&edge->list[LOWER]);
	2541                    list_del(&edge->list[UPPER]);
	2542                    btrfs_backref_free_edge(cache, edge);
	2543
	2544                    if (RB_EMPTY_NODE(&upper->rb_node)) {
	2545                            BUG_ON(!list_empty(&node->upper));
	2546                            btrfs_backref_drop_node(cache, node);
	2547                            node = upper;
	2548                            node->lowest = 1;
	2549                            continue;

> > Josef
