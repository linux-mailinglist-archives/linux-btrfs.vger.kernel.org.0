Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCE114E751
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 04:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgAaDAy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 22:00:54 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:34034 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbgAaDAy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 22:00:54 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 43F5D59C4BD; Thu, 30 Jan 2020 22:00:53 -0500 (EST)
Date:   Thu, 30 Jan 2020 22:00:53 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     David Sterba <dsterba@suse.cz>,
        Martin Steigerwald <martin@lichtvoll.de>,
        Martin Raiber <martin@urbackup.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: With Linux 5.5: Filesystem full while still 90 GiB free
Message-ID: <20200131030053.GR13306@hungrycats.org>
References: <112911984.cFFYNXyRg4@merkaba>
 <0102016ff2e7e3ad-6b776470-32f1-4b3d-9063-d3c96921df89-000000@eu-west-1.amazonses.com>
 <2049829.BAvHWrS4Fr@merkaba>
 <CAJCQCtSVqMBONCuwea_9i6xBkzOHSkCSoEAaDi2aH+-CLnNwBg@mail.gmail.com>
 <20200130171950.GZ3929@twin.jikos.cz>
 <CAJCQCtSwJHR2+jEXY=eK41xR7Z0=+Jf5xhsD03Qvoh92bAHO6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="lt3WynA+XK9Fj6D4"
Content-Disposition: inline
In-Reply-To: <CAJCQCtSwJHR2+jEXY=eK41xR7Z0=+Jf5xhsD03Qvoh92bAHO6g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--lt3WynA+XK9Fj6D4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2020 at 12:31:40PM -0700, Chris Murphy wrote:
> On Thu, Jan 30, 2020 at 10:20 AM David Sterba <dsterba@suse.cz> wrote:
> >
> > On Wed, Jan 29, 2020 at 03:55:06PM -0700, Chris Murphy wrote:
> > > On Wed, Jan 29, 2020 at 2:20 PM Martin Steigerwald <martin@lichtvoll.=
de> wrote:
> > > >
> > > > So if its just a cosmetic issue then I can wait for the patch to la=
nd in
> > > > linux-stable. Or does it still need testing?
> > >
> > > I'm not seeing it in linux-next. A reasonable short term work around
> > > is mount option 'metadata_ratio=3D1' and that's what needs more testi=
ng,
> > > because it seems decently likely mortal users will need an easy work
> > > around until a fix gets backported to stable. And that's gonna be a
> > > while, me thinks.
> >
> > We're looking into some fix that could be backported, as it affects a
> > long-term kernel (5.4).
> >
> > The fix
> > https://lore.kernel.org/linux-btrfs/20200115034128.32889-1-wqu@suse.com/
> > IMHO works by accident and is not good even as a workaround, only papers
> > over the problem in some cases. The size of metadata over-reservation
> > (caused by a change in the logic that estimates the 'over-' part) adds
> > up to the global block reserve (that's permanent and as last resort
> > reserve for deletion).
> >
> > In other words "we're making this larger by number A, so let's subtract
> > some number B". The fix is to use A.
> >
> > > Is that mount option sufficient? Or does it take a filtered balance?
> > > What's the most minimal balance needed? I'm hoping -dlimit=3D1
> > >
> > > I can't figure out a way to trigger this though, otherwise I'd be
> > > doing more testing.
> >
> > I haven't checked but I think the suggested workarounds affect statfs as
> > a side effect. Also as the reservations are temporary, the numbers
> > change again after a sync.
>=20
> Yeah I'm being careful to qualify to mortal users that any workarounds
> are temporary and uncertain. I'm not even certain what the pattern is,
> people with new file systems have hit it. A full balance seems to fix
> it, and then soon after the problem happens again. I don't do any
> balancing these days, for over a year now, so I wonder if that's why
> I'm not seeing it.

I had to intentionally balance metadata to trigger the bug on pre-existing
test filesystems.  With new filesystems it's easy, I hit it every time
the last metadata block group is half full (assuming default BG size of
1GB and max global reserved size of 512MB).  It goes away when a new
metadata BG is allocated, then comes back again later.  Sometimes it
appears and disappears rapidly while doing a large file tree copy.

An older filesystem will have some GB of allocated but partially empty
metadata BGs, and won't hit this condition unless you run metadata balance
(which shrinks metadata), or do something that causes explosive metadata
growth.  If you normally keep a healthy amount of allocated but unused
metadata space, you probably will never hit the bug.

> But yeah a small number of people are hitting it, but it also stops
> any program that does a free space check (presumably using statfs).
>=20
> A more reliable/universal work around in the meantime is still useful;
> in particular if it doesn't require changing mount options, or only
> requires it temporarily (e.g. not added  to /etc/fstab, where it can
> be forgotten for the life of that system).

You can create a GB of allocated but unused metadata space with something
like:

	btrfs sub create sub_tmp
	mkdir sub_tmp/single
	head -c 2047 /dev/urandom > sub_tmp/single/inline_file
	for x in $(seq 1 18); do=20
		cp -a sub_tmp/single sub_tmp/double
		mv sub_tmp/double sub_tmp/single/$x
	done
	sync
	btrfs sub del sub_tmp

This requires the max_inline mount option to be set to the default (2048).
Random data means it works well when compression is enabled too.

Do not balance metadata until the bug is fixed.  Balancing metadata will
release the allocated but unused metadata space, possibly retriggering
the bug.

(Hmmm...the above script is also a surprisingly effective commit latency
test case...)

>=20
> --=20
> Chris Murphy

--lt3WynA+XK9Fj6D4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXjOYYgAKCRCB+YsaVrMb
nNbSAJ9mulGWu/9/ytzfY9x/VJ49Gd2JOQCfQ5kgYXTUZBEhAP+PSNXwrNf2fQY=
=JI4i
-----END PGP SIGNATURE-----

--lt3WynA+XK9Fj6D4--
