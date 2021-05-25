Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738C439002A
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 May 2021 13:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhEYLnX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 May 2021 07:43:23 -0400
Received: from mout.gmx.net ([212.227.17.22]:37789 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230350AbhEYLnX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 May 2021 07:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621942907;
        bh=RaMmNj7RMDfFi5vg8JKIyswT+iDl/T72hZTxzq+s0BQ=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=G8Mab1w9IpJX7sHUg4Ku+bDzBPyU65ZMuG/AayT7BEnKJlLbcoKh4D/fFBlPwLHFs
         BbAWZ+J58MzyC5uIqT4RyBcOq4CuGUksihk/C9QoC4xfYoeG1E1lqowBhKrlm7MvN7
         1v0DaqnffOmyWvhHQNdNdSHIyYTT9jGsN+9bgNWg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MkHQX-1l1QF00VPV-00kg3S; Tue, 25
 May 2021 13:41:47 +0200
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210514175343.v32k2rmsfl5l2qfa@riteshh-domain>
 <80735b91-ad23-1b49-20bb-fd3a09957793@gmx.com>
 <20210515095906.ifmqf36t2jup7tzw@riteshh-domain>
 <51186fd5-af02-2be6-3ba3-426082852665@suse.com>
 <20210525044307.xqfukx6qwu6mf53n@riteshh-domain>
 <ba250f72-ce16-92c0-d4b6-938776434ea2@gmx.com>
 <1a2171a5-f356-9a2e-d238-0725d3994f45@gmx.com>
 <20210525092305.3pautkpiv3dhi3oj@riteshh-domain>
 <5a3d0e6c-425b-9b6a-ffec-9243693430c5@gmx.com>
 <181af010-af18-9f78-4028-d8bb59237c05@gmx.com>
 <20210525102010.hckdsumqfil3vnsu@riteshh-domain>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [Patch v2 41/42] btrfs: fix the use-after-free bug in writeback
 subpage helper
Message-ID: <82070e33-82f7-3a54-7620-b4a43bdaff50@gmx.com>
Date:   Tue, 25 May 2021 19:41:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210525102010.hckdsumqfil3vnsu@riteshh-domain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:F61apetr1BKicUPmj1ILE+gCfUo7FMz2Yd2IC5Jpa4TbWiJUoIv
 qFbouCxwb6AqeWdwZ7DMGpR11h3g0E+nXqgMZtPLu0IF6XWkDRkS04v5/qzxdzMC66xAWfZ
 IxabkbUg+Ypt8xXQhsMo2M7qRE4303f/xtC9nI7wz/rAyauzYU21KhB6WrvReEZ/J5FgKsb
 7UWnm1uEjJQEuCdzssoUw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:oc652BBdO8k=:5i68UYXJZasGdr0XAlkiSq
 WsAd1te+EpblRc206a0ZdVoi1uv39QPCWVQf1UB6I4Ih6dD6nUw+LgjxWst9z+wQ3y2vmoKpg
 CcOSm/U3oCFbhENU1JS5RQT2Ga2IBETahqLQzUNv40XgqLDunk3DgW7E32rznmaV1keJN/mUK
 mj1Pwy5s/4m8s5K+Z9qj/fWJPViMgdWeOd7DwQPX0hujT03C62gAI6l2Cwce6B52v70Gwv2Ya
 DStjsGstlMg980rhmMClgF2swlX2aX7h8r399QrRPg987XzNiuXietSOofLD55P+KRGpVcJd5
 +nPnnJaxqSNXoFQsFGzU7VWquYqDujusaDdVz03EFGE0It7j6IXRqmyv8BItkgY7vX4mYEJlI
 r3p7vFs9dhPZl22Wg4LbWXDIyd+xcuA/cKCIcYIIr0NdEzkAraIT26Kqc/Yjp7fcwVzsNz300
 OV3UJPUaFoCbqPdN8CRCNKgD/wCbYAwL7+yiTsey9ByiHiJ7FFuGz836fVJYDKa5mta5FDnfS
 iA58wCOhCnQlvymtRWuYgj3sulYo9bf/Ck3N5r7TtFGDQfDGwupSizlPhiFoCMj3pVzXsge4A
 5ffDXURhWavO2WQT65C5VULEbjm2mMAkk4+ti3uy7r5BOh4W3VM9+imxK+c7ICvK8E3sdfHrX
 EcxKdkXjRS65JtM/R9E7eyDz5uZJvcLD/bx+z1pnpWmCUvQJyaVM3uajgNwVs5LTSYL3p3c9U
 EyqhA1DqUMhnns+CBQbwjLEJMOzRMPWCsFAvPdVuDDICNtKsWkxFk1ibsHWdyygORB9EkiHkt
 0daMagq0G0458+glztCwi1fO1g5iR7xuO0ZntdQDxQ75QYn1qU1pR6LFY+jiNdliunPR8frJI
 StO+eaazd8rNPrXgchxU5OvQ+zsPTSEDP2RXRqQ1WV9+kesy3XXPIuCoqLdHHz7vHGDhvex37
 0LDY40VPdh3h3rs2/5puHUOuj7NRF0xlsc4VQSFK+PVQlGRxgZ/IPOwI3g0BCX1DR+Z2q2Q3V
 7W9jWOzXzB5Qd02JJ3XZtceCOyq5rkBHS7efyPrCZB7DyUVQ8E5G6qUCDqdztSb6Nf7UnInFU
 hocRMmenBVGYiXqMqxHqMh6CwvOaKgPUKWIEFrw/JM0veTRwTy2Y9lNQvx2o6HbuT/7Y8Jpze
 Ecm5yFaMMDYZ7UF+TBw+BNhBanarcJ8npM6jo5A34ouEc9WOsgG9ca2jJ/vLvnQ27BmgsCLre
 1NZaD2+RfvY+fQNGd
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/25 =E4=B8=8B=E5=8D=886:20, Ritesh Harjani wrote:
[...]
>>>
>>> - 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource flags for 6=
4-
>>>   =C2=A0 bit memory addresses")
>>>   =C2=A0 Will screw up at least my ARM board, which is using device tr=
ee for
>>>   =C2=A0 its PCIE node.
>>>   =C2=A0 Have to revert it.
>>>
>>> - 764c7c9a464b ("btrfs: zoned: fix parallel compressed writes")
>>>   =C2=A0 Will screw up compressed write with striped RAID profile.
>>>   =C2=A0 Fix sent to the mail list:
>>>
>>> https://patchwork.kernel.org/project/linux-btrfs/patch/20210525055243.=
85166-1-wqu@suse.com/
>>>
>>>
>>> - Known btrfs mkfs bug
>>>   =C2=A0 Fix sent to the mail list:
>>>
>>> https://patchwork.kernel.org/project/linux-btrfs/patch/20210517095516.=
129287-1-wqu@suse.com/
>>>
>>>
>>> - btrfs/215 false alert
>>>   =C2=A0 Fix sent to the mail list:
>>>
>>> https://patchwork.kernel.org/project/linux-btrfs/patch/20210517092922.=
119788-1-wqu@suse.com/
>>
>> Please wait for while.
>>
>> I just checked my latest result, the branch doesn't pass my local test
>> for subpage case.
>>
>> I'll fix it first, sorry for the problem.
>
> Ok, yes (it's failing for me in some test case).
> Sure, will until your confirmation.

Got the reason. The patch "btrfs: allow submit_extent_page() to do bio
split for subpage" got a conflict when got rebased, due to zone code chang=
e.

The conflict wasn't big, but to be extra safe, I manually re-craft the
patch from the scratch, to find out what's wrong.

During that re-crafting, I forgot to delete two lines, prevent
btrfs_add_bio_page() from splitting bio properly, and submit empty bio,
thus causing an ASSERT() in submit_extent_page().

The bug can be reliably reproduced by btrfs/060, thus that one can be a
quick test to make sure the problem is gone.

BTW, for older subpage branch, the latest one without problem is at HEAD
2af4eb21b234c6ddbc37568529219d33038f7f7c, which I also tested on a
Power8 VM, it passes "-g auto" with only 18 known failures.

I believe it's now safe to re-test.

Really sorry for the inconvenience.

Thanks,
Qu
>
> -ritesh
>
>
>>
>> Thanks,
>> Qu
>>
>>
>>>
>>>
>>> Thanks,
>>> Qu
>>>>
>>>> Thanks
>>>> -ritesh
>>>>
>>>>
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>>
>>>>>> Thanks again for the awesome report!
>>>>>> Qu
>>>>>>>
>>>>>>>
>>>>>>> -ritesh
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> 2. btrfs/124 failure.
>>>>>>>>>
>>>>>>>>> I guess below could be due to small size of the device?
>>>>>>>>>
>>>>>>>>> xfstests.global-btrfs/4k.btrfs/124
>>>>>>>>> Error Details
>>>>>>>>> - output mismatch (see /results/btrfs/results-4k/btrfs/124.out.b=
ad)
>>>>>>>>
>>>>>>>> Again passes locally.
>>>>>>>>
>>>>>>>> But accroding to your fs, I notice several unbalanced disk usage:
>>>>>>>>
>>>>>>>> # /usr/local/bin/btrfs filesystem show
>>>>>>>> Label: none=C2=A0 uuid: fbb48eb6-25c7-4800-8656-503c1e502d85
>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Total devices 2 FS bytes used 32.0=
0KiB
>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0devid=C2=A0=C2=A0=C2=A0 1 size 5.0=
0GiB used 622.38MiB path /dev/vdc
>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0devid=C2=A0=C2=A0=C2=A0 2 size 2.0=
0GiB used 622.38MiB path /dev/vdi
>>>>>>>>
>>>>>>>> Label: none=C2=A0 uuid: d3c4fb09-eea2-4dea-8187-b13e97f4ad5c
>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Total devices 4 FS bytes used 379.=
12MiB
>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0devid=C2=A0=C2=A0=C2=A0 1 size 5.0=
0GiB used 8.00MiB path /dev/vdb
>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0devid=C2=A0=C2=A0=C2=A0 3 size 20.=
00GiB used 264.00MiB path /dev/vde
>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0devid=C2=A0=C2=A0=C2=A0 4 size 20.=
00GiB used 1.26GiB path /dev/vdf
>>>>>>>>
>>>>>>>> We had reports about btrfs doing poor work when handling
>>>>>>>> unbalanced disk
>>>>>>>> sizes.
>>>>>>>> I had a purpose to fix it, with a little better calcuation, but s=
till
>>>>>>>> not
>>>>>>>> yet perfect.
>>>>>>>>
>>>>>>>> Thus would you mind to check if the test pass when all the disks =
in
>>>>>>>> SCRATCH_DEV_POOL are in the same size?
>>>>>>>>
>>>>>>>> Of course we need to fix the problem of ENOSPC for unbalanced
>>>>>>>> disks, but
>>>>>>>> that's a common problem and not exacly related to subpage.
>>>>>>>> I should take some time to refresh the unbalanced disk usage patc=
hes
>>>>>>>> soon.
>>>>>>>>
>>>>>>>> Thanksm
>>>>>>>> Qu
>>>>>>>>
>>>>>>>> [...]
>>>>>>>>>
>>>>>>>>> -ritesh
>>>>>>>>>
>>>>>>>
>>>>>>>
