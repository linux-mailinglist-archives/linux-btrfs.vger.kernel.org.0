Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 853FD10815B
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2019 02:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfKXBda (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Nov 2019 20:33:30 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:43572 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfKXBda (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Nov 2019 20:33:30 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 0F7834EC818; Sat, 23 Nov 2019 20:33:28 -0500 (EST)
Date:   Sat, 23 Nov 2019 20:33:28 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] Btrfs: send, skip backreference walking for extents with
 many references
Message-ID: <20191124013328.GD1046@hungrycats.org>
References: <20191030122301.25270-1-fdmanana@kernel.org>
 <20191123052741.GJ22121@hungrycats.org>
 <CAL3q7H52LYCnDdFoObCCWjrCQqLOpcPUYeD28pXtET25-ycM9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Content-Disposition: inline
In-Reply-To: <CAL3q7H52LYCnDdFoObCCWjrCQqLOpcPUYeD28pXtET25-ycM9w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2019 at 01:33:33PM +0000, Filipe Manana wrote:
> On Sat, Nov 23, 2019 at 5:29 AM Zygo Blaxell
> <ce3g8jdj@umail.furryterror.org> wrote:
> >
> > On Wed, Oct 30, 2019 at 12:23:01PM +0000, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > Backreference walking, which is used by send to figure if it can issue
> > > clone operations instead of write operations, can be very slow and us=
e too
> > > much memory when extents have many references. This change simply ski=
ps
> > > backreference walking when an extent has more than 64 references, in =
which
> > > case we fallback to a write operation instead of a clone operation. T=
his
> > > limit is conservative and in practice I observed no signicant slowdown
> > > with up to 100 references and still low memory usage up to that limit.
> > >
> > > This is a temporary workaround until there are speedups in the backref
> > > walking code, and as such it does not attempt to add extra interfaces=
 or
> > > knobs to tweak the threshold.
> > >
> > > Reported-by: Atemu <atemu.main@gmail.com>
> > > Link: https://lore.kernel.org/linux-btrfs/CAE4GHgkvqVADtS4AzcQJxo0Q1j=
KQgKaW3JGp3SGdoinVo=3DC9eQ@mail.gmail.com/T/#me55dc0987f9cc2acaa54372ce0492=
c65782be3fa
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > ---
> > >  fs/btrfs/send.c | 25 ++++++++++++++++++++++++-
> > >  1 file changed, 24 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> > > index 123ac54af071..518ec1265a0c 100644
> > > --- a/fs/btrfs/send.c
> > > +++ b/fs/btrfs/send.c
> > > @@ -25,6 +25,14 @@
> > >  #include "compression.h"
> > >
> > >  /*
> > > + * Maximum number of references an extent can have in order for us t=
o attempt to
> > > + * issue clone operations instead of write operations. This currentl=
y exists to
> > > + * avoid hitting limitations of the backreference walking code (taki=
ng a lot of
> > > + * time and using too much memory for extents with large number of r=
eferences).
> > > + */
> > > +#define SEND_MAX_EXTENT_REFS 64
> > > +
> > > +/*
> > >   * A fs_path is a helper to dynamically build path names with unknow=
n size.
> > >   * It reallocates the internal buffer on demand.
> > >   * It allows fast adding of path elements on the right side (normal =
path) and
> > > @@ -1302,6 +1310,7 @@ static int find_extent_clone(struct send_ctx *s=
ctx,
> > >       struct clone_root *cur_clone_root;
> > >       struct btrfs_key found_key;
> > >       struct btrfs_path *tmp_path;
> > > +     struct btrfs_extent_item *ei;
> > >       int compressed;
> > >       u32 i;
> > >
> > > @@ -1349,7 +1358,6 @@ static int find_extent_clone(struct send_ctx *s=
ctx,
> > >       ret =3D extent_from_logical(fs_info, disk_byte, tmp_path,
> > >                                 &found_key, &flags);
> > >       up_read(&fs_info->commit_root_sem);
> > > -     btrfs_release_path(tmp_path);
> > >
> > >       if (ret < 0)
> > >               goto out;
> > > @@ -1358,6 +1366,21 @@ static int find_extent_clone(struct send_ctx *=
sctx,
> > >               goto out;
> > >       }
> > >
> > > +     ei =3D btrfs_item_ptr(tmp_path->nodes[0], tmp_path->slots[0],
> > > +                         struct btrfs_extent_item);
> > > +     /*
> > > +      * Backreference walking (iterate_extent_inodes() below) is cur=
rently
> > > +      * too expensive when an extent has a large number of reference=
s, both
> > > +      * in time spent and used memory. So for now just fallback to w=
rite
> > > +      * operations instead of clone operations when an extent has mo=
re than
> > > +      * a certain amount of references.
> > > +      */
> > > +     if (btrfs_extent_refs(tmp_path->nodes[0], ei) > SEND_MAX_EXTENT=
_REFS) {
> >
> > So...does this...work?
>=20
> I wouldn't send it if it didn't work, at least for the case reported.
>=20
> There's even a test case for this, btrfs/130 from fstests:
>=20
> https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/tests/btrfs/1=
30
>=20
> It used to take several hours to complete on a test vm I use
> frequently, now it completes in 1 or 2 seconds.

To be clear, I'm not doubting that the patch fixes a test case.
It's more like I regularly encounter a lot of performance problems from
iterate_extent_inodes() and friends, and only a tiny fraction of them
look like that test case.

TL;DR it looks like LOGICAL_INO has more bugs than I knew about before
today, and that throws a bunch of my previous work on this topic into
doubt.  I have been viewing btrfs through a LOGICAL_INO-shaped lens.

> While that is about an extent shared only within the same file, the
> same happens if the extent is reflinked to many other files (either
> all part of the same subvolume or belonging to different subvolumes).

OK, then this might be a different bug than the ones I'm seeing, or
maybe I am hitting a variety of different bugs at once.

> > I ask because I looked at this a few years ago as a way to spend less
> > time doing LOGICAL_INO calls during dedupe (and especially avoid the
>=20
> To give some context to those not familiar with you, you are
> mentioning a user space dedupe tool that doesn't call the btrfs dedup
> ioctl, and calls the clone ioctl directly, while also using the
> LOGICAL_INO ioctl.

Uhhh...bees uses the dedup ioctl, and does not call the clone ioctl.

Here is some more correct context:

bees uses LOGICAL_INO_V2 for two purposes:  the obvious one is to
discover the set of references to an extent so we can pass them all to
the dedupe ioctl.  The other purpose is to estimate the kernel's future
performance when manipulating that extent using iterate_extent_inodes()
and related functions.

The performance estimate function is:  run the LOGICAL_INO(_V2) ioctl
and measure the CPU time the kernel thread spent.  If the kernel spends
more than 100 ms on the extent, then bees puts the extent on a blacklist
and will never touch the extent again.

Obviously this is wrong, but the test is cheap, the false positive
rate is low, and the cost of deduping a bad extent is extremely high.
A bad extent can take 100 million times more kernel CPU than an average
extent (8 orders of magnitude slower).  Only 0.001% of extents in a
typical filesystem fail the test, but if we deduped those naively,
each one can take hours of kernel CPU time in many btrfs operations
(send, balance, scrub error path, even overwrite and delete seem to
use iterate_extent_inodes() at least in some cases).  I've seen this
phenomenon occur when using other dedupe tools like duperemove as well.

The vexing thing is that I haven't found any simple way to predict the
bad behavior, other than to run the existing code and measure how it
behaves while the performance is still tolerable.  Variables like file
size, extent inline reference count, snapshot reference count, extent
size, extent item data members all have poor correlations to the kernel
CPU time of LOGICAL_INO:  it seems to happen with equal probability on
large and small files, and extents with high and low reference counts.

One of the things on my todo list is to dive into the kernel code to
figure out what's going on, but the issue is easy to work around, so
I have been looking at the higher priority crashing/hanging/corrupting
bugs instead.

> > 8-orders-of-magnitude performance degradation in the bad cases), but
> > I found that it was useless: it wasn't proportional to the number of
> > extents, nor was it an upper or lower bound, nor could extents be sorted
> > by number of references using extent.refs as a key, nor could it predict
> > the amount of time it would take for iterate_extent_inodes() to run.
> > I guess I'm surprised you got a different result.
> >
> > If the 'refs' field is 1, the extent might have somewhere between 1
> > and 3500 root/inode/offset references.
>=20
> Yes, that's due to snapshotting and the way it works.
> Creating a snapshot consists of COWing the root node of a tree only,
> which will not increment extent references (for data extents,
> referenced in leafs) if the tree has an height of 2 or more.
>=20
> Example:
>=20
> 1) You have a subvolume tree with 2 levels (root at level 1, leafs at lev=
el 0);
>=20
> 2) You have a file there that refers to extent A, not shared with
> anyone else, and has a reference count of 1 in the extent item at the
> extent tree;
>=20
> 3) After you snapshot the subvolume, extent A will still have 1
> reference count in its item at the extent tree.
>=20
> If you do anything that changes the leaf that refers to extent A
> (resulting in it being COWed), in either tree, btrfs will take care of
> adding a new backreference to the extent and bump the reference count
> to 2 for extent A.
>=20
> If on the other hand, if the source subvolume was really small,
> consisting of a single node/leaf (root at level 0), then you would get
> 2 references for extent A immediately after making the snapshot.
>=20
> > But it's not a lower bound,
> > e.g. here is an extent on a random filesystem where extent_refs is a
> > big number:
> >
> >         item 87 key (1344172032 EXTENT_ITEM 4096) itemoff 11671 itemsiz=
e 24
> >                 refs 897 gen 2668358 flags DATA
> >
> > LOGICAL_INO_V2 only finds 170 extent references:
> >
> >         # btrfs ins log 1344172032 -P . | wc -l
> >         170
>=20
> Pass "-s 65536", the default buffer is likely not large enough to all
> inode/root numbers.

The default buffer is SZ_64K.  When I hacked up 'btrfs ins log' to use
LOGICAL_INO_V2 I also increased the size to SZ_16M.  Even so, 64K is
enough for 2730 references (the previous limit with LOGICAL_INO v1),
and 2730 is more than 170 (or 897).

So I'm kind of stumped there.  If it works as you describe above
(and the description above is similar to my understanding of how it
works), then extent_item.refs should be a *lower* bound on the number
of references.  Snapshots will make the real number of references larger
than extent_item.refs, but cannot make it smaller (if an EXTENT_ITEM is
deleted in one of two subvols, the reference count in the EXTENT_DATA
would remain the same--incremented by the CoW, then decremented by
the delete).  Yet here is a case where that doesn't hold.

Or...another theory is that LOGICAL_INO is broken, or trying to be
"helpful" by doing unnecessary work to get the wrong answer (like
FIEMAP does).  If I look at this extent again, I see that

	btrfs ins dump-tree -t 12805 /dev/testfs | grep 'extent data disk byte 134=
4172032 ' | nl

is reporting 897 lines of output.  Interesting!  Up until this moment, I
had been assuming LOGICAL_INO was more or less correct, but maybe I should
reevaluate my previous experimental results with the opposite assumption.

e.g. the first lines of LOGICAL_INO output, sorted in inode/offset order:

	inode 25801552 offset 386469888 root 12805
	inode 25801552 offset 386469888 root 12801
	inode 29497105 offset 69632 root 12805
	inode 29497104 offset 69632 root 12805
	[...and 166 more...]

brute-force searching btrfs ins dump-tree shows 3 more references in inode
25801552, plus some bonus inodes that don't show up in the LOGICAL_INO
output at all:

        item 53 key (146777 EXTENT_DATA 22319104) itemoff 13342 itemsize 53
                generation 2668358 type 1 (regular)
                extent data disk byte 1344172032 nr 4096
                extent data offset 0 nr 4096 ram 4096
                extent compression 0 (none)
        item 3 key (25801552 EXTENT_DATA 128630784) itemoff 16071 itemsize =
53
                generation 2668358 type 1 (regular)
                extent data disk byte 1344172032 nr 4096
                extent data offset 0 nr 4096 ram 4096
                extent compression 0 (none)
        item 110 key (25801552 EXTENT_DATA 384958464) itemoff 10400 itemsiz=
e 53
                generation 2668358 type 1 (regular)
                extent data disk byte 1344172032 nr 4096
                extent data offset 0 nr 4096 ram 4096
                extent compression 0 (none)
        item 82 key (25801552 EXTENT_DATA 385462272) itemoff 11884 itemsize=
 53
                generation 2668358 type 1 (regular)
                extent data disk byte 1344172032 nr 4096
                extent data offset 0 nr 4096 ram 4096
                extent compression 0 (none)
        item 175 key (25801552 EXTENT_DATA 385966080) itemoff 6955 itemsize=
 53
                generation 2668358 type 1 (regular)
                extent data disk byte 1344172032 nr 4096
                extent data offset 0 nr 4096 ram 4096
                extent compression 0 (none)
        item 77 key (25801552 EXTENT_DATA 386469888) itemoff 12149 itemsize=
 53
                generation 2668358 type 1 (regular)
                extent data disk byte 1344172032 nr 4096
                extent data offset 0 nr 4096 ram 4096
                extent compression 0 (none)
        item 60 key (25855558 EXTENT_DATA 13611008) itemoff 12820 itemsize =
53
                generation 2668358 type 1 (regular)
                extent data disk byte 1344172032 nr 4096
                extent data offset 0 nr 4096 ram 4096
                extent compression 0 (none)
        item 53 key (25855558 EXTENT_DATA 14114816) itemoff 13421 itemsize =
53
                generation 2668358 type 1 (regular)
                extent data disk byte 1344172032 nr 4096
                extent data offset 0 nr 4096 ram 4096
                extent compression 0 (none)
        item 106 key (29496169 EXTENT_DATA 69632) itemoff 10426 itemsize 53
                generation 2668358 type 1 (regular)
                extent data disk byte 1344172032 nr 4096
                extent data offset 0 nr 4096 ram 4096
                extent compression 0 (none)
        item 140 key (29496170 EXTENT_DATA 69632) itemoff 8531 itemsize 53
                generation 2668358 type 1 (regular)
                extent data disk byte 1344172032 nr 4096
                extent data offset 0 nr 4096 ram 4096
                extent compression 0 (none)
        item 175 key (29496171 EXTENT_DATA 69632) itemoff 6583 itemsize 53
                generation 2668358 type 1 (regular)
                extent data disk byte 1344172032 nr 4096
                extent data offset 0 nr 4096 ram 4096
                extent compression 0 (none)
	[...etc, there are 897 of these.]

and...these are distinct, not logically or physically contiguous,
no compression, no data offset...no reason why LOGICAL_INO (v1 or v2)
should not report them.

> > Is there a good primer somewhere on how the reference counting works in
> > btrfs?
>=20
> Dunno. Source code, and an old paper about btrfs:
>=20
> https://domino.research.ibm.com/library/cyberdig.nsf/papers/6E1C5B6A1B6ED=
D9885257A38006B6130/$File/rj10501.pdf
>=20
> Maybe the wiki has more references.

I've read those.  I guess I misstated my question:  how is it *supposed*
to work, so I can compare that to what the source code (particularly
the LOGICAL_INO implementation) is *actually* doing, and possibly
correct it?

If it ever gets up to the top of my priority list I'm fully aware I
might end up writing that document.

> > > +             ret =3D -ENOENT;
> > > +             goto out;
> > > +     }
> > > +     btrfs_release_path(tmp_path);
> > > +
> > >       /*
> > >        * Setup the clone roots.
> > >        */
> > > --
> > > 2.11.0
> > >
>=20

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXdnd5AAKCRCB+YsaVrMb
nOQFAJ9MEM88C5K/4vxA4q4OYZnilH0GMgCgwaQXbjpUB9HVL90au4e1d+3uRy4=
=TU+/
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
