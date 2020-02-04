Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B97A6151482
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 04:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgBDDQo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 22:16:44 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:43504 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgBDDQo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 22:16:44 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 5A43B5A83CD; Mon,  3 Feb 2020 22:16:43 -0500 (EST)
Date:   Mon, 3 Feb 2020 22:16:42 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     linux-btrfs@vger.kernel.org
Subject: Re: WARNING at fs/btrfs/delayed-ref.c:296
 btrfs_merge_delayed_refs+0x3dc/0x410 (fixed in 5.2)
Message-ID: <20200204031642.GW13306@hungrycats.org>
References: <20190326025028.GG16651@hungrycats.org>
 <20190429223454.GB20359@hungrycats.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SvF6CGw9fzJC4Rcx"
Content-Disposition: inline
In-Reply-To: <20190429223454.GB20359@hungrycats.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--SvF6CGw9fzJC4Rcx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2019 at 06:34:55PM -0400, Zygo Blaxell wrote:
> On Mon, Mar 25, 2019 at 10:50:28PM -0400, Zygo Blaxell wrote:
> > Running balance, rsync, and dedupe, I get kernel warnings every few
> > minutes on 5.0.4.  No warnings on 5.0.3 under similar conditions.
> >=20
> > Mount options are:  flushoncommit,space_cache=3Dv2,compress=3Dzstd.
> >=20
> > There are two different stacks on the warnings.  This one comes from
> > btrfs balance:
> >=20
> > 	[Mon Mar 25 18:22:42 2019] WARNING: CPU: 0 PID: 4786 at fs/btrfs/delay=
ed-ref.c:296 btrfs_merge_delayed_refs+0x3dc/0x410
> > 	[Mon Mar 25 18:22:42 2019] Modules linked in: ppdev joydev crct10dif_p=
clmul crc32_pclmul dm_cache_smq crc32c_intel ghash_clmulni_intel dm_cache d=
m_persistent_data dm_bio_prison dm_bufio dm_mod rtc_cmos floppy parport_pc =
parport aesni_intel sr_mod cdrom aes_x86_64 crypto_simd cryptd glue_helper =
sg ide_pci_generic piix ide_core evbug evdev bochs_drm i2c_piix4 input_leds=
 psmouse serio_raw snd_pcm snd_timer snd soundcore pcspkr qemu_fw_cfg ip_ta=
bles x_tables ipv6 crc_ccitt autofs4
> > 	[Mon Mar 25 18:22:42 2019] CPU: 0 PID: 4786 Comm: btrfs-balance Tainte=
d: G        W         5.0.4-zb64-303ce93b05c9+ #1
> > 	[Mon Mar 25 18:22:42 2019] Hardware name: QEMU Standard PC (i440FX + P=
IIX, 1996), BIOS 1.10.2-1 04/01/2014
> > 	[Mon Mar 25 18:22:42 2019] RIP: 0010:btrfs_merge_delayed_refs+0x3dc/0x=
410
> > 	[Mon Mar 25 18:22:42 2019] Code: 7c 24 28 be ff ff ff ff e8 31 a0 c1 f=
f 85 c0 0f 85 7c fe ff ff 0f 0b e9 75 fe ff ff 0f 0b e9 0a fe ff ff 0f 0b e=
9 1b fe ff ff <0f> 0b e9 25 ff ff ff 0f 0b e9 b0 fe ff ff 48 c7 44 24 10 00=
 00 00
> > 	[Mon Mar 25 18:22:42 2019] RSP: 0018:ffffabb981377b70 EFLAGS: 00010246
> > 	[Mon Mar 25 18:22:42 2019] RAX: 00000000000000b6 RBX: 00000000ffffffff=
 RCX: 0000000000000001
> > 	[Mon Mar 25 18:22:42 2019] RDX: 0000000000000000 RSI: 00000000ffffffff=
 RDI: 0000000000000282
> > 	[Mon Mar 25 18:22:42 2019] RBP: ffff9392514bbb80 R08: ffff9392514bbc80=
 R09: 0000000000000000
> > 	[Mon Mar 25 18:22:42 2019] R10: 0000000000000000 R11: 0000000000000001=
 R12: ffff93928a5c8f08
> > 	[Mon Mar 25 18:22:42 2019] R13: ffff939269744e38 R14: ffff939269744e38=
 R15: ffff9392697449c0
> > 	[Mon Mar 25 18:22:42 2019] FS:  0000000000000000(0000) GS:ffff939475c0=
0000(0000) knlGS:0000000000000000
> > 	[Mon Mar 25 18:22:42 2019] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080=
050033
> > 	[Mon Mar 25 18:22:42 2019] CR2: 00007f0882d38600 CR3: 0000000230eb6002=
 CR4: 00000000001606f0
> > 	[Mon Mar 25 18:22:42 2019] Call Trace:
> > 	[Mon Mar 25 18:22:42 2019]  __btrfs_run_delayed_refs+0x70/0x170
> > 	[Mon Mar 25 18:22:42 2019]  btrfs_run_delayed_refs+0x7d/0x1d0
> > 	[Mon Mar 25 18:22:42 2019]  btrfs_commit_transaction+0x50/0x9e0
> > 	[Mon Mar 25 18:22:42 2019]  ? start_transaction+0x91/0x4d0
> > 	[Mon Mar 25 18:22:42 2019]  relocate_block_group+0x1bd/0x600
> > 	[Mon Mar 25 18:22:42 2019]  btrfs_relocate_block_group+0x15b/0x260
> > 	[Mon Mar 25 18:22:42 2019]  btrfs_relocate_chunk+0x46/0xf0
> > 	[Mon Mar 25 18:22:42 2019]  btrfs_balance+0xa60/0x12b0
> > 	[Mon Mar 25 18:22:42 2019]  balance_kthread+0x36/0x50
> > 	[Mon Mar 25 18:22:42 2019]  kthread+0x106/0x140
> > 	[Mon Mar 25 18:22:42 2019]  ? btrfs_balance+0x12b0/0x12b0
> > 	[Mon Mar 25 18:22:42 2019]  ? kthread_park+0x90/0x90
> > 	[Mon Mar 25 18:22:42 2019]  ret_from_fork+0x3a/0x50
> > 	[Mon Mar 25 18:22:42 2019] irq event stamp: 81529004
> > 	[Mon Mar 25 18:22:42 2019] hardirqs last  enabled at (81529003): [<fff=
fffffaa2be2b7>] kmem_cache_free+0x67/0x1e0
> > 	[Mon Mar 25 18:22:42 2019] hardirqs last disabled at (81529004): [<fff=
fffffaa00379f>] trace_hardirqs_off_thunk+0x1a/0x1c
> > 	[Mon Mar 25 18:22:42 2019] softirqs last  enabled at (81527500): [<fff=
fffffab0003a4>] __do_softirq+0x3a4/0x45f
> > 	[Mon Mar 25 18:22:42 2019] softirqs last disabled at (81527493): [<fff=
fffffaa0a3d24>] irq_exit+0xe4/0xf0
> > 	[Mon Mar 25 18:22:42 2019] ---[ end trace 3d8cdfff7444099a ]---
> >=20
> > This one comes from btrfs-transaction:
> >=20
> > 	[Mon Mar 25 18:27:58 2019] WARNING: CPU: 3 PID: 4137 at fs/btrfs/delay=
ed-ref.c:296 btrfs_merge_delayed_refs+0x3dc/0x410
> > 	[Mon Mar 25 18:27:58 2019] Modules linked in: ppdev joydev crct10dif_p=
clmul crc32_pclmul dm_cache_smq crc32c_intel ghash_clmulni_intel dm_cache d=
m_persistent_data dm_bio_prison dm_bufio dm_mod rtc_cmos floppy parport_pc =
parport aesni_intel sr_mod cdrom aes_x86_64 crypto_simd cryptd glue_helper =
sg ide_pci_generic piix ide_core evbug evdev bochs_drm i2c_piix4 input_leds=
 psmouse serio_raw snd_pcm snd_timer snd soundcore pcspkr qemu_fw_cfg ip_ta=
bles x_tables ipv6 crc_ccitt autofs4
> > 	[Mon Mar 25 18:27:58 2019] CPU: 3 PID: 4137 Comm: btrfs-transacti Tain=
ted: G        W         5.0.4-zb64-303ce93b05c9+ #1
> > 	[Mon Mar 25 18:27:58 2019] Hardware name: QEMU Standard PC (i440FX + P=
IIX, 1996), BIOS 1.10.2-1 04/01/2014
> > 	[Mon Mar 25 18:27:58 2019] RIP: 0010:btrfs_merge_delayed_refs+0x3dc/0x=
410
> > 	[Mon Mar 25 18:27:58 2019] Code: 7c 24 28 be ff ff ff ff e8 31 a0 c1 f=
f 85 c0 0f 85 7c fe ff ff 0f 0b e9 75 fe ff ff 0f 0b e9 0a fe ff ff 0f 0b e=
9 1b fe ff ff <0f> 0b e9 25 ff ff ff 0f 0b e9 b0 fe ff ff 48 c7 44 24 10 00=
 00 00
> > 	[Mon Mar 25 18:27:58 2019] RSP: 0018:ffffabb9812f7d40 EFLAGS: 00010246
> > 	[Mon Mar 25 18:27:58 2019] RAX: 00000000000000b6 RBX: 00000000ffffffff=
 RCX: 0000000000000001
> > 	[Mon Mar 25 18:27:58 2019] RDX: 0000000000000000 RSI: 00000000ffffffff=
 RDI: 0000000000000286
> > 	[Mon Mar 25 18:27:58 2019] RBP: ffff93925b187ce0 R08: ffff93925b187de0=
 R09: 0000000000000000
> > 	[Mon Mar 25 18:27:58 2019] R10: 0000000000000000 R11: 0000000000000001=
 R12: ffff93938b59d308
> > 	[Mon Mar 25 18:27:58 2019] R13: ffff9393a5d09820 R14: ffff9393a5d09820=
 R15: ffff939261978820
> > 	[Mon Mar 25 18:27:58 2019] FS:  0000000000000000(0000) GS:ffff93947680=
0000(0000) knlGS:0000000000000000
> > 	[Mon Mar 25 18:27:58 2019] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080=
050033
> > 	[Mon Mar 25 18:27:58 2019] CR2: 00007f91f6321c50 CR3: 00000001ef54e003=
 CR4: 00000000001606e0
> > 	[Mon Mar 25 18:27:58 2019] Call Trace:
> > 	[Mon Mar 25 18:27:58 2019]  __btrfs_run_delayed_refs+0x70/0x170
> > 	[Mon Mar 25 18:27:58 2019]  btrfs_run_delayed_refs+0x7d/0x1d0
> > 	[Mon Mar 25 18:27:58 2019]  btrfs_commit_transaction+0x50/0x9e0
> > 	[Mon Mar 25 18:27:58 2019]  ? start_transaction+0x91/0x4d0
> > 	[Mon Mar 25 18:27:58 2019]  transaction_kthread+0x146/0x180
> > 	[Mon Mar 25 18:27:58 2019]  kthread+0x106/0x140
> > 	[Mon Mar 25 18:27:58 2019]  ? btrfs_cleanup_transaction+0x620/0x620
> > 	[Mon Mar 25 18:27:58 2019]  ? kthread_park+0x90/0x90
> > 	[Mon Mar 25 18:27:58 2019]  ret_from_fork+0x3a/0x50
> > 	[Mon Mar 25 18:27:58 2019] irq event stamp: 81665152
> > 	[Mon Mar 25 18:27:58 2019] hardirqs last  enabled at (81665151): [<fff=
fffffaa2be2b7>] kmem_cache_free+0x67/0x1e0
> > 	[Mon Mar 25 18:27:58 2019] hardirqs last disabled at (81665152): [<fff=
fffffaa00379f>] trace_hardirqs_off_thunk+0x1a/0x1c
> > 	[Mon Mar 25 18:27:58 2019] softirqs last  enabled at (81664580): [<fff=
fffffab0003a4>] __do_softirq+0x3a4/0x45f
> > 	[Mon Mar 25 18:27:58 2019] softirqs last disabled at (81664565): [<fff=
fffffaa0a3d24>] irq_exit+0xe4/0xf0
> > 	[Mon Mar 25 18:27:58 2019] ---[ end trace 3d8cdfff7444099c ]---
> >
> > Pausing the balance makes the warnings stop.

This warning appears in test runs on kernels 4.20.17, 5.0.21, 5.1.21
(and several kernels in between).  It does not appear on 5.2.21, 5.3.18,
5.4.16, or 5.5.0.

I was never able to associate the warning with any bad behavior on 5.0,
which received the most testing and use of the affected kernels.

If you wrote the commit that fixed it somewhere between 5.1 and 5.2
(or possibly backported to stable from 5.3), thank you!

> After sorting out some unrelated issues with 5.0 kernels, these warnings
> are now the top of my list of unresolved 5.0 kernel issues.  They are
> popping up more often:  31804 times over two machine-days.  Too much
> spam for the kernel logs.
>=20
> This is the code surrounding the WARN_ON:
>=20
> static bool merge_ref(...
> {
> 	// ...
> 		drop_delayed_ref(trans, delayed_refs, head, next);
>                 ref->ref_mod +=3D mod;
>                 if (ref->ref_mod =3D=3D 0) {
>                         drop_delayed_ref(trans, delayed_refs, head, ref);
>                         done =3D true;
>                 } else {
>                         /*
>                          * Can't have multiples of the same ref on a tree=
 block.
>                          */
>                         WARN_ON(ref->type =3D=3D BTRFS_TREE_BLOCK_REF_KEY=
 ||
>                                 ref->type =3D=3D BTRFS_SHARED_BLOCK_REF_K=
EY);
>                 }
> 	// ...
> }
>=20
> Should the warning be removed?  If something bad was going to happen,
> I would have expected it to happen some time in the last month of
> stress-testing, but I can find no evidence of failure related to
> this warning.



--SvF6CGw9fzJC4Rcx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXjjiFwAKCRCB+YsaVrMb
nFSqAJsEpClYgGFdUnTMMW87KG+P3poCCgCgruZQUbxwtv/nskoT2+yRP+APB9E=
=R8f4
-----END PGP SIGNATURE-----

--SvF6CGw9fzJC4Rcx--
