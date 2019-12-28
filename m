Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D52F612BD78
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Dec 2019 12:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfL1LpR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 28 Dec 2019 06:45:17 -0500
Received: from mars1.mruiz.dev ([167.71.125.59]:53122 "EHLO mars1.mruiz.dev"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbfL1LpR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 Dec 2019 06:45:17 -0500
Received: from archlinux.localnet (unknown [66.115.176.23])
        by mars1.mruiz.dev (Postfix) with ESMTPSA id 5B45940728;
        Sat, 28 Dec 2019 11:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mruiz.dev; s=201908;
        t=1577533516; bh=KDW5mltv0NhuJ5FomZj2kWiA7PIbceiMP7IMxP2QhEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BQXhhVj1LwJq6tN8X6zpJFNzkim6muEQADbKBBVahaPC5PkOtdOvA8aw2RPfg68Np
         lV8puRwklp5Hr9s5cZNUysuYlHAdJwQskLNg75adND+iCtw/EjwT5XFLZ4M1wm7yiK
         KOB0QEewA1dmoD98cK9gfOelyUTp3iRHRmDgAJluVZrHqCgmGkzOOK/+GxaVF7/Hhc
         uApAQ4R3S/fTEjO2Pq1PFAIe2NzdnsGEed1yNeatJf9pCrLVqf3Y7Y6BhSXaEWVXRk
         4TzXjkUoVY5sp1BqhgsvksOPRTXf4B9wVvgnrHoH65l2sJpkXU38op0N92aXZOlYZP
         e3j3/hu3oUYPQ==
From:   Michael Ruiz <michael@mruiz.dev>
To:     linux-btrfs@vger.kernel.org
Cc:     quwenruo.btrfs@gmx.com
Subject: Re: Error during balancing '/': Input/output error
Date:   Sat, 28 Dec 2019 03:45:05 -0800
Message-ID: <3499056.kQq0lBPeGt@archlinux>
Organization: mruiz.dev
In-Reply-To: <c6a2b628-66b4-6bcb-7af5-48f1edb65522@gmx.com>
References: <4196932.LvFx2qVVIh@archlinux> <9620299.nUPlyArG6x@archlinux> <c6a2b628-66b4-6bcb-7af5-48f1edb65522@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3274091.iIbC2pHGDl"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--nextPart3274091.iIbC2pHGDl
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, December 28, 2019 3:38:48 AM PST you wrote:
> 
> Dmesg please, as that shows which file(s) is involved.
> 
> Thanks,
> Qu

Sure thing, it appears they are all from firefox cache.. Perhaps they are 
failing checksum because they were modified since I converted the partition 
earlier this week? I'm just guessing. Would you reccomend deleting these files 
manually or running btrfs check?
Thanks

``` BEGIN DMESG OUTPUT ```
[ 5638.996798] BTRFS warning (device dm-1): checksum error at logical 
253563510784 on dev /dev/mapper/volgroup0-lv_root, physical 85319491584, root 
5, inode 6477931, offset 8192, length 4096, links 1 (path: home/
michael/.mozilla/firefox/default/storage/default/https+++www.pinterest.com/
cache/morgue/16/{b696bf53-d26a-48eb-9688-ab3c5fd49010}.final)
[ 5638.996805] BTRFS warning (device dm-1): checksum error at logical 
253563502592 on dev /dev/mapper/volgroup0-lv_root, physical 85319483392, root 
5, inode 6477931, offset 0, length 4096, links 1 (path: home/michael/.mozilla/
firefox/default/storage/default/https+++www.pinterest.com/cache/morgue/16/
{b696bf53-d26a-48eb-9688-ab3c5fd49010}.final)
[ 5638.996808] BTRFS error (device dm-1): bdev /dev/mapper/volgroup0-lv_root 
errs: wr 0, rd 0, flush 0, corrupt 17, gen 0
[ 5638.996812] BTRFS error (device dm-1): unable to fixup (regular) error at 
logical 253563510784 on dev /dev/mapper/volgroup0-lv_root
[ 5638.996815] BTRFS error (device dm-1): bdev /dev/mapper/volgroup0-lv_root 
errs: wr 0, rd 0, flush 0, corrupt 18, gen 0
[ 5638.996818] BTRFS error (device dm-1): unable to fixup (regular) error at 
logical 253563502592 on dev /dev/mapper/volgroup0-lv_root
[ 5638.997338] BTRFS warning (device dm-1): checksum error at logical 
253563506688 on dev /dev/mapper/volgroup0-lv_root, physical 85319487488, root 
5, inode 6477931, offset 4096, length 4096, links 1 (path: home/
michael/.mozilla/firefox/default/storage/default/https+++www.pinterest.com/
cache/morgue/16/{b696bf53-d26a-48eb-9688-ab3c5fd49010}.final)
[ 5638.997344] BTRFS error (device dm-1): bdev /dev/mapper/volgroup0-lv_root 
errs: wr 0, rd 0, flush 0, corrupt 19, gen 0
[ 5638.997348] BTRFS error (device dm-1): unable to fixup (regular) error at 
logical 253563506688 on dev /dev/mapper/volgroup0-lv_root
[ 5638.997526] BTRFS warning (device dm-1): checksum error at logical 
253563514880 on dev /dev/mapper/volgroup0-lv_root, physical 85319495680, root 
5, inode 6477931, offset 12288, length 4096, links 1 (path: home/
michael/.mozilla/firefox/default/storage/default/https+++www.pinterest.com/
cache/morgue/16/{b696bf53-d26a-48eb-9688-ab3c5fd49010}.final)
[ 5638.997531] BTRFS error (device dm-1): bdev /dev/mapper/volgroup0-lv_root 
errs: wr 0, rd 0, flush 0, corrupt 20, gen 0
[ 5638.997533] BTRFS error (device dm-1): unable to fixup (regular) error at 
logical 253563514880 on dev /dev/mapper/volgroup0-lv_root
[ 5638.998086] BTRFS warning (device dm-1): checksum error at logical 
253563518976 on dev /dev/mapper/volgroup0-lv_root, physical 85319499776, root 
5, inode 6477931, offset 16384, length 4096, links 1 (path: home/
michael/.mozilla/firefox/default/storage/default/https+++www.pinterest.com/
cache/morgue/16/{b696bf53-d26a-48eb-9688-ab3c5fd49010}.final)
[ 5638.998097] BTRFS error (device dm-1): bdev /dev/mapper/volgroup0-lv_root 
errs: wr 0, rd 0, flush 0, corrupt 21, gen 0
[ 5638.998101] BTRFS error (device dm-1): unable to fixup (regular) error at 
logical 253563518976 on dev /dev/mapper/volgroup0-lv_root
[ 5638.998542] BTRFS warning (device dm-1): checksum error at logical 
253563523072 on dev /dev/mapper/volgroup0-lv_root, physical 85319503872, root 
5, inode 6477931, offset 20480, length 4096, links 1 (path: home/
michael/.mozilla/firefox/default/storage/default/https+++www.pinterest.com/
cache/morgue/16/{b696bf53-d26a-48eb-9688-ab3c5fd49010}.final)
[ 5638.998551] BTRFS error (device dm-1): bdev /dev/mapper/volgroup0-lv_root 
errs: wr 0, rd 0, flush 0, corrupt 22, gen 0
[ 5638.998554] BTRFS error (device dm-1): unable to fixup (regular) error at 
logical 253563523072 on dev /dev/mapper/volgroup0-lv_root
[ 5638.998975] BTRFS warning (device dm-1): checksum error at logical 
253563527168 on dev /dev/mapper/volgroup0-lv_root, physical 85319507968, root 
5, inode 6477931, offset 24576, length 4096, links 1 (path: home/
michael/.mozilla/firefox/default/storage/default/https+++www.pinterest.com/
cache/morgue/16/{b696bf53-d26a-48eb-9688-ab3c5fd49010}.final)
[ 5638.998981] BTRFS error (device dm-1): bdev /dev/mapper/volgroup0-lv_root 
errs: wr 0, rd 0, flush 0, corrupt 23, gen 0
[ 5638.998984] BTRFS error (device dm-1): unable to fixup (regular) error at 
logical 253563527168 on dev /dev/mapper/volgroup0-lv_root
[ 5638.999356] BTRFS warning (device dm-1): checksum error at logical 
253563531264 on dev /dev/mapper/volgroup0-lv_root, physical 85319512064, root 
5, inode 6477931, offset 28672, length 4096, links 1 (path: home/
michael/.mozilla/firefox/default/storage/default/https+++www.pinterest.com/
cache/morgue/16/{b696bf53-d26a-48eb-9688-ab3c5fd49010}.final)
[ 5638.999362] BTRFS error (device dm-1): bdev /dev/mapper/volgroup0-lv_root 
errs: wr 0, rd 0, flush 0, corrupt 24, gen 0
[ 5638.999366] BTRFS error (device dm-1): unable to fixup (regular) error at 
logical 253563531264 on dev /dev/mapper/volgroup0-lv_root
[ 5638.999592] BTRFS warning (device dm-1): checksum error at logical 
253563535360 on dev /dev/mapper/volgroup0-lv_root, physical 85319516160, root 
5, inode 6477931, offset 32768, length 4096, links 1 (path: home/
michael/.mozilla/firefox/default/storage/default/https+++www.pinterest.com/
cache/morgue/16/{b696bf53-d26a-48eb-9688-ab3c5fd49010}.final)
[ 5638.999596] BTRFS error (device dm-1): bdev /dev/mapper/volgroup0-lv_root 
errs: wr 0, rd 0, flush 0, corrupt 25, gen 0
[ 5638.999598] BTRFS error (device dm-1): unable to fixup (regular) error at 
logical 253563535360 on dev /dev/mapper/volgroup0-lv_root
[ 5638.999861] BTRFS warning (device dm-1): checksum error at logical 
253563539456 on dev /dev/mapper/volgroup0-lv_root, physical 85319520256, root 
5, inode 6477931, offset 36864, length 4096, links 1 (path: home/
michael/.mozilla/firefox/default/storage/default/https+++www.pinterest.com/
cache/morgue/16/{b696bf53-d26a-48eb-9688-ab3c5fd49010}.final)
[ 5638.999866] BTRFS error (device dm-1): bdev /dev/mapper/volgroup0-lv_root 
errs: wr 0, rd 0, flush 0, corrupt 26, gen 0
[ 5638.999869] BTRFS error (device dm-1): unable to fixup (regular) error at 
logical 253563539456 on dev /dev/mapper/volgroup0-lv_root
[ 5692.239308] BTRFS info (device dm-1): scrub: finished on devid 1 with 
status: 0
``` END DMESG OUTPUT ```
--nextPart3274091.iIbC2pHGDl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5lRECE0UfhBqjDUbhv/EZtxrWIFAl4HQDkACgkQbhv/EZtx
rWIh7Qf/Qd6KEOAUz6yPDciD90OXiqeQQkvddwgPSf7BLq06c31dnvx2QkWhVJwX
SJkmRNQw8cEHLSNGZ39suDKpQ/y2PzWQs4CSzV4s8kvWSKAvJKsayowHOs484EzH
u2Nq3CjKz6ZzSmnV8a86OMhRKnZgJ23gaR1+rWUqCjcybdfBsLmTrc+iHJE5/U+M
zTt97tvzTEPt24UNRtTVESWBIJWC2XVg5RGfdkRlnE/YttfWO5OH4PoqP3avOy/B
TkZAD6gUkczqi2Zg9ZbiDrwHiy4J42sYuXwSy68aB/2siLVtb/Uf9pR6EMsfHWEG
tXwqJDbYDp54fWomkSpo893bOPhKUQ==
=4jTV
-----END PGP SIGNATURE-----

--nextPart3274091.iIbC2pHGDl--



