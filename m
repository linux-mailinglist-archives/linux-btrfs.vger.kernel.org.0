Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BB753A4CD
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 14:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbiFAMW5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 08:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352975AbiFAMVh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 08:21:37 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BBA5D5FD
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 05:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654086084;
        bh=3Ql918B+yUKBq3SvPuK8up0pEfU8HasxEAkCI6N0GgY=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Nd5fjj/NY5M1ayMUAKSFOsm2DErA2b1ykuPMkkUNzydheSdYoHlTersEge3O6s7JG
         vw5/wWpZ0x6XMEQHpAnTan8PHr8Ig2BJZkwAf2moqH6NRj5q0wYA3xlqiTlHuCOR/Z
         afMIIySrSUB4ajW8jDrBDRoaOw1Gi0xXzUZ7RIog=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MGQnF-1o1c1m2pIb-00Gozl; Wed, 01
 Jun 2022 14:21:24 +0200
Message-ID: <4ab469dd-eedd-e838-65b7-e3159128e758@gmx.com>
Date:   Wed, 1 Jun 2022 20:21:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH DRAFT] btrfs: RAID56J journal on-disk format draft
Content-Language: en-US
To:     Paul Jones <paul@pauljones.id.au>,
        Wang Yugui <wangyugui@e16-tech.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20220601102532.D262.409509F4@e16-tech.com>
 <49fb1216-189d-8801-d134-596284f62f1f@gmx.com>
 <20220601170741.4B12.409509F4@e16-tech.com>
 <5f49c12e-4655-48dd-0d73-49dc351eae15@gmx.com>
 <SYCPR01MB4685030F15634C6C2FEC01369EDF9@SYCPR01MB4685.ausprd01.prod.outlook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <SYCPR01MB4685030F15634C6C2FEC01369EDF9@SYCPR01MB4685.ausprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YTRTfgqPzUvxxT9UQnXl7B4VwkVET/ONweCP9QdUTIoVSxuuUMk
 WTL+iHe7AF0i+7/vqaMGjoMAKRq/YznnvO/okTw5Q+iI2eTgzC0h7vLJdOa0NPRN+TePnB+
 tPOFDeaqWtKmxuDEJzqKCpyJEC//bxDt/ycp5pUPiaSCv3cdipL70fLR+Hx1C51/bl8QItK
 9NkkfZGi1HdHNuy/uH0Zg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RSM7fPIPka0=:xnBLccsG8WtrgSC47rKMPC
 OQldr2f3VkkKmBoeMlb9v15wlwNW0lhrPy18LpHqa9vtzKUhvnAadmfxBOfdd/Yi3Hfe3fxrt
 rhVKxEqViCm9V4x/kNahfEzwMUPBZRv6/xXV/NL+4YbXd4PHyD2rqAs438ciH/xvgB+cXYLxD
 +2xSmEUftzrfort27JRnmaisQ6x6iPu+S87FZ8AzTVnD4/TZC1i5RsnKZr1W1DVrvI+A8vGdP
 llfkXYBluq1Xrj//VRm5YU82tBG0Iv+Y60OKkHMNk3Ze47WfwqzmTMGktOj1VHouxQ1N7FMcy
 4e6ysElB+yfuzzU0vhlFCiXVPYO6qqv9hjWyegsOJ6ZeNqGN0eEToDtuvlLwnKCn6p3jfXjFL
 Ogmi5VnTMoy38PCYc9mZyX8iu3VyeDZhlAkvyRH0LDn/tFz0t9g14X9/hUvuBQgs1SszHFnWk
 F0k0nOvEcP40JentSj7gayCqx+jOyY0SEpGi7tJ6IElIeF/lMCBw33c8Z5WYlceJCLZPjJ0RX
 PF0yz9SykG2BkiOkowBifeFJS6sGvPg0r/x9c/OZCxHqwdSb4mvckO747onsL/S//tQASqJC5
 vPk4vj7F7iARhtowlZFLzfliSBhw/hEX/aucN9DGOGT1/NUTllsbah2WhOLOom9rbc051E61v
 qcNyjZtOx2it8Wwv9F+R+3KCZDlocRfHJevqLrWkE8g13xN5z8Wb8DqhzEqWk3LRG9jwX+wVP
 AxuKIWJg87tPk50qUQXpQBwjqAl2alcRtZz27fmF6JZVZq5HUTuJ/0wlvDk5sHSwt3SQo1sHK
 eYimXYflIgLHDFRJBOW9AegBu0S4nZ50PIO5nyix9QIfh0ZMcC0H5cBbi4Yo9DloAqSwWJKab
 6WjrqHBR42GD3J43F4I/O3LMGCbTZd0DXjzkcruDa+r725FBi+DW69ZtmpGbNKVQ6sx1FLb++
 3A/BY3E+J2qJSwZItVT4SADEs1RSAaNTC0p2CotrJLImrfZrm2z/p0NjfLfpmxyIAnMXM4mZQ
 FDT24gLUdOS9hAGMqTSM//5MhO5aRBvguCV3OSHYRMi41IdbQKr0jk1iW1Yfw2Wn6VibEmYK4
 EfVmPQz4kaXB5bqfTOVRaTNvW68Cbs244L6y8hBpD5wzde9D2JmQUozaA==
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/1 17:56, Paul Jones wrote:
>
>> -----Original Message-----
>> From: Qu Wenruo <quwenruo.btrfs@gmx.com>
>> Sent: Wednesday, 1 June 2022 7:27 PM
>> To: Wang Yugui <wangyugui@e16-tech.com>
>> Cc: linux-btrfs@vger.kernel.org
>> Subject: Re: [PATCH DRAFT] btrfs: RAID56J journal on-disk format draft
>>
>>
>
>>>>> If we save journal on every RAID56 HDD, it will always be very slow,
>>>>> because journal data is in a different place than normal data, so
>>>>> HDD seek is always happen?
>>>>>
>>>>> If we save journal on a device just like 'mke2fs -O journal_dev' or
>>>>> 'mkfs.xfs -l logdev', then this device just works like NVDIMM?  We
>>>>> may not need
>>>>> RAID56/RAID1 for journal data.
>>>>
>>>> That device is the single point of failure. You lost that device,
>>>> write hole come again.
>>>
>>> The HW RAID card have 'single point of failure'  too, such as the
>>> NVDIMM inside HW RAID card.
>>>
>>> but  power-lost frequency > hdd failure frequency  > NVDIMM/ssd
>>> failure frequency
>>
>> It's a completely different level.
>>
>> For btrfs RAID, we have no special treat for any disk.
>> And our RAID is focusing on ensuring device tolerance.
>>
>> In your RAID card case, indeed the failure rate of the card is much low=
er.
>> In journal device case, how do you ensure it's still true that the jour=
nal device
>> missing possibility is way lower than all the other devices?
>>
>> So this doesn't make sense, unless you introduce the journal to somethi=
ng
>> definitely not a regular disk.
>>
>> I don't believe this benefit most users.
>> Just consider how many regular people use dedicated journal device for
>> XFS/EXT4 upon md/dm RAID56.
>
> A good solid state drive should be far less error prone than spinning dr=
ives, so would be a good candidate. Not perfect, but better.

After more consideration, it looks like it's indeed better.

Although we break the guarantee on bad devices, if the journal device is
missing, we just fall back to the old RAID56 behavior.

It's not the best situation, but we still have all the content we have.
The problem is for future write, we may degrade the recovery ability
bytes by bytes.

Thanks,
Qu
>
> As an end user I think focusing on stability and recovery tools is a bet=
ter use of time than fixing the write hole, as I wouldn't even consider us=
ing Raid56 in it's current state. The write hole problem can be alleviated=
 by a UPS and not using Raid56 for a busy write load. It's still good to b=
rainstorm the issue though, as it will need solving eventually.
>
> Paul.
