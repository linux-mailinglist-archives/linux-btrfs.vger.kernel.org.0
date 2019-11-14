Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48F95FBE87
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2019 05:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfKNEZX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Nov 2019 23:25:23 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:35466 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbfKNEZW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Nov 2019 23:25:22 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 6256F4D10D1; Wed, 13 Nov 2019 23:25:21 -0500 (EST)
Date:   Wed, 13 Nov 2019 23:25:21 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     kreijack@inwind.it
Cc:     Hubert Tonneau <hubert.tonneau@fullpliant.org>,
        linux-btrfs@vger.kernel.org
Subject: Re: Avoiding BRTFS RAID5 write hole
Message-ID: <20191114042521.GY22121@hungrycats.org>
References: <0JG8IAF11@briare1.fullpliant.org>
 <441de86e-a0ea-fdc9-7fce-bb2cf56d0be8@libero.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qyHYMwAXsHLOQihY"
Content-Disposition: inline
In-Reply-To: <441de86e-a0ea-fdc9-7fce-bb2cf56d0be8@libero.it>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--qyHYMwAXsHLOQihY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2019 at 08:49:33PM +0100, Goffredo Baroncelli wrote:
> On 12/11/2019 16.13, Hubert Tonneau wrote:
> > Hi,
> >=20
> > In order to close the RAID5 write hole, I prepose the add a mount optio=
n that would change RAID5 (and RAID6) behaviour :
> >=20
> > . When overwriting a RAID5 stripe, first convert it to RAID1 (convert i=
t to RAID1C3 if it was RAID6)
>=20
> You can't overwrite  and convert a existing stripe for two kind of reason:
> 1) you still have to protect the stripe overwriting from the write hole
> 2) depending by the layout, a raid1 stripe consumes more space than a rai=
d5 stripe with equal "capacity"
>=20
> So you have to write (temporarily) the data on another place. This is som=
ething not different from what Qu proposed few years ago:
>=20
> https://www.mail-archive.com/linux-btrfs@vger.kernel.org/msg66472.html [B=
trfs: Add journal for raid5/6 writes]
>=20
> where he added a device for logging the writes.
>=20
> Unfortunately, this means doubling the writes; that for a COW filesystem =
(which already suffers this kind of issue) would be big performance penalit=
y....
>=20
> Instead I would like to investigate the idea of COW-ing the stripe: inste=
ad of updating the stripe on place, why not write the new stripe in another=
 place and then update the data extent to point to the new data ? Of course=
 would work only for the data and not for the metadata.
> Pros: the data is written only once
> Cons: the pressure of the metadata would increase; the fragmentation woul=
d increase

The write hole issue is caused by updating a RAID stripe that contains
committed data, and then not being able to finish that update because
of a crash or power loss.  You avoid this using two strategies:

	1.  never modify RAID stripes while they have committed data in
	them, or

	2.  use journalling so that you can never be prevented from
	completing a RAID stripe update due to a crash.

You can even do both, e.g. use strategy #1 for datacow files and strategy
#2 for nodatacow files.  IMHO we don't need to help nodatacow files
survive RAID5/6 failure events because we don't help nodatacow files
survive raid1, raid1c3, raid1c4, raid10, or dup failure events either,
but opinions differ so, fine, there's strategy #2 if you want it.

Other filesystems use strategy #1, but they have different layering
between CoW allocator and the RAID layer:  they put parity blocks in-band
in extents, so every extent is always a complete set of RAID stripes.
That would be a huge on-disk format change for btrfs (as well as rewriting
half the kernel implementation) that nobody wants to do.  The end
result would behave almost but not quite like the way btrfs currently
handles compression.  It's also not fixing the current btrfs raid5/6,
it's deprecating them entirely and doing something better instead.

Back to fixing existing btrfs profiles.  Any time we write to a stripe
that is not occupied by committed data on btrfs, we avoid the conditions
for the write hole.  The existing CoW mechanisms handle this, so nothing
needs to be changed there.  We only need to worry about writes to stripes
that contain data committed in earlier transactions, and we can know we
are doing this by looking at 'gen' fields in neighboring extents whenever
we insert an extent into a RAID5/6 block group.

We can get strategy #1 on btrfs by making two small(ish) changes:

	1.1.  allocate blocks strictly on stripe-aligned boundaries.

	1.2.  add a new balance filter that selects only partially filled
	RAID5/6 stripes for relocation.

The 'ssd' mount option already does 1.1, but it only works for RAID5
arrays with 5 disks and RAID6 arrays with 6 disks because it uses a fixed
allocation boundary, and it only works for metadata because...it's coded
to work only on metadata.  The change would be to have btrfs select an
allocation boundary for each block group based on the number of disks in
the block group (no new behavior for block groups that aren't raid5/6),
and do aligned allocations for both data and metadata.  This creates a
problem with free space fragmentation which we solve with change 1.2.

Implementing 1.2 allows balance to repack partially filled stripes into
complete stripes, which you will have to do fairly often if you are
allocating data strictly on RAID-stripe-aligned boundaries.  "Write 4K
then fsync" uses 256K of disk space, since writes to partially filled
stripes would not be allowed, we have 252K of wasted space and 4K in use.
Balance could later pack 64 such 4K extents into a single RAID5 stripe,
recovering all the wasted space.  Defrag can perform a similar function,
collecting multiple 4K extents into a single 256K or larger extent that
can be written in a single transaction without wasting space.

Strategy #2 requires some disk format changes:

	2.1.  add a new block group type for metadata that uses simple
	replication (raid1c3/raid1c4, already done)

	2.2.  record all data blocks to be written to partially filled
	RAID5/6 stripes in a journal before modifying any blocks in
	the stripe.

The journal in 2.2. could be some extension of the log tree or a separate
tree.  As long as we can guarantee that any partial RAID5/6 RMW stripe
update will complete all data block updates before we start updating the
committed stripes, we can update any blocks we want.  We don't need to
journal the parity blocks, we can just recompute them from the logged
data block if the updated device goes missing.

After a crash, the journal must be replayed so that there are no
incomplete stripe updates.  Normally there would be at most one partial
stripe update per transaction, unless the filesystem is really full and we
are forced to start filling in old incomplete stripes.  Full stripe writes
don't need any intervention, the existing btrfs CoW mechanisms are fine.

Strategy #1 requires no disk format changes.  It just changes
the allocator and balance behavior.  Userspace changes would not
be immediately required, though without running balance to clean up
partially filled RAID stripes, performance would degrade after some time.
New kernels will be able to write raid5/6 updates without write hole,
old kernels won't.

Strategy #2 requires multiple disk format changes:  raid1c3/c4 (which we
now have) and raid5/6 data block journalling extensions (which we don't).
A kernel that didn't know to replay the log would not be able to fix
write holes on mount.

Note there are similar numbers of writes between the two strategies.
Everything is written in two places--but strategy #1 allows the user to
choose when the second write happens.  This allows for batch updates,
or maybe the user deletes or overwrites the data before we even have to
bother relocating it.  Strategy #2 always writes every journalled data
block twice (not counting parity and mirroring), but we can keep the
number of journalled blocks to a minimum.

> > . Have a background process that converts RAID1 stripes to RAID5 (RAID1=
C3 to RAID6)
> >=20
> > Expected advantages are :
> > . the low level features set basically remains the same
> > . the filesystem format remains the same
> > . old kernels and btrs-progs would not be disturbed
> >=20
> > The end result would be a mixed filesystem where active parts are RAID1=
 and archives one are RAID5.
> >=20
> > Regards,
> > Hubert Tonneau
> >=20
>=20
>=20
> --=20
> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

--qyHYMwAXsHLOQihY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXczXKwAKCRCB+YsaVrMb
nBcdAJ4u938Vd6TChOvngvVZfMRDWxN+/ACdExWlRGPa78vAMgAnLP2LhBf/WgA=
=ovnF
-----END PGP SIGNATURE-----

--qyHYMwAXsHLOQihY--
