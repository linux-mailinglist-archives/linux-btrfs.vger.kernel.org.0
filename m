Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE412DD4BF
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 17:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgLQQB3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Dec 2020 11:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgLQQB3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Dec 2020 11:01:29 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B073BC061794
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 08:00:48 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id g24so7996495qtq.12
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 08:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Dn0fVpigPAa+zeetK6wMzxheWbKBPFBGXzw6JN+hfdQ=;
        b=WvGUUHW2Iq+UkVQkpN/9KphzOgiO8rNK3xR+JtQ1F+44GztJdXC+T1qMwWdVJRzb6x
         YSz2rqFZHlvvGCweWwHnImuzVUf4R728v0Gz2ZkpcufoW9xdjm+tPcqLTbWDiytWi5sk
         ZoAOlNetexZZ8jaJbEj7WD2bVZ6fDkkFzzy/HZ/IatyQMBPm80BUp8tB4lmoFp5ho07s
         zzBwhRXvqPGieqx7PFe2x/YP45InuA0Z5G1y6FToYVuvL86MgAE8M4nd/No1DkxuA/rJ
         LcvoUkgFVFOzeRNpx4KthpEd2Fsz5bnniNNLzcVgzcPxC49LQ0sqZ1JDyA5bO9glxu7x
         wc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dn0fVpigPAa+zeetK6wMzxheWbKBPFBGXzw6JN+hfdQ=;
        b=nCM2QDBoVFFX+ikPtnwl+rysBPXk8+fcTpZOjYjHU9oU1MM5XP8+yo9K+pBJF+oUdI
         ViesleHQr1/w4MUfM6xl9515rbOR960Jrx5GDYMcoGI5F0u2NdMRqsO+XUTTHWlqFwXE
         UIlnZRaGKFyMnQBl/G6ivZuK8OhwXU2n3UKmdBVN3WUK/o1n3gDJ4McDGIefLa8SFkNs
         XLKokj1g1Rk12k3EFJ3DEWyOm6oCD4nq41QRzRHPl/lvDsVe3wssqZsI6ypijJhwNQDA
         HTewcgvxw/Vn36DAgBR3L7zJDUG0/3BPoltP0h8hEhauBQUKS8J4I5QIT0ciKKjqSUUi
         d+hA==
X-Gm-Message-State: AOAM531a1g4X+FiJgaUwBdKUS1tbN+oo5409qBS9jdMQH9STxR2tCEjt
        /SBrZVvcuaxJ76hycH7NFh9bsTzCtb+KR+gq
X-Google-Smtp-Source: ABdhPJxUbziK8NEdJZYSMomvtIx3cfOG0Im7OZFb6Y4FsTVYBoZsMxrDAuWJTtZMQuxiLcvNuqy0/A==
X-Received: by 2002:aed:2be2:: with SMTP id e89mr48443345qtd.297.1608220847196;
        Thu, 17 Dec 2020 08:00:47 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z78sm3730253qkb.0.2020.12.17.08.00.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 08:00:46 -0800 (PST)
Subject: Re: [PATCH v2 06/18] btrfs: extent_io: make
 attach_extent_buffer_page() to handle subpage case
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201210063905.75727-1-wqu@suse.com>
 <20201210063905.75727-7-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <4ad93bff-45b3-04b5-731e-9294c08630cb@toxicpanda.com>
Date:   Thu, 17 Dec 2020 11:00:45 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201210063905.75727-7-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/10/20 1:38 AM, Qu Wenruo wrote:
> For subpage case, we need to allocate new memory for each metadata page.
> 
> So we need to:
> - Allow attach_extent_buffer_page() to return int
>    To indicate allocation failure
> 
> - Prealloc page->private for alloc_extent_buffer()
>    We don't want to call memory allocation with spinlock hold, so
>    do preallocation before we acquire the spin lock.
> 
> - Handle subpage and regular case differently in
>    attach_extent_buffer_page()
>    For regular case, just do the usual thing.
>    For subpage case, allocate new memory and update the tree_block
>    bitmap.
> 
>    The bitmap update will be handled by new subpage specific helper,
>    btrfs_subpage_set_tree_block().
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/extent_io.c | 69 +++++++++++++++++++++++++++++++++++---------
>   fs/btrfs/subpage.h   | 44 ++++++++++++++++++++++++++++
>   2 files changed, 99 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 6350c2687c7e..51dd7ec3c2b3 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -24,6 +24,7 @@
>   #include "rcu-string.h"
>   #include "backref.h"
>   #include "disk-io.h"
> +#include "subpage.h"
>   
>   static struct kmem_cache *extent_state_cache;
>   static struct kmem_cache *extent_buffer_cache;
> @@ -3142,22 +3143,41 @@ static int submit_extent_page(unsigned int opf,
>   	return ret;
>   }
>   
> -static void attach_extent_buffer_page(struct extent_buffer *eb,
> +static int attach_extent_buffer_page(struct extent_buffer *eb,
>   				      struct page *page)
>   {
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
> +
> +	/* Do new allocation to attach subpage */
> +	ret = btrfs_attach_subpage(fs_info, page);
> +	if (ret < 0)
> +		return ret;
> +
> +update_bitmap:
> +	btrfs_subpage_set_tree_block(fs_info, page, eb->start, eb->len);
> +	return 0;
>   }
>   
>   void set_page_extent_mapped(struct page *page)
> @@ -5067,12 +5087,19 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
>   		return NULL;
>   
>   	for (i = 0; i < num_pages; i++) {
> +		int ret;
> +
>   		p = alloc_page(GFP_NOFS);
>   		if (!p) {
>   			btrfs_release_extent_buffer(new);
>   			return NULL;
>   		}
> -		attach_extent_buffer_page(new, p);
> +		ret = attach_extent_buffer_page(new, p);
> +		if (ret < 0) {
> +			put_page(p);
> +			btrfs_release_extent_buffer(new);
> +			return NULL;
> +		}
>   		WARN_ON(PageDirty(p));
>   		SetPageUptodate(p);
>   		new->pages[i] = p;
> @@ -5321,6 +5348,18 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
>   			goto free_eb;
>   		}
>   
> +		/*
> +		 * Preallocate page->private for subpage case, so that
> +		 * we won't allocate memory with private_lock hold.
> +		 */
> +		ret = btrfs_attach_subpage(fs_info, p);
> +		if (ret < 0) {
> +			unlock_page(p);
> +			put_page(p);
> +			exists = ERR_PTR(-ENOMEM);
> +			goto free_eb;
> +		}
> +

This is broken, if we race with another thread adding an extent buffer for this 
same range we'll overwrite the page private with the new thing, losing any of 
the work that was done previously.  Thanks,

Josef
