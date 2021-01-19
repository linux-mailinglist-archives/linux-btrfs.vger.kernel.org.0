Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664102FC2DC
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jan 2021 22:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbhASV5H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jan 2021 16:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728099AbhASVzO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jan 2021 16:55:14 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A409C061575
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jan 2021 13:54:31 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id h4so23514233qkk.4
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jan 2021 13:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=AWZTLNAaZTCe8aFCrnqkVhQDIRdda1awI1T10BZpJew=;
        b=Ie+QvSakFeD/+s+gQckgzaeMFNU0t139XwBJgp376pxVEo6xi9yHyCyxoDv5lWB9mQ
         7lcXk2zoKCB1uBoVywsym3seJ/QcUQ3//UqS1sMXw0S7+fogZxScEH/SxM25921vDlq9
         fVI9moAYl2MBXE/YozPCoQakCcsu8Kp1wDS50uO9RdGrLIKX00ATI5/CVipYWpoH7lvV
         p9+3GFUCiajfGkFgkjcHjI1aWc/qnEflS8hPEPrY7DNqXImC23UyXG0CjJnAIoeX1/Qb
         Y0/qCJw/irdKIlGuFhUeCnxOkdf6wS01rwoqNxGxHz6oT8FbTcQCD/ummRq0ZyK0N0my
         QFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AWZTLNAaZTCe8aFCrnqkVhQDIRdda1awI1T10BZpJew=;
        b=ruIDZcmcyzxKoP+3N2Kx/YcRVSuqNLtLiTcTQAKhazvNKaIWNTgrqOLkWvDuNV1p3c
         wZ3xjSI1he4j7N8fo6LFXKfSLRLRRrotXfDg9IxPjrZqwODqystQCFDiSZL92OKUq30l
         47o53Ffp5NLRA5qlRgpsilofuyf1MQ26zMD7+6ps6Mnj/Mc1uD6jk44UTx86NEMrASMt
         y5OFOQPqZhJ3UTFZf7Bm9Wh2CJLZL9fyV7gHNOihj3DeVzO7BHH9A0tCKv0tqh/mVjBJ
         y3gsFTROtgswm+hZFg8ZTYmmF5s72jYB0oqg4qlkTFY0t133BZxDnH41hUrmp/rJxKZf
         boGA==
X-Gm-Message-State: AOAM530f1mkroC/sF/l0pSWxQetXwRkLSzZkqrCGljwxSzCJUzBcnpCl
        iCl8gIEAQAbMSg4lfEXGFdyv5OlksdwWhCT6Dt0=
X-Google-Smtp-Source: ABdhPJzAoCRJkvtuXH1rtcrcgQsvnbBosrIyceH5geeA6jswZTews7EfNE0sILTDgKrqS5JuWML3rQ==
X-Received: by 2002:a37:9687:: with SMTP id y129mr833572qkd.371.1611093269732;
        Tue, 19 Jan 2021 13:54:29 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:11d1::1325? ([2620:10d:c091:480::1:2a44])
        by smtp.gmail.com with ESMTPSA id z30sm13059428qtc.15.2021.01.19.13.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 13:54:29 -0800 (PST)
Subject: Re: [PATCH v4 04/18] btrfs: make attach_extent_buffer_page() to
 handle subpage case
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210116071533.105780-1-wqu@suse.com>
 <20210116071533.105780-5-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <5a6223fc-9937-3bd6-ecd0-d6c5939f59a7@toxicpanda.com>
Date:   Tue, 19 Jan 2021 16:54:28 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210116071533.105780-5-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/16/21 2:15 AM, Qu Wenruo wrote:
> For subpage case, we need to allocate new memory for each metadata page.
> 
> So we need to:
> - Allow attach_extent_buffer_page() to return int
>    To indicate allocation failure
> 
> - Prealloc btrfs_subpage structure for alloc_extent_buffer()
>    We don't want to call memory allocation with spinlock hold, so
>    do preallocation before we acquire mapping->private_lock.
> 
> - Handle subpage and regular case differently in
>    attach_extent_buffer_page()
>    For regular case, just do the usual thing.
>    For subpage case, allocate new memory or use the preallocated memory.
> 
> For future subpage metadata, we will make more usage of radix tree to
> grab extnet buffer.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/extent_io.c | 75 ++++++++++++++++++++++++++++++++++++++------
>   fs/btrfs/subpage.h   | 17 ++++++++++
>   2 files changed, 82 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index a816ba4a8537..320731487ac0 100644
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
> @@ -3140,9 +3141,13 @@ static int submit_extent_page(unsigned int opf,
>   	return ret;
>   }
>   
> -static void attach_extent_buffer_page(struct extent_buffer *eb,
> -				      struct page *page)
> +static int attach_extent_buffer_page(struct extent_buffer *eb,
> +				      struct page *page,
> +				      struct btrfs_subpage *prealloc)
>   {
> +	struct btrfs_fs_info *fs_info = eb->fs_info;
> +	int ret;

int ret = 0;

> +
>   	/*
>   	 * If the page is mapped to btree inode, we should hold the private
>   	 * lock to prevent race.
> @@ -3152,10 +3157,32 @@ static void attach_extent_buffer_page(struct extent_buffer *eb,
>   	if (page->mapping)
>   		lockdep_assert_held(&page->mapping->private_lock);
>   
> -	if (!PagePrivate(page))
> -		attach_page_private(page, eb);
> -	else
> -		WARN_ON(page->private != (unsigned long)eb);
> +	if (fs_info->sectorsize == PAGE_SIZE) {
> +		if (!PagePrivate(page))
> +			attach_page_private(page, eb);
> +		else
> +			WARN_ON(page->private != (unsigned long)eb);
> +		return 0;
> +	}
> +
> +	/* Already mapped, just free prealloc */
> +	if (PagePrivate(page)) {
> +		kfree(prealloc);
> +		return 0;
> +	}
> +
> +	if (prealloc) {
> +		/* Has preallocated memory for subpage */
> +		spin_lock_init(&prealloc->lock);
> +		attach_page_private(page, prealloc);
> +	} else {
> +		/* Do new allocation to attach subpage */
> +		ret = btrfs_attach_subpage(fs_info, page);
> +		if (ret < 0)
> +			return ret;

Delete the above 2 lines.

> +	}
> +
> +	return 0;

return ret;

>   }
>   
>   void set_page_extent_mapped(struct page *page)
> @@ -5062,21 +5089,29 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
>   	if (new == NULL)
>   		return NULL;
>   
> +	set_bit(EXTENT_BUFFER_UPTODATE, &new->bflags);
> +	set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
> +

Why are you doing this here?  It seems unrelated?  Looking at the code it 
appears there's a reason for this later, but I had to go look to make sure I 
wasn't crazy, so at the very least it needs to be done in a more relevant patch.

>   	for (i = 0; i < num_pages; i++) {
> +		int ret;
> +
>   		p = alloc_page(GFP_NOFS);
>   		if (!p) {
>   			btrfs_release_extent_buffer(new);
>   			return NULL;
>   		}
> -		attach_extent_buffer_page(new, p);
> +		ret = attach_extent_buffer_page(new, p, NULL);
> +		if (ret < 0) {
> +			put_page(p);
> +			btrfs_release_extent_buffer(new);
> +			return NULL;
> +		}
>   		WARN_ON(PageDirty(p));
>   		SetPageUptodate(p);
>   		new->pages[i] = p;
>   		copy_page(page_address(p), page_address(src->pages[i]));
>   	}
>   
> -	set_bit(EXTENT_BUFFER_UPTODATE, &new->bflags);
> -	set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
>   
>   	return new;
>   }
> @@ -5308,12 +5343,28 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
>   
>   	num_pages = num_extent_pages(eb);
>   	for (i = 0; i < num_pages; i++, index++) {
> +		struct btrfs_subpage *prealloc = NULL;
> +
>   		p = find_or_create_page(mapping, index, GFP_NOFS|__GFP_NOFAIL);
>   		if (!p) {
>   			exists = ERR_PTR(-ENOMEM);
>   			goto free_eb;
>   		}
>   
> +		/*
> +		 * Preallocate page->private for subpage case, so that
> +		 * we won't allocate memory with private_lock hold.
> +		 * The memory will be freed by attach_extent_buffer_page() or
> +		 * freed manually if exit earlier.
> +		 */
> +		ret = btrfs_alloc_subpage(fs_info, &prealloc);
> +		if (ret < 0) {
> +			unlock_page(p);
> +			put_page(p);
> +			exists = ERR_PTR(ret);
> +			goto free_eb;
> +		}
> +

I realize that for subpage sectorsize we'll only have 1 page, but I'd still 
rather see this outside of the for loop, just for clarity sake.

>   		spin_lock(&mapping->private_lock);
>   		exists = grab_extent_buffer(p);
>   		if (exists) {
> @@ -5321,10 +5372,14 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
>   			unlock_page(p);
>   			put_page(p);
>   			mark_extent_buffer_accessed(exists, p);
> +			kfree(prealloc);
>   			goto free_eb;
>   		}
> -		attach_extent_buffer_page(eb, p);
> +		/* Should not fail, as we have preallocated the memory */
> +		ret = attach_extent_buffer_page(eb, p, prealloc);
> +		ASSERT(!ret);
>   		spin_unlock(&mapping->private_lock);
> +
>   		WARN_ON(PageDirty(p));
>   		eb->pages[i] = p;
>   		if (!PageUptodate(p))
> diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
> index 96f3b226913e..f701256dd1e2 100644
> --- a/fs/btrfs/subpage.h
> +++ b/fs/btrfs/subpage.h
> @@ -23,8 +23,25 @@
>   struct btrfs_subpage {
>   	/* Common members for both data and metadata pages */
>   	spinlock_t lock;
> +	union {
> +		/* Structures only used by metadata */
> +		/* Structures only used by data */
> +	};
>   };
>   
> +/* For rare cases where we need to pre-allocate a btrfs_subpage structure */
> +static inline int btrfs_alloc_subpage(struct btrfs_fs_info *fs_info,
> +				      struct btrfs_subpage **ret)
> +{
> +	if (fs_info->sectorsize == PAGE_SIZE)
> +		return 0;
> +
> +	*ret = kzalloc(sizeof(struct btrfs_subpage), GFP_NOFS);
> +	if (!*ret)
> +		return -ENOMEM;
> +	return 0;
> +}

We're allocating these for every metadata page, that deserves a dedicated 
kmem_cache.  Thanks,

Josef
