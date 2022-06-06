Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96C853E2FC
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jun 2022 10:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbiFFIQi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jun 2022 04:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbiFFIQi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jun 2022 04:16:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472E71D5ABD
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 01:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654503383;
        bh=9ojHWfqOQethEIWHMC5Yxj3zfpDkrX9rVIm2hSQkod8=;
        h=X-UI-Sender-Class:Date:From:To:Cc:References:Subject:In-Reply-To;
        b=HDBYY8y7KJIWjwzIrmVAFeSaQnVXbpzscWOGfATwp2CpFtYuDjaQ+tNF3YjSz1mXC
         LbQn7y8Ascuz1ueR0ArslbOkEjmX7DDN8gyjuEqVZuDReSWrbNMxl1n/iCb6XCIId5
         9RGvYUZNa34MqmikS93/J6Wp/AwV7Kb9M8FeyvU4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MFsZ3-1nzS1p2hdn-00HQR3; Mon, 06
 Jun 2022 10:16:23 +0200
Message-ID: <252577ba-1659-62f8-fc44-fea506eb97b7@gmx.com>
Date:   Mon, 6 Jun 2022 16:16:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Lukas Straub <lukasstraub2@web.de>
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
Subject: Re: [PATCH DRAFT] btrfs: RAID56J journal on-disk format draft
In-Reply-To: <8c318892-0d36-51bb-18e0-a762dd75b723@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ifYBYAMt1ssYPDpYDsOkypAOlrsn7sElU/YGJRWz9yrNsRtB7+p
 lqa0MDhvuOTgoAG93i9E05xsWnQC3f97NV0rRpWR5vuZw7DCZnFL3fWB2tdy3RNi7yUw/74
 htdimR3mG2QNLBmooU5SVaXJM0y7ja6bKwiYHkbCR5I9BAV+vuAJwLXbVKrNTvR5j2aflL1
 qyGU/NPr+4KW9m0+jI0/Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sYYDurZgUFA=:2uwUUoBgjwrxMjAF6KSwlF
 QzjeqXRt9zODexnHWcNkVhOOY086HVIF7wr5Rzxkg061LNHKK2IlasILH/YNmC033d3I3CdpK
 2AC8DLWwFr6JSse1ZI3PyehPeMnqrkTiRWIyFqxnVmrBnN+3rrTuyLuKuVrbLiZ4LZZZvBGAS
 gwJO2vtFE3nUREJVVDFsisloE9BboKAIn9Q/yC7GA3OVvY3IGDSAzo+IrLFFY9YFceZUpmfpz
 TEOPzl3fZnxR4N+pyN/9MtwFQLvJodc3IeSxQ5ecWhIptqnrb2+rexaKwy/4pGL7JbvIrMQDG
 nODVz92uEElOMmlaDew+3LoLXfHh1s2atTHP0QQb9YqpZGY8qnwCOG2mSpawWMs8mxonxMFVb
 Lsf/+38TZwDRy3mh6VDMgFpNVMjxQKFaQJ648CsJBgDml4xr6r5jSCqFk6bn8npe7Y6Dqulr0
 pIUJ4gZGuRmNnEv2+v3AF2vGI8iQoUrtqa6pfTaZwI/WtED4pIpixTt+mks7klFtL8TXv+okR
 WqYWYg+UIpJMZi4bTBxnxP69hwKJjk2hgyPHrIA/ghMSJq+aLUAHlmo5935mfsuMnSqI81kQc
 O37HIRlkOmnbbkkkkJsGfFwI1vSZi7Fnr/jOGphsdlLXxzajb80BfhULpRr7+8yDfDLuKZFM/
 jPBtXC2tNK6RL+OY7UCbjgID7SzJZQ3PziyQEsd0FTl1XXmgpF1h45BpgiZ60N5cbJwXljp+p
 xFeBfsJSl9419V+ktNZBsdmvN1ipuyZ/lIAqhiJUpFcFJ7m/lx6ie/RGaFd1Pps8iTHuZZJK7
 VXNYC8S0nN43eYYAyCjbUXsBZxvsCSi/YmyIH7Z+PnYlQ+CEFqCQEhnmjuyt37QiWzKNnKpBP
 rAB0kK3d0Jejqu8yiudPc/+O1fMg9g2M9LjYEIFLSpN/AVaF5KyS1J3uhAjTspZC4hjtbfAn6
 FqZMvO8g/1YSjuOaTCbQ/Ob+pg1ZkGeWqntt1Qqzr3psrlny0Inc/FKqekbO5n5b+OjFdnZwI
 Ao9IsUplFEbcQ9jh1ElarIEECW6JkymPL6xXDqNbwA51ngRPUz1a/r+0JlCAjBetLg8ixM52S
 tAJG2FQi2nO//c09HcPYxv5OKwN/6Jc2ucF1QKwOnpCaBzO9DUXkVEdrA==
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/3 17:59, Qu Wenruo wrote:
>
>
> On 2022/6/3 17:32, Lukas Straub wrote:
>> On Thu, 2 Jun 2022 05:37:11 +0800
>> Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>> On 2022/6/2 02:49, Martin Raiber wrote:
>>>> On 01.06.2022 12:12 Qu Wenruo wrote:
>>>>>
>>>>>
>>>>> On 2022/6/1 17:56, Paul Jones wrote:
>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: Qu Wenruo <quwenruo.btrfs@gmx.com>
>>>>>>> Sent: Wednesday, 1 June 2022 7:27 PM
>>>>>>> To: Wang Yugui <wangyugui@e16-tech.com>
>>>>>>> Cc: linux-btrfs@vger.kernel.org
>>>>>>> Subject: Re: [PATCH DRAFT] btrfs: RAID56J journal on-disk format
>>>>>>> draft
>>>>>>>
>>>>>>>
>>>>>>
>>>>>>>>>> If we save journal on every RAID56 HDD, it will always be very
>>>>>>>>>> slow,
>>>>>>>>>> because journal data is in a different place than normal data, =
so
>>>>>>>>>> HDD seek is always happen?
>>>>>>>>>>
>>>>>>>>>> If we save journal on a device just like 'mke2fs -O
>>>>>>>>>> journal_dev' or
>>>>>>>>>> 'mkfs.xfs -l logdev', then this device just works like
>>>>>>>>>> NVDIMM?=C2=A0 We
>>>>>>>>>> may not need
>>>>>>>>>> RAID56/RAID1 for journal data.
>>>>>>>>>
>>>>>>>>> That device is the single point of failure. You lost that device=
,
>>>>>>>>> write hole come again.
>>>>>>>>
>>>>>>>> The HW RAID card have 'single point of failure'=C2=A0 too, such a=
s the
>>>>>>>> NVDIMM inside HW RAID card.
>>>>>>>>
>>>>>>>> but=C2=A0 power-lost frequency > hdd failure frequency=C2=A0 > NV=
DIMM/ssd
>>>>>>>> failure frequency
>>>>>>>
>>>>>>> It's a completely different level.
>>>>>>>
>>>>>>> For btrfs RAID, we have no special treat for any disk.
>>>>>>> And our RAID is focusing on ensuring device tolerance.
>>>>>>>
>>>>>>> In your RAID card case, indeed the failure rate of the card is
>>>>>>> much lower.
>>>>>>> In journal device case, how do you ensure it's still true that
>>>>>>> the journal device
>>>>>>> missing possibility is way lower than all the other devices?
>>>>>>>
>>>>>>> So this doesn't make sense, unless you introduce the journal to
>>>>>>> something
>>>>>>> definitely not a regular disk.
>>>>>>>
>>>>>>> I don't believe this benefit most users.
>>>>>>> Just consider how many regular people use dedicated journal
>>>>>>> device for
>>>>>>> XFS/EXT4 upon md/dm RAID56.
>>>>>>
>>>>>> A good solid state drive should be far less error prone than
>>>>>> spinning drives, so would be a good candidate. Not perfect, but
>>>>>> better.
>>>>>>
>>>>>> As an end user I think focusing on stability and recovery tools is
>>>>>> a better use of time than fixing the write hole, as I wouldn't
>>>>>> even consider using Raid56 in it's current state. The write hole
>>>>>> problem can be alleviated by a UPS and not using Raid56 for a busy
>>>>>> write load. It's still good to brainstorm the issue though, as it
>>>>>> will need solving eventually.
>>>>>
>>>>> In fact, since write hole is only a problem for power loss (and
>>>>> explicit
>>>>> degraded write), another solution is, only record if the fs is
>>>>> gracefully closed.
>>>>>
>>>>> If the fs is not gracefully closed (by a bit in superblock), then we
>>>>> just trigger a full scrub on all existing RAID56 block groups.
>>>>>
>>>>> This should solve the problem, with the extra cost of slow scrub for
>>>>> each unclean shutdown.
>>>>>
>>>>> To be extra safe, during that scrub run, we really want user to
>>>>> wait for
>>>>> the scrub to finish.
>>>>>
>>>>> But on the other hand, I totally understand user won't be happy to
>>>>> wait
>>>>> for 10+ hours just due to a unclean shutdown...
>>>> Would it be possible to put the stripe offsets/numbers into a
>>>> journal/commit them before write? Then, during mount you could scrub
>>>> only those after an unclean shutdown.
>>>
>>> If we go that path, we can already do full journal, and only replay th=
at
>>> journal without the need for scrub at all.
>>
>> Hello Qu,
>>
>> If you don't care about the write-hole, you can also use a dirty bitmap
>> like mdraid 5/6 does. There, one bit in the bitmap represents for
>> example one gigabyte of the disk that _may_ be dirty, and the bit is le=
ft
>> dirty for a while and doesn't need to be set for each write. Or you
>> could do a per-block-group dirty bit.
>
> That would be a pretty good way for auto scrub after dirty close.
>
> Currently we have quite some different ideas, but some are pretty
> similar but at different side of a spectrum:
>
>  =C2=A0=C2=A0=C2=A0 Easier to implement=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ..=C2=A0=C2=A0=C2=A0=C2=A0 Harder to implement
> |<- More on mount time scrub=C2=A0=C2=A0 ..=C2=A0=C2=A0=C2=A0=C2=A0 More=
 on journal ->|
> |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0=C2=A0 \- Full journal
> |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 \--- Per=
 bg dirty bitmap
> |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \----------- Per bg dirty fl=
ag
> \--------------------------------------------------- Per sb dirty flag

In fact, recently I'm checking the MD code (including their MD-raid5).

It turns out they have write-intent bitmap, which is almost the per-bg
dirty bitmap in above spectrum.

In fact, since btrfs has all the CoW and checksum for metadata (and part
of its data), btrfs scrub can do a much better job than MD to resilver
the range.

Furthermore, we have a pretty good reserved space (1M), and has a pretty
reasonable stripe length (1GiB).
This means, we only need 32KiB for the bitmap for each RAID56 stripe,
much smaller than the 1MiB we reserved.

I think this can be a pretty reasonable middle ground, faster than full
journal, while the amount to scrub should be reasonable enough to be
done at mount time.

Thanks,
Qu
>
> In fact, the dirty bitmap is just a simplified version of journal (only
> record the metadata, without data).
> Unlike dm/dm-raid56, with btrfs scrub, we should be able to fully
> recover the data without problem.
>
> Even with per-bg dirty bitmap, we still need some extra location to
> record the bitmap. Thus it needs a on-disk format change anyway.
>
> Currently only sb dirty flag may be backward compatible.
>
> And whether we should wait for the scrub to finish before allowing use
> to do anything into the fs is also another concern.
>
> Even using bitmap, we may have several GiB data needs to be scrubbed.
> If we wait for the scrub to finish, it's the best and safest way, but
> users won't be happy at all.
>
> If we go scrub resume way, it's faster but still leaves a large window
> to allow write-hole to reduce our tolerance.
>
> Thanks,
> Qu
>>
>> And while you're at it, add the same mechanism to all the other raid
>> and dup modes to fix the inconsistency of NOCOW files after a crash.
>>
>> Regards,
>> Lukas Straub
>>
>>> Thanks,
>>> Qu
>>>
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>
>>>>>>
>>>>>> Paul.
>>>>
>>>>
>>
>>
>>
