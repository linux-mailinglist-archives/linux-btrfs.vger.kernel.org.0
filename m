Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639E374662B
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jul 2023 01:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjGCXYr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jul 2023 19:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGCXYq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jul 2023 19:24:46 -0400
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [213.138.97.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD71C7
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 16:24:44 -0700 (PDT)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 46DE39B6BF; Tue,  4 Jul 2023 00:24:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1688426680;
        bh=V7DebNK88nXafNtWM6rmBJoU1n1v28eG+8xy66kTCdE=;
        h=Date:From:Subject:To:References:In-Reply-To:From;
        b=jIWx1iHMrOy9gSBzpC/I/JRSWq85KYgQTpJKSTEFUpftEhYAGDpbNNrpQ1e5nR0LB
         CCpqQTm9d+om1zWDKAFt+Vwy2D2g3S1zF3gRzkqMo3wGC/dD7eRasIYAiKh6WEv5Yh
         lsGjedGhxVXu9lzUFwXNDZtL7HeKzkIRc2B+e8/jjiejP1FqXUPKnyavv6ChGQk00K
         vleXvZXDiOhaGpeuOCwAHoXtMeOXpK4n9m/j7cOgNCt/Y6nkHqa8kNtAunRJN8T1Qc
         qnS8J6oytU9mox8SQ7zeH7QwdjReyUSC36gbVGbepTCWkzDyW8NU7tHuVoY8M43p7A
         GeD8539q9hGaw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 8D8CA9B6BF;
        Tue,  4 Jul 2023 00:19:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1688426379;
        bh=V7DebNK88nXafNtWM6rmBJoU1n1v28eG+8xy66kTCdE=;
        h=Date:From:Subject:To:References:In-Reply-To:From;
        b=xl9pg4gvTsnGvNqhIii4zgE4mpo+PZb53pUpj4Iw3UB286bztQPP1zub6G4nhjO55
         1X/lsSCx6s/9kOMXfN8iGVVFvLsq+fd7s22VZMdlse2HO7FH1RcUonwNZkV/wUdanZ
         RV5RgTXnTMatfJf8blN+5DW/Ug4FqDyIIEmOwwHUOnWOxiLLUXCUK0jxKhAQrLTg5w
         Ziop3kGmBOuM6nV/jehvUeAkO9qlC5NhW6r+C6YlhFSnUm+h1R8nbdi210I4SHtiRg
         /vrktQYNU2P6ZcKZDmWEn0H67xoVfTC7Bj+3hqLY92ty3+DDsW6lQZSlOnI+6aDp29
         7ww/DDE+ovL4Q==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id 4B7FA341E68;
        Tue,  4 Jul 2023 00:19:39 +0100 (BST)
Message-ID: <bc650ee0-c9c1-91eb-0b63-cb3730040784@cobb.uk.net>
Date:   Tue, 4 Jul 2023 00:19:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Subject: Re: [PATCH 00/14] btrfs: scrub: introduce SCRUB_LOGICAL flag
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1688368617.git.wqu@suse.com>
 <fda86f3c-528c-9cd6-6228-d0278a73f138@cobb.uk.net>
 <03b37264-dc70-43c6-e526-5f0baca09182@gmx.com>
In-Reply-To: <03b37264-dc70-43c6-e526-5f0baca09182@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 03/07/2023 23:40, Qu Wenruo wrote:
> 
> 
> On 2023/7/3 20:58, Graham Cobb wrote:
>> On 03/07/2023 08:32, Qu Wenruo wrote:
>>> [CHANGELOG]
>>> RFC->v1:
>>> - Add RAID56 support
>>>    Which is the biggest advantage of the new scrub mode.
>>>
>>> - More basic tests around various repair situations
>>>
>>> [REPO]
>>> Please fetch from github repo:
>>> https://github.com/adam900710/linux/tree/scrub_logical
>>>
>>> This is based on David's misc-next, but still has one extra regression
>>> fix which is not yet merged. ("btrfs: raid56: always verify the P/Q
>>> contents for scrub")
>>>
>>> [BACKGROUND]
>>> Scrub originally works in a per-device basis, that means if we want to
>>> scrub the full fs, we would queue a scrub for each writeable device.
>>>
>>> This is normally fine, but some behavior is not ideal like the
>>> following:
>>>         X    X+16K    X+32K
>>>   Mirror 1    |XXXXXXX|       |
>>>   Mirror 2    |       |XXXXXXX|
>>>
>>> When scrubbing mirror 1, we found [X, X+16K) has corruption, then we
>>> will try to read from mirror 2 and repair using the correct data.
>>>
>>> This applies to range [X+16K, X+32K) of mirror 2, causing the good copy
>>> to be read twice, which may or may not be a big deal.
>>>
>>> But the problem can easily go crazy for RAID56, as its repair requires
>>> the full stripe to be read out, so is its P/Q verification, e.g.:
>>>
>>>         X    X+16K    X+32K
>>>   Data stripe 1    |XXXXXXX|       |    |    |
>>>   Data stripe 2    |       |XXXXXXX|    |    |
>>>   Parity stripe    |       |    |XXXXXXX|    |
>>>
>>> In above case, if we're scrubbing all mirrors, we would read the same
>>> contents again and again:
>>>
>>> Scrub on mirror 1:
>>> - Read data stripe 1 for the initial read.
>>> - Read data stripes 1 + 2 + parity for the rebuild.
>>>
>>> Scrub on mirror 2:
>>> - Read data stripe 2 for the initial read.
>>> - Read data stripes 1 + 2 + parity for the rebuild.
>>>
>>> Scrub on Parity
>>> - Read data stripes 1 + 2 for the data stripes verification
>>> - Read data stripes 1 + 2 + parity for the data rebuild
>>>    This step is already improved by recent optimization to use cached
>>>    stripes.
>>> - Read the parity stripe for the final verification
>>>
>>> So for data stripes, they are read *five* times, and *three* times for
>>> parity stripes.
>>>
>>> [ENHANCEMENT]
>>> Instead of the existing per-device scrub, this patchset introduce a new
>>> flag, SCRUB_LOGICAL, to do logical address space based scrub.
>>>
>>> Unlike per-device scrub, this new flag would make scrub a per-fs
>>> operation.
>>>
>>> This allows us to scrub the different mirrors in one go, and avoid
>>> unnecessary read to repair the corruption.
>>>
>>> This means, no matter what profile, they always read the same data just
>>> once.
>>>
>>> This also makes user space handling much simpler, just one ioctl to
>>> scrub the full fs, without the current multi-thread scrub code.
>>
>> I have a comment on terminology. If I understand correctly, this flag
>> changes scrub from an operation performed in parallel on all devices, to
>> one done sequentially, with less parallelism.
> 
> It depends.
> 
> There are several different factors affecting the concurrency even for
> the mentioned cases.
> 
> Like the race of different devices for the dev-extent and csum tree lookup.
> 
> In fact for nr_devices > mirrors (aka, RAID1*, DUP, SINGLE) profiles,
> the difference scrub pace can lead to more problems like too many block
> group mark RO.
> 
> For this situation it's really hard to say the impact, but I'm
> optimistic on the performance, and it would be finally determine by real
> world benchmark.
> 
> Please remember that, the worst case profiles are mostly only utilized
> by metadata, while for data it's way more common to go RAID0/RAID10 or
> even RAID5/6 for adventurous users, which the new interface is way
> better for those profiles.

It would be great to see some real measurements, of course, but I am
thinking of cases like RAID1 data on 3, 4 or even more disks. It feels
like a RAID1 filesystem with 4 disks might take up to twice as long with
logical address-based scrub instead of per-device scrub. And I can't
even begin to visualise how it would perform with RAID5 data over 10
disks, say.

But getting benchmarks and practical experience is obviously a good
idea. Just please don't take control of which algorithm to use away from
the system manager without being sure it is really better.

Graham

> 
>>
>> The original code scrubs every device at the same time. In very rough
>> terms, for a filesystem with more devices than copies, the duration for
>> a scrub with no errors is the time taken to read every block on the most
>> occupied device. Other disks will finish earlier.
>>
>> In the same case, the new code will take the time taken to read one
>> block from every file (not just those on the most occupied disk). It is
>> not clear to me how much parallelism will occur in this case.
>>
>> I am not saying it isn't worth doing, but that it may be best to explain
>> it in terms of parallel vs. sequential rather than physical vs. logical.
>> Certainly in making the user documentation, and scrub command line,
>> clear to the user and possibly even in the naming of the flag (e.g.
>> SCRUB_SEQUENTIAL instead of SCRUB_LOGICAL).
>>
>>>
>>> [TODO]
>>> - More testing
>>>    Currently only done functional tests, no stress tests yet.
>>>
>>> - Better progs integration
>>>    In theory we can silently try SCRUB_LOGICAL first, if the kernel
>>>    doesn't support it, then fallback to the old multi-device scrub.
>>
>> Maybe not if my understanding is correct. On filesystems with more disks
>> than copies the new code may take noticeably longer?
> 
> Not really.
> 
> I'd like to have some real world benchmark for these cases instead.
> 
> Thanks,
> Qu
> 
>>
>> Or do I misunderstand?
>>
>> Graham
>>
>>>
>>>    But for current testing, a dedicated option is still assigned for
>>>    scrub subcommand.
>>>
>>>    And currently it only supports full report, no summary nor scrub file
>>>    support.
>>>
>>> Qu Wenruo (14):
>>>    btrfs: raid56: remove unnecessary parameter for
>>>      raid56_parity_alloc_scrub_rbio()
>>>    btrfs: raid56: allow scrub operation to update both P and Q stripes
>>>    btrfs: raid56: allow caching P/Q stripes
>>>    btrfs: raid56: add the interfaces to submit recovery rbio
>>>    btrfs: add the ability to read P/Q stripes directly
>>>    btrfs: scrub: make scrub_ctx::stripes dynamically allocated
>>>    btrfs: scrub: introduce the skeleton for logical-scrub
>>>    btrfs: scrub: extract the common preparation before scrubbing a block
>>>      group
>>>    btrfs: scrub: implement the chunk iteration code for scrub_logical
>>>    btrfs: scrub: implement the basic extent iteration code
>>>    btrfs: scrub: implement the repair part of scrub logical
>>>    btrfs: scrub: add RAID56 support for queue_scrub_logical_stripes()
>>>    btrfs: scrub: introduce the RAID56 data recovery path for scrub
>>>      logical
>>>    btrfs: scrub: implement the RAID56 P/Q scrub code
>>>
>>>   fs/btrfs/disk-io.c         |    1 +
>>>   fs/btrfs/fs.h              |   12 +
>>>   fs/btrfs/ioctl.c           |    6 +-
>>>   fs/btrfs/raid56.c          |  134 +++-
>>>   fs/btrfs/raid56.h          |   17 +-
>>>   fs/btrfs/scrub.c           | 1198 ++++++++++++++++++++++++++++++------
>>>   fs/btrfs/scrub.h           |    2 +
>>>   fs/btrfs/volumes.c         |   50 +-
>>>   fs/btrfs/volumes.h         |   16 +
>>>   include/uapi/linux/btrfs.h |   11 +-
>>>   10 files changed, 1206 insertions(+), 241 deletions(-)
>>>
>>

