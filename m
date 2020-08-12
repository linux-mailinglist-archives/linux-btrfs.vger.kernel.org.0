Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486DA2426B8
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Aug 2020 10:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgHLI3d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Aug 2020 04:29:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:57268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbgHLI3d (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Aug 2020 04:29:33 -0400
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC93420774
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Aug 2020 08:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597220972;
        bh=IpAXmIPfPJ3J3Wm57hPPAOWFXT4kWDE8l5/Cu9uKkRY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dtw0HTfYcc83AAw5HgClJ7Fsg0JMhylitqD7l700pMtX5hP4q6Ex43Df4y9UMs5LL
         4q8x+fvPx5wUYDqLhx1IUc05fxCMxnp0zw2FcqOK/mhQEX4WNPMWnq5rYbHltXiL5P
         s7guPAXiKUZufvCwn3EDEgd0s99xutCpBHqZVRZY=
Received: by mail-vs1-f48.google.com with SMTP id q13so671951vsn.9
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Aug 2020 01:29:32 -0700 (PDT)
X-Gm-Message-State: AOAM530aM2Gc42bvN7ixIqT9VQ3tQmVJdIpqxOl1Tv/v8SO9Vh6on0dd
        EUHWsQg34Hsm0gr7oZFNQGnOztMQczfYG+ZaLH8=
X-Google-Smtp-Source: ABdhPJxRdJ7TyxAMvFNfsRoY3j7hu2l15xSoT9PhkoOC/xNWSrGOIUA12/l5W1FyMwRhA4/w3t4m6utqS5Vk3tzMoBY=
X-Received: by 2002:a05:6102:22ed:: with SMTP id b13mr24473515vsh.206.1597220971822;
 Wed, 12 Aug 2020 01:29:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200811114348.692115-1-fdmanana@kernel.org> <32fd7959-4ea4-6930-74e5-e57c30a51733@toxicpanda.com>
In-Reply-To: <32fd7959-4ea4-6930-74e5-e57c30a51733@toxicpanda.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 12 Aug 2020 09:29:20 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6afZ0DX9o+V=gMZNQEr4ztDOzTstuRbHaT1V1trw8_dw@mail.gmail.com>
Message-ID: <CAL3q7H6afZ0DX9o+V=gMZNQEr4ztDOzTstuRbHaT1V1trw8_dw@mail.gmail.com>
Subject: Re: [PATCH 2/3] btrfs: do not commit logs and transactions during
 link and rename operations
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 11, 2020 at 7:33 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On 8/11/20 7:43 AM, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Since commit d4682ba03ef618 ("Btrfs: sync log after logging new name") we
> > started to commit logs, and fallback to transaction commits when we failed
> > to log the new names or commit the logs, after link and rename operations
> > when the target inodes (or their parents) were previously logged in the
> > current transaction. This was to avoid losing directories despite an
> > explicit fsync on them when they are ancestors of some inode that got a
> > new named logged, due to a link or rename operation. However that adds the
> > cost of starting IO and waiting for it to complete, which can cause higher
> > latencies for applications.
> >
> > Instead of doing that, just make sure that when we log a new name for an
> > inode we don't mark any of its ancestors as logged, so that if any one
> > does an fsync against any of them, without doing any other change on them,
> > the fsync commits the log. This way we only pay the cost of a log commit
> > (or a transaction commit if something goes wrong or a new block group was
> > created) if the application explicitly asks to fsync any of the parent
> > directories.
> >
> > Using dbench, which mixes several filesystems operations including renames,
> > revealed some significant latency gains. The following script that uses
> > dbench was used to test this:
> >
> >    #!/bin/bash
> >
> >    DEV=/dev/nvme0n1
> >    MNT=/mnt/btrfs
> >    MOUNT_OPTIONS="-o ssd -o space_cache=v2"
> >    MKFS_OPTIONS="-m single -d single"
> >    THREADS=16
> >
> >    echo "performance" | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
> >    mkfs.btrfs -f $MKFS_OPTIONS $DEV
> >    mount $MOUNT_OPTIONS $DEV $MNT
> >
> >    dbench -t 300 -D $MNT $THREADS
> >
> >    umount $MNT
> >
> > The test was run on bare metal, no virtualization, on a box with 12 cores
> > (Intel i7-8700), 64Gb of RAM and using a NVMe device, with a kernel
> > configuration that is the default of typical distributions (debian in this
> > case), without debug options enabled (kasan, kmemleak, slub debug, debug
> > of page allocations, lock debugging, etc).
> >
> > Results before this patch:
> >
> >   Operation      Count    AvgLat    MaxLat
> >   ----------------------------------------
> >   NTCreateX    10750455     0.011   155.088
> >   Close        7896674     0.001     0.243
> >   Rename        455222     2.158  1101.947
> >   Unlink       2171189     0.067   121.638
> >   Deltree          256     2.425     7.816
> >   Mkdir            128     0.002     0.003
> >   Qpathinfo    9744323     0.006    21.370
> >   Qfileinfo    1707092     0.001     0.146
> >   Qfsinfo      1786756     0.001    11.228
> >   Sfileinfo     875612     0.003    21.263
> >   Find         3767281     0.025     9.617
> >   WriteX       5356924     0.011   211.390
> >   ReadX        16852694     0.003    9.442
> >   LockX          35008     0.002     0.119
> >   UnlockX        35008     0.001     0.138
> >   Flush         753458     4.252  1102.249
> >
> > Throughput 1128.35 MB/sec  16 clients  16 procs  max_latency=1102.255 ms
> >
> > Results after this patch:
> >
> > 16 clients, after
> >
> >   Operation      Count    AvgLat    MaxLat
> >   ----------------------------------------
> >   NTCreateX    11471098     0.012   448.281
> >   Close        8426396     0.001     0.925
> >   Rename        485746     0.123   267.183
> >   Unlink       2316477     0.080    63.433
> >   Deltree          288     2.830    11.144
> >   Mkdir            144     0.003     0.010
> >   Qpathinfo    10397420     0.006    10.288
> >   Qfileinfo    1822039     0.001     0.169
> >   Qfsinfo      1906497     0.002    14.039
> >   Sfileinfo     934433     0.004     2.438
> >   Find         4019879     0.026    10.200
> >   WriteX       5718932     0.011   200.985
> >   ReadX        17981671     0.003    10.036
> >   LockX          37352     0.002     0.076
> >   UnlockX        37352     0.001     0.109
> >   Flush         804018     5.015   778.033
> >
> > Throughput 1201.98 MB/sec  16 clients  16 procs  max_latency=778.036 ms
> > (+6.5% throughput, -29.4% max latency, -75.8% rename latency)
> >
> > Test case generic/498 from fstests tests the scenario that the previously
> > mentioned commit fixed.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> Man this took me a while to grok, but I think I've got it.  The only thing is
> this patch doesn't apply to current (as of today) misc-next.  Thanks,

It was based on misc-next from last week.
It conflicts with current misc-next due to a trivial patch that fixes
typos and grammar on comments:

https://github.com/kdave/btrfs-devel/commit/f993ba65484d364e30d7aee0293afafadf565f25

I can resend if needed.

Thanks.

>
> Josef
