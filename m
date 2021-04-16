Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3263621D2
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Apr 2021 16:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbhDPOKb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 10:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235561AbhDPOK2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 10:10:28 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A776EC061574
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 07:10:03 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id o5so28961539qkb.0
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 07:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=fK4SrSkjR+/V92WaPxoUqhBIdXZRmx+H/FxqtX2Gq+s=;
        b=qvFMSYOpwZHwS8Ifi7b6DkJnJ9h5Rh2cetHKkTss3lw370Bonbwn3zhGnLQD0whAkw
         oZXHX8URb2wzT+dRT0oCVWHXVCPgLwguVm86kUt0DGZwVbAD4lzsPjfgsC6M+ucBmHjB
         NVgtzssWZPs4pxBHpM3FH9kggbuBh6MKsm8HVrFY3l0uLwtb11049PBKRFsPuZKdgVC2
         IVKOfr55qzwwW9AnqfKKlnkrpskPWoCFlzslVroTQBofsd24RTNuDVbVnQo2vEMHmPXh
         xYNQaiJEiQbLf9LVy3VTJWjGD+c3zaGUKKB5S6JcpysIvziZgsjBlSQxPTENqk0yjVXK
         zCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fK4SrSkjR+/V92WaPxoUqhBIdXZRmx+H/FxqtX2Gq+s=;
        b=gpsCR0YprHGacYKrCSwC2oMMIVn66NwMOKE0ix3z+KH100LVhgvA9gnqJom7B8SFTT
         aHcGi+AUqS4V6GynLHUQ83Cb4veJndk5AnokQqUEVqjZ/ngdRJHaP5FG+5YmUJ6TemUy
         TTR9jzCNBMdqiuqKTf4aEX+OLbLTFZ4uW30C2SVRDxucI6+BP2Yxcn8XnAdNe88QRdfZ
         MUz/8EGYVl4JP/r30dEnI6hSf9cT6EVJiI4MYf0u6OTfO88ADuZJY7MAOuwQkHwiCQ5p
         tskrP9CTIZgFMSr4p3a2evAXNQ8fiddBF/2NaURzp9AjVAIdXj2XsjpRsxXOhE6RTwvc
         DFEw==
X-Gm-Message-State: AOAM5334RwfzZ/BeDr6s0nLww/PEl3ZeiAWmzxPgFXa43O2LZ7XYK71Q
        FLExTwWAIxBey1glgudJ4rgYMAyFxUFJpg==
X-Google-Smtp-Source: ABdhPJz1bd2E545EvDSH8k7SMKsBwcbytEBtJzD88VF4YjWvES3FBCW1tR9bBKWmQUoxdvZxGUOfAw==
X-Received: by 2002:a37:2796:: with SMTP id n144mr8693070qkn.276.1618582202379;
        Fri, 16 Apr 2021 07:10:02 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v66sm4227490qkd.113.2021.04.16.07.10.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 07:10:00 -0700 (PDT)
Subject: Re: [PATCH 09/42] btrfs: refactor how we finish ordered extent io for
 endio functions
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210415050448.267306-1-wqu@suse.com>
 <20210415050448.267306-10-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a32df0b2-704b-958e-8499-354363169475@toxicpanda.com>
Date:   Fri, 16 Apr 2021 10:09:59 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210415050448.267306-10-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/15/21 1:04 AM, Qu Wenruo wrote:
> Btrfs has two endio functions to mark certain io range finished for
> ordered extents:
> - __endio_write_update_ordered()
>    This is for direct IO
> 
> - btrfs_writepage_endio_finish_ordered()
>    This for buffered IO.
> 
> However they go different routines to handle ordered extent io:
> - Whether to iterate through all ordered extents
>    __endio_write_update_ordered() will but
>    btrfs_writepage_endio_finish_ordered() will not.
> 
>    In fact, iterating through all ordered extents will benefit later
>    subpage support, while for current PAGE_SIZE == sectorsize requirement
>    those behavior makes no difference.
> 
> - Whether to update page Private2 flag
>    __endio_write_update_ordered() will no update page Private2 flag as
>    for iomap direct IO, the page can be not even mapped.
>    While btrfs_writepage_endio_finish_ordered() will clear Private2 to
>    prevent double accounting against btrfs_invalidatepage().
> 
> Those differences are pretty small, and the ordered extent iterations
> codes in callers makes code much harder to read.
> 
> So this patch will introduce a new function,
> btrfs_mark_ordered_io_finished(), to do the heavy lifting work:
> - Iterate through all ordered extents in the range
> - Do the ordered extent accounting
> - Queue the work for finished ordered extent
> 
> This function has two new feature:
> - Proper underflow detection and recover
>    The old underflow detection will only detect the problem, then
>    continue.
>    No proper info like root/inode/ordered extent info, nor noisy enough
>    to be caught by fstests.
> 
>    Furthermore when underflow happens, the ordered extent will never
>    finish.
> 
>    New error detection will reset the bytes_left to 0, do proper
>    kernel warning, and output extra info including root, ino, ordered
>    extent range, the underflow value.
> 
> - Prevent double accounting based on Private2 flag
>    Now if we find a range without Private2 flag, we will skip to next
>    range.
>    As that means someone else has already finished the accounting of
>    ordered extent.
>    This makes no difference for current code, but will be a critical part
>    for incoming subpage support.
> 
> Now both endio functions only need to call that new function.
> 
> And since the only caller of btrfs_dec_test_first_ordered_pending() is
> removed, also remove btrfs_dec_test_first_ordered_pending() completely.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/inode.c        |  55 +-----------
>   fs/btrfs/ordered-data.c | 179 +++++++++++++++++++++++++++-------------
>   fs/btrfs/ordered-data.h |   8 +-
>   3 files changed, 129 insertions(+), 113 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 752f0c78e1df..645097bff5a0 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3063,25 +3063,11 @@ void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
>   					  struct page *page, u64 start,
>   					  u64 end, int uptodate)
>   {
> -	struct btrfs_fs_info *fs_info = inode->root->fs_info;
> -	struct btrfs_ordered_extent *ordered_extent = NULL;
> -	struct btrfs_workqueue *wq;
> -
>   	ASSERT(end + 1 - start < U32_MAX);
>   	trace_btrfs_writepage_end_io_hook(inode, start, end, uptodate);
>   
> -	ClearPagePrivate2(page);
> -	if (!btrfs_dec_test_ordered_pending(inode, &ordered_extent, start,
> -					    end - start + 1, uptodate))
> -		return;
> -
> -	if (btrfs_is_free_space_inode(inode))
> -		wq = fs_info->endio_freespace_worker;
> -	else
> -		wq = fs_info->endio_write_workers;
> -
> -	btrfs_init_work(&ordered_extent->work, finish_ordered_fn, NULL, NULL);
> -	btrfs_queue_work(wq, &ordered_extent->work);
> +	btrfs_mark_ordered_io_finished(inode, page, start, end + 1 - start,
> +				       finish_ordered_fn, uptodate);
>   }
>   
>   /*
> @@ -7959,42 +7945,9 @@ static void __endio_write_update_ordered(struct btrfs_inode *inode,
>   					 const u64 offset, const u64 bytes,
>   					 const bool uptodate)
>   {
> -	struct btrfs_fs_info *fs_info = inode->root->fs_info;
> -	struct btrfs_ordered_extent *ordered = NULL;
> -	struct btrfs_workqueue *wq;
> -	u64 ordered_offset = offset;
> -	u64 ordered_bytes = bytes;
> -	u64 last_offset;
> -
> -	if (btrfs_is_free_space_inode(inode))
> -		wq = fs_info->endio_freespace_worker;
> -	else
> -		wq = fs_info->endio_write_workers;
> -
>   	ASSERT(bytes < U32_MAX);
> -	while (ordered_offset < offset + bytes) {
> -		last_offset = ordered_offset;
> -		if (btrfs_dec_test_first_ordered_pending(inode, &ordered,
> -							 &ordered_offset,
> -							 ordered_bytes,
> -							 uptodate)) {
> -			btrfs_init_work(&ordered->work, finish_ordered_fn, NULL,
> -					NULL);
> -			btrfs_queue_work(wq, &ordered->work);
> -		}
> -
> -		/* No ordered extent found in the range, exit */
> -		if (ordered_offset == last_offset)
> -			return;
> -		/*
> -		 * Our bio might span multiple ordered extents. In this case
> -		 * we keep going until we have accounted the whole dio.
> -		 */
> -		if (ordered_offset < offset + bytes) {
> -			ordered_bytes = offset + bytes - ordered_offset;
> -			ordered = NULL;
> -		}
> -	}
> +	btrfs_mark_ordered_io_finished(inode, NULL, offset, bytes,
> +				       finish_ordered_fn, uptodate);
>   }
>   
>   static blk_status_t btrfs_submit_bio_start_direct_io(struct inode *inode,
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index 8e6d9d906bdd..a0b625422f55 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -306,81 +306,144 @@ void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
>   }
>   
>   /*
> - * Finish IO for one ordered extent across a given range.  The range can
> - * contain several ordered extents.
> + * Mark all ordered extent io inside the specified range finished.
>    *
> - * @found_ret:	 Return the finished ordered extent
> - * @file_offset: File offset for the finished IO
> - * 		 Will also be updated to one byte past the range that is
> - * 		 recordered as finished. This allows caller to walk forward.
> - * @io_size:	 Length of the finish IO range
> - * @uptodate:	 If the IO finished without problem
> - *
> - * Return true if any ordered extent is finished in the range, and update
> - * @found_ret and @file_offset.
> - * Return false otherwise.
> + * @page:	 The invovled page for the opeartion.
> + *		 For uncompressed buffered IO, the page status also needs to be
> + *		 updated to indicate whether the pending ordered io is
> + *		 finished.
> + *		 Can be NULL for direct IO and compressed write.
> + *		 In those cases, callers are ensured they won't execute
> + *		 the endio function twice.
> + * @finish_func: The function to be executed when all the IO of an ordered
> + *		 extent is finished.
>    *
> - * NOTE: Although The range can cross multiple ordered extents, only one
> - * ordered extent will be updated during one call. The caller is responsible to
> - * iterate all ordered extents in the range.
> + * This function is called for endio, thus the range must have ordered
> + * extent(s) covering it.
>    */
> -bool btrfs_dec_test_first_ordered_pending(struct btrfs_inode *inode,
> -				   struct btrfs_ordered_extent **finished_ret,
> -				   u64 *file_offset, u32 io_size, int uptodate)
> +void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
> +				struct page *page, u64 file_offset,
> +				u32 num_bytes, btrfs_func_t finish_func,
> +				bool uptodate)
>   {
> -	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>   	struct btrfs_ordered_inode_tree *tree = &inode->ordered_tree;
> +	struct btrfs_fs_info *fs_info = inode->root->fs_info;
> +	struct btrfs_workqueue *wq;
>   	struct rb_node *node;
>   	struct btrfs_ordered_extent *entry = NULL;
> -	bool finished = false;
>   	unsigned long flags;
> -	u64 dec_end;
> -	u64 dec_start;
> -	u32 to_dec;
> +	u64 cur = file_offset;
> +
> +	if (btrfs_is_free_space_inode(inode))
> +		wq = fs_info->endio_freespace_worker;
> +	else
> +		wq = fs_info->endio_write_workers;
> +
> +	if (page)
> +		ASSERT(page->mapping && page_offset(page) <= file_offset &&
> +			file_offset + num_bytes <= page_offset(page) + PAGE_SIZE);
>   
>   	spin_lock_irqsave(&tree->lock, flags);
> -	node = tree_search(tree, *file_offset);
> -	if (!node)
> -		goto out;
> +	while (cur < file_offset + num_bytes) {
> +		u64 entry_end;
> +		u64 end;
> +		u32 len;
>   
> -	entry = rb_entry(node, struct btrfs_ordered_extent, rb_node);
> -	if (!in_range(*file_offset, entry->file_offset, entry->num_bytes))
> -		goto out;
> +		node = tree_search(tree, cur);
> +		/* No ordered extent at all */
> +		if (!node)
> +			break;
>   
> -	dec_start = max(*file_offset, entry->file_offset);
> -	dec_end = min(*file_offset + io_size,
> -		      entry->file_offset + entry->num_bytes);
> -	*file_offset = dec_end;
> -	if (dec_start > dec_end) {
> -		btrfs_crit(fs_info, "bad ordering dec_start %llu end %llu",
> -			   dec_start, dec_end);
> -	}
> -	to_dec = dec_end - dec_start;
> -	if (to_dec > entry->bytes_left) {
> -		btrfs_crit(fs_info,
> -			   "bad ordered accounting left %u size %u",
> -			   entry->bytes_left, to_dec);
> -	}
> -	entry->bytes_left -= to_dec;
> -	if (!uptodate)
> -		set_bit(BTRFS_ORDERED_IOERR, &entry->flags);
> +		entry = rb_entry(node, struct btrfs_ordered_extent, rb_node);
> +		entry_end = entry->file_offset + entry->num_bytes;
> +		/*
> +		 * |<-- OE --->|  |
> +		 *		  cur
> +		 * Go to next OE.
> +		 */
> +		if (cur >= entry_end) {
> +			node = rb_next(node);
> +			/* No more ordered extents, exit*/
> +			if (!node)
> +				break;
> +			entry = rb_entry(node, struct btrfs_ordered_extent,
> +					 rb_node);
> +
> +			/* Go next ordered extent and continue */
> +			cur = entry->file_offset;
> +			continue;
> +		}
> +		/*
> +		 * |	|<--- OE --->|
> +		 * cur
> +		 * Go to the start of OE.
> +		 */
> +		if (cur < entry->file_offset) {
> +			cur = entry->file_offset;
> +			continue;
> +		}

I think we need to yell loudly here, right?  Because if we got an endio for a 
range that isn't covered by an OE we have a serious problem, or am I missing 
something?  Thanks,

Josef
