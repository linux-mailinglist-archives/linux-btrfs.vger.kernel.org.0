Return-Path: <linux-btrfs+bounces-17809-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F8ABDC8CE
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 06:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F04153520D3
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 04:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141792FDC21;
	Wed, 15 Oct 2025 04:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="RpXWdZrh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aU5RLL3L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24522D3A7C
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 04:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760504107; cv=none; b=TFflkRZbZdQjReyU/K0ISMXF82S/UZ/qcUn1td5zPjWxxsjVxM7HwybJ+Zw53QGNPmc/vLDYWeiv4JBtNpGCtQIlSQwn1OK4UUO9IeYeH1Fay1WDjoJQOLZsIaZy+yI3jkq/NG2wMFRfMjfIenqVjsgrmArK2J5yEuaD1otlvo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760504107; c=relaxed/simple;
	bh=3rLac2Nczy3Xq8UMw3ezzpDM1twfC+K2HfF6r2R/OZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOMVV46P02Sgzd3+Q70yzAWwDZ0xFw/H/ueZbkuhJaBy5Oyam6U7xf9TDM+ZpW+BvtMKzJWiPJqs4D3bX0orBcpnbXIeDfBYghZLExQQJ8TnVjtTPL5TEMVFxRV6RicOU93hYsABoOYVl7yM4YWhVnd4vNko3fWTYyhbHxhbXpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=RpXWdZrh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aU5RLL3L; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id B0027EC026A;
	Wed, 15 Oct 2025 00:55:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 15 Oct 2025 00:55:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1760504103; x=1760590503; bh=Pg9oGNvYSa
	dOXIJURyEX/hcyDxavfdGfo4w4syfC7mI=; b=RpXWdZrh3jFSHtTOg8s+EeJxrw
	27gWIjriRonlFskR0JzbuGOwFQRLagXJBKqJllY5v1l1NmNFHyfnIHEMumJcD/57
	jzqm91PZCE5MolMH9+NlkTT6RGDSJMdN7Y534wyd277c32NugJhNsXotBjHIpOM/
	NgtpyS95odQYoliCS4H5CUsC2KEPesDoKXhHVxJAvkRdP4XCl040QFPOjHeMmm1j
	Pnz/98oojvDV81sJ2JB2/MgUojqiSwKISIMPeb+aUP2BVsIhmD1ehwDTilY9awmn
	KWuC2LfgSDv8yhVoCKHtusD6Lq5fuBF5kKFk/vn4tZzbfsj1ALKVCwhMoCiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760504103; x=1760590503; bh=Pg9oGNvYSadOXIJURyEX/hcyDxavfdGfo4w
	4syfC7mI=; b=aU5RLL3LmO4P7x+y23hFHRgQHL3Mk/Bg+HMnrd8YINnIZorI02U
	6Wlmhfxa1MM/Z9gHE+QVYWoc76Q6r/Qlu3kbg1kq1mOBsdYu+x8SdFdg8XcLxtHS
	gM4Utj3WQFlZ2bpytGXZTq+4Q+N0lmPVUESQ9QXGNdMUIASo6Fw1vNEPnyXIkxA4
	les4bJNm/l8uCCkA9mHVtc6xr31mMtUdWruy1UCVcpQySCfKlyoPMUtyBQmdy7He
	7imMpY8yEqjJRtrdUUSZvrhw8yUlVOsgTHsNswjFK8qAFNMcaslom5jDNtIKBbo9
	K6RukVsX04aLmnRYquluZiciHqHY7CrIjMA==
X-ME-Sender: <xms:JynvaOFA86cTiYiuxDB0OgJX-lKwbjeoxdMpMNerZ4ETQOTbNbta4A>
    <xme:JynvaFVl3NT5z-vuuh0wlDmaJbWyTJRqtYHG7MFf59xjqlO9jIat2OsN2UAxnrpQ-
    XHoWpRIdWlUMhJj0XA36bJZRqZz0W9G_wx2sURdh8hscsoylMzZfQ>
X-ME-Received: <xmr:JynvaFx5hvmFAbPR9H2ZQ72lK3PP7Vk-lJ8dWwoDa08ZWFqxP1qj3izZj96RSJPeoFC7JejI029KMHAl2Zy6cuY7JrI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddvheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrrhhksehhrghrmhhsthhonhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsg
    htrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:JynvaDOd9N_zM5R9UCnPQZcrye_zHh7VSzPWFTMyeLhfVwDkxOsbFg>
    <xmx:JynvaG4-LS-UiN0mMucts_1wlreNgw_hYhWyWNOrWqLYXNeZ9dv0JA>
    <xmx:JynvaENUWkuZlzopa_tYbjBr4bqrA8oEHh97Nor9cI323XYWDV-I-g>
    <xmx:JynvaEnFguAA9gEIxM6suDY3elJnzT1Ae5oc547BlLQb7FbSDMkiFQ>
    <xmx:JynvaOaK4bl0kJ3YXlavwKmDXdMwq_SNRs6c0GW-HDYfn0fW2QHBTPYu>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 00:55:02 -0400 (EDT)
Date: Tue, 14 Oct 2025 21:54:42 -0700
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 16/17] btrfs: handle discarding fully-remapped block
 groups
Message-ID: <20251015045442.GI1702774@zen.localdomain>
References: <20251009112814.13942-1-mark@harmstone.com>
 <20251009112814.13942-17-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009112814.13942-17-mark@harmstone.com>

On Thu, Oct 09, 2025 at 12:28:11PM +0100, Mark Harmstone wrote:
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
>  fs/btrfs/block-group.c      |  2 +
>  fs/btrfs/block-group.h      |  1 +
>  fs/btrfs/discard.c          | 61 +++++++++++++++++++++++++----
>  fs/btrfs/extent-tree.c      |  4 ++
>  fs/btrfs/free-space-cache.c | 77 +++++++++++++++++++++++++++++++++++++
>  fs/btrfs/free-space-cache.h |  1 +
>  fs/btrfs/transaction.c      |  8 ++--
>  7 files changed, 144 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 3f7c45d17415..a7dfa6c95223 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -4828,4 +4828,6 @@ void btrfs_mark_bg_fully_remapped(struct btrfs_block_group *bg,
>  
>  	spin_unlock(&fs_info->unused_bgs_lock);
>  
> +	if (btrfs_test_opt(fs_info, DISCARD_ASYNC))
> +		btrfs_discard_queue_work(&fs_info->discard_ctl, bg);
>  }
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index c6866a57ea24..3c086fbb0a7c 100644
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
> index 2b7b1e440bc8..421f48a6603a 100644
> --- a/fs/btrfs/discard.c
> +++ b/fs/btrfs/discard.c
> @@ -241,8 +241,17 @@ static struct btrfs_block_group *peek_discard_list(
>  	block_group = find_next_block_group(discard_ctl, now);
>  
>  	if (block_group && now >= block_group->discard_eligible_time) {
> +		bool unused;
> +
> +		if (block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED) {
> +			unused = block_group->remap_bytes == 0 &&
> +				 block_group->identity_remap_count == 0;
> +		} else {
> +			unused = block_group->used == 0;
> +		}
> +

This pattern for computing unused gets repeated enough times in this file
that I think a static helper is merited.

>  		if (block_group->discard_index == BTRFS_DISCARD_INDEX_UNUSED &&
> -		    block_group->used != 0) {
> +		    !unused) {
>  			if (btrfs_is_block_group_data_only(block_group)) {
>  				__add_to_discard_list(discard_ctl, block_group);
>  				/*
> @@ -267,7 +276,15 @@ static struct btrfs_block_group *peek_discard_list(
>  		}
>  		if (block_group->discard_state == BTRFS_DISCARD_RESET_CURSOR) {
>  			block_group->discard_cursor = block_group->start;
> -			block_group->discard_state = BTRFS_DISCARD_EXTENTS;
> +
> +			if (block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED &&
> +			    unused) {
> +				block_group->discard_state =
> +					BTRFS_DISCARD_FULLY_REMAPPED;
> +			} else {
> +				block_group->discard_state =
> +					BTRFS_DISCARD_EXTENTS;
> +			}
>  		}
>  	}
>  	if (block_group) {
> @@ -370,10 +387,19 @@ void btrfs_discard_cancel_work(struct btrfs_discard_ctl *discard_ctl,
>  void btrfs_discard_queue_work(struct btrfs_discard_ctl *discard_ctl,
>  			      struct btrfs_block_group *block_group)
>  {
> +	bool unused;
> +
>  	if (!block_group || !btrfs_test_opt(block_group->fs_info, DISCARD_ASYNC))
>  		return;
>  
> -	if (block_group->used == 0 && block_group->remap_bytes == 0)
> +	if (block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED) {
> +		unused = block_group->remap_bytes == 0 &&
> +			 block_group->identity_remap_count == 0;
> +	} else {
> +		unused = block_group->used == 0;
> +	}
> +
> +	if (unused)
>  		add_to_discard_unused_list(discard_ctl, block_group);
>  	else
>  		add_to_discard_list(discard_ctl, block_group);
> @@ -468,9 +494,18 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
>  static void btrfs_finish_discard_pass(struct btrfs_discard_ctl *discard_ctl,
>  				      struct btrfs_block_group *block_group)
>  {
> +	bool unused;
> +
>  	remove_from_discard_list(discard_ctl, block_group);
>  
> -	if (block_group->used == 0) {
> +	if (block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED) {
> +		unused = block_group->remap_bytes == 0 &&
> +			 block_group->identity_remap_count == 0;
> +	} else {
> +		unused = block_group->used == 0;
> +	}
> +
> +	if (unused) {
>  		if (btrfs_is_free_space_trimmed(block_group))
>  			btrfs_mark_bg_unused(block_group);
>  		else
> @@ -524,7 +559,8 @@ static void btrfs_discard_workfn(struct work_struct *work)
>  	/* Perform discarding */
>  	minlen = discard_minlen[discard_index];
>  
> -	if (discard_state == BTRFS_DISCARD_BITMAPS) {
> +	switch (discard_state) {
> +	case BTRFS_DISCARD_BITMAPS: {
>  		u64 maxlen = 0;
>  
>  		/*
> @@ -541,17 +577,28 @@ static void btrfs_discard_workfn(struct work_struct *work)
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
> index 2e3074612f39..03674d171ec0 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -2870,6 +2870,10 @@ int btrfs_handle_fully_remapped_bgs(struct btrfs_trans_handle *trans)
>  			return ret;
>  		}
>  
> +		if (!TRANS_ABORTED(trans))
> +			btrfs_discard_extent(fs_info, block_group->start,
> +					     block_group->length, NULL, false);
> +
>  		/*
>  		 * Set num_stripes to 0, so that btrfs_remove_dev_extents()
>  		 * won't run a second time.
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index 6387f8d1c3a1..56f27487b632 100644
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
> @@ -3063,6 +3064,12 @@ bool btrfs_is_free_space_trimmed(struct btrfs_block_group *block_group)
>  	struct rb_node *node;
>  	bool ret = true;
>  
> +	if (block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED &&
> +	    block_group->remap_bytes == 0 &&
> +	    block_group->identity_remap_count == 0) {
> +		return true;
> +	}
> +
>  	spin_lock(&ctl->tree_lock);
>  	node = rb_first(&ctl->free_space_offset);
>  
> @@ -3827,6 +3834,76 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
>  	return ret;
>  }
>  
> +void btrfs_trim_fully_remapped_block_group(struct btrfs_block_group *bg)
> +{
> +	struct btrfs_fs_info *fs_info = bg->fs_info;
> +	struct btrfs_discard_ctl *discard_ctl = &fs_info->discard_ctl;
> +	int ret = 0;
> +	u64 bytes;
> +	const u64 max_discard_size = READ_ONCE(discard_ctl->max_discard_size);
> +	u64 end = btrfs_block_group_end(bg);
> +	struct btrfs_trans_handle *trans;
> +	struct btrfs_chunk_map *map;
> +
> +	while (bg->discard_cursor < end) {
> +		u64 trimmed;
> +
> +		bytes = end - bg->discard_cursor;
> +
> +		if (max_discard_size &&
> +			bytes >= (max_discard_size +
> +				BTRFS_ASYNC_DISCARD_MIN_FILTER)) {
> +			bytes = max_discard_size;
> +		}
> +
> +		ret = btrfs_discard_extent(fs_info, bg->discard_cursor, bytes,
> +					   &trimmed, false);
> +		if (ret || trimmed == 0)
> +			return;

As opposed to btrfs_trim_block_group_extents() / trim_no_bitmap() this will
always do all the discarding in a tight loop without sending control
back up to the delayed work queue. As a result, the rate limiting is
unable to do its job; this will simply rip through the whole bg in steps
of max_discard_size. 

Check out the `async` parameter to trim_no_bitamp() and how it breaks
the loop, which then lets the higher level metering operate properly.

> +
> +		bg->discard_cursor += trimmed;
> +
> +		if (btrfs_trim_interrupted())
> +			return;
> +
> +		cond_resched();
> +	}
> +
> +	trans = btrfs_start_transaction(fs_info->tree_root, 0);
> +	if (IS_ERR(trans))
> +		return;
> +
> +	map = btrfs_get_chunk_map(fs_info, bg->start, 1);
> +	if (IS_ERR(map)) {
> +		ret = PTR_ERR(map);
> +		btrfs_abort_transaction(trans, ret);
> +		return;
> +	}
> +
> +	ret = btrfs_last_identity_remap_gone(trans, map, bg);
> +	if (ret) {
> +		btrfs_free_chunk_map(map);
> +		btrfs_abort_transaction(trans, ret);
> +		return;
> +	}
> +
> +	btrfs_end_transaction(trans);
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
> +		list_move_tail(&bg->bg_list, &fs_info->unused_bgs);
> +		spin_unlock(&fs_info->unused_bgs_lock);
> +	}
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
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 6ce91397afe6..b0a5254ba214 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -2438,9 +2438,11 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>  	if (ret)
>  		goto unlock_reloc;
>  
> -	ret = btrfs_handle_fully_remapped_bgs(trans);
> -	if (ret)
> -		goto unlock_reloc;
> +	if (!btrfs_test_opt(fs_info, DISCARD_ASYNC)) {
> +		ret = btrfs_handle_fully_remapped_bgs(trans);
> +		if (ret)
> +			goto unlock_reloc;
> +	}
>  
>  	/*
>  	 * make sure none of the code above managed to slip in a
> -- 
> 2.49.1
> 

