Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FDD4A9D38
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 17:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376688AbiBDQ4w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 11:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376686AbiBDQ4w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 11:56:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44172C06173E
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Feb 2022 08:56:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F7D1B837F9
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Feb 2022 16:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A94C004E1;
        Fri,  4 Feb 2022 16:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643993808;
        bh=1RA0zF5bN5wSMni6NE7pRu8aL1a6beFAj/VAUrFuXTc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DBHPTV72K8dAr3i61DKlDEN10h+etDet2yz1RIdcJUhtD+x/FAUObTUccQ8EffhQp
         0BOUCtSLdyjvA7ZoogjxK4Sl4Q2vq9a78yxkbhe2PEUrgF7oNYDTaMcjIVpF5B6a1z
         qTnuO4Ur9BNT3miRuajNP+0ZhlmoSfehXl3CXK6d0g3oknrqDPGwtv5uYRxXI7fDh4
         AMP+FTXCf3i4tnZNI38L6FyIbvJLorM6+39U9IsMUmeaMkd/yxqYC7JldHnyerCPMk
         FKD8WLBBB+REzTc/wfCqhktnGJqrS+/Lz/7kFfcPj8t7fG2AO7ixsST7KwhPuCwzZO
         Ds4jwcYqh+pjA==
Date:   Fri, 4 Feb 2022 16:56:46 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 5/5] btrfs: defrag: allow defrag_one_cluster() to
 large extent which is not a target
Message-ID: <Yf1azilXKXv/13lf@debian9.Home>
References: <cover.1643961719.git.wqu@suse.com>
 <6aa51c24be3675deba0c696198d2c64e6113a11f.1643961719.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6aa51c24be3675deba0c696198d2c64e6113a11f.1643961719.git.wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 04, 2022 at 04:11:59PM +0800, Qu Wenruo wrote:
> In the rework of btrfs_defrag_file(), we always call
> defrag_one_cluster() and increase the offset by cluster size, which is
> only 256K.
> 
> But there are cases where we have a large extent (e.g. 128M) which
> doesn't need to be defragged at all.
> 
> Before the refactor, we can directly skip the range, but now we have to
> scan that extent map again and again until the cluster moves after the
> non-target extent.
> 
> Fix the problem by allow defrag_one_cluster() to increase
> btrfs_defrag_ctrl::last_scanned to the end of an extent, if and only if
> the last extent of the cluster is not a target.
> 
> The test script looks like this:
> 
> 	mkfs.btrfs -f $dev > /dev/null
> 
> 	mount $dev $mnt
> 
> 	# As btrfs ioctl uses 32M as extent_threshold
> 	xfs_io -f -c "pwrite 0 64M" $mnt/file1
> 	sync
> 	# Some fragemented range to defrag
> 	xfs_io -s -c "pwrite 65548k 4k" \
> 		  -c "pwrite 65544k 4k" \
> 		  -c "pwrite 65540k 4k" \
> 		  -c "pwrite 65536k 4k" \
> 		  $mnt/file1
> 	sync
> 
> 	echo "=== before ==="
> 	xfs_io -c "fiemap -v" $mnt/file1
> 	echo "=== after ==="
> 	btrfs fi defrag $mnt/file1
> 	sync
> 	xfs_io -c "fiemap -v" $mnt/file1
> 	umount $mnt
> 
> With extra ftrace put into defrag_one_cluster(), before the patch it
> would result tons of loops:
> 
> (As defrag_one_cluster() is inlined, the function name is its caller)
> 
>   btrfs-126062  [005] .....  4682.816026: btrfs_defrag_file: r/i=5/257 start=0 len=262144
>   btrfs-126062  [005] .....  4682.816027: btrfs_defrag_file: r/i=5/257 start=262144 len=262144
>   btrfs-126062  [005] .....  4682.816028: btrfs_defrag_file: r/i=5/257 start=524288 len=262144
>   btrfs-126062  [005] .....  4682.816028: btrfs_defrag_file: r/i=5/257 start=786432 len=262144
>   btrfs-126062  [005] .....  4682.816028: btrfs_defrag_file: r/i=5/257 start=1048576 len=262144
>   ...
>   btrfs-126062  [005] .....  4682.816043: btrfs_defrag_file: r/i=5/257 start=67108864 len=262144
> 
> But with this patch there will be just one loop, then directly to the
> end of the extent:
> 
>   btrfs-130471  [014] .....  5434.029558: defrag_one_cluster: r/i=5/257 start=0 len=262144
>   btrfs-130471  [014] .....  5434.029559: defrag_one_cluster: r/i=5/257 start=67108864 len=16384
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/ioctl.c | 40 ++++++++++++++++++++++++++++++++++------
>  1 file changed, 34 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 567a662df118..999173d0925b 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1185,10 +1185,11 @@ struct defrag_target_range {
>   */
>  static int defrag_collect_targets(struct btrfs_inode *inode,
>  				  const struct btrfs_defrag_ctrl *ctrl,
> -				  u64 start, u32 len, bool locked,
> -				  struct list_head *target_list)
> +				  u64 start, u32 len, u64 *last_scanned_ret,
> +				  bool locked, struct list_head *target_list)
>  {
>  	bool do_compress = ctrl->flags & BTRFS_DEFRAG_RANGE_COMPRESS;
> +	bool last_is_target = false;
>  	u64 cur = start;
>  	int ret = 0;
>  
> @@ -1198,6 +1199,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
>  		bool next_mergeable = true;
>  		u64 range_len;
>  
> +		last_is_target = false;
>  		em = defrag_lookup_extent(&inode->vfs_inode, cur, locked);
>  		if (!em)
>  			break;
> @@ -1269,6 +1271,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
>  		}
>  
>  add:
> +		last_is_target = true;
>  		range_len = min(extent_map_end(em), start + len) - cur;
>  		/*
>  		 * This one is a good target, check if it can be merged into
> @@ -1312,6 +1315,17 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
>  			kfree(entry);
>  		}
>  	}
> +	if (!ret && last_scanned_ret) {
> +		/*
> +		 * If the last extent is not a target, the caller can skip to
> +		 * the end of that extent.
> +		 * Otherwise, we can only go the end of the spcified range.
> +		 */
> +		if (!last_is_target)
> +			*last_scanned_ret = cur;
> +		else
> +			*last_scanned_ret = start + len;
> +	}
>  	return ret;
>  }
>  
> @@ -1382,6 +1396,7 @@ static int defrag_one_range(struct btrfs_inode *inode,
>  	const u32 sectorsize = inode->root->fs_info->sectorsize;
>  	u64 last_index = (start + len - 1) >> PAGE_SHIFT;
>  	u64 start_index = start >> PAGE_SHIFT;
> +	u64 last_scanned;
>  	unsigned int nr_pages = last_index - start_index + 1;
>  	int ret = 0;
>  	int i;
> @@ -1416,8 +1431,8 @@ static int defrag_one_range(struct btrfs_inode *inode,
>  	 * And this time we have extent locked already, pass @locked = true
>  	 * so that we won't relock the extent range and cause deadlock.
>  	 */
> -	ret = defrag_collect_targets(inode, ctrl, start, len, true,
> -				     &target_list);
> +	ret = defrag_collect_targets(inode, ctrl, start, len, &last_scanned,
> +				     true, &target_list);
>  	if (ret < 0)
>  		goto unlock_extent;
>  
> @@ -1434,6 +1449,8 @@ static int defrag_one_range(struct btrfs_inode *inode,
>  		list_del_init(&entry->list);
>  		kfree(entry);
>  	}
> +	if (!ret)
> +		ctrl->last_scanned = last_scanned;
>  unlock_extent:
>  	unlock_extent_cached(&inode->io_tree, start_index << PAGE_SHIFT,
>  			     (last_index << PAGE_SHIFT) + PAGE_SIZE - 1,
> @@ -1461,13 +1478,14 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
>  			      struct btrfs_defrag_ctrl *ctrl, u32 len)
>  {
>  	const u32 sectorsize = inode->root->fs_info->sectorsize;
> +	u64 orig_start = ctrl->last_scanned;

Can be made const.
It helps to read the code and avoid regressions where we update the
wrong variable by mistake - the const makes it easy to trigger.

Just a minor comment like in the previous patches. I won't make you send
another version just because of that.

I'll reply to cover letter with the review tag.

Thanks.

>  	struct defrag_target_range *entry;
>  	struct defrag_target_range *tmp;
>  	LIST_HEAD(target_list);
>  	int ret;
>  
>  	ret = defrag_collect_targets(inode, ctrl, ctrl->last_scanned, len,
> -				     false, &target_list);
> +				     NULL, false, &target_list);
>  	if (ret < 0)
>  		goto out;
>  
> @@ -1486,6 +1504,15 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
>  					  (ctrl->max_sectors_to_defrag -
>  					   ctrl->sectors_defragged) * sectorsize);
>  
> +		/*
> +		 * If defrag_one_range() has updated ctrl::last_scanned,
> +		 * our range may already be invalid (e.g. hole punched).
> +		 * Skip if our range is before ctrl::last_scanned, as there is
> +		 * no need to defrag the range anymore.
> +		 */
> +		if (entry->start + range_len <= ctrl->last_scanned)
> +			continue;
> +
>  		if (ra)
>  			page_cache_sync_readahead(inode->vfs_inode.i_mapping,
>  				ra, NULL, entry->start >> PAGE_SHIFT,
> @@ -1500,6 +1527,8 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
>  		list_del_init(&entry->list);
>  		kfree(entry);
>  	}
> +	if (ret >= 0)
> +		ctrl->last_scanned = max(ctrl->last_scanned, orig_start + len);
>  	return ret;
>  }
>  
> @@ -1645,7 +1674,6 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
>  		btrfs_inode_unlock(inode, 0);
>  		if (ret < 0)
>  			break;
> -		ctrl->last_scanned = cluster_end + 1;
>  		if (ret > 0) {
>  			ret = 0;
>  			break;
> -- 
> 2.35.0
> 
