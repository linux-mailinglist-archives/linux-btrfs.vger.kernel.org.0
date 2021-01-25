Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85DAB301FDA
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jan 2021 02:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbhAYBUY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Jan 2021 20:20:24 -0500
Received: from mout.gmx.net ([212.227.15.18]:44825 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbhAYBTy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Jan 2021 20:19:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611537482;
        bh=Q7kWnsiAnYZXbTHQZdOXALMGjPpp8Jz8VudLwR1GvQY=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=jJ2h/pQnVDtPdpRtDzMUR5sdZRWEHnYrIuXxSP/Bt6GwNCq/4UEspf1VMJUFN6xyx
         PFPCafyZ/+dZnfHJvMwQOUdg1Qd7MUqqPo8PsmZGCPajr04KVVnQBcA0Wqv9e60JIt
         SNalK/0ESE50n7100a32inAsqjh+I/rcxEW0ty9I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MCbEf-1lCOwz1bAh-009lBC; Mon, 25
 Jan 2021 02:09:15 +0100
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20210121222051.GB4626@dread.disaster.area>
 <58c9d792-5af4-7b54-2072-77230658e677@gmx.com>
 <20210124223655.GD4626@dread.disaster.area>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Unexpected reflink/subvol snapshot behaviour
Message-ID: <3adb6e5a-1e7e-f05b-b68a-d65af1d975b4@gmx.com>
Date:   Mon, 25 Jan 2021 09:09:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210124223655.GD4626@dread.disaster.area>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QDERE45azVeUvOYlyF9ywn5ek/mGahq/NYVYKjJuJs5hXY1e0mw
 izjYQwx7Vo7Y4wkjRQYUYVgBlv0C0EkTNfPcE46NCsM1Les6PKsVFCu6c1LIdke9t63YPBi
 LhaQ7cIdcnDATg32dCX3EhAfzQVLrbquJdXm2GX6x3VZ15HcxgQhnNozlpHzgZiYn8OLWoN
 vgfvcSIB80bU5cPPo+gGA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:F1hnYDs4LL4=:jl5puFIqQW9r9ihZamF7gD
 gcYf9pjhptibba1gFaTC3iq/DYdScmaUotwl+YeFuQjS9VKBLLF2c6giefly8vdm8zi2gMo7W
 9s7mYxAb9af1SzIbE8E9e5oNB9ZTYe7/JVThf6+LBOUl2vW5kyIPktUKodHEGKeR4q510Pq8B
 dPPMFC8XZmlASzeqHQaupO9tJHhjR6ZZjruM5omtRyYu9rklFPlI+L1ng1+KhqKtM2Qw1EPX9
 h/y5kXZQBIiFptFWcjI4z/95csXFLLzRgH+gaZdY/mPteN8P2Do7WmK/CVLdAd+Y1K2U2ZTVn
 YoeN8qAU/x998AakL1sfbYwKLLDe6HKLgj6Nkg+jcgEtNc/d2e0/z9crGc8wvCOHgLan6mb0D
 qI+bG+R9vvPxidMlDU14tCC0HTgtuEamjEVTxce9rdPXVmdlFrBtyMf6JpickZIFSV0uh/Rr0
 QxaH0wx8Fe8p+kkhhXOvLtRmB6zYW35eEFicF7T0Om7m3rr0s9BPeLvDNFxQciGmNUZplz9/r
 yuE5mXnLoeBYSBzl5Z39DTMfr1YGhpv2lkPO8qDqxVDJVa/wMzJ/1TR+T95qXs13q1xrM0S55
 +x8pGi0eVE8LEE4tDPdC5xFF9jDI3AVdJTy0kQoX3PPcO+10Y2CTwmCt8DcRAr5hNYZJ4QU6O
 4Lr5OAM0ko/mDScUez2kXC/nZtcV4lCRFsfCG8ilKpwi+ecd6mdUC3ynDTwG8WbptOoaLLHlD
 4/LjoGEj07PTs2ecXhJR/cXsMb9qNjPxcq43aDTy8lHDyso+/Zb4khUcAHCEQIcDWUIc+WRX2
 Ucp/3G4PSHZE4uSpJfHJinL8qlUzhNZ4xujmsDY6tJ5MLG4En6UjSVolPoi8jBvzwUu6qqk51
 aRWRucC97HaScykfDHAg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/25 =E4=B8=8A=E5=8D=886:36, Dave Chinner wrote:
> On Sat, Jan 23, 2021 at 04:42:33PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2021/1/22 =E4=B8=8A=E5=8D=886:20, Dave Chinner wrote:
>>> Hi btrfs-gurus,
>>>
>>> I'm running a simple reflink/snapshot/COW scalability test at the
>>> moment. It is just a loop that does "fio overwrite of 10,000 4kB
>>> random direct IOs in a 4GB file; snapshot" and I want to check a
>>> couple of things I'm seeing with btrfs. fio config file is appended
>>> to the email.
>>>
>>> Firstly, what is the expected "space amplification" of such a
>>> workload over 1000 iterations on btrfs? This will write 40GB of user
>>> data, and I'm seeing btrfs consume ~220GB of space for the workload
>>> regardless of whether I use subvol snapshot or file clones
>>> (reflink).  That's a space amplification of ~5.5x (a lot!) so I'm
>>> wondering if this is expected or whether there's something else
>>> going on. XFS amplification for 1000 iterations using reflink is
>>> only 1.4x, so 5.5x seems somewhat excessive to me.
>>
>> This is mostly due to the way btrfs handles COW and the lazy extent
>> freeing behavior.
>>
>> For btrfs, an extent only get freed when there is no reference on any
>> part of it, and
>>
>> This means, if we have an file which has one 128K file extent written t=
o
>> disk, and then write 4K, which will be COWed to another 4K extent, the
>> 128K extent is still kept as is, even the no longer referred 4K range i=
s
>> still kept there, with extra 4K space usage.
>
> That's not relevant to the workload I'm running. Once it reaches
> steady state, it's just doing 4kB overwrites of shared 4kB extents.
>
>> Thus above reflink/snapshot + DIO write is going to be very unfriendly
>> for fs with lazy extent freeing and default data COW behavior.
>
> I'm not freeing any extents at all. I haven't even got to running
> the parts of the tests where I remove random snapshots/reflink files
> to measure the impact of decreasing reference counts. THis test just
> looks at increasing reference counts and COW overwrite performance.
>
>> That's also why btrfs has a worse fragmentation problem.
>
> Every other filesystem I've tested is fragmenting the reflink files
> to the same level. btrfs is not fragmenting the file any worse than
> the others - the workload is intended to fragment the file into a
> million individual 4kB extents and then keep overwriting and
> snapshotting to examine how the filesystem structures age under such
> workloads.
>
>>> On a similar note, the IO bandwidth consumed by btrfs is way out of
>>> proportion with the amount of user data being written. I'm seeing
>>> multiple GBs being written by btrfs on every iteration - easily
>>> exceeding 5GB of writes per cycle in the later iterations of the
>>> test. Given that only 40MB of user data is being written per cycle,
>>> there's a write amplification factor of well over 100x ocurring
>>> here. In comparison, XFS is writing roughly consistently at 80MB/s
>>> to disk over the course of the entire workload, largely because of
>>> journal traffic for the transactions run during COW and clone
>>> operations.  Is such a huge amount of of IO expected for btrfs in
>>> this situation?
>>
>> That's interesting. Any analyse on the type of bios submitted for the
>> device?
>
> No, and I don't actually care because it's not relevant to what
> I'm trying to understand. I've given you enough information to
> reproduce the behaviour if you want to analyse it yourself.
>
>>> Next, subvol snapshot and clone time appears to be scale with the
>>> number of snapshots/clones already present. The initial clone/subvol
>>> snapshot command take a few milliseconds. At 50 snapshots it take
>>> 1.5s. At 200 snapshots it takes 7.5s. At 500 it takes 15s and at
>>>> 850 it seems to level off at about 30s a snapshot. There are
>>> outliers that take double this time (63s was the longest) and the
>>> variation between iterations can be quite substantial. Is this
>>> expected scalablity?
>>
>> The snapshot will make the current subvolume to be fully committed
>> before really taking the snapshot.
>>
>> Considering above metadata overhead, I believe most of the performance
>> penalty should come from the metadata writeback, not the snapshot
>> creation itself.
>>
>> If you just create a big subvolume, sync the fs, and try to take as man=
y
>> snapshot as you wish, the overhead should be pretty the same as
>> snapshotting an empty subvolume.
>
> The fio workload runs fsync at the end of the overwrite, which means
> all the writes and the metadata needed to reference it *must* be on
> stable storage. Everything else is snapshot overhead, whether it be
> the freeze of the filesystem in the case of dm-thin snapshots or
> xfs-on-loopback-with-reflink-snapshots, of the internal sync that
> btrfs does so that the snapshot produces a consistent snapshot
> image...
>
>>> On subvol snapshot execution, there appears to be a bug manifesting
>>> occasionally and may be one of the reasons for things being so
>>> variable. The visible manifestation is that every so often a subvol
>>> snapshot takes 0.02s instead of the multiple seconds all the
>>> snapshots around it are taking:
>>
>> That 0.02s the real overhead for snapshot creation.
>>
>> The short snapshot creation time means those snapshot creation just wai=
t
>> for the same transaction to be committed, thus they don't need to wait
>> for the full transaction committment, just need to do the snapshot.
>
> That doesn't explain why fio sometimes appears to be running much
> slower than at other times. Maybe this implies a fsync() bug w.r.t.
> DIO overwrites and that btrfs should always be running the fio
> worklaod at 500-1000 iops and snapshots should always run at 0.02s
>
> IOWs, the problem here is the inconsistent behaviour: the workload
> is deterministic and repeats in exactly the same way every time, so
> the behaviour of the filesystem should be the same for every single
> iteration. Snapshot should either always take 0.02s and fio is
> really slow, or fio should be fast and the snapshot really slow
> because the snapshot has wider "metadata on stable storage"
> requirements than fsync. The workload should not be swapping
> randomly between the two behaviours....

That makes sense, although I still wonder if the writeback of large
amount of metadata is involved in this case.

But yes, the behavior is indeed not ideal.

>
>> [...]
>>
>>> In these instances, fio takes about as long as I would expect the
>>> snapshot to have taken to run. Regardless of the cause, something
>>> looks to be broken here...
>>>
>>> An astute reader might also notice that fio performance really drops
>>> away quickly as the number of snapshots goes up. Loop 0 is the "no
>>> snapshots" performance. By 10 snapshots, performance is half the
>>> no-snapshot rate. By 50 snapshots, performance is a quarter of the
>>> no-snapshot peroframnce. It levels out around 6-7000 IOPS, which is
>>> about 15% of the non-snapshot performance. Is this expected
>>> performance degradation as snapshot count increases?
>>
>> No, this is mostly due to the exploding amount of metadata caused by th=
e
>> near-worst case workload.
>>
>> Yeah, btrfs is pretty bad at handling small dio writes, which can easil=
y
>> explode the metadata usage.
>>
>> Thus for such dio case, we recommend to use preallocated file +
>> nodatacow, so that we won't create new extents (unless snapshot is
>> involved).
>
> Big picture. This is an accelerated aging test, not a prodcution
> workload. Telling me how to work around the problems associated with
> 4kB overwrite (as if I don't already know about nodatacow and all
> the functionality you lose by enabling it!) doesn't make the
> problems with increasing snapshot counts that I'm exposing go away.
>
> I'm interesting in knowing how btrfs scales and performs with large
> reflink/snapshot counts - I explicitly chose 4kB DIO overwrite as
> the fastest method of exposing such scalability issues because I
> know exactly how bad this is for the COW algorithms all current
> snapshot/reflink technologies implement.
>
> Please don't shoot the messenger because you think the workload is
> unrealistic - it simply indicates that you haven't understood the
> goal of the test worklaod I am running.

Didn't know that the objective is to emulate the aging problem, then 4K
dio is completely fine, as we also use it to bump metadata size quickly.
(But never to intentionally to create it to such a stage as your test case=
s)

>
> Accelerating aging involves using unfriendly workloads to push the
> filesystem into bad places in minutes instead of months or years.
> It is not a production workload that needs optimising - if anything,
> I need to make it even more aggressive and nasty, because it's just
> not causing XFS reflinks any serious scalability problems at all...
>
>>> Oh, I almost forget - FIEMAP performance. After the reflink test, I
>>> map all the extents in all the cloned files to a) count the extents
>>> and b) confirm that the difference between clones is correct (~10000
>>> extents not shared with the previous iteration). Pulling the extent
>>> maps out of XFS takes about 3s a clone (~850,000 extents), or 30
>>> minutes for the whole set when run serialised. btrfs takes 90-100s
>>> per clone - after 8 hours it had only managed to map 380 files and
>>> was running at 6-7000 read IOPS the entire time. IOWs, it was taking
>>> _half a million_ read IOs to map the extents of a single clone that
>>> only had a million extents in it. Is it expected that FIEMAP is so
>>> slow and IO intensive on cloned files?
>>
>> Exploding fragments, definitely needs a lot of metadata read, right?
>
> Well, at 1000 files, XFS does zero metadata read IO because the
> extent lists for all 1000 snapshots easily fit in RAM - about 2GB of
> RAM is needed, and that's the entire per-inode memory overhead of
> the test. Hence when the fiemap cycle starts, it just pulls all this
> from RAM and we do zero metadata read IO.

Well, you know btrfs takes more metadata space.

Btrfs takes 53 bytes for one file extent, even without the extra header
for tree blocks.

For 4GiB file with all 4KiB extent size, it's 2^20 * 53, at least 106MiB
just for one such 4GiB file.

2GiB RAM can only take at most 20 such files.

Thanks,
Qu

>
> Cheers,
>
> Dave.
>
