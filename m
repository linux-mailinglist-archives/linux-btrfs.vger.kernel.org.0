Return-Path: <linux-btrfs+bounces-20641-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC47D33BD8
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 18:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A6BF302B8D2
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 17:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E5333C19C;
	Fri, 16 Jan 2026 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="je7NZDFN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ftX27wyy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CF53090C6
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Jan 2026 17:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768583564; cv=none; b=qquFNw5Q+6FhXvq8KB/OHyBn+zl0RlpRH5RbdjqeSP6dZ+yob/F5iaWr5ULkAKRJL6p0c/FTVqDRIwh3SyzsypWK9FItQW6DUcJA/h07Y/PZsqbvMR2Wrx7VnIdyDSLGWMsN4YV2Ts80HwPDqU9Fshi4c6EDwwCXdOkKjZTvAVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768583564; c=relaxed/simple;
	bh=d2Mkvy20aPFF02u6uqdnlVk4uyRPuFwI3BpRH89diHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIN3WWmLcvqnnAduVj/oUfjDCfM4vAItyd8OvEsamBBQLpsKNtr+KhslohZp5C0bRgxprv0h4yewYO1JCxtq4yQfxg/SLqdfe1bRRU3BxY5kHgtazSHW3NBTbVuU/ctse2PAed06+BR1ZuzhGqwrOswsILBXErPFb+UMSbyRiSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=je7NZDFN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ftX27wyy; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id AD1C11D00077;
	Fri, 16 Jan 2026 12:12:41 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 16 Jan 2026 12:12:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1768583561; x=1768669961; bh=QOM4nCAvOd
	3zJVnO7u0ppMm+ADAuGj1pfal7FS5AQh8=; b=je7NZDFN17PVv9tVvK5Qt7srVE
	qqwrxVJEClOEZ9iDe3Qn11gcO9CEZavsk6/5r6ZDMY8stlJqdU5TWr1fRD2FKl/q
	ErAeVrFxJNbwpFd2pE93YhA7aaiuMGE8jB8dVy8mBeVIly0+km05fHBaFfarAXqZ
	5gRTJGQVDfn+AoxZXLGwe9kho0rCJ/g/sXlbAH1Db01UPREXc9N25Pp3QyLhwBKf
	R0omZ0d3mcRx+JpwekfAY2cieukGR714CzMmayJuFyu7Zw/FBbTrfi9wRG0s2tj2
	MZex1cCiuh10bRHd3cfjkha9BC7DvMs5w8+HynyTVz+aGarYNLF+cGRLoE9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768583561; x=1768669961; bh=QOM4nCAvOd3zJVnO7u0ppMm+ADAuGj1pfal
	7FS5AQh8=; b=ftX27wyyZycKZYDlYolKR8BkMdv0v0M50t5ZEgERxwi/8H0BuTQ
	3BZr06G7GA4L89cr1W53Rdl8aJz9YqgFk5Cj+nilZpde80pDqGd8LzQRt05Uxb+e
	BvL6hH/MtIecK6fcI1sT9jHLzhQY1saOOyuSdtnpeFWf2pFxJjG3ABzhwBNgGT5A
	nYrb3697Ux9AyG1mPimduZ+SV7+jZ4NeAQVwo1LU/7HKx+V+BYGCu7sLNiaPkRvY
	+/8bXo+0zdVyKdRhh6tIy8rz/LxYYmTjlOcya8LxCJeOATv4PMlGESXRUiTpN0A7
	pcrThAh27oH4Y0m8TIZ1l4I60pcwyLKHP9g==
X-ME-Sender: <xms:iXFqaWTRFEdYxxdA_OZPe1i3rhC8m0O9EjfA79Bi7F39l49fp8pDPA>
    <xme:iXFqaTP3_mmP_kVmZADW2nOVKHlXyHlGF8bte6VyuczlE7sXYHpSD8qN4YSenlo_X
    BiKOp9oetwfKbM9T1u4ljSqnhJv9HU2NoVVxIU4H3wIlBsqH1QtFTU>
X-ME-Received: <xmr:iXFqaRMbKYW5vg805MhwmgZf82b8LEvQl_ZOqL0j6pHHrTGo9wXqMebU1G8yZ3_hDvByWyqKyCFIJD0iM3eCJFt84h0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdelheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeehtd
    fhvefghfdtvefghfelhffgueeugedtveduieehieehteelgeehvdefgeefgeenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprh
    gtphhtthhopeifqhhusehsuhhsvgdrtghomhdprhgtphhtthhopehlihhnuhigqdgsthhr
    fhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:iXFqabscIvnSipCIwo5osP0MoTpc_LBe8LxXWYPQFUwg0rBweoLVbw>
    <xmx:iXFqaTW5G8plJZ7VKqHw8EcPdbu1dc5JNuvSDusBurx8NOLVSuglgw>
    <xmx:iXFqabv6oLPW9BDoXKgLvGP-k9YJw3s2-q320UamK0wFaoBji4O3pA>
    <xmx:iXFqaXXNBdlSFCXocjnQ9o85OG9eO_xtLmLnr-kxOjeBZB-HH_UiKA>
    <xmx:iXFqadbuCR2xVvavnMG1Cqje3Cz3lW7GFSFnWoe_KAIAeEQTjbog5O6C>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jan 2026 12:12:40 -0500 (EST)
Date: Fri, 16 Jan 2026 09:12:36 -0800
From: Boris Burkov <boris@bur.io>
To: Jan Kara <jack@suse.cz>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: do not strictly require dirty metadata threshold
 for metadata writepages
Message-ID: <20260116171236.GA2507766@zen.localdomain>
References: <ccfd051d2ae173d95f3f6e75b7466efbf4596620.1768452808.git.wqu@suse.com>
 <20260115233007.GC2118372@zen.localdomain>
 <sbfwmjgmc5o74mvhuk2qkcjd5kn7kawy6rxkuejffajvecblxu@7erdxsdn5crw>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sbfwmjgmc5o74mvhuk2qkcjd5kn7kawy6rxkuejffajvecblxu@7erdxsdn5crw>

On Fri, Jan 16, 2026 at 01:07:47PM +0100, Jan Kara wrote:
> On Thu 15-01-26 15:30:07, Boris Burkov wrote:
> > On Thu, Jan 15, 2026 at 03:23:44PM +1030, Qu Wenruo wrote:
> > > [BUG]
> > > There is an internal report that btrfs hits a hang at
> > > balance_dirty_pages() for btree inode.
> > > 
> > > [CAUSE]
> > > balance_dirty_pages() can be triggered by both internal calls like
> > > btrfs_btree_balance_dirty() and external callers like mm or cgroup.
> > > 
> > > For internal calls, btrfs_btree_balance_dirty() calls
> > > __btrfs_btree_balance_dirty() which will check if the current dirty
> > > metadata reaches a certain threshold (32M), and if not we just skip the
> > > workload.
> > > 
> > > For external calls they can directly call btree_writepages(), which
> > 
> > grammar nit: you don't need the "can".
> > "External callers directly call btree_writepages()" or something is
> > clearer.
> > 
> > > is doing a similar check against the threshold, and skip the writeback
> > > again if it's not reaching the same 32M threshold.
> > > 
> > > But the threshold is only internal to btrfs, if cgroup or mm chose to
> > > balance dirty pages for the metadata inode at a much lower threshold, in
> > > this case the dirty pages count is around 28M, lower than btrfs'
> > > internal threshold.
> > 
> > I think this is a good argument. Layering multiple different mechanisms
> > for metering writeback doesn't make a ton of sense to me. With that
> > said, it's not great for the write performance of the btrees if we
> > writeback already cow-ed nodes, so allowing more frequent writeback
> > might be harmful in practice.
> > 
> > I still think it's worth it to simplify things and "find out",
> > especially if this existing behavior is buggy...
> > 
> > > 
> > > This causes all writeback request to be ignored, and no dirty pages for
> > > btrfs btree inode can be balanced, resulting hang for all
> > > balance_dirty_pages() callers.
> > 
> > Does this happen determinstically if balance_dirty_pages() is called on
> > the btrfs sb with <32M dirty eb pages? Or does it depend on the state of
> > the dirty file pages too, like if those inodes get back some memory,
> > it's OK? Just curious to understand better.
> 
> Let me explain here some details of dirty throttling which will hopefully
> make things clearer. The system has so called dirty limit which limits
> amount of dirty pages in the page cache. For each memory cgroup it also
> translates into some limit on the number of dirty pages within that cgroup.
> This cgroup dirty limit was what was actually playing the role here because
> the cgroup had only a small amount of memory and so the dirty limit for it
> was something like 16MB. Dirty throttling is responsible for enforcing that
> nobody can dirty (significantly) more dirty memory than there's dirty
> limit. Thus when a task is dirtying pages it periodically enters into
> balance_dirty_pages() and we let it sleep there to slow down the dirtying.
> The sleep time is computed based on estimated page writeback speed and how
> far we are from reaching the dirty limit. When the system is over dirty
> limit already (either globally or within a cgroup of the running task), we
> will not let the task exit from balance_dirty_pages() until the number of
> dirty pages drops below the limit. 
> 
> So in this particular case, as I already mentioned, there was a cgroup with
> relatively small amount of memory and as a result with dirty limit set at
> 16MB. A task from that cgroup has dirtied about 28MB worth of pages in btrfs
> btree inode and these were practically the only dirty pages in that cgroup.
> So the only option how to get the cgroup below the dirty limit is to
> writeback those btree pages. But writeback for those pages was never
> started because of the btrfs internal threshold for the btree inode. So
> this was practially a deadlock (tasks stuck in balance_dirty_pages()
> indefinitely) although if somebody called sync(2) or something similar that
> would force writeback of those btree pages then the processes should get
> unstuck.

Thank you for the extra explanation on the stuck condition, that is
helpful.

I am curious if you have seen this series I wrote last year:
https://lore.kernel.org/linux-btrfs/20250829015247.GJ29826@twin.jikos.cz/
(similar to something Qu had worked on in the past) which makes it so that
btrfs btree inode pages are not accounted to a cgroup. With those patches,
I think the likelihood that we would have a situation where the dirty
pages are less than 32MB but we are over the balance_dirty_pages limit
in a way that perma-throttled a task seems low, since you couldn't have
a cgroup with a tiny limit full of btree inode pages. The btree inode
pages would be associated with the global limit which I imagine would
tend to be higher and correspond to a greater total amount (more than
32MB) of btree inode pages, and more likely to also have data pages we
can writeback. How likely is it that the global limit would be <32MB?

With all that said, even if my suspicion is correct, I think I still
support this patch since it simplifies things and I think we can
generally trust that A) balance_dirty_pages is reasonably well tuned and
B) if it somehow misbehaves we can just improve things more directly
there, rather than put arbitrary logic in other layers like btrfs
itself.

So if the description of the totally stuck condition is added to the
commit message, please add

Reviewed-by: Boris Burkov <boris@bur.io>

Thanks,
Boris

> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

