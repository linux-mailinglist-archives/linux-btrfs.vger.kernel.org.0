Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B4B2D9954
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Dec 2020 15:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408040AbgLNOAP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Dec 2020 09:00:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:52978 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbgLNOAH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Dec 2020 09:00:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607954361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=KFNByS1pTPqd5U2lrOly2U07Gz1iYNmvOii+LskkQrY=;
        b=N1g8lva3PRdJLDXcR5peSDKudcFnRf1YW1VA2woMGpGMRLCJB9fAabH1SW/SbyG0BO4Z/A
        aFEhTsclvRTcFbv9BFvTBBMapRSwBDp8z24Oa2ZuQb8EtgqQGw35Suwck0IetqUXTCz0tX
        Hbfu3Mj2pV4+pem3szz0+T8dsga+g/A=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 29B05ADC1;
        Mon, 14 Dec 2020 13:59:21 +0000 (UTC)
Subject: Re: [PATCH v2 17/18] btrfs: integrate page status update for read
 path into begin/end_page_read()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201210063905.75727-1-wqu@suse.com>
 <20201210063905.75727-18-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d46ffb04-e3a8-79d0-432b-73e3281eb7d7@suse.com>
Date:   Mon, 14 Dec 2020 15:59:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201210063905.75727-18-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10.12.20 г. 8:39 ч., Qu Wenruo wrote:
> In btrfs data page read path, the page status update are handled in two
> different locations:
> 
>   btrfs_do_read_page()
>   {
> 	while (cur <= end) {
> 		/* No need to read from disk */
> 		if (HOLE/PREALLOC/INLINE){
> 			memset();
> 			set_extent_uptodate();
> 			continue;
> 		}
> 		/* Read from disk */
> 		ret = submit_extent_page(end_bio_extent_readpage);
>   }
> 
>   end_bio_extent_readpage()
>   {
> 	endio_readpage_uptodate_page_status();
>   }
> 
> This is fine for sectorsize == PAGE_SIZE case, as for above loop we
> should only hit one branch and then exit.
> 
> But for subpage, there are more works to be done in page status update:
> - Page Unlock condition
>   Unlike regular page size == sectorsize case, we can no longer just
>   unlock a page.
>   Only the last reader of the page can unlock the page.
>   This means, we can unlock the page either in the while() loop, or in
>   the endio function.
> 
> - Page uptodate condition
>   Since we have multiple sectors to read for a page, we can only mark
>   the full page uptodate if all sectors are uptodate.
> 
> To handle both subpage and regular cases, introduce a pair of functions
> to help handling page status update:
> 
> - being_page_read()
>   For regular case, it does nothing.
>   For subpage case, it update the reader counters so that later
>   end_page_read() can know who is the last one to unlock the page.
> 
> - end_page_read()
>   This is just endio_readpage_uptodate_page_status() renamed.
>   The original name is a little too long and too specific for endio.
> 
>   The only new trick added is the condition for page unlock.
>   Now for subage data, we unlock the page if we're the last reader.
> 
> This does not only provide the basis for subpage data read, but also
> hide the special handling of page read from the main read loop.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c | 39 +++++++++++++++++++++++++-----------
>  fs/btrfs/subpage.h   | 47 ++++++++++++++++++++++++++++++++++++++------
>  2 files changed, 68 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 4e4ed9c453ae..56174e7f0ae8 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2841,8 +2841,18 @@ static void endio_readpage_release_extent(struct processed_extent *processed,
>  	processed->uptodate = uptodate;
>  }
>  
> -static void endio_readpage_update_page_status(struct page *page, bool uptodate,
> -					      u64 start, u64 end)
> +static void begin_data_page_read(struct btrfs_fs_info *fs_info, struct page *page)
> +{
> +	ASSERT(PageLocked(page));
> +	if (fs_info->sectorsize == PAGE_SIZE)
> +		return;
> +
> +	ASSERT(PagePrivate(page) && page->private);
2nd part of the assert condition is redundant, page->private should only
be set via the respective generic helper which is never called with NULL
as the 2nd argument.

> +	ASSERT(page->mapping->host != fs_info->btree_inode);
That function is only called by btrfs_do_readpage which is used only for
data read out, so do we really need this? I understand you want to be
extra careful but I think this is going over the top.

> +	btrfs_subpage_start_reader(fs_info, page, page_offset(page), PAGE_SIZE);
> +}
> +
> +static void end_page_read(struct page *page, bool uptodate, u64 start, u64 end)
>  {
>  	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
>  	u32 len;
> @@ -2860,7 +2870,12 @@ static void endio_readpage_update_page_status(struct page *page, bool uptodate,
>  
>  	if (fs_info->sectorsize == PAGE_SIZE)
>  		unlock_page(page);
> -	/* Subpage locking will be handled in later patches */
> +	else if (page->mapping->host != fs_info->btree_inode)

Use is_data_inode() helper

> +		/*
> +		 * For subpage data, unlock the page if we're the last reader.
> +		 * For subpage metadata, page lock is not utilized for read.
> +		 */
> +		btrfs_subpage_end_reader(fs_info, page, start, len);
>  }
>  
>  /*

<snip>
> diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
> index 8592234d773e..6c801ef00d2d 100644
> --- a/fs/btrfs/subpage.h
> +++ b/fs/btrfs/subpage.h
> @@ -31,6 +31,9 @@ struct btrfs_subpage {
>  			u16 tree_block_bitmap;
>  		};
>  		/* structures only used by data */
> +		struct {
> +			atomic_t readers;
> +		};
>  	};
>  };
>  
> @@ -48,6 +51,17 @@ static inline void btrfs_subpage_clamp_range(struct page *page,
>  		     orig_start + orig_len) - *start;
>  }
>  
> +static inline void btrfs_subpage_assert(struct btrfs_fs_info *fs_info,
> +					struct page *page, u64 start, u32 len)
> +{
> +	/* Basic checks */
> +	ASSERT(PagePrivate(page) && page->private);
> +	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
> +	       IS_ALIGNED(len, fs_info->sectorsize));
> +	ASSERT(page_offset(page) <= start &&
> +	       start + len <= page_offset(page) + PAGE_SIZE);
> +}
> +
>  /*
>   * Convert the [start, start + len) range into a u16 bitmap
>   *
> @@ -59,12 +73,8 @@ static inline u16 btrfs_subpage_calc_bitmap(struct btrfs_fs_info *fs_info,
>  	int bit_start = (start - page_offset(page)) >> fs_info->sectorsize_bits;
>  	int nbits = len >> fs_info->sectorsize_bits;
>  
> -	/* Basic checks */
> -	ASSERT(PagePrivate(page) && page->private);
> -	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
> -	       IS_ALIGNED(len, fs_info->sectorsize));
> -	ASSERT(page_offset(page) <= start &&
> -	       start + len <= page_offset(page) + PAGE_SIZE);
> +	btrfs_subpage_assert(fs_info, page, start, len);
> +
>  	/*
>  	 * Here nbits can be 16, thus can go beyond u16 range. Here we make the
>  	 * first left shift to be calculated in unsigned long (u32), then
> @@ -73,6 +83,31 @@ static inline u16 btrfs_subpage_calc_bitmap(struct btrfs_fs_info *fs_info,
>  	return (u16)(((1UL << nbits) - 1) << bit_start);
>  }
>  
> +static inline void btrfs_subpage_start_reader(struct btrfs_fs_info *fs_info,
> +					      struct page *page, u64 start,
> +					      u32 len)
> +{
> +	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
> +	int nbits = len >> fs_info->sectorsize_bits;
> +
> +	btrfs_subpage_assert(fs_info, page, start, len);
> +
> +	ASSERT(atomic_read(&subpage->readers) == 0);
> +	atomic_set(&subpage->readers, nbits);

To make this more explicit implement it via atomic_add_unless and assert
on the return value.

> +}
> +
> +static inline void btrfs_subpage_end_reader(struct btrfs_fs_info *fs_info,
> +			struct page *page, u64 start, u32 len)
> +{
> +	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
> +	int nbits = len >> fs_info->sectorsize_bits;
> +
> +	btrfs_subpage_assert(fs_info, page, start, len);
> +	ASSERT(atomic_read(&subpage->readers) >= nbits);
> +	if (atomic_sub_and_test(nbits, &subpage->readers))
> +		unlock_page(page);
> +}
> +
>  static inline void btrfs_subpage_set_tree_block(struct btrfs_fs_info *fs_info,
>  			struct page *page, u64 start, u32 len)
>  {
> 
