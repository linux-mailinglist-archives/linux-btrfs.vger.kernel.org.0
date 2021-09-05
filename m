Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEE44011E7
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Sep 2021 00:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238326AbhIEWEt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Sep 2021 18:04:49 -0400
Received: from mout.gmx.net ([212.227.17.20]:59811 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234277AbhIEWEt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 5 Sep 2021 18:04:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630879423;
        bh=8F0Ffhs0trhETQIfgtl8AiGo0HNsm9S2H9BE1fCbnwU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=QoI1Ob78dBSLamX2QDRmDfRBkDAZIhHH0Ye6V8sEnncZivxmu3MI0qtv74UCJIdj4
         OSmI2wx78Ems9l+SRGm3RzhpuVokhYFbBPUHJEewZ04lQOJK9eWdseICmAngC/VYKF
         epukxw/saNNe6XTnfL9mnRHrVQxowft98CD3NBlg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MRmfi-1mYZlM1xpi-00TCLn; Mon, 06
 Sep 2021 00:03:43 +0200
Subject: Re: Next steps in recovery?
To:     Robert Wyrick <rob@wyrick.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <CAA_aC9-ZAdGC15HY-Q0S-N2M1OukST5BjAk9=WsD+NArCkCFUA@mail.gmail.com>
 <3139b2df-438c-ba40-2565-1f760e6d1edb@gmx.com>
 <9c2afb5f-e854-d743-3849-727f527e877b@gmx.com>
 <CAA_aC99-C8xOf7EAvJAMk2ZkYSaN2vyK7YFMw06utQ0T+tsh9A@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <6e03129e-f8c8-a00b-2afe-97a82d06c11e@gmx.com>
Date:   Mon, 6 Sep 2021 06:03:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAA_aC99-C8xOf7EAvJAMk2ZkYSaN2vyK7YFMw06utQ0T+tsh9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IYwLwPoHEiICAlOIMjAGcFr8iEmRWCax9MMADfAFX0bv1Isi2nl
 UGJxmrUiuNLXB5IEshf7OuTG+JyEn3d8s+0mI3bNXZsmTuQKyUM3GE1LoW93dl0kM7W00B4
 9/OOVSAeV/vBlOiqHmKOovR+exjrtSmzHOGwiggk73z3nX/f/OOGy2ftzo83XfvWQH6VXp+
 ZIAaCwi4P+LUaybRG9bPA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:aW0EFbOHbXQ=:OGWpmD66gSSTAgCbWBp3O1
 ZEQM82JNS2wX8q0aMl4/O5xAFvHSbHTc8Ik6RUMjMVHfdM9kZ2eV/y+cDWxZe5Q4RYsUoVyfw
 OUQaUJLaSdiI2jNWUiQ7mWO9K0L+0/FFYgmAtihylCzPMATVmSkVZN5aPZtuP1CcGkRTVQDYx
 yRaHhov3P/SSPid2k3/9lgusobGqJQsRG5YVuSGkK8kh/gH6Dnrw1spqw8p2LVk+eAYrhVGpS
 T1sO43SDjJmmJ+Tn+p2k51PxpmH3SV88DgDL7WA1fmY6GSynQu+WwFY2WNatJYj6IuK1eSw7w
 03W3J/7DJDwBsbFSInGcLnLNZa7lg4btE1mhvs4xq/yDsWN2/5Ou88sNgmWecqaPE9Uq3Oluq
 xadb4ZS0uThyeqvZYcdPwPcHVie9qQEFSxsnNlz3QjXZwfAH6e+g4QIlWk73f1+Fh6gmKNJAk
 pktBro+ykl9+lxz3plC9t1E01qLDUbBF9YHIg/rcQyrFz64TG/qCiNBQUZyVQ8vsey7Ax39Pa
 F0a3S7zkTqh64KGZDt3YxfbHf+eB0OaykQbJ8gDnm3LieN3zdn8krMT7u7AjiF2IPgDqgS5vh
 qfv222w6QTkc6PdRIDQCHqa8oTgA3QXlIiVViMhfsRoYo1JqPDv9IKFJdYAheFytRUfbF9zpH
 J8IWRoKkCkxkKBziBd1dOWbEnoGlqEENs/qLdI+bLkS74jVoXL0SPQ0dBaKjc3k+VSrrrmHwj
 nO2lb2vmIStiVfQe6XOgeB6OI7dSbJBBytBUhlVDiJi8dlRvWShnWiP1i7+XfwUrzpi5JhYfx
 UQd7l17smZxL07vXw+J1bqz+7RdeL+I4OCDueRFVE695EIKaPWdMtqj28Ngz3XiXeJXDC8Hny
 2hSFq4cqF76IBmUf+q7DWio53J4ZfN6B2ZpzED6/vOr7wbH0wbWFtD2S42kzmO2CC68e5Jz7H
 Cn28lk5ihqXNqpRIbEooxCR/oTR1WeCa4OTfjOtoa+A/q0kgLIQoO/rJs/8owa8LwwDRNQ+qN
 ieCcmRlg1X/iRYtx+IayjScxyRebnN8RR+DHnMQejGhYgQqoYYX0f35DRA1S0g7spAWw6I9s3
 u6ajyLJD7QC04rh0j2G6CtiaTfQ1Rhgrij9a7HFYWRPEQIXvvSeY1zhgY4wjLdbxqC7UYomGv
 QSZlI=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/6 =E4=B8=8A=E5=8D=8812:00, Robert Wyrick wrote:
> Running memtest86+ now....  20 hours in.  No errors yet.
> Thanks for the analysis.  I'll let this run for another day or so.

Just to mention, since 5.11 btrfs kernel module has the ability to
detect most high bitflip before writing tree blocks to disks.

Thus even with less reliable RAM, it's still more reliable than nothing.

But still, with the existing errors, the RAM test is still an essential
one before doing anything.

Thanks,
Qu
>
>
> On Fri, Sep 3, 2021 at 12:53 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>>
>>
>>
>> On 2021/9/3 =E4=B8=8B=E5=8D=882:48, Qu Wenruo wrote:
>>>
>>>
>>> On 2021/9/3 =E4=B8=8A=E5=8D=8810:43, Robert Wyrick wrote:
>>>> I cannot mount my btrfs filesystem.
>>>> $ uname -a
>>>> Linux bigbox 5.11.0-27-generic #29~20.04.1-Ubuntu SMP Wed Aug 11
>>>> 15:58:17 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
>>>> $ btrfs version
>>>> btrfs-progs v5.4.1
>>>
>>> The tool is a little too old, thus if you're going to repair, you'd
>>> better to update the progs.
>>>>
>>>> I'm seeing the following from check:
>>>> $ btrfs check -p /dev/sda
>>>> Opening filesystem to check...
>>>> Checking filesystem on /dev/sda
>>>> UUID: 75f1f45c-552e-4ae2-a56f-46e44b6647cf
>>>> [1/7] checking root items                      (0:00:59 elapsed,
>>>> 2649102 items checked)
>>>> ERROR: invalid generation for extent 38179182174208, have
>>>> 140737491486755 expect (0, 4057084]
>>>
>>> This is a repairable problem.
>>>
>>> We have test case for exactly the same case in tests/fsck-test/044 for=
 it.
>>
>> Oh, this invalid extent generation is already a more direct indication
>> of memory bitflip.
>>
>> 140737491486755 =3D 0x8000002fc823
>>
>> Without the high 0x8 bit, the remaining part is completely valid
>> generation, 0x2fc823, which is inside the expectation.
>>
>> So, a memtest is a must before doing any repair.
>> You won't want another bitflip to ruin your perfectly repairable fs.
>>
>> Thanks,
>> Qu
>>>
>>>
>>>> [2/7] checking extents                         (0:02:17 elapsed,
>>>> 1116143 items checked)
>>>> ERROR: errors found in extent allocation tree or chunk allocation
>>>> cache and super generation don't match, space cache will be invalidat=
ed
>>>> [3/7] checking free space cache                (0:00:00 elapsed)
>>>> [4/7] chunresolved ref dir 8348950 index 3 namelen 7 name posters
>>>> filetype 2 errors 2, no dir index
>>>
>>> No dir index can also be repaired.
>>>
>>> The dir index will be added back.
>>>
>>>> unresolved ref dir 8348950 index 3 namelen 7 name poSters filetype 2
>>>> errors 5, no dir item, no inode ref
>>>
>>> No dir item nor inode ref can also be repaired, but with dir item and
>>> inode ref removed.
>>>
>>> But the problem here looks very strange.
>>>
>>> It's the same dir and the same index, but different name.
>>> posters vs poSters.
>>>
>>> 'S' is 0x53 and 's' is 0x73, I'm wondering if your system had a bad
>>> memory which caused a bitflip and the problem.
>>>
>>> Thus I prefer to do a full memtest before running btrfs check --repair=
.
>>>
>>> Thanks,
>>> Qu
>>>
>>>> [4/7] checking fs roots                        (0:00:42 elapsed,
>>>> 108894 items checked)
>>>> ERROR: errors found in fs roots
>>>> found 15729059057664 bytes used, error(s) found
>>>> total csum bytes: 15313288548
>>>> total tree bytes: 18286739456
>>>> total fs tree bytes: 1791819776
>>>> total extent tree bytes: 229130240
>>>> btree space waste bytes: 1018844959
>>>> file data blocks allocated: 51587230502912
>>>>    referenced 15627926712320
>>>>
>>>> I've tried everything I've found on the internet, but haven't
>>>> attempted to repair based on the warnings...
>>>>
>>>> What more info do you need to help me diagnose/fix this?
>>>>
>>>> Thanks!
>>>> -Rob
>>>>
