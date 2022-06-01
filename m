Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6B653A233
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 12:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350328AbiFAKNM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 06:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352015AbiFAKMq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 06:12:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C26433AB
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 03:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654078350;
        bh=rp3Y1lPv2tYis+atuVdTgQ3X9N1fBIvlTkp2vTUR1Kg=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=lik8zAxKHb62xPoqUi5smI/ALz9f08pM29/In/u4WFs2rQt3P7pJJB2bJEIl7N5ce
         FeU1fnU9a+K7VByj4WNa1VqAuGJxys05gMltxJEd62UiLPluKvtlvBzYVYsLZYRbzN
         Ao9kL1X/2WqrkzoAsc160DGgSCJ/68kPZngAKS1Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mzyya-1nYsyR1R5y-00x2Fc; Wed, 01
 Jun 2022 12:12:30 +0200
Message-ID: <6cbc718d-4afb-87e7-6f01-a1d06a74ab9e@gmx.com>
Date:   Wed, 1 Jun 2022 18:12:25 +0800
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
X-Provags-ID: V03:K1:WgpA32BzsOjYBJRcEbPSczsODxruE+v9+Sko6KPlpziQsiw37qv
 U2MCWDOK50ycj8cDi/DjTplmnyEGIRe+zW3ck0f+/6Gb1MnF3jlo3crBtsLKfvqAVwGCKrL
 sDbp0fL2q0HveXRryVkdKKSN0abU0ujoTAY93V1zRtrAUerSAUC1Eur0BfOZPUMbWBixFqj
 oCZhFbfSlc08gQpwB5oeQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5HAgf0JRGjY=:5MXdECKL7YKZTC0dZk1Xok
 xXZEkNCoCTdcqMakWN8LhWhSYaCPJdVzs8V8sEQ95hNC8uDzGjhvdjDSw9/khKkj4MSLwWSPP
 vpKWVegFN/AhJExrAfJBjV4GjIx8TSInScBdB3TfM1h9sVgqU21+tyTGiAO0co7aV9FhkKiMw
 IFgpkotb06K10rx0eY2bAa2htf6wWvySnjJFuxj/P5JKq+1X4NAQSKv6RS/4h0h6WMEsGaWb6
 XN8/F/reh6a9+qvSXX0IHfds7fRHtD4AfHe9ZzGFhvh60blPalxcS+dD3pkz7SCeOFDN4bwbr
 O3dZWrGeKUoaYb6ox5lgH5JGQsl1ni9M+K/+UdrZ7mxzC1eAo8bt9flS2gLXZAhjsrFPZgZmj
 J7afHkQfKaIjfGCPbIfczqL0/jXGHTuMVJCEJOxDz1IxF9+f0fgHfNr4tB9IsuNmymWJugnPn
 YCJifjVXiM8QvDaFf354gvhZfhTZj/47aZknjkQYj1ZftZTTvaYg9q2Zngtp/IOdVeblsOHsd
 ioLmhmW7YMfhFPhT4g7juf7/vmaSxumGDdHcAmm4j8w+SnOev4xP9TNsezXg0IsUk/3Yz1dco
 Y/fqDjaBnHsduzzzvdo3DegMpIQ6AMaWcOUHsquY/SWlY2OG3bDe4+MzCQEmh9+QODR6SH8gP
 C06AWGV5ssw/Sux46e419gO2A4J625obHjXnV2l+mYHa6nJ2kI7fpv7CXYWVOIk+s6vvXYdox
 tUr3zDxKC3l+YJZF7T06fuw8a+M4HV9keeurjMlq0mZxNR/0xno0ZFpU3KbuY0CBOHD8sMA/z
 bcmiDUDbcQ81RON11qhFtQ+Xx2kbr/sFfcNbZaXTVgfZDRpZMD15YshMEIsIlhb9XzZ5WeJJZ
 tu5Ha1cpTKPluyn2tfP++IOwdgLLVMg4HFJ8C16BGEZP6t174MV4uykAlTJdxnHlkeeM3QAIL
 8MZClAEO2e30/51vhoap0+6WzyUfp+Clcnn62gvQlHII0wQoKskXtqMmuVAmVXytAluA3sis1
 4Vj4rb2d0eLzeqcrOCE6MOEC6yocvtMdhNpY6jzaX9bnPOf3qjIvz+K8Ch/wDnDWd4D1rtOPW
 RZtIuAWrvnTkzKxbPf1iwDdzUUIiI1bi5KdckHabuMWSR0zFsmZQJrZ0g==
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
>
> As an end user I think focusing on stability and recovery tools is a bet=
ter use of time than fixing the write hole, as I wouldn't even consider us=
ing Raid56 in it's current state. The write hole problem can be alleviated=
 by a UPS and not using Raid56 for a busy write load. It's still good to b=
rainstorm the issue though, as it will need solving eventually.

In fact, since write hole is only a problem for power loss (and explicit
degraded write), another solution is, only record if the fs is
gracefully closed.

If the fs is not gracefully closed (by a bit in superblock), then we
just trigger a full scrub on all existing RAID56 block groups.

This should solve the problem, with the extra cost of slow scrub for
each unclean shutdown.

To be extra safe, during that scrub run, we really want user to wait for
the scrub to finish.

But on the other hand, I totally understand user won't be happy to wait
for 10+ hours just due to a unclean shutdown...

Thanks,
Qu

>
> Paul.
