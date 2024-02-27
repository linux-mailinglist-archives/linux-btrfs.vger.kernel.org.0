Return-Path: <linux-btrfs+bounces-2844-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B384386A1C1
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Feb 2024 22:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02757281D62
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Feb 2024 21:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFC614EFF0;
	Tue, 27 Feb 2024 21:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DMNAPuzs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C95A14A0A0
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Feb 2024 21:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709069708; cv=none; b=Z+PBD7jYdbsbQko/mmksZ55YjopGSjwxXwwHXdcKkLbKxYDV6cZwRWQ4q93o1S4fl5Idl0VnDSUqlqX3FzQUF05ecNxDnxrqjp4L+R7FoFKQl7dIgjm7yUFiSkGJRfKXKR+kEDIakpaNBKOCkHBG7sRQR4KolxdpxCOepMUp1qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709069708; c=relaxed/simple;
	bh=H7XOzoHYeaTiVtdCTGlW0SP8XPqxWXlW0ora9SbN/84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RuY2oNglgTKLUyYsDmUwMuO+2RBYtSQo740T6R2XBXYr34bVVQyZfPJ9lljxfhScvrX6OKdwoWkfbS0ntGDvxuHDci1ix07D2Cfog5j1qIgpNiEm10CWainMGJu62NObUkUMo69PW82TK3dgos66Wi1Q2HpGiwbFyyCJlZIbH88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DMNAPuzs; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=z4Luj0HagvmRkjG7XUPgzidzXssF3XmKMcoP6vMzIMQ=; b=DMNAPuzsi5dYHPqiRQMqx6N80y
	LjOtsvBxu1Yld2U+WFYRWT0oY15wdk0jaXhxpHHssGcWPDnkTH2EnjGdho/Y3WHJ5s8XBzbgaGHi9
	0zDDRKBtLH6A3dS3DAi1KgvTsglAtxKDetwUmeLOXs/fZbLgjCl9GjXtrBvWkYOAh7L3Xxe8VqKnH
	YoOkrBi6IgD5o7v4B0GnsbYMeiVgVJDPR9oQiI/XIfWskPE1z0ib0z7q8qWkG3tN+vrX20gqhRNHA
	IKi8eBOUJ4OVRLb/dM56wzQENymmRpX1JR2WsdUCnpPcMLu3a+H7TMmy1ans8n14rtGQpDn157PFA
	8wg5mSXw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf56P-00000003Qwv-0dXn;
	Tue, 27 Feb 2024 21:35:05 +0000
Date: Tue, 27 Feb 2024 21:35:05 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Convert add_ra_bio_pages() to use a folio
Message-ID: <Zd5ViSKqkVl-g2wG@casper.infradead.org>
References: <20240126065631.3055974-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126065631.3055974-1-willy@infradead.org>

On Fri, Jan 26, 2024 at 06:56:29AM +0000, Matthew Wilcox (Oracle) wrote:
> Allocate order-0 folios instead of pages.  Saves twelve hidden calls
> to compound_head().

Ping?  This is one of the few remaining callers of
add_to_page_cache_lru() and I'd like to get rid of it soon.

> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/btrfs/compression.c | 58 ++++++++++++++++++++----------------------
>  1 file changed, 28 insertions(+), 30 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 68345f73d429..517f9bc58749 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -421,7 +421,6 @@ static noinline int add_ra_bio_pages(struct inode *inode,
>  	u64 cur = cb->orig_bbio->file_offset + orig_bio->bi_iter.bi_size;
>  	u64 isize = i_size_read(inode);
>  	int ret;
> -	struct page *page;
>  	struct extent_map *em;
>  	struct address_space *mapping = inode->i_mapping;
>  	struct extent_map_tree *em_tree;
> @@ -447,6 +446,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
>  	end_index = (i_size_read(inode) - 1) >> PAGE_SHIFT;
>  
>  	while (cur < compressed_end) {
> +		struct folio *folio;
>  		u64 page_end;
>  		u64 pg_index = cur >> PAGE_SHIFT;
>  		u32 add_size;
> @@ -454,8 +454,12 @@ static noinline int add_ra_bio_pages(struct inode *inode,
>  		if (pg_index > end_index)
>  			break;
>  
> -		page = xa_load(&mapping->i_pages, pg_index);
> -		if (page && !xa_is_value(page)) {
> +		folio = xa_load(&mapping->i_pages, pg_index);
> +		if (folio && !xa_is_value(folio)) {
> +			/*
> +			 * We don't have a reference count on the folio,
> +			 * so it is unsafe to refer to folio_size()
> +			 */
>  			sectors_missed += (PAGE_SIZE - offset_in_page(cur)) >>
>  					  fs_info->sectorsize_bits;
>  
> @@ -471,38 +475,38 @@ static noinline int add_ra_bio_pages(struct inode *inode,
>  			continue;
>  		}
>  
> -		page = __page_cache_alloc(mapping_gfp_constraint(mapping,
> -								 ~__GFP_FS));
> -		if (!page)
> +		folio = filemap_alloc_folio(mapping_gfp_constraint(mapping,
> +				~__GFP_FS), 0);
> +		if (!folio)
>  			break;
>  
> -		if (add_to_page_cache_lru(page, mapping, pg_index, GFP_NOFS)) {
> -			put_page(page);
> +		if (filemap_add_folio(mapping, folio, pg_index, GFP_NOFS)) {
> +			folio_put(folio);
>  			/* There is already a page, skip to page end */
>  			cur = (pg_index << PAGE_SHIFT) + PAGE_SIZE;
>  			continue;
>  		}
>  
> -		if (!*memstall && PageWorkingset(page)) {
> +		if (!*memstall && folio_test_workingset(folio)) {
>  			psi_memstall_enter(pflags);
>  			*memstall = 1;
>  		}
>  
> -		ret = set_page_extent_mapped(page);
> +		ret = set_folio_extent_mapped(folio);
>  		if (ret < 0) {
> -			unlock_page(page);
> -			put_page(page);
> +			folio_unlock(folio);
> +			folio_put(folio);
>  			break;
>  		}
>  
> -		page_end = (pg_index << PAGE_SHIFT) + PAGE_SIZE - 1;
> +		page_end = folio_pos(folio) + folio_size(folio) - 1;
>  		lock_extent(tree, cur, page_end, NULL);
>  		read_lock(&em_tree->lock);
>  		em = lookup_extent_mapping(em_tree, cur, page_end + 1 - cur);
>  		read_unlock(&em_tree->lock);
>  
>  		/*
> -		 * At this point, we have a locked page in the page cache for
> +		 * At this point, we have a locked folio in the page cache for
>  		 * these bytes in the file.  But, we have to make sure they map
>  		 * to this compressed extent on disk.
>  		 */
> @@ -511,28 +515,22 @@ static noinline int add_ra_bio_pages(struct inode *inode,
>  		    (em->block_start >> SECTOR_SHIFT) != orig_bio->bi_iter.bi_sector) {
>  			free_extent_map(em);
>  			unlock_extent(tree, cur, page_end, NULL);
> -			unlock_page(page);
> -			put_page(page);
> +			folio_unlock(folio);
> +			folio_put(folio);
>  			break;
>  		}
>  		free_extent_map(em);
>  
> -		if (page->index == end_index) {
> -			size_t zero_offset = offset_in_page(isize);
> -
> -			if (zero_offset) {
> -				int zeros;
> -				zeros = PAGE_SIZE - zero_offset;
> -				memzero_page(page, zero_offset, zeros);
> -			}
> -		}
> +		if (folio->index == end_index)
> +			folio_zero_segment(folio, offset_in_page(isize),
> +					folio_size(folio));
>  
>  		add_size = min(em->start + em->len, page_end + 1) - cur;
> -		ret = bio_add_page(orig_bio, page, add_size, offset_in_page(cur));
> +		ret = bio_add_folio(orig_bio, folio, add_size, offset_in_page(cur));
>  		if (ret != add_size) {
>  			unlock_extent(tree, cur, page_end, NULL);
> -			unlock_page(page);
> -			put_page(page);
> +			folio_unlock(folio);
> +			folio_put(folio);
>  			break;
>  		}
>  		/*
> @@ -541,9 +539,9 @@ static noinline int add_ra_bio_pages(struct inode *inode,
>  		 * subpage::readers and to unlock the page.
>  		 */
>  		if (fs_info->sectorsize < PAGE_SIZE)
> -			btrfs_subpage_start_reader(fs_info, page_folio(page),
> +			btrfs_subpage_start_reader(fs_info, folio,
>  						   cur, add_size);
> -		put_page(page);
> +		folio_put(folio);
>  		cur += add_size;
>  	}
>  	return 0;
> -- 
> 2.43.0
> 

