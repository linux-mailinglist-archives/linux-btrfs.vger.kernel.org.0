Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9353A30140A
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Jan 2021 09:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbhAWIxR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Jan 2021 03:53:17 -0500
Received: from mout.gmx.net ([212.227.15.15]:53645 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbhAWIxM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Jan 2021 03:53:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611391895;
        bh=oWdBs9kQ5rt3sgzGXX+n2sTn93ElLUl6jHCV3kZQ05Y=;
        h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
        b=hVBVzWIx+22JNJyYSNTdQbFx0B6YDXntru30+2r+FS5xBvcG9WMl4grl0BcpUm2sS
         4dAWDUy7hPwVRGxLFQmi3F5dYATNZiy7LqiWNr3Abtv1ec+38g3UYsXZKtUlMRSr6r
         zCQnPwmUJGOyhF6mzY2IEgmzlJlzn22ojMJCsD5c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M8QWA-1l7eUA1fIO-004Tim; Sat, 23
 Jan 2021 09:51:35 +0100
Subject: Re: Unexpected reflink/subvol snapshot behaviour
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Dave Chinner <david@fromorbit.com>, linux-btrfs@vger.kernel.org
References: <20210121222051.GB4626@dread.disaster.area>
 <58c9d792-5af4-7b54-2072-77230658e677@gmx.com>
Message-ID: <8a93c304-36fd-5ef9-bb82-1ff6762a6afa@gmx.com>
Date:   Sat, 23 Jan 2021 16:51:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <58c9d792-5af4-7b54-2072-77230658e677@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tvx/sJan9LZRJ5+s7MeBVAnZi5AGbRCvxrJ8mP29DnxUE1DmNu3
 /siiZf06ZXPgT69MJ0HmCnBZzslcdiiF82kp1QTkyV1rEzoOjPPrM4IiIu8L1L9sQ36bmLs
 xG5zwv1eLwSUFJMncQG7wKRagAFDY5nmEcvFT59qrdD02sXdElEOiaVaQeLl8KW6S5L5n+P
 uJaGykPDGQ4G+ANBZj5eg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:AlaPjFwFTC8=:uIgLqwubpq8Pcyb51UEbSk
 y95nbw99BL4FN7TBMXqyog1O/dV9onowmxAd9hDuSVgaHnAUHHFSfmAKkdJorquxShCif5gOW
 CIVWRNFUYvCWDN3TtZIJkq2DZOANzmc586hNSUz+jTFu20+ptM9kFBFpo6/msaqvTqNZ7IMWN
 UKd8v4QnfheIc+ec1QMcjAtbO7B5diXHZC3kpEyi7YV80EvwfjdYp5Cu2GTfUPBSOW0a0O2CS
 B24KFOVEpN9QSnThq7GsSLrmGDHJ1NNLw+k4RIx4VM9rDnCpR9hDst9w22lLywdLKywiSJSy1
 xBQJ0XMppw/yrgjKwN46KxRmeZY2+htUJlTWXO9jA9CheyJxIuv527VZf1KR2u4l0i9lPz63d
 +FeNAimBcr6edPqwyAdekF9i/U7hZSv0LiViiGpO6h8H8k2+rExNKgy3kGVuXEt36ZAO6BdXs
 Rf8Fm7MJQ4MrxlsEBTuG0pKe0BHemQhZNq8YanIacHTXCkj5TJcvszmRgyJwDGUl5G5+5kJ5J
 sqpTvDsNKZWtW+FOBuyRYmXMMV+cxYisPauFY3PKzNSlpLMuYE9Wt2uiLoAqwXcWzafl38ucD
 mUHFYG2bGoFyMZwPi8ZnJdzuLWRIqWeOb7jPommj9fcmQdXTIF/2r5eNX6xrXLHxN8t4an6iU
 bd/tQ4wkpN9oiwNymcwysburpza25PbJ6ercIRHTVx+/7KTycIM3PEJSfTPJ2U9121O75cUmj
 RsmixI4QlFqvtjQ/2hlsWLhUUF3kgf+FfixdGC2623LPEUWAJPNcSEtNnKHwc5+6RSH4HHgb+
 XqJvVU3NDFBd5mnbg0jaG/q6bMwqdi9/FcQ+t5C9avmjdpRVcIBfAT68zw28BVsWU59os0xQO
 ir5jPkNPteVkrxHI7Vtg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/23 =E4=B8=8B=E5=8D=884:42, Qu Wenruo wrote:
>
>
> On 2021/1/22 =E4=B8=8A=E5=8D=886:20, Dave Chinner wrote:
>> Hi btrfs-gurus,
>>
>> I'm running a simple reflink/snapshot/COW scalability test at the
>> moment. It is just a loop that does "fio overwrite of 10,000 4kB
>> random direct IOs in a 4GB file; snapshot" and I want to check a
>> couple of things I'm seeing with btrfs. fio config file is appended
>> to the email.
>>
>> Firstly, what is the expected "space amplification" of such a
>> workload over 1000 iterations on btrfs? This will write 40GB of user
>> data, and I'm seeing btrfs consume ~220GB of space for the workload
>> regardless of whether I use subvol snapshot or file clones
>> (reflink).=C2=A0 That's a space amplification of ~5.5x (a lot!) so I'm
>> wondering if this is expected or whether there's something else
>> going on. XFS amplification for 1000 iterations using reflink is
>> only 1.4x, so 5.5x seems somewhat excessive to me.
>
> This is mostly due to the way btrfs handles COW and the lazy extent
> freeing behavior.
>
> For btrfs, an extent only get freed when there is no reference on any
> part of it, and
>
> This means, if we have an file which has one 128K file extent written to
> disk, and then write 4K, which will be COWed to another 4K extent, the
> 128K extent is still kept as is, even the no longer referred 4K range is
> still kept there, with extra 4K space usage.
>
> This not only increase the space usage, but also increase metadata usage=
.
> But reduce the complexity on extent tree and snapshot creation.
>
>
> For the worst case, btrfs can allocate a 128 MiB file extent, and have
> good luck to write 127MiB into the extent. It will take 127MiB + 128MiB
> space, until the last 1MiB of the original extent get freed, the full
> 128MiB can be freed.
>
>
> Thus above reflink/snapshot + DIO write is going to be very unfriendly
> for fs with lazy extent freeing and default data COW behavior.
>
> That's also why btrfs has a worse fragmentation problem.
>
>>
>> On a similar note, the IO bandwidth consumed by btrfs is way out of
>> proportion with the amount of user data being written. I'm seeing
>> multiple GBs being written by btrfs on every iteration - easily
>> exceeding 5GB of writes per cycle in the later iterations of the
>> test. Given that only 40MB of user data is being written per cycle,
>> there's a write amplification factor of well over 100x ocurring
>> here. In comparison, XFS is writing roughly consistently at 80MB/s
>> to disk over the course of the entire workload, largely because of
>> journal traffic for the transactions run during COW and clone
>> operations.=C2=A0 Is such a huge amount of of IO expected for btrfs in
>> this situation?
>
> That's interesting. Any analyse on the type of bios submitted for the
> device?
>
> My educated guess is, metadata takes most of the space, and due to
> default DUP metadata profile, it get doubled to 5G?
>
>>
>> As a side effect of that IO load, btrfs is driving the machine hard
>> into memory reclaim because the page cache footprint of each
>> writeback cycle. btrfs is dirtying a large number of metadata pages
>> in the page cache (at least 50% of the ram in the machine is dirtied
>> on every snapshot/reflink cycle). Hence when the system needs memory
>> reclaim, it hits large amounts of memory it can't reclaim
>> immediately and things go bad very quickly.=C2=A0 This is causing
>> everything on the machine to stall while btrfs dumps the dirty
>> metadata pages to disk at over 1GB/s and 10,000 IOPS for several
>> seconds. Is this expected behaviour?
>
> This may be caused by above mentioned lazy extent freeing (bookend
> extent) behavior.
>
> Especially when 4K dio is submitted, each 4K write will cause an new
> extent, greatly increasing metadata usage.
>
> For the 10,000 4KiB DIO write inside a 4GiB file, it would easily lead
> to 10,000 extents just in one iteration.
> And with several iteration, the 4GiB file will be so heavily fragmented
> that all extents are just in 4K size. (2^20 extents, which will take
> 100MiB metadata just for one subvol).

To add more, due to the extra metadata usage, the workload increases
memory pressure, forcing btrfs to flush its meatdata back to disk.

While when a btrfs tree block is not yet written to disk, btrfs can skip
the COW for the metadata, just modify it in memory.

But when a tree block is written back to disk, btrfs has to do metadata
COW. This further increase the metadata usage, causing a negative spiral
for more metadata usage.

>
> And since you're also taking snapshot, this means each new extent in
> each subvol will always has its reference there, no way to be freed, and
> cause tons of slowdown just because the amount of metadata.
>
>>
>> Next, subvol snapshot and clone time appears to be scale with the
>> number of snapshots/clones already present. The initial clone/subvol
>> snapshot command take a few milliseconds. At 50 snapshots it take
>> 1.5s. At 200 snapshots it takes 7.5s. At 500 it takes 15s and at
>>> 850 it seems to level off at about 30s a snapshot. There are
>> outliers that take double this time (63s was the longest) and the
>> variation between iterations can be quite substantial. Is this
>> expected scalablity?
>
> The snapshot will make the current subvolume to be fully committed
> before really taking the snapshot.
>
> Considering above metadata overhead, I believe most of the performance
> penalty should come from the metadata writeback, not the snapshot
> creation itself.
>
> If you just create a big subvolume, sync the fs, and try to take as many
> snapshot as you wish, the overhead should be pretty the same as
> snapshotting an empty subvolume.
>
>>
>> On subvol snapshot execution, there appears to be a bug manifesting
>> occasionally and may be one of the reasons for things being so
>> variable. The visible manifestation is that every so often a subvol
>> snapshot takes 0.02s instead of the multiple seconds all the
>> snapshots around it are taking:
>
> That 0.02s the real overhead for snapshot creation.
>
> The short snapshot creation time means those snapshot creation just wait
> for the same transaction to be committed, thus they don't need to wait
> for the full transaction committment, just need to do the snapshot.
>
>
> [...]
>
>> In these instances, fio takes about as long as I would expect the
>> snapshot to have taken to run. Regardless of the cause, something
>> looks to be broken here...
>>
>> An astute reader might also notice that fio performance really drops
>> away quickly as the number of snapshots goes up. Loop 0 is the "no
>> snapshots" performance. By 10 snapshots, performance is half the
>> no-snapshot rate. By 50 snapshots, performance is a quarter of the
>> no-snapshot peroframnce. It levels out around 6-7000 IOPS, which is
>> about 15% of the non-snapshot performance. Is this expected
>> performance degradation as snapshot count increases?
>
> No, this is mostly due to the exploding amount of metadata caused by the
> near-worst case workload.
>
> Yeah, btrfs is pretty bad at handling small dio writes, which can easily
> explode the metadata usage.
>
> Thus for such dio case, we recommend to use preallocated file +
> nodatacow, so that we won't create new extents (unless snapshot is
> involved).
>
>>
>> And before you ask, reflink copies of the fio file rather than
>> subvol snapshots have largely the same performance, IO and
>> behavioural characteristics. The only difference is that clone
>> copying also has a cyclic FIO performance dip (every 3-4 cycles)
>> that corresponds with the system driving hard into memory reclaim
>> during periodic writeback from btrfs.
>>
>> FYI, I've compared btrfs reflink to XFS reflink, too, and XFS fio
>> performance stays largely consistent across all 1000 iterations at
>> around 13-14k +/-2k IOPS. The reflink time also scales linearly with
>> the number of extents in the source file and levels off at about
>> 10-11s per cycle as the extent count in the source file levels off
>> at ~850,000 extents. XFS completes the 1000 iterations of
>> write/clone in about 4 hours, btrfs completels the same part of the
>> workload in about 9 hours.
>>
>> Oh, I almost forget - FIEMAP performance. After the reflink test, I
>> map all the extents in all the cloned files to a) count the extents
>> and b) confirm that the difference between clones is correct (~10000
>> extents not shared with the previous iteration). Pulling the extent
>> maps out of XFS takes about 3s a clone (~850,000 extents), or 30
>> minutes for the whole set when run serialised. btrfs takes 90-100s
>> per clone - after 8 hours it had only managed to map 380 files and
>> was running at 6-7000 read IOPS the entire time. IOWs, it was taking
>> _half a million_ read IOs to map the extents of a single clone that
>> only had a million extents in it. Is it expected that FIEMAP is so
>> slow and IO intensive on cloned files?
>
> Exploding fragments, definitely needs a lot of metadata read, right?
>
>>
>> As there are no performance anomolies or memory reclaim issues with
>> XFS running this workload, I suspect the issues I note above are
>> btrfs issues, not expected behaviour.=C2=A0 I'm not sure what the
>> expected scalability of btrfs file clones and snapshots are though,
>> so I'm interested to hear if these results are expected or not.
>
> I hate to say that, yes, you find the worst scenario workload for btrfs.
>
> 4K dio + snapshot is the best way to explode the already high btrfs
> metadata usage, and exploit the lazy extent reclaim behavior.
>
> But if no snapshot is involved, at least you can limit the damage, a
> 4GiB file can only be at most 1M 4K file extents.
> But with snapshots, there is no upper limit now.
>
> Thanks,
> Qu
>
>>
>> Cheers,
>>
>> Dave.
>>
