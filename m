Return-Path: <linux-btrfs+bounces-2180-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 375AC84BFD6
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 23:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD524285A5D
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 22:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C711BF3A;
	Tue,  6 Feb 2024 22:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="fbGq5bgk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s/921zbO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8EE1C686
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Feb 2024 22:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707257299; cv=none; b=b3JcSAkASz9UJ1R99s2g35p5GzUyhXIgHkesNytcwPAi3Pd+JU0tWNiAQ1hZ9Nmdgx6oowYBpw7d46SHZK3qfdjQuctYtT9kunqDhz5/UH7iywRgBm5M/NhWBoG/xxgtNOGEg5y3hIDs2sLE4sQRj3Xsf0IyOYyVZe7cDBEdgLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707257299; c=relaxed/simple;
	bh=J5VlTrnI0bPvxDJHctRHkiWNCN3TwGbrJ0b9j2tkXEw=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=BmCeB8KpIoZ8XY0eLmk80ctS4QxtpdbWTomvW4AQ1UHyOBngwJI1bQsLXZrFgdyfJ6XU8epAinw4k30Tcm/Nfqfkbd0ZF2XgP+2Db92eVgX6xDUmVbqONKRcXD/WKm4M3osDsgEhJ4VjGCpjqYMXepvkT6Ftxb9R2ABPFNdC48k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=fbGq5bgk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s/921zbO; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 2515F3200AF7;
	Tue,  6 Feb 2024 17:08:15 -0500 (EST)
Received: from imap41 ([10.202.2.91])
  by compute1.internal (MEProxy); Tue, 06 Feb 2024 17:08:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1707257294; x=1707343694; bh=Wy1btngX27
	g3bTWvfKd9qDwcuNBAR3tBedlWkaBRw3U=; b=fbGq5bgkFD17k1nZfZ4pYFGE6m
	HhcxBOWT+h3ttxc9NE1KHDYfxaT9GcAJ2QlMYIb5kH8eImitNAxj2rq3mR7jGXZE
	pYljHDMduiTEBHSJpfM7sRGTg4HP4OItkg7CwNHLK1LrU+bfyI3JcM10YZHzxVWq
	G5/VT4dv6OPia/q0aOLRSi99IkIekAy/4XFPzmh8QIsKZ0fTAhqKYshi+AnTqYLe
	8NpFbRpa5FWofx0S8oBmj2pdNZEtjTxE3aKCbZ0I/g0+4Us3KuU+eVj9W3dwVq9h
	FyEpyV196U1P8AeWKQbDobSJ42PjwD7xSt07nmBQ0fpRuzkaMJLE9b9rgwvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707257294; x=1707343694; bh=Wy1btngX27g3bTWvfKd9qDwcuNBA
	R3tBedlWkaBRw3U=; b=s/921zbOcd1rWtbQDb+I8rS+IPgpz1EKl4F2Am9lQXg2
	Xf28zLKgveEbUMAj4vh1nT65xdfjMZMK/sjKekZCttNDrm/GKQBz1r36lrUEwZG2
	ygBoCb2Ayo1KID9XQq5lUqcLOWBEbIFNk8EQykXh0Cf4lJb/H2Fah3HdWDw5UpYq
	WdPxCAgwHf803ObJ3RQmt/WjXeyQ0/O2sybWTcNQzE27TTZvnChAXO+RlGhejIgY
	VXOLTKNzJxP+npSTEpdw03QjovdPaAbJkEAYuDyVWbLvoP3FZpiosDon8wpMMKWu
	Vfy0oHNkq5AaA+3TeF4HIeGs53h4bSSsMGAOerCYnw==
X-ME-Sender: <xms:zq3CZcgHSNgzuTDBRgh1cw9iamIWUdO4WODS5NwsiyXSZCb-mVZRZA>
    <xme:zq3CZVAc_7GX4-8D3KmO2KHleXd0S2zwJwNkE0PysSZT9Y42_ttKkTc7h0X5KE8fV
    mkrrEuUywhW4QpnVtc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtddtgdduvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfueho
    rhhishcuuehurhhkohhvfdcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvg
    hrnheptdelhfekfeeukedvtdeuvdegffduuefhffeikeejveetvddtgedtffdtueevjeeu
    necuffhomhgrihhnpehgihhthhhusgdrtghomhdpsghurhdrihhonecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:zq3CZUFGL27-K4EdFp6al2grsSE7ba7tzELkk9sAa9NIhTu4TbT_og>
    <xmx:zq3CZdS7DsqmOCYrlNuxCeZ7CKXyS8mS4_qEu3B1xGObhppgdKUO_g>
    <xmx:zq3CZZw1uoBRVEcbIwiX6kA5-4QymDZOISBQycpKwpbB7F5fZb7AXw>
    <xmx:zq3CZXaKbD9jJhgg0rhvqUifQawsh98tNsUkKVofmLrM8Zb8-45NWA>
Feedback-ID: i083147f8:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0F85A2340080; Tue,  6 Feb 2024 17:08:14 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ZcKrE0iFnga94kIA@devvm12410.ftw0.facebook.com>
In-Reply-To: <20240206145524.GQ355@twin.jikos.cz>
References: <cover.1706914865.git.boris@bur.io>
 <20240206145524.GQ355@twin.jikos.cz>
Date: Tue, 06 Feb 2024 14:07:52 -0800
From: "Boris Burkov" <boris@bur.io>
To: "David Sterba" <dsterba@suse.cz>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 0/6] btrfs: dynamic and periodic block_group reclaim
Content-Type: text/plain

On Tue, Feb 06, 2024 at 03:55:24PM +0100, David Sterba wrote:
> On Fri, Feb 02, 2024 at 03:12:42PM -0800, Boris Burkov wrote:
> > Btrfs's block_group allocator suffers from a well known problem, that
> > it is capable of eagerly allocating too much space to either data or
> > metadata (most often data, absent bugs) and then later be unable to
> > allocate more space for the other, when needed. When data starves
> > metadata, this can extra painfully result in read only filesystems that
> > need careful manual balancing to fix.
> > 
> > This can be worked around by:
> > - enabling automatic reclaim
> > - periodically running balance
> > 
> > Neither of these enjoy widespread use, as far as I know, though the
> > former is used at scale at Meta with good results.
> 
> https://github.com/kdave/btrfsmaintenance is to my knowledge widely used
> and installed on distros.  (Also my most starred project on github.)

Oh, cool, I'm glad that is out there and being used. I'm sorry for my ignorance.

> 
> The idea is to make the balance separate from kernel, allowing users and
> administrators to easily tweak the parameters and timing. We haven't
> added automatic reclaim to kernel as it tends to start at the worst
> time. The jobs from btrfsmaintenance are scheduled according to the
> calendar events (systemd.timer).

Makes sense.

> 
> Also the jobs don't have to be ran at all, the package not installed.
> 
> The problem with balancing amount of data and metadata chunks is known
> and there are only heuristics, we can't solve that without knowing the
> exact usage pattern.

Agreed.

> 
> > This patch set expands on automatic reclaim, adding the ability to set a
> > dynamic reclaim threshold that appropriately scales with the global file
> > system allocation conditions as well as periodic reclaim which runs that
> > reclaim sweep in the cleaner thread. Together, I believe they constitute
> > a robust and general automatic reclaim system that should avoid
> > unfortunate read only filesystems in all but extreme conditions, where
> > space is running quite low anyway and failure is more reasonable.
> > 
> > I ran it on three workloads (described in detail on the dynamic reclaim
> > patch) but they are:
> > 1. bounce allocations around X% full.
> > 2. fill up all the way and introduce full fragmentation.
> > 3. write in a fragmented way until the filesystem is just about full.
> > script can be found here:
> > https://github.com/boryas/scripts/tree/main/fio/reclaim
> 
> A common workload on distros is regular system update (rolling distro)
> with snapshots (snapper) and cleanup. This can create a lot of under
> used block groups, both data and metadata. Reclaiming that preriodically
> was one of the ground ideas for the btrfsmaintenance project.

I believe this is pretty similar to my workload 2 in spirit, except I
haven't done much with snapshots. I would love to run this workload so
I'll try to set it up with a VM. If you have a script for it already, or
even tips for setting it up, I would be quite grateful :)

I think that the "lots of random deletes leave empty block groups"
workload is the most interesting one in general for reclaim, and I
think it's cool that it happens in the real world :)

> 
> The reclaim is needed to make the space more compact as the randomly
> removed unused extents create holes for new data so this is a good
> example for either scripted or automatic reclaim.
> 
> However you can also find use case where this would harm performance or
> just waste IO as the data are short lived and shuffling around unused
> block groups does not help much.

+1, definitely trying to avoid this.

> 
> The exact parameters of auto reclaim also depend on the storage type, an
> NVMe would be probably fine with any amount of data, HDD not so much.

Good point, have only tested on NVMe. Definitely needs to be tunable to
not abuse HDDs.

> 
> I don't know from your description above what's the estimated frequency
> of the reclaim? I understand that the urgent reclaim would start as
> needed, but otherwise the frequency of reclaim of say 30% used block
> groups can stay fine for a few days, as there are usually more new data
> than deletions.
> 
> Also with more block groups around it's more likely to find good
> candidates for the size classes and then do the placement.

I think talking about my workload 2 here is helpful. Roughly, it writes
out 100G in a ~110G disk, then deletes 70G in perfectly fragmenting
stripes, so if we were way too aggressive, or used the current
autoreclaim with an unlucky threshold, we would reclaim all 100
block_groups. Dynamic reclaim's threshold spikes up to max, relocates 7
block groups, which is enough to negative feedback loop it back to a low
threshold and not doing more reclaim.

see https://bur.io/dyn-rec/strict_frag-30/thresh.png for the threshold
curve and https://bur.io/dyn-rec/strict_frag-30/relocs.png for the
reclaim counts. (I didn't hack it up perfectly evilly to make the 30%
threshold config relocate 100 block groups in that graph, FWIW)

I will try to more systematically plot threshold curves to get a better
sense for how to cause the most reclaims possible for a worst case
estimate.

In case you were asking more about the period it runs at:
As written right now, it runs with every cleaner thread run, but skips
block_groups that got an allocation since the last cleaner thread run. I
think you make an excellent point that the rate is much better to be more
like "daily" or "weekly" rather than "minutely". That gives more time to
reach a quiescent state, fill in gaps with small writes, etc. At the
minimum, I think the periodic reclaim ought to have a configurable period
with a relatively long default (this should help with HDD too?)

> 
> > The important results can be seen here (full results explorable at
> > bur.io/dyn-rec/)
> > 
> > bounce at 30%, much higher relocations with a fixed threshold:
> > https://bur.io/dyn-rec/bounce-30/relocs.png
> > 
> > hard 30% fragmentation, dynamic actually reclaims, relocs not crazy:
> > https://bur.io/dyn-rec/strict_frag-30/unalloc_bytes.png
> > https://bur.io/dyn-rec/strict_frag-30/relocs.png
> > 
> > fill it all the way up, not crazy churn, but saving a buffer:
> > https://bur.io/dyn-rec/last_gig/unalloc_bytes.png
> > https://bur.io/dyn-rec/last_gig/relocs.png
> > https://bur.io/dyn-rec/last_gig/thresh.png
> > 
> > Boris Burkov (6):
> >   btrfs: report reclaim count in sysfs
> >   btrfs: store fs_info on space_info
> >   btrfs: dynamic block_group reclaim threshold
> >   btrfs: periodic block_group reclaim
> >   btrfs: urgent periodic reclaim pass
> >   btrfs: prevent pathological periodic reclaim loops
> 
> So one thing is to have the mechanism for the reclaim, I think that's
> the easy part, the tuning will be interesting.

My 2c based on what I learned from this effort, and from your feedback:

Our two goals should be:
1. Avoid unnecessary reclaim, it wastes user resources and can hurt
   their system's performance.
2. Prevent unallocated=1MiB before it's too late.

I think anything with a fixed threshold is unlikely to fully achieve
either goal, as unlucky workloads will either operate below the
threshold and reclaim too much or above it and never reclaim.

I believe the dynamic threshold with a negative feedback loop is the
right sort of idea for achieving both goals. Ultimately, it is a
continuous function that encodes "reclaim at all costs when it's really
bad, don't reclaim much otherwise". I think it could also work to get
rid of the extra distraction from modelling it with a continuous
function and trying to encode the two goals more discretely/directly.

i.e.,
Very long period, low threshold periodic maintenance (basically exactly
btrfsmaintenance, doesn't need to be in kernel) and the kernel having "urgent"
conditions where it reclaims more aggressively in a limited way, just to get us
back to a few gigs of unalloc.

I also saw that btrfsmaintenance defaults to dusage=5 then dusage=10
which is lower (but similar to!) the quiescent state thresholds I have
seen in my tests (around 15-20). I may try to tune it to land around 10%
for most healthy fses, as that seems to be the safest number we know.

By the way, I think the dynamic threshold could be implemented fully in
userspace by using the limit flag of balance and recalculating the threshold
between each reclaim. Would you be more interested in experimenting with
that in btrfsmaintenance? I do think that in the long run, some kind of
"urgent unalloc protection" does belong in the kernel by default, assuming
we can really nail it down perfectly.

Thanks for your feedback,
Boris

