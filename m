Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDFEE38FE29
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 May 2021 11:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbhEYJv0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 May 2021 05:51:26 -0400
Received: from mout.gmx.net ([212.227.15.15]:57199 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232545AbhEYJvZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 May 2021 05:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621936189;
        bh=HVUaxz5W5A+LZRpq8epDKgat6kSIlJBddYv9TA+cMMQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=NVXDKbE85wjvK9FkUc7O2wkofUB3Adoki8/rdNIE0UUpJPb8IW+2+M1IxcFqyFCXo
         5PuB6p6esHl8fCEWkEXmjcc2EkOUbLUyp4clTxPGordhx5aEdhtL1s5eLbUKKpaPUz
         t67GK0IQt8A7uuXAx7sxb6yZ6BJkucLhbO7Ngx/s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MDysg-1lbcK03eyK-00A1iS; Tue, 25
 May 2021 11:49:49 +0200
Subject: Re: [Patch v2 41/42] btrfs: fix the use-after-free bug in writeback
 subpage helper
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210513213656.2poyhssr4wzq65s4@riteshh-domain>
 <5f1d41d2-c7bc-ceb7-be4c-714d6731a296@gmx.com>
 <20210514150831.trfaihcy2ryp35uh@riteshh-domain>
 <20210514175343.v32k2rmsfl5l2qfa@riteshh-domain>
 <80735b91-ad23-1b49-20bb-fd3a09957793@gmx.com>
 <20210515095906.ifmqf36t2jup7tzw@riteshh-domain>
 <51186fd5-af02-2be6-3ba3-426082852665@suse.com>
 <20210525044307.xqfukx6qwu6mf53n@riteshh-domain>
 <ba250f72-ce16-92c0-d4b6-938776434ea2@gmx.com>
 <1a2171a5-f356-9a2e-d238-0725d3994f45@gmx.com>
 <20210525092305.3pautkpiv3dhi3oj@riteshh-domain>
 <5a3d0e6c-425b-9b6a-ffec-9243693430c5@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <181af010-af18-9f78-4028-d8bb59237c05@gmx.com>
Date:   Tue, 25 May 2021 17:49:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <5a3d0e6c-425b-9b6a-ffec-9243693430c5@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gAxeWRC4v5G8Din6rJpEQHIrQnpMAI2uiOSn1HTQKx6BOFwYe9x
 I+n+ikUu9/NhngJTODterSBkaqYhLumctryLYuVNCdERHK3FXEtZPn68LZX0xY1yIIOgCDH
 jFB+ofSWTA8HRcbxKmSbwQzNbCnZmWTt/eeOodtJXreW1lVhQHp/yfgyKZX8OE2Hzl7kXLQ
 RB4CDE8RQnazIpTVCXMMg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:S/Ac9XiJejQ=:LgNxyeywl9j1QAhVBHk3gp
 UhFUrRkv9gxQCyzz6uv0izlswL3lZWpOYgIvqwfFUSv3V74OFkqvDh9NNQdZWXrIzJ2nS/hGP
 hquitvNIDtXo1hjUeiRnu9zUrPqDCF8/18hmcFiGOx9dfpqkKtWt8Uj0DOyv8uto90TPkyP+R
 07dzxvexqikSyJD/cRWKB5CzfgmjubpVX3SbIj1/rVmquHWahGeYycgDIfVhzBLZ79dVILJvw
 edafuyVfu5it90yE7vdflfwOcjAWH+Nw8H5XcC7s98KHqbkQr4pPRKQo66HQSGO9/XMQbfyLP
 ly1gxOH4pMmz8edsCviOUh8gpv+XzFy/VX2mjhzb/E2CCXtzm1hxA47R0Z1GeFk+dQ80YQseu
 +IYj071FSmVYnSQ/YcMD0hHshlb3zncSXeJ6pHuZtIq5/GPwR1UyiWEWp/p7QGfUFQmS4q3tW
 yjC87lGPDccr4AfwoElCSECDurwcvJ9p6yD0olCvHPFUnJXQ0a29zG98tKj2zqnvOiEHSPf7d
 IvuHVepig4KkDCQ/DHt2KWEM06KTfKgkKa2ixk5khCfNu8MkWE6OstEW+dnpem/22wS348ZyO
 0PX7cGt6i94XP++tyeCQTqha8eUTDVoMdyxT1ge8RZRoKC75FNI8QmsMKprRW03TEX3dSB+7p
 iPo/I98dXLFkvI4cVLfgDhb0tOl3iezqKW4t5AtHrMIGrJJULMtP1ncCQjYTGS7G08bowofCA
 nY+8PWBw/LoNPGzFTah+BpsievbjWj7nUjkXmyeztQbXr4DvAmG+2x0zVe+kY2Dkcnh4jbOfy
 uyALbpWHN0gYJtQGrb1lo0S0jhLhmfCZQDLns4VNeRTq/apTA9FuhcmpbAMwuqfpaQrxlHtsZ
 6iEtdUlLEfOR1oeCKvbbnxMzWbmRtlABUooR7DyYYRv37V+rGMOoWONwITREpXPSXgjITPMX+
 AErUH+3A/J3GN94iKan+aRpRHwWevODr4QE1disAojEf9A03I7KZW76b05pqMWduaqm+RhjEp
 CpXZRsVhsuQu9Q7OKI5fA7SVoImNgnTNGf4Yc1Ps5aGsdpeg249yi5n1etxukCkicODLs1JlJ
 O0h3F5wyOfT+aDISeNi23VXmqLg8Qp/jZSmTtFXVUxr0CXy50hPUxFoap0d3DSEFzG58KAVNX
 wOU5rBayskyjqJ2C5MEHwTVd1ufbmchuNjzuCLFhPHLKmM2DaFDZh5ZbAoX/b58FkUQhgY408
 HpwPyKNo1nP5YO6p4
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/25 =E4=B8=8B=E5=8D=885:45, Qu Wenruo wrote:
[...]
>>>
>>> What a relief, it's not a big problem in my patchset, but more likely =
to
>>> be in the test case, especially in the how the mirror number is chosen=
.
>>>
>>> When the test failed, you can find in the dmesg that, there is not any
>>> error mssage related to csum mismatch at all.
>>>
>>> This means, we're reading the correct copy, no wonder we won't submit
>>> read repair.
>>> This is mostly caused by the page size difference I guess, which makes
>>> the pid balance read for RAID1 less perdicatable.
>>>
>>> I don't yet have any good idea to fix the test case yet, so I'm afraid
>>> we have to consider it as a false alert.
>>
>> Ohk gr8, Thanks a lot for looking into it.
>> I saw the change log of v3, though I don't think there are any changes
>> from when
>> I last tested the whole patch series, still I will give it a full run
>> with v3
>> for both 4k and 64k config, (since now mostly all issues should be
>> fixed).
>
> Just to be more clear, there are some known bugs in the base of my
> subpage branch:
>
> - 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource flags for 64-
>  =C2=A0 bit memory addresses")
>  =C2=A0 Will screw up at least my ARM board, which is using device tree =
for
>  =C2=A0 its PCIE node.
>  =C2=A0 Have to revert it.
>
> - 764c7c9a464b ("btrfs: zoned: fix parallel compressed writes")
>  =C2=A0 Will screw up compressed write with striped RAID profile.
>  =C2=A0 Fix sent to the mail list:
>
> https://patchwork.kernel.org/project/linux-btrfs/patch/20210525055243.85=
166-1-wqu@suse.com/
>
>
> - Known btrfs mkfs bug
>  =C2=A0 Fix sent to the mail list:
>
> https://patchwork.kernel.org/project/linux-btrfs/patch/20210517095516.12=
9287-1-wqu@suse.com/
>
>
> - btrfs/215 false alert
>  =C2=A0 Fix sent to the mail list:
>
> https://patchwork.kernel.org/project/linux-btrfs/patch/20210517092922.11=
9788-1-wqu@suse.com/

Please wait for while.

I just checked my latest result, the branch doesn't pass my local test
for subpage case.

I'll fix it first, sorry for the problem.

Thanks,
Qu


>
>
> Thanks,
> Qu
>>
>> Thanks
>> -ritesh
>>
>>
>>>
>>> Thanks,
>>> Qu
>>>>
>>>> Thanks again for the awesome report!
>>>> Qu
>>>>>
>>>>>
>>>>> -ritesh
>>>>>
>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> 2. btrfs/124 failure.
>>>>>>>
>>>>>>> I guess below could be due to small size of the device?
>>>>>>>
>>>>>>> xfstests.global-btrfs/4k.btrfs/124
>>>>>>> Error Details
>>>>>>> - output mismatch (see /results/btrfs/results-4k/btrfs/124.out.bad=
)
>>>>>>
>>>>>> Again passes locally.
>>>>>>
>>>>>> But accroding to your fs, I notice several unbalanced disk usage:
>>>>>>
>>>>>> # /usr/local/bin/btrfs filesystem show
>>>>>> Label: none=C2=A0 uuid: fbb48eb6-25c7-4800-8656-503c1e502d85
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Total devices 2 FS bytes used 32.00Ki=
B
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0devid=C2=A0=C2=A0=C2=A0 1 size 5.00Gi=
B used 622.38MiB path /dev/vdc
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0devid=C2=A0=C2=A0=C2=A0 2 size 2.00Gi=
B used 622.38MiB path /dev/vdi
>>>>>>
>>>>>> Label: none=C2=A0 uuid: d3c4fb09-eea2-4dea-8187-b13e97f4ad5c
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Total devices 4 FS bytes used 379.12M=
iB
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0devid=C2=A0=C2=A0=C2=A0 1 size 5.00Gi=
B used 8.00MiB path /dev/vdb
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0devid=C2=A0=C2=A0=C2=A0 3 size 20.00G=
iB used 264.00MiB path /dev/vde
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0devid=C2=A0=C2=A0=C2=A0 4 size 20.00G=
iB used 1.26GiB path /dev/vdf
>>>>>>
>>>>>> We had reports about btrfs doing poor work when handling
>>>>>> unbalanced disk
>>>>>> sizes.
>>>>>> I had a purpose to fix it, with a little better calcuation, but sti=
ll
>>>>>> not
>>>>>> yet perfect.
>>>>>>
>>>>>> Thus would you mind to check if the test pass when all the disks in
>>>>>> SCRATCH_DEV_POOL are in the same size?
>>>>>>
>>>>>> Of course we need to fix the problem of ENOSPC for unbalanced
>>>>>> disks, but
>>>>>> that's a common problem and not exacly related to subpage.
>>>>>> I should take some time to refresh the unbalanced disk usage patche=
s
>>>>>> soon.
>>>>>>
>>>>>> Thanksm
>>>>>> Qu
>>>>>>
>>>>>> [...]
>>>>>>>
>>>>>>> -ritesh
>>>>>>>
>>>>>
>>>>>
