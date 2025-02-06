Return-Path: <linux-btrfs+bounces-11312-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 240EDA29DF8
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2025 01:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7166C3A7852
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2025 00:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365B5125DF;
	Thu,  6 Feb 2025 00:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="CIQTcWoN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RtpxMTEu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F44E2BB13
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Feb 2025 00:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738802361; cv=none; b=DcVHbuNlhTqjReI4xR736W9nn2G4L/D8yuK7MEt6ph3JY0mU8GoEcE3H7ToeVvz44AQPhiiltEkRoVshHehWH5qCViHwHQLc9ixOvcbeWyLjm3JjIDOqkHPFSECDPyN5BkRkW/8gQRAFman5UYQ1mLzM0eTa+LGkQf76LyV1tXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738802361; c=relaxed/simple;
	bh=BsNQzLbzaO/VvLC7sncv2vgh6WLzq8kofrjxqwfGRFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avk+c08iL2F1+lDnZRW2MbexZ8NmuKH4QqJhl76/sfSXfr7XfKel6MsmAgRfN1+w3fqljH6lOaer6PD4BQHKIJRBjyAEbPvVtVd7Sm2AzFahn9E8FP8Ga8fRLbETgllz6Lf0lns+Kn7Chc0U9YL60FSRsq+SFkVQIHIf4hAYcYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=CIQTcWoN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RtpxMTEu; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 334411140124;
	Wed,  5 Feb 2025 19:39:18 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 05 Feb 2025 19:39:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1738802358; x=1738888758; bh=H2CQCQNeGT
	K3PY50iIUO3rCWRSKvybDZQUeE63LSE04=; b=CIQTcWoN2SBxpOdB9RElycwDLO
	kko7BHyqs1kluxg5qORATmMfg3bgdYJ4/aerfjjD0JgJYf8E7eJZV80GaaOPcAFW
	KPPqiOrmq2u7fp/+6eXrhFbnlpcLeNBtPNNeX9nM4B3QHTXb7H1D9PsT1yYv9dD5
	EyCxORyN/0bKSNc62ztFY48rx/+hnzKn/lzCrR2ol0IAu0zDPBu7g8oTL9Frhq3v
	AnZMlQKGUH3ZbTG06ZFaNvDY+QH9Ihfo7zEoOTMUC7lrvXG5mUsh4uxNDLuJavMa
	6JueAy67i9FJ2t3k/krKFvh/k41JpAzOqRRvgyu1fm+LoLNfNUuUQDRax65w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738802358; x=1738888758; bh=H2CQCQNeGTK3PY50iIUO3rCWRSKvybDZQUe
	E63LSE04=; b=RtpxMTEuZM7+cdk9OMySGYVsS4cCDeZxogBcHnrPRd/JGYFXBIy
	fGq1OA3IyOsJ4lOeGC8Spww7Z3HZq3+VY6m7eIz2ZxfSac14EHIkxG4rU7KqvKrM
	NWq66wwHnrC73r9i4bWxfetovo7spirWr384nzTrkf/NLaG83/AuV6tZ3ToeDsnh
	wk8pSwzP/TWrELgEfOLHhQ0C9ytqmc7Dh0j/8KiJ5WQYxg7NUIiHBCuB0xqtB5mu
	7L3vgKv70jHV+5QubkH+jrW5q3A7ySLV6L0dH0e3J+qSLUfp7bS80RsfU9e8oyhC
	XjE1DLBySZqGok7QB9B/HZYKQMUlyiUt8gg==
X-ME-Sender: <xms:tQSkZ9wcayi23ddxIvHfhZBQoKqQ2jmdxUVstxL6X2tocFckA0XufA>
    <xme:tQSkZ9QNTxzd7BnG7a8pA8rCmNxh8Tm-vxyTjWXQtlnDoOrMBshm-G1WIslAbLZPZ
    E0evbSgpFGtWdV8GMc>
X-ME-Received: <xmr:tQSkZ3Wz5aLeWiJBNEdbLB-hP8P_78gkWPVKYDY-sfSOoFdN2Lw_ObtNL9eVTTs4ZB2J6kXAR09aQXnNWmTrDMZxnX0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqne
    cuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfg
    uefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopeifqhhusehsuhhsvgdrtghomhdprhgtphhtthhope
    hlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:tQSkZ_jyx-USoJPyheqyeuwsBL5s_dm7fsdNcGccwr4UtEM_uAhhKg>
    <xmx:tQSkZ_AHUcP-tdYsSMIjJ8UPVKLJ71ACovCiMlXI-st79Rl0gakLlw>
    <xmx:tQSkZ4KdyOgwmLkEBbUDDWT9RnwdvH7zBALEDVC9K7PUy7HH0bpB7Q>
    <xmx:tQSkZ-BtY70goSXmxwWhmoo17a0cHXgbn0C2llqqlC7euzKVJp5NgA>
    <xmx:tgSkZyMj23OOntvVo2yKAb6sYsrr8sh6RYexJ23UZn8XZrXy05T-kcq_>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 19:39:17 -0500 (EST)
Date: Wed, 5 Feb 2025 16:39:49 -0800
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: extract the nocow ordered extent and extent
 map generation into a helper
Message-ID: <20250206003949.GB149656@zen.localdomain>
References: <cover.1736759698.git.wqu@suse.com>
 <044a1ae92ce797c5c9be5ab43359ec820ed151fd.1736759698.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <044a1ae92ce797c5c9be5ab43359ec820ed151fd.1736759698.git.wqu@suse.com>

On Mon, Jan 13, 2025 at 08:12:12PM +1030, Qu Wenruo wrote:
> Currently we're doing all the ordered extent and extent map generation
> inside a while() loop of run_delalloc_nocow().
> 
> This makes it pretty hard to read, nor do proper error handling.
> 
> So move that part of code into a helper, nocow_one_range().
> 
> This should not change anything, but there is a tiny timing change where
> btrfs_dec_nocow_writers() is only called after nocow_one_range() helper
> exits.
> 
> This timing change is small, and makes error handling easier, thus
> should be fine.
> 
Reviewed-by: Boris Burkov <boris@bur.io>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/inode.c | 130 +++++++++++++++++++++++++----------------------
>  1 file changed, 69 insertions(+), 61 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 130f0490b14f..42f67f8a4a33 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1974,6 +1974,71 @@ static void cleanup_dirty_folios(struct btrfs_inode *inode,
>  	mapping_set_error(mapping, error);
>  }
>  
> +static int nocow_one_range(struct btrfs_inode *inode,
> +			   struct folio *locked_folio,
> +			   struct extent_state **cached,
> +			   struct can_nocow_file_extent_args *nocow_args,
> +			   u64 file_pos, bool is_prealloc)
> +{
> +	struct btrfs_ordered_extent *ordered;
> +	u64 len = nocow_args->file_extent.num_bytes;
> +	u64 end = file_pos + len - 1;
> +	int ret = 0;
> +
> +	lock_extent(&inode->io_tree, file_pos, end, cached);
> +
> +	if (is_prealloc) {
> +		struct extent_map *em;
> +
> +		em = btrfs_create_io_em(inode, file_pos,
> +					&nocow_args->file_extent,
> +					BTRFS_ORDERED_PREALLOC);
> +		if (IS_ERR(em)) {
> +			unlock_extent(&inode->io_tree, file_pos,
> +				      end, cached);
> +			return PTR_ERR(em);
> +		}
> +		free_extent_map(em);
> +	}
> +
> +	ordered = btrfs_alloc_ordered_extent(inode, file_pos,
> +			&nocow_args->file_extent,
> +			is_prealloc
> +			? (1 << BTRFS_ORDERED_PREALLOC)
> +			: (1 << BTRFS_ORDERED_NOCOW));
> +	if (IS_ERR(ordered)) {
> +		if (is_prealloc) {
> +			btrfs_drop_extent_map_range(inode, file_pos,
> +						    end, false);
> +		}
> +		unlock_extent(&inode->io_tree, file_pos,
> +			      end, cached);
> +		return PTR_ERR(ordered);
> +	}
> +
> +	if (btrfs_is_data_reloc_root(inode->root))
> +		/*
> +		 * Error handled later, as we must prevent
> +		 * extent_clear_unlock_delalloc() in error handler
> +		 * from freeing metadata of created ordered extent.
> +		 */
> +		ret = btrfs_reloc_clone_csums(ordered);
> +	btrfs_put_ordered_extent(ordered);
> +
> +	extent_clear_unlock_delalloc(inode, file_pos, end,
> +				     locked_folio, cached,
> +				     EXTENT_LOCKED | EXTENT_DELALLOC |
> +				     EXTENT_CLEAR_DATA_RESV,
> +				     PAGE_UNLOCK | PAGE_SET_ORDERED);
> +
> +	/*
> +	 * btrfs_reloc_clone_csums() error, now we're OK to call error
> +	 * handler, as metadata for created ordered extent will only
> +	 * be freed by btrfs_finish_ordered_io().
> +	 */
> +	return ret;
> +}
> +
>  /*
>   * when nowcow writeback call back.  This checks for snapshots or COW copies
>   * of the extents that exist in the file, and COWs the file as required.
> @@ -2018,15 +2083,12 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
>  
>  	while (cur_offset <= end) {
>  		struct btrfs_block_group *nocow_bg = NULL;
> -		struct btrfs_ordered_extent *ordered;
>  		struct btrfs_key found_key;
>  		struct btrfs_file_extent_item *fi;
>  		struct extent_buffer *leaf;
>  		struct extent_state *cached_state = NULL;
>  		u64 extent_end;
> -		u64 nocow_end;
>  		int extent_type;
> -		bool is_prealloc;
>  
>  		ret = btrfs_lookup_file_extent(NULL, root, path, ino,
>  					       cur_offset, 0);
> @@ -2160,67 +2222,13 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
>  			}
>  		}
>  
> -		nocow_end = cur_offset + nocow_args.file_extent.num_bytes - 1;
> -		lock_extent(&inode->io_tree, cur_offset, nocow_end, &cached_state);
> -
> -		is_prealloc = extent_type == BTRFS_FILE_EXTENT_PREALLOC;
> -		if (is_prealloc) {
> -			struct extent_map *em;
> -
> -			em = btrfs_create_io_em(inode, cur_offset,
> -						&nocow_args.file_extent,
> -						BTRFS_ORDERED_PREALLOC);
> -			if (IS_ERR(em)) {
> -				unlock_extent(&inode->io_tree, cur_offset,
> -					      nocow_end, &cached_state);
> -				btrfs_dec_nocow_writers(nocow_bg);
> -				ret = PTR_ERR(em);
> -				goto error;
> -			}
> -			free_extent_map(em);
> -		}
> -
> -		ordered = btrfs_alloc_ordered_extent(inode, cur_offset,
> -				&nocow_args.file_extent,
> -				is_prealloc
> -				? (1 << BTRFS_ORDERED_PREALLOC)
> -				: (1 << BTRFS_ORDERED_NOCOW));
> +		ret = nocow_one_range(inode, locked_folio, &cached_state,
> +				      &nocow_args, cur_offset,
> +				      extent_type == BTRFS_FILE_EXTENT_PREALLOC);
>  		btrfs_dec_nocow_writers(nocow_bg);
> -		if (IS_ERR(ordered)) {
> -			if (is_prealloc) {
> -				btrfs_drop_extent_map_range(inode, cur_offset,
> -							    nocow_end, false);
> -			}
> -			unlock_extent(&inode->io_tree, cur_offset,
> -				      nocow_end, &cached_state);
> -			ret = PTR_ERR(ordered);
> +		if (ret < 0)
>  			goto error;
> -		}
> -
> -		if (btrfs_is_data_reloc_root(root))
> -			/*
> -			 * Error handled later, as we must prevent
> -			 * extent_clear_unlock_delalloc() in error handler
> -			 * from freeing metadata of created ordered extent.
> -			 */
> -			ret = btrfs_reloc_clone_csums(ordered);
> -		btrfs_put_ordered_extent(ordered);
> -
> -		extent_clear_unlock_delalloc(inode, cur_offset, nocow_end,
> -					     locked_folio, &cached_state,
> -					     EXTENT_LOCKED | EXTENT_DELALLOC |
> -					     EXTENT_CLEAR_DATA_RESV,
> -					     PAGE_UNLOCK | PAGE_SET_ORDERED);
> -
>  		cur_offset = extent_end;
> -
> -		/*
> -		 * btrfs_reloc_clone_csums() error, now we're OK to call error
> -		 * handler, as metadata for created ordered extent will only
> -		 * be freed by btrfs_finish_ordered_io().
> -		 */
> -		if (ret)
> -			goto error;
>  	}
>  	btrfs_release_path(path);
>  
> -- 
> 2.47.1
> 

