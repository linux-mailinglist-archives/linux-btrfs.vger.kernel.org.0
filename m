Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA26B484ACF
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jan 2022 23:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbiADWhR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Jan 2022 17:37:17 -0500
Received: from mout.gmx.net ([212.227.15.19]:42191 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235613AbiADWhR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Jan 2022 17:37:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641335833;
        bh=S3A3xQHO7Y4iXnVcTkO2SKJoOvxeVmwedlzzB7N6Gng=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=RonSA1p8lJ8BXzrW32nnO3bHgtvk+QAygmVhEtWObDTXtN7xylMGKYnymQKrefSgA
         S9yiqEKYYxce6Nb45QUvW79hXX30iOUPT39BJurYX7ssd0pmkwvBduOm9sZntPByX6
         7QPn8nrRseYPDNP7NKZ77ilxhvmycuw/AkSNoPZY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mn2W5-1me6Gd3Q5X-00k5CF; Tue, 04
 Jan 2022 23:37:13 +0100
Message-ID: <09ee7152-a650-32a8-a036-e322a1afe177@gmx.com>
Date:   Wed, 5 Jan 2022 06:37:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To:     Eric Levy <contact@ericlevy.name>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <2c80ca8507181b1e65a67bbd4dca459d24a47da2.camel@ericlevy.name>
 <b0d434dd-e76d-fdfa-baa2-bb7e00d28b01@gmx.com>
 <487b4d965a6942d6c2d1fad91e4e5a4aa29e2871.camel@ericlevy.name>
 <e3fd9851-ccf4-6f04-b376-56c6f7383de7@gmx.com>
 <faa7edb08a5cf68e8668546facbb8c60ae5a22e7.camel@ericlevy.name>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: "hardware-assisted zeroing"
In-Reply-To: <faa7edb08a5cf68e8668546facbb8c60ae5a22e7.camel@ericlevy.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xxQ00FhJeDJU/QBCPlMp4lCzfBlN4JEMDr1IoRfYH97vMGXUc/E
 35Er2/fes11ti3zmQqXJ8VgvyRmmdevi5nfoTApv9FgDS5d/3fvS8M7yknP3M1q90zZbh15
 bn2cQnIPBSZXgGDGkOJ5+9o6FHFyQ/FWwqU4ViNQkud6LrgQI5GafJ6JBg/dk5g+uO1x+qY
 Z4PF3dTB8IykEOQlZBC1g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:T/qZrkg4a/I=:oPgYz2SFfb3HbC/6MqBLgr
 k4nHuyjcsBL0338kHnf0L+vh3krn+QLiMgjaxwrmNCTFEzR0p22Q6tq7rTJnB6i9IzPFa8fQy
 NwSXYoLHOfY4OubMIcJGAjuBWaMwEYyu1s4t4b4FU/oXcqYBUDivvU5NU0QrKFzsxb3cV2WQd
 oguOHCLh8TnHD4t3BstWlRP1HQgmvonyE4JSWVCemE2kpSPElDFZ8K6ZMOCRrienWp56q4qy6
 6SBi807tw/9rJWqL552vjvOWLq1Mcvf5TdpVLKe7Ue8e2FXTMjAhjErL1LnNiNrG7ZtQLRCx7
 PApEJPj3KwlsV1X/y75kGuTVmv6yd7ZfYgBUp2chdAUDZAxEvC19Wvpuy233vRfyYQfPpgFl+
 2AEUmjwNzewHxmwLwXvW0jV7m7b0Gv7t8tMl5kbZxNVDbaXAzxYkMaAsKLuHCpqYyJc8xfGBY
 E8tUw6C6MnR4yyNdNB7a8owqfiW+ug+xtVGR55FMHXsTQYreqonHjhYyWeoM97jbVVTi3q6+R
 CIGe4GvQBYdiq+qUj60csB9wOYloqygBPUwdBAAln7+K4AFjw7B20q/dJOpW03wj/oWgQLZUI
 ynV2R+4VMSoqwqnuYLmS+e7wCb6dBMn/FWOpYV+FV0vsSV6MQtQxoHrmVHtcPTXWNnOiKWiMJ
 dBPqxNxSvBnLsuo0p6vB+YMg/xvAsmHcZodLvfBtz3tZ8GCoYfF5+SYwGRdXqAClIKL9nEEBV
 FrN6tXHIkjxn6CuLK1UsMx/O4uSiFBpr7iN22U7KWsqxd5e6DU9B3xsNxVFeYi6zidwyz2WRo
 bzei23Jhnzspmms1k4/s1y1hvi/dh3leaO90Y1ZLVU2rhvOYReqWQqVKEebBD37eb/7N+lwGq
 zkccjrQVYmf3CyvZ2pAg24gAfXC+li3Sz9Iq6wdUyOqrVT3uA7WNcChbbaBeBr+ya4sgQ+HMr
 wdEqllqyWBMeKrTw225EuP95KN+u1rDmU6Sy2qOGi/NBON8IcJeI6w5xNeq0XlhI84A8K1fOy
 8dp0SuxPu5Bg7yYd/tsvB7YE4li6BhV7kDo2Q7U4PLl72QlMx7TFo3lfgmizREBBc7CQ3sjGY
 A/J6IedqAoRiIM=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/4 18:50, Eric Levy wrote:
> On Mon, 2022-01-03 at 19:51 +0800, Qu Wenruo wrote:
>
>> The filesystem (normally) doesn't maintain such info, what a
>> filesystem
>> really care is the unused/used space.
>>
>> For fstrim case, the filesystem will issue such discard comand to
>> most
>> (if not all) unused space.
>>
>> And one can call fstrim multiple times to do the same work again and
>> again, the filesystem won't really care.
>> (even the operation can be very time consuming)
>>
>> The special thing in btrfs is, there is a cache to record which
>> blocks
>> have been trimmed. (only in memory, thus after unmount, such cache is
>> lost, and on next mount will need to be rebuilt)
>>
>> This is to reduce the trim workload with recent async-discard
>> optimization.
>
> So in the general case (i.e. no session cache), the trim operation
> scans all the allocation structures, to process all non-allocated
> space?

Yes, and that's almost for all filesystems supporting trim.

All filesystems supporing read-write need to maintain such info anyway.
IIRC for filesystems like ext4, there is a bitmap storing which sector
is used and which is not.

Btrfs has a more complex one (extent tree), not only recording which
range is used, but also which tree is using it.

>
>>> Why is the
>>> command not sent instantly, as soon as the space is freed by the
>>> file
>>> system?
>>
>> If you use discard mount option, then most filesystems will send the
>> discard command to the underlying device when some space is freed.
>>
>> But please keep in mind that, how such discard command gets handled
>> is
>> hardware/storage stack dependent.
>>
>> Some disk firmware may choose to do discard synchronously, which can
>> hugely slow down other operations.
>> (That's why btrfs has async-discard optimization, and also why fstrim
>> is
>> preferred, to avoid unexpected slow down).
>
> Yes, but of course as I have used "instantly", I meant, not necessarily
> synchronously, but simply near in time.
>
> The trim operation is not avoiding bottlenecks, even if it is non-
> blocking, because it operates at the level of the entire file system,
> in a single operation. If Btrfs is able to process discard operations
> asynchronously, then mounting with the discard option seems preferable,
> as it requires no redundant work, adds no serious delay until until the
> calls are made, and depends on no activity (not even automatic
> activity) from the admin.

IIRC this async discard is currently only specific to btrfs, thus it's
not really generic.

Another thing is, just as Zygo said, there is not much benefit from
discarding some frequently used/freed metadata.

But the overhead is always there for discard mount option, thus that's
why we don't recommend discard mount option, even we have async-discard
behavior.

Thanks,
Qu

>
> I fail to see a reason for preferring trim over discard.
>
