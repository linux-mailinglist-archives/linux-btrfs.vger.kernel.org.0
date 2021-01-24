Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18637301BFE
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Jan 2021 14:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbhAXNJt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Jan 2021 08:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbhAXNJs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Jan 2021 08:09:48 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90F2C061573
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Jan 2021 05:09:07 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id e17so7724628qto.3
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Jan 2021 05:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=oL01qpGG83bGC3ObY/9iR3WvAlCbbqWFh+BIj6Laryo=;
        b=Y9tEnPsTJ5VElYUmyrtfRZrYF7oMfYcvinT/CNgHSCO4UGexKG6EHazWVDezWVuoSn
         B9xutGclaGWp2WnjCzntSCblbg6PrdxjnEmhzSfS5wCYdWSHGpvICnn5X6YoiBCPqMsl
         4Rs9UstQrgWWVD/ZIZ38D3yWmGxsE9msOE9EkrCKMOQqHpJdJBQ34YqRBTlZTnV18XAs
         9mMT3uNefFrH7ZVOEEk9UubTIz9w0nzgCK4Qud74Orho89lM0JdWCZudGO98/XFwp1Qr
         T1Vh39+MZu8iMJLBtlVlg7r1yqa9O6W4ETEV5/hcMO24U+sg/SRV2X4Iu2G3GwIroh4F
         diQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=oL01qpGG83bGC3ObY/9iR3WvAlCbbqWFh+BIj6Laryo=;
        b=OcETUkKe5F84YetcBzpVjA7bplnExwJikFNh4mTo41uGdDLWrDxUUs/ZWXKucVT6jo
         BNBJUsauNNHb17jHOfJG4N73PAVzwAontwtIdfjyEu2oUHCG1YUIEiXDWEO2g28FE4qy
         ZGbVA9NqJg94eH6QrE9ubBcZckPEdmhqIFi8CQbHVZbdA2VKJ1B7D2WYcFIKAZPecZ2H
         SJUh2Vh3sDl1tQHQ+Xv3KgxrxTMDmpLE1s8YTw33eLmUfWKmxeC3aU4FexMSBwP7Clpw
         n7vlbGZukogkBtL6luDJVaBU4MoK5PcynYwGDOvnk4d6zhYOqc9F2x9NkXzh7bEvgQtX
         /rOg==
X-Gm-Message-State: AOAM530sUGfMJ04Qo0pM5cSslkQ/RDMWt8VlqzxNY3KXHYOOmXH6UHWQ
        +M0DPjk8QSg8U3O9y5Coe+ZlwDRADupvarv/uRg=
X-Google-Smtp-Source: ABdhPJzOM5Eht4EPmDZiqb3XJckLhA+Oex2AF7UozDWaf6POPke9jqxqpnB862OL12mSX6M6QINkJZGH1Kaeek21eJ0=
X-Received: by 2002:ac8:6edd:: with SMTP id f29mr589517qtv.213.1611493746679;
 Sun, 24 Jan 2021 05:09:06 -0800 (PST)
MIME-Version: 1.0
References: <20210121222051.GB4626@dread.disaster.area> <58c9d792-5af4-7b54-2072-77230658e677@gmx.com>
In-Reply-To: <58c9d792-5af4-7b54-2072-77230658e677@gmx.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Sun, 24 Jan 2021 13:08:55 +0000
Message-ID: <CAL3q7H4zpBuLqqR2_JYO2ru40_0x58ouJBYRisdBc-vC4tP34A@mail.gmail.com>
Subject: Re: Unexpected reflink/subvol snapshot behaviour
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 23, 2021 at 8:46 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2021/1/22 =E4=B8=8A=E5=8D=886:20, Dave Chinner wrote:
> > Hi btrfs-gurus,
> >
> > I'm running a simple reflink/snapshot/COW scalability test at the
> > moment. It is just a loop that does "fio overwrite of 10,000 4kB
> > random direct IOs in a 4GB file; snapshot" and I want to check a
> > couple of things I'm seeing with btrfs. fio config file is appended
> > to the email.
> >
> > Firstly, what is the expected "space amplification" of such a
> > workload over 1000 iterations on btrfs? This will write 40GB of user
> > data, and I'm seeing btrfs consume ~220GB of space for the workload
> > regardless of whether I use subvol snapshot or file clones
> > (reflink).  That's a space amplification of ~5.5x (a lot!) so I'm
> > wondering if this is expected or whether there's something else
> > going on. XFS amplification for 1000 iterations using reflink is
> > only 1.4x, so 5.5x seems somewhat excessive to me.
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
> This not only increase the space usage, but also increase metadata usage.
> But reduce the complexity on extent tree and snapshot creation.
>
>
> For the worst case, btrfs can allocate a 128 MiB file extent, and have
> good luck to write 127MiB into the extent. It will take 127MiB + 128MiB
> space, until the last 1MiB of the original extent get freed, the full
> 128MiB can be freed.

That is all true, but it does not apply to Dave's test.
If you look at the fio job, it does direct IO writes, all with a fixed
size of 4K, plus the file they write into was not preallocated
(fallocate=3Dnone).

>
>
> Thus above reflink/snapshot + DIO write is going to be very unfriendly
> for fs with lazy extent freeing and default data COW behavior.
>
> That's also why btrfs has a worse fragmentation problem.
>
> >
> > On a similar note, the IO bandwidth consumed by btrfs is way out of
> > proportion with the amount of user data being written. I'm seeing
> > multiple GBs being written by btrfs on every iteration - easily
> > exceeding 5GB of writes per cycle in the later iterations of the
> > test. Given that only 40MB of user data is being written per cycle,
> > there's a write amplification factor of well over 100x ocurring
> > here. In comparison, XFS is writing roughly consistently at 80MB/s
> > to disk over the course of the entire workload, largely because of
> > journal traffic for the transactions run during COW and clone
> > operations.  Is such a huge amount of of IO expected for btrfs in
> > this situation?
>
> That's interesting. Any analyse on the type of bios submitted for the
> device?
>
> My educated guess is, metadata takes most of the space, and due to
> default DUP metadata profile, it get doubled to 5G?
>
> >
> > As a side effect of that IO load, btrfs is driving the machine hard
> > into memory reclaim because the page cache footprint of each
> > writeback cycle. btrfs is dirtying a large number of metadata pages
> > in the page cache (at least 50% of the ram in the machine is dirtied
> > on every snapshot/reflink cycle). Hence when the system needs memory
> > reclaim, it hits large amounts of memory it can't reclaim
> > immediately and things go bad very quickly.  This is causing
> > everything on the machine to stall while btrfs dumps the dirty
> > metadata pages to disk at over 1GB/s and 10,000 IOPS for several
> > seconds. Is this expected behaviour?
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
>
> And since you're also taking snapshot, this means each new extent in
> each subvol will always has its reference there, no way to be freed, and
> cause tons of slowdown just because the amount of metadata.
>
> >
> > Next, subvol snapshot and clone time appears to be scale with the
> > number of snapshots/clones already present. The initial clone/subvol
> > snapshot command take a few milliseconds. At 50 snapshots it take
> > 1.5s. At 200 snapshots it takes 7.5s. At 500 it takes 15s and at
> >> 850 it seems to level off at about 30s a snapshot. There are
> > outliers that take double this time (63s was the longest) and the
> > variation between iterations can be quite substantial. Is this
> > expected scalablity?
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
> >
> > On subvol snapshot execution, there appears to be a bug manifesting
> > occasionally and may be one of the reasons for things being so
> > variable. The visible manifestation is that every so often a subvol
> > snapshot takes 0.02s instead of the multiple seconds all the
> > snapshots around it are taking:
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
> > In these instances, fio takes about as long as I would expect the
> > snapshot to have taken to run. Regardless of the cause, something
> > looks to be broken here...
> >
> > An astute reader might also notice that fio performance really drops
> > away quickly as the number of snapshots goes up. Loop 0 is the "no
> > snapshots" performance. By 10 snapshots, performance is half the
> > no-snapshot rate. By 50 snapshots, performance is a quarter of the
> > no-snapshot peroframnce. It levels out around 6-7000 IOPS, which is
> > about 15% of the non-snapshot performance. Is this expected
> > performance degradation as snapshot count increases?
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
> >
> > And before you ask, reflink copies of the fio file rather than
> > subvol snapshots have largely the same performance, IO and
> > behavioural characteristics. The only difference is that clone
> > copying also has a cyclic FIO performance dip (every 3-4 cycles)
> > that corresponds with the system driving hard into memory reclaim
> > during periodic writeback from btrfs.
> >
> > FYI, I've compared btrfs reflink to XFS reflink, too, and XFS fio
> > performance stays largely consistent across all 1000 iterations at
> > around 13-14k +/-2k IOPS. The reflink time also scales linearly with
> > the number of extents in the source file and levels off at about
> > 10-11s per cycle as the extent count in the source file levels off
> > at ~850,000 extents. XFS completes the 1000 iterations of
> > write/clone in about 4 hours, btrfs completels the same part of the
> > workload in about 9 hours.
> >
> > Oh, I almost forget - FIEMAP performance. After the reflink test, I
> > map all the extents in all the cloned files to a) count the extents
> > and b) confirm that the difference between clones is correct (~10000
> > extents not shared with the previous iteration). Pulling the extent
> > maps out of XFS takes about 3s a clone (~850,000 extents), or 30
> > minutes for the whole set when run serialised. btrfs takes 90-100s
> > per clone - after 8 hours it had only managed to map 380 files and
> > was running at 6-7000 read IOPS the entire time. IOWs, it was taking
> > _half a million_ read IOs to map the extents of a single clone that
> > only had a million extents in it. Is it expected that FIEMAP is so
> > slow and IO intensive on cloned files?
>
> Exploding fragments, definitely needs a lot of metadata read, right?
>
> >
> > As there are no performance anomolies or memory reclaim issues with
> > XFS running this workload, I suspect the issues I note above are
> > btrfs issues, not expected behaviour.  I'm not sure what the
> > expected scalability of btrfs file clones and snapshots are though,
> > so I'm interested to hear if these results are expected or not.
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
> >
> > Cheers,
> >
> > Dave.
> >



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
