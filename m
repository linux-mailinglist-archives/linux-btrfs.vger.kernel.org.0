Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9829F31667E
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Feb 2021 13:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhBJMVr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Feb 2021 07:21:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:55984 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230412AbhBJMTk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Feb 2021 07:19:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5454EAC43;
        Wed, 10 Feb 2021 12:18:58 +0000 (UTC)
Date:   Wed, 10 Feb 2021 12:18:53 +0000
From:   Michal Rostecki <mrostecki@suse.de>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Michal Rostecki <mrostecki@suse.com>
Subject: Re: [PATCH RFC 0/6] Add roundrobin raid1 read policy
Message-ID: <20210210121853.GA23499@wotan.suse.de>
References: <20210209203041.21493-1-mrostecki@suse.de>
 <4f24ef7f-c1cf-3cda-b12f-a2c8c84a7e45@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f24ef7f-c1cf-3cda-b12f-a2c8c84a7e45@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 10, 2021 at 02:52:01PM +0800, Anand Jain wrote:
> On 10/02/2021 04:30, Michal Rostecki wrote:
> > From: Michal Rostecki <mrostecki@suse.com>
> > 
> > This patch series adds a new raid1 read policy - roundrobin. For each
> > request, it selects the mirror which has lower load than queue depth.
> > Load is defined  as the number of inflight requests + a penalty value
> > (if the scheduled request is not local to the last processed request for
> > a rotational disk).
> > 
> > The series consists of preparational changes which add necessary
> > information to the btrfs_device struct and the change with the policy.
> > 
> > This policy was tested with fio and compared with the default `pid`
> > policy.
> > 
> > The singlethreaded test has the following parameters:
> > 
> >    [global]
> >    name=btrfs-raid1-seqread
> >    filename=btrfs-raid1-seqread
> >    rw=read
> >    bs=64k
> >    direct=0
> >    numjobs=1
> >    time_based=0
> > 
> >    [file1]
> >    size=10G
> >    ioengine=libaio
> > 
> > and shows the following results:
> > 
> > - raid1c3 with 3 HDDs:
> >    3 x Segate Barracuda ST2000DM008 (2TB)
> >    * pid policy
> >      READ: bw=217MiB/s (228MB/s), 217MiB/s-217MiB/s (228MB/s-228MB/s),
> >      io=10.0GiB (10.7GB), run=47082-47082msec
> >    * roundrobin policy
> >      READ: bw=409MiB/s (429MB/s), 409MiB/s-409MiB/s (429MB/s-429MB/s),
> >      io=10.0GiB (10.7GB), run=25028-25028mse
> 
> 
> > - raid1c3 with 2 HDDs and 1 SSD:
> >    2 x Segate Barracuda ST2000DM008 (2TB)
> >    1 x Crucial CT256M550SSD1 (256GB)
> >    * pid policy (the worst case when only HDDs were chosen)
> >      READ: bw=220MiB/s (231MB/s), 220MiB/s-220MiB/s (231MB/s-231MB/s),
> >      io=10.0GiB (10.7GB), run=46577-46577mse
> >    * pid policy (the best case when SSD was used as well)
> >      READ: bw=513MiB/s (538MB/s), 513MiB/s-513MiB/s (538MB/s-538MB/s),
> >      io=10.0GiB (10.7GB), run=19954-19954msec
> >    * roundrobin (there are no noticeable differences when testing multiple
> >      times)
> >      READ: bw=541MiB/s (567MB/s), 541MiB/s-541MiB/s (567MB/s-567MB/s),
> >      io=10.0GiB (10.7GB), run=18933-18933msec
> > 
> > The multithreaded test has the following parameters:
> > 
> >    [global]
> >    name=btrfs-raid1-seqread
> >    filename=btrfs-raid1-seqread
> >    rw=read
> >    bs=64k
> >    direct=0
> >    numjobs=8
> >    time_based=0
> > 
> >    [file1]
> >    size=10G
> >    ioengine=libaio
> > 
> > and shows the following results:
> > 
> > - raid1c3 with 3 HDDs: 3 x Segate Barracuda ST2000DM008 (2TB)
> >    3 x Segate Barracuda ST2000DM008 (2TB)
> >    * pid policy
> >      READ: bw=1569MiB/s (1645MB/s), 196MiB/s-196MiB/s (206MB/s-206MB/s),
> >      io=80.0GiB (85.9GB), run=52210-52211msec
> >    * roundrobin
> >      READ: bw=1733MiB/s (1817MB/s), 217MiB/s-217MiB/s (227MB/s-227MB/s),
> >      io=80.0GiB (85.9GB), run=47269-47271msec
> > - raid1c3 with 2 HDDs and 1 SSD:
> >    2 x Segate Barracuda ST2000DM008 (2TB)
> >    1 x Crucial CT256M550SSD1 (256GB)
> >    * pid policy
> >      READ: bw=1843MiB/s (1932MB/s), 230MiB/s-230MiB/s (242MB/s-242MB/s),
> >      io=80.0GiB (85.9GB), run=44449-44450msec
> >    * roundrobin
> >      READ: bw=2485MiB/s (2605MB/s), 311MiB/s-311MiB/s (326MB/s-326MB/s),
> >      io=80.0GiB (85.9GB), run=32969-32970msec
> > 
> 
>  Both of the above test cases are sequential. How about some random IO
>  workload?
> 
>  Also, the seek time for non-rotational devices does not exist. So it is
>  a good idea to test with ssd + nvme and all nvme or all ssd.
> 

Good idea. I will test random I/O and will try to test all-nvme /
all-ssd and mixed nonrot.

> > To measure the performance of each policy and find optimal penalty
> > values, I created scripts which are available here:
> > 
> > https://gitlab.com/vadorovsky/btrfs-perf
> > https://github.com/mrostecki/btrfs-perf
> > 
> > Michal Rostecki (6):
> 
> 
> >    btrfs: Add inflight BIO request counter
> >    btrfs: Store the last device I/O offset
> 
> These patches look good. But as only round-robin policy requires
> to monitor the inflight and last-offset. Could you bring them under
> if policy=roundrobin? Otherwise, it is just a waste of CPU cycles
> if the policy != roundrobin.
> 

If I bring those stats under if policy=roundrobin, they are going to be
inaccurate if someone switches policies on the running system, after
doing any I/O in that filesystem.

I'm open to suggestions how can I make those stats as lightweight as
possible. Unfortunately, I don't think I can store the last physical
location without atomic_t.

The BIO percpu counter is probably the least to be worried about, though
I could maybe get rid of it entirely in favor of using part_stat_read().

> >    btrfs: Add stripe_physical function
> >    btrfs: Check if the filesystem is has mixed type of devices
> 
> Thanks, Anand
> 
> >    btrfs: sysfs: Add directory for read policies
> >    btrfs: Add roundrobin raid1 read policy
> > 
> >   fs/btrfs/ctree.h   |   3 +
> >   fs/btrfs/disk-io.c |   3 +
> >   fs/btrfs/sysfs.c   | 144 ++++++++++++++++++++++++++----
> >   fs/btrfs/volumes.c | 218 +++++++++++++++++++++++++++++++++++++++++++--
> >   fs/btrfs/volumes.h |  22 +++++
> >   5 files changed, 366 insertions(+), 24 deletions(-)
> > 
> 

Thanks for review,
Michal
