Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E183060DC
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 17:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbhA0QTE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 11:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343928AbhA0QSl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 11:18:41 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B711AC06174A
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 08:18:00 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id a19so2242738qka.2
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 08:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ppkvPicuscc+KQuuNmiQ29e4fljoXYCnWZ1WPZby+6g=;
        b=nvdXV/wtRIwsh4nLt5QTelExKQ7TFGYaNKtRbxX+bA5wzNzZBrtmlA7ihomhln6Akl
         FcFe9wB/zh5/DnLLBMHpRfmNWozFsfOrMH/YaG/7YjiTXi5A9rrgbuaoOd/m6GOWp4eT
         fFqEAQV9bMxbkEH/+fEal6jZahKKiiOgmquahO61XYloEkTASyaMdibJ3fWWIsZSFEaj
         o+IvWkEZZcuyiesMStiL0RJFghylJfuSkplZ9I0yT9tTlvi6xhJYnli9W7y8xdfJPhRG
         XQ4N2Su/cFqBXejTcpkLC+1hMVQqPHfI0pGWlsAmO/ajkxFbQNpu09LUWh9+Kvmv4aMl
         8CQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ppkvPicuscc+KQuuNmiQ29e4fljoXYCnWZ1WPZby+6g=;
        b=WDMMAJXuKM7HIWWzaV1Tvq+xUH861/XYFSmPrU9LXJZRxXWIp3Z7RhHGnrDMr3P3Yj
         zK2CMdofNyAHRsd2T3v/QUSpr8j5KkueHJSU+9fHx5seD9oeV+ur4o8QYTyJVpPm9UY/
         vzhgbZR/AyyeyBxyBuT/DmTycMYEabZ++KtoF0gBPpCK68flr4JexDUDnXuxNP4NLwLK
         zNeFAhdcqrrNAJtDAAjLDCm3PCCO3lsILBVKeRmOzx/MWO0P2GL6a5gDUplR9FYGI/X5
         Q3XCtVwpLzGTVbYoA01DZhV/dURI1zSJkpxNCgsjuBbeg0ETMcroanhYZRq6mJJVxcf1
         vlDQ==
X-Gm-Message-State: AOAM531CTtSNStVIVjHkN6hVKBv/ylLmslXuPRCphVsuXJSGwWwGD4U/
        ZRqDsUth2aUr8BcDpqbx0M+PLMaO0csh+AAd
X-Google-Smtp-Source: ABdhPJz0Ud4fM98C4sG4i3u2E9yuAVodJscPmVrJ6zOd6LkdDaqmUsT16Oo1KM2QUkTsb8njvQQ2wQ==
X-Received: by 2002:a37:dc43:: with SMTP id v64mr11650628qki.361.1611764279334;
        Wed, 27 Jan 2021 08:17:59 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e189sm1485856qkf.24.2021.01.27.08.17.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 08:17:58 -0800 (PST)
Subject: Re: [PATCH v5 00/18] btrfs: add read-only support for subpage sector
 size
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210126083402.142577-1-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a448ea77-957b-b7fc-c05a-29a4a13352b8@toxicpanda.com>
Date:   Wed, 27 Jan 2021 11:17:57 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210126083402.142577-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/26/21 3:33 AM, Qu Wenruo wrote:
> Patches can be fetched from github:
> https://github.com/adam900710/linux/tree/subpage
> Currently the branch also contains partial RW data support (still some
> ordered extent and data csum mismatch problems)
> 
> Great thanks to David/Nikolay/Josef for their effort reviewing and
> merging the preparation patches into misc-next.
> 
> === What works ===
> Just from the patchset:
> - Data read
>    Both regular and compressed data, with csum check.
> 
> - Metadata read
> 
> This means, with these patchset, 64K page systems can at least mount
> btrfs with 4K sector size read-only.
> This should provide the ability to migrate data at least.
> 
> While on the github branch, there are already experimental RW supports,
> there are still ordered extent related bugs for me to fix.
> Thus only the RO part is sent for review and testing.
> 
> === Patchset structure ===
> Patch 01~02:	Preparation patches which don't have functional change
> Patch 03~12:	Subpage metadata allocation and freeing
> Patch 13~15:	Subpage metadata read path
> Patch 16~17:	Subpage data read path
> Patch 18:	Enable subpage RO support
> 
> === Changelog ===
> v1:
> - Separate the main implementation from previous huge patchset
>    Huge patchset doesn't make much sense.
> 
> - Use bitmap implementation
>    Now page::private will be a pointer to btrfs_subpage structure, which
>    contains bitmaps for various page status.
> 
> v2:
> - Use page::private as btrfs_subpage for extra info
>    This replace old extent io tree based solution, which reduces latency
>    and don't require memory allocation for its operations.
> 
> - Cherry-pick new preparation patches from RW development
>    Those new preparation patches improves the readability by their own.
> 
> v3:
> - Make dummy extent buffer to follow the same subpage accessors
>    Fsstress exposed several ASSERT() for dummy extent buffers.
>    It turns out we need to make dummy extent buffer to own the same
>    btrfs_subpage structure to make eb accessors to work properly
> 
> - Two new small __process_pages_contig() related preparation patches
>    One to make __process_pages_contig() to enhance the error handling
>    path for locked_page, one to merge one macro.
> 
> - Extent buffers refs count update
>    Except try_release_extent_buffer(), all other eb uses will try to
>    increase the ref count of the eb.
>    For try_release_extent_buffer(), the eb refs check will happen inside
>    the rcu critical section to avoid eb being freed.
> 
> - Comment updates
>    Addressing the comments from the mail list.
> 
> v4:
> - Get rid of btrfs_subpage::tree_block_bitmap
>    This is to reduce lock complexity (no need to bother extra subpage
>    lock for metadata, all locks are existing locks)
>    Now eb looking up mostly depends on radix tree, with small help from
>    btrfs_subpage::under_alloc.
>    Now I haven't experieneced metadata related problems any more during
>    my local fsstress tests.
> 
> - Fix a race where metadata page dirty bit can race
>    Fixed in the metadata RW patchset though.
> 
> - Rebased to latest misc-next branch
>    With 4 patches removed, as they are already in misc-next.
> 
> v5:
> - Use the updated version from David as base
>    Most comment/commit message update should be kept as is.
> 
> - A new separate patch to move UNMAPPED bit set timing
> 
> - New comment on why we need to prealloc subpage inside a loop
>    Mostly for further 16K page size support, where we can have
>    eb across multiple pages.
> 
> - Remove one patch which is too RW specific
>    Since it introduces functional change which only makes sense for RW
>    support, it's not a good idea to include it in RO support.
> 
> - Error handling fixes
>    Great thanks to Josef.
> 
> - Refactor btrfs_subpage allocation/freeing
>    Now we have btrfs_alloc_subpage() and btrfs_free_subpage() helpers to
>    do all the allocation/freeing.
>    It's pretty easy to convert to kmem_cache using above helpers.
>    (already internally tested using kmem_cache without problem, in fact
>     it's all the problems found in kmem_cache test leads to the new
>     interface)
> 
> - Use btrfs_subpage::eb_refs to replace old under_alloc
>    This makes checking whether the page has any eb left much easier.
> 
> Qu Wenruo (18):
>    btrfs: merge PAGE_CLEAR_DIRTY and PAGE_SET_WRITEBACK to
>      PAGE_START_WRITEBACK
>    btrfs: set UNMAPPED bit early in btrfs_clone_extent_buffer() for
>      subpage support
>    btrfs: introduce the skeleton of btrfs_subpage structure
>    btrfs: make attach_extent_buffer_page() handle subpage case
>    btrfs: make grab_extent_buffer_from_page() handle subpage case
>    btrfs: support subpage for extent buffer page release

I don't have this patch in my inbox so I can't reply to it directly, but you 
include refcount.h, but then use normal atomics.  Please used the actual 
refcount_t, as it gets us all the debugging stuff that makes finding problems 
much easier.  Thanks,

Josef
