Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7B54AA72
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2019 20:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbfFRS5F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jun 2019 14:57:05 -0400
Received: from frost.carfax.org.uk ([85.119.82.111]:32891 "EHLO
        frost.carfax.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730142AbfFRS5F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jun 2019 14:57:05 -0400
Received: from hrm by frost.carfax.org.uk with local (Exim 4.80)
        (envelope-from <hrm@carfax.org.uk>)
        id 1hdJHx-0003jR-SM; Tue, 18 Jun 2019 18:57:01 +0000
Date:   Tue, 18 Jun 2019 18:57:01 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Cc:     =?iso-8859-1?Q?St=E9phane?= Lesimple <stephane_btrfs@lesimple.fr>,
        linux-btrfs@vger.kernel.org
Subject: Re: Rebalancing raid1 after adding a device
Message-ID: <20190618185701.GK21016@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        "Austin S. Hemmelgarn" <ahferroin7@gmail.com>,
        =?iso-8859-1?Q?St=E9phane?= Lesimple <stephane_btrfs@lesimple.fr>,
        linux-btrfs@vger.kernel.org
References: <16b6bd72bc0.2787.faeb54a6cf393cf366ff7c8c6259040e@lesimple.fr>
 <20190618184501.GJ21016@carfax.org.uk>
 <51e41a52-cbec-dae8-afec-ec171ec36eaa@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+HmK7y6O+lKZIGkr"
Content-Disposition: inline
In-Reply-To: <51e41a52-cbec-dae8-afec-ec171ec36eaa@gmail.com>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--+HmK7y6O+lKZIGkr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2019 at 02:50:34PM -0400, Austin S. Hemmelgarn wrote:
> On 2019-06-18 14:45, Hugo Mills wrote:
> >On Tue, Jun 18, 2019 at 08:26:32PM +0200, St=E9phane Lesimple wrote:
> >>I've been a btrfs user for quite a number of years now, but it seems
> >>I need the wiseness of the btrfs gurus on this one!
> >>
> >>I have a 5-hdd btrfs raid1 setup with 4x3T+1x10T drives.
> >>A few days ago, I replaced one of the 3T by a new 10T, running btrfs
> >>replace and then resizing the FS to use all the available space of
> >>the new device.
> >>
> >>The filesystem was 90% full before I expanded it so, as expected,
> >>most of the space on the new device wasn't actually allocatable in
> >>raid1, as very few available space was available on the 4 other
> >>devs.
> >>
> >>Of course the solution is to run a balance, but as the filesystem is
> >>now quite big, I'd like to avoid running a full rebalance. This
> >>would be quite i/o intensive, would be running for several days, and
> >>putting and unecessary stress on the drives. This also seems
> >>excessive as in theory only some Tb would need to be moved: if I'm
> >>correct, only one of two block groups of a sufficient amount of
> >>chunks to be moved to the new device so that the sum of the amount
> >>of available space on the 4 preexisting devices would at least equal
> >>the available space on the new device, ~7Tb instead of moving ~22T.
> >>I don't need to have a perfectly balanced FS, I just want all the
> >>space to be allocatable.
> >>
> >>I tried using the -ddevid option but it only instructs btrfs to work
> >>on the block groups allocated on said device, as it happens, it
> >>tends to move data between the 4 preexisting devices and doesn't fix
> >>my problem. A full balance with -dlimit=3D100 did no better.
> >
> >    -dlimit=3D100 will only move 100 GiB of data (i.e. 200 GiB), so it'll
> >be a pretty limited change. You'll need to use a larger number than
> >that if you want it to have a significant visible effect.
> Last I checked, that's not how the limit filter works.  AFAIUI, it's
> an upper limit on how full a chunk can be to be considered for the
> balance operation.  So, balancing with only `-dlimit=3D100` should
> actually balance all data chunks (but only data chunks, because you
> haven't asked for metadata balancing).

   That's usage, not limit. limit is simply counting the number of
block groups to move.

   Hugo.

--=20
Hugo Mills             | Great films about cricket: Umpire of the Rising Sun
hugo@... carfax.org.uk |
http://carfax.org.uk/  |
PGP: E2AB1DE4          |

--+HmK7y6O+lKZIGkr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJdCTP9AAoJEFheFHXiqx3kFkYP+wRjpuNE/f05ALBCMsKV0nyn
YaUkm+lZReuDofa31CmoBRMC2y2anv7381g3MamnHBgPnenW2f6+lGR4TU691u9a
k1jEb5c3Dh+cnfCxIH82ts7tRYLKN0f+fyc035CilIgD1H6D2Yll26Rz7Wo/IyQI
18JpWSMqRYdA3EHD1T2cnRx8MuCu3nBvSkFtDLHv1GiOhUE3FcwaCsmlihVUEknT
FilDgCmHxjQw27R+lTZWcv2TfbFKxRzdTPuLMOoF2Z9Z/KitWJJ4crqB9nktmsuS
tk7Q3Iy6NNpz6Its6fPwjTWqTzt0HgeWEOunq/xDnq4VuYYGMErm7oGZw3m3Y9cj
XdlkS1Ah8l6cWUH9wg8uQyLnFw710X3hJVPXO3X531AR54aX0EXCkyZ844womxCd
TtaltR1k0jRNhA/ijg2HcNWMPZpIV0A3lBzaN+NUpWK51Mmmyvu1VnUzLLXlnS0W
5B/nOgd0McRbaH/Iw/lUrkXiGMoVV+DJ8VFfSJvwB0xscrP6N5irjXGtL+MDcAfl
Gasvzy7PEi6TKcaBNAq/JhDh4GhUdugmdMLEA4QWrhfcpMmRr9bsP+fO7IIfv6oa
kIrEI+taerxPNk2SAml6NRTHNg4rYhJq5jC3DFI9Q8ouZtMVDr8DWap2gg1fP3uv
C8kDjL/wgm5frFpUY3oU
=2fWB
-----END PGP SIGNATURE-----

--+HmK7y6O+lKZIGkr--
