Return-Path: <linux-btrfs+bounces-1562-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FACF8320F8
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 22:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD5AF1F24756
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 21:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFB831747;
	Thu, 18 Jan 2024 21:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="NQtzjSPq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YFeyyYnt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143B12EAF9
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jan 2024 21:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705614160; cv=none; b=n2OANI2fCfFlr2RDK9l/PWaEmOI5kGVuXW0o3pNmtt97bWy7G1iWSpuMjlnLNjp/LJLHJfMcKa1IfpRZc+vI1RThCvA2Q3g6dNur1E+Cl99QfCX5Jw8+R0HhkMF5n+5ohaF38D/eFHujM5ANby78Y278GzYCxiRbJ7rqd8kYxsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705614160; c=relaxed/simple;
	bh=CjA3m5L2rUoP8VYcx9xR2FRuV3kkOUagDqhDLP4BqbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLCEMmv13/N4uHe0JJVz5OR3ynceqYnwmxD0vMJHHoBk/aTNALw/vkMb/V6HGK5nLFHmTUy0FQyH7GclsjvmIBKNFyeaFgnOh6GmDsg7v+RS7wJKwf6Z53sTBL12kpZViQQJV8PDRFnytkdxZP9Ikdm2LLr1j2oOL7zOCA6vtic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=NQtzjSPq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YFeyyYnt; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id EAEC03200A60;
	Thu, 18 Jan 2024 16:42:36 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 18 Jan 2024 16:42:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1705614156; x=1705700556; bh=X6e/p6p5h9
	RAT7Db6wp+cNrhpslZTfu/djicVygxL7Q=; b=NQtzjSPqmj4xh3Ily/nth4ai94
	PpknYROCiqbYOulegUZkDSR4++AZuSvJnzt/37TbUm6gvJlC//rbZJIu/0e+fRlr
	9A5tDtMrFIboqiivTwHbWI7+orUsl6glpgOlrrQz3KP3k5YgnrFKAoNVVHpxPnLn
	yG5CB8prLnj2SC3ldxyAwCu5zedj7fHotCshbEauu1V0Q2U7C12DTIJJKlC2q+Xr
	DMP1lrTPkjmcE/ktUL36tWppthIQx6IJ+KCOlUfc1vj1QsJFGxs5wGtLGiMb4pmO
	dkv2G3jVROL0MWVxqRThsufHk2iRazWpzTKTSRMKwQCtzArd2m10X5hi3Mow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705614156; x=1705700556; bh=X6e/p6p5h9RAT7Db6wp+cNrhpslZ
	Tfu/djicVygxL7Q=; b=YFeyyYntoXs1b9ccmcJYQ4c2nfoDzklC+Co6SvNUweLf
	DUBCjyMCLUCXyMAf1HxrdyqEd+yIoKjRsy8cAclwxPs6OCgKxfOOqP7QpBxgjAyr
	moY51YoHCbJQh61bfFGwSRLwOx4x18gd1crYrZMC8gernQxOJ41ZLuCTGia8n2vF
	/5T0on1oLX9pJik88QS4FMUjKmcvDULsai0I4imcYJfevIt5VAe+xXutLIWR0v9S
	MzzkSkwYiqMBSyzjpIOIkNcOu+Anr4wkuhVHguT9N9FzpPTOz0JMm1/rwVD93YzM
	CDjfoqAsC6i1Q+YyHI5aiyVpn5m+e+D1CZNd3MSaJw==
X-ME-Sender: <xms:TJupZcTPSdOoYoADijd6ToXzCGrb2umvoDiTN--kPVIstkLDGZw3Zw>
    <xme:TJupZZyqvQ8yUIZO10Gw9gmFth0Bj2nsx-wb_8J02nX8SIewdw_XiCZvF9arFIOSj
    padMVr3tlyZjo4Ese0>
X-ME-Received: <xmr:TJupZZ0kOqK3C2HWm3XYogZ7_dZJdhh_TefzpnJaV8bHrJ_BUNkxDfGU70KulJ4Br4VOPLXXeysZ4VUEaHggjwqdE-4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejkedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:TJupZQARRnvf_otLezOXenUsuVMmf7xTDL-7Vy1dRSTn03SZmYm1-Q>
    <xmx:TJupZVgBX1jUeF6KSaCYUpQOp38bl6rYLsCohSWE6n1i43BjNReAvw>
    <xmx:TJupZco-rwlH23-0qkkdaxl8fHv3d6fHLkOxmM0X536p7JcbTjk0yA>
    <xmx:TJupZVY87vhV8XcPp7xQ70m-WBTA50D1fAbN2FaU143lNMy4P7vslA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jan 2024 16:42:35 -0500 (EST)
Date: Thu, 18 Jan 2024 13:43:47 -0800
From: Boris Burkov <boris@bur.io>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 3/4] btrfs: convert relocate_one_page() to
 relocate_one_folio()
Message-ID: <20240118214347.GC1356080@zen.localdomain>
References: <cover.1705605787.git.rgoldwyn@suse.com>
 <b723970ca03542e6863442ded58651cfcdb8fe24.1705605787.git.rgoldwyn@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b723970ca03542e6863442ded58651cfcdb8fe24.1705605787.git.rgoldwyn@suse.com>

On Thu, Jan 18, 2024 at 01:46:39PM -0600, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Convert page references to folios and call the respective folio
> functions.
> 
> Since find_or_create_page() takes a mask argument, call
> __filemap_get_folio() instead of filemap_grab_folio().
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/relocation.c | 87 ++++++++++++++++++++++---------------------
>  1 file changed, 44 insertions(+), 43 deletions(-)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index c365bfc60652..f4fd4257adae 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -2849,7 +2849,7 @@ static noinline_for_stack int prealloc_file_extent_cluster(
>  	 * btrfs_do_readpage() call of previously relocated file cluster.
>  	 *
>  	 * If the current cluster starts in the above range, btrfs_do_readpage()
> -	 * will skip the read, and relocate_one_page() will later writeback
> +	 * will skip the read, and relocate_one_folio() will later writeback
>  	 * the padding zeros as new data, causing data corruption.
>  	 *
>  	 * Here we have to manually invalidate the range (i_size, PAGE_END + 1).
> @@ -2983,68 +2983,69 @@ static u64 get_cluster_boundary_end(const struct file_extent_cluster *cluster,
>  	return cluster->boundary[cluster_nr + 1] - 1;
>  }
>  
> -static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
> +static int relocate_one_folio(struct inode *inode, struct file_ra_state *ra,
>  			     const struct file_extent_cluster *cluster,
> -			     int *cluster_nr, unsigned long page_index)
> +			     int *cluster_nr, unsigned long index)
>  {
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>  	u64 offset = BTRFS_I(inode)->index_cnt;
>  	const unsigned long last_index = (cluster->end - offset) >> PAGE_SHIFT;
>  	gfp_t mask = btrfs_alloc_write_mask(inode->i_mapping);
> -	struct page *page;
> -	u64 page_start;
> -	u64 page_end;
> +	struct folio *folio;
> +	u64 start;
> +	u64 end;

This patch throws out this function labelling the start/index/end with
'page_' which I think was pretty useful given the other starts/ends like
'extent_' and 'clamped_'. Namespacing the indices makes the code easier
to follow, IMO.

>  	u64 cur;
>  	int ret;
>  
> -	ASSERT(page_index <= last_index);
> -	page = find_lock_page(inode->i_mapping, page_index);
> -	if (!page) {
> +	ASSERT(index <= last_index);
> +	folio = filemap_lock_folio(inode->i_mapping, index);
> +	if (IS_ERR(folio)) {
>  		page_cache_sync_readahead(inode->i_mapping, ra, NULL,
> -				page_index, last_index + 1 - page_index);
> -		page = find_or_create_page(inode->i_mapping, page_index, mask);
> -		if (!page)
> -			return -ENOMEM;
> +				index, last_index + 1 - index);
> +		folio = __filemap_get_folio(inode->i_mapping, index,
> +				FGP_LOCK | FGP_ACCESSED | FGP_CREAT, mask);
> +		if (IS_ERR(folio))
> +			return PTR_ERR(folio);
>  	}
>  
> -	if (PageReadahead(page))
> +	if (folio_test_readahead(folio))
>  		page_cache_async_readahead(inode->i_mapping, ra, NULL,
> -				page_folio(page), page_index,
> -				last_index + 1 - page_index);
> +				folio, index,
> +				last_index + 1 - index);
>  
> -	if (!PageUptodate(page)) {
> -		btrfs_read_folio(NULL, page_folio(page));
> -		lock_page(page);
> -		if (!PageUptodate(page)) {
> +	if (!folio_test_uptodate(folio)) {
> +		btrfs_read_folio(NULL, folio);
> +		folio_lock(folio);
> +		if (!folio_test_uptodate(folio)) {
>  			ret = -EIO;
> -			goto release_page;
> +			goto release;
>  		}
>  	}
>  
>  	/*
> -	 * We could have lost page private when we dropped the lock to read the
> -	 * page above, make sure we set_page_extent_mapped here so we have any
> +	 * We could have lost folio private when we dropped the lock to read the
> +	 * folio above, make sure we set_page_extent_mapped here so we have any
>  	 * of the subpage blocksize stuff we need in place.
>  	 */
> -	ret = set_page_extent_mapped(page);
> +	ret = set_folio_extent_mapped(folio);
>  	if (ret < 0)
> -		goto release_page;
> +		goto release;
>  
> -	page_start = page_offset(page);
> -	page_end = page_start + PAGE_SIZE - 1;
> +	start = folio_pos(folio);
> +	end = start + PAGE_SIZE - 1;
>  
>  	/*
>  	 * Start from the cluster, as for subpage case, the cluster can start
> -	 * inside the page.
> +	 * inside the folio.
>  	 */
> -	cur = max(page_start, cluster->boundary[*cluster_nr] - offset);
> -	while (cur <= page_end) {
> +	cur = max(start, cluster->boundary[*cluster_nr] - offset);
> +	while (cur <= end) {
>  		struct extent_state *cached_state = NULL;
>  		u64 extent_start = cluster->boundary[*cluster_nr] - offset;
>  		u64 extent_end = get_cluster_boundary_end(cluster,
>  						*cluster_nr) - offset;
> -		u64 clamped_start = max(page_start, extent_start);
> -		u64 clamped_end = min(page_end, extent_end);
> +		u64 clamped_start = max(start, extent_start);
> +		u64 clamped_end = min(end, extent_end);

e.g., I think these lines lose clarity from s/page_start/start/

>  		u32 clamped_len = clamped_end + 1 - clamped_start;
>  
>  		/* Reserve metadata for this range */
> @@ -3052,7 +3053,7 @@ static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
>  						      clamped_len, clamped_len,
>  						      false);
>  		if (ret)
> -			goto release_page;
> +			goto release;
>  
>  		/* Mark the range delalloc and dirty for later writeback */
>  		lock_extent(&BTRFS_I(inode)->io_tree, clamped_start, clamped_end,
> @@ -3068,20 +3069,20 @@ static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
>  							clamped_len, true);
>  			btrfs_delalloc_release_extents(BTRFS_I(inode),
>  						       clamped_len);
> -			goto release_page;
> +			goto release;
>  		}
> -		btrfs_folio_set_dirty(fs_info, page_folio(page),
> +		btrfs_folio_set_dirty(fs_info, folio,
>  				      clamped_start, clamped_len);

Does this fit one line now?

>  
>  		/*
> -		 * Set the boundary if it's inside the page.
> +		 * Set the boundary if it's inside the folio.
>  		 * Data relocation requires the destination extents to have the
>  		 * same size as the source.
>  		 * EXTENT_BOUNDARY bit prevents current extent from being merged
>  		 * with previous extent.
>  		 */
>  		if (in_range(cluster->boundary[*cluster_nr] - offset,
> -			     page_start, PAGE_SIZE)) {
> +			     start, PAGE_SIZE)) {
>  			u64 boundary_start = cluster->boundary[*cluster_nr] -
>  						offset;
>  			u64 boundary_end = boundary_start +
> @@ -3104,8 +3105,8 @@ static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
>  				break;
>  		}
>  	}
> -	unlock_page(page);
> -	put_page(page);
> +	folio_unlock(folio);
> +	folio_put(folio);
>  
>  	balance_dirty_pages_ratelimited(inode->i_mapping);
>  	btrfs_throttle(fs_info);
> @@ -3113,9 +3114,9 @@ static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
>  		ret = -ECANCELED;
>  	return ret;
>  
> -release_page:
> -	unlock_page(page);
> -	put_page(page);
> +release:
> +	folio_unlock(folio);
> +	folio_put(folio);
>  	return ret;
>  }
>  
> @@ -3150,7 +3151,7 @@ static int relocate_file_extent_cluster(struct inode *inode,
>  	last_index = (cluster->end - offset) >> PAGE_SHIFT;
>  	for (index = (cluster->start - offset) >> PAGE_SHIFT;
>  	     index <= last_index && !ret; index++)
> -		ret = relocate_one_page(inode, ra, cluster, &cluster_nr, index);
> +		ret = relocate_one_folio(inode, ra, cluster, &cluster_nr, index);
>  	if (ret == 0)
>  		WARN_ON(cluster_nr != cluster->nr);
>  out:
> -- 
> 2.43.0
> 

