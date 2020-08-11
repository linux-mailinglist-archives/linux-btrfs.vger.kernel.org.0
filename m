Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB42241FC9
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Aug 2020 20:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgHKSfl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Aug 2020 14:35:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:57146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbgHKSfk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Aug 2020 14:35:40 -0400
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B2092076B
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 18:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597170938;
        bh=XtGhE9hF7QNUu7LAM6LIFJGgl4x+xNqpr+p+aE4XMc4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AwdzUsT3zsAQArnUBExPGSKyb0eJi5MgaX1IeuzUSJ8oHyfCUi3kRR7309eXT9yFh
         PkWJr8xBRxtq1M06X1NZmcxGPNBRw6+pilIkydw4pKTqfcrUt2OBAIFJpQYKCQotqu
         buzI7z5+K0nNbSYElCjfsZWDFNmuNSFw0lCuNj0I=
Received: by mail-ua1-f45.google.com with SMTP id q68so3796301uaq.0
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 11:35:38 -0700 (PDT)
X-Gm-Message-State: AOAM531oavlxy+mP4vJ/rVhZkz/CI3PvTSNZn18xPnKrEcH+zOem+vHU
        ktaKJ/zzhcqZClYXazkR/TnQ5TWf88IrEQn5F7w=
X-Google-Smtp-Source: ABdhPJxm4O/bHTvyTTrY4UwWjO16GdfIeybvVUWwZAGNhNP/0ssySvrVjdNhYVCoON4tLdeGaxNEc41vtmPxXVw6dk8=
X-Received: by 2002:a9f:368c:: with SMTP id p12mr22787240uap.135.1597170936773;
 Tue, 11 Aug 2020 11:35:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200811114358.693993-1-fdmanana@kernel.org> <441f3000-e860-2b22-3f0d-3b541bc0f4cf@toxicpanda.com>
In-Reply-To: <441f3000-e860-2b22-3f0d-3b541bc0f4cf@toxicpanda.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 11 Aug 2020 19:35:25 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5Sy_t39xaGPm_5fcwdzvC5gzgsJSFbK+vY0AdV=GZ77A@mail.gmail.com>
Message-ID: <CAL3q7H5Sy_t39xaGPm_5fcwdzvC5gzgsJSFbK+vY0AdV=GZ77A@mail.gmail.com>
Subject: Re: [PATCH 3/3] btrfs: make fast fsyncs wait only for writeback
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 11, 2020 at 7:23 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On 8/11/20 7:43 AM, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Currently regardless of a full or a fast fsync we always wait for ordered
> > extents to complete, and then start logging the inode after that. However
> > for fast fsyncs we can just wait for the writeback to complete, we don't
> > need to wait for the ordered extents to complete since we use the list of
> > modified extents maps to figure out which extents we must log and we can
> > get their checksums directly from the ordered extents that are still in
> > flight, otherwise look them up from the checksums tree.
> >
> > Until commit b5e6c3e170b770 ("btrfs: always wait on ordered extents at
> > fsync time"), for fast fsyncs, we used to start logging without even
> > waiting for the writeback to complete first, we would wait for it to
> > complete after logging, while holding a transaction open, which lead to
> > performance issues when using cgroups and probably for other cases too,
> > as wait for IO while holding a transaction handle should be avoided as
> > much as possible. After that, for fast fsyncs, we started to wait for
> > ordered extents to complete before starting to log, which adds some
> > latency to fsyncs and we even got at least one report about a performance
> > drop which bisected to that particular change:
> >
> > https://lore.kernel.org/linux-btrfs/20181109215148.GF23260@techsingularity.net/
> >
> > This change makes fast fsyncs only wait for writeback to finish before
> > starting to log the inode, instead of waiting for both the writeback to
> > finish and for the ordered extents to complete. This brings back part of
> > the logic we had that extracts checksums from in flight ordered extents,
> > which are not yet in the checksums tree, and making sure transaction
> > commits wait for the completion of ordered extents previously logged
> > (by far most of the time they have already completed by the time a
> > transaction commit starts, resulting in no wait at all), to avoid any
> > data loss if an ordered extent completes after the transaction used to
> > log an inode is committed, followed by a power failure.
> >
> > When there are no other tasks accessing the checksums and the subvolume
> > btrees, the ordered extent completion is pretty fast, typically taking
> > 100 to 200 microseconds only in my observations. However when there are
> > other tasks accessing these btrees, ordered extent completion can take a
> > lot more time due to lock contention on nodes and leaves of these btrees.
> > I've seen cases over 2 milliseconds, which starts to be significant. In
> > particular when we do have concurrent fsyncs against different files there
> > is a lot of contention on the checksums btree, since we have many tasks
> > writing the checksums into the btree and other tasks that already started
> > the logging phase are doing lookups for checksums in the btree.
> >
> > This change also turns all ranged fsyncs into full ranged fsyncs, which
> > is something we already did when not using the NO_HOLES features or when
> > doing a full fsync. This is to guarantee we never miss checksums due to
> > writeback having been triggered only for a part of an extent, and we end
> > up logging the full extent but only checksums for the written range, which
> > results in missing checksums after log replay. Allowing ranged fsyncs to
> > operate again only in the original range, when using the NO_HOLES feature
> > and doing a fast fsync is doable but requires some non trivial changes to
> > the writeback path, which can always be worked on later if needed, but I
> > don't think they are a very common use case.
> >
> > Several tests were performed using fio for different numbers of concurrent
> > jobs, each writing and fsyncing its own file, for both sequential and
> > random file writes. The tests were run on bare metal, no virtualization,
> > on a box with 12 cores (Intel i7-8700), 64Gb of RAM and a NVMe device,
> > with a kernel configuration that is the default of typical distributions
> > (debian in this case), without debug options enabled (kasan, kmemleak,
> > slub debug, debug of page allocations, lock debugging, etc).
> >
> > The following script that calls fio was used:
> >
> >    $ cat test-fsync.sh
> >    #!/bin/bash
> >
> >    DEV=/dev/nvme0n1
> >    MNT=/mnt/btrfs
> >    MOUNT_OPTIONS="-o ssd -o space_cache=v2"
> >    MKFS_OPTIONS="-d single -m single"
> >
> >    if [ $# -ne 5 ]; then
> >      echo "Use $0 NUM_JOBS FILE_SIZE FSYNC_FREQ BLOCK_SIZE [write|randwrite]"
> >      exit 1
> >    fi
> >
> >    NUM_JOBS=$1
> >    FILE_SIZE=$2
> >    FSYNC_FREQ=$3
> >    BLOCK_SIZE=$4
> >    WRITE_MODE=$5
> >
> >    if [ "$WRITE_MODE" != "write" ] && [ "$WRITE_MODE" != "randwrite" ]; then
> >      echo "Invalid WRITE_MODE, must be 'write' or 'randwrite'"
> >      exit 1
> >    fi
> >
> >    cat <<EOF > /tmp/fio-job.ini
> >    [writers]
> >    rw=$WRITE_MODE
> >    fsync=$FSYNC_FREQ
> >    fallocate=none
> >    group_reporting=1
> >    direct=0
> >    bs=$BLOCK_SIZE
> >    ioengine=sync
> >    size=$FILE_SIZE
> >    directory=$MNT
> >    numjobs=$NUM_JOBS
> >    EOF
> >
> >    echo "performance" | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
> >
> >    echo
> >    echo "Using config:"
> >    echo
> >    cat /tmp/fio-job.ini
> >    echo
> >
> >    umount $MNT &> /dev/null
> >    mkfs.btrfs -f $MKFS_OPTIONS $DEV
> >    mount $MOUNT_OPTIONS $DEV $MNT
> >    fio /tmp/fio-job.ini
> >    umount $MNT
> >
> > The results were the following:
> >
> > *************************
> > *** sequential writes ***
> > *************************
> >
> > ==== 1 job, 8GiB file, fsync frequency 1, block size 64KiB ====
> >
> > Before patch:
> >
> > WRITE: bw=36.6MiB/s (38.4MB/s), 36.6MiB/s-36.6MiB/s (38.4MB/s-38.4MB/s), io=8192MiB (8590MB), run=223689-223689msec
> >
> > After patch:
> >
> > WRITE: bw=40.2MiB/s (42.1MB/s), 40.2MiB/s-40.2MiB/s (42.1MB/s-42.1MB/s), io=8192MiB (8590MB), run=203980-203980msec
> > (+9.8%, -8.8% runtime)
> >
> > ==== 2 jobs, 4GiB files, fsync frequency 1, block size 64KiB ====
> >
> > Before patch:
> >
> > WRITE: bw=35.8MiB/s (37.5MB/s), 35.8MiB/s-35.8MiB/s (37.5MB/s-37.5MB/s), io=8192MiB (8590MB), run=228950-228950msec
> >
> > After patch:
> >
> > WRITE: bw=43.5MiB/s (45.6MB/s), 43.5MiB/s-43.5MiB/s (45.6MB/s-45.6MB/s), io=8192MiB (8590MB), run=188272-188272msec
> > (+21.5% throughput, -17.8% runtime)
> >
> > ==== 4 jobs, 2GiB files, fsync frequency 1, block size 64KiB ====
> >
> > Before patch:
> >
> > WRITE: bw=50.1MiB/s (52.6MB/s), 50.1MiB/s-50.1MiB/s (52.6MB/s-52.6MB/s), io=8192MiB (8590MB), run=163446-163446msec
> >
> > After patch:
> >
> > WRITE: bw=64.5MiB/s (67.6MB/s), 64.5MiB/s-64.5MiB/s (67.6MB/s-67.6MB/s), io=8192MiB (8590MB), run=126987-126987msec
> > (+28.7% throughput, -22.3% runtime)
> >
> > ==== 8 jobs, 1GiB files, fsync frequency 1, block size 64KiB ====
> >
> > Before patch:
> >
> > WRITE: bw=64.0MiB/s (68.1MB/s), 64.0MiB/s-64.0MiB/s (68.1MB/s-68.1MB/s), io=8192MiB (8590MB), run=126075-126075msec
> >
> > After patch:
> >
> > WRITE: bw=86.8MiB/s (91.0MB/s), 86.8MiB/s-86.8MiB/s (91.0MB/s-91.0MB/s), io=8192MiB (8590MB), run=94358-94358msec
> > (+35.6% throughput, -25.2% runtime)
> >
> > ==== 16 jobs, 512MiB files, fsync frequency 1, block size 64KiB ====
> >
> > Before patch:
> >
> > WRITE: bw=79.8MiB/s (83.6MB/s), 79.8MiB/s-79.8MiB/s (83.6MB/s-83.6MB/s), io=8192MiB (8590MB), run=102694-102694msec
> >
> > After patch:
> >
> > WRITE: bw=107MiB/s (112MB/s), 107MiB/s-107MiB/s (112MB/s-112MB/s), io=8192MiB (8590MB), run=76446-76446msec
> > (+34.1% throughput, -25.6% runtime)
> >
> > ==== 32 jobs, 512MiB files, fsync frequency 1, block size 64KiB ====
> >
> > Before patch:
> >
> > WRITE: bw=93.2MiB/s (97.7MB/s), 93.2MiB/s-93.2MiB/s (97.7MB/s-97.7MB/s), io=16.0GiB (17.2GB), run=175836-175836msec
> >
> > After patch:
> >
> > WRITE: bw=111MiB/s (117MB/s), 111MiB/s-111MiB/s (117MB/s-117MB/s), io=16.0GiB (17.2GB), run=147001-147001msec
> > (+19.1% throughput, -16.4% runtime)
> >
> > ==== 64 jobs, 512MiB files, fsync frequency 1, block size 64KiB ====
> >
> > Before patch:
> >
> > WRITE: bw=108MiB/s (114MB/s), 108MiB/s-108MiB/s (114MB/s-114MB/s), io=32.0GiB (34.4GB), run=302656-302656msec
> >
> > After patch:
> >
> > WRITE: bw=133MiB/s (140MB/s), 133MiB/s-133MiB/s (140MB/s-140MB/s), io=32.0GiB (34.4GB), run=246003-246003msec
> > (+23.1% throughput, -18.7% runtime)
> >
> > ************************
> > ***   random writes  ***
> > ************************
> >
> > ==== 1 job, 8GiB file, fsync frequency 16, block size 4KiB ====
> >
> > Before patch:
> >
> > WRITE: bw=11.5MiB/s (12.0MB/s), 11.5MiB/s-11.5MiB/s (12.0MB/s-12.0MB/s), io=8192MiB (8590MB), run=714281-714281msec
> >
> > After patch:
> >
> > WRITE: bw=11.6MiB/s (12.2MB/s), 11.6MiB/s-11.6MiB/s (12.2MB/s-12.2MB/s), io=8192MiB (8590MB), run=705959-705959msec
> > (+0.9% throughput, -1.7% runtime)
> >
> > ==== 2 jobs, 4GiB files, fsync frequency 16, block size 4KiB ====
> >
> > Before patch:
> >
> > WRITE: bw=12.8MiB/s (13.5MB/s), 12.8MiB/s-12.8MiB/s (13.5MB/s-13.5MB/s), io=8192MiB (8590MB), run=638101-638101msec
> >
> > After patch:
> >
> > WRITE: bw=13.1MiB/s (13.7MB/s), 13.1MiB/s-13.1MiB/s (13.7MB/s-13.7MB/s), io=8192MiB (8590MB), run=625374-625374msec
> > (+2.3% throughput, -2.0% runtime)
> >
> > ==== 4 jobs, 2GiB files, fsync frequency 16, block size 4KiB ====
> >
> > Before patch:
> >
> > WRITE: bw=15.4MiB/s (16.2MB/s), 15.4MiB/s-15.4MiB/s (16.2MB/s-16.2MB/s), io=8192MiB (8590MB), run=531146-531146msec
> >
> > After patch:
> >
> > WRITE: bw=17.8MiB/s (18.7MB/s), 17.8MiB/s-17.8MiB/s (18.7MB/s-18.7MB/s), io=8192MiB (8590MB), run=460431-460431msec
> > (+15.6% throughput, -13.3% runtime)
> >
> > ==== 8 jobs, 1GiB files, fsync frequency 16, block size 4KiB ====
> >
> > Before patch:
> >
> > WRITE: bw=19.9MiB/s (20.8MB/s), 19.9MiB/s-19.9MiB/s (20.8MB/s-20.8MB/s), io=8192MiB (8590MB), run=412664-412664msec
> >
> > After patch:
> >
> > WRITE: bw=22.2MiB/s (23.3MB/s), 22.2MiB/s-22.2MiB/s (23.3MB/s-23.3MB/s), io=8192MiB (8590MB), run=368589-368589msec
> > (+11.6% throughput, -10.7% runtime)
> >
> > ==== 16 jobs, 512MiB files, fsync frequency 16, block size 4KiB ====
> >
> > Before patch:
> >
> > WRITE: bw=29.3MiB/s (30.7MB/s), 29.3MiB/s-29.3MiB/s (30.7MB/s-30.7MB/s), io=8192MiB (8590MB), run=279924-279924msec
> >
> > After patch:
> >
> > WRITE: bw=30.4MiB/s (31.9MB/s), 30.4MiB/s-30.4MiB/s (31.9MB/s-31.9MB/s), io=8192MiB (8590MB), run=269258-269258msec
> > (+3.8% throughput, -3.8% runtime)
> >
> > ==== 32 jobs, 512MiB files, fsync frequency 16, block size 4KiB ====
> >
> > Before patch:
> >
> > WRITE: bw=36.9MiB/s (38.7MB/s), 36.9MiB/s-36.9MiB/s (38.7MB/s-38.7MB/s), io=16.0GiB (17.2GB), run=443581-443581msec
> >
> > After patch:
> >
> > WRITE: bw=41.6MiB/s (43.6MB/s), 41.6MiB/s-41.6MiB/s (43.6MB/s-43.6MB/s), io=16.0GiB (17.2GB), run=394114-394114msec
> > (+12.7% throughput, -11.2% runtime)
> >
> > ==== 64 jobs, 512MiB files, fsync frequency 16, block size 4KiB ====
> >
> > Before patch:
> >
> > WRITE: bw=45.9MiB/s (48.1MB/s), 45.9MiB/s-45.9MiB/s (48.1MB/s-48.1MB/s), io=32.0GiB (34.4GB), run=714614-714614msec
> >
> > After patch:
> >
> > WRITE: bw=48.8MiB/s (51.1MB/s), 48.8MiB/s-48.8MiB/s (51.1MB/s-51.1MB/s), io=32.0GiB (34.4GB), run=672087-672087msec
> > (+6.3% throughput, -6.0% runtime)
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   fs/btrfs/btrfs_inode.h  |   5 ++
> >   fs/btrfs/file.c         |  97 ++++++++++++++--------
> >   fs/btrfs/ordered-data.c |  59 ++++++++++++++
> >   fs/btrfs/ordered-data.h |  11 +++
> >   fs/btrfs/transaction.c  |  10 +++
> >   fs/btrfs/transaction.h  |   7 ++
> >   fs/btrfs/tree-log.c     | 174 ++++++++++++++++++++++++----------------
> >   fs/btrfs/tree-log.h     |  18 ++++-
> >   8 files changed, 276 insertions(+), 105 deletions(-)
> >
> > diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> > index c47b6c6fea9f..f37785822f1f 100644
> > --- a/fs/btrfs/btrfs_inode.h
> > +++ b/fs/btrfs/btrfs_inode.h
> > @@ -25,6 +25,11 @@ enum {
> >       BTRFS_INODE_DUMMY,
> >       BTRFS_INODE_IN_DEFRAG,
> >       BTRFS_INODE_HAS_ASYNC_EXTENT,
> > +      /*
> > +       * Always set under the vfs's inode lock, otherwise it can cause races
> > +       * during fsync (we start as a fast fsync and then end up in a full
> > +       * fsync racing with ordered extent completion).
> > +       */
> >       BTRFS_INODE_NEEDS_FULL_SYNC,
> >       BTRFS_INODE_COPY_EVERYTHING,
> >       BTRFS_INODE_IN_DELALLOC_LIST,
> > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > index 841c516079a9..372a4fc2e418 100644
> > --- a/fs/btrfs/file.c
> > +++ b/fs/btrfs/file.c
> > @@ -2116,20 +2116,24 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
> >       struct btrfs_trans_handle *trans;
> >       struct btrfs_log_ctx ctx;
> >       int ret = 0, err;
> > +     u64 len;
> > +     bool full_sync;
> >
> >       trace_btrfs_sync_file(file, datasync);
> >
> >       btrfs_init_log_ctx(&ctx, inode);
> >
> >       /*
> > -      * Set the range to full if the NO_HOLES feature is not enabled.
> > -      * This is to avoid missing file extent items representing holes after
> > -      * replaying the log.
> > +      * Always set the range to a full range, otherwise we can get into
> > +      * several problems, from missing file extent items to represent holes
> > +      * when not using the NO_HOLES feature, to log tree corruption due to
> > +      * races between hole detection during logging and completion of ordered
> > +      * extents outside the range, to missing checksums due to ordered extents
> > +      * for which we flushed only a subset of their pages.
> >        */
> > -     if (!btrfs_fs_incompat(fs_info, NO_HOLES)) {
> > -             start = 0;
> > -             end = LLONG_MAX;
> > -     }
> > +     start = 0;
> > +     end = LLONG_MAX;
> > +     len = (u64)LLONG_MAX + 1;
> >
> >       /*
> >        * We write the dirty pages in the range and wait until they complete
> > @@ -2153,19 +2157,12 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
> >       atomic_inc(&root->log_batch);
> >
> >       /*
> > -      * If the inode needs a full sync, make sure we use a full range to
> > -      * avoid log tree corruption, due to hole detection racing with ordered
> > -      * extent completion for adjacent ranges and races between logging and
> > -      * completion of ordered extents for adjancent ranges - both races
> > -      * could lead to file extent items in the log with overlapping ranges.
> > -      * Do this while holding the inode lock, to avoid races with other
> > -      * tasks.
> > +      * Always check for the full sync flag while holding the inode's lock,
> > +      * to avoid races with other tasks. The flag must be either set all the
> > +      * time during logging or always off all the time while logging.
> >        */
> > -     if (test_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
> > -                  &BTRFS_I(inode)->runtime_flags)) {
> > -             start = 0;
> > -             end = LLONG_MAX;
> > -     }
> > +     full_sync = test_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
> > +                          &BTRFS_I(inode)->runtime_flags);
> >
> >       /*
> >        * Before we acquired the inode's lock, someone may have dirtied more
> > @@ -2196,20 +2193,42 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
> >        * We have to do this here to avoid the priority inversion of waiting on
> >        * IO of a lower priority task while holding a transaction open.
> >        *
> > -      * Also, the range length can be represented by u64, we have to do the
> > -      * typecasts to avoid signed overflow if it's [0, LLONG_MAX].
> > +      * For a full fsync we wait for the ordered extents to complete while
> > +      * for a fast fsync we wait just for writeback to complete, and then
> > +      * attach the ordered extents to the transaction so that a transaction
> > +      * commit waits for their completion, to avoid data loss if we fsync,
> > +      * the current transaction commits before the ordered extents complete
> > +      * and a power failure happens right after that.
> >        */
> > -     ret = btrfs_wait_ordered_range(inode, start, (u64)end - (u64)start + 1);
> > -     if (ret) {
> > -             up_write(&BTRFS_I(inode)->dio_sem);
> > -             inode_unlock(inode);
> > -             goto out;
> > +     if (full_sync) {
> > +             ret = btrfs_wait_ordered_range(inode, start, len);
> > +     } else {
> > +             /*
> > +              * Get our ordered extents as soon as possible to avoid doing
> > +              * checksum lookups in the csums btree, and use instead the
> > +              * checksums attached to the ordered extents.
> > +              */
> > +             btrfs_get_ordered_extents_for_logging(BTRFS_I(inode),
> > +                                                   &ctx.ordered_extents);
> > +             ret = filemap_fdatawait_range(inode->i_mapping, start, end);
> >       }
> > +
> > +     if (ret)
> > +             goto out_release_extents;
> > +
> >       atomic_inc(&root->log_batch);
> >
> > +     /*
> > +      * If we are doing a fast fsync we can not bail out if the inode's
> > +      * last_trans is <= then the last committed transaction, because we only
> > +      * update the last_trans of the inode during ordered extent completion,
> > +      * and for a fast fsync we don't wait for that, we only wait for the
> > +      * writeback to complete.
> > +      */
> >       smp_mb();
> >       if (btrfs_inode_in_log(BTRFS_I(inode), fs_info->generation) ||
> > -         BTRFS_I(inode)->last_trans <= fs_info->last_trans_committed) {
> > +         (BTRFS_I(inode)->last_trans <= fs_info->last_trans_committed &&
> > +          (full_sync || list_empty(&ctx.ordered_extents)))) {
> >               /*
> >                * We've had everything committed since the last time we were
> >                * modified so clear this flag in case it was set for whatever
> > @@ -2225,9 +2244,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
> >                * checked called fsync.
> >                */
> >               ret = filemap_check_wb_err(inode->i_mapping, file->f_wb_err);
> > -             up_write(&BTRFS_I(inode)->dio_sem);
> > -             inode_unlock(inode);
> > -             goto out;
> > +             goto out_release_extents;
> >       }
> >
> >       /*
> > @@ -2244,12 +2261,11 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
> >       trans = btrfs_start_transaction(root, 0);
> >       if (IS_ERR(trans)) {
> >               ret = PTR_ERR(trans);
> > -             up_write(&BTRFS_I(inode)->dio_sem);
> > -             inode_unlock(inode);
> > -             goto out;
> > +             goto out_release_extents;
> >       }
> >
> > -     ret = btrfs_log_dentry_safe(trans, dentry, start, end, &ctx);
> > +     ret = btrfs_log_dentry_safe(trans, dentry, &ctx);
> > +     btrfs_release_log_ctx_extents(&ctx);
> >       if (ret < 0) {
> >               /* Fallthrough and commit/free transaction. */
> >               ret = 1;
> > @@ -2276,6 +2292,13 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
> >                               goto out;
> >                       }
> >               }
> > +             if (!full_sync) {
> > +                     ret = btrfs_wait_ordered_range(inode, start, len);
> > +                     if (ret) {
> > +                             btrfs_end_transaction(trans);
> > +                             goto out;
> > +                     }
> > +             }
> >               ret = btrfs_commit_transaction(trans);
> >       } else {
> >               ret = btrfs_end_transaction(trans);
> > @@ -2286,6 +2309,12 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
> >       if (!ret)
> >               ret = err;
> >       return ret > 0 ? -EIO : ret;
> > +
> > +out_release_extents:
> > +     btrfs_release_log_ctx_extents(&ctx);
> > +     up_write(&BTRFS_I(inode)->dio_sem);
> > +     inode_unlock(inode);
> > +     goto out;
> >   }
> >
> >   static const struct vm_operations_struct btrfs_file_vm_ops = {
> > diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> > index ebac13389e7e..4732c5b89460 100644
> > --- a/fs/btrfs/ordered-data.c
> > +++ b/fs/btrfs/ordered-data.c
> > @@ -212,6 +212,7 @@ static int __btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset
> >       refcount_set(&entry->refs, 1);
> >       init_waitqueue_head(&entry->wait);
> >       INIT_LIST_HEAD(&entry->list);
> > +     INIT_LIST_HEAD(&entry->log_list);
> >       INIT_LIST_HEAD(&entry->root_extent_list);
> >       INIT_LIST_HEAD(&entry->work_list);
> >       init_completion(&entry->completion);
> > @@ -445,6 +446,7 @@ void btrfs_put_ordered_extent(struct btrfs_ordered_extent *entry)
> >
> >       if (refcount_dec_and_test(&entry->refs)) {
> >               ASSERT(list_empty(&entry->root_extent_list));
> > +             ASSERT(list_empty(&entry->log_list));
> >               ASSERT(RB_EMPTY_NODE(&entry->rb_node));
> >               if (entry->inode)
> >                       btrfs_add_delayed_iput(entry->inode);
> > @@ -470,6 +472,7 @@ void btrfs_remove_ordered_extent(struct inode *inode,
> >       struct btrfs_inode *btrfs_inode = BTRFS_I(inode);
> >       struct btrfs_root *root = btrfs_inode->root;
> >       struct rb_node *node;
> > +     bool pending;
> >
> >       /* This is paired with btrfs_add_ordered_extent. */
> >       spin_lock(&btrfs_inode->lock);
> > @@ -491,8 +494,36 @@ void btrfs_remove_ordered_extent(struct inode *inode,
> >       if (tree->last == node)
> >               tree->last = NULL;
> >       set_bit(BTRFS_ORDERED_COMPLETE, &entry->flags);
> > +     pending = test_and_clear_bit(BTRFS_ORDERED_PENDING, &entry->flags);
> >       spin_unlock_irq(&tree->lock);
> >
> > +     /*
> > +      * The current running transaction is waiting on us, we need to let it
> > +      * know that we're complete and wake it up.
> > +      */
> > +     if (pending) {
> > +             struct btrfs_transaction *trans;
> > +
> > +             /*
> > +              * The checks for trans are just a formality, it should be set,
> > +              * but if it isn't we don't want to deref/assert under the spin
> > +              * lock, so be nice and check if trans is set, but ASSERT() so
> > +              * if it isn't set a developer will notice.
> > +              */
> > +             spin_lock(&fs_info->trans_lock);
> > +             trans = fs_info->running_transaction;
> > +             if (trans)
> > +                     refcount_inc(&trans->use_count);
> > +             spin_unlock(&fs_info->trans_lock);
> > +
> > +             ASSERT(trans);
> > +             if (trans) {
> > +                     if (atomic_dec_and_test(&trans->pending_ordered))
> > +                             wake_up(&trans->pending_wait);
> > +                     btrfs_put_transaction(trans);
> > +             }
> > +     }
> > +
> >       spin_lock(&root->ordered_extent_lock);
> >       list_del_init(&entry->root_extent_list);
> >       root->nr_ordered_extents--;
> > @@ -774,6 +805,34 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_range(
> >       return entry;
> >   }
> >
> > +/*
> > + * Adds all ordered extents to the given list. The list ends up sorted by the
> > + * file_offset of the ordered extents.
> > + */
> > +void btrfs_get_ordered_extents_for_logging(struct btrfs_inode *inode,
> > +                                        struct list_head *list)
> > +{
> > +     struct btrfs_ordered_inode_tree *tree = &inode->ordered_tree;
> > +     struct rb_node *n;
> > +
> > +     ASSERT(inode_is_locked(&inode->vfs_inode));
> > +
> > +     spin_lock_irq(&tree->lock);
> > +     for (n = rb_first(&tree->tree); n; n = rb_next(n)) {
> > +             struct btrfs_ordered_extent *ordered;
> > +
> > +             ordered = rb_entry(n, struct btrfs_ordered_extent, rb_node);
> > +
> > +             if (test_bit(BTRFS_ORDERED_LOGGED, &ordered->flags))
> > +                     continue;
> > +
> > +             ASSERT(list_empty(&ordered->log_list));
> > +             list_add_tail(&ordered->log_list, list);
> > +             refcount_inc(&ordered->refs);
> > +     }
> > +     spin_unlock_irq(&tree->lock);
> > +}
> > +
> >   /*
> >    * lookup and return any extent before 'file_offset'.  NULL is returned
> >    * if none is found
> > diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
> > index d61ea9c880a3..644258a7dfb1 100644
> > --- a/fs/btrfs/ordered-data.h
> > +++ b/fs/btrfs/ordered-data.h
> > @@ -56,6 +56,12 @@ enum {
> >       BTRFS_ORDERED_TRUNCATED,
> >       /* Regular IO for COW */
> >       BTRFS_ORDERED_REGULAR,
> > +     /* Used during fsync to track already logged extents */
> > +     BTRFS_ORDERED_LOGGED,
> > +     /* We have already logged all the csums of the ordered extent */
> > +     BTRFS_ORDERED_LOGGED_CSUM,
> > +     /* We wait for this extent to complete in the current transaction */
> > +     BTRFS_ORDERED_PENDING,
> >   };
> >
> >   struct btrfs_ordered_extent {
> > @@ -104,6 +110,9 @@ struct btrfs_ordered_extent {
> >       /* list of checksums for insertion when the extent io is done */
> >       struct list_head list;
> >
> > +     /* used for fast fsyncs */
> > +     struct list_head log_list;
> > +
> >       /* used to wait for the BTRFS_ORDERED_COMPLETE bit */
> >       wait_queue_head_t wait;
> >
> > @@ -174,6 +183,8 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_range(
> >               struct btrfs_inode *inode,
> >               u64 file_offset,
> >               u64 len);
> > +void btrfs_get_ordered_extents_for_logging(struct btrfs_inode *inode,
> > +                                        struct list_head *list);
> >   int btrfs_find_ordered_sum(struct inode *inode, u64 offset, u64 disk_bytenr,
> >                          u8 *sum, int len);
> >   u64 btrfs_wait_ordered_extents(struct btrfs_root *root, u64 nr,
> > diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> > index 20c6ac1a5de7..be1cd3a780c1 100644
> > --- a/fs/btrfs/transaction.c
> > +++ b/fs/btrfs/transaction.c
> > @@ -292,6 +292,8 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
> >       }
> >
> >       cur_trans->fs_info = fs_info;
> > +     atomic_set(&cur_trans->pending_ordered, 0);
> > +     init_waitqueue_head(&cur_trans->pending_wait);
> >       atomic_set(&cur_trans->num_writers, 1);
> >       extwriter_counter_init(cur_trans, type);
> >       init_waitqueue_head(&cur_trans->writer_wait);
> > @@ -2164,6 +2166,14 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
> >
> >       btrfs_wait_delalloc_flush(trans);
> >
> > +     /*
> > +      * Wait for all ordered extents started by a fast fsync that joined this
> > +      * transaction. Otherwise if this transaction commits before the ordered
> > +      * extents complete we lose logged data after a power failure.
> > +      */
> > +     wait_event(cur_trans->pending_wait,
> > +                atomic_read(&cur_trans->pending_ordered) == 0);
> > +
>
> This introduces the possiblity of a priority inversion, because now if we have
> some low priority cgroup that's fsyncing a bunch, we have to wait for its IO to
> complete before the transaction is allowed to commit, which is going to screw us
> in production.

Well yes. But we already have that problem elsewhere: log commits are
done while holding a transaction open.
A low priority cgroup that is fsyncing already blocks a transaction commit.

>
> Secondly, we would only lose something if a subsequent transaction committed
> right?  So the current transaction can commit fine, we just get screwed if the
> ordered extents haven't completed in time for the next transaction.  Which is
> definitely possible, just different from what the comment says.  Thanks,

Hum? I think the problem is the current transaction committing.
If we are at transaction N, a fast fsync happens, before the
transaction commits we must make sure it waits for all the ordered
extents to complete - because the commits wipes out the log and writes
a superblock that doesn't point to the log trees anymore (and space
can reused immediately after).

What do you have in mind exactly?

Thanks.

>
> Josef
