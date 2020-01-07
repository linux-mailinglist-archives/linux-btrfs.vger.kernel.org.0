Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56A9E133775
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2020 00:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbgAGXck (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jan 2020 18:32:40 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:44080 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgAGXck (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jan 2020 18:32:40 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 2C491560DF8; Tue,  7 Jan 2020 18:32:37 -0500 (EST)
Date:   Tue, 7 Jan 2020 18:32:37 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: write amplification, was: very slow "btrfs dev delete" 3x6Tb,
 7Tb of data
Message-ID: <20200107233237.GC24056@hungrycats.org>
References: <CAJCQCtQEpXvgbs+Y0+A4cLZUft3oqp+sLW8xVPfxt2aqYhMj_g@mail.gmail.com>
 <2c135c87-d01b-53f1-9f76-a5653918a4e7@dubiel.pl>
 <cc364577-1bb8-1512-4d2e-dc7e465ca2d6@dubiel.pl>
 <20191228202344.GE13306@hungrycats.org>
 <c278f501-f5a5-c905-5431-2d735e97fa13@dubiel.pl>
 <CAJCQCtRvAZS1CNgJLdUZTNeUma6A74oPT-SeQe7NYHhXKrMzoA@mail.gmail.com>
 <5e6e2ff8-89be-45db-49d3-802de42663ed@dubiel.pl>
 <CAJCQCtSr9j8AzLRfguHb8+9n_snxmpXkw0V+LiuDnqqvLVAxKQ@mail.gmail.com>
 <20200104053843.GK13306@hungrycats.org>
 <CAJCQCtTvTbr9Civ5DLhTPRsMZ2qK2=YWFLB3JMSRRzZS9v-iNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2/5bycvrmDh4d1IB"
Content-Disposition: inline
In-Reply-To: <CAJCQCtTvTbr9Civ5DLhTPRsMZ2qK2=YWFLB3JMSRRzZS9v-iNA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--2/5bycvrmDh4d1IB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2020 at 11:44:43AM -0700, Chris Murphy wrote:
> On Fri, Jan 3, 2020 at 10:38 PM Zygo Blaxell
> <ce3g8jdj@umail.furryterror.org> wrote:
> >
> > On Thu, Jan 02, 2020 at 04:22:37PM -0700, Chris Murphy wrote:
>=20
> > > I've seen with 16KiB leaf size, often small files that could be
> > > inlined, are instead put into a data block group, taking up a minimum
> > > 4KiB block size (on x64_64 anyway). I'm not sure why, but I suspect
> > > there just isn't enough room in that leaf to always use inline
> > > extents, and yet there is enough room to just reference it as a data
> > > block group extent. When using a larger node size, a larger percentage
> > > of small files ended up using inline extents. I'd expect this to be
> > > quite a bit more efficient, because it eliminates a time expensive (on
> > > HDD anyway) seek.
> >
> > Putting a lot of inline file data into metadata pages makes them less
> > dense, which is either good or bad depending on which bottleneck you're
> > currently hitting.  If you have snapshots there is an up-to-300x metada=
ta
> > write amplification penalty to update extent item references every time
> > a shared metadata page is unshared.  Inline extents reduce the write
> > amplification.  On the other hand, if you are doing a lot of 'find'-sty=
le
> > tree sweeps, then inline extents will reduce their efficiency because m=
ore
> > pages will have to be read to scan the same number of dirents and inode=
s.
>=20
> Egads! Soo... total tangent. I'll change the subject.
>=20
> I have had multiple flash drive failures while using Btrfs: all
> Samsung, several SD Cards, and so far two USB sticks. They all fail in
> the essentially the same way, the media itself becomes read only. USB:
> writes succeed but they do not persist. Write data to the media, and
> there is no error. Read that same sector back, old data is there. SD
> Card: writes fail with a call trace and diagnostic info unique to the
> sd card kernel code, and everything just goes belly up. This happens
> inside of 6 months of rather casual use as rootfs. And BTW Samsung
> always replaces the media under warranty without complaint.
>=20
> It's not a scientific sample. Could be the host device, which is the
> same in each case. Could be a bug in the firmware. I have nothing to
> go on really.

It seems to be normal behavior for USB sticks and SD cards.  I've also
had USB sticks degrade (bit errors) simply from sitting unused on a shelf
for six months.  Some low-end SATA SSDs (like $20/TB drives from Amazon)
are giant USB sticks with a SATA interface, and will fail the same way.

SD card vendors are starting to notice, and there are now SD card options
with higher endurance ratings.  Still "putting this card in a dashcam
voids the warranty" in most cases.

ext2 and msdos both make USB sticks last longer, but they have obvious
other problems.  From my fleet of raspberry pis, I find that SD cards
last longer on btrfs than ext4 with comparable write loads, but they
are still both lead very short lives, and the biggest life expectancy
improvement (up to a couple of years) comes from eliminating local
writes entirely.

> But I wonder if this is due to write amplification that's just not
> anticipated by the manufacturers? Is there any way to test for this or
> estimate the amount of amplification? This class of media doesn't
> report LBA's written, so I'm at quite a lack of useful information to
> know what the cause is. The relevance here though is, I really like
> the idea of Btrfs used as a rootfs for things like IoT because of
> compression, ostensibly there are ssd optimizations, and always on
> checksumming to catch what often can be questionable media: like USB
> sticks, SD Cards, eMMC, etc. But not if the write amplication has a
> good chance of killing people's hardware (I have no proof of this but
> now I wonder, as I read your email).
>=20
> I'm aware of write amplification, I just didn't realize it could be
> this massive. It's is 300x just by having snapshots at all? Or does it
> get worse with each additional snapshot? And is it multiplicative or
> exponentially worse?

A 16K subvol metadata page can hold ~300 extent references.  Each extent
reference is bidirectional--there is a reference from the subvol metadata
page to the extent data item, and a backref from the extent data item
to the reference.  If a new reference is created via clone or dedupe or
partially overwriting an extent in the middle, then the extent item's
reference count is increased, and new backrefs are added to the extent
item's page.

When a snapshot is created, all the metadata pages except the root become
shared.  Each referenced extent data item is not changed at this time, as
there is only one metadata page containing references to each extent data
item.  The metadata page carrying the extent reference item has multiple
owners which are ancestor nodes in all of the snapshot subvol trees.

The backref walking code starts from an extent data item, and follows
references back to subvol metadata pages.  If the subvol metadata
pages are also shared, then the walking code follows those back to the
subvol roots.  The true reference count for an extent is a combination
of the direct references (subvol leaf page to extent data) and indirect
references (subvol root or node page to subvol leaf page).

When a snapshot metadata page is modified, a new metadata page is created
with mostly the same content, give or take the items that are added
or modified.  This inserts ~300 new extent data backref items into the
extent tree because they are now owned by both the old and new versions of
the metadata page.  It is as if the files located in the subvol metadata
page were silently reflinked from the old to new subvol, but only in
the specific areas listed on the single modified metadata page.

In the worst case, all ~300 extent data items are stored on separate
extent tree pages (i.e. you have really bad fragmentation on a big
filesystem, and all of the extents in a file are in different places on
disk).  In this case, to modify a single page of shared subvol metadata,
we must also update up to 300 extent tree pages.  This is where the
300x write multiply comes from.  It's not really the worst case--each
of those 300 page updates has their own multiplication (e.g. the extent
tree page may be overfilled and split, doubling one write).  If you end
up freeing pages all over the filesystem, there will be free space
cache/tree modifications as well.

In the best case, the metadata page isn't shared (i.e. it was CoWed or
it's a brand new metadata page).  In this case there's no need to update
backref pointers or reference counts for unmodified items, as they will
be deleted during the same transaction that creates a copy of them.

Real cases fall between 1x and 300x.  The first time you modify a metadata
page in a snapshotted subvol, you must also update ~300 extent data item
backrefs (unless the subvol is so small it contains fewer than 300 items).
This repeats for every shared page as it is unshared.  Over time, shared
pages are replaced with unshared pages, and performance within the subvol
returns to normal levels.  If a new snapshot is created for the subvol,
we start over at 300x item updates since every metadata page in the
subvol is now shared again.

The write multiplication contribution from snapshots quickly drops to 1x,
but it's worst after a new snapshot is created (for either the old or
new subvol).  On a big filesystem it can take minutes to create a new
directory, rename, delete, or hardlink files for the first time after
a snapshot is created, as even the most trivial metadata update becomes
an update of tens of thousands of randomly scattered extent tree pages.

Snapshots and 'cp -ax --reflink=3Dalways a b' are comparably expensive
if you modify more than 0.3% of the metadata and the modifications are
equally distributed across the subvol.  In the end, you'll have completely
unshared metadata and touched every page of the extent tree either way,
but the timing will be different (e.g. mkdirs and renames will be blamed
for the low performance, when the root cause is really the snapshot for
backups that happened 12 hours earlier).

> In the most prolific snapshotting case, I had two subvolumes, each
> with 20 snapshots (at most). I used default ssd mount option for the
> sdcards, most recently ssd_spread with the usb sticks. And now nossd
> with the most recent USB stick I just started to use.

The number of snapshots doesn't really matter:  you get the up-to-300x
write multiple from writing to a subvol that has shared metadata pages,
which happens when you have just one snapshot.  It doesn't matter if
you have 1 snapshot or 10000 (at least, not for _this_ reason).

> --=20
> Chris Murphy
>=20

--2/5bycvrmDh4d1IB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXhUVEwAKCRCB+YsaVrMb
nKFeAJ96mOKoJgXAwF+epD4ENYjteho6TgCeNbP5VwIvU5znYUFLIi9Q7Uuy5vs=
=tZHc
-----END PGP SIGNATURE-----

--2/5bycvrmDh4d1IB--
