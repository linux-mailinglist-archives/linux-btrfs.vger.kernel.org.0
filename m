Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B2256974D
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jul 2022 03:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbiGGBOn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jul 2022 21:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbiGGBOm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Jul 2022 21:14:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9062E68A
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jul 2022 18:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657156471;
        bh=8LM/QAicIKokoVUPaSKxgEsdklwnw8M2+ZQnO9OrjQo=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Y4X3j5mm6KbIEzJw7MJyMuPDMgNnDRygkVE+7N4LeMaCeD0s0dEM07VQ3RW4+Th7b
         e/tgStZm5O+qF8R0rihPj/K1CaAbF0A0+oAD1fn9G17AP8wje1DbsYorSWZmVPc4Ia
         8iy1gcKmUe3P4TWU74hCN8ojnqjZFk3nZIl1uOzs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MYNNo-1o4K7Z00lG-00VO0e; Thu, 07
 Jul 2022 03:14:31 +0200
Message-ID: <d80eb281-6aae-0dbe-5ed5-277087c9ce91@gmx.com>
Date:   Thu, 7 Jul 2022 09:14:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH RFC 00/11] btrfs: introduce write-intent bitmaps for
 RAID56
Content-Language: en-US
To:     Wang Yugui <wangyugui@e16-tech.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1657004556.git.wqu@suse.com>
 <20220707073652.D696.409509F4@e16-tech.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220707073652.D696.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oaPkCnEHo/l3oB8wNp1yzVYNr45VMzUczunnspY+Ojj7foDXOdi
 jOpbCCZ/7h7pM9RQqr9uUxN+fnV+H4K7HHvqfhs+B348YBTKEQPOK013edsGqNQUQrOLtoy
 1fnicu11Zw4NaQ8wLKkxid2dghjyAdrFXjgBeWEStM1Ec3aWJH4a6Wz9Tr6wRkElvgYS4Zp
 +jJny4hTl6fVmYSrQ394g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lDaFz2PCZTo=:dPsntOBG1taCM4I5CRMu/m
 GsCZw/7E13kdvoyyJvx/zlHff5EOt+OcbLQ2/v2LN9bffD7GmDjX95fbPAPC/eNUOIP6tfg8t
 /MnigkWFwpN6jA1Hgs0ZVQ7F1pe6B/na+ZoNTBS01rJhrMhA0G1ubu/nKImSTwRvNbBnkWPjJ
 edUe31g5jPhWtbl6B0Logh7eiQN1bU+6rBMcumBbdLJaPPjqPX6yaiIk8F9sCITlGtnyjg25b
 QKt7zjuEv9BLw6zQKA0CR40VB/6eBuW+B0MqlbISyLke+yxL+iOFb53+KQmnxAmJfWmsv1E1N
 KJKFi20poxCGcut7CK/tm1kp3VnE5DmqAQqGRERiSQQ3aewj9VaHw7Ip/YUdxb3d3yW6BL/HM
 OrosUCFPKX/IIvczRYRrTBZ6Px3WCUzJ3u1RxSB3XSpQTfCsXZbXFYKAelkNxti40pbNRohBe
 xuGlTgiy89uAywmjzOxej2IdSBxjGSd/srZ13zzUuYUofkB8JacMQoPHCVHTNVEM0/lPwdE/C
 or0c0lmM7ICiDgvgwvqOLh5GYJg0kH9QMSRjxmFMKrCdIFAlpj8CUJAMUQIqc/+IRRhGyufcN
 0645PzEj6vW8nxvONRpzok6AiaVfrYaUlAv0YRA8q+CI5qiSDHhKlJHgrNK5OYQ5gabXNh0h7
 AuvWpay6kfDzs8YNdxIYIKJhLSCr31TE3mOke9LgxDbyc19W3eifNx1dj8m21zCrxCKVEXWzS
 l7L4fRHyzKJCbcGPKK1EFHjampu0g4Ae9a3zPh9EosrpO+apWB27hG+FEVzeDwjBzVyHo6UY+
 Tw5Ufc1gdMj/QMEyGEvdvsbwNW8NyXr9EtMKrivAMvjRdpm+eddLL02kruB8MWQxvcRlIAjSS
 nPkaEfy9KdhBvW5pwc9uhaF9hrorq7LELKvRKpNRzc+NuBaljzd74C8Mh4UxToWXPjTUC3Eeu
 OmpGmoXaT+Tjv2sT1360VRc/RcA02ErdVO7M6NFlLu0bNFNoYPz6NrLHM7rzof0jCQOBxSFb2
 OXSHKHFA1nqphKZ+bxk99vRr4u3gphMyZue/VLISJpNvM9S5cGnI8vLXk7u/dHBWOdA01+X9L
 WTRMiedON8FlS63+VF7FJIGOulgt7Lm6loUT0VGqk6KbdPzVFTTZiZNnA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/7 07:36, Wang Yugui wrote:
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
>
> Is there a case that write-intent bitmap log is rotated?
>
> For hardware raid of broadcom/LSI,  once a disk is unpluged,
> the whole disk will be rebuild after this disk  is plugged again.

There is a plan in the future, adding a new flag,
WRITE_INTENT_TARGET_DEGRADED, to record such new writes after a degraded
rw operation.

But that would be something with lower priority, like after full journal.

Thanks,
Qu

>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/07/07
>
>
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
