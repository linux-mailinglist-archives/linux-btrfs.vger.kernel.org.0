Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3F75FBF0B
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2019 06:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfKNFN0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Nov 2019 00:13:26 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:40502 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfKNFNZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Nov 2019 00:13:25 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id F40FE4D11D7; Thu, 14 Nov 2019 00:13:24 -0500 (EST)
Date:   Thu, 14 Nov 2019 00:13:24 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     dsterba@suse.cz, Neal Gompa <ngompa13@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 0/4] RAID1 with 3- and 4- copies
Message-ID: <20191114051324.GZ22121@hungrycats.org>
References: <cover.1572534591.git.dsterba@suse.com>
 <CAEg-Je_oNz5BtpRAF3fzfX1G-Dhh7yjpshyy47NwLaREWv0wBQ@mail.gmail.com>
 <20191101150908.GU3001@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Z/kiM2A+9acXa48/"
Content-Disposition: inline
In-Reply-To: <20191101150908.GU3001@twin.jikos.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--Z/kiM2A+9acXa48/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 01, 2019 at 04:09:08PM +0100, David Sterba wrote:
> The raid1c34 patches are not intrusive and could be backported on top of
> 5.3 because all the preparatory work has been merged already.

Indeed, that's how I ended up testing them.  I couldn't get the 5.4-rc
kernels to run long enough to do meaningful testing before they locked
up.  I tested with 5.3.8 + patches.

I left out the last patch that removes the raid1c3 incompat flag because
5.3 didn't have the block group tree code to apply it to.

I ran my raid1 and raid56 corruption recovery tests modified for raid1c3.
The first test is roughly:

	mkfs.btrfs -draid1c3 -mraid1c3 /dev/vd[bcdef]
	mount /dev/vdb /test
	cp -a 9GB_data /test
	sync
	sysctl vm.drop_caches=3
	diff -r 9GB_data /test
	head -c 9g /dev/urandom > /dev/vdb
	head -c 9g /dev/urandom > /dev/vdc
	sync
	sysctl vm.drop_caches=3
	diff -r 9GB_data /test
	btrfs scrub start -Bd /test
	sysctl vm.drop_caches=3
	diff -r 9GB_data /test
	btrfs scrub start -Bd /test
	sysctl vm.drop_caches=3
	diff -r 9GB_data /test

First scrub reported a lot of corruption on /dev/vdb and /dev/vdc.  Second
scrub reported no errors.  diff (all instances) reported no differences.

Second test is:

	mkfs.btrfs -draid6 -mraid1c3 /dev/vd[bcdef]
	# rest as above...

Similar results:  first scrub reported many errors as expected.
Second scrub reported no errors.  No diffs.

--Z/kiM2A+9acXa48/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXczicQAKCRCB+YsaVrMb
nHSiAJ0X2IbqXBaROMhsja+VJTwNXp4mIQCffm9ssyr5qxYQ//PfDEZQqD5mhYY=
=oGbg
-----END PGP SIGNATURE-----

--Z/kiM2A+9acXa48/--
