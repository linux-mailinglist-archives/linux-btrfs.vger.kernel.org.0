Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF4E30D7F7
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Feb 2021 11:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbhBCKwO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Feb 2021 05:52:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:52742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233670AbhBCKwN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Feb 2021 05:52:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5F9A64DF8
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Feb 2021 10:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612349492;
        bh=iSJYAwWdIKKeBKirL20TEkpfNRBv3TdvJqcQbFqJk5Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aYkBSagl8ZTwe+c/sAm9U8mH0Ae2xeEZzUtnhuyZ5of5pFzAaUXFXdGqIOnQrI/to
         eeeoc7vheHpM1vD+CFOKH9f+/qXYe5bCQbat/2/wb4AkYPSClAc5a9mTjwJT6z2du1
         yI5ZuBc7DjILASab1J4rzfMWFXth6PI/ZiseJYWVPe9dSqQCw05KctgO/FrCiXkMKT
         oboyIIQwFj7uE9eBSNDrwwC53S6EF2W/70MZ7XOJ+0fSImsksLSTxQLOfUz3EllWWT
         LmkOugpRZUTGAQ3pIpoRsjNnsCDo/H7ZEyqif+AbNQCM0t20fjmO2Pcd30lGXNkZMM
         eXpVnHicR/Dyg==
Received: by mail-qk1-f181.google.com with SMTP id a12so22834714qkh.10
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Feb 2021 02:51:31 -0800 (PST)
X-Gm-Message-State: AOAM533wVOooL/7vQhQRdgmqRsXjysB0+sOp3f/LbKF+xlDYRvp0h4rZ
        jfxFUYf+MKjCyz80+rRBpeiEjpIHgVM1VBS/2cw=
X-Google-Smtp-Source: ABdhPJzFE6UVdFvKNBNqakfAB44mWqQkkE/z9DGVF5ooYd8q8izIR2H2Up28duywxk88t1F1nawuJd6M4/cj8H5mzeg=
X-Received: by 2002:a37:bc07:: with SMTP id m7mr1938221qkf.438.1612349490854;
 Wed, 03 Feb 2021 02:51:30 -0800 (PST)
MIME-Version: 1.0
References: <CAL3q7H73JQk=ndXM7NB0iqyL6J60-pUw3O8X_LMRYfO+gKUt4g@mail.gmail.com>
 <20210202210151.4AE7.409509F4@e16-tech.com> <20210202220953.5EA7.409509F4@e16-tech.com>
In-Reply-To: <20210202220953.5EA7.409509F4@e16-tech.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 3 Feb 2021 10:51:19 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5GsZucNBBeTvbtmT5tcrwQi3qA6fOkp3N3uObuuczzCQ@mail.gmail.com>
Message-ID: <CAL3q7H5GsZucNBBeTvbtmT5tcrwQi3qA6fOkp3N3uObuuczzCQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] btrfs: do not block inode logging for so long during
 transaction commit
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 2, 2021 at 2:15 PM Wang Yugui <wangyugui@e16-tech.com> wrote:
>
> Hi, Filipe Manana
>
> There are some dbench(sync mode) result on the same hardware,
> but with different linux kernel
>
> 4.14.200
> Operation      Count    AvgLat    MaxLat
>  ----------------------------------------
>  WriteX        225281     5.163    82.143
>  Flush          32161     2.250    62.669
> Throughput 236.719 MB/sec (sync open)  32 clients  32 procs  max_latency=82.149 ms
>
> 4.19.21
> Operation      Count    AvgLat    MaxLat
>  ----------------------------------------
>  WriteX        118842    10.946   116.345
>  Flush          16506     0.115    44.575
> Throughput 125.973 MB/sec (sync open)  32 clients  32 procs  max_latency=116.390 ms
>
> 4.19.150
>  Operation      Count    AvgLat    MaxLat
>  ----------------------------------------
>  WriteX        144509     9.151   117.353
>  lush          20563     0.128    52.014
> Throughput 153.707 MB/sec (sync open)  32 clients  32 procs  max_latency=117.379 ms
>
> 5.4.91
>  Operation      Count    AvgLat    MaxLat
>  ----------------------------------------
>  WriteX        367033     4.377  1908.724
>  Flush          52037     0.159    39.871
> Throughput 384.554 MB/sec (sync open)  32 clients  32 procs  max_latency=1908.968 ms

Ok, it seems somewhere between 4.19 and 5.4, something made the
latency much worse for you at least.

Is it only when using sync open (O_SYNC, dbench's -s flag), what about
when not using it?

I'll have to look at it, but it will likely take some time.

Thanks.

>
> 5.10.12+patches
> Operation      Count    AvgLat    MaxLat
>  ----------------------------------------
>  WriteX        429696     3.960  2239.973
>  Flush          60771     0.621     6.794
> Throughput 452.385 MB/sec (sync open)  32 clients  32 procs  max_latency=1963.312 ms
>
>
> MaxLat / AvgLat  of WriteX is increased from 82.143/5.163=15.9  to
> 2239.973/3.960=565.6.
>
> For QoS, can we have an option to tune the value of MaxLat / AvgLat  of
> WriteX to less than 100?
>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2021/02/02
>
> > Hi, Filipe Manana
> >
> > > On Tue, Feb 2, 2021 at 5:42 AM Wang Yugui <wangyugui@e16-tech.com> wrote:
> > > >
> > > > Hi, Filipe Manana
> > > >
> > > > The dbench result with these patches is very good. thanks a lot.
> > > >
> > > > This is the dbench(synchronous mode) result , and then a question.
> > > >
> > > > command: dbench -s -t 60 -D /btrfs/ 32
> > > > mount option:ssd,space_cache=v2
> > > > kernel:5.10.12 + patchset 1 + this patchset
> > >
> > > patchset 1 and "this patchset" are the same, did you mean two
> > > different patchsets or just a single patchset?
> >
> > patchset1:
> > btrfs: some performance improvements for dbench alike workloads
> >
> > patchset2:
> > btrfs: more performance improvements for dbench workloads
> > https://patchwork.kernel.org/project/linux-btrfs/list/?series=422801
> >
> > I'm sorroy that I have replayed to the wrong patchset.
> >
> > >
> > > >
> > > > Question:
> > > > for synchronous mode, the result type 1 is perfect?
> > >
> > > What do you mean by perfect? You mean if result 1 is better than result 2?
> >
> > In result 1,  the MaxLat of Flush of dbench synchronous mode is fast as
> > expected, the same level as  kernel 5.4.91.
> >
> > But in result 2, the MaxLat of Flush of dbench synchronous mode is big
> > as write level, but this is synchronous mode, most job should be done
> > already before flush.
> >
> > > > and there is still some minor place about the flush to do for
> > > > the result type2?
> > >
> > > By "minor place" you mean the huge difference I suppose.
> > >
> > > >
> > > >
> > > > result type 1:
> > > >
> > > >  Operation      Count    AvgLat    MaxLat
> > > >  ----------------------------------------
> > > >  NTCreateX     868942     0.028     3.017
> > > >  Close         638536     0.003     0.061
> > > >  Rename         36851     0.663     4.000
> > > >  Unlink        175182     0.399     5.358
> > > >  Qpathinfo     789014     0.014     1.846
> > > >  Qfileinfo     137684     0.002     0.047
> > > >  Qfsinfo       144241     0.004     0.059
> > > >  Sfileinfo      70913     0.008     0.046
> > > >  Find          304554     0.057     1.889
> > > > ** WriteX        429696     3.960  2239.973
> > > >  ReadX        1363356     0.005     0.358
> > > >  LockX           2836     0.004     0.038
> > > >  UnlockX         2836     0.002     0.018
> > > > ** Flush          60771     0.621     6.794
> > > >
> > > > Throughput 452.385 MB/sec (sync open)  32 clients  32 procs  max_latency=1963.312 ms
> > > > + stat -f -c %T /btrfs/
> > > > btrfs
> > > > + uname -r
> > > > 5.10.12-4.el7.x86_64
> > > >
> > > >
> > > > result type 2:
> > > >  Operation      Count    AvgLat    MaxLat
> > > >  ----------------------------------------
> > > >  NTCreateX     888943     0.028     2.679
> > > >  Close         652765     0.002     0.058
> > > >  Rename         37705     0.572     3.962
> > > >  Unlink        179713     0.383     3.983
> > > >  Qpathinfo     806705     0.014     2.294
> > > >  Qfileinfo     140752     0.002     0.125
> > > >  Qfsinfo       147909     0.004     0.049
> > > >  Sfileinfo      72374     0.008     0.104
> > > >  Find          311839     0.058     2.305
> > > > ** WriteX        439656     3.854  1872.109
> > > >  ReadX        1396868     0.005     0.324
> > > >  LockX           2910     0.004     0.026
> > > >  UnlockX         2910     0.002     0.025
> > > > ** Flush          62260     0.750  1659.364
> > > >
> > > > Throughput 461.856 MB/sec (sync open)  32 clients  32 procs  max_latency=1872.118 ms
> > > > + stat -f -c %T /btrfs/
> > > > btrfs
> > > > + uname -r
> > > > 5.10.12-4.el7.x86_64
> > >
> > > I'm not sure what your question is exactly.
> > >
> > > Are both results after applying the same patchset, or are they before
> > > and after applying the patchset, respectively?
> >
> > Both result after applying the same patchset.
> > and both on the same server, same SAS SSD disk.
> > but the result is not stable, and the major diff is MaxLat of Flush.
> >
> > Server:Dell T7610
> > CPU: E5-2660 v2(10core 20threads) x2
> > SSD:TOSHIBA  PX05SMQ040
> > Memory:192G (with ECC)
> >
> >
> > > If they are both with the patchset applied, and you wonder about the
> > > big variation in the "Flush" operations, I am not sure about why it is
> > > so.
> > > Both throughput and max latency are better in result 2.
> > >
> > > It's normal to have variations across dbench runs, I get them too, and
> > > I do several runs (5 or 6) to check things out.
> > >
> > > I don't use virtualization (testing on bare metal), I set the cpu
> > > governor mode to performance (instead of the "powersave" default) and
> > > use a non-debug kernel configuration, because otherwise I get
> > > significant variations in latencies and throughput too (though I never
> > > got a huge difference such as from 6.794 to 1659.364).
> >
> > This is a bare metal(dell T7610).
> > CPU mode is set to performance by BIOS. and I checked it by
> > 'cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor'
> >
> > Maybe I used a SAS ssd, and the queue depth of SAS SSD is 254.
> > smaller than 1023 of a NVMe SSD,but it is still enough for
> > dbench 32 threads?
> >
> >
> > The huge difference of MaxLat of Flush such as from 6.794 to 1659.364 is
> > a problem.
> > It is not easy to re-product both,  mabye easy to reproduce the small
> > one, maybe easy to reproduce the big one.
> >
> >
> > Best Regards
> > Wang Yugui (wangyugui@e16-tech.com)
> > 2021/02/02
> >
>
>
