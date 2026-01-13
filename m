Return-Path: <linux-btrfs+bounces-20473-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E85D1B7E2
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 22:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F64D3043229
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 21:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A994350A0E;
	Tue, 13 Jan 2026 21:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="huVafrFa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bXSlSM6I"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D2D2E9749;
	Tue, 13 Jan 2026 21:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768341427; cv=none; b=l0zeLInw5mMujGuAN4wnitaMeGy8UV0LMt9IRRPMO18RszPc2RaI82061dgIy6ULeAWh/qMcA7hYBhuBwcso498c+hNVaxR1JiIAvBrfapboW/RcTO10k8M06H5NrsHt+1V6H9DMVq+fVVf5f0QvTe/9cJ63982RorDxV6M780E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768341427; c=relaxed/simple;
	bh=Q5bxNzZLJmoWZi2jvYus1kHT++0hJH9MC9l/B1zaYHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0FT4evVhlBuk/iC8/ixmFUFcUF4guWqg0kgDvvg2DS91TFIs6Qb2VaB+18YuPOKVsXtS/8m4uxC7T7GsNlxgr/lrDRqYI9fI5gLdKYAQgsvgTsXVjcOEA/neAtXqUejfyT6YmGoXauJDvA2Xps4+JPpElToVdqsSllWP/JT3tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=huVafrFa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bXSlSM6I; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4EEDC14000F3;
	Tue, 13 Jan 2026 16:57:05 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 13 Jan 2026 16:57:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1768341425;
	 x=1768427825; bh=rbsdhJQoJd7KhVeQOaKNtJrgGHcEpox6Luyg20a0nFw=; b=
	huVafrFa47NoV036Z1PfQbjtvexEphGxK+czP80/eeLlnu1jc5OEhmkBq5VcFjwR
	07sVQbM4ETJopNmqQIKlWRBj30pQ8c5YPvNfy+qh4DiP1a07bJzo6Lv8n3OcqS5i
	y6FqXpVKyT1FiMRk0n5GRqneHw2C3wEDTeaHPlqsqbevmDLm29xLKVWKlAA9A/og
	beXCLWs7PyXupeV0OFexha0FbWWdTPhrJFAIn/X8mpzbto2Q/fzYW0gqo7xsuDmn
	Jd4139poiH5IBgRnCHbhkPIRP09uyRoUlftstsG39mMUaHbT+9l+wU5pFxT7lBSW
	EaER/rVPCUBN9cE4rbVNbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768341425; x=
	1768427825; bh=rbsdhJQoJd7KhVeQOaKNtJrgGHcEpox6Luyg20a0nFw=; b=b
	XSlSM6I+CsXHPETMFatKFevJeTYzLLBeSZFDDlLZI2arJY3SxJNqfZh6LrrBS7jR
	Wm7t7R8B7Zu0MQusNhmBpbspuuQG1yAevCAd+eEbZCXu4Uh4l9/p9gGHibvLlstj
	iVNpDkMPuqFA1hfOhhz8cAOuL2s8qg4ZJ6uzpfTRAMaqYC4xUBhj4QHOM+UHO/cJ
	nYqHhGHGiECm6dHVA22b1EIdbQSFcNGnaPynClaGqd8pjzRC1whteQYi8llN+b/C
	v8TsqYpuUheYoqHjQ1+gNd/BGQKFehbCm4d2cgUOAPT7c/sPbAATuAIYuwJJpubB
	tGuNBTjjnXes4p+445IXQ==
X-ME-Sender: <xms:sb9mabXmfO4q-BT4jrMSPuV2WYthM_6USJ-PLVKzIHoDwoiP5RBoug>
    <xme:sb9mac5IPkuUYXYtQmF5sOT8BSNLhq5eGlnrBnODbnc3I5wdk1nOFAJ3TqWR_MlBQ
    YBZ_sh-ZUPB5F62UQ69fcpM4VmNM9Vfa2ijq6V_bHDlg3VvwiOPtg>
X-ME-Received: <xmr:sb9maeriSyeCB-a3MQEnrc-t1crnGLwnQn2vU_yfQjri9kXiOs6X3dIXPqLMiAv3cjP_WPVjTVQdbUpf_c6rPeR9mCI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddugeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesthekre
    dttddtjeenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpedulefhtdfhteduvdethfeftdeitdethedvtdekvd
    eltddvveegtdeuuddtiedtieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepiedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhirghshhgvnhhgjhhirghnghgtohho
    lhesghhmrghilhdrtghomhdprhgtphhtthhopegtlhhmsehfsgdrtghomhdprhgtphhtth
    hopegushhtvghrsggrsehsuhhsvgdrtghomhdprhgtphhtthhopehfughmrghnrghnrges
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:sb9maXn4FZSdLaxbWjjPvK_tiOIN0-teRKYSqIFiMycYBXNVNzwr3Q>
    <xmx:sb9maSP4K9Y5NcQH60VgNz1ppN2_sGh6JV_9RBdoxW93x0r1LW_4kQ>
    <xmx:sb9maTMduspAqXiUltfTzovlVXpAMmDwHCc_PIRUlmeetBXTL1zc0Q>
    <xmx:sb9mabgcwpfZ2nr7G1r_9YW_hnJfQ1zKiwgV-hRnq9bQShx3QBzxsQ>
    <xmx:sb9maaAbzy1zWr_mqlDK8Lxtsj34SXzdtkOknItVP88X7BCk3_v2GMaC>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 16:57:04 -0500 (EST)
Date: Tue, 13 Jan 2026 13:57:05 -0800
From: Boris Burkov <boris@bur.io>
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: clm@fb.com, dsterba@suse.com, fdmanana@kernel.org,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] btrfs: reset block group size class when it becomes
 empty
Message-ID: <20260113215705.GB1048609@zen.localdomain>
References: <20260112185001.GA450687@zen.localdomain>
 <20260113205532.42625-1-jiashengjiangcool@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260113205532.42625-1-jiashengjiangcool@gmail.com>

On Tue, Jan 13, 2026 at 08:55:32PM +0000, Jiasheng Jiang wrote:
> Differential analysis of block-group.c shows an inconsistency in how
> block group size classes are managed.
> 
> Currently, btrfs_use_block_group_size_class() sets a block group's size
> class to specialize it for a specific allocation size. However, this
> size class remains "stale" even if the block group becomes completely
> empty (both used and reserved bytes reach zero).
> 
> This happens in two scenarios:
> 1. When space reservations are freed (e.g., due to errors or transaction
>    aborts) via btrfs_free_reserved_bytes().
> 2. When the last extent in a block group is freed via
>    btrfs_update_block_group().
> 
> While size classes are advisory, a stale size class can cause
> find_free_extent to unnecessarily skip candidate block groups during
> initial search loops. This undermines the purpose of size classes—to
> reduce fragmentation—by keeping block groups restricted to a specific
> size class when they could be reused for any size.
> 
> Fix this by resetting the size class to BTRFS_BG_SZ_NONE whenever a
> block group's used and reserved counts both reach zero. This ensures
> that empty block groups are fully available for any allocation size in
> the next cycle.
> 
> Fixes: 52bb7a2166af ("btrfs: introduce size class to block group allocator")

I don't think this necessarily amounts to a bug of the level that needs
a Fixes tag, since I don't think it should realistically break any
workload nor is it that urgent to backport to stable branches.

But if we want to use these tags to note targeted improvements / semi-bugs
then I am fine leaving it.

Either way,

Reviewed-by: Boris Burkov <boris@bur.io>

> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
> ---
> Changelog:
> 
> v3 -> v4:
> 1. Introduced btrfs_maybe_reset_size_class() helper to unify the logic.
> 2. Expanded the fix to include btrfs_update_block_group() to handle cases where the last extent in a block group is freed.
> 3. Refined the commit message to clarify that size classes are advisory and their stale state impacts allocation efficiency rather than causing absolute allocation failures.
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
>  fs/btrfs/block-group.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 08b14449fabe..343d7724939f 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -3675,6 +3675,14 @@ int btrfs_write_dirty_block_groups(struct btrfs_trans_handle *trans)
>  	return ret;
>  }
>  
> +static void btrfs_maybe_reset_size_class(struct btrfs_block_group *cache)
> +{
> +	lockdep_assert_held(&cache->lock);
> +	if (btrfs_block_group_should_use_size_class(cache) &&
> +	    cache->used == 0 && cache->reserved == 0)
> +		cache->size_class = BTRFS_BG_SZ_NONE;
> +}
> +
>  int btrfs_update_block_group(struct btrfs_trans_handle *trans,
>  			     u64 bytenr, u64 num_bytes, bool alloc)
>  {
> @@ -3739,6 +3747,7 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
>  		old_val -= num_bytes;
>  		cache->used = old_val;
>  		cache->pinned += num_bytes;
> +		btrfs_maybe_reset_size_class(cache);
>  		btrfs_space_info_update_bytes_pinned(space_info, num_bytes);
>  		space_info->bytes_used -= num_bytes;
>  		space_info->disk_used -= num_bytes * factor;
> @@ -3867,6 +3876,7 @@ void btrfs_free_reserved_bytes(struct btrfs_block_group *cache, u64 num_bytes,
>  	spin_lock(&cache->lock);
>  	bg_ro = cache->ro;
>  	cache->reserved -= num_bytes;
> +	btrfs_maybe_reset_size_class(cache);
>  	if (is_delalloc)
>  		cache->delalloc_bytes -= num_bytes;
>  	spin_unlock(&cache->lock);
> -- 
> 2.25.1
> 

