Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6CA53C80B
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jun 2022 12:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243158AbiFCKAY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jun 2022 06:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243315AbiFCKAU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Jun 2022 06:00:20 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FAF3AA55
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Jun 2022 03:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654250404;
        bh=wvOqE95of770cfPeRxRE6r/aXHfDQhs2qkCXKXmo7Ns=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=hjSS8fF0ESEKI1RKvNZXZsWijFiWLVa4tsk5JGhoIsad5bxK41I1NqhJfbrmfzDzL
         OjXE8jox99k1DTXTNSM+mbkZ/f60+tXfVp1wisaKTETzqPwFAZCQ/2Ob0Vrlxn/O+3
         Qdk2Q2Z1h6wxRPanRsWFbH+H7WhEQrqvEsf00MPs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MfpSl-1nGpOk2g01-00gHkY; Fri, 03
 Jun 2022 12:00:04 +0200
Message-ID: <8c318892-0d36-51bb-18e0-a762dd75b723@gmx.com>
Date:   Fri, 3 Jun 2022 17:59:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
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
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH DRAFT] btrfs: RAID56J journal on-disk format draft
In-Reply-To: <20220603093207.6722d77a@gecko>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BT4M4I8v9rFez/c8+pASWG5r6PaLsDK54uytZ28yE7dmW2Ie5Fl
 fcNq0/DeU4xxMuQOw7DNZpZjG8hyIvECaLPhIVwjYaZZrgyOoxsp10kg7GuJqKIaa5N8Fi1
 Nb0EOlqEZG4a9rP1JAXaWGAM+/J7Tbj3mHrVgPuke8+agZd5WMKWopQQEMQYOMwXHXIV1SL
 VpPFnZaMWXQPDWoQucOuA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bMdfQ/iduoM=:xiVANdyzzuyLj/FZ7JShdQ
 vgSw4+yCnuGCD8TfhQc5FAmK/ubfdk9P0PBx1zsdPeTYORiwKV+mpUWkydxVgcmdM2+T4j38O
 xpB23Pfy342p9AcTXXpWYbi2xZdY0JiCTtVDRAstcMIHLeMoPpGLNUC9LJzAOaSHETqBK74xW
 xsWYNoYOCBZyUOT8CGqfjiiI2pIGkDqzF5+DdNKP4kfGztIbOKUQAcSmjtb0l58ERNmFlFt4t
 dgrZMf0n0wmh43Tk9T0j2ec5c/omH74pcAU+7dqKQmz59fcYs7IiYoC4hW0hUIY8fI6IaXfgn
 nGs5mNor5MgTu22IE5L4Pg7MLSgvD6YOQc10rHSLOTQsNYP2MCZG6Rle7a7vPCDQXWy1b80Hs
 xhyP24SAkJrqkD74WiFjMBINfVyiOEczG9SfYIHH4bsUrbGB3+IIQ9cOUeZDBqGnNV2SGoRHS
 M61txVOMIRIMeX25yX2XJgfayJl2IbiUVApCCvfzYwA2SRS++j04ckW5BLsiz51XM/AKzIZR5
 DTVqtaAiDWou3aVXuNLBqqyW6VlBFnC3yyk/+Fa9WSyQRTUgMSvbcns+CrQkvU6eFI31pce6Q
 dK1xj3dPw/W59x9l+1vhA1AoulmUhsYZVue24SOg7G+k/QFlR9LTC1YjTfPeWiP+b5UuNsWpj
 KVPnBBA52KRaCW4LtVAnD93pv/YGL0zrfDdlcku08IiA4VD9nJT1oGuXM7K90Fm/xGtO4KPpD
 SY+al2G1wxXE6JzvPKYl5RFR5c77pF/y/p53hE3s9Fbud0ZMSmqpAR+8N36OvPiDJVZmD/9vr
 loPvLNekGR/PqB6CihiSdmDgxEbDOphZClgjdQ0omHDcsJJznFD9b/nP2Aq9ir/Ow/uKVjA7j
 pd39hrHrs/pP789icatY0iV0BA/qHh8o3NqtRi6QrmZp9OmUy6w21E5tVoGtAshdx34obQNsO
 Nguas8GLL9YLG7Uiqb6qeEbkZnLlp7AGhjAi8La4BMq/yvcQ/uCTU/uC6Ud+gfvTq+iV6Vtj/
 nG/TRBZpCP6wPLv2yIW+fj/H6pTXx3LFgGiwRwjQ0Bjm3zlJyXsaPbQXuuV7U7LPuH9sD7GBB
 8/Itut9SdgZgMjbixRWrykszIOzaDVOHIKBJ9Wlz87IfDibId3sO/9Rpw==
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/3 17:32, Lukas Straub wrote:
> On Thu, 2 Jun 2022 05:37:11 +0800
> Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>> On 2022/6/2 02:49, Martin Raiber wrote:
>>> On 01.06.2022 12:12 Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2022/6/1 17:56, Paul Jones wrote:
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Qu Wenruo <quwenruo.btrfs@gmx.com>
>>>>>> Sent: Wednesday, 1 June 2022 7:27 PM
>>>>>> To: Wang Yugui <wangyugui@e16-tech.com>
>>>>>> Cc: linux-btrfs@vger.kernel.org
>>>>>> Subject: Re: [PATCH DRAFT] btrfs: RAID56J journal on-disk format dr=
aft
>>>>>>
>>>>>>
>>>>>
>>>>>>>>> If we save journal on every RAID56 HDD, it will always be very s=
low,
>>>>>>>>> because journal data is in a different place than normal data, s=
o
>>>>>>>>> HDD seek is always happen?
>>>>>>>>>
>>>>>>>>> If we save journal on a device just like 'mke2fs -O journal_dev'=
 or
>>>>>>>>> 'mkfs.xfs -l logdev', then this device just works like NVDIMM?=
=C2=A0 We
>>>>>>>>> may not need
>>>>>>>>> RAID56/RAID1 for journal data.
>>>>>>>>
>>>>>>>> That device is the single point of failure. You lost that device,
>>>>>>>> write hole come again.
>>>>>>>
>>>>>>> The HW RAID card have 'single point of failure'=C2=A0 too, such as=
 the
>>>>>>> NVDIMM inside HW RAID card.
>>>>>>>
>>>>>>> but=C2=A0 power-lost frequency > hdd failure frequency=C2=A0 > NVD=
IMM/ssd
>>>>>>> failure frequency
>>>>>>
>>>>>> It's a completely different level.
>>>>>>
>>>>>> For btrfs RAID, we have no special treat for any disk.
>>>>>> And our RAID is focusing on ensuring device tolerance.
>>>>>>
>>>>>> In your RAID card case, indeed the failure rate of the card is much=
 lower.
>>>>>> In journal device case, how do you ensure it's still true that the =
journal device
>>>>>> missing possibility is way lower than all the other devices?
>>>>>>
>>>>>> So this doesn't make sense, unless you introduce the journal to som=
ething
>>>>>> definitely not a regular disk.
>>>>>>
>>>>>> I don't believe this benefit most users.
>>>>>> Just consider how many regular people use dedicated journal device =
for
>>>>>> XFS/EXT4 upon md/dm RAID56.
>>>>>
>>>>> A good solid state drive should be far less error prone than spinnin=
g drives, so would be a good candidate. Not perfect, but better.
>>>>>
>>>>> As an end user I think focusing on stability and recovery tools is a=
 better use of time than fixing the write hole, as I wouldn't even conside=
r using Raid56 in it's current state. The write hole problem can be allevi=
ated by a UPS and not using Raid56 for a busy write load. It's still good =
to brainstorm the issue though, as it will need solving eventually.
>>>>
>>>> In fact, since write hole is only a problem for power loss (and expli=
cit
>>>> degraded write), another solution is, only record if the fs is
>>>> gracefully closed.
>>>>
>>>> If the fs is not gracefully closed (by a bit in superblock), then we
>>>> just trigger a full scrub on all existing RAID56 block groups.
>>>>
>>>> This should solve the problem, with the extra cost of slow scrub for
>>>> each unclean shutdown.
>>>>
>>>> To be extra safe, during that scrub run, we really want user to wait =
for
>>>> the scrub to finish.
>>>>
>>>> But on the other hand, I totally understand user won't be happy to wa=
it
>>>> for 10+ hours just due to a unclean shutdown...
>>> Would it be possible to put the stripe offsets/numbers into a journal/=
commit them before write? Then, during mount you could scrub only those af=
ter an unclean shutdown.
>>
>> If we go that path, we can already do full journal, and only replay tha=
t
>> journal without the need for scrub at all.
>
> Hello Qu,
>
> If you don't care about the write-hole, you can also use a dirty bitmap
> like mdraid 5/6 does. There, one bit in the bitmap represents for
> example one gigabyte of the disk that _may_ be dirty, and the bit is lef=
t
> dirty for a while and doesn't need to be set for each write. Or you
> could do a per-block-group dirty bit.

That would be a pretty good way for auto scrub after dirty close.

Currently we have quite some different ideas, but some are pretty
similar but at different side of a spectrum:

     Easier to implement        ..     Harder to implement
|<- More on mount time scrub   ..     More on journal ->|
|					|	|	\- Full journal
|					|	\--- Per bg dirty bitmap
|					\----------- Per bg dirty flag
\--------------------------------------------------- Per sb dirty flag

In fact, the dirty bitmap is just a simplified version of journal (only
record the metadata, without data).
Unlike dm/dm-raid56, with btrfs scrub, we should be able to fully
recover the data without problem.

Even with per-bg dirty bitmap, we still need some extra location to
record the bitmap. Thus it needs a on-disk format change anyway.

Currently only sb dirty flag may be backward compatible.

And whether we should wait for the scrub to finish before allowing use
to do anything into the fs is also another concern.

Even using bitmap, we may have several GiB data needs to be scrubbed.
If we wait for the scrub to finish, it's the best and safest way, but
users won't be happy at all.

If we go scrub resume way, it's faster but still leaves a large window
to allow write-hole to reduce our tolerance.

Thanks,
Qu
>
> And while you're at it, add the same mechanism to all the other raid
> and dup modes to fix the inconsistency of NOCOW files after a crash.
>
> Regards,
> Lukas Straub
>
>> Thanks,
>> Qu
>>
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>> Paul.
>>>
>>>
>
>
>
