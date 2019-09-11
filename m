Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71238B01AF
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 18:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbfIKQdu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 12:33:50 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:34634 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728828AbfIKQdu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 12:33:50 -0400
X-Greylist: delayed 443 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Sep 2019 12:33:50 EDT
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id C8634420431; Wed, 11 Sep 2019 12:26:05 -0400 (EDT)
Date:   Wed, 11 Sep 2019 12:26:05 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Cc:     webmaster@zedlx.com, linux-btrfs@vger.kernel.org
Subject: Re: Feature requests: online backup - defrag - change RAID level
Message-ID: <20190911162605.GA22121@hungrycats.org>
References: <20190908225508.Horde.51Idygc4ykmhqRn316eLdRO@server53.web-hosting.com>
 <5e6a9092-b9f9-58d2-d638-9e165d398747@gmx.com>
 <20190909072518.Horde.c4SobsfDkO6FUtKo3e_kKu0@server53.web-hosting.com>
 <fb80b97a-9bcd-5d13-0026-63e11e1a06b5@gmx.com>
 <c4f05241-77d4-3ae4-9773-795351a26a8e@cobb.uk.net>
 <20190909152625.Horde.fICzOssZXCnCZS2vVHBK-sn@server53.web-hosting.com>
 <fc81fcf2-f8e9-1a08-52f8-136503e40494@gmail.com>
 <20190910193221.Horde.HYrKYqNVgQ10jshWWA1Gxxu@server53.web-hosting.com>
 <d958659e-6dc0-fa0a-7da9-2d88df4588f5@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: <d958659e-6dc0-fa0a-7da9-2d88df4588f5@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2019 at 08:02:40AM -0400, Austin S. Hemmelgarn wrote:
> On 2019-09-10 19:32, webmaster@zedlx.com wrote:
> >=20
> > Quoting "Austin S. Hemmelgarn" <ahferroin7@gmail.com>:
> >=20
> >=20
> > > > Defrag may break up extents. Defrag may fuse extents. But it
> > > > shouln't ever unshare extents.
> >=20
> > > Actually, spitting or merging extents will unshare them in a large
> > > majority of cases.
> >=20
> > Ok, this point seems to be repeated over and over without any proof, and
> > it is illogical to me.
> >=20
> > About merging extents: a defrag should merge extents ONLY when both
> > extents are shared by the same files (and when those extents are
> > neighbours in both files). In other words, defrag should always merge
> > without unsharing. Let's call that operation "fusing extents", so that
> > there are no more misunderstandings.
> And I reiterate: defrag only operates on the file it's passed in.  It nee=
ds
> to for efficiency reasons (we had a reflink aware defrag for a while a few
> years back, it got removed because performance limitations meant it was
> unusable in the cases where you actually needed it). Defrag doesn't even
> know that there are reflinks to the extents it's operating on.
>=20
> Now factor in that _any_ write will result in unsharing the region being
> written to, rounded to the nearest full filesystem block in both directio=
ns
> (this is mandatory, it's a side effect of the copy-on-write nature of BTR=
FS,
> and is why files that experience heavy internal rewrites get fragmented v=
ery
> heavily and very quickly on BTRFS).
>=20
> Given this, defrag isn't willfully unsharing anything, it's just a
> side-effect of how it works (since it's rewriting the block layout of the
> file in-place).
> >=20
> > =3D=3D=3D I CHALLENGE you and anyone else on this mailing list: =3D=3D=
=3D
> >=20
> >  =A0- Show me an exaple where splitting an extent requires unsharing, a=
nd
> > this split is needed to defrag.
> >
> > Make it clear, write it yourself, I don't want any machine-made outputs.
> >=20
> Start with the above comment about all writes unsharing the region being
> written to.
>=20
> Now, extrapolating from there:
>=20
> Assume you have two files, A and B, each consisting of 64 filesystem bloc=
ks
> in single shared extent.  Now assume somebody writes a few bytes to the
> middle of file B, right around the boundary between blocks 31 and 32, and
> that you get similar writes to file A straddling blocks 14-15 and 47-48.
>=20
> After all of that, file A will be 5 extents:
>=20
> * A reflink to blocks 0-13 of the original extent.
> * A single isolated extent consisting of the new blocks 14-15
> * A reflink to blocks 16-46 of the original extent.
> * A single isolated extent consisting of the new blocks 47-48
> * A reflink to blocks 49-63 of the original extent.
>=20
> And file B will be 3 extents:
>=20
> * A reflink to blocks 0-30 of the original extent.
> * A single isolated extent consisting of the new blocks 31-32.
> * A reflink to blocks 32-63 of the original extent.
>=20
> Note that there are a total of four contiguous sequences of blocks that a=
re
> common between both files:
>=20
> * 0-13
> * 16-30
> * 32-46
> * 49-63
>=20
> There is no way to completely defragment either file without splitting the
> original extent (which is still there, just not fully referenced by either
> file) unless you rewrite the whole file to a new single extent (which wou=
ld,
> of course, completely unshare the whole file).  In fact, if you want to
> ensure that those shared regions stay reflinked, there's no way to
> defragment either file without _increasing_ the number of extents in that
> file (either file would need 7 extents to properly share only those 4
> regions), and even then only one of the files could be fully defragmented.

Arguably, the kernel's defrag ioctl should go ahead and do the extent
relocation and update all the reflinks at once, using the file given
in the argument as the "canonical" block order, i.e. the fd and offset
range you pass in is checked, and if it's not physically contiguous,
the extents in the range are copied to a single contiguous extent, then
all the other references to the old extent(s) within the offset range are
rewritten to point to the new extent, then the old extent is discarded.

It is possible to do this from userspace now using a mix of data copies
and dedupe, but it's much more efficient to use the facilities available
in the kernel:  in particular, the kernel can lock the extent in question
while all of this is going on, and the kernel can update shared snapshot
metadata pages directly instead of duplicating them and doing identical
updates on each copy.

This sort of extent reference manipulation, particularly of extents
referenced by readonly snapshots, used to break a lot of things (btrfs
send in particular) but the same issues came up again for dedupe,
and they now seem to be fixed as of 5.3 or so.  Maybe it's time to try
shared-extent-aware defrag again.

In practice, such an improved defrag ioctl would probably need some
more limit parameters, e.g.  "just skip over any extent with more than
1000 references" or "do a two-pass algorithm and relocate data only if
every reference to the data is logically contiguous" to avoid getting
bogged down on extents which require more iops to defrag in the present
than can possibly be saved by using the defrag result in the future.
That makes the defrag API even uglier, with even more magic baked-in
behavior to get in the way of users who know what they're doing, but
some stranger on a mailing list requested it, so why not...  :-P

> Such a situation generally won't happen if you're just dealing with
> read-only snapshots, but is not unusual when dealing with regular files t=
hat
> are reflinked (which is not an uncommon situation on some systems, as a l=
ot
> of people have `cp` aliased to reflink things whenever possible).

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXXkgEwAKCRCB+YsaVrMb
nAUzAKC/uFvuT+IVG6TehqpINvx1kGmu4ACdH99pM/vn1ksXa9UrXs//A8tsghw=
=DTjN
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
