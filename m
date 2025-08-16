Return-Path: <linux-btrfs+bounces-16104-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE9DB2893A
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Aug 2025 02:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FE0BAA6036
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Aug 2025 00:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FC510957;
	Sat, 16 Aug 2025 00:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="K6JCjTdc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cxwBTbJ2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9700F38B
	for <linux-btrfs@vger.kernel.org>; Sat, 16 Aug 2025 00:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755304065; cv=none; b=HQJJAedeieAmbju4K8pyF8X/22tyQ/iNVIQAt1kiLU1SjzNSflYUnWesAdo6FHLRSjMgdoG1xmal7uXAy5uU7csr3ArNqGJmcUdCMhPGIKUedK65Ne4V2mKbHKeSYbL3e93YFiu/hVXS8SYAD3kZVLvk1ABbzGblyynenmlVtis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755304065; c=relaxed/simple;
	bh=dJz1mkksrDvKErDygfWzu6TjIAydDWhrlFCWUwlQFRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXg51F4xUi7U/hAu1t/0BDTPGDW4dXi7DF3PiCn9Vk6GAT8WqGBjZOfe9SYYKdEKNVdA7BXb/6Nl08QeA5GZyLWys5tBuu2SidzNulLlyG5n/hANVR5tu/HNsA4IOuiTIeXfYHc1KS4PKgN8Ps2wcVu82Cj+vaztzsLkqYk9Lj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=K6JCjTdc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cxwBTbJ2; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AA70B7A0296;
	Fri, 15 Aug 2025 20:27:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 15 Aug 2025 20:27:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1755304061; x=1755390461; bh=FofBJpP9vp
	9bruAlZ1cxY3iboOnDF41iaDJ2wn+sZnE=; b=K6JCjTdcbWry1j3job/sq6bOqf
	cGN1ygSBP/IL7kBnt6Zo28nxKeEgzDedaCQqB6uS21r0PBgephsAMRe/675opn1Z
	YKFR2IVUNq3ulGqRclUWSHfd2Dp06dz+CucNLKhn5F2jYQYk///up/mGLmajIBIT
	KcdSTt4Fr0r2zuynt1bWC/nGeI5rnyRoHLLJNMi7ElOg6sWnXWb56WHGBio81IXZ
	atb/wdZsWsUM0ql/OPu580oKY7JQLMzwhzC4E8KNN63vHDu2ktv9yfA/npRjZiI8
	JPl+Xh5rduSZ/T28IlDuGgTHsAabXTnga2CzDBtzN0Q/pWvS1PehKoRQsiLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755304061; x=1755390461; bh=FofBJpP9vp9bruAlZ1cxY3iboOnDF41iaDJ
	2wn+sZnE=; b=cxwBTbJ2YXB2mkbu9rlO/9X3OHYFbOL5fsZVFWJGcNSmRXWO5jZ
	zNRpld0ZfZjwJERIDRh7MV0JLPRzoUkIxuM5m9WnDtHnDPSoKMp44c1JsUiTIhEF
	tcQOfXqdU+qKU+t1lqe7rFP1k+oEzLD/jYYN9py7lUnn8bpqZ0GscclocMv1zwQe
	8/3GSxFdwh8yp/YvfRp7fvpkHPzE/dH9biYqRtTbCTU5ATcXJFS646yKQZYhvFkL
	gQahakFGXKuOZynM71lcXs6d6G7kXXFIxTH3SPyirQMbZl0Ql2Uj1XlFfDhsGQg2
	ewnvONyuT4Owf/fDk6TVWOKWS6vIqE2rT8g==
X-ME-Sender: <xms:fdCfaEtbU6zArmRHDv4CPOODFSyYI8rMJJ9rMEmgEsYdxNq3R1S7qA>
    <xme:fdCfaBo38Kq7M2pbwhYMW-omCFZp6_2GTGbtpXDXOzA_dlxJ6fUfVymnZjR9X8ZsE
    yd4l8IsoMOW0blTLo4>
X-ME-Received: <xmr:fdCfaBkbmxkOMFMlZwZNYYN_HoY_w0EXiZ23DnrEHtFKFImS9PyoeuaP7TDQnzza6mGJuYQd6Kl1pBm3ikuVf-J0H84>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeehgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrrhhksehhrghrmhhsthhonhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsg
    htrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:fdCfaFx9NdQPFc_M6hQZBdc2xCt8zskzGXPGO1GogUAwGH2j22ELcg>
    <xmx:fdCfaJnzzl8SKlvHosT1TmYbDow3jcupRec3BRGH9BKKFwLlORseSA>
    <xmx:fdCfaOfgmdRZcF0LYmwFpoxffzzC79EJ8IqVzGeULdJ4T7VhvdN8sw>
    <xmx:fdCfaPpDWh6mNScwqIUgQjBtGSAYrACCJS2Y_pntm9EHdjOIvEGJnw>
    <xmx:fdCfaPw2eS-bzmCuUS-n-bpQBUT8BnUZBXGIE0KTQwDMJ-lyqEM49OXW>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Aug 2025 20:27:40 -0400 (EDT)
Date: Fri, 15 Aug 2025 17:28:22 -0700
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 10/16] btrfs: handle deletions from remapped block
 group
Message-ID: <20250816002822.GE3042054@zen.localdomain>
References: <20250813143509.31073-1-mark@harmstone.com>
 <20250813143509.31073-11-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813143509.31073-11-mark@harmstone.com>

On Wed, Aug 13, 2025 at 03:34:52PM +0100, Mark Harmstone wrote:
> Handle the case where we free an extent from a block group that has the
> REMAPPED flag set. Because the remap tree is orthogonal to the extent
> tree, for data this may be within any number of identity remaps or
> actual remaps. If we're freeing a metadata node, this will be wholly
> inside one or the other.
> 
> btrfs_remove_extent_from_remap_tree() searches the remap tree for the
> remaps that cover the range in question, then calls
> remove_range_from_remap_tree() for each one, to punch a hole in the
> remap and adjust the free-space tree.
> 
> For an identity remap, remove_range_from_remap_tree() will adjust the
> block group's `identity_remap_count` if this changes. If it reaches
> zero we call last_identity_remap_gone(), which removes the chunk's
> stripes and device extents - it is now fully remapped.
> 
> The changes which involve the block group's ro flag are because the
> REMAPPED flag itself prevents a block group from having any new
> allocations within it, and so we don't need to account for this
> separately.
> 
> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> ---
>  fs/btrfs/block-group.c |  82 ++++---
>  fs/btrfs/block-group.h |   1 +
>  fs/btrfs/disk-io.c     |   1 +
>  fs/btrfs/extent-tree.c |  28 ++-
>  fs/btrfs/fs.h          |   1 +
>  fs/btrfs/relocation.c  | 510 +++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/relocation.h  |   3 +
>  fs/btrfs/volumes.c     |  56 +++--
>  fs/btrfs/volumes.h     |   6 +
>  9 files changed, 630 insertions(+), 58 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 8c28f829547e..7a0524138235 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1068,6 +1068,32 @@ static int remove_block_group_item(struct btrfs_trans_handle *trans,
>  	return ret;
>  }
>  
> +void btrfs_remove_bg_from_sinfo(struct btrfs_block_group *block_group)
> +{
> +	int factor = btrfs_bg_type_to_factor(block_group->flags);
> +
> +	spin_lock(&block_group->space_info->lock);
> +
> +	if (btrfs_test_opt(block_group->fs_info, ENOSPC_DEBUG)) {
> +		WARN_ON(block_group->space_info->total_bytes
> +			< block_group->length);
> +		WARN_ON(block_group->space_info->bytes_readonly
> +			< block_group->length - block_group->zone_unusable);
> +		WARN_ON(block_group->space_info->bytes_zone_unusable
> +			< block_group->zone_unusable);
> +		WARN_ON(block_group->space_info->disk_total
> +			< block_group->length * factor);
> +	}
> +	block_group->space_info->total_bytes -= block_group->length;
> +	block_group->space_info->bytes_readonly -=
> +		(block_group->length - block_group->zone_unusable);
> +	btrfs_space_info_update_bytes_zone_unusable(block_group->space_info,
> +						    -block_group->zone_unusable);
> +	block_group->space_info->disk_total -= block_group->length * factor;
> +
> +	spin_unlock(&block_group->space_info->lock);
> +}
> +
>  int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
>  			     struct btrfs_chunk_map *map)
>  {
> @@ -1079,7 +1105,6 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
>  	struct kobject *kobj = NULL;
>  	int ret;
>  	int index;
> -	int factor;
>  	struct btrfs_caching_control *caching_ctl = NULL;
>  	bool remove_map;
>  	bool remove_rsv = false;
> @@ -1088,7 +1113,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
>  	if (!block_group)
>  		return -ENOENT;
>  
> -	BUG_ON(!block_group->ro);
> +	BUG_ON(!block_group->ro && !(block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED));
>  
>  	trace_btrfs_remove_block_group(block_group);
>  	/*
> @@ -1100,7 +1125,6 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
>  				  block_group->length);
>  
>  	index = btrfs_bg_flags_to_raid_index(block_group->flags);
> -	factor = btrfs_bg_type_to_factor(block_group->flags);
>  
>  	/* make sure this block group isn't part of an allocation cluster */
>  	cluster = &fs_info->data_alloc_cluster;
> @@ -1224,26 +1248,11 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
>  
>  	spin_lock(&block_group->space_info->lock);
>  	list_del_init(&block_group->ro_list);
> -
> -	if (btrfs_test_opt(fs_info, ENOSPC_DEBUG)) {
> -		WARN_ON(block_group->space_info->total_bytes
> -			< block_group->length);
> -		WARN_ON(block_group->space_info->bytes_readonly
> -			< block_group->length - block_group->zone_unusable);
> -		WARN_ON(block_group->space_info->bytes_zone_unusable
> -			< block_group->zone_unusable);
> -		WARN_ON(block_group->space_info->disk_total
> -			< block_group->length * factor);
> -	}
> -	block_group->space_info->total_bytes -= block_group->length;
> -	block_group->space_info->bytes_readonly -=
> -		(block_group->length - block_group->zone_unusable);
> -	btrfs_space_info_update_bytes_zone_unusable(block_group->space_info,
> -						    -block_group->zone_unusable);
> -	block_group->space_info->disk_total -= block_group->length * factor;
> -
>  	spin_unlock(&block_group->space_info->lock);
>  
> +	if (!(block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED))
> +		btrfs_remove_bg_from_sinfo(block_group);
> +
>  	/*
>  	 * Remove the free space for the block group from the free space tree
>  	 * and the block group's item from the extent tree before marking the
> @@ -1539,6 +1548,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>  	while (!list_empty(&fs_info->unused_bgs)) {
>  		u64 used;
>  		int trimming;
> +		bool made_ro = false;
>  
>  		block_group = list_first_entry(&fs_info->unused_bgs,
>  					       struct btrfs_block_group,
> @@ -1575,7 +1585,8 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>  
>  		spin_lock(&space_info->lock);
>  		spin_lock(&block_group->lock);
> -		if (btrfs_is_block_group_used(block_group) || block_group->ro ||
> +		if (btrfs_is_block_group_used(block_group) ||
> +		    (block_group->ro && !(block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED)) ||
>  		    list_is_singular(&block_group->list)) {
>  			/*
>  			 * We want to bail if we made new allocations or have
> @@ -1617,9 +1628,10 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>  		 * needing to allocate extents from the block group.
>  		 */
>  		used = btrfs_space_info_used(space_info, true);
> -		if ((space_info->total_bytes - block_group->length < used &&
> +		if (((space_info->total_bytes - block_group->length < used &&
>  		     block_group->zone_unusable < block_group->length) ||
> -		    has_unwritten_metadata(block_group)) {
> +		    has_unwritten_metadata(block_group)) &&
> +			!(block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED)) {
>  			spin_unlock(&block_group->lock);
>  
>  			/*
> @@ -1638,8 +1650,14 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>  		spin_unlock(&block_group->lock);
>  		spin_unlock(&space_info->lock);
>  
> -		/* We don't want to force the issue, only flip if it's ok. */
> -		ret = inc_block_group_ro(block_group, 0);
> +		if (!(block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED)) {
> +			/* We don't want to force the issue, only flip if it's ok. */
> +			ret = inc_block_group_ro(block_group, 0);
> +			made_ro = true;
> +		} else {
> +			ret = 0;
> +		}
> +
>  		up_write(&space_info->groups_sem);
>  		if (ret < 0) {
>  			ret = 0;
> @@ -1648,7 +1666,8 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>  
>  		ret = btrfs_zone_finish(block_group);
>  		if (ret < 0) {
> -			btrfs_dec_block_group_ro(block_group);
> +			if (made_ro)
> +				btrfs_dec_block_group_ro(block_group);
>  			if (ret == -EAGAIN) {
>  				btrfs_link_bg_list(block_group, &retry_list);
>  				ret = 0;
> @@ -1663,7 +1682,8 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>  		trans = btrfs_start_trans_remove_block_group(fs_info,
>  						     block_group->start);
>  		if (IS_ERR(trans)) {
> -			btrfs_dec_block_group_ro(block_group);
> +			if (made_ro)
> +				btrfs_dec_block_group_ro(block_group);
>  			ret = PTR_ERR(trans);
>  			goto next;
>  		}
> @@ -1673,7 +1693,8 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>  		 * just delete them, we don't care about them anymore.
>  		 */
>  		if (!clean_pinned_extents(trans, block_group)) {
> -			btrfs_dec_block_group_ro(block_group);
> +			if (made_ro)
> +				btrfs_dec_block_group_ro(block_group);
>  			goto end_trans;
>  		}
>  
> @@ -1687,7 +1708,8 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>  		spin_lock(&fs_info->discard_ctl.lock);
>  		if (!list_empty(&block_group->discard_list)) {
>  			spin_unlock(&fs_info->discard_ctl.lock);
> -			btrfs_dec_block_group_ro(block_group);
> +			if (made_ro)
> +				btrfs_dec_block_group_ro(block_group);
>  			btrfs_discard_queue_work(&fs_info->discard_ctl,
>  						 block_group);
>  			goto end_trans;
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index ecc89701b2ea..0433b0127ed8 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -336,6 +336,7 @@ int btrfs_add_new_free_space(struct btrfs_block_group *block_group,
>  struct btrfs_trans_handle *btrfs_start_trans_remove_block_group(
>  				struct btrfs_fs_info *fs_info,
>  				const u64 chunk_offset);
> +void btrfs_remove_bg_from_sinfo(struct btrfs_block_group *block_group);
>  int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
>  			     struct btrfs_chunk_map *map);
>  void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info);
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 563aea5e3b1b..d92d08316322 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2907,6 +2907,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
>  	mutex_init(&fs_info->chunk_mutex);
>  	mutex_init(&fs_info->transaction_kthread_mutex);
>  	mutex_init(&fs_info->cleaner_mutex);
> +	mutex_init(&fs_info->remap_mutex);
>  	mutex_init(&fs_info->ro_block_group_mutex);
>  	init_rwsem(&fs_info->commit_root_sem);
>  	init_rwsem(&fs_info->cleanup_work_sem);
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index c1b96c728fe6..ca3f6d6bb5ba 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -40,6 +40,7 @@
>  #include "orphan.h"
>  #include "tree-checker.h"
>  #include "raid-stripe-tree.h"
> +#include "relocation.h"
>  
>  #undef SCRAMBLE_DELAYED_REFS
>  
> @@ -2999,7 +3000,8 @@ u64 btrfs_get_extent_owner_root(struct btrfs_fs_info *fs_info,
>  }
>  
>  static int do_free_extent_accounting(struct btrfs_trans_handle *trans,
> -				     u64 bytenr, struct btrfs_squota_delta *delta)
> +				     u64 bytenr, struct btrfs_squota_delta *delta,
> +				     bool remapped)
>  {
>  	int ret;
>  	u64 num_bytes = delta->num_bytes;
> @@ -3027,10 +3029,16 @@ static int do_free_extent_accounting(struct btrfs_trans_handle *trans,
>  		return ret;
>  	}
>  
> -	ret = btrfs_add_to_free_space_tree(trans, bytenr, num_bytes);
> -	if (ret) {
> -		btrfs_abort_transaction(trans, ret);
> -		return ret;
> +	/*
> +	 * If remapped, FST has already been taken care of in
> +	 * remove_range_from_remap_tree().
> +	 */

Why not do btrfs_remove_extent_from_remap_tree() here in
do_free_extent_accounting() rather than the caller?

> +	if (!remapped) {
> +		ret = btrfs_add_to_free_space_tree(trans, bytenr, num_bytes);
> +		if (ret) {
> +			btrfs_abort_transaction(trans, ret);
> +			return ret;
> +		}
>  	}
>  
>  	ret = btrfs_update_block_group(trans, bytenr, num_bytes, false);

So in the normal case, this will trigger updating the block group bytes
counters, and when they hit 0 put the block group on the unused list,
which queues it for deletion and ultimately removing from space info
etc.

I fail to see what is special about remapped block groups from that
perspective. I would strongly prefer to see you integrate with
btrsf_delete_unused_bgs() rather than special case skipping it there and
copying parts of the logic elsewhere.

Unless there is some very good reason for the special treatment that I
am not seeing.

> @@ -3396,7 +3404,15 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
>  		}
>  		btrfs_release_path(path);
>  
> -		ret = do_free_extent_accounting(trans, bytenr, &delta);
> +		/* returns 1 on success and 0 on no-op */
> +		ret = btrfs_remove_extent_from_remap_tree(trans, path, bytenr,
> +							  num_bytes);
> +		if (ret < 0) {
> +			btrfs_abort_transaction(trans, ret);
> +			goto out;
> +		}
> +
> +		ret = do_free_extent_accounting(trans, bytenr, &delta, ret);
>  	}
>  	btrfs_release_path(path);
>  
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 6ea96e76655e..dbb7de95241b 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -547,6 +547,7 @@ struct btrfs_fs_info {
>  	struct mutex transaction_kthread_mutex;
>  	struct mutex cleaner_mutex;
>  	struct mutex chunk_mutex;
> +	struct mutex remap_mutex;
>  
>  	/*
>  	 * This is taken to make sure we don't set block groups ro after the
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index e1f1da9336e7..03a1246af678 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -37,6 +37,7 @@
>  #include "super.h"
>  #include "tree-checker.h"
>  #include "raid-stripe-tree.h"
> +#include "free-space-tree.h"
>  
>  /*
>   * Relocation overview
> @@ -3884,6 +3885,148 @@ static const char *stage_to_string(enum reloc_stage stage)
>  	return "unknown";
>  }
>  
> +static void adjust_block_group_remap_bytes(struct btrfs_trans_handle *trans,
> +					   struct btrfs_block_group *bg,
> +					   s64 diff)
> +{
> +	struct btrfs_fs_info *fs_info = trans->fs_info;
> +	bool bg_already_dirty = true;
> +
> +	bg->remap_bytes += diff;
> +
> +	if (bg->used == 0 && bg->remap_bytes == 0)
> +		btrfs_mark_bg_unused(bg);
> +
> +	spin_lock(&trans->transaction->dirty_bgs_lock);
> +	if (list_empty(&bg->dirty_list)) {
> +		list_add_tail(&bg->dirty_list, &trans->transaction->dirty_bgs);
> +		bg_already_dirty = false;
> +		btrfs_get_block_group(bg);
> +	}
> +	spin_unlock(&trans->transaction->dirty_bgs_lock);
> +
> +	/* Modified block groups are accounted for in the delayed_refs_rsv. */
> +	if (!bg_already_dirty)
> +		btrfs_inc_delayed_refs_rsv_bg_updates(fs_info);
> +}
> +
> +static int remove_chunk_stripes(struct btrfs_trans_handle *trans,
> +				struct btrfs_chunk_map *chunk,
> +				struct btrfs_path *path)
> +{
> +	struct btrfs_fs_info *fs_info = trans->fs_info;
> +	struct btrfs_key key;
> +	struct extent_buffer *leaf;
> +	struct btrfs_chunk *c;
> +	int ret;
> +
> +	key.objectid = BTRFS_FIRST_CHUNK_TREE_OBJECTID;
> +	key.type = BTRFS_CHUNK_ITEM_KEY;
> +	key.offset = chunk->start;
> +
> +	ret = btrfs_search_slot(trans, fs_info->chunk_root, &key, path,
> +				0, 1);
> +	if (ret) {
> +		if (ret == 1) {
> +			btrfs_release_path(path);
> +			ret = -ENOENT;
> +		}
> +		return ret;
> +	}
> +
> +	leaf = path->nodes[0];
> +
> +	c = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_chunk);
> +	btrfs_set_chunk_num_stripes(leaf, c, 0);
> +
> +	btrfs_truncate_item(trans, path, offsetof(struct btrfs_chunk, stripe),
> +			    1);
> +
> +	btrfs_mark_buffer_dirty(trans, leaf);
> +
> +	btrfs_release_path(path);
> +
> +	return 0;
> +}
> +

Same question as elsewhere, but placed here for clarity:
Why can't this be queued for normal unused bgs deletion, rather than
having a special remap bg deletion function?

> +static int last_identity_remap_gone(struct btrfs_trans_handle *trans,
> +				    struct btrfs_chunk_map *chunk,
> +				    struct btrfs_block_group *bg,
> +				    struct btrfs_path *path)
> +{
> +	int ret;
> +
> +	ret = btrfs_remove_dev_extents(trans, chunk);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&trans->fs_info->chunk_mutex);
> +
> +	for (unsigned int i = 0; i < chunk->num_stripes; i++) {
> +		ret = btrfs_update_device(trans, chunk->stripes[i].dev);
> +		if (ret) {
> +			mutex_unlock(&trans->fs_info->chunk_mutex);
> +			return ret;
> +		}
> +	}
> +
> +	mutex_unlock(&trans->fs_info->chunk_mutex);
> +
> +	write_lock(&trans->fs_info->mapping_tree_lock);
> +	btrfs_chunk_map_device_clear_bits(chunk, CHUNK_ALLOCATED);
> +	write_unlock(&trans->fs_info->mapping_tree_lock);
> +
> +	btrfs_remove_bg_from_sinfo(bg);
> +
> +	ret = remove_chunk_stripes(trans, chunk, path);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int adjust_identity_remap_count(struct btrfs_trans_handle *trans,
> +				       struct btrfs_path *path,
> +				       struct btrfs_block_group *bg, int delta)
> +{
> +	struct btrfs_fs_info *fs_info = trans->fs_info;
> +	struct btrfs_chunk_map *chunk;
> +	bool bg_already_dirty = true;
> +	int ret;
> +
> +	WARN_ON(delta < 0 && -delta > bg->identity_remap_count);
> +
> +	bg->identity_remap_count += delta;
> +
> +	spin_lock(&trans->transaction->dirty_bgs_lock);
> +	if (list_empty(&bg->dirty_list)) {
> +		list_add_tail(&bg->dirty_list, &trans->transaction->dirty_bgs);
> +		bg_already_dirty = false;
> +		btrfs_get_block_group(bg);
> +	}
> +	spin_unlock(&trans->transaction->dirty_bgs_lock);
> +
> +	/* Modified block groups are accounted for in the delayed_refs_rsv. */
> +	if (!bg_already_dirty)
> +		btrfs_inc_delayed_refs_rsv_bg_updates(fs_info);
> +
> +	if (bg->identity_remap_count != 0)
> +		return 0;
> +
> +	chunk = btrfs_find_chunk_map(fs_info, bg->start, 1);
> +	if (!chunk)
> +		return -ENOENT;
> +
> +	ret = last_identity_remap_gone(trans, chunk, bg, path);
> +	if (ret)
> +		goto end;
> +
> +	ret = 0;
> +end:
> +	btrfs_free_chunk_map(chunk);
> +	return ret;
> +}
> +
>  int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
>  			  u64 *length, bool nolock)
>  {
> @@ -4504,3 +4647,370 @@ u64 btrfs_get_reloc_bg_bytenr(const struct btrfs_fs_info *fs_info)
>  		logical = fs_info->reloc_ctl->block_group->start;
>  	return logical;
>  }
> +
> +static int remove_range_from_remap_tree(struct btrfs_trans_handle *trans,
> +					struct btrfs_path *path,
> +					struct btrfs_block_group *bg,
> +					u64 bytenr, u64 num_bytes)
> +{
> +	int ret;
> +	struct btrfs_fs_info *fs_info = trans->fs_info;
> +	struct extent_buffer *leaf = path->nodes[0];
> +	struct btrfs_key key, new_key;
> +	struct btrfs_remap *remap_ptr = NULL, remap;
> +	struct btrfs_block_group *dest_bg = NULL;
> +	u64 end, new_addr = 0, remap_start, remap_length, overlap_length;
> +	bool is_identity_remap;
> +
> +	end = bytenr + num_bytes;
> +
> +	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
> +
> +	is_identity_remap = key.type == BTRFS_IDENTITY_REMAP_KEY;
> +
> +	remap_start = key.objectid;
> +	remap_length = key.offset;
> +
> +	if (!is_identity_remap) {
> +		remap_ptr = btrfs_item_ptr(leaf, path->slots[0],
> +					   struct btrfs_remap);
> +		new_addr = btrfs_remap_address(leaf, remap_ptr);
> +
> +		dest_bg = btrfs_lookup_block_group(fs_info, new_addr);
> +	}
> +
> +	if (bytenr == remap_start && num_bytes >= remap_length) {
> +		/* Remove entirely. */
> +
> +		ret = btrfs_del_item(trans, fs_info->remap_root, path);
> +		if (ret)
> +			goto end;
> +
> +		btrfs_release_path(path);
> +
> +		overlap_length = remap_length;
> +
> +		if (!is_identity_remap) {
> +			/* Remove backref. */
> +
> +			key.objectid = new_addr;
> +			key.type = BTRFS_REMAP_BACKREF_KEY;
> +			key.offset = remap_length;
> +
> +			ret = btrfs_search_slot(trans, fs_info->remap_root,
> +						&key, path, -1, 1);
> +			if (ret) {
> +				if (ret == 1) {
> +					btrfs_release_path(path);
> +					ret = -ENOENT;
> +				}
> +				goto end;
> +			}
> +
> +			ret = btrfs_del_item(trans, fs_info->remap_root, path);
> +
> +			btrfs_release_path(path);
> +
> +			if (ret)
> +				goto end;
> +
> +			adjust_block_group_remap_bytes(trans, dest_bg,
> +						       -remap_length);
> +		} else {
> +			ret = adjust_identity_remap_count(trans, path, bg, -1);
> +			if (ret)
> +				goto end;
> +		}
> +	} else if (bytenr == remap_start) {
> +		/* Remove beginning. */
> +
> +		new_key.objectid = end;
> +		new_key.type = key.type;
> +		new_key.offset = remap_length + remap_start - end;
> +
> +		btrfs_set_item_key_safe(trans, path, &new_key);
> +		btrfs_mark_buffer_dirty(trans, leaf);
> +
> +		overlap_length = num_bytes;
> +
> +		if (!is_identity_remap) {
> +			btrfs_set_remap_address(leaf, remap_ptr,
> +						new_addr + end - remap_start);
> +			btrfs_release_path(path);
> +
> +			/* Adjust backref. */
> +
> +			key.objectid = new_addr;
> +			key.type = BTRFS_REMAP_BACKREF_KEY;
> +			key.offset = remap_length;
> +
> +			ret = btrfs_search_slot(trans, fs_info->remap_root,
> +						&key, path, -1, 1);
> +			if (ret) {
> +				if (ret == 1) {
> +					btrfs_release_path(path);
> +					ret = -ENOENT;
> +				}
> +				goto end;
> +			}
> +
> +			leaf = path->nodes[0];
> +
> +			new_key.objectid = new_addr + end - remap_start;
> +			new_key.type = BTRFS_REMAP_BACKREF_KEY;
> +			new_key.offset = remap_length + remap_start - end;
> +
> +			btrfs_set_item_key_safe(trans, path, &new_key);
> +
> +			remap_ptr = btrfs_item_ptr(leaf, path->slots[0],
> +						   struct btrfs_remap);
> +			btrfs_set_remap_address(leaf, remap_ptr, end);
> +
> +			btrfs_mark_buffer_dirty(trans, path->nodes[0]);
> +
> +			btrfs_release_path(path);
> +
> +			adjust_block_group_remap_bytes(trans, dest_bg,
> +						       -num_bytes);
> +		}
> +	} else if (bytenr + num_bytes < remap_start + remap_length) {
> +		/* Remove middle. */
> +
> +		new_key.objectid = remap_start;
> +		new_key.type = key.type;
> +		new_key.offset = bytenr - remap_start;
> +
> +		btrfs_set_item_key_safe(trans, path, &new_key);
> +		btrfs_mark_buffer_dirty(trans, leaf);
> +
> +		new_key.objectid = end;
> +		new_key.offset = remap_start + remap_length - end;
> +
> +		btrfs_release_path(path);
> +
> +		overlap_length = num_bytes;
> +
> +		if (!is_identity_remap) {
> +			/* Add second remap entry. */
> +
> +			ret = btrfs_insert_empty_item(trans, fs_info->remap_root,
> +						path, &new_key,
> +						sizeof(struct btrfs_remap));
> +			if (ret)
> +				goto end;
> +
> +			btrfs_set_stack_remap_address(&remap,
> +						new_addr + end - remap_start);
> +
> +			write_extent_buffer(path->nodes[0], &remap,
> +				btrfs_item_ptr_offset(path->nodes[0], path->slots[0]),
> +				sizeof(struct btrfs_remap));
> +
> +			btrfs_release_path(path);
> +
> +			/* Shorten backref entry. */
> +
> +			key.objectid = new_addr;
> +			key.type = BTRFS_REMAP_BACKREF_KEY;
> +			key.offset = remap_length;
> +
> +			ret = btrfs_search_slot(trans, fs_info->remap_root,
> +						&key, path, -1, 1);
> +			if (ret) {
> +				if (ret == 1) {
> +					btrfs_release_path(path);
> +					ret = -ENOENT;
> +				}
> +				goto end;
> +			}
> +
> +			new_key.objectid = new_addr;
> +			new_key.type = BTRFS_REMAP_BACKREF_KEY;
> +			new_key.offset = bytenr - remap_start;
> +
> +			btrfs_set_item_key_safe(trans, path, &new_key);
> +			btrfs_mark_buffer_dirty(trans, path->nodes[0]);
> +
> +			btrfs_release_path(path);
> +
> +			/* Add second backref entry. */
> +
> +			new_key.objectid = new_addr + end - remap_start;
> +			new_key.type = BTRFS_REMAP_BACKREF_KEY;
> +			new_key.offset = remap_start + remap_length - end;
> +
> +			ret = btrfs_insert_empty_item(trans, fs_info->remap_root,
> +						path, &new_key,
> +						sizeof(struct btrfs_remap));
> +			if (ret)
> +				goto end;
> +
> +			btrfs_set_stack_remap_address(&remap, end);
> +
> +			write_extent_buffer(path->nodes[0], &remap,
> +				btrfs_item_ptr_offset(path->nodes[0], path->slots[0]),
> +				sizeof(struct btrfs_remap));
> +
> +			btrfs_release_path(path);
> +
> +			adjust_block_group_remap_bytes(trans, dest_bg,
> +						       -num_bytes);
> +		} else {
> +			/* Add second identity remap entry. */
> +
> +			ret = btrfs_insert_empty_item(trans, fs_info->remap_root,
> +						      path, &new_key, 0);
> +			if (ret)
> +				goto end;
> +
> +			btrfs_release_path(path);
> +
> +			ret = adjust_identity_remap_count(trans, path, bg, 1);
> +			if (ret)
> +				goto end;
> +		}
> +	} else {
> +		/* Remove end. */
> +
> +		new_key.objectid = remap_start;
> +		new_key.type = key.type;
> +		new_key.offset = bytenr - remap_start;
> +
> +		btrfs_set_item_key_safe(trans, path, &new_key);
> +		btrfs_mark_buffer_dirty(trans, leaf);
> +
> +		btrfs_release_path(path);
> +
> +		overlap_length = remap_start + remap_length - bytenr;
> +
> +		if (!is_identity_remap) {
> +			/* Shorten backref entry. */
> +
> +			key.objectid = new_addr;
> +			key.type = BTRFS_REMAP_BACKREF_KEY;
> +			key.offset = remap_length;
> +
> +			ret = btrfs_search_slot(trans, fs_info->remap_root,
> +						&key, path, -1, 1);
> +			if (ret) {
> +				if (ret == 1) {
> +					btrfs_release_path(path);
> +					ret = -ENOENT;
> +				}
> +				goto end;
> +			}
> +
> +			new_key.objectid = new_addr;
> +			new_key.type = BTRFS_REMAP_BACKREF_KEY;
> +			new_key.offset = bytenr - remap_start;
> +
> +			btrfs_set_item_key_safe(trans, path, &new_key);
> +			btrfs_mark_buffer_dirty(trans, path->nodes[0]);
> +
> +			btrfs_release_path(path);
> +
> +			adjust_block_group_remap_bytes(trans, dest_bg,
> +					bytenr - remap_start - remap_length);
> +		}
> +	}
> +
> +	if (!is_identity_remap) {
> +		ret = btrfs_add_to_free_space_tree(trans,
> +					     bytenr - remap_start + new_addr,
> +					     overlap_length);
> +		if (ret)
> +			goto end;
> +	}
> +
> +	ret = overlap_length;
> +
> +end:
> +	if (dest_bg)
> +		btrfs_put_block_group(dest_bg);
> +
> +	return ret;
> +}
> +
> +/*
> + * Returns 1 if remove_range_from_remap_tree() has been called successfully,
> + * 0 if block group wasn't remapped, and a negative number on error.
> + */
> +int btrfs_remove_extent_from_remap_tree(struct btrfs_trans_handle *trans,
> +					struct btrfs_path *path,
> +					u64 bytenr, u64 num_bytes)
> +{
> +	struct btrfs_fs_info *fs_info = trans->fs_info;
> +	struct btrfs_key key, found_key;
> +	struct extent_buffer *leaf;
> +	struct btrfs_block_group *bg;
> +	int ret, length;
> +
> +	if (!(btrfs_super_incompat_flags(fs_info->super_copy) &
> +	      BTRFS_FEATURE_INCOMPAT_REMAP_TREE))
> +		return 0;
> +
> +	bg = btrfs_lookup_block_group(fs_info, bytenr);
> +	if (!bg)
> +		return 0;
> +
> +	mutex_lock(&fs_info->remap_mutex);
> +
> +	if (!(bg->flags & BTRFS_BLOCK_GROUP_REMAPPED)) {
> +		mutex_unlock(&fs_info->remap_mutex);
> +		btrfs_put_block_group(bg);
> +		return 0;
> +	}
> +
> +	do {
> +		key.objectid = bytenr;
> +		key.type = (u8)-1;
> +		key.offset = (u64)-1;
> +
> +		ret = btrfs_search_slot(trans, fs_info->remap_root, &key, path,
> +					-1, 1);
> +		if (ret < 0)
> +			goto end;
> +
> +		leaf = path->nodes[0];
> +
> +		if (path->slots[0] == 0) {
> +			ret = -ENOENT;
> +			goto end;
> +		}
> +
> +		path->slots[0]--;
> +
> +		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
> +
> +		if (found_key.type != BTRFS_IDENTITY_REMAP_KEY &&
> +		    found_key.type != BTRFS_REMAP_KEY) {
> +			ret = -ENOENT;
> +			goto end;
> +		}
> +
> +		if (bytenr < found_key.objectid ||
> +		    bytenr >= found_key.objectid + found_key.offset) {
> +			ret = -ENOENT;
> +			goto end;
> +		}
> +
> +		length = remove_range_from_remap_tree(trans, path, bg, bytenr,
> +						      num_bytes);
> +		if (length < 0) {
> +			ret = length;
> +			goto end;
> +		}
> +
> +		bytenr += length;
> +		num_bytes -= length;
> +	} while (num_bytes > 0);
> +
> +	ret = 1;
> +
> +end:
> +	mutex_unlock(&fs_info->remap_mutex);
> +
> +	btrfs_put_block_group(bg);
> +	btrfs_release_path(path);
> +	return ret;
> +}
> diff --git a/fs/btrfs/relocation.h b/fs/btrfs/relocation.h
> index a653c42a25a3..4b0bb34b3fc1 100644
> --- a/fs/btrfs/relocation.h
> +++ b/fs/btrfs/relocation.h
> @@ -33,5 +33,8 @@ bool btrfs_should_ignore_reloc_root(const struct btrfs_root *root);
>  u64 btrfs_get_reloc_bg_bytenr(const struct btrfs_fs_info *fs_info);
>  int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
>  			  u64 *length, bool nolock);
> +int btrfs_remove_extent_from_remap_tree(struct btrfs_trans_handle *trans,
> +					struct btrfs_path *path,
> +					u64 bytenr, u64 num_bytes);
>  
>  #endif
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index a2c49cb8bfc6..fc2b3e7de32e 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2941,8 +2941,8 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>  	return ret;
>  }
>  
> -static noinline int btrfs_update_device(struct btrfs_trans_handle *trans,
> -					struct btrfs_device *device)
> +int btrfs_update_device(struct btrfs_trans_handle *trans,
> +			struct btrfs_device *device)
>  {
>  	int ret;
>  	struct btrfs_path *path;
> @@ -3246,25 +3246,13 @@ static int remove_chunk_item(struct btrfs_trans_handle *trans,
>  	return btrfs_free_chunk(trans, chunk_offset);
>  }
>  
> -int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
> +int btrfs_remove_dev_extents(struct btrfs_trans_handle *trans,
> +			     struct btrfs_chunk_map *map)
>  {
>  	struct btrfs_fs_info *fs_info = trans->fs_info;
> -	struct btrfs_chunk_map *map;
> +	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
>  	u64 dev_extent_len = 0;
>  	int i, ret = 0;
> -	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
> -
> -	map = btrfs_get_chunk_map(fs_info, chunk_offset, 1);
> -	if (IS_ERR(map)) {
> -		/*
> -		 * This is a logic error, but we don't want to just rely on the
> -		 * user having built with ASSERT enabled, so if ASSERT doesn't
> -		 * do anything we still error out.
> -		 */
> -		DEBUG_WARN("errr %ld reading chunk map at offset %llu",
> -			   PTR_ERR(map), chunk_offset);
> -		return PTR_ERR(map);
> -	}
>  
>  	/*
>  	 * First delete the device extent items from the devices btree.
> @@ -3285,7 +3273,7 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
>  		if (ret) {
>  			mutex_unlock(&fs_devices->device_list_mutex);
>  			btrfs_abort_transaction(trans, ret);
> -			goto out;
> +			return ret;
>  		}
>  
>  		if (device->bytes_used > 0) {
> @@ -3305,6 +3293,30 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
>  	}
>  	mutex_unlock(&fs_devices->device_list_mutex);
>  
> +	return 0;
> +}
> +
> +int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
> +{
> +	struct btrfs_fs_info *fs_info = trans->fs_info;
> +	struct btrfs_chunk_map *map;
> +	int ret;
> +
> +	map = btrfs_get_chunk_map(fs_info, chunk_offset, 1);
> +	if (IS_ERR(map)) {
> +		/*
> +		 * This is a logic error, but we don't want to just rely on the
> +		 * user having built with ASSERT enabled, so if ASSERT doesn't
> +		 * do anything we still error out.
> +		 */
> +		ASSERT(0);
> +		return PTR_ERR(map);
> +	}
> +
> +	ret = btrfs_remove_dev_extents(trans, map);
> +	if (ret)
> +		goto out;
> +
>  	/*
>  	 * We acquire fs_info->chunk_mutex for 2 reasons:
>  	 *
> @@ -5448,7 +5460,7 @@ static void chunk_map_device_set_bits(struct btrfs_chunk_map *map, unsigned int
>  	}
>  }
>  
> -static void chunk_map_device_clear_bits(struct btrfs_chunk_map *map, unsigned int bits)
> +void btrfs_chunk_map_device_clear_bits(struct btrfs_chunk_map *map, unsigned int bits)
>  {
>  	for (int i = 0; i < map->num_stripes; i++) {
>  		struct btrfs_io_stripe *stripe = &map->stripes[i];
> @@ -5465,7 +5477,7 @@ void btrfs_remove_chunk_map(struct btrfs_fs_info *fs_info, struct btrfs_chunk_ma
>  	write_lock(&fs_info->mapping_tree_lock);
>  	rb_erase_cached(&map->rb_node, &fs_info->mapping_tree);
>  	RB_CLEAR_NODE(&map->rb_node);
> -	chunk_map_device_clear_bits(map, CHUNK_ALLOCATED);
> +	btrfs_chunk_map_device_clear_bits(map, CHUNK_ALLOCATED);
>  	write_unlock(&fs_info->mapping_tree_lock);
>  
>  	/* Once for the tree reference. */
> @@ -5501,7 +5513,7 @@ int btrfs_add_chunk_map(struct btrfs_fs_info *fs_info, struct btrfs_chunk_map *m
>  		return -EEXIST;
>  	}
>  	chunk_map_device_set_bits(map, CHUNK_ALLOCATED);
> -	chunk_map_device_clear_bits(map, CHUNK_TRIMMED);
> +	btrfs_chunk_map_device_clear_bits(map, CHUNK_TRIMMED);
>  	write_unlock(&fs_info->mapping_tree_lock);
>  
>  	return 0;
> @@ -5866,7 +5878,7 @@ void btrfs_mapping_tree_free(struct btrfs_fs_info *fs_info)
>  		map = rb_entry(node, struct btrfs_chunk_map, rb_node);
>  		rb_erase_cached(&map->rb_node, &fs_info->mapping_tree);
>  		RB_CLEAR_NODE(&map->rb_node);
> -		chunk_map_device_clear_bits(map, CHUNK_ALLOCATED);
> +		btrfs_chunk_map_device_clear_bits(map, CHUNK_ALLOCATED);
>  		/* Once for the tree ref. */
>  		btrfs_free_chunk_map(map);
>  		cond_resched_rwlock_write(&fs_info->mapping_tree_lock);
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 430be12fd5e7..64b34710b68b 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -789,6 +789,8 @@ u64 btrfs_calc_stripe_length(const struct btrfs_chunk_map *map);
>  int btrfs_nr_parity_stripes(u64 type);
>  int btrfs_chunk_alloc_add_chunk_item(struct btrfs_trans_handle *trans,
>  				     struct btrfs_block_group *bg);
> +int btrfs_remove_dev_extents(struct btrfs_trans_handle *trans,
> +			     struct btrfs_chunk_map *map);
>  int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset);
>  
>  #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
> @@ -900,6 +902,10 @@ bool btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical);
>  
>  bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr);
>  const u8 *btrfs_sb_fsid_ptr(const struct btrfs_super_block *sb);
> +int btrfs_update_device(struct btrfs_trans_handle *trans,
> +			struct btrfs_device *device);
> +void btrfs_chunk_map_device_clear_bits(struct btrfs_chunk_map *map,
> +				       unsigned int bits);
>  
>  #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
>  struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_info,
> -- 
> 2.49.1
> 

