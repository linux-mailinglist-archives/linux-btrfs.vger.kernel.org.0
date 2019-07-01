Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F75F5B302
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2019 05:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfGADIN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 Jun 2019 23:08:13 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:41754 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727135AbfGADIN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 Jun 2019 23:08:13 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 7065C36CB37; Sun, 30 Jun 2019 23:08:01 -0400 (EDT)
Date:   Sun, 30 Jun 2019 23:07:48 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     linux-btrfs@vger.kernel.org
Subject: Re: Global reserve and ENOSPC while deleting orphan inodes on 5.1.14
Message-ID: <20190701030725.GG11831@hungrycats.org>
References: <20190423230649.GB11530@hungrycats.org>
 <20190623141434.GB11831@hungrycats.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0z5c7mBtSy1wdr4F"
Content-Disposition: inline
In-Reply-To: <20190623141434.GB11831@hungrycats.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--0z5c7mBtSy1wdr4F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 23, 2019 at 10:14:34AM -0400, Zygo Blaxell wrote:
> On Tue, Apr 23, 2019 at 07:06:51PM -0400, Zygo Blaxell wrote:
> > I had a test filesystem that ran out of unallocated space, then ran
> > out of metadata space during a snapshot delete, and forced readonly.
> > The workload before the failure was a lot of rsync and bees dedupe
> > combined with random snapshot creates and deletes.
>=20
> Had this happen again on a production filesystem, this time on 5.1.11,
> and it happened during orphan inode cleanup instead of snapshot delete:
>=20
> 	[14303.076134][T20882] BTRFS: error (device dm-21) in add_to_free_space_=
tree:1037: errno=3D-28 No space left
> 	[14303.076144][T20882] BTRFS: error (device dm-21) in __btrfs_free_exten=
t:7196: errno=3D-28 No space left
> 	[14303.076157][T20882] BTRFS: error (device dm-21) in btrfs_run_delayed_=
refs:3008: errno=3D-28 No space left
> 	[14303.076203][T20882] BTRFS error (device dm-21): Error removing orphan=
 entry, stopping orphan cleanup
> 	[14303.076210][T20882] BTRFS error (device dm-21): could not do orphan c=
leanup -22
> 	[14303.076281][T20882] BTRFS error (device dm-21): commit super ret -30
> 	[14303.357337][T20882] BTRFS error (device dm-21): open_ctree failed
>=20
> Same fix:  I bumped the reserved size limit from 512M to 2G and mounted
> normally.  (OK, technically, I booted my old 5.0.21 kernel--but my 5.0.21
> kernel has the 2G reserved space patch below in it.)

It turns out that it was the boot with 5.0.21 that fixed this, not the
increase reserved limit patch.  This filesystem's global reserve is is
only 1.71G (it's a 2x150G btrfs raid1), so raising the limit to 2G has
no effect on 5.1.x.

I was able to mount the filesystem with 5.0.21, but not with 5.1.14--even
after successfully mounting with 5.0.21 and finishing orphan inode
cleanup, mounting on 5.1.14 or 5.1.15 fails.

I tried a few other things:  balancing metadata (Size:19.04GiB,
Used:7.54GiB) and mounting with 'nossd' (which somehow became 'ssd'
after the fact?).  Eventually I was able to mount the filesystem with
kernel 5.1.15 and the 'nossd' option.  I can now wait and see how long
5.1.15 lasts until the next similar event occurs.

The full mount options are:  rw,noatime,degraded,compress=3Dzstd:3,ssd,flus=
honcommit,space_cache=3Dv2,skip_balance

(filesystem isn't degraded in this case, I just have that option in case
a disk fails some day)

--0z5c7mBtSy1wdr4F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXRl45QAKCRCB+YsaVrMb
nIrLAJ0QnxkjAAql/Sk0DVtUvrtcN47MYQCffHmAapiVT0bxUYqFOU4giHtl1ZY=
=nPlP
-----END PGP SIGNATURE-----

--0z5c7mBtSy1wdr4F--
