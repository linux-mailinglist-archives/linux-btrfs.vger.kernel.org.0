Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8289F2FC084
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jan 2021 21:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbhASUBj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jan 2021 15:01:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:42942 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728033AbhASTsg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jan 2021 14:48:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DF89CAF28;
        Tue, 19 Jan 2021 19:47:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 37FA6DA6E3; Tue, 19 Jan 2021 20:45:51 +0100 (CET)
Date:   Tue, 19 Jan 2021 20:45:51 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 08/18] btrfs: introduce helper for subpage uptodate
 status
Message-ID: <20210119194551.GQ6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210116071533.105780-1-wqu@suse.com>
 <20210116071533.105780-9-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210116071533.105780-9-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 16, 2021 at 03:15:23PM +0800, Qu Wenruo wrote:
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
>   Although caller should still ensure that the range is inside the page.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/subpage.h | 115 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 115 insertions(+)
> 
> diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
> index d8b34879368d..3373ef4ffec1 100644
> --- a/fs/btrfs/subpage.h
> +++ b/fs/btrfs/subpage.h
> @@ -23,6 +23,7 @@
>  struct btrfs_subpage {
>  	/* Common members for both data and metadata pages */
>  	spinlock_t lock;
> +	u16 uptodate_bitmap;
>  	union {
>  		/* Structures only used by metadata */
>  		bool under_alloc;
> @@ -78,4 +79,118 @@ static inline void btrfs_page_end_meta_alloc(struct btrfs_fs_info *fs_info,
>  int btrfs_attach_subpage(struct btrfs_fs_info *fs_info, struct page *page);
>  void btrfs_detach_subpage(struct btrfs_fs_info *fs_info, struct page *page);
>  
> +/*
> + * Convert the [start, start + len) range into a u16 bitmap
> + *
> + * E.g. if start == page_offset() + 16K, len = 16K, we get 0x00f0.
> + */
> +static inline u16 btrfs_subpage_calc_bitmap(struct btrfs_fs_info *fs_info,

All the API functions should use const for data that are only read,
fs_info in this case at least.

> +			struct page *page, u64 start, u32 len)
> +{
> +	int bit_start = offset_in_page(start) >> fs_info->sectorsize_bits;
> +	int nbits = len >> fs_info->sectorsize_bits;
> +
> +	/* Basic checks */
> +	ASSERT(PagePrivate(page) && page->private);
> +	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
> +	       IS_ALIGNED(len, fs_info->sectorsize));
> +
> +	/*
> +	 * The range check only works for mapped page, we can
> +	 * still have unampped page like dummy extent buffer pages.
> +	 */
> +	if (page->mapping)
> +		ASSERT(page_offset(page) <= start &&
> +			start + len <= page_offset(page) + PAGE_SIZE);
> +	/*
> +	 * Here nbits can be 16, thus can go beyond u16 range. Here we make the
> +	 * first left shift to be calculated in unsigned long (u32), then
> +	 * truncate the result to u16.
> +	 */
> +	return (u16)(((1UL << nbits) - 1) << bit_start);
> +}
> +
> +static inline void btrfs_subpage_set_uptodate(struct btrfs_fs_info *fs_info,
> +			struct page *page, u64 start, u32 len)
> +{
> +	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
> +	u16 tmp = btrfs_subpage_calc_bitmap(fs_info, page, start, len);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&subpage->lock, flags);
> +	subpage->uptodate_bitmap |= tmp;
> +	if (subpage->uptodate_bitmap == U16_MAX)
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
> +	subpage->uptodate_bitmap &= ~tmp;
> +	ClearPageUptodate(page);
> +	spin_unlock_irqrestore(&subpage->lock, flags);
> +}
> +
> +/*
> + * Unlike set/clear which is dependent on each page status, for test all bits
> + * are tested in the same way.
> + */
> +#define DECLARE_BTRFS_SUBPAGE_TEST_OP(name)				\
> +static inline bool btrfs_subpage_test_##name(struct btrfs_fs_info *fs_info, \
> +			struct page *page, u64 start, u32 len)		\
> +{									\
> +	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private; \
> +	u16 tmp = btrfs_subpage_calc_bitmap(fs_info, page, start, len); \
> +	unsigned long flags;						\
> +	bool ret;							\
> +									\
> +	spin_lock_irqsave(&subpage->lock, flags);			\
> +	ret = ((subpage->name##_bitmap & tmp) == tmp);			\
> +	spin_unlock_irqrestore(&subpage->lock, flags);			\
> +	return ret;							\
> +}
> +DECLARE_BTRFS_SUBPAGE_TEST_OP(uptodate);
> +
> +/*
> + * Note that, in selftest, especially extent-io-tests, we can have empty
> + * fs_info passed in.
> + * Thankfully in selftest, we only test sectorsize == PAGE_SIZE cases so far,
> + * thus we can fall back to regular sectorsize branch.
> + */
> +#define DECLARE_BTRFS_PAGE_OPS(name, set_page_func, clear_page_func,	\
> +			       test_page_func)				\
> +static inline void btrfs_page_set_##name(struct btrfs_fs_info *fs_info,	\
> +			struct page *page, u64 start, u32 len)		\
> +{									\
> +	if (unlikely(!fs_info) || fs_info->sectorsize == PAGE_SIZE) {	\
> +		set_page_func(page);					\
> +		return;							\
> +	}								\
> +	btrfs_subpage_set_##name(fs_info, page, start, len);		\
> +}									\
> +static inline void btrfs_page_clear_##name(struct btrfs_fs_info *fs_info, \
> +			struct page *page, u64 start, u32 len)		\
> +{									\
> +	if (unlikely(!fs_info) || fs_info->sectorsize == PAGE_SIZE) {	\
> +		clear_page_func(page);					\
> +		return;							\
> +	}								\
> +	btrfs_subpage_clear_##name(fs_info, page, start, len);		\
> +}									\
> +static inline bool btrfs_page_test_##name(struct btrfs_fs_info *fs_info, \
> +			struct page *page, u64 start, u32 len)		\
> +{									\
> +	if (unlikely(!fs_info) || fs_info->sectorsize == PAGE_SIZE)	\
> +		return test_page_func(page);				\
> +	return btrfs_subpage_test_##name(fs_info, page, start, len);	\
> +}
> +DECLARE_BTRFS_PAGE_OPS(uptodate, SetPageUptodate, ClearPageUptodate,
> +			PageUptodate);
> +
>  #endif /* BTRFS_SUBPAGE_H */
> -- 
> 2.30.0
