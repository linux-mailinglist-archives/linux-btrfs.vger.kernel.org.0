Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96DDB150F1B
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 19:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgBCSIo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 13:08:44 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:33292 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728433AbgBCSIn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 13:08:43 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id C23955A7372; Mon,  3 Feb 2020 13:08:42 -0500 (EST)
Date:   Mon, 3 Feb 2020 13:08:42 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: 5.4.6+ kernel BUG at fs/btrfs/ctree.c:1245
Message-ID: <20200203180842.GU13306@hungrycats.org>
References: <20191231013709.GH13306@hungrycats.org>
 <CAL3q7H7jq4x5kRXOKeHDTcnsNn3ZxHckgGcsx9fVMPsop+jK-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="VvnGyWaJ9JuxX38U"
Content-Disposition: inline
In-Reply-To: <CAL3q7H7jq4x5kRXOKeHDTcnsNn3ZxHckgGcsx9fVMPsop+jK-g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--VvnGyWaJ9JuxX38U
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2020 at 12:32:29PM +0000, Filipe Manana wrote:
> On Tue, Dec 31, 2019 at 1:38 AM Zygo Blaxell
> <ce3g8jdj@umail.furryterror.org> wrote:
> >
> > In the past month there have been a lot of kernel crash bug fixes.
> > The fixes have increased uptimes for kernels 5.0 through 5.4 by two
> > orders of magnitude under test loads.
> >
> > This BUG() is now the most frequent crash remaining.  It happens about
> > twice a machine-day.
> >
> > The test kernel is 5.4.6 with patches from the mailing list to fix other
> > known bugs.  These patches fix other crashing bugs on 5.1+ kernels:
> >
> >         btrfs: relocation: Fix KASAN report on create_reloc_tree due to=
 extended reloc tree lifepsan
> >         btrfs: relocation: Fix a KASAN report on btrfs_reloc_pre_snapsh=
ot() due to extended reloc root lifespan
> >         btrfs: relocation: Fix a KASAN use-after-free bug due to extend=
ed reloc tree lifespan
> >         Btrfs: fix removal logic of the tree mod log that leads to use-=
after-free issues
> >
> > The following patches enabled faster reproduction of earlier bugs;
> > however, they don't seem to affect the rate of this bug.  They're still
> > in the test kernel:
> >
> >         btrfs: relocation: Introduce error injection points for cancell=
ing balance
> >         btrfs: relocation: Work around dead relocation stage loop
> >         btrfs: relocation: Check cancel request after each extent found
> >         btrfs: relocation: Check cancel request after each data page re=
ad
> >
> > This one fixes a bug in 5.4 kernels that does not lead to a BUG, but it
> > breaks the test workload:
> >
> >         btrfs: super: Make btrfs_statfs() work with metadata over-commi=
ting
> >
> > The next patches are in the test kernel but I don't think they're relev=
ant
> > to the bug.  The bug, or something similar, has been observed long befo=
re
> > these patches came along.  I list them here for full disclosure:
> >
> >         Btrfs: make deduplication with range including the last block w=
ork
> >         fs: allow deduplication of eof block into the end of the destin=
ation file
> >         btrfs: relocation: Output current relocation stage at btrfs_rel=
ocate_block_group()
> >
> > The workload is:
> >
> >         * data balance start at random intervals
> >         * metadata balance start at random intervals
> >         * balance cancel at random intervals
> >         * bees dedupe (logical_ino, tree_search_v2, ino_paths)
> >         * 10x rsync receiver
> >         * scrub start at random intervals
> >         * scrub cancel at random intervals
> >         * create snapshot at random intervals
> >         * delete snapshot at random intervals
> >
> > This is a standard workload we use to test kernel releases for
> > regressions, not a minimal test case for this specific bug.  AFAICT only
> > the logical_ino and balance components are really needed for this bug.
> >
> > The bug is:
> >
> >         [40930.407302][ T4482] ------------[ cut here ]------------
> >         [40930.413439][ T4482] kernel BUG at fs/btrfs/ctree.c:1245!
> >         [40930.421400][ T4482] invalid opcode: 0000 [#1] SMP KASAN PTI
> >         [40930.427943][ T4482] CPU: 2 PID: 4482 Comm: crawl_5902 Not ta=
inted 5.4.6-6ededf16b6f3+ #5
> >         [40930.437905][ T4482] Hardware name: QEMU Standard PC (i440FX =
+ PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> >         [40930.448237][ T4482] RIP: 0010:__tree_mod_log_rewind+0x38d/0x=
3a0
> >         [40930.454532][ T4482] Code: 05 48 8d 74 10 65 ba 19 00 00 00 e=
8 2d 30 07 00 e9 b8 fd ff ff 4c 8d 7b 2c 4c 89 ff e8 3c 55 ce ff 48 63 43 2=
c e9 a2 fe ff ff <0f> 0b 0f 0b 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00=
 0f 1f 44
> >         [40930.473360][ T4482] RSP: 0018:ffff8881c64aee48 EFLAGS: 00010=
293
> >         [40930.479335][ T4482] RAX: 0000000000000000 RBX: ffff8881d08a9=
800 RCX: ffffffff947c8ab2
> >         [40930.486945][ T4482] RDX: 0000000000000007 RSI: dffffc0000000=
000 RDI: ffff8881d08a982c
> >         [40930.495436][ T4482] RBP: ffff8881c64aee98 R08: 1ffff1103decf=
e0f R09: ffff8881c64aed90
> >         [40930.504343][ T4482] R10: ffffed103decfe0e R11: ffff8881ef67f=
075 R12: 0000000000000005
> >         [40930.512359][ T4482] R13: ffff888068e037f0 R14: ffff88813f196=
900 R15: ffff8881d08a982c
> >         [40930.520353][ T4482] FS:  00007fdf6effd700(0000) GS:ffff8881f=
5c00000(0000) knlGS:0000000000000000
> >         [40930.528997][ T4482] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033
> >         [40930.535456][ T4482] CR2: 00007f0390127350 CR3: 00000001dd966=
001 CR4: 00000000001606e0
> >         [40930.548556][ T4482] Call Trace:
> >         [40930.551997][ T4482]  btrfs_search_old_slot+0x1e9/0xfd0
> >         [40930.557705][ T4482]  ? btrfs_search_slot+0x1050/0x1050
> >         [40930.563783][ T4482]  ? _raw_spin_unlock+0x27/0x40
> >         [40930.569627][ T4482]  ? release_extent_buffer+0x73/0x130
> >         [40930.576132][ T4482]  ? free_extent_buffer.part.46+0xd7/0x140
> >         [40930.582940][ T4482]  resolve_indirect_refs+0x372/0xe10
> >         [40930.589438][ T4482]  ? __lock_acquire+0xa7/0x2550
> >         [40930.595629][ T4482]  ? add_inline_refs.isra.9+0x470/0x470
> >         [40930.602351][ T4482]  ? btrfs_release_extent_buffer_pages+0x1=
c4/0x3e0
> >         [40930.610494][ T4482]  ? lock_downgrade+0x3d0/0x3d0
> >         [40930.616774][ T4482]  ? __kasan_check_write+0x14/0x20
> >         [40930.623198][ T4482]  ? lock_contended+0x710/0x710
> >         [40930.628732][ T4482]  ? do_raw_spin_lock+0x1d0/0x1d0
> >         [40930.634574][ T4482]  ? lockdep_hardirqs_on+0x16/0x290
> >         [40930.640447][ T4482]  ? __call_rcu+0x180/0x5b0
> >         [40930.645646][ T4482]  ? trace_hardirqs_on+0x4e/0x140
> >         [40930.651411][ T4482]  ? rb_insert_color+0x3af/0x400
> >         [40930.657723][ T4482]  ? prelim_ref_insert+0x312/0x580
> >         [40930.663360][ T4482]  find_parent_nodes+0x5c6/0x1590
> >         [40930.668871][ T4482]  ? kasan_kmalloc+0x9/0x10
> >         [40930.673681][ T4482]  ? resolve_indirect_refs+0xe10/0xe10
> >         [40930.683669][ T4482]  ? find_parent_nodes+0x129b/0x1590
> >         [40930.691859][ T4482]  ? kmem_cache_alloc_trace+0x134/0x740
> >         [40930.698262][ T4482]  ? ulist_alloc+0x3f/0xa0
> >         [40930.702764][ T4482]  ? iterate_extent_inodes+0x413/0x590
> >         [40930.708419][ T4482]  ? resolve_indirect_refs+0xe10/0xe10
> >         [40930.713945][ T4482]  ? kasan_unpoison_shadow+0x35/0x50
> >         [40930.719153][ T4482]  ? kasan_unpoison_shadow+0x35/0x50
> >         [40930.724294][ T4482]  btrfs_find_all_roots_safe+0x144/0x1e0
> >         [40930.729673][ T4482]  ? find_parent_nodes+0x1590/0x1590
> >         [40930.734835][ T4482]  ? _raw_write_unlock+0x27/0x40
> >         [40930.740366][ T4482]  ? btrfs_inode_flags_to_xflags+0x50/0x50
> >         [40930.746005][ T4482]  iterate_extent_inodes+0x21c/0x590
> >         [40930.751145][ T4482]  ? tree_backref_for_extent+0x230/0x230
> >         [40930.756613][ T4482]  ? lock_downgrade+0x3d0/0x3d0
> >         [40930.761340][ T4482]  ? memcpy+0x45/0x50
> >         [40930.765256][ T4482]  ? lock_acquired+0x82/0x650
> >         [40930.769791][ T4482]  ? __kasan_check_write+0x14/0x20
> >         [40930.775066][ T4482]  ? lock_contended+0x710/0x710
> >         [40930.780184][ T4482]  ? do_raw_spin_unlock+0xa8/0x140
> >         [40930.781696][ T4482]  ? _raw_spin_unlock+0x27/0x40
> >         [40930.783125][ T4482]  ? __kasan_check_write+0x14/0x20
> >         [40930.784430][ T4482]  iterate_inodes_from_logical+0x129/0x170
> >         [40930.787676][ T4482]  ? iterate_inodes_from_logical+0x129/0x1=
70
> >         [40930.790919][ T4482]  ? btrfs_inode_flags_to_xflags+0x50/0x50
> >         [40930.794182][ T4482]  ? iterate_extent_inodes+0x590/0x590
> >         [40930.797069][ T4482]  ? init_data_container+0x34/0xb0
> >         [40930.799729][ T4482]  ? __vmalloc_node_flags_caller+0x88/0xa0
> >         [40930.802696][ T4482]  ? init_data_container+0x34/0xb0
> >         [40930.804012][ T4482]  ? kvmalloc_node+0x5b/0x80
> >         [40930.815799][ T4482]  btrfs_ioctl_logical_to_ino+0x110/0x1d0
> >         [40930.817461][ T4482]  btrfs_ioctl+0x25d3/0x45a0
> >         [40930.818727][ T4482]  ? __kasan_check_read+0x11/0x20
> >         [40930.820167][ T4482]  ? copyout+0x91/0xa0
> >         [40930.821793][ T4482]  ? btrfs_ioctl_get_supported_features+0x=
30/0x30
> >         [40930.824572][ T4482]  ? __lock_acquire+0xa7/0x2550
> >         [40930.826677][ T4482]  ? lock_downgrade+0x3d0/0x3d0
> >         [40930.829048][ T4482]  ? __kasan_check_write+0x14/0x20
> >         [40930.831498][ T4482]  ? lock_contended+0x710/0x710
> >         [40930.834461][ T4482]  ? do_raw_spin_lock+0x1d0/0x1d0
> >         [40930.836948][ T4482]  ? debug_lockdep_rcu_enabled+0x26/0x40
> >         [40930.840927][ T4482]  ? register_lock_class+0x970/0x970
> >         [40930.843115][ T4482]  ? get_task_mm+0x69/0x80
> >         [40930.845045][ T4482]  ? lock_downgrade+0x3d0/0x3d0
> >         [40930.847705][ T4482]  ? __kasan_check_write+0x14/0x20
> >         [40930.850488][ T4482]  ? lock_contended+0x710/0x710
> >         [40930.852769][ T4482]  ? debug_lockdep_rcu_enabled+0x26/0x40
> >         [40930.868386][ T4482]  ? ___might_sleep+0x10f/0x1e0
> >         [40930.879297][ T4482]  ? __might_sleep+0x71/0xe0
> >         [40930.889063][ T4482]  ? __kasan_check_write+0x14/0x20
> >         [40930.901617][ T4482]  ? mmput+0x3b/0x220
> >         [40930.909543][ T4482]  ? __lock_acquire+0xa7/0x2550
> >         [40930.919233][ T4482]  ? __lock_acquire+0xa7/0x2550
> >         [40930.927665][ T4482]  ? debug_lockdep_rcu_enabled+0x26/0x40
> >         [40930.937549][ T4482]  ? register_lock_class+0x970/0x970
> >         [40930.947372][ T4482]  ? __might_fault+0x7a/0xe0
> >         [40930.955746][ T4482]  ? __fget+0x22d/0x350
> >         [40930.962538][ T4482]  do_vfs_ioctl+0x13e/0xa80
> >         [40930.970304][ T4482]  ? btrfs_ioctl_get_supported_features+0x=
30/0x30
> >         [40930.981524][ T4482]  ? do_vfs_ioctl+0x13e/0xa80
> >         [40930.989029][ T4482]  ? lock_acquire+0x103/0x220
> >         [40930.996196][ T4482]  ? ioctl_preallocate+0x150/0x150
> >         [40931.004120][ T4482]  ? __fget+0x24c/0x350
> >         [40931.010917][ T4482]  ? do_dup2+0x2a0/0x2a0
> >         [40931.017800][ T4482]  ? lock_downgrade+0x3d0/0x3d0
> >         [40931.025487][ T4482]  ? __fget_light+0xeb/0x110
> >         [40931.032627][ T4482]  ? __task_pid_nr_ns+0x5/0x280
> >         [40931.040073][ T4482]  ksys_ioctl+0x67/0x90
> >         [40931.046459][ T4482]  __x64_sys_ioctl+0x43/0x50
> >         [40931.053288][ T4482]  do_syscall_64+0x77/0x2a0
> >         [40931.060351][ T4482]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >         [40931.069094][ T4482] RIP: 0033:0x7fdf753d0427
> >         [40931.076179][ T4482] Code: 00 00 90 48 8b 05 69 aa 0c 00 64 c=
7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 1=
0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 aa 0c 00 f7 d8 64=
 89 01 48
> >         [40931.113317][ T4482] RSP: 002b:00007fdf6effaca8 EFLAGS: 00000=
246 ORIG_RAX: 0000000000000010
> >         [40931.129586][ T4482] RAX: ffffffffffffffda RBX: 00007fdf6effa=
ee0 RCX: 00007fdf753d0427
> >         [40931.143190][ T4482] RDX: 00007fdf6effaee8 RSI: 00000000c0389=
43b RDI: 0000000000000003
> >         [40931.156948][ T4482] RBP: 0000000001000000 R08: 0000000000000=
000 R09: 00007fdf6effb0c0
> >         [40931.166573][ T4482] R10: 000055fcd78a4c40 R11: 0000000000000=
246 R12: 0000000000000003
> >         [40931.168923][ T4482] R13: 00007fdf6effaee8 R14: 00007fdf6effa=
ff0 R15: 00007fdf6effaee0
> >         [40931.171601][ T4482] Modules linked in: dm_cache_smq dm_cache=
 dm_persistent_data dm_bio_prison dm_bufio intel_rapl_msr intel_rapl_common=
 crct10dif_pclmul crc32_pclmul crc32c_intel sr_mod ghash_clmulni_intel cdro=
m joydev ppdev dm_mod sg snd_pcm ide_pci_generic snd_timer piix ide_core sn=
d i2c_piix4 aesni_intel crypto_simd drm_vram_helper soundcore psmouse crypt=
d glue_helper input_leds floppy evbug parport_pc pcspkr qemu_fw_cfg rtc_cmo=
s evdev serio_raw parport ip_tables x_tables ipv6 crc_ccitt nf_defrag_ipv6 =
autofs4
> >         [40931.204483][ T4482] ---[ end trace e64e1d8e5896fe28 ]---
> >
> > Matching trace addresses to code:
> >
> >         (gdb) list *(__tree_mod_log_rewind+0x38d)
> >         0xffffffff817c8c1d is in __tree_mod_log_rewind (fs/btrfs/ctree.=
c:1245).
> >         1240                     * the modification. as we're going bac=
kwards, we do the
> >         1241                     * opposite of each operation here.
> >         1242                     */
> >         1243                    switch (tm->op) {
> >         1244                    case MOD_LOG_KEY_REMOVE_WHILE_FREEING:
> >         1245                            BUG_ON(tm->slot < n);
> >         1246                            /* Fallthrough */
> >         1247                    case MOD_LOG_KEY_REMOVE_WHILE_MOVING:
> >         1248                    case MOD_LOG_KEY_REMOVE:
> >         1249                            btrfs_set_node_key(eb, &tm->key=
, tm->slot);
> >
> >         (gdb) list *(btrfs_search_old_slot+0x1e9)
> >         0xffffffff817d5509 is in btrfs_search_old_slot (fs/btrfs/ctree.=
c:1429).
> >         1424                    btrfs_set_header_owner(eb, eb_root_owne=
r);
> >         1425                    btrfs_set_header_level(eb, old_root->le=
vel);
> >         1426                    btrfs_set_header_generation(eb, old_gen=
eration);
> >         1427            }
> >         1428            if (tm)
> >         1429                    __tree_mod_log_rewind(fs_info, eb, time=
_seq, tm);
> >         1430            else
> >         1431                    WARN_ON(btrfs_header_level(eb) !=3D 0);
> >         1432            WARN_ON(btrfs_header_nritems(eb) > BTRFS_NODEPT=
RS_PER_BLOCK(fs_info));
> >         1433
> >
> >         (gdb) list *(resolve_indirect_refs+0x372)
> >         0xffffffff818c7122 is in resolve_indirect_refs (./include/linux=
/srcu.h:179).
> >         174      * Exit an SRCU read-side critical section.
> >         175      */
> >         176     static inline void srcu_read_unlock(struct srcu_struct =
*ssp, int idx)
> >         177             __releases(ssp)
> >         178     {
> >         179             WARN_ON_ONCE(idx & ~0x1);
> >         180             rcu_lock_release(&(ssp)->dep_map);
> >         181             __srcu_read_unlock(ssp, idx);
> >         182     }
> >         183
> >
> >         (gdb) list *(find_parent_nodes+0x5c6)
> >         0xffffffff818c8186 is in find_parent_nodes (fs/btrfs/backref.c:=
1238).
> >         1233            if (ret)
> >         1234                    goto out;
> >         1235
> >         1236            WARN_ON(!RB_EMPTY_ROOT(&preftrees.indirect_miss=
ing_keys.root.rb_root));
> >         1237
> >         1238            ret =3D resolve_indirect_refs(fs_info, path, ti=
me_seq, &preftrees,
> >         1239                                        extent_item_pos, to=
tal_refs, sc, ignore_offset);
> >         1240            if (ret)
> >         1241                    goto out;
> >         1242
> >
>=20
> This looks like a problem I have been hitting sporadically for
> sometime now while trying to debug other problems (and balance and
> logical ino calls aren't needed, just writes and fiemap in parallel).
> I just a sent 2 patches patchset to address it:
>=20
> https://lore.kernel.org/linux-btrfs/20200122122320.30073-1-fdmanana@kerne=
l.org/
> https://lore.kernel.org/linux-btrfs/20200122122354.30132-1-fdmanana@kerne=
l.org/
>=20
> The first patch is a bug fix, the second one just an optimization (not
> necessary to fix any bug).
>=20
> Try it so see if it solves the problem for you too.

It does!  Sorry for the late reply, I wanted to test it thoroughly to
be sure, and it can take a week to hit the bug.

With this patch and Qu's recent reloc_root UAF fixes, I have seen
zero crashes since January 16 on 5.4.8+ and 5.5-rc6+ running the test
workload above.

This is the first kernel I've tested that can run the test workload
above for more than 10 days on btrfs.  18 days and counting!

The 3 mod tree log UAF bug fixes from you in the last year also fix all
my known crash cases for 5.0.21.  Tests on that kernel have not crashed
running this test workload since January 16 either.

I think these 4 patches combined also fix all known crashes on 5.1,
5.2, and 5.3, but I haven't run those kernels through as many testing
hours as I have for 5.0, 5.4, and 5.5.  After Qu's reloc_root patch,
5.1 to 5.3 only showed mod tree BUG_ONs in testing, so it's plausible
that all crashes are fixed there too.

After applying the mod tree patches to 4.20 and 4.19, these kernels
no longer hit BUG_ON in tree mod, they now only fail with a deadlock.
I'm bisecting 4.20..5.0 to see if I can isolate where that got fixed,
and whether it's a candidate for a stable backport.


> Thanks.
>=20
>=20
> --=20
> Filipe David Manana,
>=20
> =E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you'=
re right.=E2=80=9D

--VvnGyWaJ9JuxX38U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXjhhpwAKCRCB+YsaVrMb
nPqVAKCDjT4alwOm7KTem80ky+Lxj2MlMwCffTLIakobRz+ZfzieALhhd046wt0=
=xb7k
-----END PGP SIGNATURE-----

--VvnGyWaJ9JuxX38U--
