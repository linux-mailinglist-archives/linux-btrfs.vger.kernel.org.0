Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAC6B6A28
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Sep 2019 20:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbfIRSAu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 18 Sep 2019 14:00:50 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:48734 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfIRSAu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Sep 2019 14:00:50 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id ACF24430D88; Wed, 18 Sep 2019 14:00:49 -0400 (EDT)
Date:   Wed, 18 Sep 2019 14:00:49 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     General Zed <general-zed@zedlx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Feature requests: online backup - defrag - change RAID level
Message-ID: <20190918180049.GI24379@hungrycats.org>
References: <20190912051904.GD22121@hungrycats.org>
 <20190912172321.Horde.oyDNseL4IVWz-QYWBqgXqjO@server53.web-hosting.com>
 <20190914041255.GJ22121@hungrycats.org>
 <20190916074251.Horde.bsBwDU_QYlFY0p-a1JzxZrm@server53.web-hosting.com>
 <20190917004916.GD24379@hungrycats.org>
 <20190916223039.Horde.HZvhrBkQsN12DF6IDemvio6@server53.web-hosting.com>
 <20190917053055.GG24379@hungrycats.org>
 <20190917060724.Horde.2JvifSdoEgszEJI8_4CFSH8@server53.web-hosting.com>
 <20190917234044.GH24379@hungrycats.org>
 <20190918003742.Horde.uCadf9qXuYdCVqBfASzDeuN@server53.web-hosting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190918003742.Horde.uCadf9qXuYdCVqBfASzDeuN@server53.web-hosting.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 18, 2019 at 12:37:42AM -0400, General Zed wrote:
> It just postpones the inevitable, but you missed the point. The point of
> shutting down dedupe is to avoid nasty bugs caused by dedupe-defrag
> interaction.

They are the same bugs you'll have to fix anyway.  Dedupe isn't
particularly special or different from the way that other btrfs write
operations work, and nobody wants to be locked out of their filesystem
during a big data relocation operation.  Even balance doesn't prevent
concurrent filesystem modification--it allows concurrent changes, and
restarts processing to take care of them when necessary.

> The share-preserving defrag shouldn't interfere with dedupe because defrag
> is run on-demand, and it should then shut down dedupe until it has
> completed. Therefore, the issues it causes to dedupe are only temporary (and
> minor, really).

On big filesystems fragmentation is a _continuous_ problem that gets
more expensive to fix the longer it is neglected.  So I'd naturally
expect both dedupe and defrag agents to be active at the same time,
or very closely interleaved, with concurrent data updates as well.
VM images and database files are hotspots for all three activities.

I'd expect a sysadmin interface more like balance, where the interface
looks like "run defrag now, relocating at most 20GB of data" and defrag
decides (possibly with hints from the admin) which 20GB of data out of
50TB of filesystem that should be.  Or I'd set the defrag limit to 1GB
per run, and run it as many times as possible in a maintenance window
until either the time runs out or defrag says "no further optimization
is practical or possible, you can stop looping now."

For small systems it doesn't matter--admin says "relocate at most
1TB of data" and new-and-improved defrag says "easy, that's the whole
filesystem."  But small systems are not very interesting.  On small
systems I can just run the current reflink-breaking file-oriented
recursive defrag and dedupe at the same time.  Dedupe can put the sharing
back almost as fast as current reflink-breaking defrag can break it,
the whole thing finishes in minutes, and I don't even bother calculating
how many iops were wasted because they were all free.

> > I guess the extent-merge call could be augmented with an address hint
> > for allocation, but experiments so far have indicated that the possible
> > gains are marginal at best given the current btrfs allocator behaviour,
> > so I haven't bothered pursuing that.
> 
> The "batch-update" from defrag should certainly trumps any "extent-merge".
> The defrag will do it all for you, you just supply the defrag with a list of
> extents that need to be defragmented.

Sure...either way, it's an ioctl that takes a list of extents to be
defragmented as an argument, and produces an output locally optimized
for minimal fragmentation, updating and removing references to the old
locations, etc.  Maybe it's a single list input and single extent output;
maybe it's a list of lists which produces multiple extent outputs; maybe
you can call it multiple times per commit and the kernel batches them up
when it does a flush; maybe it takes allocation hints in the argument
because the user already knows the best free space location; maybe it
finds its own contiguous space; maybe you pass it a file descriptor and
offset to a O_TMPFILE file where you already allocated the destination
area with fallocate; maybe there's two separate ioctls, one sets up the
destination area and the other moves extent data into it.  You can call
that ioctl(s) 'batch-update' or 'extent-merge' or whatever you like.
Figure out the requirements and make a proposal, we can see where the
proposals overlap or decompose them into common components.

Other questions you've asked indicate you are thinking of doing the bulk
of the defrag work in the kernel.  This is not a good idea.  It's hard
to allocate and effectively use large amounts of memory in the kernel
(for developers and users alike), and the in-kernel btrfs maintenance
tools so far have proven to make desirable administrative functions like
IO bandwidth management difficult to impossible.  Once code is integrated
into the kernel, it has to be kept around more or less forever, even if
it is half-finished, obviously awful, and nobody can use it seriously
without major redesign.  The current defrag ioctl is a prime example
of that, but balance and send are also good examples of things that
would have been better outside the kernel if the right interfaces had
been available at the time they were designed.  (Balance could also be
implemented in userspace with a batch-update data relocation ioctl, and
could easily avoid several problems with the current kernel implementation
in the process.)

It's much easier to do big-memory operations in userspace (not just the
technical operations themselves, but also getting the code accepted
in the kernel).  There are already interfaces for rapid ingestion
of the necessary metadata from userspace, so defrag's needs are
covered there.  What is currently missing is good kernel interfaces
for rapid implementation of the output of data relocation algorithms
(i.e.  ioctls to move extent data precisely as instructed and don't
break references).  Leave the kernel to physically move the data and
update metadata once userspace knows where it should go, but don't make
the kernel try to plan stuff or make decisions on its own--that doesn't
end well.  Minimizing the kernel code footprint will also make it much
easier to avoid crashes and deadlocks (or at least make them harmless
should they occur).  btrfs has had more deadlock bugs than any two
other filesystems on Linux combined, so designs that minimize the risk
of adding new deadlocks will be preferred.

I don't think you can gain much by throwing kernel memory at
predetermining extent moves, given the current on-disk structure of btrfs.
Existing sharing-preserving extent move operations in btrfs are currently
dominated by _read_ IO times--the writes are fast mostly-contiguous
flushes, while the reads are slow random accesses.  The kernel already
caches reads well already, there are just a lot of them to do when
doing anything related to extent backrefs.  On small filesystems the
whole metadata fits comfortably in 10% of RAM (below default page cache
eviction thresholds), and on filesystems of that size you can already
do full balances in minutes, there is no problem to be solved there.
You can prefetch metadata into cache RAM by running TREE_SEARCH_V2 on it,
if you think that will help.

Consider the XFS kernel interfaces for defrag.  It may be possible to
implement those on btrfs, then make minor modifications to xfs_fsr so it
can do defrag on btrfs (probably not efficiently--xfs_fsr likely assumes
extent splits are possible without moving data--but it's a good example
of a kernel interface designed for defrag nonetheless).
