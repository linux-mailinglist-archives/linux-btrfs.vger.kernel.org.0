Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40759154FDE
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 01:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgBGA6o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 19:58:44 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:47068 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgBGA6o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Feb 2020 19:58:44 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 35D8C5B028D; Thu,  6 Feb 2020 19:58:43 -0500 (EST)
Date:   Thu, 6 Feb 2020 19:58:43 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Sebastian =?iso-8859-1?Q?D=F6ring?= <moralapostel@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: btrfs-scrub: slow scrub speed (raid5)
Message-ID: <20200207005843.GE13306@hungrycats.org>
References: <CADkZQan+F47nHo49RRhWLi2DfWeJLrhCYvw4=Zw_W7gFedneDw@mail.gmail.com>
 <CAJCQCtTgK08eY3j4VYC=htY5bYj6cu9w3_58nzGo4BoWCQL7uQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="p1zxN+PsucbyOM2v"
Content-Disposition: inline
In-Reply-To: <CAJCQCtTgK08eY3j4VYC=htY5bYj6cu9w3_58nzGo4BoWCQL7uQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--p1zxN+PsucbyOM2v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 06, 2020 at 01:51:06PM -0700, Chris Murphy wrote:
> On Thu, Feb 6, 2020 at 10:33 AM Sebastian D=F6ring <moralapostel@gmail.co=
m> wrote:
> >
> > Hi everyone,
> >
> > when I run a scrub on my 5 disk raid5 array (data: raid5, metadata:
> > raid6) I notice very slow scrubbing speed: max. 5MB/s per device,
> > about 23-24 MB/s in sum (according to btrfs scrub status).
>=20
> raid56 is not recommended for metadata. With raid5 data, it's
> recommended to use raid1 metadata. It's possible to convert from raid6
> to raid1 metadata, but you'll need to use -f flag due to the reduced
> redundancy.

Definitely do not use raid5 or raid6 for metadata.  All test runs end
in total filesystem loss.  Use raid1 or raid1c3 metadata for raid5 or
raid6 data respectively.

> If you can consistently depend on kernel 5.5+ you can use raid1c3 or
> raid1c4 for metadata, although even though the file system itself can
> survive a two or three device failure, most of your data won't
> survive. It would allow getting some fraction of the files smaller
> than 64KiB (raid5 strip size) off the volume.
>=20
> I'm not sure this accounts for the slow scrub though. It could be some
> combination of heavy block group fragmentation, i.e. a lot of free
> space in block groups, in both metadata and data block groups, and
> then raid6 on top of it. But, I'm not convinced. It's be useful to see
> IO and utilization during the scrub from iostat 5, to see if any one
> of the drives is ever getting close to 100% utilization.

When you run the scrub userspace utility, it creates one thread for
every drive to run the scrub ioctl.  This works well for the other RAID
levels as each drive can be read independently of all others; however,
it's a terrible idea for raid5/6 as each thread has to read all the
drives to recompute parity.  Patches welcome!

(e.g. a patch to make the btrfs scrub userspace utility detect and handle
raid5/6 differently, or to fix the kernel's raid5/6 implementation, or
to add a new scrub ioctl interface that is block-group based instead of
device based).

A workaround is to run scrub on each disk sequentially.  This will take
N times longer than necessary for N disks, but that's better than 20-100
times longer than necessary with all the thrashing of disk heads between
threads on spinning disks.  'btrfs scrub' on a filesystem mountpoint is
exactly equivalent to running several independent 'btrfs scrub' ioctls
on each disk at the same time, so there's no change in behavior to scrub
separate disks one at a time on raid5/6, except for the massive speedup.

Currently btrfs raid5/6 csum error correction works roughly 99.999% of
the time on corrupted data blocks, and utterly fails the other 0.001%.
Recovery will work for things like total-loss disk failures (as long as
you're not writing to the filesystem during recovery).  If you have a
more minor failure, e.g. a disk being offline for a few minutes and then
reconnecting, or a drive silently corrupting data but otherwise healthy,
then the effort to recover and the amount of data lost go *up*.

I just updated this bug report today with some details:

	https://www.spinics.net/lists/linux-btrfs/msg94594.html

> > What's interesting is at the same time the gross read speed across the
> > involved devices (according to iostat) is about ~71 MB/s in sum (14-15
> > MB/s per device). Where are the remaining 47 MB/s going? I expect
> > there would be some overhead because it's a raid5, but it shouldn't be
> > much more than a factor of (n-1) / n , no? At the moment it appears to
> > be only scrubbing 1/3 of all data that is being read and the rest is
> > thrown out (and probably re-read again at a different time).
>=20
> What do you get for
> btrfs fi df /mountpoint/
> btrfs fi us /mountpoint/
>=20
> Is it consistently this slow or does it vary a lot?
>=20
> >
> > Surely this can't be right? Are iostat or possibly btrfs scrub status
> > lying to me? What am I seeing here? I've never seen this problem with
> > scrubbing a raid1, so maybe there's a bug in how scrub is reading data
> > from raid5 data profile?
>=20
> I'd say more likely it's a lack of optimization for the moderate to
> high fragmentation case. Both LVM and mdadm raid have no idea what the
> layout is, there's no fs metadata to take into account, so every scrub
> read is a full stripe read. However, that means it reads unused
> portions of the array too, where Btrfs won't because every read is
> deliberate. But that means performance can be impacted by disk
> contention.
>=20
>=20
> > It seems to me that I could perform a much faster scrub by rsyncing
> > the whole fs into /dev/null... btrfs is comparing the checksums anyway
> > when reading data, no?
>=20
> Yes.

No.  Reads will not verify or update the parity unless a csum error
is detected.  Scrub reads the entire stripe if any portion of the
stripe contains data.

> --=20
> Chris Murphy

--p1zxN+PsucbyOM2v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXjy2QAAKCRCB+YsaVrMb
nA1nAJ9MD118LT3UojTZt6lj8Z/a7RwaKACfbsjVjA3zAi2bKCaH1nZZs/e0mgs=
=enby
-----END PGP SIGNATURE-----

--p1zxN+PsucbyOM2v--
