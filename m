Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35477362186
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Apr 2021 15:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbhDPNzT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 09:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhDPNzS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 09:55:18 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC48FC061574
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 06:54:53 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id f19so11158844qka.8
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 06:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=zcaOQkFu3M8oOP9JJATTnL9+yxsH2xhqmA3wvCp68Q4=;
        b=i+aqyDnGLhyg7eonk6stcIKYET9EjWEu+ANcyG4AWXqjerHrqEK3ALO4s+7AvUyG3E
         CZu0c7XIx/RqXQ86IscK1FJUtcJ2eHsf1z4xAThF5fDhGiMDzgDrL4tJ54N5yoxDq1aS
         YI7kWMZIrGUXTQ/+3urq6J3I6opRNCqQSUPQ+mF1kWWRaDS82UTgVmi5Qng5IReM0ge3
         8BG0bLg34a8IMx/FO9lynIj8eNjHuV9tNfLvj4Wx5CgXD8ZMHCCw3Bd/tiqhfDEBrC+G
         xAm0xzz1TsOwJ4z8NxXU0oTkru5bQbEEQQrc2gW/I1/qPyTfYztSKhmCHerYnZBlYMH/
         j+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zcaOQkFu3M8oOP9JJATTnL9+yxsH2xhqmA3wvCp68Q4=;
        b=m5Wgwd8CLXx+cA5BreI8nMHm5mXQjnlKK+v14im0a4mOicmlLA4+fBMPZln3xELL0b
         t7TSSg0e+vHmZBdQlOrwWyjSh3j2mIFmw5+c9fXjWWzmFKliaAiEEcArWSaGWc1rYFeu
         97xITDDwUPSgt94W5boa7yhKMdZioQtA10igMJItQWmdkuVCTyNzJAhqxr4CkCqfYtUL
         qI/ut4A9It5TfXGLupoMSxzcghfhr+lfOUiCMJ08gNCKYBmPmzhuOsDV0hN2YpO9c1J0
         qaWxU5/4803/22T/acAqyphcuU3cSOmhFIkTn2K2e18AeZGINDS9lrsQHytZTlLtp20F
         McHA==
X-Gm-Message-State: AOAM530jpgz5ZZ1s4XTp6QZYD46UPWgC52EzXW5baX8PW0Q2A7ug3AzD
        kY8ixeSIoXixs9SZapqAJhwZvaymeg4KuQ==
X-Google-Smtp-Source: ABdhPJxsNLzxZyS9lxYOrE/ZjexQHuTDmlAlm2OYqMpDqZOzgxLWFQTxXKV9ulc19qyW0hbttuoydg==
X-Received: by 2002:a37:8bc5:: with SMTP id n188mr8553934qkd.441.1618581292800;
        Fri, 16 Apr 2021 06:54:52 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f14sm4212983qka.54.2021.04.16.06.54.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 06:54:52 -0700 (PDT)
Subject: Re: [PATCH 07/42] btrfs: use u32 for length related members of
 btrfs_ordered_extent
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210415050448.267306-1-wqu@suse.com>
 <20210415050448.267306-8-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <5160a3e9-1612-45d9-a1ba-71fdcf9b8b24@toxicpanda.com>
Date:   Fri, 16 Apr 2021 09:54:51 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210415050448.267306-8-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/15/21 1:04 AM, Qu Wenruo wrote:
> Unlike btrfs_file_extent_item, btrfs_ordered_extent has its length
> limit (BTRFS_MAX_EXTENT_SIZE), which is far smaller than U32_MAX.
> 
> Using u64 for those length related members are just a waste of memory.
> 
> This patch will make the following members u32:
> - num_bytes
> - disk_num_bytes
> - bytes_left
> - truncated_len
> 
> This will save 16 bytes for btrfs_ordered_extent structure.
> 
> For btrfs_add_ordered_extent*() call sites, they are mostly deeply
> inside other functions passing u64.
> Thus this patch will keep those u64, but do internal ASSERT() to ensure
> the correct length values are passed in.
> 
> For btrfs_dec_test_.*_ordered_extent() call sites, length related
> parameters are converted to u32, with extra ASSERT() added to ensure we
> get correct values passed in.
> 
> There is special convert needed in btrfs_remove_ordered_extent(), which
> needs s64, using "-entry->num_bytes" from u32 directly will cause
> underflow.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/inode.c        | 11 ++++++++---
>   fs/btrfs/ordered-data.c | 21 ++++++++++++++-------
>   fs/btrfs/ordered-data.h | 25 ++++++++++++++-----------
>   3 files changed, 36 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 74ee34fc820d..554effbf307e 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3066,6 +3066,7 @@ void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
>   	struct btrfs_ordered_extent *ordered_extent = NULL;
>   	struct btrfs_workqueue *wq;
>   
> +	ASSERT(end + 1 - start < U32_MAX);
>   	trace_btrfs_writepage_end_io_hook(page, start, end, uptodate);
>   
>   	ClearPagePrivate2(page);
> @@ -7969,6 +7970,7 @@ static void __endio_write_update_ordered(struct btrfs_inode *inode,
>   	else
>   		wq = fs_info->endio_write_workers;
>   
> +	ASSERT(bytes < U32_MAX);
>   	while (ordered_offset < offset + bytes) {
>   		last_offset = ordered_offset;
>   		if (btrfs_dec_test_first_ordered_pending(inode, &ordered,
> @@ -8415,10 +8417,13 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
>   		if (TestClearPagePrivate2(page)) {
>   			spin_lock_irq(&inode->ordered_tree.lock);
>   			set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
> -			ordered->truncated_len = min(ordered->truncated_len,
> -						     start - ordered->file_offset);
> +			ASSERT(start - ordered->file_offset < U32_MAX);
> +			ordered->truncated_len = min_t(u32,
> +						ordered->truncated_len,
> +						start - ordered->file_offset);
>   			spin_unlock_irq(&inode->ordered_tree.lock);
>   
> +			ASSERT(end - start + 1 < U32_MAX);
>   			if (btrfs_dec_test_ordered_pending(inode, &ordered,
>   							   start,
>   							   end - start + 1, 1)) {
> @@ -8937,7 +8942,7 @@ void btrfs_destroy_inode(struct inode *vfs_inode)
>   			break;
>   		else {
>   			btrfs_err(root->fs_info,
> -				  "found ordered extent %llu %llu on inode cleanup",
> +				  "found ordered extent %llu %u on inode cleanup",
>   				  ordered->file_offset, ordered->num_bytes);
>   			btrfs_remove_ordered_extent(inode, ordered);
>   			btrfs_put_ordered_extent(ordered);
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index 07b0b4218791..8e6d9d906bdd 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -160,6 +160,12 @@ static int __btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset
>   	struct btrfs_ordered_extent *entry;
>   	int ret;
>   
> +	/*
> +	 * Basic size check, all length related members should be smaller
> +	 * than U32_MAX.
> +	 */
> +	ASSERT(num_bytes < U32_MAX && disk_num_bytes < U32_MAX);
> +
>   	if (type == BTRFS_ORDERED_NOCOW || type == BTRFS_ORDERED_PREALLOC) {
>   		/* For nocow write, we can release the qgroup rsv right now */
>   		ret = btrfs_qgroup_free_data(inode, NULL, file_offset, num_bytes);
> @@ -186,7 +192,7 @@ static int __btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset
>   	entry->bytes_left = num_bytes;
>   	entry->inode = igrab(&inode->vfs_inode);
>   	entry->compress_type = compress_type;
> -	entry->truncated_len = (u64)-1;
> +	entry->truncated_len = (u32)-1;
>   	entry->qgroup_rsv = ret;
>   	entry->physical = (u64)-1;
>   	entry->disk = NULL;
> @@ -320,7 +326,7 @@ void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
>    */
>   bool btrfs_dec_test_first_ordered_pending(struct btrfs_inode *inode,
>   				   struct btrfs_ordered_extent **finished_ret,
> -				   u64 *file_offset, u64 io_size, int uptodate)
> +				   u64 *file_offset, u32 io_size, int uptodate)
>   {
>   	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>   	struct btrfs_ordered_inode_tree *tree = &inode->ordered_tree;
> @@ -330,7 +336,7 @@ bool btrfs_dec_test_first_ordered_pending(struct btrfs_inode *inode,
>   	unsigned long flags;
>   	u64 dec_end;
>   	u64 dec_start;
> -	u64 to_dec;
> +	u32 to_dec;
>   
>   	spin_lock_irqsave(&tree->lock, flags);
>   	node = tree_search(tree, *file_offset);
> @@ -352,7 +358,7 @@ bool btrfs_dec_test_first_ordered_pending(struct btrfs_inode *inode,
>   	to_dec = dec_end - dec_start;
>   	if (to_dec > entry->bytes_left) {
>   		btrfs_crit(fs_info,
> -			   "bad ordered accounting left %llu size %llu",
> +			   "bad ordered accounting left %u size %u",
>   			   entry->bytes_left, to_dec);
>   	}
>   	entry->bytes_left -= to_dec;
> @@ -397,7 +403,7 @@ bool btrfs_dec_test_first_ordered_pending(struct btrfs_inode *inode,
>    */
>   bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
>   				    struct btrfs_ordered_extent **cached,
> -				    u64 file_offset, u64 io_size, int uptodate)
> +				    u64 file_offset, u32 io_size, int uptodate)
>   {
>   	struct btrfs_ordered_inode_tree *tree = &inode->ordered_tree;
>   	struct rb_node *node;
> @@ -422,7 +428,7 @@ bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
>   
>   	if (io_size > entry->bytes_left)
>   		btrfs_crit(inode->root->fs_info,
> -			   "bad ordered accounting left %llu size %llu",
> +			   "bad ordered accounting left %u size %u",
>   		       entry->bytes_left, io_size);
>   
>   	entry->bytes_left -= io_size;
> @@ -495,7 +501,8 @@ void btrfs_remove_ordered_extent(struct btrfs_inode *btrfs_inode,
>   		btrfs_delalloc_release_metadata(btrfs_inode, entry->num_bytes,
>   						false);
>   
> -	percpu_counter_add_batch(&fs_info->ordered_bytes, -entry->num_bytes,
> +	percpu_counter_add_batch(&fs_info->ordered_bytes,
> +				 -(s64)entry->num_bytes,
>   				 fs_info->delalloc_batch);
>   
>   	tree = &btrfs_inode->ordered_tree;
> diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
> index e60c07f36427..6906df0c946c 100644
> --- a/fs/btrfs/ordered-data.h
> +++ b/fs/btrfs/ordered-data.h
> @@ -83,13 +83,22 @@ struct btrfs_ordered_extent {
>   	/*
>   	 * These fields directly correspond to the same fields in
>   	 * btrfs_file_extent_item.
> +	 *
> +	 * But since ordered extents can't be larger than BTRFS_MAX_EXTENT_SIZE,
> +	 * for length related members, they can use u32.
>   	 */
>   	u64 disk_bytenr;
> -	u64 num_bytes;
> -	u64 disk_num_bytes;
> +	u32 num_bytes;
> +	u32 disk_num_bytes;
>   
>   	/* number of bytes that still need writing */
> -	u64 bytes_left;
> +	u32 bytes_left;
> +
> +	/*
> +	 * If we get truncated we need to adjust the file extent we enter for
> +	 * this ordered extent so that we do not expose stale data.
> +	 */
> +	u32 truncated_len;
>   

This is the actual logical length of the file, which could be well above u32, so 
at the very least this needs to stay.

And I hate this patch in general.  Ok generally we are limited to 128mib, but we 
use u64 literally everywhere else for sizes, so using u64 here makes us 
consistent with the rest of how we address space and lengths, which is more 
valuable to me than saving 16bytes.  Thanks,

Josef
