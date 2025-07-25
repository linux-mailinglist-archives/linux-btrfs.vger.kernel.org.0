Return-Path: <linux-btrfs+bounces-15676-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F75B1241F
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jul 2025 20:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A16B71CE6CB7
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jul 2025 18:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2BD258CFA;
	Fri, 25 Jul 2025 18:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="mHHHzM5V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z5U/oDAQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EAC2494FE
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Jul 2025 18:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468584; cv=none; b=r/p4kEbOpS4PCMLeilTn8vv6sg4HJdwRkrduJlZM392NeyajHG9zvGhwq6TxCaKidXpNYCkpXjpH5TZD3jAzHsPGUpQRbRWd6GIEe/FHEzxbLZ6Xl/rkMoVLpThUz0d4x5Z2v6OsqlVaIQMxjyUVqm4vN9Qeq91sOnejkku7jUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468584; c=relaxed/simple;
	bh=F71w6fw1MuqQRN39XYY0MLUGjDYb/PnJ6Xw/9+ZZscY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdg7fUjrka493/c2cJJXxbLyBxu4iMuxoeMilz4xjFqPWuRX8Dh54uKvnBK/QPGMDmpdJAqXFNRsee+Tcq0bAlSn+F4ayra9ts2yXJ4nLpPFho+GweJlnQkOfVCy+KxBMVJQ0hOCtmoeFNG2zibnA9a/FUW0z8fIvGSZ/iRRgyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=mHHHzM5V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z5U/oDAQ; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id A4B361D0011A;
	Fri, 25 Jul 2025 14:36:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 25 Jul 2025 14:36:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1753468581; x=1753554981; bh=iZo21IIZR8
	JpPN5eRg5Vp9KVnGoebC6pOk5MXJuL/Oc=; b=mHHHzM5V6neXaxIBcTPgV7ku6v
	F9KeA7wqd5DClyHXo3CMgpbL/1qb0UkhUPJE1GMfPmhvhSruKyKnmoUu1bOgGS7g
	isxrGrl7eAV9fj0rCywBZlQ80e2MPo0EdkZE0m1gbj8lxaNCP/AKkn18pkYL9b3w
	ujo9GOJ4isDbjOSPN0MLmJetlAhj7+9ZoaBuRfq7q+NAafCRHfczXBUAKiwq96js
	S75nuoUKjGksodjuAAqaYuFFHtPuQaN2T6/dD35axHiHry0BIwoWCbDPG1zL46b5
	3NutHI5Mtp2+TXFtOhsbRWX/HaynIvcfOXAWVI7I0lhJGMVGZ34vQ3CyoPhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753468581; x=1753554981; bh=iZo21IIZR8JpPN5eRg5Vp9KVnGoebC6pOk5
	MXJuL/Oc=; b=Z5U/oDAQrFMtT+gIZ1sNfdEJrIzgQ7ufvolVnWrr2uIkQ1MnIku
	a2FmDsMMRyMiwzd5qwMSxzq0pFyrLzOE3eqHhbVJ6wUcxJfEC5pkVH9l2tA/5ASj
	QsARCdtgb2CJBePJ7iEDi2DX3MOBnd5YAbcVsmc1s9jFW5BKLPO96ggk2/Oz+qpT
	Pjazt6c648UU6QauwinUn3xCI+bAyf4WyaEexyFAZG6tZkkYdNAw7S+XKjlu0MLv
	rR68L8lttZNsbRR8datQqB8wMvs6VhnMUhXjLtDdYMCnXeuba/l1FzNC0kzTNoXN
	VadZU2LOSsr/roMCgS6ZEr7qwhZ7yRMHndQ==
X-ME-Sender: <xms:pc6DaA58c-L8O5naxoj0nFMACu0mp0L8BIyFXYq_5GiBlUZajXEzwA>
    <xme:pc6DaCFc0eFe8nz56vnh1_Kcn1TV3bGbb2iWTpikpB6QIihSyameD1Bf_NXgDoHfm
    SqPAwioIoQqxmegcEg>
X-ME-Received: <xmr:pc6DaBQpMPN4gxkgsSGqxJ2XXxKAIojmojHaF0OD_NsXFwbuNEw73DvJz8yCvj8uyQ1J3SyJ_qdq0PClBZDdZ4HAz4E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekgedvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhsuceu
    uhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepkedvke
    ffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihhopdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    peifqhhusehsuhhsvgdrtghomhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:pc6DaDvzn_Abug7egfyx0tyACxpbFv8GYKvODt9C-lGCz9YjFBi8BQ>
    <xmx:pc6DaIx9nSrnfhkbTQH7oZZZr2yN-jnoE-fMUJTyAOO5_g-ngfFDrg>
    <xmx:pc6DaF7vfqQy9jgAKuWear83sdFWlAmbwiMs-GXW6FfWihZ9iugjBw>
    <xmx:pc6DaKVWlPUEuF86gc02vKaYRSW_43AaZdlFnYJnn-8yIo-zvWlG7g>
    <xmx:pc6DaFqbt4vM_rH-Vcg_gSQpT-VxDyH-w1PSs9i0Q0XNBwkdoic2Bwmx>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Jul 2025 14:36:20 -0400 (EDT)
Date: Fri, 25 Jul 2025 11:37:39 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs: make nocow_one_range() to do cleanup on error
Message-ID: <20250725183739.GC1649496@zen.localdomain>
References: <cover.1753269601.git.wqu@suse.com>
 <b851a5b50ae3f291fdb40818b3342b58f199f82d.1753269601.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b851a5b50ae3f291fdb40818b3342b58f199f82d.1753269601.git.wqu@suse.com>

On Wed, Jul 23, 2025 at 08:51:23PM +0930, Qu Wenruo wrote:
> Currently if we hit an error inside nocow_one_range(), we do not clear
> the page dirty, and let the caller to handle it.
> 
> This is very different compared to fallback_to_cow(), when that function
> failed, everything will be cleaned up by cow_file_range().
> 
> Enhance the situation by:
> 
> - Use a common error handling for nocow_one_range()
>   If we failed anything, use the same btrfs_cleanup_ordered_extents()
>   and extent_clear_unlock_delalloc().
> 
>   btrfs_cleanup_ordered_extents() is safe even if we haven't created new
>   ordered extent, in that case there should be no OE and that function
>   will do nothing.
> 
>   The same applies to extent_clear_unlock_delalloc(), and since we're
>   passing PAGE_UNLOCK | PAGE_START_WRITEBACK | PAGE_END_WRITEBACK, it
>   will also clear folio dirty flag during error handling.
> 
> - Avoid touching the failed range of nocow_one_range()
>   As the failed range will be cleaned up and unlocked by that function.
> 
>   Here we introduce a new variable @nocow_end to record the failed range,
>   so that we can skip it during the error handling of run_delalloc_nocow().
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/inode.c | 45 +++++++++++++++++++++++++++------------------
>  1 file changed, 27 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 55d42f2b4a86..3f2f3c6024ba 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1982,8 +1982,8 @@ static int nocow_one_range(struct btrfs_inode *inode, struct folio *locked_folio
>  		em = btrfs_create_io_em(inode, file_pos, &nocow_args->file_extent,
>  					BTRFS_ORDERED_PREALLOC);
>  		if (IS_ERR(em)) {
> -			btrfs_unlock_extent(&inode->io_tree, file_pos, end, cached);
> -			return PTR_ERR(em);
> +			ret = PTR_ERR(em);
> +			goto error;
>  		}
>  		btrfs_free_extent_map(em);
>  	}
> @@ -1995,8 +1995,8 @@ static int nocow_one_range(struct btrfs_inode *inode, struct folio *locked_folio
>  	if (IS_ERR(ordered)) {
>  		if (is_prealloc)
>  			btrfs_drop_extent_map_range(inode, file_pos, end, false);
> -		btrfs_unlock_extent(&inode->io_tree, file_pos, end, cached);
> -		return PTR_ERR(ordered);
> +		ret = PTR_ERR(ordered);
> +		goto error;
>  	}
>  
>  	if (btrfs_is_data_reloc_root(inode->root))
> @@ -2008,23 +2008,24 @@ static int nocow_one_range(struct btrfs_inode *inode, struct folio *locked_folio
>  		ret = btrfs_reloc_clone_csums(ordered);
>  	btrfs_put_ordered_extent(ordered);
>  
> +	if (ret < 0)
> +		goto error;
>  	extent_clear_unlock_delalloc(inode, file_pos, end, locked_folio, cached,
>  				     EXTENT_LOCKED | EXTENT_DELALLOC |
>  				     EXTENT_CLEAR_DATA_RESV,
>  				     PAGE_UNLOCK | PAGE_SET_ORDERED);
> -	/*
> -	 * On error, we need to cleanup the ordered extents we created.
> -	 *
> -	 * We do not clear the folio Dirty flags because they are set and
> -	 * cleaered by the caller.
> -	 */
> -	if (ret < 0) {
> -		btrfs_cleanup_ordered_extents(inode, file_pos, len);
> -		btrfs_err(inode->root->fs_info,
> -			  "%s failed, root=%lld inode=%llu start=%llu len=%llu: %d",
> -			  __func__, btrfs_root_id(inode->root), btrfs_ino(inode),
> -			  file_pos, len, ret);
> -	}
> +	return ret;
> +error:
> +	btrfs_cleanup_ordered_extents(inode, file_pos, len);
> +	extent_clear_unlock_delalloc(inode, file_pos, end, locked_folio, cached,
> +				     EXTENT_LOCKED | EXTENT_DELALLOC |
> +				     EXTENT_CLEAR_DATA_RESV,
> +				     PAGE_UNLOCK | PAGE_START_WRITEBACK |
> +				     PAGE_END_WRITEBACK);
> +	btrfs_err(inode->root->fs_info,
> +		  "%s failed, root=%lld inode=%llu start=%llu len=%llu: %d",
> +		  __func__, btrfs_root_id(inode->root), btrfs_ino(inode),
> +		  file_pos, len, ret);
>  	return ret;
>  }
>  
> @@ -2046,8 +2047,12 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
>  	/*
>  	 * If not 0, represents the inclusive end of the last fallback_to_cow()
>  	 * range. Only for error handling.
> +	 *
> +	 * The same for nocow_end, it's to avoid double cleaning up the range
> +	 * already cleaned by nocow_one_range().
>  	 */
>  	u64 cow_end = 0;
> +	u64 nocow_end = 0;
>  	u64 cur_offset = start;
>  	int ret;
>  	bool check_prev = true;
> @@ -2216,8 +2221,10 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
>  				      &nocow_args, cur_offset,
>  				      extent_type == BTRFS_FILE_EXTENT_PREALLOC);
>  		btrfs_dec_nocow_writers(nocow_bg);
> -		if (ret < 0)
> +		if (ret < 0) {
> +			nocow_end = cur_offset + nocow_args.file_extent.num_bytes - 1;
>  			goto error;
> +		}
>  		cur_offset = extent_end;
>  	}
>  	btrfs_release_path(path);
> @@ -2291,6 +2298,8 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
>  	 */
>  	if (cow_end)
>  		cur_offset = cow_end + 1;

The cow_end case has a comment explaining how cow_file_range does the
cleanup. Now that you made nocow_one_range match cow_file_range, can you
update the comment(s) to make that clear? I think the logic is the same
so one shared comment (rather than a separate one for this else-if
should do.

I also wonder if some of the descriptions of the 3 cases still make
perfect sense. What ordered extent are we ever finishing in case 1,
if nocow_one_range already did it, for example?

> +	else if (nocow_end)
> +		cur_offset = nocow_end + 1;
>  
>  	/*
>  	 * We need to lock the extent here because we're clearing DELALLOC and
> -- 
> 2.50.0
> 

