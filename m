Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B83922545
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 May 2019 23:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbfERVlw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 18 May 2019 17:41:52 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:41804 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727600AbfERVlv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 May 2019 17:41:51 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 94E60303A4D; Sat, 18 May 2019 17:41:38 -0400 (EDT)
Date:   Sat, 18 May 2019 17:41:38 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: storm-of-soft-lockups: spinlocks running on all cores,
 preventing forward progress (4.14- to 5.0+)
Message-ID: <20190518214138.GJ20359@hungrycats.org>
References: <20190515213650.GG20359@hungrycats.org>
 <0480104e-db25-4e2f-08e5-0236ffd5c1c2@suse.com>
 <20190518044411.GH20359@hungrycats.org>
 <349ec27f-7eb4-45be-7cd4-29c2cd56d05b@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mhjHhnbe5PrRcwjY"
Content-Disposition: inline
In-Reply-To: <349ec27f-7eb4-45be-7cd4-29c2cd56d05b@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--mhjHhnbe5PrRcwjY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 18, 2019 at 11:27:46AM +0300, Nikolay Borisov wrote:
> On 18.05.19 =D0=B3. 7:44 =D1=87., Zygo Blaxell wrote:
> > On Thu, May 16, 2019 at 09:57:01AM +0300, Nikolay Borisov wrote:
> >> On 16.05.19 =D0=B3. 0:36 =D1=87., Zygo Blaxell wrote:
> >>> "Storm-of-soft-lockups" is a failure mode where btrfs puts all of the
> >>> CPU cores in kernel functions that are unable to make forward progres=
s,
> >>> but also unwilling to release their respective CPU cores.  This is
> >>> usually accompanied by a lot of CPU usage (detectable as either kvm C=
PU
> >>> usage or just a lot of CPU fan noise) though I don't know if all cores
> >>> are spinning or only some of them.
> >>>
> >>> The kernel console presents a continual stream of "BUG: soft lockup"
> >>> warnings for some days.  None of the call traces change during this t=
ime.
> >>> The only way out is to reboot.
> >>>
> >>> You can reproduce this by writing a bunch of data to a filesystem whi=
le
> >>> bees is running on all cores.  It takes a few days to occur naturally.
> >>> It can probably be sped up by just doing a bunch of random LOGICAL_INO
> >>> ioctls in a tight loop on each core.
> >>>
> >>> Here's an instance on a 4-CPU VM where CPU#0 is running btrfs-transac=
tion
> >>> (btrfs_try_tree_write_lock) and CPU#1-3 are running the LOGICAL_INO
> >>> ioctl (btrfs_tree_read_lock_atomic):
> >>
> >>
> >> Provide output of all sleeping threads when this occur via
> >>  echo w > /proc/sysrq-trigger.
> >=20
> > I fixed my SysRq configuration.  The results are...kind of interesting.
> > I guess the four threads that are running loops on all cores don't count
> > as "blocked"...
> >=20
> <snip>
> So you are discards are hung or there is a lost wakeup (which is rather
> unlikely, since this is the block layer). What is the underlying block
> device i.e model/make

Here's another set of soft-lockups, this time with no discard or snapshot.
This one's more interesting--the stuck CPUs are running something that
isn't commit_transaction or LOGICAL_INO.  It's the first time I've
seen that.

First the kernel BUG at fs/btrfs/ctree.c which looks pretty similar to
the last one:

	[20512.078483] kernel BUG at fs/btrfs/ctree.c:1227!
	[20512.079356] invalid opcode: 0000 [#1] SMP PTI
	[20512.080144] CPU: 1 PID: 5662 Comm: crawl_5268 Tainted: G        W      =
   5.0.16-zb64-9b948ea3083a+ #1
	[20512.081397] irq event stamp: 2743290041
	[20512.082303] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS=
 1.10.2-1 04/01/2014
	[20512.082307] RIP: 0010:__tree_mod_log_rewind+0x239/0x240
	[20512.082308] Code: c0 48 89 df 48 89 d6 48 c1 e6 05 48 8d 74 32 65 ba 19=
 00 00 00 e8 87 02 05 00 e9 88 fe ff ff 49 63 57 2c e9 16 ff ff ff 0f 0b <0=
f> 0b 0f 1f 44 00 00 0f 1f 44 00 00 55 83 c2 01 48 63 d2 48 89 e5
	[20512.082309] RSP: 0018:ffffa95b80f1b820 EFLAGS: 00010206
	[20512.082311] RAX: ffff9e059aa5a100 RBX: ffff9e04e01496e0 RCX: ffff9e0655=
5dcb81
	[20512.082312] RDX: 00000000000000ce RSI: 000000000000009f RDI: 0000006336=
410000
	[20512.082312] RBP: ffffa95b80f1b850 R08: ffffa95b80f1b7c8 R09: ffffa95b80=
f1b7d0
	[20512.082313] R10: 0000000000007b2a R11: 000000000000009f R12: 0000000000=
000008
	[20512.082314] R13: ffff9e05c9e21c80 R14: 000000000003a09e R15: ffff9e059a=
a5a100
	[20512.082315] FS:  00007f938be31700(0000) GS:ffff9e06b6000000(0000) knlGS=
:0000000000000000
	[20512.082316] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	[20512.082317] CR2: 00007f6dc1f8c519 CR3: 00000001c3d14005 CR4: 0000000000=
1606e0
	[20512.082319] Call Trace:
	[20512.082324]  btrfs_search_old_slot+0xfe/0x800
	[20512.082339]  resolve_indirect_refs+0x1c5/0x910
	[20512.082345]  ? prelim_ref_insert+0x10a/0x320
	[20512.082347]  find_parent_nodes+0x443/0x1340
	[20512.082356]  btrfs_find_all_roots_safe+0xc5/0x140
	[20512.082359]  ? btrfs_inode_flags_to_fsflags+0x90/0x90
	[20512.082361]  iterate_extent_inodes+0x198/0x3e0
	[20512.082367]  iterate_inodes_from_logical+0xa1/0xd0
	[20512.082369]  ? iterate_inodes_from_logical+0xa1/0xd0
	[20512.082370]  ? btrfs_inode_flags_to_fsflags+0x90/0x90
	[20512.082373]  btrfs_ioctl_logical_to_ino+0xf3/0x1a0
	[20512.082376]  btrfs_ioctl+0xcf7/0x2cb0
	[20512.082380]  ? __lock_acquire+0x477/0x1b50
	[20512.082382]  ? kvm_sched_clock_read+0x18/0x30
	[20512.082385]  ? kvm_sched_clock_read+0x18/0x30
	[20512.082387]  ? sched_clock+0x9/0x10
	[20512.082390]  do_vfs_ioctl+0xa6/0x6e0
	[20512.082391]  ? btrfs_ioctl_get_supported_features+0x30/0x30
	[20512.082392]  ? do_vfs_ioctl+0xa6/0x6e0
	[20512.082394]  ? __fget+0x119/0x200
	[20512.082397]  ksys_ioctl+0x75/0x80
	[20512.082399]  __x64_sys_ioctl+0x1a/0x20
	[20512.082402]  do_syscall_64+0x65/0x1a0
	[20512.082405]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
	[20512.082407] RIP: 0033:0x7f938cf29777
	[20512.082408] Code: 00 00 90 48 8b 05 19 a7 0c 00 64 c7 00 26 00 00 00 48=
 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <4=
8> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e9 a6 0c 00 f7 d8 64 89 01 48
	[20512.082409] RSP: 002b:00007f938be2e458 EFLAGS: 00000246 ORIG_RAX: 00000=
00000000010
	[20512.082410] RAX: ffffffffffffffda RBX: 00007f938be2e780 RCX: 00007f938c=
f29777
	[20512.082411] RDX: 00007f938be2e788 RSI: 00000000c038943b RDI: 0000000000=
000003
	[20512.082412] RBP: 0000000001000000 R08: 0000000000000000 R09: 00007f938b=
e2e960
	[20512.082412] R10: 000055ad4e628c40 R11: 0000000000000246 R12: 0000000000=
000003
	[20512.082413] R13: 00007f938be2e788 R14: 00007f938be2e668 R15: 00007f938b=
e2e890
	[20512.082418] Modules linked in: mq_deadline bfq dm_cache_smq dm_cache dm=
_persistent_data dm_bio_prison dm_bufio crct10dif_pclmul crc32_pclmul crc32=
c_intel ghash_clmulni_intel ppdev joydev dm_mod snd_pcm aesni_intel aes_x86=
_64 sr_mod cdrom crypto_simd snd_timer cryptd sg glue_helper snd parport_pc=
 ide_pci_generic parport soundcore piix bochs_drm input_leds ide_core rtc_c=
mos floppy i2c_piix4 pcspkr psmouse evbug evdev serio_raw qemu_fw_cfg ip_ta=
bles x_tables ipv6 crc_ccitt autofs4
	[20512.082464] ---[ end trace 3bcb7e6493f60fe5 ]---
	[20512.082466] RIP: 0010:__tree_mod_log_rewind+0x239/0x240
	[20512.082467] Code: c0 48 89 df 48 89 d6 48 c1 e6 05 48 8d 74 32 65 ba 19=
 00 00 00 e8 87 02 05 00 e9 88 fe ff ff 49 63 57 2c e9 16 ff ff ff 0f 0b <0=
f> 0b 0f 1f 44 00 00 0f 1f 44 00 00 55 83 c2 01 48 63 d2 48 89 e5
	[20512.082468] RSP: 0018:ffffa95b80f1b820 EFLAGS: 00010206
	[20512.082469] RAX: ffff9e059aa5a100 RBX: ffff9e04e01496e0 RCX: ffff9e0655=
5dcb81
	[20512.082469] RDX: 00000000000000ce RSI: 000000000000009f RDI: 0000006336=
410000
	[20512.082470] RBP: ffffa95b80f1b850 R08: ffffa95b80f1b7c8 R09: ffffa95b80=
f1b7d0
	[20512.082471] R10: 0000000000007b2a R11: 000000000000009f R12: 0000000000=
000008
	[20512.082472] R13: ffff9e05c9e21c80 R14: 000000000003a09e R15: ffff9e059a=
a5a100
	[20512.082473] FS:  00007f938be31700(0000) GS:ffff9e06b6000000(0000) knlGS=
:0000000000000000
	[20512.082473] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	[20512.082474] CR2: 00007f6dc1f8c519 CR3: 00000001c3d14005 CR4: 0000000000=
1606e0
	[20512.082478] BUG: sleeping function called from invalid context at ./inc=
lude/linux/percpu-rwsem.h:34
	[20512.082479] in_atomic(): 1, irqs_disabled(): 0, pid: 5662, name: crawl_=
5268
	[20512.082479] INFO: lockdep is turned off.
	[20512.082481] CPU: 1 PID: 5662 Comm: crawl_5268 Tainted: G      D W      =
   5.0.16-zb64-9b948ea3083a+ #1
	[20512.082482] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS=
 1.10.2-1 04/01/2014
	[20512.082482] Call Trace:
	[20512.082485]  dump_stack+0x86/0xc5
	[20512.082488]  ___might_sleep+0x217/0x240
	[20512.082490]  __might_sleep+0x4a/0x80
	[20512.082494]  exit_signals+0x33/0x250
	[20512.082496]  do_exit+0xb9/0xd70
	[20512.082502]  rewind_stack_do_exit+0x17/0x20
	[20512.082503] RIP: 0033:0x7f938cf29777
	[20512.082504] Code: 00 00 90 48 8b 05 19 a7 0c 00 64 c7 00 26 00 00 00 48=
 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <4=
8> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e9 a6 0c 00 f7 d8 64 89 01 48
	[20512.082505] RSP: 002b:00007f938be2e458 EFLAGS: 00000246 ORIG_RAX: 00000=
00000000010
	[20512.082506] RAX: ffffffffffffffda RBX: 00007f938be2e780 RCX: 00007f938c=
f29777
	[20512.082507] RDX: 00007f938be2e788 RSI: 00000000c038943b RDI: 0000000000=
000003
	[20512.082508] RBP: 0000000001000000 R08: 0000000000000000 R09: 00007f938b=
e2e960
	[20512.082508] R10: 000055ad4e628c40 R11: 0000000000000246 R12: 0000000000=
000003
	[20512.082509] R13: 00007f938be2e788 R14: 00007f938be2e668 R15: 00007f938b=
e2e890
	[20512.082514] note: crawl_5268[5662] exited with preempt_count 2
	[20512.214564] hardirqs last  enabled at (2743290041): [<ffffffff922d4758>=
] kmem_cache_alloc+0x208/0x330
	[20512.216158] hardirqs last disabled at (2743290040): [<ffffffff922d4614>=
] kmem_cache_alloc+0xc4/0x330
	[20512.217793] softirqs last  enabled at (2743288790): [<ffffffff930003a0>=
] __do_softirq+0x3a0/0x45a
	[20512.219555] softirqs last disabled at (2743288767): [<ffffffff920a9949>=
] irq_exit+0xe9/0xf0
	[20536.037778] watchdog: BUG: soft lockup - CPU#2 stuck for 22s! [rsync:57=
15]
	[20536.042129] watchdog: BUG: soft lockup - CPU#3 stuck for 22s! [btrfs-tr=
ansacti:4737]
	[20540.028759] watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [crawl_52=
68:5663]
	[20540.033740] watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [crawl_52=
68:5664]

Then SysRq-W:

	[53268.006056] sysrq: SysRq : Show Blocked State
	[53268.006780]   task                        PC stack   pid father
	[53268.007927] rsync           D    0  5683   5673 0x00000000
	[53268.008786] Call Trace:
	[53268.009215]  __schedule+0x3d4/0xb70
	[53268.009770]  schedule+0x3d/0x80
	[53268.010313]  btrfs_tree_lock+0x1a5/0x270
	[53268.010984]  ? wait_woken+0xa0/0xa0
	[53268.011560]  btrfs_search_slot+0x75f/0x930
	[53268.012335]  btrfs_lookup_inode+0x3e/0xc0
	[53268.013066]  ? kmem_cache_alloc+0x208/0x330
	[53268.013817]  ? btrfs_alloc_path+0x1a/0x20
	[53268.014552]  __btrfs_update_delayed_inode+0x70/0x210
	[53268.015542]  btrfs_commit_inode_delayed_inode+0x126/0x130
	[53268.016741]  btrfs_evict_inode+0x3c7/0x530
	[53268.017586]  ? dput+0x2a/0x2e0
	[53268.018222]  evict+0xc3/0x1c0
	[53268.018835]  iput+0x1de/0x280
	[53268.019481]  ? dput+0x2a/0x2e0
	[53268.020130]  dentry_unlink_inode+0xc0/0xf0
	[53268.020996]  __dentry_kill+0xd1/0x1b0
	[53268.021767]  dentry_kill+0x55/0x1e0
	[53268.022512]  ? dput+0x2a/0x2e0
	[53268.023168]  dput+0x291/0x2e0
	[53268.023792]  do_renameat2+0x420/0x5b0
	[53268.024667]  __x64_sys_rename+0x20/0x30
	[53268.025583]  do_syscall_64+0x65/0x1a0
	[53268.026501]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
	[53268.027664] RIP: 0033:0x7f0167fb1947
	[53268.028415] Code: Bad RIP value.
	[53268.029104] RSP: 002b:00007ffd919c7d08 EFLAGS: 00000246 ORIG_RAX: 00000=
00000000052
	[53268.030731] RAX: ffffffffffffffda RBX: 00007ffd919c9ed0 RCX: 00007f0167=
fb1947
	[53268.031962] RDX: 0000000000000000 RSI: 00007ffd919c7ed0 RDI: 00007ffd91=
9c9ed0
	[53268.033209] RBP: 00007ffd919c7ed0 R08: 0000000000000000 R09: 0000000000=
000000
	[53268.034540] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000=
000000
	[53268.036319] R13: 0000000000000004 R14: 00000000000081a4 R15: 0000000000=
000001
	[53268.038063] rsync           D    0  6461   6460 0x00000000
	[53268.039405] Call Trace:
	[53268.040102]  __schedule+0x3d4/0xb70
	[53268.040877]  ? sched_clock+0x9/0x10
	[53268.041640]  schedule+0x3d/0x80
	[53268.042301]  io_schedule+0x16/0x40
	[53268.043065]  wait_on_page_bit_killable+0x183/0x290
	[53268.044111]  ? add_to_page_cache_lru+0xd0/0xd0
	[53268.044909]  generic_file_read_iter+0x267/0xb70
	[53268.045688]  __vfs_read+0x124/0x1b0
	[53268.046290]  vfs_read+0xab/0x160
	[53268.046899]  ksys_read+0x5f/0xf0
	[53268.047637]  __x64_sys_read+0x1a/0x20
	[53268.048582]  do_syscall_64+0x65/0x1a0
	[53268.049368]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
	[53268.050207] RIP: 0033:0x7fa9d031c761
	[53268.050787] Code: Bad RIP value.
	[53268.051318] RSP: 002b:00007ffc5f634ad8 EFLAGS: 00000246 ORIG_RAX: 00000=
00000000000
	[53268.052997] RAX: ffffffffffffffda RBX: 000055a2c9a3cba0 RCX: 00007fa9d0=
31c761
	[53268.054359] RDX: 0000000000003800 RSI: 000055a2c998e9d0 RDI: 0000000000=
000001
	[53268.056088] RBP: 0000000000003800 R08: fffffffffffffff0 R09: 0000000000=
b75811
	[53268.057557] R10: 000055a2c998e9d0 R11: 0000000000000246 R12: 0000000000=
001000
	[53268.058876] R13: 0000000000003800 R14: 0000000000000320 R15: 0000000000=
001000
	[53268.060583] rsync           D    0  6596   6595 0x00000000
	[53268.061503] Call Trace:
	[53268.061988]  __schedule+0x3d4/0xb70
	[53268.062717]  schedule+0x3d/0x80
	[53268.063693]  io_schedule+0x16/0x40
	[53268.064330]  wait_on_page_bit+0x178/0x270
	[53268.065084]  ? add_to_page_cache_lru+0xd0/0xd0
	[53268.065959]  read_extent_buffer_pages+0x27e/0x350
	[53268.066914]  btree_read_extent_buffer_pages+0xb8/0x1c0
	[53268.067778]  read_tree_block+0x42/0x70
	[53268.068594]  read_block_for_search.isra.11+0x181/0x350
	[53268.069556]  btrfs_search_slot+0x3cf/0x930
	[53268.070318]  btrfs_lookup_extent_info+0xa3/0x450
	[53268.071986]  update_ref_for_cow+0x1a6/0x340
	[53268.073145]  __btrfs_cow_block+0x1ff/0x570
	[53268.074389]  btrfs_cow_block+0xf8/0x230
	[53268.075428]  push_leaf_left+0x11a/0x190
	[53268.077233]  btrfs_del_items+0x27b/0x470
	[53268.078094]  btrfs_truncate_inode_items+0x2ee/0xe70
	[53268.079041]  ? _raw_spin_unlock+0x27/0x40
	[53268.079898]  btrfs_evict_inode+0x455/0x530
	[53268.080898]  ? dput+0x2a/0x2e0
	[53268.081540]  evict+0xc3/0x1c0
	[53268.082183]  iput+0x1de/0x280
	[53268.082853]  ? dput+0x2a/0x2e0
	[53268.084211]  dentry_unlink_inode+0xc0/0xf0
	[53268.084965]  __dentry_kill+0xd1/0x1b0
	[53268.085805]  dentry_kill+0x55/0x1e0
	[53268.086685]  ? dput+0x2a/0x2e0
	[53268.087371]  dput+0x291/0x2e0
	[53268.087973]  do_renameat2+0x420/0x5b0
	[53268.088974]  __x64_sys_rename+0x20/0x30
	[53268.090099]  do_syscall_64+0x65/0x1a0
	[53268.091287]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
	[53268.092354] RIP: 0033:0x7f17fb432947
	[53268.093487] Code: Bad RIP value.
	[53268.094165] RSP: 002b:00007ffe387435d8 EFLAGS: 00000246 ORIG_RAX: 00000=
00000000052
	[53268.095777] RAX: ffffffffffffffda RBX: 00007ffe387457a0 RCX: 00007f17fb=
432947
	[53268.097312] RDX: 0000000000000000 RSI: 00007ffe387437a0 RDI: 00007ffe38=
7457a0
	[53268.098906] RBP: 00007ffe387437a0 R08: 0000000000000000 R09: 0000000000=
000000
	[53268.100613] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000=
000000
	[53268.102466] R13: 0000000000000004 R14: 00000000000081a4 R15: 0000000000=
000001
	[53268.104454] rsync           D    0  6679   6674 0x00000000
	[53268.105875] Call Trace:
	[53268.106453]  __schedule+0x3d4/0xb70
	[53268.107603]  schedule+0x3d/0x80
	[53268.108404]  io_schedule+0x16/0x40
	[53268.109461]  wait_on_page_bit_killable+0x183/0x290
	[53268.110459]  ? add_to_page_cache_lru+0xd0/0xd0
	[53268.111238]  generic_file_read_iter+0x267/0xb70
	[53268.112123]  __vfs_read+0x124/0x1b0
	[53268.112842]  vfs_read+0xab/0x160
	[53268.113494]  ksys_read+0x5f/0xf0
	[53268.114127]  ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
	[53268.116272]  __x64_sys_read+0x1a/0x20
	[53268.116887]  do_syscall_64+0x65/0x1a0
	[53268.117540]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
	[53268.118364] RIP: 0033:0x7f935866e761
	[53268.119003] Code: 00 f7 27 00 00 00 00 00 00 62 81 01 00 00 00 00 00 00=
 20 00 00 00 00 00 00 08 28 00 00 00 00 00 00 62 81 01 00 00 00 00 00 00 <2=
0> 00 00 00 00 00 00 2d 28 00 00 00 00 00 00 62 81 01 00 00 00 00
	[53268.124309] RSP: 002b:00007ffd292115f8 EFLAGS: 00000246 ORIG_RAX: 00000=
00000000000
	[53268.126193] RAX: ffffffffffffffda RBX: 00005587c16c2ff0 RCX: 00007f9358=
66e761
	[53268.127920] RDX: 0000000000007c00 RSI: 00005587c16c3430 RDI: 0000000000=
000001
	[53268.129621] RBP: 0000000000007c00 R08: fffffffffffffff0 R09: 0000000005=
334800
	[53268.132283] R10: 00005587c16c3430 R11: 0000000000000246 R12: 0000000000=
000400
	[53268.134937] R13: 0000000000007c00 R14: 0000000000000390 R15: 0000000000=
000400
	[53268.137415] rsync           D    0  7081   7053 0x00000000
	[53268.138587] Call Trace:
	[53268.139507]  __schedule+0x3d4/0xb70
	[53268.141054]  schedule+0x3d/0x80
	[53268.141638]  io_schedule+0x16/0x40
	[53268.142392]  wait_on_page_bit_killable+0x183/0x290
	[53268.143263]  ? add_to_page_cache_lru+0xd0/0xd0
	[53268.144926]  generic_file_read_iter+0x267/0xb70
	[53268.145758]  __vfs_read+0x124/0x1b0
	[53268.146472]  vfs_read+0xab/0x160
	[53268.147252]  ksys_read+0x5f/0xf0
	[53268.148273]  ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
	[53268.149682]  __x64_sys_read+0x1a/0x20
	[53268.150565]  do_syscall_64+0x65/0x1a0
	[53268.151428]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
	[53268.152233] RIP: 0033:0x7ff3a6803761
	[53268.152800] Code: Bad RIP value.
	[53268.153319] RSP: 002b:00007ffefada95e8 EFLAGS: 00000246 ORIG_RAX: 00000=
00000000000
	[53268.154919] RAX: ffffffffffffffda RBX: 0000562ccb936cc0 RCX: 00007ff3a6=
803761
	[53268.156871] RDX: 0000000000002109 RSI: 0000562cc7e2b1c0 RDI: 0000000000=
000000
	[53268.158322] RBP: 0000000000002109 R08: 0000562cc7e2b1b0 R09: 00007ff3a6=
8d53f0
	[53268.160016] R10: 0000562cc7269010 R11: 0000000000000246 R12: 0000000000=
000000
	[53268.161736] R13: 0000000000002109 R14: 0000000000000000 R15: 0000000000=
000000
	[53268.163275] rsync           D    0  8636   8583 0x00000000
	[53268.164188] Call Trace:
	[53268.164688]  __schedule+0x3d4/0xb70
	[53268.165647]  schedule+0x3d/0x80
	[53268.166522]  io_schedule+0x16/0x40
	[53268.167170]  wait_on_page_bit_killable+0x183/0x290
	[53268.168046]  ? add_to_page_cache_lru+0xd0/0xd0
	[53268.168887]  generic_file_read_iter+0x267/0xb70
	[53268.170488]  __vfs_read+0x124/0x1b0
	[53268.171445]  vfs_read+0xab/0x160
	[53268.172233]  ksys_read+0x5f/0xf0
	[53268.172922]  ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
	[53268.174115]  __x64_sys_read+0x1a/0x20
	[53268.174922]  do_syscall_64+0x65/0x1a0
	[53268.175769]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
	[53268.177195] RIP: 0033:0x7ff57017f761
	[53268.178011] Code: Bad RIP value.
	[53268.178730] RSP: 002b:00007ffcbb34b548 EFLAGS: 00000246 ORIG_RAX: 00000=
00000000000
	[53268.180469] RAX: ffffffffffffffda RBX: 000055e78c7bfc90 RCX: 00007ff570=
17f761
	[53268.182613] RDX: 00000000000022dd RSI: 000055e78c7b63d0 RDI: 0000000000=
000000
	[53268.184854] RBP: 00000000000022dd R08: 000055e78c7b63c0 R09: 00007ff570=
250cd0
	[53268.186508] R10: 000055e78bd77010 R11: 0000000000000246 R12: 0000000000=
000000
	[53268.189446] R13: 00000000000022dd R14: 0000000000000000 R15: 0000000000=
000000
	[53268.190635] rsync           D    0 30991   8458 0x00000000
	[53268.192905] Call Trace:
	[53268.193332]  __schedule+0x3d4/0xb70
	[53268.193920]  ? sched_clock+0x9/0x10
	[53268.195564]  schedule+0x3d/0x80
	[53268.196290]  io_schedule+0x16/0x40
	[53268.197067]  wait_on_page_bit_killable+0x183/0x290
	[53268.197895]  ? add_to_page_cache_lru+0xd0/0xd0
	[53268.198875]  generic_file_read_iter+0x267/0xb70
	[53268.199770]  __vfs_read+0x124/0x1b0
	[53268.200515]  vfs_read+0xab/0x160
	[53268.201198]  ksys_read+0x5f/0xf0
	[53268.201755]  __x64_sys_read+0x1a/0x20
	[53268.202561]  do_syscall_64+0x65/0x1a0
	[53268.203364]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
	[53268.204306] RIP: 0033:0x7fcab8c0c761
	[53268.205129] Code: Bad RIP value.
	[53268.205698] RSP: 002b:00007ffe4e709938 EFLAGS: 00000246 ORIG_RAX: 00000=
00000000000
	[53268.207263] RAX: ffffffffffffffda RBX: 000055cf5c835d70 RCX: 00007fcab8=
c0c761
	[53268.208588] RDX: 0000000000004400 RSI: 000055cf5a51d7c0 RDI: 0000000000=
000001
	[53268.209908] RBP: 0000000000004400 R08: 000055cf5a51d7b0 R09: 00007fcab8=
cde450
	[53268.211376] R10: 000055cf59ded010 R11: 0000000000000246 R12: 0000000000=
000000
	[53268.214192] R13: 0000000000004400 R14: 0000000000000000 R15: 0000000000=
000000

Then SysRq-T excerpts for each of the 4 tasks stuck on CPUs:

CPU#0:

	[53274.315728] rsync           R  running task        0  5715   5708 0x800=
00008
	[53274.316927] Call Trace:
	[53274.317380]  ? trace_hardirqs_on_thunk+0x1a/0x1c
	[53274.318181]  ? retint_kernel+0x10/0x10
	[53274.318820]  ? trace_hardirqs_on_thunk+0x1a/0x1c
	[53274.319646]  ? retint_kernel+0x10/0x10
	[53274.320331]  ? trace_hardirqs_on_thunk+0x1a/0x1c
	[53274.321125]  ? trace_hardirqs_on_caller+0x4a/0x100
	[53274.321924]  ? trace_hardirqs_on_thunk+0x1a/0x1c
	[53274.322716]  ? retint_kernel+0x10/0x10
	[53274.323367]  ? retint_kernel+0x10/0x10
	[53274.324009]  ? __pv_queued_spin_lock_slowpath+0x273/0x2b0
	[53274.324926]  ? __pv_queued_spin_lock_slowpath+0xf7/0x2b0
	[53274.325814]  ? __pv_queued_spin_lock_slowpath+0x273/0x2b0
	[53274.326729]  ? queued_write_lock_slowpath+0x80/0x90
	[53274.327560]  ? do_raw_write_lock+0xae/0xb0
	[53274.328262]  ? _raw_write_lock+0x55/0x70
	[53274.328932]  ? tree_mod_log_insert_key+0xd3/0x150
	[53274.329840]  ? __btrfs_cow_block+0x25d/0x570
	[53274.330810]  ? btrfs_cow_block+0xf8/0x230
	[53274.331688]  ? btrfs_search_slot+0x213/0x930
	[53274.332621]  ? btrfs_lookup_inode+0x3e/0xc0
	[53274.333595]  ? kmem_cache_alloc+0x208/0x330
	[53274.334505]  ? btrfs_alloc_path+0x1a/0x20
	[53274.335385]  ? __btrfs_update_delayed_inode+0x70/0x210
	[53274.336515]  ? btrfs_commit_inode_delayed_inode+0x126/0x130
	[53274.337740]  ? btrfs_evict_inode+0x3c7/0x530
	[53274.338683]  ? dput+0x2a/0x2e0
	[53274.339350]  ? evict+0xc3/0x1c0
	[53274.340056]  ? iput+0x1de/0x280
	[53274.340746]  ? dput+0x2a/0x2e0
	[53274.341456]  ? dentry_unlink_inode+0xc0/0xf0
	[53274.342378]  ? __dentry_kill+0xd1/0x1b0
	[53274.343208]  ? dentry_kill+0x55/0x1e0
	[53274.343932]  ? dput+0x2a/0x2e0
	[53274.344597]  ? dput+0x291/0x2e0
	[53274.345263]  ? __fput+0x12f/0x260
	[53274.345984]  ? ____fput+0xe/0x10
	[53274.346660]  ? task_work_run+0x8f/0xc0
	[53274.347499]  ? exit_to_usermode_loop+0x112/0x120
	[53274.348543]  ? do_syscall_64+0x199/0x1a0
	[53274.349368]  ? entry_SYSCALL_64_after_hwframe+0x49/0xbe

CPU#1:

	[53273.449195] btrfs-transacti R  running task        0  4737      2 0x800=
00008
	[53273.451375] Call Trace:
	[53273.451980]  ? retint_kernel+0x10/0x10
	[53273.452758]  ? trace_hardirqs_on_thunk+0x1a/0x1c
	[53273.453549]  ? trace_hardirqs_on_caller+0x4a/0x100
	[53273.454355]  ? trace_hardirqs_on_thunk+0x1a/0x1c
	[53273.455143]  ? retint_kernel+0x10/0x10
	[53273.455777]  ? kvm_wait+0x86/0x90
	[53273.456368]  ? __pv_queued_spin_lock_slowpath+0x1ed/0x2b0
	[53273.457300]  ? trace_hardirqs_on+0x4c/0x100
	[53273.458008]  ? kvm_wait+0x8b/0x90
	[53273.458577]  ? __pv_queued_spin_lock_slowpath+0x1ed/0x2b0
	[53273.459747]  ? queued_write_lock_slowpath+0x80/0x90
	[53273.460762]  ? do_raw_write_lock+0xae/0xb0
	[53273.461682]  ? _raw_write_lock+0x55/0x70
	[53273.462493]  ? tree_mod_log_insert_key+0xd3/0x150
	[53273.463314]  ? __btrfs_cow_block+0x25d/0x570
	[53273.464040]  ? btrfs_cow_block+0xf8/0x230
	[53273.464718]  ? btrfs_search_slot+0x213/0x930
	[53273.465447]  ? lookup_inline_extent_backref+0x118/0x570
	[53273.466358]  ? mark_held_locks+0x76/0xa0
	[53273.467175]  ? insert_inline_extent_backref+0x51/0xe0
	[53273.468334]  ? rcu_read_lock_sched_held+0x72/0x80
	[53273.469560]  ? __btrfs_inc_extent_ref+0x87/0x220
	[53273.470730]  ? run_delayed_data_ref+0x1c2/0x210
	[53273.471718]  ? run_one_delayed_ref+0x55/0xa0
	[53273.472787]  ? btrfs_run_delayed_refs_for_head+0x17b/0x3b0
	[53273.474200]  ? __btrfs_run_delayed_refs+0x84/0x180
	[53273.475455]  ? btrfs_run_delayed_refs+0x86/0x1e0
	[53273.476684]  ? btrfs_commit_transaction+0x52/0xab0
	[53273.478684]  ? start_transaction+0x93/0x4d0
	[53273.479500]  ? transaction_kthread+0x155/0x190
	[53273.480308]  ? kthread+0x113/0x150
	[53273.480920]  ? btrfs_cleanup_transaction+0x630/0x630
	[53273.481937]  ? kthread_park+0x90/0x90
	[53273.483571]  ? ret_from_fork+0x3a/0x50

CPU#2:

	[53273.814635] crawl_5268      R  running task        0  5663   5650 0x800=
00008
	[53273.816033] Call Trace:
	[53273.816470]  <IRQ>
	[53273.816840]  sched_show_task+0x198/0x260
	[53273.817546]  show_state_filter+0xa0/0x1a0
	[53273.818276]  sysrq_handle_showstate+0x10/0x20
	[53273.819059]  __handle_sysrq+0x139/0x210
	[53273.819744]  handle_sysrq+0x26/0x30
	[53273.820376]  serial8250_handle_irq.part.16+0xbc/0x100
	[53273.821298]  serial8250_default_handle_irq+0x53/0x60
	[53273.822209]  serial8250_interrupt+0x68/0x100
	[53273.823001]  __handle_irq_event_percpu+0x4e/0x2b0
	[53273.823958]  handle_irq_event_percpu+0x32/0x80
	[53273.824947]  handle_irq_event+0x39/0x60
	[53273.825800]  handle_edge_irq+0xef/0x1c0
	[53273.826554]  handle_irq+0x75/0x120
	[53273.827191]  do_IRQ+0x64/0x130
	[53273.827760]  common_interrupt+0xf/0xf
	[53273.828443]  </IRQ>
	[53273.828841] RIP: 0010:native_safe_halt+0x12/0x20
	[53273.829783] Code: f0 80 48 02 20 48 8b 00 a8 08 0f 84 7b ff ff ff eb bd=
 90 90 90 90 90 90 55 48 89 e5 e9 07 00 00 00 0f 00 2d b2 ec 43 00 fb f4 <5=
d> c3 66 90 66 2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 e9 07 00 00
	[53273.834211] RSP: 0018:ffffa95b81107790 EFLAGS: 00000246 ORIG_RAX: fffff=
fffffffffd6
	[53273.835701] RAX: 0000000000000000 RBX: ffff9e06b5e159d4 RCX: 0000000000=
000001
	[53273.837608] RDX: ffff9e06aeb2c000 RSI: ffffffff921199ed RDI: ffffffff92=
07a326
	[53273.839525] RBP: ffffa95b81107790 R08: 0000000000000000 R09: 0000000000=
000000
	[53273.841170] R10: ffffa95b811077d0 R11: ffff9e069ddfd6b8 R12: 0000000000=
000246
	[53273.842439] R13: 0000000000000001 R14: ffff9e06b5e159d4 R15: 0000000000=
000001
	[53273.843995]  ? __pv_queued_spin_lock_slowpath+0x1ed/0x2b0
	[53273.845002]  ? kvm_wait+0x86/0x90
	[53273.845610]  kvm_wait+0x8b/0x90
	[53273.846178]  __pv_queued_spin_lock_slowpath+0x1ed/0x2b0
	[53273.847472]  queued_read_lock_slowpath+0x75/0x80
	[53273.848317]  do_raw_read_lock+0x4b/0x50
	[53273.849013]  _raw_read_lock+0x58/0x70
	[53273.849693]  __tree_mod_log_search+0x2d/0xb0
	[53273.850466]  __tree_mod_log_oldest_root.isra.1+0x4c/0x80
	[53273.851593]  btrfs_old_root_level+0x26/0x80
	[53273.852374]  resolve_indirect_refs+0x2ad/0x910
	[53273.853211]  ? __schedule+0x3dc/0xb70
	[53273.853870]  find_parent_nodes+0x443/0x1340
	[53273.854631]  btrfs_find_all_roots_safe+0xc5/0x140
	[53273.855774]  ? btrfs_inode_flags_to_fsflags+0x90/0x90
	[53273.856908]  iterate_extent_inodes+0x198/0x3e0
	[53273.857766]  iterate_inodes_from_logical+0xa1/0xd0
	[53273.858929]  ? iterate_inodes_from_logical+0xa1/0xd0
	[53273.859939]  ? btrfs_inode_flags_to_fsflags+0x90/0x90
	[53273.860847]  btrfs_ioctl_logical_to_ino+0xf3/0x1a0
	[53273.861741]  btrfs_ioctl+0xcf7/0x2cb0
	[53273.862617]  ? __lock_acquire+0x477/0x1b50
	[53273.863530]  ? kvm_sched_clock_read+0x18/0x30
	[53273.864496]  ? kvm_sched_clock_read+0x18/0x30
	[53273.865335]  ? sched_clock+0x9/0x10
	[53273.866015]  do_vfs_ioctl+0xa6/0x6e0
	[53273.866891]  ? btrfs_ioctl_get_supported_features+0x30/0x30
	[53273.867954]  ? do_vfs_ioctl+0xa6/0x6e0
	[53273.869148]  ? __fget+0x119/0x200
	[53273.869922]  ksys_ioctl+0x75/0x80
	[53273.870649]  __x64_sys_ioctl+0x1a/0x20
	[53273.871450]  do_syscall_64+0x65/0x1a0
	[53273.872351]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
	[53273.873487] RIP: 0033:0x7f938cf29777
	[53273.874154] Code: 00 00 90 48 8b 05 19 a7 0c 00 64 c7 00 26 00 00 00 48=
 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <4=
8> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e9 a6 0c 00 f7 d8 64 89 01 48
	[53273.878117] RSP: 002b:00007f938b62d458 EFLAGS: 00000246 ORIG_RAX: 00000=
00000000010
	[53273.879542] RAX: ffffffffffffffda RBX: 00007f938b62d780 RCX: 00007f938c=
f29777
	[53273.881224] RDX: 00007f938b62d788 RSI: 00000000c038943b RDI: 0000000000=
000003
	[53273.882805] RBP: 0000000001000000 R08: 0000000000000000 R09: 00007f938b=
62d960
	[53273.884519] R10: 000055ad4e628c40 R11: 0000000000000246 R12: 0000000000=
000003
	[53273.885971] R13: 00007f938b62d788 R14: 00007f938b62d668 R15: 00007f938b=
62d890

CPU#3:

	[53273.887482] crawl_5268      R  running task        0  5664   5650 0x800=
00008
	[53273.888778] Call Trace:
	[53273.889807]  ? tree_mod_log_insert_root.isra.2+0x117/0x350
	[53273.890820]  ? __btrfs_cow_block+0x41e/0x570
	[53273.891625]  ? btrfs_cow_block+0xf8/0x230
	[53273.892471]  ? btrfs_search_slot+0x213/0x930
	[53273.893296]  ? kmem_cache_free+0xa4/0x1e0
	[53273.894189]  ? btrfs_lookup_file_extent+0x49/0x60
	[53273.895058]  ? __btrfs_drop_extents+0x183/0xdf0
	[53273.895869]  ? kmem_cache_alloc+0x208/0x330
	[53273.896641]  ? btrfs_alloc_path+0x1a/0x20
	[53273.897371]  ? trace_hardirqs_on+0x4c/0x100
	[53273.898310]  ? btrfs_drop_extents+0x5d/0x90
	[53273.899096]  ? btrfs_clone+0x845/0xcf0
	[53273.899938]  ? btrfs_extent_same_range+0x5b/0xd0
	[53273.901203]  ? btrfs_remap_file_range+0x218/0x380
	[53273.902585]  ? vfs_dedupe_file_range_one+0x111/0x170
	[53273.903996]  ? vfs_dedupe_file_range+0x157/0x1f0
	[53273.904850]  ? do_vfs_ioctl+0x27f/0x6e0
	[53273.905655]  ? __fget+0x119/0x200
	[53273.906918]  ? ksys_ioctl+0x75/0x80
	[53273.907699]  ? __x64_sys_ioctl+0x1a/0x20
	[53273.908428]  ? do_syscall_64+0x65/0x1a0
	[53273.909175]  ? entry_SYSCALL_64_after_hwframe+0x49/0xbe

> >>
> >> <SNIP>

--mhjHhnbe5PrRcwjY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXOB8DgAKCRCB+YsaVrMb
nEUYAJ9Hb/DfoEd0UAz69l/4QeNzKANgNQCfal32Tf6SEd5kc/iorn6qHYwMczQ=
=qK0g
-----END PGP SIGNATURE-----

--mhjHhnbe5PrRcwjY--
