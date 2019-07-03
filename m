Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C45585DD78
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2019 06:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbfGCEcy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jul 2019 00:32:54 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:33184 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725807AbfGCEcy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Jul 2019 00:32:54 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id AC40A373297; Wed,  3 Jul 2019 00:32:53 -0400 (EDT)
Date:   Wed, 3 Jul 2019 00:32:53 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Spurious "ghost" "parent transid verify failed" messages on
 5.0.21 - with call traces
Message-ID: <20190703043253.GI11831@hungrycats.org>
References: <20190312040024.GI9995@hungrycats.org>
 <20190403144716.GA15312@hungrycats.org>
 <20190701033925.GH11831@hungrycats.org>
 <eb60e397-6e33-b73c-e845-a4498952601d@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gJNQRAHI5jiYqw2y"
Content-Disposition: inline
In-Reply-To: <eb60e397-6e33-b73c-e845-a4498952601d@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--gJNQRAHI5jiYqw2y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 01, 2019 at 01:56:08PM +0800, Qu Wenruo wrote:
>=20
>=20
> On 2019/7/1 =E4=B8=8A=E5=8D=8811:39, Zygo Blaxell wrote:
> > On Wed, Apr 03, 2019 at 10:47:16AM -0400, Zygo Blaxell wrote:
> >> On Tue, Mar 12, 2019 at 12:00:25AM -0400, Zygo Blaxell wrote:
> >>> On 4.14.x and 4.20.14 kernels (probably all the ones in between too,
> >>> but I haven't tested those), I get what I call "ghost parent transid
> >>> verify failed" errors.  Here's an unedited recent example from dmesg:
> >>>
> >>> 	[16180.649285] BTRFS error (device dm-3): parent transid verify fail=
ed on 1218181971968 wanted 9698 found 9744
> >>
> >> These happen much less often on 5.0.x, but they still happen from time
> >> to time.
> >=20
> > I put this patch in 5.0.21:
> >=20
> > 	commit 5abbed1af5570f1317f31736e3862e8b7df1ca8b
> > 	Author: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
> > 	Date:   Sat May 18 17:48:59 2019 -0400
> >=20
> > 	    btrfs: get a call trace when we hit ghost parent transid verify fa=
ilures
> >=20
> > 	diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > 	index 6fe9197f6ee4..ed961d2915a1 100644
> > 	--- a/fs/btrfs/disk-io.c
> > 	+++ b/fs/btrfs/disk-io.c
> > 	@@ -356,6 +356,7 @@ static int verify_parent_transid(struct extent_io_=
tree *io_tree,
> > 			"parent transid verify failed on %llu wanted %llu found %llu",
> > 				eb->start,
> > 				parent_transid, btrfs_header_generation(eb));
> > 	+               WARN_ON(1);
> > 		ret =3D 1;
> > 	=20
> > 		/*
> >=20
> > and eventually (six weeks later!) got another reproduction of this bug
> > on 5.0.21:
> >=20
> [snip]
> >=20
> > which confirms the event comes from the LOGICAL_INO ioctl, at least.
> > I had suspected that before based on timing and event log correlations,
> > but now I have stack traces.
> >=20
> > It looks like insufficient locking, i.e. the eb got modified while
> > LOGICAL_INO was looking at it.
>=20
> For this case, a quick dirty fix would be try to joining a transaction
> (if the fs is not RO) and hold the trans handler to block current
> transaction from being committed.

Do you mean, revert "bfc61c36260c Btrfs: do not start a transaction at
iterate_extent_inodes()"?  Or something else?

I've had the spurious parent transid verify failures since at least 4.14,
years before that patch.

> This is definitely going to impact performance but at least should avoid
> such transid mismatch call.
>=20
> In theory it should also affect any backref lookup not protected, like
> subvolume aware defrag.
>=20
> Thanks,
> Qu
>=20
> >=20
> > As usual for the "ghost" parent transid verify failure, there's no
> > persistent failure, no error reported to applications, and error counts
> > in 'btrfs dev stats' are not incremented.
> >=20
>=20




--gJNQRAHI5jiYqw2y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXRwv8gAKCRCB+YsaVrMb
nEI9AJ94PJw1M3pNEGMuMFu+mTn2qgsPsQCeIKRBj5k9srJqEjrWrffm/zjfo3Q=
=+aXD
-----END PGP SIGNATURE-----

--gJNQRAHI5jiYqw2y--
