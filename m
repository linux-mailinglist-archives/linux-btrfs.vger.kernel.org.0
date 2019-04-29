Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34F6AECD3
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Apr 2019 00:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbfD2We4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Apr 2019 18:34:56 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:42160 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729534AbfD2Wez (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Apr 2019 18:34:55 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 151F52D7F69; Mon, 29 Apr 2019 18:34:55 -0400 (EDT)
Date:   Mon, 29 Apr 2019 18:34:55 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     linux-btrfs@vger.kernel.org
Subject: Re: WARNING at fs/btrfs/delayed-ref.c:296
 btrfs_merge_delayed_refs+0x3dc/0x410 (still on 5.0.10)
Message-ID: <20190429223454.GB20359@hungrycats.org>
References: <20190326025028.GG16651@hungrycats.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
In-Reply-To: <20190326025028.GG16651@hungrycats.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2019 at 10:50:28PM -0400, Zygo Blaxell wrote:
> Running balance, rsync, and dedupe, I get kernel warnings every few
> minutes on 5.0.4.  No warnings on 5.0.3 under similar conditions.
>=20
> Mount options are:  flushoncommit,space_cache=3Dv2,compress=3Dzstd.
>=20
> There are two different stacks on the warnings.  This one comes from
> btrfs balance:
>=20
> 	[Mon Mar 25 18:22:42 2019] WARNING: CPU: 0 PID: 4786 at fs/btrfs/delayed=
-ref.c:296 btrfs_merge_delayed_refs+0x3dc/0x410
> 	[Mon Mar 25 18:22:42 2019] Modules linked in: ppdev joydev crct10dif_pcl=
mul crc32_pclmul dm_cache_smq crc32c_intel ghash_clmulni_intel dm_cache dm_=
persistent_data dm_bio_prison dm_bufio dm_mod rtc_cmos floppy parport_pc pa=
rport aesni_intel sr_mod cdrom aes_x86_64 crypto_simd cryptd glue_helper sg=
 ide_pci_generic piix ide_core evbug evdev bochs_drm i2c_piix4 input_leds p=
smouse serio_raw snd_pcm snd_timer snd soundcore pcspkr qemu_fw_cfg ip_tabl=
es x_tables ipv6 crc_ccitt autofs4
> 	[Mon Mar 25 18:22:42 2019] CPU: 0 PID: 4786 Comm: btrfs-balance Tainted:=
 G        W         5.0.4-zb64-303ce93b05c9+ #1
> 	[Mon Mar 25 18:22:42 2019] Hardware name: QEMU Standard PC (i440FX + PII=
X, 1996), BIOS 1.10.2-1 04/01/2014
> 	[Mon Mar 25 18:22:42 2019] RIP: 0010:btrfs_merge_delayed_refs+0x3dc/0x410
> 	[Mon Mar 25 18:22:42 2019] Code: 7c 24 28 be ff ff ff ff e8 31 a0 c1 ff =
85 c0 0f 85 7c fe ff ff 0f 0b e9 75 fe ff ff 0f 0b e9 0a fe ff ff 0f 0b e9 =
1b fe ff ff <0f> 0b e9 25 ff ff ff 0f 0b e9 b0 fe ff ff 48 c7 44 24 10 00 0=
0 00
> 	[Mon Mar 25 18:22:42 2019] RSP: 0018:ffffabb981377b70 EFLAGS: 00010246
> 	[Mon Mar 25 18:22:42 2019] RAX: 00000000000000b6 RBX: 00000000ffffffff R=
CX: 0000000000000001
> 	[Mon Mar 25 18:22:42 2019] RDX: 0000000000000000 RSI: 00000000ffffffff R=
DI: 0000000000000282
> 	[Mon Mar 25 18:22:42 2019] RBP: ffff9392514bbb80 R08: ffff9392514bbc80 R=
09: 0000000000000000
> 	[Mon Mar 25 18:22:42 2019] R10: 0000000000000000 R11: 0000000000000001 R=
12: ffff93928a5c8f08
> 	[Mon Mar 25 18:22:42 2019] R13: ffff939269744e38 R14: ffff939269744e38 R=
15: ffff9392697449c0
> 	[Mon Mar 25 18:22:42 2019] FS:  0000000000000000(0000) GS:ffff939475c000=
00(0000) knlGS:0000000000000000
> 	[Mon Mar 25 18:22:42 2019] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005=
0033
> 	[Mon Mar 25 18:22:42 2019] CR2: 00007f0882d38600 CR3: 0000000230eb6002 C=
R4: 00000000001606f0
> 	[Mon Mar 25 18:22:42 2019] Call Trace:
> 	[Mon Mar 25 18:22:42 2019]  __btrfs_run_delayed_refs+0x70/0x170
> 	[Mon Mar 25 18:22:42 2019]  btrfs_run_delayed_refs+0x7d/0x1d0
> 	[Mon Mar 25 18:22:42 2019]  btrfs_commit_transaction+0x50/0x9e0
> 	[Mon Mar 25 18:22:42 2019]  ? start_transaction+0x91/0x4d0
> 	[Mon Mar 25 18:22:42 2019]  relocate_block_group+0x1bd/0x600
> 	[Mon Mar 25 18:22:42 2019]  btrfs_relocate_block_group+0x15b/0x260
> 	[Mon Mar 25 18:22:42 2019]  btrfs_relocate_chunk+0x46/0xf0
> 	[Mon Mar 25 18:22:42 2019]  btrfs_balance+0xa60/0x12b0
> 	[Mon Mar 25 18:22:42 2019]  balance_kthread+0x36/0x50
> 	[Mon Mar 25 18:22:42 2019]  kthread+0x106/0x140
> 	[Mon Mar 25 18:22:42 2019]  ? btrfs_balance+0x12b0/0x12b0
> 	[Mon Mar 25 18:22:42 2019]  ? kthread_park+0x90/0x90
> 	[Mon Mar 25 18:22:42 2019]  ret_from_fork+0x3a/0x50
> 	[Mon Mar 25 18:22:42 2019] irq event stamp: 81529004
> 	[Mon Mar 25 18:22:42 2019] hardirqs last  enabled at (81529003): [<fffff=
fffaa2be2b7>] kmem_cache_free+0x67/0x1e0
> 	[Mon Mar 25 18:22:42 2019] hardirqs last disabled at (81529004): [<fffff=
fffaa00379f>] trace_hardirqs_off_thunk+0x1a/0x1c
> 	[Mon Mar 25 18:22:42 2019] softirqs last  enabled at (81527500): [<fffff=
fffab0003a4>] __do_softirq+0x3a4/0x45f
> 	[Mon Mar 25 18:22:42 2019] softirqs last disabled at (81527493): [<fffff=
fffaa0a3d24>] irq_exit+0xe4/0xf0
> 	[Mon Mar 25 18:22:42 2019] ---[ end trace 3d8cdfff7444099a ]---
>=20
> This one comes from btrfs-transaction:
>=20
> 	[Mon Mar 25 18:27:58 2019] WARNING: CPU: 3 PID: 4137 at fs/btrfs/delayed=
-ref.c:296 btrfs_merge_delayed_refs+0x3dc/0x410
> 	[Mon Mar 25 18:27:58 2019] Modules linked in: ppdev joydev crct10dif_pcl=
mul crc32_pclmul dm_cache_smq crc32c_intel ghash_clmulni_intel dm_cache dm_=
persistent_data dm_bio_prison dm_bufio dm_mod rtc_cmos floppy parport_pc pa=
rport aesni_intel sr_mod cdrom aes_x86_64 crypto_simd cryptd glue_helper sg=
 ide_pci_generic piix ide_core evbug evdev bochs_drm i2c_piix4 input_leds p=
smouse serio_raw snd_pcm snd_timer snd soundcore pcspkr qemu_fw_cfg ip_tabl=
es x_tables ipv6 crc_ccitt autofs4
> 	[Mon Mar 25 18:27:58 2019] CPU: 3 PID: 4137 Comm: btrfs-transacti Tainte=
d: G        W         5.0.4-zb64-303ce93b05c9+ #1
> 	[Mon Mar 25 18:27:58 2019] Hardware name: QEMU Standard PC (i440FX + PII=
X, 1996), BIOS 1.10.2-1 04/01/2014
> 	[Mon Mar 25 18:27:58 2019] RIP: 0010:btrfs_merge_delayed_refs+0x3dc/0x410
> 	[Mon Mar 25 18:27:58 2019] Code: 7c 24 28 be ff ff ff ff e8 31 a0 c1 ff =
85 c0 0f 85 7c fe ff ff 0f 0b e9 75 fe ff ff 0f 0b e9 0a fe ff ff 0f 0b e9 =
1b fe ff ff <0f> 0b e9 25 ff ff ff 0f 0b e9 b0 fe ff ff 48 c7 44 24 10 00 0=
0 00
> 	[Mon Mar 25 18:27:58 2019] RSP: 0018:ffffabb9812f7d40 EFLAGS: 00010246
> 	[Mon Mar 25 18:27:58 2019] RAX: 00000000000000b6 RBX: 00000000ffffffff R=
CX: 0000000000000001
> 	[Mon Mar 25 18:27:58 2019] RDX: 0000000000000000 RSI: 00000000ffffffff R=
DI: 0000000000000286
> 	[Mon Mar 25 18:27:58 2019] RBP: ffff93925b187ce0 R08: ffff93925b187de0 R=
09: 0000000000000000
> 	[Mon Mar 25 18:27:58 2019] R10: 0000000000000000 R11: 0000000000000001 R=
12: ffff93938b59d308
> 	[Mon Mar 25 18:27:58 2019] R13: ffff9393a5d09820 R14: ffff9393a5d09820 R=
15: ffff939261978820
> 	[Mon Mar 25 18:27:58 2019] FS:  0000000000000000(0000) GS:ffff9394768000=
00(0000) knlGS:0000000000000000
> 	[Mon Mar 25 18:27:58 2019] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005=
0033
> 	[Mon Mar 25 18:27:58 2019] CR2: 00007f91f6321c50 CR3: 00000001ef54e003 C=
R4: 00000000001606e0
> 	[Mon Mar 25 18:27:58 2019] Call Trace:
> 	[Mon Mar 25 18:27:58 2019]  __btrfs_run_delayed_refs+0x70/0x170
> 	[Mon Mar 25 18:27:58 2019]  btrfs_run_delayed_refs+0x7d/0x1d0
> 	[Mon Mar 25 18:27:58 2019]  btrfs_commit_transaction+0x50/0x9e0
> 	[Mon Mar 25 18:27:58 2019]  ? start_transaction+0x91/0x4d0
> 	[Mon Mar 25 18:27:58 2019]  transaction_kthread+0x146/0x180
> 	[Mon Mar 25 18:27:58 2019]  kthread+0x106/0x140
> 	[Mon Mar 25 18:27:58 2019]  ? btrfs_cleanup_transaction+0x620/0x620
> 	[Mon Mar 25 18:27:58 2019]  ? kthread_park+0x90/0x90
> 	[Mon Mar 25 18:27:58 2019]  ret_from_fork+0x3a/0x50
> 	[Mon Mar 25 18:27:58 2019] irq event stamp: 81665152
> 	[Mon Mar 25 18:27:58 2019] hardirqs last  enabled at (81665151): [<fffff=
fffaa2be2b7>] kmem_cache_free+0x67/0x1e0
> 	[Mon Mar 25 18:27:58 2019] hardirqs last disabled at (81665152): [<fffff=
fffaa00379f>] trace_hardirqs_off_thunk+0x1a/0x1c
> 	[Mon Mar 25 18:27:58 2019] softirqs last  enabled at (81664580): [<fffff=
fffab0003a4>] __do_softirq+0x3a4/0x45f
> 	[Mon Mar 25 18:27:58 2019] softirqs last disabled at (81664565): [<fffff=
fffaa0a3d24>] irq_exit+0xe4/0xf0
> 	[Mon Mar 25 18:27:58 2019] ---[ end trace 3d8cdfff7444099c ]---
>
> Pausing the balance makes the warnings stop.

After sorting out some unrelated issues with 5.0 kernels, these warnings
are now the top of my list of unresolved 5.0 kernel issues.  They are
popping up more often:  31804 times over two machine-days.  Too much
spam for the kernel logs.

This is the code surrounding the WARN_ON:

static bool merge_ref(...
{
	// ...
		drop_delayed_ref(trans, delayed_refs, head, next);
                ref->ref_mod +=3D mod;
                if (ref->ref_mod =3D=3D 0) {
                        drop_delayed_ref(trans, delayed_refs, head, ref);
                        done =3D true;
                } else {
                        /*
                         * Can't have multiples of the same ref on a tree b=
lock.
                         */
                        WARN_ON(ref->type =3D=3D BTRFS_TREE_BLOCK_REF_KEY ||
                                ref->type =3D=3D BTRFS_SHARED_BLOCK_REF_KEY=
);
                }
	// ...
}

Should the warning be removed?  If something bad was going to happen,
I would have expected it to happen some time in the last month of
stress-testing, but I can find no evidence of failure related to
this warning.

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXMd8CQAKCRCB+YsaVrMb
nGkqAKDpsjYS3oBPpXYckIvAG1dzLKUL6gCfdy9YYT5u2dKoN+K4gjUkSJA577Y=
=Hi2S
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
