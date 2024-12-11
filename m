Return-Path: <linux-btrfs+bounces-10264-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E30A9ED6AF
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 20:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDA532818F8
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 19:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739841DD885;
	Wed, 11 Dec 2024 19:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inwind.it header.i=@inwind.it header.b="fwDbCcsP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-16.italiaonline.it [213.209.10.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E51259491
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 19:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.10.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733946109; cv=none; b=eq8PmWU5FMX1mBVl0yYbCtHSyfp4SvP62yH63vAZsOd96bkV9t2obUgzBV3RNT07rk5excTdJVPf6ogSx35vB0+v/df/tbrPvRgAqZOC3zYWWHRO8PwFQEGCDRWK1XBqebREKeI/XgSZpsQzdPeYNata82ZLrC9KC5wqqPseSjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733946109; c=relaxed/simple;
	bh=ic2AdQ65yM53C9pC5q9kdUNv+egk1dE/gLDnTiGAgJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oLomTgWKdNGLpYy7a3EWSuQ/PPTTTrS05wJC4H9/8xoMawfK8D0Y7n0gWd1a+IbAAB57N4ZAcL9jMfhIo4B8o7MccJeEcbkgws4Zk4h/D2mDNos5mH7aS39j8M7d+8sBKFkmq75T7RS3iXDZBg1nzLDn8n3SaH2kEpRsaZcuRHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=inwind.it; spf=pass smtp.mailfrom=inwind.it; dkim=pass (2048-bit key) header.d=inwind.it header.i=@inwind.it header.b=fwDbCcsP; arc=none smtp.client-ip=213.209.10.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=inwind.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inwind.it
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-16.iol.local with ESMTPSA
	id LSY5tj4YnyzhsLSY5tkG5F; Wed, 11 Dec 2024 20:39:05 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
	t=1733945945; bh=x+Z2YP2lEXwLE6zu0SNGrOqX7cgNbWCEEC+I8Bo9cCk=;
	h=From;
	b=fwDbCcsPtt8S3UW68hm9SYm/Tc8o4thfnarYqTsHZqNlIVrlho9JCFH8W5CuDx9WU
	 kxS27gWoUWWWfQnvwxvQrg4upR/bispNSGnoPDYhLNITlVAkw77DHfHbiOe3j3Tu6G
	 LWiV0j8Haju4Z2rCxmyp2L3xRQoIw4os2zpTlwp1G3XEjOAONnBt3Gj9UAlb4LJXAL
	 tzqx9OjhnKHJWsixanAezziBb1L1Nw7wLVeHBD89pc6or4liqtewZuJueXO9s5w1TY
	 2lSH9dXBXmjJSeTX4FouGmvaLcxg4mAn1r8pCtCDJGSoZkNfxFG0W2R0M/KdbthItX
	 phjmmsFeG6jRA==
X-CNFS-Analysis: v=2.4 cv=XJb7ShhE c=1 sm=1 tr=0 ts=6759ea59 cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=UHn8HBmbSe9w8Yf75cMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
Message-ID: <014edba0-5edc-4c71-9a6b-35a0227adb30@inwind.it>
Date: Wed, 11 Dec 2024 20:39:04 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: Using btrfs raid5/6
To: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Andrei Borzenkov
 <arvidjaar@gmail.com>, Qu Wenruo <wqu@suse.com>,
 Scoopta <mlist@scoopta.email>, linux-btrfs@vger.kernel.org
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
 <Z1k-rlpwCqdynfWe@hungrycats.org>
Content-Language: en-US
From: Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <Z1k-rlpwCqdynfWe@hungrycats.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfGhktX3CVmC0YrwSM9WeTOk7LoaVs3iEPH5MmcVKq3UF6CWmCu+Sz+xhNVG0HHZS7FVSdpFAiCXBfYyzdrf8dxhdNhOAdcbpf9mwjmMWdfg4HxQgL3JC
 oyOY8O+CJII8oZyr/OuXQF0U1ZKEODpxwtZF2xGB1pofIep9R1Nzx4Q13jlQgNn4X6IuBdkN4Dl5R8aPSWpIabjnyNEti7FigK96O+PhOxd+UQXMLApNGM79
 LKY+DRmXoFqCT7hTU4aW5kY2/4NNFXIG6Gfce/qSscFYTuGxbqABtdi1hwPJVQcDIfvh/quOK+BmUuZpcdXW+YoGEkK71MZCtyZy5CDRIJHJNu/tEG8yjx9y
 HMsZMCzc

On 11/12/2024 08.26, Zygo Blaxell wrote:
> On Tue, Dec 10, 2024 at 08:36:05PM +0100, Goffredo Baroncelli wrote:
>> On 10/12/2024 03.34, Zygo Blaxell wrote:
>>> On Sun, Dec 08, 2024 at 06:56:00AM +1030, Qu Wenruo wrote:
>>
>>
>> Hi Zygo,
>>
>>
>> thank for this excellent analisys
>>
>> [...]
>>
>>
>>> There's several options to fix the write hole:
>>>
>>> 1.  Modify btrfs so it behaves the way Qu thinks it does:  no allocations
>>> within a partially filled raid56 stripe, unless the stripe was empty
>>> at the beginning of the current transaction (i.e. multiple RMW writes
>>> are OK, as long as they all disappear in the same crash event).  This
>>> ensures a stripe is never written from two separate btrfs transactions,
>>> eliminating the write hole.  This option requires an allocator change,
>>> and some rework/optimization of how ordered extents are written out.
>>> It also requires more balances--space within partially filled stripes
>>> isn't usable until every data block within the stripe is freed, and
>>> balances do exactly that.
>>
>> My impression  is that this solution would degenerate in a lot of
>> waste space, in case of small/frequent/sync writes.
> 
> "A lot" is relative.
> 
> If we first coalesce small writes, e.g. put a hook in delalloc or ordered
> extent handling that defers small writes until there are enough to fill a
> stripe, and only get to partial stripe writes during a commit or a fsync,
> then there far fewer of these then there are now.  This would be a big
> performance gain for btrfs raid5, without even considering the gains
> in robustness.

Are you considered the "write in the middle of a file case" ? In this case
the old data will be an hole in the stripe that will not filled until
a re - balance. My impression is that this approach for some workload will
degenerate badly with an high number of half empty stripe (more below)

[..]
> 
> In the real world this may not be a problem.  On my RAID5 arrays, all
> extents smaller than a RAID stripe combined represent only 1-3% percent
> of the total space.  Part of this is self-selection: if I have a workload
> that hammers the filesystem with 4K fsyncs, I'm not going to run it on
> top of raid5 in the stack because the random write performance will suck.
> I'll move that thing to a raid1 filesystem, and use raid5 for bulk data
> storage.  On my raid1 filesystems, small extents are 10-15% of the space.

1-3% ? In effect I expected a lot more. Do you perform regular balances ?

> There are probably half a dozen ways to fix this problem, if it is
> a problem.  Other filesystems degenerate to raid1 in this case, so they
> can lose a lot of space this way.  The existing btrfs allocator doesn't
> completely fill block groups even without raid5, and requires balance to
> get the space back (unless you're willing to burn CPU all day running
> the allocator's search algorithm).  Nobody is currently running OLTP
> workloads on btrfs raid5 because of the risk they'll explode from the
> write hole.

The hard part of a filesystem is to not suck for *any workload* even at the
cost to not be the best for *all workloads*.

> 
> Off the top of my head.
> 
> We only ever need one partially filled stripe, so we can keep it in
> memory and add blocks to it as we get more data to write.  For the first
> short fsync in a transaction, write a new partially filled stripe to a
> new location (this is a full write, no RMW, but some of the data blocks
> are empty so they'll be zero-filled) and save the data's location in
> the log tree (except for the full write, this is what btrfs does now).
> 
> For the next short fsync, write a stripe which contains the first
> and second fsync's data, and save the new location of both blocks in
> the log tree (since there are only a few of these, they can also be
> kept in kernel memory).
> 
> For the third short fsync, write a stripe which contains first, second,
> and third fsync's data, and save the new location of all 3 blocks in the
> log tree.  During transaction commit, write out only the last stripe's
> location in the metadata (the first two stripes remain free space).
> During log replay after a crash, replay all the add/delete operations up
> to the last completed fsync.  There's never a RMW write here, so nothing
> ever gets lost in a write hole.  There's never an overwrite of data in
> any form, which is better than most journalling writeback schemes where
> overwrites are mandatory.

If I understood correctly, to write 3 short data+fsync, you write 1+2+3=6
fsync data: 2 times the data and 3 fsync. This is the same cost of a journal.

> 
> I think we can also hack up balance so that it only relocates extents
> that begin or end in partially filled/partially empty raid56 stripes,
> with some additional heuristics like "don't move a 60M extent to get 4K
> free space."  That would be much faster than moving around all data that
> already occupies full stripes.
> 
>>> 2.  Add a stripe journal.  Requires on-disk format change to add the
>>> journal, and recovery code at startup to replay it.  It's the industry
>>> standard way to fix the write hole in a traditional raid5 implementation,
>>> so it's the first idea everyone proposes.  It's also quite slow if you
>>> don't have dedicated purpose-built hardware for the journal.  It's the
>>> only option for closing the write hole on nodatacow files.
>>
>> I am not sure about the "quite slow" part.
> 
> "Journal" means writing the same data to two different locations.
> That's always slower than writing once to a single location, after all
> other optimizations have been done.

Why you say write only once ? In the example above, you write the data
two times.

> 
> bcachefs (grossly oversimplified) writes a raid1 journal, then batches
> up and replays the writes as raid5 in the background.  That's great if
> you have long periods of idle IO bandwidth, but it can suck a lot if
> the background thread doesn't keep up.  It's functionally the same as
> using balance to reclaim space on btrfs.
> 

My understanding is that, more or less all the proposed solution try to
reduce the number of RMW cycles putting the data in a journal/log/raid1 bg.

Then the data is move in a raid5/6 bg. The main difference is how big is this
journal. Depending by this size, a "balance" is required more or less frequently.

The current btrfs design, is based on the fact that the raid profile is managed at
the block-group level, and it is completely independent by the btree/extents
managements. This scaled very well with the different raid model until the raid
parity based. This because the COW model (needed to maintain the sync between the
checksum and the data) is not enough to maintain the sync between the parity and the data.

Time to time I thought a variable stripe length, where the parity is stored
inside the extent at fixed offset, where this offset depend by the number
of disk and the height of the stripe.

Having the parity inside the extents would solve this part of the problem, until you need
to update in the middle a file. In this case the thing became very complex until
the point that it is easier to write a full stripe.


>> In the journal only the "small" write should go. The "bigger" write
>> should go directly in the "fully empty" stripe (where it is not needed
>> a RMW cycle).
> 
> Yes, the best first step is to remove as many RMW operations as possible
> in the upper layers of the filesystem.  If we don't have RMW, we don't
> need to journal or do anything else with it.  We also don't have the
> severe performance hit that unnecessary RMW does, either.
> 
>> So a typical transaction  would be composed by:
>>
>> - update the "partial empty" stripes with a RMW cycle with the data
>> that were stored in the journal in the *previous* transaction
>>
>> - updated the journal with the new "small" write
> 
> A naive design of the journal implementation would store PPL blocks
> in metadata, as this is more efficient than storing entire stripes or
> copies of data.  Metadata is necessarily non-parity raid, both to avoid
> the write hole and for performance reasons, so it can redundantly store
> PPL information.
> 
> Error handling with PPL might be challenging:  what happens if we need
> to correct a corrupt stripe while updating it?

I think the same thing that happens when you do a standard RMW cycle with a corruption:
pause the transaction: read the full stripe and the data checksum, try all the
possible combination between data and parity until you get good data, rewrite the stripe
(passing by a journal !); resume the transaction.
> 
> But maybe journalling full stripe writes is a better match for btrfs.
> To do a PPL update, the PPL has to be committed first, which would mean it
> has to be written out _before_ the transaction that modifies the target
> raid5 stripe.  That would mean the updated stripe has to be written
> during a later transaction than the one that updated it, so it needs to
> be stored somewhere until that can happen.  Given those requirements,
> it might be better to simply write out the whole new stripe to a free
> stripe in a raid5 data block group, and write a log tree item to copy
> that stripe to the destination location.  That starts to sound a lot
> like option 1 with the fix above...why overwrite, when you can put data
> in the log tree and commit it from there without moving it?
> 
> In mdadm-land, PPL burns 30-40% of write performance.  We can assume that
> will be higher on btrfs.

My suspects is that this happens because md is not in the position to relocate
data to fill a stripe. BTRFS can join different writes and put together in a
stripe. And if this happens BTRFS can bypass the journal because no RMW cycle is
needed. So I expected BTRFS would performs better.

> For me, if the tradeoff is losing 1.5% of a 100 TB filesystem for
> unreclaimed free space vs. a 30% performance hit on all writes with
> journalling, I'll just delete one day's worth of snapshots to make that
> space available, and never consider journalling again.
> 
> Journalling isn't so great for nodatacow either:  the whole point of
> nodatacow is to reduce overhead comparable to plain xfs/ext4 on mdadm,
> and journalling puts that overhead back in.  I'd expect to see users in
> both camps, those who want btrfs to emulate ext4 on mdadm raid5 without
> PPL, and those who want btrfs to emulate ext4 on mdadm raid5 with PPL.
> So that would add two more options to either mount flags or inode flags.
> 
>> - pass-through the "big write" directly to the "fully empty" stripes
>>
>> - commit the transaction (w/journal)
>>
>>
>> The key point is that the allocator should know if a stripe is fully
>> empty or is partially empty. A classic block-based raid doesn't have
>> this information. BTRFS has this information.
>>
>>
>>
>> BR
>>
>> G.Baroncelli
>>
>> -- 
>> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
>> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
>>
>>


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

