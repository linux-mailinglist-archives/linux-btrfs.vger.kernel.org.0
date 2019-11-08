Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73BD6F5ADA
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2019 23:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbfKHWYP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Nov 2019 17:24:15 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:36060 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfKHWYO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Nov 2019 17:24:14 -0500
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Nov 2019 17:24:14 EST
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 4F0184C11A5; Fri,  8 Nov 2019 17:16:57 -0500 (EST)
Date:   Fri, 8 Nov 2019 17:16:56 -0500
From:   Zygo Blaxell <zblaxell@furryterror.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Decoding "unable to fixup (regular)" errors
Message-ID: <20191108221656.GS22121@hungrycats.org>
References: <1591390.YpsIS3gr9g@blindfold>
 <2590197.gOHgNE8CYM@blindfold>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ni93GHxFvA+th69W"
Content-Disposition: inline
In-Reply-To: <2590197.gOHgNE8CYM@blindfold>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--ni93GHxFvA+th69W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 08, 2019 at 11:06:50PM +0100, Richard Weinberger wrote:
> Am Dienstag, 5. November 2019, 23:03:01 CET schrieb Richard Weinberger:
> > [10860370.764595] BTRFS error (device md1): unable to fixup (regular) e=
rror at logical 593483341824 on dev /dev/md1
> > [10860395.236787] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, r=
d 0, flush 0, corrupt 2292, gen 0
> > [10860395.237267] BTRFS error (device md1): unable to fixup (regular) e=
rror at logical 595304841216 on dev /dev/md1
> > [10860395.506085] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, r=
d 0, flush 0, corrupt 2293, gen 0
> > [10860395.506560] BTRFS error (device md1): unable to fixup (regular) e=
rror at logical 595326820352 on dev /dev/md1
> > [10860395.511546] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, r=
d 0, flush 0, corrupt 2294, gen 0
> > [10860395.512061] BTRFS error (device md1): unable to fixup (regular) e=
rror at logical 595327647744 on dev /dev/md1
> > [10860395.664956] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, r=
d 0, flush 0, corrupt 2295, gen 0
> > [10860395.664959] BTRFS error (device md1): unable to fixup (regular) e=
rror at logical 595344850944 on dev /dev/md1
> > [10860395.677733] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, r=
d 0, flush 0, corrupt 2296, gen 0
> > [10860395.677736] BTRFS error (device md1): unable to fixup (regular) e=
rror at logical 595346452480 on dev /dev/md1
> > [10860395.770918] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, r=
d 0, flush 0, corrupt 2297, gen 0
> > [10860395.771523] BTRFS error (device md1): unable to fixup (regular) e=
rror at logical 595357601792 on dev /dev/md1
> > [10860395.789808] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, r=
d 0, flush 0, corrupt 2298, gen 0
> > [10860395.790455] BTRFS error (device md1): unable to fixup (regular) e=
rror at logical 595359870976 on dev /dev/md1
> > [10860395.806699] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, r=
d 0, flush 0, corrupt 2299, gen 0
> > [10860395.807381] BTRFS error (device md1): unable to fixup (regular) e=
rror at logical 595361865728 on dev /dev/md1
> > [10860395.918793] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, r=
d 0, flush 0, corrupt 2300, gen 0
> > [10860395.919513] BTRFS error (device md1): unable to fixup (regular) e=
rror at logical 595372343296 on dev /dev/md1
> > [10860395.993817] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, r=
d 0, flush 0, corrupt 2301, gen 0
> > [10860395.994574] BTRFS error (device md1): unable to fixup (regular) e=
rror at logical 595384438784 on dev /dev/md1
>=20
> > For obvious reasons the "BTRFS error (device md1): unable to fixup (reg=
ular) error" lines made me nervous
> > and I would like to understand better what is going on.
> > The system has ECC memory with md1 being a RAID1 which passes all healt=
h checks.
> >=20
> > I tried to find the inodes behind the erroneous addresses without succe=
ss.
> > e.g.
> > $ btrfs inspect-internal logical-resolve -v -P 593483341824 /
> > ioctl ret=3D0, total_size=3D4096, bytes_left=3D4080, bytes_missing=3D0,=
 cnt=3D0, missed=3D0
> > $ echo $?
> > 1
> >=20
> > My kernel is 4.12.14-lp150.12.64-default (OpenSUSE 15.0), so not super =
recent but AFAICT btrfs should be sane
> > there. :-)
> >=20
> > What could cause the errors and how to dig further?
>=20
> I was able to reproduce this on vanilla v5.4-rc6.
>=20
> Instrumenting btrfs revealed that all erroneous blocks are data blocks (B=
TRFS_EXTENT_FLAG_DATA)
> and only have ->checksum_error set.
> Both expected and computed checksums are non-zero.
>=20
> To me it seems like all these blocks are orphaned data, while extent_from=
_logical() finds and extent
> for the affected logical addresses, none of the extents belong to an inod=
e.
> This explains also why "btrfs inspect-internal logical-resolve" is unable=
 to point me to an
> inode. And why scrub_print_warning("checksum error", sblock_to_check) doe=
s not log anything.
> The function returns early if no inode can be found for a data block...
>=20
> This is something to worry about?
>=20
> Why does the scrubbing mechanism check orphaned blocks?

Because it would be absurdly expensive to figure out which blocks in an
extent are orphaned.

Scrub normally reads just the extent and csum trees which are already
sorted in on-disk order, so it reads fast with no seeking.

To determine if an extent has orphaned blocks, scrub would have to
follow backrefs until it found references to every block in the extent,
or ran out of backrefs without finding a reference to at least one block.
The seeking makes this hundreds to millions of times more expensive than
just reading and verifying the orphan blocks.

> Thanks,
> //richard
>=20
>=20

--ni93GHxFvA+th69W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXcXpWAAKCRCB+YsaVrMb
nJTQAJsGEA6u9m9lySY8uV7OFi5TUcBp1wCfXr+7VUoda0F/zEpSmwlbLtAbqr8=
=YQEd
-----END PGP SIGNATURE-----

--ni93GHxFvA+th69W--
