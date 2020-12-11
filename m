Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62C02D6EEE
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Dec 2020 04:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395250AbgLKDuB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 10 Dec 2020 22:50:01 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:37970 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbgLKDtq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Dec 2020 22:49:46 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id ED6B88EE69F; Thu, 10 Dec 2020 22:49:00 -0500 (EST)
Date:   Thu, 10 Dec 2020 22:49:00 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Eric Wheeler <btrfs@lists.ewheeler.net>
Cc:     linux-btrfs@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Global reserve ran out of space at 512MB, fails to rebalance
Message-ID: <20201211034859.GK31381@hungrycats.org>
References: <alpine.LRH.2.21.2012100149160.15698@pop.dreamhost.com>
 <20201210031251.GJ31381@hungrycats.org>
 <alpine.LRH.2.21.2012101935440.15698@pop.dreamhost.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <alpine.LRH.2.21.2012101935440.15698@pop.dreamhost.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 10, 2020 at 07:50:06PM +0000, Eric Wheeler wrote:
> On Wed, 9 Dec 2020, Zygo Blaxell wrote:
> > On Thu, Dec 10, 2020 at 01:52:19AM +0000, Eric Wheeler wrote:
> > > Hello all,
> > > 
> > > We have a 30TB volume with lots of snapshots that is low on space and we 
> > > are trying to rebalance.  Even if we don't rebalance, the space cleaner 
> > > still fills up the Global reserve:
> > > 
> > > >>> Global reserve:              512.00MiB	(used: 512.00MiB) <<<<<<<
> > 
> > It would be nice to have the rest of the btrfs fi usage output.  We are
> > having to guess how your drives are populated with data and metadata
> > and what profiles are in use.
> 
> Here is the whole output:
> 
> ]# df -h /mnt/btrbackup ; echo; btrfs fi df /mnt/btrbackup|column -t; echo; btrfs fi usage /mnt/btrbackup
> 
> Filesystem                  Size  Used Avail Use% Mounted on
> /dev/mapper/btrbackup-luks   30T   30T  541G  99% /mnt/btrbackup
> 
> Data,           single:  total=29.80TiB,  used=29.28TiB
> System,         DUP:     total=8.00MiB,   used=3.42MiB
> Metadata,	DUP:     total=99.00GiB,  used=87.03GiB
> GlobalReserve,  single:  total=4.00GiB,   used=1.73MiB
> 
> Overall:
>     Device size:                  30.00TiB
>     Device allocated:             30.00TiB
>     Device unallocated:            1.00GiB
>     Device missing:                  0.00B
>     Used:                         29.45TiB
>     Free (estimated):            540.74GiB	(min: 540.24GiB)
>     Data ratio:                       1.00
>     Metadata ratio:                   2.00
>     Global reserve:                4.00GiB	(used: 1.73MiB) <<<< with 4GB hack
> 
> Data,single: Size:29.80TiB, Used:29.28TiB (98.23%)
>    /dev/mapper/btrbackup-luks     29.80TiB
> 
> Metadata,DUP: Size:99.00GiB, Used:87.03GiB (87.91%)
>    /dev/mapper/btrbackup-luks    198.00GiB
> 
> System,DUP: Size:8.00MiB, Used:3.42MiB (42.77%)
>    /dev/mapper/btrbackup-luks     16.00MiB
> 
> Unallocated:
>    /dev/mapper/btrbackup-luks	   1.00GiB
>  
> > You probably need to be running some data balances (btrfs balance start
> > -dlimit=9 about once a day) to ensure there is always at least 1GB of
> > unallocated space on every drive.
> 
> Thanks for the daily rebalance tip.  Is there a reason you chose 
> -dlimit=9?  I know it means 9 chunks, but why 9?  Also, how big is a 
> "chunk" ? 

"9" is fewer digits than "10"... ;)

It's a good starting point for an average filesystem.  You may want
to tune it for your workload.

Most chunks are multiples of 1GB except on very small filesystems;
however, sometimes the last data chunk is an odd size (i.e. not 1GB).
If the filesystem has been resized in the past, there could be multiple
odd-sized chunks.  A balance of one or two tiny chunks might not release a
useful amount of space.  Balancing 9 chunks at a time reduces the chance
of getting stuck with such a small chunk, and also gives you some extra
unallocated space in case some of it gets allocated during the day.

On a mostly idle system, you may not need to run the balance every day.
On a system with hundreds of GB of unallocated space on every drive,
you don't need to run balance at all.  Monitor your system's unallocated
space over time and adjust the limit and scheduling as required so you
don't run out of unallocated space.

Ideally we'd have a packaged tool ready to install that makes those
decisions automatically, but we're still trying to figure out what the
threshold values should be.  Clearly, "2TB of unallocated space on every
drive" needs no intervention, while "0 unallocated space on any drive"
is too late for intervention to be useful any more.  In between these
extremes, it is harder to evaluate from code.  When there's 20GB
unallocated on every drive, and 10GB are consumed per day, does that
require a balance today, or can it wait until tomorrow?  How would we get
the trend data?  Will the user do something unpredictable that requires
balance earlier than expected?  Will we set the thresholds too low,
and waste a lot of iops on balancing that isn't useful?  Will we set
the thresholds too high, and fail to intervene on a system that is
headed for metadata ENOSPC?

> In this case we have 1GB unallocated.

And also almost 12 GB allocated but not used metadata.  So I'm not sure
why you're hitting ENOSPC unless you are hitting a straight-up bug
(or using ssd_spread...don't use ssd_spread).  But 5.6 kernels did
have exactly such a bug (as did all kernels before 5.8).

> > Never balance metadata, especially not from a scheduled job.  Metadata
> > balances lead directly to this situation.
> 
> So when /would/ you balance metadata?

There are three cases where metadata balance does something useful:

	1.  When converting to a different raid profile (e.g. add
	a second disk, convert with balance -mconvert=raid1,soft).

	2.  When shrinking a disk or removing a drive from an array.
	This will run relocation on metadata in the removed sections
	of the filesystem.  This is not avoidable with the current
	btrfs code.

	3.  When you are a kernel developer testing for regressions in
	the metadata balance code.

Otherwise, never balance metadata.

btrfs is pretty good at reusing the allocated metadata space, plus
or minus a gigabyte.  Free space fragmentation is not an issue for
metadata space, since every metadata page is the same size, so there is
no equivalent benefit for defragmeting free space in metadata chunks as
there is for data chunks.  If your filesystem needed metadata space in
the past, chances are good it will be needed in the future, so the peak
metadata allocation size is almost always the correct size.

Metadata balance will deallocate metadata chunks based on current
instantaneous metadata space requirements, which can leave you with
insufficient space for metadata when you need it at other times.
Metadata should be allowed to grow, and never forced to shrink, until
it reaches approximately the right size for your workload.

> > > This was on a Linux 5.6 kernel.  I'm trying a Linux 5.9.13 kernel with a 
> > > hacked in SZ_4G in place of the SZ_512MB and will report back when I learn 
> > > more.
> >
> > I've had similar problems with snapshot deletes hitting ENOSPC with
> > small amounts of free metadata space.  In this case, the upgrade from
> > 5.6 to 5.9 will include a fix for that (it's in 5.8, also 5.4 and earlier
> > LTS kernels).
> 
> Ok, now on 5.9.13
>  
> > Increasing the global reserve may seem to help, but so will just rebooting
> > over and over, so a positive result from an experimental kernel does not
> > necessarily mean anything.
> 
> At least this reduces the number of times I need to reboot ;)

Does it?

You switched from SZ_512M on 5.6 to SZ_4G on 5.9.  5.9 has a proper fix
for the bug you most likely enountered, in which case SZ_4G would not
have any effect other than to use more memory and increase commit latency.

Transactions should be throttled at the reserved size, regardless of what
the reserved size is.  i.e. if you make the reserved size bigger, then
big deletes will just run longer and use more memory between commits.
Deletions are pretty huge metadata consumers--deleting as little as
0.3% of the filesystem can force a rewrite of all metadata in the worst
case--so you have probably been hitting the 512M limit over and over
without issue before now.  Transactions are supposed to grow to reach
the reserved limit and then pause to commit, so a big delete operation
will span many transactions.  The limit is there to keep kernel RAM
usage and transaction latency down.

If you ran two boots at SZ_512M followed by one boot at SZ_4G, and it
works, then that test only tells you that you needed to do 3 boots in
total to recover the filesystem from the initial bad state.  It doesn't
indicate SZ_4G is solving any problem.  To confirm that hypothesis,
you'd need to rewind the filesystem back to the initial state, run
a series of reboots on kernel A and a series of reboots on kernel B,
correct for timing artifacts (at some point there will be a scheduled
transaction commit that will appear at a random point in the IO sequence,
so different test runs under identical initial conditions will not produce
identical results), and show both 1) a consistent improvement in reboot
count between kernel A and kernel B, and 2) the only difference between
kernel A and kernel B is reserved size SZ_512M vs SZ_4G.

> Question: 
> 
> What do people think of making this a module option or ioctl for those who 
> need to hack it into place to minimize reboots?

I think it would be better to find the code that is failing to handle
running out of free transaction metadata, and fix that.  Assuming it
isn't fixed already.

> -Eric
> 
> --
> Eric Wheeler
