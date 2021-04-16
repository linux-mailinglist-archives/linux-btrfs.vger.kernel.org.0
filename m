Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C798F362338
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Apr 2021 16:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236004AbhDPO7N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 10:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240740AbhDPO7M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 10:59:12 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089F7C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 07:58:47 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id c123so24256406qke.1
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 07:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=YIcnSinjj1JM/13a8k8wrmCwKkbUvMUBmBcdszUea8U=;
        b=QuvVqg51AVgLyZSGIz+NwCgEVANEQxv5+GitHaLsW9MjCz3fXCKbyi3Z0L+O0tdspD
         etcasA/pVPEVELsc3DKgKsKKDEI0qykpMCFnJFeSqsoRTCEHl/WKx/Bhr3+qw6BGQM20
         73ivgGIg5pO5SRk3VuqPFowGzRONxK0g72T6QRsCgx4Augsg67LQ+189fxaaxVii9PBL
         L1sVRq1K5NaMyFUGIXzVC+iOKg1rW5zZ41y2pYRtg+vzvdXNQ2mIu0GLHCT18wtwFhiX
         3be9DWKV5/wF3zIaI6xA+PQ/sCgD5DtXamRXnMizytQaWENVgMLJ6YE2Q0GHANOPd58F
         TzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YIcnSinjj1JM/13a8k8wrmCwKkbUvMUBmBcdszUea8U=;
        b=oLCgRN9WTB/LXlM8qYqv67bayWjil3VPfIOd2P6qM9Z2Kyw6S/83L/Y8fYqLMJ69XT
         f8HwANyucLq6hYJkSNoKjiaEHJHC33b4pJRRFLhNBwkVXjQ42rpBeOIeCIkl0FqCI7ZM
         +z+XgSro9crjengBIUDBM4fgZJJ/RHOPtAyNS22mkSpbQMDFFsM/CkdbERWt6FRsS710
         srNh1lGU6EAlOGxkxOP8KsI8h+U/ap9zFtdbzwq3WDeBRnenmuYWdcv2nruSVyosOTkp
         Nm55SzSOacMU4H5hkGi1s/1lUdTpJAWSMNvB+rGPm/o6PAxV99GPpPwaLBuX2qLgBwHl
         8bLw==
X-Gm-Message-State: AOAM531GizioklA+KNGODkxi9vMmKAsahJ7L9dcG+D6kJvdUmp8rwg3g
        eJWsdGIuiDU8bGmN90KzY/oC1azhsqA6Dg==
X-Google-Smtp-Source: ABdhPJzO6bOrFVfcFBvU2CEgYQK6+gBDoMqBeZiqEfnCMzm2o8ETebNjFuQjH0FSBKg1FN2DwjZJzQ==
X-Received: by 2002:a37:b704:: with SMTP id h4mr9491524qkf.177.1618585125867;
        Fri, 16 Apr 2021 07:58:45 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q6sm4330798qkj.50.2021.04.16.07.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 07:58:45 -0700 (PDT)
Subject: Re: [PATCH 14/42] btrfs: pass bytenr directly to
 __process_pages_contig()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210415050448.267306-1-wqu@suse.com>
 <20210415050448.267306-15-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <8d57a798-01ff-5149-f0fc-42bbeb466999@toxicpanda.com>
Date:   Fri, 16 Apr 2021 10:58:44 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210415050448.267306-15-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/15/21 1:04 AM, Qu Wenruo wrote:
> As a preparation for incoming subpage support, we need bytenr passed to
> __process_pages_contig() directly, not the current page index.
> 
> So change the parameter and all callers to pass bytenr in.
> 
> With the modification, here we need to replace the old @index_ret with
> @processed_end for __process_pages_contig(), but this brings a small
> problem.
> 
> Normally we follow the inclusive return value, meaning @processed_end
> should be the last byte we processed.
> 
> If parameter @start is 0, and we failed to lock any page, then we would
> return @processed_end as -1, causing more problems for
> __unlock_for_delalloc().
> 
> So here for @processed_end, we use two different return value patterns.
> If we have locked any page, @processed_end will be the last byte of
> locked page.
> Or it will be @start otherwise.
> 
> This change will impact lock_delalloc_pages(), so it needs to check
> @processed_end to only unlock the range if we have locked any.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/extent_io.c | 57 ++++++++++++++++++++++++++++----------------
>   1 file changed, 37 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index ac01f29b00c9..ff24db8513b4 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1807,8 +1807,8 @@ bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
>   
>   static int __process_pages_contig(struct address_space *mapping,
>   				  struct page *locked_page,
> -				  pgoff_t start_index, pgoff_t end_index,
> -				  unsigned long page_ops, pgoff_t *index_ret);
> +				  u64 start, u64 end, unsigned long page_ops,
> +				  u64 *processed_end);
>   
>   static noinline void __unlock_for_delalloc(struct inode *inode,
>   					   struct page *locked_page,
> @@ -1821,7 +1821,7 @@ static noinline void __unlock_for_delalloc(struct inode *inode,
>   	if (index == locked_page->index && end_index == index)
>   		return;
>   
> -	__process_pages_contig(inode->i_mapping, locked_page, index, end_index,
> +	__process_pages_contig(inode->i_mapping, locked_page, start, end,
>   			       PAGE_UNLOCK, NULL);
>   }
>   
> @@ -1831,19 +1831,19 @@ static noinline int lock_delalloc_pages(struct inode *inode,
>   					u64 delalloc_end)
>   {
>   	unsigned long index = delalloc_start >> PAGE_SHIFT;
> -	unsigned long index_ret = index;
>   	unsigned long end_index = delalloc_end >> PAGE_SHIFT;
> +	u64 processed_end = delalloc_start;
>   	int ret;
>   
>   	ASSERT(locked_page);
>   	if (index == locked_page->index && index == end_index)
>   		return 0;
>   
> -	ret = __process_pages_contig(inode->i_mapping, locked_page, index,
> -				     end_index, PAGE_LOCK, &index_ret);
> -	if (ret == -EAGAIN)
> +	ret = __process_pages_contig(inode->i_mapping, locked_page, delalloc_start,
> +				     delalloc_end, PAGE_LOCK, &processed_end);
> +	if (ret == -EAGAIN && processed_end > delalloc_start)
>   		__unlock_for_delalloc(inode, locked_page, delalloc_start,
> -				      (u64)index_ret << PAGE_SHIFT);
> +				      processed_end);
>   	return ret;
>   }
>   
> @@ -1938,12 +1938,14 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
>   
>   static int __process_pages_contig(struct address_space *mapping,
>   				  struct page *locked_page,
> -				  pgoff_t start_index, pgoff_t end_index,
> -				  unsigned long page_ops, pgoff_t *index_ret)
> +				  u64 start, u64 end, unsigned long page_ops,
> +				  u64 *processed_end)
>   {
> +	pgoff_t start_index = start >> PAGE_SHIFT;
> +	pgoff_t end_index = end >> PAGE_SHIFT;
> +	pgoff_t index = start_index;
>   	unsigned long nr_pages = end_index - start_index + 1;
>   	unsigned long pages_processed = 0;
> -	pgoff_t index = start_index;
>   	struct page *pages[16];
>   	unsigned ret;
>   	int err = 0;
> @@ -1951,17 +1953,19 @@ static int __process_pages_contig(struct address_space *mapping,
>   
>   	if (page_ops & PAGE_LOCK) {
>   		ASSERT(page_ops == PAGE_LOCK);
> -		ASSERT(index_ret && *index_ret == start_index);
> +		ASSERT(processed_end && *processed_end == start);
>   	}
>   
>   	if ((page_ops & PAGE_SET_ERROR) && nr_pages > 0)
>   		mapping_set_error(mapping, -EIO);
>   
>   	while (nr_pages > 0) {
> -		ret = find_get_pages_contig(mapping, index,
> +		int found_pages;
> +
> +		found_pages = find_get_pages_contig(mapping, index,
>   				     min_t(unsigned long,
>   				     nr_pages, ARRAY_SIZE(pages)), pages);
> -		if (ret == 0) {
> +		if (found_pages == 0) {
>   			/*
>   			 * Only if we're going to lock these pages,
>   			 * can we find nothing at @index.
> @@ -2004,13 +2008,27 @@ static int __process_pages_contig(struct address_space *mapping,
>   			put_page(pages[i]);
>   			pages_processed++;
>   		}
> -		nr_pages -= ret;
> -		index += ret;
> +		nr_pages -= found_pages;
> +		index += found_pages;
>   		cond_resched();
>   	}
>   out:
> -	if (err && index_ret)
> -		*index_ret = start_index + pages_processed - 1;
> +	if (err && processed_end) {
> +		/*
> +		 * Update @processed_end. I know this is awful since it has
> +		 * two different return value patterns (inclusive vs exclusive).
> +		 *
> +		 * But the exclusive pattern is necessary if @start is 0, or we
> +		 * underflow and check against processed_end won't work as
> +		 * expected.
> +		 */
> +		if (pages_processed)
> +			*processed_end = min(end,
> +			((u64)(start_index + pages_processed) << PAGE_SHIFT) - 1);
> +		else
> +			*processed_end = start;

This shouldn't happen, as the first page should always be locked, and thus 
pages_processed is always going to be at least 1.  Or am I missing something 
here?  Thanks,

Josef
