Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561653248A7
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Feb 2021 02:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbhBYBrn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Feb 2021 20:47:43 -0500
Received: from sandeen.net ([63.231.237.45]:53224 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235425AbhBYBrm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Feb 2021 20:47:42 -0500
Received: from liberator.sandeen.net (liberator.sandeen.net [10.0.0.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id BF799450A88;
        Wed, 24 Feb 2021 19:46:45 -0600 (CST)
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     fstests@vger.kernel.org
References: <3e8f846d-e248-52a3-9863-d188f031401e@sandeen.net>
 <5e133067-ec0c-f2c6-7fb6-84620e26881e@sandeen.net>
 <407b5343-4124-2e30-0202-13f42d612b7c@oracle.com>
From:   Eric Sandeen <sandeen@sandeen.net>
Subject: Re: xfstests seems broken on btrfs with multi-dev TEST_DEV
Message-ID: <68737772-deb2-6429-2ac6-572e15cffe57@sandeen.net>
Date:   Wed, 24 Feb 2021 19:46:59 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <407b5343-4124-2e30-0202-13f42d612b7c@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/24/21 7:16 PM, Anand Jain wrote:
> On 25/02/2021 05:39, Eric Sandeen wrote:
>> On 2/24/21 10:12 AM, Eric Sandeen wrote:
>>> Last week I was curious to just see how btrfs is faring with RAID5 in
>>> xfstests, so I set it up for a quick run with devices configured as:
>>
>> Whoops this was supposed to cc: fstests, not fsdevel, sorry.
>>
>> -Eric
>>
>>> TEST_DEV=/dev/sdb1 # <--- this was a 3-disk "-d raid5" filesystem
>>> SCRATCH_DEV_POOL="/dev/sdb2 /dev/sdb3 /dev/sdb4 /dev/sdb5 /dev/sdb6"
>>>
>>> and fired off ./check -g auto
>>>
>>> Every test after btrfs/124 fails, because that test btrfs/124 does this:
>>>
>>> # un-scan the btrfs devices
>>> _btrfs_forget_or_module_reload
>>>
>>> and nothing re-scans devices after that, so every attempt to mount TEST_DEV
>>> will fail:
>>>
>>>> devid 2 uuid e42cd5b8-2de6-4c85-ae51-74b61172051e is missing"
>>>
>>> Other btrfs tests seeme to have the same problem.
>>>
>>> If xfstest coverage on multi-device btrfs volumes is desired, it might be
>>> a good idea for someone who understands the btrfs framework in xfstests
>>> to fix this.
> 
> Eric,
> 
>  All our multi-device test-cases under tests/btrfs used the
>  SCRATCH_DEV_POOL. Unless I am missing something, any idea if
>  TEST_DEV can be made optional for test cases that don't need TEST_DEV?
>  OR I don't understand how TEST_DEV is useful in some of these
>  test-cases under tests/btrfs.

Those are the tests specifically designed to poke at multi-dev btrfs, right.

TEST_DEV is more designed to "age" - it is used for more non-destructive tests.

The point is that many tests /d/o run using TEST_DEV, and if a multi-dev TEST_DEV
can't be used, you are getting no coverage from those tests on that type of
btrfs configuration. And if a multi-dev TEST_DEV breaks the test run, nobody's
going to test that way.

There are ~300 tests that run on TEST_DEV, and restricting its functionality
to a single-device btrfs filesytem misses coverage.

# grep require_test tests/generic/??? | wc -l
299

tl;dr: a btrfs test which renders a legitimate btrfs TEST_DEV inoperable is
a flaw in that btrfs test, IMHO.

-Eric

> Thanks, Anand
> 
>>>
>>> Thanks,
>>> -Eric
>>>
> 
