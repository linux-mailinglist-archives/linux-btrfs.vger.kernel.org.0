Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6E1612E107
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 00:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgAAXi5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jan 2020 18:38:57 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:34252 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbgAAXi5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jan 2020 18:38:57 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id A9E33553D16; Wed,  1 Jan 2020 18:38:56 -0500 (EST)
Date:   Wed, 1 Jan 2020 18:38:56 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     =?iso-8859-1?Q?Sw=E2mi?= Petaramesh <swami@petaramesh.org>
Cc:     Ole Langbehn <neurolabs.de@gmail.com>, linux-btrfs@vger.kernel.org
Subject: Re: repeated enospc errors during balance on a filesystem with spare
 room - pls advise
Message-ID: <20200101233856.GJ13306@hungrycats.org>
References: <495cfb98-7afd-a36d-151b-d7cc58f1d352@gmail.com>
 <7461874b-dc8d-4939-c4ae-fbab486750b3@gmail.com>
 <20191231225848.GI13306@hungrycats.org>
 <015942c2-1bf8-00a5-5091-f967c7db999d@petaramesh.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="iRjOs3ViPWHdlw/I"
Content-Disposition: inline
In-Reply-To: <015942c2-1bf8-00a5-5091-f967c7db999d@petaramesh.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--iRjOs3ViPWHdlw/I
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 01, 2020 at 11:05:00AM +0100, Sw=E2mi Petaramesh wrote:
> Hi list,
>=20
> Le 31/12/2019 =E0 23:58, Zygo Blaxell a =E9crit=A0:
> > A full balance includes a metadata balance.  The primary effect
> > of metadata balance is to temporarily reduce space for metadata.
> > Reducing metadata space causes an assortment of problems for btrfs,
> > only one of which is hitting the 5.4 free space bug.  For all but a few
> > contrived test cases, btrfs manages metadata well without interference
> > from balance.  Too much metadata balancing (i.e. any at all) can make
> > a filesystem truly run out of metadata space on disk--a condition that
> > is sometimes difficult to reverse.
>=20
> I however was hit by the "dummy zero free space condition" using 5.4 on
> a machine, and the resulting filesystem (on an external HD) then still
> showed 0% free using a 5.3 or a 4.15 kernel on other machines.

Interesting...so 5.4 can put the filesystem into a _persistent_ state
where the metadata allocator makes no further progress.  Two bugs in one!

I do note from the git history that metadata free space calculations
seem to have been dodgy for years.  The code that is touched from the
5.4 kernel bug fix patch dates back to v4.5, so probably all kernels
newer than 2015 have some metadata allocation bugs (kernels up to 4.4
would hit ENOSPC while reporting non-zero free space reported in df,
kernels 4.5 and later report zero free space in df first, then ENOSPC).
5.4 has other changes that make these problems more frequent, but these
are not new bugs.

The longer patch series Qu mentioned looks like it's trying to properly
solve the problem instead of using a quick guesstimate.

> It however passsed "btrfs check" without any error.

Not surprising.  "btrfs check" cannot detect kernel bugs.

"btrfs check" is concerned with on-disk data, while free space
calculations only exist in kernel memory structures.  btrfs check verifies
the metadata is correct, but check can't tell you if the kernel will read
the metadata and then just return the wrong free space number.

> The thing that fixed it and returned it to a =AB normal working state =BB
> has been running a "btrfs balance -m" (on the 5.4 machine) on it.
>=20
> So I'm a bit puzzled reading that metadata balance is useless when it
> precisely fixed this issue on a FS here.

The kernel bug is triggered under very specific conditions.  Almost any
change to the filesystem could change those conditions to temporarily work
around the kernel bug.  Metadata balance is a change to the filesystem,
so sometimes it works--but it can also trigger the problem in a filesystem
that didn't have the problem before.

Other things that randomly allocate metadata, and might by chance
temporarily fix this problem without the bad side-effects of metadata
balances:

	- metadata defrag (btrfs fi defrag on a subvol without -r)

	- metadata modifications (deleting or touching files,
	creating and deleting empty directories)

	- running a data balance (allocates a lot of metadata)

	- using the metadata_ratio mount option

For 5 years our regression tests have been running on filesystems
that never run metadata balances.  We don't run metadata balances in
the test workloads or in production because 1) in production we never
have a requirement to balance metadata on any workload except for raid
conversions, and 2) balancing metadata is a pretty reliable reproducer
for the correct, non-bug metadata ENOSPC condition that a btrfs gets
into when it runs out of both metadata and unallocated space.  This is
especially bad on filesystems with less than ~250GB of free space, where
rounding to GB-sized block groups and free space fragmentation in data
block groups combine to make it very important to have a lot of slack
in metadata block groups.

We've probably been avoiding all the false-zero-free-space conditions
in kernels 4.5+ accidentally, simply as a side-effect of never running a
metadata balance.  To reproduce the 5.4 issue, I had to set up a custom
test workload which did metadata balances to force the bug to happen.

> Kind regards (and best wishes for a happy new year).
>=20
>=20

--iRjOs3ViPWHdlw/I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXg0tjQAKCRCB+YsaVrMb
nOzuAKCEKbcBXL7F8ymtMQX0pmACYMBZkgCeLWAHRsdTpGORS9T+6STUX7v0Ptg=
=92jV
-----END PGP SIGNATURE-----

--iRjOs3ViPWHdlw/I--
