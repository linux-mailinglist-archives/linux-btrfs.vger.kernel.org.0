Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71B5015152B
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 05:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgBDE5p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 23:57:45 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:35726 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbgBDE5p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 23:57:45 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 1F93C5A8529; Mon,  3 Feb 2020 23:57:44 -0500 (EST)
Date:   Mon, 3 Feb 2020 23:57:44 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     linux-btrfs@vger.kernel.org
Subject: Re: storm-of-soft-lockups: spinlocks running on all cores,
 preventing forward progress (4.14- to 5.0+, fixed in 5.4)
Message-ID: <20200204045744.GA13306@hungrycats.org>
References: <20190515213650.GG20359@hungrycats.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bWJzwVwZrZVVyQvz"
Content-Disposition: inline
In-Reply-To: <20190515213650.GG20359@hungrycats.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--bWJzwVwZrZVVyQvz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2019 at 05:36:50PM -0400, Zygo Blaxell wrote:
> "Storm-of-soft-lockups" is a failure mode where btrfs puts all of the
> CPU cores in kernel functions that are unable to make forward progress,
> but also unwilling to release their respective CPU cores.  This is
> usually accompanied by a lot of CPU usage (detectable as either kvm CPU
> usage or just a lot of CPU fan noise) though I don't know if all cores
> are spinning or only some of them.
>=20
> The kernel console presents a continual stream of "BUG: soft lockup"
> warnings for some days.  None of the call traces change during this time.
> The only way out is to reboot.
>=20
> You can reproduce this by writing a bunch of data to a filesystem while
> bees is running on all cores.  It takes a few days to occur naturally.
> It can probably be sped up by just doing a bunch of random LOGICAL_INO
> ioctls in a tight loop on each core.
>=20
> Here's an instance on a 4-CPU VM where CPU#0 is running btrfs-transaction
> (btrfs_try_tree_write_lock) and CPU#1-3 are running the LOGICAL_INO
> ioctl (btrfs_tree_read_lock_atomic):
>=20
> 	[509506.128259] watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [btrfs=
-transacti:4716]
> 	[509506.130000] Modules linked in: mq_deadline bfq dm_cache_smq ppdev jo=
ydev dm_cache dm_persistent_data dm_bio_prison dm_bufio crct10dif_pclmul cr=
c32_pclmul crc32c_intel ghash_clmulni_intel dm_mod aesni_intel aes_x86_64 c=
rypto_simd cryptd glue_helper sr_mod cdrom sg ide_pci_generic piix input_le=
ds i2c_piix4 bochs_drm ide_core rtc_cmos floppy parport_pc parport psmouse =
serio_raw evbug evdev snd_pcm snd_timer snd soundcore pcspkr qemu_fw_cfg ip=
_tables x_tables ipv6 crc_ccitt autofs4
> 	[509506.137503] irq event stamp: 217070078
> 	[509506.138165] hardirqs last  enabled at (217070077): [<ffffffffa2dcafb=
6>] _raw_spin_unlock_irqrestore+0x36/0x60
> 	[509506.140129] hardirqs last disabled at (217070078): [<ffffffffa2dc32c=
9>] __schedule+0xd9/0xb70
> 	[509506.141653] softirqs last  enabled at (217069454): [<ffffffffa30003a=
0>] __do_softirq+0x3a0/0x45a
> 	[509506.143251] softirqs last disabled at (217069443): [<ffffffffa20a994=
9>] irq_exit+0xe9/0xf0
> 	[509506.144782] CPU: 0 PID: 4716 Comm: btrfs-transacti Tainted: G      D=
 W    L    5.0.11-zb64-ae88fcd98bb4+ #1
> 	[509506.146453] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS 1.10.2-1 04/01/2014
> 	[509506.147881] RIP: 0010:queued_write_lock_slowpath+0x4e/0x90
> 	[509506.148912] Code: c0 75 0d ba ff 00 00 00 f0 0f b1 13 85 c0 74 33 f0=
 81 03 00 01 00 00 b9 ff 00 00 00 be 00 01 00 00 8b 03 3d 00 01 00 00 74 0c=
 <f3> 90 8b 13 81 fa 00 01 00 00 75 f4 89 f0 f0 0f b1 0b 3d 00 01 00
> 	[509506.152585] RSP: 0018:ffffab0b412579c0 EFLAGS: 00000206 ORIG_RAX: ff=
ffffffffffff13
> 	[509506.154027] RAX: 00000000000001ff RBX: ffff89ea1ac6fde8 RCX: 0000000=
0000000ff
> 	[509506.155449] RDX: 00000000000001ff RSI: 0000000000000100 RDI: ffff89e=
a1ac6fde8
> 	[509506.156729] RBP: ffffab0b412579d0 R08: ffffffffa2502785 R09: 0000000=
000000000
> 	[509506.157946] R10: ffffab0b41257980 R11: ffff89ea1ac6fe00 R12: ffff89e=
a1ac6fdec
> 	[509506.159175] R13: 0000000000000001 R14: 0000000000000000 R15: 0000000=
000000001
> 	[509506.160345] FS:  0000000000000000(0000) GS:ffff89ebb5c00000(0000) kn=
lGS:0000000000000000
> 	[509506.161714] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 	[509506.162703] CR2: 00007f381507ca68 CR3: 000000021b0b0003 CR4: 0000000=
0001606f0
> 	[509506.164006] Call Trace:
> 	[509506.164473]  do_raw_write_lock+0xae/0xb0
> 	[509506.165315]  _raw_write_lock+0x55/0x70
> 	[509506.166026]  btrfs_try_tree_write_lock+0x35/0x90
> 	[509506.167033]  btrfs_search_slot+0x41c/0x930
> 	[509506.167981]  lookup_inline_extent_backref+0x118/0x570
> 	[509506.168929]  ? kvm_sched_clock_read+0x18/0x30
> 	[509506.169763]  insert_inline_extent_backref+0x51/0xe0
> 	[509506.170686]  __btrfs_inc_extent_ref+0x87/0x220
> 	[509506.171583]  ? lock_acquire+0xbd/0x1c0
> 	[509506.172394]  run_delayed_tree_ref+0x182/0x1f0
> 	[509506.173264]  run_one_delayed_ref+0x94/0xa0
> 	[509506.174043]  btrfs_run_delayed_refs_for_head+0x17b/0x3b0
> 	[509506.175064]  __btrfs_run_delayed_refs+0x84/0x180
> 	[509506.175948]  btrfs_run_delayed_refs+0x86/0x1e0
> 	[509506.176803]  btrfs_commit_transaction+0x52/0xa00
> 	[509506.177695]  ? start_transaction+0x93/0x4d0
> 	[509506.178506]  transaction_kthread+0x155/0x190
> 	[509506.179450]  kthread+0x113/0x150
> 	[509506.180222]  ? btrfs_cleanup_transaction+0x630/0x630
> 	[509506.181178]  ? kthread_park+0x90/0x90
> 	[509506.181896]  ret_from_fork+0x3a/0x50

This was a terrible bug report.  ;)

The storm-of-softlockups happens whenever the kernel hits a BUG_ON while
holding a spinlock.  We have to find the _first_ BUG log message and
stack trace to get any useful information.  The later traces are all
consequences of the first, and they will spam the console until the
hardware watchdog times out and forces a reboot.  All cores are in an
infinite loop and will make no further progress.

I made the connection when I hit the storm of soft lockups twice due
to a BUG_ON in CIFS.  The storm isn't a btrfs-specific feature, but the
causative BUG_ON is.

This turned out to be a BUG_ON in fs/btrfs/ctree.c in
__tree_mod_log_rewind, and the fix is the three recent tree mod log
patches:

        6609fee8897a Btrfs: fix removal logic of the tree mod log that lead=
s to use-after-free issues                              =20
        efad8a853ad2 Btrfs: fix use-after-free when using the tree modifica=
tion log                                                =20
        47c8495d358b Btrfs: fix race between adding and putting tree mod se=
q elements and nodes                                    =20

Thanks again Filipe for these!

--bWJzwVwZrZVVyQvz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXjj5xgAKCRCB+YsaVrMb
nCFTAKCX0OURxtVyOXn4V7oxfHWghgJ3bgCg0qrSWtSvp/dX3RnBnWF0x4vWO0U=
=kGUy
-----END PGP SIGNATURE-----

--bWJzwVwZrZVVyQvz--
