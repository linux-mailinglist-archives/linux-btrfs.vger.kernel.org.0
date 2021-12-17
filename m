Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403264784B7
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Dec 2021 06:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbhLQFxR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Dec 2021 00:53:17 -0500
Received: from drax.kayaks.hungrycats.org ([174.142.148.226]:41404 "EHLO
        drax.kayaks.hungrycats.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230405AbhLQFxQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Dec 2021 00:53:16 -0500
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 9A8CCF92D8; Fri, 17 Dec 2021 00:53:13 -0500 (EST)
Date:   Fri, 17 Dec 2021 00:53:13 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Christoph Anton Mitterer <calestyo@scientia.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: ENOSPC while df shows 826.93GiB free
Message-ID: <Ybwlyba2V74xOZC6@hungrycats.org>
References: <f001f3e81d413ea290722c38b14d95f3f1f52249.camel@scientia.org>
 <25d305e5-c75f-3d71-fc5a-c2019e49bed9@gmx.com>
 <c64be50bdc99b993b910a7ab019af8d552eeb0d4.camel@scientia.org>
 <b7b6a6a7-700e-f83d-dae6-581ed6befbef@gmx.com>
 <3239b2307fae4c7f9e8be9f194d5f3ef470ddb8c.camel@scientia.org>
 <20211207072128.GL17148@hungrycats.org>
 <b913833639d11a0242f781d94452e5e31d7cbf1b.camel@scientia.org>
 <20211207181437.GM17148@hungrycats.org>
 <2e0f4856d8132f39e5d668929f77aac7ed01d476.camel@scientia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e0f4856d8132f39e5d668929f77aac7ed01d476.camel@scientia.org>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 17, 2021 at 12:16:21AM +0100, Christoph Anton Mitterer wrote:
> On Tue, 2021-12-07 at 13:14 -0500, Zygo Blaxell wrote:

[snip]

> Is there some way to see a distribution of the space usage of block
> groups?
> Like some print out that shows me:
> - there are n block groups
> - xx = 100%
> - xx > 90%
> - xx > 80%
> ...
> - xx = 0%
> ?
> 
> That would also give some better idea on how worth it is to balance,
> and which options to use.

Python-btrfs lets you access btrfs data structures from python scripts.
This might even be an existing example.

> > Minimal balance is exactly one data block group, i.e.
> > 
> >         btrfs balance start -dlimit=1 /fs
> > 
> > Run it when unallocated space gets low.  The exact threshold is low
> > enough that the time between new data block group allocations is less
> > than the balance time.
> 
> What the sysadmin of large storage farms needs is something that one
> can run basically always (so even if unallocated space is NOT low),
> which kinda works out of the box and automatically (run via cron?) and
> doesn't impact the IO too much.
> Or one would need some daemon, which monitors unallocated space and
> kicks in if necessary.

That's the theory, and its what packages like btrfsmaintenance try to do.

The practice is...more complicated.

> Does it make sense to use -dusage=xx in addition to -dlimit?
> I mean if space is already tight... would just -dlimit=1 try to find a
> block group that it can balance (because it's usage is low enough)...
> or might it just fail when the first tried one is nearly fully (and not
> enough space is left for that in other block groups)?

The best strategy I've found so far is to choose block groups entirely
at random, because:

	* the benefit is fixed:  after a successful block group balance,
	you will have 1GB of unallocated space on all disks in the
	block group.  In that sense it doesn't matter which block groups
	you balance, only the number that you balance.  If you pick
	a full block group, btrfs will pack the data into emptier block
	groups.  If you pick an empty block group, btrfs will pack the
	data into other empty block groups, or create a new empty block
	group and just shuffle the data around.

	* the cost of computing the cost of relocating a block group is
	proportional to doing the work of relocating the block group.  The
	data movement for 1GB takes 12 seconds on modern spinning drives
	and 1 second or less on NVMe.  The other 60-seconds-to-an-hour
	of relocating a block group is updating all the data references,
	and the parent nodes that reference them, recursively.	If you
	had some clever caching and precomputation scheme you could
	maybe choose a good block group to balance in less time than
	it takes to balance it, but if you predict wrong, you're stuck
	doing the extra work with no benefit.  Also because this is a
	deterministic algorithm, you run into the next problem:

	* choosing block groups by a deterministic algorithm (e.g. number
	of free bytes, percentage of free space, fullest/emptiest device,
	largest vaddr, smallest vaddr) eventually runs into adverse
	selection, and gets stuck on a block group that doesn't fit into
	the available free space, but it's always the "next" block group
	according to the selecting algorithm, so it can make no further
	progress.  Choosing a completely random block group (from the
	target devices where unallocated space is required) may or may
	not succeed, but it's a cheap algorithm to run and it's very
	good at avoiding adverse selection.

> > TBH it's never been a problem--but I run the minimal data balance
> > daily,
> > and scrub every month, and never balance metadata, and have snapshots
> > and dedupe.  Between these they trigger all the necessary metadata
> > allocations.
> 
> I'm also still not really sure why this happened here.
> 
> I've asked the developers of our storage middleware software in the
> meantime, and it seems in fact that dCache does pre-allocate the space
> of files that it wants to write.
> 
> But even then, shouldn't btrfs be able to know how much it will
> generally need for csum metadata?

It varies a lot.  Checksum items have variable overheads as they are
packed into pages.  There is some heuristic based on a constant ratio
but maybe it's a little too low.

It does seem to be prone to rounding error, as I've seen a lot of
users presenting filesystems that have exactly 1GB too little metadata
allocated.

> I can only think of IO patterns where one would end up with too
> aggressive meta-data allocation (e.g. when writing lots of directories
> or XATTRS) and where not enough data block groups are left.
> 
> But the other way round?
> If one writes very small files (so that they are inlined) -> meta-data
> should grow.
> 
> If one writes non-inlined files, regardless of whether small or big...
> shouldn't it always be clear how much space could be needed for csum
> meta-data, when a new block group is allocated for data and if that
> would be fully written?

It's not even clear how much space is needed for the data.  Extents are
immutable, so if you overwrite part of a large extent, you will need more
space for the new data even though the old data is no longer reachable
through any file.

Checksums can vary in density from 779 (if there are a lot of holes in
files) to 4090 blocks per metadata page (if they're all contiguous).
That's a 5:1 size ratio between the extremes.

> > That's possible (and there are patches attempting to address it).
> > We don't want to be too aggressive, or the disk fills up with unused
> > metadata allocations...but we need to be about 5 block groups more
> > aggressive than we are now to handle special cases like "mount and
> > write until full without doing any backups or maintenance."
> 
> Wouldn't a "simple" (at least in my mind ;-) ) solution be, that:
> - if the case arises, that either data or meta-data block groups are
>   full
> - and not unallocated space is left
> - and if the other kind of block groups has plenty of free space left
>   (say in total something like > 10 times the size of a block group...
>   or maybe more (depending on the total filesystem size), cause one
>   probably doesn't want to shuffle loads of data around, just for the
>   last 0.005% to be squeezed out.)
> then:
> - btrfs automatically does the balance?
>   Or maybe something "better" that also works when it would need to
>   break up extents?

The problem is in the definitions of things like "plenty" and "not a lot",
and expectations like "last 0.005%."  We all know balancing automatically
solves the problem, but all the algorithms we use to trigger it are wrong
in some edge case.

Balance is a big and complex thing that operates on big filesystem
allocation objects, too big to run automatically at the moment a critical
failure is detected.  The challenge is to predict the future well enough
to know when to run balance to avoid it.  In these early days, everybody
seems to be rolling their own solutions and discovering surprising
implications of their choices.

Also there are much simpler solutions, like "put all the metadata on
SSD", where the administrator picks the metadata size and btrfs works
(or doesn't work) with it.

Rewriting the extent tree is also on the table, though people have
recently worked on that (extent tree v2) and the ability to change
allocated extent lengths after the fact was dropped from the proposal.

> If there are cases where one doesn't like that automatic shuffling, one
> could make it opt-in via some mount option.

In theory a garbage collection tool can be written today to manage
this, but it's only a theory until somebody writes it.  It's possible
to break up extents by running a combination of defrag and dedupe over
them using existing userspace interfaces.  Once such a tool exists, the
kernel interfaces could be improved for performance.  That tool would
essentially be data balance in userspace, so the kernel data balance
would no longer be needed.  It's not clear that this would be able to
perform any better than the current data balance scheme, though, except
for being slightly more flexible on extremely full filesystems.

> > A couple more suggestions (more like exploitable side-effects):
> > 
> >         - Run regular scrubs.  If a write occurs to a block group
> >         while it's being scrubbed, there's an extra metadata block
> >         group allocation.
> 
> But writes during scrubs would only happen when it finds and corrupted
> blocks?

Each block group is made read-only while it is scrubbed to prevent
modification while scrub verifies it.  If some process wants to modify
data on the filesystem during the scrub, it must allocate its new data
in some block group that is not being scrubbed.  If all the existing
block groups are either full or read-only, then a new block group must be
allocated.  If this is not possible, the writing process will hit ENOSPC.
In other words, scrub effectively decreases free space while it runs by
locking some of it away temporarily, and this forces btrfs to allocate
a little more space for data and metadata.

This is one of the many triggers for btrfs to require and allocate another
GB of metadata apparently at random.  It's never random, but there are
a lot of different triggering conditions in the implementation.

Only a few spare block groups are usually needed, so people running
scrub regularly work around the metadata problem without knowing they're
working around a problem.

> Thanks,
> Chris.
> 
