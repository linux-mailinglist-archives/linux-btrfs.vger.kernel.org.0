Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF53530190B
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Jan 2021 01:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbhAXATr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Jan 2021 19:19:47 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:40486 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbhAXATq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Jan 2021 19:19:46 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id D43FA951CC3; Sat, 23 Jan 2021 19:19:03 -0500 (EST)
Date:   Sat, 23 Jan 2021 19:19:03 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Unexpected reflink/subvol snapshot behaviour
Message-ID: <20210124001903.GS31381@hungrycats.org>
References: <20210121222051.GB4626@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121222051.GB4626@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 22, 2021 at 09:20:51AM +1100, Dave Chinner wrote:
> Hi btrfs-gurus,
> 
> I'm running a simple reflink/snapshot/COW scalability test at the
> moment. It is just a loop that does "fio overwrite of 10,000 4kB
> random direct IOs in a 4GB file; snapshot" and I want to check a
> couple of things I'm seeing with btrfs. fio config file is appended
> to the email.
> 
> Firstly, what is the expected "space amplification" of such a
> workload over 1000 iterations on btrfs? This will write 40GB of user
> data, and I'm seeing btrfs consume ~220GB of space for the workload
> regardless of whether I use subvol snapshot or file clones
> (reflink).  That's a space amplification of ~5.5x (a lot!) so I'm
> wondering if this is expected or whether there's something else
> going on. XFS amplification for 1000 iterations using reflink is
> only 1.4x, so 5.5x seems somewhat excessive to me.
> 
> On a similar note, the IO bandwidth consumed by btrfs is way out of
> proportion with the amount of user data being written. I'm seeing
> multiple GBs being written by btrfs on every iteration - easily
> exceeding 5GB of writes per cycle in the later iterations of the
> test. Given that only 40MB of user data is being written per cycle,
> there's a write amplification factor of well over 100x ocurring
> here. In comparison, XFS is writing roughly consistently at 80MB/s
> to disk over the course of the entire workload, largely because of
> journal traffic for the transactions run during COW and clone
> operations.  Is such a huge amount of of IO expected for btrfs in
> this situation?
> 
> As a side effect of that IO load, btrfs is driving the machine hard
> into memory reclaim because the page cache footprint of each
> writeback cycle. btrfs is dirtying a large number of metadata pages
> in the page cache (at least 50% of the ram in the machine is dirtied
> on every snapshot/reflink cycle). Hence when the system needs memory
> reclaim, it hits large amounts of memory it can't reclaim
> immediately and things go bad very quickly.  This is causing
> everything on the machine to stall while btrfs dumps the dirty
> metadata pages to disk at over 1GB/s and 10,000 IOPS for several
> seconds. Is this expected behaviour?
> 
> Next, subvol snapshot and clone time appears to be scale with the
> number of snapshots/clones already present. The initial clone/subvol
> snapshot command take a few milliseconds. At 50 snapshots it take
> 1.5s. At 200 snapshots it takes 7.5s. At 500 it takes 15s and at
> >850 it seems to level off at about 30s a snapshot. There are
> outliers that take double this time (63s was the longest) and the
> variation between iterations can be quite substantial. Is this
> expected scalablity?
> 
> On subvol snapshot execution, there appears to be a bug manifesting
> occasionally and may be one of the reasons for things being so
> variable. The visible manifestation is that every so often a subvol
> snapshot takes 0.02s instead of the multiple seconds all the
> snapshots around it are taking:
> 
>  $ grep -C 1 ": 0.0" results/btrfs-snap/2021-01-21-22\:08\:15-1000/snapshot_times | sed 's/://'
>  snapshot 0 0.02
>  snapshot 1 0.06
>  snapshot 2 0.10
>  --
>  snapshot 25 0.77
>  snapshot 26 0.02
>  snapshot 27 0.85
>  --
>  snapshot 51 1.45
>  snapshot 52 0.02
>  snapshot 53 1.51
>  --
>  snapshot 78 2.35
>  snapshot 79 0.03
>  snapshot 80 2.31
>  --
>  snapshot 104 3.22
>  snapshot 105 0.02
>  snapshot 106 3.44
>  --
>  snapshot 130 4.25
>  snapshot 131 0.02
>  snapshot 132 4.53
>  --
>  snapshot 156 5.38
>  snapshot 157 0.02
>  snapshot 158 5.76
>  --
>  snapshot 183 6.17
>  snapshot 184 0.02
>  snapshot 185 6.94
>  --
>  snapshot 209 8.08
>  snapshot 210 0.04
>  snapshot 211 6.91
>  --
>  snapshot 235 8.77
>  snapshot 236 0.02
>  snapshot 237 9.80
>  --
>  snapshot 288 10.91
>  snapshot 289 0.04
>  snapshot 290 9.07
>  --
>  snapshot 314 11.81
>  snapshot 315 0.04
>  snapshot 316 11.74
>  --
>  snapshot 340 11.83
>  snapshot 341 0.05
>  snapshot 342 12.11
>  --
>  snapshot 367 11.95
>  snapshot 368 0.06
>  snapshot 369 11.83
>  --
>  snapshot 393 13.66
>  snapshot 394 0.03
>  snapshot 395 10.98
>  --
>  snapshot 419 14.04
>  snapshot 420 0.04
>  snapshot 421 12.62
>  --
>  snapshot 472 22.10
>  snapshot 473 0.03
>  snapshot 474 14.90
>  --
>  snapshot 498 14.48
>  snapshot 499 0.03
>  snapshot 500 17.46
>  --
>  snapshot 524 20.50
>  snapshot 525 0.04
>  snapshot 526 18.01
>  --
>  snapshot 577 55.81
>  snapshot 578 0.08
>  snapshot 579 34.02
>  --
>  snapshot 603 22.81
>  snapshot 604 0.03
>  snapshot 605 19.26
>  --
>  snapshot 682 30.88
>  snapshot 683 0.02
>  snapshot 684 14.83
>  --
>  snapshot 708 19.90
>  snapshot 709 0.03
>  snapshot 710 15.38
>  --
>  snapshot 761 25.63
>  snapshot 762 0.05
>  snapshot 763 15.58
>  --
>  snapshot 787 15.33
>  snapshot 788 0.03
>  snapshot 789 15.08
>  --
>  snapshot 866 23.77
>  snapshot 867 0.04
>  snapshot 868 27.40
>  --
>  snapshot 892 15.33
>  snapshot 893 0.03
>  snapshot 894 13.38
>  --
>  snapshot 945 15.32
>  snapshot 946 0.05
>  snapshot 947 15.52
>  --
>  snapshot 971 15.30
>  snapshot 972 0.03
>  snapshot 973 14.88
> 
> It seems .... unlikely that random snapshots of exactly the same
> repeating workloadi have such a variance in execution time. And then

btrfs delays a lot of metadata updates (millions, if you have enough
memory) and then runs them in giant batches during commits, so they can
show up as latency spikes at random times while you're benchmarking.
That is likely part of what is happening here.

The current behavior is something of a regression--there used to be a
latency feedback loop to avoid queueing up too many metadata updates
before throttling the processes that were generating the updates.
It's not clear that simply reverting that change is a good way forward.

> I noticed that they exactly correlate with the order of magnitude
> fio performance drops that manifested occasionally:
> 
> $ for i in `grep ": 0.0" results/btrfs-snap/2021-01-21-22\:08\:15-1000/snapshot_times | sed 's/://' |cut -d " " -f 2`; do grep -C 1 " $i:" results/btrfs-snap/2021-01-21-22\:08\:15-1000/fio_times ; echo --- ; done
> fio loop 0:   write: IOPS=43.7k, BW=171MiB/s (179MB/s)(39.1MiB/229msec); 0 zone resets
> fio loop 1:   write: IOPS=30.1k, BW=118MiB/s (123MB/s)(39.1MiB/332msec); 0 zone resets
> ---
> fio loop 0:   write: IOPS=43.7k, BW=171MiB/s (179MB/s)(39.1MiB/229msec); 0 zone resets
> fio loop 1:   write: IOPS=30.1k, BW=118MiB/s (123MB/s)(39.1MiB/332msec); 0 zone resets
> fio loop 2:   write: IOPS=33.7k, BW=132MiB/s (138MB/s)(39.1MiB/297msec); 0 zone resets
> ---
> fio loop 25:   write: IOPS=15.7k, BW=61.3MiB/s (64.3MB/s)(39.1MiB/637msec); 0 zone resets
> fio loop 26:   write: IOPS=5537, BW=21.6MiB/s (22.7MB/s)(39.1MiB/1806msec); 0 zone resets
> fio loop 27:   write: IOPS=15.4k, BW=60.2MiB/s (63.1MB/s)(39.1MiB/649msec); 0 zone resets
> ---
> fio loop 51:   write: IOPS=12.5k, BW=48.0MiB/s (51.3MB/s)(39.1MiB/798msec); 0 zone resets
> fio loop 52:   write: IOPS=3480, BW=13.6MiB/s (14.3MB/s)(39.1MiB/2873msec); 0 zone resets
> fio loop 53:   write: IOPS=9345, BW=36.5MiB/s (38.3MB/s)(39.1MiB/1070msec); 0 zone resets
> ---
> fio loop 78:   write: IOPS=6887, BW=26.9MiB/s (28.2MB/s)(39.1MiB/1452msec); 0 zone resets
> fio loop 79:   write: IOPS=1955, BW=7823KiB/s (8011kB/s)(39.1MiB/5113msec); 0 zone resets
> fio loop 80:   write: IOPS=7751, BW=30.3MiB/s (31.8MB/s)(39.1MiB/1290msec); 0 zone resets
> ---
> fio loop 104:   write: IOPS=8340, BW=32.6MiB/s (34.2MB/s)(39.1MiB/1199msec); 0 zone resets
> fio loop 105:   write: IOPS=1546, BW=6184KiB/s (6333kB/s)(39.1MiB/6468msec); 0 zone resets
> fio loop 106:   write: IOPS=7262, BW=28.4MiB/s (29.7MB/s)(39.1MiB/1377msec); 0 zone resets
> ---
> fio loop 130:   write: IOPS=7788, BW=30.4MiB/s (31.9MB/s)(39.1MiB/1284msec); 0 zone resets
> fio loop 131:   write: IOPS=1268, BW=5074KiB/s (5195kB/s)(39.1MiB/7884msec); 0 zone resets
> fio loop 132:   write: IOPS=6468, BW=25.3MiB/s (26.5MB/s)(39.1MiB/1546msec); 0 zone resets
> ---
> fio loop 156:   write: IOPS=7137, BW=27.9MiB/s (29.2MB/s)(39.1MiB/1401msec); 0 zone resets
> fio loop 157:   write: IOPS=1487, BW=5949KiB/s (6092kB/s)(39.1MiB/6724msec); 0 zone resets
> fio loop 158:   write: IOPS=8904, BW=34.8MiB/s (36.5MB/s)(39.1MiB/1123msec); 0 zone resets
> ---
> fio loop 183:   write: IOPS=6002, BW=23.4MiB/s (24.6MB/s)(39.1MiB/1666msec); 0 zone resets
> fio loop 184:   write: IOPS=936, BW=3746KiB/s (3836kB/s)(39.1MiB/10679msec); 0 zone resets
> fio loop 185:   write: IOPS=7230, BW=28.2MiB/s (29.6MB/s)(39.1MiB/1383msec); 0 zone resets
> ---
> fio loop 209:   write: IOPS=5521, BW=21.6MiB/s (22.6MB/s)(39.1MiB/1811msec); 0 zone resets
> fio loop 210:   write: IOPS=775, BW=3101KiB/s (3175kB/s)(39.1MiB/12899msec); 0 zone resets
> fio loop 211:   write: IOPS=6489, BW=25.3MiB/s (26.6MB/s)(39.1MiB/1541msec); 0 zone resets
> ---
> fio loop 235:   write: IOPS=7230, BW=28.2MiB/s (29.6MB/s)(39.1MiB/1383msec); 0 zone resets
> fio loop 236:   write: IOPS=758, BW=3035KiB/s (3108kB/s)(39.1MiB/13178msec); 0 zone resets
> fio loop 237:   write: IOPS=8071, BW=31.5MiB/s (33.1MB/s)(39.1MiB/1239msec); 0 zone resets
> ---
> fio loop 288:   write: IOPS=5552, BW=21.7MiB/s (22.7MB/s)(39.1MiB/1801msec); 0 zone resets
> fio loop 289:   write: IOPS=652, BW=2612KiB/s (2675kB/s)(39.1MiB/15314msec); 0 zone resets
> fio loop 290:   write: IOPS=6027, BW=23.5MiB/s (24.7MB/s)(39.1MiB/1659msec); 0 zone resets
> ---
> fio loop 314:   write: IOPS=5186, BW=20.3MiB/s (21.2MB/s)(39.1MiB/1928msec); 0 zone resets
> fio loop 315:   write: IOPS=669, BW=2680KiB/s (2744kB/s)(39.1MiB/14926msec); 0 zone resets
> fio loop 316:   write: IOPS=7163, BW=27.0MiB/s (29.3MB/s)(39.1MiB/1396msec); 0 zone resets
> ---
> fio loop 340:   write: IOPS=5170, BW=20.2MiB/s (21.2MB/s)(39.1MiB/1934msec); 0 zone resets
> fio loop 341:   write: IOPS=697, BW=2791KiB/s (2858kB/s)(39.1MiB/14333msec); 0 zone resets
> fio loop 342:   write: IOPS=6345, BW=24.8MiB/s (25.0MB/s)(39.1MiB/1576msec); 0 zone resets
> ---
> fio loop 367:   write: IOPS=5509, BW=21.5MiB/s (22.6MB/s)(39.1MiB/1815msec); 0 zone resets
> fio loop 368:   write: IOPS=607, BW=2429KiB/s (2488kB/s)(39.1MiB/16466msec); 0 zone resets
> fio loop 369:   write: IOPS=6402, BW=25.0MiB/s (26.2MB/s)(39.1MiB/1562msec); 0 zone resets
> ---
> fio loop 393:   write: IOPS=7331, BW=28.6MiB/s (30.0MB/s)(39.1MiB/1364msec); 0 zone resets
> fio loop 394:   write: IOPS=637, BW=2550KiB/s (2612kB/s)(39.1MiB/15684msec); 0 zone resets
> fio loop 395:   write: IOPS=7358, BW=28.7MiB/s (30.1MB/s)(39.1MiB/1359msec); 0 zone resets
> ---
> fio loop 419:   write: IOPS=6480, BW=25.3MiB/s (26.5MB/s)(39.1MiB/1543msec); 0 zone resets
> fio loop 420:   write: IOPS=620, BW=2484KiB/s (2543kB/s)(39.1MiB/16104msec); 0 zone resets
> fio loop 421:   write: IOPS=7007, BW=27.4MiB/s (28.7MB/s)(39.1MiB/1427msec); 0 zone resets
> ---
> fio loop 472:   write: IOPS=6313, BW=24.7MiB/s (25.9MB/s)(39.1MiB/1584msec); 0 zone resets
> fio loop 473:   write: IOPS=455, BW=1822KiB/s (1866kB/s)(39.1MiB/21951msec); 0 zone resets
> fio loop 474:   write: IOPS=6715, BW=26.2MiB/s (27.5MB/s)(39.1MiB/1489msec); 0 zone resets
> ---
> fio loop 498:   write: IOPS=7662, BW=29.9MiB/s (31.4MB/s)(39.1MiB/1305msec); 0 zone resets
> fio loop 499:   write: IOPS=470, BW=1882KiB/s (1928kB/s)(39.1MiB/21249msec); 0 zone resets
> fio loop 500:   write: IOPS=4228, BW=16.5MiB/s (17.3MB/s)(39.1MiB/2365msec); 0 zone resets
> ---
> fio loop 524:   write: IOPS=6697, BW=26.2MiB/s (27.4MB/s)(39.1MiB/1493msec); 0 zone resets
> fio loop 525:   write: IOPS=454, BW=1818KiB/s (1861kB/s)(39.1MiB/22004msec); 0 zone resets
> fio loop 526:   write: IOPS=7112, BW=27.8MiB/s (29.1MB/s)(39.1MiB/1406msec); 0 zone resets
> ---
> fio loop 577:   write: IOPS=4222, BW=16.5MiB/s (17.3MB/s)(39.1MiB/2368msec); 0 zone resets
> fio loop 578:   write: IOPS=150, BW=602KiB/s (617kB/s)(39.1MiB/66416msec); 0 zone resets
> fio loop 579:   write: IOPS=6038, BW=23.6MiB/s (24.7MB/s)(39.1MiB/1656msec); 0 zone resets
> ---
> fio loop 603:   write: IOPS=5991, BW=23.4MiB/s (24.5MB/s)(39.1MiB/1669msec); 0 zone resets
> fio loop 604:   write: IOPS=441, BW=1764KiB/s (1806kB/s)(39.1MiB/22674msec); 0 zone resets
> fio loop 605:   write: IOPS=6056, BW=23.7MiB/s (24.8MB/s)(39.1MiB/1651msec); 0 zone resets
> ---
> fio loop 682:   write: IOPS=6226, BW=24.3MiB/s (25.5MB/s)(39.1MiB/1606msec); 0 zone resets
> fio loop 683:   write: IOPS=322, BW=1290KiB/s (1321kB/s)(39.1MiB/31002msec); 0 zone resets
> fio loop 684:   write: IOPS=5934, BW=23.2MiB/s (24.3MB/s)(39.1MiB/1685msec); 0 zone resets
> ---
> fio loop 708:   write: IOPS=5614, BW=21.9MiB/s (22.0MB/s)(39.1MiB/1781msec); 0 zone resets
> fio loop 709:   write: IOPS=473, BW=1894KiB/s (1939kB/s)(39.1MiB/21124msec); 0 zone resets
> fio loop 710:   write: IOPS=6816, BW=26.6MiB/s (27.9MB/s)(39.1MiB/1467msec); 0 zone resets
> ---
> fio loop 761:   write: IOPS=6301, BW=24.6MiB/s (25.8MB/s)(39.1MiB/1587msec); 0 zone resets
> fio loop 762:   write: IOPS=448, BW=1796KiB/s (1839kB/s)(39.1MiB/22275msec); 0 zone resets
> fio loop 763:   write: IOPS=7490, BW=29.3MiB/s (30.7MB/s)(39.1MiB/1335msec); 0 zone resets
> ---
> fio loop 787:   write: IOPS=6729, BW=26.3MiB/s (27.6MB/s)(39.1MiB/1486msec); 0 zone resets
> fio loop 788:   write: IOPS=579, BW=2318KiB/s (2374kB/s)(39.1MiB/17253msec); 0 zone resets
> fio loop 789:   write: IOPS=5356, BW=20.9MiB/s (21.9MB/s)(39.1MiB/1867msec); 0 zone resets
> ---
> fio loop 866:   write: IOPS=6720, BW=26.3MiB/s (27.5MB/s)(39.1MiB/1488msec); 0 zone resets
> fio loop 867:   write: IOPS=314, BW=1258KiB/s (1288kB/s)(39.1MiB/31791msec); 0 zone resets
> fio loop 868:   write: IOPS=5602, BW=21.9MiB/s (22.9MB/s)(39.1MiB/1785msec); 0 zone resets
> ---
> fio loop 892:   write: IOPS=6915, BW=27.0MiB/s (28.3MB/s)(39.1MiB/1446msec); 0 zone resets
> fio loop 893:   write: IOPS=598, BW=2395KiB/s (2452kB/s)(39.1MiB/16704msec); 0 zone resets
> fio loop 894:   write: IOPS=6544, BW=25.6MiB/s (26.8MB/s)(39.1MiB/1528msec); 0 zone resets
> ---
> fio loop 945:   write: IOPS=6176, BW=24.1MiB/s (25.3MB/s)(39.1MiB/1619msec); 0 zone resets
> fio loop 946:   write: IOPS=570, BW=2281KiB/s (2336kB/s)(39.1MiB/17536msec); 0 zone resets
> fio loop 947:   write: IOPS=6631, BW=25.9MiB/s (27.2MB/s)(39.1MiB/1508msec); 0 zone resets
> ---
> fio loop 971:   write: IOPS=8539, BW=33.4MiB/s (34.0MB/s)(39.1MiB/1171msec); 0 zone resets
> fio loop 972:   write: IOPS=579, BW=2317KiB/s (2372kB/s)(39.1MiB/17265msec); 0 zone resets
> fio loop 973:   write: IOPS=6265, BW=24.5MiB/s (25.7MB/s)(39.1MiB/1596msec); 0 zone resets
> ---
> 
> 
> In these instances, fio takes about as long as I would expect the
> snapshot to have taken to run. Regardless of the cause, something
> looks to be broken here...
> 
> An astute reader might also notice that fio performance really drops
> away quickly as the number of snapshots goes up. Loop 0 is the "no
> snapshots" performance. By 10 snapshots, performance is half the
> no-snapshot rate. By 50 snapshots, performance is a quarter of the
> no-snapshot peroframnce. It levels out around 6-7000 IOPS, which is
> about 15% of the non-snapshot performance. Is this expected
> performance degradation as snapshot count increases?

Somewhere in that workload, there's probably a pretty high write
multiplier for unsharing subvol metadata pages in snapshots.  The worst
case is about 300x write multiply for the first few pages after a snapshot
is created, because every item referenced on the shared subvol metadata
page (there can be 150-300 of them) must have a new backreference added
to the newly created unshared metadata page, and in the worst case every
one of those new items lives in a separate metadata page that also
has to be read, modified, and written.  The write multiplier rapidly
levels off to 1x once all the snapshot's metadata pages are unshared,
after random writes to around 0.3% of the subvol.  So writing 4K to a
file in a subvol right after a snapshot was taken could hit the disks
with up to 20MB of random read and write iops before it's over.

Fragmentation pushes everything toward the worst-case scenario because it
spreads the referenced items around to separate pages, which could explain
the asymptotic performance curve for snapshots.  Without fragmentation,
all the referenced items tend to appear on the same or at least a few
adjacent pages, so the unsharing cost is much lower.  It's the same
number of pages to unshare whether it's 1 snapshot or 1000, but the
referenced items will get spread around a lot after 1000 iterarations
of that fio loop.

Reflinks don't share metadata pages, so they don't have this problem
(except when the dst of the reflink is modifying metadata pages that are
shared with a snapshot, like any other write).

> And before you ask, reflink copies of the fio file rather than
> subvol snapshots have largely the same performance, IO and
> behavioural characteristics. The only difference is that clone
> copying also has a cyclic FIO performance dip (every 3-4 cycles)
> that corresponds with the system driving hard into memory reclaim
> during periodic writeback from btrfs.
> 
> FYI, I've compared btrfs reflink to XFS reflink, too, and XFS fio
> performance stays largely consistent across all 1000 iterations at
> around 13-14k +/-2k IOPS. The reflink time also scales linearly with
> the number of extents in the source file and levels off at about
> 10-11s per cycle as the extent count in the source file levels off
> at ~850,000 extents. XFS completes the 1000 iterations of
> write/clone in about 4 hours, btrfs completels the same part of the
> workload in about 9 hours.
> 
> Oh, I almost forget - FIEMAP performance. After the reflink test, I
> map all the extents in all the cloned files to a) count the extents
> and b) confirm that the difference between clones is correct (~10000
> extents not shared with the previous iteration). Pulling the extent
> maps out of XFS takes about 3s a clone (~850,000 extents), or 30
> minutes for the whole set when run serialised. btrfs takes 90-100s
> per clone - after 8 hours it had only managed to map 380 files and
> was running at 6-7000 read IOPS the entire time. IOWs, it was taking
> _half a million_ read IOs to map the extents of a single clone that
> only had a million extents in it. Is it expected that FIEMAP is so
> slow and IO intensive on cloned files?

There were severe performance issues with FIEMAP (or anything else that
does backref lookup) on kernels before 5.7, especially on files bigger
than a few hundred MB (among other things, it was searching the entire
file for matching forward ref instead of just around the area where the
backref was).  FIEMAP looks at backrefs to populate the 'shared' bit,
so it was affected by this bug.

There might still be a big IO overhead for backref search on current
kernels.  The worst case is some gigabytes of metadata pages for extent
references, if every referencing item ends up stored on its own metadata
page, and if FIEMAP has to read many of them before it finds a reference
that matches the logical file offset so it can set or clear the 'shared'
bit.

I'm not sure the worst case is even bounded--you could have billions of
references to an extent and I don't know of any reason why you couldn't
fill a disk with them (other than btrfs getting too slow to finish before
the disk crumbles to dust).

TREE_SEARCH_V2 doesn't have a 'shared' bit to populate, so it runs _much_
faster than FIEMAP.

> As there are no performance anomolies or memory reclaim issues with
> XFS running this workload, I suspect the issues I note above are
> btrfs issues, not expected behaviour.  I'm not sure what the
> expected scalability of btrfs file clones and snapshots are though,
> so I'm interested to hear if these results are expected or not.

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 
> JOBS=4
> IODEPTH=4
> IOCOUNT=$((10000 / $JOBS))
> FILESIZE=4g
> 
> cat >$fio_config <<EOF
> [global]
> name=${DST}.name
> directory=${DST}
> size=${FILESIZE}
> randrepeat=0
> bs=4k
> ioengine=libaio
> iodepth=${IODEPTH}
> iodepth_low=2
> direct=1
> end_fsync=1
> fallocate=none
> overwrite=1
> number_ios=${IOCOUNT}
> runtime=30s
> group_reporting=1
> disable_lat=1
> lat_percentiles=0
> clat_percentiles=0
> slat_percentiles=0
> disk_util=0
> 
> [j1]
> filename=testfile
> rw=randwrite
> 
> [j2]
> filename=testfile
> rw=randwrite
> 
> [j3]
> filename=testfile
> rw=randwrite
> 
> [j4]
> filename=testfile
> rw=randwrite
> EOF
> 
