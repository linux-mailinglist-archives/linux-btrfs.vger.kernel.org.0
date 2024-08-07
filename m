Return-Path: <linux-btrfs+bounces-7023-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9962694A9E8
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2024 16:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B7941F21A87
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2024 14:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E414C78C84;
	Wed,  7 Aug 2024 14:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="g/RGIXPO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7EE7605E
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Aug 2024 14:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040290; cv=none; b=uNSoPNyK8fJkdf/53z9RoqqoRkyAySGnw+ZkhujxQx1vsAqGmA1rSpHV9zlUBwwRo41hoPa5csQ2uQY+/MC6T/oAgBT3seVJosPXsML2aJrRtr8yMIUT0h6YApYn0+65TKhmBt+LiMQpmrJ7dCWAnHbuzfmNOwt3a1BZp+3LmGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040290; c=relaxed/simple;
	bh=vXoN9bzkzc6JpWrpPMm3dZa1zqs3BJ0W5o2bVXx5cOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcC9QeKv0fjoyzcP5S8je/iJ4oSlr6BtaMEKwsAbpwJWmAKPNgwCvl4OikTcVyYVEVrSiZNty/C6p1kTGfF967zn08iW099vb5cKvJYW9ImJqAqSSTtS02ro6cOap1KC0KM+RrxI2xHf9u63WRkAZM1nSQYap3Q9Wg97XSsrf2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=g/RGIXPO; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-44fe28eb1bfso9040241cf.0
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Aug 2024 07:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723040287; x=1723645087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xzoGv51qG688e8CkqfOWZi/K63J+LGOYfGSyGwjiq6g=;
        b=g/RGIXPOIs68m1a/KSj9ZU2k46KmGY+kl6SnjHwjDhabpgWfi67uBG/+1vhUFFiI3k
         GD3a5r1O2keLkBRAklRxJrdXpZvgKisIMmJLSKNyDa89v9Y3e4HCUSRpkNPlzOq4BnjZ
         Lm1tFkYKVH0VYiQBJA+iVV9LDNueQG9SJBpDS8D4fCndKISkL9or3R49JyXJ+AJlbIqU
         YH0dgGjmbCjAckMUd50YaL8H9mN/Dk+ZcvNLNQCJIufbavZmLa6pzBopQdaelRDfRbsK
         gopKQbv2DTlNrkPWQcfvNXCmhda0pjJd11Y0Up0yftNjCdBCG/DsmNZn9uo8CCw3+Mjg
         psKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723040287; x=1723645087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzoGv51qG688e8CkqfOWZi/K63J+LGOYfGSyGwjiq6g=;
        b=qfAqWBqXlHlRLqphZ74/0JPJV5MRb2pD6IQYuC5jmAZr3ECIyruDEgEwg3+ijFqGbl
         Gq3XAdUS/mQHZWfVFlODrw0tOsGX+WVPoL66+P2zBbrQlOwdBRzXQH66QUms6WguTvs8
         YYmqqI+wCzW0rfFLtARsrZUNsLEfBwXVSUk4o9UxIRWTZj9VJK6EZN9W81+2srOo14oo
         Rk1Bwn6YsE/nx6i22g42ksnQkFaepyu7gjUazwCjCgP5Rhb0NftfitowIy+ecG82gP/d
         dQM6jO7D/7Aqn6tC+/jE3mRYncH+IX58+LI1UMb7SQr9B8d6MNrkQFjaaR7dV01HE2D1
         P31w==
X-Gm-Message-State: AOJu0YyGro+dJORzR4LZD6+7RlKpKVlqzyvqaGRPiVJLxQMPOaYleerP
	xM3ImR5q1kEdWpLGmmKmdcKSYLQ3vZcTQhSEWXxy7+vODjxov76NRhHoxeriOyGi97WYoatmUMw
	q
X-Google-Smtp-Source: AGHT+IGJSWQFH+R3ifCujrxDZg0GTFUwE4Bo8NI4NS8qjJCXw6vzvQd3fSMz6O5vZ0krh018wm7Org==
X-Received: by 2002:ac8:5796:0:b0:446:5568:a6de with SMTP id d75a77b69052e-451893033femr242913661cf.48.1723040286746;
        Wed, 07 Aug 2024 07:18:06 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-451c86ff93bsm5287851cf.20.2024.08.07.07.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 07:18:06 -0700 (PDT)
Date: Wed, 7 Aug 2024 10:18:05 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: refactor __extent_writepage_io() to do
 sector-by-sector submission
Message-ID: <20240807141805.GB242945@perftesting>
References: <9102c028537fbc1d94c4b092dd4a9940661bc58b.1723020573.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9102c028537fbc1d94c4b092dd4a9940661bc58b.1723020573.git.wqu@suse.com>

On Wed, Aug 07, 2024 at 06:21:00PM +0930, Qu Wenruo wrote:
> Unlike the bitmap usage inside raid56, for __extent_writepage_io() we
> handle the subpage submission not sector-by-sector, but for each dirty
> range we found.
> 
> This is not a big deal normally, as normally the subpage complex code is
> already mostly optimized out.
> 
> For the sake of consistency and for the future of subpage sector-perfect
> compression support, this patch does:
> 
> - Extract the sector submission code into submit_one_sector()
> 
> - Add the needed code to extract the dirty bitmap for subpage case
> 
> - Use bitmap_and() to calculate the target sectors we need to submit
> 
> For x86_64, the dirty bitmap will be fixed to 1, with the length of 1,
> so we're still doing the same workload per sector.
> 
> For larger page sizes, the overhead will be a little larger, as previous
> we only need to do one extent_map lookup per-dirty-range, but now it
> will be one extent_map lookup per-sector.

I'd like this to be a followup, because even in the normal page case (or hell
the subpage case) we shouldn't have to look up the extent map over and over
again, it could span a much larger area.

> 
> But that is the same frequency as x86_64, so we're just aligning the
> behavior to x86_64.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> The plan of sector-perfect subpage compression is to introduce another
> bitmap, possibly inside bio_ctrl, to indicate which sectors do not need
> writeback submission (either inline, or async submission).
> 
> So that __extent_writepage_io() can properly skip those ranges to
> support sector-perfect subpage compression.
> ---
>  fs/btrfs/extent_io.c | 188 +++++++++++++++++--------------------------
>  fs/btrfs/subpage.c   |  17 ++++
>  fs/btrfs/subpage.h   |   3 +
>  3 files changed, 96 insertions(+), 112 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 040c92541bc9..6acd763e8f26 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1333,56 +1333,65 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
>  }
>  
>  /*
> - * Find the first byte we need to write.
> + * Return 0 if we have submitted or queued the sector for submission.
> + * Return <0 for critical errors.
>   *
> - * For subpage, one page can contain several sectors, and
> - * __extent_writepage_io() will just grab all extent maps in the page
> - * range and try to submit all non-inline/non-compressed extents.
> - *
> - * This is a big problem for subpage, we shouldn't re-submit already written
> - * data at all.
> - * This function will lookup subpage dirty bit to find which range we really
> - * need to submit.
> - *
> - * Return the next dirty range in [@start, @end).
> - * If no dirty range is found, @start will be page_offset(page) + PAGE_SIZE.
> + * Caller should make sure filepos < i_size and handle filepos >= i_size case.
>   */
> -static void find_next_dirty_byte(const struct btrfs_fs_info *fs_info,
> -				 struct folio *folio, u64 *start, u64 *end)
> +static int submit_one_sector(struct btrfs_inode *inode,
> +			     struct folio *folio,
> +			     u64 filepos, struct btrfs_bio_ctrl *bio_ctrl,
> +			     loff_t i_size)
>  {
> -	struct btrfs_subpage *subpage = folio_get_private(folio);
> -	struct btrfs_subpage_info *spi = fs_info->subpage_info;
> -	u64 orig_start = *start;
> -	/* Declare as unsigned long so we can use bitmap ops */
> -	unsigned long flags;
> -	int range_start_bit;
> -	int range_end_bit;
> +	struct btrfs_fs_info *fs_info = inode->root->fs_info;
> +	struct extent_map *em;
> +	u64 block_start;
> +	u64 disk_bytenr;
> +	u64 extent_offset;
> +	u64 em_end;
> +	u32 sectorsize = fs_info->sectorsize;
>  
> -	/*
> -	 * For regular sector size == page size case, since one page only
> -	 * contains one sector, we return the page offset directly.
> -	 */
> -	if (!btrfs_is_subpage(fs_info, folio->mapping)) {
> -		*start = folio_pos(folio);
> -		*end = folio_pos(folio) + folio_size(folio);
> -		return;
> +	ASSERT(IS_ALIGNED(filepos, sectorsize));
> +
> +	/* @filepos >= i_size case should be handled by the caller. */
> +	ASSERT(filepos < i_size);
> +
> +	em = btrfs_get_extent(inode, NULL, filepos, sectorsize);
> +	if (IS_ERR(em))
> +		return PTR_ERR_OR_ZERO(em);
> +
> +	extent_offset = filepos - em->start;
> +	em_end = extent_map_end(em);
> +	ASSERT(filepos <= em_end);
> +	ASSERT(IS_ALIGNED(em->start, fs_info->sectorsize));
> +	ASSERT(IS_ALIGNED(em->len, fs_info->sectorsize));
> +
> +	block_start = extent_map_block_start(em);
> +	disk_bytenr = extent_map_block_start(em) + extent_offset;
> +
> +	ASSERT(!extent_map_is_compressed(em));
> +	ASSERT(block_start != EXTENT_MAP_HOLE);
> +	ASSERT(block_start != EXTENT_MAP_INLINE);
> +
> +	free_extent_map(em);
> +	em = NULL;
> +
> +	btrfs_set_range_writeback(inode, filepos, filepos + sectorsize - 1);
> +	if (!folio_test_writeback(folio)) {
> +		btrfs_err(fs_info,
> +			  "folio %lu not writeback, cur %llu end %llu",
> +			  folio->index, filepos, filepos + sectorsize);
>  	}
> -
> -	range_start_bit = spi->dirty_offset +
> -			  (offset_in_folio(folio, orig_start) >>
> -			   fs_info->sectorsize_bits);
> -
> -	/* We should have the page locked, but just in case */
> -	spin_lock_irqsave(&subpage->lock, flags);
> -	bitmap_next_set_region(subpage->bitmaps, &range_start_bit, &range_end_bit,
> -			       spi->dirty_offset + spi->bitmap_nr_bits);
> -	spin_unlock_irqrestore(&subpage->lock, flags);
> -
> -	range_start_bit -= spi->dirty_offset;
> -	range_end_bit -= spi->dirty_offset;
> -
> -	*start = folio_pos(folio) + range_start_bit * fs_info->sectorsize;
> -	*end = folio_pos(folio) + range_end_bit * fs_info->sectorsize;
> +	/*
> +	 * Although the PageDirty bit is cleared before entering this
> +	 * function, subpage dirty bit is not cleared.
> +	 * So clear subpage dirty bit here so next time we won't submit
> +	 * folio for range already written to disk.
> +	 */
> +	btrfs_folio_clear_dirty(fs_info, folio, filepos, sectorsize);
> +	submit_extent_folio(bio_ctrl, disk_bytenr, folio,
> +			    sectorsize, filepos - folio_pos(folio));
> +	return 0;
>  }
>  
>  /*
> @@ -1401,10 +1410,10 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
>  {
>  	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>  	u64 cur = start;
> -	u64 end = start + len - 1;
> -	u64 extent_offset;
> -	u64 block_start;
> -	struct extent_map *em;
> +	unsigned long dirty_bitmap = 1;
> +	unsigned long range_bitmap = 0;
> +	unsigned int bitmap_size = 1;
> +	int bit;
>  	int ret = 0;
>  	int nr = 0;
>  
> @@ -1419,18 +1428,23 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
>  		return 1;
>  	}
>  
> +	if (btrfs_is_subpage(fs_info, inode->vfs_inode.i_mapping)) {
> +		ASSERT(fs_info->subpage_info);
> +		btrfs_get_subpage_dirty_bitmap(fs_info, folio, &dirty_bitmap);
> +		bitmap_size = fs_info->subpage_info->bitmap_nr_bits;
> +	}
> +	for (cur = start; cur < start + len; cur += fs_info->sectorsize)
> +		set_bit((cur - start) >> fs_info->sectorsize_bits, &range_bitmap);
> +	bitmap_and(&dirty_bitmap, &dirty_bitmap, &range_bitmap, bitmap_size);

I'd rather move this completely under the btrfs_is_subpage() case, we don't need
to do this where sectorsize == page size.

Other than that this cleans things up nicely, you can add my

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to v2.  Thanks,

Josef

