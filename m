Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45CFE466E81
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 01:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345043AbhLCAjQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Dec 2021 19:39:16 -0500
Received: from mout.gmx.net ([212.227.15.18]:50729 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230131AbhLCAjO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Dec 2021 19:39:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638491748;
        bh=FW6EQuvTyzggXVyHk+0JiOzG9v8kuReBKv2fT4sDrsQ=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=c7C8sqYkRcv2sJ2Jhk6JCzg/thoeDQ2vzC8+u7tHn/KV+HnhXs+fSjsr/B8GYN1pk
         JZHtAkDOkkol1MEOoupr0dW918vLYT+jKPVR0wlit974bjVnPWXktCCBKsO2nsxfIr
         UVYnCxOBDUXu6K4sESJ4Q4O+XNrRXdyrydVbh3tQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M9FjR-1myjJd2Jip-006P8u; Fri, 03
 Dec 2021 01:35:48 +0100
Message-ID: <5d21f0d2-7a91-80aa-3b42-31cf65f10a94@gmx.com>
Date:   Fri, 3 Dec 2021 08:35:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: Unable to Mount Btrfs Partition used on Both Funtoo and Windows
Content-Language: en-US
To:     Charlie Lin <CLIN@Rollins.edu>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <DM8P220MB03421444D486BBC29023BE74C1699@DM8P220MB0342.NAMP220.PROD.OUTLOOK.COM>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <DM8P220MB03421444D486BBC29023BE74C1699@DM8P220MB0342.NAMP220.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3ybOBwW9IeDBCGLE/+3yfU1WBi6qvi5bIO2ii9eTWDHm5poAeWA
 r1VQ9HAb437r5s5Bzyxo2EHM9DWRHvYa+T102TDGeSWvxqO4WjKyDdaihV9EnOTLsnn+9gt
 cFevWjMfTE/83L99pT5MJhXcTkLTSQO7euJnwl4rQn8TlIb76i99gESjKqnYtGdLy3AHBSx
 uyEC9LoErEl613JbXPzKQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:z9Tv+SWgVTk=:GsCKggKPkVoAAXRMDMlLjO
 nGF3BXMVrdC0v1cI19dkq1dDHWCsIleWHtAqkXCmmcK+upuE10c6jaWr3rLqHIGk8gwj9/EyD
 IpvwOem8ILqowFAhLunDTUgN0z2tBZIf5gFqRzBxV9eWLk5/nUmYo4tJgB71bKyx6Yox58ipL
 TW0VdIwvW+VwbQCMpQl0Giig8hipRWpmx21fRAF/tRQ4QFa5d/pdImrrMvRDooxmGSlnsyxLv
 hq/vnaazr95DZ2CxkpVMPOCZ5h/SHlepJpfhT6FyK1/z0LQfufkEufAmFC17OdDvoq+7HJ5M9
 Q5Wmj7Yilrjt6ZMzzVTnoIuThXlf2OR2ob8mguv7A7J0EC3Lq+CVMCUbjtnCAsvlbTdLozkOP
 eVgmshMPz2uy9E3BFDZQODBIToiofjsmGHWKJdoUD/e/BsNqkI+Q5JMuvQQrW2/2A365Thsyy
 nzS8aloLEVC9oYxK5Q8tOFZNuIlJR7rh/AnDlE7b/xmNy0SuEa4l70se+RMo6m5Ps3WYjdusL
 0J5f1soW/Jhu1/f5PcN/VoCcJ3OAcu6QpIUAjmzOao4PZMAfwPuR/hTc1+lnQ5+7UNbqMc/hh
 9bAJEs64c4OwByenDSbrOwZcEpopgE2ru8BTPiUULHgz3+uGrTqMp3jLB+icS47ilhvtm+UQM
 pBat4xq5QKi3bABZ/8WzJeu5qBXfy9iAiBnKt2U1mRArurVnzN9DDNsVpqI5N1UuUw6zY5UTx
 jAp47tBtEoidUaLMbuDxbYuGQmQ1HQAddRPZEdQb4O8Rj0HnmwrdHg9MvZAxJWKOwr9P8jSD8
 wI7WLln66npprxeJiyiPb/kLr8Gqy5UME1YzW2gWGpNE0xynBUka+xGxU8uoBhaGLwcEKZIa2
 +ZIErdObDBlz0lFMgYKOA8MmBHWYtO5WNSC1Ppw4BXvBv/9A8y8nXl6UdnUw7qC6BBQO9Cg6M
 pDbyM3cF3Sb61fKNTuB2/6xsnM26vW4hBZFReuKsI0TnyEOjTOhxcX/0374KebbMV95i0Qy4D
 KBZHrCNpjcfKurxS4IOWlrBHqprCNBTIh+zRTUPcyr393nI8g9A/s61V4nGF5w3MATS/bmG97
 E3MwfQhCxRLNa0=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/12/3 03:33, Charlie Lin wrote:
> I have a partition, /dev/nvme0n1p8, that I can't mount on either Funtoo =
or Windows (using winbtrfs) (normally the partition is mounted on /home/sh=
ared). Interestingly btrfs fi show indicates that metadata is present on t=
he partition, but other than that, I'm stuck.
>
> Linux funtur 5.15.3_p1-debian-sources #1 SMP Mon Nov 22 22:10:28 -00 202=
1 x86_64 AMD Ryzen 7 4700U with Radeon Graphics AuthenticAMD GNU/Linux
>
> btrfs-progs v5.9
>
> btrfs fi show:
> Label: none  uuid: 198a8721-446d-4012-a0ce-533328c5b5f7
> 	Total devices 1 FS bytes used 12.79GiB
> 	devid    1 size 70.00GiB used 16.02GiB path /dev/nvme0n1p6
>
> Label: none  uuid: 3fa3cb95-582a-407c-864c-160b47b1f93d
> 	Total devices 1 FS bytes used 684.88MiB
> 	devid    1 size 100.00GiB used 2.02GiB path /dev/nvme0n1p7
>
> Label: none  uuid: b0a63a1a-7f19-4ada-97da-402534ed4ed1
> 	Total devices 1 FS bytes used 1.96GiB
> 	devid    1 size 548.32GiB used 3.02GiB path /dev/nvme0n1p8
>
> btrfs fi df /home:
> Data, single: total=3D1.01GiB, used=3D673.34MiB
> System, single: total=3D4.00MiB, used=3D16.00KiB
> Metadata, single: total=3D1.01GiB, used=3D11.55MiB
> GlobalReserve, single: total=3D3.73MiB, used=3D0.00B
>
> btrfs fi df /:
> Data, single: total=3D15.01GiB, used=3D12.32GiB
> System, single: total=3D4.00MiB, used=3D16.00KiB
> Metadata, single: total=3D1.01GiB, used=3D486.73MiB
> GlobalReserve, single: total=3D36.77MiB, used=3D0.00B
>
> Full dmesg:
[...]
> [    2.676936] BTRFS: device fsid 198a8721-446d-4012-a0ce-533328c5b5f7 d=
evid 1 transid 2047 /dev/nvme0n1p6 scanned by mount (1329)
> [    2.677222] BTRFS info (device nvme0n1p6): flagging fs with big metad=
ata feature
> [    2.677225] BTRFS info (device nvme0n1p6): enabling ssd optimizations
> [    2.677228] BTRFS info (device nvme0n1p6): disk space caching is enab=
led
> [    2.677229] BTRFS info (device nvme0n1p6): has skinny extents
> [    2.681455] BTRFS info (device nvme0n1p6): bdev /dev/nvme0n1p6 errs: =
wr 0, rd 0, flush 0, corrupt 56, gen 0
[...]
> [    5.138240] BTRFS info (device nvme0n1p7): flagging fs with big metad=
ata feature
> [    5.138245] BTRFS info (device nvme0n1p7): enabling ssd optimizations
> [    5.138249] BTRFS info (device nvme0n1p7): disk space caching is enab=
led
> [    5.138250] BTRFS info (device nvme0n1p7): has skinny extents
> [    5.140819] BTRFS info (device nvme0n1p7): checking UUID tree
> [    5.141173] usb 3-4: Found UVC 1.00 device HD User Facing (04f2:b64f)
> [    5.141954] BTRFS info (device nvme0n1p8): flagging fs with big metad=
ata feature
> [    5.141957] BTRFS info (device nvme0n1p8): enabling ssd optimizations
> [    5.141960] BTRFS info (device nvme0n1p8): disk space caching is enab=
led
> [    5.141961] BTRFS info (device nvme0n1p8): has skinny extents
> [    5.142505] BTRFS error (device nvme0n1p8): bad tree block start, wan=
t 1064960 have 0

This shows part of your metadata is wiped/zeroed out, and that's why it
get failed to be mounted.

For this particular partition, it's chunk tree, which is the very
essential tree for all btrfs. No wonder it fails to mount.

> [    5.142515] BTRFS error (device nvme0n1p8): failed to read chunk root
> [    5.142703] BTRFS error (device nvme0n1p8): open_ctree failed
> [    5.169296] BTRFS error (device nvme0n1p6): bad tree block start, wan=
t 2162049024 have 0
> [    5.169315] BTRFS warning (device nvme0n1p6): csum hole found for dis=
k bytenr range [2573238272, 2573242368)
> [    5.169404] BTRFS error (device nvme0n1p6): bad tree block start, wan=
t 2162049024 have 0
> [    5.169421] BTRFS warning (device nvme0n1p6): csum hole found for dis=
k bytenr range [2573242368, 2573246464)
> [    5.169480] BTRFS error (device nvme0n1p6): bad tree block start, wan=
t 2162049024 have 0
> [    5.169485] BTRFS warning (device nvme0n1p6): csum hole found for dis=
k bytenr range [2573246464, 2573250560)
> [    5.169533] BTRFS error (device nvme0n1p6): bad tree block start, wan=
t 2162049024 have 0
> [    5.169538] BTRFS warning (device nvme0n1p6): csum hole found for dis=
k bytenr range [2573250560, 2573254656)

And even for the other partition on the same driver, there are metadata
range being wiped/zeroed out.

If you're not using fstrim/discard, then it looks like a problem for the
NVME drive.

Thanks,
Qu

> [    5.169731] BTRFS warning (device nvme0n1p6): csum failed root 5 ino =
41594 off 0 csum 0x3bcfe7c0 expected csum 0x00000000 mirror 1
> [    5.169736] BTRFS error (device nvme0n1p6): bdev /dev/nvme0n1p6 errs:=
 wr 0, rd 0, flush 0, corrupt 57, gen 0
> [    5.169746] BTRFS warning (device nvme0n1p6): csum failed root 5 ino =
41594 off 4096 csum 0x80c92a82 expected csum 0x00000000 mirror 1
> [    5.169748] BTRFS error (device nvme0n1p6): bdev /dev/nvme0n1p6 errs:=
 wr 0, rd 0, flush 0, corrupt 58, gen 0
> [    5.169753] BTRFS warning (device nvme0n1p6): csum failed root 5 ino =
41594 off 8192 csum 0x96276691 expected csum 0x00000000 mirror 1
> [    5.169755] BTRFS error (device nvme0n1p6): bdev /dev/nvme0n1p6 errs:=
 wr 0, rd 0, flush 0, corrupt 59, gen 0
> [    5.169760] BTRFS warning (device nvme0n1p6): csum failed root 5 ino =
41594 off 12288 csum 0x9ce1a09d expected csum 0x00000000 mirror 1
> [    5.169762] BTRFS error (device nvme0n1p6): bdev /dev/nvme0n1p6 errs:=
 wr 0, rd 0, flush 0, corrupt 60, gen 0
> [    5.169788] BTRFS error (device nvme0n1p6): bad tree block start, wan=
t 2162049024 have 0
> [    5.169793] BTRFS warning (device nvme0n1p6): csum hole found for dis=
k bytenr range [2573238272, 2573242368)
> [    5.169874] BTRFS warning (device nvme0n1p6): csum failed root 5 ino =
41594 off 0 csum 0x3bcfe7c0 expected csum 0x00000000 mirror 1
> [    5.169876] BTRFS error (device nvme0n1p6): bdev /dev/nvme0n1p6 errs:=
 wr 0, rd 0, flush 0, corrupt 61, gen 0
> [    5.169949] BTRFS error (device nvme0n1p6): bad tree block start, wan=
t 2162049024 have 0
> [    5.169955] BTRFS warning (device nvme0n1p6): csum hole found for dis=
k bytenr range [2573238272, 2573242368)
> [    5.170038] BTRFS warning (device nvme0n1p6): csum failed root 5 ino =
41594 off 0 csum 0x3bcfe7c0 expected csum 0x00000000 mirror 1
> [    5.170040] BTRFS error (device nvme0n1p6): bdev /dev/nvme0n1p6 errs:=
 wr 0, rd 0, flush 0, corrupt 62, gen 0
> [    5.221991] Bluetooth: Core ver 2.22
> [    5.222023] NET: Registered PF_BLUETOOTH protocol family
> [    5.222024] Bluetooth: HCI device and connection manager initialized
> [    5.222027] Bluetooth: HCI socket layer initialized
> [    5.222029] Bluetooth: L2CAP socket layer initialized
> [    5.222032] Bluetooth: SCO socket layer initialized
> [    5.225820] usbcore: registered new interface driver btusb
> [    5.234942] bluetooth hci0: firmware: direct-loading firmware qca/ram=
patch_usb_00000302.bin
> [    5.234951] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00=
000302.bin
> [    5.234954] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmw=
are rome 0x302 build 0x111
> [    5.329021] elogind-daemon[2721]: New seat seat0.
> [    5.329853] elogind-daemon[2721]: Watching system buttons on /dev/inp=
ut/event4 (Power Button)
> [    5.330107] elogind-daemon[2721]: Watching system buttons on /dev/inp=
ut/event1 (Power Button)
> [    5.330246] elogind-daemon[2721]: Watching system buttons on /dev/inp=
ut/event3 (Lid Switch)
> [    5.330300] elogind-daemon[2721]: Watching system buttons on /dev/inp=
ut/event2 (Sleep Button)
> [    5.330732] elogind-daemon[2721]: Watching system buttons on /dev/inp=
ut/event0 (AT Translated Set 2 keyboard)
> [    5.330786] elogind-daemon[2721]: Watching system buttons on /dev/inp=
ut/event13 (Acer WMI hotkeys)
> [    5.619785] bluetooth hci0: firmware: direct-loading firmware qca/nvm=
_usb_00000302.bin
> [    5.619791] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [    5.757245] BTRFS error (device nvme0n1p6): bad tree block start, wan=
t 2162049024 have 0
> [    5.757275] BTRFS warning (device nvme0n1p6): csum hole found for dis=
k bytenr range [2573238272, 2573242368)
> [    5.757416] BTRFS warning (device nvme0n1p6): csum failed root 5 ino =
41594 off 0 csum 0x3bcfe7c0 expected csum 0x00000000 mirror 1
> [    5.757427] BTRFS error (device nvme0n1p6): bdev /dev/nvme0n1p6 errs:=
 wr 0, rd 0, flush 0, corrupt 63, gen 0
> [    5.757623] BTRFS error (device nvme0n1p6): bad tree block start, wan=
t 2162049024 have 0
> [    5.757640] BTRFS warning (device nvme0n1p6): csum hole found for dis=
k bytenr range [2573238272, 2573242368)
> [    5.757792] BTRFS warning (device nvme0n1p6): csum failed root 5 ino =
41594 off 0 csum 0x3bcfe7c0 expected csum 0x00000000 mirror 1
> [    5.757804] BTRFS error (device nvme0n1p6): bdev /dev/nvme0n1p6 errs:=
 wr 0, rd 0, flush 0, corrupt 64, gen 0
> [    5.854639] r8169 0000:03:00.0: firmware: direct-loading firmware rtl=
_nic/rtl8168h-2.fw
> [    5.885176] Generic FE-GE Realtek PHY r8169-0-300:00: attached PHY dr=
iver (mii_bus:phy_addr=3Dr8169-0-300:00, irq=3DMAC)
> [    6.049742] r8169 0000:03:00.0 eth0: Link is Down
> [    7.016170] BTRFS error (device nvme0n1p6): bad tree block start, wan=
t 2162049024 have 0
> [    7.016188] BTRFS warning (device nvme0n1p6): csum hole found for dis=
k bytenr range [2575118336, 2575122432)
> [    7.016238] BTRFS warning (device nvme0n1p6): csum hole found for dis=
k bytenr range [2575122432, 2575126528)
> [    7.016441] BTRFS warning (device nvme0n1p6): csum failed root 5 ino =
41658 off 0 csum 0x413c7e41 expected csum 0x00000000 mirror 1
> [    7.016448] BTRFS error (device nvme0n1p6): bdev /dev/nvme0n1p6 errs:=
 wr 0, rd 0, flush 0, corrupt 65, gen 0
> [    7.016466] BTRFS warning (device nvme0n1p6): csum failed root 5 ino =
41658 off 4096 csum 0xffa7e36a expected csum 0x00000000 mirror 1
> [    7.016471] BTRFS error (device nvme0n1p6): bdev /dev/nvme0n1p6 errs:=
 wr 0, rd 0, flush 0, corrupt 66, gen 0
> [    7.770761] elogind-daemon[2721]: New session 1 of user lightdm.
> [   11.953107] elogind-daemon[2721]: Removed session 1.
> [   11.971611] elogind-daemon[2721]: New session 2 of user cl.
> [   26.340715] wlan0: authenticate with 34:fc:b9:78:b7:b2
> [   26.393925] wlan0: send auth to 34:fc:b9:78:b7:b2 (try 1/3)
> [   26.394854] wlan0: authenticated
> [   26.404982] wlan0: associate with 34:fc:b9:78:b7:b2 (try 1/3)
> [   26.406375] wlan0: RX AssocResp from 34:fc:b9:78:b7:b2 (capab=3D0x401=
 status=3D0 aid=3D2)
> [   26.409567] wlan0: associated
> [   26.410414] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
>
