Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182802FD335
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jan 2021 15:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388854AbhATOwX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jan 2021 09:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389221AbhATOX6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jan 2021 09:23:58 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C029C061794
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jan 2021 06:22:38 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id f26so25421923qka.0
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jan 2021 06:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Ime1CiUQtb1b0FdA2P7VUc9dMgV8gkizzeIthJ5nMIw=;
        b=rZJmu6nLmnhdAWobMiB9JX1hWQbRT/D7uGr1F5Rwqs4RH4riv343YVfVcbZ6gHonIx
         EDPlJZbT7TNYD5EkKEF7r4uFyqN+S3eMBSikN59lnnx/YVNjQhQFHU07wSKwd5KA4ESv
         8P2QMb3wZN7q/y40oHkqwMvKUw6WSRMN4RBjpOA39wSbhBlrtxnE92dxNhy3WoeQdkaq
         INN09zgueEKX0gtiP1copg3WzM71Fim25fleL7yVld6qognBabN/9RSlD8xVUZ/LRL6l
         gSY2CGJJ8NLg0NbewsTtQRAqlRH9ZiEcxhqVcPXIrrNV8d3nlc3yjh4TBElvxkEhhhTV
         559A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ime1CiUQtb1b0FdA2P7VUc9dMgV8gkizzeIthJ5nMIw=;
        b=BY1pQWZF5kxPw9mfVYly0hvArlBvO+yykTzhlhqK4d6R2Snk3OtyDzMhCNM0fOMvAi
         dO+sjG9KArFV0aFZS0TICjb1LXfg/1bvW7c+++dlKSjSqLJUMuu1qWSFSpgnmge70Qjv
         lSr2P5+7VC4/IPVosCn2S0FlLm8B169XAUejV8QVlEO0HxBmE8frSxNNWb0hgESovse9
         HupOALUvb6WAxMBjBocoO3x9o6VJolJCgpm/IvAtunbOCRTQGNIVK6Zr+MjmSd9doNsQ
         VIVKNwhpa9URBR0qRY8eWHcGewJ9IVAxhvqSH6g4k1ZNWRpn8KjU3ZsNtGng2JdOQgiX
         nOwg==
X-Gm-Message-State: AOAM532QPEqa1BqrQ5aomUP7uZX+AE6qBX8TowS0UOMHitKYnNQGxh8j
        ozrZ5QkWfCuL0yNjOfjH2agd7AWnzZsV0+wPW9M=
X-Google-Smtp-Source: ABdhPJxbbxAtmcmTvoakPMXs0OprXeds5NPYooI5nPiv60EbE2VhgzJGBqG3Pdo+PVzK64hJFHfQPw==
X-Received: by 2002:a05:620a:1096:: with SMTP id g22mr9952355qkk.7.1611152556792;
        Wed, 20 Jan 2021 06:22:36 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l38sm1192997qte.88.2021.01.20.06.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 06:22:35 -0800 (PST)
Subject: Re: [PATCH v4 04/18] btrfs: make attach_extent_buffer_page() to
 handle subpage case
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210116071533.105780-1-wqu@suse.com>
 <20210116071533.105780-5-wqu@suse.com>
 <5a6223fc-9937-3bd6-ecd0-d6c5939f59a7@toxicpanda.com>
 <a58c8366-f3b5-a152-92be-c7252891a7c6@gmx.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <8a1f085c-4701-c32f-37e6-72c99fa2074c@toxicpanda.com>
Date:   Wed, 20 Jan 2021 09:22:34 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <a58c8366-f3b5-a152-92be-c7252891a7c6@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/19/21 7:27 PM, Qu Wenruo wrote:
> 
> 
> On 2021/1/20 上午5:54, Josef Bacik wrote:
>> On 1/16/21 2:15 AM, Qu Wenruo wrote:
>>> For subpage case, we need to allocate new memory for each metadata page.
>>>
>>> So we need to:
>>> - Allow attach_extent_buffer_page() to return int
>>>    To indicate allocation failure
>>>
>>> - Prealloc btrfs_subpage structure for alloc_extent_buffer()
>>>    We don't want to call memory allocation with spinlock hold, so
>>>    do preallocation before we acquire mapping->private_lock.
>>>
>>> - Handle subpage and regular case differently in
>>>    attach_extent_buffer_page()
>>>    For regular case, just do the usual thing.
>>>    For subpage case, allocate new memory or use the preallocated memory.
>>>
>>> For future subpage metadata, we will make more usage of radix tree to
>>> grab extnet buffer.
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>>   fs/btrfs/extent_io.c | 75 ++++++++++++++++++++++++++++++++++++++------
>>>   fs/btrfs/subpage.h   | 17 ++++++++++
>>>   2 files changed, 82 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>>> index a816ba4a8537..320731487ac0 100644
>>> --- a/fs/btrfs/extent_io.c
>>> +++ b/fs/btrfs/extent_io.c
>>> @@ -24,6 +24,7 @@
>>>   #include "rcu-string.h"
>>>   #include "backref.h"
>>>   #include "disk-io.h"
>>> +#include "subpage.h"
>>>   static struct kmem_cache *extent_state_cache;
>>>   static struct kmem_cache *extent_buffer_cache;
>>> @@ -3140,9 +3141,13 @@ static int submit_extent_page(unsigned int opf,
>>>       return ret;
>>>   }
>>> -static void attach_extent_buffer_page(struct extent_buffer *eb,
>>> -                      struct page *page)
>>> +static int attach_extent_buffer_page(struct extent_buffer *eb,
>>> +                      struct page *page,
>>> +                      struct btrfs_subpage *prealloc)
>>>   {
>>> +    struct btrfs_fs_info *fs_info = eb->fs_info;
>>> +    int ret;
>>
>> int ret = 0;
>>
>>> +
>>>       /*
>>>        * If the page is mapped to btree inode, we should hold the private
>>>        * lock to prevent race.
>>> @@ -3152,10 +3157,32 @@ static void attach_extent_buffer_page(struct 
>>> extent_buffer *eb,
>>>       if (page->mapping)
>>>           lockdep_assert_held(&page->mapping->private_lock);
>>> -    if (!PagePrivate(page))
>>> -        attach_page_private(page, eb);
>>> -    else
>>> -        WARN_ON(page->private != (unsigned long)eb);
>>> +    if (fs_info->sectorsize == PAGE_SIZE) {
>>> +        if (!PagePrivate(page))
>>> +            attach_page_private(page, eb);
>>> +        else
>>> +            WARN_ON(page->private != (unsigned long)eb);
>>> +        return 0;
>>> +    }
>>> +
>>> +    /* Already mapped, just free prealloc */
>>> +    if (PagePrivate(page)) {
>>> +        kfree(prealloc);
>>> +        return 0;
>>> +    }
>>> +
>>> +    if (prealloc) {
>>> +        /* Has preallocated memory for subpage */
>>> +        spin_lock_init(&prealloc->lock);
>>> +        attach_page_private(page, prealloc);
>>> +    } else {
>>> +        /* Do new allocation to attach subpage */
>>> +        ret = btrfs_attach_subpage(fs_info, page);
>>> +        if (ret < 0)
>>> +            return ret;
>>
>> Delete the above 2 lines.
>>
>>> +    }
>>> +
>>> +    return 0;
>>
>> return ret;
>>
>>>   }
>>>   void set_page_extent_mapped(struct page *page)
>>> @@ -5062,21 +5089,29 @@ struct extent_buffer *btrfs_clone_extent_buffer(const 
>>> struct extent_buffer *src)
>>>       if (new == NULL)
>>>           return NULL;
>>> +    set_bit(EXTENT_BUFFER_UPTODATE, &new->bflags);
>>> +    set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
>>> +
>>
>> Why are you doing this here?  It seems unrelated?  Looking at the code it 
>> appears there's a reason for this later, but I had to go look to make sure I 
>> wasn't crazy, so at the very least it needs to be done in a more relevant patch.
> 
> This is to handle case where we allocated a page but failed to allocate subpage 
> structure.
> 
> In that case, btrfs_release_extent_buffer() will go different routine to free 
> the eb.
> 
> Without UNMAPPED bit, it just go wrong without knowing it's a unmapped eb.
> 
> This change is mostly due to the extra failure pattern introduced by the subpage 
> memory allocation.
> 

Yes, but my point is it's unrelated to this change, and in fact the problem 
exists outside of your changes, so it needs to be addressed in its own patch 
with its own changelog.

>>
>>>       for (i = 0; i < num_pages; i++) {
>>> +        int ret;
>>> +
>>>           p = alloc_page(GFP_NOFS);
>>>           if (!p) {
>>>               btrfs_release_extent_buffer(new);
>>>               return NULL;
>>>           }
>>> -        attach_extent_buffer_page(new, p);
>>> +        ret = attach_extent_buffer_page(new, p, NULL);
>>> +        if (ret < 0) {
>>> +            put_page(p);
>>> +            btrfs_release_extent_buffer(new);
>>> +            return NULL;
>>> +        }
>>>           WARN_ON(PageDirty(p));
>>>           SetPageUptodate(p);
>>>           new->pages[i] = p;
>>>           copy_page(page_address(p), page_address(src->pages[i]));
>>>       }
>>> -    set_bit(EXTENT_BUFFER_UPTODATE, &new->bflags);
>>> -    set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
>>>       return new;
>>>   }
>>> @@ -5308,12 +5343,28 @@ struct extent_buffer *alloc_extent_buffer(struct 
>>> btrfs_fs_info *fs_info,
>>>       num_pages = num_extent_pages(eb);
>>>       for (i = 0; i < num_pages; i++, index++) {
>>> +        struct btrfs_subpage *prealloc = NULL;
>>> +
>>>           p = find_or_create_page(mapping, index, GFP_NOFS|__GFP_NOFAIL);
>>>           if (!p) {
>>>               exists = ERR_PTR(-ENOMEM);
>>>               goto free_eb;
>>>           }
>>> +        /*
>>> +         * Preallocate page->private for subpage case, so that
>>> +         * we won't allocate memory with private_lock hold.
>>> +         * The memory will be freed by attach_extent_buffer_page() or
>>> +         * freed manually if exit earlier.
>>> +         */
>>> +        ret = btrfs_alloc_subpage(fs_info, &prealloc);
>>> +        if (ret < 0) {
>>> +            unlock_page(p);
>>> +            put_page(p);
>>> +            exists = ERR_PTR(ret);
>>> +            goto free_eb;
>>> +        }
>>> +
>>
>> I realize that for subpage sectorsize we'll only have 1 page, but I'd still 
>> rather see this outside of the for loop, just for clarity sake.
> 
> This is the trade-off.
> Either we do every separately, sharing the minimal amount of code (and need 
> extra for loop for future 16K pages), or using the same loop sacrifice a little 
> readability.
> 
> Here I'd say sharing more code is not that a big deal.
> 

It's not a tradeoff, it's confusing.  What I'm suggesting is you do

ret = btrfs_alloc_subpage(fs_info, &prealloc);
if (ret) {
	exists = ERR_PTR(ret);
	goto free_eb;
}
for (i = 0; i < num_pages; i++, index++) {
}

free_eb:
	kmem_cache_free(prealloc);

The subpage portion is part of the eb itself, and there's one per eb, and thus 
should be pre-allocated outside of the loop that is doing the page lookup, as 
it's logically a different thing.  Thanks,

Josef
