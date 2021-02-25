Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A263248F9
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Feb 2021 03:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbhBYCqo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Feb 2021 21:46:44 -0500
Received: from sandeen.net ([63.231.237.45]:56198 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235432AbhBYCqk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Feb 2021 21:46:40 -0500
Received: from liberator.sandeen.net (liberator.sandeen.net [10.0.0.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id E1932450A88;
        Wed, 24 Feb 2021 20:45:43 -0600 (CST)
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     fstests@vger.kernel.org
References: <3e8f846d-e248-52a3-9863-d188f031401e@sandeen.net>
 <5e133067-ec0c-f2c6-7fb6-84620e26881e@sandeen.net>
 <407b5343-4124-2e30-0202-13f42d612b7c@oracle.com>
 <68737772-deb2-6429-2ac6-572e15cffe57@sandeen.net>
 <b119f3a9-bf78-5b09-2054-09a2f583581c@gmx.com>
From:   Eric Sandeen <sandeen@sandeen.net>
Subject: Re: xfstests seems broken on btrfs with multi-dev TEST_DEV
Message-ID: <eb0d9c05-2818-fb57-4b2c-75b379d088a5@sandeen.net>
Date:   Wed, 24 Feb 2021 20:45:57 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <b119f3a9-bf78-5b09-2054-09a2f583581c@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/24/21 7:56 PM, Qu Wenruo wrote:
> 
> 
> On 2021/2/25 上午9:46, Eric Sandeen wrote:
>> On 2/24/21 7:16 PM, Anand Jain wrote:
>>> On 25/02/2021 05:39, Eric Sandeen wrote:
>>>> On 2/24/21 10:12 AM, Eric Sandeen wrote:
>>>>> Last week I was curious to just see how btrfs is faring with RAID5 in
>>>>> xfstests, so I set it up for a quick run with devices configured as:
>>>>
>>>> Whoops this was supposed to cc: fstests, not fsdevel, sorry.
>>>>
>>>> -Eric
>>>>
>>>>> TEST_DEV=/dev/sdb1 # <--- this was a 3-disk "-d raid5" filesystem
>>>>> SCRATCH_DEV_POOL="/dev/sdb2 /dev/sdb3 /dev/sdb4 /dev/sdb5 /dev/sdb6"
>>>>>
>>>>> and fired off ./check -g auto
>>>>>
>>>>> Every test after btrfs/124 fails, because that test btrfs/124 does this:
>>>>>
>>>>> # un-scan the btrfs devices
>>>>> _btrfs_forget_or_module_reload
>>>>>
>>>>> and nothing re-scans devices after that, so every attempt to mount TEST_DEV
>>>>> will fail:
>>>>>
>>>>>> devid 2 uuid e42cd5b8-2de6-4c85-ae51-74b61172051e is missing"
>>>>>
>>>>> Other btrfs tests seeme to have the same problem.
>>>>>
>>>>> If xfstest coverage on multi-device btrfs volumes is desired, it might be
>>>>> a good idea for someone who understands the btrfs framework in xfstests
>>>>> to fix this.
>>>
>>> Eric,
>>>
>>>   All our multi-device test-cases under tests/btrfs used the
>>>   SCRATCH_DEV_POOL. Unless I am missing something, any idea if
>>>   TEST_DEV can be made optional for test cases that don't need TEST_DEV?
>>>   OR I don't understand how TEST_DEV is useful in some of these
>>>   test-cases under tests/btrfs.
>>
>> Those are the tests specifically designed to poke at multi-dev btrfs, right.
>>
>> TEST_DEV is more designed to "age" - it is used for more non-destructive tests.
>>
>> The point is that many tests /d/o run using TEST_DEV, and if a multi-dev TEST_DEV
>> can't be used, you are getting no coverage from those tests on that type of
>> btrfs configuration. And if a multi-dev TEST_DEV breaks the test run, nobody's
>> going to test that way.
> 
> The problem is, TEST_DEV should not be included in SCRATCH_DEV_POOL.

Sorry, I typed out the config from memory and made an error, sorry for
the confusion.

Let me try again to demonstrate. I have 10 completely different block devices
(loop devices, for this demo)

# cat local.config
export TEST_DEV=/dev/loop1 
export TEST_DIR=/mnt/test
export SCRATCH_DEV_POOL="/dev/loop5 /dev/loop6 /dev/loop7 /dev/loop8 /dev/loop9"
export SCRATCH_MNT=/mnt/scratch

TEST_DEV is a 3-device filesystem:

# mkfs.btrfs -f -d raid5 /dev/loop1 /dev/loop2 /dev/loop3

so: 3-dev TEST_DEV, 5 /different/ devices in the SCRATCH_DEV_POOL

Run btrfs/124:

# ./check btrfs/124
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 intel-lizardhead-04 5.11.0-rc7+ #128 SMP Fri Feb 12 16:15:39 EST 2021
MKFS_OPTIONS  -- /dev/loop5
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/loop5 /mnt/scratch

btrfs/124	- output mismatch (see /root/xfstests-dev/results//btrfs/124.out.bad)

<ok it failed but ... beside the point>

Now, no other test can be run:

# dmesg -c > /dev/null

# ./check generic/001
mount: wrong fs type, bad option, bad superblock on /dev/loop1,
       missing codepage or helper program, or other error

       In some cases useful info is found in syslog - try
       dmesg | tail or so.
common/rc: retrying test device mount with external set
mount: wrong fs type, bad option, bad superblock on /dev/loop1,
       missing codepage or helper program, or other error

       In some cases useful info is found in syslog - try
       dmesg | tail or so.
common/rc: could not mount /dev/loop1 on /mnt/test

# dmesg
[544731.787311] BTRFS info (device loop1): disk space caching is enabled
[544731.794514] BTRFS info (device loop1): has skinny extents
[544731.801050] BTRFS error (device loop1): devid 2 uuid 2cb73b87-b5c9-46ec-a457-594455cfb7e3 is missing
[544731.811343] BTRFS error (device loop1): failed to read the system array: -2
[544731.826098] BTRFS error (device loop1): open_ctree failed
[544731.863343] BTRFS info (device loop1): disk space caching is enabled
[544731.870530] BTRFS info (device loop1): has skinny extents
[544731.877022] BTRFS error (device loop1): devid 2 uuid 2cb73b87-b5c9-46ec-a457-594455cfb7e3 is missing
[544731.887335] BTRFS error (device loop1): failed to read the system array: -2
[544731.903094] BTRFS error (device loop1): open_ctree failed

