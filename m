Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7E3B113A21
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 03:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfLEC6d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Dec 2019 21:58:33 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:45086 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728449AbfLEC6d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Dec 2019 21:58:33 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 7449A50D790; Wed,  4 Dec 2019 21:58:32 -0500 (EST)
Date:   Wed, 4 Dec 2019 21:58:32 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs: Make balance cancelling response faster
Message-ID: <20191205025832.GY22121@hungrycats.org>
References: <20191203064254.22683-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+QmoJrblcRudFCJH"
Content-Disposition: inline
In-Reply-To: <20191203064254.22683-1-wqu@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--+QmoJrblcRudFCJH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 03, 2019 at 02:42:50PM +0800, Qu Wenruo wrote:
> [PROBLEM]
> There are quite some users reporting that 'btrfs balance cancel' slow to
> cancel current running balance, or even doesn't work for certain dead
> balance loop.
>=20
> With the following script showing how long it takes to fully stop a
> balance:
>   #!/bin/bash
>   dev=3D/dev/test/test
>   mnt=3D/mnt/btrfs
>=20
>   umount $mnt &> /dev/null
>   umount $dev &> /dev/null
>=20
>   mkfs.btrfs -f $dev
>   mount $dev -o nospace_cache $mnt
>=20
>   dd if=3D/dev/zero bs=3D1M of=3D$mnt/large &
>   dd_pid=3D$!
>=20
>   sleep 3
>   kill -KILL $dd_pid
>   sync
>=20
>   btrfs balance start --bg --full $mnt &
>   sleep 1
>=20
>   echo "cancel request" >> /dev/kmsg
>   time btrfs balance cancel $mnt
>   umount $mnt
>=20
> It takes around 7~10s to cancel the running balance in my test
> environment.
>=20
> [CAUSE]
> Btrfs uses btrfs_fs_info::balance_cancel_req to record how many cancel
> request are queued.
> However that cancelling request is only checked after relocating a block
> group.
>=20
> That behavior is far from optimal to provide a faster cancelling.
>=20
> [FIX]
> This patchset will add more cancelling check points, to make cancelling
> faster.

Nice!  I look forward to using this in the future!

Does this cover device delete/resize as well?  I think there needs to be
a check added for fatal signals for those to work, as they don't respond
to balance cancel.

> And also, introduce a new error injection points to cover these newly
> introduced and future check points.
>=20
> Qu Wenruo (4):
>   btrfs: relocation: Introduce error injection points for cancelling
>     balance
>   btrfs: relocation: Check cancel request after each data page read
>   btrfs: relocation: Check cancel request after each extent found
>   btrfs: relocation: Work around dead relocation stage loop
>=20
>  fs/btrfs/ctree.h      |  1 +
>  fs/btrfs/relocation.c | 23 +++++++++++++++++++++++
>  fs/btrfs/volumes.c    |  2 +-
>  3 files changed, 25 insertions(+), 1 deletion(-)
>=20
> --=20
> 2.24.0
>=20

--+QmoJrblcRudFCJH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXehyWAAKCRCB+YsaVrMb
nGemAJ9XMVE7uyBiImMKmxl41YPtD/j3jgCeN6xAMegBvKvdUEX1uUK6v8zVOaY=
=B8lB
-----END PGP SIGNATURE-----

--+QmoJrblcRudFCJH--
