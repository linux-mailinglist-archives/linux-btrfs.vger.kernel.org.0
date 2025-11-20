Return-Path: <linux-btrfs+bounces-19174-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A99C718A8
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 01:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 297E3350138
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 00:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E371C6FF5;
	Thu, 20 Nov 2025 00:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="YeawhC2r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j32LV+I+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E84BE5E
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 00:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763598032; cv=none; b=GUP4Cqmu2JsKzE8R81FsZJhbGVMzB4ir0GbsxgGteqEu2A6MHgECI0QnDGhE5G2JhcO6blBWeMR9h8u3Zorw+uU8l4zv9Zhx5QLkXE2UbR3dV/RBaMDYRgN7au97mOecaEfmnjvVyDkkbztiSerbDIMxoMcbGDHR8GkC3arSCkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763598032; c=relaxed/simple;
	bh=wpcAzKMy4B7hKF3yjyw0HWVaYvm1E6fE+8OSzb4vSgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYt04raIs6e9+sQC5G6bITZnXqKqoBYuGUbyYgCM2IpTUh14KUvOMuWEhPSb8g8fi+XnhK+KtLGyDiNo+7Xi48J9QDfsFzRyQwu0aNha8O8wm6Ia/82wnc65m6qSJ3TWBnhQ8py++t1j38VJ+Rp15ZMFJ362KhEqCLVdODyMMeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=YeawhC2r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j32LV+I+; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id E8E21EC02FE;
	Wed, 19 Nov 2025 19:20:28 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 19 Nov 2025 19:20:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1763598028; x=1763684428; bh=OWHOhkqM4Q
	opNmnUWPlb5OcDnWKkjzF2JNrHzj8avOw=; b=YeawhC2rzIZ/R/TOvsk3152lgJ
	2yBU8gSEOt/XqELHDlUJziTIrDRzsBPnGJkp86l8VXBUyf9MHx40hp1mtvU5HpNd
	iNgLwdS/0FPTuCAW1kq7bE+pY6E3ChLRh6osimHhOuSGTS8Ciw02Tm2lbzHZtAYw
	CLXVYAwzzZk7Ck0KF22Prpuwb4zs18ZF4q2ksDx/weMkrAdhQAx9bAD34URpktq5
	YpOK7XrYlJ8WCrBxDot50Be+7RonueA+R9hVWfy+vmokGoh6l0VViT8tT6dytT5F
	s6Q9KL/o0cpjG0FBTyY0xotllCNt/4G5kjUxXhNrW7SqzLhGPEXjXPqWXEpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763598028; x=1763684428; bh=OWHOhkqM4QopNmnUWPlb5OcDnWKkjzF2JNr
	Hzj8avOw=; b=j32LV+I+BOtDrlk7jOm4nd8isFhpIeI81FiJqVjr6wtPGfUaGIM
	DJyw3G0l6SWpOhghp7inMZceTOD07kIeD/I7pZsbS6co/rPpViRUzI37HS2P5T/C
	OT0HOdRayRNLfPlc4vp3mMz2Z8EHy19iyJKLLPyDnQudSiZdbAte8bmKF0hMDC8o
	l4yl8aNx0iOqLGIwYtD7F9UVWAvp64FZOM80YNcDyQQigcvWnnrnSqahxpJQIg5a
	HUuOVejOY72jQA7IfmKRHXlTHB49zhKDHPExPseQFlz6Y3APEBTydM5AyT6XUl/I
	Z8M9NruRLc+WIb3iOaTQd2JhXAyhA5DMpyA==
X-ME-Sender: <xms:zF4eaRx3_jiHCXS-OFVlrkDbNGhxN68mELowc0oAiefiVUfOeeOEXA>
    <xme:zF4eaXR-v9E8_ezXLgJUJ1WPP5oWO3MOD2rraSN-HF5lWrQdtv1kZtpTipGqquGa5
    _EsSLrcukNIT2X7Ott6dfiDEZ5vrM0mWZn-xA8bNpOpW0e3Kp1Ja4dE>
X-ME-Received: <xmr:zF4eaY8FXrl4ddOcRfu3Ec4wdqKZnd5jFPFfAFtnwicosLDTUQfTFv06uuru7gexvO5qGUwJmJx7X_iWnaigOKALKPk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdehiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrrhhksehhrghrmhhsthhonhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsg
    htrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:zF4eaeogta_aWi69l1py7jjJ9D4wtUUWZm3L2UFHvu6LH9c2VbUXtw>
    <xmx:zF4eaVm9L7k_7d6wloT0QxtltCvgh1GpHCGG_NdlenWt3CymGrmtiQ>
    <xmx:zF4eaVKAFRdW_LcNM0jhYjicbMpsqNKXIq6OSMefZU7YP9TF_10BJA>
    <xmx:zF4eaawBnmjvjqbh-skvq5JtEHaddIy0gS0p1YA86yg8W2WsS3iodQ>
    <xmx:zF4eacm0-XXXb0h_Qa3gzFn5OiI6twr0FZUeINfiggnBMeLQU2UfiOBf>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Nov 2025 19:20:28 -0500 (EST)
Date: Wed, 19 Nov 2025 16:19:43 -0800
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v6 15/16] btrfs: handle discarding fully-remapped block
 groups
Message-ID: <20251120001943.GB2478853@zen.localdomain>
References: <20251114184745.9304-1-mark@harmstone.com>
 <20251114184745.9304-16-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114184745.9304-16-mark@harmstone.com>

On Fri, Nov 14, 2025 at 06:47:20PM +0000, Mark Harmstone wrote:
> Discard normally works by iterating over the free-space entries of a
> block group. This doesn't work for fully-remapped block groups, as we
> removed their free-space entries when we started relocation.
> 
> For sync discard, call btrfs_discard_extent() when we commit the
> transaction in which the last identity remap was removed.
> 
> For async discard, add a new function btrfs_trim_fully_remapped_block_group()
> to be called by the discard worker, which iterates over the block
> group's range using the normal async discard rules. Once we reach the
> end, remove the chunk's stripes and device extents to get back its free
> space.
> 
> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> ---
>  fs/btrfs/block-group.c      | 29 ++++++++--------
>  fs/btrfs/block-group.h      |  1 +
>  fs/btrfs/discard.c          | 57 ++++++++++++++++++++++++++++----
>  fs/btrfs/extent-tree.c      |  3 ++
>  fs/btrfs/free-space-cache.c | 66 +++++++++++++++++++++++++++++++++++++
>  fs/btrfs/free-space-cache.h |  1 +
>  6 files changed, 137 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 4c4edaf3c753..965ae904ec2e 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -4823,20 +4823,23 @@ void btrfs_mark_bg_fully_remapped(struct btrfs_block_group *bg,
>  {
>  	struct btrfs_fs_info *fs_info = trans->fs_info;
>  
> -	spin_lock(&fs_info->unused_bgs_lock);
> +	if (btrfs_test_opt(fs_info, DISCARD_ASYNC)) {
> +		btrfs_discard_queue_work(&fs_info->discard_ctl, bg);
> +	} else {
> +		spin_lock(&fs_info->unused_bgs_lock);
>  
> -	/*
> -	 * The block group might already be on the unused_bgs list, remove it
> -	 * if it is. It'll get readded after the async discard worker finishes,
> -	 * or in btrfs_handle_fully_remapped_bgs() if we're not using async
> -	 * discard.
> -	 */
> -	if (!list_empty(&bg->bg_list))
> -		list_del(&bg->bg_list);
> -	else
> -		btrfs_get_block_group(bg);
> +		/*
> +		 * The block group might already be on the unused_bgs list,
> +		 * remove it if it is. It'll get readded after
> +		 * btrfs_handle_fully_remapped_bgs() finishes.
> +		 */
> +		if (!list_empty(&bg->bg_list))
> +			list_del(&bg->bg_list);
> +		else
> +			btrfs_get_block_group(bg);
>  
> -	list_add_tail(&bg->bg_list, &fs_info->fully_remapped_bgs);
> +		list_add_tail(&bg->bg_list, &fs_info->fully_remapped_bgs);
>  
> -	spin_unlock(&fs_info->unused_bgs_lock);
> +		spin_unlock(&fs_info->unused_bgs_lock);
> +	}
>  }
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index 4522074a45c2..b0b16efea19a 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -49,6 +49,7 @@ enum btrfs_discard_state {
>  	BTRFS_DISCARD_EXTENTS,
>  	BTRFS_DISCARD_BITMAPS,
>  	BTRFS_DISCARD_RESET_CURSOR,
> +	BTRFS_DISCARD_FULLY_REMAPPED,
>  };
>  
>  /*
> diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> index ee5f5b2788e1..f9890037395a 100644
> --- a/fs/btrfs/discard.c
> +++ b/fs/btrfs/discard.c
> @@ -215,6 +215,27 @@ static struct btrfs_block_group *find_next_block_group(
>  	return ret_block_group;
>  }
>  
> +/*
> + * Returns whether a block group is empty.
> + *
> + * @block_group: block_group of interest
> + *
> + * "Empty" here means that there are no extents physically located within the
> + * device extents corresponding to this block group.
> + *
> + * For a remapped block group, this means that all of its identity remaps have
> + * been removed. For a non-remapped block group, this means that no extents
> + * have an address within its range, and that nothing has been remapped to be
> + * within it.
> + */
> +static bool block_group_is_empty(struct btrfs_block_group *block_group)
> +{
> +	if (block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED)
> +		return block_group->identity_remap_count == 0;
> +	else
> +		return block_group->used == 0 && block_group->remap_bytes == 0;
> +}
> +
>  /*
>   * Look up next block group and set it for use.
>   *
> @@ -241,8 +262,10 @@ static struct btrfs_block_group *peek_discard_list(
>  	block_group = find_next_block_group(discard_ctl, now);
>  
>  	if (block_group && now >= block_group->discard_eligible_time) {
> +		bool empty = block_group_is_empty(block_group);
> +
>  		if (block_group->discard_index == BTRFS_DISCARD_INDEX_UNUSED &&
> -		    block_group->used != 0) {
> +		    !empty) {
>  			if (btrfs_is_block_group_data_only(block_group)) {
>  				__add_to_discard_list(discard_ctl, block_group);
>  				/*
> @@ -267,7 +290,15 @@ static struct btrfs_block_group *peek_discard_list(
>  		}
>  		if (block_group->discard_state == BTRFS_DISCARD_RESET_CURSOR) {
>  			block_group->discard_cursor = block_group->start;
> -			block_group->discard_state = BTRFS_DISCARD_EXTENTS;
> +
> +			if (block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED &&
> +			    empty) {
> +				block_group->discard_state =
> +					BTRFS_DISCARD_FULLY_REMAPPED;
> +			} else {
> +				block_group->discard_state =
> +					BTRFS_DISCARD_EXTENTS;
> +			}
>  		}
>  	}
>  	if (block_group) {
> @@ -373,7 +404,7 @@ void btrfs_discard_queue_work(struct btrfs_discard_ctl *discard_ctl,
>  	if (!block_group || !btrfs_test_opt(block_group->fs_info, DISCARD_ASYNC))
>  		return;
>  
> -	if (block_group->used == 0 && block_group->remap_bytes == 0)
> +	if (block_group_is_empty(block_group))
>  		add_to_discard_unused_list(discard_ctl, block_group);
>  	else
>  		add_to_discard_list(discard_ctl, block_group);
> @@ -470,7 +501,7 @@ static void btrfs_finish_discard_pass(struct btrfs_discard_ctl *discard_ctl,
>  {
>  	remove_from_discard_list(discard_ctl, block_group);
>  
> -	if (block_group->used == 0) {
> +	if (block_group_is_empty(block_group)) {
>  		if (btrfs_is_free_space_trimmed(block_group))
>  			btrfs_mark_bg_unused(block_group);
>  		else
> @@ -524,7 +555,8 @@ static void btrfs_discard_workfn(struct work_struct *work)
>  	/* Perform discarding */
>  	minlen = discard_minlen[discard_index];
>  
> -	if (discard_state == BTRFS_DISCARD_BITMAPS) {
> +	switch (discard_state) {
> +	case BTRFS_DISCARD_BITMAPS: {
>  		u64 maxlen = 0;
>  
>  		/*
> @@ -541,17 +573,28 @@ static void btrfs_discard_workfn(struct work_struct *work)
>  				       btrfs_block_group_end(block_group),
>  				       minlen, maxlen, true);
>  		discard_ctl->discard_bitmap_bytes += trimmed;
> -	} else {
> +
> +		break;
> +	}
> +
> +	case BTRFS_DISCARD_FULLY_REMAPPED:
> +		btrfs_trim_fully_remapped_block_group(block_group);
> +		break;
> +
> +	default:
>  		btrfs_trim_block_group_extents(block_group, &trimmed,
>  				       block_group->discard_cursor,
>  				       btrfs_block_group_end(block_group),
>  				       minlen, true);
>  		discard_ctl->discard_extent_bytes += trimmed;
> +
> +		break;
>  	}
>  
>  	/* Determine next steps for a block_group */
>  	if (block_group->discard_cursor >= btrfs_block_group_end(block_group)) {
> -		if (discard_state == BTRFS_DISCARD_BITMAPS) {
> +		if (discard_state == BTRFS_DISCARD_BITMAPS ||
> +		    discard_state == BTRFS_DISCARD_FULLY_REMAPPED) {
>  			btrfs_finish_discard_pass(discard_ctl, block_group);
>  		} else {
>  			block_group->discard_cursor = block_group->start;
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 91b4e1b0842c..f64ca57108af 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -2876,6 +2876,9 @@ void btrfs_handle_fully_remapped_bgs(struct btrfs_fs_info *fs_info)
>  			return;
>  		}
>  
> +		btrfs_discard_extent(fs_info, block_group->start,
> +				     block_group->length, NULL, false);
> +
>  		/*
>  		 * Set num_stripes to 0, so that btrfs_remove_dev_extents()
>  		 * won't run a second time.
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index 30507fa8ad80..1b8716b17031 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -29,6 +29,7 @@
>  #include "file-item.h"
>  #include "file.h"
>  #include "super.h"
> +#include "relocation.h"
>  
>  #define BITS_PER_BITMAP		(PAGE_SIZE * 8UL)
>  #define MAX_CACHE_BYTES_PER_GIG	SZ_64K
> @@ -3066,6 +3067,11 @@ bool btrfs_is_free_space_trimmed(struct btrfs_block_group *block_group)
>  	struct rb_node *node;
>  	bool ret = true;
>  
> +	if (block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED &&
> +	    block_group->identity_remap_count == 0) {
> +		return true;
> +	}
> +
>  	spin_lock(&ctl->tree_lock);
>  	node = rb_first(&ctl->free_space_offset);
>  
> @@ -3834,6 +3840,66 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
>  	return ret;
>  }
>  
> +void btrfs_trim_fully_remapped_block_group(struct btrfs_block_group *bg)
> +{
> +	struct btrfs_fs_info *fs_info = bg->fs_info;
> +	struct btrfs_discard_ctl *discard_ctl = &fs_info->discard_ctl;
> +	int ret = 0;
> +	u64 bytes, trimmed;
> +	const u64 max_discard_size = READ_ONCE(discard_ctl->max_discard_size);
> +	u64 end = btrfs_block_group_end(bg);
> +	struct btrfs_chunk_map *map;
> +
> +	bytes = end - bg->discard_cursor;
> +
> +	if (max_discard_size &&
> +		bytes >= (max_discard_size +
> +			BTRFS_ASYNC_DISCARD_MIN_FILTER)) {
> +		bytes = max_discard_size;
> +	}
> +
> +	ret = btrfs_discard_extent(fs_info, bg->discard_cursor, bytes, &trimmed,
> +				   false);
> +	if (ret)
> +		return;
> +
> +	bg->discard_cursor += trimmed;
> +
> +	if (bg->discard_cursor < end)
> +		return;
> +
> +	map = btrfs_get_chunk_map(fs_info, bg->start, 1);
> +	if (IS_ERR(map)) {
> +		ret = PTR_ERR(map);
> +		return;
> +	}
> +
> +	ret = btrfs_last_identity_remap_gone(map, bg);
> +	if (ret) {
> +		btrfs_free_chunk_map(map);
> +		return;
> +	}
> +
> +	/*
> +	 * Set num_stripes to 0, so that btrfs_remove_dev_extents()
> +	 * won't run a second time.
> +	 */
> +	map->num_stripes = 0;
> +
> +	btrfs_free_chunk_map(map);
> +
> +	if (bg->used == 0) {
> +		spin_lock(&fs_info->unused_bgs_lock);
> +		if (!list_empty(&bg->bg_list)) {
> +			list_del_init(&bg->bg_list);
> +			btrfs_put_block_group(bg);
> +		}
> +		spin_unlock(&fs_info->unused_bgs_lock);
> +
> +		btrfs_mark_bg_unused(bg);
> +	}

This sequence here:
get_chunk -> last_identity_remap_gone -> num_stripes = 0 -> free_chunk_map -> mark_unused 

is the same as in handle_fully_remapped_bgs, and should be shared. In
fact, that would have prevented you from having the bespoke
mark_bg_unused here but not there (which I think I did complain about in
v5, but it's hard to keep track over email..)

> +}
> +
>  /*
>   * If we break out of trimming a bitmap prematurely, we should reset the
>   * trimming bit.  In a rather contrived case, it's possible to race here so
> diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
> index 9f1dbfdee8ca..33fc3b245648 100644
> --- a/fs/btrfs/free-space-cache.h
> +++ b/fs/btrfs/free-space-cache.h
> @@ -166,6 +166,7 @@ int btrfs_trim_block_group_extents(struct btrfs_block_group *block_group,
>  int btrfs_trim_block_group_bitmaps(struct btrfs_block_group *block_group,
>  				   u64 *trimmed, u64 start, u64 end, u64 minlen,
>  				   u64 maxlen, bool async);
> +void btrfs_trim_fully_remapped_block_group(struct btrfs_block_group *bg);
>  
>  bool btrfs_free_space_cache_v1_active(struct btrfs_fs_info *fs_info);
>  int btrfs_set_free_space_cache_v1_active(struct btrfs_fs_info *fs_info, bool active);
> -- 
> 2.51.0
> 

