Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408BA543A80
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 19:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbiFHRc1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 13:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiFHRcY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 13:32:24 -0400
Received: from libero.it (smtp-16.italiaonline.it [213.209.10.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF79B102D
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 10:32:21 -0700 (PDT)
Received: from [192.168.1.27] ([84.220.25.110])
        by smtp-16.iol.local with ESMTPA
        id yzXYn9Wec4YHxyzXYnbD2j; Wed, 08 Jun 2022 19:32:20 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1654709540; bh=kKPV05FUm6JSuf44lKIhCe+rZzfAcM6/W70USDmsS5M=;
        h=From;
        b=fypWSe3nGRgi5rP283SsZMzsErYTT1DKcCaowEyDUTmXuFPZ1XTFBQZ0esM5P+Gf/
         3SD2lgdawR4CZKEU87eDgdqHDiTtiaaEJpP/Y6mbzCgR+V0XeRRndicmbkYDYUH2iq
         EDgFFC1c5CaBmeDYsvwTI3Ru5ToobCOTKVCm29F4UyFRJJ2FO5fMBP5jPVoM1IQGfe
         SO6zoDK3pPlQTUXJjzLXKwbsuAK8SQGlu9IYjrsYg1UNEw2RyLauiZ8Bjwml02i4mZ
         G2/IZJsmJSIofw4QhfJ+yM0b/247t+XBi43Tp/UiM7wBGQ6b2ahK+6aac1Fwfq3SOv
         bJGwlr7vwLFCw==
X-CNFS-Analysis: v=2.4 cv=cbYXElPM c=1 sm=1 tr=0 ts=62a0dd24 cx=a_exe
 a=UrC+9AN/Oct56HHGXTc7PQ==:117 a=UrC+9AN/Oct56HHGXTc7PQ==:17
 a=IkcTkHD0fZMA:10 a=7YfXLusrAAAA:8 a=Uq0mbvy6AAAA:8 a=VwQbUJbxAAAA:8
 a=k24e1_OxQHP_L4nHD_gA:9 a=QEXdDO2ut3YA:10 a=SLz71HocmBbuEhFRYD3r:22
 a=9nAYT2xhiIK_ZOnRzmc7:22 a=AjGcO6oz07-iQ99wixmX:22
Message-ID: <4a53d2ef-c843-aeb3-ac92-719855ad90cb@libero.it>
Date:   Wed, 8 Jun 2022 19:32:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH DRAFT] btrfs: RAID56J journal on-disk format draft
Content-Language: en-US
To:     Lukas Straub <lukasstraub2@web.de>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
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
 <20220608151736.6731b1d9@gecko>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <20220608151736.6731b1d9@gecko>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfNNHriyZxqCGgH2gI4USnp9JpFJ/PqdAT8AT6PJ3KN+dt8eipk/XUCJvg0oDp2dfCJxf9B2V+UC1WFManKfnVNiebErBZk2VyjYIKcvn8B2wAIX6pfFB
 bMW81vaNjYyPcePUU5Nm0FEg+yFLQSLo9jdMFOkkBAV3GSb+CmUO0/Ems3VgheDemS2dqRslNMT6XGy2VFtYseh1msmeDrnbBEY8naFC+uY6NUMjkcaBmBvW
 KtyNrLsHOnaM9F5YRDpArAAWoO0lbJataZW3ogsJS2FC2RSFC3R2Zyt+qRlbZvmvqg0qUtDV4sxMyy7kBhX0BngxpDtdgrz1nm6l0LEMv0RWZk2IK75zAL78
 JO0tnzqo
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 08/06/2022 17.17, Lukas Straub wrote:
> On Fri, 3 Jun 2022 17:59:59 +0800
> Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> 
>> On 2022/6/3 17:32, Lukas Straub wrote:
>>> On Thu, 2 Jun 2022 05:37:11 +0800
>>> Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>   
>>>> On 2022/6/2 02:49, Martin Raiber wrote:
>>>>> On 01.06.2022 12:12 Qu Wenruo wrote:
>>>>>>
>>>>>>
>>>>>> On 2022/6/1 17:56, Paul Jones wrote:
>>>>>>>   
>>>>>>>> -----Original Message-----
>>>>>>>> From: Qu Wenruo <quwenruo.btrfs@gmx.com>
>>>>>>>> Sent: Wednesday, 1 June 2022 7:27 PM
>>>>>>>> To: Wang Yugui <wangyugui@e16-tech.com>
>>>>>>>> Cc: linux-btrfs@vger.kernel.org
>>>>>>>> Subject: Re: [PATCH DRAFT] btrfs: RAID56J journal on-disk format draft
>>>>>>>>
>>>>>>>>   
>>>>>>>   
>>>>>>>>>>> If we save journal on every RAID56 HDD, it will always be very slow,
>>>>>>>>>>> because journal data is in a different place than normal data, so
>>>>>>>>>>> HDD seek is always happen?
>>>>>>>>>>>
>>>>>>>>>>> If we save journal on a device just like 'mke2fs -O journal_dev' or
>>>>>>>>>>> 'mkfs.xfs -l logdev', then this device just works like NVDIMM?  We
>>>>>>>>>>> may not need
>>>>>>>>>>> RAID56/RAID1 for journal data.
>>>>>>>>>>
>>>>>>>>>> That device is the single point of failure. You lost that device,
>>>>>>>>>> write hole come again.
>>>>>>>>>
>>>>>>>>> The HW RAID card have 'single point of failure'  too, such as the
>>>>>>>>> NVDIMM inside HW RAID card.
>>>>>>>>>
>>>>>>>>> but  power-lost frequency > hdd failure frequency  > NVDIMM/ssd
>>>>>>>>> failure frequency
>>>>>>>>
>>>>>>>> It's a completely different level.
>>>>>>>>
>>>>>>>> For btrfs RAID, we have no special treat for any disk.
>>>>>>>> And our RAID is focusing on ensuring device tolerance.
>>>>>>>>
>>>>>>>> In your RAID card case, indeed the failure rate of the card is much lower.
>>>>>>>> In journal device case, how do you ensure it's still true that the journal device
>>>>>>>> missing possibility is way lower than all the other devices?
>>>>>>>>
>>>>>>>> So this doesn't make sense, unless you introduce the journal to something
>>>>>>>> definitely not a regular disk.
>>>>>>>>
>>>>>>>> I don't believe this benefit most users.
>>>>>>>> Just consider how many regular people use dedicated journal device for
>>>>>>>> XFS/EXT4 upon md/dm RAID56.
>>>>>>>
>>>>>>> A good solid state drive should be far less error prone than spinning drives, so would be a good candidate. Not perfect, but better.
>>>>>>>
>>>>>>> As an end user I think focusing on stability and recovery tools is a better use of time than fixing the write hole, as I wouldn't even consider using Raid56 in it's current state. The write hole problem can be alleviated by a UPS and not using Raid56 for a busy write load. It's still good to brainstorm the issue though, as it will need solving eventually.
>>>>>>
>>>>>> In fact, since write hole is only a problem for power loss (and explicit
>>>>>> degraded write), another solution is, only record if the fs is
>>>>>> gracefully closed.
>>>>>>
>>>>>> If the fs is not gracefully closed (by a bit in superblock), then we
>>>>>> just trigger a full scrub on all existing RAID56 block groups.
>>>>>>
>>>>>> This should solve the problem, with the extra cost of slow scrub for
>>>>>> each unclean shutdown.
>>>>>>
>>>>>> To be extra safe, during that scrub run, we really want user to wait for
>>>>>> the scrub to finish.
>>>>>>
>>>>>> But on the other hand, I totally understand user won't be happy to wait
>>>>>> for 10+ hours just due to a unclean shutdown...
>>>>> Would it be possible to put the stripe offsets/numbers into a journal/commit them before write? Then, during mount you could scrub only those after an unclean shutdown.
>>>>
>>>> If we go that path, we can already do full journal, and only replay that
>>>> journal without the need for scrub at all.
>>>
>>> Hello Qu,
>>>
>>> If you don't care about the write-hole, you can also use a dirty bitmap
>>> like mdraid 5/6 does. There, one bit in the bitmap represents for
>>> example one gigabyte of the disk that _may_ be dirty, and the bit is left
>>> dirty for a while and doesn't need to be set for each write. Or you
>>> could do a per-block-group dirty bit.
>>
>> That would be a pretty good way for auto scrub after dirty close.
>>
>> Currently we have quite some different ideas, but some are pretty
>> similar but at different side of a spectrum:
>>
>>       Easier to implement        ..     Harder to implement
>> |<- More on mount time scrub   ..     More on journal ->|
>> |					|	|	\- Full journal
>> |					|	\--- Per bg dirty bitmap
>> |					\----------- Per bg dirty flag
>> \--------------------------------------------------- Per sb dirty flag
>>
>> In fact, the dirty bitmap is just a simplified version of journal (only
>> record the metadata, without data).
>> Unlike dm/dm-raid56, with btrfs scrub, we should be able to fully
>> recover the data without problem.
>>
>> Even with per-bg dirty bitmap, we still need some extra location to
>> record the bitmap. Thus it needs a on-disk format change anyway.
>>
>> Currently only sb dirty flag may be backward compatible.
>>
>> And whether we should wait for the scrub to finish before allowing use
>> to do anything into the fs is also another concern.
>>
>> Even using bitmap, we may have several GiB data needs to be scrubbed.
>> If we wait for the scrub to finish, it's the best and safest way, but
>> users won't be happy at all.
>>
> 
> Hmm, but it doesn't really make a difference in safety whether we allow
> use while scrub/resync is running: The disks have inconsistent data and
> if we now loose one disk, write-hole happens.

This is not correct. When you update the data, to compute the parity you
should read all the data and check the checksums. Then you can
write the (correct) parity.

For raid5 there is an optimization, so you don't need to read all the stripes:
you can compute the new parity as

	new-parity = old-parity ^ new-data ^ old-data

This would create the write hole, but I hope that BTRFS doesn't have this
optimization.


> 
> The only thing to watch out for while scrub/resync is running and a
> write is submitted to the filesystem, is to scrub the stripe before
> writing to it.
> 
> 
> Regards,
> Lukas Straub
> 
>> If we go scrub resume way, it's faster but still leaves a large window
>> to allow write-hole to reduce our tolerance.
>>
>> Thanks,
>> Qu
>>>
>>> And while you're at it, add the same mechanism to all the other raid
>>> and dup modes to fix the inconsistency of NOCOW files after a crash.
>>>
>>> Regards,
>>> Lukas Straub
>>>   
>>>> Thanks,
>>>> Qu
>>>>   
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>   
>>>>>>>
>>>>>>> Paul.
>>>>>
>>>>>   
>>>
>>>
>>>   
> 
> 
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
