Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC1E614010D
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 01:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbgAQAoU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jan 2020 19:44:20 -0500
Received: from mars1.mruiz.dev ([167.71.125.59]:59778 "EHLO mars1.mruiz.dev"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726378AbgAQAoU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jan 2020 19:44:20 -0500
Received: from archlinux.localnet (unknown [153.18.172.64])
        by mars1.mruiz.dev (Postfix) with ESMTPSA id 0FEC240728;
        Fri, 17 Jan 2020 00:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mruiz.dev; s=201908;
        t=1579221860; bh=Xka5DgdGjlFTFzqrXnyBqJtSm4r1flYhdp553NCNiNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hxVnDOxLfsq0kb2m4lhwlemygvaxt5wyw7ZyTM96OK0FmBSITwhdtki3Bc5HXM8D6
         oVm+spvXo2kEarVrvjBZz3vbA9xvShxXXCl7/D08GkgqOaXhtsbc18e8ZW4bMtoEHh
         U9m4XPT9eo05wzyWOb+UIT6m4X7+1PeXZjnbgtrb2XQRwQX1d4uJqhpy95cAYj8OZc
         64ijRzJIhrMDvq4rDpEqX4IwdLsBbAit5AIqlfWHaNzBn4T9geWHJyuq7jO0/YlLLB
         v1rmYiDjX+znVIqjmzFkl3FJzb9HbDp2Xt2DxpDXRnu2MDLf8oMeO0ksrByPn/zWG0
         9sd8vFTxytAlQ==
From:   Michael Ruiz <michael@mruiz.dev>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Linux swap file not activating after reboot
Date:   Thu, 16 Jan 2020 16:44:18 -0800
Message-ID: <5561753.lOV4Wx5bFT@archlinux>
In-Reply-To: <20200116204329.GA269122@vader>
References: <5318295.DvuYhMxLoT@archlinux> <20200116185539.GZ3929@twin.jikos.cz> <20200116204329.GA269122@vader>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4526103.31r3eYUQgx"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--nextPart4526103.31r3eYUQgx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, January 16, 2020 12:43:29 PM PST you wrote:
> On Thu, Jan 16, 2020 at 07:55:39PM +0100, David Sterba wrote:
> > On Wed, Jan 15, 2020 at 04:34:02PM -0800, Michael Ruiz wrote:
> > > Hi,
> > > 
> > >  I have a //@swap subvolume and i have a swapfile within it. I mount the
> > > 
> > > subvolume like such in fstab:
> > > 
> > > `rw,ssd,nofail,noautodefrag,nodatacow,nodatasum,subvolid=1234,subvol=/@s
> > > wap`
> > > 
> > > It mounts correctly, but 1/15/20 4:20 PM kernel I get:
> > > 
> > > `BTRFS warning (device dm-0): swapfile must not be copy-on-write`
> > 
> > There are two reasons why the message is printed, one is when the file
> > does not have the C attribute and another one when the the existing file
> > extents need to be COWed (same case as if the file is NOCOW and has been
> > snapshotted).
> > 
> > Plain reboot will not change the C attribute, so either there's a
> > snapshot of /@snap or the check of a used swapfile is wrong.
> > 
> > I tested it here, a swapfile that got almost full after a stress test,
> > followed by reboot and swapon (without any change to the file) was ok.
> > 
> > Doing a snapshot and swapon resulted in the message you saw.
> > 
> > After deleting the snapshot and waiting until it gets cleaned, swapon
> > did not activate the file anymore. Filefrag or fiemap don't report any
> > shared extents so here I' expect that the file should be in a valid
> > state for swapon.
> > 
> > Omar, any ideas?
> 
> Hm, we're hitting this check in can_nocow_extent():
> 
>         if (btrfs_file_extent_generation(leaf, fi) <=
>             btrfs_root_last_snapshot(&root->root_item))
> 
> That check was added in 78d4295b1eee ("btrfs: lift some
> btrfs_cross_ref_exist checks in nocow path") as an optimization. Even if
> we comment that out, we'll hit the similar check in
> btrfs_cross_ref_exist():
> 
>         /* If extent created before last snapshot => it's definitely shared
> */ if (btrfs_extent_generation(leaf, ei) <=
>             btrfs_root_last_snapshot(&root->root_item))
> 
> That's not quite right in exactly this case that the snapshot has been
> deleted. Apparently we've been doing unnecessary COW for this case. I'll
> need to think about how to safely avoid these checks without too much of
> a performance hit.
> 
> Thanks for the report!

My solution was to boot into an arch live usb, unlock my dmcrypt partition and 
mount the btrfs partition to /mnt. After that I created a subvolume on the @ 
directory (top level 5) instead of a subvolume of my root (/) partition. 
So now my subvolume layout is like this:

ID 256 gen 45343 top level 5 path @
ID 257 gen 45346 top level 5 path @home
ID 258 gen 45346 top level 5 path @log
ID 259 gen 44303 top level 5 path @srv
ID 260 gen 44650 top level 5 path @pkg
ID 261 gen 45346 top level 5 path @tmp
ID 1607 gen 43963 top level 5 path @swap

The strange thing to me is that I didn't ask for snapshots of this subvolume, 
although I do keep snapshots of my / directory, I was under the impression 
that snapshots would not be recursive and go into the /swap subvolume. I can 
also confirm I had the +C attribute while getting this error. So now I am able 
to mount this subvolume with it's own options, whereas before I guess it 
inherited options from the root dir which has CoW enabled. The problem is now 
resolved by doing this. Thanks for the responses.




--nextPart4526103.31r3eYUQgx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEr70V3EMiSIOlxR/PXLDtxglpeu0FAl4hA1kACgkQXLDtxglp
eu39qwgAgfaYjav2jUiNpnh0fPAMymZ6aUu7nRY/7/PsaminVFMzimaoxAHJomJT
pQrTf/Xp61DJFw9Y2//R1+PC2dxYdqhxB15FySQDyerzWygJc7mcrp/72bpyPkNg
BNe1iW34Fc48c/xrmj/VnGTFnZf2t5AQ9wuLQQQJcUuBSLhhoC8t/cvSgB3mDyPd
/wvSgDzHQygP2OL8WsNjEok+LN3DnW0WLcDvpkRTrlhRsR5/siHBzRTwbS1c9l8w
/FgunoHICmh4ntLdScff4JF9aFDkTqVYFu0Ahe5N4itSj6iyFbdBqIWcc2Ae6FPo
u80SVoUGmliJRI/MDHyKfmHFyUsepA==
=otH2
-----END PGP SIGNATURE-----

--nextPart4526103.31r3eYUQgx--



