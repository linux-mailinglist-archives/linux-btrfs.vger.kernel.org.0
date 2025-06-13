Return-Path: <linux-btrfs+bounces-14655-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38583AD97E1
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Jun 2025 00:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA50C4A0850
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jun 2025 22:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E69A271462;
	Fri, 13 Jun 2025 22:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="YZ0bg7zH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qmFO4lXB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5DD1632DD
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Jun 2025 22:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749852039; cv=none; b=aSovBQdWAHwmBPHKzPd5oG5aiNXLBoLaZVK8CytX2OapCPqCgBBDjDiKxg07Xgp+2IRFNQ0iOkj6CUTli+E7ub+nm1rE0nuY/W7GEeeXqdhKArDiEWrIboo4r4qO9rvq+SPj7/mL3Eq5i3ePg5yOvHFRoO17TFAOuaXh7fV2D5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749852039; c=relaxed/simple;
	bh=bidNjAf+HCGgB5UtwMtjct2DLW2vX2ESjLKOLJ/f1Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jhd+exfQIi0w0K1wbwPjzqT/jCu6qsHhuzxGWiJyaW7oyIB0OiujVY7C8kfo5IKqlc8WDkmQvWh9V9q6JLo8msTofzOmGLjbzHpLPXKY45sBk3NSfIaVY5QfqFI0493OMMS8bO2gSakb8SvmVLStUw1Gm8wPZJLJujCXCs5oTek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=YZ0bg7zH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qmFO4lXB; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 5B5E3138026B;
	Fri, 13 Jun 2025 18:00:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 13 Jun 2025 18:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1749852035; x=1749938435; bh=2Q7kYw+lKh
	T5VSX51J+o3pD1OotzaGU0aNbTp9KYjVU=; b=YZ0bg7zHazHbiTAuwLlq98aDLB
	hC7ff6qZCbjVQnWJKcVq1XLjpmfb/P2g3MYR8wrvFVm1xHMloKoULrbgBP17v37H
	xO25n3xIXFQ/RfOEvGldiDRdE7KlmeIG+AyWNVSUScGdayz9DtLIwN//IdBAnXrn
	dAEgy3YoI9x9oHA4EOcmufNUS68lmF/PsJxYswP2aa2IElUmux/V2zyIWzoAtgGr
	elbJqTJoEIZlgXcvXp77aG6Hh4wB+UCOWYn7T28vdp75lvDkiiXUWv7IUxfpRfnV
	ZIODppCayKszcEvgdh5zsAvANMKfllLk4dMOmtT4PHUxzDrhDt8YhbzkPE/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749852035; x=1749938435; bh=2Q7kYw+lKhT5VSX51J+o3pD1OotzaGU0aNb
	Tp9KYjVU=; b=qmFO4lXBvMmAjmnc7K7lC9BRC4c2MMpWM3wIfby4wY8Wzh+SIdj
	7WitAWzXihdzfdjZebKlvd5bkxf/79Iu9QKXkXxXTadQGr9EqPjPz3MoCrx5INir
	9VJ8EF4RnzXxYSpmtoSINLTIbZjN7EgDBrllr9snWHyHOagVv4j+ZGclxhHy3Qij
	eEo+ywR9VavQHzBf9Te+jCDGfRIFWAywDQxxZkkZVj5kk6A80VAeacb1U6e5b6DI
	5jxSx9mRubQQw72VwUUMPjE65eCsXw4JAQAgyEfghBaptBH0qkmAuHiHOryEr8va
	UJlko3Q5JoBAwYqlcpUGVXXyl7oNXFEbTcg==
X-ME-Sender: <xms:g59MaIxcvaAGzeC_hEgbQux6tDciNM08cUnBlff5FV5-07QXVqoO_w>
    <xme:g59MaMRLzJIfBr4r6k_VZvm-006YAWkeFV90oBPhAFTpg5F-dEimQdK14iruaH3YH
    oRdVyiD_wdhmJmnxrU>
X-ME-Received: <xmr:g59MaKWyHtUnCbKTgEOsp5c57ANJvXihVW9ibagvUe5T3YGSw_3QwbmrHGXRq4cxLfLOUj60R8rUHmH-6xhDyzSqIl0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduledtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqne
    cuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfg
    uefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmrghhrghrmhhsthhonhgvsehfsgdrtghomhdprh
    gtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:g59MaGi6kV2byi5dDqv3s4TD4nhUMyOZFpANuuQxXvTDiPhn3VNlyw>
    <xmx:g59MaKCSqQiqoX_XIuNf5l3ALfGzAETuqJlPA4lCgoZ3S8YwYk6kRg>
    <xmx:g59MaHLKVXYckgJa8ugZrORtYO9FD3BSOtRsqFwdbGE6uBufzYy9Eg>
    <xmx:g59MaBAwH2Y9qwMvjxYi_dbOyLEJwkhW8i9kpvSyolis6__-Y07lTw>
    <xmx:g59MaFXGdix1hdogsob1DQtQEG9DAtE7ck8-bTuUj9n5DRtohyO_Fexp>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Jun 2025 18:00:34 -0400 (EDT)
Date: Fri, 13 Jun 2025 15:00:15 -0700
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 04/12] btrfs: remove remapped block groups from the
 free-space tree
Message-ID: <20250613220015.GD3621880@zen.localdomain>
References: <20250605162345.2561026-1-maharmstone@fb.com>
 <20250605162345.2561026-5-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605162345.2561026-5-maharmstone@fb.com>

On Thu, Jun 05, 2025 at 05:23:34PM +0100, Mark Harmstone wrote:
> No new allocations can be done from block groups that have the REMAPPED flag
> set, so there's no value in their having entries in the free-space tree.
> 
> Prevent a search through the free-space tree being scheduled for such a
> block group, and prevent discard being run for a fully-remapped block
> group.
> 
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> ---
>  fs/btrfs/block-group.c | 21 ++++++++++++++++-----
>  fs/btrfs/discard.c     |  9 +++++++++
>  2 files changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 5b0cb04b2b93..9b3b5358f1ba 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -920,6 +920,13 @@ int btrfs_cache_block_group(struct btrfs_block_group *cache, bool wait)
>  	if (btrfs_is_zoned(fs_info))
>  		return 0;
>  
> +	/*
> +	 * No allocations can be done from remapped block groups, so they have
> +	 * no entries in the free-space tree.
> +	 */
> +	if (cache->flags & BTRFS_BLOCK_GROUP_REMAPPED)
> +		return 0;
> +
>  	caching_ctl = kzalloc(sizeof(*caching_ctl), GFP_NOFS);
>  	if (!caching_ctl)
>  		return -ENOMEM;
> @@ -1235,9 +1242,11 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
>  	 * another task to attempt to create another block group with the same
>  	 * item key (and failing with -EEXIST and a transaction abort).
>  	 */
> -	ret = remove_block_group_free_space(trans, block_group);
> -	if (ret)
> -		goto out;

nit: it feels nicer to hide the check inside the function.

> +	if (!(block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED)) {
> +		ret = remove_block_group_free_space(trans, block_group);
> +		if (ret)
> +			goto out;
> +	}
>  
>  	ret = remove_block_group_item(trans, path, block_group);
>  	if (ret < 0)
> @@ -2457,10 +2466,12 @@ static int read_one_block_group(struct btrfs_fs_info *info,
>  	if (btrfs_chunk_writeable(info, cache->start)) {
>  		if (cache->used == 0) {
>  			ASSERT(list_empty(&cache->bg_list));
> -			if (btrfs_test_opt(info, DISCARD_ASYNC))
> +			if (btrfs_test_opt(info, DISCARD_ASYNC) &&

I asked this on the previous patch, but I guess this means we will never
discard these blocks? Is that desirable? Or are we discarding them at
some other point in the life-cycle?

> +			    !(cache->flags && BTRFS_BLOCK_GROUP_REMAPPED)) {
>  				btrfs_discard_queue_work(&info->discard_ctl, cache);
> -			else
> +			} else {
>  				btrfs_mark_bg_unused(cache);
> +			}
>  		}
>  	} else {
>  		inc_block_group_ro(cache, 1);
> diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> index 89fe85778115..1015a4d37fb2 100644
> --- a/fs/btrfs/discard.c
> +++ b/fs/btrfs/discard.c
> @@ -698,6 +698,15 @@ void btrfs_discard_punt_unused_bgs_list(struct btrfs_fs_info *fs_info)
>  	/* We enabled async discard, so punt all to the queue */
>  	list_for_each_entry_safe(block_group, next, &fs_info->unused_bgs,
>  				 bg_list) {
> +		/* Fully remapped BGs have nothing to discard */

Same question. If we simply *don't* discard them, I feel like this
comment is misleadingly worded.

> +		spin_lock(&block_group->lock);
> +		if (block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED &&
> +		    !btrfs_is_block_group_used(block_group)) {
> +			spin_unlock(&block_group->lock);
> +			continue;
> +		}
> +		spin_unlock(&block_group->lock);
> +
>  		list_del_init(&block_group->bg_list);
>  		btrfs_discard_queue_work(&fs_info->discard_ctl, block_group);
>  		/*
> -- 
> 2.49.0
> 

