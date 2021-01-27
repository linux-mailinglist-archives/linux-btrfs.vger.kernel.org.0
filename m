Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B94873060EA
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 17:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237044AbhA0QWM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 11:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236278AbhA0QVw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 11:21:52 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920D6C06174A
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 08:21:11 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id a7so2203715qkb.13
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 08:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k/ypAYOCVCcpOQkPCDD0vDEi9fnLF/5lLhTgJyTveeY=;
        b=HqRtCQOECDXEyTxepyxb8ykfEl7DEW3zfmviPzNNZIjTLcl6O0L3s4/BmwIYo3XLMf
         HTEViXKJZTIEdogQ67ndmmSNLYYoP6iCPPRKb1Jn7ZyD+jHafBMhu5C+e4EtPwU5UK/U
         G6d3hJYhZDvhFOtCfFtJeULd6B3ThJ5ceYCW+WXNjV0AObC82dZcrsq5GJl9JZPHU5Uc
         0exZbam0yqUVmoiTta2y716s2P27Bm6S/Sr66Swyi0ofNOUT3ed1Eh+m0BN8pL64WF+L
         Lkc4nR6AtcfPSADXGrTragz5sqssegUUUSYTncPVcPcK66tDnXh8EIn0eFahGKtam917
         0bqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k/ypAYOCVCcpOQkPCDD0vDEi9fnLF/5lLhTgJyTveeY=;
        b=N8+V1M82s3rGPS+cg2uzVAzGwWO2NhSLA2IgT8YyiJebydepM0PlHLQx8Zs7dIJlmB
         KTMNBiy3awG8XcwsihySRR/nvaNumTIcXP/iKoljz8CVaSviXPYIagzOh9AjrhBFUEJR
         cwkqpJHAk7ZT5nra29Dbvyiy/n0aOkY4PBaV8BpXRPxC5IoEue2ofX1+zZTjuGs4Iee/
         gMiPj+igZgzjv8WEcj1kL4QWbrUkYcvuPjWEwLLi6tSQATXM5ZT9klCinfTjVUef6b6t
         1QNEABppVTyiuEUQB+bbvymFxisa3rZWFap7Axtqyczm8ilP8UXSx2T827WSe9zXKBim
         0QuA==
X-Gm-Message-State: AOAM533k8BmvE0k18GXt/B+baqtVb0Zzk2WkaB1e+RWZcwCzIVnJEf3M
        Bm2kr3trOw9hHoRkO5cbg2l9PTAm2SgMGlC0
X-Google-Smtp-Source: ABdhPJygD7sOlROMOBYqJaJ6THBSI8VSQ9/6TXgD9RHJ1CnArGceo3OUAdfhGHcan/8KhQ3ynVcRSQ==
X-Received: by 2002:a05:620a:898:: with SMTP id b24mr11177721qka.269.1611764470604;
        Wed, 27 Jan 2021 08:21:10 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u5sm1459525qkb.120.2021.01.27.08.21.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 08:21:09 -0800 (PST)
Subject: Re: [PATCH v5 06/18] btrfs: support subpage for extent buffer page
 release
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
References: <20210126083402.142577-1-wqu@suse.com>
 <20210126083402.142577-7-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <8522b133-9bdf-c130-1a3c-15114755c47a@toxicpanda.com>
Date:   Wed, 27 Jan 2021 11:21:08 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210126083402.142577-7-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/26/21 3:33 AM, Qu Wenruo wrote:
> In btrfs_release_extent_buffer_pages(), we need to add extra handling
> for subpage.
> 
> Introduce a helper, detach_extent_buffer_page(), to do different
> handling for regular and subpage cases.
> 
> For subpage case, handle detaching page private.
> 
> For unmapped (dummy or cloned) ebs, we can detach the page private
> immediately as the page can only be attached to one unmapped eb.
> 
> For mapped ebs, we have to ensure there are no eb in the page range
> before we delete it, as page->private is shared between all ebs in the
> same page.
> 
> But there is a subpage specific race, where we can race with extent
> buffer allocation, and clear the page private while new eb is still
> being utilized, like this:
> 
>    Extent buffer A is the new extent buffer which will be allocated,
>    while extent buffer B is the last existing extent buffer of the page.
> 
>    		T1 (eb A) 	 |		T2 (eb B)
>    -------------------------------+------------------------------
>    alloc_extent_buffer()		 | btrfs_release_extent_buffer_pages()
>    |- p = find_or_create_page()   | |
>    |- attach_extent_buffer_page() | |
>    |				 | |- detach_extent_buffer_page()
>    |				 |    |- if (!page_range_has_eb())
>    |				 |    |  No new eb in the page range yet
>    |				 |    |  As new eb A hasn't yet been
>    |				 |    |  inserted into radix tree.
>    |				 |    |- btrfs_detach_subpage()
>    |				 |       |- detach_page_private();
>    |- radix_tree_insert()	 |
> 
>    Then we have a metadata eb whose page has no private bit.
> 
> To avoid such race, we introduce a subpage metadata-specific member,
> btrfs_subpage::eb_refs.
> 
> In alloc_extent_buffer() we increase eb_refs in the critical section of
> private_lock.  Then page_range_has_eb() will return true for
> detach_extent_buffer_page(), and will not detach page private.
> 
> The section is marked by:
> 
> - btrfs_page_inc_eb_refs()
> - btrfs_page_dec_eb_refs()
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: David Sterba <dsterba@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/extent_io.c | 94 +++++++++++++++++++++++++++++++++++++-------
>   fs/btrfs/subpage.c   | 42 ++++++++++++++++++++
>   fs/btrfs/subpage.h   | 13 +++++-
>   3 files changed, 133 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 16a29f63cfd1..118874926179 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -4993,25 +4993,39 @@ int extent_buffer_under_io(const struct extent_buffer *eb)
>   		test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
>   }
>   
> -/*
> - * Release all pages attached to the extent buffer.
> - */
> -static void btrfs_release_extent_buffer_pages(struct extent_buffer *eb)
> +static bool page_range_has_eb(struct btrfs_fs_info *fs_info, struct page *page)
>   {
> -	int i;
> -	int num_pages;
> -	int mapped = !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
> +	struct btrfs_subpage *subpage;
>   
> -	BUG_ON(extent_buffer_under_io(eb));
> +	lockdep_assert_held(&page->mapping->private_lock);
>   
> -	num_pages = num_extent_pages(eb);
> -	for (i = 0; i < num_pages; i++) {
> -		struct page *page = eb->pages[i];
> +	if (PagePrivate(page)) {
> +		subpage = (struct btrfs_subpage *)page->private;
> +		if (atomic_read(&subpage->eb_refs))
> +			return true;
> +	}
> +	return false;
> +}
>   
> -		if (!page)
> -			continue;
> +static void detach_extent_buffer_page(struct extent_buffer *eb, struct page *page)
> +{
> +	struct btrfs_fs_info *fs_info = eb->fs_info;
> +	const bool mapped = !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
> +
> +	/*
> +	 * For mapped eb, we're going to change the page private, which should
> +	 * be done under the private_lock.
> +	 */
> +	if (mapped)
> +		spin_lock(&page->mapping->private_lock);
> +
> +	if (!PagePrivate(page)) {
>   		if (mapped)
> -			spin_lock(&page->mapping->private_lock);
> +			spin_unlock(&page->mapping->private_lock);
> +		return;
> +	}
> +
> +	if (fs_info->sectorsize == PAGE_SIZE) {
>   		/*
>   		 * We do this since we'll remove the pages after we've
>   		 * removed the eb from the radix tree, so we could race
> @@ -5030,9 +5044,49 @@ static void btrfs_release_extent_buffer_pages(struct extent_buffer *eb)
>   			 */
>   			detach_page_private(page);
>   		}
> -
>   		if (mapped)
>   			spin_unlock(&page->mapping->private_lock);
> +		return;
> +	}
> +
> +	/*
> +	 * For subpage, we can have dummy eb with page private.  In this case,
> +	 * we can directly detach the private as such page is only attached to
> +	 * one dummy eb, no sharing.
> +	 */
> +	if (!mapped) {
> +		btrfs_detach_subpage(fs_info, page);
> +		return;
> +	}
> +
> +	btrfs_page_dec_eb_refs(fs_info, page);
> +
> +	/*
> +	 * We can only detach the page private if there are no other ebs in the
> +	 * page range.
> +	 */
> +	if (!page_range_has_eb(fs_info, page))
> +		btrfs_detach_subpage(fs_info, page);
> +
> +	spin_unlock(&page->mapping->private_lock);
> +}
> +
> +/* Release all pages attached to the extent buffer */
> +static void btrfs_release_extent_buffer_pages(struct extent_buffer *eb)
> +{
> +	int i;
> +	int num_pages;
> +
> +	ASSERT(!extent_buffer_under_io(eb));
> +
> +	num_pages = num_extent_pages(eb);
> +	for (i = 0; i < num_pages; i++) {
> +		struct page *page = eb->pages[i];
> +
> +		if (!page)
> +			continue;
> +
> +		detach_extent_buffer_page(eb, page);
>   
>   		/* One for when we allocated the page */
>   		put_page(page);
> @@ -5392,6 +5446,16 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
>   		/* Should not fail, as we have preallocated the memory */
>   		ret = attach_extent_buffer_page(eb, p, prealloc);
>   		ASSERT(!ret);
> +		/*
> +		 * To inform we have extra eb under allocation, so that
> +		 * detach_extent_buffer_page() won't release the page private
> +		 * when the eb hasn't yet been inserted into radix tree.
> +		 *
> +		 * The ref will be decreased when the eb released the page, in
> +		 * detach_extent_buffer_page().
> +		 * Thus needs no special handling in error path.
> +		 */
> +		btrfs_page_inc_eb_refs(fs_info, p);
>   		spin_unlock(&mapping->private_lock);
>   
>   		WARN_ON(PageDirty(p));
> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> index 61b28dfca20c..a2a21fa0ea35 100644
> --- a/fs/btrfs/subpage.c
> +++ b/fs/btrfs/subpage.c
> @@ -52,6 +52,8 @@ int btrfs_alloc_subpage(const struct btrfs_fs_info *fs_info,
>   	if (!*ret)
>   		return -ENOMEM;
>   	spin_lock_init(&(*ret)->lock);
> +	if (type == BTRFS_SUBPAGE_METADATA)
> +		atomic_set(&(*ret)->eb_refs, 0);
>   	return 0;
>   }
>   
> @@ -59,3 +61,43 @@ void btrfs_free_subpage(struct btrfs_subpage *subpage)
>   {
>   	kfree(subpage);
>   }
> +
> +/*
> + * Increase the eb_refs of current subpage.
> + *
> + * This is important for eb allocation, to prevent race with last eb freeing
> + * of the same page.
> + * With the eb_refs increased before the eb inserted into radix tree,
> + * detach_extent_buffer_page() won't detach the page private while we're still
> + * allocating the extent buffer.
> + */
> +void btrfs_page_inc_eb_refs(const struct btrfs_fs_info *fs_info,
> +			    struct page *page)
> +{
> +	struct btrfs_subpage *subpage;
> +
> +	if (fs_info->sectorsize == PAGE_SIZE)
> +		return;
> +
> +	ASSERT(PagePrivate(page) && page->mapping);
> +	lockdep_assert_held(&page->mapping->private_lock);
> +
> +	subpage = (struct btrfs_subpage *)page->private;
> +	atomic_inc(&subpage->eb_refs);
> +}
> +
> +void btrfs_page_dec_eb_refs(const struct btrfs_fs_info *fs_info,
> +			    struct page *page)
> +{
> +	struct btrfs_subpage *subpage;
> +
> +	if (fs_info->sectorsize == PAGE_SIZE)
> +		return;
> +
> +	ASSERT(PagePrivate(page) && page->mapping);
> +	lockdep_assert_held(&page->mapping->private_lock);
> +
> +	subpage = (struct btrfs_subpage *)page->private;
> +	ASSERT(atomic_read(&subpage->eb_refs));
> +	atomic_dec(&subpage->eb_refs);
> +}
> diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
> index 7ba544bcc9c6..eef2ecae77e0 100644
> --- a/fs/btrfs/subpage.h
> +++ b/fs/btrfs/subpage.h
> @@ -4,6 +4,7 @@
>   #define BTRFS_SUBPAGE_H
>   
>   #include <linux/spinlock.h>
> +#include <linux/refcount.h>

I made this comment elsewhere, but the patch finally showed up in my email after 
I refreshed (???? thunderbird wtf??).  Anyway you import refcount.h here, but 
don't actually use refcount_t.  Please use refcount_t, so we get the benefit of 
the debugging from the helpers.  Thanks,

Josef
