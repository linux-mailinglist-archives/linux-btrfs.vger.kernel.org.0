Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C0E47B90E
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Dec 2021 04:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbhLUDi3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Dec 2021 22:38:29 -0500
Received: from drax.kayaks.hungrycats.org ([174.142.148.226]:48892 "EHLO
        drax.kayaks.hungrycats.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230286AbhLUDi2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Dec 2021 22:38:28 -0500
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id A4604107CBB; Mon, 20 Dec 2021 22:38:27 -0500 (EST)
Date:   Mon, 20 Dec 2021 22:38:27 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Jingyun He <jingyun.ho@gmail.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: unable to use all spaces
Message-ID: <YcFMM8MfNU4LrUc1@hungrycats.org>
References: <CAHQ7scWFUthGXGs72M9VYPHc2eiZ2hSSs6LJd6XVL2oQO2fgLw@mail.gmail.com>
 <20211215155059.GB28560@twin.jikos.cz>
 <1010d177-a983-d95f-1927-690114805b8f@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1010d177-a983-d95f-1927-690114805b8f@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 16, 2021 at 07:58:39AM +0800, Qu Wenruo wrote:
> On 2021/12/15 23:50, David Sterba wrote:
> > On Wed, Dec 15, 2021 at 10:31:13PM +0800, Jingyun He wrote:
> > > Hello,
> > > I have a 14TB WDC HM-SMR disk formatted with BTRFS,
> > > It looks like I'm unable to fill the disk full.
> > > E.g. btrfs fi usage /disk1/
> > > Free (estimated): 128.95GiB (min: 128.95GiB)
> > > 
> > > It still has 100+GB available
> > > But I'm unable to put more files.
> > 
> > We'd need more information to diagnose that, eg. output of 'btrfs fi df'
> > to see if eg. the metadata space is not exhausted or if the remaining
> > 128G account for the unusable space in the zones (this is also in the
> > 'fi df' output).
> 
> A little off-topic, but IMHO we should really make our 'fi usage' and
> vanilla 'df' to take metadata and unallocated space into consideration.
> 
> The vanilla 'df' command reporting more space than what we can really
> use is already causing new btrfs users problems.
> 
> We can keep teaching users, but there are still tools relying completely
> on vanilla 'df' output to reserve their space usage.
> 
> Thus it's not really something can be purely solved by education.
> 
> My purpose is to make vanilla 'df' output to take metadata/unallocated
> space into consideration.
> 
> Unfortunately I don't have solid plan yet.
> But maybe we can start by returning 0 available space when no more
> unallocated space.

It's a really bad idea to abruptly flip to zero free space.  If df reports
"3.7TB free", and then you write 4K, and then df reports "zero free",
it's no better than if the write had just returned ENOSPC with 3.7TB free.
If the number provides no predictive information about how the filesystem
will respond to near-future allocations, then it's useless.

Worse, automated responses to a reported low free space number might
get triggered, and wipe out significant amounts of data in a futile
attempt to get some usable free space (it's futile because the required
response is data balance not file deletion, and if there are snapshots
the response will make the metadata problem worse for a long time before
making it better).

If we have good information about the ratio of data to metadata on
the filesystem, we could gradually reduce the reported free space,
always reporting a number between zero and the true number of free data
blocks (i.e. the lower of "true free data blocks" and "estimated data
blocks that could be allocated if all the remaining metadata space was
completely consumed at the current data:metadata ratio").  That would
mean that instead of 3.7TB free, we might report 3.5TB free if we have
0.8MB of free space for metadata, and it would drop to 1.7TB as we
drop to 0.4MB of free metadata space (after deducting global reserve).
In this situation, writing 4K to the filesystem might decrease the free
space reported by 4MB, but it would happen while 4MB is 0.2% of the free
space on the filesystem, far enough in advance of reaching zero that an
attentive sysadmin or robot could avoid a disaster before it happens.

On the other hand, if we are tracking those statistics and they're
accurate, we could use them to preallocate more metadata and prevent
surprising shortages of metadata space.  We'd also have to stop metadata
balance from wiping out preallocations.  We'd have correct df free space
numbers based on that--if we need 1% of the filesystem for metadata,
we'd actually allocate 1% of the filesystem for metadata, and df would
report 1% less free space.

We already had the abrupt zeroing behavior and removed it in 5.4 for
that reason (and also the fact that the zero trigger calculation had a
long-standing bug).

The entire discussion is moot as long as df is as wildly inaccurate as
it is now.  Step 0 of this plan would be to give df a working algorithm
to figure out how much space the filesystem has.

> Maybe later we can have more comprehensive available space calculation.
> 
> (Other fses like ext4/xfs already does similar behavior by
> under-reporting available space)

ext4 has "superuser reserved" space which isn't really underreporting,
it's just taking the real free space number (which ext4 can compute
accurately) and subtracting a user-configured constant value.  root can
still fill the filesystem all the way to zero, less a few blocks for
directories and indirect block lists.

ext4 does preallocate space for metadata and the filesystem does give
ENOSPC with non-zero df free when metadata runs out.  There's a data
block to inode ratio that is fixed at mkfs time, and you get up to (size
of filiesystem / that number) of inodes and not a single file more.
The other ext4 "metadata" (indirect block lists and directories) is
stored in its data blocks, so it shows up in df's available space number
and behaves the way users expect.  ext4 has no snapshots or reflinks
so the other btrfs special metadata cases can't happen on ext4.

> Thanks,
> Qu
> > 
> > > Do you know if there are any mkfs/mount options that I can use to
> > > reach maximum capacity? like mkfs.ext4 -m 0 -O ^has_journal -T
> > > largefile4
> > 
> > There are no such options and the space should be used at the full range
> > with respect to the chunk allocations.
