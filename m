Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2663C062E
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2019 15:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfI0NSi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Sep 2019 09:18:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:51688 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727207AbfI0NSh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Sep 2019 09:18:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E1442AEB8;
        Fri, 27 Sep 2019 13:18:34 +0000 (UTC)
Subject: Re: [PATCH 2/2] btrfs: Add test for btrfs balance convert
 functionality
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <20190927105233.14926-1-nborisov@suse.com>
 <20190927105233.14926-2-nborisov@suse.com>
 <471ec614-1f19-445e-bb4f-cfceca68f93f@gmx.com>
 <178f1a6a-6c91-de5b-d1eb-a05050c1d5bf@suse.com>
 <da92f869-47ab-4135-dd62-1f16fd6f27af@gmx.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5534607d-15e2-8c54-b12a-5bbb525d34ac@suse.com>
Date:   Fri, 27 Sep 2019 16:18:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <da92f869-47ab-4135-dd62-1f16fd6f27af@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 27.09.19 г. 15:22 ч., Qu Wenruo wrote:
> 
> 
> On 2019/9/27 下午7:50, Nikolay Borisov wrote:
>>
>>
>> On 27.09.19 г. 14:21 ч., Qu Wenruo wrote:
>>>
>>>
>>> On 2019/9/27 下午6:52, Nikolay Borisov wrote:
>>>> This does an exhaustive testing of all possible conversion combination.
>>>>
>>>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>>>> ---
>>>>
>>>> This is a rather long test - it takes around 38 minutes, OTOH it exercies around
>>>> 1780 combinations of source/destination test.
>>>
>>> Exactly the problem I'm concerning.
>>>
>>> However we all know that btrfs convert works by relocating old data to
>>> new chunks.
>>> It means the source doesn't matter that much.
>>>
>>> As long as the chunk read code works fine, converting from single to
>>> RAID10 is not that different from converting from DUP to RAID10.
>>> (ALthough there is still some difference due to different nr_disks and
>>> dev extent layouts, but that's not the core problem)
>>>
>>> By that we can change from testing all the combinations to just testing
>>> all destination profiles.
>>>
>>> This should only needs about 6 tests, and you can reuse all the same
>>> setup to fulfill all tests.
>>
>> True, but thanks to the exhaustive tests I was able to catch xfstest
>> special casing -mdup as source argument which resulted in patch 1 of
>> this series. I will leave that here to gather some more feedback and
>> will trim down the tests.
>>
>> And regarding the number of tests - do we want to mix the source
>> profiles of data/metadata.
> 
> To me, unless we have some strong evident in how different data/metadata
> profiles can cause different behavior, then using the same profile
> should be OK.
> 
>> Because it's true that it takes 6 test to
>> convert from
>>
>> SINGLE=>DUP, RAID1, RAID5, RAID0, RAID10, RAID6
>> but we also need a 7th test e.g. DUP->SINGLE.
> 
> Ah, I forgot RAID6. Then it's indeed 7 tests.
> 
> BTW, with 7 tests, we can afford more extensive tests, like 15~30s
> fsstress at the background, and after balance run a full scrub, then
> umount and fsck.

Makes sense I will work in that direction.

> 
> Thanks,
> Qu
> 
>>
>>>
>>> Just 4 devices, then you can go convert to SINGLE, DUP, RAID1, RAID5,
>>> RAID6, RAID10.
>>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>>
>>>>  tests/btrfs/194     | 1843 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>  tests/btrfs/194.out |    2 +
>>>>  tests/btrfs/group   |    1 +
>>>>  3 files changed, 1846 insertions(+)
>>>>  create mode 100755 tests/btrfs/194
>>>>  create mode 100644 tests/btrfs/194.out
>>>>
>>>> diff --git a/tests/btrfs/194 b/tests/btrfs/194
>>>> new file mode 100755
>>>> index 000000000000..7ba4555c12b0
>>>> --- /dev/null
>>>> +++ b/tests/btrfs/194
>>>> @@ -0,0 +1,1843 @@
>>>> +#! /bin/bash
>>>> +# SPDX-License-Identifier: GPL-2.0
>>>> +# Copyright (c) 2019 SUSE Linux Products GmbH. All Rights Reserved.
>>>> +#
>>>> +# FS QA Test 194
>>>> +#
>>>> +# Exercises all available combinations of btrfs balance start -d/-m convert
>>>> +#
> [...]
>>>> +
>>>> +for i in "${TEST_VECTORS[@]}"; do
>>>> +	run_testcase $i
>>>> +done
>>>> +
>>>> +echo "Silence is golden"
>>>> +status=0
>>>> +exit
>>>> diff --git a/tests/btrfs/194.out b/tests/btrfs/194.out
>>>> new file mode 100644
>>>> index 000000000000..7bfd50ffb5a4
>>>> --- /dev/null
>>>> +++ b/tests/btrfs/194.out
>>>> @@ -0,0 +1,2 @@
>>>> +QA output created by 194
>>>> +Silence is golden
>>>> diff --git a/tests/btrfs/group b/tests/btrfs/group
>>>> index b92cb12ca66f..a2c0ad87d0f6 100644
>>>> --- a/tests/btrfs/group
>>>> +++ b/tests/btrfs/group
>>>> @@ -196,3 +196,4 @@
>>>>  191 auto quick send dedupe
>>>>  192 auto replay snapshot stress
>>>>  193 auto quick qgroup enospc limit
>>>> +194 auto volume balance
>>>>
>>>
> 
