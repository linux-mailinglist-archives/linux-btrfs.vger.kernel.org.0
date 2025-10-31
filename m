Return-Path: <linux-btrfs+bounces-18495-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 397F2C271C8
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 23:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BC8993522A6
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 22:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7F232AAA6;
	Fri, 31 Oct 2025 22:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="qdF/AoZP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q4eso8MZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5D0329E6E
	for <linux-btrfs@vger.kernel.org>; Fri, 31 Oct 2025 22:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761948687; cv=none; b=EekMXA6Aijru7c7Z39NpdZITklw0fu9FF67eP1tpeERHb5SJipVLi1uhhmrC13+j9sGkNpFaZ0PcwbkNoWyk6vs4ved8d0n35zKmvlX/Aj/adlnJYhN8pY5iRjveRIY2L66aeQEtsHsQc/1vL2R9W5EqGSXW/46y1U2iS2VaONY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761948687; c=relaxed/simple;
	bh=vaclK+7LQTxNL/m7TRu0NLxDAm8RFwcWSnisZIi3++U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrGIktPnvtk7RUnPOmFR1e4jlDrCiX1OWnWohIxWyzRC7cu+Q4bNsEUKMEI8ykhrHrjBkD+Qi618rnCxbmeszFUrdHhDRQ8HF4D5VTXfaNHCy7/XLXG3FNIJWG1h6pxG0DKhBjaP+v5aCMLmAJ7h/GdgyNzNEnR8lBM7lFXVSoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=qdF/AoZP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q4eso8MZ; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E106C1400082;
	Fri, 31 Oct 2025 18:11:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 31 Oct 2025 18:11:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761948683; x=1762035083; bh=fF4Fwj6ld6
	3ddHDKXTdD8g7566ipdzNFQdSwkdCTalw=; b=qdF/AoZP8fJz8BCvbVpwAWLmD4
	SMqgyJhI2a6ypQMang1OIkZ9Sb0b2WNaugkgSVkmNDbacwaMi+vFDZ4W4GRH3X0L
	Uo21lrLe5Ok7FvdoEKb9eJ2jOE+JKDv8getKZ+cojdcabOcrr5pFLujlwZzagd6a
	NlkGx95YRNRpJnfF/8gcJzXDw0HFThVWCTpxak1eJwecXz5bmJmtjYKApBwMHH4f
	WEbY1YWIA6AGhMg+sd2Lkc5vIQSeA9u+7U51irO58Z/7sMlWmIidgUTxpLa1njn8
	mOPkz4AhO4AHWkijEQjuQcRQEzfIrwLnFwnvO1fEYIDS9146GEVoS2yb2kTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761948683; x=1762035083; bh=fF4Fwj6ld63ddHDKXTdD8g7566ipdzNFQdS
	wkdCTalw=; b=q4eso8MZpyIpy2SfVpXsRwXHCjKBzAwsEK5ej8xmru42OFTyr2R
	un3qiqRWIb4N3ELghwkpppOi+sfEVwaizbrQqbtasXB/aCQkierh4ebOgIKoXODu
	nkIUDIiNfELwluZ8gxDcH1+iTdelSlOdSL1/Xxd6J1qK5fB1DeXkEwsnNDno3bfr
	j7p28BWDIto41xjo199Mky1DJ08obLK9N2TF3TUGMHOqu2ohgw9wKBkg9Y4lkj4c
	fOpKc9tuehQ13Zb4dkG/uiiedy+f0XXPlPq0dgZWBBpm2yEXAMrFz+yFgPDk4ziC
	KkdHE9wwRzXnQFo6CiRZngXl+bFn7vVEqIQ==
X-ME-Sender: <xms:CzQFafXpDAtCEc14OcBWc9rjPcnCYlko5uovTTBYlnPB2ejvGaD01w>
    <xme:CzQFadlaIUsNrCYXQbJMRwZc6kCnz3IGufoOu0wfbA6wn7VCwuE_5UzhEMnTaAqJY
    I5MOdpEyR94ZLcF3oLYkZRs3YHfxAbD8mgqR8sg-UnqD4W7vtUqjw>
X-ME-Received: <xmr:CzQFaZCaJxdGuWe_mH3pt3EBDMUkTde0quF9dxu6SGvZ_Jul-pibpO492Kc_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujedtieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrrhhksehhrghrmhhsthhonhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsg
    htrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:CzQFaVd4VPWCZYhZMCKfs6-6n4jiHdmXHICdT3iW-1DbSyF50aCVtA>
    <xmx:CzQFacLkD6XT75-F6dOXOSOWi45ZzSbXK4kSNrlQFLjNyHRTPhUQ4g>
    <xmx:CzQFaQeeuktpRN8rxk5gwoW-C1q63sFFZGihAkPHL9jLKsT_7rUlQQ>
    <xmx:CzQFab1FeISCGR4mbyvjco9_HAuFC1SPBkZaxJXO4j24-itDHZ8L5w>
    <xmx:CzQFaVpVBPo66_Hr3oqJwxZVxm9eLcsAcTwDzLek0QTI51xWWgYauvia>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Oct 2025 18:11:23 -0400 (EDT)
Date: Fri, 31 Oct 2025 15:11:20 -0700
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 15/16] btrfs: handle discarding fully-remapped block
 groups
Message-ID: <aQU0CDKWD4LoXdCB@devvm12410.ftw0.facebook.com>
References: <20251024181227.32228-1-mark@harmstone.com>
 <20251024181227.32228-16-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024181227.32228-16-mark@harmstone.com>

On Fri, Oct 24, 2025 at 07:12:16PM +0100, Mark Harmstone wrote:
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
>  fs/btrfs/block-group.c      |  2 ++
>  fs/btrfs/block-group.h      |  1 +
>  fs/btrfs/discard.c          | 57 ++++++++++++++++++++++++++----
>  fs/btrfs/extent-tree.c      | 10 ++++++
>  fs/btrfs/free-space-cache.c | 70 +++++++++++++++++++++++++++++++++++++
>  fs/btrfs/free-space-cache.h |  1 +
>  6 files changed, 134 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 8feddb472882..0c91553b02cf 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -4833,4 +4833,6 @@ void btrfs_mark_bg_fully_remapped(struct btrfs_block_group *bg,
>  
>  	spin_unlock(&fs_info->unused_bgs_lock);
>  
> +	if (btrfs_test_opt(fs_info, DISCARD_ASYNC))
> +		btrfs_discard_queue_work(&fs_info->discard_ctl, bg);
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
> index 82dc88915b7e..82d102a157e9 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -2860,6 +2860,12 @@ int btrfs_handle_fully_remapped_bgs(struct btrfs_trans_handle *trans)
>  	list_for_each_entry_safe(block_group, tmp, fully_remapped_bgs, bg_list) {
>  		struct btrfs_chunk_map *map;
>  
> +		btrfs_discard_queue_work(&fs_info->discard_ctl, block_group);

Any reason to queue this when DISCARD_ASYNC isn't set?
i.e., put this in the if (btrfs_test_opt(..)) below?

> +
> +		/* for async discard the below gets done in discard job */
> +		if (btrfs_test_opt(fs_info, DISCARD_ASYNC))
> +			continue;
> +
>  		map = btrfs_get_chunk_map(fs_info, block_group->start, 1);
>  		if (IS_ERR(map))
>  			return PTR_ERR(map);
> @@ -2870,6 +2876,10 @@ int btrfs_handle_fully_remapped_bgs(struct btrfs_trans_handle *trans)
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
> index 91670d0af179..5d5e3401e723 100644
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
> @@ -3830,6 +3836,70 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
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
> -- 
> 2.49.1
> 

