Return-Path: <linux-btrfs+bounces-7030-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB26F94AE24
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2024 18:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E50922831C4
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2024 16:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E521513D63B;
	Wed,  7 Aug 2024 16:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wbwD3uyL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uSZ52EaP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wbwD3uyL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uSZ52EaP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8377132117
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Aug 2024 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723048042; cv=none; b=rgdNsgCCbcb6Fq/bfWZLsdWLaw2X0HI5hgKoDPwXrHOqCjdi/JfyUFJ/9wI9kP9HrcMpoGLgtL49DRrz3y90iOtkoEa9bCUZTk+sqqoNg6t2NCxFkSn4su+/r33/ZKBXGYxZB9/CD1Qc5t2adN2BPCmZQek+7xI8KiY7H8RUPPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723048042; c=relaxed/simple;
	bh=uA+7KqJCC1Arp93b44bndaOWtVdicxUVUTt2pbeXAlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKe/18CXwrECNAkOjpD6uFEeVvIb/0yLdZKcDBziKciymUxV/FcrNx+T1aWwGr/wZGB3daR/ssY2m7ET7qfB1ZIa9zraQKte7Vm9mloEJedlh4mPFrUKa/WhFlGxtpd7JmcTR+LvWXjSnLvhRugiLJKoklHDHUiAy6SzvQDxLvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wbwD3uyL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uSZ52EaP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wbwD3uyL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uSZ52EaP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BEF0F21B4B;
	Wed,  7 Aug 2024 16:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723048037;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2nAly3Brv8MM6hbT9NpxRsIVuS2JpqOwWzVlJOPM6Vs=;
	b=wbwD3uyLJ6q9HWH/FIj4u4lOXdCc7m6RYOHir6ogk4S4UGOGb6n/036lVcY86RPisPl7w7
	fPt3LgPuQDBgPK0LmOH8CachaBpcKI83srb6zV0GbPJuExoatW0me4X1F40kVg21pEuXPR
	ClGdM38pwlt+0A4pKaJ4gbWAj+LnTy4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723048037;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2nAly3Brv8MM6hbT9NpxRsIVuS2JpqOwWzVlJOPM6Vs=;
	b=uSZ52EaP6p6+4pRoAokVdfzSdqYIBPRhPG1Lhfa3DC/EiaLYLXkBZKTPcglICh8j6bw6//
	Y7Kwvlv0nGaQOkCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723048037;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2nAly3Brv8MM6hbT9NpxRsIVuS2JpqOwWzVlJOPM6Vs=;
	b=wbwD3uyLJ6q9HWH/FIj4u4lOXdCc7m6RYOHir6ogk4S4UGOGb6n/036lVcY86RPisPl7w7
	fPt3LgPuQDBgPK0LmOH8CachaBpcKI83srb6zV0GbPJuExoatW0me4X1F40kVg21pEuXPR
	ClGdM38pwlt+0A4pKaJ4gbWAj+LnTy4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723048037;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2nAly3Brv8MM6hbT9NpxRsIVuS2JpqOwWzVlJOPM6Vs=;
	b=uSZ52EaP6p6+4pRoAokVdfzSdqYIBPRhPG1Lhfa3DC/EiaLYLXkBZKTPcglICh8j6bw6//
	Y7Kwvlv0nGaQOkCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8495113A7D;
	Wed,  7 Aug 2024 16:27:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Gd3OH2Wgs2YGEAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 07 Aug 2024 16:27:17 +0000
Date: Wed, 7 Aug 2024 18:27:16 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: refactor __extent_writepage_io() to do
 sector-by-sector submission
Message-ID: <20240807162716.GD17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
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
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-8.00 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.com:email]
X-Spam-Score: -8.00
X-Spam-Flag: NO
X-Spam-Level: 

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

This can be const

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

And the local sectorsize used here

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

This is copied from the original code but I wonder if this should be a
hard error or more visible as it looks like bad page state tracking.


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

