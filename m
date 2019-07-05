Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8FA55FFC4
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2019 05:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfGEDeA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Jul 2019 23:34:00 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:47298 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727053AbfGEDeA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Jul 2019 23:34:00 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 8CC84377B44; Thu,  4 Jul 2019 23:33:59 -0400 (EDT)
Date:   Thu, 4 Jul 2019 23:33:59 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: repeatable(ish) corrupt leaf filesystem splat on 5.1.x
Message-ID: <20190705033359.GD11820@hungrycats.org>
References: <20190704210323.GK11831@hungrycats.org>
 <89b27a4e-8074-9e07-f98f-fc7f25d78ca1@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="hoZxPH4CaxYzWscb"
Content-Disposition: inline
In-Reply-To: <89b27a4e-8074-9e07-f98f-fc7f25d78ca1@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--hoZxPH4CaxYzWscb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 05, 2019 at 08:06:13AM +0800, Qu Wenruo wrote:
>=20
>=20
> On 2019/7/5 =E4=B8=8A=E5=8D=885:03, Zygo Blaxell wrote:
> > I've seen this twice in 3 days after releasing 5.1.x kernels from the
> > test lab:
> >=20
> > 5.1.15 on 2xSATA RAID1 SSD, during a balance:
> >=20
> > 	[48714.200014][ T3498] BTRFS critical (device dm-21): corrupt leaf: ro=
ot=3D2 block=3D117776711680 slot=3D57, unexpected item end, have 109534755 =
expect 12632
> > 	[48714.200381][ T3498] BTRFS critical (device dm-21): corrupt leaf: ro=
ot=3D2 block=3D117776711680 slot=3D57, unexpected item end, have 109534755 =
expect 12632
> > 	[48714.200399][ T9749] BTRFS: error (device dm-21) in __btrfs_free_ext=
ent:7109: errno=3D-5 IO failure
> > 	[48714.200401][ T9749] BTRFS info (device dm-21): forced readonly
> > 	[48714.200405][ T9749] BTRFS: error (device dm-21) in btrfs_run_delaye=
d_refs:3008: errno=3D-5 IO failure
> > 	[48714.200419][ T9749] BTRFS info (device dm-21): found 359 extents
> > 	[48714.200442][ T9749] BTRFS info (device dm-21): 1 enospc errors duri=
ng balance
> > 	[48714.200445][ T9749] BTRFS info (device dm-21): balance: ended with =
status: -30
> >=20
> > and 5.1.9 on 1xNVME, a few hours after some /proc NULL pointer derefere=
nce
> > bugs:
> >=20
> > 	[89244.144505][ T7009] BTRFS critical (device dm-4): corrupt leaf: roo=
t=3D2 block=3D1854946361344 slot=3D32, unexpected item end, have 1335222703=
 expect 15056
> > 	[89244.144822][ T7009] BTRFS critical (device dm-4): corrupt leaf: roo=
t=3D2 block=3D1854946361344 slot=3D32, unexpected item end, have 1335222703=
 expect 15056
> > 	[89244.144832][ T2403] BTRFS: error (device dm-4) in btrfs_run_delayed=
_refs:3008: errno=3D-5 IO failure
> > 	[89244.144836][ T2403] BTRFS info (device dm-4): forced readonly
> >=20
> > The machines had been upgraded from 5.0.x to 5.1.x for less than 24
> > hours each.
>=20
> All in btrfs_run_delayed_refs() when updating extent tree.
>=20
> The new check is to prevent btrfs receiving corrupted data, thus it
> happens at tree read time, where there should be no race.
> And that check has been there for a while, v4.15 should be the first
> kernel version with such check.
>=20
> So it doesn't look like false alert but some real corruption.

There was definite persistent corruption in this case (which is different
=66rom the "ghost" cases in the other thread).  I had to repair or replace
filesystems after each of these events.  I did a quick dump-tree and
found exactly the corruption stated in the kernel log, even after reboot.

> Would you please provide the tree dump of the related tree blocks?

Alas, these happened on production systems, so I had to repair or restore
the filesystems immediately and didn't have time to do more than a quick
analysis.  I also didn't know I was looking at a pattern of new behavior
until after the first two failures, so I didn't think of saving the tree.

I can't reproduce this on expendable test machines (they run a replica
of production workload with no problems, 27 days on 5.1.x so far),
and it's too expensive to keep running 5.1.x kernels in production if
an important filesystem is going down every few days.

> > The 5.1.9 machine had crashed (on 5.0.15) before, but a scrub had passed
> > while running 5.1.9 after the crash.  The filesystem failure occurred
> > 20 hours later.  There were some other NULL pointer deferences in that
> > uptime, so maybe 5.1.9 is just a generally buggy kernel that nobody
> > should ever run.  I expect better from 5.1.15, though, which had no
> > unusual events reported in the 8 hours between its post-reboot scrub
> > and the filesystem failure.
>=20
> BTW, would you like to spend some extra time on v5.2-rc kernel?
> In v5.2 kernel, we have extra write time tree checker (and makes read
> time tree checker a little faster).
> Current read time only checker is not good enough to expose the cause of
> the coorruption and prevent it.
>=20
> With v5.2, if the bug is still there, we could at least prevent the
> corruption before it's too late.

I can build a v5.2-rc kernel and throw it at a test machine...but my test
machines can't reproduce this bug, so they might not tell us much.

> > I have several other machines running 5.1.x kernels that have not yet h=
ad
> > such a failure--including all of my test machines, which don't seem to =
hit
> > this issue after 25+ days of stress-testing.  Most of the test machines
> > are using rotating disks, a few are running SSD+HDD with lvmcache.
> >=20
> > One correlation that may be interesting:  both of the failing filesyste=
ms
> > had 1MB unallocated on all disks; all of the non-failing filesystems ha=
ve
> > 1GB or more unallocated on all disks.  I was running the balance on the
> > first filesystem to try to free up some unallocated space.  The second
> > filesystem died without any help from me.
> >=20
> > It turns out that 'btrfs check --repair' can fix these!  First time
> > I've ever seen check --repair fix a broken filesystem.  A few files are
> > damaged, but the filesystem is read-write again and still working so far
> > (on a 5.0.21 kernel) .
>=20
> Maybe one won't believe, btrfs check has leaf re-order and item offset
> repair from the very beginning, but I'm not sure how reliable it is.

Repair seems to do well with simple software bugs (i.e. things that
corrupt only single items and don't lose entire leaf nodes) on small
filesystems (under 10 TB).  I just don't have many failures that fit
those constraints.  For me, it's either something outside of btrfs
(hardware failure, firmware bugs, or both) that completely destroys a
filesystem, or the filesystem is too large for btrfs check (it runs out
of RAM before it can do anything useful), or the filesystem runs for 5+
years with no problems at all.

> Thanks,
> Qu
>=20
> >=20
>=20




--hoZxPH4CaxYzWscb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXR7FJAAKCRCB+YsaVrMb
nJbFAKC4HXw9Lm1QeWIdXk4PtbLmHJlHDACeLfaranxjDGqPNsvgU4/stEFhV3A=
=2wiZ
-----END PGP SIGNATURE-----

--hoZxPH4CaxYzWscb--
