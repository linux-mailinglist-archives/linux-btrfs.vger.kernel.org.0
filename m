Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D1F47A308
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Dec 2021 00:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbhLSXmU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Dec 2021 18:42:20 -0500
Received: from mout.gmx.net ([212.227.15.19]:39923 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229628AbhLSXmT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Dec 2021 18:42:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1639957335;
        bh=bQsorurldhJ3BroaXXWB60MiXGCVIXMXYQG6h7bwURU=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=YMVj7yFAfpXl4jyPlC/qXpuRlowcFijq4Hi3SYXvmW0ijOnrzPPme24iZDxfmQxMu
         3ALUJ1w3FAvP5yh7+vbccQM6Yuqa2BYAAkFZo8q/An4QpFhS3ZxeFpMaPhv5HNa4TC
         INRK3Gt3p0iDUmNRRGLnT5JyQoKnGg5/V5dnUWzo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M9FjR-1msmor1rHj-006Mf9; Mon, 20
 Dec 2021 00:42:15 +0100
Message-ID: <5d598d12-9f14-5783-f8fb-dcb1ebb7d9de@gmx.com>
Date:   Mon, 20 Dec 2021 07:42:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Tuetuopay <tuetuopay@me.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <6CD45090-C29D-4508-98CB-36A0C7958E35@getmailspring.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: btrfs_free_extent
In-Reply-To: <6CD45090-C29D-4508-98CB-36A0C7958E35@getmailspring.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZJpvMBqKcXLXBWp826hfhg+TIzpOKsPWPl5c1taPBSf7REPQpab
 g4pLDc8Ry+67DFL5UxRkmfymqfBkrKlYDBPfvzSA4lMY2E9pI9EOaJHpicQjvr629NgX9uC
 wzsppqUvQ4N5Qvr5OC+7L7mVoLbSQM67SOel3BEJXLEQjQ3vGOOTZq9BJucaFgw94AV0Xr4
 CqPh1oUsuW9Sy/OOm6bdQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/1Ku02XOv/A=:GOcB6i3bMVDhySL3VF2vKD
 /5up2DVNll3g8ioh9KAmIq9OTqw9kmD5pubHoK0qZiZE1xz/sanLnthoA+9WCd3QKfvLKmAnh
 UhpNZw366U5RKKV/y8mSbnZr7Qb/hlUCNo8pAqmpuWiyuilL5FaOgDHJVwjMXTTjzW4b5nL1+
 zEueloSQiprzbiCXFcSwfTeZp/XA3rNtDz+5hEGnOdfVKLHV0sgodDU7XwB8xeIdBNNAbLOOc
 nUPMbvUGS3IwFVDeUYQsMv2djZdf1JkYVDXw6ABhUQ1o14YKLgrPL3fhPGRKqlM9/c13X+/vA
 AGbYIbymTDcF3KbuPNymvb2CsHyGh/zntw9fUYRUvt02nhMUbl2DzromDwrzl/5SNlovcRZ5O
 jPrW23ELWEMkO+OYtkYDJkgWef3lA1/Bn/vT/uUEqo8TEibyHol7EfJGfQUuZ7SUFEPsDz6Tb
 y+spJJi1QcgdUQlV2tS7Y4h7aqFC8BzVyo3s19HP/NS7OxlNMVrKncgis97zB9YgmeyvlKyzj
 QSJY9Pa2uCqeIWGLnQBtFge2nVLZcjys0i18qVrywVJ0hUnpyXd1uAKEnjckLuwA/emeNzzxY
 Bz+443zMexB1rtisMMUf0h8qQzVePKgaqQoBbW1PqgRWHi8XjQ2RzD6c6m6yvhBdrSTXPtMNx
 5gd9+hjtURkfYnWeVfv9c+sASdnzuuuvtvtaHZtdjQUMQHSxNF/0UZUIUYeD8hm9BDhzIj5HB
 OYrOYKGJ2oo6XQ4wVUS0UKM6TTsQj6ow4EaI0Qk7nni8Iax1UYvWJg3bFdN1e8OkgKm4nTYL3
 81Lcv5KmQFiUGMnAED5lDPv8sX7rznodsDuQE9me/NCwLG7KUN4maJR3UM09MQlwVPmbZMkzp
 ZAqAcrzD/2mkNfxa6Pt02DmeQGcjahCWpBcUTMOH4luhkuzGmli04pVvk48h+1miDEgj59Enb
 BAD6rWOs7xr6dT7MQhM/r5fkI5d2Cl7mThjt1LkaolYc3svdO6IPf4fCDQhyZQIK7sxw/igoc
 AF/iUyTj0jXUgU4Pd1Rg5IcnSBAOAA8DaiuFypMbcMrBvnDoX0swH9QrjkY2HpgYbsQhsiqtg
 tfg7nK42H3fwqA=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/12/19 23:24, Tuetuopay wrote:
> Hi,
>
> I need some advice on a btrfs raid-1 volume that shows a few corruptions
> on some places. I have some files that triggered some safeguards on
> write, which ended up remounting the fs as read-only.
>
> Over on IRC, multicore suggested me to run a readonly check, whose
> output is here:
>
> # btrfs check --readonly
> /dev/disk/by-uuid/e944a837-f89b-48ea-80fd-40b2bec8f21b
> Opening filesystem to check...
> Checking filesystem on /dev/disk/by-uuid/e944a837-f89b-48ea-80fd-40b2bec=
8f21b
> UUID: e944a837-f89b-48ea-80fd-40b2bec8f21b
> [1/7] checking root items
> [2/7] checking extents
> tree backref 9882747355136 root 7 not found in extent tree
> backref 9882747355136 root 23 not referenced back 0x556ea3cb07d0

This is one corruption in extent tree, we don't have root 23 at all.
Only root 7 is correct.

On the other hand, 23 =3D 0x17, while 7 =3D 0x07.

So, see a pattern here?

Thus recommend to memtest to make sure it's not a memory bitflip causing
the corruption in the first hand.

> incorrect global backref count on 9882747355136 found 2 wanted 1
> backpointer mismatch on [9882747355136 16384]
> ERROR: errors found in extent allocation tree or chunk allocation
> [3/7] checking free space cache
> [4/7] checking fs roots
> root 5 inode 1626695 errors 40000
> Dir items with mismatch hash:
> 	name: fendor.qti.hardware.sigma_miracast@1.0-impl.so namelen: 46 wanted
> 0x12c67915 has 0x0471bc31
> root 5 inode 1626696 errors 2000, link count wrong
> 	unresolved ref dir 1626695 index 2 namelen 46 name
> vendor.qti.hardware.sigma_miracast@1.0-impl.so filetype 1 errors 1, no
> dir item

This can also be caused by memory bitfip.

Fortunately, both cases should be repairable.
But that should only be done after you have checked your memory.
You won't want to have unreliable memory which can definitely cause more
damage during repair.

But it's still better to keep important data backed up.

> ERROR: errors found in fs roots
> found 6870080626688 bytes used, error(s) found
> total csum bytes: 6668958308
> total tree bytes: 9075539968
> total fs tree bytes: 1478344704
> total extent tree bytes: 243793920
> btree space waste bytes: 820626944
> file data blocks allocated: 326941710356480
>   referenced 6854941941760
>
> They suggested that I run a non-ro check, but warned that it could do
> more harm than good, hence this email seeking advice. Has check any
> chance to fix the issue?
>
> I think I should also mention that I'm fine deleting those specific
> files as I can get them back somewhat easily.
>
> To finish off, here is the information requested by the wiki page:
>
> $ uname -a
> Linux gimli 5.10.70-3ware #1 SMP Wed Dec 15 03:46:13 CET 2021 x86_64 GNU=
/Linux

One thing to mention is, if you're running kernel newer than v5.11, the
last corruption (the one on name hash mismatch) can be detected early,
without writing the corrupted data back to disk.

Thus it's recommended to use newer kernel.

Thanks,
Qu

> $ btrfs fi show
> Label: none  uuid: 381bd0ef-20cb-4517-b825-d45630a6ca0a
> 	Total devices 1 FS bytes used 65.49GiB
> 	devid    1 size 111.79GiB used 111.79GiB path /dev/sdk1
>
> Label: 'storage'  uuid: e944a837-f89b-48ea-80fd-40b2bec8f21b
> 	Total devices 5 FS bytes used 6.25TiB
> 	devid    1 size 2.73TiB used 2.50TiB path /dev/sdd
> 	devid    2 size 2.73TiB used 2.50TiB path /dev/sdc
> 	devid    4 size 931.51GiB used 702.00GiB path /dev/sdf
> 	devid    6 size 3.64TiB used 3.41TiB path /dev/sdg
> 	devid    7 size 3.64TiB used 3.41TiB path /dev/sdh
>
> $ btrfs fi df /media/storage
> Data, RAID1: total=3D6.25TiB, used=3D6.24TiB
> System, RAID1: total=3D32.00MiB, used=3D944.00KiB
> Metadata, RAID1: total=3D10.00GiB, used=3D8.45GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
> $ btrfs --version
> btrfs-progs v5.10.1
>
> The dmesg is attached to the email, but most of the `BTRFS critical` log
> lines related to name corruption have been removed to get the file to 20=
0KB.
>
> Some things to note:
> - I recently upgraded the machine from Debian 9 to 11, getting the
> kernel from 4.9 to 5.10, but the issue already existed on 4.9 (it even
> started there, prompting me to replace a drive as I though it to be the
> source of the corruption).
> - The kernel is almost the vanilla debian bullseye kernel, with an added
> (tiny) patch to fix an issue between 3Ware RAID cards and AMD Ryzen
> CPUs. It should not affect the BTRFS subsystem as it adds a quirk to the
> PCIe subsystem.
> - I have a few name mismatches, which can be seen in the logs too. While
> I'd love someday to get rid of them, I simply moved the affected files
> in a corner for now. That's not the issue I'm trying to solve now
> (though if someone can help, I'd be glad). They come from a ZIP archive,
> so deleting them is fine, but I can't as I only get "Input/Output error"
> when trying to rm them.
>
> Thank you very much to whoever can help!
