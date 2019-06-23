Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30A764FC04
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Jun 2019 16:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfFWOOg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Jun 2019 10:14:36 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:48526 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725963AbfFWOOg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Jun 2019 10:14:36 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id C54DE35B6A7; Sun, 23 Jun 2019 10:14:34 -0400 (EDT)
Date:   Sun, 23 Jun 2019 10:14:34 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     linux-btrfs@vger.kernel.org
Subject: Re: Global reserve and ENOSPC while deleting snapshots on 5.0.9 -
 still happens on 5.1.11
Message-ID: <20190623141434.GB11831@hungrycats.org>
References: <20190423230649.GB11530@hungrycats.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Content-Disposition: inline
In-Reply-To: <20190423230649.GB11530@hungrycats.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2019 at 07:06:51PM -0400, Zygo Blaxell wrote:
> I had a test filesystem that ran out of unallocated space, then ran
> out of metadata space during a snapshot delete, and forced readonly.
> The workload before the failure was a lot of rsync and bees dedupe
> combined with random snapshot creates and deletes.

Had this happen again on a production filesystem, this time on 5.1.11,
and it happened during orphan inode cleanup instead of snapshot delete:

	[14303.076134][T20882] BTRFS: error (device dm-21) in add_to_free_space_tr=
ee:1037: errno=3D-28 No space left
	[14303.076144][T20882] BTRFS: error (device dm-21) in __btrfs_free_extent:=
7196: errno=3D-28 No space left
	[14303.076157][T20882] BTRFS: error (device dm-21) in btrfs_run_delayed_re=
fs:3008: errno=3D-28 No space left
	[14303.076203][T20882] BTRFS error (device dm-21): Error removing orphan e=
ntry, stopping orphan cleanup
	[14303.076210][T20882] BTRFS error (device dm-21): could not do orphan cle=
anup -22
	[14303.076281][T20882] BTRFS error (device dm-21): commit super ret -30
	[14303.357337][T20882] BTRFS error (device dm-21): open_ctree failed

Same fix:  I bumped the reserved size limit from 512M to 2G and mounted
normally.  (OK, technically, I booted my old 5.0.21 kernel--but my 5.0.21
kernel has the 2G reserved space patch below in it.)

I've not been able to repeat this ENOSPC behavior under test conditions
in the last two months of trying, but it's now happened twice in different
places, so it has non-zero repeatability.

> I tried the usual fix strategies:
>=20
> 	1.  Immediately after mount, try to balance to free space for
> 	metadata
>=20
> 	2.  Immediately after mount, add additional disks to provide
> 	unallocated space for metadata
>=20
> 	3.  Mount -o nossd to increase metadata density
>=20
> #3 had no effect.  #1 failed consistently.
>=20
> #2 was successful, but the additional space was not used because
> btrfs couldn't allocate chunks for metadata because it ran out of
> metadata space for new metadata chunks.
>=20
> When btrfs-cleaner tried to remove the first pending deleted snapshot,
> it started a transaction that failed due to lack of metadata space.
> Since the transaction failed, the filesystem reverts to its earlier state,
> and exactly the same thing happens on the next mount.  The 'btrfs dev
> add' in #2 is successful only if it is executed immediately after mount,
> before the btrfs-cleaner thread wakes up.
>=20
> Here's what the kernel said during one of the attempts:
>=20
> 	[41263.822252] BTRFS info (device dm-3): use zstd compression, level 0
> 	[41263.825135] BTRFS info (device dm-3): using free space tree
> 	[41263.827319] BTRFS info (device dm-3): has skinny extents
> 	[42046.463356] ------------[ cut here ]------------
> 	[42046.463387] BTRFS: error (device dm-3) in __btrfs_free_extent:7056: e=
rrno=3D-28 No space left
> 	[42046.463404] BTRFS: error (device dm-3) in __btrfs_free_extent:7056: e=
rrno=3D-28 No space left
> 	[42046.463407] BTRFS info (device dm-3): forced readonly
> 	[42046.463414] BTRFS: error (device dm-3) in btrfs_run_delayed_refs:3011=
: errno=3D-28 No space left
> 	[42046.463429] BTRFS: error (device dm-3) in btrfs_create_pending_block_=
groups:10517: errno=3D-28 No space left
> 	[42046.463548] BTRFS: error (device dm-3) in btrfs_create_pending_block_=
groups:10520: errno=3D-28 No space left
> 	[42046.471363] BTRFS: error (device dm-3) in btrfs_run_delayed_refs:3011=
: errno=3D-28 No space left
> 	[42046.471475] BTRFS: error (device dm-3) in btrfs_create_pending_block_=
groups:10517: errno=3D-28 No space left
> 	[42046.471506] BTRFS: error (device dm-3) in btrfs_create_pending_block_=
groups:10520: errno=3D-28 No space left
> 	[42046.473672] BTRFS: error (device dm-3) in btrfs_drop_snapshot:9489: e=
rrno=3D-28 No space left
> 	[42046.475643] WARNING: CPU: 0 PID: 10187 at fs/btrfs/extent-tree.c:7056=
 __btrfs_free_extent+0x364/0xf60
> 	[42046.475645] Modules linked in: mq_deadline bfq dm_cache_smq dm_cache =
dm_persistent_data dm_bio_prison dm_bufio joydev ppdev crct10dif_pclmul crc=
32_pclmul crc32c_intel ghash_clmulni_intel dm_mod snd_pcm aesni_intel aes_x=
86_64 snd_timer crypto_simd cryptd glue_helper sr_mod snd cdrom psmouse sg =
soundcore input_leds pcspkr serio_raw ide_pci_generic i2c_piix4 bochs_drm p=
arport_pc piix rtc_cmos floppy parport pcc_cpufreq ide_core qemu_fw_cfg evb=
ug evdev ip_tables x_tables ipv6 crc_ccitt autofs4
> 	[42046.475677] CPU: 0 PID: 10187 Comm: btrfs-transacti Tainted: G    B  =
 W         5.0.8-zb64-10a85e8a1569+ #1
> 	[42046.475678] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BI=
OS 1.10.2-1 04/01/2014
> 	[42046.475681] RIP: 0010:__btrfs_free_extent+0x364/0xf60
> 	[42046.475684] Code: 50 f0 48 0f ba a8 90 22 00 00 02 72 1f 8b 85 88 fe =
ff ff 83 f8 fb 0f 84 59 04 00 00 89 c6 48 c7 c7 00 85 be b8 e8 3c 1b 9b ff =
<0f> 0b 8b 8d 88 fe ff ff 48 8b bd 90 fe ff ff ba 90 1b 00 00 48 c7
> 	[42046.475685] RSP: 0018:ffff888103d8f8e0 EFLAGS: 00010282
> 	[42046.475688] RAX: 0000000000000000 RBX: ffff88802d9ce370 RCX: ffffffff=
b7224ca2
> 	[42046.475689] RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffff8881=
1960dfac
> 	[42046.475691] RBP: ffff888103d8fa98 R08: ffffed10232c24c1 R09: ffffed10=
232c24c0
> 	[42046.475693] R10: ffff888025c94aeb R11: ffffed10232c24c1 R12: 00000000=
00a5054e
> 	[42046.475694] R13: 0000000000003000 R14: 000000000000214a R15: ffff8881=
03d8fa70
> 	[42046.475696] FS:  0000000000000000(0000) GS:ffff888119400000(0000) knl=
GS:0000000000000000
> 	[42046.475698] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 	[42046.475700] CR2: 00007f1b84271718 CR3: 00000000a3636001 CR4: 00000000=
001606f0
> 	[42046.475702] Call Trace:
> 	[42046.475707]  ? trace_hardirqs_off+0x24/0x120
> 	[42046.475714]  ? update_block_group+0x6d0/0x6d0
> 	[42046.475718]  ? __lock_acquire+0xf8/0x26e0
> 	[42046.475721]  ? __kasan_slab_free+0x14d/0x230
> 	[42046.475724]  ? btrfs_delayed_ref_lock+0x3e/0x100
> 	[42046.475727]  ? __lock_acquire+0xf8/0x26e0
> 	[42046.475730]  ? kthread+0x1a9/0x200
> 	[42046.475733]  ? debug_show_all_locks+0x210/0x210
> 	[42046.475737]  ? __btrfs_run_delayed_refs+0xce/0x210
> 	[42046.475742]  ? debug_show_all_locks+0x210/0x210
> 	[42046.475747]  run_delayed_data_ref+0x15a/0x400
> 	[42046.475752]  ? alloc_reserved_file_extent+0x520/0x520
> 	[42046.475756]  ? rb_next+0x25/0x90
> 	[42046.475761]  run_one_delayed_ref+0x71/0xe0
> 	[42046.475765]  btrfs_run_delayed_refs_for_head+0x284/0x580
> 	[42046.475772]  __btrfs_run_delayed_refs+0xeb/0x210
> 	[42046.475777]  ? btrfs_run_delayed_refs_for_head+0x580/0x580
> 	[42046.475781]  ? debug_show_all_locks+0x210/0x210
> 	[42046.475786]  btrfs_run_delayed_refs+0xc0/0x260
> 	[42046.475792]  btrfs_commit_transaction+0xf0/0x10f0
> 	[42046.475795]  ? do_raw_spin_unlock+0xa8/0x140
> 	[42046.475799]  ? _raw_spin_unlock+0x27/0x40
> 	[42046.475803]  ? btrfs_record_root_in_trans+0x24/0xb0
> 	[42046.475807]  ? btrfs_apply_pending_changes+0xb0/0xb0
> 	[42046.475809]  ? start_transaction+0x14a/0x760
> 	[42046.475816]  transaction_kthread+0x218/0x250
> 	[42046.475822]  kthread+0x1a9/0x200
> 	[42046.475824]  ? btrfs_cleanup_transaction+0xb80/0xb80
> 	[42046.475827]  ? kthread_park+0xb0/0xb0
> 	[42046.475831]  ret_from_fork+0x3a/0x50
> 	[42046.475837] irq event stamp: 0
> 	[42046.475839] hardirqs last  enabled at (0): [<0000000000000000>]      =
     (null)
> 	[42046.475843] hardirqs last disabled at (0): [<ffffffffb70efe95>] copy_=
process.part.7+0xad5/0x3b80
> 	[42046.475846] softirqs last  enabled at (0): [<ffffffffb70efe95>] copy_=
process.part.7+0xad5/0x3b80
> 	[42046.475847] softirqs last disabled at (0): [<0000000000000000>]      =
     (null)
> 	[42046.475849] ---[ end trace b02d556137ea688c ]---
> 	[42046.475852] BTRFS: error (device dm-3) in __btrfs_free_extent:7056: e=
rrno=3D-28 No space left
> 	[42046.475859] BTRFS: error (device dm-3) in btrfs_run_delayed_refs:3011=
: errno=3D-28 No space left
> 	[42046.475878] BTRFS: error (device dm-3) in btrfs_create_pending_block_=
groups:10517: errno=3D-28 No space left
> 	[42046.475905] BTRFS: error (device dm-3) in btrfs_create_pending_block_=
groups:10520: errno=3D-28 No space left
>=20
> I noticed that during the few minutes when the filesystem was running,
> the "global reserve" number in "btrfs fi usage" output kept going up to
> 503M or so, then the transaction failed.
>=20
> I then applied this patch to the kernel (5.0.8):
>=20
> 	diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> 	index 83791d13c204..59ba456e2314 100644
> 	--- a/fs/btrfs/extent-tree.c
> 	+++ b/fs/btrfs/extent-tree.c
> 	@@ -5790,7 +5790,7 @@ static void update_global_block_rsv(struct btrfs_f=
s_info *fs_info)
> 		spin_lock(&sinfo->lock);
> 		spin_lock(&block_rsv->lock);
>=20
> 	-       block_rsv->size =3D min_t(u64, num_bytes, SZ_512M);
> 	+       block_rsv->size =3D min_t(u64, num_bytes, SZ_1G);
>=20
> 		if (block_rsv->reserved < block_rsv->size) {
> 			num_bytes =3D btrfs_space_info_used(sinfo, true);
>=20
> Then mounted the filesystem.
>=20
> With the larger reserved block size, btrfs-cleaner was able to get
> past its earlier failures, allocating 3GB of new metadata chunks in the
> first transaction after it started deleting snapshots.  After this, the
> filesystem deleted some more snapshots (there are currently 2470 deleted
> snapshots remaining on this filesystem).
>=20
> This isn't really a solution, though, for two reasons:
>=20
> 1.  The commit that adds the limit on block_rsv->size (fdf30d1c1b3
> "Btrfs: limit the global reserve to 512mb") points out:
>=20
>     A user reported a problem where he was getting early ENOSPC with
>     hundreds of gigs of free data space and 6 gigs of free metadata space.
>     This is because the global block reserve was taking up the entire
>     free metadata space.  This is ridiculous, we have infrastructure in
>     place to throttle if we start using too much of the global reserve,
>     so instead of letting it get this huge just limit it to 512mb so that
>     users can still get work done.  This allowed the user to complete
>     his rsync without issues.=20
>=20
> In other words, something should be handling the case when reserved
> space runs out, and that something is failing.
>=20
> 2.  The 1G reserved limit still isn't sufficient.  The filesystem deletes
> a few dozen snapshots, then fails again later:
>=20
> 	[ 3705.477036] CPU: 2 PID: 8388 Comm: btrfs-transacti Tainted: G    B   =
          5.0.9-zb64-b6eed6abc880+ #3
> 	[ 3705.481510] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BI=
OS 1.10.2-1 04/01/2014
> 	[ 3705.484038] RIP: 0010:__btrfs_free_extent+0x364/0xf60
> 	[ 3705.485061] Code: 50 f0 48 0f ba a8 90 22 00 00 02 72 1f 8b 85 88 fe =
ff ff 83 f8 fb 0f 84 59 04 00 00 89 c6 48 c7 c7 80 85 be 8b e8 fc 1b 9b ff =
<0f> 0b 8b 8d 88 fe ff ff 48 8b bd 90 fe ff ff ba 90 1b 00 00 48 c7
> 	[ 3705.488046] RSP: 0018:ffff8881c29cf8e0 EFLAGS: 00010282
> 	[ 3705.488868] RAX: 0000000000000000 RBX: ffff888121dbdf20 RCX: ffffffff=
8a224a92
> 	[ 3705.490129] RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffff8881=
f5e0dfac
> 	[ 3705.491246] RBP: ffff8881c29cfa98 R08: ffffed103ebc24c1 R09: ffffed10=
3ebc24c0
> 	[ 3705.492376] R10: ffff88819e6d430b R11: ffffed103ebc24c1 R12: 00000000=
009ecb21
> 	[ 3705.493501] R13: 0000000000040000 R14: 00000000000021b3 R15: ffff8881=
c29cfa70
> 	[ 3705.494619] FS:  0000000000000000(0000) GS:ffff8881f5c00000(0000) knl=
GS:0000000000000000
> 	[ 3705.495883] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 	[ 3705.496781] CR2: 0000556bc833ec70 CR3: 00000001ef9e0001 CR4: 00000000=
001606e0
> 	[ 3705.497872] Call Trace:
> 	[ 3705.498279]  ? update_block_group+0x6d0/0x6d0
> 	[ 3705.498950]  ? btrfs_run_delayed_refs_for_head+0x352/0x580
> 	[ 3705.499816]  ? kthread+0x1a9/0x200
> 	[ 3705.500379]  ? debug_show_all_locks+0x210/0x210
> 	[ 3705.501078]  ? __btrfs_run_delayed_refs+0xce/0x210
> 	[ 3705.501813]  ? debug_show_all_locks+0x210/0x210
> 	[ 3705.502516]  run_delayed_data_ref+0x15a/0x400
> 	[ 3705.503193]  ? alloc_reserved_file_extent+0x520/0x520
> 	[ 3705.503968]  ? rb_next+0x3c/0x90
> 	[ 3705.504479]  run_one_delayed_ref+0x71/0xe0
> 	[ 3705.505116]  btrfs_run_delayed_refs_for_head+0x284/0x580
> 	[ 3705.505935]  __btrfs_run_delayed_refs+0xeb/0x210
> 	[ 3705.506649]  ? btrfs_run_delayed_refs_for_head+0x580/0x580
> 	[ 3705.507495]  ? debug_show_all_locks+0x210/0x210
> 	[ 3705.508201]  btrfs_run_delayed_refs+0xc0/0x260
> 	[ 3705.508912]  btrfs_commit_transaction+0xf0/0x10f0
> 	[ 3705.509654]  ? do_raw_spin_unlock+0xa8/0x140
> 	[ 3705.510343]  ? _raw_spin_unlock+0x27/0x40
> 	[ 3705.510979]  ? btrfs_record_root_in_trans+0x24/0xb0
> 	[ 3705.511748]  ? btrfs_apply_pending_changes+0xb0/0xb0
> 	[ 3705.512533]  ? start_transaction+0x14a/0x760
> 	[ 3705.513216]  transaction_kthread+0x218/0x250
> 	[ 3705.513900]  kthread+0x1a9/0x200
> 	[ 3705.514425]  ? btrfs_cleanup_transaction+0xb80/0xb80
> 	[ 3705.515233]  ? kthread_park+0xb0/0xb0
> 	[ 3705.515829]  ret_from_fork+0x3a/0x50
> 	[ 3705.516408] irq event stamp: 0
> 	[ 3705.516898] hardirqs last  enabled at (0): [<0000000000000000>]      =
     (null)
> 	[ 3705.518054] hardirqs last disabled at (0): [<ffffffff8a0efe65>] copy_=
process.part.7+0xad5/0x3b80
> 	[ 3705.519419] softirqs last  enabled at (0): [<ffffffff8a0efe65>] copy_=
process.part.7+0xad5/0x3b80
> 	[ 3705.520779] softirqs last disabled at (0): [<0000000000000000>]      =
     (null)
> 	[ 3705.521944] ---[ end trace 3a5f720e889bc0d3 ]---
> 	[ 3705.522713] BTRFS: error (device dm-3) in __btrfs_free_extent:7056: e=
rrno=3D-28 No space left
> 	[ 3705.524069] BTRFS: error (device dm-3) in btrfs_run_delayed_refs:3011=
: errno=3D-28 No space left
>=20
> If I increase the reserved limit again to 2G, btrfs-cleaner gets past
> this shapshot (so far).  It takes more than 10 minutes to delete some
> of the snapshots, so this will take a while to finish all 2470.
>=20
> The current btrfs fi usage output worries me:
>=20
> 	Overall:
> 	    Device size:                   2.02TiB
> 	    Device allocated:              2.01TiB
> 	    Device unallocated:           10.03GiB
> 	    Device missing:                  0.00B
> 	    Used:                          1.70TiB
> 	    Free (estimated):            296.02GiB      (min: 291.01GiB)
> 	    Data ratio:                       1.00
> 	    Metadata ratio:                   2.00
> 	    Global reserve:                2.00GiB      (used: 864.00KiB)
>=20
> 	Data,single: Size:1.81TiB, Used:1.53TiB
> 	   /dev/mapper/vgnebtest-tvdb    928.97GiB
> 	   /dev/mapper/vgnebtest-tvdc    929.00GiB
>=20
> 	Metadata,RAID1: Size:99.99GiB, Used:82.29GiB
> 	   /dev/mapper/vgnebtest-lvol1     5.00GiB
> 	   /dev/mapper/vgnebtest-lvol2     5.00GiB
> 	   /dev/mapper/vgnebtest-tvdb     94.99GiB
> 	   /dev/mapper/vgnebtest-tvdc     94.99GiB
>=20
> 	System,RAID1: Size:8.00MiB, Used:240.00KiB
> 	   /dev/mapper/vgnebtest-tvdb      8.00MiB
> 	   /dev/mapper/vgnebtest-tvdc      8.00MiB
>=20
> 	Unallocated:
> 	   /dev/mapper/vgnebtest-lvol1     5.00GiB
> 	   /dev/mapper/vgnebtest-lvol2     5.00GiB
> 	   /dev/mapper/vgnebtest-tvdb     30.00MiB
> 	   /dev/mapper/vgnebtest-tvdc      1.00MiB
>=20
> Note "lvol1" and "lvol2" were added after the initial failure. =20
>=20
> There is clearly a lot of metadata space available, but the filesystem st=
ill
> intermittently hits ENOSPC while trying to free space.



--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXQ+JRgAKCRCB+YsaVrMb
nKiRAJ9Yxfp4NYCNvO2EIWmP3XjAgQ+g9QCcC5gdJR0bJwcsf8woOLQ0aEd1RrE=
=aJ1I
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--
