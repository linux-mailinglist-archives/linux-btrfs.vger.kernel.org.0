Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21DF61EB53
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Nov 2022 08:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiKGHFP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Nov 2022 02:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiKGHFP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Nov 2022 02:05:15 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37525B85B;
        Sun,  6 Nov 2022 23:05:13 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MK3Vu-1oZqJT2IGs-00LV8h; Mon, 07
 Nov 2022 08:05:06 +0100
Message-ID: <60694b4e-4d27-8579-bc2d-65c4150ece86@gmx.com>
Date:   Mon, 7 Nov 2022 15:05:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US
To:     Zorro Lang <zlang@redhat.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20221106235348.9732-1-wqu@suse.com>
 <20221107025843.osxx3alzzkkoxnl6@zlang-mailbox>
 <6dc410ea-c79f-809c-303c-f79cb7625ce3@gmx.com>
 <20221107061329.w5rf6qcf4cqy6eps@zlang-mailbox>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] fstests: btrfs: add a regression test case to make sure
 scrub can detect errors
In-Reply-To: <20221107061329.w5rf6qcf4cqy6eps@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:tiamUqrN4djPY9em7oAtKLmL27J8QL4TPsiL9j9UuD6ZKxuXYdT
 mFOlnyqHQhrndGTIS/X07NwvbPyfsWT9OID5iGzSUSK8zZRtlqJ/7q1jR6TzLLaTqy1hSGu
 sNJsulSLrXSZx67uaxxY6OjSqjqfWlXDSh7IHyvVq+vd8qLJg4bAueiUwKEGNAGaxqP3r4M
 SnK09zOWqbu2HbTz/oymw==
UI-OutboundReport: notjunk:1;M01:P0:IVq8+o7FNV8=;R+JaWhABwGwYuQjVyOIM43KxkSF
 lvzAydD+1M+KP5mYkfF6MF4M7drlE6EjM94/vwn4T33+pRASqcoCAsNCy8WAHO2SZUBNO3Omn
 d+QUQ28bb8LUhspE3DbG4+PGOmM50tmXSEbQYqwXlhX2x1+i5XS9nFSUwPYw3IM9fRqib/2jb
 ACU8DED7FI3mQHVAXtMN2Aphg+vLwMp7jtlWaBvV91DklFaa3v0YtV+8amq78TXshK+DU6U/J
 88Glp1KC960LoJCHWTA5vrApGT0MGicy0UFhHaXHbJCGRC/CsfXMEK+QlQjoydQ8DPJ+51c/m
 YOGITE9K8S96ABC0iHMYHf5bvhXTGmxE93aCjJqDESJNnNcU5EwUYhk87uDx7GLIM4dZiPazl
 nyXz1gaBV9TEM6mcXGwKeyeK4n4+IFQgFjvAljqFmqtJMNHGkTxcV0KdwPbkd/sk0qn33mljZ
 tLvr5V/z0MfpHJhozoVP0FXQZJVfhqlPigtNOY2QNjLG+I71TtHMn4KK3X8a5hMAMvUKEl3ng
 3P+0O901Ma8qVHRca8UtaE+OfEClaFzovbLz9kI6m1QJcWSRi7EbSfZVi2lgJMhZiJ5bVkAyw
 CwCNLbRLDvD5PFffJVj9aZYDEmM5SRsTYN5klYCku+Ln7qGjBJJqkoDDesdMRnb6AcTy7Avld
 4rkN7uvvAPLFHIPsETAL5s8uFVwh/Kf8VHsH5GYoioVdGULRWbTcnfyXtvRTmuGHtbmvJPMwv
 61UB9fkbrugNQxxmpYQ0QvRcA2RIh8a2mCgK648KAJ06j1Qb169NJ0e9gAGXKdfnFEkBma4Xw
 tb+5hEbVpPreZV5dWpc1X3ogcStMSNgfRkcLpqy5UTYVUTCdXyJDRV1NzDfJ9fu6/Sd36+edd
 xs+7M+y/c6M+YgtPM+NykiwzWmB+A0WXHDsByjkwbqGGzPHez1GxIRmwQHfo6NBRqPIZlOtc0
 Gz8WsDTl5L+k77z0SmSIw56BS/E=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/7 14:13, Zorro Lang wrote:
> On Mon, Nov 07, 2022 at 12:41:34PM +0800, Qu Wenruo wrote:
>>
>>
[...]
>>>
>>> btrfs/278 has been taken, please rebase on the latest for-next branch, or
>>> use a big enough number.
>>
>> I'm not sure if some one else has already complained about this, the idea of
>> a for-next branch of a test suite is stupid (nor the weekly tags).
>>
>> Fstests is a test suite, it is only for fs developers, I doubt why we need
>> tags/for-next at all.
> 
> 1)
> I think fstests isn't only for developers, there're many people, they even
> never contributed to fstests or linux, but they still need fstests to do
> sanity/regression test daily/weekly for some downstream things.
> 
> 2)
> I don't doubt the tags are useless for most users, but as I know some people
> enjoy it. And the tags don't bring in troubles to others don't use it, so why
> can't I give it tags?

Tags are providing a stable anchor for downsteam QAers to rely on 
certain tags.
Which is a bad behavior and should be discouraged.

The best way to discourage this thing is, just no tags, no branches, 
forcing them to go the latest master.

Even for downstream QA, they should use the latest master.
They should have their own systems to detect new tests, and if new tests 
fails, they really need to understand why, and better to submit a patch 
to fix fstests.

> 
> 3)
> Although fstests is a test tool, but it still might bring in big/small
> regression issues. Someone might submit lots of testing jobs after push some
> changes, and happy to sleep or enjoy their weekend (wait the test done).
> But when they come back, they find all test jobs are broken due to fstests
> regression, they get nothing valid testing results. How despondent are they?

This is a bad behavior already, passing tests means nothing.
Only failed tests are good ones, even if it's a false alert.

Such failures drives us to improve the project.

Especially this already means they may miss some high priority regressions.

> 
> Some testing jobs are just automatical testing, they don't want to deal with
> fstests issues manually. So the master branch trys to keep stable. The patches
> will be in for-next branch at first, then merge onto master branch if no one
> complains these patches.

That's a bad argument, convenience should not have a higher priority 
than possible regressions/bugs.

And if QA guys want a stable basis for their downstream tests, they 
should contribute to fstests, not relying on old tags to give them a 
false joy of passing tests.

At least from my limited understanding, more commits to upstream 
projects would always be a plus for QA people.

> 
> The for-next is for fstests developers, and other developers who always want
> to use lastest update, and don't mind (even enjoy) dealing with fstests issues
> (if there's) manually. The master branch is for the ones who just hope to get
> a stabler (relative) for their automatical testing frame.

It's fine to not update fstests hourly, but relying on an old 
branch/tags for months just to make the existing ones to pass, no, this 
is definitely not the way to go.

> 
>>
>> Remember, before the whole for-next/tags things, developers just checkout
>> the master branch and go ./new, no need to bother the tags/branches at all.
> 
> Now you can treat for-next branch as master branch you used before. As your
> using habits, you can always base on for-next branch, master branch isn't for
> developers as you now.

Another point is, if you don't plan to backport tests for older tags, 
just don't keep those tags, it makes no help.
Without tags, for-next doesn't make much sense either.

If some users don't want cutting edges, they always have the choice to 
not update their local fstests that frequently (but hopefully not for 
too long time).

But still, just one master branch is a very strong gesture to discourage 
incorrect QA behavior.

> 
>>
>>>
>>>>    2 files changed, 68 insertions(+)
>>>>    create mode 100755 tests/btrfs/278
>>>>    create mode 100644 tests/btrfs/278.out
>>>>
>>>> diff --git a/tests/btrfs/278 b/tests/btrfs/278
>>>> new file mode 100755
>>>> index 00000000..ebbf207a
>>>> --- /dev/null
>>>> +++ b/tests/btrfs/278
>>>> @@ -0,0 +1,66 @@
>>>> +#! /bin/bash
>>>> +# SPDX-License-Identifier: GPL-2.0
>>>> +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
>>>> +#
>>>> +# FS QA Test 278
>>>> +#
>>>> +# A regression test for offending commit 786672e9e1a3 ("btrfs: scrub: use
>>>> +# larger block size for data extent scrub"), which makes btrfs scrub unable
>>>> +# to detect corruption if it's not the first sector of an data extent.
>>>
>>> So 786672e9e1a3 is the commit which brought in this regression issue? Is there
>>> a fix patch or commit by reviewed?
>>
>> The fix (by reverting it) is send to btrfs mailing list, titled "Revert
>> \"btrfs: scrub: use larger block size for data extent scrub\"".
> 
> OK, thanks.
> 
>>
>>>
>>>> +#
>>>> +. ./common/preamble
>>>> +_begin_fstest auto quick scrub
>>>> +
>>>> +# Import common functions.
>>>> +. ./common/filter
>>>> +. ./common/btrfs
>>>
>>> The common/btrfs is imported automatically, so don't need to import it at here.
>>> And I think this case doesn't use any filter, if so, the common/filter isn't
>>> needed either.
>>>
>>>> +
>>>> +# real QA test starts here
>>>> +
>>>> +# Modify as appropriate.
>>>
>>> This comment can be removed.
>>
>> If you really believe removing those boilerplate makes much sense, then I'd
>> say, the template should be updated to remove those completely.
> 
> Hmm... there're many comments in template should be removed when we start to
> write a new case. Most of them are always removed properly, only this line
> always be missed.
> 
> I don't doubt the template can be improved. But it's a tiny problem, so I
> planned to improve that next time when we have chance to improve the template.
> Before that, if a patch is all good, only this single line can be removed, I'll
> ignore it. If a patch need to change, I'll point out this line incidentally :)

Another thing is, such nitpicking is a little too common.

 From my limited experience of previous maintainer Guan, he would either 
just fix it when merging.

Which is mostly inline with the fs maintainers, and makes the whole 
process so smooth.

I really appreciate the maintenance effort and valuable comments (like 
the one for "-s 4k"), but these comments on something from the template?
No, those makes no sense.

Thanks,
Qu

> 
>>
>>>
>>>> +_supported_fs btrfs
>>>> +
>>>> +# Need to use 4K as sector size
>>>> +_require_btrfs_support_sectorsize 4096
>>>> +_require_scratch
>>>> +
>>>> +_scratch_mkfs >> $seqres.full
>>>
>>> Just check with you, do you need "-s 4k" so make sure sector size is 4k (even
>>> if 4k is supported)?
>>
>> I'll add "-s 4k" to make it more explicit for systems with larger page
>> sizes.
> 
> Thanks,
> Zorro
> 
>>
>> Thanks,
>> Qu
>>
>>>
>>> Thanks,
>>> Zorro
>>>
>>>> +_scratch_mount
>>>> +
>>>> +# Create a data extent with 2 sectors
>>>> +$XFS_IO_PROG -fc "pwrite -S 0xff 0 8k" $SCRATCH_MNT/foobar >> $seqres.full
>>>> +sync
>>>> +
>>>> +first_logical=$(_btrfs_get_first_logical $SCRATCH_MNT/foobar)
>>>> +echo "logical of the first sector: $first_logical" >> $seqres.full
>>>> +
>>>> +second_logical=$(( $first_logical + 4096 ))
>>>> +echo "logical of the second sector: $second_logical" >> $seqres.full
>>>> +
>>>> +second_physical=$(_btrfs_get_physical $second_logical 1)
>>>> +echo "physical of the second sector: $second_physical" >> $seqres.full
>>>> +
>>>> +second_dev=$(_btrfs_get_device_path $second_logical 1)
>>>> +echo "device of the second sector: $second_dev" >> $seqres.full
>>>> +
>>>> +_scratch_unmount
>>>> +
>>>> +# Corrupt the second sector of the data extent.
>>>> +$XFS_IO_PROG -c "pwrite -S 0x00 $second_physical 4k" $second_dev >> $seqres.full
>>>> +_scratch_mount
>>>> +
>>>> +# Redirect stderr and stdout, as if btrfs detected the unrepairable corruption,
>>>> +# it will output an error message.
>>>> +$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT &> $tmp.output
>>>> +cat $tmp.output >> $seqres.full
>>>> +_scratch_unmount
>>>> +
>>>> +if ! grep -q "csum=1" $tmp.output; then
>>>> +	echo "Scrub failed to detect corruption"
>>>> +fi
>>>> +
>>>> +echo "Silence is golden"
>>>> +
>>>> +# success, all done
>>>> +status=0
>>>> +exit
>>>> diff --git a/tests/btrfs/278.out b/tests/btrfs/278.out
>>>> new file mode 100644
>>>> index 00000000..b4c4a95d
>>>> --- /dev/null
>>>> +++ b/tests/btrfs/278.out
>>>> @@ -0,0 +1,2 @@
>>>> +QA output created by 278
>>>> +Silence is golden
>>>> -- 
>>>> 2.38.0
>>>>
>>>
>>
> 
