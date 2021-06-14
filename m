Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29243A6E3A
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Jun 2021 20:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbhFNSck (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Jun 2021 14:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbhFNSck (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Jun 2021 14:32:40 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B837C061574
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Jun 2021 11:30:22 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id 93so9288875qtc.10
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Jun 2021 11:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=HLFVtco7eXpMYjxETAEreCdhgsylkjEaeaPG+RBmj8g=;
        b=OAWmQNv41TQ+DK4eqS73+kFlDcWU0+O+bHW8jDSQngS9lI3J+c3pI9Z55x8zWTrka1
         qBa5a/4A+PvKWL9zQT/tuo7phcv7pnqCt1NIIzAo7B4jsqIXj+0eIQE93P19bhVv9Q1E
         Sg9lM4f5l/ZT2Vet69o3LggbH4zQbKWGsORqv6vX1QOdlH1IHcch2COEU7wPFVNu8GEx
         r9Q7v+LU4DQjHuJqgC7GCJ4luwW7ewHLowMBggcDGHovqohvome96LWYisys2+FJKRGg
         ytOVh8Fi8u81v4WEaNuO08mqr1/qHE4uK6S8XM1qurnzcFKuCz+wIhgK/Z2pCn7gq6RT
         hkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HLFVtco7eXpMYjxETAEreCdhgsylkjEaeaPG+RBmj8g=;
        b=FC8oH3YQ6owTtn2AlBgyLVAM0irmQt2dTti1gV/OwnaXRnbhxIwQ6JufTfVPmRMIYc
         MANtAO18ijn4rEakjBSeOxab3si/dOdx51xdDjZ+N3Du6J9i+fHjwpNzv2vjNoPSQvwS
         RYCVt0MvwXRTW82GfDJUIK7ASOPH99w8fJ80XnJFIs5625h2YpVxwzhUbtP4a7LJbjmq
         B94k48gQmkSMLxpKeH/jKYSR2zkXvWGg2hO9/19Xzeee2X3FCHUmkMrQ5ZNnqcVOQ/2b
         0vR9rwvTLaTIy27QmEcSo0PcIcmS7oRFcAy1L/tBnIMQVYt5Pvvd4HRHL0SUasz7shRz
         +X/Q==
X-Gm-Message-State: AOAM531k9LegJjIwpRXX5d3AU9MEUatNcstbR0hjio970qCPnhJFjFMo
        AgaE0U4HDcAUezikgKbWcNLiDg==
X-Google-Smtp-Source: ABdhPJxfMUhn00nkFvQEy3bEKXk+DeSjJGkExHg8RhTgxTnS6WOW3IgQzCYFX4HHMudJARJd5sdg8A==
X-Received: by 2002:ac8:5d55:: with SMTP id g21mr17869712qtx.101.1623695421623;
        Mon, 14 Jun 2021 11:30:21 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d9::1287? ([2620:10d:c091:480::1:a94c])
        by smtp.gmail.com with ESMTPSA id z3sm10705164qkj.40.2021.06.14.11.30.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 11:30:21 -0700 (PDT)
Subject: Re: [PATCH 1/4] btrfs: wait on async extents when flushing delalloc
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1623419155.git.josef@toxicpanda.com>
 <f2a18e6cf6553f9b886768d86d5580561d9c279e.1623419155.git.josef@toxicpanda.com>
 <af617239-cc73-1e36-6f06-f5c9d385af73@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <3ea2790a-11be-51a9-85a0-9c6f6fdf96a6@toxicpanda.com>
Date:   Mon, 14 Jun 2021 14:30:19 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <af617239-cc73-1e36-6f06-f5c9d385af73@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/14/21 6:05 AM, Nikolay Borisov wrote:
> 
> 
> On 11.06.21 г. 16:53, Josef Bacik wrote:
>> I've been debugging an early ENOSPC problem in production and finally
>> root caused it to this problem.  When we switched to the per-inode
>> flushing code I pulled out the async extent handling, because we were
>> doing the correct thing by calling filemap_flush() if we had async
>> extents set.  This would properly wait on any async extents by locking
>> the page in the second flush, thus making sure our ordered extents were
>> properly set up.
> 
> Which commit is this paragraph referring to? It will be helpful to
> include a reference so once can actually trace the  history of this code.
>>
>> However when I switched us back to page based flushing, I used
>> sync_inode(), which allows us to pass in our own wbc.  The problem here
>> is that sync_inode() is smarter than the filemap_* helpers, it tries to
>> avoid calling writepages at all.  This means that our second call could
>> skip calling do_writepages altogether, and thus not wait on the pagelock
>> for the async helpers.  This means we could come back before any ordered
>> extents were created and then simply continue on in our flushing
>> mechanisms and ENOSPC out when we have plenty of space to use.
> 
> AFAICS in the code and based on your problem statement it would seem the
> culprit here is really the fact we are calling the 2nd sync_inode with
> WBC_SYNC_NONE, which is an indicator for sync_inode (respectively.
> writeback_single_inode) to simply return in case I_SYNC is still set
> from the first invocation of sync_inode or if the inode doesn't have
> I_DIRTY_ALL set. So wouldn't a simple fix be to change the wbc's
> .sync_mode to the second sync_inode to be WB_SYNC_ALL that will ensure
> that the 2nd sync_inode takes effect?

It would, except that would make us wait on writeback, which is not what we want 
necessarily, we want to just wait for the async workers to finish and then 
continue writing stuff.

> 
>>
>> Fix this by putting back the async pages logic in shrink_delalloc.  This
>> allows us to bulk write out everything that we need to, and then we can
>> wait in one place for the async helpers to catch up, and then wait on
>> any ordered extents that are created.
>>
>> Fixes: e076ab2a2ca7 ("btrfs: shrink delalloc pages instead of full inodes")
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> 
>> ---
>>   fs/btrfs/inode.c      |  4 ----
>>   fs/btrfs/space-info.c | 33 +++++++++++++++++++++++++++++++++
>>   2 files changed, 33 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index 8ba4b194cd3e..6cb73ff59c7c 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -9681,10 +9681,6 @@ static int start_delalloc_inodes(struct btrfs_root *root,
>>   					 &work->work);
>>   		} else {
>>   			ret = sync_inode(inode, wbc);
>> -			if (!ret &&
>> -			    test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
>> -				     &BTRFS_I(inode)->runtime_flags))
>> -				ret = sync_inode(inode, wbc);
>>   			btrfs_add_delayed_iput(inode);
>>   			if (ret || wbc->nr_to_write <= 0)
>>   				goto out;
>> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
>> index af467e888545..3c89af4fd729 100644
>> --- a/fs/btrfs/space-info.c
>> +++ b/fs/btrfs/space-info.c
>> @@ -547,9 +547,42 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
>>   	while ((delalloc_bytes || ordered_bytes) && loops < 3) {
>>   		u64 temp = min(delalloc_bytes, to_reclaim) >> PAGE_SHIFT;
>>   		long nr_pages = min_t(u64, temp, LONG_MAX);
>> +		int async_pages;
>>   
>>   		btrfs_start_delalloc_roots(fs_info, nr_pages, true);
>>   
>> +		/*
>> +		 * We need to make sure any outstanding async pages are now
>> +		 * processed before we continue.  This is because things like
>> +		 * sync_inode() try to be smart and skip writing if the inode is
>> +		 * marked clean.  We don't use filemap_fwrite for flushing
>> +		 * because we want to control how many pages we write out at a
>> +		 * time, thus this is the only safe way to make sure we've
>> +		 * waited for outstanding compressed workers to have started
>> +		 * their jobs and thus have ordered extents set up properly.
>> +		 * Josef, when you think you are smart enough to remove this in
>> +		 * the future, read this comment 4 times and explain in the
>> +		 * commit message why it makes sense to remove it, and then
>> +		 * delete the commit and don't remove it.
> 
> I think the last sentence can be omitted, simply prefix the paragraph
> with N.B. or put a more generic warning e.g. "Be extra careful and
> thoughtful when considering changing this logic".

Yeah I meant to go back and change that.

> 
>> +		 */
>> +		async_pages = atomic_read(&fs_info->async_delalloc_pages);
>> +		if (!async_pages)
>> +			goto skip_async;
>> +
>> +		/*
>> +		 * We don't want to wait forever, if we wrote less pages in this
>> +		 * loop than we have outstanding, only wait for that number of
>> +		 * pages, otherwise we can wait for all async pages to finish
>> +		 * before continuing.
>> +		 */
>> +		if (async_pages > nr_pages)
>> +			async_pages -= nr_pages;
>> +		else
>> +			async_pages = 0;
>> +		wait_event(fs_info->async_submit_wait,
>> +			   atomic_read(&fs_info->async_delalloc_pages) <=
>> +			   async_pages);
> 
> nit: What's funny is that without this patch async_submit_wait actually
> doesn't have a single user, it's only woken up in async_cow_submit but
> nobody actually waited for it. Ideally it should have been removed when
> its last user was removed. ;)
> 

Clearly, but hooray I didn't rip it out because now I can just add this bit. 
Thanks,

Josef
