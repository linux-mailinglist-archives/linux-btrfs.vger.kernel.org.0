Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFDD54A14F
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jun 2022 23:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbiFMVZg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jun 2022 17:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbiFMVZL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jun 2022 17:25:11 -0400
X-Greylist: delayed 490 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Jun 2022 14:13:18 PDT
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C9C37AAC
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 14:13:17 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 53EFB80BA8;
        Mon, 13 Jun 2022 17:05:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1655154306; bh=W3pVdRvY1Bo2Dz6+OLyElIGBbfI13xAH+rjVUZUHmaw=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=rHC5+KpLr6VtvdpY0iI3HC9xRrvPwgjVlrLCuN646lr9/2vduc9+MdwaWAqixUBL2
         2mqduSedtxz3vv8Q2s8pGzf6/K+6cHQu8enBLNBVrekEctnQfqZZcu3aTF3ivw2z9k
         j9oMXF6Tywex1AHSjiAlGOf7ga7yLPEeoNLHEJuNKJKk3EKfYqPkvDPYNq1s7x5Tmp
         12+pPkOuJfKjw5VdbEyI7nA1JoJYGghm3wkOuFESXBGuOF4Hizj2crFbkMxb0iJ2N8
         vFfu9uZeMhWmA0QvzPUBWzIUGsK3AQ3H0jQ7FUXbPeYtqcw+fbUQI5IUBmZv7qfvZN
         a7p+1nC3l+ryw==
Message-ID: <4ecbbf88-4f83-92e3-d8ca-90dec9f1a053@dorminy.me>
Date:   Mon, 13 Jun 2022 17:05:05 -0400
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] btrfs: Add the capability of getting commit stats in
 BTRFS
Content-Language: en-US
To:     Ioannis Angelakopoulos <iangelak@fb.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20220610205406.301397-1-iangelak@fb.com>
 <20220610205406.301397-2-iangelak@fb.com>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <20220610205406.301397-2-iangelak@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 6/10/22 16:54, Ioannis Angelakopoulos wrote:
> First we add  "struct btrfs_commit_stats" data structure under "fs_info"
> to store the commit stats for BTRFS that will be exposed through sysfs
> 
> The stats exposed are: 1) The number of commits so far, 2) The duration of
> the last commit in ms, 3) The maximum commit duration seen so far in ms
> and 4) The total duration for all commits so far in ms.
> 
> The update of the commit stats occurs after the commit thread has gone
> through all the logic that checks if there is another thread committing
> at the same time. This means that we only account for actual commit work
> in the commit stats we report and not the time the thread spends waiting
> until it is ready to do the commit work.
> 
> Signed-off-by: Ioannis Angelakopoulos <iangelak@fb.com>
> ---
>   fs/btrfs/ctree.h       | 14 ++++++++++++++
>   fs/btrfs/disk-io.c     |  6 ++++++
>   fs/btrfs/transaction.c | 38 +++++++++++++++++++++++++++++++++++++-
>   3 files changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index f7afdfd0bae7..d4cc38451c7b 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -660,6 +660,18 @@ enum btrfs_exclusive_operation {
>   	BTRFS_EXCLOP_SWAP_ACTIVATE,
>   };
>   
> +/* Storing data about btrfs commits. The data are accessible over sysfs */
> +struct btrfs_commit_stats {
> +	/* Total number of commits */
> +	u64 commit_counter;
> +	/* The maximum commit duration so far*/
> +	u64 max_commit_dur;
> +	/* The last commit duration */
> +	u64 last_commit_dur;
> +	/* The total commit duration */
> +	u64 total_commit_dur;
> +};
> +
>   struct btrfs_fs_info {
>   	u8 chunk_tree_uuid[BTRFS_UUID_SIZE];
>   	unsigned long flags;
> @@ -1082,6 +1094,8 @@ struct btrfs_fs_info {
>   	spinlock_t eb_leak_lock;
>   	struct list_head allocated_ebs;
>   #endif
> +
> +	struct btrfs_commit_stats *commit_stats;
>   };
>   
>   static inline struct btrfs_fs_info *btrfs_sb(struct super_block *sb)
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 800ad3a9c68e..1c366ea01a9f 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1668,6 +1668,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
>   	btrfs_free_ref_cache(fs_info);
>   	kfree(fs_info->balance_ctl);
>   	kfree(fs_info->delayed_root);
> +	kfree(fs_info->commit_stats);
>   	free_global_roots(fs_info);
>   	btrfs_put_root(fs_info->tree_root);
>   	btrfs_put_root(fs_info->chunk_root);
> @@ -3174,6 +3175,11 @@ static int init_mount_fs_info(struct btrfs_fs_info *fs_info, struct super_block
>   		return -ENOMEM;
>   	btrfs_init_delayed_root(fs_info->delayed_root);
>   
> +	fs_info->commit_stats = kzalloc(sizeof(struct btrfs_commit_stats),
> +					GFP_KERNEL);
> +	if (!fs_info->commit_stats)
> +		return -ENOMEM;
> +
>   	if (sb_rdonly(sb))
>   		set_bit(BTRFS_FS_STATE_RO, &fs_info->fs_state);
>   
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 06c0a958d114..fb2a9bc9bae4 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -10,6 +10,7 @@
>   #include <linux/pagemap.h>
>   #include <linux/blkdev.h>
>   #include <linux/uuid.h>
> +#include <linux/timekeeping.h>
>   #include "misc.h"
>   #include "ctree.h"
>   #include "disk-io.h"
> @@ -674,7 +675,7 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
>   	 * and then we deadlock with somebody doing a freeze.
>   	 *
>   	 * If we are ATTACH, it means we just want to catch the current
> -	 * transaction and commit it, so we needn't do sb_start_intwrite().
> +	 * transaction and commit it, so we needn't do sb_start_intwrite().
>   	 */
>   	if (type & __TRANS_FREEZABLE)
>   		sb_start_intwrite(fs_info->sb);
> @@ -2084,12 +2085,30 @@ static void add_pending_snapshot(struct btrfs_trans_handle *trans)
>   	list_add(&trans->pending_snapshot->list, &cur_trans->pending_snapshots);
>   }
>   
> +static void update_commit_stats(struct btrfs_fs_info *fs_info,
> +								ktime_t interval)
> +{
> +	/* Increase the successful commits counter */
> +	fs_info->commit_stats->commit_counter += 1;
> +	/* Update the last commit duration */
> +	fs_info->commit_stats->last_commit_dur = interval / 1000000;
> +	/* Update the maximum commit duration */
> +	fs_info->commit_stats->max_commit_dur =
> +				fs_info->commit_stats->max_commit_dur >	interval / 1000000 ?
> +				fs_info->commit_stats->max_commit_dur :	interval / 1000000;
could use max(fs_info->commit_stats->max_commit_dur, interval) for less 
duplication.
> +	/* Update the total commit duration */
> +	fs_info->commit_stats->total_commit_dur += interval / 1000000;
> +}

Why not store as ns? You could do the conversion at display time for a 
slight increase in accuracy of total_commit_dur (consider samples of 2.8 
ms, 2.8 ms, 1.4 ms: this code would print total duration of 5 ms, if I 
understand rightly, but 7 ms is the actual total).

Might also use the macro NSEC_PER_MSEC instead of 1000000.

> +
>   int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>   {
>   	struct btrfs_fs_info *fs_info = trans->fs_info;
>   	struct btrfs_transaction *cur_trans = trans->transaction;
>   	struct btrfs_transaction *prev_trans = NULL;
>   	int ret;
> +	ktime_t start_time;
> +	ktime_t end_time;
> +	ktime_t interval;
>   
>   	ASSERT(refcount_read(&trans->use_count) == 1);
>   
> @@ -2214,6 +2233,12 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>   		}
>   	}
>   
> +	/*
> +	 * Get the time spent on the work done by the commit thread and not
> +	 * the time spent on a previous commit
> +	 */
> +	start_time = ktime_get_ns();
> +
>   	extwriter_counter_dec(cur_trans, trans->type);
>   
>   	ret = btrfs_start_delalloc_flush(fs_info);
> @@ -2462,6 +2487,17 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>   
>   	kmem_cache_free(btrfs_trans_handle_cachep, trans);
>   
> +	end_time = ktime_get_ns();
> +	interval = end_time - start_time;
> +
> +	/*
> +	 * Protect the commit stats updates from concurrent updates through
> +	 * sysfs.
> +	 */
> +	spin_lock(&fs_info->trans_lock);
> +	update_commit_stats(fs_info, interval);
> +	spin_unlock(&fs_info->trans_lock)
> +
>   	return ret;
>   
>   unlock_reloc:
