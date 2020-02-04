Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 419C8151538
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 06:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgBDFE5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 00:04:57 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:36430 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgBDFE4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 00:04:56 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 3310C5A8555; Tue,  4 Feb 2020 00:04:56 -0500 (EST)
Date:   Tue, 4 Feb 2020 00:04:56 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     linux-btrfs@vger.kernel.org
Subject: Re: Kernels 4.15..5.5:  "WARNING: CPU: 2 PID: 4150 at
 fs/fs-writeback.c:2363 __writeback_inodes_sb_nr+0xa9/0xc0"
Message-ID: <20200204050456.GB13306@hungrycats.org>
References: <20190322041731.GF16651@hungrycats.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gz4FNQG/2iJjJcgR"
Content-Disposition: inline
In-Reply-To: <20190322041731.GF16651@hungrycats.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--gz4FNQG/2iJjJcgR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2019 at 12:17:32AM -0400, Zygo Blaxell wrote:
> When filesystems are mounted flushoncommit, I get this warning roughly
> every 30 seconds:
>=20
> 	[ 4575.142805] WARNING: CPU: 3 PID: 4150 at fs/fs-writeback.c:2363 __wri=
teback_inodes_sb_nr+0xa9/0xc0
> 	[ 4575.145567] Modules linked in: crct10dif_pclmul crc32_pclmul dm_cache=
_smq crc32c_intel dm_cache snd_pcm ghash_clmulni_intel aesni_intel sr_mod d=
m_persistent_data ppdev joydev dm_bio_prison aes_x86_64 crypto_simd snd_tim=
er dm_bufio cryptd cdrom snd glue_helper dm_mod parport_pc soundcore sg flo=
ppy parport pcspkr psmouse bochs_drm rtc_cmos ide_pci_generic piix input_le=
ds i2c_piix4 ide_core serio_raw evbug qemu_fw_cfg evdev ip_tables x_tables =
ipv6 crc_ccitt autofs4
> 	[ 4575.160021] CPU: 3 PID: 4150 Comm: btrfs-transacti Tainted: G        =
W         5.0.3-zb64+ #1
> 	[ 4575.162484] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BI=
OS 1.10.2-1 04/01/2014
> 	[ 4575.164505] RIP: 0010:__writeback_inodes_sb_nr+0xa9/0xc0
> 	[ 4575.165809] Code: 0f b6 d2 e8 b9 f8 ff ff 48 89 ee 48 89 df e8 0e f8 =
ff ff 48 8b 44 24 48 65 48 33 04 25 28 00 00 00 75 0b 48 83 c4 50 5b 5d c3 =
<0f> 0b eb cb e8 4e e9 d6 ff 0f 1f 40 00 66 2e 0f 1f 84 00 00 00 00
> 	[ 4575.171927] RSP: 0018:ffffa9cac0eabde8 EFLAGS: 00010246
> 	[ 4575.173045] RAX: 0000000000000000 RBX: ffff9353e23af000 RCX: 00000000=
00000000
> 	[ 4575.175639] RDX: 0000000000000002 RSI: 0000000000030c67 RDI: ffffa9ca=
c0eabe30
> 	[ 4575.177619] RBP: ffffa9cac0eabdec R08: ffffa9cac0eabdf0 R09: ffff9353=
f12da000
> 	[ 4575.179736] R10: 0000000000000000 R11: 0000000000000001 R12: ffff9353=
e1980000
> 	[ 4575.181661] R13: ffff9353e1981430 R14: ffff9353f27e4260 R15: ffff9353=
e1981518
> 	[ 4575.183871] FS:  0000000000000000(0000) GS:ffff9353f6800000(0000) knl=
GS:0000000000000000
> 	[ 4575.185940] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 	[ 4575.188072] CR2: 00007fb81841fa20 CR3: 00000002218c0006 CR4: 00000000=
001606e0
> 	[ 4575.190094] Call Trace:
> 	[ 4575.190828]  btrfs_commit_transaction+0x7a6/0x9e0
> 	[ 4575.192115]  ? start_transaction+0x91/0x4d0
> 	[ 4575.193197]  transaction_kthread+0x146/0x180
> 	[ 4575.194415]  kthread+0x106/0x140
> 	[ 4575.195403]  ? btrfs_cleanup_transaction+0x620/0x620
> 	[ 4575.196903]  ? kthread_park+0x90/0x90
> 	[ 4575.198412]  ret_from_fork+0x3a/0x50
> 	[ 4575.199374] irq event stamp: 54922780
> 	[ 4575.200218] hardirqs last  enabled at (54922779): [<ffffffffa3d5f2e2>=
] _raw_spin_unlock_irqrestore+0x32/0x60
> 	[ 4575.202753] hardirqs last disabled at (54922780): [<ffffffffa300379f>=
] trace_hardirqs_off_thunk+0x1a/0x1c
> 	[ 4575.205921] softirqs last  enabled at (54922378): [<ffffffffa40003a4>=
] __do_softirq+0x3a4/0x45f
> 	[ 4575.208350] softirqs last disabled at (54922361): [<ffffffffa30a3d44>=
] irq_exit+0xe4/0xf0
> 	[ 4575.210616] ---[ end trace 5309dcf3a1920eca ]---
>=20
> For my own kernel builds I just comment out the line in fs-writeback.c,
> but that's not a real solution.

This still happens in 5.5.0.  No changes in behavior or workaround, no
apparent harmful effect, almost 2 years running in stress-testing and
production.

I, for one, am glad we fixed all those other bugs before doing anything
about this one.  It is utterly harmless.

--gz4FNQG/2iJjJcgR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXjj7dwAKCRCB+YsaVrMb
nKRRAKCuKxEXPaCy96U1sxLciONrraPtKQCcC+fh/CwMt06VcOYvU1PfDHtU1ew=
=NcLD
-----END PGP SIGNATURE-----

--gz4FNQG/2iJjJcgR--
