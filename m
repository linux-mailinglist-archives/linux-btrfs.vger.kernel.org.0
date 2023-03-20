Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FE46C106C
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Mar 2023 12:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjCTLMr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Mar 2023 07:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjCTLMY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Mar 2023 07:12:24 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0145C125AA
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 04:09:04 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mwwdf-1qPPp23i5D-00yPH6; Mon, 20
 Mar 2023 12:08:52 +0100
Message-ID: <c797c695-cd20-9ab6-7b12-19e43ab1069c@gmx.com>
Date:   Mon, 20 Mar 2023 19:08:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 01/10] btrfs: use a plain workqueue for ordered_extent
 processing
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org
References: <20230314165910.373347-1-hch@lst.de>
 <20230314165910.373347-2-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230314165910.373347-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:qjswc6KfgoZL47Cy0diu/kwcypmWvC4fYB5DK7cN/L/gyd+wkTd
 peHMXY0ZyeSyRDtKGk+QY0yFkFYfiWeps678Z8oXDIBZhUVFfh2MrhaI3Hzsk6mll+7Svs7
 gX7XZzwamBIWL+IkidNBf5QcMHlWG18ab6ePnWY+BH+tJdtUCH8sTqW5SRNDx0K9DRVMmyZ
 9aWW7PvOnymgDY7Xt63vw==
UI-OutboundReport: notjunk:1;M01:P0:P/0zekla5w8=;RFqOyLjoBMLR0gmMdJlQ+1ICpnE
 Z/ajmnEcbqd9eEqbwL+z71ydDr3M5Y/7DxiOypDjMuvhlTIIxbi5hSQYe8Q+4ckwr/AFklqI6
 gubp3nji6WpgznQqE8V8yQ8QwoyDKwiucj/L+Ih9c6ebLfwnalZLM7K0ycitWlxybZpnUYOJR
 weBFa+kCFebYPeh2qSamS1epkU3EzywFoNaRQvMdFffvmk3i8Xsy26YTcrx0E3PEFxI2wbdw8
 K+7JZbxTc4+MHkQDGza0rFhRnPsng7/eDG9w2pfLEaPkV4dhmIml8sN5dNpohLLW/iqEBgGe0
 B/G2/F4/wh5YB9aOD07GYg6jXPLQPcz075TPc7j6cyJ/cBbX2OTnq0aDU6asNdv8dOon9Y3/Y
 W841ti/qqcHqC1d2dp5CPTJF/epDiff8O81+gSCfSQwqp2oM+zuaqv25PNFJpe3OGvEaSo3Dd
 /43Zc3J6ryl2Goo5pOBGT9TCUjuDO6YjKeIwL744T89QDG5GVZsMmzx0ohEOwRv8BhvvKbysb
 ix6Ft2bNxOXeLppoC7pmGqycNirbuyzkke6/1BDbzoGIvLBmTurOniZckje9rXIlk2UMvylTR
 4KfrSvaF/HwYNgSPKMiaIBIrZbcANdtrTDr0zzSpv98iM524dPAlO7TLWSrGncYa4oYPJ1jDa
 sRUBUio6QOKHnjDwTcLb3uj6I9ZVO3oyWBrau5ZKaaBarkMZzYFn+GM5TkeYiemv2EH4uuLxj
 qnS0KW+FQwCuIfnzmb5sMZRlxYZ2bRpScdI8vOexK3uzgBPqXfQbcXzQHydFpLd+hGSHMAGUJ
 SYVKg0KpQ3raCvAIQu3aiOKOe/9qiyVVtAGLbZk3Hh6PSYr6x6/NpECYb+FnCLXQ5UEh/K2MX
 RRE5oTkxS6XYOprdj3Vf7ZYycUX6iAbEFVPxZj3uZ5N8TgwVk7tfTU+MTjT4G3kkeokOYaNEi
 kfApNut6FD7rCBB+xW6ocUzTgGs=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/15 00:59, Christoph Hellwig wrote:
> The endio_write_workers and endio_freespace_workers workqueues don't use
> any of the ordering features in the btrfs_workqueue, so switch them to
> plain Linux workqueues.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/disk-io.c      | 16 ++++++++--------
>   fs/btrfs/fs.h           |  4 ++--
>   fs/btrfs/ordered-data.c |  8 ++++----
>   fs/btrfs/ordered-data.h |  2 +-
>   fs/btrfs/super.c        |  2 --
>   5 files changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index bb864cf2eed60f..0889eb81e71a7d 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1993,8 +1993,10 @@ static void btrfs_stop_all_workers(struct btrfs_fs_info *fs_info)
>   		destroy_workqueue(fs_info->rmw_workers);
>   	if (fs_info->compressed_write_workers)
>   		destroy_workqueue(fs_info->compressed_write_workers);
> -	btrfs_destroy_workqueue(fs_info->endio_write_workers);
> -	btrfs_destroy_workqueue(fs_info->endio_freespace_worker);
> +	if (fs_info->endio_write_workers)
> +		destroy_workqueue(fs_info->endio_write_workers);
> +	if (fs_info->endio_freespace_worker)
> +		destroy_workqueue(fs_info->endio_freespace_worker);
>   	btrfs_destroy_workqueue(fs_info->delayed_workers);
>   	btrfs_destroy_workqueue(fs_info->caching_workers);
>   	btrfs_destroy_workqueue(fs_info->flush_workers);
> @@ -2204,13 +2206,11 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
>   		alloc_workqueue("btrfs-endio-meta", flags, max_active);
>   	fs_info->rmw_workers = alloc_workqueue("btrfs-rmw", flags, max_active);
>   	fs_info->endio_write_workers =
> -		btrfs_alloc_workqueue(fs_info, "endio-write", flags,
> -				      max_active, 2);
> +		alloc_workqueue("btrfs-endio-write", flags, max_active);
>   	fs_info->compressed_write_workers =
>   		alloc_workqueue("btrfs-compressed-write", flags, max_active);
>   	fs_info->endio_freespace_worker =
> -		btrfs_alloc_workqueue(fs_info, "freespace-write", flags,
> -				      max_active, 0);
> +		alloc_workqueue("btrfs-freespace-write", flags, max_active);
>   	fs_info->delayed_workers =
>   		btrfs_alloc_workqueue(fs_info, "delayed-meta", flags,
>   				      max_active, 0);
> @@ -4536,9 +4536,9 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
>   	 * the final btrfs_put_ordered_extent() (which must happen at
>   	 * btrfs_finish_ordered_io() when we are unmounting).
>   	 */
> -	btrfs_flush_workqueue(fs_info->endio_write_workers);
> +	flush_workqueue(fs_info->endio_write_workers);
>   	/* Ordered extents for free space inodes. */
> -	btrfs_flush_workqueue(fs_info->endio_freespace_worker);
> +	flush_workqueue(fs_info->endio_freespace_worker);
>   	btrfs_run_delayed_iputs(fs_info);
>   
>   	cancel_work_sync(&fs_info->async_reclaim_work);
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 20d554a0c2ac0d..276a17780f2b1b 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -542,8 +542,8 @@ struct btrfs_fs_info {
>   	struct workqueue_struct *endio_meta_workers;
>   	struct workqueue_struct *rmw_workers;
>   	struct workqueue_struct *compressed_write_workers;
> -	struct btrfs_workqueue *endio_write_workers;
> -	struct btrfs_workqueue *endio_freespace_worker;
> +	struct workqueue_struct *endio_write_workers;
> +	struct workqueue_struct *endio_freespace_worker;
>   	struct btrfs_workqueue *caching_workers;
>   
>   	/*
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index 1848d0d1a9c41e..23f496f0d7b776 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -303,7 +303,7 @@ void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
>   	spin_unlock_irq(&tree->lock);
>   }
>   
> -static void finish_ordered_fn(struct btrfs_work *work)
> +static void finish_ordered_fn(struct work_struct *work)
>   {
>   	struct btrfs_ordered_extent *ordered_extent;
>   
> @@ -330,7 +330,7 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
>   {
>   	struct btrfs_ordered_inode_tree *tree = &inode->ordered_tree;
>   	struct btrfs_fs_info *fs_info = inode->root->fs_info;
> -	struct btrfs_workqueue *wq;
> +	struct workqueue_struct *wq;
>   	struct rb_node *node;
>   	struct btrfs_ordered_extent *entry = NULL;
>   	unsigned long flags;
> @@ -439,8 +439,8 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
>   			refcount_inc(&entry->refs);
>   			trace_btrfs_ordered_extent_mark_finished(inode, entry);
>   			spin_unlock_irqrestore(&tree->lock, flags);
> -			btrfs_init_work(&entry->work, finish_ordered_fn, NULL, NULL);
> -			btrfs_queue_work(wq, &entry->work);
> +			INIT_WORK(&entry->work, finish_ordered_fn);
> +			queue_work(wq, &entry->work);
>   			spin_lock_irqsave(&tree->lock, flags);
>   		}
>   		cur += len;
> diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
> index 18007f9c00add8..b8a92f040458f0 100644
> --- a/fs/btrfs/ordered-data.h
> +++ b/fs/btrfs/ordered-data.h
> @@ -146,7 +146,7 @@ struct btrfs_ordered_extent {
>   	/* a per root list of all the pending ordered extents */
>   	struct list_head root_extent_list;
>   
> -	struct btrfs_work work;
> +	struct work_struct work;
>   
>   	struct completion completion;
>   	struct btrfs_work flush_work;
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index d8885966e801cd..065b4fab1ee011 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -1632,8 +1632,6 @@ static void btrfs_resize_thread_pool(struct btrfs_fs_info *fs_info,
>   	btrfs_workqueue_set_max(fs_info->hipri_workers, new_pool_size);
>   	btrfs_workqueue_set_max(fs_info->delalloc_workers, new_pool_size);
>   	btrfs_workqueue_set_max(fs_info->caching_workers, new_pool_size);
> -	btrfs_workqueue_set_max(fs_info->endio_write_workers, new_pool_size);
> -	btrfs_workqueue_set_max(fs_info->endio_freespace_worker, new_pool_size);

I guess we need workqueue_set_max_active() for all our plain work queues 
too.

Thanks,
Qu

>   	btrfs_workqueue_set_max(fs_info->delayed_workers, new_pool_size);
>   }
>   
