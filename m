Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45A534AA26
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2019 20:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730269AbfFRSpE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jun 2019 14:45:04 -0400
Received: from frost.carfax.org.uk ([85.119.82.111]:32769 "EHLO
        frost.carfax.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730252AbfFRSpD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jun 2019 14:45:03 -0400
Received: from hrm by frost.carfax.org.uk with local (Exim 4.80)
        (envelope-from <hrm@carfax.org.uk>)
        id 1hdJ6L-0003eG-QC; Tue, 18 Jun 2019 18:45:01 +0000
Date:   Tue, 18 Jun 2019 18:45:01 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     =?iso-8859-1?Q?St=E9phane?= Lesimple <stephane_btrfs@lesimple.fr>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Rebalancing raid1 after adding a device
Message-ID: <20190618184501.GJ21016@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        =?iso-8859-1?Q?St=E9phane?= Lesimple <stephane_btrfs@lesimple.fr>,
        linux-btrfs@vger.kernel.org
References: <16b6bd72bc0.2787.faeb54a6cf393cf366ff7c8c6259040e@lesimple.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ONvqYzh+7ST5RsLk"
Content-Disposition: inline
In-Reply-To: <16b6bd72bc0.2787.faeb54a6cf393cf366ff7c8c6259040e@lesimple.fr>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--ONvqYzh+7ST5RsLk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2019 at 08:26:32PM +0200, St=E9phane Lesimple wrote:
> I've been a btrfs user for quite a number of years now, but it seems
> I need the wiseness of the btrfs gurus on this one!
>=20
> I have a 5-hdd btrfs raid1 setup with 4x3T+1x10T drives.
> A few days ago, I replaced one of the 3T by a new 10T, running btrfs
> replace and then resizing the FS to use all the available space of
> the new device.
>=20
> The filesystem was 90% full before I expanded it so, as expected,
> most of the space on the new device wasn't actually allocatable in
> raid1, as very few available space was available on the 4 other
> devs.
>=20
> Of course the solution is to run a balance, but as the filesystem is
> now quite big, I'd like to avoid running a full rebalance. This
> would be quite i/o intensive, would be running for several days, and
> putting and unecessary stress on the drives. This also seems
> excessive as in theory only some Tb would need to be moved: if I'm
> correct, only one of two block groups of a sufficient amount of
> chunks to be moved to the new device so that the sum of the amount
> of available space on the 4 preexisting devices would at least equal
> the available space on the new device, ~7Tb instead of moving ~22T.
> I don't need to have a perfectly balanced FS, I just want all the
> space to be allocatable.
>=20
> I tried using the -ddevid option but it only instructs btrfs to work
> on the block groups allocated on said device, as it happens, it
> tends to move data between the 4 preexisting devices and doesn't fix
> my problem. A full balance with -dlimit=3D100 did no better.

   -dlimit=3D100 will only move 100 GiB of data (i.e. 200 GiB), so it'll
be a pretty limited change. You'll need to use a larger number than
that if you want it to have a significant visible effect.

   The -ddevid=3D<old_10T> option would be my recommendation. It's got
more chunks on it, so they're likely to have their copies spread
across the other four devices. This should help with the
balance.

   Alternatively, just do a full balance and then cancel it when the
amount of unallocated space is reasonably well spread across the
devices (specifically, the new device's unallocated space is less than
the sum of the unallocated space on the other devices).

> Is there a way to ask the block group allocator to prefer writing to
> a specific device during a balance? Something like -ddestdevid=3DN?
> This would just be a hint to the allocator and the usual constraints
> would always apply (and prevail over the hint when needed).

   No, there isn't. Having control over the allocator (or bypassing
it) would be pretty difficult to implement, I think.

   It would be really great if there was an ioctl that allowed you to
say things like "take the chunks of this block group and put them on
devices 2, 4 and 5 in RAID-5", because you could do a load of
optimisation with reshaping the FS in userspace with that. But I
suspect it's a long way down the list of things to do.

> Or is there any obvious solution I'm completely missing?

   I don't think so.

   Hugo.

--=20
Hugo Mills             | Great films about cricket: Umpire of the Rising Sun
hugo@... carfax.org.uk |
http://carfax.org.uk/  |
PGP: E2AB1DE4          |

--ONvqYzh+7ST5RsLk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJdCTEtAAoJEFheFHXiqx3kCFIQAIyQqHOqMvYo8YdmmxR4DRF3
MS2g6dm+nBvAZ5KerHsK/ViOUKRtWx/9ipWHB87OBbWQq+sdMtVK/k+lSGryPh1e
onEAbEmq0YzFqwTWwNNiWOaUHnSKwDaaSnkfij6dnUl3GK2R5DrNwWGsf3RLkpVd
Ru2TDXaeODbQVy6mBCf7/1PxWXoMASd0c3zsne/uoVQeJ4Fbc5fMyxAQQ/eIDwj0
4pSihFv47jpkT3PmUQfIwd/GeQuD6G1sQlF4lsbK/KYoOqS7eyPOI5YlLMyMV6vX
zgLBgx+5Aievhzwhld+niBHOfJiKU0a2EySTFlYJ5dwXHgIZKLh801NrVS+6cJbz
4w74bfAEvQopHOalf8sTxGVuKHjXs4dU+J5CgbTTBIpxP32iac6aHf86WpQtNKzY
AkjVuFe8zx202u5WFCbReTq5H1M4k6IQ8PzvuMsdAU7edmU62nZym1XlB21zzYr0
BRZUi8/tK9RLVSfxHaLqMqc2euV6dOnOOVz8ZyjHvsKlQwna4ifYOtyJrUuLbwbc
QlqPYE2y3WlCua6DYynrG4DDsQRXNMihQXStfnw8Lf0sO1izmvF6md8XkmleIQ8u
CrkD1sHCrv504q86rsrNFCiEkSiUHtYiVR6Om0q5X6yoZn7ODkoFtnTL3PS3CM+1
9ApgPbXblPywkxT5GhSB
=sVOU
-----END PGP SIGNATURE-----

--ONvqYzh+7ST5RsLk--
