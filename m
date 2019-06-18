Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 152134AAF6
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2019 21:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbfFRTWF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jun 2019 15:22:05 -0400
Received: from frost.carfax.org.uk ([85.119.82.111]:32999 "EHLO
        frost.carfax.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfFRTWF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jun 2019 15:22:05 -0400
Received: from hrm by frost.carfax.org.uk with local (Exim 4.80)
        (envelope-from <hrm@carfax.org.uk>)
        id 1hdJgB-0003s2-0c; Tue, 18 Jun 2019 19:22:03 +0000
Date:   Tue, 18 Jun 2019 19:22:02 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     =?iso-8859-1?Q?St=E9phane?= Lesimple <stephane_btrfs@lesimple.fr>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Rebalancing raid1 after adding a device
Message-ID: <20190618192202.GL21016@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        =?iso-8859-1?Q?St=E9phane?= Lesimple <stephane_btrfs@lesimple.fr>,
        linux-btrfs@vger.kernel.org
References: <20190618184501.GJ21016@carfax.org.uk>
 <16b6bd72bc0.2787.faeb54a6cf393cf366ff7c8c6259040e@lesimple.fr>
 <97d71a1c6b16fec6a49004db84fac254@lesimple.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="KIbT1ud6duwZIwNL"
Content-Disposition: inline
In-Reply-To: <97d71a1c6b16fec6a49004db84fac254@lesimple.fr>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--KIbT1ud6duwZIwNL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2019 at 07:14:26PM +0000, DO NOT USE wrote:
> June 18, 2019 8:45 PM, "Hugo Mills" <hugo@carfax.org.uk> wrote:
>
> > On Tue, Jun 18, 2019 at 08:26:32PM +0200, St=E9phane Lesimple wrote:
> >> [...]
> >> I tried using the -ddevid option but it only instructs btrfs to work
> >> on the block groups allocated on said device, as it happens, it
> >> tends to move data between the 4 preexisting devices and doesn't fix
> >> my problem. A full balance with -dlimit=3D100 did no better.
> >
> > -dlimit=3D100 will only move 100 GiB of data (i.e. 200 GiB), so it'll
> > be a pretty limited change. You'll need to use a larger number than
> > that if you want it to have a significant visible effect.
>
> Yes of course, I wasn't clear here but what I meant to do when starting
> a full balance with -dlimit=3D100 was to test under a reasonable amount of
> time whether the allocator would prefer to fill the new drive. I observed
> after those 100G (200G) of data moved that it wasn't the case at all.
> Specifically, no single allocation happened on the new drive. I know this
> would be the case at some point, after Terabytes of data would have been
> moved, but that's exactly what I'm trying to avoid.

   It's probably putting the data into empty space first. The solution
here would, as Austin said in his reply to your original post, be to
run some compaction on the FS, which will move data from chunks with
little data in, into existing chunks with space. When that's done,
you'll be able to see the chunks moving onto the new device.

[snip]
> > It would be really great if there was an ioctl that allowed you to
> > say things like "take the chunks of this block group and put them on
> > devices 2, 4 and 5 in RAID-5", because you could do a load of
> > optimisation with reshaping the FS in userspace with that. But I
> > suspect it's a long way down the list of things to do.
>
> Exactly, that would be awesome. I would probably even go as far as
> writing some C code myself to call this ioctl to do this "intelligent"
> balance on my system!

   You wouldn't need to. I'd be at the head of the queue to write the
tool. :)

   Hugo.

--=20
Hugo Mills             | How do you become King? You stand in the marketpla=
ce
hugo@... carfax.org.uk | and announce you're going to tax everyone. If you
http://carfax.org.uk/  | get out alive, you're King.
PGP: E2AB1DE4          |                                        Harry Harri=
son

--KIbT1ud6duwZIwNL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJdCTnaAAoJEFheFHXiqx3kReoP/jKN3TiDXkwsKW4P1ddl0pIG
JyGwjAkGJIDYZB83UrZNnOgqNImKBI+g3ZkjtLd/Ud9TMNjetW5s+oi3esVgF3+C
aVOC1Zj0ex4W1bVfhOXHD2YykfoifM1le0n4PqK4/Y1bzs3g4KfH5xqpMBRqpwSb
bQzZc6FYOHFgaSK4cBK2mHBF5DepCXjXSSnqolefB5IG9wPOyiOmxVevBz1IswOv
K1UjUwv54QewZMIE3qm266mEic3V0kusyrQdoEZ3kYT7n5DErBITZIxlKemsRTeY
9qhWDHVU79sZq9ruAb6+mM0Rr3Vpg6TWuvBkRn14C5jKqH4hCeCF1d5DGjrwsmDr
ONx35A1FMRHnxqF2nYH3f3v73szZ/X39imKw9ezc/eZoMzqqdYkDSXqYyA0uSWzs
W/TPFrH6CoJRkTK6cPE1pAOCXMjRcN0nGxACl4wFfOXQ2mORR5TWPnHR5nWlFhZl
ElPbLBKP4OgMl4J5DcVkQjahWS4YMDphCjSMlIEVeTfcqPag0bSREUuCiOViccbJ
BMrZaF9/RwVDC3WALgHTPdGgIl8Ayng/zNr9xrfR+ZTrOXf1Uw+6/hfZUBhlbzFb
HEvF9evDkSQUSH8iERbibdu7+cJpMTbWOdGkw9VN4lt4hw6FygX6NuSzD6rdXOfC
CM+Xn7VVaxADhUcQJcLr
=sPaR
-----END PGP SIGNATURE-----

--KIbT1ud6duwZIwNL--
