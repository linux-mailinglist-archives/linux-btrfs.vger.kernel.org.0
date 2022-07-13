Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC292573FE3
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jul 2022 01:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiGMXBG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 19:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiGMXBD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 19:01:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588592A727
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 16:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657753253;
        bh=VGOyoAu/daaeXMoJYrSLla+qO7w9o06wsTukILWYRdM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=aIbxBpa5m9LEAg7ge4HUWUb8s4K3Yat/pHr7B0N+bJD2bpwJMBbxCdQCAQUhqmrb/
         wUQmyaCgA/B/DF74wqVPGqOjVVVyNNxNsNHQQkJmOVUNAEngq/8TELtf6u77/tjHuz
         jndBShHI/63mvNPcRb6DlsuqtuiFUUr46fJfQ4/s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N17YY-1nR6ju1gHi-012Vea; Thu, 14
 Jul 2022 01:00:53 +0200
Message-ID: <3bd5ca3a-5e7a-7b48-6cd9-c97a80c85f50@gmx.com>
Date:   Thu, 14 Jul 2022 07:00:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 00/12] btrfs: introduce write-intent bitmaps for RAID56
Content-Language: en-US
To:     Lukas Straub <lukasstraub2@web.de>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.cz>
References: <cover.1657171615.git.wqu@suse.com>
 <20220713161835.63ad1b00@gecko>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220713161835.63ad1b00@gecko>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0U5kO7Fh8BRnpriyeRLzw7pd30StN8xl2PMUJI0t264j2YvStY6
 qB70CkUVw4JjloDm991q6D69Ovh8AmVx8pgAibHafz2yj117+FXi2esca89dhPgyiFAbcs+
 ATp1ONlIsPEoDcL4MhciGr94hHvOzE1rbkCEzVoTzw53p3Arov8tVUCvtCIU2SCrnibBh2s
 ioZrTQg+X+gYcthREgJtQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9vBDE5/0rlo=:hztxmxFtWSDJivyqT1bfn4
 SJaAoS2bf5/DuVO4E6rzeOry9wzif9kOJMsgx9h41Qf9CCvcrei+a8hBrxOoMcrcfedClb+4o
 EnMcdlz4yZvlC7RihACf02JKsOWovygCE+NKpG+gFOJ/Ahd3edsIoeRmUDbM67cT1bFraVhRi
 WW5UO87PRwBCFJp9Mq6eHqEtkBo+OuESPqrIKgXdhrKAbNRp4fSrPjKdYi6ZWwXLETDO/07Gl
 5zb1Ety2odci7G50uQPaWMbRQ2UiJ5/1U4SZ32VK+GrYoq91JEJU5ZTF2X8u7E0pb1cqrXiLQ
 tvg6GQUuD4WDp6Ci8qDmlA+MgK7MianWoNvPgtuLZZh/gE58kBh6t3Uul5sp4gbmTa0MJvEt3
 o9MHWw4X0gFBqd2NBlYYuA2jDafhm6/Nr/XjUSZYR+ZfgcfHk3UpPTvpbL/2eP6rPftxvaLQz
 ttNDr5BGmyiFOW/z5fO/xhNgz2wvR57AqaUZOByDxhd7ZvAMF3N8VGru8nQQ4r0xM2Qe+BjlZ
 YJWu+/wWtfRnV5rJg9e46dKhWn/dsB63+Pekb4ndqqUCP2rQf/MjHv91oDhj0HvFTvlpnWTJD
 fHw43OFqbWyMMwdVbqo8ofOU1j0qKl7fKB75REhpTLLkc4vRKiFyLa3QSOGwqI1Q8v5K4NM/2
 +DBBypkousDN0Ii1smuoI032qWumRXNnskLCT3RPUxNtbAVAAgm4rSU8Vhlte6l/b3l/9x6pE
 vuc3pRofK7gduM7cyWKbRx4dacdPadtT+CR7FFquoccxQYo43H3id4rrxIFvoLbTvOey9en57
 WLc/rPQTJiLlw9Bic3VdOuxw8FdzUCaUZ+HyYamI3JRVFkOI8to775On/PWdGpdgO8NQGotQc
 cjYuZPk/24/Otl0dz10fVnQ3SkgaZAiycR0NK2cGbGXL056j1QWyEcL2GwvxfxwBRpqNbatx1
 FWr2+gc8gvUqo4GrPzxax5/coB9644zPYIn21Z6jybdYfW+3dYH1mNyZXm1KHc0Hnan7JjV0O
 TFopOMtcPrdToPXOj7IW3uHnltGsQlINxhCLGuNHaHyILX+FncVQCiEJIYpkn8vhIJHq0Fa8E
 s3axeGM7QXFYZaEmI64mDE/e3ZM757dCVMEi2hoD5j79jiCKbmTrzmKyA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/14 00:18, Lukas Straub wrote:
> Hello Qu,
>
> I think I mentioned it elsewhere, but could this be made general to all
> raid levels (e.g. raid1/10 too)? This way, the bitmap can also be used
> to fix the corruption of nocow files on btrfs raid. IMHO this is very
> important since openSUSE and Fedora use nocow for certain files
> (databases, vm images) by default and currently anyone using btrfs raid
> there will be shot in the foot by this.

Yes, that's in the future plan.

Although currently we're still at the discussion stage to make sure
which way we should really go (RST or write-intent).
>
> More comments below.
>
> On Thu,  7 Jul 2022 13:32:25 +0800
> Qu Wenruo <wqu@suse.com>
>> [...]
>> [OBJECTIVE]
>>
>> This patchset will introduce a btrfs specific write-intent bitmap.
>>
>> The bitmap will locate at physical offset 1MiB of each device, and the
>> content is the same between all devices.
>>
>> When there is a RAID56 write (currently all RAID56 write, _including fu=
ll
>> stripe write_), before submitting all the real bios to disks,
>> write-intent bitmap will be updated and flushed to all writeable
>> devices.
>
> You'll need to update the bitmap even with full stripe writes. I don't
> know btrfs internals well, but this example should apply:
>
> 1. Powerloss happens during a full stripe write. If the bitmap wasn't se=
t,
> the whole stripe will contain inconsistent data:

That's why btrfs COW shines.

If we are doing full stripe writes and power loss, that full stripe data
won't be read at at mount at all.

All metadata will point back to old data, thus only partial writes
matter here.

Thanks,
Qu
>
> 	0		32K		64K
> Disk 1	|iiiiiiiiiiiiiiiiiiiiiiiiiiiiiii| (data stripe)
> Disk 2  |iiiiiiiiiiiiiiiiiiiiiiiiiiiiiii| (data stripe)
> Disk 3	|iiiiiiiiiiiiiiiiiiiiiiiiiiiiiii| (parity stripe)
>
> 2. Partial stripe write happens, only updates one data + parity:
>
> 	0		32K		64K
> Disk 1	|XXiiiiiiiiiiiiiiiiiiiiiiiiiiiii| (data stripe)
> Disk 2  |iiiiiiiiiiiiiiiiiiiiiiiiiiiiiii| (data stripe)
> Disk 3	|XXiiiiiiiiiiiiiiiiiiiiiiiiiiiii| (parity stripe)
>
> 3. We loose Disk 1. We try to recover Disk 1 data by using Disk 2 data
> + parity. Because Disk 2 is inconsistent we get invalid data.
>
> Thus, we need to scrub the stripe even after a full stripe write to
> prevent this.
>
>> So even if a powerloss happened, at the next mount time we know which
>> full stripes needs to check, and can start a scrub for those involved
>> logical bytenr ranges.
>>
>> [...]
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
> IMHO we can go much larger, mdraid for example uses a blocksize of
> 64MiB by default. Sure, we'll scrub many unrelated stripes on recovery
> but write performance will be better.
>
> Regards,
> Lukas Straub
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
>>      So that we can merge more dirty bites and cause less bitmaps
>>      writeback
>>
>> - Proper performance benchmark
>>    Needs hardware/baremetal VMs, since I don't have any physical machin=
e
>>    large enough to contian 3 3.5" HDDs.
>>
>>
>> Qu Wenruo (12):
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
>>
>>   fs/btrfs/Makefile                           |   5 +-
>>   fs/btrfs/ctree.h                            |  24 +-
>>   fs/btrfs/disk-io.c                          |  54 ++
>>   fs/btrfs/raid56.c                           |  16 +
>>   fs/btrfs/sysfs.c                            |   2 +
>>   fs/btrfs/tests/btrfs-tests.c                |   4 +
>>   fs/btrfs/tests/btrfs-tests.h                |   2 +
>>   fs/btrfs/tests/write-intent-bitmaps-tests.c | 247 ++++++
>>   fs/btrfs/volumes.c                          |  34 +-
>>   fs/btrfs/write-intent.c                     | 903 +++++++++++++++++++=
+
>>   fs/btrfs/write-intent.h                     | 303 +++++++
>>   fs/btrfs/zoned.c                            |   8 +
>>   include/uapi/linux/btrfs.h                  |  17 +
>>   13 files changed, 1610 insertions(+), 9 deletions(-)
>>   create mode 100644 fs/btrfs/tests/write-intent-bitmaps-tests.c
>>   create mode 100644 fs/btrfs/write-intent.c
>>   create mode 100644 fs/btrfs/write-intent.h
>>
>
>
>
