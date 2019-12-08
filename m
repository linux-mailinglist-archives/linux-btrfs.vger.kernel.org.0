Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 664FA11635F
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2019 19:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfLHSMe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Dec 2019 13:12:34 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:40908 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfLHSMe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 8 Dec 2019 13:12:34 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 296835157BA; Sun,  8 Dec 2019 13:12:33 -0500 (EST)
Date:   Sun, 8 Dec 2019 13:12:33 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Martin Raiber <martin@urbackup.org>,
        Tomasz Chmielewski <mangoo@wpkg.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: df shows no available space in 5.4.1
Message-ID: <20191208181232.GE22121@hungrycats.org>
References: <0102016edd1b0184-848d9b6d-6b80-4ce3-8428-e472a224e554-000000@eu-west-1.amazonses.com>
 <CAJCQCtTMCQBU98hYdzizMsxajB+6cmxYs5CKmNVDh4D9YZgfEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4CyH/NlNBqvsUTYP"
Content-Disposition: inline
In-Reply-To: <CAJCQCtTMCQBU98hYdzizMsxajB+6cmxYs5CKmNVDh4D9YZgfEg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--4CyH/NlNBqvsUTYP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2019 at 03:35:59PM -0700, Chris Murphy wrote:
> On Fri, Dec 6, 2019 at 2:26 PM Martin Raiber <martin@urbackup.org> wrote:
> >
> > Hi,
> >
> > with kernel 5.4.1 I have the problem that df shows 100% space used. I
> > can still write to the btrfs volume, but my software looks at the
> > available space and starts deleting stuff if statfs() says there is a
> > low amount of available space.
>=20
> This is the second bug like this reported in as many days against 5.4.1.
>=20
> Does this happen with an older kernel? Any 5.3 kernel or 5.2.15+ or
> any 5.1 kernel? Or heck, even 5.4? :P

I've noticed very different (lower) df space estimations while testing
5.3 kernels, compared to 5.0 or 5.2, on a draid5/mraid1 array.

df estimated about 1926 GB free on 5.0 and 5.2, 964 GB free on 5.3.
I'm guessing about 2GB was used in the time between those measurements,
which accounts for the discrepancy 1926 !=3D 964 * 2.

My array has 2 large disks and 1 small one.  The small one is full,
so only 2 drives are available for allocation, and at the time they
both had 954 GB of unallocated space + 10 GB in allocated/unused space.
The correct amount of free space is closer to 964 GB (5.3 value) than
1926 GB (5.0/5.2 values).


>=20
>=20
> >
> > # df -h
> > Filesystem                                            Size  Used Avail
> > Use% Mounted on
> > ...
> > /dev/loop0                                            7.4T  623G     0
> > 100% /media/backup
> > ...
> >
> > statfs("/media/backup", {f_type=3DBTRFS_SUPER_MAGIC, f_bsize=3D4096,
> > f_blocks=3D1985810876, f_bfree=3D1822074245, f_bavail=3D0, f_files=3D0,
> > f_ffree=3D0, f_fsid=3D{val=3D[3667078581, 2813298474]}, f_namelen=3D255,
> > f_frsize=3D4096, f_flags=3DST_VALID|ST_NOATIME}) =3D 0
>=20
>=20
> f_bavail=3D0 seems wrong to me.
>=20
> What distro and what version of coreutils?
>=20
> It's the same questions for Tomasz in yesterday's thread with similar sub=
ject.
>=20
> --
> Chris Murphy

--4CyH/NlNBqvsUTYP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXe09DgAKCRCB+YsaVrMb
nKYrAJwKbyiUFbzVcIRg4Fmx7fzqyr3krACg4/ZBraAOWswaMypfxQ9o51wGPWE=
=K/gg
-----END PGP SIGNATURE-----

--4CyH/NlNBqvsUTYP--
