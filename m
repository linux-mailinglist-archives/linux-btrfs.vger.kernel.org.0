Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8008C154F6A
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 00:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgBFXki (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 18:40:38 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:37754 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgBFXki (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Feb 2020 18:40:38 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 4445E5B00E5; Thu,  6 Feb 2020 18:40:37 -0500 (EST)
Date:   Thu, 6 Feb 2020 18:40:37 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     linux-btrfs@vger.kernel.org
Subject: Re: RAID5 fails to correct correctable errors, makes them
 uncorrectable instead (sometimes).  With reproducer for kernel 5.3.11, still
 works on 5.5.1
Message-ID: <20200206234037.GD13306@hungrycats.org>
References: <20191119040827.GC22121@hungrycats.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xOS8do0ZRfB5pORP"
Content-Disposition: inline
In-Reply-To: <20191119040827.GC22121@hungrycats.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--xOS8do0ZRfB5pORP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2019 at 11:08:27PM -0500, Zygo Blaxell wrote:
> Sometimes, btrfs raid5 not only fails to recover corrupt data with a
> parity stripe, it also copies bad data over good data.  This propagates
> errors between drives and makes a correctable failure uncorrectable.
> Reproducer script at the end.
>=20
> This doesn't happen very often.  The repro script corrupts *every*
> data block on one of the RAID5 drives, and only a handful of blocks
> fail to be corrected--about 16 errors per 3GB of data, but sometimes
> half or double that rate.  It behaves more like a race condition than
> a boundary condition.  It can take a few tries to get a failure with a
> 16GB disk array.  It seems to happen more often on 2-disk raid5 than
> 5-disk raid5, but if you repeat the test enough times even a 5-disk
> raid5 will eventually fail.
>=20
> Kernels 4.16..5.3 all seem to behave similarly, so this is not a new bug.
> I haven't tried this reproducer on kernels earlier than 4.16 due to
> other raid5 issues in earlier kernels.

Still reproducible on 5.5.1.  Some more details below:

> [...snip...]
> Reproducer part 1 (runs in a qemu with test disks on /dev/vdb and /dev/vd=
c):
>=20
> 	#!/bin/bash
> 	set -x
>=20
> 	# Reset state
> 	umount /try
> 	mkdir -p /try
>=20
> 	# Create FS and mount.	Use raid1 metadata so the filesystem
> 	# has a fair chance of survival.
> 	mkfs.btrfs -draid5 -mraid1 -f /dev/vd[bc] || exit 1
> 	btrfs dev scan
> 	mount -onoatime /dev/vdb /try || exit 1
>=20
> 	# Must be on btrfs
> 	cd /try || exit 1
> 	btrfs sub list . || exit 1
>=20
> 	# Fill disk with files.  Increase seq for more test data
> 	# to increase the chance of finding corruption.
> 	for x in $(seq 0 3); do
> 		sync &
> 		rsync -axHSWI "/usr/." "/try/$(date +%s)" &
> 		sleep 2
> 	done
> 	wait
>=20
> 	# Remove half the files.  If you increased seq above, increase the
> 	# '-2' here as well.
> 	find /try/* -maxdepth 0 -type d -print | unsort | head -2 | while read x=
; do
> 		sync &
> 		rm -fr "$x" &
> 		sleep 2
> 	done
> 	wait
>=20
> 	# Fill in some of the holes.  This is to get a good mix of
> 	# partially filled RAID stripes of various sizes.
> 	for x in $(seq 0 1); do
> 		sync &
> 		rsync -axHSWI "/usr/." "/try/$(date +%s)" &
> 		sleep 2
> 	done
> 	wait
>=20
> 	# Calculate hash we will use to verify data later
> 	find -type f -exec sha1sum {} + > /tmp/sha1sums.txt
>=20
> 	# Make sure it's all on the disk
> 	sync
> 	sysctl vm.drop_caches=3D3
>=20
> 	# See distribution of data across drives
> 	btrfs dev usage /try
> 	btrfs fi usage /try
>=20
> 	# Corrupt one byte of each of the first 4G on /dev/vdb,
> 	# so that the crc32c algorithm will always detect the corruption.
> 	# If you need a bigger test disk then increase the '4'.
> 	# Leave the first 16MB of the disk alone so we don't kill the superblock.
> 	perl -MFcntl -e '
> 		for my $x (0..(4 * 1024 * 1024 * 1024 / 4096)) {
> 			my $pos =3D int(rand(4096)) + 16777216 + ($x * 4096);
> 			sysseek(STDIN, $pos, SEEK_SET) or die "seek: $!";
> 			sysread(STDIN, $dat, 1) or die "read: $!";
> 			sysseek(STDOUT, $pos, SEEK_SET) or die "seek: $!";
> 			syswrite(STDOUT, chr(ord($dat) ^ int(rand(255) + 1)), 1) or die "write=
: $!";
> 		}
> 	' </dev/vdb >/dev/vdb
>=20
> 	# Make sure all that's on disk and our caches are empty
> 	sync
> 	sysctl vm.drop_caches=3D3

I split the test into two parts: everything up to the above line (let's
call it part 1), and everything below this line (part 2).  Part 1 creates
a RAID5 array with corruption on one disk.  Part 2 tries to read all the
original data and correct the corrupted disk with sha1sum and btrfs scrub.

I saved a copy of the VM's disk images after part 1, so I could repeatedly
reset and run part 2 on identical filesystem images.

I also split up

	btrfs scrub start -rBd /try

and replaced it with

	btrfs scrub start -rBd /dev/vdb
	btrfs scrub start -rBd /dev/vdc

(and same for the non-read-only scrubs) so the scrub runs sequentially
on each disk, instead of running on both in parallel.

Original part 2:

> 	# Before and after dev stat and read-only scrub to see what the damage l=
ooks like.
> 	# This will produce some ratelimited kernel output.
> 	btrfs dev stat /try | grep -v ' 0$'
> 	btrfs scrub start -rBd /try
> 	btrfs dev stat /try | grep -v ' 0$'
>=20
> 	# Verify all the files are correctly restored transparently by btrfs.
> 	# btrfs repairs correctable blocks as a side-effect.
> 	sha1sum --quiet -c /tmp/sha1sums.txt
>=20
> 	# Do a scrub to clean up stray corrupted blocks (including superblocks)
> 	btrfs dev stat /try | grep -v ' 0$'
> 	btrfs scrub start -Bd /try
> 	btrfs dev stat /try | grep -v ' 0$'
>=20
> 	# This scrub should be clean, but sometimes is not.
> 	btrfs scrub start -Bd /try
> 	btrfs dev stat /try | grep -v ' 0$'
>=20
> 	# Verify that the scrub didn't corrupt anything.
> 	sha1sum --quiet -c /tmp/sha1sums.txt

Multiple runs of part 2 produce different results in scrub:

	result-1581019560.txt:scrub device /dev/vdb (id 1) done
	result-1581019560.txt:Error summary:    super=3D1 csum=3D273977
	result-1581019560.txt:scrub device /dev/vdc (id 2) done
	result-1581019560.txt:Error summary:    read=3D1600744 csum=3D230813
	result-1581019560.txt:[/dev/vdb].corruption_errs  504791

	result-1581029949.txt:scrub device /dev/vdb (id 1) done
	result-1581029949.txt:Error summary:    super=3D1 csum=3D273799
	result-1581029949.txt:scrub device /dev/vdc (id 2) done
	result-1581029949.txt:Error summary:    read=3D1600744 csum=3D230813
	result-1581029949.txt:[/dev/vdb].corruption_errs  504613

With scrub on the filesystem it is no better:

	result-1.txt:scrub device /dev/vdb (id 1) done
	result-1.txt:Error summary:    super=3D1 csum=3D272757
	result-1.txt:scrub device /dev/vdc (id 2) done
	result-1.txt:Error summary:    read=3D1600744 csum=3D230813
	result-1.txt:[/dev/vdb].corruption_errs  503571
	result-2.txt:scrub device /dev/vdb (id 1) done
	result-2.txt:Error summary:    super=3D1 csum=3D273430
	result-2.txt:scrub device /dev/vdc (id 2) done
	result-2.txt:Error summary:    read=3D1600744 csum=3D230813
	result-2.txt:[/dev/vdb].corruption_errs  504244
	result-3.txt:scrub device /dev/vdb (id 1) done
	result-3.txt:Error summary:    super=3D1 csum=3D273456
	result-3.txt:scrub device /dev/vdc (id 2) done
	result-3.txt:Error summary:    read=3D1600744 csum=3D230813
	result-3.txt:[/dev/vdb].corruption_errs  504270

The scrub summaries after the sha1sum -c are different too, although in
this case the errors were all corrected (sha1sum -c is clean):

	result-1.txt:scrub device /dev/vdb (id 1) done
	result-1.txt:Error summary:    csum=3D29911
	result-1.txt:scrub device /dev/vdc (id 2) done
	result-1.txt:Error summary:    csum=3D11
	result-2.txt:scrub device /dev/vdb (id 1) done
	result-2.txt:Error summary:    csum=3D29919
	result-2.txt:scrub device /dev/vdc (id 2) done
	result-2.txt:Error summary:    csum=3D14
	result-3.txt:scrub device /dev/vdb (id 1) done
	result-3.txt:Error summary:    csum=3D29713
	result-3.txt:scrub device /dev/vdc (id 2) done
	result-3.txt:Error summary:    csum=3D9

The error counts on /dev/vdb are different after the sha1sum -c,
indicating that file reads are nondeterministically correcting or not
correcting csum errors on btrfs raid5.  This could be due to readahead
or maybe something else.

The error counts on /dev/vdc are interesting, as that drive is not
corrupted, nor does it have read errors, but it is very consistently
reporting read=3D1600744 csum=3D230813 in scrub output.

--xOS8do0ZRfB5pORP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXjyj8AAKCRCB+YsaVrMb
nAoSAJ9D5lRgqhqbwTrGoGKRmGYj3byB0gCfbRPsy5hegkxaJKp9o17MTpWqMVM=
=XdTr
-----END PGP SIGNATURE-----

--xOS8do0ZRfB5pORP--
