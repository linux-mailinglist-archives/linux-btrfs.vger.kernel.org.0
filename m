Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C412D5FC2
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Dec 2020 16:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391741AbgLJPbv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Dec 2020 10:31:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:39742 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391522AbgLJPbp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Dec 2020 10:31:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607614257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=iyT/l/dvPDTK1LNLBdGqE3BDfYLlcgZHpAp8d3ypON0=;
        b=phflGSjB8DojHX5W5yoOvqAIORykKmg1bHGc2Df7xRo21mVG+CvfwJ1+lhNkJzQr2uPuyp
        won/BhUFu9t+Lq9SG6cy3XKCxh3z327uT/ivmsAXYxfEHqX2w3EZsS2HOCZUwtpIpZHYHl
        srR75Jv5gSlqwAp6/n8ejMMW6WAR2q0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B6770AC6A;
        Thu, 10 Dec 2020 15:30:57 +0000 (UTC)
Subject: Re: [PATCH v2 06/18] btrfs: extent_io: make
 attach_extent_buffer_page() to handle subpage case
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201210063905.75727-1-wqu@suse.com>
 <20201210063905.75727-7-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <4dd63414-5e74-77d1-723b-6fb61ffca5fb@suse.com>
Date:   Thu, 10 Dec 2020 17:30:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201210063905.75727-7-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10.12.20 г. 8:38 ч., Qu Wenruo wrote:
> For subpage case, we need to allocate new memory for each metadata page.
> 
> So we need to:
> - Allow attach_extent_buffer_page() to return int
>   To indicate allocation failure
> 
> - Prealloc page->private for alloc_extent_buffer()
>   We don't want to call memory allocation with spinlock hold, so
>   do preallocation before we acquire the spin lock.
> 
> - Handle subpage and regular case differently in
>   attach_extent_buffer_page()
>   For regular case, just do the usual thing.
>   For subpage case, allocate new memory and update the tree_block
>   bitmap.
> 
>   The bitmap update will be handled by new subpage specific helper,
>   btrfs_subpage_set_tree_block().
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c | 69 +++++++++++++++++++++++++++++++++++---------
>  fs/btrfs/subpage.h   | 44 ++++++++++++++++++++++++++++
>  2 files changed, 99 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 6350c2687c7e..51dd7ec3c2b3 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -24,6 +24,7 @@
>  #include "rcu-string.h"
>  #include "backref.h"
>  #include "disk-io.h"
> +#include "subpage.h"
>  
>  static struct kmem_cache *extent_state_cache;
>  static struct kmem_cache *extent_buffer_cache;
> @@ -3142,22 +3143,41 @@ static int submit_extent_page(unsigned int opf,
>  	return ret;
>  }
>  
> -static void attach_extent_buffer_page(struct extent_buffer *eb,
> +static int attach_extent_buffer_page(struct extent_buffer *eb,
>  				      struct page *page)
>  {
> -	/*
> -	 * If the page is mapped to btree inode, we should hold the private
> -	 * lock to prevent race.
> -	 * For cloned or dummy extent buffers, their pages are not mapped and
> -	 * will not race with any other ebs.
> -	 */
> -	if (page->mapping)
> -		lockdep_assert_held(&page->mapping->private_lock);
> +	struct btrfs_fs_info *fs_info = eb->fs_info;
> +	int ret;
>  
> -	if (!PagePrivate(page))
> -		attach_page_private(page, eb);
> -	else
> -		WARN_ON(page->private != (unsigned long)eb);
> +	if (fs_info->sectorsize == PAGE_SIZE) {
> +		/*
> +		 * If the page is mapped to btree inode, we should hold the
> +		 * private lock to prevent race.
> +		 * For cloned or dummy extent buffers, their pages are not
> +		 * mapped and will not race with any other ebs.
> +		 */
> +		if (page->mapping)
> +			lockdep_assert_held(&page->mapping->private_lock);
> +
> +		if (!PagePrivate(page))
> +			attach_page_private(page, eb);
> +		else
> +			WARN_ON(page->private != (unsigned long)eb);
> +		return 0;
> +	}
> +
> +	/* Already mapped, just update the existing range */
> +	if (PagePrivate(page))
> +		goto update_bitmap;

How can this check ever be false, given btrfs_attach_subpage is called
unconditionally  in alloc_extent_buffer so that you can avoid allocating
memory with private lock held, yet in this function you check if memory
hasn't been allocated and you proceed to do it? Also that memory
allocation is done with GFP_NOFS under a spinlock, that's not atomic i.e
IO can still be kicked which means you can go to sleep while holding a
spinlock, not cool.

> +
> +	/* Do new allocation to attach subpage */
> +	ret = btrfs_attach_subpage(fs_info, page);
> +	if (ret < 0)
> +		return ret;
> +
> +update_bitmap:
> +	btrfs_subpage_set_tree_block(fs_info, page, eb->start, eb->len);
> +	return 0;

Those are really 2 functions, demarcated by the if. Given that
attach_extent_buffer is called in only 2 places, can't you opencode the
if (fs_info->sectorize) check in the callers and define 2 functions:

1 for subpage blocksize and the other one for the old code?

>  }
>  

<snip>

> diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
> index 96f3b226913e..c2ce603e7848 100644
> --- a/fs/btrfs/subpage.h
> +++ b/fs/btrfs/subpage.h
> @@ -23,9 +23,53 @@
>  struct btrfs_subpage {
>  	/* Common members for both data and metadata pages */
>  	spinlock_t lock;
> +	union {
> +		/* Structures only used by metadata */
> +		struct {
> +			u16 tree_block_bitmap;
> +		};
> +		/* structures only used by data */
> +	};
>  };
>  
>  int btrfs_attach_subpage(struct btrfs_fs_info *fs_info, struct page *page);
>  void btrfs_detach_subpage(struct btrfs_fs_info *fs_info, struct page *page);
>  
> +/*
> + * Convert the [start, start + len) range into a u16 bitmap
> + *
> + * E.g. if start == page_offset() + 16K, len = 16K, we get 0x00f0.
> + */
> +static inline u16 btrfs_subpage_calc_bitmap(struct btrfs_fs_info *fs_info,
> +			struct page *page, u64 start, u32 len)
> +{
> +	int bit_start = (start - page_offset(page)) >> fs_info->sectorsize_bits;
> +	int nbits = len >> fs_info->sectorsize_bits;
> +
> +	/* Basic checks */
> +	ASSERT(PagePrivate(page) && page->private);
> +	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
> +	       IS_ALIGNED(len, fs_info->sectorsize));

Separate aligns so if they feel it's evident which one failed.

> +	ASSERT(page_offset(page) <= start &&
> +	       start + len <= page_offset(page) + PAGE_SIZE);

ditto. Also instead of checking 'page_offset(page) <= start' you can
simply check 'bit_start is >= 0' as that's what you ultimately care about.

> +	/*
> +	 * Here nbits can be 16, thus can go beyond u16 range. Here we make the
> +	 * first left shift to be calculated in unsigned long (u32), then
> +	 * truncate the result to u16.
> +	 */
> +	return (u16)(((1UL << nbits) - 1) << bit_start);
> +}
> +
> +static inline void btrfs_subpage_set_tree_block(struct btrfs_fs_info *fs_info,
> +			struct page *page, u64 start, u32 len)
> +{
> +	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
> +	unsigned long flags;
> +	u16 tmp = btrfs_subpage_calc_bitmap(fs_info, page, start, len);
> +
> +	spin_lock_irqsave(&subpage->lock, flags);
> +	subpage->tree_block_bitmap |= tmp;
> +	spin_unlock_irqrestore(&subpage->lock, flags);
> +}
> +
>  #endif /* BTRFS_SUBPAGE_H */
> 

