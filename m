Return-Path: <linux-btrfs+bounces-15505-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFEDB064AA
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Jul 2025 18:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59DC31AA5A84
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Jul 2025 16:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D7C27A139;
	Tue, 15 Jul 2025 16:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="KVbL5XMr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="adX44etB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904A719F464
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Jul 2025 16:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752598403; cv=none; b=IwMrHmf8DWza618d7ZWcqYwZzrh9adbukPnfKNGpmTdD12yquv2CgrGnPbCfLFVnNB7Q4AOQTvaKUiVWC44eebk/9F4T2/yPJspYtYwFIfu2UxOOm8fJQNV1Vx3vwOaTJ2o4KFa+Jq4XvydCj1oTupaiPJ3MQBw2cZdzvNUdBNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752598403; c=relaxed/simple;
	bh=SJu+la+hVQlOFUfTIrdu0pMsVp63iIv7omoB0srNzWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbh+AhUVFnE/SB/3rNJrxqJbZex0ShyJAqwlTVXrQMxWiI2lUTSqjmdmSJfnIpcItonuF9qM9GXFm6zcMiZjAoY9kalbPQ5W6qOEKqvFSFAr6GKR1GnUDBtR6agC4PHWiNAZK11ytw4ts6ghxIFjDKv1wUsWpkYzDuEbYwQxih4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=KVbL5XMr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=adX44etB; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 2388A1D00215;
	Tue, 15 Jul 2025 12:53:20 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 15 Jul 2025 12:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1752598399;
	 x=1752684799; bh=9J2BjF0Vzm82DvafVeZ5Jv/soaLmsobX1UOoyF7jYFg=; b=
	KVbL5XMrbUZSWbfuyZjbxAMl9U14D+DbHO6YC/3/znCD5ENBkWpgQ/EL/chPjZEZ
	GPqcyRhcpTE1BGOaU1119jbSDLt0cgjzDXG2xbrNOFKMvDvpZF5KU3g6f/G6KStk
	Uy/mxaq9LUOz97BoCZ206B/+EDzUCjgtk7ErTYz+auHobuLDw+hgq32Q6fStYqpJ
	B7PnvS/J0ZJSQDkmF/QDFu/MebV+ba/Aq80TbbnUQXNc5gD7+P2Bw0eXf9BWPCN7
	kTO+QdHCwmQin2B+Xg3Xhosi4+0amDuqNAl/UbHZpiIGLeMP1FH8Z3YO25KqN0j7
	aB3wAXhDKo178SfVU+zvvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752598399; x=
	1752684799; bh=9J2BjF0Vzm82DvafVeZ5Jv/soaLmsobX1UOoyF7jYFg=; b=a
	dX44etBb7Df/WHokBTk0AZjWcOwQ5rABmmeitjgtlObFpuxNtKhrLnKlsdtH3xOV
	msa6xhK2MnLf1MyIM+9ffGCAg+PCxYkaepFeHw0JxwIZxHzoko9UfCX2IRQ1zhrl
	OWwW/YhyH0rV3bJfYja+H/VkHRrzgvjK81bz4vlfpdvXfUBwhL5eMN1PijM/j0Ie
	E+1UaLI9XHs49ZnzT8CrEz5upzQW8ivssbxBYxxM+RKSAh5q4QThOTdfgMM8c5R4
	WXr/+UQmz3tsH1Fy6o+8YlDwNKEXeeg6BG5V20C2cKHnHTMmEGjFvQnmPP7WEi+l
	oXK0h3Ae9dCG7Z6R5WCpg==
X-ME-Sender: <xms:f4d2aAE74nGeMcoyy2kHLCHoXxiXg1cVf_Q2rwtqYFOw-w_Mz3CcTA>
    <xme:f4d2aMkNwDW-oWIuEMpkQreG8BZ8QNT9a0Qsh3hYMEA7wVhuBYCsCyZoKMiuqxJoU
    Z99XWfnph352ij7pSA>
X-ME-Received: <xmr:f4d2aDn4PlsRKSI4VQmn__C-_-a9faz777TQIxs69-RJoI7PEN_qSnCGyjtLrKoscKQ1sRZpUyHiUGUwEBb-sxQEuwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehheefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpedule
    fhtdfhteduvdethfeftdeitdethedvtdekvdeltddvveegtdeuuddtiedtieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepfhgumhgrnhgrnhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    gsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghl
    qdhtvggrmhesfhgsrdgtohhm
X-ME-Proxy: <xmx:f4d2aNthwBkB7QAPYe5y-eYJhy9uEeX8963wSmKYe6jAOgcIrjoU4Q>
    <xmx:f4d2aGntSfn-eRlqGEOFvNEf6FCsXDEbdEwXratUVviEyrRyULxtnQ>
    <xmx:f4d2aIt1Zegu0KN4JskEU_51tjAcM_72gtQWFmhYVomRmiJX6RSRYw>
    <xmx:f4d2aMeuIGR7bbeUzqNzZGGB4ILh9B-jvQTT-iVlPj3hEDt1l6pBtg>
    <xmx:f4d2aGuvoFahx6DQu2tkRpGfCk3YPfNB3nAEvTjlJuFFNJAQ5GjKCTrz>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 12:53:19 -0400 (EDT)
Date: Tue, 15 Jul 2025 09:54:54 -0700
From: Boris Burkov <boris@bur.io>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: fix ssd_spread overallocation
Message-ID: <20250715165454.GA805364@zen.localdomain>
References: <22b101fdabce832fc954622fcc0d49793d2070f2.1752540760.git.boris@bur.io>
 <CAL3q7H7MCSLiZc-KipzGWcybBM7+Y2SD9B-tw0=07Rzg+spdrw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H7MCSLiZc-KipzGWcybBM7+Y2SD9B-tw0=07Rzg+spdrw@mail.gmail.com>

On Tue, Jul 15, 2025 at 03:52:00PM +0100, Filipe Manana wrote:
> On Tue, Jul 15, 2025 at 1:52 AM Boris Burkov <boris@bur.io> wrote:
> >
> > If the ssd_spread mount option is enabled, then we run the so called
> > clustered allocator for data block groups. In practice, this results in
> > creating a btrfs_free_cluster which caches a block_group and borrows its
> > free extents for allocation.
> >
> > Since the introduction of allocation size classes, there has been a bug
> > in the interaction between that feature and ssd_spread. find_free_extent()
> > has a number of nested loops. The loop going over the allocation stages,
> > stored in ffe_ctl->loop and managed by find_free_extent_update_loop(),
> > the loop over the raid levels, and the loop over all the block_groups in
> > a space_info. The size class feature relies on the block_group loop to
> > ensure it gets a chance to see a block_group of a given size class.
> > However, the clustered allocator uses the cached cluster block_group and
> > breaks that loop. Each call to do_allocation() will really just go back
> > to the same cached block_group. Normally, this is OK, as the allocation
> > either succeeds and we don't want to loop any more or it fails, and we
> > clear the cluster and return its space to the block_group.
> >
> > But with size classes, the allocation can succeed, then later fail,
> > outside of do_allocation() due to size class mismatch. That latter
> > failure is not properly handled due to the highly complex multi loop
> > logic. The result is a painful loop where we continue to allocate the
> > same num_bytes from the cluster in a tight loop until it fails and
> > releases the cluster and lets us try a new block_group. But by then, we
> > have skipped great swaths of the available block_groups and are likely
> > to fail to allocate, looping the outer loop. In pathological cases like
> > the reproducer below, the cached block_group is often the very last one,
> > in which case we don't perform this tight bg loop but instead rip
> > through the ffe stages to LOOP_CHUNK_ALLOC and allocate a chunk, which
> > is now the last one, and we enter the tight inner loop until an
> > allocation failure. Then allocation succeeds on the final block_group
> > and if the next allocation is a size mismatch, the exact same thing
> > happens again.
> >
> > Triggering this is as easy as mounting with -o ssd_spread and then
> > running:
> >
> > mount -o ssd_spread $dev $mnt
> > dd if=/dev/zero of=$mnt/big bs=16M count=1 &>/dev/null
> > dd if=/dev/zero of=$mnt/med bs=4M count=1 &>/dev/null
> > sync
> >
> > if you do the two writes + sync in a loop, you can force btrfs to spin
> > an excessive amount on semi-successful clustered allocations, before
> > ultimately failing and advancing to the stage where we force a chunk
> > allocation. This results in 2G of data allocated per iteration, despite
> > only using ~20M of data. By using a small size classed extent, the inner
> > loop takes longer and we can spin for longer.
> >
> > The simplest, shortest term fix to unbreak this is to make the clustered
> > allocator size_class aware in the dumbest way, where it fails on size
> > class mismatch. This may hinder the operation of the clustered
> > allocator, but better hindered than completely broken and terribly
> > overallocating.
> >
> > Further re-design improvements are also in the works.
> >
> > Fixes: 52bb7a2166af ("btrfs: introduce size class to block group allocator")
> > Reported-by: Dave Sterba <dsterba@suse.com>
> 
> I think you should probably use David and not Dave, since that's the form he
> always uses in his SoB tags, RB tags, etc.
> 

Fixed while pushing to for-next, thanks.

> > Signed-off-by: Boris Burkov <boris@bur.io>
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> 
> Looks good, thanks.
> 
> 
> 
> 
> > ---
> >  fs/btrfs/extent-tree.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> > index 85833bf216de..ca54fbb0231c 100644
> > --- a/fs/btrfs/extent-tree.c
> > +++ b/fs/btrfs/extent-tree.c
> > @@ -3672,7 +3672,8 @@ static int find_free_extent_clustered(struct btrfs_block_group *bg,
> >         if (!cluster_bg)
> >                 goto refill_cluster;
> >         if (cluster_bg != bg && (cluster_bg->ro ||
> > -           !block_group_bits(cluster_bg, ffe_ctl->flags)))
> > +           !block_group_bits(cluster_bg, ffe_ctl->flags) ||
> > +           ffe_ctl->size_class != cluster_bg->size_class))
> >                 goto release_cluster;
> >
> >         offset = btrfs_alloc_from_cluster(cluster_bg, last_ptr,
> > --
> > 2.50.0
> >
> >

