Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CC053AF5E
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 00:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbiFAVhi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 17:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbiFAVha (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 17:37:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED611447A1
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 14:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654119436;
        bh=pH8eoy05gytwlMtZEvz3Hi+5veazqI8R1SJBQc5vm/A=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=geZekmKfSXf4GsUGqvD5/MDKZNoDiEoJ+LsNuzYSQ1bBsmM2kGm9JGwmbX2TnJACN
         qTSA03UhozkTrAw/vCEbnq7JhbyPVQWBl7+CkkdTJdr/5AzmfyJASasvc69Q4aFe/y
         1KaRvQVQz06LlITos/R3Lz3R+FT9k5S4JG7MA3b4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MAfYm-1o7XaV3plI-00B0KN; Wed, 01
 Jun 2022 23:37:16 +0200
Message-ID: <f56d4b11-1788-e4b5-35fa-d17b46a46d00@gmx.com>
Date:   Thu, 2 Jun 2022 05:37:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH DRAFT] btrfs: RAID56J journal on-disk format draft
Content-Language: en-US
To:     Martin Raiber <martin@urbackup.org>,
        Paul Jones <paul@pauljones.id.au>,
        Wang Yugui <wangyugui@e16-tech.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20220601102532.D262.409509F4@e16-tech.com>
 <49fb1216-189d-8801-d134-596284f62f1f@gmx.com>
 <20220601170741.4B12.409509F4@e16-tech.com>
 <5f49c12e-4655-48dd-0d73-49dc351eae15@gmx.com>
 <SYCPR01MB4685030F15634C6C2FEC01369EDF9@SYCPR01MB4685.ausprd01.prod.outlook.com>
 <6cbc718d-4afb-87e7-6f01-a1d06a74ab9e@gmx.com>
 <01020181209a0f8e-b97fa255-3146-4ced-b9c9-a6627a21d6e1-000000@eu-west-1.amazonses.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <01020181209a0f8e-b97fa255-3146-4ced-b9c9-a6627a21d6e1-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FC05cKy8vc36mm9M2W6IcJCkWVjOBUh53N2vkpjSMyuq6jFX1af
 NkkUm/9NNBuNtebUmKEAKgvIylNC+5GKx7ctABqTjllMg3oQ+HV1GY9PzAuClR99R1w7wOK
 4yMYA2OaeVDb7SmcsVYKxWbtsyG8nkVTZZpdTpmDijnLolAjoG3VTwUkYavqIubVCtjP1E6
 XdX8TeVNmXWPYCrPM+s1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:881nSW9bQqM=:oOEeYQzyZGDe08oQW/BL7y
 MAQHBhHuQSOcQMrnfZ0DbKnS6W2QPRZV0y+JRr6iOd/KoNvrkXBEvbep0cdVnjlM1NkBGjoRE
 fp03g/Mq2MrL+CONGD5LSpys0MngIY1Zq0Xc4IetdmTD0VcNdzVMraHQ7PIGgVVfjcdQAr7An
 EirUI3PkS6PhQTJSDTVPKuKwCEeH300JiGwxjoRf0cjE/R38AwAedy4GrRfv3b5JH0EuX4TOn
 SICheaA5b5m9zkHqDPFK6UFwjCJQnr06ewOHNkOAYWk1g3HiHUutP5WqJyz0P98I2VDjFqRb8
 WpQ5E5QrvwOlxKqTNEHeK5rrudqukYeCKIInJi+sLiSmc76k3XLKpLFoxKFuuoF1RSh4a6Rxl
 g9v80H2fPzyQK79xhcEzKCbr7ThvrBV2gTmAuJM7nNI0ToMrClE3wJRBvdNZLpactfY9RaUQu
 zj282umD3ZdomRSOReh1vMgrGfAF0hxYhd3iasQRESWYJ7owF7HwP2j73RXYl4jq5eRiqCEtd
 oZ9pgHsLJXBFEzBq02rJQ0Kxm68WVkRw/7gEdO0mKDVlLsilWl6O7LTlg0OOYe8MiDlCt2teZ
 JWildkyEnFLzovJ4RXYjdZe4+uDGqdz+a62lEAzHCyFvdk4rTHD+NA8vvPArgrTq2BswR48/L
 u1g/+XLa0gVwWOzFRM0KsdQ6AQGkqo17JdIdYeAbXwYAET3nlvANhyxfJiHbbAZK3PeFN7FEQ
 l0I3Hy/KWUVnzqZ86+og6u/qrdcKRXJyulOqsu82iTnSGFKJuxhR7nAfQTpNw1RvEnA5RHaJF
 TX3Zef50wCfXy7cy6ye3Ur1L6qi+bAYtXBtXK8mGsLMYwBh0x//bmUA1uYT2MRAXpwrUFfzUH
 qQD363y5JIYSCyAztjom3CnGixiK2RJB/j3CR/k3g2+VwWa3a14evwcJOV+h03epa1Y7oKT6i
 WI+NqNOUKv0eW/xzWSqiYi8RnYWxkXQc7BtRgFZidPu2KqjSRh03B47a/3EvKcszUl/5Secr8
 iylt5lcQSoZK4uhwpQ8TMDX7xpAGwDG3g/nouMw8AzyJ74tKqZqtB6+pqM4B3zkHVX2dZQ1Zu
 8aV8768rumsk+/dMeXDv5EfKIhefi3bxCs0MHxx3zXPoQeWHmPGCh+88A==
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/2 02:49, Martin Raiber wrote:
> On 01.06.2022 12:12 Qu Wenruo wrote:
>>
>>
>> On 2022/6/1 17:56, Paul Jones wrote:
>>>
>>>> -----Original Message-----
>>>> From: Qu Wenruo <quwenruo.btrfs@gmx.com>
>>>> Sent: Wednesday, 1 June 2022 7:27 PM
>>>> To: Wang Yugui <wangyugui@e16-tech.com>
>>>> Cc: linux-btrfs@vger.kernel.org
>>>> Subject: Re: [PATCH DRAFT] btrfs: RAID56J journal on-disk format draf=
t
>>>>
>>>>
>>>
>>>>>>> If we save journal on every RAID56 HDD, it will always be very slo=
w,
>>>>>>> because journal data is in a different place than normal data, so
>>>>>>> HDD seek is always happen?
>>>>>>>
>>>>>>> If we save journal on a device just like 'mke2fs -O journal_dev' o=
r
>>>>>>> 'mkfs.xfs -l logdev', then this device just works like NVDIMM?=C2=
=A0 We
>>>>>>> may not need
>>>>>>> RAID56/RAID1 for journal data.
>>>>>>
>>>>>> That device is the single point of failure. You lost that device,
>>>>>> write hole come again.
>>>>>
>>>>> The HW RAID card have 'single point of failure'=C2=A0 too, such as t=
he
>>>>> NVDIMM inside HW RAID card.
>>>>>
>>>>> but=C2=A0 power-lost frequency > hdd failure frequency=C2=A0 > NVDIM=
M/ssd
>>>>> failure frequency
>>>>
>>>> It's a completely different level.
>>>>
>>>> For btrfs RAID, we have no special treat for any disk.
>>>> And our RAID is focusing on ensuring device tolerance.
>>>>
>>>> In your RAID card case, indeed the failure rate of the card is much l=
ower.
>>>> In journal device case, how do you ensure it's still true that the jo=
urnal device
>>>> missing possibility is way lower than all the other devices?
>>>>
>>>> So this doesn't make sense, unless you introduce the journal to somet=
hing
>>>> definitely not a regular disk.
>>>>
>>>> I don't believe this benefit most users.
>>>> Just consider how many regular people use dedicated journal device fo=
r
>>>> XFS/EXT4 upon md/dm RAID56.
>>>
>>> A good solid state drive should be far less error prone than spinning =
drives, so would be a good candidate. Not perfect, but better.
>>>
>>> As an end user I think focusing on stability and recovery tools is a b=
etter use of time than fixing the write hole, as I wouldn't even consider =
using Raid56 in it's current state. The write hole problem can be alleviat=
ed by a UPS and not using Raid56 for a busy write load. It's still good to=
 brainstorm the issue though, as it will need solving eventually.
>>
>> In fact, since write hole is only a problem for power loss (and explici=
t
>> degraded write), another solution is, only record if the fs is
>> gracefully closed.
>>
>> If the fs is not gracefully closed (by a bit in superblock), then we
>> just trigger a full scrub on all existing RAID56 block groups.
>>
>> This should solve the problem, with the extra cost of slow scrub for
>> each unclean shutdown.
>>
>> To be extra safe, during that scrub run, we really want user to wait fo=
r
>> the scrub to finish.
>>
>> But on the other hand, I totally understand user won't be happy to wait
>> for 10+ hours just due to a unclean shutdown...
> Would it be possible to put the stripe offsets/numbers into a journal/co=
mmit them before write? Then, during mount you could scrub only those afte=
r an unclean shutdown.

If we go that path, we can already do full journal, and only replay that
journal without the need for scrub at all.

Thanks,
Qu

>>
>> Thanks,
>> Qu
>>
>>>
>>> Paul.
>
>
