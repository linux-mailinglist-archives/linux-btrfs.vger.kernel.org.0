Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8B0814E71F
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 03:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgAaCYH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 21:24:07 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:46848 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgAaCYH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 21:24:07 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id B98AC59C41A; Thu, 30 Jan 2020 21:24:05 -0500 (EST)
Date:   Thu, 30 Jan 2020 21:23:58 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: statfs: Don't reset f_bavail if we're over
 committing metadata space
Message-ID: <20200131022358.GQ13306@hungrycats.org>
References: <20200115034128.32889-1-wqu@suse.com>
 <20200116142928.GX3929@twin.jikos.cz>
 <40ff2d8d-eb3b-1c90-ea19-618e5c058bcc@gmx.com>
 <20200117140231.GF3929@twin.jikos.cz>
 <f1f1a2ab-ed09-d841-6a93-a44a8fb2312f@gmx.com>
 <20200129160147.GI3929@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ngPZezdD7QsvFaqQ"
Content-Disposition: inline
In-Reply-To: <20200129160147.GI3929@twin.jikos.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--ngPZezdD7QsvFaqQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2020 at 05:01:47PM +0100, David Sterba wrote:
> On Fri, Jan 17, 2020 at 10:16:45PM +0800, Qu Wenruo wrote:
> > >> But this behavior itself is not accurate.
> > >>
> > >> We have global reservation, which is normally always larger than the
> > >> immediate number 4M.
> > >=20
> > > The global block reserve is subtracted from the metadata accounted fr=
om
> > > the block groups. And after that, if there's only little space left, =
the
> > > check triggers. Because at this point any new metadata reservation
> > > cannot be satisfied from the remaining space, yet there's >0 reported.
> >=20
> > OK, then we need to do over-commit calculation here, and do the 4M
> > calculation.
> >=20
> > The quick solution I can think of would go back to Josef's solution by
> > exporting can_overcommit() to do the calculation.
> >=20
> >=20
> > But my biggest problem is, do we really need to do all these hassle?
>=20
> As far as I know we did not ask for it, it's caused by limitations of
> the public interfaces (statfs).

We don't use half of the existing public interface (the f_files side).

Conflating data with metadata isn't helpful:  they need very different
remedial actions when you run out of each.  This is true even on other
filesystems, though other filesystems don't have remedial actions as
extremely different as "deleting files" and "btrfs data balance."

> > My argument is, other fs like ext4/xfs still has their inode number
> > limits, and they don't report 0 avail when  that get exhausted.
> > (Although statfs() has such report mechanism for them though).
>=20
> Maybe that's also the perception of what "space" is for users. The data
> and metadata distinction is an implementation detail. So if 'df' tells
> me there's space I should be able to create new files, right?=20

Not necessarily.  Someone else might allocate data between statfs check
and the write.  The new file's name may overflow existing directory
blocks and trigger a data block allocation (on filesystems that have
directory data blocks).  The filesystem might be out of inodes, if it's
a filesystem with static inode allocation.  Also recall that 'df' has the
'-i' option, so df does give you two numbers for space, and it has two
opportunities to tell you that you don't have any.

Seeing "72KB data blocks free" is not a guarantee that you can write
exactly 72KB of data.  It's an estimate that you can write _about_
72KB of data.  Some difference between the estimated free space and the
actual number of data blocks that can be written is expected, especially
when the filesystem is nearly full or has multiple agents writing to it
(and then there's compression, snapshots, dedupe, unreachable overwritten
extent blocks...).

We expect certainty when comparing numbers that are very different.
The closer you get to the reported number, the less certain we can be
about whether an ENOSPC will occur before you write that amount of data.
Examples: If you have 72K free in df, you _definitely_ can't install
that package that requires 860MB of space, but you probably can write
just one more 4K block to a log.  Maybe you can install a 60KB package
but not a 68KB one.  Users (and the robots they configure) can usually
cope with derating the numbers a little.

The recent problem in 5.4+ kernels is that this difference is now often
far too large--thousands of gigabytes, because btrfs flips from counting
"all the free data blocks in existing and future data block groups" to
"zero" at arbitrary times.  This is *much worse* than the nearly-full
case, where the correct and reported (zero) numbers are within a few GB
of each other.  The large errors in statfs reporting and large changes
in reported value result in large consequences--automated deletion of
data is the most serious one, where the bigger the error, the more data
is unnecessarily deleted.

The case where a filesystem runs out of unallocated space, has several
thousand GB of unused space in data block groups, and runs out of metadata
space is...tricky, because you correctly hit ENOSPC with thousands of GB
of free space on the drive, but it's not in a form btrfs can use because
it's all in data block groups.  The usual automated responses triggered
on statfs() reports of low data space don't work here.  Data balances are
required to free up space for metadata.  'unlink' or 'btrfs sub delete'
usually don't help in these cases, or help extremely inefficiently
(i.e. the kernel won't free data block groups until they're entirely
empty, so it's not sufficient to delete a few files--you have to delete
almost _all_ of the files).  'unlink' can even make the problem worse
(duplicating shared metadata pages, consuming even more metadata space).
The arbitrary reporting of "0 available data blocks" in df isn't helpful
in this case because the ENOSPC has nothing at all to do with data blocks.

One could say "well if we're out of metadata space and have free data
blocks, the correct thing to do is block writers and start balancing,
so that a free block is a free block."  There are obvious problems
with that, but it would make sense to consider reducing data blocks and
metadata free space to a single number in df only *after* they were made
transparently fungible.

> more data, but still looking at the same number of free space.
>=20
> For ext2 or ext3 it should be easier to see if it's possible to create
> new inodes, the values of 'df -i' are likely accurate because of the
> mkfs-time preallocation.

> Newer features on ext4 and xfs allow dynamic creation of inodes, you can
> find guesswork regarding the f_files estimates.
>=20
> I vaguely remember that it's possible to get ENOSPC on ext4 by
> exhausting metadata yet statfs will still tell you there's free space.

Yes, if you run out of f_favail on a traditional Unix filesystem, you
can't make any more inodes, but you can still write all the data blocks
to existing files you want (until f_bavail runs out).  Other filesystems
do _not_ set f_bavail to 0 when f_favail happens to be 0 too.

Also, on a traditional Unix filesystem, you can overwrite, truncate
(shrink, maybe not expand) or delete any files you want, no matter
what df says.  On btrfs those things are not all always possible, and
sometimes have a negative effect on free space.

> This is confusing too.

statfs on btrfs will tell you that you have free blocks (f_bavail),
but not free files.  Many users have never heard of f_favail because
some filesystems (including btrfs) don't implement it, and on the others
f_favail changes very slowly and rarely hits zero for typical workloads
when compared to f_bavail.

That said, f_favail is an ideal way to report to users that they are
running out of some scarce resource that isn't data blocks.  Thankfully
btrfs only has two kinds of scarce resource (for now), so we can still
use the statvfs structure.

On btrfs we could overload f_f{avail,free,iles} to count metadata
blocks (metadata_allocated - metadata_used + (all_unallocated /
raid_profile_parameters) - metadata_reserved).  That would provide
a number that proportionally decreases to zero as all options for
allocating new metadata blocks are exhausted.  When ENOSPC occurs,
either f_favail or f_bavail will end up being zero[1], no questionable
hacks required.  Automated low space responders will be able to apply
the correct proportional response (delete files/snapshots or balance
data for low data and metadata space, respectively) by looking at which
value is zero.

TBH I think the code change content of Qu's patch was fine as-is:
it mostly reverts ca8a51b3a9 "btrfs: statfs: report zero available if
metadata are exhausted", and I think that should be reverted regardless
of the other issues, simply and only because it conflates data blocks
with metadata.  It's reporting values in the wrong columns, so confusion
is (and bugs are) inevitable.


[1] If f_{b,f}avail ends up being below 0, make it 0.  Nothing is more
confusing or has less predictable effects than reports of negative free
disk space.

--ngPZezdD7QsvFaqQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXjOPuwAKCRCB+YsaVrMb
nF+DAJ9x7YIU+Sg3IHjlmu4N7BoePqe9oQCgo4S0JrRxguZrRKsqxvpFFE+/PWY=
=itXf
-----END PGP SIGNATURE-----

--ngPZezdD7QsvFaqQ--
