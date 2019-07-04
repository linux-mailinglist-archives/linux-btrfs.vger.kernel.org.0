Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABCE25FE05
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2019 23:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfGDVDY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Jul 2019 17:03:24 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:47654 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726038AbfGDVDY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Jul 2019 17:03:24 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id B2C2C37741D; Thu,  4 Jul 2019 17:03:23 -0400 (EDT)
Date:   Thu, 4 Jul 2019 17:03:23 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     linux-btrfs@vger.kernel.org
Subject: repeatable(ish) corrupt leaf filesystem splat on 5.1.x
Message-ID: <20190704210323.GK11831@hungrycats.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="q6mBvMCt6oafMx9a"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--q6mBvMCt6oafMx9a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I've seen this twice in 3 days after releasing 5.1.x kernels from the
test lab:

5.1.15 on 2xSATA RAID1 SSD, during a balance:

	[48714.200014][ T3498] BTRFS critical (device dm-21): corrupt leaf: root=2 block=117776711680 slot=57, unexpected item end, have 109534755 expect 12632
	[48714.200381][ T3498] BTRFS critical (device dm-21): corrupt leaf: root=2 block=117776711680 slot=57, unexpected item end, have 109534755 expect 12632
	[48714.200399][ T9749] BTRFS: error (device dm-21) in __btrfs_free_extent:7109: errno=-5 IO failure
	[48714.200401][ T9749] BTRFS info (device dm-21): forced readonly
	[48714.200405][ T9749] BTRFS: error (device dm-21) in btrfs_run_delayed_refs:3008: errno=-5 IO failure
	[48714.200419][ T9749] BTRFS info (device dm-21): found 359 extents
	[48714.200442][ T9749] BTRFS info (device dm-21): 1 enospc errors during balance
	[48714.200445][ T9749] BTRFS info (device dm-21): balance: ended with status: -30

and 5.1.9 on 1xNVME, a few hours after some /proc NULL pointer dereference
bugs:

	[89244.144505][ T7009] BTRFS critical (device dm-4): corrupt leaf: root=2 block=1854946361344 slot=32, unexpected item end, have 1335222703 expect 15056
	[89244.144822][ T7009] BTRFS critical (device dm-4): corrupt leaf: root=2 block=1854946361344 slot=32, unexpected item end, have 1335222703 expect 15056
	[89244.144832][ T2403] BTRFS: error (device dm-4) in btrfs_run_delayed_refs:3008: errno=-5 IO failure
	[89244.144836][ T2403] BTRFS info (device dm-4): forced readonly

The machines had been upgraded from 5.0.x to 5.1.x for less than 24
hours each.

The 5.1.9 machine had crashed (on 5.0.15) before, but a scrub had passed
while running 5.1.9 after the crash.  The filesystem failure occurred
20 hours later.  There were some other NULL pointer deferences in that
uptime, so maybe 5.1.9 is just a generally buggy kernel that nobody
should ever run.  I expect better from 5.1.15, though, which had no
unusual events reported in the 8 hours between its post-reboot scrub
and the filesystem failure.

I have several other machines running 5.1.x kernels that have not yet had
such a failure--including all of my test machines, which don't seem to hit
this issue after 25+ days of stress-testing.  Most of the test machines
are using rotating disks, a few are running SSD+HDD with lvmcache.

One correlation that may be interesting:  both of the failing filesystems
had 1MB unallocated on all disks; all of the non-failing filesystems have
1GB or more unallocated on all disks.  I was running the balance on the
first filesystem to try to free up some unallocated space.  The second
filesystem died without any help from me.

It turns out that 'btrfs check --repair' can fix these!  First time
I've ever seen check --repair fix a broken filesystem.  A few files are
damaged, but the filesystem is read-write again and still working so far
(on a 5.0.21 kernel) .

--q6mBvMCt6oafMx9a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXR5pmQAKCRCB+YsaVrMb
nANnAKCcfXC5HdK77e9gN4RJ5NEFPRG5oQCeId+oRw7vw9rIpOoWPwW0EjlCIU4=
=yj3T
-----END PGP SIGNATURE-----

--q6mBvMCt6oafMx9a--
