Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD713F5A99
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2019 23:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfKHWJ7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Nov 2019 17:09:59 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:33964 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfKHWJ7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Nov 2019 17:09:59 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 6C3534C116F; Fri,  8 Nov 2019 17:09:54 -0500 (EST)
Date:   Fri, 8 Nov 2019 17:09:27 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Decoding "unable to fixup (regular)" errors
Message-ID: <20191108220927.GR22121@hungrycats.org>
References: <1591390.YpsIS3gr9g@blindfold>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="DqhR8hV3EnoxUkKN"
Content-Disposition: inline
In-Reply-To: <1591390.YpsIS3gr9g@blindfold>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--DqhR8hV3EnoxUkKN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 05, 2019 at 11:03:01PM +0100, Richard Weinberger wrote:
> Hi!
>=20
> One of my build servers logged the following:
>=20
> [10511433.614135] BTRFS info (device md1): relocating block group 2931997=
933568 flags data
> [10511441.887812] BTRFS info (device md1): found 135 extents
> [10511466.539198] BTRFS info (device md1): found 135 extents
> [10511472.805969] BTRFS info (device md1): found 1 extents
> [10511480.786194] BTRFS info (device md1): relocating block group 2933071=
675392 flags data
> [10511487.314283] BTRFS info (device md1): found 117 extents
> [10511498.483226] BTRFS info (device md1): found 117 extents
> [10511506.708389] BTRFS info (device md1): relocating block group 2930890=
637312 flags system|dup
> [10511508.386025] BTRFS info (device md1): found 5 extents
> [10511511.382986] BTRFS info (device md1): relocating block group 2935219=
159040 flags system|dup
> [10511512.565190] BTRFS info (device md1): found 5 extents
> [10511519.032713] BTRFS info (device md1): relocating block group 2935252=
713472 flags system|dup
> [10511520.586222] BTRFS info (device md1): found 5 extents
> [10511523.107052] BTRFS info (device md1): relocating block group 2935286=
267904 flags system|dup
> [10511524.392271] BTRFS info (device md1): found 5 extents
> [10511527.381846] BTRFS info (device md1): relocating block group 2935319=
822336 flags system|dup
> [10511528.766564] BTRFS info (device md1): found 5 extents
> [10857025.725121] BTRFS info (device md1): relocating block group 2934145=
417216 flags data
> [10857057.071228] BTRFS info (device md1): found 1275 extents
> [10857073.721609] BTRFS info (device md1): found 1231 extents
> [10857086.237500] BTRFS info (device md1): relocating block group 2935386=
931200 flags data
> [10857095.182532] BTRFS info (device md1): found 151 extents
> [10857125.204024] BTRFS info (device md1): found 151 extents
> [10857133.473086] BTRFS info (device md1): relocating block group 2935353=
376768 flags system|dup
> [10857135.063924] BTRFS info (device md1): found 5 extents
> [10857138.066852] BTRFS info (device md1): relocating block group 2937534=
414848 flags system|dup
> [10857139.542984] BTRFS info (device md1): found 5 extents
> [10857142.083035] BTRFS info (device md1): relocating block group 2937567=
969280 flags system|dup
> [10857143.664667] BTRFS info (device md1): found 5 extents
> [10857145.971518] BTRFS info (device md1): relocating block group 2937601=
523712 flags system|dup
> [10857146.924543] BTRFS info (device md1): found 5 extents
> [10857150.289957] BTRFS info (device md1): relocating block group 2937635=
078144 flags system|dup
> [10857152.173086] BTRFS info (device md1): found 5 extents
> [10860370.725465] scrub_handle_errored_block: 71 callbacks suppressed
> [10860370.764356] btrfs_dev_stat_print_on_error: 71 callbacks suppressed
> [10860370.764359] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd =
0, flush 0, corrupt 2291, gen 0
> [10860370.764593] scrub_handle_errored_block: 71 callbacks suppressed
> [10860370.764595] BTRFS error (device md1): unable to fixup (regular) err=
or at logical 593483341824 on dev /dev/md1
> [10860395.236787] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd =
0, flush 0, corrupt 2292, gen 0
> [10860395.237267] BTRFS error (device md1): unable to fixup (regular) err=
or at logical 595304841216 on dev /dev/md1
> [10860395.506085] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd =
0, flush 0, corrupt 2293, gen 0
> [10860395.506560] BTRFS error (device md1): unable to fixup (regular) err=
or at logical 595326820352 on dev /dev/md1
> [10860395.511546] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd =
0, flush 0, corrupt 2294, gen 0
> [10860395.512061] BTRFS error (device md1): unable to fixup (regular) err=
or at logical 595327647744 on dev /dev/md1
> [10860395.664956] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd =
0, flush 0, corrupt 2295, gen 0
> [10860395.664959] BTRFS error (device md1): unable to fixup (regular) err=
or at logical 595344850944 on dev /dev/md1
> [10860395.677733] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd =
0, flush 0, corrupt 2296, gen 0
> [10860395.677736] BTRFS error (device md1): unable to fixup (regular) err=
or at logical 595346452480 on dev /dev/md1
> [10860395.770918] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd =
0, flush 0, corrupt 2297, gen 0
> [10860395.771523] BTRFS error (device md1): unable to fixup (regular) err=
or at logical 595357601792 on dev /dev/md1
> [10860395.789808] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd =
0, flush 0, corrupt 2298, gen 0
> [10860395.790455] BTRFS error (device md1): unable to fixup (regular) err=
or at logical 595359870976 on dev /dev/md1
> [10860395.806699] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd =
0, flush 0, corrupt 2299, gen 0
> [10860395.807381] BTRFS error (device md1): unable to fixup (regular) err=
or at logical 595361865728 on dev /dev/md1
> [10860395.918793] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd =
0, flush 0, corrupt 2300, gen 0
> [10860395.919513] BTRFS error (device md1): unable to fixup (regular) err=
or at logical 595372343296 on dev /dev/md1
> [10860395.993817] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd =
0, flush 0, corrupt 2301, gen 0
> [10860395.994574] BTRFS error (device md1): unable to fixup (regular) err=
or at logical 595384438784 on dev /dev/md1
> [11033396.165434] md: data-check of RAID array md0
> [11033396.273818] md: data-check of RAID array md2
> [11033396.282822] md: delaying data-check of md1 until md0 has finished (=
they share one or more physical units)
> [11033406.609033] md: md0: data-check done.
> [11033406.623027] md: data-check of RAID array md1
> [11035858.847538] md: md2: data-check done.
> [11043788.746468] md: md1: data-check done.
>=20
> For obvious reasons the "BTRFS error (device md1): unable to fixup (regul=
ar) error" lines made me nervous
> and I would like to understand better what is going on.

btrfs found corrupted data on md1.  You appear to be using btrfs
-dsingle on a single mdadm raid1 device, so no recovery is possible
("unable to fixup").

> The system has ECC memory with md1 being a RAID1 which passes all health =
checks.

mdadm doesn't have any way to repair data corruption--it can find
differences, but it cannot identify which version of the data is correct.
If one of your drives is corrupting data without reporting IO errors,
mdadm will simply copy the corruption to the other drive.  If one
drive is failing by intermittently injecting corrupted bits into reads
(e.g. because of a failure in the RAM on the drive control board),
this behavior may not show up in mdadm health checks.

> I tried to find the inodes behind the erroneous addresses without success.
> e.g.
> $ btrfs inspect-internal logical-resolve -v -P 593483341824 /
> ioctl ret=3D0, total_size=3D4096, bytes_left=3D4080, bytes_missing=3D0, c=
nt=3D0, missed=3D0
> $ echo $?
> 1

That usually means the file is deleted, or the specific blocks referenced
have been overwritten (i.e. there are no references to the given block in
any existing file, but a reference to the extent containing the block
still exists).  Although it's not possible to reach those blocks by
reading a file, a scrub or balance will still hit the corrupted blocks.

You can try adding or subtracting multiples of 4096 to the block number
to see if you get a hint about which inodes reference this extent.
The first block found in either direction should be a reference to the
same extent, though there's no easy way (other than dumping the extent
tree with 'btrfs ins dump-tree -t 2' and searching for the extent record
containing the block number) to figure out which.  Extents can be up to
128MB long, i.e. 32768 blocks.

Or modify 'btrfs ins log' to use LOGICAL_INO_V2 and the IGNORE_OFFSETS
flag.

> My kernel is 4.12.14-lp150.12.64-default (OpenSUSE 15.0), so not super re=
cent but AFAICT btrfs should be sane
> there. :-)

I don't know of specific problems with csums in 4.12, but I'd upgrade that
for a dozen other reasons anyway.  One of those is that LOGICAL_INO_V2
was merged in 4.15.

> What could cause the errors and how to dig further?

Probably a silent data corruption on one of the underlying disks.
If you convert this mdadm raid1 to btrfs raid1, btrfs will tell you
which disk the errors are coming from while also correcting them.

> Thanks,
> //richard
>=20
>=20

--DqhR8hV3EnoxUkKN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXcXnkwAKCRCB+YsaVrMb
nPCLAJ4sZk+0JsJMBmFy8WNNyiVs1nLcFwCgvMLc0dNY4lPP24BE637UZPkAeE0=
=e+PD
-----END PGP SIGNATURE-----

--DqhR8hV3EnoxUkKN--
