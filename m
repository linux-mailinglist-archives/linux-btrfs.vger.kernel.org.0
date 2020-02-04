Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1E65151511
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 05:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgBDEne (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 23:43:34 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:34494 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbgBDEne (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 23:43:34 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 943845A84F6; Mon,  3 Feb 2020 23:43:33 -0500 (EST)
Date:   Mon, 3 Feb 2020 23:43:33 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     linux-btrfs@vger.kernel.org
Subject: Re: repeatable(ish) corrupt leaf filesystem splat on 5.1.x - fixed
 in 5.4.14, 5.5.0
Message-ID: <20200204044333.GZ13306@hungrycats.org>
References: <20190704210323.GK11831@hungrycats.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bIBSTgLWjO5xMb20"
Content-Disposition: inline
In-Reply-To: <20190704210323.GK11831@hungrycats.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--bIBSTgLWjO5xMb20
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2019 at 05:03:23PM -0400, Zygo Blaxell wrote:
> I've seen this twice in 3 days after releasing 5.1.x kernels from the
> test lab:
>=20
> 5.1.15 on 2xSATA RAID1 SSD, during a balance:
>=20
> 	[48714.200014][ T3498] BTRFS critical (device dm-21): corrupt leaf: root=
=3D2 block=3D117776711680 slot=3D57, unexpected item end, have 109534755 ex=
pect 12632
> 	[48714.200381][ T3498] BTRFS critical (device dm-21): corrupt leaf: root=
=3D2 block=3D117776711680 slot=3D57, unexpected item end, have 109534755 ex=
pect 12632
> 	[48714.200399][ T9749] BTRFS: error (device dm-21) in __btrfs_free_exten=
t:7109: errno=3D-5 IO failure
> 	[48714.200401][ T9749] BTRFS info (device dm-21): forced readonly
> 	[48714.200405][ T9749] BTRFS: error (device dm-21) in btrfs_run_delayed_=
refs:3008: errno=3D-5 IO failure
> 	[48714.200419][ T9749] BTRFS info (device dm-21): found 359 extents
> 	[48714.200442][ T9749] BTRFS info (device dm-21): 1 enospc errors during=
 balance
> 	[48714.200445][ T9749] BTRFS info (device dm-21): balance: ended with st=
atus: -30
>=20
> and 5.1.9 on 1xNVME, a few hours after some /proc NULL pointer dereference
> bugs:
>=20
> 	[89244.144505][ T7009] BTRFS critical (device dm-4): corrupt leaf: root=
=3D2 block=3D1854946361344 slot=3D32, unexpected item end, have 1335222703 =
expect 15056
> 	[89244.144822][ T7009] BTRFS critical (device dm-4): corrupt leaf: root=
=3D2 block=3D1854946361344 slot=3D32, unexpected item end, have 1335222703 =
expect 15056
> 	[89244.144832][ T2403] BTRFS: error (device dm-4) in btrfs_run_delayed_r=
efs:3008: errno=3D-5 IO failure
> 	[89244.144836][ T2403] BTRFS info (device dm-4): forced readonly
>=20
> The machines had been upgraded from 5.0.x to 5.1.x for less than 24
> hours each.
>=20
> The 5.1.9 machine had crashed (on 5.0.15) before, but a scrub had passed
> while running 5.1.9 after the crash.  The filesystem failure occurred
> 20 hours later.  There were some other NULL pointer deferences in that
> uptime, so maybe 5.1.9 is just a generally buggy kernel that nobody
> should ever run.  I expect better from 5.1.15, though, which had no
> unusual events reported in the 8 hours between its post-reboot scrub
> and the filesystem failure.
>=20
> I have several other machines running 5.1.x kernels that have not yet had
> such a failure--including all of my test machines, which don't seem to hit
> this issue after 25+ days of stress-testing.  Most of the test machines
> are using rotating disks, a few are running SSD+HDD with lvmcache.
>=20
> One correlation that may be interesting:  both of the failing filesystems
> had 1MB unallocated on all disks; all of the non-failing filesystems have
> 1GB or more unallocated on all disks.  I was running the balance on the
> first filesystem to try to free up some unallocated space.  The second
> filesystem died without any help from me.
>=20
> It turns out that 'btrfs check --repair' can fix these!  First time
> I've ever seen check --repair fix a broken filesystem.  A few files are
> damaged, but the filesystem is read-write again and still working so far
> (on a 5.0.21 kernel) .

Since this report I have repeated this event several times on kernels
=66rom 5.1 to 5.4, running my 10x rsync, bees dedupe, balance, scrub,
snapshot create and delete stress test.

The symptoms on each kernel are different because the bug interacts with
other capabilities and fixes in each kernel:

	5.1.21 - all test runs eventually end with corrupted metadata
	on disk (*)

	5.2.21, 5.3.18 - write time tree checker (usually) detects
	filesystem corruption and aborts transaction before metadata on
	disk is damaged

	5.4.13 - NULL pointer splats in various places, especially
	snapshot create and during mount.  These end the test too quickly
	to see if there is also metadata corruption.

These are all fixed by:

	707de9c0806d btrfs: relocation: fix reloc_root lifespan and access

When this patch is applied to kernels 5.1, 5.2, or 5.3, it fixes all of
the above problems.

Thanks Qu for this patch.

(*) or one of the tree mod log UAF bugs--but the metadata corruption
usually happens much faster.

--bIBSTgLWjO5xMb20
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXjj2cwAKCRCB+YsaVrMb
nAPcAKCAdrj3cm9/Ymc1BvFw5/jmjUnvMwCfeYijx4G2p86ygSJCX817iIFI41U=
=/SxX
-----END PGP SIGNATURE-----

--bIBSTgLWjO5xMb20--
