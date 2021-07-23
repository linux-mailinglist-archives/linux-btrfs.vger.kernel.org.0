Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDFF3D42FF
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jul 2021 00:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbhGWVzF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Jul 2021 17:55:05 -0400
Received: from mout.gmx.net ([212.227.15.15]:33807 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231742AbhGWVzF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Jul 2021 17:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627079735;
        bh=uVXKEqgQJ6ddldP4cDOIF9WNiZzMXKjth3cjImD4cUw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=PDRuCQn3Depzp+QB85pK4zzqh/3hiAOh0XCiY1EKUyQTf44ZhBmAybSh1gejUaWWL
         QzR26lOjciKT8xMBlzH/Gzcdq5vkGiW0OuDxpqUGGeI8SjodpLF49yhg9mHqK/Zf78
         NOmQjKhl6viD6RjVu5Tp2fv1M28I2n3xvXzjOgg4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MEFzr-1lz7Gl2t5Z-00ADWZ; Sat, 24
 Jul 2021 00:35:35 +0200
Subject: Re: [PATCH] btrfs: allow degenerate raid0/raid10
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20210722192955.18709-1-dsterba@suse.com>
 <db9e2f31-73a5-0d0d-a1da-7acde6fb118e@gmx.com>
 <20210723140843.GE19710@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <808c7591-6bd7-882d-63d7-a1c25f3e1833@gmx.com>
Date:   Sat, 24 Jul 2021 06:35:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210723140843.GE19710@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0l15Kus5CVTag+rzjYGFQlSlBWI57pNmQwQb8xKz2nujHAoXvsp
 o1oecDQh0ITQNB0yNsqA0cCWeynSOUPcFD/VStwgwqgs2rX7Dv1YFoJh8fC4mSY0t9Bby0u
 6X39D/wyvtcKuqj5MVIIgUNqbHdMnDTzDiT4FugEpzWu2NY6QGBVW4hpqBz8gq3VpGqM+V+
 DdAeHjqgH0oxyXUVeHiEA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:B/z0F+pquus=:57+LoMKp7i++AVdegZQPWd
 jlk2+CRxCYNJRDJsiwo8/8vwRbvwFIWNV5d2N/1nMjtH89MFBUAHuaPuKklJbdOabCGHMpOIv
 zgKUEHdQppFnXUt9qb0SMfT1kQ65DfCFUt9gcasKanW7ONGmTLdBt314vlOPjesFafekNlHPV
 MsBdW0vbzVXNiww6zz7aUqeVUw692NKQHLuvVHMfJWIMIsMV7+yrQqjKps2NRVWCMABLN3tQs
 NNmX75wByvG/apExD77Hs8wQKWP+0FqJafaXZHNHDvODAmhyoAaFcXFhfZeJJSvpa98EbqYIW
 QpXYY9eti4tR+965Tvc8Dg47mtx1MnGPKEwALI3lJq1VEG2h2iltKwZWMQtU8z8a7LFFmIt+M
 gHAiZSNLVE/sTkzMjoBNWkSGY9SnAgPlKWIv9vZYM6IJOUC2jOCCHaq87Df+QV4X/AcR5BdCJ
 PnTzrP2oGOVCcY3WqcUSwaqi273FmWFcNbHdzlr4dEbTL53qj3FXgAZhE+CfIcBreHUFxsB5V
 pRy3nhkOLBi87vqekUkycXSnERP688EU2Td3hszcBlBPUqU0QMhTlJYn1EsEcntcFyqUe9NlF
 YHFRCKI47vv1eo4mDg77aJjSRjb9QajqzXwGDjbNVWng89bV6WEsmECIpbf8YB4HJskytrnYJ
 AczRntA09qAZXflvRL1dGOoS8vQHZlWrQTSd9Bb4W1/oUFChUEJtcPp4NOlL7qd38GW+9WytP
 sEQLEzwIGW6wG/gIX9cTASNqo/NQXWJwFHJgrbcYusFNPbLIsDNKAgBPg08KTdxUdGEMbfqEs
 jfT8RnnBJCU3kYLQp8foq8aqeZjWXq3oNSoNO4/Wc2cVHHZJVDqhMs6/q2XOrEGIPcWxJPqhr
 SFJJuSsflKSCkAE2i54lRyI6U7i3uRy8dKO46vXJETyp2UTyf8SnooMp1evcKwHNAAbhGrfbF
 na6KzNOuxxvzSJyq9TxcAfwqkjHnzqaZbzA7wFMsgBccdfeh+RW0QoQlNDE9FRoNaeCc2s2nB
 o7Vb0OnuK/N7dFHy+hmg68PZ8eZEDY252LTMi8x2i20saq7CL0PzQ+qc4j75xLwp8dmvM2geK
 NZrNkoFLCLQQDMt4+fz1b3XNZ5Vka3vz//vWkx2tfrSa4PJvtuHDPeGxg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/23 =E4=B8=8B=E5=8D=8810:08, David Sterba wrote:
> On Fri, Jul 23, 2021 at 06:51:31AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2021/7/23 =E4=B8=8A=E5=8D=883:29, David Sterba wrote:
>>> The data on raid0 and raid10 are supposed to be spread over multiple
>>> devices, so the minimum constraints are set to 2 and 4 respectively.
>>> This is an artificial limit and there's some interest to remove it.
>>
>> This could be a better way to solve the SINGLE chunk created by degrade=
d
>> mount.
>
> Yes, but in this case it's rather a conicidence because raid0 now
> becomes a valid fallback profile, other cases are not affected. There's
> also some interest to allow full write with missing devices (as long as
> complete data can be written, not necessarily to all copies). MD-RAID
> allows that.
>
> As an example, when we'd allow that, 2 device raid1 with one missing
> will continue to write to the present device and once the missing device
> reappears, scrub will fill the missing bits, or device replace will do a
> full sync.
>
>>> Change this to allow raid0 on one device and raid10 on two devices. Th=
is
>>> works as expected eg. when converting or removing devices.
>>>
>>> The only difference is when raid0 on two devices gets one device
>>> removed. Unpatched would silently create a single profile, while newly
>>> it would be raid0.
>>>
>>> The motivation is to allow to preserve the profile type as long as it
>>> possible for some intermediate state (device removal, conversion).
>>>
>>> Unpatched kernel will mount and use the degenerate profiles just fine
>>> but won't allow any operation that would not satisfy the stricter devi=
ce
>>> number constraints, eg. not allowing to go from 3 to 2 devices for
>>> raid10 or various profile conversions.
>>
>> My initial thought is, tree-checker will report errors like crazy, but
>> no, the check for RAID1 only cares substripe, while for RAID0 no number
>> of devices check.
>>
>> So a good surprise here.
>>
>> Another thing is about the single device RAID0 or 2 devices RAID10 is
>> the stripe splitting.
>>
>> Single device RAID0 is just SINGLE, while 2 devices RAID10 is just RAID=
1.
>> Thus they need no stripe splitting at all.
>>
>> But we will still do the stripe calculation, thus it could slightly
>> reduce the performance.
>> Not a big deal though.
>
> Yeah effectively they're raid0 =3D=3D single, raid10 =3D=3D raid1, I hav=
en't
> checked the overhead of the additional striping logic nor measured
> performance impact but I don't feel it would be noticeable.
>
>>> Example output:
>>>
>>>     # btrfs fi us -T .
>>>     Overall:
>>>         Device size:                  10.00GiB
>>>         Device allocated:              1.01GiB
>>>         Device unallocated:            8.99GiB
>>>         Device missing:                  0.00B
>>>         Used:                        200.61MiB
>>>         Free (estimated):              9.79GiB      (min: 9.79GiB)
>>>         Free (statfs, df):             9.79GiB
>>>         Data ratio:                       1.00
>>>         Metadata ratio:                   1.00
>>>         Global reserve:                3.25MiB      (used: 0.00B)
>>>         Multiple profiles:                  no
>>>
>>> 		Data      Metadata  System
>>>     Id Path       RAID0     single    single   Unallocated
>>>     -- ---------- --------- --------- -------- -----------
>>>      1 /dev/sda10   1.00GiB   8.00MiB  1.00MiB     8.99GiB
>>>     -- ---------- --------- --------- -------- -----------
>>>        Total        1.00GiB   8.00MiB  1.00MiB     8.99GiB
>>>        Used       200.25MiB 352.00KiB 16.00KiB
>>>
>>>     # btrfs dev us .
>>>     /dev/sda10, ID: 1
>>>        Device size:            10.00GiB
>>>        Device slack:              0.00B
>>>        Data,RAID0/1:            1.00GiB
>>
>> Can we slightly enhance the output?
>> RAID0/1 really looks like a new profile now, even the "1" really means
>> the number of device.
>
> Do you have a concrete suggestion? This format was inspired by a
> discussion and suggested by users so I guess this is what people expect
> and I find it clear. It's also documented in manual page so if you think
> it's not clear or missing some important information, please let me
> know.

My idea may not be pretty though:

         Data,RAID0 (1 dev):            1.00GiB

As if we follow the existing pattern, it can be more confusing like:

         Data,RAID5/6

Thanks,
Qu
