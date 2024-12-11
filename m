Return-Path: <linux-btrfs+bounces-10220-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7A09EC583
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 08:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C59A167F37
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 07:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE511C5F28;
	Wed, 11 Dec 2024 07:26:47 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53C31C5F00
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 07:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=174.142.148.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733902007; cv=none; b=mNMD/pYmUzRyXjdkpN9/kvLmjj5oDZbLZu3O+y3gagRG0IBGYX+8elHJAZ7zXDPmcV2aUY50Zka+lxy3HNoUXrMSP+2HaLuN9OFS4q5K87fc1TZ6dWTC05bCpZXAJOSQoFhbuMTuhOj4yjADPtfTmZNG4WHUzeN1a4DnRJB3dec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733902007; c=relaxed/simple;
	bh=rRcI8mbXCkUxMz29NeE2R7DiygxSRqLXPNN2lyg7XHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q09D+ZW1PTNBGbKwJ+OCyh58bzQmKa3Bg6mGurlBQM+opFcVQmEhbCzcKNURhnOpzeaaELKif2P8ldLk4Kq+jk3bhC8ZGt9iBEgM6r7Z41YG+JCHXhgdrr3/o62x8+YgCCChPgPHq0ztFocx8fc1maRAClWGhYyGxjXAeC9gOWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=umail.furryterror.org; spf=pass smtp.mailfrom=drax.hungrycats.org; arc=none smtp.client-ip=174.142.148.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=umail.furryterror.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drax.hungrycats.org
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
	id 8350A112DBF6; Wed, 11 Dec 2024 02:26:38 -0500 (EST)
Date: Wed, 11 Dec 2024 02:26:38 -0500
From: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To: kreijack@inwind.it
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Andrei Borzenkov <arvidjaar@gmail.com>, Qu Wenruo <wqu@suse.com>,
	Scoopta <mlist@scoopta.email>, linux-btrfs@vger.kernel.org
Subject: Re: Using btrfs raid5/6
Message-ID: <Z1k-rlpwCqdynfWe@hungrycats.org>
References: <24abfa4c-e56b-4364-a210-f5bfb7c0f40e@gmail.com>
 <a5982710-0e14-4559-82f0-7914a11d1306@gmx.com>
 <d906fbb8-e268-4dbd-a33a-8ed583942580@gmail.com>
 <48fa5494-33f0-4f2a-882d-ad4fd12c4a63@gmx.com>
 <93a52b5f-9a87-420e-b52e-81c6d441bcd7@gmail.com>
 <b5f70481-34a1-4d65-a607-a3151009964d@suse.com>
 <9ae3c85e-6f0b-4e33-85eb-665b3292638e@gmail.com>
 <cfa74363-b310-49f0-b4bf-07a98c1be972@gmx.com>
 <Z1eonzLzseG2_vny@hungrycats.org>
 <08082848-9633-4b3c-9d9d-6135efab8e2d@libero.it>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <08082848-9633-4b3c-9d9d-6135efab8e2d@libero.it>

On Tue, Dec 10, 2024 at 08:36:05PM +0100, Goffredo Baroncelli wrote:
> On 10/12/2024 03.34, Zygo Blaxell wrote:
> > On Sun, Dec 08, 2024 at 06:56:00AM +1030, Qu Wenruo wrote:
> 
> 
> Hi Zygo,
> 
> 
> thank for this excellent analisys
> 
> [...]
> 
> 
> > There's several options to fix the write hole:
> > 
> > 1.  Modify btrfs so it behaves the way Qu thinks it does:  no allocations
> > within a partially filled raid56 stripe, unless the stripe was empty
> > at the beginning of the current transaction (i.e. multiple RMW writes
> > are OK, as long as they all disappear in the same crash event).  This
> > ensures a stripe is never written from two separate btrfs transactions,
> > eliminating the write hole.  This option requires an allocator change,
> > and some rework/optimization of how ordered extents are written out.
> > It also requires more balances--space within partially filled stripes
> > isn't usable until every data block within the stripe is freed, and
> > balances do exactly that.
> 
> My impression  is that this solution would degenerate in a lot of
> waste space, in case of small/frequent/sync writes.

"A lot" is relative.

If we first coalesce small writes, e.g. put a hook in delalloc or ordered
extent handling that defers small writes until there are enough to fill a
stripe, and only get to partial stripe writes during a commit or a fsync,
then there far fewer of these then there are now.  This would be a big
performance gain for btrfs raid5, without even considering the gains
in robustness.

That would leave nodatacow and small fsyncs as the only remaining users
of the RMW mechanism.

In the "fsync 4K" case, we would use an entire stripe width (N devices *
4K), not an entire stripe (N device * 64K).  So for a 9-disk array that
means we use 32K of space to store 4K of data; however, that's smaller
than the space and IO we're already using for the log tree, and much
smaller than the amount of space we use to update csum, extent, and
free-space trees.

In the real world this may not be a problem.  On my RAID5 arrays, all
extents smaller than a RAID stripe combined represent only 1-3% percent
of the total space.  Part of this is self-selection: if I have a workload
that hammers the filesystem with 4K fsyncs, I'm not going to run it on
top of raid5 in the stack because the random write performance will suck.
I'll move that thing to a raid1 filesystem, and use raid5 for bulk data
storage.  On my raid1 filesystems, small extents are 10-15% of the space.

There are probably half a dozen ways to fix this problem, if it is
a problem.  Other filesystems degenerate to raid1 in this case, so they
can lose a lot of space this way.  The existing btrfs allocator doesn't
completely fill block groups even without raid5, and requires balance to
get the space back (unless you're willing to burn CPU all day running
the allocator's search algorithm).  Nobody is currently running OLTP
workloads on btrfs raid5 because of the risk they'll explode from the
write hole.

Off the top of my head.

We only ever need one partially filled stripe, so we can keep it in
memory and add blocks to it as we get more data to write.  For the first
short fsync in a transaction, write a new partially filled stripe to a
new location (this is a full write, no RMW, but some of the data blocks
are empty so they'll be zero-filled) and save the data's location in
the log tree (except for the full write, this is what btrfs does now).

For the next short fsync, write a stripe which contains the first
and second fsync's data, and save the new location of both blocks in
the log tree (since there are only a few of these, they can also be
kept in kernel memory).

For the third short fsync, write a stripe which contains first, second,
and third fsync's data, and save the new location of all 3 blocks in the
log tree.  During transaction commit, write out only the last stripe's
location in the metadata (the first two stripes remain free space).
During log replay after a crash, replay all the add/delete operations up
to the last completed fsync.  There's never a RMW write here, so nothing
ever gets lost in a write hole.  There's never an overwrite of data in
any form, which is better than most journalling writeback schemes where
overwrites are mandatory.

I think we can also hack up balance so that it only relocates extents
that begin or end in partially filled/partially empty raid56 stripes,
with some additional heuristics like "don't move a 60M extent to get 4K
free space."  That would be much faster than moving around all data that
already occupies full stripes.

> > 2.  Add a stripe journal.  Requires on-disk format change to add the
> > journal, and recovery code at startup to replay it.  It's the industry
> > standard way to fix the write hole in a traditional raid5 implementation,
> > so it's the first idea everyone proposes.  It's also quite slow if you
> > don't have dedicated purpose-built hardware for the journal.  It's the
> > only option for closing the write hole on nodatacow files.
> 
> I am not sure about the "quite slow" part. 

"Journal" means writing the same data to two different locations.
That's always slower than writing once to a single location, after all
other optimizations have been done.

bcachefs (grossly oversimplified) writes a raid1 journal, then batches
up and replays the writes as raid5 in the background.  That's great if
you have long periods of idle IO bandwidth, but it can suck a lot if
the background thread doesn't keep up.  It's functionally the same as
using balance to reclaim space on btrfs.

> In the journal only the "small" write should go. The "bigger" write
> should go directly in the "fully empty" stripe (where it is not needed
> a RMW cycle).

Yes, the best first step is to remove as many RMW operations as possible
in the upper layers of the filesystem.  If we don't have RMW, we don't
need to journal or do anything else with it.  We also don't have the
severe performance hit that unnecessary RMW does, either.

> So a typical transaction  would be composed by:
> 
> - update the "partial empty" stripes with a RMW cycle with the data
> that were stored in the journal in the *previous* transaction
> 
> - updated the journal with the new "small" write

A naive design of the journal implementation would store PPL blocks
in metadata, as this is more efficient than storing entire stripes or
copies of data.  Metadata is necessarily non-parity raid, both to avoid
the write hole and for performance reasons, so it can redundantly store
PPL information.

Error handling with PPL might be challenging:  what happens if we need
to correct a corrupt stripe while updating it?

But maybe journalling full stripe writes is a better match for btrfs.
To do a PPL update, the PPL has to be committed first, which would mean it
has to be written out _before_ the transaction that modifies the target
raid5 stripe.  That would mean the updated stripe has to be written
during a later transaction than the one that updated it, so it needs to
be stored somewhere until that can happen.  Given those requirements,
it might be better to simply write out the whole new stripe to a free
stripe in a raid5 data block group, and write a log tree item to copy
that stripe to the destination location.  That starts to sound a lot
like option 1 with the fix above...why overwrite, when you can put data
in the log tree and commit it from there without moving it?

In mdadm-land, PPL burns 30-40% of write performance.  We can assume that
will be higher on btrfs.

For me, if the tradeoff is losing 1.5% of a 100 TB filesystem for
unreclaimed free space vs. a 30% performance hit on all writes with
journalling, I'll just delete one day's worth of snapshots to make that
space available, and never consider journalling again.

Journalling isn't so great for nodatacow either:  the whole point of
nodatacow is to reduce overhead comparable to plain xfs/ext4 on mdadm,
and journalling puts that overhead back in.  I'd expect to see users in
both camps, those who want btrfs to emulate ext4 on mdadm raid5 without
PPL, and those who want btrfs to emulate ext4 on mdadm raid5 with PPL.
So that would add two more options to either mount flags or inode flags.

> - pass-through the "big write" directly to the "fully empty" stripes
> 
> - commit the transaction (w/journal)
> 
> 
> The key point is that the allocator should know if a stripe is fully
> empty or is partially empty. A classic block-based raid doesn't have
> this information. BTRFS has this information.
> 
> 
> 
> BR
> 
> G.Baroncelli
> 
> -- 
> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
> 
> 

