Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6F5E1FC4A
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2019 23:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfEOVgw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 May 2019 17:36:52 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:34068 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbfEOVgv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 May 2019 17:36:51 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 3860B2FCBBC; Wed, 15 May 2019 17:36:50 -0400 (EDT)
Date:   Wed, 15 May 2019 17:36:50 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     linux-btrfs@vger.kernel.org
Subject: storm-of-soft-lockups: spinlocks running on all cores, preventing
 forward progress (4.14- to 5.0+)
Message-ID: <20190515213650.GG20359@hungrycats.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="AjmyJqqohANyBN/e"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--AjmyJqqohANyBN/e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

"Storm-of-soft-lockups" is a failure mode where btrfs puts all of the
CPU cores in kernel functions that are unable to make forward progress,
but also unwilling to release their respective CPU cores.  This is
usually accompanied by a lot of CPU usage (detectable as either kvm CPU
usage or just a lot of CPU fan noise) though I don't know if all cores
are spinning or only some of them.

The kernel console presents a continual stream of "BUG: soft lockup"
warnings for some days.  None of the call traces change during this time.
The only way out is to reboot.

You can reproduce this by writing a bunch of data to a filesystem while
bees is running on all cores.  It takes a few days to occur naturally.
It can probably be sped up by just doing a bunch of random LOGICAL_INO
ioctls in a tight loop on each core.

Here's an instance on a 4-CPU VM where CPU#0 is running btrfs-transaction
(btrfs_try_tree_write_lock) and CPU#1-3 are running the LOGICAL_INO
ioctl (btrfs_tree_read_lock_atomic):

	[509506.128259] watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [btrfs-t=
ransacti:4716]
	[509506.130000] Modules linked in: mq_deadline bfq dm_cache_smq ppdev joyd=
ev dm_cache dm_persistent_data dm_bio_prison dm_bufio crct10dif_pclmul crc3=
2_pclmul crc32c_intel ghash_clmulni_intel dm_mod aesni_intel aes_x86_64 cry=
pto_simd cryptd glue_helper sr_mod cdrom sg ide_pci_generic piix input_leds=
 i2c_piix4 bochs_drm ide_core rtc_cmos floppy parport_pc parport psmouse se=
rio_raw evbug evdev snd_pcm snd_timer snd soundcore pcspkr qemu_fw_cfg ip_t=
ables x_tables ipv6 crc_ccitt autofs4
	[509506.137503] irq event stamp: 217070078
	[509506.138165] hardirqs last  enabled at (217070077): [<ffffffffa2dcafb6>=
] _raw_spin_unlock_irqrestore+0x36/0x60
	[509506.140129] hardirqs last disabled at (217070078): [<ffffffffa2dc32c9>=
] __schedule+0xd9/0xb70
	[509506.141653] softirqs last  enabled at (217069454): [<ffffffffa30003a0>=
] __do_softirq+0x3a0/0x45a
	[509506.143251] softirqs last disabled at (217069443): [<ffffffffa20a9949>=
] irq_exit+0xe9/0xf0
	[509506.144782] CPU: 0 PID: 4716 Comm: btrfs-transacti Tainted: G      D W=
    L    5.0.11-zb64-ae88fcd98bb4+ #1
	[509506.146453] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S 1.10.2-1 04/01/2014
	[509506.147881] RIP: 0010:queued_write_lock_slowpath+0x4e/0x90
	[509506.148912] Code: c0 75 0d ba ff 00 00 00 f0 0f b1 13 85 c0 74 33 f0 8=
1 03 00 01 00 00 b9 ff 00 00 00 be 00 01 00 00 8b 03 3d 00 01 00 00 74 0c <=
f3> 90 8b 13 81 fa 00 01 00 00 75 f4 89 f0 f0 0f b1 0b 3d 00 01 00
	[509506.152585] RSP: 0018:ffffab0b412579c0 EFLAGS: 00000206 ORIG_RAX: ffff=
ffffffffff13
	[509506.154027] RAX: 00000000000001ff RBX: ffff89ea1ac6fde8 RCX: 000000000=
00000ff
	[509506.155449] RDX: 00000000000001ff RSI: 0000000000000100 RDI: ffff89ea1=
ac6fde8
	[509506.156729] RBP: ffffab0b412579d0 R08: ffffffffa2502785 R09: 000000000=
0000000
	[509506.157946] R10: ffffab0b41257980 R11: ffff89ea1ac6fe00 R12: ffff89ea1=
ac6fdec
	[509506.159175] R13: 0000000000000001 R14: 0000000000000000 R15: 000000000=
0000001
	[509506.160345] FS:  0000000000000000(0000) GS:ffff89ebb5c00000(0000) knlG=
S:0000000000000000
	[509506.161714] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	[509506.162703] CR2: 00007f381507ca68 CR3: 000000021b0b0003 CR4: 000000000=
01606f0
	[509506.164006] Call Trace:
	[509506.164473]  do_raw_write_lock+0xae/0xb0
	[509506.165315]  _raw_write_lock+0x55/0x70
	[509506.166026]  btrfs_try_tree_write_lock+0x35/0x90
	[509506.167033]  btrfs_search_slot+0x41c/0x930
	[509506.167981]  lookup_inline_extent_backref+0x118/0x570
	[509506.168929]  ? kvm_sched_clock_read+0x18/0x30
	[509506.169763]  insert_inline_extent_backref+0x51/0xe0
	[509506.170686]  __btrfs_inc_extent_ref+0x87/0x220
	[509506.171583]  ? lock_acquire+0xbd/0x1c0
	[509506.172394]  run_delayed_tree_ref+0x182/0x1f0
	[509506.173264]  run_one_delayed_ref+0x94/0xa0
	[509506.174043]  btrfs_run_delayed_refs_for_head+0x17b/0x3b0
	[509506.175064]  __btrfs_run_delayed_refs+0x84/0x180
	[509506.175948]  btrfs_run_delayed_refs+0x86/0x1e0
	[509506.176803]  btrfs_commit_transaction+0x52/0xa00
	[509506.177695]  ? start_transaction+0x93/0x4d0
	[509506.178506]  transaction_kthread+0x155/0x190
	[509506.179450]  kthread+0x113/0x150
	[509506.180222]  ? btrfs_cleanup_transaction+0x630/0x630
	[509506.181178]  ? kthread_park+0x90/0x90
	[509506.181896]  ret_from_fork+0x3a/0x50

	[509514.134266] watchdog: BUG: soft lockup - CPU#1 stuck for 23s! [crawl_6=
501:4815]
	[509514.135639] Modules linked in: mq_deadline bfq dm_cache_smq ppdev joyd=
ev dm_cache dm_persistent_data dm_bio_prison dm_bufio crct10dif_pclmul crc3=
2_pclmul crc32c_intel ghash_clmulni_intel dm_mod aesni_intel aes_x86_64 cry=
pto_simd cryptd glue_helper sr_mod cdrom sg ide_pci_generic piix input_leds=
 i2c_piix4 bochs_drm ide_core rtc_cmos floppy parport_pc parport psmouse se=
rio_raw evbug evdev snd_pcm snd_timer snd soundcore pcspkr qemu_fw_cfg ip_t=
ables x_tables ipv6 crc_ccitt autofs4
	[509514.144037] irq event stamp: 2124844710
	[509514.144834] hardirqs last  enabled at (2124844709): [<ffffffffa20037da=
>] trace_hardirqs_on_thunk+0x1a/0x1c
	[509514.146349] hardirqs last disabled at (2124844710): [<ffffffffa2dc32c9=
>] __schedule+0xd9/0xb70
	[509514.148170] softirqs last  enabled at (2124844566): [<ffffffffa30003a0=
>] __do_softirq+0x3a0/0x45a
	[509514.149577] softirqs last disabled at (2124844467): [<ffffffffa20a9949=
>] irq_exit+0xe9/0xf0
	[509514.150981] CPU: 1 PID: 4815 Comm: crawl_6501 Tainted: G      D W    L=
    5.0.11-zb64-ae88fcd98bb4+ #1
	[509514.152659] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S 1.10.2-1 04/01/2014
	[509514.154373] RIP: 0010:queued_read_lock_slowpath+0x43/0x80
	[509514.155226] Code: 1f 00 75 3b f0 81 2f 00 02 00 00 ba 01 00 00 00 4c 8=
d 67 04 f0 0f b1 57 04 75 37 f0 81 03 00 02 00 00 8b 03 84 c0 74 08 f3 90 <=
8b> 13 84 d2 75 f8 4c 89 e7 e8 23 d3 ff ff 66 90 5b 41 5c 5d c3 8b
	[509514.158458] RSP: 0018:ffffab0b4145b8d0 EFLAGS: 00000286 ORIG_RAX: ffff=
ffffffffff13
	[509514.160094] RAX: 00000000000002ff RBX: ffff89eaa518b0e8 RCX: 000000000=
0000002
	[509514.161452] RDX: 00000000000002ff RSI: ffffffffa25026b7 RDI: ffff89eaa=
518b0e8
	[509514.162946] RBP: ffffab0b4145b8e0 R08: ffffffffa25026b7 R09: 000000000=
0000000
	[509514.164116] R10: ffffab0b4145b890 R11: ffff89eaa518b100 R12: ffff89eaa=
518b0ec
	[509514.165865] R13: ffff89eaa518b0e8 R14: 0000000000000001 R15: 000000000=
0000002
	[509514.167028] FS:  00007fc7a2c08700(0000) GS:ffff89ebb6000000(0000) knlG=
S:0000000000000000
	[509514.168405] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	[509514.169342] CR2: 000055fa1280ad60 CR3: 000000021b0b0001 CR4: 000000000=
01606e0
	[509514.170504] Call Trace:
	[509514.170927]  do_raw_read_lock+0x4b/0x50
	[509514.171643]  _raw_read_lock+0x58/0x70
	[509514.172343]  btrfs_tree_read_lock_atomic+0x37/0x70
	[509514.173276]  btrfs_search_slot+0x631/0x930
	[509514.173971]  ? trace_hardirqs_on+0x4c/0x100
	[509514.174810]  find_parent_nodes+0x19e/0x1340
	[509514.175596]  btrfs_find_all_roots_safe+0xc5/0x140
	[509514.176534]  ? btrfs_inode_flags_to_fsflags+0x90/0x90
	[509514.177512]  iterate_extent_inodes+0x198/0x3e0
	[509514.178332]  iterate_inodes_from_logical+0xa1/0xd0
	[509514.179234]  ? iterate_inodes_from_logical+0xa1/0xd0
	[509514.180186]  ? btrfs_inode_flags_to_fsflags+0x90/0x90
	[509514.181155]  btrfs_ioctl_logical_to_ino+0xf3/0x1a0
	[509514.182097]  btrfs_ioctl+0xcf7/0x2cb0
	[509514.182837]  ? lock_acquire+0xbd/0x1c0
	[509514.183519]  ? lock_acquire+0xbd/0x1c0
	[509514.184215]  do_vfs_ioctl+0xa6/0x6e0
	[509514.184957]  ? btrfs_ioctl_get_supported_features+0x30/0x30
	[509514.185966]  ? do_vfs_ioctl+0xa6/0x6e0
	[509514.186687]  ? __fget+0x119/0x200
	[509514.187277]  ksys_ioctl+0x75/0x80
	[509514.187958]  __x64_sys_ioctl+0x1a/0x20
	[509514.188677]  do_syscall_64+0x65/0x190
	[509514.189340]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
	[509514.190278] RIP: 0033:0x7fc7a4d02777
	[509514.191003] Code: 00 00 90 48 8b 05 19 a7 0c 00 64 c7 00 26 00 00 00 4=
8 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <=
48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e9 a6 0c 00 f7 d8 64 89 01 48
	[509514.194420] RSP: 002b:00007fc7a2c05458 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000010
	[509514.195742] RAX: ffffffffffffffda RBX: 00007fc7a2c05780 RCX: 00007fc7a=
4d02777
	[509514.197070] RDX: 00007fc7a2c05788 RSI: 00000000c038943b RDI: 000000000=
0000004
	[509514.198340] RBP: 0000000001000000 R08: 0000000000000000 R09: 00007fc7a=
2c05960
	[509514.199699] R10: 000055b03d58cc40 R11: 0000000000000246 R12: 000000000=
0000004
	[509514.201021] R13: 00007fc7a2c05788 R14: 00007fc7a2c05668 R15: 00007fc7a=
2c05890

	[507290.135151] watchdog: BUG: soft lockup - CPU#2 stuck for 22s! [crawl_6=
501:4813]
	[507290.135157] Modules linked in: mq_deadline bfq dm_cache_smq ppdev joyd=
ev dm_cache dm_persistent_data dm_bio_prison dm_bufio crct10dif_pclmul crc3=
2_pclmul crc32c_intel ghash_clmulni_intel dm_mod aesni_intel aes_x86_64 cry=
pto_simd cryptd glue_helper sr_mod cdrom sg ide_pci_generic piix input_leds=
 i2c_piix4 bochs_drm ide_core rtc_cmos floppy parport_pc parport psmouse se=
rio_raw evbug evdev snd_pcm snd_timer snd soundcore pcspkr qemu_fw_cfg ip_t=
ables x_tables ipv6 crc_ccitt autofs4
	[507290.135177] irq event stamp: 2472772428
	[507290.135186] hardirqs last  enabled at (2472772427): [<ffffffffa21448d6=
>] __call_rcu.constprop.43+0x126/0x430
	[507290.135187] hardirqs last disabled at (2472772428): [<ffffffffa2dc32c9=
>] __schedule+0xd9/0xb70
	[507290.135189] softirqs last  enabled at (2472772410): [<ffffffffa30003a0=
>] __do_softirq+0x3a0/0x45a
	[507290.135191] softirqs last disabled at (2472772383): [<ffffffffa20a9949=
>] irq_exit+0xe9/0xf0
	[507290.135199] CPU: 2 PID: 4813 Comm: crawl_6501 Tainted: G      D W    L=
    5.0.11-zb64-ae88fcd98bb4+ #1
	[507290.135200] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S 1.10.2-1 04/01/2014
	[507290.135202] RIP: 0010:native_safe_halt+0x6/0x10
	[507290.135204] Code: 5d ff ff ff 7f 5d c3 65 48 8b 04 25 00 6e 01 00 f0 8=
0 48 02 20 48 8b 00 a8 08 74 8b eb c1 90 90 90 90 90 90 55 48 89 e5 fb f4 <=
5d> c3 0f 1f 84 00 00 00 00 00 55 48 89 e5 f4 5d c3 90 90 90 90 90
	[507290.135211] RSP: 0018:ffffab0b4144b850 EFLAGS: 00000246 ORIG_RAX: ffff=
ffffffffff13
	[507290.135212] RAX: 0000000000000000 RBX: ffff89eaa518b0ec RCX: 000000000=
0000008
	[507290.135212] RDX: ffff89eba5f08000 RSI: ffffffffa2119a63 RDI: ffffffffa=
207a316
	[507290.135213] RBP: ffffab0b4144b850 R08: 0000000000000000 R09: 000000000=
000004c
	[507290.135214] R10: ffffab0b4144b890 R11: ffff89eaa518b100 R12: 000000000=
0000246
	[507290.135214] R13: 0000000000000003 R14: 0000000000000100 R15: 000000000=
0000000
	[507290.135215] FS:  00007fc7a3c0a700(0000) GS:ffff89ebb6400000(0000) knlG=
S:0000000000000000
	[507290.135216] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	[507290.135217] CR2: 000055def62f0f90 CR3: 000000021b0b0002 CR4: 000000000=
01606e0
	[507290.135226] Call Trace:
	[507290.135229]  kvm_wait+0x8b/0x90
	[507290.135231]  __pv_queued_spin_lock_slowpath+0x273/0x2b0
	[507290.135240]  queued_read_lock_slowpath+0x75/0x80
	[507290.135241]  do_raw_read_lock+0x4b/0x50
	[507290.135243]  _raw_read_lock+0x58/0x70
	[507290.135245]  btrfs_tree_read_lock_atomic+0x37/0x70
	[507290.135254]  btrfs_search_slot+0x631/0x930
	[507290.135256]  ? trace_hardirqs_on+0x4c/0x100
	[507290.135266]  find_parent_nodes+0x19e/0x1340
	[507290.135280]  btrfs_find_all_roots_safe+0xc5/0x140
	[507290.135282]  ? btrfs_inode_flags_to_fsflags+0x90/0x90
	[507290.135284]  iterate_extent_inodes+0x198/0x3e0
	[507290.135295]  iterate_inodes_from_logical+0xa1/0xd0
	[507290.135312]  ? iterate_inodes_from_logical+0xa1/0xd0
	[507290.135313]  ? btrfs_inode_flags_to_fsflags+0x90/0x90
	[507290.135316]  btrfs_ioctl_logical_to_ino+0xf3/0x1a0
	[507290.135324]  btrfs_ioctl+0xcf7/0x2cb0
	[507290.135327]  ? lock_acquire+0xbd/0x1c0
	[507290.135330]  ? lock_acquire+0xbd/0x1c0
	[507290.135339]  do_vfs_ioctl+0xa6/0x6e0
	[507290.135340]  ? btrfs_ioctl_get_supported_features+0x30/0x30
	[507290.135341]  ? do_vfs_ioctl+0xa6/0x6e0
	[507290.135343]  ? __fget+0x119/0x200
	[507290.135351]  ksys_ioctl+0x75/0x80
	[507290.135353]  __x64_sys_ioctl+0x1a/0x20
	[507290.135355]  do_syscall_64+0x65/0x190
	[507290.135357]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
	[507290.135365] RIP: 0033:0x7fc7a4d02777
	[507290.135367] Code: 00 00 90 48 8b 05 19 a7 0c 00 64 c7 00 26 00 00 00 4=
8 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <=
48> 3d 0
	1 f0 ff ff 73 01 c3 48 8b 0d e9 a6 0c 00 f7 d8 64 89 01 48
	[507290.135367] RSP: 002b:00007fc7a3c07458 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000010
	[507290.135368] RAX: ffffffffffffffda RBX: 00007fc7a3c07780 RCX: 00007fc7a=
4d02777
	[507290.135369] RDX: 00007fc7a3c07788 RSI: 00000000c038943b RDI: 000000000=
0000004
	[507290.135370] RBP: 0000000001000000 R08: 0000000000000000 R09: 00007fc7a=
3c07960
	[507290.135376] R10: 000055b03d58cc40 R11: 0000000000000246 R12: 000000000=
0000004
	[507290.135376] R13: 00007fc7a3c07788 R14: 00007fc7a3c07668 R15: 00007fc7a=
3c07890
	[507290.135680] hardirqs last  enabled at (217070077): [<ffffffffa2dcafb6>=
] _raw_spin_unlock_irqrestore+0x36/0x60
	[507290.135682] hardirqs last disabled at (217070078): [<ffffffffa2dc32c9>=
] __schedule+0xd9/0xb70

	[506450.138317] watchdog: BUG: soft lockup - CPU#3 stuck for 22s! [crawl_6=
501:4816]
	[506450.138318] Modules linked in: mq_deadline bfq dm_cache_smq ppdev joyd=
ev dm_cache dm_persistent_data dm_bio_prison dm_bufio crct10dif_pclmul crc3=
2_pclmul crc32c_intel ghash_clmulni_intel dm_mod aesni_intel aes_x86_64 cry=
pto_simd cryptd glue_helper sr_mod cdrom sg ide_pci_generic piix input_leds=
 i2c_piix4 bochs_drm ide_core rtc_cmos floppy parport_pc parport psmouse se=
rio_raw evbug evdev snd_pcm snd_timer snd soundcore pcspkr qemu_fw_cfg ip_t=
ables x_tables ipv6 crc_ccitt autofs4
	[506450.138334] irq event stamp: 2322381922
	[506450.138338] hardirqs last  enabled at (2322381921): [<ffffffffa22d525b=
>] kmem_cache_free+0x6b/0x1e0
	[506450.138340] hardirqs last disabled at (2322381922): [<ffffffffa2dc32c9=
>] __schedule+0xd9/0xb70
	[506450.138342] softirqs last  enabled at (2322378644): [<ffffffffa30003a0=
>] __do_softirq+0x3a0/0x45a
	[506450.138344] softirqs last disabled at (2322378637): [<ffffffffa20a9949=
>] irq_exit+0xe9/0xf0
	[506450.138346] CPU: 3 PID: 4816 Comm: crawl_6501 Tainted: G      D W    L=
    5.0.11-zb64-ae88fcd98bb4+ #1
	[506450.138347] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S 1.10.2-1 04/01/2014
	[506450.138349] RIP: 0010:native_safe_halt+0x6/0x10
	[506450.138352] Code: 5d ff ff ff 7f 5d c3 65 48 8b 04 25 00 6e 01 00 f0 8=
0 48 02 20 48 8b 00 a8 08 74 8b eb c1 90 90 90 90 90 90 55 48 89 e5 fb f4 <=
5d> c3 0f 1f 84 00 00 00 00 00 55 48 89 e5 f4 5d c3 90 90 90 90 90
	[506450.138352] RSP: 0018:ffffab0b41463850 EFLAGS: 00000246 ORIG_RAX: ffff=
ffffffffff13
	[506450.138353] RAX: 0000000000000000 RBX: ffff89ebb6a159d4 RCX: 000000000=
0000001
	[506450.138354] RDX: ffff89eb9b10c000 RSI: ffffffffa21199dd RDI: ffffffffa=
207a316
	[506450.138355] RBP: ffffab0b41463850 R08: 0000000000000000 R09: 000000000=
0000000
	[506450.138356] R10: ffffab0b41463890 R11: ffff89eaa518b100 R12: 000000000=
0000246
	[506450.138356] R13: 0000000000000001 R14: ffff89ebb6a159d4 R15: 000000000=
0000001
	[506450.138357] FS:  00007fc7a2407700(0000) GS:ffff89ebb6800000(0000) knlG=
S:0000000000000000
	[506450.138358] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	[506450.138359] CR2: 00007f326a211c50 CR3: 000000021b0b0006 CR4: 000000000=
01606e0
	[506450.138362] Call Trace:
	[506450.138365]  kvm_wait+0x8b/0x90
	[506450.138368]  __pv_queued_spin_lock_slowpath+0x1ed/0x2b0
	[506450.138371]  queued_read_lock_slowpath+0x75/0x80
	[506450.138372]  do_raw_read_lock+0x4b/0x50
	[506450.138374]  _raw_read_lock+0x58/0x70
	[506450.138376]  btrfs_tree_read_lock_atomic+0x37/0x70
	[506450.138379]  btrfs_search_slot+0x631/0x930
	[506450.138382]  ? trace_hardirqs_on+0x4c/0x100
	[506450.138386]  find_parent_nodes+0x19e/0x1340
	[506450.138394]  btrfs_find_all_roots_safe+0xc5/0x140
	[506450.138396]  ? btrfs_inode_flags_to_fsflags+0x90/0x90
	[506450.138399]  iterate_extent_inodes+0x198/0x3e0
	[506450.138404]  iterate_inodes_from_logical+0xa1/0xd0
	[506450.138406]  ? iterate_inodes_from_logical+0xa1/0xd0
	[506450.138407]  ? btrfs_inode_flags_to_fsflags+0x90/0x90
	[506450.138410]  btrfs_ioctl_logical_to_ino+0xf3/0x1a0
	[506450.138412]  btrfs_ioctl+0xcf7/0x2cb0
	[506450.138415]  ? lock_acquire+0xbd/0x1c0
	[506450.138418]  ? lock_acquire+0xbd/0x1c0
	[506450.138421]  do_vfs_ioctl+0xa6/0x6e0
	[506450.138422]  ? btrfs_ioctl_get_supported_features+0x30/0x30
	[506450.138423]  ? do_vfs_ioctl+0xa6/0x6e0
	[506450.138425]  ? __fget+0x119/0x200
	[506450.138428]  ksys_ioctl+0x75/0x80
	[506450.138430]  __x64_sys_ioctl+0x1a/0x20
	[506450.138432]  do_syscall_64+0x65/0x190
	[506450.138434]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
	[506450.138435] RIP: 0033:0x7fc7a4d02777
	[506450.138437] Code: 00 00 90 48 8b 05 19 a7 0c 00 64 c7 00 26 00 00 00 4=
8 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <=
48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e9 a6 0c 00 f7 d8 64 89 01 48
	[506450.138438] RSP: 002b:00007fc7a2404458 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000010
	[506450.138439] RAX: ffffffffffffffda RBX: 00007fc7a2404780 RCX: 00007fc7a=
4d02777
	[506450.138440] RDX: 00007fc7a2404788 RSI: 00000000c038943b RDI: 000000000=
0000004
	[506450.138440] RBP: 0000000001000000 R08: 0000000000000000 R09: 00007fc7a=
2404960
	[506450.138441] R10: 000055b03d58cc40 R11: 0000000000000246 R12: 000000000=
0000004
	[506450.138442] R13: 00007fc7a2404788 R14: 00007fc7a2404668 R15: 00007fc7a=
2404890
	[506450.142132] irq event stamp: 2124844710
	[506450.142136] hardirqs last  enabled at (2124844709): [<ffffffffa20037da=
>] trace_hardirqs_on_thunk+0x1a/0x1c

[ed note: The logs are from different timestamps because I wanted to get a
clean copy of each stack trace.  Usually two of the cores are running call
traces at the same time, making jumbled output, so I picked call traces
=66rom different points in the log to make the traces as cleanly separated
as possible.  Any cut+paste errors are mine.  The stack traces for each
core are all identical and there are hundreds of them from this instance.]

--AjmyJqqohANyBN/e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXNyGbwAKCRCB+YsaVrMb
nOWTAJ0TTJI7oZFO/iYSEWkny+301JsgKACfdTHE2GUK8nV/zBhdFKXlEPxydMc=
=T+qv
-----END PGP SIGNATURE-----

--AjmyJqqohANyBN/e--
