Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 506E610B580
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2019 19:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfK0SUs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Nov 2019 13:20:48 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:44308 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbfK0SUs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Nov 2019 13:20:48 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id F31014FB222; Wed, 27 Nov 2019 13:20:46 -0500 (EST)
Date:   Wed, 27 Nov 2019 13:20:46 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] Btrfs: send, skip backreference walking for extents with
 many references
Message-ID: <20191127182046.GF1046@hungrycats.org>
References: <20191030122301.25270-1-fdmanana@kernel.org>
 <20191123052741.GJ22121@hungrycats.org>
 <CAL3q7H52LYCnDdFoObCCWjrCQqLOpcPUYeD28pXtET25-ycM9w@mail.gmail.com>
 <20191124013328.GD1046@hungrycats.org>
 <CAL3q7H61mTQ6kFU9ER-F=-9xEXE8uSdpa-FjJpoS61x7kMaEjw@mail.gmail.com>
 <20191126230251.GK22121@hungrycats.org>
 <CAL3q7H5RCgs53nBG9HKLMHqUXLM=xiUKTQi8dS8nvuvW9x5bDA@mail.gmail.com>
 <20191127180954.GE1046@hungrycats.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/unnNtmY43mpUSKx"
Content-Disposition: inline
In-Reply-To: <20191127180954.GE1046@hungrycats.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--/unnNtmY43mpUSKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2019 at 01:09:55PM -0500, Zygo Blaxell wrote:
> On Wed, Nov 27, 2019 at 11:42:21AM +0000, Filipe Manana wrote:
> > Walking the backreferences was always slow, and having a few hundred
> > references for an extent is enough to notice a significant slowdown
> > already.
> > That affects the logical_ino ioctls, send, etc.
> >=20
> > Worst, for logical_ino, is that we do the backreference walking while
> > either holding a transaction (if one is currently running) or
> > holding a semaphore (commit_root_sem) to prevent transaction commits
> > from happening (to ensure consistency and that things don't disappear
> > while we're using them).
> > So for a slow backreference walking, that can hang a lot of other
> > tasks that are trying to commit a transaction.
> >=20
> > There was someone working on improving backreference walking (Mark),
> > but I think he's not working on btrfs anymore, and I don't know what
> > happened to that work (if it was ever finished, etc).
>=20
> Writing a userspace backref walker to replace LOGICAL_INO has been on
> my TODO list for a while, but I had to go after the kernel crashing
> bugs first.  Now the top of the kernel crashing bug list is LOGICAL_INO
> too, so I guess there is no escape.
>=20
> I'd love to help with the kernel implementation of backref walking,
> but it's used by everything in btrfs, and it's full of wonderful things
> like log unwinding and negative reference counting that I know I don't
> understand well enough to mess with.
>=20
> > > Simultaneous LOGICAL_INO + balance correlates with these three failure
> > > modes:
> > >
> > >         https://www.spinics.net/lists/linux-btrfs/msg89425.html
> > >
> > >         https://www.mail-archive.com/linux-btrfs@vger.kernel.org/msg8=
8892.html
> >=20
> > For the bug involving btrfs_search_old_slot(), try the following fix:
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Defad8a853ad2057f96664328a0d327a05ce39c76
> >=20
> > Both reports where made before that fix was posted/merged.
>=20
> 5.3.13 already contains that commit (backported as
> f59d80e2f12b695d38e646f00de1e46e123dfcc9 in 5.3.4), and:
>=20
> 	[58446.332688][ T4514] ------------[ cut here ]------------
> 	[58446.336367][ T4514] kernel BUG at fs/btrfs/ctree.c:1222!

I note this is not exactly the same bug as the one I reported before:
it's BUG_ON(tm->slot < n) in case MOD_LOG_KEY_REMOVE_WHILE_FREEING,
while the previously reported one (and the one that is much more common
and apparently much harder to hit on 5.3.x) is BUG_ON(tm->slot >=3D n)
in case MOD_LOG_KEY_REPLACE.

> 	[58446.339993][ T4514] invalid opcode: 0000 [#1] SMP PTI
> 	[58446.343408][ T4514] CPU: 3 PID: 4514 Comm: crawl_35277 Not tainted 5.=
3.13-zb64-c0eaf2b82f8c+ #1
> 	[58446.348872][ T4514] Hardware name: QEMU Standard PC (i440FX + PIIX, 1=
996), BIOS 1.12.0-1 04/01/2014
> 	[58446.354272][ T4514] RIP: 0010:__tree_mod_log_rewind+0x235/0x240
> 	[58446.356393][ T4514] Code: 45 31 c0 4c 89 e7 48 89 d6 48 c1 e6 05 48 8=
d 74 32 65 ba 19 00 00 00 e8 59 d1 04 00 e9 89 fe ff ff 49 63 57 2c e9 18 f=
f ff ff <0f> 0b 0f 0b 0f 1f 80 00 00 00 00 0f 1f 44 00 00 55 83 c2 01 48 63
> 	[58446.361072][ T4514] RSP: 0000:ffffa34340e1b830 EFLAGS: 00010293
> 	[58446.364072][ T4514] RAX: 000003ff696b4000 RBX: 000000000000000f RCX: =
ffff981b2bf7db00
> 	[58446.366818][ T4514] RDX: 0000000000000000 RSI: 000000000000007e RDI: =
ffff981b2bf7d300
> 	[58446.368673][ T4514] RBP: ffffa34340e1b860 R08: ffffa34340e1b7d8 R09: =
ffffa34340e1b7e0
> 	[58446.371392][ T4514] R10: 000000000008b74a R11: 0000000000000000 R12: =
ffff981c62b2e4a0
> 	[58446.375829][ T4514] R13: ffff981b2bf7d300 R14: 0000000000000006 R15: =
ffff981b2bf7db00
> 	[58446.378642][ T4514] FS:  00007fccbd589700(0000) GS:ffff981cf6800000(0=
000) knlGS:0000000000000000
> 	[58446.380289][ T4514] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 	[58446.381567][ T4514] CR2: 00007fcc447d5000 CR3: 0000000205248003 CR4: =
00000000001606e0
> 	[58446.383172][ T4514] Call Trace:
> 	[58446.383835][ T4514]  btrfs_search_old_slot+0x14a/0x7e0
> 	[58446.384850][ T4514]  resolve_indirect_refs+0x1f0/0x9a0
> 	[58446.385864][ T4514]  find_parent_nodes+0x427/0x1330
> 	[58446.386849][ T4514]  btrfs_find_all_roots_safe+0xc1/0x130
> 	[58446.387924][ T4514]  ? btrfs_inode_flags_to_xflags+0x50/0x50
> 	[58446.389055][ T4514]  iterate_extent_inodes+0x134/0x390
> 	[58446.390078][ T4514]  ? _raw_spin_unlock+0x27/0x40
> 	[58446.391008][ T4514]  iterate_inodes_from_logical+0x9c/0xd0
> 	[58446.392090][ T4514]  ? iterate_inodes_from_logical+0x9c/0xd0
> 	[58446.393245][ T4514]  ? btrfs_inode_flags_to_xflags+0x50/0x50
> 	[58446.394409][ T4514]  btrfs_ioctl_logical_to_ino+0x10e/0x1b0
> 	[58446.395554][ T4514]  btrfs_ioctl+0x1417/0x2c30
> 	[58446.396459][ T4514]  ? kvm_sched_clock_read+0x18/0x30
> 	[58446.397462][ T4514]  ? __lock_acquire+0x4b2/0x1c00
> 	[58446.398414][ T4514]  ? retint_kernel+0x10/0x10
> 	[58446.399329][ T4514]  ? kvm_sched_clock_read+0x18/0x30
> 	[58446.400357][ T4514]  ? sched_clock+0x9/0x10
> 	[58446.401219][ T4514]  do_vfs_ioctl+0xa9/0x6f0
> 	[58446.402099][ T4514]  ? do_vfs_ioctl+0xa9/0x6f0
> 	[58446.403025][ T4514]  ? __fget+0x11e/0x200
> 	[58446.403863][ T4514]  ksys_ioctl+0x67/0x90
> 	[58446.404704][ T4514]  __x64_sys_ioctl+0x1a/0x20
> 	[58446.405619][ T4514]  do_syscall_64+0x65/0x1b0
> 	[58446.406529][ T4514]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>=20
> I was finally able to hit this bug on a 5.3.x kernel last night.



--/unnNtmY43mpUSKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXd6+fAAKCRCB+YsaVrMb
nEVKAJ4ksdEuUbPYNTQ+RDSwxj96HuOHYACgrsJw05huEpdm7y74IiSBCrHnhPQ=
=BMQx
-----END PGP SIGNATURE-----

--/unnNtmY43mpUSKx--
