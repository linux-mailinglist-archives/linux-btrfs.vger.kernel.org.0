Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D047BED52
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2019 10:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbfIZIYo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Sep 2019 04:24:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:51154 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725787AbfIZIYn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Sep 2019 04:24:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B22C3AF92;
        Thu, 26 Sep 2019 08:24:40 +0000 (UTC)
Subject: Re: [PATCH] btrfs: Add regression test for SINGLE profile conversion
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     WenRuo Qu <wqu@suse.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20190926072635.9310-1-nborisov@suse.com>
 <20190926081230.GX2622@desktop>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <f1bb82c4-f1e3-d0f0-35f6-89f2d7d0d221@suse.com>
Date:   Thu, 26 Sep 2019 11:24:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190926081230.GX2622@desktop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 26.09.19 г. 11:12 ч., Eryu Guan wrote:
> On Thu, Sep 26, 2019 at 10:26:35AM +0300, Nikolay Borisov wrote:
>> This is a regression test for the bug fixed by
>> 'btrfs: Fix a regression which we can't convert to SINGLE profile'
>>
>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>> ---
>>  tests/btrfs/194     | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  tests/btrfs/194.out |  2 ++
>>  tests/btrfs/group   |  1 +
>>  3 files changed, 55 insertions(+)
>>  create mode 100755 tests/btrfs/194
>>  create mode 100644 tests/btrfs/194.out
>>
>> diff --git a/tests/btrfs/194 b/tests/btrfs/194
>> new file mode 100755
>> index 000000000000..8935defd3f5e
>> --- /dev/null
>> +++ b/tests/btrfs/194
>> @@ -0,0 +1,52 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2019 SUSE Linux Products GmbH. All Rights Reserved.
>> +#
>> +# FS QA Test 194
>> +#
>> +# Test that block groups profile can be converted to SINGLE. This is a regression
>> +# test for 'btrfs: Fix a regression which we can't convert to SINGLE profile'
>> +#
>> +seq=`basename $0`
>> +seqres=$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +here=`pwd`
>> +tmp=/tmp/$$
>> +status=1	# failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +	cd /
>> +	rm -f $tmp.*
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +. ./common/filter
>> +
>> +# remove previous $seqres.full before test
>> +rm -f $seqres.full
>> +
>> +# real QA test starts here
>> +
>> +# Modify as appropriate.
>> +_supported_fs btrfs
>> +_supported_os Linux
>> +_require_scratch_dev_pool 2
>> +
>> +_scratch_dev_pool_get 2
>> +_scratch_pool_mkfs -draid1
>> +
>> +_scratch_mount 
>> +
>> +$BTRFS_UTIL_PROG balance start -dconvert=single $SCRATCH_MNT > $seqres.full 2>&1
>> +[ $? -eq 0 ] || _fail "Convert failed"
> 
> This indicates we're missing profile conversion tests in fstests. I
> think it's better to add a test framework/helpers and a full set of
> profile conversion tests instead of this raid1->single special case.

It's not important to be raid1, the important bit here is any profile to
single. As this is a specific, targeted test. But I do agree that having
a conversion test will be a more robust, long-term solution. Will work
on that.

> 
> e.g.
> 
> Define a test case array, which describes what's the src/dst of this
> conversion and how many devices this case requires, e.g.
> 
> test_cases=(
>         # $nr_dev_min:$metadata:$data:$metadata_convert:$data_convert
>         "2:single:single:raid0:raid0"
>         "2:single:single:raid1:raid1"
>         "2:single:single:raid1:raid0"
>         "3:single:single:raid5:raid5"
>         "4:single:single:raid6:raid6"
>         "4:single:single:raid10:raid10"
>         "2:raid0:raid0:raid1:raid0"
>         "2:raid0:raid0:raid1:raid1"
>         "3:raid0:raid0:raid5:raid5"
>         "4:raid0:raid0:raid6:raid6"
>         "4:raid0:raid0:raid10:raid10"
>         "2:raid1:raid0:raid1:raid1"
>         "3:raid1:raid0:raid5:raid5"
>         "4:raid1:raid0:raid6:raid6"
>         "4:raid1:raid1:raid10:raid10"
>         "4:raid5:raid5:raid1:raid1"
>         "4:raid5:raid5:raid6:raid6"
>         "4:raid5:raid5:raid10:raid10"
>         "4:raid6:raid6:raid1:raid1"
>         "4:raid6:raid6:raid5:raid5"
>         "4:raid6:raid6:raid10:raid10"
>         "4:raid10:raid10:raid5:raid5"
>         "4:raid10:raid10:raid6:raid6"
> 	<adding more cases>
> )
> 
> Then, create btrfs in source profile and populate fs with different
> kinds of files, compute sha1 digests of these files(fssum?), start
> conversion, after conversion compare sha1 digests.
> 
> And perhaps we could split the test cases into group and add them to
> different tests, in case putting all cases in a single test makes the
> test time too long.
> 
> Thanks,
> Eryu
> 
>> +
>> +_scratch_umount
>> +_scratch_dev_pool_put
>> +
>> +echo "Silence is golden"
>> +status=0
>> +exit
>> diff --git a/tests/btrfs/194.out b/tests/btrfs/194.out
>> new file mode 100644
>> index 000000000000..7bfd50ffb5a4
>> --- /dev/null
>> +++ b/tests/btrfs/194.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 194
>> +Silence is golden
>> diff --git a/tests/btrfs/group b/tests/btrfs/group
>> index b92cb12ca66f..6a11eb1b8230 100644
>> --- a/tests/btrfs/group
>> +++ b/tests/btrfs/group
>> @@ -196,3 +196,4 @@
>>  191 auto quick send dedupe
>>  192 auto replay snapshot stress
>>  193 auto quick qgroup enospc limit
>> +194 auto quick volume balance
>> -- 
>> 2.7.4
>>
> 
