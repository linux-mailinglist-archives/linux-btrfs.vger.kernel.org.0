Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED2C10E4D9
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2019 04:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfLBDXB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Dec 2019 22:23:01 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:33076 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbfLBDXA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 Dec 2019 22:23:00 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id DF771505C14; Sun,  1 Dec 2019 22:22:59 -0500 (EST)
Date:   Sun, 1 Dec 2019 22:22:59 -0500
From:   Zygo Blaxell <zblaxell@furryterror.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: More intelligent degraded chunk allocator
Message-ID: <20191202032259.GN22121@hungrycats.org>
References: <20191107062710.67964-1-wqu@suse.com>
 <20191118201834.GN3001@twin.jikos.cz>
 <f6dfede7-c65c-2321-ab8f-ba16a6a3c71f@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Hch1Uz/zGPcHFdv8"
Content-Disposition: inline
In-Reply-To: <f6dfede7-c65c-2321-ab8f-ba16a6a3c71f@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--Hch1Uz/zGPcHFdv8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2019 at 07:32:26AM +0800, Qu Wenruo wrote:
>=20
>=20
> On 2019/11/19 =E4=B8=8A=E5=8D=884:18, David Sterba wrote:
> > On Thu, Nov 07, 2019 at 02:27:07PM +0800, Qu Wenruo wrote:
> >> This patchset will make btrfs degraded mount more intelligent and
> >> provide more consistent profile keeping function.
> >>
> >> One of the most problematic aspect of degraded mount is, btrfs may
> >> create unwanted profiles.
> >>
> >>  # mkfs.btrfs -f /dev/test/scratch[12] -m raid1 -d raid1
> >>  # wipefs -fa /dev/test/scratch2
> >>  # mount -o degraded /dev/test/scratch1 /mnt/btrfs
> >>  # fallocate -l 1G /mnt/btrfs/foobar
> >>  # btrfs ins dump-tree -t chunk /dev/test/scratch1
> >>         item 7 key (FIRST_CHUNK_TREE CHUNK_ITEM 1674575872) itemoff 15=
511 itemsize 80
> >>                 length 536870912 owner 2 stripe_len 65536 type DATA
> >>  New data chunk will fallback to SINGLE or DUP.
> >>
> >>
> >> The cause is pretty simple, when mounted degraded, missing devices can=
't
> >> be used for chunk allocation.
> >> Thus btrfs has to fall back to SINGLE profile.
> >>
> >> This patchset will make btrfs to consider missing devices as last reso=
rt if
> >> current rw devices can't fulfil the profile request.
> >>
> >> This should provide a good balance between considering all missing
> >> device as RW and completely ruling out missing devices (current mainli=
ne
> >> behavior).
> >=20
> > Thanks. This is going to change the behaviour with a missing device, so
> > the question is if we should make this configurable first and then
> > switch the default.
>=20
> Configurable then switch makes sense for most cases, but for this
> degraded chunk case, IIRC the new behavior is superior in all cases.
>=20
> For 2 devices RAID1 with one missing device (the main concern), old
> behavior will create SINGLE/DUP chunk, which has no tolerance for extra
> missing devices.
>=20
> The new behavior will create degraded RAID1, which still lacks tolerance
> for extra missing devices.
>=20
> The difference is, for degraded chunk, if we have the device back, and
> do proper scrub, then we're completely back to proper RAID1.
> No need to do extra balance/convert, only scrub is needed.

I think you meant to say "replace" instead of "scrub" above.

> So the new behavior is kinda of a super set of old behavior, using the
> new behavior by default should not cause extra concern.

It sounds OK to me, provided that the missing device is going away
permanently, and a new device replaces it.

If the missing device comes back, we end up relying on scrub and 32-bit
CRCs to figure out which disk has correct data, and it will be wrong
1/2^32 of the time.  For nodatasum files there are no CRCs so the data
will be wrong much more often.  This patch doesn't change that, but
maybe another patch should.

> > How does this work with scrub? Eg. if there are 2 devices in RAID1, one
> > goes missing and then scrub is started. It makes no sense to try to
> > repair the missing blocks, but given the logic in the patches all the
> > data will be rewritten, right?
>=20
> Scrub is unchanged at all.
>=20
> Missing device will not go through scrub at all, as scrub is per-device
> based, missing device will be ruled out at very beginning of scrub.
>=20
> Thanks,
> Qu
> >=20
>=20




--Hch1Uz/zGPcHFdv8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXeSDkAAKCRCB+YsaVrMb
nIZ6AKDGnd+vaqPjt9343OkFVmxrxnbIjwCguznCzvLz/EBJNWqBBhWsQEO1Cjk=
=PSP4
-----END PGP SIGNATURE-----

--Hch1Uz/zGPcHFdv8--
