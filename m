Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB24525A1AD
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Sep 2020 00:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgIAWxv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Sep 2020 18:53:51 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:33420 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgIAWxu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Sep 2020 18:53:50 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id D6C2F7E152A; Tue,  1 Sep 2020 18:53:47 -0400 (EDT)
Date:   Tue, 1 Sep 2020 18:53:42 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        wqu@suse.com
Subject: Re: BUG at fs/btrfs/relocation.c:794! Still happening on misc-next
 and 5.8.3
Message-ID: <20200901225341.GY5890@hungrycats.org>
References: <20200630221006.17585-1-dsterba@suse.com>
 <20200723215641.GE5890@hungrycats.org>
 <bfecfacd-2d9d-386d-dfb7-951a5c5c6f6e@gmx.com>
 <20200804161626.GN5890@hungrycats.org>
 <20200828000313.GS5890@hungrycats.org>
 <20200828000822.GT5890@hungrycats.org>
 <720f3ac7-6af5-e171-5947-ed0240d5f5e5@suse.com>
 <20200828204255.GV5890@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200828204255.GV5890@hungrycats.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 28, 2020 at 04:42:55PM -0400, Zygo Blaxell wrote:
> On Fri, Aug 28, 2020 at 09:34:31AM +0300, Nikolay Borisov wrote:
> > On 28.08.20 г. 3:08 ч., Zygo Blaxell wrote:
> > > On Thu, Aug 27, 2020 at 08:03:13PM -0400, Zygo Blaxell wrote:
> > >> On Tue, Aug 04, 2020 at 12:16:26PM -0400, Zygo Blaxell wrote:
> > 
> > <snip>
> > 
> > Since you can repro reliably could you modify the code in
> > create_reloc_root so it prints what's the returned error value, I'd
> > speculate it's EEXIST from
> > 
> > btrfs_insert_root
> >   btrfs_insert_item
> >    btrfs_insert_empty_item
> >      btrfs_insert_empty_items
> >        btrfs_search_slot
> > 
> > But better be sure.
> 
> Here you go, EEXIST == 17:
> 
> 	Aug 28 15:30:55 regress kernel: [18452.845182][T31546] BTRFS info (device dm-0): balance: start -dlimit=9
> 	Aug 28 15:30:55 regress kernel: [18452.874627][T31546] BTRFS info (device dm-0): relocating block group 15873413742592 flags data
> 	Aug 28 15:30:55 regress kernel: [18453.097516][ T2100] btrfs_search_slot ret = 0
> 	Aug 28 15:30:55 regress kernel: [18453.104865][ T2100] btrfs_search_slot ret = 0
> 	Aug 28 15:30:55 regress kernel: [18453.109751][ T2100] btrfs_search_slot ret = 0
> 	Aug 28 15:30:56 regress kernel: [18454.453135][ T2100] btrfs_search_slot ret = 0
> 	Aug 28 15:30:56 regress kernel: [18454.453955][ T2100] btrfs_insert_empty_item ret = -17
> 	Aug 28 15:30:56 regress kernel: [18454.455022][ T2100] btrfs_insert_root ret = -17
> 	Aug 28 15:30:56 regress kernel: [18454.456229][ T2100] ------------[ cut here ]------------
> 	Aug 28 15:30:56 regress kernel: [18454.457622][ T2100] kernel BUG at fs/btrfs/relocation.c:795!

I did a low-resolution bisect for this issue.  I dug up 5.4, 5.5, 5.6,
and 5.7 kernel sources, backported btrfs fixes from 5.4 to the obsolete
kernels, and ran the tests on each kernel.  Results:

	5.8:  kernel BUG at fs/btrfs/relocation.c:794

	5.7:  kernel BUG (same code but different line number)

	5.6:  kernel BUG (same as the others)

	5.5:  assertion failure (stack trace below)

	5.4:  kernel BUG (!)

The 5.4 result is interesting--I've been running 5.4 for some time and
not hit this before.  So there are 3 possible theories:

	1.  It's because of sending signals to balance.  That has been
	added to my test workload after 5.7 was released, so earlier
	tests on 5.4 would not have triggered it.

	2.  There's a regression in 5.4-stable, which I've cherry-picked
	to all the other kernels during my test setup.	(On the other
	hand, if I don't backport some fixes, kernels 5.5..5.7 crash
	before they get to this bug.)

	3.  There's something rotten in my test filesystem, and the
	BUG will go away for a while if I do a mkfs.  Qu asked for
	a dump earlier in this thread, and I provided one.

All three of these theories are testable to some extent, so I'll have
my test VM run some variations.

The full test workload is:

	balance metadata or data at random intervals

	scrub, scrub cancel at random intervals

	20x rsync updating files

	snapshot create, delete at random intervals

	bees dedupe (lots of EXTENT_SAME and LOGICAL_INO calls)

	balance cancel at random intervals

	kill -9 $(pidof btrfs balance) at random intervals (NEW - added
	when 5.7 came out)

This is the 5.5 root assertion failure:

	Sep  1 04:48:48 regress kernel: [10642.537825][T24161] assertion failed: root, in fs/btrfs/relocation.c:837
	Sep  1 04:48:48 regress kernel: [10642.538911][T24161] ------------[ cut here ]------------
	Sep  1 04:48:48 regress kernel: [10642.539704][T24161] kernel BUG at fs/btrfs/ctree.h:3125!
	Sep  1 04:48:48 regress kernel: [10642.540621][T24161] invalid opcode: 0000 [#1] SMP KASAN PTI
	Sep  1 04:48:48 regress kernel: [10642.540624][ T4639] irq event stamp: 49626809
	Sep  1 04:48:48 regress kernel: [10642.540632][ T4639] hardirqs last  enabled at (49626809): [<ffffffff8a00481a>] trace_hardirqs_on_thunk+0x1a/0x1c
	Sep  1 04:48:48 regress kernel: [10642.541451][T24161] CPU: 1 PID: 24161 Comm: btrfs Tainted: G        W         5.5.19-76348822ab91+ #14
	Sep  1 04:48:48 regress kernel: [10642.542114][ T4639] hardirqs last disabled at (49626808): [<ffffffff8a004836>] trace_hardirqs_off_thunk+0x1a/0x1c
	Sep  1 04:48:48 regress kernel: [10642.543693][T24161] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
	Sep  1 04:48:48 regress kernel: [10642.545017][ T4639] softirqs last  enabled at (49626726): [<ffffffff8bc0048b>] __do_softirq+0x48b/0x5be
	Sep  1 04:48:48 regress kernel: [10642.545023][ T4639] softirqs last disabled at (49626715): [<ffffffff8a1258a2>] irq_exit+0x112/0x120
	Sep  1 04:48:48 regress kernel: [10642.546536][T24161] RIP: 0010:assertfail.constprop.42+0x1c/0x1e
	Sep  1 04:48:49 regress kernel: [10642.551589][T24161] Code: 48 c7 c6 c0 90 03 8c e8 89 29 f1 ff 0f 0b 55 89 f1 48 c7 c2 40 82 03 8c 48 89 fe 48 c7 c7 60 83 03 8c 48 89 e5 e8 41 b0 90 ff <0f> 0b 0f 1f 44 00 00 55 48 89 e5 41 54 49 89 f4 53 48 89 fb 48 83
	Sep  1 04:48:49 regress kernel: [10642.554495][T24161] RSP: 0018:ffffc90002327150 EFLAGS: 00010282
	Sep  1 04:48:49 regress kernel: [10642.555371][T24161] RAX: 0000000000000034 RBX: 000004513701c000 RCX: ffffffff8a264242
	Sep  1 04:48:49 regress kernel: [10642.556515][T24161] RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff8881f580004c
	Sep  1 04:48:49 regress kernel: [10642.557680][T24161] RBP: ffffc90002327150 R08: ffffed103eb017e1 R09: ffffed103eb017e1
	Sep  1 04:48:49 regress kernel: [10642.558895][T24161] R10: ffffed103eb017e0 R11: ffff8881f580bf07 R12: ffff88800d1ea5c0
	Sep  1 04:48:49 regress kernel: [10642.560139][T24161] R13: ffffc900023273e0 R14: 0000000000000000 R15: ffff8880bbf238f0
	Sep  1 04:48:49 regress kernel: [10642.561391][T24161] FS:  00007f03f48488c0(0000) GS:ffff8881f5600000(0000) knlGS:0000000000000000
	Sep  1 04:48:49 regress kernel: [10642.562779][T24161] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	Sep  1 04:48:49 regress kernel: [10642.563801][T24161] CR2: 00007f1cab76f718 CR3: 0000000189a5e004 CR4: 00000000001606e0
	Sep  1 04:48:49 regress kernel: [10642.565046][T24161] Call Trace:
	Sep  1 04:48:49 regress kernel: [10642.565565][T24161]  build_backref_tree+0x186b/0x2590
	Sep  1 04:48:49 regress kernel: [10642.566389][T24161]  ? relocate_data_extent+0x1a0/0x1a0
	Sep  1 04:48:49 regress kernel: [10642.567295][T24161]  ? lock_downgrade+0x3d0/0x3d0
	Sep  1 04:48:49 regress kernel: [10642.568142][T24161]  ? match_held_lock+0x20/0x260
	Sep  1 04:48:49 regress kernel: [10642.568925][T24161]  ? do_raw_spin_unlock+0xa8/0x140
	Sep  1 04:48:49 regress kernel: [10642.569765][T24161]  ? _raw_spin_trylock_bh+0x60/0x80
	Sep  1 04:48:49 regress kernel: [10642.570605][T24161]  ? release_extent_buffer+0x13b/0x230
	Sep  1 04:48:49 regress kernel: [10642.571480][T24161]  ? free_extent_buffer.part.45+0xd7/0x140
	Sep  1 04:48:49 regress kernel: [10642.572406][T24161]  relocate_tree_blocks+0x204/0xa50
	Sep  1 04:48:49 regress kernel: [10642.573244][T24161]  ? build_backref_tree+0x2590/0x2590
	Sep  1 04:48:49 regress kernel: [10642.574103][T24161]  ? rb_insert_color+0x3af/0x400
	Sep  1 04:48:49 regress kernel: [10642.574896][T24161]  ? kmem_cache_alloc_trace+0x5af/0x740
	Sep  1 04:48:49 regress kernel: [10642.575785][T24161]  ? tree_insert+0x90/0xb0
	Sep  1 04:48:49 regress kernel: [10642.576495][T24161]  ? add_tree_block.isra.38+0x1d6/0x230
	Sep  1 04:48:49 regress kernel: [10642.577387][T24161]  relocate_block_group+0x528/0x9d0
	Sep  1 04:48:49 regress kernel: [10642.578220][T24161]  ? merge_reloc_roots+0x470/0x470
	Sep  1 04:48:49 regress kernel: [10642.579047][T24161]  btrfs_relocate_block_group+0x26e/0x4c0
	Sep  1 04:48:49 regress kernel: [10642.579968][T24161]  btrfs_relocate_chunk+0x52/0xf0
	Sep  1 04:48:49 regress kernel: [10642.580773][T24161]  btrfs_balance+0xe5b/0x1800
	Sep  1 04:48:49 regress kernel: [10642.581542][T24161]  ? btrfs_relocate_chunk+0xf0/0xf0
	Sep  1 04:48:49 regress kernel: [10642.582381][T24161]  ? kmem_cache_alloc_trace+0x5af/0x740
	Sep  1 04:48:49 regress kernel: [10642.583270][T24161]  ? _copy_from_user+0xaa/0xd0
	Sep  1 04:48:49 regress kernel: [10642.584022][T24161]  btrfs_ioctl_balance+0x3de/0x4c0
	Sep  1 04:48:49 regress kernel: [10642.584819][T24161]  btrfs_ioctl+0x3122/0x4470
	Sep  1 04:48:49 regress kernel: [10642.585540][T24161]  ? __asan_loadN+0xf/0x20
	Sep  1 04:48:49 regress kernel: [10642.586229][T24161]  ? __asan_loadN+0xf/0x20
	Sep  1 04:48:49 regress kernel: [10642.586920][T24161]  ? btrfs_ioctl_get_supported_features+0x30/0x30
	Sep  1 04:48:49 regress kernel: [10642.587935][T24161]  ? __asan_loadN+0xf/0x20
	Sep  1 04:48:49 regress kernel: [10642.588649][T24161]  ? pvclock_clocksource_read+0xeb/0x190
	Sep  1 04:48:49 regress kernel: [10642.589566][T24161]  ? __asan_loadN+0xf/0x20
	Sep  1 04:48:49 regress kernel: [10642.590254][T24161]  ? pvclock_clocksource_read+0xeb/0x190
	Sep  1 04:48:49 regress kernel: [10642.591128][T24161]  ? __kasan_check_read+0x11/0x20
	Sep  1 04:48:49 regress kernel: [10642.591913][T24161]  ? check_chain_key+0x1e6/0x2e0
	Sep  1 04:48:49 regress kernel: [10642.592707][T24161]  ? __asan_loadN+0xf/0x20
	Sep  1 04:48:49 regress kernel: [10642.593409][T24161]  ? pvclock_clocksource_read+0xeb/0x190
	Sep  1 04:48:49 regress kernel: [10642.594312][T24161]  ? kvm_sched_clock_read+0x18/0x30
	Sep  1 04:48:49 regress kernel: [10642.595139][T24161]  ? check_chain_key+0x1e6/0x2e0
	Sep  1 04:48:49 regress kernel: [10642.595929][T24161]  ? sched_clock_cpu+0x1b/0x120
	Sep  1 04:48:49 regress kernel: [10642.596712][T24161]  do_vfs_ioctl+0x13e/0xad0
	Sep  1 04:48:49 regress kernel: [10642.597432][T24161]  ? btrfs_ioctl_get_supported_features+0x30/0x30
	Sep  1 04:48:49 regress kernel: [10642.598455][T24161]  ? do_vfs_ioctl+0x13e/0xad0
	Sep  1 04:48:49 regress kernel: [10642.599202][T24161]  ? compat_ioctl_preallocate+0x170/0x170
	Sep  1 04:48:49 regress kernel: [10642.600128][T24161]  ? __kasan_check_write+0x14/0x20
	Sep  1 04:48:49 regress kernel: [10642.600949][T24161]  ? up_read+0x176/0x4f0
	Sep  1 04:48:49 regress kernel: [10642.601648][T24161]  ? down_write_nested+0x2d0/0x2d0
	Sep  1 04:48:49 regress kernel: [10642.602476][T24161]  ? handle_mm_fault+0x211/0x480
	Sep  1 04:48:49 regress kernel: [10642.603263][T24161]  ? __kasan_check_read+0x11/0x20
	Sep  1 04:48:49 regress kernel: [10642.604062][T24161]  ? __fget_light+0xb2/0x110
	Sep  1 04:48:49 regress kernel: [10642.604805][T24161]  ksys_ioctl+0x67/0x90
	Sep  1 04:48:49 regress kernel: [10642.605471][T24161]  __x64_sys_ioctl+0x43/0x50
	Sep  1 04:48:49 regress kernel: [10642.606203][T24161]  do_syscall_64+0x77/0x2d0
	Sep  1 04:48:49 regress kernel: [10642.606933][T24161]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
	Sep  1 04:48:49 regress kernel: [10642.607875][T24161] RIP: 0033:0x7f03f493b427
	Sep  1 04:48:49 regress kernel: [10642.608588][T24161] Code: 00 00 90 48 8b 05 69 aa 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 aa 0c 00 f7 d8 64 89 01 48
	Sep  1 04:48:49 regress kernel: [10642.611697][T24161] RSP: 002b:00007ffd6bd78fb8 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
	Sep  1 04:48:49 regress kernel: [10642.613035][T24161] RAX: ffffffffffffffda RBX: 00007ffd6bd79058 RCX: 00007f03f493b427
	Sep  1 04:48:49 regress kernel: [10642.614313][T24161] RDX: 00007ffd6bd79058 RSI: 00000000c4009420 RDI: 0000000000000003
	Sep  1 04:48:49 regress kernel: [10642.615605][T24161] RBP: 0000000000000003 R08: 0000000000000003 R09: 0000000000000078
	Sep  1 04:48:49 regress kernel: [10642.616877][T24161] R10: fffffffffffff5ab R11: 0000000000000206 R12: 0000000000000001
	Sep  1 04:48:49 regress kernel: [10642.618132][T24161] R13: 0000000000000000 R14: 00007ffd6bd7aa46 R15: 0000000000000001
	Sep  1 04:48:49 regress kernel: [10642.619378][T24161] Modules linked in:
	Sep  1 04:48:49 regress kernel: [10642.620153][T24161] ---[ end trace a33c17a7d43dd973 ]---

