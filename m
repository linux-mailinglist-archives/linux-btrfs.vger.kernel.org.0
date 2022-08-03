Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C70588984
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Aug 2022 11:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbiHCJj2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Aug 2022 05:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiHCJj1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Aug 2022 05:39:27 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B051E201BA
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Aug 2022 02:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659519560;
        bh=CYziluWpRWLljcCQPOYH/l22X+4vjtKk0RWQyyhJ320=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=KhvkmWEjjxcAOD6z/iVkkzlNisuORFgB2Wjaos/5ere9v4yqkrLBwtxEOOrU11Eli
         vmjHOalpTVxPzsSsDv5cELZb+EbhT19XlXtsEvGFYuwU/8BbjGOPk+Gxb0yVfYhVBN
         gVMYHRtTxFKi5YTl6+CZiVP0Ddw2aigZ9NOEtx+Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mzyyk-1nXPof4AJq-00x5ap; Wed, 03
 Aug 2022 11:39:20 +0200
Message-ID: <146f79ed-690d-7d68-c90a-8ae813299a2e@gmx.com>
Date:   Wed, 3 Aug 2022 17:39:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 00/14] btrfs: introduce write-intent bitmaps for RAID56
Content-Language: en-US
To:     kreijack@inwind.it, "me@jse.io" <me@jse.io>,
        Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1658726692.git.wqu@suse.com>
 <CAFMvigdrNM4Jspc=_Pu1UM8Z=+YBdcMuAqJVTK6=LJzC43Aokw@mail.gmail.com>
 <e2ea258a-baa8-e437-a303-c55184a55106@gmx.com>
 <feb3072c-794f-8b15-23d3-4a212191fd90@libero.it>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <feb3072c-794f-8b15-23d3-4a212191fd90@libero.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bz6JnguL/Y8g5jSx6Y26vBOOJOXxITiHhMvN+VfjR2ySlOpiw7a
 frx92gsytH0mLjkwzeZTIZuPr0FSoubdrW96lJmlxDTUD5xnE+ewqF5LwFmxmnjyx0cz7bD
 tt8pF2hKOC4NF+06jafCEyq9UFiFSYoubbkLlSzpC7VzEsRHhts3ruOnQdiK+3Bjw64LLT8
 QF/wrHcpYZT08FxSHZeoQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HaSTv8H5WBE=:n5mENItOx4UW99odYtXLLV
 sNS8H8zu8VIkwzx4v5UFvVf7svOWTEVYn5uxg1g+zTgt4OP8skdNv6O5d8IMU24F19Od8LtIa
 /eV1AnwJEk+vSXyE2QJfFQps1NijQNE8l6kKaeVwCDdSjL26h0c90gZ0zdVj8jMFbDi1jApWf
 /sX9l+3HjMu0t6gdaPaPu3WI/AoMz0cdQUveAl9otCOIpyOG4XUeHUR4k+J5ksi5OyzLVdU3w
 cQvbPRjNydjP9CmP9ODKIAQrl9rNL6TTw/XsT3CqOe0VXR2e6vy9ealI2Oz6U7VTJZHNIkfcy
 NLLl90S3++ZZVqFIbbm5d6MjhIv9AOE8u9c87jaj7MWsMnYGslWAO+L6cxqH2kHQVjewkegod
 ZEshWwRLw01XoKz581t+f3/GnntZ7K6XCmGQgeJS3D3PZrgkfQOHry2VySBcNYDVdKzDGl/u8
 phyU/y79bnR1lurSEY8EHFvC1K6n3y96gJMY08AC9emB7NcYTp7lb9fnP4lXMwtKnT97+5RV6
 j888JLLbP2W1Jpn8qoAhGdzLDp9e1RWmuxPKCg68Vyq5KqQc5yR6NW2KAnp7aZ/LNeaXN9m9r
 Juxhjrf7l1dcQHBEoAwr2X0A/JNALdoQuUhE4L1P8k8e8tvmDN9p0R9H0twlDojirIh9mW34E
 UrK3K26Z9N2Wejmqrk13hwu6uv2zw2PayAtfMz+rmtQx1IOLcM4AH7vAJFm52OPAMhOlmkyRP
 X51m7lpL1WQPSvJ/0oExfZTFT1WkPrDtiaRkD6jGTCH+Ti4fhdOWjaOrBBE/Kz/LuGW/dHFwh
 HlcJlCX7SX3M2erqfBN57dbHPmsAYBaHsElWUne0cAUw89Imq7Qz7RANw6eLKeAPffgV9Cvo5
 se5UhWQAHlOLfPqSZRX1Iz1V9rCDBtX88KQMiQAiTN74Lj34RqsDndTGcpv+4gM+YJ8YnsqYi
 kr/F8AmOsTSfPWJxcL2FCMr//WECxn3yqK0Kk7RHGmEfZeTBK47cXPF7bLX2pdJI2BY7ulDvz
 s1KJGoGCFX6pYh95hRrCDy2uVJ2MEaCnnFYvJiJGrx/cB5J489BGVdEb3PFh4G00EG8MkvNPo
 cluPz5q1JXhnHSs4jDHQ4G+0vlF4DA1HOZ29NmegV3/Vwj4PG4CBsO2Dg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/3 17:11, Goffredo Baroncelli wrote:
> On 03/08/2022 02.58, Qu Wenruo wrote:
>>
>>
>> On 2022/8/3 08:29, me@jse.io wrote:
>>> Hey there,
> [...]
>>>
>>> That seems worse than the corruption itself that can't be repaired due
>>> to no CSUMs, and is by far worse than MD.
>>
>> The problem for NOCOW file is, it also implies NOCSUM, and even we can
>> detect mismatches in copies, it only really helps limited profiles like
>> RAID1C3, RAID1C4, and maybe RAID56.
>>
>> The problem here is, for 2 mirrors profiles, even if we can detect the
>> mismatch, we have no idea which is correct.
>>
>> We rely on csum to determine which copy is correct, but NOCOW/NOCSUM
>> makes it very hard to do.
>>
>> For RAID1C3/C4 we can go democracy, but for RAID1C4 it's also possible
>> that we got two different content from all the mirrors.
>
> The same is true for all the "even" redundancy. I.e. even for raid6
> you can have two different matches: one with P and one with Q.
>
> Anyway I think that the point of 'me' is to not have two different
> data depending by the read path. To this, it is preferable to have alway=
s
> the same data, even if it is wrong.
>
> What does scrub when it works on a raid4c (or raid 5/6) with a nocow
> data and each block is different ?

The current scrub only read the data, furthermore current scrub only
cares the device it's scrubbing, thus unless hit a read error or csum
mismatch, it won't even try the remaining copies.

Thus for NOCSUM data, as long as it can be read, scrub won't bother it.

Thanks,
Qu
>
> If this can "solve" the problem of 'me' we could discuss to refine
> the logic to skip only under the conditions "full stripe" **and**
> "cow data".
>
> This is a problem that we need to discuss even with a
> full journal (where still have the option to skip a full stripe).
>
> BR
> G.Baroncelli
>
>>
>> If we really want to solve the NOCOW/NOCSUM problem, I guess full
>> journal is the only solution, and I'm pretty sure we will go that
>> direction anyway (after the write-intent part get merged, as the full
>> journal still relies on a lot of things from write-intent code).
>>
>>>
>>> This is especially worrisome since a number of distros and userspace
>>> tools and distros these days are defaulting to using the NOCOW
>>> attribute for common applications. ie. Arch and mySQL, or libvirt.
>>>
>>> Is there any way this could be used for these purposes as well, in
>>> addition to the stated purpose for RAID5/6?
>>
>> For now, the plan for future development on write-intent only includes:
>>
>> - For degraded mount
>> - As basis for later full journal implement.
>>
>> For your concern, it's in fact not related to write-intent, but in scru=
b
>> code.
>>
>> In that part, I have some plan to rework the scrub interface completely=
,
>> and with the rework, it will have the ability to detect content
>> difference between mirrors, even without csum.
>>
>> But that would take a longer time, and the main purpose is to improve
>> the RAID56 scrub perf, not really the problem you mentioned.
>>
>> Thanks,
>> Qu
>>
>>>
>>> On Mon, Jul 25, 2022 at 2:38 AM Qu Wenruo <wqu@suse.com> wrote:
>>>>
>>>> [CHANGELOG]
>>>> v2->v1:
>>>> - Add mount time recovery functionality
>>>> =C2=A0=C2=A0 Now if a dirty bitmap is found, we will do proper recove=
ry at mount
>>>> =C2=A0=C2=A0 time.
>>>>
>>>> =C2=A0=C2=A0 The code is using scrub routine to do the proper recover=
y for both
>>>> =C2=A0=C2=A0 data and P/Q parity.
>>>>
>>>> =C2=A0=C2=A0 Currently we can only test this by manually setting up a=
 dirty
>>>> bitmap,
>>>> =C2=A0=C2=A0 and corrupt the full stripe, then mounting it and verify=
 the full
>>>> =C2=A0=C2=A0 stripe using "btrfs check --check-data-csum"
>>>>
>>>> - Skip full stripe writes
>>>> =C2=A0=C2=A0 Full stripe writes are either:
>>>> =C2=A0=C2=A0 * New writes into unallocated space
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 After powerloss, we won't read any data from=
 the full stripe.
>>>>
>>>> =C2=A0=C2=A0 * Writes into NODATACOW ranges
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 We won't have csum for them anyway, thus new=
 way to do any
>>>> recovery.
>>>>
>>>> - Fix a memory leakage caused by RO mount
>>>> =C2=A0=C2=A0 Previously we only cleanup the write-intent ctrl if it's=
 RW mount,
>>>> =C2=A0=C2=A0 thus for RO mount we will cause memory leak.
>>>>
>>>>
>>>> RFC->v1:
>>>> - Fix a corner case in write_intent_set_bits()
>>>> =C2=A0=C2=A0 If the range covers the last existing entry, but still n=
eeds a new
>>>> =C2=A0=C2=A0 entry, the old code will not insert the new entry, causi=
ng
>>>> =C2=A0=C2=A0 write_intent_clear_bits() to cause a warning.
>>>>
>>>> - Add selftests for the write intent bitmaps
>>>> =C2=A0=C2=A0 The write intent bitmaps is an sparse array of bitmaps.
>>>> =C2=A0=C2=A0 There are some corner cases tricky to get it done correc=
tly in the
>>>> =C2=A0=C2=A0 first try (see above case).
>>>> =C2=A0=C2=A0 The test case would prevent such problems from happening=
 again.
>>>>
>>>> - Fix hang with dev-replace, and better bitmaps bio submission
>>>> =C2=A0=C2=A0 Previously we will hold device_list_mutex while submitti=
ng the
>>>> bitmaps
>>>> =C2=A0=C2=A0 bio, this can lead to deadlock with dev-replace/dev-remo=
val.
>>>> =C2=A0=C2=A0 Fix it by using RCU to keep an local copy of devices and=
 use them
>>>> =C2=A0=C2=A0 to submit the bitmaps bio.
>>>>
>>>> =C2=A0=C2=A0 Furthermore, there is no need to follow the way of super=
blocks
>>>> =C2=A0=C2=A0 writeback, as the content of bitmaps are always the same=
 for all
>>>> =C2=A0=C2=A0 devices, we can just submitting the same page and use at=
omic counter
>>>> =C2=A0=C2=A0 to wait for them to finish.
>>>>
>>>> =C2=A0=C2=A0 Now there is no more crash/warning/deadlock in btrfs/070=
.
>>>>
>>>> [BACKGROUND]
>>>> Unlike md-raid, btrfs RAID56 has nothing to sync its devices when pow=
er
>>>> loss happens.
>>>>
>>>> For pure mirror based profiles it's fine as btrfs can utilize its csu=
ms
>>>> to find the correct mirror the repair the bad ones.
>>>>
>>>> But for RAID56, the repair itself needs the data from other devices,
>>>> thus any out-of-sync data can degrade the tolerance.
>>>>
>>>> Even worse, incorrect RMW can use the stale data to generate P/Q,
>>>> removing the possibility of recovery the data.
>>>>
>>>>
>>>> For md-raid, it goes with write-intent bitmap, to do faster resilver,
>>>> and goes journal (partial parity log for RAID5) to ensure it can even
>>>> stand a powerloss + device lose.
>>>>
>>>> [OBJECTIVE]
>>>>
>>>> This patchset will introduce a btrfs specific write-intent bitmap.
>>>>
>>>> The bitmap will locate at physical offset 1MiB of each device, and th=
e
>>>> content is the same between all devices.
>>>>
>>>> When there is a RAID56 write (currently all RAID56 write, including
>>>> full
>>>> stripe write), before submitting all the real bios to disks,
>>>> write-intent bitmap will be updated and flushed to all writeable
>>>> devices.
>>>>
>>>> So even if a powerloss happened, at the next mount time we know which
>>>> full stripes needs to check, and can start a scrub for those involved
>>>> logical bytenr ranges.
>>>>
>>>> [ADVANTAGE OF BTRFS SPECIFIC WRITE-INTENT BITMAPS]
>>>>
>>>> Since btrfs can utilize csum for its metadata and CoWed data, unlike
>>>> dm-bitmap which can only be used for faster re-silver, we can fully
>>>> rebuild the full stripe, as long as:
>>>>
>>>> 1) There is no missing device
>>>> =C2=A0=C2=A0=C2=A0 For missing device case, we still need to go full =
journal.
>>>>
>>>> 2) Untouched data stays untouched
>>>> =C2=A0=C2=A0=C2=A0 This should be mostly sane for sane hardware.
>>>>
>>>> And since the btrfs specific write-intent bitmaps are pretty small
>>>> (4KiB
>>>> in size), the overhead much lower than full journal.
>>>>
>>>> In the future, we may allow users to choose between just bitmaps or
>>>> full
>>>> journal to meet their requirement.
>>>>
>>>> [BITMAPS DESIGN]
>>>>
>>>> The bitmaps on-disk format looks like this:
>>>>
>>>> =C2=A0 [ super ][ entry 1 ][ entry 2 ] ... [entry N]
>>>> =C2=A0 |<---------=C2=A0 super::size (4K) ------------->|
>>>>
>>>> Super block contains how many entires are in use.
>>>>
>>>> Each entry is 128 bits (16 bytes) in size, containing one u64 for
>>>> bytenr, and u64 for one bitmap.
>>>>
>>>> And all utilized entries will be sorted in their bytenr order, and no
>>>> bit can overlap.
>>>>
>>>> The blocksize is now fixed to BTRFS_STRIPE_LEN (64KiB), so each entry
>>>> can contain at most 4MiB, and the whole bitmaps can contain 224
>>>> entries.
>>>>
>>>> For the worst case, it can contain 14MiB dirty ranges.
>>>> (1 bits set per bitmap, also means 2 disks RAID5 or 3 disks RAID6).
>>>>
>>>> For the best case, it can contain 896MiB dirty ranges.
>>>> (all bits set per bitmap)
>>>>
>>>> [WHY NOT BTRFS BTREE]
>>>>
>>>> Current write-intent structure needs two features:
>>>>
>>>> - Its data needs to survive cross stripe boundary
>>>> =C2=A0=C2=A0 Normally this means write-intent btree needs to acts lik=
e a proper
>>>> =C2=A0=C2=A0 tree root, has METADATA_ITEMs for all its tree blocks.
>>>>
>>>> - Its data update must be outside of a transaction
>>>> =C2=A0=C2=A0 Currently only log tree can do such thing.
>>>> =C2=A0=C2=A0 But unfortunately log tree can not survive across transa=
ction
>>>> =C2=A0=C2=A0 boundary.
>>>>
>>>> Thus write-intent btree can only meet one of the requirement, not a
>>>> suitable solution here.
>>>>
>>>> [TESTING AND BENCHMARK]
>>>>
>>>> For performance benchmark, unfortunately I don't have 3 HDDs to test.
>>>> Will do the benchmark after secured enough hardware.
>>>>
>>>> For testing, it can survive volume/raid/dev-replace test groups, and =
no
>>>> write-intent bitmap leakage.
>>>>
>>>> Unfortunately there is still a warning triggered in btrfs/070, still
>>>> under investigation, hopefully to be a false alert in bitmap clearing
>>>> path.
>>>>
>>>> [TODO]
>>>> - Extra optimizations
>>>> =C2=A0=C2=A0 * Enlarge the window between btrfs_write_intent_mark_dir=
ty() and
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 btrfs_write_intent_writeback()
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 So that we can merge more dirty bites and ca=
use less bitmaps
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 writeback
>>>>
>>>> - Proper performance benchmark
>>>> =C2=A0=C2=A0 Needs hardware/baremetal VMs, since I don't have any phy=
sical
>>>> machine
>>>> =C2=A0=C2=A0 large enough to contian 3 3.5" HDDs.
>>>>
>>>>
>>>> Qu Wenruo (14):
>>>> =C2=A0=C2=A0 btrfs: introduce new compat RO flag, EXTRA_SUPER_RESERVE=
D
>>>> =C2=A0=C2=A0 btrfs: introduce a new experimental compat RO flag,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 WRITE_INTENT_BITMAP
>>>> =C2=A0=C2=A0 btrfs: introduce the on-disk format of btrfs write inten=
t bitmaps
>>>> =C2=A0=C2=A0 btrfs: load/create write-intent bitmaps at mount time
>>>> =C2=A0=C2=A0 btrfs: write-intent: write the newly created bitmaps to =
all disks
>>>> =C2=A0=C2=A0 btrfs: write-intent: introduce an internal helper to set=
 bits for a
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 range.
>>>> =C2=A0=C2=A0 btrfs: write-intent: introduce an internal helper to cle=
ar bits
>>>> for a
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 range.
>>>> =C2=A0=C2=A0 btrfs: selftests: add selftests for write-intent bitmaps
>>>> =C2=A0=C2=A0 btrfs: write back write intent bitmap after barrier_all_=
devices()
>>>> =C2=A0=C2=A0 btrfs: update and writeback the write-intent bitmap for =
RAID56
>>>> write.
>>>> =C2=A0=C2=A0 btrfs: raid56: clear write-intent bimaps when a full str=
ipe
>>>> finishes.
>>>> =C2=A0=C2=A0 btrfs: warn and clear bitmaps if there is dirty bitmap a=
t mount time
>>>> =C2=A0=C2=A0 btrfs: avoid recording full stripe write into write-inte=
nt bitmaps
>>>> =C2=A0=C2=A0 btrfs: scrub the full stripe which had sub-stripe write =
at mount
>>>> time
>>>>
>>>> =C2=A0 fs/btrfs/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 5 +-
>>>> =C2=A0 fs/btrfs/ctree.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 26 +-
>>>> =C2=A0 fs/btrfs/disk-io.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 58 +-
>>>> =C2=A0 fs/btrfs/raid56.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 27 +
>>>> =C2=A0 fs/btrfs/scrub.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 177 +++-
>>>> =C2=A0 fs/btrfs/sysfs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
>>>> =C2=A0 fs/btrfs/tests/btrfs-tests.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 =
+
>>>> =C2=A0 fs/btrfs/tests/btrfs-tests.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 =
+
>>>> =C2=A0 fs/btrfs/tests/write-intent-bitmaps-tests.c | 247 ++++++
>>>> =C2=A0 fs/btrfs/volumes.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 34 +-
>>>> =C2=A0 fs/btrfs/write-intent.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 923
>>>> ++++++++++++++++++++
>>>> =C2=A0 fs/btrfs/write-intent.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 303 +++++++
>>>> =C2=A0 fs/btrfs/zoned.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +
>>>> =C2=A0 include/uapi/linux/btrfs.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 17 +
>>>> =C2=A0 14 files changed, 1812 insertions(+), 21 deletions(-)
>>>> =C2=A0 create mode 100644 fs/btrfs/tests/write-intent-bitmaps-tests.c
>>>> =C2=A0 create mode 100644 fs/btrfs/write-intent.c
>>>> =C2=A0 create mode 100644 fs/btrfs/write-intent.h
>>>>
>>>> --
>>>> 2.37.0
>>>>
>
