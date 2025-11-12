Return-Path: <linux-btrfs+bounces-18883-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 82812C50A70
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 06:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C14134E347F
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 05:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0A42DA757;
	Wed, 12 Nov 2025 05:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="XWN517aW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ILmxW8E4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA8923184A
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Nov 2025 05:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762926937; cv=none; b=ninaPXQ2Q3r/DZvE3xTI/miBVlB/B57QWlW1C3vOCW+G7GOjkB1sIQ1rrjiCwz/OcvDIElOLh6k1bs6UIVlkYCeoQjqUb7P8BgMEzWA+hFASzAGZ/oq/EaB/xc2Q7A4w2BYKkM3A22QvJLDy+7f0DF5MmM1+jemcbTK2HqbDjJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762926937; c=relaxed/simple;
	bh=yTxhKZpukaC34GxYQ94vzSzF2kIgz4XercuqdYxCYdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkuJe85fLDefagqreGe9ZWAkJrCB4HUHTR62rAwWMUKegVqKNkX2qkxSuqnPWtRctbmtQ5datkhk9kIkOujpuySLADRcaPK/BwS5ivw6V6CRrOYrmG2lweex5LPs7aWNk5WQn3WaWsVqP05cNUXP7UNRu1yJgpmukyl/QeMtGNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=XWN517aW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ILmxW8E4; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 457A31400281;
	Wed, 12 Nov 2025 00:55:34 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 12 Nov 2025 00:55:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1762926934; x=1763013334; bh=Ipw/H9ZCJv
	98xaY8p0fdSIBn6nNNnRM+8MggWRY7jNk=; b=XWN517aWOsJdhF7stX+9sufHay
	vWzwegaOxusuJswLdokgAM7Ex+ek3otx1ULffknXnJZ9T7ERUARujOJAWR+g0WQe
	nb3+gp37a5y9+lIosl31rIT4vvuEZyIW1H4jtl957MZAR1LBZ2kIFERo55gbkRWx
	N9Sg1SMv0QyqFaZtmFUZzd4yCKxVBROFAp0HuNUIgMxPxtaJWrlGwso87jkP5vdH
	4BU6PGZaFKjnKidaL1sugWNjHCwd6Ny4Ae8Rxs0q34IayC1D73WSGAwVeH2UfYbX
	k0dwC9LaAQtIDj90g9J/IXi+BISjHU6FrtJHVEaQ4UGYXaw8NsnxXm6Heh+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762926934; x=1763013334; bh=Ipw/H9ZCJv98xaY8p0fdSIBn6nNNnRM+8Mg
	gWRY7jNk=; b=ILmxW8E4WQbyILj5vxqJ1AMrWbnGIP4er8R1riSvnLan9nr2+Ia
	Osz1QPci/5SKHm2CnFKqDu8ZVUGPvFgrwZJsc+vZvYmNVColRNr+YFJOfi6wQzFA
	ehOgjQk/iz1m/XAWRpzY4ESi7C3tlUebbGW0bqzGk0yV4apBjgDiC/eXgnmltzt8
	WVzcUNT8oF0NZxa5lyh8dnS4jLOumfFkj0yKrHsPhhZBWTrSKnwa3H5/vOoq0Ij8
	JWutOkgbSJ/FfAUEdxM6njGawvlq1rDZN0+pfiJvCNz3sOBDsIL+w+7zUDXeDLhs
	mmDI6fvBxEpote6aFndFPnXmwMHoZx1+xbQ==
X-ME-Sender: <xms:VSEUaYR8W6oA0NVti47L8baAuVD-_WcpYEc9C3ed9R0uVGB3fZk5mg>
    <xme:VSEUabw7FtU72FbYSq2COczpA9S-EMMsu-Uu6IG-7w4UqFG3OjQCKdBTyaPxTU0ze
    M19LWfeJvl4QYjU-rRHk2WSDCQcsdbtAcRbTZF2Ksd6djqaDI7neno>
X-ME-Received: <xmr:VSEUaTdNuwG9pCobgssbKDfrjokme3fcWlZ-4D9kfs_f3d8Qin7IG6Ce3uE-1Ge7doXfr2WLB3d29GG5MQmdUkP8Morhlg1jxFNcdyeqk1pCBR6vwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdefvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrrhhksehhrghrmhhsthhonhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsg
    htrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:VSEUaXKTrQwit5uMHw570XVB3LweQC52gtV4KzunEN8iJWOa3_9e0g>
    <xmx:VSEUaUGxPgsFKo346hbrXlS5LOwilCh1BN_Tz8PPrFv8mKwJt5gXkw>
    <xmx:VSEUaRrKdYDMP95emLli7R6Kaagiyw0F0kqPSWIWvDnP3CCNRQwbDQ>
    <xmx:VSEUadQbRz0TymoQvj-1ljvkOFn9-2FC2wjR8hWUspCpFAzjk8oEag>
    <xmx:ViEUafECQ5w2WZZFYgYILOFto0cEXG-NwQjusOYbJKs64fwcdQe8heaO>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 00:55:33 -0500 (EST)
Date: Tue, 11 Nov 2025 21:55:30 -0800
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v5 15/16] btrfs: handle discarding fully-remapped block
 groups
Message-ID: <aRQhUsZ72nzH3+RG@devvm12410.ftw0.facebook.com>
References: <20251110171511.20900-1-mark@harmstone.com>
 <20251110171511.20900-16-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110171511.20900-16-mark@harmstone.com>

On Mon, Nov 10, 2025 at 05:14:39PM +0000, Mark Harmstone wrote:
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

One small logic nit about double dipping on queuing and fully_remapped-ing
and some lingering questions mostly asked on a different patch, but this
one largely LGTM.

> ---
>  fs/btrfs/block-group.c      |  3 ++
>  fs/btrfs/block-group.h      |  1 +
>  fs/btrfs/discard.c          | 57 ++++++++++++++++++++++++----
>  fs/btrfs/extent-tree.c      | 11 ++++++
>  fs/btrfs/free-space-cache.c | 75 +++++++++++++++++++++++++++++++++++++
>  fs/btrfs/free-space-cache.h |  1 +
>  6 files changed, 141 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 7e9c3222beb6..b8ace5118d79 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -4850,4 +4850,7 @@ void btrfs_mark_bg_fully_remapped(struct btrfs_block_group *bg,
>  	list_add_tail(&bg->bg_list, &fs_info->fully_remapped_bgs);
>  
>  	spin_unlock(&fs_info->unused_bgs_lock);
> +
> +	if (btrfs_test_opt(fs_info, DISCARD_ASYNC))
> +		btrfs_discard_queue_work(&fs_info->discard_ctl, bg);

This feels redundant with doing it in btrfs_handle_fully_remapped_bgs

alternatively, if all we do with a fully remapped bg under async discard
is queue it for discard, why bother putting it on that list compared to
just queuing it for discard?

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
> index aacf983ccf73..6764ba02f531 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -2859,6 +2859,13 @@ int btrfs_handle_fully_remapped_bgs(struct btrfs_trans_handle *trans)
>  	list_for_each_entry_safe(block_group, tmp, fully_remapped_bgs, bg_list) {
>  		struct btrfs_chunk_map *map;
>  
> +		/* for async discard the below gets done in discard job */
> +		if (btrfs_test_opt(fs_info, DISCARD_ASYNC)) {
> +			btrfs_discard_queue_work(&fs_info->discard_ctl,
> +						 block_group);
> +			continue;
> +		}
> +
>  		map = btrfs_get_chunk_map(fs_info, block_group->start, 1);
>  		if (IS_ERR(map))
>  			return PTR_ERR(map);
> @@ -2869,6 +2876,10 @@ int btrfs_handle_fully_remapped_bgs(struct btrfs_trans_handle *trans)
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
> index 30507fa8ad80..60101cb93e3d 100644
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
> @@ -3834,6 +3840,75 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
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
> +	struct btrfs_trans_handle *trans;
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
> +	trans = btrfs_start_transaction(fs_info->tree_root, 0);

removing block groups does not use this 0 reservation pattern,
so I think you should try to follow that lead.

(Noted here as well as on patch 9)

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
> +		if (list_empty(&bg->bg_list)) {
> +			btrfs_get_block_group(bg);
> +			list_add_tail(&bg->bg_list, &fs_info->unused_bgs);
> +		} else {
> +			list_move_tail(&bg->bg_list, &fs_info->unused_bgs);
> +		}
> +		spin_unlock(&fs_info->unused_bgs_lock);
> +	}

I would feel a bit better if my questions on the other patch were
resolved and this either used btrfs_mark_bg_unused or there was a really
strong reason not to use it.

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

