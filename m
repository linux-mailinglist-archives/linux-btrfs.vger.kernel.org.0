Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DADC10A6DC
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2019 00:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfKZXDJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Nov 2019 18:03:09 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:38170 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfKZXDI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Nov 2019 18:03:08 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id E66E74F7108; Tue, 26 Nov 2019 18:03:05 -0500 (EST)
Date:   Tue, 26 Nov 2019 18:02:58 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] Btrfs: send, skip backreference walking for extents with
 many references
Message-ID: <20191126230251.GK22121@hungrycats.org>
References: <20191030122301.25270-1-fdmanana@kernel.org>
 <20191123052741.GJ22121@hungrycats.org>
 <CAL3q7H52LYCnDdFoObCCWjrCQqLOpcPUYeD28pXtET25-ycM9w@mail.gmail.com>
 <20191124013328.GD1046@hungrycats.org>
 <CAL3q7H61mTQ6kFU9ER-F=-9xEXE8uSdpa-FjJpoS61x7kMaEjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4PR/+zdSfVlxyWed"
Content-Disposition: inline
In-Reply-To: <CAL3q7H61mTQ6kFU9ER-F=-9xEXE8uSdpa-FjJpoS61x7kMaEjw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--4PR/+zdSfVlxyWed
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2019 at 03:31:59PM +0000, Filipe Manana wrote:
> On Sun, Nov 24, 2019 at 1:33 AM Zygo Blaxell
> <ce3g8jdj@umail.furryterror.org> wrote:
> >
> > On Sat, Nov 23, 2019 at 01:33:33PM +0000, Filipe Manana wrote:
> > > On Sat, Nov 23, 2019 at 5:29 AM Zygo Blaxell
> > > <ce3g8jdj@umail.furryterror.org> wrote:
> > > >
> > > > On Wed, Oct 30, 2019 at 12:23:01PM +0000, fdmanana@kernel.org wrote:
> > To be clear, I'm not doubting that the patch fixes a test case.
> > It's more like I regularly encounter a lot of performance problems from
> > iterate_extent_inodes() and friends, and only a tiny fraction of them
> > look like that test case.
> >
> > TL;DR it looks like LOGICAL_INO has more bugs than I knew about before
> > today,
>=20
> Which are? Where were they reported?

The first and least important bug is that LOGICAL_INO is slow.  This is
well known, although maybe the magnitude of the problem is not.  In one
dedupe test corpus I can produce (with bees or duperemove) a filesystem
with extents that have only a few thousand references, but take 45
kernel CPU minutes to process (each).  On this filesystem image I can
find backrefs by brute force processing 'btrfs inspect dump-tree' output
with a Perl script in only 8 minutes, and the problematic extents only
have a few hundred to a few thousand references.  Other extents have half
a million references and LOGICAL_INO can find them all in a few seconds
(including both CPU and IO time).  I don't know what the kernel's doing,
but whatever it is, it's *far* beyond any reasonable amount of processing
for the metadata.

The second bug is a bit more subtle.

I've been mining the last year of crash and corruption data and
tracking about 7 distict frequent failure behaviors in 5.0..5.3 kernels.
It turns out that LOGICAL_INO is implicated in half of these as well.
I've been running some tests to confirm this and exclude other factors
for the past month.  I was intending to post something about it at the
conclusion of testing a few weeks, but I have some actionable information
today, so here we are...

The data so far says that a host in the wild running LOGICAL_INO and
balance at the same time is 150x more likely to crash compared to hosts
that do not run LOGICAL_INO at all, or hosts that run either LOGICAL_INO
or balance but not at the same time.

Simultaneous LOGICAL_INO + balance correlates with these three failure
modes:

	https://www.spinics.net/lists/linux-btrfs/msg89425.html

	https://www.mail-archive.com/linux-btrfs@vger.kernel.org/msg88892.html

	[metadata corruption on 5.2 that looks the same as the previously
	reported corruption on 5.1, except 5.2 has a write time corruption
	detector that aborts the transaction instead of damaging the
	filesystem]

A host in our fleet that rarely or never runs LOGICAL_INO has few or no
problems on any kernel from 5.0 to 5.3.  When crashes do occur, they are
mostly random non-btrfs bugs (CIFS, wifi drivers, GPU, hardware failure,
power failure, etc).  We did have a few 5.2.x kernels hang in testing
due to the writeback bug fixed in 5.2.15.

The specific application we are running that uses LOGICAL_INO is bees.
bees spends more time running LOGICAL_INO than any other single activity
(other than sleeping).  Other dedupe tools don't seem to have an impact
on system uptime, which rules out EXTENT_SAME.  If there was a bug in
POSIX API like open() or read() we would all know about it.  That leaves
LOGICAL_INO, TREE_SEARCH_V2, and INO_PATHS as the 3 ioctls that bees calls
with unusual frequency compared to other software, but TREE_SEARCH_V2
and INO_PATHS don't show up in BUG_ON stack traces while LOGICAL_INO does.

I don't have a nice minimal reproducer yet, but "run bees and btrfs
balance start on a big, busy filesystem" triggers some kind of crash
(BUG_ON or transaction abort) for me in less than a day, 3x a day on
some hosts.  I think that a good reproducer would be a simple program
that walks the extent tree and feeds every extent bytenr in random order
to LOGICAL_INO in multiple threads while a balance is running, to see
if that makes the crashes happen faster.  I have not tried this yet.

I don't know how the 5.1 and 5.2 metadata corruption is connected,
other than the corruption immediately stops happening when we stop
running bees on the test host, or arrange for bees and balance to run
at separate times.

The bug is possibly as old as 4.12--based on earlier crash data, it
might have been the 4th most frequent crash case in kernels prior to 5.0.
The first three most frequent cases in 4.14 were flushoncommit deadlocks,
a reclaim/commit deadlock, and the rename/dedupe deadlock, all fixed
by 5.0.  LOGICAL_INO-related failures are now the most common crash case
in my data up to 5.2.

I'm running tests on 5.3 kernels, which are crashing in new, different,
and possibly unrelated ways.  LOGICAL_INO + balance is not the fastest
way to crash a 5.3 kernel, but I don't know yet whether or not it is
still a *possible* way to crash a 5.3 kernel.

That's all I really know about this bug so far:  there seems to be a
bug, it's not a new bug, and simultaneous LOGICAL_INO + balance seems
to trigger it.

> > > > LOGICAL_INO_V2 only finds 170 extent references:
> > > >
> > > >         # btrfs ins log 1344172032 -P . | wc -l
> > > >         170
> > >
> > > Pass "-s 65536", the default buffer is likely not large enough to all
> > > inode/root numbers.
> >
> > The default buffer is SZ_64K.  When I hacked up 'btrfs ins log' to use
>=20
> SZ_4K: https://github.com/kdave/btrfs-progs/blob/master/cmds/inspect.c#L1=
51

=2E..which is not the SZ_64K I was referring to.  Oops!

OK, my bad.  I forgot to double check this against the hand-rolled tools
I usually use.

With the right buffer size, `btrfs ins log` produces 1794 references,
which is the right number given the extent appears in 2 snapshots.

> > So I'm kind of stumped there.  If it works as you describe above
> > (and the description above is similar to my understanding of how it
> > works), then extent_item.refs should be a *lower* bound on the number
> > of references.  Snapshots will make the real number of references larger
> > than extent_item.refs, but cannot make it smaller (if an EXTENT_ITEM is
> > deleted in one of two subvols, the reference count in the EXTENT_DATA
> > would remain the same--incremented by the CoW, then decremented by
> > the delete).  Yet here is a case where that doesn't hold.
> >
> > Or...another theory is that LOGICAL_INO is broken, or trying to be
> > "helpful" by doing unnecessary work to get the wrong answer (like
> > FIEMAP does).  If I look at this extent again, I see that
>=20
> Hum, what wrong answers does fiemap gives? Was this reported before somew=
here?

FIEMAP coalesces physically adjacent extents as opposed to reporting
btrfs extent item boundaries, and it adjusts the first extent record to
match the beginning of the range parameter given to FIEMAP instead of
reporting the beginning of the extent.  This does interesting things
when the extents are compressed or if you try to iterate over them in
reverse order.

I presume that behavior is either by design, or just an awful compromise
to make the output conform to the limited capabilities of the FIEMAP
result format.  This would mean FIEMAP's behavior is not really a bug,
and I haven't reported it as one; however, it does mean FIEMAP is not an
appropriate tool for applications that need accurate information about
physical structure on btrfs.

Computing the 'shared' flag for FIEMAP is prohibitively expensive
at scale, and there's no way to skip that work with the current
FIEMAP interface if the application is not interested.

I switched to TREE_SEARCH_V2 to get extent item data:  it's faster, more
accurate, and more useful than FIEMAP, especially for compressed extents.

If anyone's interested in improving the generic FIEMAP interface to
handle btrfs quirks better, I can write up a proposal--it could be handy
to get this data without having to be root as TREE_SEARCH_V2 requires.
Alternatively, btrfs could have an unprivileged form of TREE_SEARCH_V2
that limits the min/max root/objectid ranges to the inode of the file
descriptor that is passed to the ioctl.

--4PR/+zdSfVlxyWed
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXd2vGQAKCRCB+YsaVrMb
nK/tAKC9tnYN84weqQegiVkCG8Am5WpCrACgsol5AKWXfoxYIhp2/syhb0QwqQU=
=Q7Q+
-----END PGP SIGNATURE-----

--4PR/+zdSfVlxyWed--
