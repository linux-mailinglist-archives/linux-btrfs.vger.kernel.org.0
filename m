Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3D2013389E
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2020 02:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgAHBlD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jan 2020 20:41:03 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:45108 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgAHBlD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jan 2020 20:41:03 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 3DFA2561146; Tue,  7 Jan 2020 20:41:02 -0500 (EST)
Date:   Tue, 7 Jan 2020 20:41:02 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: write amplification, was: very slow "btrfs dev delete" 3x6Tb,
 7Tb of data
Message-ID: <20200108014102.GD24056@hungrycats.org>
References: <cc364577-1bb8-1512-4d2e-dc7e465ca2d6@dubiel.pl>
 <20191228202344.GE13306@hungrycats.org>
 <c278f501-f5a5-c905-5431-2d735e97fa13@dubiel.pl>
 <CAJCQCtRvAZS1CNgJLdUZTNeUma6A74oPT-SeQe7NYHhXKrMzoA@mail.gmail.com>
 <5e6e2ff8-89be-45db-49d3-802de42663ed@dubiel.pl>
 <CAJCQCtSr9j8AzLRfguHb8+9n_snxmpXkw0V+LiuDnqqvLVAxKQ@mail.gmail.com>
 <20200104053843.GK13306@hungrycats.org>
 <CAJCQCtTvTbr9Civ5DLhTPRsMZ2qK2=YWFLB3JMSRRzZS9v-iNA@mail.gmail.com>
 <20200107233237.GC24056@hungrycats.org>
 <CAJCQCtRUtdBe7gBeRwMyWg40if8wJKgCvCF--yWTXORXDiDJJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="WChQLJJJfbwij+9x"
Content-Disposition: inline
In-Reply-To: <CAJCQCtRUtdBe7gBeRwMyWg40if8wJKgCvCF--yWTXORXDiDJJQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--WChQLJJJfbwij+9x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2020 at 04:53:13PM -0700, Chris Murphy wrote:
> On Tue, Jan 7, 2020 at 4:32 PM Zygo Blaxell
> <ce3g8jdj@umail.furryterror.org> wrote:
> >
> > It seems to be normal behavior for USB sticks and SD cards.  I've also
> > had USB sticks degrade (bit errors) simply from sitting unused on a she=
lf
> > for six months.  Some low-end SATA SSDs (like $20/TB drives from Amazon)
> > are giant USB sticks with a SATA interface, and will fail the same way.
> >
> > SD card vendors are starting to notice, and there are now SD card optio=
ns
> > with higher endurance ratings.  Still "putting this card in a dashcam
> > voids the warranty" in most cases.
> >
> > ext2 and msdos both make USB sticks last longer, but they have obvious
> > other problems.  From my fleet of raspberry pis, I find that SD cards
> > last longer on btrfs than ext4 with comparable write loads, but they
> > are still both lead very short lives, and the biggest life expectancy
> > improvement (up to a couple of years) comes from eliminating local
> > writes entirely.
>=20
> It's long been an accepted fact in professional photography circles
> that CF/SD card corruption is due to crappy firmware in cameras. Ergo,
> format (FAT32/exFAT) only with that camera's firmware, don't delete
> files using the camera's interface, suck off all the files (back them
> up too) then format the card in that particular camera, etc.

Well, those are all good ideas.  One should never assume firmware
is bug-free or that any individual storage device is durable or
interoperable.

I have encountered embedded firmware developers who write their own VFAT
implementation from scratch "because [they] don't want to debug someone
else's", as if exhaustive bug compatibility was somehow not inherent to
correct operation of a VFAT filesystem.

> I've wondered for a while now, if all of that was flash manufacturer
> buck passing.

Consumer SD cards have been ruthlessly optimized for decades, mostly
for cost.  It will take a while for the consumer-facing part of the
industry to dig itself out of that hole.  In the meantime, we can expect
silent data corruption, bad wear leveling, and power failure corruption
to be part of the default feature set.

> > > In the most prolific snapshotting case, I had two subvolumes, each
> > > with 20 snapshots (at most). I used default ssd mount option for the
> > > sdcards, most recently ssd_spread with the usb sticks. And now nossd
> > > with the most recent USB stick I just started to use.
> >
> > The number of snapshots doesn't really matter:  you get the up-to-300x
> > write multiple from writing to a subvol that has shared metadata pages,
> > which happens when you have just one snapshot.  It doesn't matter if
> > you have 1 snapshot or 10000 (at least, not for _this_ reason).
>=20
> Gotcha. So I wonder if the cheap consumer USB/SD card use case,
> Raspberry Pi and such, rootfs or general purpose use, should use a
> 4KiB node instead of default 16KiB? I read on HN someone using much
> much more expensive industrial SD cards and this problem  has entirely
> vanished for them (Pi use case). I've looked around and they are a lot
> smaller and more expensive but for a Pi rootfs it's pretty sane
> really, USD$56 for a 4G card that won't die every 6 months? They are
> slower too. *shrug*

I run btrfs with dup data and dup metadata on the Pis, with minimized
write workloads (i.e. I turn off all the local log files, sending the
data to other machines or putting it on tmpfs with periodic uploads,
and I use compression to reduce write volume).  I don't use snapshots on
these devices--they do get backups, but they are fine with plain rsync,
given the minimized write workloads.  I haven't tried changing filesystem
parameters like node size.  Dup data doesn't help the SD card last any
longer, but it does keep the device operating long enough to build and
deploy a new SD card.

Samsung is making SD cards with 10-year warranties and a 300 TBW rating
(equivalent, it is specified in units of "hours of HD video").  They are
USD$25 for 128GB, 100MB/s read 90MB/s write.  No idea what they're like
in the field, I start test deployments next week...

=20
>=20
> --=20
> Chris Murphy
>=20

--WChQLJJJfbwij+9x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXhUzKwAKCRCB+YsaVrMb
nGwbAJ966lcaV5FQPPMm7rTxhXv1l3cqXACeKSkbtEMCwj7eFmPIqVDJEEcHCro=
=vWUO
-----END PGP SIGNATURE-----

--WChQLJJJfbwij+9x--
