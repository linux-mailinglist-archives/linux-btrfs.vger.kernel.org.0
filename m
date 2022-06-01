Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7746A53A988
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 17:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241776AbiFAPEc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 11:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbiFAPEb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 11:04:31 -0400
X-Greylist: delayed 506 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Jun 2022 08:04:30 PDT
Received: from mail.render-wahnsinn.de (render-wahnsinn.de [138.201.18.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B612E0BF
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 08:04:30 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 96E7F2F35FD
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 16:55:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=render-wahnsinn.de;
        s=dkim; t=1654095359; h=from:subject:date:message-id:cc:mime-version:content-type:
         content-transfer-encoding:content-language:in-reply-to:references;
        bh=M9tlAJ2NUD6DZQJcn7UE1nLWQPF8Zby9nkUZWlRkTng=;
        b=rbBfGBaBZ+Di8B2E05NPHl7VZBOJTuVreFbL9rLJCEFzBOdZ28iLvQbmZ51y621fQhToMA
        IhC/SUomluLDvPHNhah15GjLBqdVFc7gQHvj+NcDrCw1SGIRsHvgIWZqd9cQBTLWFpBPxA
        RGL7LnNDxFzgozbW6Dgc+HPi4fsIAK2IOxLAKzdb0/Gd01y4EbwYmp7wkhy/JZR7D1lLvR
        tal3Use1TMDBLFJHUYX02+YsJ7eqksDvmvixG23+dsNXWroBvcTaNLBdlUnYC8K12GCRDr
        t45i3hPNqg+QD8rDjdr3KHHhmV2Ep83az3YvxLNPau7mY9PVjb0jdOjFDI580g==
Message-ID: <b668009a-35e1-48bc-fcf9-2d12b9966a2b@render-wahnsinn.de>
Date:   Wed, 1 Jun 2022 16:55:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH DRAFT] btrfs: RAID56J journal on-disk format draft
Content-Language: en-US
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20220601102532.D262.409509F4@e16-tech.com>
 <49fb1216-189d-8801-d134-596284f62f1f@gmx.com>
 <20220601170741.4B12.409509F4@e16-tech.com>
 <5f49c12e-4655-48dd-0d73-49dc351eae15@gmx.com>
 <SYCPR01MB4685030F15634C6C2FEC01369EDF9@SYCPR01MB4685.ausprd01.prod.outlook.com>
 <4ab469dd-eedd-e838-65b7-e3159128e758@gmx.com>
From:   Robert Krig <robert.krig@render-wahnsinn.de>
In-Reply-To: <4ab469dd-eedd-e838-65b7-e3159128e758@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I guess you guys are probably aware, but I thought I'd mention it 
anyway. With ZFS for example you can create mirrored log or cache disks, 
using either whole disks or just partitions.

Wouldn't a mirrored journal device remove the single point of failure? 
If you had the optional capability to create a raid1 journal on two 
disks (let's assume SSDs or NVMEs).



On 01.06.22 14:21, Qu Wenruo wrote:
>
>
> On 2022/6/1 17:56, Paul Jones wrote:
>>
>>> -----Original Message-----
>>> From: Qu Wenruo <quwenruo.btrfs@gmx.com>
>>> Sent: Wednesday, 1 June 2022 7:27 PM
>>> To: Wang Yugui <wangyugui@e16-tech.com>
>>> Cc: linux-btrfs@vger.kernel.org
>>> Subject: Re: [PATCH DRAFT] btrfs: RAID56J journal on-disk format draft
>>>
>>>
>>
>>>>>> If we save journal on every RAID56 HDD, it will always be very slow,
>>>>>> because journal data is in a different place than normal data, so
>>>>>> HDD seek is always happen?
>>>>>>
>>>>>> If we save journal on a device just like 'mke2fs -O journal_dev' or
>>>>>> 'mkfs.xfs -l logdev', then this device just works like NVDIMM?  We
>>>>>> may not need
>>>>>> RAID56/RAID1 for journal data.
>>>>>
>>>>> That device is the single point of failure. You lost that device,
>>>>> write hole come again.
>>>>
>>>> The HW RAID card have 'single point of failure'  too, such as the
>>>> NVDIMM inside HW RAID card.
>>>>
>>>> but  power-lost frequency > hdd failure frequency  > NVDIMM/ssd
>>>> failure frequency
>>>
>>> It's a completely different level.
>>>
>>> For btrfs RAID, we have no special treat for any disk.
>>> And our RAID is focusing on ensuring device tolerance.
>>>
>>> In your RAID card case, indeed the failure rate of the card is much 
>>> lower.
>>> In journal device case, how do you ensure it's still true that the 
>>> journal device
>>> missing possibility is way lower than all the other devices?
>>>
>>> So this doesn't make sense, unless you introduce the journal to 
>>> something
>>> definitely not a regular disk.
>>>
>>> I don't believe this benefit most users.
>>> Just consider how many regular people use dedicated journal device for
>>> XFS/EXT4 upon md/dm RAID56.
>>
>> A good solid state drive should be far less error prone than spinning 
>> drives, so would be a good candidate. Not perfect, but better.
>
> After more consideration, it looks like it's indeed better.
>
> Although we break the guarantee on bad devices, if the journal device is
> missing, we just fall back to the old RAID56 behavior.
>
> It's not the best situation, but we still have all the content we have.
> The problem is for future write, we may degrade the recovery ability
> bytes by bytes.
>
> Thanks,
> Qu
>>
>> As an end user I think focusing on stability and recovery tools is a 
>> better use of time than fixing the write hole, as I wouldn't even 
>> consider using Raid56 in it's current state. The write hole problem 
>> can be alleviated by a UPS and not using Raid56 for a busy write 
>> load. It's still good to brainstorm the issue though, as it will need 
>> solving eventually.
>>
>> Paul.
