Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6270147B628
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Dec 2021 00:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbhLTXU5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Dec 2021 18:20:57 -0500
Received: from mout.gmx.net ([212.227.17.21]:54923 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230055AbhLTXU5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Dec 2021 18:20:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1640042452;
        bh=UIvOjVyCIgHqBiGg/J80P9ssMC/R8rJU0+wQCiYlGWk=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=BFOOUfTvTvfHe7s7ri+sRdTX2dWC89k4vuNOw4OafamJQTBvedqmxnP0pXO/9ABoH
         pdmCPhpOPKumyhBE+4TKnZN4GK35bw/ns5vF2hGP7GWn2C3XmWNvtPFTwzHM+23ZAn
         CYSHBh1ZxofwFy2m7EFSFvYPk4pvaGIAxu8RrYSM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mn2aN-1maafs2EdD-00kBju; Tue, 21
 Dec 2021 00:20:52 +0100
Message-ID: <ce91d387-78e0-3e8e-fd05-a3f952352e73@gmx.com>
Date:   Tue, 21 Dec 2021 07:20:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: btrfs_free_extent
Content-Language: en-US
To:     Tuetuopay <tuetuopay@me.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <13D6C56C-97FA-4C92-B756-05C5839B5CC9@getmailspring.com>
 <786664B0-CEB3-48EC-A84B-4EA3BA8A29FE@getmailspring.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <786664B0-CEB3-48EC-A84B-4EA3BA8A29FE@getmailspring.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q1CuW7MGJv1kqKlKOHNJImlKY6AgudF0P0DCSoXEjXFZRA9nOOQ
 MNUX1Q99i1E+rEUyIWvYr26ubK5JN8j2hOVtwYLswkk5dY+QJtoYmqdETl6U1KJYNLM2ZiE
 oYyTlYpKQedrpaDVZ7/u2DIjjOJmUI6J8/HEa75OAPBYlgWM6cZv2oZqTTHKFjnrKAcRenO
 XjkFm1mSqehmbUNm3e/ng==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+A3xGrzwKyo=:e4Ae0N6otkdASUzvwms7pX
 ErEvuKjcriM6CaYuUkalgJS2TB4zsmDp11gsa7DimmWOgvKf+pJG4JXx0OixSFEPPs2yhQ0Zo
 UDpFuhGO+gugYC7LWE0QvL/EWiPxcpNAsiYejYpRFi1AGL81Jip2oSXNHbujWb/6tg8AGhjPO
 EZGpB7xVX5bpkt1OTMufQUyKNRlUdVynrjKRR1y8WBXcfSAIBf6xfnKv2IrFeYH8D9DGc2xav
 9lbaXwuzrdSlfSeK9Mw7yHZ8RuRrqQnkotRUzi2cI79SUtAICAAlIf6L9iyoXA7H5tTDs4pi7
 wLYnhIaYjhVpSMSVdsS/0eAdR4yBu+YoEHp0ofF4rj9IDUbs+LU4pzLU+YK8OtWPqbGPqHkpb
 V7aTV8uaDO/yoWY9/hh3h+EPUdqF1QfC9zu7D6HCKUGxoAR+ylNuGWZsMl9zqw9uTAJ4UT0sb
 SRAv7keDLithIKv2fASebVhz1R4uGRLPsaqnjEg7qNqknTnJa6bubCow8oNHPLSZk7JDHQkG/
 LTomTialVjHd2XrduOXl1r+OWIWqBUWU0/Rf1Zhgiyrha44BCM/v3KEWYOSW2lgkV5zZ8fkZq
 PGb350W1miZgn50VOB0gKFALmEF2DV3Qp06w03Hd50imAzGIyRWksOq7Gg4uy3UD8+vinFTT3
 zJeN8wL1XGnIUR7I92kr6lE8RVz9KzkkHdTgySqBD9FyAz18N/PWMPJ1VhWtckP/lSpLo06P8
 yCx9dYTH0xnCpiQ/3UzehZPYGF/QbFB4mwV/eDlIThOu7//YMsivmm2zE5TI+B0PIuIKWHbDp
 H3CG5uG02Mi5et/eT6UkV+lWg+8G0djZJuLCOSzGWUX1/Rm9gsXb9Q6p/e2UDoP0qf0kNooYv
 ctSAL0P5aTDjUzDD/CnCTpvX/71aXrS0z/CYPsB7D0/RK1TwMjFhHdMTC0BAPhBCTnmzRGcR4
 6IfP1sx6KOzzY3ocs63Y7/cYafUmvp93Vs6ULaL4NCsQqS+NdOBO28rC8GiJnYyhNEMwjrME/
 Ixc50lYPqL8kQ/0AtM0D0i2eu4d51bJtyi79VSzj2jI/QP9JABSTS3o16vXG40XkV86FWvWbS
 gH2nDBaT5Sk7CA=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/12/21 04:30, Tuetuopay wrote:
> Hi,
>
> It's me again. I have completed several memtest86+ passes without errors
> whatsoever, so this RAM can be considered good. Also, following your
> advice, I built and upgraded the kernel to the latest stable, i.e. 5.15.=
10.
>
> What is the next step to (hopefully) fix the error? Is it to run `btrfs
> check` but not in readonly mode. I think I'll need to upgrade
> btrfs-progs too since I'm now running 5.15.10 instead of 5.10.70.

Yes, latest btrfs-progs is always recommended.

After backing up the important data and upgrading btrfs-progs, "btrfs
check --repair" could at least solve the extent tree problem.

Thanks,
Qu
>
> Thank you so much in advance!
>
> Alexis
>
> On d=C3=A9c. 20 2021, at 10:35 am, Tuetuopay <tuetuopay@me.com> wrote:
>> Hi, thanks for the swift reply!
>>
>> On d=C3=A9c. 20 2021, at 12:42 am, Qu Wenruo <quwenruo.btrfs@gmx.com> w=
rote:
>>> On 2021/12/19 23:24, Tuetuopay wrote:
>>>> Hi,
>>>>
>>>> I need some advice on a btrfs raid-1 volume that shows a few corrupti=
ons
>>>> on some places. I have some files that triggered some safeguards on
>>>> write, which ended up remounting the fs as read-only.
>>>>
>>>> Over on IRC, multicore suggested me to run a readonly check, whose
>>>> output is here:
>>>>
>>>> # btrfs check --readonly
>>>> /dev/disk/by-uuid/e944a837-f89b-48ea-80fd-40b2bec8f21b
>>>> Opening filesystem to check...
>>>> Checking filesystem on /dev/disk/by-uuid/e944a837-f89b-48ea-80fd-40b2=
bec8f21b
>>>> UUID: e944a837-f89b-48ea-80fd-40b2bec8f21b
>>>> [1/7] checking root items
>>>> [2/7] checking extents
>>>> tree backref 9882747355136 root 7 not found in extent tree
>>>> backref 9882747355136 root 23 not referenced back 0x556ea3cb07d0
>>>
>>> This is one corruption in extent tree, we don't have root 23 at all.
>>> Only root 7 is correct.
>>>
>>> On the other hand, 23 =3D 0x17, while 7 =3D 0x07.
>>>
>>> So, see a pattern here?
>>>
>>> Thus recommend to memtest to make sure it's not a memory bitflip causi=
ng
>>> the corruption in the first hand.
>>
>> That definitely looks like a bitflip to me.
>>
>>>> incorrect global backref count on 9882747355136 found 2 wanted 1
>>>> backpointer mismatch on [9882747355136 16384]
>>>> ERROR: errors found in extent allocation tree or chunk allocation
>>>> [3/7] checking free space cache
>>>> [4/7] checking fs roots
>>>> root 5 inode 1626695 errors 40000
>>>> Dir items with mismatch hash:
>>>> 	name: fendor.qti.hardware.sigma_miracast@1.0-impl.so namelen: 46 wan=
ted
>>>> 0x12c67915 has 0x0471bc31
>>>> root 5 inode 1626696 errors 2000, link count wrong
>>>> 	unresolved ref dir 1626695 index 2 namelen 46 name
>>>> vendor.qti.hardware.sigma_miracast@1.0-impl.so filetype 1 errors 1, n=
o
>>>> dir item
>>>
>>> This can also be caused by memory bitfip.
>>>
>>> Fortunately, both cases should be repairable.
>>> But that should only be done after you have checked your memory.
>>> You won't want to have unreliable memory which can definitely cause mo=
re
>>> damage during repair.
>>>
>>> But it's still better to keep important data backed up.
>>
>> Yes, definitely a bitflip, f =3D 0x66 and v =3D 0x76.
>>
>>>> ERROR: errors found in fs roots
>>>> found 6870080626688 bytes used, error(s) found
>>>> total csum bytes: 6668958308
>>>> total tree bytes: 9075539968
>>>> total fs tree bytes: 1478344704
>>>> total extent tree bytes: 243793920
>>>> btree space waste bytes: 820626944
>>>> file data blocks allocated: 326941710356480
>>>>    referenced 6854941941760
>>>>
>>>> They suggested that I run a non-ro check, but warned that it could do
>>>> more harm than good, hence this email seeking advice. Has check any
>>>> chance to fix the issue?
>>>>
>>>> I think I should also mention that I'm fine deleting those specific
>>>> files as I can get them back somewhat easily.
>>>>
>>>> To finish off, here is the information requested by the wiki page:
>>>>
>>>> $ uname -a
>>>> Linux gimli 5.10.70-3ware #1 SMP Wed Dec 15 03:46:13 CET 2021 x86_64 =
GNU/Linux
>>>
>>> One thing to mention is, if you're running kernel newer than v5.11, th=
e
>>> last corruption (the one on name hash mismatch) can be detected early,
>>> without writing the corrupted data back to disk.
>>>
>>> Thus it's recommended to use newer kernel.
>>
>> Amazing advice. I'll definitely upgrade the kernel, likely latest.
>>
>>> Thanks,
>>> Qu
>>
>> Thank you very much to you! I just started a full memtest on the
>> machine. I expect it to be good, since the RAM is brand new (just
>> swapped the whole system due to the previous motherboard dying), but yo=
u
>> never know. I'll get back to you with the results!
>>
>> Also, if I can get my hands on a DDR3 system, I'll test the old ram to
>> be sure. If this ends up being a RAM issue, I'll send back the current
>> one and buy some ECC memory.
>>
>> Thanks,
>> Alexis
>>
>>>> $ btrfs fi show
>>>> Label: none  uuid: 381bd0ef-20cb-4517-b825-d45630a6ca0a
>>>> 	Total devices 1 FS bytes used 65.49GiB
>>>> 	devid    1 size 111.79GiB used 111.79GiB path /dev/sdk1
>>>>
>>>> Label: 'storage'  uuid: e944a837-f89b-48ea-80fd-40b2bec8f21b
>>>> 	Total devices 5 FS bytes used 6.25TiB
>>>> 	devid    1 size 2.73TiB used 2.50TiB path /dev/sdd
>>>> 	devid    2 size 2.73TiB used 2.50TiB path /dev/sdc
>>>> 	devid    4 size 931.51GiB used 702.00GiB path /dev/sdf
>>>> 	devid    6 size 3.64TiB used 3.41TiB path /dev/sdg
>>>> 	devid    7 size 3.64TiB used 3.41TiB path /dev/sdh
>>>>
>>>> $ btrfs fi df /media/storage
>>>> Data, RAID1: total=3D6.25TiB, used=3D6.24TiB
>>>> System, RAID1: total=3D32.00MiB, used=3D944.00KiB
>>>> Metadata, RAID1: total=3D10.00GiB, used=3D8.45GiB
>>>> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>>>> $ btrfs --version
>>>> btrfs-progs v5.10.1
>>>>
>>>> The dmesg is attached to the email, but most of the `BTRFS critical` =
log
>>>> lines related to name corruption have been removed to get the file
>>>> to 200KB.
>>>>
>>>> Some things to note:
>>>> - I recently upgraded the machine from Debian 9 to 11, getting the
>>>> kernel from 4.9 to 5.10, but the issue already existed on 4.9 (it eve=
n
>>>> started there, prompting me to replace a drive as I though it to be t=
he
>>>> source of the corruption).
>>>> - The kernel is almost the vanilla debian bullseye kernel, with an ad=
ded
>>>> (tiny) patch to fix an issue between 3Ware RAID cards and AMD Ryzen
>>>> CPUs. It should not affect the BTRFS subsystem as it adds a quirk to =
the
>>>> PCIe subsystem.
>>>> - I have a few name mismatches, which can be seen in the logs too. Wh=
ile
>>>> I'd love someday to get rid of them, I simply moved the affected file=
s
>>>> in a corner for now. That's not the issue I'm trying to solve now
>>>> (though if someone can help, I'd be glad). They come from a ZIP archi=
ve,
>>>> so deleting them is fine, but I can't as I only get "Input/Output err=
or"
>>>> when trying to rm them.
>>>>
>>>> Thank you very much to whoever can help!
>>>
