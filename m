Return-Path: <linux-btrfs+bounces-20420-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D790D14CDC
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 19:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 105073068BED
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 18:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F873876C0;
	Mon, 12 Jan 2026 18:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="TIsNa9lj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ECpPtWhL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2112EC0A2;
	Mon, 12 Jan 2026 18:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768243829; cv=none; b=Mfmw5gE66zkQWQsVZNWmR/IOJfnhzqq9y1GbN+pAB2nz/dQ0y+S9JbGSVjW3JHYEAjnC8il7tNKrEsSdpB9T0T//KlMM1zOGoNe6OCnsBS1X2rkwWa35c9V7qvpVRgcRPGSZ3iZdSNkaW/scSuXjGlC9ouMpDo0W6NSyOgceRAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768243829; c=relaxed/simple;
	bh=5zDLu3preaLUE6CW+n0w5uxzxTVHg8zAjJ2L+9XLDLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qp6okcrYm4AYNytXERLWz+faN5f2kSmjGydkz0oG6essi6K+YD9cJkN68MAvt9amOnd3qC8GcbaQb6LDLk+vmueP9gfQWcPNsqpihiDMuNBOjVcSUT9eQiU7qHgeuMBEEJEjnbD8fB1CZSpSbzXZxGS1Y5iAkY4EGAVxjempeGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=TIsNa9lj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ECpPtWhL; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 538137A014F;
	Mon, 12 Jan 2026 13:50:26 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 12 Jan 2026 13:50:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1768243826; x=1768330226; bh=QFMljeTs0X
	5O2YiFHxz6n7TiqSKcMxDR2pdyFT7oCVg=; b=TIsNa9lj3RUtORnPzAzTeuKlzP
	f5NViAkuS9SLlukP6y1h2hplB8Tt2iuRJ3L0AnZIJVLGLsMFzVwJ3ga4W+IyB9Kl
	GVzERenOEz+wOLl6VLqpEUOI3lQwlQCh+Akr1NNAZ6hSpbOm8GdX9yh0PRdOk5rf
	RNHonudVvFMPAJSkPItMnjdsGCyqmZCdfWAi31X+EJyIorwNInJhJ8UkXi3wciBv
	0qqKpirjzjBU7ANxXxU7KG7VtUyhNyofTPhutJwNy7rXLt551keq48YRiPRqBBAV
	GibCuKpygbLcpnd5Gaq/Ois+mETu3BJhwpX0Rj0sovQKbQaGvLE1Ecz8Iekg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768243826; x=1768330226; bh=QFMljeTs0X5O2YiFHxz6n7TiqSKcMxDR2pd
	yFT7oCVg=; b=ECpPtWhL4RSAYhdKqzreVqh4lWNuTrx6LUouuKwTIj+PViUfFB5
	E7x1U0rBkRWDXR9Nc6/LYRYnu6mcPAZxEf6Uz5GITA5tuGz7poGUZJ1mKalZsu9b
	fF48DUJHORhaMS3kj+HcwegmOXaYE05njFd2Jrm2+O3GYY7RBSla5t9xWd5psY/u
	NewtwFnoYozUf3MzmWRwqd11WL6vJsHqJEJ3STs/LVuHsAdb5Zree5l5DPuwd0qn
	CKsRRauWSlBVDc3XSe1R6vnwWs8nSDO+XK+RlaVB3s9Kjm1rrv/O4DjzPbtVWHwN
	8GsgEmx8N/vWveEN0U1fsYDyIt8IYIUs7gg==
X-ME-Sender: <xms:cUJlacXJIcCLMlnPY0hxJ_ecn6uLgbA81a-J_4ZJmwbA2LaoYWm_qQ>
    <xme:cUJlaZ5WM-WJwP-45-axLoa6SbpcD-y27nLvIr7IbjE30HBTc6Uj0fglkwB48_5Jd
    TfQOwYpWaxOYknIMHOgjhWiDnlvuZwjajZF4IMrhioF5uY3obixef4>
X-ME-Received: <xmr:cUJlaXqky_pYK17fswxWw0MUsT8Bb404M3UYcozX72BZloi7Pe3kgpbRfTDFaF9xWqOVTJGEWN9Enef2JE4yTqDU6KE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudekvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiie
    eiudfguefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopeeipdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehjihgrshhhvghnghhjihgrnhhgtghoohhl
    sehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghlmhesfhgsrdgtohhmpdhrtghpthhtoh
    epughsthgvrhgsrgesshhushgvrdgtohhmpdhrtghpthhtohepfhgumhgrnhgrnhgrsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:cUJlacnCIrqgWCAF0pHvoQqPK3vqd8er3Slnp43qk_XihsBkhKFU_g>
    <xmx:ckJlaTP8IWnu7oFli2sbsQOXRqHc9Rua7mltoF01cXasg_B1ABvEOA>
    <xmx:ckJlaQM44APq5ODdXJfzIaCg6p-AVC6ReXUdjKNxi-RnO-xgFoWajA>
    <xmx:ckJlaUhn0kBYhW-JePY9xlmuXJvXz1vyt3VQW9ISJDh96xr8bMkljQ>
    <xmx:ckJlaVdkKtusud8jAq5L55VYiE-vyNsV43XgVdQiHg_82G5ntvaxzcln>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 13:50:25 -0500 (EST)
Date: Mon, 12 Jan 2026 10:50:27 -0800
From: Boris Burkov <boris@bur.io>
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: clm@fb.com, dsterba@suse.com, fdmanana@kernel.org,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] btrfs: reset block group size class when reservations
 are freed
Message-ID: <20260112185001.GA450687@zen.localdomain>
References: <20260112143523.31542-1-jiashengjiangcool@gmail.com>
 <20260112150248.32570-1-jiashengjiangcool@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112150248.32570-1-jiashengjiangcool@gmail.com>

On Mon, Jan 12, 2026 at 03:02:48PM +0000, Jiasheng Jiang wrote:
> Differential analysis of block-group.c shows an inconsistency between
> btrfs_add_reserved_bytes() and btrfs_free_reserved_bytes().
> 
> When space is reserved, btrfs_use_block_group_size_class() is called to
> set a block group's size class, specializing it for a specific allocation
> size to reduce fragmentation. However, when these reservations are
> subsequently freed (e.g., due to an error or transaction abort),
> btrfs_free_reserved_bytes() fails to perform the corresponding cleanup.
> 
> This leads to a state where a block group remains stuck with a specific
> size class even if it contains no used or reserved bytes. While the
> impact depends on the workload, this stale state can cause
> find_free_extent to unnecessarily skip these block groups for mismatched
> size requests.
> In some cases, it may even trigger the allocation of new block groups if
> no matching or unassigned block groups are available.

Sorry I missed v1 and v2 of this, so I may be late with my questions.

This seems reasonable enough, but I am wondering why you are only doing
it for the error handling path.

We can also legitimately free the last extent in a block group which will
go through btrfs_update_block_group(). That will either mark it unused or
for async discard, which may eventually result in the bg getting cleaned up.
But in the meantime it is eligible to be used again so by the same
reasoning as this patch, it shouldn't have a size class.

That aside, I don't think this should be a huge issue for two reasons:
1. size classes are advisory and allocations won't fail because of them,
so I don't think your assertion about triggering new allocations is
accurate. (see LOOP_WRONG_SIZE_CLASS)
2. the bg is likely to end up getting used anyway, so it would take
pretty specific conditions to meaningfully "leak" one.

If this issue is something you have observed in practice rather than a
(valid) theoretical problem, I'd be curious to hear more about your
workload and the negative effects you observed.


One final point: this also makes me wonder if it would be beneficial to
merge some of the logic on hitting 0 used+reserved between
btrfs_update_block_group() and btrfs_free_reserve_bytes(). I imagine we
might be able to also miss a block group that needs to be marked unused
on this path.

Thanks,
Boris

> 
> Fix this by resetting the size class to BTRFS_BG_SZ_NONE in
> btrfs_free_reserved_bytes() when the block group becomes completely
> empty.
> 
> Fixes: 52bb7a2166af ("btrfs: introduce size class to block group allocator")
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
> ---
> Changelog:
> 
> v2 -> v3:
> 1. Corrected the "Fixes" tag to 52bb7a2166af.
> 2. Updated the commit message to reflect that the performance impact is workload-dependent.
> 3. Added mention that the issue can lead to unnecessary allocation of new block groups.
> 
> v1 -> v2:
> 1. Inlined btrfs_maybe_reset_size_class() function.
> 2. Moved check below the reserved bytes decrement in btrfs_free_reserved_bytes().
> ---
>  fs/btrfs/block-group.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 08b14449fabe..8339ad001d3f 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -3867,6 +3867,12 @@ void btrfs_free_reserved_bytes(struct btrfs_block_group *cache, u64 num_bytes,
>  	spin_lock(&cache->lock);
>  	bg_ro = cache->ro;
>  	cache->reserved -= num_bytes;
> +
> +	if (btrfs_block_group_should_use_size_class(cache)) {
> +		if (cache->used == 0 && cache->reserved == 0)
> +			cache->size_class = BTRFS_BG_SZ_NONE;
> +	}
> +
>  	if (is_delalloc)
>  		cache->delalloc_bytes -= num_bytes;
>  	spin_unlock(&cache->lock);
> -- 
> 2.25.1
> 

