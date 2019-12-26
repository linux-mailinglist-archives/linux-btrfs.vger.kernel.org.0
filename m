Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE82312AA68
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Dec 2019 06:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbfLZFk7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Dec 2019 00:40:59 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:40814 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfLZFk7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Dec 2019 00:40:59 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id BDA7F5410C7; Thu, 26 Dec 2019 00:40:58 -0500 (EST)
Date:   Thu, 26 Dec 2019 00:40:58 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Martin <mbakiev@gmail.com>, linux-btrfs@vger.kernel.org
Subject: Re: Deleting a failing drive from RAID6 fails
Message-ID: <20191226054058.GC13306@hungrycats.org>
References: <CAHs_hg00v9zmMAXp7E=7Xe_ZD5kgB2tVBOFCt5UQuJRp+yESAg@mail.gmail.com>
 <3826413f-f81d-de13-8437-4e5b762d812f@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="JWEK1jqKZ6MHAcjA"
Content-Disposition: inline
In-Reply-To: <3826413f-f81d-de13-8437-4e5b762d812f@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--JWEK1jqKZ6MHAcjA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 26, 2019 at 01:03:47PM +0800, Qu Wenruo wrote:
>=20
>=20
> On 2019/12/26 =E4=B8=8A=E5=8D=883:25, Martin wrote:
> > Hi,
> >=20
> > I have a drive that started failing (uncorrectable errors & lots of
> > relocated sectors) in a RAID6 (12 device/70TB total with 30TB of
> > data), btrfs scrub started showing corrected errors as well (seemingly
> > no big deal since its RAID6). I decided to remove the drive from the
> > array with:
> >     btrfs device delete /dev/sdg /mount_point
> >=20
> > After about 20 hours and having rebalanced 90% of the data off the
> > drive, the operation failed with an I/O error. dmesg was showing csum
> > errors:
> >     BTRFS warning (device sdf): csum failed root -9 ino 2526 off
> > 10673848320 csum 0x8941f998 expected csum 0x253c8e4b mirror 2
> >     BTRFS warning (device sdf): csum failed root -9 ino 2526 off
> > 10673852416 csum 0x8941f998 expected csum 0x8a9a53fe mirror 2
> >     . . .
>=20
> This means some data reloc tree had csum mismatch.
> The strange part is, we shouldn't hit csum error here, as if it's some
> data corrupted, it should report csum error at read time, other than
> reporting the error at this timing.
>=20
> This looks like something reported before.
>=20
> >=20
> > I pulled the drive out of the system and attempted the device deletion
> > again, but getting the same error.
> >=20
> > Looking back through the logs to the previous scrubs, it showed the
> > file paths where errors were detected, so I deleted those files, and
> > tried removing the failing drive again. It moved along some more. Now
> > its down to only 13GiB of data remaining on the missing drive. Is
> > there any way to track the above errors to specific files so I can
> > delete them and finish the removal. Is there is a better way to finish
> > the device deletion?
>=20
> As the message shows, it's the data reloc tree, which store the newly
> relocated data.
> So it doesn't contain the file path.
>=20
> >=20
> > Scrubbing with the device missing just racks up uncorrectable errors
> > right off the bat, so it seemingly doesn't like missing a device - I
> > assume it's not actually doing anything useful, right?
>=20
> Which kernel are you using?
>=20
> IIRC older kernel doesn't retry all possible device combinations, thus
> it can report uncorrectable errors even if it should be correctable.

> Another possible cause is write-hole, which reduced the tolerance of
> RAID6 stripes by stripes.

Did you find a fix for

	https://www.spinics.net/lists/linux-btrfs/msg94634.html

If that bug is happening in this case, it can abort a device delete
on raid5/6 due to corrupted data every few block groups.

> You can also try replace the missing device.
> In that case, it doesn't go through the regular relocation path, but dev
> replace path (more like scrub), but you need physical access then.
>=20
> Thanks,
> Qu
>=20
> >=20
> > I'm currently traveling and away from the system physically. Is there
> > any way to complete the device removal without reconnecting the
> > failing drive? Otherwise, I'll have a replacement drive in a couple of
> > weeks when I'm back, and can try anything involving reconnecting the
> > drive.
> >=20
> > Thanks,
> > Martin
> >=20
>=20




--JWEK1jqKZ6MHAcjA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXgRH6AAKCRCB+YsaVrMb
nCc0AKDnU2v45v0UuM25GiPOuRxPc5AGowCdERyOrXi8/jpucCkyuI+dEUKczVM=
=BeQJ
-----END PGP SIGNATURE-----

--JWEK1jqKZ6MHAcjA--
