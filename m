Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3D5F59CD
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2019 22:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731286AbfKHVYU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Nov 2019 16:24:20 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:42866 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfKHVYU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Nov 2019 16:24:20 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 0CB4E4C101C; Fri,  8 Nov 2019 16:23:44 -0500 (EST)
Date:   Fri, 8 Nov 2019 16:23:44 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Odin Hultgren van der Horst <odin@digitalgarden.no>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Extent to files
Message-ID: <20191108212343.GQ22121@hungrycats.org>
References: <20191104113519.htdigcg6lzbes6v7@T580.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0/kgSOzhNoDC5T3a"
Content-Disposition: inline
In-Reply-To: <20191104113519.htdigcg6lzbes6v7@T580.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--0/kgSOzhNoDC5T3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 04, 2019 at 12:35:19PM +0100, Odin Hultgren van der Horst wrote:
> I did a ioctl(FICLONE) IOCTL-FICLONERANGE(2) at some point later I want t=
o be
> able to check if the new file still shares all its physical storage with =
just
> knowing the name of the new file.

"Shares all its physical storage" is not very specific.  You could run
'filefrag -v' and count extents with and without the "shared" flag.
If either number is 0, the file is all-unique or all-shared.

If the extents are marked shared, filefrag doesn't tell you what is doing
the sharing.  A file can, and often does, share extents with itself.
e.g. you write a 1MB extent, then write 4K in the middle, now you have
two smaller references to the 1MB extent separated by the 4K in the
middle.  Having two references will set the "shared" bit in FIEMAP
even though all references are in the same file.

> I found some people suggesting to compare the files extents.
>=20
> But the implementation I looked at knew both files used in the comparison,
> so I was wondering if there a way to get all files that references a exte=
nt
> in user space?

Use TREE_SEARCH_V2 and the subvol and inode numbers of the target file
to read the file's EXTENT_ITEM metadata to get all the extent bytenrs
in a file.  You need the raw extent bytenr ("physical") field from each
extent metadata item in the file.

You can use 'btrfs ins dump-tree' to see the metadata in the filesystem,
and as an example of how to decode the various metadata objects.  I used
'btrfs sub find-new' as an example for walking the metadata trees with
TREE_SEARCH_V2.

Use the LOGICAL_INO_V2 ioctl with the extent bytenrs obtained from
TREE_SEARCH_V2 to discover the (subvol, ino, offset) tuples referencing
each extent.  'btrfs ins logical' does this with LOGICAL_INO v1.  You want
to use the V2 BTRFS_LOGICAL_INO_ARGS_IGNORE_OFFSET flag so you get all
the referencing extent items (V1 requires repeating the call for every
block in the extent, V2 gets all references at once).

Use 'btrfs ins subvolid-resolve' to map subvol IDs to paths in the
filesystem.  You will need to open these paths to use INO_TO_PATHS.

Use INO_TO_PATHS ioctl to convert (subvol_fd, inode) numbers
into filenames.  For the FD argument, use the paths obtained from
'subvolid-resolve'.  This tells you the filename relative to the subvol.
Combine with the subvol's name for the full path of the file.

All of the above require root or CAP_SYS_ADMIN privileges to work.

> In reality I want a count off clones/(identical files) to a given file
> in user space.

Repeat the above for each extent in the target file to build a list of
all extents and what files reference them.

Partial matches between files and extents are possible, so you will
need to decide what to do about them (include in result set, exclude
=66rom result set, diffstat-style output, percentage overlap, make a Venn
diagram, etc).

It's also possible to have two files referring to the same extents in
different orders or at different offsets within the extents, so two
files could share 100% of their space but not be identical.

If you only care about the number of files that have one or more blocks
shared, you can skip some of the steps, i.e. you only need the total
number of unique (subvol, inode) pairs and you can skip the path lookups,
but if you do this, you can't tell if the files are identical, only that
they are at least partly shared.

--0/kgSOzhNoDC5T3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXcXc2gAKCRCB+YsaVrMb
nJi/AJ9inlydZDbPtyrj/NCvpUyGLkjvZQCfdR5QY9tLC4kGc/vRSHik+mAC9EI=
=KDXj
-----END PGP SIGNATURE-----

--0/kgSOzhNoDC5T3a--
