Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED192DE76D
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Dec 2020 17:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgLRQ0f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Dec 2020 11:26:35 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:33158 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbgLRQ0f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Dec 2020 11:26:35 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id A5525903553; Fri, 18 Dec 2020 11:25:53 -0500 (EST)
Date:   Fri, 18 Dec 2020 11:25:53 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v7 00/38] Cleanup error handling in relocation
Message-ID: <20201218162553.GQ31381@hungrycats.org>
References: <cover.1608135849.git.josef@toxicpanda.com>
 <20201216195603.GP31381@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216195603.GP31381@hungrycats.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 16, 2020 at 02:56:03PM -0500, Zygo Blaxell wrote:
> On Wed, Dec 16, 2020 at 11:26:16AM -0500, Josef Bacik wrote:
> > v6->v7:
> > - Broke up the series into 3 series, 1 for cosmetic things, 1 for all the major
> >   issues (including those reported on v6 of this set), and this new set which is
> >   solely the error handling related patches for relocation.  It's still a lot of
> >   patches, sorry about that.
> 
> So far it lockdepped, but it is still running:
> 
> 	[Wed Dec 16 13:30:45 2020] irq event stamp: 5875656

...and now it's dead, looks like tree mod log strikes again:

	[145504.989768][ T3280] BTRFS info (device dm-0): found 13271 extents, loops 2, stage: update data pointers
	[145622.222898][ T3280] avg_delayed_ref_runtime = 743782, time = 772386615466, count = 1038457
	[145664.364729][ T4659] ------------[ cut here ]------------
	[145664.373144][ T4659] kernel BUG at fs/btrfs/ctree.c:1208!
	[145664.377059][ T4659] invalid opcode: 0000 [#1] SMP KASAN PTI
	[145664.379909][ T4659] CPU: 1 PID: 4659 Comm: crawl_258 Tainted: G        W         5.10.0-39fbe74d1bbc-josef+ #1
	[145664.383114][ T4659] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
	[145664.386201][ T4659] RIP: 0010:__tree_mod_log_rewind+0x3b1/0x3c0
	[145664.388238][ T4659] Code: 05 48 8d 74 10 65 ba 19 00 00 00 e8 49 e7 06 00 e9 a7 fd ff ff 4c 8d 7b 2c 4c 89 ff e8 f8 3e c9 ff 48 63 43 2c e9 a2 fe ff ff <0f> 0b 0f 0b 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 48
	[145664.394705][ T4659] RSP: 0018:ffffc90001c870e8 EFLAGS: 00010297
	[145664.396777][ T4659] RAX: 0000000000000000 RBX: ffff888004946f00 RCX: ffffffff978792f6
	[145664.399482][ T4659] RDX: 0000000000000007 RSI: dffffc0000000000 RDI: ffff888004946f2c
	[145664.402117][ T4659] RBP: ffffc90001c87138 R08: 1ffff1100da2481c R09: ffffed100da2481c
	[145664.404763][ T4659] R10: ffff88806d1240d8 R11: ffffed100da2481b R12: 000000000000000b
	[145664.407401][ T4659] R13: ffff888062123000 R14: ffff88800f6a7a00 R15: ffff888004946f2c
	[145664.410047][ T4659] FS:  00007f0c92e1f700(0000) GS:ffff8881f5600000(0000) knlGS:0000000000000000
	[145664.413001][ T4659] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	[145664.415177][ T4659] CR2: 00007fc867df6100 CR3: 00000001038e0004 CR4: 0000000000170ee0
	[145664.417822][ T4659] Call Trace:
	[145664.418935][ T4659]  btrfs_search_old_slot+0x265/0x10d0
	[145664.420747][ T4659]  ? lock_acquired+0xbb/0x5e0
	[145664.422335][ T4659]  ? btrfs_search_slot+0x1090/0x1090
	[145664.424102][ T4659]  ? free_extent_buffer.part.53+0xd7/0x140
	[145664.426077][ T4659]  ? free_extent_buffer+0x13/0x20
	[145664.427810][ T4659]  resolve_indirect_refs+0x3e9/0xfc0
	[145664.429610][ T4659]  ? down_write_nested+0x2d0/0x2d0
	[145664.431310][ T4659]  ? __kasan_check_read+0x11/0x20
	[145664.432998][ T4659]  ? __kasan_check_read+0x11/0x20
	[145664.434654][ T4659]  ? add_prelim_ref.part.12+0x150/0x150
	[145664.436511][ T4659]  ? lock_downgrade+0x3f0/0x3f0
	[145664.438140][ T4659]  ? __kasan_check_read+0x11/0x20
	[145664.439818][ T4659]  ? lock_acquired+0xbb/0x5e0
	[145664.441384][ T4659]  ? free_extent_buffer.part.53+0xb1/0x140
	[145664.443416][ T4659]  ? do_raw_spin_unlock+0xa8/0x140
	[145664.445231][ T4659]  ? rb_insert_color+0x310/0x360
	[145664.446928][ T4659]  ? prelim_ref_insert+0x12d/0x430
	[145664.448694][ T4659]  find_parent_nodes+0x5c3/0x1830
	[145664.450439][ T4659]  ? resolve_indirect_refs+0xfc0/0xfc0
	[145664.452355][ T4659]  ? iterate_inodes_from_logical+0x129/0x170
	[145664.454282][ T4659]  ? btrfs_ioctl+0x237e/0x4360
	[145664.457750][ T4659]  ? __x64_sys_ioctl+0xc3/0x100
	[145664.459969][ T4659]  ? do_syscall_64+0x37/0x80
	[145664.462279][ T4659]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
	[145664.465078][ T4659]  ? resolve_indirect_refs+0xf90/0xfc0
	[145664.467560][ T4659]  ? __kasan_check_read+0x11/0x20
	[145664.471069][ T4659]  ? kasan_unpoison_shadow+0x35/0x50
	[145664.472861][ T4659]  ? trace_hardirqs_on+0x55/0x120
	[145664.474528][ T4659]  btrfs_find_all_roots_safe+0x142/0x1e0
	[145664.476661][ T4659]  ? find_parent_nodes+0x1830/0x1830
	[145664.478378][ T4659]  ? btrfs_inode_flags_to_xflags+0x50/0x50
	[145664.480274][ T4659]  iterate_extent_inodes+0x20e/0x580
	[145664.481995][ T4659]  ? tree_backref_for_extent+0x230/0x230
	[145664.483514][ T4659]  ? release_extent_buffer+0x225/0x280
	[145664.485246][ T4659]  ? read_extent_buffer+0xdd/0x110
	[145664.486916][ T4659]  ? lock_downgrade+0x3f0/0x3f0
	[145664.490569][ T4659]  ? __kasan_check_read+0x11/0x20
	[145664.492257][ T4659]  ? lock_acquired+0xbb/0x5e0
	[145664.493876][ T4659]  ? free_extent_buffer.part.53+0xb1/0x140
	[145664.495842][ T4659]  ? do_raw_spin_unlock+0xa8/0x140
	[145664.497540][ T4659]  ? _raw_spin_unlock+0x22/0x30
	[145664.499181][ T4659]  ? release_extent_buffer+0x225/0x280
	[145664.501022][ T4659]  iterate_inodes_from_logical+0x129/0x170
	[145664.502926][ T4659]  ? iterate_inodes_from_logical+0x129/0x170
	[145664.505126][ T4659]  ? btrfs_inode_flags_to_xflags+0x50/0x50
	[145664.507147][ T4659]  ? iterate_extent_inodes+0x580/0x580
	[145664.509104][ T4659]  ? __vmalloc_node+0x92/0xb0
	[145664.510806][ T4659]  ? init_data_container+0x34/0xb0
	[145664.512612][ T4659]  ? init_data_container+0x34/0xb0
	[145664.514452][ T4659]  ? kvmalloc_node+0x60/0x80
	[145664.516057][ T4659]  btrfs_ioctl_logical_to_ino+0x139/0x1e0
	[145664.518043][ T4659]  btrfs_ioctl+0x237e/0x4360
	[145664.519622][ T4659]  ? __kasan_check_write+0x14/0x20
	[145664.521403][ T4659]  ? mmput+0x3b/0x220
	[145664.522780][ T4659]  ? btrfs_ioctl_get_supported_features+0x30/0x30
	[145664.525000][ T4659]  ? __kasan_check_read+0x11/0x20
	[145664.526713][ T4659]  ? lock_release+0xc8/0x640
	[145664.528308][ T4659]  ? __might_fault+0x64/0xd0
	[145664.529894][ T4659]  ? __kasan_check_read+0x11/0x20
	[145664.531564][ T4659]  ? lock_downgrade+0x3f0/0x3f0
	[145664.533187][ T4659]  ? check_flags+0x30/0x30
	[145664.534701][ T4659]  ? check_flags+0x30/0x30
	[145664.536227][ T4659]  ? __kasan_check_read+0x11/0x20
	[145664.537952][ T4659]  ? lock_release+0xc8/0x640
	[145664.539497][ T4659]  ? do_vfs_ioctl+0xfc/0x9d0
	[145664.541020][ T4659]  ? __fget_files+0x151/0x250
	[145664.542641][ T4659]  ? ioctl_file_clone+0xe0/0xe0
	[145664.544304][ T4659]  ? lock_downgrade+0x3f0/0x3f0
	[145664.545917][ T4659]  ? check_flags+0x30/0x30
	[145664.547160][ T4659]  ? __kasan_check_read+0x11/0x20
	[145664.548782][ T4659]  ? lock_release+0xc8/0x640
	[145664.550404][ T4659]  ? __task_pid_nr_ns+0xd3/0x250
	[145664.553313][ T4659]  ? __kasan_check_read+0x11/0x20
	[145664.555669][ T4659]  ? __fget_files+0x170/0x250
	[145664.557893][ T4659]  ? __fget_light+0xf2/0x110
	[145664.560061][ T4659]  __x64_sys_ioctl+0xc3/0x100
	[145664.562178][ T4659]  do_syscall_64+0x37/0x80
	[145664.563689][ T4659]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
	[145664.565964][ T4659] RIP: 0033:0x7f0c94f19427
	[145664.567420][ T4659] Code: 00 00 90 48 8b 05 69 aa 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 aa 0c 00 f7 d8 64 89 01 48
	[145664.574088][ T4659] RSP: 002b:00007f0c92e1cca8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
	[145664.577078][ T4659] RAX: ffffffffffffffda RBX: 00007f0c92e1cee0 RCX: 00007f0c94f19427
	[145664.579999][ T4659] RDX: 00007f0c92e1cee8 RSI: 00000000c038943b RDI: 0000000000000004
	[145664.582957][ T4659] RBP: 0000000001000000 R08: 0000000000000000 R09: 00007f0c92e1d0c0
	[145664.585592][ T4659] R10: 000055b378eb9c40 R11: 0000000000000246 R12: 0000000000000004
	[145664.588153][ T4659] R13: 00007f0c92e1cee8 R14: 00007f0c92e1cff0 R15: 00007f0c92e1cee0
	[145664.591569][ T4659] Modules linked in:
	[145664.592962][ T4659] ---[ end trace 21a31c4983711212 ]---
	[145664.594870][ T4659] RIP: 0010:__tree_mod_log_rewind+0x3b1/0x3c0
	[145664.597141][ T4659] Code: 05 48 8d 74 10 65 ba 19 00 00 00 e8 49 e7 06 00 e9 a7 fd ff ff 4c 8d 7b 2c 4c 89 ff e8 f8 3e c9 ff 48 63 43 2c e9 a2 fe ff ff <0f> 0b 0f 0b 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 48
	[145664.604814][ T4659] RSP: 0018:ffffc90001c870e8 EFLAGS: 00010297
	[145664.606882][ T4659] RAX: 0000000000000000 RBX: ffff888004946f00 RCX: ffffffff978792f6
	[145664.611246][ T4659] RDX: 0000000000000007 RSI: dffffc0000000000 RDI: ffff888004946f2c
	[145664.613859][ T4659] RBP: ffffc90001c87138 R08: 1ffff1100da2481c R09: ffffed100da2481c
	[145664.617160][ T4659] R10: ffff88806d1240d8 R11: ffffed100da2481b R12: 000000000000000b
	[145664.619988][ T4659] R13: ffff888062123000 R14: ffff88800f6a7a00 R15: ffff888004946f2c
	[145664.622597][ T4659] FS:  00007f0c92e1f700(0000) GS:ffff8881f5600000(0000) knlGS:0000000000000000
	[145664.625590][ T4659] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	[145664.627890][ T4659] CR2: 00007fc867df6100 CR3: 00000001038e0004 CR4: 0000000000170ee0
	[145664.630639][ T4659] note: crawl_258[4659] exited with preempt_count 1

