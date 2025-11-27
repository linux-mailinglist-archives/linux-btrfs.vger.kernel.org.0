Return-Path: <linux-btrfs+bounces-19376-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 106C8C8D5D8
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Nov 2025 09:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 750E14E586C
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Nov 2025 08:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334C9324B3E;
	Thu, 27 Nov 2025 08:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="ehn1f+jc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fo2xKWPV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCFA321F48
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 08:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764232642; cv=none; b=CPnxWG1e2WsTAesqCZ0xwXlN5cm8vdJCracT8t6V+qIqBk0zwCvm7IiQUJswrglWIHo62Rlt+P7KL/nczyWz40j45L5Ax0+BAuTHk9eyQ11QPGlC15ucaQamsA3Ex6nKPfPU7NESB8+KhITMBbJUrIQ67cUnPbLhBHByX0QcnSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764232642; c=relaxed/simple;
	bh=U+cb4ofjgqZ1ndI3JBKnvXE0+u2a7zaomIIOW8QKj8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=paXHMVCW5QFpx+sXDHqc+VdlpLafhm7k1TV3IyoKbCKkbb4ELQg/pUlSHNmmrvtQp4rtB3LRvKRl5bDsKdstXGAnYb8qcnMDykVEzA7upRyN9r/j8MH9c03lXf2QwSgze8qQNx0vPOnic7AquZoTecApCJqVCKf5f61hCKFLiYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=ehn1f+jc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fo2xKWPV; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 22B591D00157;
	Thu, 27 Nov 2025 03:37:19 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 27 Nov 2025 03:37:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1764232638; x=1764319038; bh=8/F+luMCva
	mhh+Hb7uNLkfLK5aSvfF/VioaXeZwu2UE=; b=ehn1f+jcO4h5lKs5hpmBYqJGWH
	kk93b/gMeak/VrbwflwmZ17tgdGWM0I6NE1JiCTPV/+lSbYamRN9DLZ4ho5cXaAc
	zxNSxMyPBVcELV/4ZAM9BiViZMUQjdj89YwuuKGSQ+63oXxmm7MPbZJnRuBbsOCH
	X+IuZ3Gu8yFwJMtq9VQeiYhtTrd5reaQHz6YoJ/RqRTipDuQqKU8iU0D6iFHB4D6
	J2sLm4NzhP3npb2U+SHrXgfiT+Hzi90C6Nq7cNEzlTIJI7mNSEw3j4ERlCDOHJAu
	A6ONC6imauEMe4ETLBwWpbO9KUrm0MpjKEq+Q9FbvdJfFwZ6Ace0Cz7xun0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764232638; x=1764319038; bh=8/F+luMCvamhh+Hb7uNLkfLK5aSvfF/Vioa
	XeZwu2UE=; b=fo2xKWPVp7G7da5X0s+x+0HJuGVaCAu63I8pIWKSiR/bQjBAa3u
	iREiedJPvpBugrJphgIHsnObKVP1MiDR5mJDcO+ufWIa1BmmOKyzMII5j7DzCBrj
	EAl/OZJIs+FekEn48Flq0I24kGJZ6hWbonXejuJKqyoUkUOSkc4FmjJ2QurLnozC
	CGtoHewu0fyTbdfdkllj4UVL1vpOYI5hjVt+WbXhLyCiy0Mre9V+1oO2u1wDWcJr
	G/4o1Pl/R775d4KUMaUb9Um7Ap/sx2z8M/PWcgOrFZaKENgCdZuBVR1upY1Z4szj
	Kms2mSS1Dj8cfcNFIX2Uv3ibwxNikCZwe5A==
X-ME-Sender: <xms:vQ0oaUo7QMGmZjtj1TgpTVlnEgRAY9GZ0AuOgau3o8VMpgwmfmtlGQ>
    <xme:vQ0oaQpaaaoNT7JVd5SsAEKh3eDF3vIQ73hChIwkXoEWyi1Go11c19ndEIkRbpoTB
    q0d2Y2U_y47_QQVc2abqMKgmebUqFQ_EO8NlW_SQm-r2EHJGBSA36hw>
X-ME-Received: <xmr:vQ0oaW1IQRf_k41_WNMYUQro9XUALgh6TxV-_p30btnbUa9u3r43y1xPVyyAthZikSaye1bJI8vE5OoRRDvlU1vwqSk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeeijeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrrhhksehhrghrmhhsthhonhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsg
    htrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:vg0oaXANNADqt-2MkkE-4-XbCYj_yOs_CpuZ8MG_HuGYi5pICvJ2cA>
    <xmx:vg0oaWfWQketOzdwdrJax40Ok1IQhLQ27OpZYNXlZYggHhUmjbyP_w>
    <xmx:vg0oaUi_ofqeJzfageFK64GWN1SMpiIVB60bHZWm2sqCUAadIIrbRw>
    <xmx:vg0oaWrUrarjUeWkE3BP2RblsJaQRkJ41yTSaiitFJrSMOZZXrlCww>
    <xmx:vg0oaYe-TwJjDTw80h-Rl9tmxlaEojK0R6IAwImUPqaPJGpVMkPwXpJ7>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Nov 2025 03:37:17 -0500 (EST)
Date: Thu, 27 Nov 2025 00:37:28 -0800
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v7 16/16] btrfs: populate fully_remapped_bgs_list on mount
Message-ID: <20251127083531.GA2656892@zen.localdomain>
References: <20251124185335.16556-1-mark@harmstone.com>
 <20251124185335.16556-17-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124185335.16556-17-mark@harmstone.com>

On Mon, Nov 24, 2025 at 06:53:08PM +0000, Mark Harmstone wrote:
> Add a function btrfs_populate_fully_remapped_bgs_list() which gets
> called on mount, which looks for fully remapped block groups
> (i.e. identity_remap_count == 0) which haven't yet had their chunk
> stripes and device extents removed.
> 
> This happens when a filesystem is unmounted while async discard has not
> yet finished, as otherwise the data range occupied by the chunk stripes
> would be permanently unusable.
> 
Reviewed-by: Boris Burkov <boris@bur.io>
> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> ---
>  fs/btrfs/block-group.c      | 79 +++++++++++++++++++++++++++++++++++++
>  fs/btrfs/block-group.h      |  2 +
>  fs/btrfs/disk-io.c          |  9 +++++
>  fs/btrfs/free-space-cache.c | 18 +++++++++
>  fs/btrfs/relocation.c       |  4 ++
>  5 files changed, 112 insertions(+)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index a6005a54273f..e82a8d8618be 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -4823,6 +4823,11 @@ void btrfs_mark_bg_fully_remapped(struct btrfs_block_group *bg,
>  	struct btrfs_fs_info *fs_info = trans->fs_info;
>  
>  	if (btrfs_test_opt(fs_info, DISCARD_ASYNC)) {
> +		spin_lock(&bg->lock);
> +		set_bit(BLOCK_GROUP_FLAG_STRIPE_REMOVAL_PENDING,
> +			&bg->runtime_flags);
> +		spin_unlock(&bg->lock);
> +
>  		btrfs_discard_queue_work(&fs_info->discard_ctl, bg);
>  	} else {
>  		spin_lock(&fs_info->unused_bgs_lock);
> @@ -4842,3 +4847,77 @@ void btrfs_mark_bg_fully_remapped(struct btrfs_block_group *bg,
>  		spin_unlock(&fs_info->unused_bgs_lock);
>  	}
>  }
> +
> +/*
> + * Compare the block group and chunk trees, and find any fully-remapped block
> + * groups which haven't yet had their chunk stripes and device extents removed,
> + * and put them on the fully_remapped_bgs list so this gets done.
> + *
> + * This happens when a block group becomes fully remapped, i.e. its last
> + * identity mapping is removed, and the volume is unmounted before async
> + * discard has finished. It's important this gets done as until it is the
> + * chunk's stripes are dead space.
> + */
> +int btrfs_populate_fully_remapped_bgs_list(struct btrfs_fs_info *fs_info)
> +{
> +	struct rb_node *node_bg, *node_chunk;
> +
> +	node_bg = rb_first_cached(&fs_info->block_group_cache_tree);
> +	node_chunk = rb_first_cached(&fs_info->mapping_tree);
> +
> +	while (node_bg && node_chunk) {
> +		struct btrfs_block_group *bg;
> +		struct btrfs_chunk_map *map;
> +
> +		bg = rb_entry(node_bg, struct btrfs_block_group, cache_node);
> +		map = rb_entry(node_chunk, struct btrfs_chunk_map, rb_node);
> +
> +		ASSERT(bg->start == map->start);
> +
> +		if (!(bg->flags & BTRFS_BLOCK_GROUP_REMAPPED))
> +			goto next;
> +
> +		if (bg->identity_remap_count != 0)
> +			goto next;
> +
> +		if (map->num_stripes == 0)
> +			goto next;
> +
> +		spin_lock(&fs_info->unused_bgs_lock);
> +
> +		if (list_empty(&bg->bg_list)) {
> +			btrfs_get_block_group(bg);
> +			list_add_tail(&bg->bg_list,
> +				      &fs_info->fully_remapped_bgs);
> +		} else {
> +			list_move_tail(&bg->bg_list,
> +				       &fs_info->fully_remapped_bgs);
> +		}
> +
> +		spin_unlock(&fs_info->unused_bgs_lock);
> +
> +		/*
> +		 * Ideally we'd want to call btrfs_discard_queue_work() here,
> +		 * but it'd do nothing as the discard worker hasn't been
> +		 * started yet.
> +		 *
> +		 * The block group will get added to the discard list when
> +		 * btrfs_handle_fully_remapped_bgs() gets called, when we
> +		 * commit the first transaction.
> +		 */
> +		if (btrfs_test_opt(fs_info, DISCARD_ASYNC)) {
> +			spin_lock(&bg->lock);
> +			set_bit(BLOCK_GROUP_FLAG_STRIPE_REMOVAL_PENDING,
> +				&bg->runtime_flags);
> +			spin_unlock(&bg->lock);
> +		}
> +
> +next:
> +		node_bg = rb_next(node_bg);
> +		node_chunk = rb_next(node_chunk);
> +	}
> +
> +	ASSERT(!node_bg && !node_chunk);
> +
> +	return 0;
> +}
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index 743702f4e5d1..bdb75bf1c3f5 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -93,6 +93,7 @@ enum btrfs_block_group_flags {
>  	 * transaction.
>  	 */
>  	BLOCK_GROUP_FLAG_NEW,
> +	BLOCK_GROUP_FLAG_STRIPE_REMOVAL_PENDING,
>  };
>  
>  enum btrfs_caching_type {
> @@ -416,5 +417,6 @@ int btrfs_use_block_group_size_class(struct btrfs_block_group *bg,
>  bool btrfs_block_group_should_use_size_class(const struct btrfs_block_group *bg);
>  void btrfs_mark_bg_fully_remapped(struct btrfs_block_group *bg,
>  				  struct btrfs_trans_handle *trans);
> +int btrfs_populate_fully_remapped_bgs_list(struct btrfs_fs_info *fs_info);
>  
>  #endif /* BTRFS_BLOCK_GROUP_H */
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index e29a6d5ecb2d..7e0e5f6f3223 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3637,6 +3637,15 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>  		goto fail_sysfs;
>  	}
>  
> +	if (btrfs_fs_incompat(fs_info, REMAP_TREE)) {
> +		ret = btrfs_populate_fully_remapped_bgs_list(fs_info);
> +		if (ret) {
> +			btrfs_err(fs_info,
> +			"failed to populate fully_remapped_bgs list: %d", ret);
> +			goto fail_sysfs;
> +		}
> +	}
> +
>  	btrfs_zoned_reserve_data_reloc_bg(fs_info);
>  	btrfs_free_zone_cache(fs_info);
>  
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index e15fa8567f7c..7f7744a78de2 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -3068,6 +3068,7 @@ bool btrfs_is_free_space_trimmed(struct btrfs_block_group *block_group)
>  	bool ret = true;
>  
>  	if (block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED &&
> +	    !test_bit(BLOCK_GROUP_FLAG_STRIPE_REMOVAL_PENDING, &block_group->runtime_flags) &&
>  	    block_group->identity_remap_count == 0) {
>  		return true;
>  	}
> @@ -3849,6 +3850,23 @@ void btrfs_trim_fully_remapped_block_group(struct btrfs_block_group *bg)
>  	const u64 max_discard_size = READ_ONCE(discard_ctl->max_discard_size);
>  	u64 end = btrfs_block_group_end(bg);
>  
> +	if (!test_bit(BLOCK_GROUP_FLAG_STRIPE_REMOVAL_PENDING, &bg->runtime_flags)) {
> +		bg->discard_cursor = end;
> +
> +		if (bg->used == 0) {
> +			spin_lock(&fs_info->unused_bgs_lock);
> +			if (!list_empty(&bg->bg_list)) {
> +				list_del_init(&bg->bg_list);
> +				btrfs_put_block_group(bg);
> +			}
> +			spin_unlock(&fs_info->unused_bgs_lock);
> +
> +			btrfs_mark_bg_unused(bg);
> +		}
> +
> +		return;
> +	}
> +
>  	bytes = end - bg->discard_cursor;
>  
>  	if (max_discard_size &&
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 2e1a87ab0509..25766b418a6b 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -4792,6 +4792,10 @@ int btrfs_last_identity_remap_gone(struct btrfs_chunk_map *chunk,
>  
>  	btrfs_remove_bg_from_sinfo(bg);
>  
> +	spin_lock(&bg->lock);
> +	clear_bit(BLOCK_GROUP_FLAG_STRIPE_REMOVAL_PENDING, &bg->runtime_flags);
> +	spin_unlock(&bg->lock);
> +
>  	ret = remove_chunk_stripes(trans, chunk, path);
>  	if (ret) {
>  		btrfs_abort_transaction(trans, ret);
> -- 
> 2.51.0
> 

