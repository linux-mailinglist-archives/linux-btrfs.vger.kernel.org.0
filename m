Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7D849F1A9
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jan 2022 04:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242222AbiA1DKn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jan 2022 22:10:43 -0500
Received: from mout.gmx.net ([212.227.15.18]:37747 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237367AbiA1DKm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jan 2022 22:10:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643339437;
        bh=NEXmnpKjvYjZH5HP8v1y9ntnKW9RLoc3MGg4D5YUeqY=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=krVfYjFPVXT0zoWBmf0fk7r3ZIwCZVVaI9saUkQkpfI3/ciw1DNk+fp0HGvRDCLaC
         6v3+AyX4bCzypJWRmeUhrI6r41D47+1+qO9Zw0X4kyh2CsX4/w2cKrPBTtru3iu32r
         I5z7S6k0BPHs/FaRAHrtq8mugOog6F0cHsUA3kUQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M26rD-1nFCWz1cEL-002Wbi; Fri, 28
 Jan 2022 04:10:37 +0100
Message-ID: <5e4ad821-146d-5696-e1d7-755986fee5e9@gmx.com>
Date:   Fri, 28 Jan 2022 11:10:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Qu Wenruo <wqu@suse.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20220127055306.30252-1-wqu@suse.com>
 <20220127153806.vufsbus447s2tdib@riteshh-domain>
 <92343b23-cf6c-e138-9cfe-79336cd1bb54@gmx.com>
 <20220128025656.z3a72e2xak66vbj7@riteshh-domain>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs: add test case to verify that btrfs won't waste
 IO/CPU to defrag compressed extents already at their max size
In-Reply-To: <20220128025656.z3a72e2xak66vbj7@riteshh-domain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aJR45UdJNPj+Rr82ArPKgDuFZovGf+d4z81HcHw6orSIKR9DBxQ
 1blWSKzm7NMLyfb5YL0suWg67cjXh/M/mvDL9XpYAbMJYqOuR9NNeJYTxt4QpbklU1AKgnu
 CgrDY/lqv5b7h7Io56Jkhaz2X9zy4HjU9S5UGEgrKPzCJQYVGOba0c6IPeIaHzuK5H/axPy
 32FLUoVov7FuiM83U5Diw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JolaqXSwCC4=:SWQpiaoqHg0tS8KCVoMkv4
 kIJ6aX++QA4gUZOGAol9A11bSvmqtGkZ5fCaTOgwre41WLoLk2ZjOJLc2MyV6al1EfTmavU73
 SQvOTBlIELN7yB5Au4zHs5y0O6MHZSDO0VnHBpVKRdNL5zJy8GML6dbBVRTl2HX61/+O/ZASx
 ccvWuz+LcK9aE1sEUKivdOcP01yWiJMPmZt0i/JHRvhCoi1JDAd036w901k4JM5Vu0V7JMYW7
 2qm5GbWQTpXfZEOzdQhiTo8l02f2OCZHTveufFntQPyHo/cPKMkddY1CrvJuBJ1+lTkbz/Mcq
 anjtimFS4GAfHyjaeZzJhADaUe3Fnffgh7/AdMSg+i+7EZl7VcU+p26MA9kwEUz4KL3vdJUWY
 Gk/SHBBX/xUoetI6NjJ8U0LRfmJ6U+OtZ/ynC0k/O+srAHF9E8nQt858zFLm4I302+Gce5H4Y
 2uxNGsh5ei9lst4Cm1BOoQIO/yN/kqY8fpuejj5sqFDKxgnkqXe/mY8VeUnZ8br2JcEps17NE
 9YAGrzX4XnJBIFuVhpdHgCRsgYXbWbENsq0mMGCjaArUGCRXQbatn1xiGgR2gF6bMv2IJ0rCX
 3ZdKgf5d0Alw2KHxqfHpEY7NeK1UyVcbUt5OJpnsj4oOC8RUVnFno+Y4U6WmiKupdXLVsOjxn
 AMNukZ5Uoko0AYtEWblOLFALCtR8zIQzYIj98x/RuJQojpH0b8PSebh43jta1NIUtNOZrsFNN
 LrfrrQCnTPcSgu0M6NAusmFQ730uoIcsUXeeExbulmEWHdyFt/879OhFWkEasMRSW+7+CuwOZ
 NVfrEUzHFKFTd7aMBscmkeEnWRn1XoWV0QQi+xY7CY2YuyF0U44fZXLe9ZuG1gcTee53f1Cyi
 0O/4eqwGxZRFsuuMbabz9GHl329qiGsNj0ueCP3EWIHgHxlOGlO6mDXtWi8YyIASTPZ24oUV0
 kDihF9CJGcQqWMrNGlViN4qTW6u2ZHnjv1gBZ2+NYXVGncV93w1nkq5gOQVJe7ltbqBVdJRr6
 89ugnFW3sLuESmuK2vFrakyVdN8+D5BeEXuw/WeA7+73xiEBHsBIcsYKhxXZfHOkfPvMuRM2s
 qTufOvuYiQQHCg=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/28 10:56, Ritesh Harjani wrote:
> On 22/01/28 06:20AM, Qu Wenruo wrote:
>>
>>
>> On 2022/1/27 23:38, Ritesh Harjani wrote:
>>> On 22/01/27 01:53PM, Qu Wenruo wrote:
>>>> There is a long existing bug in btrfs defrag code that it will always
>>>> try to defrag compressed extents, even they are already at max capaci=
ty.
>>>>
>>>> This will not reduce the number of extents, but only waste IO/CPU.
>>>>
>>>> The kernel fix is titled:
>>>>
>>>>     btrfs: defrag: don't defrag extents which is already at its max c=
apacity
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>>    tests/btrfs/257     | 79 +++++++++++++++++++++++++++++++++++++++++=
++++
>>>>    tests/btrfs/257.out |  2 ++
>>>>    2 files changed, 81 insertions(+)
>>>>    create mode 100755 tests/btrfs/257
>>>>    create mode 100644 tests/btrfs/257.out
>>>>
>>>> diff --git a/tests/btrfs/257 b/tests/btrfs/257
>>>> new file mode 100755
>>>> index 00000000..326687dc
>>>> --- /dev/null
>>>> +++ b/tests/btrfs/257
>>>> @@ -0,0 +1,79 @@
>>>> +#! /bin/bash
>>>> +# SPDX-License-Identifier: GPL-2.0
>>>> +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
>>>> +#
>>>> +# FS QA Test 257
>>>> +#
>>>> +# Make sure btrfs defrag ioctl won't defrag compressed extents which=
 are already
>>>> +# at their max capacity.
>>>
>>> Haven't really looked into this fstest. But it is a good practice to a=
dd the
>>> commit id and the title here for others to easily refer kernel commit.
>>
>> Isn't that already in the commit message?
>
> Yes, that's true. And thanks for adding that.
> I generally found mentioning commit-id and commit-title
> in the description section of the test too to be lot more helpful.

This is in fact discussed before, I used to include the fixes in the
test description, but later move them into the commit message.

In the long run, the test should and would all pass, thus there is
really no need to bother mentioning it.

For the guys who really need to bother the test failure, aka QA testers
or some developers in the future causing some regression, they will
check the full commit messages anyway.

And the fixes tag has its own problems, like at the time of fstests
merging, the fixes may not yet being merged into mainline, or the title
may change.

Thus mentioning something volatile in the test description can be a
little confusing, and hiding it into the commit message may be preferred.

Thanks,
Qu

>
> For e.g. tests/btrfs/232
>
> # FS QA Test 232
> #
> # Test that performing io and exhausting qgroup limit won't deadlock. Th=
is
> # exercises issues fixed by the following kernel commits:
> #
> # 4f6a49de64fd ("btrfs: unlock extents in btrfs_zero_range in case of qu=
ota
> # reservation errors")
> # 4d14c5cde5c2 ("btrfs: don't flush from btrfs_delayed_inode_reserve_met=
adata")
>
> Though I don't think it is mandatory, but as I said, it is generally hel=
pful
> for anyone to refer to commit directly / title directly from here if it =
has
> a commit-id (might be it's just me :))
>
> Thanks!
> -ritesh
>
