Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51DF512B490
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Dec 2019 13:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfL0Mj7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Dec 2019 07:39:59 -0500
Received: from mars1.mruiz.dev ([167.71.125.59]:52842 "EHLO mars1.mruiz.dev"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfL0Mj7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Dec 2019 07:39:59 -0500
Received: from archlinux.localnet (unknown [66.115.176.21])
        by mars1.mruiz.dev (Postfix) with ESMTPSA id 0E5CE40FFD
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Dec 2019 12:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mruiz.dev; s=201908;
        t=1577450399; bh=kAp3hbPjybcqdrQLaMqkBO5HznwOy9b4duaau3g6x1g=;
        h=From:To:Subject:Date:From;
        b=Ak+v8ZPbxndBTW6I9gTQ49zCc2vcbPSQTZ0vn0P9wUuCzh8/mOLzz3oiKUaSSR1Xc
         mHuaRtoHoHiUXpoWsXIHDxTvhwDmmR0SDAmf5L5JB/ja9GX3cCNpQBOJa8Td3LhQUR
         zwUMg6g78eMBGKkeqnYpcGJTtvjcMwYqvrU//q4wuoty3xxrt7yuKU22j+vgG4xdpp
         n8Y43FuuJOxPrqHNnUYdDCQ10FJ+hAXPRBxMG631kp8BjjQF7FQ6MtBGhq5XAm33LC
         AhaY/5sOfhjeUSKj5fDawS+HAbe7aKNeSWpTxIKIsUkOu4lJaxwZiFOwCQLCoMThDJ
         PmSi4mITj1sQA==
From:   Michael Ruiz <michael@mruiz.dev>
To:     linux-btrfs@vger.kernel.org
Subject: Error during balancing '/': Input/output error
Date:   Fri, 27 Dec 2019 04:39:56 -0800
Message-ID: <4196932.LvFx2qVVIh@archlinux>
Organization: mruiz.dev
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2136160.ElGaqSPkdT"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--nextPart2136160.ElGaqSPkdT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

I recently did a btrfs-convert from ext4 to btrfs and it went well, so I 
deleted the ext2 'home-backup' or whatever subvolume it created and I 
proceeded to balance the disk. However, I keep getting this error when I try 
to run this command (see bottom of message for debug info.) This might be a 
simple question, but I am worried that my root drive is corrupt and if I 
restart it might not boot so I haven't tried rebooting and mounting the disk 
from a live usb. Any suggestions pointing me in the right direction are most 
appreciated.


Thanks,
Michael

``` BEGIN DEBUG INFO ```
[michael@linux /]$ sudo btrfs balance /
ERROR: error during balancing '/': Input/output error
There may be more info in syslog - try dmesg | tail

[michael@linux /]$ dmesg | tail
[ 1235.433416] BTRFS info (device dm-1): relocating block group 265709158400 
flags metadata
[ 1375.701515] BTRFS info (device dm-1): found 65034 extents
[ 1381.270271] BTRFS info (device dm-1): relocating block group 264635416576 
flags metadata
[ 1483.628290] BTRFS info (device dm-1): found 64995 extents
[ 1485.160174] BTRFS info (device dm-1): relocating block group 253562454016 
flags data
[ 1485.352336] BTRFS warning (device dm-1): csum failed root -9 ino 265 off 
1048576 csum 0x9a7afaa8 expected csum 0x63e15594 mirror 1
[ 1485.353008] BTRFS warning (device dm-1): csum failed root -9 ino 265 off 
1048576 csum 0x9a7afaa8 expected csum 0x63e15594 mirror 1
[ 1485.375271] BTRFS info (device dm-1): balance: ended with status: -5
[ 1485.544838] audit: type=1106 audit(1577448716.970:152): pid=4178 uid=0 
auid=1000 ses=1 msg='op=PAM:session_close 
grantors=pam_limits,pam_unix,pam_permit acct="root" exe="/usr/bin/sudo" 
hostname=? addr=? terminal=/dev/pts/2 res=success'
[ 1485.545220] audit: type=1104 audit(1577448716.970:153): pid=4178 uid=0 
auid=1000 ses=1 msg='op=PAM:setcred grantors=pam_unix,pam_permit,pam_env 
acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/2 
res=success'
``` END DEBUG INFO ```


--nextPart2136160.ElGaqSPkdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5lRECE0UfhBqjDUbhv/EZtxrWIFAl4F+5MACgkQbhv/EZtx
rWIHMAgAhdL/B7Cpu3mVRm6eSuunVfYspFHv5V0Wnx3Rgl+lwMVRqwzFkcgI2Mn/
RkycnLK69FxBYNNEFqznqQDBS/q562aRaQIF0vyH7CctqJJ+CjfivIriWnK0B4K4
mLL4nS/ZtXxxWjwLQ2rsGytFhoAhcpDXSohTmTsYxGFalBHuZQSgCuLbXNBe7DqP
jyUxqZimByt+fJGirycpnBLcmmelYMMAS7PreVXQyCDoRmoayl93Xx0rIxfHW1Xy
37luKssjiI1NvR6oP2RcdKic+Yp6SVah6xtVjpwgi/V2UGavsPp0mTYNkwxVbPRP
ikFleJ3GOr+8JHI4k1n0pXKi+dM98Q==
=3Mi8
-----END PGP SIGNATURE-----

--nextPart2136160.ElGaqSPkdT--



