Return-Path: <linux-btrfs+bounces-10176-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E761D9EA53C
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 03:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFDAB16268D
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 02:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC2419D88F;
	Tue, 10 Dec 2024 02:39:18 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F245233129
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2024 02:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=174.142.148.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733798358; cv=none; b=LNungsrBx0O9cofVNidstoFdcfFIQMoIggohRlFsoU+/ozLnYnT848YdnvXo7nT5ZEUgfL+O36zSAHIc2fxH+yfMgW2aCsUfJrNVAcgrzsfUXhw3vNp3TbNVw9wW0N5htWnOUNqDtBp9DMjF1OO8dHhtrXsxAi3yzdoT+wA8YzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733798358; c=relaxed/simple;
	bh=TD6n18VkywY/8N7AEYwg3s70OBhNy6EDwwiunbRmRUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ya3k2t7S8qU1GR9HoLE6X3Lu6ru/Cnd9a0HnHHM3bkXiZnQxyLAOV08t2syTMQ271F6w1/qLN0SwBEsRPcVmVnxw7QEn5WJgAtbVOea3pep2gjNX095SbGQWIDf/ZEiP3UPwCsr/vuaJzni8Gs+OKDGufvnHB6EnNCh4csBUgTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=umail.furryterror.org; spf=pass smtp.mailfrom=drax.hungrycats.org; arc=none smtp.client-ip=174.142.148.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=umail.furryterror.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drax.hungrycats.org
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
	id C00EE1128B5D; Mon,  9 Dec 2024 21:34:07 -0500 (EST)
Date: Mon, 9 Dec 2024 21:34:07 -0500
From: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Andrei Borzenkov <arvidjaar@gmail.com>, Qu Wenruo <wqu@suse.com>,
	Scoopta <mlist@scoopta.email>, linux-btrfs@vger.kernel.org
Subject: Re: Using btrfs raid5/6
Message-ID: <Z1eonzLzseG2_vny@hungrycats.org>
References: <97b4f930-e1bd-43d0-ad00-d201119df33c@scoopta.email>
 <45adaefb-b0fe-4925-bc83-6d1f5f65a6dc@suse.com>
 <24abfa4c-e56b-4364-a210-f5bfb7c0f40e@gmail.com>
 <a5982710-0e14-4559-82f0-7914a11d1306@gmx.com>
 <d906fbb8-e268-4dbd-a33a-8ed583942580@gmail.com>
 <48fa5494-33f0-4f2a-882d-ad4fd12c4a63@gmx.com>
 <93a52b5f-9a87-420e-b52e-81c6d441bcd7@gmail.com>
 <b5f70481-34a1-4d65-a607-a3151009964d@suse.com>
 <9ae3c85e-6f0b-4e33-85eb-665b3292638e@gmail.com>
 <cfa74363-b310-49f0-b4bf-07a98c1be972@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cfa74363-b310-49f0-b4bf-07a98c1be972@gmx.com>

On Sun, Dec 08, 2024 at 06:56:00AM +1030, Qu Wenruo wrote:
> 在 2024/12/7 18:07, Andrei Borzenkov 写道:
> > 06.12.2024 07:16, Qu Wenruo wrote:
> > > 在 2024/12/6 14:29, Andrei Borzenkov 写道:
> > > > 05.12.2024 23:27, Qu Wenruo wrote:
> > > > > 在 2024/12/6 03:23, Andrei Borzenkov 写道:
> > > > > > 05.12.2024 01:34, Qu Wenruo wrote:
> > > > > > > 在 2024/12/5 05:47, Andrei Borzenkov 写道:
> > > > > > > > 04.12.2024 07:40, Qu Wenruo wrote:
> > > > > > > > > 
> > > > > > > > > 在 2024/12/4 14:04, Scoopta 写道:
> > > > > > > > > > I'm looking to deploy btfs raid5/6 and have read some of the
> > > > > > > > > > previous
> > > > > > > > > > posts here about doing so "successfully." I want to make sure I
> > > > > > > > > > understand the limitations correctly. I'm looking to replace an
> > > > > > > > > > md+ext4
> > > > > > > > > > setup. The data on these drives is replaceable but obviously
> > > > > > > > > > ideally I
> > > > > > > > > > don't want to have to replace it.
> > > > > > > > > 
> > > > > > > > > 0) Use kernel newer than 6.5 at least.
> > > > > > > > > 
> > > > > > > > > That version introduced a more comprehensive check for any RAID56
> > > > > > > > > RMW,
> > > > > > > > > so that it will always verify the checksum and rebuild when
> > > > > > > > > necessary.
> > > > > > > > > 
> > > > > > > > > This should mostly solve the write hole problem, and we even have
> > > > > > > > > some
> > > > > > > > > test cases in the fstests already verifying the behavior.
> > > > > > > > 
> > > > > > > > Write hole happens when data can *NOT* be rebuilt because data is
> > > > > > > > inconsistent between different strips of the same stripe. How btrfs
> > > > > > > > solves this problem?
> > > > > > > 
> > > > > > > An example please.
> > > > > > 
> > > > > > You start with stripe
> > > > > > 
> > > > > > A1,B1,C1,D1,P1
> > > > > > 
> > > > > > You overwrite A1 with A2
> > > > > 
> > > > > This already falls into NOCOW case.
> > > > > 
> > > > > No guarantee for data consistency.
> > > > > 
> > > > > For COW cases, the new data are always written into unused slot, and
> > > > > after crash we will only see the old data.
> > > > 
> > > > Do you mean that btrfs only does full stripe write now? As I recall from
> > > > the previous discussions, btrfs is using fixed size stripes and it can
> > > > fill unused strips. Like
> > > > 
> > > > First write
> > > > 
> > > > A1,B1,...,...,P1
> > > > 
> > > > Second write
> > > > 
> > > > A1,B1,C2,D2,P2
> > > > 
> > > > I.e. A1 and B1 do not change, but C2 and D2 are added.
> > > > 
> > > > Now, if parity is not updated before crash and D gets lost we have
> > > 
> > > After crash, C2/D2 is not referenced by anyone.
> > > So we won't need to read C2/D2/P2 because it's just unallocated space.
> > 
> > You do need to read C2/D2 to build parity and to reconstruct any missing
> > block. Parity no more matches C2/D2. Whether C2/D2 are actually
> > referenced by upper layers is irrelevant for RAID5/6.
> 
> Nope, in that case whatever garbage is in C2/D2, btrfs just do not care.
> 
> Just try it yourself.
> 
> You can even mkfs without discarding the device, then btrfs has garbage
> for unwritten ranges.
> 
> Then do btrfs care those unallocated space nor their parity?
> No.
> 
> Btrfs only cares full stripe that has at least one block being referred.
> 
> For vertical stripe that has no sector involved, btrfs treats it as
> nocsum, aka, as long as it can read it's fine. If it can not be read
> from the disk (missing dev etc), just use the rebuild data.
> 
> Either way for unused sector it makes no difference.

The assumption Qu made here is that btrfs never writes data blocks to the
same stripe from two or more different transactions, without freeing and
allocating the entire stripe in between.  If that assumption were true,
there would be no write hole in the current implementation.

The reality is that btrfs does exactly the opposite, as in Andrei's second
example.  This causes potential data loss of the first transaction's
data if the second transaction's write is aborted by a crash.  After the
first transaction, the parity and uninitialized data blocks can be used
to recover any data block in the first transaction.  When the second
transaction is aborted with some but not all of the blocks updated, the
parity will no longer be usable to reconstruct the data blocks from _any_
part of the stripe, including the first transaction's committed data.

Technically, in this event, the second transaction's data is _also_
lost, but as Qu mentioned above, that data isn't part of a committed
transaction, so the damaged data won't appear in the filesystem after a
crash, corrupted or otherwise.

The potential data loss does not become actual data loss until the stripe
goes into degraded mode, where the out-of-sync parity block is needed to
recover a missing or corrupt data block.  If the stripe was already in
degraded mode during the crash, data loss is immediate.

If the drives are all healthy, the parity block can be recomputed
by a scrub, as long as the scrub is completed between a crash and a
drive failure.

If drives are missing or corrupt and parity hasn't been properly updated,
then data block reconstruction cannot occur.  btrfs will reject the
reconstructed block when its csum doesn't match, resulting in an
uncorrectable error.

There's several options to fix the write hole:

1.  Modify btrfs so it behaves the way Qu thinks it does:  no allocations
within a partially filled raid56 stripe, unless the stripe was empty
at the beginning of the current transaction (i.e. multiple RMW writes
are OK, as long as they all disappear in the same crash event).  This
ensures a stripe is never written from two separate btrfs transactions,
eliminating the write hole.  This option requires an allocator change,
and some rework/optimization of how ordered extents are written out.
It also requires more balances--space within partially filled stripes
isn't usable until every data block within the stripe is freed, and
balances do exactly that.

2.  Add a stripe journal.  Requires on-disk format change to add the
journal, and recovery code at startup to replay it.  It's the industry
standard way to fix the write hole in a traditional raid5 implementation,
so it's the first idea everyone proposes.  It's also quite slow if you
don't have dedicated purpose-built hardware for the journal.  It's the
only option for closing the write hole on nodatacow files.

3.  Add a generic remapping layer for all IO blocks to avoid requiring
RMW cycles.  This is the raid-stripe-tree feature, a brute-force approach
that makes RAID profiles possible on ZNS drives.  ZNS drives have similar
but much more strict write-ordering constraints than traditional raid56,
so if the raid stripe tree can do raid5 on ZNS, it should be able to
handle CMR easily ("efficiently" is a separate question).

4.  Replace the btrfs raid5 profile with something else, and deprecate
the raid5 profile.  I'd recommend not considering that option until
after someone delivers a complete, write-hole-free replacement profile,
ready for merging.  The existing raid5 is not _that_ hard to fix, we
already have 3 well-understood options, and one of them doesn't require
an on-disk format change.


Option 1 is probably the best one:  it doesn't require on-disk format
changes, only changes to the way kernels manage future writes.  Ideally,
the implementation includes an optimization to collect small extent writes
and merge them into full-stripe writes, which will make those _much_
faster on raid56.  The current implementation does multiple unnecessary
RMW cycles when writing multiple separate data extents to the same
stripe, even when the extents are allocated within a single transaction
and collectively the extents fill the entire stripe.

Option 1 won't fix nodatacow files, but that's only a problem if you
use nodatacow files.

I suspect options 2 and 3 have so much overhead that they are far
slower than option 1, even counting the extra balances option 1 requires.
With option 1, the extra overhead is in a big batch you can run overnight,
while options 2 and 3 impose continuous overhead on writes, and for
option 3, on reads as well.

> > > So still wrong example.
> > > 
> > 
> > It is the right example, you just prefer to ignore this problem.
> 
> Sure sure, whatever you believe.
> 
> Or why not just read the code on how the current RAID56 works?

The above is a summary of the state of raid56 when I last read the code
in depth (from circa v6.6), combined with direct experience from running
a small fleet of btrfs raid5 arrays and observing how they behave since
2016, and review of the raid-stripe-tree design docs.

> > > Remember we should discuss on the RMW case, meanwhile your case doesn't
> > > even involve RMW, just a full stripe write.
> > > 
> > > > 
> > > > A1,B1,C2,miss,P1
> > > > 
> > > > with exactly the same problem.
> > > > 
> > > > It has been discussed multiple times, that to fix it either btrfs has to
> > > > use variable stripe size (basically, always do full stripe write) or
> > > > some form of journal for pending updates.
> > > 
> > > If taking a correct example, it would be some like this:
> > > 
> > > Existing D1 data, unused D2 , P(D1+D2).
> > > Write D2 and update P(D1+D2), then power loss.
> > > 
> > > Case 0): Power loss after all data and metadata reached disk
> > > Nothing to bother, metadata already updated to see both D1 and D2,
> > > everything is fine.
> > > 
> > > Case 1): Power loss before metadata reached disk
> > > 
> > > This means we will only see D1 as the old data, have no idea there is
> > > any D2.
> > > 
> > > Case 1.0): both D2 and P(D1+D2) reached disk
> > > Nothing to bother, again.
> > > 
> > > Case 1.1): D2 reached disk, P(D1+D2) doesn't
> > > We still do not need to bother anything (if all devices are still
> > > there), because D1 is still correct.
> > > 
> > > But if the device of D1 is missing, we can not recover D1, because D2
> > > and P(D1+D2) is out of sync.
> > > 
> > > However I can argue this is not a simple corruption/power loss, it's two
> > > problems (power loss + missing device), this should count as 2
> > > missing/corrupted sectors in the same vertical stripe.

A raid56 array must still tolerate power failures while it is degraded.
This is table stakes for a modern parity raid implementation.

The raid56 write hole occurs when it is possible for an active stripe
to enter an unrecoverable state.  This is an implementation bug, not a
device failure.

Leaving an inactive stripe in a corrupted state after a crash is OK.
Never modifying any active stripe, so they are never corrupted, is OK.
btrfs corrupts active stripes, which is not OK.

Hopefully this is clear.

> > This is the very definition of the write hole. You are entitled to have
> > your opinion, but at least do not confuse others by claiming that btrfs
> > protects against write hole.
> > 
> > It need not be the whole device - it is enough to have a single
> > unreadable sector which happens more often (at least, with HDD).
> > 
> > And as already mentioned it need not happen at the same (or close) time.
> > The data corruption may happen days and months after lost write. Sure,
> > you can still wave it off as a double fault - but if in case of failed
> > disk (or even unreadable sector) administrator at least gets notified in
> > logs, here it is absolutely silent without administrator even being
> > aware that this stripe is no more redundant and so administrator cannot
> > do anything to fix it.
> > 
> > > As least btrfs won't do any writeback to the same vertical stripe at all.
> > > 
> > > Case 1.2): P(D1+D2) reached disk, D2 doesn't
> > > The same as case 1.1).
> > > 
> > > Case 1.3): Neither D2 nor P(D1+D2) reached disk
> > > 
> > > It's the same as case 1.0, even missing D1 is fine to recover.
> > > 
> > > 
> > > So if you believe powerloss + missing device counts as a single device
> > > missing, and it doesn't break the tolerance of RAID5, then you can count
> > > this as a "write-hole".
> > > 
> > > But to me, this is not a single error, but two error (write failure +
> > > missing device), beyond the tolerance of RAID5.
> > > 
> > > Thanks,
> > > Qu
> > 
> 
> 

