Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFAE547D9D
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jun 2022 04:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbiFMC1p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Jun 2022 22:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbiFMC1n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Jun 2022 22:27:43 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4834A28E00
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Jun 2022 19:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655087243;
        bh=5ycujk03gddRCuyZe02/kvRYcHFNEqjPIfWHrnb3DVM=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=jQeOPpJD72Tu94+kzzSdSDIip4s+D7V+yMBxZ61hGLCoLFo1dsA5B6PnQqlt0Vdjv
         2gkeUlwP0PbDDST739+7Buf9s4TSGBdr9khbNnl0AICpR7ZqElj+kdeEjG/7ucagfY
         +h9YP+vphiaK03u5Dl7fM0OaoYYYTeUkeZa1ftEo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mq2nK-1nMHBA3DyE-00n76X; Mon, 13
 Jun 2022 04:27:23 +0200
Message-ID: <f8d90bb5-f538-e492-34d7-9e006b2e2e60@gmx.com>
Date:   Mon, 13 Jun 2022 10:27:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     kreijack@inwind.it, Lukas Straub <lukasstraub2@web.de>
Cc:     Martin Raiber <martin@urbackup.org>,
        Paul Jones <paul@pauljones.id.au>,
        Wang Yugui <wangyugui@e16-tech.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20220601102532.D262.409509F4@e16-tech.com>
 <49fb1216-189d-8801-d134-596284f62f1f@gmx.com>
 <20220601170741.4B12.409509F4@e16-tech.com>
 <5f49c12e-4655-48dd-0d73-49dc351eae15@gmx.com>
 <SYCPR01MB4685030F15634C6C2FEC01369EDF9@SYCPR01MB4685.ausprd01.prod.outlook.com>
 <6cbc718d-4afb-87e7-6f01-a1d06a74ab9e@gmx.com>
 <01020181209a0f8e-b97fa255-3146-4ced-b9c9-a6627a21d6e1-000000@eu-west-1.amazonses.com>
 <f56d4b11-1788-e4b5-35fa-d17b46a46d00@gmx.com>
 <20220603093207.6722d77a@gecko>
 <8c318892-0d36-51bb-18e0-a762dd75b723@gmx.com>
 <252577ba-1659-62f8-fc44-fea506eb97b7@gmx.com>
 <c4c298bf-ca54-1915-c22f-a6d87fc5a78f@gmx.com>
 <128e0119-088b-7a10-c874-551196df4c56@libero.it>
 <2575376b-fbd9-8406-3684-7fbc3899ddf3@gmx.com>
 <f5bf7ecb-8cb1-4da1-6052-a2968d4dc6b1@inwind.it>
 <49b3013f-68a3-648c-7b15-42d29b64d131@gmx.com>
 <d7de634b-d1a2-7d2d-1b4f-91400b19e9a7@inwind.it>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH DRAFT] btrfs: RAID56J journal on-disk format draft
In-Reply-To: <d7de634b-d1a2-7d2d-1b4f-91400b19e9a7@inwind.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9ilJsY0lOJOcM2GVbWJLBEwMrV+cIvh4j11cLbkAj8Jn9z+4z1k
 sutQpsJr8LzLpAhxEQfX/Z9b8DKGMODeVIuip3eAfyBdSOp71GenvN7b9Nbktzu77BA/hWI
 HvfU6MbYYqTkIpVoX1RiM0Nje0nMa5aaUYRV6Q0V3/nP5PgjXntHHz+cEDtVxinbVMLwl7k
 qTqXKVT0rY3AcpW8dvHbQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tAVK9OQS1Tw=:R549habFwh9zDqc3r/YWSn
 vwYR2VewcmtU4HZhfuzmSdpQHJiVHMZhHldBrS5yZ9+QicGlnTJkRE69jpeiH4Ybji+qbS0PS
 /myKsgVGPV+haVsOqN+qf3e4nvRoF4bs6gK9QCikzN1RfFgkA4X1gu5uiWhDbZTQOCdrQQh00
 aMkIVYMeKLDQk+8Vy4IDmdXBERTSbsE5b2XQ6HO9M+FRlkyVYFsMjYYmF7WtMnC8N6zTqc8SN
 N/erMWiKSX77mc2X1bIsS2JG+KR/MlJCmcIihE0gr5F99/XRE6zTcGgfYJdPHXv9UJmAzH4DM
 w8HW2PO4dKY2uVsLUUfWuyjVpjCpdIvJPw48Jm3xU9AgeyFOs5+EXnw5WCW0H9P+xvDSJVczS
 qQgHNhxswXBFng4M4eDqX9ODJThqEfcKI4EqY+ux/kn9LZpTSg1dN8yj9q3kHZbr3YVC+tWyI
 Ws4GzJp8rxleNoxyA+vDMkUh64jd0aB+FiHh7AyOrde4MMw9OOAuRPi3PirsC9Mnb5cCkom6X
 wwFgsNmVapEnApHPSoBlxrQIkGDJjhKTLXs5F3S+21q9aCxo3urad2ZSuB+c43lmT3kW2yy2K
 r4V+h38hrmSnEgr9mo3wUgXwWa6o3Vr5CWexln899w1xZ9GgUM+xuaCSzCSU1Rlav3ziNuXLU
 GU40kbzMyTudil3TsHef8eioNpKoe3cQK7yn/rys/tiS5/uIcC6NWcvtWVjpnsKs19ADxFNwt
 7MGrSZTEKaEXzwG9c1eRX2dUiygPDbyGFJ1XpbAwpbNhn7dhPZqxLGLjPErjWCdtDLXs3M4Bt
 LpoB2iinyUMnANv6Z/tsPGFwULgHTTiKIYZ+LjUi5dCSMVq3Zi0V5vZyTKw+JSieht2pNFNbv
 w1IuxQcCEBJ3Xg9yZk81ZN5V6Gi36T9+N5Sw5YCgEADy/F9sStFXx6gfjhnsp1PMbkdjSPZqY
 A4L32ch1H45/7VcdjHVCARVmzV1leR9V4fi4kf3RgpXOf3+vriSu6UcdqJYmgieGJRgMAOPNa
 zIT6c+429OHkvu6eWBHfU/2GVTqfIXE66buZnWeiTPPGqfBjLIUJbwIt9u2IDOMyBYeFwyIbh
 nthqNZ+fqpRd9/2d4/gBcn13SlT4T9HQ/0f+X0RxmzbZxPqwnYydl1QkA==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/9 01:26, Goffredo Baroncelli wrote:
> On 08/06/2022 00.14, Qu Wenruo wrote:
>>
>>
>> On 2022/6/8 01:36, Goffredo Baroncelli wrote:
>>> On 07/06/2022 03.27, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2022/6/7 02:10, Goffredo Baroncelli wrote:
>>> [...]
>>>
>>>>>
>>>>> But with a battery backup (i.e. no power failure), the likelihood
>>>>> of b)
>>>>> became
>>>>> negligible.
>>>>>
>>>>> This to say that a write intent bitmap will provide an huge
>>>>> improvement of the resilience of a btrfs raid5, and in turn raid6.
>>>>>
>>>>> My only suggestions, is to find a way to store the bitmap intent not
>>>>> in the
>>>>> raid5/6 block group, but in a separate block group, with the
>>>>> appropriate
>>>>> level
>>>>> of redundancy.
>>>>
>>>> That's why I want to reject RAID56 as metadata, and just store the
>>>> write-intent tree into the metadata, like what we did for fsync (log
>>>> tree).
>>>>
>>>
>>> My suggestion was not to use the btrfs metadata to store the
>>> "write-intent", but
>>> to track the space used by the write-intent storage area with a bg. Th=
en
>>> the
>>> write intent can be handled not with a btrfs btree, but (e.g.) simply
>>> writing a bitmap of the used blocks, or the pairs [starts, length]....
>>
>> That solution requires a lot of extra change to chunk allocation, and
>> out-of-btree tracking.
>>
>> Furthermore, btrfs Btree itself has CoW to defend against the power los=
s.
>
> [...]
>>
>> But such write intent bitmap must survive powerloss by itself.
>>
>
> What is the reason that the write intent "must survive" ?

Easy, to let us know whether a range needs to be scrubbed, to close the
write hole.

Consider the following case of RAID56, a partial write:

Disk1:		|WWWWW|     |
Disk2:		|     |WWWWW|
Parity:		|WWWWW|WWWWW|

If we write something into the write-intent bitmap, and we do the real
write, but a powerloss happened.

Only the untouched data in Disk1 and Disk2 are safe.
The remaining can be updated or not.

At next mount, we should scrub the this full stripe to close the write hol=
e.

If by somehow, for example the metadata is on another disk (not involved
in the RAID5 array), and that disk is lost.
We are unable to know which full stripe we need to scrub, thus the write
hole is still there.

> My understanding is that if the write intent is not fully wrote,
> also no data is wrote. And to check if a write intent
> is fully wrote, it is enough to check against a checksums.
>
> I imagine (but maybe I am wrong) that the sequence should be:
>
> 1) write the intent (w/ checksum)
> 2) sync
> 3) write the raid5/6 data
> 4) sync
> 5) invalid the intent
> 6) sync
>
> a) If the powerloss happens before 3, we don't *need* to scrub anything.
> But if the checksum matches we will.
> But hopefully it doesn't harm (only a delay at mount time after a powero=
ff)
>
>
> b) If the powerloss happens after 2 (and until 6), we should scrub all
> the potential
> impacted blocks disk. But the consistency of the write intent is guarant=
ee
> by "2) sync" (and this doesn't depend by the fact that the intent is
> stored in a btree or in another kind of storage)
>
>
>> And in fact, that bitmap is not small as you think.
>>
>> In fact, for users who need write-intent tree/bitmap, we're talking
>> about at least TiB level usage.
>
> The worst case is that the data to write is big as the memory. Usually
> sizeof(memory) << sizeof(disk), so I think an intent map "extent based"
> would be more efficient than a bit map.

Nope, write intent bitmap/tree doesn't work like that.

In fact for mdraid, the bitmap normally has only 16KiB in size.

It has proper reclaim mechanism, like flushing a disk to reclaim all
those bitmaps.

Thus in fact I don't really think we'd need to contain the whole bitmap,
sorry for the confusion.



And furthermore, some previous idea, especially using btrfs btree for
write-intent bitmap is not feasible.

The problem here is about the lifespan.
Previously I think write-intent tree can go the same lifespan as log tree.

But it's not true, the problem is, data writeback can happen crossing
transaction boundary.

This means the purposed write-intent tree need to survive multiple
transactions, and is different from log tree, thus it needs metadata
extent item.

The requirement for metadata extent item can get pretty messy.

Thus I'd say, the write-intent bitmap would really go the mdraid way,
preserve a small space (1MiB~2MiB range for each device), then get
updated at the same timing/behavior just like md-bitmap.c.

Thanks,
Qu
>
> Supposing to have 16gb server, and to track the blocks using an extent
> based (64bit pointer + 16bit length in 4k unit). The worst case is that
> all the
> pages are not contiguous, so we need 16GB/4k*10 =3D 41MB to track all th=
e
> pages.
>
> The point is that for each 16GB of data, we need to write further 41MB,
> which is a negligible quantity, 0.2%; and this factor is constant.
> And in case of a powerloss, you have to scrub only the
> changed blocks (plus the intrinsic amplification factor of raid5/6).
>
>
> On the other side, supposing to have a 16TB disks set, and to track the
> blocks using a bitmap, where each bit represent 1MB.
> To track all the disks we need 2MB. However:
> 1) if you write 4k, you still need to write 21MB
> 2) the worst case is that you need to update 16GB of 4k pages, where eac=
h
> pages is 1MB far from the nearest. This means that you need to scrub
> 16GB/4k*1MB =3D 4TB of disks (plus the intrinsic amplification factor
> of raid5/6).
>
> If we reduce the unit of the page, we reduce the amplification factor
> for the scrub, but we increase the size of the bitmap.
> For example if each bit tracks a 4k page, we have a bitmap of
> 4GB for a 16TB filesystem. And
> 1.bis) if you write 4k, you will still need to write 4GB of intent.
> 2.bis) on the other side in case of powerloss, you have to scrub only th=
e
> impacted disk pages (plus the intrinsic amplification factor
> of raid5/6).
>
>>
>> 4TiB used space needs already 128MiB if we really go straight bitmap fo=
r
>> them.
>> Embedding them all in a per-device basis is completely possible, but
>> when implementing it, it's much complex.
>>
>> 128MiB is not that large, so in theory we're fine to keep an in-memory
>> bitmap.
>> But what would happen if we go 32TiB? Then 1GiB in-memory bitmap is
>> needed, which is not really acceptable anymore.
>>
>> When we start to choose what part is really needed in the large bitmap
>> pool, then Btree starts to make sense. We can store a super large bitma=
p
>> using bitmap and extent based entries pretty easily, just like free
>> space cache tree.
>>
>>>
>>> Moreover, the handling of raid5/6 is a layer below the btree.
>>
>> While CSUM is also a layer below, but we still put it into CSUM tree.
>>
>> The handling of write-intent bitmap/tree is indeed a layer lower.
>> But traditional DM lacks the awareness of the upper layer fs, thus has =
a
>> lot of problems like unable to detect bit rot in RAID1 for example.
>>
>> Yes, we care about layer separation, but more in a code level.
>> For functionality, layer separation is not that a big deal already.
>>
>>> I think that
>>> updating the write-intent btree would be a performance bottleneck. I a=
m
>>> quite sure
>>> that the write intent likely requires less than one metadata page (16K
>>> today);
>>> however to store this page you need to update the metadata page
>>> tracking...
>>
>> We already have the existing log tree code doing similar (but still
>> quite different purpose) things, and it's used to speed up fsync.
>>
>> Furthermore, DM layer bitmap is not a straight bitmap of all sectors
>> either, and for performance it's almost negligible for sequential RW.
>>
>> I don't think Btree handling would be a performance bottleneck, as
>> NODATACOW for data doesn't improve much performance other than the
>> implied NODATASUM.
>>
>>>
>>>>>
>>>>> This for two main reasons:
>>>>> 1) in future BTRFS may get the ability of allocating this block grou=
p
>>>>> in a
>>>>> dedicate disks set. I see two main cases:
>>>>> a) in case of raid6, we can store the intent bitmap (or the journal)
>>>>> in a
>>>>> raid1C3 BG allocated in the faster disks. The cons is that each bloc=
k
>>>>> has to be
>>>>> written 3x2 times. But if you have an hybrid disks set (some ssd and
>>>>> some hdd,
>>>>> you got a noticeable gain of performance)
>>>>
>>>> In fact, for 4 disk usage, RAID10 has good enough chance to tolerate =
2
>>>> missing disks.
>>>>
>>>> In fact, the chance to tolerate two missing devices for 4 disks RAID1=
0
>>>> is:
>>>>
>>>> 4 / 6 =3D 66.7%
>>>>
>>>> 4 is the total valid combinations, no order involved, including:
>>>> (1, 3), (1, 4), (2, 3) (2, 4).
>>>> (Or 4C2 - 2)
>>>>
>>>> 6 is the 4C2.
>>>>
>>>> So really no need to go RAID1C3 unless you're really want to ensured =
2
>>>> disks tolerance.
>>>
>>> I don't get the point: I started talking about raid6. The raid6 is two
>>> failures proof (you need three failure to see the problem... in theory=
).
>>>
>>> If P is the probability of a disk failure (with P << 1), the
>>> likelihood of
>>> a RAID6 failure is O(P^3). The same is RAID1C3.
>>>
>>> Instead RAID10 failure likelihood is only a bit lesser than two disk
>>> failure:
>>> RAID10 (4 disks) failure is O(0.66 * P^2) ~ O(P^2).
>>>
>>> Because P is << 1 then=C2=A0 P^3 << 0.66 * P^2.
>>
>> My point here is, although RAID10 is not ensured to lose 2 disks, just
>> losing two disks still have a high enough chance to survive.
>>
>> While RAID10 only have two copies of data, instead of 3 from RAID1C3,
>> such cost saving can be attractive for a lot of users though.
>>
>> Thanks,
>> Qu
>>
>>>>
>>>>> b) another option is to spread the intent bitmap (or the journal) in
>>>>> *all* disks,
>>>>> where each disks contains only the the related data (if we update on=
ly
>>>>> disk #1
>>>>> and disk #2, we have to update only the intent bitmap (or the
>>>>> journal) in
>>>>> disk #1 and=C2=A0 disk #2)
>>>>
>>>> That's my initial per-device reservation method.
>>>>
>>>> But for write-intent tree, I tend to not go that way, but with a
>>>> RO-compatible flag instead, as it's much simpler and more back
>>>> compatible.
>>>>
>>>> Thanks,
>>>> Qu
>>>>>
>>>>>
>>>>> 2) having a dedicate bg for the intent bitmap (or the journal), has
>>>>> another big
>>>>> advantage: you don't need to change the meaning of the raid5/6 bg.
>>>>> This
>>>>> means
>>>>> that an older kernel can read/write a raid5/6 filesystem: it
>>>>> sufficient
>>>>> to ignore
>>>>> the intent bitmap (or the journal)
>>>>>
>>>>>
>>>>>
>>>>>>
>>>>>> Furthermore, this even allows us to go something like bitmap tree,
>>>>>> for
>>>>>> such write-intent bitmap.
>>>>>> And as long as the user is not using RAID56 for metadata (maybe eve=
n
>>>>>> it's OK to use RAID56 for metadata), it should be pretty safe again=
st
>>>>>> most write-hole (for metadata and CoW data only though, nocow data =
is
>>>>>> still affected).
>>>>>>
>>>>>> Thus I believe this can be a valid path to explore, and even have a
>>>>>> higher priority than full journal.
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>
>>>>>
>>>>>
>>>>>
>>>
>>>
>
>
