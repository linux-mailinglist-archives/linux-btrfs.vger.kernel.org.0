Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486822FD38B
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jan 2021 16:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388895AbhATPJq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jan 2021 10:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390578AbhATPB7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jan 2021 10:01:59 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E66BC061794
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jan 2021 07:00:26 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id t17so8182260qtq.2
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jan 2021 07:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=B5yDoRHE3ZHIkUcHtw51v4fl18XXKt02O1aY2pSkTrI=;
        b=FyKfpqQoiuRIdVngM0D72K+Rwkd1gGqDCoGATPd4czYbn8DOlMXl64VVvodOOM7O4E
         tUuXje2HxwCec9cFxgFF1/sjgqiroDfLFRpW9q89SItV/Sk+bV2aaX0iTMrU4ghn6G0M
         vhBCR1gbMf2+Ga2qGoZqeKWq/1CD7mhW4KgDuip5Ycr0EhHlLT8U6KkqlZQ6IH2z0D46
         JRvO5ddF46s1IYgdFxsFk+5C7P8wLj165hOHKsrzf477fp9wTEt7yEKulnPO08H7YxAR
         UJy/iwyPGZmkqHOwVtTTELmP5RetnbMOsB5UDqpXlS/Peq+aW5PLVAXYe47/oMyOeuIl
         12cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B5yDoRHE3ZHIkUcHtw51v4fl18XXKt02O1aY2pSkTrI=;
        b=RhcYPnDmE7s0u7T1yop14vlk4b1O1ofKTsWPxJnaQ4kiTPSDzpY3gksOgwOTSz2JKm
         HSgQPAeniYJcEC4GqkK5kzLWWs3KSnxHGJLa18yxqpFosQdnko8c/X7d94ofuO7HrsFN
         AnkhJo/cuC9OO+JU9aVKmSXfCEvaJ4nGlAEfy1uPa8jqiflHOqt+VfVYtk05qWpnuetK
         ivRrohdzDknIDJBVJeAlv49I9GmSbXW3gbWlVpmJEfwPxKoRsyTI7NYXykwqkVSsIMMc
         Bxi6u8vDL1w+Z1MfVphahnKovwd2wpho6XpHeoF6y5AjS0QHDW99MD54GF2TMyr00FTS
         eIxQ==
X-Gm-Message-State: AOAM533T68qgjMV0Ed5KRJJBIhRm42WdvDa4JU+LcdkcoJdcCo+G7UYZ
        a0Zph2Jmkuzjf1MZ3ZhE3fD2tJGpNyhluaGEo74=
X-Google-Smtp-Source: ABdhPJxl9Cj1aPbUO5Qjkc+GbEyinSmUZ97Wz4qL3efUMxmF0eruCtEAKs1KuaCW+L69ZW422z1Frg==
X-Received: by 2002:ac8:6edd:: with SMTP id f29mr9174833qtv.213.1611154824896;
        Wed, 20 Jan 2021 07:00:24 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m64sm1465788qkb.90.2021.01.20.07.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 07:00:24 -0800 (PST)
Subject: Re: [PATCH v4 08/18] btrfs: introduce helper for subpage uptodate
 status
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210116071533.105780-1-wqu@suse.com>
 <20210116071533.105780-9-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <812a4f48-3210-926f-cf59-de63bfcc4c0d@toxicpanda.com>
Date:   Wed, 20 Jan 2021 10:00:23 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210116071533.105780-9-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/16/21 2:15 AM, Qu Wenruo wrote:
> This patch introduce the following functions to handle btrfs subpage
> uptodate status:
> - btrfs_subpage_set_uptodate()
> - btrfs_subpage_clear_uptodate()
> - btrfs_subpage_test_uptodate()
>    Those helpers can only be called when the range is ensured to be
>    inside the page.
> 
> - btrfs_page_set_uptodate()
> - btrfs_page_clear_uptodate()
> - btrfs_page_test_uptodate()
>    Those helpers can handle both regular sector size and subpage without
>    problem.
>    Although caller should still ensure that the range is inside the page.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/subpage.h | 115 +++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 115 insertions(+)
> 
> diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
> index d8b34879368d..3373ef4ffec1 100644
> --- a/fs/btrfs/subpage.h
> +++ b/fs/btrfs/subpage.h
> @@ -23,6 +23,7 @@
>   struct btrfs_subpage {
>   	/* Common members for both data and metadata pages */
>   	spinlock_t lock;
> +	u16 uptodate_bitmap;
>   	union {
>   		/* Structures only used by metadata */
>   		bool under_alloc;
> @@ -78,4 +79,118 @@ static inline void btrfs_page_end_meta_alloc(struct btrfs_fs_info *fs_info,
>   int btrfs_attach_subpage(struct btrfs_fs_info *fs_info, struct page *page);
>   void btrfs_detach_subpage(struct btrfs_fs_info *fs_info, struct page *page);
>   
> +/*
> + * Convert the [start, start + len) range into a u16 bitmap
> + *
> + * E.g. if start == page_offset() + 16K, len = 16K, we get 0x00f0.
> + */
> +static inline u16 btrfs_subpage_calc_bitmap(struct btrfs_fs_info *fs_info,
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

Another thing I just realized is you're doing this

btrfs_page_set_uptodate(fs_info, page, eb->start, eb->len);

but we default to a nodesize > PAGE_SIZE on x86.  This is fine, because you're 
checking fs_info->sectorsize == PAGE_SIZE, which will mean we do the right thing.

But what happens if fs_info->nodesize < PAGE_SIZE && fs_info->sectorsize == 
PAGE_SIZE?  We by default have fs'es that ->nodesize != ->sectorsize, so really 
what we should be doing is checking if len == PAGE_SIZE here, but then you need 
to take into account the case that eb->len > PAGE_SIZE.  Fix this to do the 
right thing in either of those cases.  Thanks,

Josef
