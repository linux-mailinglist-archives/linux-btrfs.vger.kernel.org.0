Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B1B542366
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 08:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384448AbiFHCqw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 22:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447247AbiFHClb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 22:41:31 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E479925F913
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 15:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654640082;
        bh=FJ/mA2riq9BTlvuL/dZBhIyOCQiEiRcofnScxoHtvSQ=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=NokXxXr5KZGUunAAHHmFDKcgfuezKInyjchMJv85Wc/nya+RTj3r/AZCek6FhYJrI
         xraStP3I3erANdL90MPMmjc7Y5J/5Ak7mfTBIK1WGiM9Z+8SPXKXPlPfiy49oWOtYl
         9ecwg8m94Rv+0g4MUxkI86q2/DOdXQYYE4V4i5MA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MRTN9-1oAT1Y2EHF-00NRG2; Wed, 08
 Jun 2022 00:14:42 +0200
Message-ID: <49b3013f-68a3-648c-7b15-42d29b64d131@gmx.com>
Date:   Wed, 8 Jun 2022 06:14:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
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
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH DRAFT] btrfs: RAID56J journal on-disk format draft
In-Reply-To: <f5bf7ecb-8cb1-4da1-6052-a2968d4dc6b1@inwind.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rSUDJTi5ubJ+z4UfE1Kp7lJ0LxajPV2VDh/ua+mHqkckQiyyUh+
 ujN9B5k1pJY8ErcsP0H3EHYTrK6jWZ5fSPRd2taz7pti3k/Of+jkac0BU0VKx4eNZ8mQmNT
 1gvWCp2eKmYG1K99B46s5D6T1abEV3gFAQgkyiE8QC/nEXYHBv16p0IuqpR0JdXZht18PAt
 HkWIzCmSw5cKHKVQDNgGA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:H+LZ3NQa2fM=:wcFmRVd4GkJdalvaJIDRRy
 COpORNozUiF1NhEdUpZ83Ba9BnJIen70jVtnm1IhREKhzi9UrDdWPWdQqxo/SUTa7Jw50MFGz
 w02Qk6QLlWxrBWe+zNCg4Brj3Uiu/JE0D7Ke5lFYGE2i4yEDJJYZzG989m83uvQ4QKVdWOxbl
 aHAYxR6Onn8ZNpemJE+X7a1ObGwmu45UB4psp1Rs9YR5bV4WFJQviuFcXO5bZtNFC4c9Q4LXJ
 It9aDYge7mqr6KoCKPi+f9OYhN9NpUk6/p2r3exmkfXrGzaCFkLhtcGuOaP/iSyhQ2olyhgWy
 BP8Yp6XWpDA4GnrWhj9eoOun3Lwwj4REuRw34imJ+pDPhC8BBnk+/qgM342sP4xH4YZWXErAJ
 0xlMZRkrvggi89s0nUnDrNtESy8qIupKQxGHFhFBRtPQiEjCsRrbolY6WlM6we+d02wQtsQto
 r9wVeUwKIUsZPGc8rTwSPetgr/cYHwmT/edOLn8Oc7HyJSjnFVJXAyCi4w201IyL4RZHPyWvB
 5cx4m7STz4fV1TRTKwib5Wx4RZbN9EiyjR49kqBfbadpjAIcHMQixLDCQQFIasAIdcc858koG
 yW/xVPdN4Gtshr4BoCOzNa31Ik4R01vq+LQ0CauKFHMQ9iZmVvG8m69/tlchoA9HLhipkfq+F
 TExmGi/6oSpcTkPPbC9BcFhvFknBY3hMXsNzMFoikiQdesFwFEcmTq1hLE5uDEknCB8FwB+gK
 FK5D6AXyJZEvwGKfIqQ60EIbI75ouAn1iG9s/J9l0cNpb6ZZ1kwVNRfICea2jyeMlqyw4dWsn
 mYYeofAoUHVfv2GmULEpYdpUoKZ/mZD88XQfSgeuj88c60lW3njr/xdQo/IFbklRR0ucJuzbv
 82ZOdlGe6D5hELoFGEU+V0HIzHSr3idvi8KSrU+xFxhmNk5/sq6vmLd5Eae96e5jWpRMctlQH
 V6MGLd9zkPTH3R9RLhVdfiGWSXUbkgTs7tCXfI7lSNP38RnT58NfDGa8NFYTFoAlzIumXpmdu
 /itJwSUUIv7ZrolHi22b+esO36oGyeTfG28xxnr9W074hQsT7tJj0L50qxtVd7rEq9oZN7U8P
 URa9+ABYp+dFDOUQo7JlynOfYmsA9DQwFu/GeQ5NBP5+GwYTOifMNuc3Q==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/8 01:36, Goffredo Baroncelli wrote:
> On 07/06/2022 03.27, Qu Wenruo wrote:
>>
>>
>> On 2022/6/7 02:10, Goffredo Baroncelli wrote:
> [...]
>
>>>
>>> But with a battery backup (i.e. no power failure), the likelihood of b=
)
>>> became
>>> negligible.
>>>
>>> This to say that a write intent bitmap will provide an huge
>>> improvement of the resilience of a btrfs raid5, and in turn raid6.
>>>
>>> My only suggestions, is to find a way to store the bitmap intent not
>>> in the
>>> raid5/6 block group, but in a separate block group, with the appropria=
te
>>> level
>>> of redundancy.
>>
>> That's why I want to reject RAID56 as metadata, and just store the
>> write-intent tree into the metadata, like what we did for fsync (log
>> tree).
>>
>
> My suggestion was not to use the btrfs metadata to store the
> "write-intent", but
> to track the space used by the write-intent storage area with a bg. Then
> the
> write intent can be handled not with a btrfs btree, but (e.g.) simply
> writing a bitmap of the used blocks, or the pairs [starts, length]....

That solution requires a lot of extra change to chunk allocation, and
out-of-btree tracking.

Furthermore, btrfs Btree itself has CoW to defend against the power loss.

By not using Btree, we will pay a much higher price on the complexity of
implementing everything.

>
> I really like the idea to store the write intent in a btree. I find it v=
ery
> elegant. However I don't think that it is convenient.
>
> The write intent disk format is not performance related, you don't need
> to seek
> inside it; and it is small: you need to read it (entirerly) only in case
> of power
> failure, and in any case the biggest cost is to scrub the last updated
> blocks. So
> it is not needed a btree.

But such write intent bitmap must survive powerloss by itself.

And in fact, that bitmap is not small as you think.

In fact, for users who need write-intent tree/bitmap, we're talking
about at least TiB level usage.

4TiB used space needs already 128MiB if we really go straight bitmap for
them.
Embedding them all in a per-device basis is completely possible, but
when implementing it, it's much complex.

128MiB is not that large, so in theory we're fine to keep an in-memory
bitmap.
But what would happen if we go 32TiB? Then 1GiB in-memory bitmap is
needed, which is not really acceptable anymore.

When we start to choose what part is really needed in the large bitmap
pool, then Btree starts to make sense. We can store a super large bitmap
using bitmap and extent based entries pretty easily, just like free
space cache tree.

>
> Moreover, the handling of raid5/6 is a layer below the btree.

While CSUM is also a layer below, but we still put it into CSUM tree.

The handling of write-intent bitmap/tree is indeed a layer lower.
But traditional DM lacks the awareness of the upper layer fs, thus has a
lot of problems like unable to detect bit rot in RAID1 for example.

Yes, we care about layer separation, but more in a code level.
For functionality, layer separation is not that a big deal already.

> I think that
> updating the write-intent btree would be a performance bottleneck. I am
> quite sure
> that the write intent likely requires less than one metadata page (16K
> today);
> however to store this page you need to update the metadata page tracking=
...

We already have the existing log tree code doing similar (but still
quite different purpose) things, and it's used to speed up fsync.

Furthermore, DM layer bitmap is not a straight bitmap of all sectors
either, and for performance it's almost negligible for sequential RW.

I don't think Btree handling would be a performance bottleneck, as
NODATACOW for data doesn't improve much performance other than the
implied NODATASUM.

>
>>>
>>> This for two main reasons:
>>> 1) in future BTRFS may get the ability of allocating this block group
>>> in a
>>> dedicate disks set. I see two main cases:
>>> a) in case of raid6, we can store the intent bitmap (or the journal)
>>> in a
>>> raid1C3 BG allocated in the faster disks. The cons is that each block
>>> has to be
>>> written 3x2 times. But if you have an hybrid disks set (some ssd and
>>> some hdd,
>>> you got a noticeable gain of performance)
>>
>> In fact, for 4 disk usage, RAID10 has good enough chance to tolerate 2
>> missing disks.
>>
>> In fact, the chance to tolerate two missing devices for 4 disks RAID10
>> is:
>>
>> 4 / 6 =3D 66.7%
>>
>> 4 is the total valid combinations, no order involved, including:
>> (1, 3), (1, 4), (2, 3) (2, 4).
>> (Or 4C2 - 2)
>>
>> 6 is the 4C2.
>>
>> So really no need to go RAID1C3 unless you're really want to ensured 2
>> disks tolerance.
>
> I don't get the point: I started talking about raid6. The raid6 is two
> failures proof (you need three failure to see the problem... in theory).
>
> If P is the probability of a disk failure (with P << 1), the likelihood =
of
> a RAID6 failure is O(P^3). The same is RAID1C3.
>
> Instead RAID10 failure likelihood is only a bit lesser than two disk
> failure:
> RAID10 (4 disks) failure is O(0.66 * P^2) ~ O(P^2).
>
> Because P is << 1 then=C2=A0 P^3 << 0.66 * P^2.

My point here is, although RAID10 is not ensured to lose 2 disks, just
losing two disks still have a high enough chance to survive.

While RAID10 only have two copies of data, instead of 3 from RAID1C3,
such cost saving can be attractive for a lot of users though.

Thanks,
Qu

>>
>>> b) another option is to spread the intent bitmap (or the journal) in
>>> *all* disks,
>>> where each disks contains only the the related data (if we update only
>>> disk #1
>>> and disk #2, we have to update only the intent bitmap (or the
>>> journal) in
>>> disk #1 and=C2=A0 disk #2)
>>
>> That's my initial per-device reservation method.
>>
>> But for write-intent tree, I tend to not go that way, but with a
>> RO-compatible flag instead, as it's much simpler and more back
>> compatible.
>>
>> Thanks,
>> Qu
>>>
>>>
>>> 2) having a dedicate bg for the intent bitmap (or the journal), has
>>> another big
>>> advantage: you don't need to change the meaning of the raid5/6 bg. Thi=
s
>>> means
>>> that an older kernel can read/write a raid5/6 filesystem: it sufficien=
t
>>> to ignore
>>> the intent bitmap (or the journal)
>>>
>>>
>>>
>>>>
>>>> Furthermore, this even allows us to go something like bitmap tree, fo=
r
>>>> such write-intent bitmap.
>>>> And as long as the user is not using RAID56 for metadata (maybe even
>>>> it's OK to use RAID56 for metadata), it should be pretty safe against
>>>> most write-hole (for metadata and CoW data only though, nocow data is
>>>> still affected).
>>>>
>>>> Thus I believe this can be a valid path to explore, and even have a
>>>> higher priority than full journal.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>
>>>
>>>
>
>
