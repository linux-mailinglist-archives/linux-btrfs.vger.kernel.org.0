Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348C33F4EDE
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 19:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhHWRBb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 13:01:31 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40638 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbhHWRBa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 13:01:30 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A643022006;
        Mon, 23 Aug 2021 17:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629738046;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Il+RGDFt3Ztl373LHRlcz2OgJsjTo2EIjSZgnOVTzOI=;
        b=1BoMaTp+N1ql4csln4mQFHZEtvMNWaQq/1VdIMvgn3mPdQtnHqo7uZHLL6geWAhXhzetbL
        HNYaNhn9ot8gexDghwtofzUUtF+4kW3IdhoemPz5yV+4Ce3w4oPtGvDByj+NSFLKPlLjGt
        jTYXlBxtHIJklAxIrA91fmgtIqDotE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629738046;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Il+RGDFt3Ztl373LHRlcz2OgJsjTo2EIjSZgnOVTzOI=;
        b=j+st0IDc0LQ1oZexi8sfuZsFsnFrhloHil1Hao64kabQA3I6foVi/9QZ9Hq8XAi5gibSXW
        DbxRmAshApsSorBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A0574A3BBD;
        Mon, 23 Aug 2021 17:00:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BA241DA725; Mon, 23 Aug 2021 18:57:46 +0200 (CEST)
Date:   Mon, 23 Aug 2021 18:57:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 4/4] btrfs: subpage: pack all subpage bitmaps into a
 larger bitmap
Message-ID: <20210823165746.GH5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210817093852.48126-1-wqu@suse.com>
 <20210817093852.48126-5-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817093852.48126-5-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 17, 2021 at 05:38:52PM +0800, Qu Wenruo wrote:
> Currently we use u16 bitmap to make 4k sectorsize work for 64K page
> size.
> 
> But this u16 bitmap is not large enough to contain larger page size like
> 128K, nor is space efficient for 16K page size.
> 
> To handle both cases, here we pack all subpage bitmaps into a larger
> bitmap, now btrfs_subpage::bitmaps[] will be the ultimate bitmap for
> subpage usage.
> 
> Each sub-bitmap will has its start bit number recorded in
> btrfs_subpage_info::*_start, and its bitmap length will be recorded in
> btrfs_subpage_info::bitmap_nr_bits.
> 
> All subpage bitmap operations will be converted from using direct u16
> operations to bitmap operations, with above *_start calculated.
> 
> For 64K page size with 4K sectorsize, this should not cause much
> difference.
> 
> While for 16K page size, we will only need 1 unsigned long (u32) to
> store all the bitmaps, which saves quite some space.
> 
> Furthermore, this allows us to support larger page size like 128K and
> 258K.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c |  59 +++++++++++--------
>  fs/btrfs/subpage.c   | 136 +++++++++++++++++++++++++++++--------------
>  fs/btrfs/subpage.h   |  19 +-----
>  3 files changed, 129 insertions(+), 85 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 3c5770d47a95..fcb25ff86ea9 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3856,10 +3856,9 @@ static void find_next_dirty_byte(struct btrfs_fs_info *fs_info,
>  	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
>  	u64 orig_start = *start;
>  	/* Declare as unsigned long so we can use bitmap ops */
> -	unsigned long dirty_bitmap;
>  	unsigned long flags;
> -	int nbits = (orig_start - page_offset(page)) >> fs_info->sectorsize_bits;
> -	int range_start_bit = nbits;
> +	int range_start_bit = fs_info->subpage_info->dirty_offset +
> +		(offset_in_page(orig_start) >> fs_info->sectorsize_bits);

There are several instances of fs_info->subpage_info so that warrants a
temporary variable.

>  	int range_end_bit;
>  
>  	/*
> @@ -3874,11 +3873,14 @@ static void find_next_dirty_byte(struct btrfs_fs_info *fs_info,
>  
>  	/* We should have the page locked, but just in case */
>  	spin_lock_irqsave(&subpage->lock, flags);
> -	dirty_bitmap = subpage->dirty_bitmap;
> +	bitmap_next_set_region(subpage->bitmaps, &range_start_bit, &range_end_bit,
> +			       fs_info->subpage_info->dirty_offset +
> +			       fs_info->subpage_info->bitmap_nr_bits);
>  	spin_unlock_irqrestore(&subpage->lock, flags);
>  
> -	bitmap_next_set_region(&dirty_bitmap, &range_start_bit, &range_end_bit,
> -			       BTRFS_SUBPAGE_BITMAP_SIZE);
> +	range_start_bit -= fs_info->subpage_info->dirty_offset;
> +	range_end_bit -= fs_info->subpage_info->dirty_offset;
> +
>  	*start = page_offset(page) + range_start_bit * fs_info->sectorsize;
>  	*end = page_offset(page) + range_end_bit * fs_info->sectorsize;
>  }
> @@ -4602,12 +4604,11 @@ static int submit_eb_subpage(struct page *page,
>  	int submitted = 0;
>  	u64 page_start = page_offset(page);
>  	int bit_start = 0;
> -	const int nbits = BTRFS_SUBPAGE_BITMAP_SIZE;
>  	int sectors_per_node = fs_info->nodesize >> fs_info->sectorsize_bits;
>  	int ret;
>  
>  	/* Lock and write each dirty extent buffers in the range */
> -	while (bit_start < nbits) {
> +	while (bit_start < fs_info->subpage_info->bitmap_nr_bits) {
>  		struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
>  		struct extent_buffer *eb;
>  		unsigned long flags;
> @@ -4623,7 +4624,8 @@ static int submit_eb_subpage(struct page *page,
>  			break;
>  		}
>  		spin_lock_irqsave(&subpage->lock, flags);
> -		if (!((1 << bit_start) & subpage->dirty_bitmap)) {
> +		if (!test_bit(bit_start + fs_info->subpage_info->dirty_offset,
> +			      subpage->bitmaps)) {
>  			spin_unlock_irqrestore(&subpage->lock, flags);
>  			spin_unlock(&page->mapping->private_lock);
>  			bit_start++;
> @@ -7170,32 +7172,41 @@ void memmove_extent_buffer(const struct extent_buffer *dst,
>  	}
>  }
>  
> +#define GANG_LOOKUP_SIZE	16
>  static struct extent_buffer *get_next_extent_buffer(
>  		struct btrfs_fs_info *fs_info, struct page *page, u64 bytenr)
>  {
> -	struct extent_buffer *gang[BTRFS_SUBPAGE_BITMAP_SIZE];
> +	struct extent_buffer *gang[GANG_LOOKUP_SIZE];
>  	struct extent_buffer *found = NULL;
>  	u64 page_start = page_offset(page);
> -	int ret;
> -	int i;
> +	u64 cur = page_start;
>  
>  	ASSERT(in_range(bytenr, page_start, PAGE_SIZE));
> -	ASSERT(PAGE_SIZE / fs_info->nodesize <= BTRFS_SUBPAGE_BITMAP_SIZE);
>  	lockdep_assert_held(&fs_info->buffer_lock);
>  
> -	ret = radix_tree_gang_lookup(&fs_info->buffer_radix, (void **)gang,
> -			bytenr >> fs_info->sectorsize_bits,
> -			PAGE_SIZE / fs_info->nodesize);
> -	for (i = 0; i < ret; i++) {
> -		/* Already beyond page end */
> -		if (gang[i]->start >= page_start + PAGE_SIZE)
> -			break;
> -		/* Found one */
> -		if (gang[i]->start >= bytenr) {
> -			found = gang[i];
> -			break;
> +	while (cur < page_start + PAGE_SIZE) {
> +		int ret;
> +		int i;
> +
> +		ret = radix_tree_gang_lookup(&fs_info->buffer_radix,
> +				(void **)gang, cur >> fs_info->sectorsize_bits,
> +				min_t(unsigned int, GANG_LOOKUP_SIZE,
> +				      PAGE_SIZE / fs_info->nodesize));
> +		if (ret == 0)
> +			goto out;
> +		for (i = 0; i < ret; i++) {
> +			/* Already beyond page end */
> +			if (gang[i]->start >= page_start + PAGE_SIZE)
> +				goto out;
> +			/* Found one */
> +			if (gang[i]->start >= bytenr) {
> +				found = gang[i];
> +				goto out;
> +			}
>  		}
> +		cur = gang[ret - 1]->start + gang[ret - 1]->len;
>  	}
> +out:
>  	return found;
>  }
>  
> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> index c4fb2ce52207..578095c52a0f 100644
> --- a/fs/btrfs/subpage.c
> +++ b/fs/btrfs/subpage.c
> @@ -142,10 +142,13 @@ struct btrfs_subpage *btrfs_alloc_subpage(const struct btrfs_fs_info *fs_info,
>  					  enum btrfs_subpage_type type)
>  {
>  	struct btrfs_subpage *ret;
> +	unsigned int real_size;
>  
>  	ASSERT(fs_info->sectorsize < PAGE_SIZE);
>  
> -	ret = kzalloc(sizeof(struct btrfs_subpage), GFP_NOFS);
> +	real_size = struct_size(ret, bitmaps,
> +			BITS_TO_LONGS(fs_info->subpage_info->total_nr_bits));
> +	ret = kzalloc(real_size, GFP_NOFS);
>  	if (!ret)
>  		return ERR_PTR(-ENOMEM);
>  
> @@ -328,37 +331,60 @@ void btrfs_page_end_writer_lock(const struct btrfs_fs_info *fs_info,
>  		unlock_page(page);
>  }
>  
> -/*
> - * Convert the [start, start + len) range into a u16 bitmap
> - *
> - * For example: if start == page_offset() + 16K, len = 16K, we get 0x00f0.
> - */
> -static u16 btrfs_subpage_calc_bitmap(const struct btrfs_fs_info *fs_info,
> -		struct page *page, u64 start, u32 len)
> +static bool bitmap_test_range_all_set(unsigned long *addr, unsigned int start,
> +				      unsigned int nbits)
>  {
> -	const int bit_start = offset_in_page(start) >> fs_info->sectorsize_bits;
> -	const int nbits = len >> fs_info->sectorsize_bits;
> +	unsigned int found_zero;
>  
> -	btrfs_subpage_assert(fs_info, page, start, len);
> +	found_zero = find_next_zero_bit(addr, start + nbits, start);
> +	if (found_zero == start + nbits)
> +		return true;
> +	return false;
> +}
>  
> -	/*
> -	 * Here nbits can be 16, thus can go beyond u16 range. We make the
> -	 * first left shift to be calculate in unsigned long (at least u32),
> -	 * then truncate the result to u16.
> -	 */
> -	return (u16)(((1UL << nbits) - 1) << bit_start);
> +static bool bitmap_test_range_all_zero(unsigned long *addr, unsigned int start,
> +				       unsigned int nbits)
> +{
> +	unsigned int found_set;
> +
> +	found_set = find_next_bit(addr, start + nbits, start);
> +	if (found_set == start + nbits)
> +		return true;
> +	return false;
>  }
>  
> +#define subpage_calc_start_bit(fs_info, page, name, start, len)		\
> +({									\
> +	unsigned int start_bit;						\
> +									\
> +	btrfs_subpage_assert(fs_info, page, start, len);		\
> +	start_bit = offset_in_page(start) >> fs_info->sectorsize_bits;	\
> +	start_bit += fs_info->subpage_info->name##_offset;		\
> +	start_bit;							\
> +})
> +
> +#define subpage_test_bitmap_all_set(fs_info, subpage, name)		\
> +	bitmap_test_range_all_set(subpage->bitmaps,			\
> +			fs_info->subpage_info->name##_offset,		\
> +			fs_info->subpage_info->bitmap_nr_bits)
> +
> +#define subpage_test_bitmap_all_zero(fs_info, subpage, name)		\
> +	bitmap_test_range_all_zero(subpage->bitmaps,			\
> +			fs_info->subpage_info->name##_offset,		\
> +			fs_info->subpage_info->bitmap_nr_bits)
> +
>  void btrfs_subpage_set_uptodate(const struct btrfs_fs_info *fs_info,
>  		struct page *page, u64 start, u32 len)
>  {
>  	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
> -	const u16 tmp = btrfs_subpage_calc_bitmap(fs_info, page, start, len);
> +	unsigned int start_bit = subpage_calc_start_bit(fs_info, page,
> +							uptodate, start, len);
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&subpage->lock, flags);
> -	subpage->uptodate_bitmap |= tmp;
> -	if (subpage->uptodate_bitmap == U16_MAX)
> +	bitmap_set(subpage->bitmaps, start_bit,
> +		   len >> fs_info->sectorsize_bits);

All the bitmap_* calls like this and the parameter fit one line.
