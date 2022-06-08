Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65292543A62
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 19:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbiFHR2T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 13:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbiFHR2J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 13:28:09 -0400
Received: from libero.it (smtp-16.italiaonline.it [213.209.10.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D153135DC1
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 10:26:45 -0700 (PDT)
Received: from [192.168.1.27] ([84.220.25.110])
        by smtp-16.iol.local with ESMTPA
        id yzS5n9UG14YHxyzS5nbAb4; Wed, 08 Jun 2022 19:26:43 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1654709203; bh=NeKEFCzJT8PTlM4Gdf4l3XZUMNXBx0Xtq/WlKSCMgZo=;
        h=From;
        b=oxkinn4+pPyw3RoUBgT5EVrAUUu2dIbgyrQqZ6IDQq8V6Zt7BvLLKxPUVWY6UaOZy
         jNac1WnnHgXnPSxtocc9WepTa/mfzhlCXWd/TW8ju8a8HWBQzst5SECn1tSujsJZgm
         1UD1UDx5Zm3mYl3xFqkfD7CdH+AUcLcexP5Vdb3OaGTZUSsc2mherjLdkCw5AHNrx6
         phmph75YccQ23xLlyEiU4w7dYPV0wSsh3fqUGoOJH1DVW83SpSILlMpERnuEOkE5WI
         PZd2sdVhqvAa/wqek15ByfGm4HLUaWiO8mBpaA/SWQ/w/nA+PTDGhuexd6r6zYXCuA
         aOMuUiKWIb8gw==
X-CNFS-Analysis: v=2.4 cv=cbYXElPM c=1 sm=1 tr=0 ts=62a0dbd3 cx=a_exe
 a=UrC+9AN/Oct56HHGXTc7PQ==:117 a=UrC+9AN/Oct56HHGXTc7PQ==:17
 a=IkcTkHD0fZMA:10 a=Gey96TiuT-TcPs76zoMA:9 a=QEXdDO2ut3YA:10
Message-ID: <d7de634b-d1a2-7d2d-1b4f-91400b19e9a7@inwind.it>
Date:   Wed, 8 Jun 2022 19:26:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH DRAFT] btrfs: RAID56J journal on-disk format draft
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Lukas Straub <lukasstraub2@web.de>
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
From:   Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <49b3013f-68a3-648c-7b15-42d29b64d131@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfLgLIE0IshRGEcSXDqXFgd+dCBF++Nu3+mkauavx1moKkNxjRreIzO2HHsg3DFuxKJtX9bTyG+A6PGH0M5v5qBsgb1D6Q3/FlkWzjbxTr6+9fpBlE4r9
 jPp1OuFGtf1dv7MzBYJJgNYAgT5Q1X7BkKtzJ9O86GHmgPotTbOTv9n0QpBno0H5/fds+4AVg9QcShZ9QPcAq+vCGxPL8budzJqWhLTGerLKzMWivAm+rDsC
 aVcfXknZGduoAXjTZJgBx4tGjSprsvpJS+KSBQXyEsX+7pSQ/8CSHDuQ9/JzadA9B2m1IeKySzUO52bKUKbZSiBUtq+Ip8Cq2zUbyP82Bg51rH5d/rA9B1Nm
 RJFum06k
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 08/06/2022 00.14, Qu Wenruo wrote:
> 
> 
> On 2022/6/8 01:36, Goffredo Baroncelli wrote:
>> On 07/06/2022 03.27, Qu Wenruo wrote:
>>>
>>>
>>> On 2022/6/7 02:10, Goffredo Baroncelli wrote:
>> [...]
>>
>>>>
>>>> But with a battery backup (i.e. no power failure), the likelihood of b)
>>>> became
>>>> negligible.
>>>>
>>>> This to say that a write intent bitmap will provide an huge
>>>> improvement of the resilience of a btrfs raid5, and in turn raid6.
>>>>
>>>> My only suggestions, is to find a way to store the bitmap intent not
>>>> in the
>>>> raid5/6 block group, but in a separate block group, with the appropriate
>>>> level
>>>> of redundancy.
>>>
>>> That's why I want to reject RAID56 as metadata, and just store the
>>> write-intent tree into the metadata, like what we did for fsync (log
>>> tree).
>>>
>>
>> My suggestion was not to use the btrfs metadata to store the
>> "write-intent", but
>> to track the space used by the write-intent storage area with a bg. Then
>> the
>> write intent can be handled not with a btrfs btree, but (e.g.) simply
>> writing a bitmap of the used blocks, or the pairs [starts, length]....
> 
> That solution requires a lot of extra change to chunk allocation, and
> out-of-btree tracking.
> 
> Furthermore, btrfs Btree itself has CoW to defend against the power loss.

[...]
> 
> But such write intent bitmap must survive powerloss by itself.
> 

What is the reason that the write intent "must survive" ?
My understanding is that if the write intent is not fully wrote,
also no data is wrote. And to check if a write intent
is fully wrote, it is enough to check against a checksums.

I imagine (but maybe I am wrong) that the sequence should be:

1) write the intent (w/ checksum)
2) sync
3) write the raid5/6 data
4) sync
5) invalid the intent
6) sync

a) If the powerloss happens before 3, we don't *need* to scrub anything.
But if the checksum matches we will.
But hopefully it doesn't harm (only a delay at mount time after a poweroff)


b) If the powerloss happens after 2 (and until 6), we should scrub all the potential
impacted blocks disk. But the consistency of the write intent is guarantee
by "2) sync" (and this doesn't depend by the fact that the intent is
stored in a btree or in another kind of storage)


> And in fact, that bitmap is not small as you think.
> 
> In fact, for users who need write-intent tree/bitmap, we're talking
> about at least TiB level usage.

The worst case is that the data to write is big as the memory. Usually
sizeof(memory) << sizeof(disk), so I think an intent map "extent based"
would be more efficient than a bit map.

Supposing to have 16gb server, and to track the blocks using an extent
based (64bit pointer + 16bit length in 4k unit). The worst case is that all the
pages are not contiguous, so we need 16GB/4k*10 = 41MB to track all the pages.

The point is that for each 16GB of data, we need to write further 41MB,
which is a negligible quantity, 0.2%; and this factor is constant.
And in case of a powerloss, you have to scrub only the
changed blocks (plus the intrinsic amplification factor of raid5/6).


On the other side, supposing to have a 16TB disks set, and to track the
blocks using a bitmap, where each bit represent 1MB.
To track all the disks we need 2MB. However:
1) if you write 4k, you still need to write 21MB
2) the worst case is that you need to update 16GB of 4k pages, where each
pages is 1MB far from the nearest. This means that you need to scrub
16GB/4k*1MB = 4TB of disks (plus the intrinsic amplification factor
of raid5/6).

If we reduce the unit of the page, we reduce the amplification factor
for the scrub, but we increase the size of the bitmap.
For example if each bit tracks a 4k page, we have a bitmap of
4GB for a 16TB filesystem. And
1.bis) if you write 4k, you will still need to write 4GB of intent.
2.bis) on the other side in case of powerloss, you have to scrub only the
impacted disk pages (plus the intrinsic amplification factor
of raid5/6).

> 
> 4TiB used space needs already 128MiB if we really go straight bitmap for
> them.
> Embedding them all in a per-device basis is completely possible, but
> when implementing it, it's much complex.
> 
> 128MiB is not that large, so in theory we're fine to keep an in-memory
> bitmap.
> But what would happen if we go 32TiB? Then 1GiB in-memory bitmap is
> needed, which is not really acceptable anymore.
> 
> When we start to choose what part is really needed in the large bitmap
> pool, then Btree starts to make sense. We can store a super large bitmap
> using bitmap and extent based entries pretty easily, just like free
> space cache tree.
> 
>>
>> Moreover, the handling of raid5/6 is a layer below the btree.
> 
> While CSUM is also a layer below, but we still put it into CSUM tree.
> 
> The handling of write-intent bitmap/tree is indeed a layer lower.
> But traditional DM lacks the awareness of the upper layer fs, thus has a
> lot of problems like unable to detect bit rot in RAID1 for example.
> 
> Yes, we care about layer separation, but more in a code level.
> For functionality, layer separation is not that a big deal already.
> 
>> I think that
>> updating the write-intent btree would be a performance bottleneck. I am
>> quite sure
>> that the write intent likely requires less than one metadata page (16K
>> today);
>> however to store this page you need to update the metadata page tracking...
> 
> We already have the existing log tree code doing similar (but still
> quite different purpose) things, and it's used to speed up fsync.
> 
> Furthermore, DM layer bitmap is not a straight bitmap of all sectors
> either, and for performance it's almost negligible for sequential RW.
> 
> I don't think Btree handling would be a performance bottleneck, as
> NODATACOW for data doesn't improve much performance other than the
> implied NODATASUM.
> 
>>
>>>>
>>>> This for two main reasons:
>>>> 1) in future BTRFS may get the ability of allocating this block group
>>>> in a
>>>> dedicate disks set. I see two main cases:
>>>> a) in case of raid6, we can store the intent bitmap (or the journal)
>>>> in a
>>>> raid1C3 BG allocated in the faster disks. The cons is that each block
>>>> has to be
>>>> written 3x2 times. But if you have an hybrid disks set (some ssd and
>>>> some hdd,
>>>> you got a noticeable gain of performance)
>>>
>>> In fact, for 4 disk usage, RAID10 has good enough chance to tolerate 2
>>> missing disks.
>>>
>>> In fact, the chance to tolerate two missing devices for 4 disks RAID10
>>> is:
>>>
>>> 4 / 6 = 66.7%
>>>
>>> 4 is the total valid combinations, no order involved, including:
>>> (1, 3), (1, 4), (2, 3) (2, 4).
>>> (Or 4C2 - 2)
>>>
>>> 6 is the 4C2.
>>>
>>> So really no need to go RAID1C3 unless you're really want to ensured 2
>>> disks tolerance.
>>
>> I don't get the point: I started talking about raid6. The raid6 is two
>> failures proof (you need three failure to see the problem... in theory).
>>
>> If P is the probability of a disk failure (with P << 1), the likelihood of
>> a RAID6 failure is O(P^3). The same is RAID1C3.
>>
>> Instead RAID10 failure likelihood is only a bit lesser than two disk
>> failure:
>> RAID10 (4 disks) failure is O(0.66 * P^2) ~ O(P^2).
>>
>> Because P is << 1 then  P^3 << 0.66 * P^2.
> 
> My point here is, although RAID10 is not ensured to lose 2 disks, just
> losing two disks still have a high enough chance to survive.
> 
> While RAID10 only have two copies of data, instead of 3 from RAID1C3,
> such cost saving can be attractive for a lot of users though.
> 
> Thanks,
> Qu
> 
>>>
>>>> b) another option is to spread the intent bitmap (or the journal) in
>>>> *all* disks,
>>>> where each disks contains only the the related data (if we update only
>>>> disk #1
>>>> and disk #2, we have to update only the intent bitmap (or the
>>>> journal) in
>>>> disk #1 and  disk #2)
>>>
>>> That's my initial per-device reservation method.
>>>
>>> But for write-intent tree, I tend to not go that way, but with a
>>> RO-compatible flag instead, as it's much simpler and more back
>>> compatible.
>>>
>>> Thanks,
>>> Qu
>>>>
>>>>
>>>> 2) having a dedicate bg for the intent bitmap (or the journal), has
>>>> another big
>>>> advantage: you don't need to change the meaning of the raid5/6 bg. This
>>>> means
>>>> that an older kernel can read/write a raid5/6 filesystem: it sufficient
>>>> to ignore
>>>> the intent bitmap (or the journal)
>>>>
>>>>
>>>>
>>>>>
>>>>> Furthermore, this even allows us to go something like bitmap tree, for
>>>>> such write-intent bitmap.
>>>>> And as long as the user is not using RAID56 for metadata (maybe even
>>>>> it's OK to use RAID56 for metadata), it should be pretty safe against
>>>>> most write-hole (for metadata and CoW data only though, nocow data is
>>>>> still affected).
>>>>>
>>>>> Thus I believe this can be a valid path to explore, and even have a
>>>>> higher priority than full journal.
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>
>>>>
>>>>
>>>>
>>
>>


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
