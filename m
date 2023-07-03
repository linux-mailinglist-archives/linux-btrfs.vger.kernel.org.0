Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F647465CA
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jul 2023 00:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjGCWkk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jul 2023 18:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGCWkj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jul 2023 18:40:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CA8E5F
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 15:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1688424034; x=1689028834; i=quwenruo.btrfs@gmx.com;
 bh=RyoMksD1jKU/GHR9iuxMkQLzz/EUQpHCLIncpcleva8=;
 h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
 b=qOeACq5n60/JtOlj6JxD3bTRGuFc8K2FMydbt1eMy2cP9TfttvtUJyhmdvWr63fkFI/56WU
 Al8Vr+BB53o+I3yszjz7wSmR2QcTSGrULCQgs8lTiEmXyvq9aKsxIlHqkAzvjmVYQIj2GF0SD
 IeQ1St1AHOjGYEDESQ7ckK1EEqyEaDzOm/5xv8xlbdCH/ZRE7itbkp+8QxYyxm9AzpHM5jzzJ
 ZVpGFPp8L5IekVkfkecQ/2kxMXPRys72WA3SiQqZXX6dKqG5Ty3rsx1BaSbrVQAQtPoFqaKzc
 stbV3fEjE5jUz93hoPUO3f9WD8RATggNwEhhxRFb8NAr1U/VRnug==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M8hZJ-1qKb5f0XAX-004oLl; Tue, 04
 Jul 2023 00:40:34 +0200
Message-ID: <03b37264-dc70-43c6-e526-5f0baca09182@gmx.com>
Date:   Tue, 4 Jul 2023 06:40:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To:     Graham Cobb <g.btrfs@cobb.uk.net>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1688368617.git.wqu@suse.com>
 <fda86f3c-528c-9cd6-6228-d0278a73f138@cobb.uk.net>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 00/14] btrfs: scrub: introduce SCRUB_LOGICAL flag
In-Reply-To: <fda86f3c-528c-9cd6-6228-d0278a73f138@cobb.uk.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C2r8COLQoIRqB8F/aBvoGMGODgg5HSAnmuxxtRjvqgRL7cirlbR
 zbAGRS2ZSO/Ne9jHzfQ1GQPxmsRPMapWQuK6yAyv1HHziqnvgC3dK5BammbAGBotPrl+Ps9
 SgjiPCFcv63eU8AzP/gkh+EoVKC7ckD9jRtKNdm6xo7kkAnEn4sp8oV45U5sHn6YHnwKDVh
 QS94ioTX9W3C32aXFlLtg==
UI-OutboundReport: notjunk:1;M01:P0:pz8LFcTv0L4=;DyVOAip+lwbqGyT1ni1U5HvtOSK
 QgTZIAKtkbeoybl3u/4G6AU0t+/xmEazyQVgPOLzcGY7OtwVkbLIZWpLf2p8uTApgy3gqE+P3
 7pnM8exSV1a2bS3DU63vrlU25F3U/X/+3JzWCNZQnu6g9nU/G3jde7SQ2/11zkRt0/VlL4FjP
 Dy6j/jMIiWCeuDz1Djf2S0KByuzj73lq2EAgWKvUl0e0o+BBPILymZsR+TCXzDmFiHQ/kZxku
 ZHSrK5nbS2mc6rMwKUuQAp3bWUXtnGd9WuJTodsdlMSq7K3d1WxMxcUPGWFsKt0ujnHu893A0
 svsYeAO1Gat4xGUQ6cbh+XtQHZeUwv6uKNONUcZQeQDBli++dMipmDypdmhmIBuKSrHl3L6hM
 sUouhMQUc7xsm7MAGw+xx7oFowzfnoLjAI3pc7ljFBbVDY0M1VTVkAy8Do4bF4yrrvaV+X4wE
 4qNILeWBNs0RiHyQS2Th2D20EOdXzW4CQp/USlxjCAWaP60p++HiGk/NipORZ67ZpqaDpVpp6
 6xwuBr5YfgoyBaKyUNvKEObU0q+FVVIouTsseKSjiGCAbBNDw7ax/piG6y4aWLfWwfXc2bGlC
 uzWPTx0v+Nxr8FBdCfbj5MvxQmW42eydbCuueaUOCPIMvL76v5WzdO2vNfSdu5vasnsF96b/I
 ELheWcBEQSMPzU4fEwbZ87LKZD6UaIQCvtNk1KuIDHC2RqXokjBpuHmNpe5F+bGoEmoiP2RS8
 ZGC7bbzutN4gcWDnA65/3HYtQQFODA2znxx9LPJsjXxDecTvm7jcEc25kROFVcr5eSnFgN1p0
 4PaBfF4EbjN4INxrEGvzN7jAxSNJ3Cz1J/oRisoCadrz6pqzeBiWNHQqJ1i9HuqjaIufAvxmW
 zvr+sX19DVK3AEMqX03Habnet4FDjSH+7iOstkyztb/3KM4JefMXWQ8CGUPUdiUX0elIQfejx
 hVjAzZZdC65d4zh5jt4IajALUgE=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/3 20:58, Graham Cobb wrote:
> On 03/07/2023 08:32, Qu Wenruo wrote:
>> [CHANGELOG]
>> RFC->v1:
>> - Add RAID56 support
>>    Which is the biggest advantage of the new scrub mode.
>>
>> - More basic tests around various repair situations
>>
>> [REPO]
>> Please fetch from github repo:
>> https://github.com/adam900710/linux/tree/scrub_logical
>>
>> This is based on David's misc-next, but still has one extra regression
>> fix which is not yet merged. ("btrfs: raid56: always verify the P/Q
>> contents for scrub")
>>
>> [BACKGROUND]
>> Scrub originally works in a per-device basis, that means if we want to
>> scrub the full fs, we would queue a scrub for each writeable device.
>>
>> This is normally fine, but some behavior is not ideal like the
>> following:
>> 		X	X+16K	X+32K
>>   Mirror 1	|XXXXXXX|       |
>>   Mirror 2	|       |XXXXXXX|
>>
>> When scrubbing mirror 1, we found [X, X+16K) has corruption, then we
>> will try to read from mirror 2 and repair using the correct data.
>>
>> This applies to range [X+16K, X+32K) of mirror 2, causing the good copy
>> to be read twice, which may or may not be a big deal.
>>
>> But the problem can easily go crazy for RAID56, as its repair requires
>> the full stripe to be read out, so is its P/Q verification, e.g.:
>>
>> 		X	X+16K	X+32K
>>   Data stripe 1	|XXXXXXX|       |	|	|
>>   Data stripe 2	|       |XXXXXXX|	|	|
>>   Parity stripe	|       |	|XXXXXXX|	|
>>
>> In above case, if we're scrubbing all mirrors, we would read the same
>> contents again and again:
>>
>> Scrub on mirror 1:
>> - Read data stripe 1 for the initial read.
>> - Read data stripes 1 + 2 + parity for the rebuild.
>>
>> Scrub on mirror 2:
>> - Read data stripe 2 for the initial read.
>> - Read data stripes 1 + 2 + parity for the rebuild.
>>
>> Scrub on Parity
>> - Read data stripes 1 + 2 for the data stripes verification
>> - Read data stripes 1 + 2 + parity for the data rebuild
>>    This step is already improved by recent optimization to use cached
>>    stripes.
>> - Read the parity stripe for the final verification
>>
>> So for data stripes, they are read *five* times, and *three* times for
>> parity stripes.
>>
>> [ENHANCEMENT]
>> Instead of the existing per-device scrub, this patchset introduce a new
>> flag, SCRUB_LOGICAL, to do logical address space based scrub.
>>
>> Unlike per-device scrub, this new flag would make scrub a per-fs
>> operation.
>>
>> This allows us to scrub the different mirrors in one go, and avoid
>> unnecessary read to repair the corruption.
>>
>> This means, no matter what profile, they always read the same data just
>> once.
>>
>> This also makes user space handling much simpler, just one ioctl to
>> scrub the full fs, without the current multi-thread scrub code.
>
> I have a comment on terminology. If I understand correctly, this flag
> changes scrub from an operation performed in parallel on all devices, to
> one done sequentially, with less parallelism.

It depends.

There are several different factors affecting the concurrency even for
the mentioned cases.

Like the race of different devices for the dev-extent and csum tree lookup=
.

In fact for nr_devices > mirrors (aka, RAID1*, DUP, SINGLE) profiles,
the difference scrub pace can lead to more problems like too many block
group mark RO.

For this situation it's really hard to say the impact, but I'm
optimistic on the performance, and it would be finally determine by real
world benchmark.

Please remember that, the worst case profiles are mostly only utilized
by metadata, while for data it's way more common to go RAID0/RAID10 or
even RAID5/6 for adventurous users, which the new interface is way
better for those profiles.

>
> The original code scrubs every device at the same time. In very rough
> terms, for a filesystem with more devices than copies, the duration for
> a scrub with no errors is the time taken to read every block on the most
> occupied device. Other disks will finish earlier.
>
> In the same case, the new code will take the time taken to read one
> block from every file (not just those on the most occupied disk). It is
> not clear to me how much parallelism will occur in this case.
>
> I am not saying it isn't worth doing, but that it may be best to explain
> it in terms of parallel vs. sequential rather than physical vs. logical.
> Certainly in making the user documentation, and scrub command line,
> clear to the user and possibly even in the naming of the flag (e.g.
> SCRUB_SEQUENTIAL instead of SCRUB_LOGICAL).
>
>>
>> [TODO]
>> - More testing
>>    Currently only done functional tests, no stress tests yet.
>>
>> - Better progs integration
>>    In theory we can silently try SCRUB_LOGICAL first, if the kernel
>>    doesn't support it, then fallback to the old multi-device scrub.
>
> Maybe not if my understanding is correct. On filesystems with more disks
> than copies the new code may take noticeably longer?

Not really.

I'd like to have some real world benchmark for these cases instead.

Thanks,
Qu

>
> Or do I misunderstand?
>
> Graham
>
>>
>>    But for current testing, a dedicated option is still assigned for
>>    scrub subcommand.
>>
>>    And currently it only supports full report, no summary nor scrub fil=
e
>>    support.
>>
>> Qu Wenruo (14):
>>    btrfs: raid56: remove unnecessary parameter for
>>      raid56_parity_alloc_scrub_rbio()
>>    btrfs: raid56: allow scrub operation to update both P and Q stripes
>>    btrfs: raid56: allow caching P/Q stripes
>>    btrfs: raid56: add the interfaces to submit recovery rbio
>>    btrfs: add the ability to read P/Q stripes directly
>>    btrfs: scrub: make scrub_ctx::stripes dynamically allocated
>>    btrfs: scrub: introduce the skeleton for logical-scrub
>>    btrfs: scrub: extract the common preparation before scrubbing a bloc=
k
>>      group
>>    btrfs: scrub: implement the chunk iteration code for scrub_logical
>>    btrfs: scrub: implement the basic extent iteration code
>>    btrfs: scrub: implement the repair part of scrub logical
>>    btrfs: scrub: add RAID56 support for queue_scrub_logical_stripes()
>>    btrfs: scrub: introduce the RAID56 data recovery path for scrub
>>      logical
>>    btrfs: scrub: implement the RAID56 P/Q scrub code
>>
>>   fs/btrfs/disk-io.c         |    1 +
>>   fs/btrfs/fs.h              |   12 +
>>   fs/btrfs/ioctl.c           |    6 +-
>>   fs/btrfs/raid56.c          |  134 +++-
>>   fs/btrfs/raid56.h          |   17 +-
>>   fs/btrfs/scrub.c           | 1198 ++++++++++++++++++++++++++++++-----=
-
>>   fs/btrfs/scrub.h           |    2 +
>>   fs/btrfs/volumes.c         |   50 +-
>>   fs/btrfs/volumes.h         |   16 +
>>   include/uapi/linux/btrfs.h |   11 +-
>>   10 files changed, 1206 insertions(+), 241 deletions(-)
>>
>
