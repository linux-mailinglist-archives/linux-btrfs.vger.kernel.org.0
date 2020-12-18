Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A122DE6D4
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Dec 2020 16:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbgLRPmg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Dec 2020 10:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbgLRPmg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Dec 2020 10:42:36 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA62C0617A7
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Dec 2020 07:41:56 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id 22so2314930qkf.9
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Dec 2020 07:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=upckRGFl+nHLb58RFfc8ZU9GNt5V5jJwPllzXXn211I=;
        b=tqiLWM2L7XNgRW3Iqa/rX0mZE1XxgnOCCU9vHE6WWceM7He1sLx2thAHQ4z0hWCxQR
         SqlOJzXEvBYbF+82oZXmQXI57+R7oZkZv8wUFkHRHA0S+at7qxtBVDpXC9VRuNCW1pMD
         f/ZP6hnOxjPz0XGImwOJ/71z1UZblq8EZG5v0mrWIZ/7LmNFpBsrJeXCXSy6IaXOMY0H
         ZvM2myuxlAL6ksVB731EHiBgAt5xdGhgzgjQ/fTt4Sw+dYowE8wKGCR5GGDOCOaNhas4
         SHeVFSjGLVZWtqJCiy2ElrTYKnHtJ+7w+k8TcCTMblnEUk0dvfY/fOsMyLuCMPmn5qhS
         F+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=upckRGFl+nHLb58RFfc8ZU9GNt5V5jJwPllzXXn211I=;
        b=qwqkIqL3b3phbz3776OBFw1H8Jlk9W6MD9inMJvvHpss9TSU9k03Xn8v2VgQh1g/ZN
         M2kuOlHXneZuIKJz+Y+Umm2oMhYZAG9N5dVTaDDw/gh2poF9/8AHzAP8YAX7yuIwzjIh
         zMGuJdQTKVYTUu2CkIN+jVHsw6Pv8bAVz7JrDB94WXAlS/CyGu6chn7vfDlQMWhK3r5Z
         2tbwFW+Z5bpJnbYHIF4xEiebS7cObOUpMSQMiES9Bm/UOpeHHuVTUc9PgSe4uuwDE680
         d8AXWK5fQkURs0cK43B/WDdjAJ6B5+7N4yHnP1wtKotFXUJtB3fE68ZFihQVhqedC2Cp
         4F7g==
X-Gm-Message-State: AOAM532AOeIJY5kmAa3Edkb/OlIhXvYcJPV7z9wABSidyL4B+A3clEkw
        dCL/gFUsO6jwpqfI3bjBh+Zpk6LUFeQROBt7
X-Google-Smtp-Source: ABdhPJypFQY4BXjU3+e2ETyL+wXdVgjNJ9VpQxXIiao5VVelaXJQZSKfyvVECJI2hZo7tpdmZQcDPQ==
X-Received: by 2002:a37:b683:: with SMTP id g125mr5226119qkf.85.1608306114827;
        Fri, 18 Dec 2020 07:41:54 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x28sm5199439qtv.8.2020.12.18.07.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Dec 2020 07:41:54 -0800 (PST)
Subject: Re: [PATCH v2 06/18] btrfs: extent_io: make
 attach_extent_buffer_page() to handle subpage case
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201210063905.75727-1-wqu@suse.com>
 <20201210063905.75727-7-wqu@suse.com>
 <4ad93bff-45b3-04b5-731e-9294c08630cb@toxicpanda.com>
 <5baecd2e-1749-d3fa-c228-942ff0c2f31e@gmx.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <90da14a1-f5ce-c3e7-6119-d97152ef25d4@toxicpanda.com>
Date:   Fri, 18 Dec 2020 10:41:53 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <5baecd2e-1749-d3fa-c228-942ff0c2f31e@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/17/20 7:44 PM, Qu Wenruo wrote:
> 
> 
> On 2020/12/18 上午12:00, Josef Bacik wrote:
>> On 12/10/20 1:38 AM, Qu Wenruo wrote:
>>> For subpage case, we need to allocate new memory for each metadata page.
>>>
>>> So we need to:
>>> - Allow attach_extent_buffer_page() to return int
>>>    To indicate allocation failure
>>>
>>> - Prealloc page->private for alloc_extent_buffer()
>>>    We don't want to call memory allocation with spinlock hold, so
>>>    do preallocation before we acquire the spin lock.
>>>
>>> - Handle subpage and regular case differently in
>>>    attach_extent_buffer_page()
>>>    For regular case, just do the usual thing.
>>>    For subpage case, allocate new memory and update the tree_block
>>>    bitmap.
>>>
>>>    The bitmap update will be handled by new subpage specific helper,
>>>    btrfs_subpage_set_tree_block().
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>>   fs/btrfs/extent_io.c | 69 +++++++++++++++++++++++++++++++++++---------
>>>   fs/btrfs/subpage.h   | 44 ++++++++++++++++++++++++++++
>>>   2 files changed, 99 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>>> index 6350c2687c7e..51dd7ec3c2b3 100644
>>> --- a/fs/btrfs/extent_io.c
>>> +++ b/fs/btrfs/extent_io.c
>>> @@ -24,6 +24,7 @@
>>>   #include "rcu-string.h"
>>>   #include "backref.h"
>>>   #include "disk-io.h"
>>> +#include "subpage.h"
>>>   static struct kmem_cache *extent_state_cache;
>>>   static struct kmem_cache *extent_buffer_cache;
>>> @@ -3142,22 +3143,41 @@ static int submit_extent_page(unsigned int opf,
>>>       return ret;
>>>   }
>>> -static void attach_extent_buffer_page(struct extent_buffer *eb,
>>> +static int attach_extent_buffer_page(struct extent_buffer *eb,
>>>                         struct page *page)
>>>   {
>>> -    /*
>>> -     * If the page is mapped to btree inode, we should hold the private
>>> -     * lock to prevent race.
>>> -     * For cloned or dummy extent buffers, their pages are not mapped and
>>> -     * will not race with any other ebs.
>>> -     */
>>> -    if (page->mapping)
>>> -        lockdep_assert_held(&page->mapping->private_lock);
>>> +    struct btrfs_fs_info *fs_info = eb->fs_info;
>>> +    int ret;
>>> -    if (!PagePrivate(page))
>>> -        attach_page_private(page, eb);
>>> -    else
>>> -        WARN_ON(page->private != (unsigned long)eb);
>>> +    if (fs_info->sectorsize == PAGE_SIZE) {
>>> +        /*
>>> +         * If the page is mapped to btree inode, we should hold the
>>> +         * private lock to prevent race.
>>> +         * For cloned or dummy extent buffers, their pages are not
>>> +         * mapped and will not race with any other ebs.
>>> +         */
>>> +        if (page->mapping)
>>> +            lockdep_assert_held(&page->mapping->private_lock);
>>> +
>>> +        if (!PagePrivate(page))
>>> +            attach_page_private(page, eb);
>>> +        else
>>> +            WARN_ON(page->private != (unsigned long)eb);
>>> +        return 0;
>>> +    }
>>> +
>>> +    /* Already mapped, just update the existing range */
>>> +    if (PagePrivate(page))
>>> +        goto update_bitmap;
>>> +
>>> +    /* Do new allocation to attach subpage */
>>> +    ret = btrfs_attach_subpage(fs_info, page);
>>> +    if (ret < 0)
>>> +        return ret;
>>> +
>>> +update_bitmap:
>>> +    btrfs_subpage_set_tree_block(fs_info, page, eb->start, eb->len);
>>> +    return 0;
>>>   }
>>>   void set_page_extent_mapped(struct page *page)
>>> @@ -5067,12 +5087,19 @@ struct extent_buffer *btrfs_clone_extent_buffer(const 
>>> struct extent_buffer *src)
>>>           return NULL;
>>>       for (i = 0; i < num_pages; i++) {
>>> +        int ret;
>>> +
>>>           p = alloc_page(GFP_NOFS);
>>>           if (!p) {
>>>               btrfs_release_extent_buffer(new);
>>>               return NULL;
>>>           }
>>> -        attach_extent_buffer_page(new, p);
>>> +        ret = attach_extent_buffer_page(new, p);
>>> +        if (ret < 0) {
>>> +            put_page(p);
>>> +            btrfs_release_extent_buffer(new);
>>> +            return NULL;
>>> +        }
>>>           WARN_ON(PageDirty(p));
>>>           SetPageUptodate(p);
>>>           new->pages[i] = p;
>>> @@ -5321,6 +5348,18 @@ struct extent_buffer *alloc_extent_buffer(struct 
>>> btrfs_fs_info *fs_info,
>>>               goto free_eb;
>>>           }
>>> +        /*
>>> +         * Preallocate page->private for subpage case, so that
>>> +         * we won't allocate memory with private_lock hold.
>>> +         */
>>> +        ret = btrfs_attach_subpage(fs_info, p);
>>> +        if (ret < 0) {
>>> +            unlock_page(p);
>>> +            put_page(p);
>>> +            exists = ERR_PTR(-ENOMEM);
>>> +            goto free_eb;
>>> +        }
>>> +
>>
>> This is broken, if we race with another thread adding an extent buffer for 
>> this same range we'll overwrite the page private with the new thing, losing 
>> any of the work that was done previously.  Thanks,
> 
> Firstly the page is locked, so there should be only one to grab the page.
> 
> Secondly, btrfs_attach_subpage() would just exit if it detects the page is 
> already private.
> 
> So there shouldn't be a race.
> 
Task1						Task2
alloc_extent_buffer(4096)			alloc_extent_buffer(4096)
   find_extent_buffer, nothing			  find_extent_buffer, nothing
     find_or_create_page(1)
						    find_or_create_page(1)
						      waits on page lock
       btrfs_attach_subpage()
   radix_tree_insert()
   unlock pages
						      exit find_or_create_page()
						    btrfs_attach_subpage(), BAD

there's definitely a race, again this is why the code does the check to see if 
there's a private attached to the EB already.  Thanks,

Josef
