Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95C57113A13
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 03:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbfLECul (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Dec 2019 21:50:41 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:44440 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbfLECul (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Dec 2019 21:50:41 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 9390A50D76B; Wed,  4 Dec 2019 21:50:40 -0500 (EST)
Date:   Wed, 4 Dec 2019 21:50:40 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Christian =?iso-8859-1?Q?H=F6ppner?= <chris@mkaito.net>,
        linux-btrfs@vger.kernel.org
Subject: Re: False alert: read time tree block corruption
Message-ID: <20191205025040.GX22121@hungrycats.org>
References: <BYWL23M0PMTD.134Q4QBKEGA96@cryptbreaker>
 <6c2d09ca-1483-cd82-c906-e30731baa39f@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IB2Qao3B4XdnqHmg"
Content-Disposition: inline
In-Reply-To: <6c2d09ca-1483-cd82-c906-e30731baa39f@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--IB2Qao3B4XdnqHmg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 04, 2019 at 01:32:59PM +0200, Nikolay Borisov wrote:
>=20
>=20
> On 4.12.19 =D0=B3. 13:04 =D1=87., Christian H=C3=B6ppner wrote:
> > Hello,
> >=20
> > I'm writing because the kernel wiki page relating to this error[1] says=
 to
> > write here first.
> >=20
> > I'm (was) running Arch Linux, kernel 5.4.1, btrfs-progs 5.3.1
> >=20
> > Yesterday during usage, the root file system remounted read-only. I was
> > dumb enough to react by rebooting the machine, when I was greeted by the
> > following error:
> >=20
> > [  25.634530] BTRFS critical (device nvme0n1p2): corrupf leaf: block=3D=
810145234944...
>=20
> How come you omitted exactly the most useful error that could have
> pointed at the problem ? If the data is intact on-disk and the leaf
> checker triggered this means you likely have faulty ram.

Yesterday on IRC there was a similar case where the metadata in the extent
tree had nonsense generation values, but the rest of the filesystem
was fine.  It was very specific:  only the generation fields in several
extent items (sometimes even consecutive ones!).  Bad RAM is usually much
more chaotic:  different fields are corrupted, and some or all of them
will cause a more visible failure than mere mismatched transid.

	https://pastebin.com/raw/GemSDdin

Also it turned out that the filesystem was made in 2014.  Maybe there was
an old kernel bug that was putting garbage in extent generation numbers,
and this is the last remnant of it.

If such a bug was known in 2014, it might explain why btrfs doesn't seem
to detect it today.  btrfs check, read, and delete all said nothing
about the mismatched gen field.  I'd expect at least check and delete
to notice the gen field mismatch--after all, they are inspecting or
manipulating the extent item and the extent data reference already,
so there's no significant performance loss compared to not doing the
check at the same time.

> > [  25.634793] BTRFS error (device nvme0n1p2): block=3D810145234944 read=
 time tree block corruption detected
> > [  25.634961] BTRFS error (device nvme0n1p2): in __btrfs_free_extent:30=
80: errno=3D-5 IO failure
> > [  25.635042] BTRFS error (device nvme0n1p2): in btrfs_run_delayed_refs=
:2188: errno=3D-5 IO failure
> > [  34.653440] systemd-journald[483]: Failed to torate /var/log/journal/=
8f7037b10bbd4f25aadd3d19105ef920/system.journal
> >=20
> > After booting to live media, I checked SMART, badblocks, `btrfs check
> > --readonly` and `btrfs scrub`. All came back clean. I conclude that this
> > is a false positive, and have downgraded the kernel to 5.3.13 as a
> > workaround.
> >=20
> > How can I provide more information to help?
> >=20
> > [1]: https://btrfs.wiki.kernel.org/index.php/Tree-checker#How_to_handle=
_such_error
> >=20

--IB2Qao3B4XdnqHmg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXehwgAAKCRCB+YsaVrMb
nBUAAJ4wPiOuacmdSmxxUyEjBKBddUmRBACcDZQpi6JmeATK1Ew8WSmRU6jmP7Q=
=TfwC
-----END PGP SIGNATURE-----

--IB2Qao3B4XdnqHmg--
