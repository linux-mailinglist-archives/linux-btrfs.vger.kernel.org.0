Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29B48151E80
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 17:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgBDQtV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 11:49:21 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:45308 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbgBDQtU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 11:49:20 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id EFA305A9A06; Tue,  4 Feb 2020 11:49:18 -0500 (EST)
Date:   Tue, 4 Feb 2020 11:49:18 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Kernels 4.15..5.5: "WARNING: CPU: 2 PID: 4150 at
 fs/fs-writeback.c:2363 __writeback_inodes_sb_nr+0xa9/0xc0"
Message-ID: <20200204164918.GC13306@hungrycats.org>
References: <20190322041731.GF16651@hungrycats.org>
 <20200204050456.GB13306@hungrycats.org>
 <65514978-506f-83fa-2c95-ee9ce3cbf5b4@applied-asynchrony.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="QFYA38BK7dvhx8Kf"
Content-Disposition: inline
In-Reply-To: <65514978-506f-83fa-2c95-ee9ce3cbf5b4@applied-asynchrony.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--QFYA38BK7dvhx8Kf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 04, 2020 at 02:58:52PM +0100, Holger Hoffst=C3=A4tte wrote:
> On 2/4/20 6:04 AM, Zygo Blaxell wrote:
> > On Fri, Mar 22, 2019 at 12:17:32AM -0400, Zygo Blaxell wrote:
> > > When filesystems are mounted flushoncommit, I get this warning roughly
> > > every 30 seconds:
> > >=20
> > > 	[ 4575.142805] WARNING: CPU: 3 PID: 4150 at fs/fs-writeback.c:2363 _=
_writeback_inodes_sb_nr+0xa9/0xc0
> > > 	[ 4575.145567] Modules linked in: crct10dif_pclmul crc32_pclmul dm_c=
ache_smq crc32c_intel dm_cache snd_pcm ghash_clmulni_intel aesni_intel sr_m=
od dm_persistent_data ppdev joydev dm_bio_prison aes_x86_64 crypto_simd snd=
_timer dm_bufio cryptd cdrom snd glue_helper dm_mod parport_pc soundcore sg=
 floppy parport pcspkr psmouse bochs_drm rtc_cmos ide_pci_generic piix inpu=
t_leds i2c_piix4 ide_core serio_raw evbug qemu_fw_cfg evdev ip_tables x_tab=
les ipv6 crc_ccitt autofs4
> > > 	[ 4575.160021] CPU: 3 PID: 4150 Comm: btrfs-transacti Tainted: G    =
    W         5.0.3-zb64+ #1
> > > 	[ 4575.162484] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)=
, BIOS 1.10.2-1 04/01/2014
> > > 	[ 4575.164505] RIP: 0010:__writeback_inodes_sb_nr+0xa9/0xc0
> > > 	[ 4575.165809] Code: 0f b6 d2 e8 b9 f8 ff ff 48 89 ee 48 89 df e8 0e=
 f8 ff ff 48 8b 44 24 48 65 48 33 04 25 28 00 00 00 75 0b 48 83 c4 50 5b 5d=
 c3 <0f> 0b eb cb e8 4e e9 d6 ff 0f 1f 40 00 66 2e 0f 1f 84 00 00 00 00
> > > 	[ 4575.171927] RSP: 0018:ffffa9cac0eabde8 EFLAGS: 00010246
> > > 	[ 4575.173045] RAX: 0000000000000000 RBX: ffff9353e23af000 RCX: 0000=
000000000000
> > > 	[ 4575.175639] RDX: 0000000000000002 RSI: 0000000000030c67 RDI: ffff=
a9cac0eabe30
> > > 	[ 4575.177619] RBP: ffffa9cac0eabdec R08: ffffa9cac0eabdf0 R09: ffff=
9353f12da000
> > > 	[ 4575.179736] R10: 0000000000000000 R11: 0000000000000001 R12: ffff=
9353e1980000
> > > 	[ 4575.181661] R13: ffff9353e1981430 R14: ffff9353f27e4260 R15: ffff=
9353e1981518
> > > 	[ 4575.183871] FS:  0000000000000000(0000) GS:ffff9353f6800000(0000)=
 knlGS:0000000000000000
> > > 	[ 4575.185940] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > 	[ 4575.188072] CR2: 00007fb81841fa20 CR3: 00000002218c0006 CR4: 0000=
0000001606e0
> > > 	[ 4575.190094] Call Trace:
> > > 	[ 4575.190828]  btrfs_commit_transaction+0x7a6/0x9e0
> > > 	[ 4575.192115]  ? start_transaction+0x91/0x4d0
> > > 	[ 4575.193197]  transaction_kthread+0x146/0x180
> > > 	[ 4575.194415]  kthread+0x106/0x140
> > > 	[ 4575.195403]  ? btrfs_cleanup_transaction+0x620/0x620
> > > 	[ 4575.196903]  ? kthread_park+0x90/0x90
> > > 	[ 4575.198412]  ret_from_fork+0x3a/0x50
> > > 	[ 4575.199374] irq event stamp: 54922780
> > > 	[ 4575.200218] hardirqs last  enabled at (54922779): [<ffffffffa3d5f=
2e2>] _raw_spin_unlock_irqrestore+0x32/0x60
> > > 	[ 4575.202753] hardirqs last disabled at (54922780): [<ffffffffa3003=
79f>] trace_hardirqs_off_thunk+0x1a/0x1c
> > > 	[ 4575.205921] softirqs last  enabled at (54922378): [<ffffffffa4000=
3a4>] __do_softirq+0x3a4/0x45f
> > > 	[ 4575.208350] softirqs last disabled at (54922361): [<ffffffffa30a3=
d44>] irq_exit+0xe4/0xf0
> > > 	[ 4575.210616] ---[ end trace 5309dcf3a1920eca ]---
> > >=20
> > > For my own kernel builds I just comment out the line in fs-writeback.=
c,
> > > but that's not a real solution.
> >=20
> > This still happens in 5.5.0.  No changes in behavior or workaround, no
> > apparent harmful effect, almost 2 years running in stress-testing and
> > production.
> >=20
> > I, for one, am glad we fixed all those other bugs before doing anything
> > about this one.  It is utterly harmless.
>=20
> This triggered my archeology itch. I had to go deeper.

You could start with this thread:

	https://www.spinics.net/lists/linux-btrfs/msg87752.html

> The warning goes all the way back to 2010 (kernel 2.6.x) when everything
> happened at FusionIO.
>=20
> Commit [1] introduced it as preparation for [2].
>=20
> The only caller of writeback_inodes_sb_nr is btrfs_writeback_inodes_sb_nr=
 in
> (today's) space-info.c, where the mutex trylock was introduced in [3], ap=
parently
> to work around a VFS function that didn't do it for btrfs at the time.
>=20
> Flushoncommit was added by Sage Weil for Ceph's btrfs backend in [4], even
> before the WARN_ON, in 2009. We know how that story ended.
>=20
> Why has nobody except you noticed this? Probably because the number of pe=
ople
> actually using it or reporting bugs is.. very small. =C2=AF\_(=E3=83=84)_=
/=C2=AF

I'm not the only one to notice, or report, e.g.

	https://www.spinics.net/lists/linux-btrfs/msg74496.html
	https://www.spinics.net/lists/linux-btrfs/msg72483.html
	https://github.com/Zygo/bees/issues/68

plus it comes up every now and then on IRC.  I have heard from other
users of flushoncommit that they also patch their kernels to get rid of
the WARN_ON (or make it WARN_ON_ONCE).

The WARN_ON appears in btrfs starting in 4.15 after:

	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/=
?id=3Dce8ea7cc6eb3139f4c730d647325e69354159b0f

which rearranges some calls to put the fs-writeback.c WARN_ON on a code
path where it doesn't hold the lock.

To answer a question I asked in

	https://www.spinics.net/lists/linux-btrfs/msg87769.html

(and again in another message of this thread), the answer is
"cherry-picking ce8ea7cc6eb3 into 4.14.107 makes 4.14.107 deadlock
immediately".  Reverting the same commit makes kernel 4.15 and later
deadlock immediately.

btrfs crashes _much_ less often now than it did in 4.14.  Mounting with
noflushoncommit is starting to look like an option worth contemplating
for some workloads on 5.4.18+.  On the other hand, one of the reasons
why I use btrfs instead of other filesystems is that other filesystems
don't implement a sane equivalent of flushoncommit, and those use cases
aren't going away any time soon.

> Unfortunately I'm still none the wiser why btrfs feels it's necessary to
> "open-code"/circumvent the rwsem check. Maybe this gives you a clue.
>=20
> cheers,
> Holger
>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/fs/fs-writeback.c?id=3Dcf37e972478ec58a8a54a6b4f951815f0ae28f78
>=20
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/fs/fs-writeback.c?id=3Dd19de7edf59cdd586777b009e0e8fbe5412dd35f
>=20
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/fs/btrfs/extent-tree.c?id=3D925a6efb8ff0c2bdbec107ed9890e62650c83306
>=20
> [4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Ddccae99995089641fbac452ebc7f0cab18751ddb

--QFYA38BK7dvhx8Kf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXjmgjAAKCRCB+YsaVrMb
nHodAJ9hBwPMSJWa+/Xc3EO5l/EuhH5mtwCg3ExVeAu+g6rxM9d8xxBuBNzHjSU=
=tITI
-----END PGP SIGNATURE-----

--QFYA38BK7dvhx8Kf--
