Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B98B3ED1ED
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Aug 2021 12:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhHPK0y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Aug 2021 06:26:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49450 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbhHPK0v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Aug 2021 06:26:51 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AB5A61FF91;
        Mon, 16 Aug 2021 10:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629109578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oJ/hGo/qSNRiB49+d3UM3Y3cFfL86XcjfgkcURIYZ7o=;
        b=QUSn71jhERJgbdUoghbTxG6ONi4A0WieUu77czu26jtz56sl5zS43EyiYP3P0vXWeDMP/a
        zT4nXvKC4WnSOxasvxzSuYraAkPw6mfTCz0pDLJjWR29MD1NiO1bHr7/eaDrgiSbgyfQ0f
        xRzhIIcUZuYY/4DkIZSkkuFVezhu+8k=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 83AEA136A6;
        Mon, 16 Aug 2021 10:26:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id oEefHUo9GmGLCwAAGKfGzw
        (envelope-from <nborisov@suse.com>); Mon, 16 Aug 2021 10:26:18 +0000
Subject: Re: [PATCH 2/2] btrfs: subpage: pack all subpage bitmaps into a
 larger bitmap
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210816060036.57788-1-wqu@suse.com>
 <20210816060036.57788-3-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <bcda08a2-c014-10d7-64c8-1ac29b0f43ab@suse.com>
Date:   Mon, 16 Aug 2021 13:26:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210816060036.57788-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 16.08.21 г. 9:00, Qu Wenruo wrote:
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
> For 64K page size with 4K sectorsize, this should not cause much difference.
> While for 16K page size, we will only need 1 unsigned long (u32) to
> restore the bitmap.
> And will be able to support 128K page size in the future.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c |  58 ++++++++++--------
>  fs/btrfs/subpage.c   | 137 +++++++++++++++++++++++++++++--------------
>  fs/btrfs/subpage.h   |  19 +-----
>  3 files changed, 130 insertions(+), 84 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 543f87ea372e..e428d6208bb7 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3865,10 +3865,9 @@ static void find_next_dirty_byte(struct btrfs_fs_info *fs_info,
>  	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
>  	u64 orig_start = *start;
>  	/* Declare as unsigned long so we can use bitmap ops */
> -	unsigned long dirty_bitmap;
>  	unsigned long flags;
> -	int nbits = (orig_start - page_offset(page)) >> fs_info->sectorsize_bits;
> -	int range_start_bit = nbits;
> +	int nbits = offset_in_page(orig_start) >> fs_info->sectorsize_bits;

nbits is rather dubious, by reading it I'd expect it to hold a
count/number of bits. In fact it holds a sector index. A better name
would be sector_index or block_index.

> +	int range_start_bit = nbits + fs_info->subpage_info->dirty_start;
>  	int range_end_bit;
>  
>  	/*
> @@ -3883,11 +3882,14 @@ static void find_next_dirty_byte(struct btrfs_fs_info *fs_info,
>  
>  	/* We should have the page locked, but just in case */
>  	spin_lock_irqsave(&subpage->lock, flags);
> -	dirty_bitmap = subpage->dirty_bitmap;
> +	bitmap_next_set_region(subpage->bitmaps, &range_start_bit, &range_end_bit,
> +			       fs_info->subpage_info->dirty_start +
> +			       fs_info->subpage_info->bitmap_nr_bits);
>  	spin_unlock_irqrestore(&subpage->lock, flags);
>  
> -	bitmap_next_set_region(&dirty_bitmap, &range_start_bit, &range_end_bit,
> -			       BTRFS_SUBPAGE_BITMAP_SIZE);
> +	range_start_bit -= fs_info->subpage_info->dirty_start;
> +	range_end_bit -= fs_info->subpage_info->dirty_start;
> +
>  	*start = page_offset(page) + range_start_bit * fs_info->sectorsize;
>  	*end = page_offset(page) + range_end_bit * fs_info->sectorsize;
>  }
> @@ -4613,7 +4615,7 @@ static int submit_eb_subpage(struct page *page,
>  	int submitted = 0;
>  	u64 page_start = page_offset(page);
>  	int bit_start = 0;
> -	const int nbits = BTRFS_SUBPAGE_BITMAP_SIZE;
> +	const int nbits = fs_info->subpage_info->bitmap_nr_bits;

nit: do we really need nbits, given that
fs_info->subpage_info->bitmap_nr_bits fits on one line inside the while
expression. Also see the discrepancy - nbits here indeed holds a "number
of bits value".

>  	int sectors_per_node = fs_info->nodesize >> fs_info->sectorsize_bits;
>  	int ret;
>  

<snip>

> @@ -7178,32 +7181,41 @@ void memmove_extent_buffer(const struct extent_buffer *dst,
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
> +				break;

Instead of break, don't you want to do got out? Break would exit from
the inner for() loop and continue at the outter while loop.

> +			}
>  		}
> +		cur = gang[ret - 1]->start + gang[ret - 1]->len;
>  	}
> +out:
>  	return found;
>  }
>  
> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> index 014256d47beb..9d6da9f2d77e 100644
> --- a/fs/btrfs/subpage.c
> +++ b/fs/btrfs/subpage.c
> @@ -139,10 +139,14 @@ int btrfs_alloc_subpage(const struct btrfs_fs_info *fs_info,
>  			struct btrfs_subpage **ret,
>  			enum btrfs_subpage_type type)
>  {
> +	unsigned int real_size;
> +
>  	if (fs_info->sectorsize == PAGE_SIZE)
>  		return 0;

offtopic: Instead of having a bunch of those checks can't we replace
them with ASSERTS and ensure that the decision whether we do subpage or
not is taken at a higher level ?
>  
> -	*ret = kzalloc(sizeof(struct btrfs_subpage), GFP_NOFS);
> +	real_size = BITS_TO_LONGS(fs_info->subpage_info->total_nr_bits) *
> +		    sizeof(unsigned long) + sizeof(struct btrfs_subpage);

real_size = struct_size(*ret, bitmaps,
BITS_TO_LONGS(fs_info->subpage_info->total_nr_bits));

And the calling convention for this function is awful. Just make it
return struct btrfs_subpage * and kill the dreadful **ret....

> +	*ret = kzalloc(real_size, GFP_NOFS);
>  	if (!*ret)
>  		return -ENOMEM;
>  	spin_lock_init(&(*ret)->lock);
> @@ -324,37 +328,60 @@ void btrfs_page_end_writer_lock(const struct btrfs_fs_info *fs_info,
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
> +static bool bitmap_test_range_all_set(unsigned long *addr, unsigned start,
> +				      unsigned int nbits)
>  {
> -	const int bit_start = offset_in_page(start) >> fs_info->sectorsize_bits;
> -	const int nbits = len >> fs_info->sectorsize_bits;
> +	unsigned int found_zero;
>  
> -	btrfs_subpage_assert(fs_info, page, start, len);
> +	found_zero = find_next_zero_bit(addr, start + nbits, start);

2 argument of find_next_zero_bit is 'size' which would be nbits as it
expects the size to be in bits , not start + nbit. Every logical bitmap
in ->bitmaps is defined by [start, nbits] no ? Unfortunately there is a
discrepancy between the order of documentation and the order of actual
arguments in the definition of this function....

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
> +static bool bitmap_test_range_all_zero(unsigned long *addr, unsigned start,
> +				       unsigned int nbits)
> +{
> +	unsigned int found_set;
> +
> +	found_set = find_next_bit(addr, start + nbits, start);
> +	if (found_set == start + nbits)
> +		return true;
> +	return false;

This can be implemented by simply doing !bitmap_test_range_all_set no
need to have 2 separate implementations. Given those 2 functions are
only used in the definition oof the subpage_test_bitmap* macros I'da say
remove one of them and simply code the macros as
bitmap_test_range_all_set and !bitmap_test_range_all_set respectively.

>  }
>  

<snip>

