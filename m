Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080322DFBA2
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Dec 2020 12:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgLULqS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Dec 2020 06:46:18 -0500
Received: from mout.gmx.net ([212.227.17.21]:33221 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbgLULqR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Dec 2020 06:46:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608551083;
        bh=g0FC4mt8u04GPoJG0f0FzlEhaDs9UaU+4gC5lHAviOo=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=AQdSmHPc12Omkh9Os1vsEol8JbEbg3FwVdN6hQKWRCke5VY2HGhYbMD5hmqiGAwZT
         VvGK/LgIGindGjJ9rh/lGalgieJhevNCm/eFdBMpF8YF41jYLWSX00WmoqtUvftMpz
         IYUqJ7ECXaa2pJaqCUvoDOWoCqxiWzyINDH5qhqU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MdefJ-1kIFul2BMH-00ZcBW; Mon, 21
 Dec 2020 12:44:43 +0100
To:     "Nik." <btrfs@avgustinov.eu>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <6f36a628-21f9-ca21-bae3-2a4150245ec2@avgustinov.eu>
 <0e4cb41f-c1bf-539a-dc19-8df234e0d0e7@avgustinov.eu>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Fwd: "BTRFS critical: ... corrupt leaf" due to defective RAM
Message-ID: <296aa513-1ac8-2242-b7fa-1aa082a6e554@gmx.com>
Date:   Mon, 21 Dec 2020 19:44:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <0e4cb41f-c1bf-539a-dc19-8df234e0d0e7@avgustinov.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WHSXcufaQ31TasS6xHXQrSqFoVoRtClDwxuNwpcC0GWP6ZSM5g9
 6/T+0bJs+9aIqitNq+JLH/PfdFPPvuYKaYF2XmxqUkQjwshTmBAbqeMW3LOTHDv7tFz3OFn
 M1qffClhAifHYwYuOQlLKxOHDfwUds8l4NTuKDd6d9xGn7fRsA9RNk34G+0jU4KVIKJlb0o
 2P9iykkmcid8+hMetuLmw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VsnrbLzFEpU=:fQ/oqYd70ndsRbG06AgGaa
 mNrr+KiT5WThbQtnwdQngoljEJdboQn4ZmYCXLNUaGXIuwWTFHVeY6pn9sySVLWsdzLvD+E76
 nCmCfhgbMuqPGEbI2ZPatshtjXGBFwI9/+VflXp32FSOzhyaTSgsV2EmSTazesjQJ8YD2XQLP
 ZccxnKJKrwueeHyW/+nItJERUl92vFXyj/GYvoygyAijkuQbePJe4oKDw5jABNINhQGm5Nxe6
 YUjFkUcl3qEBpal2vWw7i2lN0a+Mlm/lE0JWPLgLSMJ9Wm88XpsJO8LbrUJMath2K17ooYTr7
 GBhCOn7lVs60P2x1uPe06Bv/OmrFjj6NFbqwhuWbqxBDgmjlcPRUPTfp2YSuQ5IxjCMJaPGBY
 RD0akWfk7tl5FsBy1lgri2nvacBbgpx6dICKnPd7+SWrfMJoyH/wCctcpexZLiB9Lgk82zTWD
 DKlYOU2mGzXGZgBOFD+PuqlDH+KHZQ2yAogADyxWAogYIGVfPw5GEOx9a1rPTDGZ0ZhsKDFK6
 QkZeh6FNvSBYKirieiBnUe/acVbmzqxr67kalXqn6i4swA1CVbRg3Wv/ZFQDXtPqksopmh0sn
 XzZVNcEtLL1jQn+7U3DZCdjlTUSlELFiq6DXx5QMR0xVE8oBN9+/MW3urlRr8VrOUvbIEPjOv
 lK8+rOygPOFotzMxsfGgFQMBKiIQ//FEl+AV+T6PRQVGwtmbG1MoDGvXyHLcryp5OqhFZuri2
 WFt7RoS8LCZMprK5ngpUzYXP+sjT6QCSAtrHp6Xk33HRKwy482mdm0DCcvd18oRvHiSGtp9Lk
 YAOwOowg7KcOem0cnTI6PeOggnvHmltsdbTplUZR9lmav2a0GlI4YNitE2BP/Z4eRnTgGZS/7
 NBBGbDPZYN00VQhhIMOw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/12/21 =E4=B8=8B=E5=8D=886:08, Nik. wrote:
> Dear all,
>
> the forwarded mail below came back yesterday with the error
> "Diagnostic-Code: X-Postfix; TLS is required, but was not offered by
> host vger.kernel.org[23.128.96.18]".
>
> Is it really intended that your mail server does not offer TLS?

Can't help on that, not a vger manager nor know anything. (Most if not
all kernel mail lists are hosted by vger, each mail list can't do much)

But I can definitely answer some of your btrfs problem.
>
> Kind regards,
>
> Nik.
>
> --
>
> 15.12.2020 18:40, Nik.:
>> Dear all,
>>
>> after almost a year without problems I need again your advice about
>> the same computer, but this time it is (hopefully only) the root FS
>> that failed. I have backups of everything except a couple of files in
>> /etc, so nothing critical, but probably it would be interesting for
>> somebody to see how behaved btrfs in such a situation.
>>
>> The story in short:
>>
>> - the FS switched to ro mode. Initially I thought that it is due to
>> insufficient free space (have already had similar situations) and
>> deleted some old snapshots. Within half a day it happened 3 more
>> times, though.

Any detailed report on that RO?
We should have it addressed upstream, if you still hit that, I guess we
need more investigation (if it's not caused by memory corruption)

>>
>> - so I booted in memtest86 and it gave me a lot of errors! This NAS is
>> 9 years old and I was already looking for replacement, but it is not
>> easy to find 8-bay NAS for 2,5" drives...
>>
>> - took the drive out from the failed system and tried to mount it on
>> another (healthy?) PC. I am getting:
>>
>> root@ubrun:~# mount -t btrfs -o subvol=3D@ /dev/sdb1 /mnt/sd
>> mount: /mnt/sd: wrong fs type, bad option, bad superblock on
>> /dev/sdb1, missing codepage or helper program, or other error.
>> root@ubrun:~# dmesg |tail
>> [=C2=A0=C2=A0 50.672561] Policy zone: Normal
>> [=C2=A0 185.190764] BTRFS info (device sdb1): disk space caching is ena=
bled
>> [=C2=A0 185.190767] BTRFS info (device sdb1): has skinny extents
>> [=C2=A0 185.199331] BTRFS info (device sdb1): bdev /dev/sdb1 errs: wr 0=
, rd
>> 0, flush 0, corrupt 65, gen 0
>> [=C2=A0 185.246051] BTRFS critical (device sdb1): corrupt leaf:
>> block=3D50850988032 slot=3D79 extent bytenr=3D50496929792 len=3D16384 u=
nknown
>> inline ref type: 54

This is indeed some memory bitflip, and your initial kernel is not newer
enough to detect it at write time.

If using newer enough kernel, such corrupted metadata shouldn't even
reach disk. (Although it still means you will get the fs RO)

There are only 4 valid types for extent refs:

TREE_BLOCK_REF	 176(0xb0)
EXTENT_DATA_REF  178(0xb2)
SHARED_BLOCK_REF 182(0xb6)
SHARED_DATA_REF  184(0xb8)

The invalid type is:

                   54(0x36)

The diff is 0x80 to SHARED_BLOCK_REF, indeed one bit flipped.

>> [=C2=A0 185.246055] BTRFS error (device sdb1): block=3D50850988032 read=
 time
>> tree block corruption detected
>> [=C2=A0 185.247070] BTRFS critical (device sdb1): corrupt leaf:
>> block=3D50850988032 slot=3D79 extent bytenr=3D50496929792 len=3D16384 u=
nknown
>> inline ref type: 54
>> [=C2=A0 185.247073] BTRFS error (device sdb1): block=3D50850988032 read=
 time
>> tree block corruption detected
>> [=C2=A0 185.247093] BTRFS error (device sdb1): failed to read block gro=
ups: -5
>> [=C2=A0 185.281382] BTRFS error (device sdb1): open_ctree failed
>> root@ubrun:~#
>>
>> How should one proceed?

Since it's caused by bitflip and you mentioned the system has tons of
memory error, I believe there will be tons of similar problems
scattering around your fs.

For repair, I don't really believe btrfs-check can or will be able to
fix any bitflip, not to mention so many possible more bitflips.

It's better just to use your backup.

BTW, for detection for extent tree bitflip is introduced in v5.4.
Next time at least you can catch the faulty hardware before it screws up
your data.

Thanks,
Qu

>>
>> Kind regards
>>
>> Nik.
>>
