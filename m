Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 137112D806D
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Dec 2020 22:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394870AbgLKVH2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Dec 2020 16:07:28 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:42114 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392579AbgLKVGz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Dec 2020 16:06:55 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 447798F0358; Fri, 11 Dec 2020 16:05:49 -0500 (EST)
Date:   Fri, 11 Dec 2020 16:05:49 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Eric Wheeler <btrfs@lists.ewheeler.net>
Cc:     linux-btrfs@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Global reserve ran out of space at 512MB, fails to rebalance
Message-ID: <20201211210549.GL31381@hungrycats.org>
References: <alpine.LRH.2.21.2012100149160.15698@pop.dreamhost.com>
 <20201210031251.GJ31381@hungrycats.org>
 <alpine.LRH.2.21.2012101935440.15698@pop.dreamhost.com>
 <20201211034859.GK31381@hungrycats.org>
 <alpine.LRH.2.21.2012111857360.15698@pop.dreamhost.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.2012111857360.15698@pop.dreamhost.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 11, 2020 at 07:08:23PM +0000, Eric Wheeler wrote:
> On Thu, 10 Dec 2020, Zygo Blaxell wrote:
> > On Thu, Dec 10, 2020 at 07:50:06PM +0000, Eric Wheeler wrote:
> > > On Wed, 9 Dec 2020, Zygo Blaxell wrote:
> > > > On Thu, Dec 10, 2020 at 01:52:19AM +0000, Eric Wheeler wrote:
> > > > > Hello all,
> > > > > 
> > > > > We have a 30TB volume with lots of snapshots that is low on space and we 
> > > > > are trying to rebalance.  Even if we don't rebalance, the space cleaner 
> > > > > still fills up the Global reserve:
> > > > > 
> > > > > >>> Global reserve:              512.00MiB	(used: 512.00MiB) <<<<<<<
>[...]
> > > Ok, now on 5.9.13
> > >  
> > > > Increasing the global reserve may seem to help, but so will just rebooting
> > > > over and over, so a positive result from an experimental kernel does not
> > > > necessarily mean anything.
> > > 
> > > At least this reduces the number of times I need to reboot ;)
> > 
> > Does it?
> > 
> > You switched from SZ_512M on 5.6 to SZ_4G on 5.9.  5.9 has a proper fix
> > for the bug you most likely enountered, in which case SZ_4G would not
> > have any effect other than to use more memory and increase commit latency.
> > 
> > Transactions should be throttled at the reserved size, regardless of what
> > the reserved size is.  i.e. if you make the reserved size bigger, then
> > big deletes will just run longer and use more memory between commits.
> > Deletions are pretty huge metadata consumers--deleting as little as
> > 0.3% of the filesystem can force a rewrite of all metadata in the worst
> > case--so you have probably been hitting the 512M limit over and over
> > without issue before now.  Transactions are supposed to grow to reach
> > the reserved limit and then pause to commit, so a big delete operation
> > will span many transactions.  The limit is there to keep kernel RAM
> > usage and transaction latency down.
> 
> Interesting.  In that case, perhaps there are low-latency scenarios for 
> which the 512MB limit should be tuned down (not up like we tried).
> 
> I'm guessing most transaction management is asynchronous to userspace, but 
> under what circumstances (if any) might a transaction commit block 
> userspace IO?

Transaction commit is not asynchronous.  Only one can run at a time--the
singular transaction is used to lock out certain concurrent operations.
It normally has a short critical section, and some write operations are
allowed to proceed across transaction boundaries.

Since 5.0, processes can add more work for btrfs-transaction to do while
it's trying to commit a transaction, limited only by available disk space
(previously there was a feedback loop that measured how fast the disks
were disposing of the data and throttled writing processes so the disks
could keep up).  This tops up the queued work for the transaction to
write to the disk, so the transaction never completes.  This leads to
several "stop the world" scenarios where one process can overwhelm btrfs
with write operations and lock out all other writers for as long as it
takes for the filesystem to run out of space (when the filesystem runs
out of space, the transaction must end, either with a commit or by
forcing the filesystem read-only).

There have been some patches to address some special cases of these,
and more are in for-next and on the mailing list.  But there are still
plenty of bad cases for current kernels.

> > If you ran two boots at SZ_512M followed by one boot at SZ_4G, and it
> > works, then that test only tells you that you needed to do 3 boots in
> > total to recover the filesystem from the initial bad state.  It doesn't
> > indicate SZ_4G is solving any problem.  To confirm that hypothesis,
> > you'd need to rewind the filesystem back to the initial state, run
> > a series of reboots on kernel A and a series of reboots on kernel B,
> > correct for timing artifacts (at some point there will be a scheduled
> > transaction commit that will appear at a random point in the IO sequence,
> > so different test runs under identical initial conditions will not produce
> > identical results), and show both 1) a consistent improvement in reboot
> > count between kernel A and kernel B, and 2) the only difference between
> > kernel A and kernel B is reserved size SZ_512M vs SZ_4G.
> 
> I understand, it is likely that 5.9 with 4G didn't do anything since the 
> 5.8 fix is in place.  Good to know that we don't have a reason to maintain 
> the 4G hack.
> 
> Great writeup.  Your entire email response should go on the wiki!  I've 
> searched hi-and-low for disk space best practices in BTRFS and I think you 
> covered it all.
> 
> The system is in great shape now, check it out:
> 
> Overall:
>     Device size:                  30.00TiB
>     Device allocated:             29.88TiB
>     Device unallocated:          123.97GiB
>     Device missing:                  0.00B
>     Used:                         23.45TiB
>     Free (estimated):              6.47TiB	(min: 6.41TiB)
>     Data ratio:                       1.00
>     Metadata ratio:                   2.00
>     Global reserve:                4.00GiB	(used: 0.00B)
> 
> Data,single: Size:29.68TiB, Used:23.33TiB (78.59%)
>    /dev/mapper/btrbackup-luks     29.68TiB
> 
> Metadata,DUP: Size:101.00GiB, Used:63.49GiB (62.86%)
>    /dev/mapper/btrbackup-luks    202.00GiB
> 
> System,DUP: Size:8.00MiB, Used:3.42MiB (42.77%)
>    /dev/mapper/btrbackup-luks     16.00MiB
> 
> Unallocated:
>    /dev/mapper/btrbackup-luks    123.97GiB

Yep, that should be good to go for a while.

> 
> --
> Eric Wheeler
