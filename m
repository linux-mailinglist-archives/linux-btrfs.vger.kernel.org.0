Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0AE4A93E9
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 07:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242487AbiBDGUu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 01:20:50 -0500
Received: from mout.gmx.net ([212.227.15.15]:42641 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231431AbiBDGUu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 4 Feb 2022 01:20:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643955648;
        bh=I5Uaetd9TEQfuw52m+zpwtSQwzwFueK6fGy2CB4Eco8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=YncIUbGSnogxjueIZ50uGO6y2HGY0BpbuNZIaSVqltd+odJFaWTul6loi5pgx359B
         4J5P2qpM8TjDMxhXg70E4GDp0ozTMDoGNdiUv7NBAByw1dr6WEIyaVSryIb5GHAiB1
         MojEcrRnSrA00p7zclSYsBnbgXdWyxumwMykqcao=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MbRfv-1mecGU1IPx-00bqMV; Fri, 04
 Feb 2022 07:20:48 +0100
Message-ID: <2d78b264-5a12-c7ba-21c4-26a56ef54101@gmx.com>
Date:   Fri, 4 Feb 2022 14:20:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: Still seeing high autodefrag IO with kernel 5.16.5
Content-Language: en-US
To:     Benjamin Xiao <ben.r.xiao@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <KTVQ6R.R75CGDI04ULO2@gmail.com>
 <9409dc0c-e99d-cc61-757e-727bd54c6ffd@gmx.com>
 <88b6fe3e-8317-8070-cb27-0aee4dc72cfb@gmx.com>
 <5AJR6R.7DWSX2SE14RN3@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <5AJR6R.7DWSX2SE14RN3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TqlMUUV4dqkBEGYTfoLj5WtBntokbQbKupPPZFv2EBCzBNmDIJn
 KF9iWx5BAfLlr1KR6LXWn9U6YlaGPvWS43evAhOaTBzADGu2RcRnb9OfqS0oxaaEu5pv3uy
 1RZ0etRG8qgJIPXl+GFpOkNeyp92Hebx/DBMTeDNqzUfZWhYxsR3XDqfX5gV2JLjyGzJ3cX
 qI4p113cUgAqSP+MvjWew==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3LbPKAC8f1M=:qFTIjmb0aq96W4dx4dYoqu
 MjuMtAfROPSpWvz66X/gf8p2/xAM+p1knQrm1sp/NmblhFNvueQ9wDnyxt+P1CFIz2YddVTOq
 t5+5pobF6lI+INex7TpbBmHfgWfNm8HsIHtitLuC70ERuqUBtPapr7pM8oSRx9Y+uvkt91IDz
 697m3ZWebKMENjS4ZlRgBoVOh8PDaNDweieIrb8valexwlkaEpg+zm/0yqGi/loltdkZj8N4q
 Hwp0U7L8xZA/CoG9nlB3ZVaWoKvzjtZETFZsNtqkRuIXABNpssK0uojffGVP2253DQi/7KypX
 Pt3qvfpS6m3FpSGIN8LxObwNXevqMA0uoQeWY2kAoLC2bckSBCdtFFdqHZzuv5QOlKg8tbQEQ
 V11Q6CEbO+bq090XDZTOCvj8vh8eHkSUP+6+utMONqrSowNikEpSIgdU4U+kW/DrarazLFLhQ
 HzmjnpZ6Ah6srkA+fCgVVzH3cQlkRq68Po5emBkfo+9eSvY1uRwjdYtTwHe608Nq0WKaI/NY3
 f8ITimWekG90cRP9vkwmfHSjWgrQjzr359gpo5bGbmHeSb8MS+OCnHCrpltccVQx2A4nuxI8p
 OwWrI1MROapUM+WyLV6Gp2Y33Wf2oCdyjmp/UChhOuEs94mvCE0OU4YelpDBwUhBsjfxTWUM4
 n2St+0uBz+X3t7zn7JHxs0kvgCiyIezxn96yZCxMN1Tk3oLlj50R1IdXFAmecHBZdM3Dbdl1u
 x4x/0VKqEEah1ch0xUHKynUeltyeTywTzjXdT0fg/RYn5EsXMnP6mXCEZjWS0Avug1/SBfLzS
 C0MWkJGZnD/3ZSEcgruvBkpYQaVDSQef4gQSWGRmJXK3yRe+96u2MZeQB1lBfAF+HvAA9VW4m
 yVMkh2cM9EiNsCYuuSlMKbV7JRxp/wAlQOeJF+kEXe79Mx4I1iSMYT32PEhDfO2orbsdZHKIx
 8cGjJCwb+sQHPum/glgOZumUQsXf7CCu9Qrg9+Sw9/a0DXaGUT356Metyui4QpAO3kYhbDrzQ
 zaQUeweb+IhBSL4DncI7KyDjzNo6+cteDq5y59JRA6mSVmuSQHuMo/zHocrDGiX0QGk1USkxF
 AtdE0WgP6bubDg=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/4 12:32, Benjamin Xiao wrote:
> Okay, I just compiled a custom Arch kernel with your patches applied.
> Will test soon. Besides enabling autodefrag and redownloading a game
> from Steam, what other sorts of tests should I do?

As long as your workload can trigger the problem reliably, nothing else.

Thanks,
Qu

>
> Ben
>
> On Fri, Feb 4 2022 at 09:54:19 AM +0800, Qu Wenruo
> <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>> On 2022/2/4 09:17, Qu Wenruo wrote:
>>>
>>>
>>> On 2022/2/4 04:05, Benjamin Xiao wrote:
>>>> Hello all,
>>>>
>>>> Even after the defrag patches that landed in 5.16.5, I am still seein=
g
>>>> lots of cpu usage and disk writes to my SSD when autodefrag is enable=
d.
>>>> I kinda expected slightly more IO during writes compared to 5.15, but
>>>> what I am actually seeing is massive amounts of btrfs-cleaner i/o eve=
n
>>>> when no programs are actively writing to the disk.
>>>>
>>>> I can reproduce it quite reliably on my 2TB Btrfs Steam library
>>>> partition. In my case, I was downloading Strange Brigade, which is a
>>>> roughly 25GB download and 33.65GB on disk. Somewhere during the
>>>> download, iostat will start reporting disk writes around 300 MB/s, ev=
en
>>>> though Steam itself reports disk usage of 40-45MB/s. After the downlo=
ad
>>>> finishes and nothing else is being written to disk, I still see aroun=
d
>>>> 90-150MB/s worth of disk writes. Checking in iotop, I can see btrfs
>>>> cleaner and other btrfs processes writing a lot of data.
>>>>
>>>> I left it running for a while to see if it was just some maintenance
>>>> tasks that Btrfs needed to do, but it just kept going. I tried to
>>>> reboot, but it actually prevented me from properly rebooting. After
>>>> systemd timed out, my system finally shutdown.
>>>>
>>>> Here are my mount options:
>>>> rw,relatime,compress-force=3Dzstd:2,ssd,autodefrag,space_cache=3Dv2,s=
ubvolid=3D5,subvol=3D/
>>>>
>>>>
>>>
>>> Compression, I guess that's the reason.
>>>
>>> =C2=A0From the very beginning, btrfs defrag doesn't handle compressed =
extent
>>> well.
>>>
>>> Even if a compressed extent is already at its maximum capacity, btrfs
>>> will still try to defrag it.
>>>
>>> I believe the behavior is masked by other problems in older kernels th=
us
>>> not that obvious.
>>>
>>> But after rework of defrag in v5.16, this behavior is more exposed.
>>
>> And if possible, please try this diff on v5.15.x, and see if v5.15 is
>> really doing less IO than v5.16.x.
>>
>> The diff will solve a problem in the old code, where autodefrag is
>> almost not working.
>>
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index cc61813213d8..f6f2468d4883 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -1524,13 +1524,8 @@ int btrfs_defrag_file(struct inode *inode, struc=
t
>> file *file,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cont=
inue;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
>>
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (!newer_than) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cluster =
=3D (PAGE_ALIGN(defrag_end) >>
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PAGE_SHIFT) - i;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cluster =
=3D min(cluster, max_cluster);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 } else {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cluster =
=3D max_cluster;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 cluster =3D (PAGE_ALIGN(defrag_end) >> PAGE_SHIFT) - i;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 cluster =3D min(cluster, max_cluster);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (i + cluster > ra_index) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ra_i=
ndex =3D max(i, ra_index);
>>
>>>
>>> There are patches to address the compression related problem, but not
>>> yet merged:
>>>
>>> https://patchwork.kernel.org/project/linux-btrfs/list/?series=3D609387
>>>
>>> Mind to test them to see if that's the case?
>>>
>>> Thanks,
>>> Qu
>>>>
>>>>
>>>> I've disabled autodefrag again for now to save my SSD, but just wante=
d
>>>> to say that there is still an issue. Have the defrag issues been full=
y
>>>> fixed or are there more patches incoming despite what Reddit and
>>>> Phoronix say? XD
>>>>
>>>> Thanks!
>>>> Ben
>>>>
>>>>
>
>
