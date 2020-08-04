Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0638023BDE6
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Aug 2020 18:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgHDQQp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Aug 2020 12:16:45 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:42168 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729328AbgHDQQi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Aug 2020 12:16:38 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 8C66D7979AA; Tue,  4 Aug 2020 12:16:26 -0400 (EDT)
Date:   Tue, 4 Aug 2020 12:16:26 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        wqu@suse.com
Subject: Re: BUG at fs/btrfs/relocation.c:794!
Message-ID: <20200804161626.GN5890@hungrycats.org>
References: <20200630221006.17585-1-dsterba@suse.com>
 <20200723215641.GE5890@hungrycats.org>
 <bfecfacd-2d9d-386d-dfb7-951a5c5c6f6e@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bfecfacd-2d9d-386d-dfb7-951a5c5c6f6e@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 24, 2020 at 08:19:36AM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/7/24 上午5:56, Zygo Blaxell wrote:
> > On Wed, Jul 01, 2020 at 12:10:06AM +0200, David Sterba wrote:
> >> Hi,
> >>
> >> I've hit a crash in relocation I've never seen before.
> >>
> >> [ 2129.210066] kernel BUG at fs/btrfs/relocation.c:794!
> > 
> > I hit an issue yesterday that reminded me of this.
> > 
> >> [ 2129.215268] invalid opcode: 0000 [#1] PREEMPT SMP
> >> [ 2129.220114] CPU: 1 PID: 3303 Comm: btrfs Not tainted 5.8.0-rc3-git+ #638
> >> [ 2129.220116] Hardware name: empty empty/S3993, BIOS PAQEX0-3 02/24/2008
> >> [ 2129.220265] RIP: 0010:create_reloc_root+0x214/0x260 [btrfs]
> >> [ 2129.258760] RSP: 0018:ffffbe1e809b38b8 EFLAGS: 00010282
> >> [ 2129.258763] RAX: 00000000ffffffef RBX: ffff988d577f9000 RCX: 0000000000000000
> >> [ 2129.258765] RDX: 0000000000000001 RSI: ffffffff8e2a2580 RDI: ffff988d64aaa6a8
> >> [ 2129.258766] RBP: ffff988d5dfcdc00 R08: 0000000000000000 R09: 0000000000000000
> >> [ 2129.258767] R10: 0000000000000001 R11: 0000000000000000 R12: ffff988d0e02fa78
> >> [ 2129.258769] R13: 0000000000000005 R14: ffff988d64fe8000 R15: ffff988d0e02fa78
> >> [ 2129.258771] FS:  00007f82a612e8c0(0000) GS:ffff988d67000000(0000) knlGS:0000000000000000
> >> [ 2129.258772] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> [ 2129.258774] CR2: 000000000559d028 CR3: 000000020b289000 CR4: 00000000000006e0
> >> [ 2129.258775] Call Trace:
> >> [ 2129.258825]  btrfs_init_reloc_root+0xe8/0x120 [btrfs]
> >> [ 2129.258862]  record_root_in_trans+0xae/0xd0 [btrfs]
> >> [ 2129.258901]  btrfs_record_root_in_trans+0x51/0x70 [btrfs]
> >> [ 2129.340388]  select_reloc_root+0x94/0x340 [btrfs]
> >> [ 2129.340433]  do_relocation+0xda/0x7b0 [btrfs]
> >> [ 2129.349854]  ? _raw_spin_unlock+0x1f/0x40
> >> [ 2129.349898]  relocate_tree_blocks+0x336/0x670 [btrfs]
> >> [ 2129.359325]  relocate_block_group+0x2f6/0x600 [btrfs]
> >> [ 2129.359365]  btrfs_relocate_block_group+0x15e/0x340 [btrfs]
> >> [ 2129.359408]  btrfs_relocate_chunk+0x38/0x110 [btrfs]
> >> [ 2129.375494]  __btrfs_balance+0x42c/0xce0 [btrfs]
> >> [ 2129.375553]  btrfs_balance+0x66a/0xbe0 [btrfs]
> >> [ 2129.375562]  ? kmem_cache_alloc_trace+0x19c/0x330
> >> [ 2129.389852]  btrfs_ioctl_balance+0x298/0x350 [btrfs]
> >> [ 2129.389887]  btrfs_ioctl+0x304/0x2490 [btrfs]
> >> [ 2129.389898]  ? do_user_addr_fault+0x221/0x49c
> >> [ 2129.404070]  ? sched_clock_cpu+0x15/0x140
> >> [ 2129.404073]  ? do_user_addr_fault+0x221/0x49c
> >> [ 2129.404079]  ? up_read+0x18/0x240
> >> [ 2129.404086]  ? ksys_ioctl+0x68/0xa0
> >> [ 2129.404091]  ksys_ioctl+0x68/0xa0
> >> [ 2129.423308]  __x64_sys_ioctl+0x16/0x20
> >> [ 2129.423312]  do_syscall_64+0x50/0xe0
> >> [ 2129.423315]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >> [ 2129.423318] RIP: 0033:0x7f82a51c6327
> >> [ 2129.423319] Code: Bad RIP value.
> >> [ 2129.423348] RSP: 002b:00007ffd32cf6218 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
> >> [ 2129.423367] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f82a51c6327
> >> [ 2129.423368] RDX: 00007ffd32cf62a0 RSI: 00000000c4009420 RDI: 0000000000000003
> >> [ 2129.423372] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
> >> [ 2129.423377] R10: 000000000fa99fa0 R11: 0000000000000206 R12: 00007ffd32cf8823
> >> [ 2129.423379] R13: 00007ffd32cf62a0 R14: 0000000000000001 R15: 0000000000000000
> >>
> >> Relevant code called from create_reloc_root:
> >>
> >>         ret = btrfs_insert_root(trans, fs_info->tree_root,
> >>                                 &root_key, root_item);
> >>         BUG_ON(ret)
> >>
> >> and according to EAX, ret is -17 which is EEXIST.
> >>
> >> I don't have a reproducer, the testing image has been filled by random git
> >> checkouts, deduplicated by BEES, then tons of snapshots created until the
> >> metadata got exhausted, some file deletion and balances.
> > 
> > Mine is rsync, bees, lots of snapshots, balances, scrubs.  I recently also
> > added random 'killall -INT btrfs' to send balance some fatal signals.
> > 
> >> This is the same image that led to the patch "btrfs: allow use of global block
> >> reserve for balance item deletion", so this could have left it in some
> >> intermediate state where the balance item was not removed and the reloc tree as
> >> well.
> >>
> >> There were a few unsuccessful mounts due to relocation recovery, that was
> >> trying to debug but then it started to work.
> >>
> >> The error happened with this 'fi df' saved after the balance start:
> >>
> >> # btrfs fi df mnt
> >> Data, single: total=80.01GiB, used=38.67GiB
> >> System, single: total=4.00MiB, used=16.00KiB
> >> Metadata, single: total=19.99GiB, used=19.46GiB
> >> GlobalReserve, single: total=512.00MiB, used=44.00KiB
> > 
> > Mine is:
> > 
> > 	Data, single: total=1.75TiB, used=1.74TiB
> > 	System, RAID1: total=32.00MiB, used=208.00KiB
> > 	Metadata, RAID1: total=25.00GiB, used=22.89GiB
> > 	GlobalReserve, single: total=512.00MiB, used=0.00B
> > 
> > though this is some time after the failure (and a reboot).  I do notice
> > that there's lots of unallocated space, but metadata usage is close
> > to allocated, and I have been experiencing a lot of EROFS events when
> > that happens, even if there's gigabytes unallocated.
> > 
> > btrfs fi us:
> > 
> > 	Overall:
> > 	    Device size:                   2.00TiB
> > 	    Device allocated:              1.80TiB
> > 	    Device unallocated:          208.94GiB
> > 	    Device missing:                  0.00B
> > 	    Used:                          1.79TiB
> > 	    Free (estimated):            211.30GiB      (min: 106.83GiB)
> > 	    Data ratio:                       1.00
> > 	    Metadata ratio:                   2.00
> > 	    Global reserve:              512.00MiB      (used: 0.00B)
> > 
> > 	Data,single: Size:1.75TiB, Used:1.74TiB (99.87%)
> > 	   /dev/mapper/vgtest-tvdb        894.00GiB
> > 	   /dev/mapper/vgtest-tvdc        895.00GiB
> > 
> > 	Metadata,RAID1: Size:25.00GiB, Used:22.87GiB (91.47%)
> > 	   /dev/mapper/vgtest-tvdb         25.00GiB
> > 	   /dev/mapper/vgtest-tvdc         25.00GiB
> > 
> > 	System,RAID1: Size:32.00MiB, Used:208.00KiB (0.63%)
> > 	   /dev/mapper/vgtest-tvdb         32.00MiB
> > 	   /dev/mapper/vgtest-tvdc         32.00MiB
> > 
> > 	Unallocated:
> > 	   /dev/mapper/vgtest-tvdb        104.97GiB
> > 	   /dev/mapper/vgtest-tvdc        103.97GiB
> > 
> >> The error looks like a repeated relocation tree creation, which would point to
> >> the unsuccesful balances or inconsistent state (balance item, reloc trees).
> >> It's not a "typical" mix of operations but I'd appreciate any insights here.
> > 
> > I have the same line but different call stack, with misc-next
> > e3027d10af42d24940be74dabaf1550cd770bd48:
> > 
> > 	[ 9717.746937][T13609] BTRFS info (device dm-0): balance: start -mlimit=1 -slimit=1
> > 	[ 9717.765086][T13609] BTRFS info (device dm-0): relocating block group 10991411658752 flags metadata|raid1
> > 	[ 9718.511137][T13609] ------------[ cut here ]------------
> > 	[ 9718.512293][T13609] kernel BUG at fs/btrfs/relocation.c:794!
> > 	[ 9718.513421][T13609] invalid opcode: 0000 [#1] SMP KASAN PTI
> > 	[ 9718.514590][T13609] CPU: 1 PID: 13609 Comm: btrfs Tainted: G        W         5.8.0-6582a95aabfe+ #44
> > 	[ 9718.516178][T13609] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> > 	[ 9718.517750][T13609] RIP: 0010:create_reloc_root+0x468/0x480
> > 	[ 9718.518717][T13609] Code: e8 bd 5b bd ff 4d 8b 76 50 be 08 00 00 00 49 8d bc 24 f0 00 00 00 e8 c7 5b bd ff 4d 89 b4 24 f0 00 00 00 e9 ee fc ff ff 0f 0b <0f> 0b 0f 0b 0f 0b 0f 0b 
> > 	e8 9b df 07 01 66 66 2e 0f 1f 84 00 00 00
> > 	[ 9718.521995][T13609] RSP: 0018:ffffc900018e7018 EFLAGS: 00010282
> > 	[ 9718.522991][T13609] RAX: 00000000ffffffef RBX: ffff8881e103a400 RCX: 0000000000000000
> > 	[ 9718.524300][T13609] RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000246
> > 	[ 9718.525612][T13609] RBP: ffffc900018e7108 R08: 0000000000000000 R09: 0000000000000001
> > 	[ 9718.527056][T13609] R10: 0000000000000001 R11: fffffbfff3dfb081 R12: ffff8881f37c8020
> > 	[ 9718.528386][T13609] R13: ffff88801fbc5b28 R14: ffff8881f37c8000 R15: ffffc900018e70a0
> > 	[ 9718.529756][T13609] FS:  00007f9577d928c0(0000) GS:ffff8881f5800000(0000) knlGS:0000000000000000
> > 	[ 9718.531211][T13609] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > 	[ 9718.532295][T13609] CR2: 00007f9823e35500 CR3: 00000000a52e0002 CR4: 00000000001606e0
> > 	[ 9718.533608][T13609] Call Trace:
> > 	[ 9718.534151][T13609]  ? update_backref_node+0xf0/0xf0
> > 	[ 9718.535137][T13609]  ? check_chain_key+0x1e6/0x2e0
> > 	[ 9718.536057][T13609]  btrfs_init_reloc_root+0x2d7/0x310
> 
> That's the same problem.
> 
> Btrfs_init_reloc_root() got -EEXIST and triggering BUG_ON().
> 
> In that case, that means there are some reloc trees not cleaned up.
> 
> Would you mind to provide the "btrfs ins dump-tree -t root" dump for
> that fs if the problem still happens?

http://furryterror.org/~zblaxell/tmp/.tvdb/tvdb.txt

The problem is now happening multiple times per day, starting with
kdave's misc-next e3027d10af42d24940be74dabaf1550cd770bd48 Date:  Thu
Jul 23 00:18:04 2020 +0900 and continuing on v5.8.0.

The previous misc-next (that I have test data for),
cb799f0a0bb372f37f96893d2e80c1dc2f5206da Date: Thu Jul 16 13:29:46 2020
-0700 does not have this problem.

These commit hashes are from https://gitlab.com/kdave/btrfs-devel.


> Thanks,
> Qu
> > 	[ 9718.537016][T13609]  ? find_reloc_root+0x200/0x200
> > 	[ 9718.537992][T13609]  ? do_raw_spin_unlock+0xa8/0x140
> > 	[ 9718.538899][T13609]  record_root_in_trans+0x18c/0x1d0
> > 	[ 9718.539848][T13609]  btrfs_record_root_in_trans+0x8b/0xc0
> > 	[ 9718.540843][T13609]  select_reloc_root+0x15f/0x6a0
> > 	[ 9718.541943][T13609]  ? create_reloc_inode.isra.28+0x410/0x410
> > 	[ 9718.543066][T13609]  ? rcu_read_lock_sched_held+0xa1/0xd0
> > 	[ 9718.544333][T13609]  ? check_flags.part.44+0x86/0x220
> > 	[ 9718.545186][T13609]  ? check_flags+0x26/0x30
> > 	[ 9718.545870][T13609]  ? lock_is_held_type+0xc9/0x100
> > 	[ 9718.546651][T13609]  do_relocation+0x242/0xc90
> > 	[ 9718.547372][T13609]  ? select_reloc_root+0x6a0/0x6a0
> > 	[ 9718.548160][T13609]  ? check_flags.part.44+0x86/0x220
> > 	[ 9718.548969][T13609]  ? __kasan_check_read+0x11/0x20
> > 	[ 9718.549745][T13609]  ? mark_lock+0xa8/0x440
> > 	[ 9718.550426][T13609]  ? mark_held_locks+0x8d/0xb0
> > 	[ 9718.551165][T13609]  ? btrfs_backref_cleanup_node+0x5c1/0x600
> > 	[ 9718.552079][T13609]  ? memcpy+0x4d/0x60
> > 	[ 9718.552694][T13609]  ? read_extent_buffer+0xcc/0x120
> > 	[ 9718.553478][T13609]  relocate_tree_blocks+0xa29/0xb00
> > 	[ 9718.554255][T13609]  ? do_relocation+0xc90/0xc90
> > 	[ 9718.554978][T13609]  ? kmem_cache_alloc_trace+0x5af/0x740
> > 	[ 9718.555855][T13609]  ? free_extent_buffer.part.46+0x90/0x140
> > 	[ 9718.556756][T13609]  ? rb_insert_color+0x342/0x360
> > 	[ 9718.557581][T13609]  ? free_extent_buffer+0x13/0x20
> > 	[ 9718.558445][T13609]  ? add_tree_block.isra.34+0x236/0x2b0
> > 	[ 9718.559387][T13609]  relocate_block_group+0x52e/0x830
> > 	[ 9718.560275][T13609]  ? merge_reloc_roots+0x4b0/0x4b0
> > 	[ 9718.561137][T13609]  btrfs_relocate_block_group+0x26e/0x4c0
> > 	[ 9718.562137][T13609]  btrfs_relocate_chunk+0x52/0x120
> > 	[ 9718.562918][T13609]  btrfs_balance+0xe22/0x1910
> > 	[ 9718.563605][T13609]  ? check_chain_key+0x1e6/0x2e0
> > 	[ 9718.564331][T13609]  ? btrfs_relocate_chunk+0x120/0x120
> > 	[ 9718.565126][T13609]  ? kmem_cache_alloc_trace+0x5af/0x740
> > 	[ 9718.565943][T13609]  ? _copy_from_user+0x95/0xd0
> > 	[ 9718.566649][T13609]  btrfs_ioctl_balance+0x3de/0x4c0
> > 	[ 9718.567414][T13609]  btrfs_ioctl+0x2385/0x4250
> > 	[ 9718.568090][T13609]  ? __kasan_check_read+0x11/0x20
> > 	[ 9718.568830][T13609]  ? check_chain_key+0x1e6/0x2e0
> > 	[ 9718.569619][T13609]  ? btrfs_ioctl_get_supported_features+0x30/0x30
> > 	[ 9718.570658][T13609]  ? kvm_sched_clock_read+0x18/0x30
> > 	[ 9718.571526][T13609]  ? check_chain_key+0x1e6/0x2e0
> > 	[ 9718.572348][T13609]  ? lock_downgrade+0x3e0/0x3e0
> > 	[ 9718.573121][T13609]  ? do_vfs_ioctl+0xfc/0x9d0
> > 	[ 9718.573835][T13609]  ? ioctl_file_clone+0xe0/0xe0
> > 	[ 9718.574637][T13609]  ? check_flags.part.44+0x86/0x220
> > 	[ 9718.575472][T13609]  ? check_flags+0x26/0x30
> > 	[ 9718.576190][T13609]  ? lock_is_held_type+0xc9/0x100
> > 	[ 9718.576990][T13609]  ? check_flags.part.44+0x86/0x220
> > 	[ 9718.577836][T13609]  ? check_flags+0x26/0x30
> > 	[ 9718.578542][T13609]  ? lock_is_held_type+0xc9/0x100
> > 	[ 9718.579403][T13609]  ? __kasan_check_read+0x11/0x20
> > 	[ 9718.580225][T13609]  ? __fget_light+0xae/0x110
> > 	[ 9718.580983][T13609]  ksys_ioctl+0xa1/0xe0
> > 	[ 9718.581628][T13609]  __x64_sys_ioctl+0x43/0x50
> > 	[ 9718.582334][T13609]  do_syscall_64+0x60/0xf0
> > 	[ 9718.583285][T13609]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > 	[ 9718.584378][T13609] RIP: 0033:0x7f9577e85427
> > 	[ 9718.585289][T13609] Code: Bad RIP value.
> > 	[ 9718.586076][T13609] RSP: 002b:00007ffdc7b82548 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
> > 	[ 9718.587896][T13609] RAX: ffffffffffffffda RBX: 00007ffdc7b825e8 RCX: 00007f9577e85427
> > 	[ 9718.589391][T13609] RDX: 00007ffdc7b825e8 RSI: 00000000c4009420 RDI: 0000000000000003
> > 	[ 9718.590817][T13609] RBP: 0000000000000003 R08: 0000000000000003 R09: 0000000000000078
> > 	[ 9718.592631][T13609] R10: fffffffffffff31c R11: 0000000000000206 R12: 0000000000000001
> > 	[ 9718.594405][T13609] R13: 0000000000000000 R14: 00007ffdc7b84a48 R15: 0000000000000001
> > 	[ 9718.596109][T13609] Modules linked in:
> > 	[ 9718.597056][T13609] ---[ end trace 2cf173f8217fc093 ]---
> > 	[ 9718.598018][T13609] RIP: 0010:create_reloc_root+0x468/0x480
> > 	[ 9718.602850][T13609] Code: e8 bd 5b bd ff 4d 8b 76 50 be 08 00 00 00 49 8d bc 24 f0 00 00 00 e8 c7 5b bd ff 4d 89 b4 24 f0 00 00 00 e9 ee fc ff ff 0f 0b <0f> 0b 0f 0b 0f 0b 0f 0b e8 9b df 07 01 66 66 2e 0f 1f 84 00 00 00
> > 	[ 9718.613371][T13609] RSP: 0018:ffffc900018e7018 EFLAGS: 00010282
> > 	[ 9718.621286][T13609] RAX: 00000000ffffffef RBX: ffff8881e103a400 RCX: 0000000000000000
> > 	[ 9718.631255][T13609] RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000246
> > 	[ 9718.639764][T13609] RBP: ffffc900018e7108 R08: 0000000000000000 R09: 0000000000000001
> > 	[ 9718.641533][T13609] R10: 0000000000000001 R11: fffffbfff3dfb081 R12: ffff8881f37c8020
> > 	[ 9718.643173][T13609] R13: ffff88801fbc5b28 R14: ffff8881f37c8000 R15: ffffc900018e70a0
> > 	[ 9718.644840][T13609] FS:  00007f9577d928c0(0000) GS:ffff8881f5800000(0000) knlGS:0000000000000000
> > 	[ 9718.646728][T13609] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > 	[ 9718.648607][T13609] CR2: 00007f9823e35500 CR3: 00000000a52e0002 CR4: 00000000001606e0
> > 	[ 9718.869689][ T4545] ==================================================================
> > 
> > same line, different call stack:
> > 
> > 	0xffffffff81933dd8 is in create_reloc_root (fs/btrfs/relocation.c:794).
> > 	789             btrfs_tree_unlock(eb);
> > 	790             free_extent_buffer(eb);
> > 	791
> > 	792             ret = btrfs_insert_root(trans, fs_info->tree_root,
> > 	793                                     &root_key, root_item);
> > 	794             BUG_ON(ret);
> > 	795             kfree(root_item);
> > 	796
> > 	797             reloc_root = btrfs_read_tree_root(fs_info->tree_root, &root_key);
> > 	798             BUG_ON(IS_ERR(reloc_root));
> > 
> > followed by
> > 
> > 	[ 9718.869689][ T4545] ==================================================================
> > 	[ 9718.871333][ T4545] BUG: KASAN: use-after-free in __mutex_lock+0x202/0xce0
> > 	[ 9718.872483][ T4545] Read of size 4 at addr ffff888014e9402c by task crawl_28443/4545
> > 	[ 9718.873746][ T4545] 
> > 	[ 9718.874106][ T4545] CPU: 1 PID: 4545 Comm: crawl_28443 Tainted: G      D W         5.8.0-6582a95aabfe+ #44
> > 	[ 9718.875684][ T4545] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> > 	[ 9718.877149][ T4545] Call Trace:
> > 	[ 9718.877655][ T4545]  dump_stack+0xc8/0x11a
> > 	[ 9718.878317][ T4545]  ? __mutex_lock+0x202/0xce0
> > 	[ 9718.879065][ T4545]  print_address_description.constprop.8+0x1f/0x200
> > 	[ 9718.880167][ T4545]  ? __mutex_lock+0x202/0xce0
> > 	[ 9718.880916][ T4545]  ? __mutex_lock+0x202/0xce0
> > 	[ 9718.881666][ T4545]  kasan_report.cold.11+0x20/0x3e
> > 	[ 9718.882483][ T4545]  ? __mutex_lock+0x202/0xce0
> > 	[ 9718.883229][ T4545]  __asan_load4+0x69/0x90
> > 	[ 9718.883920][ T4545]  __mutex_lock+0x202/0xce0
> > 	[ 9718.884651][ T4545]  ? wait_current_trans+0xb7/0x230
> > 	[ 9718.885465][ T4545]  ? btrfs_record_root_in_trans+0x7e/0xc0
> > 	[ 9718.886388][ T4545]  ? mutex_lock_io_nested+0xc20/0xc20
> > 	[ 9718.887246][ T4545]  ? __kasan_check_read+0x11/0x20
> > 	[ 9718.888035][ T4545]  ? join_transaction+0x32/0x6f0
> > 	[ 9718.888854][ T4545]  ? join_transaction+0x1a6/0x6f0
> > 	[ 9718.889679][ T4545]  ? lock_downgrade+0x3e0/0x3e0
> > 	[ 9718.890496][ T4545]  ? __kasan_check_write+0x14/0x20
> > 	[ 9718.891308][ T4545]  ? lock_contended+0x720/0x720
> > 	[ 9718.892093][ T4545]  ? do_raw_spin_lock+0x1e0/0x1e0
> > 	[ 9718.892912][ T4545]  ? wait_current_trans+0xb7/0x230
> > 	[ 9718.893705][ T4545]  mutex_lock_nested+0x1b/0x20
> > 	[ 9718.894494][ T4545]  ? mutex_lock_nested+0x1b/0x20
> > 	[ 9718.895317][ T4545]  btrfs_record_root_in_trans+0x7e/0xc0
> > 	[ 9718.896245][ T4545]  start_transaction+0x189/0x8f0
> > 	[ 9718.897081][ T4545]  btrfs_start_transaction+0x1e/0x20
> > 	[ 9718.897941][ T4545]  btrfs_cont_expand+0x549/0x7a0
> > 	[ 9718.898805][ T4545]  ? btrfs_truncate_block+0x930/0x930
> > 	[ 9718.899665][ T4545]  ? inode_newsize_ok+0x75/0xc0
> > 	[ 9718.900438][ T4545]  ? setattr_prepare+0x9c/0x310
> > 	[ 9718.901242][ T4545]  btrfs_setattr+0x514/0x850
> > 	[ 9718.902035][ T4545]  ? current_time+0x8c/0xe0
> > 	[ 9718.902799][ T4545]  notify_change+0x4ec/0x700
> > 	[ 9718.903584][ T4545]  ? do_sys_ftruncate+0x108/0x220
> > 	[ 9718.904459][ T4545]  do_truncate+0xe4/0x160
> > 	[ 9718.905200][ T4545]  ? __x64_sys_openat2+0x170/0x170
> > 	[ 9718.906116][ T4545]  ? __sb_start_write+0x1a1/0x270
> > 	[ 9718.906954][ T4545]  do_sys_ftruncate+0x1b8/0x220
> > 	[ 9718.907759][ T4545]  __x64_sys_ftruncate+0x36/0x40
> > 	[ 9718.908577][ T4545]  do_syscall_64+0x60/0xf0
> > 	[ 9718.909292][ T4545]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > 	[ 9718.910521][ T4545] RIP: 0033:0x7f201fcab947
> > 	[ 9718.911247][ T4545] Code: Bad RIP value.
> > 	[ 9718.911915][ T4545] RSP: 002b:00007f201d3abeb8 EFLAGS: 00000202 ORIG_RAX: 000000000000004d
> > 	[ 9718.913285][ T4545] RAX: ffffffffffffffda RBX: 00007f201d3abfa0 RCX: 00007f201fcab947
> > 	[ 9718.914613][ T4545] RDX: 000000005f18a6d2 RSI: 0000000000286000 RDI: 0000000000000ec1
> > 	[ 9718.915921][ T4545] RBP: 00007f1fb01c2f00 R08: 00007ffe1e345080 R09: 00000000011b1f78
> > 	[ 9718.917236][ T4545] R10: 00000000011b1f78 R11: 0000000000000202 R12: 00007f201d3abf20
> > 	[ 9718.918556][ T4545] R13: 00007f201d3abef0 R14: 00007f201d3abf50 R15: 00007f201d3abed0
> > 	[ 9718.919882][ T4545] 
> > 	[ 9718.920268][ T4545] Allocated by task 6732:
> > 	[ 9718.920973][ T4545]  save_stack+0x21/0x50
> > 	[ 9718.921648][ T4545]  __kasan_kmalloc.constprop.17+0xc1/0xd0
> > 	[ 9718.922580][ T4545]  kasan_slab_alloc+0x12/0x20
> > 	[ 9718.923345][ T4545]  kmem_cache_alloc_node+0x113/0x720
> > 	[ 9718.924203][ T4545]  copy_process+0x357/0x3680
> > 	[ 9718.924955][ T4545]  _do_fork+0xed/0x880
> > 	[ 9718.925622][ T4545]  __do_sys_clone+0xee/0x130
> > 	[ 9718.926369][ T4545]  __x64_sys_clone+0x67/0x80
> > 	[ 9718.927119][ T4545]  do_syscall_64+0x60/0xf0
> > 	[ 9718.927848][ T4545]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > 	[ 9718.928812][ T4545] 
> > 	[ 9718.929173][ T4545] Freed by task 24:
> > 	[ 9718.929787][ T4545]  save_stack+0x21/0x50
> > 	[ 9718.930453][ T4545]  __kasan_slab_free+0x118/0x170
> > 	[ 9718.931242][ T4545]  kasan_slab_free+0xe/0x10
> > 	[ 9718.931970][ T4545]  kmem_cache_free+0x5f/0x280
> > 	[ 9718.932730][ T4545]  free_task+0x73/0x90
> > 	[ 9718.933391][ T4545]  __put_task_struct+0x199/0x1d0
> > 	[ 9718.934187][ T4545]  delayed_put_task_struct+0x124/0x1b0
> > 	[ 9718.935071][ T4545]  rcu_core+0x3b0/0xeb0
> > 	[ 9718.935758][ T4545]  rcu_core_si+0xe/0x10
> > 	[ 9718.936433][ T4545]  __do_softirq+0x120/0x5e3
> > 	[ 9718.937165][ T4545] 
> > 	[ 9718.937545][ T4545] The buggy address belongs to the object at ffff888014e94000
> > 	[ 9718.937545][ T4545]  which belongs to the cache task_struct(168:screen-wrapper.service) of size 11072
> > 	[ 9718.940391][ T4545] The buggy address is located 44 bytes inside of
> > 	[ 9718.940391][ T4545]  11072-byte region [ffff888014e94000, ffff888014e96b40)
> > 	[ 9718.942559][ T4545] The buggy address belongs to the page:
> > 	[ 9718.943454][ T4545] page:ffffea000053a500 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888014e97fff head:ffffea000053a500 order:2 compound_mapcount:0 compound_pincount:0
> > 	[ 9718.946072][ T4545] flags: 0xfffe0000010200(slab|head)
> > 	[ 9718.946958][ T4545] raw: 00fffe0000010200 ffffea00011ab108 ffffea0001d6f108 ffff8881eabd9700
> > 	[ 9718.948406][ T4545] raw: ffff888014e97fff ffff888014e94000 0000000100000001 0000000000000000
> > 	[ 9718.949889][ T4545] page dumped because: kasan: bad access detected
> > 	[ 9718.950977][ T4545] 
> > 	[ 9718.951354][ T4545] Memory state around the buggy address:
> > 	[ 9718.952296][ T4545]  ffff888014e93f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 	[ 9718.953641][ T4545]  ffff888014e93f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 	[ 9718.955004][ T4545] >ffff888014e94000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > 	[ 9718.956366][ T4545]                                   ^
> > 	[ 9718.957258][ T4545]  ffff888014e94080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > 	[ 9718.958653][ T4545]  ffff888014e94100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > 	[ 9718.960034][ T4545] ==================================================================
> > 
> 



