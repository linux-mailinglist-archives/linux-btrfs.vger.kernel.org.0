Return-Path: <linux-btrfs+bounces-11311-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 324DDA29DF7
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2025 01:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 751541888F89
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2025 00:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811D914286;
	Thu,  6 Feb 2025 00:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="DuyI7c8d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qiyrxJI6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764942B9A5
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Feb 2025 00:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738802346; cv=none; b=mgv2bQ77k8Ed+Qh+2PkpjPhjJ+3Y3gR+23ZODBabnJ9/a03CMZz136maDReM3uoxQtxCLbmCAKue9sDGEGyS6vN/1Eu6dtORRoLKfjwU/Mifvn2XldBi3K6L7RqeYTABfu1p7tGFCy1j1oSSO3rVFuNtby4sO4GJela3EGner3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738802346; c=relaxed/simple;
	bh=ctCjL4YqCu4AVS58X7tIIpCMiHb9R9iUrfF2qrAmHLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLpAqkreMJRtrvq1YAqMuIwDX6YXar1JhhmY7M3ttCU/LDvcah4ysUEPa5PFuhtXqnUrw5BAinr1o5lAPedsSuJpIx5LPA20QGKUhdXkKChWxPyPOLUAsX0J1KQWR6My7VMl8EplDXNtKZMIcYQxHWFuzGitBEJ4oT1XgOYA3fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=DuyI7c8d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qiyrxJI6; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 3D02C1140124;
	Wed,  5 Feb 2025 19:39:02 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 05 Feb 2025 19:39:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1738802342; x=1738888742; bh=wQgmdGsS3k
	1j5ruy5BNUVmR7Gx3hV/ym0vUAN2pEmJE=; b=DuyI7c8dRjcC0AnGi5xn5GV2pk
	J8FIeSVsEn2TPOObqOckc61LrfCzLLhweg0HJHsFYyTt7LcYCeN/fCYA6CPvkm/K
	thjBRod4WLb6q9c8KYXQcLjQ1L5gRVv5BtP5Y2D6QN14UQRaEG7i1uja+ll5ciwY
	auqUW6Nvf0/fLzuFF7mdKek7P4XNLkCTfLuPo5y6R50gk6RyIOV4t16L0Bf7nmHj
	5yd+fQ/DPFMcnUNoPm1/gFpxVdUhnkYhZDTEpIZWlMtCj6t/fWAoFH9z0aVTI4Rf
	CrbtYobbLAcK05tuQEqa5UjM1HI2oqqBvw5z9f9f77HlrbJ8sWVA3ifW03Mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738802342; x=1738888742; bh=wQgmdGsS3k1j5ruy5BNUVmR7Gx3hV/ym0vU
	AN2pEmJE=; b=qiyrxJI6S8tKXGKHEHENWLhEmdaCR/ppKREGopDnNv5xlbyHdIS
	/EZA36oF9oPoohYIFpmRwEZ+8GjxZEBzJrf2E6YYoqxl6sryd1Xojb8SQoKIc1vz
	Mj/kjtIkuIAN75rHcMpaYvJK1o9i1JSCFrrQDSbSa7HoqddTvcHFoIuIDma9z/WH
	48xN6XKPp+iZTNBY7dtITcU8J1LW/dLK6kIWOvqKEL/PjfBk9vlbAsHFeCVlz7Dw
	7O5HlVBSNGyVXJ6nt4qpKqNpG2ayrZL9hfL9HZ1Bc2wS8z6ToYO8yf8x6EOeZNeA
	gKJuAFqGz8tRRFd0eVxw7/7mRURJOslBtyA==
X-ME-Sender: <xms:pQSkZ7D1uBJmykPUnIyrv4z47FXTsMuvSTbHsDiYPaa2CH3rmLL3Zw>
    <xme:pQSkZxjYsovyTOkW1AFRPFy9AG3-Vy9ZTxMh98AvbKSol4OhIEUAAI4TnM6E3uXJL
    RopzXNIByy2VS1KCF0>
X-ME-Received: <xmr:pQSkZ2nqyybiX9dfJm6WgnMWli7sLeXTEqvbeCercxTRP7DdWkZvIIPJaq0_8BP6fddaw7JQ_qk7bxUE1gK3Qknwlck>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeelgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqne
    cuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfg
    uefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopeifqhhusehsuhhsvgdrtghomhdprhgtphhtthhope
    hlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:pQSkZ9yQHCW8Q9OqTamGjUGAB-ST9RXNw5Qgph5B5UN_GaSddPtTqA>
    <xmx:pQSkZwQaYwYtz6iPyssPl9cbSPhY4QSUs-RQf2UDXDFyoSjICCUP7A>
    <xmx:pQSkZwZIKLaP7ra7s1k5baTgUb4cj5mxkfuaAxekipT2pVH6lMtSUA>
    <xmx:pQSkZxSgAcwH3XIpMNNGkBVAB3pFMOuu9W8hWrNlOJD9NdGk1InHHw>
    <xmx:pgSkZ7fjTVv0NBGn8zVhME3sNSkRyzTny73vPmHEAr-AUyKAgvMu7KwG>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 19:39:01 -0500 (EST)
Date: Wed, 5 Feb 2025 16:39:33 -0800
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: move ordered extent cleanup to where they are
 allocated
Message-ID: <20250206003933.GA149656@zen.localdomain>
References: <cover.1736759698.git.wqu@suse.com>
 <ac72ae0a2f67771efaf3839aede82b1b294ccbcb.1736759698.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac72ae0a2f67771efaf3839aede82b1b294ccbcb.1736759698.git.wqu@suse.com>

On Mon, Jan 13, 2025 at 08:12:13PM +1030, Qu Wenruo wrote:
> The ordered extent cleanup is hard to grasp because it doesn't follow
> the common cleanup-asap pattern.
> 
> E.g. run_delalloc_nocow() and cow_file_range() allocate one or more
> ordered extents, but if any error is hit, the cleanup is done later inside
> btrfs_run_delalloc_range().
> 
> To change the existing delayed cleanup:
> 
> - Update the comment on error handling of run_delalloc_nocow()
>   There are in fact 3 different cases other than 2 if we are doing
>   ordered extents cleanup inside run_delalloc_nocow():
> 
>   1) @cow_start and @cow_end not set
>      No fallback to COW at all.
>      Before @cur_offset we need to cleanup the OE and page dirty.
>      After @cur_offset just clear all involved page and extent flags.
> 
>   2) @cow_start set but @cow_end not set.
>      This means we failed before even calling fallback_to_cow().
>      It's just an variant of case 1), where it's @cow_start splitting
>      the two parts (and we should just ignore @cur_offset since it's
>      advanced without any new ordered extent).
> 
>   3) @cow_start and @cow_end both set
>      This means fallback_to_cow() failed, meaning [start, cow_start)
>      needs the regular OE and dirty folio cleanup, and skip range
>      [cow_start, cow_end) as cow_file_range() has done the cleanup,
>      and eventually cleanup [cow_end, end) range.
> 
> - Only reset @cow_start after fallback_to_cow() succeeded
>   As above case 2) and 3) are both relying on @cow_start to determine
>   cleanup range.
> 
> - Move btrfs_cleanup_ordered_extents() into run_delalloc_nocow(),
>   cow_file_range() and nocow_one_range()
> 
>   For cow_file_range() it's pretty straightforward and easy.
> 
>   For run_delalloc_nocow() refer to the above 3 different error cases.
> 
>   For nocow_one_range() if we hit an error, we need to cleanup the
>   ordered extents by ourselves.
>   And then it will fallback to case 1), since @cur_offset is not yet
>   advanced, the existing cleanup will co-operate with nocow_one_range()
>   well.
> 
> - Remove the btrfs_cleanup_ordered_extents() inside
>   submit_uncompressed_range()
>   As failed cow_file_range() will do all the proper cleanup now.
> 

LGTM, thanks for all the extra explanations in the commit and comments.

If you fix the IMO serious comment error I pointed out inline, please
add
Reviewed-by: Boris Burkov <boris@bur.io>

> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/inode.c | 66 ++++++++++++++++++++++++++++++------------------
>  1 file changed, 42 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 42f67f8a4a33..8e8b08412d35 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1090,7 +1090,6 @@ static void submit_uncompressed_range(struct btrfs_inode *inode,
>  			       &wbc, false);
>  	wbc_detach_inode(&wbc);
>  	if (ret < 0) {
> -		btrfs_cleanup_ordered_extents(inode, start, end - start + 1);
>  		if (locked_folio)
>  			btrfs_folio_end_lock(inode->root->fs_info, locked_folio,
>  					     start, async_extent->ram_size);
> @@ -1272,10 +1271,7 @@ u64 btrfs_get_extent_allocation_hint(struct btrfs_inode *inode, u64 start,
>   * - Else all pages except for @locked_folio are unlocked.
>   *
>   * When a failure happens in the second or later iteration of the
> - * while-loop, the ordered extents created in previous iterations are kept
> - * intact. So, the caller must clean them up by calling
> - * btrfs_cleanup_ordered_extents(). See btrfs_run_delalloc_range() for
> - * example.
> + * while-loop, the ordered extents created in previous iterations are cleaned up.
>   */
>  static noinline int cow_file_range(struct btrfs_inode *inode,
>  				   struct folio *locked_folio, u64 start,
> @@ -1488,11 +1484,9 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>  
>  	/*
>  	 * For the range (1). We have already instantiated the ordered extents
> -	 * for this region. They are cleaned up by
> -	 * btrfs_cleanup_ordered_extents() in e.g,
> -	 * btrfs_run_delalloc_range().
> +	 * for this region, thus we need to cleanup those ordered extents.
>  	 * EXTENT_DELALLOC_NEW | EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV
> -	 * are also handled by the cleanup function.
> +	 * are also handled by the ordered extents cleanup.
>  	 *
>  	 * So here we only clear EXTENT_LOCKED and EXTENT_DELALLOC flag,
>  	 * and finish the writeback of the involved folios, which will be
> @@ -1504,6 +1498,8 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>  
>  		if (!locked_folio)
>  			mapping_set_error(inode->vfs_inode.i_mapping, ret);
> +
> +		btrfs_cleanup_ordered_extents(inode, orig_start, start - orig_start);
>  		extent_clear_unlock_delalloc(inode, orig_start, start - 1,
>  					     locked_folio, NULL, clear_bits, page_ops);
>  	}
> @@ -2030,12 +2026,15 @@ static int nocow_one_range(struct btrfs_inode *inode,
>  				     EXTENT_LOCKED | EXTENT_DELALLOC |
>  				     EXTENT_CLEAR_DATA_RESV,
>  				     PAGE_UNLOCK | PAGE_SET_ORDERED);
> -
>  	/*
> -	 * btrfs_reloc_clone_csums() error, now we're OK to call error
> -	 * handler, as metadata for created ordered extent will only
> -	 * be freed by btrfs_finish_ordered_io().
> +	 * On error, we need to cleanup the ordered extents we created.
> +	 *
> +	 * We also need to clear the folio Dirty flags for the range,
> +	 * but it's not something touched by us, it will be cleared
> +	 * by the caller (with cleanup_dirty_folios()).

I don't love this phrasing about the Dirty flags for some reason. Not a
deal breaker, though.

How about:
"We do not clear the folio Dirty flags because they are set and cleaered
by the caller"

or something like that?

>  	 */
> +	if (ret < 0)
> +		btrfs_cleanup_ordered_extents(inode, file_pos, end);
>  	return ret;
>  }
>  
> @@ -2214,12 +2213,12 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
>  		if (cow_start != (u64)-1) {
>  			ret = fallback_to_cow(inode, locked_folio, cow_start,
>  					      found_key.offset - 1);
> -			cow_start = (u64)-1;
>  			if (ret) {
>  				cow_end = found_key.offset - 1;
>  				btrfs_dec_nocow_writers(nocow_bg);
>  				goto error;
>  			}
> +			cow_start = (u64)-1;
>  		}
>  
>  		ret = nocow_one_range(inode, locked_folio, &cached_state,
> @@ -2237,11 +2236,11 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
>  
>  	if (cow_start != (u64)-1) {
>  		ret = fallback_to_cow(inode, locked_folio, cow_start, end);
> -		cow_start = (u64)-1;
>  		if (ret) {
>  			cow_end = end;
>  			goto error;
>  		}
> +		cow_start = (u64)-1;
>  	}
>  
>  	btrfs_free_path(path);
> @@ -2255,16 +2254,32 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
>  	 *    start         cur_offset             end
>  	 *    |/////////////|                      |
>  	 *
> +	 *    In this case, cow_start should be (u64)-1.
> +	 *
>  	 *    For range [start, cur_offset) the folios are already unlocked (except
>  	 *    @locked_folio), EXTENT_DELALLOC already removed.
>  	 *    Only need to clear the dirty flag as they will never be submitted.
>  	 *    Ordered extent and extent maps are handled by
>  	 *    btrfs_mark_ordered_io_finished() inside run_delalloc_range().

I believe this comment is quite wrong now, and does not represent the
new logic where we cleanup the ordered extents up to cur_offset (or
cow_start in case 2) here rather than in run_delalloc_range

>  	 *
> -	 * 2) Failed with error from fallback_to_cow()
> -	 *    start         cur_offset  cow_end    end
> +	 * 2) Failed with error before calling fallback_to_cow()
> +	 *
> +	 *    start         cow_start              end
> +	 *    |/////////////|                      |
> +	 *
> +	 *    In this case, only @cow_start is set, @cur_offset is between
> +	 *    [cow_start, end)
> +	 *
> +	 *    It's mostly the same as case 1), just replace @cur_offset with
> +	 *    @cow_start.
> +	 *
> +	 * 3) Failed with error from fallback_to_cow()
> +	 *
> +	 *    start         cow_start   cow_end    end
>  	 *    |/////////////|-----------|          |
>  	 *
> +	 *    In this case, both @cow_start and @cow_end is set.
> +	 *
>  	 *    For range [start, cur_offset) it's the same as case 1).
>  	 *    But for range [cur_offset, cow_end), the folios have dirty flag
>  	 *    cleared and unlocked, EXTENT_DEALLLOC cleared by cow_file_range().
> @@ -2272,10 +2287,17 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
>  	 *    Thus we should not call extent_clear_unlock_delalloc() on range
>  	 *    [cur_offset, cow_end), as the folios are already unlocked.
>  	 *
> -	 * So clear the folio dirty flags for [start, cur_offset) first.
> +	 *
> +	 * So for all above cases, if @cow_start is set, cleanup ordered extents
> +	 * for range [start, @cow_start), other wise cleanup range [start, @cur_offset).
>  	 */
> -	if (cur_offset > start)
> +	if (cow_start != (u64)-1)
> +		cur_offset = cow_start;
> +
> +	if (cur_offset > start) {
> +		btrfs_cleanup_ordered_extents(inode, start, cur_offset - start);
>  		cleanup_dirty_folios(inode, locked_folio, start, cur_offset - 1, ret);
> +	}
>  
>  	/*
>  	 * If an error happened while a COW region is outstanding, cur_offset
> @@ -2340,7 +2362,7 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct folio *locked_fol
>  
>  	if (should_nocow(inode, start, end)) {
>  		ret = run_delalloc_nocow(inode, locked_folio, start, end);
> -		goto out;
> +		return ret;
>  	}
>  
>  	if (btrfs_inode_can_compress(inode) &&
> @@ -2354,10 +2376,6 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct folio *locked_fol
>  	else
>  		ret = cow_file_range(inode, locked_folio, start, end, NULL,
>  				     false, false);
> -
> -out:
> -	if (ret < 0)
> -		btrfs_cleanup_ordered_extents(inode, start, end - start + 1);
>  	return ret;
>  }
>  
> -- 
> 2.47.1
> 

