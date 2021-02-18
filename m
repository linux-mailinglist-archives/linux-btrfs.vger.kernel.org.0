Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7D931E582
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Feb 2021 06:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhBRF0P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Feb 2021 00:26:15 -0500
Received: from mout.gmx.net ([212.227.15.19]:42019 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229656AbhBRF0L (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Feb 2021 00:26:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1613625869;
        bh=XSwh4rRo8/+tLewmHoX1OvHk0G5ZSZzHoCO4AhM2UUw=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=HqujEQFqWpWwNgorHiHQJM9Pwko3O936FTQQ07UtVY8YkRzSU5JsKsZWtbqFUqUoX
         JsgiVeeARldfpOMxbVhAVNXD2jowdsP0Ir+D0rZkbE1mczAoDwduNbrXk5ydjqEidw
         disywthzes5n5NHktvboH7D+0hY6jmqPee+UvgYg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MwfWa-1m5vDK2RhK-00y73R; Thu, 18
 Feb 2021 06:24:29 +0100
To:     Erik Jensen <erikjensen@rkjnsn.net>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Su Yue <l@damenly.su>, Hugo Mills <hugo@carfax.org.uk>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAMj6ewO7PGBoN565WYz_bqL6nGszweNouP-Fphok9+GGpGn8gg@mail.gmail.com>
 <CAMj6ewNjSs-_3akOquO1Zry5RBNEPqQWf7ZKjs8JOzTA7ZGZ7w@mail.gmail.com>
 <2abb2701-5dde-cd5d-dd25-084682313b11@gmx.com>
 <b2bbff7d-22d0-84c2-7749-ac9e27d4ab3d@gmx.com>
 <CAMj6ewOqCJTGjykDijun9_LWYELA=92HrE+KjGo-ehJTutR_+w@mail.gmail.com>
 <CAMj6ewP-NK3g1xzHNF+fKt6M+_W-ec29Sq+CBtwcb1dcqc7dNA@mail.gmail.com>
 <CAMj6ewPtDJdkQ=H3DO6BSPucdkqSoHOkeb-xgTd8mo+AaUWhkA@mail.gmail.com>
 <16d35c47-40c5-25a9-c2ba-f6aab00db8e6@gmx.com> <mtwofibp.fsf@damenly.su>
 <CAMj6ewNYSnFUFPER06qweZaypWC6qVHmUX7gYxRXO7Gbuw_16A@mail.gmail.com>
 <CAMj6ewMSw+UzZHhEEN=rhxN8O3pN9gWA05usAodk2xX5+s-Qjw@mail.gmail.com>
 <7d32a06e-dc2e-c2c4-ddce-1f2693980c5b@gmx.com>
 <CAMj6ewOc+jJAo=rLmH_mBzaqO10daPkcN5XacPiwx6eh9PVvBQ@mail.gmail.com>
 <90ce8de3-c759-da91-f89e-3d1ac7b3d049@gmx.com>
 <2ac19a21-1674-b34a-7e0a-8a5744f0513a@gmx.com>
 <CAMj6ewPbivS1yZOmvT22hJsMxHGK-fWhyGgm3PJ4TVUbo04Eew@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: "bad tree block start" when trying to mount on ARM
Message-ID: <b06c1665-7547-2321-3863-4c68c9818f90@gmx.com>
Date:   Thu, 18 Feb 2021 13:24:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAMj6ewPbivS1yZOmvT22hJsMxHGK-fWhyGgm3PJ4TVUbo04Eew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Uc4f9nxSJdWbZ6cpgDkLNgHpi3Y3cpkSqrpTLYDVWytvoIilA7i
 e1P0ol5zRnoLpria4uos+EP9I4zufd0BZi3pVWCLcdtZc/1+q7CIbMLMWBiqwmT87S4lwnT
 W4IESbeKIMb+x59cHMrLqf3Y81fMSL8G+65Ds4fX7fctUBUkGWFt2AdgXDAcWnnon0kaNLl
 gOWxglHnY09gSyW5mdZBA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:s9lBpkdub4E=:2jEgien+SSjCJhg4vUC4qb
 Afgg3WPDMhSIsqsSxkS5s/eeW6jcmQi6Iv8tmGMneB0HxokeM8Ojzvah4e6vWRT+8M8C4tcc9
 qYPkqIeFurfKCRbOj1HdEtMrUB28WXeFGdzAPOTBjsZbQZqcrxHUQimnx2oMabDV+tSyjOch6
 OQT71RHO1T8yPKnB5+7FUYcTY9FNHTzcBgzIXfeigUH9duZ29vb+zTQKypNKlgtTTPc8+Uaik
 +nrSDx0Yj2BzsPD8RDmi0CoQiOGHWnjb3T6/B8zl5+NJohRZnIsEioasb4e+XSQHUQalwt0Rh
 WI3PXTR4FIkm/84PMIZ1FjMhLTeAlVq2GCJqxU45rIEsueLJ4LfNhKMG5JBvN5lqB/4qu9rrJ
 pZg4OOeU4ZbfELdU5NLgQ5JtPa2M5fZRLbttK9VhnmGgqU1ivrBJ1ABB4s+/V+HYm4wGqSgPT
 dLUlmzRHhgPh0KIvUSBc0mcPbrRNWXQKO34CzSH1blCPgI3JGNGYg0uUUkJr9VvkGhl3J5JDh
 /xVzeKYpW7plll1o9p5cx7QCbIJUUeZoFwuLpWMmywezwwEhmTSsb+HFq5WPY2Pynsy5Qs7Ht
 p2+xde9H2rrGKc5Qr/RYtTTJb+lrQxDzvVxqhLRlaJzwBqtWsSJcxHOuSG5RzIK9NS6j3dBQk
 oVKedomEOalCLgj8637vN3/unyw48gpPZl49dAj9luOiUp9x+f7y9xB7ajZQ+S/0zCc6fOz1F
 0U7lzIgUQQePnh1/jZX9KMXOd2YhIlHSzE4JsqeAeBrcb4H+BjtIfFWzhIuMrgXFusj5bJrsO
 BNvTb2D83/HkyiRk+rRRMUAyZSB27eHP5mG9CzbvxH38yRyjz/LrUaK8iytggV9Dx4iH04fnz
 wBgB69aw5A6dMqdLdF1g==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/2/18 =E4=B8=8B=E5=8D=8812:03, Erik Jensen wrote:
> On Wed, Feb 17, 2021 at 5:24 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>> On 2021/2/11 =E4=B8=8A=E5=8D=887:47, Qu Wenruo wrote:
>>> On 2021/2/11 =E4=B8=8A=E5=8D=886:17, Erik Jensen wrote:
>>>> On Tue, Feb 9, 2021 at 9:47 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wro=
te:
>>> [...]
>>>>>
>>>>> Unfortunately I didn't get much useful info from the trace events.
>>>>> As a lot of the values doesn't even make sense to me....
>>>>>
>>>>> But the chunk tree dump proves to be more useful.
>>>>>
>>>>> Firstly, the offending tree block doesn't even occur in chunk chunk
>>>>> ranges.
>>>>>
>>>>> The offending tree block is 26207780683776, but the tree dump doesn'=
t
>>>>> have any range there.
>>>>>
>>>>> The highest chunk is at 5958289850368 + 4294967296, still one digit
>>>>> lower than the expected value.
>>>>>
>>>>> I'm surprised we didn't even get any error for that, thus it may
>>>>> indicate our chunk mapping is incorrect too.
>>>>>
>>>>> Would you please try the following diff on the 32bit system and repo=
rt
>>>>> back the dmesg?
>>>>>
>>>>> The diff adds the following debug output:
>>>>> - when we try to read one tree block
>>>>> - when a bio is mapped to read device
>>>>> - when a new chunk is added to chunk tree
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>
>>>> Okay, here's the dmesg output from attempting to mount the filesystem=
:
>>>> https://gist.github.com/rkjnsn/914651efdca53c83199029de6bb61e20
>>>>
>>>> I captured this on my 32-bit x86 VM, as it's much faster to rebuild
>>>> the kernel there than on my ARM board, and it fails with the same
>>>> error.
>>>>
>>>
>>> This is indeed much better.
>>>
>>> The involved things are:
>>>
>>> [   84.463147] read_one_chunk: chunk start=3D26207148048384 len=3D1073=
741824
>>> num_stripes=3D2 type=3D0x14
>>> [   84.463148] read_one_chunk:    stripe 0 phy=3D6477927415808 devid=
=3D5
>>> [   84.463149] read_one_chunk:    stripe 1 phy=3D6477927415808 devid=
=3D4
>>>
>>> Above is the chunk for the offending tree block.
>>>
>>> [   84.463724] read_extent_buffer_pages: eb->start=3D26207780683776 mi=
rror=3D0
>>> [   84.463731] submit_stripe_bio: rw 0 0x1000, phy=3D2118735708160
>>> sector=3D4138155680 dev_id=3D3 size=3D16384
>>> [   84.470793] BTRFS error (device dm-4): bad tree block start, want
>>> 26207780683776 have 3395945502747707095
>>>
>>> But when the metadata read happens, the physical address and dev id is
>>> completely insane.
>>>
>>> The chunk doesn't have dev 3 in it at all, but we still get the wrong
>>> mapping.
>>>
>>> Furthermore, that physical and devid belongs to chunk 8614760677376,
>>> which is raid5 data chunk.
>>>
>>> So there is definitely something wrong in btrfs chunk mapping on 32bit=
.
>>>
>>> I'll craft a newer debug diff for you after I pinned down which can be
>>> wrong.
>>
>> Sorry for the delay, mostly due to lunar new year vocation.
>>
>> Here is the new diff, it should be applied upon previous diff.
>>
>> This new diff would add extra debug info inside __btrfs_map_block().
>>
>> BTW, you only need to rebuild btrfs module to test it, hopes this saves
>> you some time.
>>
>> Although if I could got a small enough image to reproduce locally, it
>> would be the best case...
>>
>> Thanks,
>> Qu
>>>
>>> Thanks,
>>> Qu
>
> Okay, here is the output with both patches applied:
> https://gist.github.com/rkjnsn/7139eaf855687c6bd4ce371f88e28a9e

Got it now.

[  295.249182] read_extent_buffer_pages: eb->start=3D26207780683776 mirror=
=3D0
[  295.249188] __btrfs_map_block: logical=3D8615594639360 chunk
start=3D8614760677376 len=3D4294967296 type=3D0x81
[  295.249189] __btrfs_map_block: stripe[0] devid=3D3 phy=3D2118735708160

Note that, the initial request is to read from 26207780683776.
But inside btrfs_map_block(), we want to read from 8615594639360.

This is totally screwed up in a unexpected way.

26207780683776 =3D 0x17d5f9754000
8615594639360  =3D 0x07d5f9754000

See the missing leading 1, which screws up the result.

The problem should be the logical calculation part, which doesn't do
proper u64 conversion which could cause the problem.

Would you like to test the single line fix below?

Thanks,
Qu

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index b8fab44394f5..69d728f5ff9e 100644
=2D-- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6575,7 +6575,7 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info
*fs_info, struct bio *bio,
  {
         struct btrfs_device *dev;
         struct bio *first_bio =3D bio;
-       u64 logical =3D bio->bi_iter.bi_sector << 9;
+       u64 logical =3D ((u64)bio->bi_iter.bi_sector) << 9;
         u64 length =3D 0;
         u64 map_length;
         int ret;


>
> I've only run into the issue on this filesystem, which is quite large,
> so I'm not sure how I would even attempt to make a reduced test case.
>
> Thanks!
>
