Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6753E9BE1
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Aug 2021 03:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbhHLBSx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 21:18:53 -0400
Received: from mout.gmx.net ([212.227.17.21]:46193 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232302AbhHLBSx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 21:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628731104;
        bh=s4TPzSUhfukmCxdFmHvsr7cqjj0iK2ey5Dj4uY5OQZo=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=YUzbPpO/z4Hhv3bjJhdMZXSyYMoi7nKc7OBxVvucCuS5vvBbpxSnyipW9DHShMI1g
         Olulz3aqMg5mplFZXV2VIWswCv1rpWp2Qe2dsYsjCFS0Te6gnnAWYuuOPb0OOIcnyr
         s8u2dKGJklSpkAnUKywLvRzSBMVEy0ssufnaRyjs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6UZl-1mC3Xy43HF-006sbL; Thu, 12
 Aug 2021 03:18:24 +0200
To:     Konstantin Svist <fry.kun@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <67691486-9dd9-6837-d485-30279d3d3413@gmail.com>
 <46f3b990-ec2d-6508-249e-8954bf356e89@gmx.com>
 <CADQtc0=GDa-v_byewDmUHqr-TrX_S734ezwhLYL9OSkX-jcNOw@mail.gmail.com>
 <04ce5d53-3028-16a3-cc1d-ee4e048acdba@gmx.com>
 <7f42b532-07b4-5833-653f-bef148be5d9a@gmail.com>
 <1c066a71-bc66-3b12-c566-bac46d740960@gmx.com>
 <d60cca92-5fe2-6059-3591-8830ca9cf35c@gmail.com>
 <c7fed97e-d034-3af1-2072-65a9bb0e49ef@gmx.com>
 <544e3e73-5490-2cae-c889-88d80e583ac4@gmail.com>
 <c03628f0-585c-cfa8-5d80-bd1f1e4fb9c1@gmx.com>
 <d7c65e1d-6f4e-484b-a52f-60084160969f@gmail.com>
 <2684f59f-679d-5ee7-2591-f0a4ea4e9fbe@gmx.com>
 <238d1f6c-20a9-f002-e03a-722175c63bd6@gmail.com>
 <4bd90f4a-7ced-3477-f113-eee72bc05cbb@gmx.com>
 <fab2dab5-41bb-43f2-5396-451d66df3917@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Trying to recover data from SSD
Message-ID: <60a21bca-d133-26c0-4768-7d9a70f9d102@gmx.com>
Date:   Thu, 12 Aug 2021 09:18:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <fab2dab5-41bb-43f2-5396-451d66df3917@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Pxo3TODGxBBAT3JKS+yFN504yTgk3o9vjDGEgR+IhPe7kFvubTa
 1q10gPXock8XScWUyZjDiZqfyfUvrZ28tvhKsKmGWuQxRaXoDrSVA13maCEGwTO9wWhofLx
 SMAGxLbGWkil+KaJ7LVhJEgjXK70FnzuQKVD7fqcPegX+hYF/5UdvjdGGh8JLIyK4nO60bI
 qg3sphFFiKrWkevWOfmlw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6Ko9dx47Zc4=:VeWGpfK0xJIY5Oe8xi4Ya9
 pExZpZsaRfBa3mOZJ3I6jCGRAzq5DP50ZWPcEhPpftzyf80maQcWXICnU4eRzR0nXmLWm1sGt
 lTvEXgNyfL8e840NqnHyUqmohEnaJqsviLe2m/74HgW9UQx2nSd/h2UVIfEH4I6+IbjVRLsXV
 u75FZBdPL7fVulMFmDzZQ+LNTHPO+fwsDs+tLbGrUX5Mk0sPGUQ7o2PFpwf7+vde1U9TLfg5n
 tof2k6OPl50MiwoJBF/KpEfm0D9KRTD/1Lpaj2a7g4RwnjG7PVygq5zTkMdLNXcBH4yc33AcL
 3xsUd2VSM3v4yDJHdWGyrwQdWIRAYLOvw5i4bmNGMYLEQoU4y21Of2B8bpjR0L8bXF+zkTIOS
 05hFJrfr98gf9ZNRud0Fit4YFQ+Jw8alA73kyMZAJdX4P629rq2851rto5ibD3lFpXxfgJjef
 th5rtVjNknd6432QQabkFl0t8uAzmAMTFbDX1qEG/v0FcGEt+bI51cH6QUXKSlcYj38lK5Z3A
 jh6AQcKBYh/Vei4OofjLTuL25fmOp6kjYB+w6YblXL2QcJXNtZuW/eK+MNeqz8TtCqJ98l14/
 /YjX0XQVLOb/FI9XHOuRAQw+m6KJ5iAvdhWywlCJvtmpVBmoVe4MubdXVwoKFypI9uM2LzQzw
 fW0H+4eWh5+NtFoSvvR1TSGQXoIxZ5A7G/iJ5vc922qegqR4fyqtN3/P5spqbqIBrVX5TMWCK
 ayv2gWVjHPRsERnnvbB/J71f5LUxTBmLexcVBY9qPTUYVra8iJhHu9lr4/76R2ShBEA03vhzI
 EUUbLyYgXn/ldxLLXVeqkoWjr2nYallIdae5bgpNJ6FzUiOgXVBvcX16+HNKbAuJWWqfAGe6t
 uhr5qEfw725n6K4L0n9RPFwJaFLSsCSEccV3pHTNmlkUHoC/E5dwcNaQcq0iDT1idLn6f/S2p
 t+wh1Ba18jw2fBJrfJpzjDsZSUJOyb1lHLa/3DqqP2PrR/L8rGFJBS/QdgsDPpSSWg6HAIkMM
 mq/ESTTt/h8HHNyK1WVaxfhhUkS1dQPaHtz73PGQhTvqJm8vzawZA4CtY8KQMIbjgFG31xb82
 zvDdyuNxW06EJ5aAE2HTIMit4vF+q5cCS54SWJMGDeycT2UvuXkQEUiRw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/12 =E4=B8=8A=E5=8D=886:34, Konstantin Svist wrote:
> On 8/11/21 14:51, Qu Wenruo wrote:
>>
>>
>> On 2021/8/12 =E4=B8=8A=E5=8D=883:33, Konstantin Svist wrote:
>>> On 8/10/21 22:49, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2021/8/11 =E4=B8=8B=E5=8D=881:34, Konstantin Svist wrote:
>>>>> On 8/10/21 22:24, Qu Wenruo wrote:
>>>>>>
>>>>>>
>>>>>> On 2021/8/11 =E4=B8=8B=E5=8D=881:22, Konstantin Svist wrote:
>>>>>>> On 8/10/21 16:54, Qu Wenruo wrote:
>>>>>>>>
>>>>>>>> Oh, that btrfs-map-logical is requiring unnecessary trees to
>>>>>>>> continue.
>>>>>>>>
>>>>>>>> Can you re-compile btrfs-progs with the attached patch?
>>>>>>>> Then the re-compiled btrfs-map-logical should work without proble=
m.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Awesome, that worked to map the sector & mount the partition.. but=
 I
>>>>>>> still can't access subvol_root, where the recent data is:
>>>>>>
>>>>>> Is subvol_root a subvolume?
>>>>>>
>>>>>> If so, you can try to mount the subvolume using subvolume id.
>>>>>>
>>>>>> But in that case, it would be not much different than using
>>>>>> btrfs-restore with "-r" option.
>>>>>
>>>>>
>>>>> Yes it is.
>>>>>
>>>>> # mount -oro,rescue=3Dall,subvol=3Dsubvol_root /dev/sdb3 /mnt/
>>>>> mount: /mnt: can't read superblock on /dev/sdb3.
>>>>
>>>> I mean using subvolid=3D<number>
>>>>
>>>> Using subvol=3D will still trigger the same path lookup code and get
>>>> aborted by the IO error.
>>>>
>>>> To get the number, I guess the regular tools are not helpful.
>>>>
>>>> You may want to manually exam the root tree:
>>>>
>>>> # btrfs ins dump-tree -t root <device>
>>>>
>>>> Then look for the keys like (<number> ROOT_ITEM <0 or number>), and t=
ry
>>>> passing the first number to "subvolid=3D" option.
>>>
>>> This works (and numbers seem to be the same as from dump-tree):
>>> # mount -oro,rescue=3Dall /dev/sdb3 /mnt/
>>> # btrfs su li /mnt/
>>> ID 257 gen 166932 top level 5 path subvol_root
>>> ID 258 gen 56693 top level 5 path subvol_snapshots
>>> ID 498 gen 56479 top level 258 path subvol_snapshots/29/snapshot
>>> ID 499 gen 56642 top level 258 path subvol_snapshots/30/snapshot
>>> ID 500 gen 56691 top level 258 path subvol_snapshots/31/snapshot
>>>
>>> This also works (not what I want):
>>> # mount -oro,rescue=3Dall,subvol=3Dsubvol_snapshots /dev/sdb3 /mnt/
>>>
>>>
>>> But this doesn't:
>>>
>>> # mount -oro,rescue=3Dall,subvolid=3D257 /dev/sdb3 /mnt/
>>> mount: /mnt: can't read superblock on /dev/sdb3.
>>>
>>> dmesg:
>>> BTRFS error (device sdb3): bad tree block start, want 920748032 have 0
>>>
>>>
>> Then it means, the tree blocks of that subvolume is corrupted, thus no
>> way to read that subvolume, unfortunately.
>>
>> Thanks,
>> Qu
>
>
> Shouldn't there be an earlier generation of this subvolume's tree block
> somewhere on the disk? Would all of them have gotten overwritten already=
?

Then it will be more complex and I can't ensure any good result.

Firstly you need to find an older root tree:

# btrfs ins dump-super -f /dev/sdb3 | grep backup_tree_root
                 backup_tree_root:       30687232        gen: 2317
  level: 0
                 backup_tree_root:       30834688        gen: 2318
  level: 0
                 backup_tree_root:       30408704        gen: 2319
  level: 0
                 backup_tree_root:       31031296        gen: 2316
  level: 0

Then try the bytenr in their reverse generation order in btrfs ins
dump-tree:
(The latest one should be the current root, thus you can skip it)

# btrfs ins dump-tree -b 30834688 /dev/sdb3 | grep "(257 ROOT_ITEM" -A 5

Then grab the bytenr of the subvolume 257, then pass the bytenr to
btrfs-restore:

# btrfs-restore -f <bytenr> /dev/sdb3 <restore_path>

The chance is already pretty low, good luck.

Thanks,
Qu

>
> Any hope for any individual files, if not for subvolume?
>
>
>
>
