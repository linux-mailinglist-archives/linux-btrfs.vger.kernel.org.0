Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A442D739B
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Dec 2020 11:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388456AbgLKKLo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Dec 2020 05:11:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:33548 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393698AbgLKKLd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Dec 2020 05:11:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607681446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=cjd7HE0AVxWz0+/DmcACKeZcXWvkcxya7NTHuVe5YZM=;
        b=rICY/nR4ZnYqMV+RTjcZXPoR4z0TDdw6p3MN6ZhFzqS2QJDQ4YPyRosLDGu4srSGbv2D1M
        oKcyxd4umMJ3SJMbJbIHa45QJoqYnWDAqQJEYWvRgnSGF0WZuRStz5yIRS204Pkq19KNsO
        51pmpxDkLKWO/abH2Ln8Ug3aWh7Q0iw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6D8B0AC10;
        Fri, 11 Dec 2020 10:10:46 +0000 (UTC)
Subject: Re: [PATCH v2 09/18] btrfs: subpage: introduce helper for subpage
 uptodate status
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201210063905.75727-1-wqu@suse.com>
 <20201210063905.75727-10-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <40aaa304-cf64-806f-e2d0-8bb02b32abdf@suse.com>
Date:   Fri, 11 Dec 2020 12:10:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201210063905.75727-10-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10.12.20 г. 8:38 ч., Qu Wenruo wrote:
> This patch introduce the following functions to handle btrfs subpage
> uptodate status:
> - btrfs_subpage_set_uptodate()
> - btrfs_subpage_clear_uptodate()
> - btrfs_subpage_test_uptodate()
>   Those helpers can only be called when the range is ensured to be
>   inside the page.
> 
> - btrfs_page_set_uptodate()
> - btrfs_page_clear_uptodate()
> - btrfs_page_test_uptodate()
>   Those helpers can handle both regular sector size and subpage without
>   problem.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/subpage.h | 98 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
> 
> diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
> index 87b4e028ae18..b3cf9171ec98 100644
> --- a/fs/btrfs/subpage.h
> +++ b/fs/btrfs/subpage.h
> @@ -23,6 +23,7 @@
>  struct btrfs_subpage {
>  	/* Common members for both data and metadata pages */
>  	spinlock_t lock;
> +	u16 uptodate_bitmap;
>  	union {
>  		/* Structures only used by metadata */
>  		struct {
> @@ -35,6 +36,17 @@ struct btrfs_subpage {
>  int btrfs_attach_subpage(struct btrfs_fs_info *fs_info, struct page *page);
>  void btrfs_detach_subpage(struct btrfs_fs_info *fs_info, struct page *page);
>  
> +static inline void btrfs_subpage_clamp_range(struct page *page,
> +					     u64 *start, u32 *len)
> +{
> +	u64 orig_start = *start;
> +	u32 orig_len = *len;
> +
> +	*start = max_t(u64, page_offset(page), orig_start);
> +	*len = min_t(u64, page_offset(page) + PAGE_SIZE,
> +		     orig_start + orig_len) - *start;
> +}

This handles EB's which span pages, right? If so - a comment is in order
since there is no design document specifying whether eb can or cannot
span multiple pages.

> +
>  /*
>   * Convert the [start, start + len) range into a u16 bitmap
>   *
> @@ -96,4 +108,90 @@ static inline bool btrfs_subpage_clear_and_test_tree_block(
>  	return last;
>  }
>  
> +static inline void btrfs_subpage_set_uptodate(struct btrfs_fs_info *fs_info,
> +			struct page *page, u64 start, u32 len)
> +{
> +	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
> +	u16 tmp = btrfs_subpage_calc_bitmap(fs_info, page, start, len);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&subpage->lock, flags);
> +	subpage->uptodate_bitmap |= tmp;
> +	if (subpage->uptodate_bitmap == (u16)-1)

just use U16_MAX instead of (u16)-1.

> +		SetPageUptodate(page);
> +	spin_unlock_irqrestore(&subpage->lock, flags);
> +}
> +
> +static inline void btrfs_subpage_clear_uptodate(struct btrfs_fs_info *fs_info,
> +			struct page *page, u64 start, u32 len)
> +{
> +	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
> +	u16 tmp = btrfs_subpage_calc_bitmap(fs_info, page, start, len);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&subpage->lock, flags);
> +	subpage->tree_block_bitmap &= ~tmp;

I  guess you meant to clear uptodate_bitmap and not tree_block_bitmap ?

> +	ClearPageUptodate(page);
> +	spin_unlock_irqrestore(&subpage->lock, flags);
> +}
> +

<snip>

> +DECLARE_BTRFS_SUBPAGE_TEST_OP(uptodate);
> +
> +/*
> + * Note that, in selftest, especially extent-io-tests, we can have empty
> + * fs_info passed in.
> + * Thanfully in selftest, we only test sectorsize == PAGE_SIZE cases so far

nit:s/Thankfully/Thankfully

> + * thus we can fall back to regular sectorsize branch.
> + */

<snip>

> 
