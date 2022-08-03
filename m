Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2398558853B
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Aug 2022 02:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236986AbiHCA6U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 20:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235306AbiHCA6Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 20:58:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2CD50070
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 17:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659488291;
        bh=GLPRIX+38u3m5iI0oc5Jb66tv+At/KJkhOXQ5P1UYqY=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=SIAkMl8eiPsoAEUNver2H9LB6a2dbwCS/YEEQfhCSFvL15+j29+JFcdOjGM5vqGeI
         h8QLcD5JGYRz07RqtT2SHCi8uaX0+OXvypOrOA9oa1IJ9R/Wzs4rfYaVkoqJ3NoGfK
         Bc+EuUI0NqBZBptRej92F1c9tqhPXF205c8Bcsfw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mqs0X-1nf5O73jTF-00molz; Wed, 03
 Aug 2022 02:58:11 +0200
Message-ID: <e2ea258a-baa8-e437-a303-c55184a55106@gmx.com>
Date:   Wed, 3 Aug 2022 08:58:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     "me@jse.io" <me@jse.io>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1658726692.git.wqu@suse.com>
 <CAFMvigdrNM4Jspc=_Pu1UM8Z=+YBdcMuAqJVTK6=LJzC43Aokw@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 00/14] btrfs: introduce write-intent bitmaps for RAID56
In-Reply-To: <CAFMvigdrNM4Jspc=_Pu1UM8Z=+YBdcMuAqJVTK6=LJzC43Aokw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eFvcgmwDKRBzaVcqUdBNI7oXEQaRN+2CGuwsNO1uIc2FYpAe3Qq
 gY8AljE37ITwSZT+NjNHM5ROlxPPcflEGMr9V6XTAqDKgNoqVjmBrYKLn6xAszWV0qrjecs
 96OCTyl2vGGDOu4dqOtcbHAWqh7IefmCpgtIbebpUsZHtvCJewvF3xcp1SCzf2oh2Kl8ckM
 TQNVZIuXLbsgy6CksApDw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UGT8elYWlII=:oeeV07RKVzhHRSMgJj8mPC
 44//xGd4ELrT/Wyexd9MELeGfkEB4N2QKSjvGovaTjhsazMVXNzHneSz+BRW2bio4m9Kd66JW
 PxgRM5AbFKGDXrPE8wqCgj3mmxjfueTax+HqkTZCfX1qm1WFD/1XHSsBI5HCmiZFd4T4Nw4mN
 iGc4H3dppY3WHHILbaSsK7/5GbpzP+/MjBYwCoRwkn635NRVs64APGAOaoSRI2d/dEAA9xa9Z
 msGSDMdTxNcRWRrWHOFd2Hf6s1z//9NMYfHpK0N/ruXeUwBoy8fxmHjmCaSO8INUvbTXsKL/m
 0evLeoZ5vX2trBQzlIJDt3Sz4sxDQDrfo9ERZqFRaRTKfUVvlxksF4BaRMEIkgtB1ptkPNR4r
 0z4eSrvaEl9th2WW+1kFN0T2s/URuEcBUkU+oNEwZpVcGwigdj17rwMLqtCYopngekcw5ReBJ
 B0PHKq8RF2YWBL1VqiLY+N14NdBlJz2Dr78j+QPxPsT9BccpQZ/Hi+r4kNex9TatFC0ZHrEkb
 vkLZ6i72oT04nk+D5cBNb7bk1NZmjAMkmHxyNR+tDhbFMyDJBL/vwBP6pcdoW9GNpd0UGI6+H
 SuT98RsIRZbj0oGq/HJF/aYiusSy94YwWzaSfATo7aqcLpTcOktkBKj/CXPdC+yYnQPGDVo36
 Bny7FNIWSDaskoJUMA519ARkv36vmClfvjMwoT5qQfCU8/2knjOyMQ1RlTtaG5CwSh7aOOizg
 tpJLZXBbjiPzhaLJWxXhDY3Juru5F9s+pbp17J/C3oqcx3gS3IA9jyASZ6ryThwEJ6MOJbAm8
 tqkYkKhM8oyiQz1YvijPaHkgAND3ie7NRlYU9dNnGLJlRwLSAkCnc7VPAFINofAxIDcwh2vLO
 Q4FQtfvWPaxKpXH//jhRr3shFegqZFqRxvHkpBSLkchPbL8cbDjUTSTFTnYIPwMoWIZxPxDjh
 24QUeDxiLPXeBsNXKJlJGHtIwwOERIq+YTSWB8GapKKMMB+e5leUFh9HYK7aISe2p2cr/BiW+
 YQ+7ZoTLB4PgSUU9Buetf/Z9/9dQ425h1kordaC6YeNTzpSIAR2VjD+1XjDdgiFJw7W966SmO
 3DsG2g/S6HspGUjkGatLuVYcpneI/kmmGwTwH0sMOh98m13ri9P67gB/A==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/3 08:29, me@jse.io wrote:
> Hey there,
> It would be nice if a bitmap could be used for other purposes too, not
> just for RAID5/6. To not only improve resilver times without scrubbing
> the entire array,

That's already in the todo list.

> but also for just syncing up NOCOW files.

But I'm not sure if it can help for NOCOW files.

> Corruption
> sucks, and using NOCOW the user should assume you have no protection
> from csums. However, the problem with NOCOW right now is on any
> redundant profile, it seems once one copy goes out of sync with
> another, unless the user balances the affected chunks or cp
> --reflink=3Dnever the file, you can end up in a case where one copy may
> always be out of sync with the other. Then, the application reading
> the file can get different results depending on which disk it reads
> from.
>
> That seems worse than the corruption itself that can't be repaired due
> to no CSUMs, and is by far worse than MD.

The problem for NOCOW file is, it also implies NOCSUM, and even we can
detect mismatches in copies, it only really helps limited profiles like
RAID1C3, RAID1C4, and maybe RAID56.

The problem here is, for 2 mirrors profiles, even if we can detect the
mismatch, we have no idea which is correct.

We rely on csum to determine which copy is correct, but NOCOW/NOCSUM
makes it very hard to do.

For RAID1C3/C4 we can go democracy, but for RAID1C4 it's also possible
that we got two different content from all the mirrors.

If we really want to solve the NOCOW/NOCSUM problem, I guess full
journal is the only solution, and I'm pretty sure we will go that
direction anyway (after the write-intent part get merged, as the full
journal still relies on a lot of things from write-intent code).

>
> This is especially worrisome since a number of distros and userspace
> tools and distros these days are defaulting to using the NOCOW
> attribute for common applications. ie. Arch and mySQL, or libvirt.
>
> Is there any way this could be used for these purposes as well, in
> addition to the stated purpose for RAID5/6?

For now, the plan for future development on write-intent only includes:

- For degraded mount
- As basis for later full journal implement.

For your concern, it's in fact not related to write-intent, but in scrub
code.

In that part, I have some plan to rework the scrub interface completely,
and with the rework, it will have the ability to detect content
difference between mirrors, even without csum.

But that would take a longer time, and the main purpose is to improve
the RAID56 scrub perf, not really the problem you mentioned.

Thanks,
Qu

>
> On Mon, Jul 25, 2022 at 2:38 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [CHANGELOG]
>> v2->v1:
>> - Add mount time recovery functionality
>>    Now if a dirty bitmap is found, we will do proper recovery at mount
>>    time.
>>
>>    The code is using scrub routine to do the proper recovery for both
>>    data and P/Q parity.
>>
>>    Currently we can only test this by manually setting up a dirty bitma=
p,
>>    and corrupt the full stripe, then mounting it and verify the full
>>    stripe using "btrfs check --check-data-csum"
>>
>> - Skip full stripe writes
>>    Full stripe writes are either:
>>    * New writes into unallocated space
>>      After powerloss, we won't read any data from the full stripe.
>>
>>    * Writes into NODATACOW ranges
>>      We won't have csum for them anyway, thus new way to do any recover=
y.
>>
>> - Fix a memory leakage caused by RO mount
>>    Previously we only cleanup the write-intent ctrl if it's RW mount,
>>    thus for RO mount we will cause memory leak.
>>
>>
>> RFC->v1:
>> - Fix a corner case in write_intent_set_bits()
>>    If the range covers the last existing entry, but still needs a new
>>    entry, the old code will not insert the new entry, causing
>>    write_intent_clear_bits() to cause a warning.
>>
>> - Add selftests for the write intent bitmaps
>>    The write intent bitmaps is an sparse array of bitmaps.
>>    There are some corner cases tricky to get it done correctly in the
>>    first try (see above case).
>>    The test case would prevent such problems from happening again.
>>
>> - Fix hang with dev-replace, and better bitmaps bio submission
>>    Previously we will hold device_list_mutex while submitting the bitma=
ps
>>    bio, this can lead to deadlock with dev-replace/dev-removal.
>>    Fix it by using RCU to keep an local copy of devices and use them
>>    to submit the bitmaps bio.
>>
>>    Furthermore, there is no need to follow the way of superblocks
>>    writeback, as the content of bitmaps are always the same for all
>>    devices, we can just submitting the same page and use atomic counter
>>    to wait for them to finish.
>>
>>    Now there is no more crash/warning/deadlock in btrfs/070.
>>
>> [BACKGROUND]
>> Unlike md-raid, btrfs RAID56 has nothing to sync its devices when power
>> loss happens.
>>
>> For pure mirror based profiles it's fine as btrfs can utilize its csums
>> to find the correct mirror the repair the bad ones.
>>
>> But for RAID56, the repair itself needs the data from other devices,
>> thus any out-of-sync data can degrade the tolerance.
>>
>> Even worse, incorrect RMW can use the stale data to generate P/Q,
>> removing the possibility of recovery the data.
>>
>>
>> For md-raid, it goes with write-intent bitmap, to do faster resilver,
>> and goes journal (partial parity log for RAID5) to ensure it can even
>> stand a powerloss + device lose.
>>
>> [OBJECTIVE]
>>
>> This patchset will introduce a btrfs specific write-intent bitmap.
>>
>> The bitmap will locate at physical offset 1MiB of each device, and the
>> content is the same between all devices.
>>
>> When there is a RAID56 write (currently all RAID56 write, including ful=
l
>> stripe write), before submitting all the real bios to disks,
>> write-intent bitmap will be updated and flushed to all writeable
>> devices.
>>
>> So even if a powerloss happened, at the next mount time we know which
>> full stripes needs to check, and can start a scrub for those involved
>> logical bytenr ranges.
>>
>> [ADVANTAGE OF BTRFS SPECIFIC WRITE-INTENT BITMAPS]
>>
>> Since btrfs can utilize csum for its metadata and CoWed data, unlike
>> dm-bitmap which can only be used for faster re-silver, we can fully
>> rebuild the full stripe, as long as:
>>
>> 1) There is no missing device
>>     For missing device case, we still need to go full journal.
>>
>> 2) Untouched data stays untouched
>>     This should be mostly sane for sane hardware.
>>
>> And since the btrfs specific write-intent bitmaps are pretty small (4Ki=
B
>> in size), the overhead much lower than full journal.
>>
>> In the future, we may allow users to choose between just bitmaps or ful=
l
>> journal to meet their requirement.
>>
>> [BITMAPS DESIGN]
>>
>> The bitmaps on-disk format looks like this:
>>
>>   [ super ][ entry 1 ][ entry 2 ] ... [entry N]
>>   |<---------  super::size (4K) ------------->|
>>
>> Super block contains how many entires are in use.
>>
>> Each entry is 128 bits (16 bytes) in size, containing one u64 for
>> bytenr, and u64 for one bitmap.
>>
>> And all utilized entries will be sorted in their bytenr order, and no
>> bit can overlap.
>>
>> The blocksize is now fixed to BTRFS_STRIPE_LEN (64KiB), so each entry
>> can contain at most 4MiB, and the whole bitmaps can contain 224 entries=
.
>>
>> For the worst case, it can contain 14MiB dirty ranges.
>> (1 bits set per bitmap, also means 2 disks RAID5 or 3 disks RAID6).
>>
>> For the best case, it can contain 896MiB dirty ranges.
>> (all bits set per bitmap)
>>
>> [WHY NOT BTRFS BTREE]
>>
>> Current write-intent structure needs two features:
>>
>> - Its data needs to survive cross stripe boundary
>>    Normally this means write-intent btree needs to acts like a proper
>>    tree root, has METADATA_ITEMs for all its tree blocks.
>>
>> - Its data update must be outside of a transaction
>>    Currently only log tree can do such thing.
>>    But unfortunately log tree can not survive across transaction
>>    boundary.
>>
>> Thus write-intent btree can only meet one of the requirement, not a
>> suitable solution here.
>>
>> [TESTING AND BENCHMARK]
>>
>> For performance benchmark, unfortunately I don't have 3 HDDs to test.
>> Will do the benchmark after secured enough hardware.
>>
>> For testing, it can survive volume/raid/dev-replace test groups, and no
>> write-intent bitmap leakage.
>>
>> Unfortunately there is still a warning triggered in btrfs/070, still
>> under investigation, hopefully to be a false alert in bitmap clearing
>> path.
>>
>> [TODO]
>> - Extra optimizations
>>    * Enlarge the window between btrfs_write_intent_mark_dirty() and
>>      btrfs_write_intent_writeback()
>>      So that we can merge more dirty bites and cause less bitmaps
>>      writeback
>>
>> - Proper performance benchmark
>>    Needs hardware/baremetal VMs, since I don't have any physical machin=
e
>>    large enough to contian 3 3.5" HDDs.
>>
>>
>> Qu Wenruo (14):
>>    btrfs: introduce new compat RO flag, EXTRA_SUPER_RESERVED
>>    btrfs: introduce a new experimental compat RO flag,
>>      WRITE_INTENT_BITMAP
>>    btrfs: introduce the on-disk format of btrfs write intent bitmaps
>>    btrfs: load/create write-intent bitmaps at mount time
>>    btrfs: write-intent: write the newly created bitmaps to all disks
>>    btrfs: write-intent: introduce an internal helper to set bits for a
>>      range.
>>    btrfs: write-intent: introduce an internal helper to clear bits for =
a
>>      range.
>>    btrfs: selftests: add selftests for write-intent bitmaps
>>    btrfs: write back write intent bitmap after barrier_all_devices()
>>    btrfs: update and writeback the write-intent bitmap for RAID56 write=
.
>>    btrfs: raid56: clear write-intent bimaps when a full stripe finishes=
.
>>    btrfs: warn and clear bitmaps if there is dirty bitmap at mount time
>>    btrfs: avoid recording full stripe write into write-intent bitmaps
>>    btrfs: scrub the full stripe which had sub-stripe write at mount tim=
e
>>
>>   fs/btrfs/Makefile                           |   5 +-
>>   fs/btrfs/ctree.h                            |  26 +-
>>   fs/btrfs/disk-io.c                          |  58 +-
>>   fs/btrfs/raid56.c                           |  27 +
>>   fs/btrfs/scrub.c                            | 177 +++-
>>   fs/btrfs/sysfs.c                            |   2 +
>>   fs/btrfs/tests/btrfs-tests.c                |   4 +
>>   fs/btrfs/tests/btrfs-tests.h                |   2 +
>>   fs/btrfs/tests/write-intent-bitmaps-tests.c | 247 ++++++
>>   fs/btrfs/volumes.c                          |  34 +-
>>   fs/btrfs/write-intent.c                     | 923 +++++++++++++++++++=
+
>>   fs/btrfs/write-intent.h                     | 303 +++++++
>>   fs/btrfs/zoned.c                            |   8 +
>>   include/uapi/linux/btrfs.h                  |  17 +
>>   14 files changed, 1812 insertions(+), 21 deletions(-)
>>   create mode 100644 fs/btrfs/tests/write-intent-bitmaps-tests.c
>>   create mode 100644 fs/btrfs/write-intent.c
>>   create mode 100644 fs/btrfs/write-intent.h
>>
>> --
>> 2.37.0
>>
