Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C073412DC37
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Dec 2019 23:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfLaW6u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Dec 2019 17:58:50 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:44228 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfLaW6u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Dec 2019 17:58:50 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id BACD855246B; Tue, 31 Dec 2019 17:58:48 -0500 (EST)
Date:   Tue, 31 Dec 2019 17:58:48 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Ole Langbehn <neurolabs.de@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: repeated enospc errors during balance on a filesystem with spare
 room - pls advise
Message-ID: <20191231225848.GI13306@hungrycats.org>
References: <495cfb98-7afd-a36d-151b-d7cc58f1d352@gmail.com>
 <7461874b-dc8d-4939-c4ae-fbab486750b3@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IbA9xpzOQlG26JSn"
Content-Disposition: inline
In-Reply-To: <7461874b-dc8d-4939-c4ae-fbab486750b3@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--IbA9xpzOQlG26JSn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 31, 2019 at 04:10:40PM +0100, Ole Langbehn wrote:
> Excuse me for adding more information in a second mail:
>=20
> # uname -a
> Linux leo 5.4.6-gentoo #1 SMP PREEMPT Sun Dec 22 10:27:05 CET 2019

That is the most likely problem.  A fix for 5.4's zero-free-space issue
is still being reviewed on the mailing list.

On btrfs you can run out of space as often as you like, it won't hurt
data on the filesystem.  A lot of applications are not so robust, though,
so you may encounter problems with embedded databases and configuration
data.  The current 5.4 bug just makes the kernel think there is 0 free
space, it has nothing to do with the filesystem on disk.

Two workarounds:

	- use 5.3.18 instead of 5.4.6

	- use the 'metadata_ratio=3D1' mount option after balancing a few
	data block groups

In your other mail you indicated you were running a full balance.  Full
balances are never useful(*) and will make this specific situation worse.

A full balance includes a metadata balance.  The primary effect
of metadata balance is to temporarily reduce space for metadata.
Reducing metadata space causes an assortment of problems for btrfs,
only one of which is hitting the 5.4 free space bug.  For all but a few
contrived test cases, btrfs manages metadata well without interference
=66rom balance.  Too much metadata balancing (i.e. any at all) can make
a filesystem truly run out of metadata space on disk--a condition that
is sometimes difficult to reverse.

You should run data balances to temporarily reduce space available
for data.  This will allow btrfs to use more space for metadata,
which will avoid the bad things that happen when metadata runs out.
This will also compact free space areas into large contiguous areas for
future data allocations, which will improve fragmentation and may make
the filesystem run a little faster.

In your specific case, you probably have to do the first few block groups
of data balance on a 5.3 kernel until you have enough unallocated space
to make new metadata block groups.

Going forward, run something like 'btrfs balance start -dlimit=3D9' every
day (adjust the limit upwards if you write more than 10GB of data per
day, downwards if you write less).  Or use 'btrfs fi usage' and make
sure that the 'unallocated' space stays above a few GB at all times,
and run data balance with larger limits if it's not.

(*) A full balance contains a metadata balance, and you should never
balance metadata except to convert from one RAID profile to another.
Older kernels have bugs that lead to overallocation of metadata, but it
is better to upgrade than to continue using the old kernels with metadata
balances.  There are some obscure corner test cases where a metadata
balance is useful, but users will not encounter these by accident.

> x86_64 Intel(R) Core(TM) i7-8850H CPU @ 2.60GHz GenuineIntel GNU/Linux
>=20
> # btrfs --version
> btrfs-progs v5.4
>=20




--IbA9xpzOQlG26JSn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXgvSpAAKCRCB+YsaVrMb
nM27AJsFvaJlRQ589jfHJGQ0AaNo37UYyQCeOsbsmyYb+lpkdTZ99B3zQ8gw5TI=
=ytOh
-----END PGP SIGNATURE-----

--IbA9xpzOQlG26JSn--
