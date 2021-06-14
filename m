Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E5C3A5FAA
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Jun 2021 12:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbhFNKHd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Jun 2021 06:07:33 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45322 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbhFNKHc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Jun 2021 06:07:32 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3CF891FD29;
        Mon, 14 Jun 2021 10:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623665129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZNaeHfpworRaHwbYWGBo82ID+Ws91lZWskujRu/57vU=;
        b=ec8AXltdK0n7yMcym5KTUA/oh8gY7ORmhJSzoqyCBnY/6EvLYCGKN50JGFD74JcAO5J9Aa
        InT31LK7qJhX541EgidZ7eCtX8WCni4uvDvfzk0P5sqTE/9MZBd9xAKdyGp8XyMSIC5fie
        3G7+xE4/j7GhkeiNrQb8qbOOLxtlJMA=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 03436118DD;
        Mon, 14 Jun 2021 10:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623665129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZNaeHfpworRaHwbYWGBo82ID+Ws91lZWskujRu/57vU=;
        b=ec8AXltdK0n7yMcym5KTUA/oh8gY7ORmhJSzoqyCBnY/6EvLYCGKN50JGFD74JcAO5J9Aa
        InT31LK7qJhX541EgidZ7eCtX8WCni4uvDvfzk0P5sqTE/9MZBd9xAKdyGp8XyMSIC5fie
        3G7+xE4/j7GhkeiNrQb8qbOOLxtlJMA=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id Za8ROugpx2BjYAAALh3uQQ
        (envelope-from <nborisov@suse.com>); Mon, 14 Jun 2021 10:05:28 +0000
Subject: Re: [PATCH 1/4] btrfs: wait on async extents when flushing delalloc
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1623419155.git.josef@toxicpanda.com>
 <f2a18e6cf6553f9b886768d86d5580561d9c279e.1623419155.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <af617239-cc73-1e36-6f06-f5c9d385af73@suse.com>
Date:   Mon, 14 Jun 2021 13:05:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <f2a18e6cf6553f9b886768d86d5580561d9c279e.1623419155.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11.06.21 г. 16:53, Josef Bacik wrote:
> I've been debugging an early ENOSPC problem in production and finally
> root caused it to this problem.  When we switched to the per-inode
> flushing code I pulled out the async extent handling, because we were
> doing the correct thing by calling filemap_flush() if we had async
> extents set.  This would properly wait on any async extents by locking
> the page in the second flush, thus making sure our ordered extents were
> properly set up.

Which commit is this paragraph referring to? It will be helpful to
include a reference so once can actually trace the  history of this code.
> 
> However when I switched us back to page based flushing, I used
> sync_inode(), which allows us to pass in our own wbc.  The problem here
> is that sync_inode() is smarter than the filemap_* helpers, it tries to
> avoid calling writepages at all.  This means that our second call could
> skip calling do_writepages altogether, and thus not wait on the pagelock
> for the async helpers.  This means we could come back before any ordered
> extents were created and then simply continue on in our flushing
> mechanisms and ENOSPC out when we have plenty of space to use.

AFAICS in the code and based on your problem statement it would seem the
culprit here is really the fact we are calling the 2nd sync_inode with
WBC_SYNC_NONE, which is an indicator for sync_inode (respectively.
writeback_single_inode) to simply return in case I_SYNC is still set
from the first invocation of sync_inode or if the inode doesn't have
I_DIRTY_ALL set. So wouldn't a simple fix be to change the wbc's
.sync_mode to the second sync_inode to be WB_SYNC_ALL that will ensure
that the 2nd sync_inode takes effect?

> 
> Fix this by putting back the async pages logic in shrink_delalloc.  This
> allows us to bulk write out everything that we need to, and then we can
> wait in one place for the async helpers to catch up, and then wait on
> any ordered extents that are created.
> 
> Fixes: e076ab2a2ca7 ("btrfs: shrink delalloc pages instead of full inodes")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>


> ---
>  fs/btrfs/inode.c      |  4 ----
>  fs/btrfs/space-info.c | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 8ba4b194cd3e..6cb73ff59c7c 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -9681,10 +9681,6 @@ static int start_delalloc_inodes(struct btrfs_root *root,
>  					 &work->work);
>  		} else {
>  			ret = sync_inode(inode, wbc);
> -			if (!ret &&
> -			    test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
> -				     &BTRFS_I(inode)->runtime_flags))
> -				ret = sync_inode(inode, wbc);
>  			btrfs_add_delayed_iput(inode);
>  			if (ret || wbc->nr_to_write <= 0)
>  				goto out;
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index af467e888545..3c89af4fd729 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -547,9 +547,42 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
>  	while ((delalloc_bytes || ordered_bytes) && loops < 3) {
>  		u64 temp = min(delalloc_bytes, to_reclaim) >> PAGE_SHIFT;
>  		long nr_pages = min_t(u64, temp, LONG_MAX);
> +		int async_pages;
>  
>  		btrfs_start_delalloc_roots(fs_info, nr_pages, true);
>  
> +		/*
> +		 * We need to make sure any outstanding async pages are now
> +		 * processed before we continue.  This is because things like
> +		 * sync_inode() try to be smart and skip writing if the inode is
> +		 * marked clean.  We don't use filemap_fwrite for flushing
> +		 * because we want to control how many pages we write out at a
> +		 * time, thus this is the only safe way to make sure we've
> +		 * waited for outstanding compressed workers to have started
> +		 * their jobs and thus have ordered extents set up properly.
> +		 * Josef, when you think you are smart enough to remove this in
> +		 * the future, read this comment 4 times and explain in the
> +		 * commit message why it makes sense to remove it, and then
> +		 * delete the commit and don't remove it.

I think the last sentence can be omitted, simply prefix the paragraph
with N.B. or put a more generic warning e.g. "Be extra careful and
thoughtful when considering changing this logic".

> +		 */
> +		async_pages = atomic_read(&fs_info->async_delalloc_pages);
> +		if (!async_pages)
> +			goto skip_async;
> +
> +		/*
> +		 * We don't want to wait forever, if we wrote less pages in this
> +		 * loop than we have outstanding, only wait for that number of
> +		 * pages, otherwise we can wait for all async pages to finish
> +		 * before continuing.
> +		 */
> +		if (async_pages > nr_pages)
> +			async_pages -= nr_pages;
> +		else
> +			async_pages = 0;
> +		wait_event(fs_info->async_submit_wait,
> +			   atomic_read(&fs_info->async_delalloc_pages) <=
> +			   async_pages);

nit: What's funny is that without this patch async_submit_wait actually
doesn't have a single user, it's only woken up in async_cow_submit but
nobody actually waited for it. Ideally it should have been removed when
its last user was removed. ;)

> +skip_async:
>  		loops++;
>  		if (wait_ordered && !trans) {
>  			btrfs_wait_ordered_roots(fs_info, items, 0, (u64)-1);
> 
