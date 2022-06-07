Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1BB53F35A
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jun 2022 03:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbiFGB1Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jun 2022 21:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235639AbiFGB1X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jun 2022 21:27:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FAD25289
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 18:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654565227;
        bh=C7zPndnO1zEp+pqu1I+j2hThHXT0bDydJ2/JzfYAKEM=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=I5HJiH7DjGMnvJ3IykbIl1bMqfdUlcPcsYaZfTY0y4PTCyq8TKnrpaiyaEZu1XMSL
         s93MiRNQNmu1uiD594/PncnykfY9gaAet2mtvgewDsLWPaS7L8ZWtOOM43752CGT1i
         ysRofbPmSmmeQ8SlIvTPCowMFhyhTXeByHPi4ZVI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MatVb-1nMZKz1TXX-00cNvn; Tue, 07
 Jun 2022 03:27:07 +0200
Message-ID: <2575376b-fbd9-8406-3684-7fbc3899ddf3@gmx.com>
Date:   Tue, 7 Jun 2022 09:27:01 +0800
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
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH DRAFT] btrfs: RAID56J journal on-disk format draft
In-Reply-To: <128e0119-088b-7a10-c874-551196df4c56@libero.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lipDI+5QPcM8EyLv+Sl18umATpfeLEmAcQHLTTqVbJLNC2rgr+N
 DY8Cc8hXH+IrMxB1Uanzgkw+TUzQ6aQhRmypahQVgbZcwUXoozlXWFVmnr/zpx9gaNMxCCB
 17WidD9L5k9ls+sbjBov9+ZyzbqrtJOhyYcYfOLJi+cqW6GIrItBSFjsHm2QnwHHFScqItG
 C7CDZSgFdCUPens02CoTQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fSl/YkWiX9g=:T8cP94uOidnI5UazJozKyY
 3/evT+aeQg2EfiBHd8xy98IH5eR/kwK7MYjdnmbcDZaWNWad6AfFdlj1v44EPrIl0YGn6+NT7
 GBW2z28LaFPenmNgTyVRDT1REybc/a+WQAuaa3uOhx+hPPUFWU1ZazqQkT93LtHeWys1H92tL
 zYSbutLk2zeDOV1x2RtN73u1zjF25CCz56ZudyR1wIWNuwIA5xHt0H+iqkCoijI79bMtizqWH
 UmZKNgWNTNDdasKEi8c1m/q0HmJsghoR+eAArwIicXDnGkSmTUjrWHNnM9snLkXQzCrn0SYTS
 Rs9yuGpVS1KG54tb9qyiUomub2fk+kCFpAA2pX7AeXZLATVqp2Or6CPC5iFmLdk8pTghPqy+R
 pHVnAArAa8Ntv4BPyx4f+ZbhrMfJ5McEe4CTLU3J4q+xkQ5PGrO90b6gmuKJXS0/SR8n0yLdR
 Vi7gW9HSsOOZa6Nd23tzO9Ubss3h24P8UIwaVOKdnfl5Rb4yQ9G6tOcgmAIlru4uk2epiauzT
 1QUZXD/elXJxUWg9GUZLQKrr9vC6gejr1Fqgrfj19Bjz/FQgoWx5jpTRBltzsHSyB+gJ1RaFG
 LD1JK2NwxWlktDJPhwfaJbbnEzS2o11Qh40XeUmIgNZjZVcrBBCtPv9nJQZrTcxkDdqPsBMcu
 fALNrlpMaEZsTGmSRi/X637atOvzG/wqbhgYmlRGHRzYKbWVX8Pcf5Xa4L6wHlFl5JZPt52t8
 ZMZLH+uxJIlwuFf9G2QG7bqiCPVldpEORisSMhFXnkxwKM2HAZoJryJGhznEA5KSMZx8IUxhJ
 V1Mv79+biewOImetikP5+RtI6e6K3qIl+sl0I47iH3kLfXfztTy+5Osk56W8q2jH8lX/XAeaS
 3uRQzJaKdFkcOWWIGrgsjCdOqnSZSdQNuhnxCu/8k2ZOQ4S0cpXgVno0WTnGcSNxChWSL6Vao
 mBE9b59BnF3MZj5E7iaT0C44BCQf1spT62wPZ4PDj1lWO76t+j1Rt1h5QqiLynjpaSOpGWBoC
 i20UW+pmrwRXfLaPozYEZgo9CSGUHEaFxKJViHGY7ToHcQFFxksaBZbVGQqi5sn1EBDPcX8B4
 RfCYPU4e/dO082+itMmEnGjNxuTFM1D3qYnkFDy0XQi5tgji9j4Miobpg==
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/7 02:10, Goffredo Baroncelli wrote:
> Hi Qu,
>
> On 06/06/2022 13.21, Qu Wenruo wrote:
>>
>>
>> On 2022/6/6 16:16, Qu Wenruo wrote:
>>>
>>>
>> [...]
>>>>>
>>>>> Hello Qu,
>>>>>
>>>>> If you don't care about the write-hole, you can also use a dirty
>>>>> bitmap
>>>>> like mdraid 5/6 does. There, one bit in the bitmap represents for
>>>>> example one gigabyte of the disk that _may_ be dirty, and the bit is
>>>>> left
>>>>> dirty for a while and doesn't need to be set for each write. Or you
>>>>> could do a per-block-group dirty bit.
>>>>
>>>> That would be a pretty good way for auto scrub after dirty close.
>>>>
>>>> Currently we have quite some different ideas, but some are pretty
>>>> similar but at different side of a spectrum:
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Easier to implement=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ..=C2=A0=C2=A0=C2=A0=C2=A0 Harder to implement
>>>> |<- More on mount time scrub=C2=A0=C2=A0 ..=C2=A0=C2=A0=C2=A0=C2=A0 M=
ore on journal ->|
>>>> |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0 \- Full journal
>>>> |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 \--- =
Per bg dirty bitmap
>>>> |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \----------- Per bg dirty=
 flag
>>>> \--------------------------------------------------- Per sb dirty fla=
g
>>>
>>> In fact, recently I'm checking the MD code (including their MD-raid5).
>>>
>>> It turns out they have write-intent bitmap, which is almost the per-bg
>>> dirty bitmap in above spectrum.
>>>
>>> In fact, since btrfs has all the CoW and checksum for metadata (and pa=
rt
>>> of its data), btrfs scrub can do a much better job than MD to resilver
>>> the range.
>>>
>>> Furthermore, we have a pretty good reserved space (1M), and has a pret=
ty
>>> reasonable stripe length (1GiB).
>>> This means, we only need 32KiB for the bitmap for each RAID56 stripe,
>>> much smaller than the 1MiB we reserved.
>>>
>>> I think this can be a pretty reasonable middle ground, faster than ful=
l
>>> journal, while the amount to scrub should be reasonable enough to be
>>> done at mount time.
>
> Raid5 is "single fault proof". This means that it can sustain only one
> failure *at time* like:
> 1) unavailability of a disk (e.g. data disk failure)
> 2) a missing write in the stripe (e.g. unclean shutdown)

Yep, only one of them happen at the same time.

But to end users, they want to handle all of them at the same time.
And it's not that unreasonable to hit cases like a power loss, then one
disk also gave up.

So, I'm afraid we will want to go full journal (at least allow users to
choose) in the future for that case.

>
> a) Until now (i.e. without the "bitmap intent"), even if these failures
> happen
> in different days (i.e. not at the same time), the result may be a
> "write hole".

Yep.

>
> b) With the bitmap intent, the write hole requires that 1) and 2) happen
> at the same time. But this would be not anymore a "single fault", with
> only an
> exception: if these failure have a common cause (e.g. a power
> failure which in turn cause the dead of a disk). In this case this has
> to be
> considered "single fault".

Exactly, so the write-intent tree (I hate the DM naming, it just name it
bitmap) would still be an obvious improvement.

And that's exactly why multi-device DM profiles all have that configurable=
.

>
> But with a battery backup (i.e. no power failure), the likelihood of b)
> became
> negligible.
>
> This to say that a write intent bitmap will provide an huge
> improvement of the resilience of a btrfs raid5, and in turn raid6.
>
> My only suggestions, is to find a way to store the bitmap intent not in =
the
> raid5/6 block group, but in a separate block group, with the appropriate
> level
> of redundancy.

That's why I want to reject RAID56 as metadata, and just store the
write-intent tree into the metadata, like what we did for fsync (log tree)=
.

>
> This for two main reasons:
> 1) in future BTRFS may get the ability of allocating this block group in=
 a
> dedicate disks set. I see two main cases:
> a) in case of raid6, we can store the intent bitmap (or the journal) in =
a
> raid1C3 BG allocated in the faster disks. The cons is that each block
> has to be
> written 3x2 times. But if you have an hybrid disks set (some ssd and
> some hdd,
> you got a noticeable gain of performance)

In fact, for 4 disk usage, RAID10 has good enough chance to tolerate 2
missing disks.

In fact, the chance to tolerate two missing devices for 4 disks RAID10 is:

4 / 6 =3D 66.7%

4 is the total valid combinations, no order involved, including:
(1, 3), (1, 4), (2, 3) (2, 4).
(Or 4C2 - 2)

6 is the 4C2.

So really no need to go RAID1C3 unless you're really want to ensured 2
disks tolerance.

> b) another option is to spread the intent bitmap (or the journal) in
> *all* disks,
> where each disks contains only the the related data (if we update only
> disk #1
> and disk #2, we have to update only the intent bitmap (or the journal) i=
n
> disk #1 and=C2=A0 disk #2)

That's my initial per-device reservation method.

But for write-intent tree, I tend to not go that way, but with a
RO-compatible flag instead, as it's much simpler and more back compatible.

Thanks,
Qu
>
>
> 2) having a dedicate bg for the intent bitmap (or the journal), has
> another big
> advantage: you don't need to change the meaning of the raid5/6 bg. This
> means
> that an older kernel can read/write a raid5/6 filesystem: it sufficient
> to ignore
> the intent bitmap (or the journal)
>
>
>
>>
>> Furthermore, this even allows us to go something like bitmap tree, for
>> such write-intent bitmap.
>> And as long as the user is not using RAID56 for metadata (maybe even
>> it's OK to use RAID56 for metadata), it should be pretty safe against
>> most write-hole (for metadata and CoW data only though, nocow data is
>> still affected).
>>
>> Thus I believe this can be a valid path to explore, and even have a
>> higher priority than full journal.
>>
>> Thanks,
>> Qu
>>
>
>
>
