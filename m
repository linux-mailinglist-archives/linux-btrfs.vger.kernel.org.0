Return-Path: <linux-btrfs+bounces-11203-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC884A24371
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2025 20:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8DB13A802C
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2025 19:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55931F1316;
	Fri, 31 Jan 2025 19:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="xHy48E6x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fJqbiufu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DB71369BB
	for <linux-btrfs@vger.kernel.org>; Fri, 31 Jan 2025 19:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738352299; cv=none; b=sw/r2fwkZ+trsdlSDjXdLi9+gSZwdZspm72FHTMfAtwiv+6AR1/fwGa7AVhHAecBkLBqjTTUN7/rCIvFDhOa4ZSeuhcbso3F1BsbiHvbp19QY/Rp6LVgwb7aWk8XnFrOgBuyCSIjaqdH+UKkLGE1jAQkxxH18U0Bb5eS7/TrU/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738352299; c=relaxed/simple;
	bh=J9XxFlSfxnPP8W7QdA76yeQXARZKRBE3wCl+gK/hFMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFnrnLZPq3q6nM7HdBRW2R4Xs/6Y/AfFzwmzd4BHtRfMwNoO64lEcc21xjc0arJimhvqZ7oH9BkimVzjJkiUfiz4gmJGD0I6WoT+mj/r1NDFbfojKuM1eqBbWntgxarrMRTaco1vHKd/jEF9aseN3LlshmSs+jyGgHYZyeE7L0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=xHy48E6x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fJqbiufu; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 46BBB138012B;
	Fri, 31 Jan 2025 14:38:16 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 31 Jan 2025 14:38:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1738352296; x=1738438696; bh=vU/Hm14uUH
	0nMh80PkzMvaCR8+PVB6vGpGhOMhgC/14=; b=xHy48E6xo2XSMkx2pzaDjUgxRI
	xNzV0kaXyGn0QiNFjeN+oOhFEFYoRMp5dxhYqfPNhg3QSI0YiNw/q7RO3p2eVYS1
	J8hcaegYHKuWGucbhQUQlJZqHNpJlHVOiOXmMzgjz/VEhrQFr6pOl8NSj3w+ARo2
	3F9Wt3+DwQWNfpL9YHBWaY+OhpvPsvntZMiA9suNEcLBn7K3XLhGDHjWqSQt9vxQ
	o4G3XRPaGpWuc1fR3cW1nEkNXHSMEfcabMQI5V0LP0qcdHMHkV2chSf1zvs1gY2d
	+XqBrkBnVTeotWer5910RToSduqE/gi0PlbKR6BM5HneCvzAq5cy1EVB6RiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738352296; x=1738438696; bh=vU/Hm14uUH0nMh80PkzMvaCR8+PVB6vGpGh
	OMhgC/14=; b=fJqbiufuIIOyjCz4igSH0A2sD7vTtVxc3x6KAG6zVG9Ubmjend1
	EZd4txzK0LJHCQfM/qhdCM80kjeAyyQiE6juhaid7OmZ07Owy8hMMFSPxfwKuSu1
	p7osQXvlEbsbXuYzar+FJM7ETmHEZloTU/sUO0IlbuIX2c+DUUQw2SmueE5PSjGy
	onqZx0+onGfmgn64uzLLBFmFJBMB9/YWrBziYlZ5Aa+sAbeaOu6aMy5tSY2UeD0w
	5bCYA/yLmEzm5fj5EbSxg/lpFNcSUmT7RjwdUh46PpUjz0MYajOGt1Ujwqs8YKCb
	fQBSWO7mO5Xe1IBH36le8IVGE4DQnNrn6FA==
X-ME-Sender: <xms:pyadZ6EBIZSZASz5i9HiuwfgAbYu0CZYTq0EIYZW077DY1WPnjitkA>
    <xme:pyadZ7Vz5h_AB55eHZek58mPLw6qH3s_uSDuQ9WYdWZS8RepGpgTV-LodYoepnMp3
    Kd3fpbych64HT2l1yU>
X-ME-Received: <xmr:pyadZ0I6UDmkl_Ynd2YUlzv9aHWByPrJLw5eRCtTihdrc4iKT3kHhHpPbqLJvKZeRibOnyIt6Bu5NrSJJd5oOlKwwCo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenuc
    ggtffrrghtthgvrhhnpeekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeu
    gfdtjefgfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepnhgvvghlgiesshhushgvrdgtohhmpdhrtghpthhtoh
    epughsthgvrhgsrgesshhushgvrdgtiidprhgtphhtthhopehmrghhrghrmhhsthhonhgv
    sehmvghtrgdrtghomhdprhgtphhtthhopehfughmrghnrghnrgeskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:pyadZ0GGO7H1VNVcieNou3W5lJdAWFcZhoj2Bzu7Jo_Fk06OuT1Gpw>
    <xmx:pyadZwVUJk9wD6mYH5cQhRnvMO-dCJ_7x464cuOu9d84si9IX6rsjg>
    <xmx:pyadZ3PgUG7vgUj5N8rNMrsjklrXDpFAG_PD8LESYmB1e3DeR1nS_w>
    <xmx:pyadZ310uLhpc0Ref23KKkzWHpaKXZugRjWa83Uu09xcaU6XdR7ACg>
    <xmx:qCadZ6fzSNnIy_MfxJMlaspAKsyzFAJaYfjN2sK1OYKZkQixrR6KLjOI>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jan 2025 14:38:15 -0500 (EST)
Date: Fri, 31 Jan 2025 11:38:55 -0800
From: Boris Burkov <boris@bur.io>
To: Daniel Vacek <neelx@suse.com>
Cc: David Sterba <dsterba@suse.cz>, Mark Harmstone <maharmstone@meta.com>,
	Filipe Manana <fdmanana@kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: use atomic64_t for free_objectid
Message-ID: <20250131193855.GA1197694@zen.localdomain>
References: <20250122122459.1148668-1-maharmstone@fb.com>
 <CAL3q7H4tB3Cb-djYhh_bGB-BRJ7EahjUZec2qfbhH7QHP2iSUw@mail.gmail.com>
 <CAPjX3Fd+-510YrvpxR1GcK2F+XKDVknxes2sj=Eat1Un1zvEkQ@mail.gmail.com>
 <20250123215955.GN5777@twin.jikos.cz>
 <CAPjX3Ffb2sz9aiWoyx73Bp7cFSDu3+d5WM-9PWW9UBRaHp0yzg@mail.gmail.com>
 <CAL3q7H7+UZcXPefg-_8R=eZj42P2UkV2=yE1dSv8BQZagEOhyQ@mail.gmail.com>
 <962f5499-d730-4e30-8956-7cac25a6b119@meta.com>
 <20250127201717.GT5777@twin.jikos.cz>
 <20250129225822.GA216421@zen.localdomain>
 <CAPjX3FfG9fpYWn-A8DROS9Kk3RTRj2RU+MP00gg7dCk=TF36Og@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPjX3FfG9fpYWn-A8DROS9Kk3RTRj2RU+MP00gg7dCk=TF36Og@mail.gmail.com>

On Thu, Jan 30, 2025 at 12:34:59PM +0100, Daniel Vacek wrote:
> On Wed, 29 Jan 2025 at 23:57, Boris Burkov <boris@bur.io> wrote:
> >
> > On Mon, Jan 27, 2025 at 09:17:17PM +0100, David Sterba wrote:
> > > On Mon, Jan 27, 2025 at 05:42:28PM +0000, Mark Harmstone wrote:
> > > > On 24/1/25 12:25, Filipe Manana wrote:
> > > > >>
> > > > >> It will only retry precisely when more concurrent requests race here.
> > > > >> And thanks to cmpxchg only one of them wins and increments. The others
> > > > >> retry in another iteration of the loop.
> > > > >>
> > > > >> I think this way no lock is needed and the previous behavior is preserved.
> > > > >
> > > > > That looks fine to me. But under heavy concurrency, there's the
> > > > > potential to loop too much, so I would at least add a cond_resched()
> > > > > call before doing the goto.
> > > > > With the mutex there's the advantage of not looping and wasting CPU if
> > > > > such high concurrency happens, tasks will be blocked and yield the cpu
> > > > > for other tasks.
> > > >
> > > > And then we have the problem of the function potentially sleeping, which
> > > > was one of the things I'm trying to avoid.
> > > >
> > > > I still think an atomic is the correct choice here:
> > > >
> > > > * Skipped integers aren't a problem, as there's no reliance on the
> > > > numbers being contiguous.
> > > > * The overflow check is wasted cycles, and should never have been there
> > > > in the first place.
> > >
> > > We do many checks that almost never happen but declare the range of the
> > > expected values and can catch eventual bugs caused by the "impossible"
> > > reasons like memory bitflips or consequences of other errors that only
> > > show up due to such checks. I would not cosider one condition wasted
> > > cycles in this case, unless we really are optimizing a hot path and
> > > counting the cycles.
> > >
> >
> > Could you explain a bit more what you view the philosophy on "impossible"
> > inputs to be? In this case, we are *not* safe from full on memory
> > corruption, as some other thread might doodle on our free_objectid after
> > we do the check. It helps with a bad write for inode metadata, but in
> > that case, we still have the following on our side:
> >
> > 1. we have multiple redundant inode items, so fsck/tree checker can
> > notice an inconsistency when we see an item with a random massive
> > objectid out of order. I haven't re-read it to see if it does, but it
> > seems easy enough to implement if not.
> >
> > 2. a single bit flip, even of the MSB, still doesn't put us THAT close
> > to the end of the range and Mark's argument about 2^64 being a big
> > number still presents a reasonable, if not bulletproof, defense.
> >
> > I generally support correctness trumping performance, but suppose the
> > existing code was the atomic and we got a patch to do the inc under a
> > mutex, justified by the possible bug. Would we be excited by that patch,
> > or would we say it's not a real bug?
> >
> > I was thinking some more about it, and was wondering if we could get
> > away with setting the max objectid to something smaller than -256 s.t.
> > we felt safe with some trivial algorithm like "atomic_inc with dec on
> > failure", which would obviously not fly with a buffer of only 256.
> 
> You mean at least NR_CPUS, right? That would imply wrapping into
> `preempt_disable()` section.

Probably :) I was just brainstorming and didn't think it through super
carefully in terms of a provably correct algorithm.

> But yeah, that could be another possible solution here.
> The pros would be a single pass (no loop) and hence no
> `cond_resched()` needed even.
> For the cons, there are multiple `root->free_objectid <=
> BTRFS_LAST_FREE_OBJECTID` asserts and other uses of the const macro
> which would need to be reviewed and considered.
> 
> > Another option is aborting the fs when we get an obviously impossibly
> > large inode. In that case, the disaster scenario of overflowing into a
> > dupe is averted, and it will never happen except in the case of
> > corruption, so it's not a worse UX than ENOSPC. Presumably, we can ensure
> > that we can't commit the transaction once a thread hits this error, so
> > no one should be able to write an item with an overflowed inode number.

I am liking this idea more. A filesystem that eternally ENOSPCs on inode
creation is borderline dead anyway.

> >
> > Those slightly rambly ideas aside, I also support Daniel's solution. I
> > would worry about doing it without cond_resched as we don't really know
> > how much we currently rely on the queueing behavior of mutex.
> 
> Let me emphasize once again, I still have this feeling that if this
> mutex was contended, we would notoriously know about it as being a
> major throughput bottleneck. Whereby 'we' I mean you guys as I don't
> have much experience with regards to this one yet.

In my opinion, it doesn't really matter if it's a bottleneck or not.
Code can evolve over time with people attempting to make safe
transformations until it reaches a state that doesn't make sense.

If not for the technically correct point about the bounds check, then
changing

mutex_lock(m);
x++;
mutex_unlock(m);

to

atomic_inc(x);

is just a free win for simplicity and using the right tool for the job.

It being a bottleneck would make it *urgent* but it still makes sense to
fix bad code when we find it.

I dug into the history of the code a little bit, and the current mutex
object dates back to 2008 when it was split out of a global fs mutex in
this patch:
a213501153fd ("Btrfs: Replace the big fs_mutex with a collection of other locks")
and the current bounds checking logic dates back to
13a8a7c8c47e ("Btrfs: do not reuse objectid of deleted snapshot/subvol")
which was a refactor of running the find_highest algorithm inline.
Perhaps this has to do with handling ORPHAN_OBJECTID properly when
loading the highest objectid. 

These were operating in a totally different environment, with different
timings for walking the inode tree to find the highest inode, as well as
a since ripped out experiment to cache free objectids.

Note that there is never a conscious choice to protect this integer
overflow check with a mutex, it's just a natural evolution of refactors
leaving things untouched. Some number of intelligent cleanups later and
we are left with the current basically nonsensical code.

I believe this supports my view that this was never done to consciously
protect against some feared corruption based overflow. I am open to
being corrected on this by someone who was there or knows better.

I think any one of:
- Mark's patch
- atomic_inc_unless
- abort fs on enospc
- big enough buffer to make dec on enospc work

would constitute an improvement over a mutex around an essentially
impossible condition. Besides performance, mutexes incur readability
overhead. They suggest that some important coordination is occurring.
They incur other costs as well, like making functions block. We
shouldn't use them unless we need them.

> 
> But then again, if this mutex is rather a protection against unlikely
> races than against likely expected contention, then the overhead
> should already be minimal anyways in most cases and Mark's patch would
> make little to no difference really. More like just covering the
> unlikely edge cases (which could still be a good thing).
> So I'm wondering, is there actually any performance gain with Mark's
> patch to begin with? Or is the aim to cover and address the edge cases
> where CPUs (or rather tasks) may be racing and one/some are forced to
> sleep?
> The commit message tries to sell the non-blocking mode for new
> inodes/subvol's. That sounds fair as it is, but again, little
> experience from my side here.

My understanding is that the motivation is to enable non-blocking mode
for io_uring operations, but I'll let Mark reply in detail.

> 
> > > > Even if we were to grab a new integer a billion
> > > > times a second, it would take 584 years to wrap around.
> > >
> > > Good to know, but I would not use that as an argument.  This may hold if
> > > you predict based on contemporary hardware. New technologies can bring
> > > an order of magnitude improvement, eg. like NVMe brought compared to SSD
> > > technology.
> >
> > I eagerly look forward to my 40GHz processor :)
> 
> You never know about unexpected break-throughs. So fingers crossed.
> Though I'd be surprised.
> 
> But maybe a question for (not just) Dave:
> Can you imagine (or do you know already) any workload which would rely
> on creating FS objects as lightning-fast as possible?
> The size of the storage would have to be enormous to hold that many
> files so that the BTRFS_LAST_FREE_OBJECTID limit could be reached or
> the files would have to be ephemeral (but in that case tmpfs sounds
> like a better fit anyways).

