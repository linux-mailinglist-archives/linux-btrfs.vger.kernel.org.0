Return-Path: <linux-btrfs+bounces-1615-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A28688374A3
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 21:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 340321F24B9A
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 20:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A90E47F51;
	Mon, 22 Jan 2024 20:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KNGqLv25";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0Q76MeZH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KNGqLv25";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0Q76MeZH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0EF47F44
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Jan 2024 20:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956789; cv=none; b=do3JdygR3T9ejBllkPs+9h3sxd13J951xWeq9PUiKvzh1V+pmJfx/P9uaB6EsfeRQBFiflBMqJvHsd334XjF1fzPbpbXpt3D+qqLXzfnxGN4omT2Y19uvXO4Hh8yYXmoxKZrPwEker1Wtx21SxP+pyIL3RR+uC8RAAEldrW97NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956789; c=relaxed/simple;
	bh=OASAB/l20ewrNeLX/s8I7JNFJA+OScS9QZBvRYsq3s0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNK+rtCBA5uaQWfkZEDRKU+6VBGCVrHlz236vv/n6LfyOI4LqanUVYDxVoQMr1ENNtrwCCmFK77sFhjDbzEuEZTCqjL7lTJMfRhHEfhs5CGeih8SiahU679RrxS2ZCQAA3fQHNWkoUDiWkkLwMLoTB/AVmka5GJ41Wsbwi6mKrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KNGqLv25; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0Q76MeZH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KNGqLv25; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0Q76MeZH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 018661FCD7;
	Mon, 22 Jan 2024 20:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705956786;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pnxhkagHfDyoE4edN/O3mYL93XwwBRhiTh2qYZRqJGQ=;
	b=KNGqLv25zcBHQHPYdmG7MSa7V1abq1GaDKtQ/7AlNBaYSyAT6e0AzBNI2euzuMGcNoo1Kz
	c6guC6IG1HTRbKn0iFcz0QskgtmtS9CDJ72T+z2kYZ3msCuOQzAQmyCm3bOMb0Hec6S4f5
	bMQH5NhelLjiReRcDwNbcsuLSTU0qec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705956786;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pnxhkagHfDyoE4edN/O3mYL93XwwBRhiTh2qYZRqJGQ=;
	b=0Q76MeZHHsuCzjQYGyTOdyYRnTk7c1WjX+/G+O1v1kIBHGU1ch4faTmLI/RRhdZlnDrgv1
	jv+FbXi441Dsm8DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705956786;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pnxhkagHfDyoE4edN/O3mYL93XwwBRhiTh2qYZRqJGQ=;
	b=KNGqLv25zcBHQHPYdmG7MSa7V1abq1GaDKtQ/7AlNBaYSyAT6e0AzBNI2euzuMGcNoo1Kz
	c6guC6IG1HTRbKn0iFcz0QskgtmtS9CDJ72T+z2kYZ3msCuOQzAQmyCm3bOMb0Hec6S4f5
	bMQH5NhelLjiReRcDwNbcsuLSTU0qec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705956786;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pnxhkagHfDyoE4edN/O3mYL93XwwBRhiTh2qYZRqJGQ=;
	b=0Q76MeZHHsuCzjQYGyTOdyYRnTk7c1WjX+/G+O1v1kIBHGU1ch4faTmLI/RRhdZlnDrgv1
	jv+FbXi441Dsm8DA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C684513310;
	Mon, 22 Jan 2024 20:53:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id xE38L7HVrmU7fAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 22 Jan 2024 20:53:05 +0000
Date: Mon, 22 Jan 2024 21:52:44 +0100
From: David Sterba <dsterba@suse.cz>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 3/4] btrfs: convert relocate_one_page() to
 relocate_one_folio()
Message-ID: <20240122205244.GY31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
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
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

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

How do page_cache_sync_readahead and folios interact? We still have
page == folio but the large folios are on the way, so do we need
something to make it work? If there's an assumption about pages and
folios this could be turned to an assertion so we don't forget about
that later.

> -				page_index, last_index + 1 - page_index);
> -		page = find_or_create_page(inode->i_mapping, page_index, mask);
> -		if (!page)
> -			return -ENOMEM;
> +				index, last_index + 1 - index);
> +		folio = __filemap_get_folio(inode->i_mapping, index,
> +				FGP_LOCK | FGP_ACCESSED | FGP_CREAT, mask);

Please format the line continuation so the parameters start under (,
this has been the preferred style, although there's still a lot of the
one/two tabs as next line indentation.

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

Same here

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

This can be joined with the line above

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

Can be joined

>  			u64 boundary_start = cluster->boundary[*cluster_nr] -
>  						offset;
>  			u64 boundary_end = boundary_start +

