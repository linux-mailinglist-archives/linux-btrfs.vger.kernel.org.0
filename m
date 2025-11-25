Return-Path: <linux-btrfs+bounces-19341-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CFBC85DA9
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Nov 2025 17:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 834304E3151
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Nov 2025 16:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8C51EA7CE;
	Tue, 25 Nov 2025 16:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="TF7u8rIl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xEAni5jC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD75B168BD
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Nov 2025 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764086524; cv=none; b=OT7OuhFrRfN+jjOSrLxlZc3hhnay+me3uNI/gF6+Ei0ISiVqp6/sa5Ly2ifYqBxMaH/WaGHkkiV+wJ304qaz8Ls46PpFJudzoAJDiKo6neQls5zbMsQQOIlP53llB5gYKmiXLdcX7WvMUwmsw+zj7N5ZkOeT4h65khYmYSGLIMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764086524; c=relaxed/simple;
	bh=2Ya3tdL5zQp8betOD2FrzxXSDwpGf0LBWNAT0Lt7Q64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fu7EI5YeUAbYKPoMDXt8N3VKLwDpl1rndjPvC6kWedXt3wCyjUIcLSl+zqKmPOf9i/YMqrbuKuA5MA6lh+5DwaRr0r25Wgy78Bn6HwrHJBD3Y3PxDLL88OfPMlGEMBDL7EF/h0Nr9gNTVc5nAOGv2Jq8O87HuHBmVejyiNIXN4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=TF7u8rIl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xEAni5jC; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C4CCB140015A;
	Tue, 25 Nov 2025 11:02:00 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 25 Nov 2025 11:02:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1764086520; x=1764172920; bh=teXfiGeFlx
	W/dPJ8cqPpixXBlG6w8x6/SZNXU57eEXU=; b=TF7u8rIl53n/BQgLG5FVJxN/RA
	Xv9Mb/O5A4h2v8xyoVkS6cCFWoFVlTLQsYmQ1bgqIsJXGSKY6zL0Mr3LE7qNBQT5
	obmKtfRvcQxMW3hvAb0LyO9H/2fQXunfPeMtjHkwixkZ6hAXhYmjSnQWG1gZ3e8H
	FbGFXymvhTyObt0osESdHEtGp378mcArwzfQ4478rsTDugju69HsPUrkJonhZbPl
	8vs6JrLkM80obc+ixf9umrQ2F7fEr7Ydq9KAgou/sE5einDZ4Q8dnC8+fWPFJkik
	8sJs5ly5tN20TxgQHImmsG16rzvVTdu2etRZyc+UQ9kUDlz6w13WVeojBlGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1764086520; x=1764172920; bh=teXfiGeFlxW/dPJ8cqPpixXBlG6w8x6/SZN
	XU57eEXU=; b=xEAni5jCYDYNgCk5SG0Ld6JOmuWdogXdOKE+VNANgWU1UYrwVGn
	wZLsmxZTZL3QRv7KCBMfwp+Wpp7stq2NqJ/CbNlw247MSGR07QhOrPvDvNS6G+v1
	lzMcpvQz7KesoBfHSArZvMAc3L3p8lA+2OABsRlxz49XF2OqISBg87RvBiJS50lO
	Dq2Tg81XmkoWEtUMXL0D09RtVy6KjvisVselPu+IZC7OmKQeDGN8TXbPUBNe1mDV
	kWPIbKLwdm2R4/LdifHayafpl3otIDYYjiFgamM5Ratfl98eLtZrOwcDo0DXTsjT
	dGYvvxA9c2c2duXThlsAuhdpzJbyRNFmV4A==
X-ME-Sender: <xms:-NIlaUeYj2S3Xvq8DEaSxSrGilwU7vz8ZwBQ5JnSJrhmi2xic1WLXQ>
    <xme:-NIlacM_-5-gCLmiaJyaxWPu-FiGDWFOvud2sCesZiusJ96eGULSvYd9PkKqN03kV
    ia4Om6CNpI1OE9WUS0QmInQXyyBsdKVQSYFRygGQE32n0LYJ6aD>
X-ME-Received: <xmr:-NIlaTJOUO_SL3RYXDFGSOxR71ym018V-T7375M2ysaUReN6Ll38Qq-swzWdYZFGQWsWiTUxTFKsdaCOaFhJvUfgRfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeduledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrrhhksehhrghrmhhsthhonhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsg
    htrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:-NIlaVGAZKUp7Q7ZoPJRktrICqzcaFDivGSMn7P8e4iVy87Mhhm8WA>
    <xmx:-NIlaTTmhSkEo2tIRiuWmdFSiX28_BJ2uv3SLnOBI6hnkAfqcYMNqQ>
    <xmx:-NIlaZGnXeglXcrLNC7qBayNa0glZ_-DVucqb618P14RZC1YefNeyA>
    <xmx:-NIlaX9RrScMUzEtwXaSbFiBn90yTeyWKfhWxDKj7sH2wppuLbyKHQ>
    <xmx:-NIlaRxqRFMxRpxprcpujyL0tICdbl6MvMjndCxgNMa25J6_WkFAu_MF>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Nov 2025 11:01:59 -0500 (EST)
Date: Tue, 25 Nov 2025 08:02:13 -0800
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v7 15/16] btrfs: handle discarding fully-remapped block
 groups
Message-ID: <20251125160213.GB1650435@zen.localdomain>
References: <20251124185335.16556-1-mark@harmstone.com>
 <20251124185335.16556-16-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124185335.16556-16-mark@harmstone.com>

On Mon, Nov 24, 2025 at 06:53:07PM +0000, Mark Harmstone wrote:
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
Reviewed-by: Boris Burkov <boris@bur.io>
> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> ---
>  fs/btrfs/block-group.c      | 29 ++++++++++---------
>  fs/btrfs/block-group.h      |  1 +
>  fs/btrfs/discard.c          | 57 ++++++++++++++++++++++++++++++++-----
>  fs/btrfs/extent-tree.c      |  3 ++
>  fs/btrfs/free-space-cache.c | 36 +++++++++++++++++++++++
>  fs/btrfs/free-space-cache.h |  1 +
>  6 files changed, 107 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 5fa6910e9813..a6005a54273f 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -4822,20 +4822,23 @@ void btrfs_mark_bg_fully_remapped(struct btrfs_block_group *bg,
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
> index fd28353b4511..743702f4e5d1 100644
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
> index 1d86abee4e23..cbc9b20e17e7 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -2904,6 +2904,9 @@ void btrfs_handle_fully_remapped_bgs(struct btrfs_fs_info *fs_info)
>  		list_del_init(&block_group->bg_list);
>  		spin_unlock(&fs_info->unused_bgs_lock);
>  
> +		btrfs_discard_extent(fs_info, block_group->start,
> +				     block_group->length, NULL, false);
> +
>  		ret = btrfs_complete_bg_remapping(block_group);
>  		if (ret) {
>  			btrfs_put_block_group(block_group);
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index 17e79ee3e021..e15fa8567f7c 100644
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
> @@ -3834,6 +3840,36 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
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
> +	btrfs_complete_bg_remapping(bg);
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

