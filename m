Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3B5039E500
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jun 2021 19:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbhFGRNH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Jun 2021 13:13:07 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43624 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhFGRNG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Jun 2021 13:13:06 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1B24D21A99;
        Mon,  7 Jun 2021 17:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623085874;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qyCQbeWvPcQTM+zE13h641pYk86wcx5l+FLGci6yU04=;
        b=LFO9a8bvCjElOP5Va+R0WD3EEKMSF0Ubw+GL8ovMrR6W8SgQR+sg5xETxXf9Nw2MFVTfPH
        NVC2oQ/rWc8v1imvbTzwLyf+3oZnnsIlXSgM72XqGBBptXyHxCNIOIquOLGHUbm2ncSvb0
        /O73HvNKpVWadg2xsn1bzo8hGj/9L4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623085874;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qyCQbeWvPcQTM+zE13h641pYk86wcx5l+FLGci6yU04=;
        b=ZKfv0tnKrOBgXzFEZnIGxin203zUA3di+dAhg6DRDIljO+xV1vl8Hzp/XqAU/JK7M7ERWZ
        6YKFmxPvQdlewaAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 14BDEA3B8A;
        Mon,  7 Jun 2021 17:11:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 05FFEDB228; Mon,  7 Jun 2021 19:08:30 +0200 (CEST)
Date:   Mon, 7 Jun 2021 19:08:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.cz
Subject: Re: [PATCH] btrfs: fix embarrassing bugs in find_next_dirty_byte()
Message-ID: <20210607170830.GF31483@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210605001428.26072-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210605001428.26072-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jun 05, 2021 at 08:14:28AM +0800, Qu Wenruo wrote:
> There are several bugs in find_next_dirty_byte():
> 
> - Wrong right shift
>   int nbits = (orig_start - page_offset(page)) >> fs_info->sectorsize;
> 
>   This makes nbits to be always 0, thus find_next_dirty_byte() doesn't
>   really check any range, but bit by bit check.
> 
>   This mask all other bugs in the same function.
> 
> - Wrong @first_bit_zero calculation
>   The real @first_bit_zero we want should be after @first_bit_set.
> 
> All these bit dancing with tons of ASSERT() is really a waste of time.
> The only reason I didn't go bitmap operations is they require unsigned
> long.
> 
> But considering how many bugs there are just in this small function,
> bitmap_next_set_region() should be the correct way to go.
> 
> Fix all these mess by using unsigned long for the local bitmap, and call
> bitmap_next_set_region() to end all these stupid bugs.
> 
> Thankfully, this bug can be easily verify by any short fsstress/fsx run.
> 
> Please fold this fix into "btrfs: make __extent_writepage_io() only submit dirty range for subpage".
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c | 38 +++++++++-----------------------------
>  1 file changed, 9 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index d6a12f7e36d9..77b59ca93419 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3877,11 +3877,12 @@ static void find_next_dirty_byte(struct btrfs_fs_info *fs_info,
>  {
>  	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
>  	u64 orig_start = *start;
> -	u16 dirty_bitmap;
> +	/* Declare as unsigned long so we can use bitmap ops */
> +	unsigned long dirty_bitmap;
>  	unsigned long flags;
> -	int nbits = (orig_start - page_offset(page)) >> fs_info->sectorsize;
> -	int first_bit_set;
> -	int first_bit_zero;
> +	int nbits = (orig_start - page_offset(page)) >> fs_info->sectorsize_bits;
> +	int range_start_bit = nbits;
> +	int range_end_bit;
>  
>  	/*
>  	 * For regular sector size == page size case, since one page only
> @@ -3898,31 +3899,10 @@ static void find_next_dirty_byte(struct btrfs_fs_info *fs_info,
>  	dirty_bitmap = subpage->dirty_bitmap;
>  	spin_unlock_irqrestore(&subpage->lock, flags);
>  
> -	/* Set bits lower than @nbits with 0 */
> -	dirty_bitmap &= ~((1 << nbits) - 1);
> -
> -	first_bit_set = ffs(dirty_bitmap);
> -	/* No dirty range found */
> -	if (first_bit_set == 0) {
> -		*start = page_offset(page) + PAGE_SIZE;
> -		return;
> -	}
> -
> -	ASSERT(first_bit_set > 0 && first_bit_set <= BTRFS_SUBPAGE_BITMAP_SIZE);
> -	*start = page_offset(page) + (first_bit_set - 1) * fs_info->sectorsize;
> -
> -	/* Set all bits lower than @nbits to 1 for ffz() */
> -	dirty_bitmap |= ((1 << nbits) - 1);
> -
> -	first_bit_zero = ffz(dirty_bitmap);
> -	if (first_bit_zero == 0 || first_bit_zero > BTRFS_SUBPAGE_BITMAP_SIZE) {
> -		*end = page_offset(page) + PAGE_SIZE;
> -		return;
> -	}
> -	ASSERT(first_bit_zero > 0 &&
> -	       first_bit_zero <= BTRFS_SUBPAGE_BITMAP_SIZE);
> -	*end = page_offset(page) + first_bit_zero * fs_info->sectorsize;
> -	ASSERT(*end > *start);
> +	bitmap_next_set_region(&dirty_bitmap, &range_start_bit, &range_end_bit,
> +			       BTRFS_SUBPAGE_BITMAP_SIZE);
> +	*start = page_offset(page) + range_start_bit * fs_info->sectorsize;
> +	*end = page_offset(page) + range_end_bit * fs_info->sectorsize;

Makes sense. We want the u16 for the storage but the more complex
calculations could be done using the bitmap helpers, and converted back
eventually.
