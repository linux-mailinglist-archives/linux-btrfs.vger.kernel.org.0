Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73DC2553D4
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Aug 2020 06:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgH1Ega convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 28 Aug 2020 00:36:30 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:46604 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgH1Eg3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Aug 2020 00:36:29 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 158817D5E68; Fri, 28 Aug 2020 00:36:28 -0400 (EDT)
Date:   Fri, 28 Aug 2020 00:36:28 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Eric Wong <e@80x24.org>
Cc:     kreijack@inwind.it, linux-btrfs@vger.kernel.org
Subject: Re: adding new devices to degraded raid1
Message-ID: <20200828043627.GE8346@hungrycats.org>
References: <20200827124147.GA16923@dcvr>
 <862ab235-298a-12eb-647b-04ec01d95293@libero.it>
 <20200828003037.GU5890@hungrycats.org>
 <20200828023412.GA308@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200828023412.GA308@dcvr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 28, 2020 at 02:34:12AM +0000, Eric Wong wrote:
> Zygo Blaxell <ce3g8jdj@umail.furryterror.org> wrote:
> > Note that add/remove is orders of magnitude slower than replace.
> > Replace might take hours or even a day or two on a huge spinning drive.
> > Add/remove might take _months_, though if you have 8-year-old disks
> > then it's probably a few days, weeks at most.
> 
> Btw, any explanation or profiling done on why remove is so much
> slower than replace?  Especially since btrfs raid1 ought to be
> fairly mature at this point (and I run recent stable kernels).

They do different things.

Replace just computes the contents of the filesystem the same way scrub
does:  except for the occasional metadata seek, it runs at wire speeds
because it reads blocks in order from one disk and writes in order on
the other disk, 99.999% of the time.

Remove makes a copy of every extent, updates every reference to the
extent, then deletes the original extents.  Very seek-heavy--including
seeks between reads and writes on the same drive--and the work is roughly
proportional to the number of reflinks, so dedupe and snapshots push
the cost up.  About the only advantage of remove (and balance) is that
it consists of 95% existing btrfs read and write code, and it can handle
any relocation that does not require changing the size or content of an
extent (including all possible conversions).

Arguably this isn't necessary.  Remove could copy a complete block group,
the same way replace does but to a different offset on each drive, and
simply update the chunk tree with the new location of the block group
at the end.  Trouble is, nobody's implemented this approach in btrfs yet.
It would be a whole new code path with its very own new bugs to fix.

> Converting a single drive to raid1 was not slow at all, either.
> RAID 1 ought to be straightforward if there's plenty of free
> space, one would think...

Depends on the disk size, performance, and structure (how big the extents
are and how many references).  Also, "slow" is relative:  100x 2 minutes
is not such a long time.  100x 20 hours is.

> > Add/remove does work for raid1* (i.e. raid1, raid10, raid1c3, raid1c4).
> > At the moment only 'replace' works reliably for raid5/raid6.
> 
> Noted, I'm staying far, far away from raid5/6 :)  Thanks for
> your posts on that topic, by the way.
> 
> > On Thu, Aug 27, 2020 at 07:14:18PM +0200, Goffredo Baroncelli wrote:
> > > Instead of
> > > 
> > >  	btrfs device remove broken /mnt/foo
> > > 
> > > You should do
> > > 
> > > 	btrfs device remove missing /mnt/foo
> > > 
> > > ("missing" has to be write as is, it is a special term, see man page)
> 
> Thanks Goffredo, noted.
> 
> > > and
> > > 
> > > 	btrfs balance start /mnt/foo
> > 
> > If the replacement disks are larger than half the size of the failed disk
> > then device remove may do sufficient data relocation and you won't need
> > balance.  Once all the disks have equal amounts of unallocated space in
> > 'btrfs fi usage' you can cancel any balances that are running.
> > 
> > On the other hand, if the replacement disks are close to half the size
> > of the failed disk, then some careful balance filtering is required in
> > order to utilize all the available space.  This filtering is more than
> > what the stock tool offers.  You have to make sure that there are no block
> > groups with a mirror copy on both of the small disks, as any such block
> > group removes 1GB of available mirror space for data on the largest disk.
> 
> Yikes, that balancing sounds like a pain.  I'm not super-limited
> on space, and a fair bit gets overwritten or replaced as time
> goes on, anyways.
> 
> I wonder how far I could get with some lossless rewrites which
> might make sense, anyways.
> 
> 1) full "git gc" (I have a fair amount of git repos)
>    Maybe setting pack.compression=0 will even help dedupe
>    similar repos (but they'll be no fun to serve over network)

Git pack doesn't do 4K block alignment, which limits filesystem-level
dedupe opportunities.  Git repos are strange:  large ones are full of
duplicate blocks, but only 3 or 4 at a time.  By the time a big pack file
has been cut up into extents that can be deduped, we've burned a gigabyte
of IO, created 60 new extents out of 8, and might save 300K of space.

If you have a lot of related git repos, '.git/objects/info/alternates'
is much more efficient than dedupe.  Set up a repo that pulls refs/*
to different remotes from all the other repos on the filesystem, and
set all the other repos' alternates to point to the central repo.
You'll only have each git object once on the filesystem after git gc.
Aaaand you'll also have various issues with git auto-gc occasionally
eating your reflogs.  So maybe this is not for everyone.

> 2) replacing some manually-compressed files with uncompressed
>    versions (let btrfs compression handle it).  I expect that'll
>    let dedupe work better, too.
> 
>    I have a lot of FLAC that could live as uncompressed .sox
>    files.  I expect FLAC to be more efficient on single files,
>    but dedupe could save on cuts that are/were used for editing.
>    I won't miss FLAC MD5 checksums when btrfs has checksums, either.

If they're analog recordings (or have analog in any part of their mix)
they will have nearly zero duplication.  Dedupe only does bit-for-bit
matches, and two clips that are off by one sample, or anything but
an exact integer multiple of 1024 samples, will not be dedupeable.
FLAC is much better than zstd.

VM image files compress and dedupe well.  Better than xz if you
have more than 2 or 3 big ones, but not as good as zpaq (which
has its own deduper built-in, and it's more flexible than btrfs).

> 3) is this also something defrag can help with?

Not really.  defrag can make the balance run faster, but defrag will
require almost the same amount of IO as the balance does.  If you've
already had to remove a disk, it's too late for defrag--it's something you
have to maintain over time so that it's already done before a disk fails.

> Thanks again.
> 
