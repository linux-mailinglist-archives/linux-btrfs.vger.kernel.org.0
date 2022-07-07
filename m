Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865D856994A
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jul 2022 06:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbiGGE2Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jul 2022 00:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiGGE2V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jul 2022 00:28:21 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B4230546
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jul 2022 21:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657168093;
        bh=69IQEKSFWftd/uTrQP60IHYG81MQYmefT9XvyVTSv6c=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=iC4ECxRtJ+o07gEOTY+0tfYXuANAPXBBvLsZX9U7aflNr/gyOdLp22nW9Xw40p7WO
         vSyofyhOUG63n+ib8mJweYg+XSqEYkcSJk+ykEYZGsDQirtij3YCL71fbpApEeJv1p
         jwENTKNtpohw2Oo0+ySnKVUgv2T/iQuHQtWyVu4M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MfYPY-1ngs7Q46hs-00g3EK; Thu, 07
 Jul 2022 06:28:13 +0200
Message-ID: <ebdc96e3-56f8-37e3-dba1-79622c860e2a@gmx.com>
Date:   Thu, 7 Jul 2022 12:28:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH RFC 00/11] btrfs: introduce write-intent bitmaps for
 RAID56
Content-Language: en-US
To:     Wang Yugui <wangyugui@e16-tech.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1657004556.git.wqu@suse.com>
 <20220707122446.98D1.409509F4@e16-tech.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220707122446.98D1.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/Hc7o481f7N9USMcKN0GZwBd9fkPuDbNkFNcm9R4D2oY8GKO60z
 D5grmkb2u8erHbBMs2mHqWP31jL+5D440U2LGZYqmRLvPKE/Y8M9A7MB8iGZHxRvS0AdFce
 tGIHeIP6iAxHpYp28nAtA+nAKkQvbMnMWi//9zJSerSExSJgTZP1FBhlYqIAQ4oDpwoUjxS
 oTEq2hfa7sFP9h5XKh61A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HvU6HZ4HMgQ=:+bI4kRl2wXi0wR3UM+P7dz
 4fkm4Y+LPtPWazqQvrH3MOYezptBJNV9hLLgLSB+LWHkLFbukWva4zIgxBgdIfWH9u9huTdIj
 AlTYPG8OxwE2BMPaZ2bVflBSsqd1Oa62k8fDgfTfr2m0uV0KD2YWnQD68cgqexmY4fF1Z9X5h
 vVH2mgAJN+lH20rzx9SGvkyMYYJBGhuVhxUiF5YAPgoL74u7225mNNBavcQQPD8tpWM0w7Au9
 8NOatkJd6JLiufkV+2ukZsXnsbYv0IZvJx0OIRgQHYxYy4ENgwlUpDEktDPj768xyoZ1ajO7y
 UGLljA89tJSMDtvixCHwZRewS/e85zvnisya7KzLA1O0ibenQzOLYKHbt36uTLE+ZeTyYMtTC
 U662T3MVdvZzLe7CS1FamY1FhQj6fRpeisoMwY8LhFkfV3IUKBNAT5ydbOSNB6n62QTENT0QT
 tjkQ/2VhfHIw2cQaTIE7QXbltcSat3o8unOBiCqeDJ1ZwuaMV8rPWw400IV4cIqMzXyfn0pmp
 H7NGB3E/pqgOEUfnJ2HCrT6kzOij2Qf18ApDvlPNGRTSc3nCFUM5gIMDkyKyUeH++Imor1ZYn
 9v2lqov8/JqP6/V2/5W+E4FIHszqjwIXR966pusnsiAhjNr8xzD+GdZEpSpKKXpD0D+N/PSK8
 /GgDKzJaFIcDaSTtbx5BT4/yDGc/gVPU4sq74ECsS1RBvlG4/Ywgnmpar/xGJTWBhZMDbMqCJ
 9RkBrYZpgIGShsb90tPvjajbqRyBtVoia1F1yP+rDsyH7Ed6valMXijJtz7285g1KvJ3KbzVb
 nykY/Es6OSPVuOanc4iiIBnJw1I6dLNLYbamZIb1CvcrFxKa5vDpO3gPQn4gRPvYSfBKaubtL
 W5ER7khHjHqfCXn8h2AvtIVDUYZ5GcI7ws5AmOxWX3xWbLqIM3p+hEqTa6AQ1s5DC8N4HPZ2b
 woYUtgsbq2XwUxhKDSankURIxPc3EQhxjpeN+1+LJcOTzn5/O5RsGPuHJtS5/bqYg52MFf61g
 tH5EHqT+QmMZQRiKbGs1HqUjBjZincNRchw9lIwSq7/zvbk+5YGSSGjgJPdCdHhKcyACSq1t3
 bSgqAystYyHfmz4H87y26dVsT6sGrgDKtzUCQjyJqNaKMLylc290S1j/A==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/7 12:24, Wang Yugui wrote:
> Hi,
>
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
>> [NO RECOVERY CODE YET]
>>
>> Unfortunately, this patchset only implements the write-intent bitmap
>> code, the recovery part is still a place holder, as we need some scrub
>> refactor to make it only scrub a logical bytenr range.
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
>
> Can we skip the write-intent bitmap log if we already log it in last N r=
ecords
> (logrotate aware) to improve the write performance?  because HDD sync
> IOPS is very small.

I'm not aware about the logrotate idea you mentioned, mind to explain it
more?

But the overall idea of journal/write-intent bitmaps are, always ensure
there is something recording the full write or the write-intention
before the real IO is submitted.

So I'm afraid such behavior can not be changed much.

Thanks,
Qu

>
> And a bigger blocksize help this case too.
>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/07/07
>
>
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
>> - Scrub refactor to allow us to do proper recovery at mount time
>>    Need to change scrub interface to scrub based on logical bytenr.
>>
>>    This can be a super big work, thus currently we will focus only on
>>    RAID56 new scrub interface for write-intent recovery only.
>>
>> - Extra optimizations
>>    * Skip full stripe writes
>>    * Enlarge the window between btrfs_write_intent_mark_dirty() and
>>      btrfs_write_intent_writeback()
>>
>> - Bug hunts and more fstests runs
>>
>> - Proper performance benchmark
>>    Needs hardware/baremetal VMs, since I don't have any physical machin=
e
>>    large enough to contian 3 3.5" HDDs.
>>
>>
>> Qu Wenruo (11):
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
>>    btrfs: write back write intent bitmap after barrier_all_devices()
>>    btrfs: update and writeback the write-intent bitmap for RAID56 write=
.
>>    btrfs: raid56: clear write-intent bimaps when a full stripe finishes=
.
>>    btrfs: warn and clear bitmaps if there is dirty bitmap at mount time
>>
>>   fs/btrfs/Makefile          |   2 +-
>>   fs/btrfs/ctree.h           |  24 +-
>>   fs/btrfs/disk-io.c         |  54 +++
>>   fs/btrfs/raid56.c          |  16 +
>>   fs/btrfs/sysfs.c           |   2 +
>>   fs/btrfs/volumes.c         |  34 +-
>>   fs/btrfs/write-intent.c    | 962 ++++++++++++++++++++++++++++++++++++=
+
>>   fs/btrfs/write-intent.h    | 288 +++++++++++
>>   fs/btrfs/zoned.c           |   8 +
>>   include/uapi/linux/btrfs.h |  17 +
>>   10 files changed, 1399 insertions(+), 8 deletions(-)
>>   create mode 100644 fs/btrfs/write-intent.c
>>   create mode 100644 fs/btrfs/write-intent.h
>>
>> --
>> 2.36.1
>
>
