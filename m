Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95514A8A46
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Feb 2022 18:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352933AbiBCRjh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Feb 2022 12:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352922AbiBCRjg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Feb 2022 12:39:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E4FC061714
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Feb 2022 09:39:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F62BB8339C
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Feb 2022 17:39:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54567C340ED;
        Thu,  3 Feb 2022 17:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643909972;
        bh=hF/uqnK66MJWv9C7wZeNX4oMYoT0+yr344zcZraCwfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sOuZee1HvpntFYRZSB5cfKPGwcBPK8pRsHq60qiSMcMHmsVE5+xQMAWpfs9gGs40Y
         voHX/TcA0Ix43pYj46qOmQgxwpCdJLG7JDOlYm05KY40am3ssN6zwruYop2VaVyrXd
         to1bTbecqxfgTSW4kWLuOfWI/DnLnKU9R4WUUopgOuWPBc6+utMYuS3c2n9Z59rPTq
         90EUN1JCRxv46BG2xCryS5yeko9hzCS21hxEr01vf4MwCN2YbfrJkt7fgBBFbnWWAF
         jo0t7so1+xFMbB4RETznzcfKrVAtB9Xt2LET4kwKOXyWN2cDt8yLxkLtsT+A/xlwmg
         VQ/IhNsyM8+lg==
Date:   Thu, 3 Feb 2022 17:39:30 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/4] btrfs: defrag: allow defrag_one_cluster() to large
 extent which is not a target
Message-ID: <YfwTUlD3okcrD4Zw@debian9.Home>
References: <cover.1643357469.git.wqu@suse.com>
 <fce83045d775e59ab8a6746e5ad09c474a0c90a2.1643357469.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fce83045d775e59ab8a6746e5ad09c474a0c90a2.1643357469.git.wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 28, 2022 at 04:12:58PM +0800, Qu Wenruo wrote:
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

Did you also measure how much time was spent before and after?
It would be interesting to have it here in case you have measured it.
If you don't have it, then it's fine.

> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/ioctl.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 67ba934be99e..592a542164a4 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1197,10 +1197,11 @@ struct defrag_target_range {
>   */
>  static int defrag_collect_targets(struct btrfs_inode *inode,
>  				  const struct btrfs_defrag_ctrl *ctrl,
> -				  u64 start, u32 len, bool locked,
> -				  struct list_head *target_list)
> +				  u64 start, u32 len, u64 *last_scanned_ret,
> +				  bool locked, struct list_head *target_list)
>  {
>  	bool do_compress = ctrl->flags & BTRFS_DEFRAG_RANGE_COMPRESS;
> +	bool last_target = false;
>  	u64 cur = start;
>  	int ret = 0;
>  
> @@ -1210,6 +1211,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
>  		bool next_mergeable = true;
>  		u64 range_len;
>  
> +		last_target = false;
>  		em = defrag_lookup_extent(&inode->vfs_inode, cur, locked);
>  		if (!em)
>  			break;
> @@ -1259,6 +1261,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
>  		}
>  
>  add:
> +		last_target = true;
>  		range_len = min(extent_map_end(em), start + len) - cur;
>  		/*
>  		 * This one is a good target, check if it can be merged into
> @@ -1302,6 +1305,17 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
>  			kfree(entry);
>  		}
>  	}
> +	if (!ret && last_scanned_ret) {
> +		/*
> +		 * If the last extent is not a target, the caller can skip to
> +		 * the end of that extent.
> +		 * Otherwise, we can only go the end of the spcified range.
> +		 */
> +		if (!last_target)
> +			*last_scanned_ret = cur;
> +		else
> +			*last_scanned_ret = start + len;

Might be just me, but I found the name "last_target" a bit harder to
decipher. Something like "last_is_target" seems more clear to me, as
it indicates if the last extent we found was a target for defrag.

> +	}
>  	return ret;
>  }
>  
> @@ -1405,7 +1419,7 @@ static int defrag_one_range(struct btrfs_inode *inode,
>  	 * And this time we have extent locked already, pass @locked = true
>  	 * so that we won't relock the extent range and cause deadlock.
>  	 */
> -	ret = defrag_collect_targets(inode, ctrl, start, len, true,
> +	ret = defrag_collect_targets(inode, ctrl, start, len, NULL, true,
>  				     &target_list);
>  	if (ret < 0)
>  		goto unlock_extent;
> @@ -1448,6 +1462,7 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
>  			      struct btrfs_defrag_ctrl *ctrl, u32 len)
>  {
>  	const u32 sectorsize = inode->root->fs_info->sectorsize;
> +	u64 last_scanned;
>  	struct defrag_target_range *entry;
>  	struct defrag_target_range *tmp;
>  	LIST_HEAD(target_list);
> @@ -1455,7 +1470,7 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
>  
>  	BUILD_BUG_ON(!IS_ALIGNED(CLUSTER_SIZE, PAGE_SIZE));
>  	ret = defrag_collect_targets(inode, ctrl, ctrl->last_scanned, len,
> -				     false, &target_list);
> +				     &last_scanned, false, &target_list);

So I would revert the logic here.
What I mean is, to pass a non-NULL pointer *last_scanned_ret to defrag_collect_targets()
when it's called at defrag_one_range(), and then here, at defrag_one_cluster(), pass it NULL
instead.

The reason is simple and I think makes more sense:

1) defrag_one_cluster() does a first call to defrag_collect_targets() to scan
   for the extents maps in a range without locking the range in the inode's
   iotree;

2) Then for each range it collects, we call defrag_one_range(). That will
   lock the range in the io tree and then call again defrag_collect_targets(),
   this time extent maps may have changed (due to concurrent mmap writes, etc).
   So it's this second time that we can have an accurate value for
   *last_scanned_ret

That would deal with the case where first pass considered a range for
defrag, but then in the second pass we skipped a subrange because in the
meanwhile, before we locked the range in the io tree, it got a large extent.

Thanks.
   

>  	if (ret < 0)
>  		goto out;
>  
> @@ -1496,6 +1511,8 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
>  		list_del_init(&entry->list);
>  		kfree(entry);
>  	}
> +	if (!ret)
> +		ctrl->last_scanned = last_scanned;
>  	return ret;
>  }
>  
> @@ -1624,7 +1641,6 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
>  		btrfs_inode_unlock(inode, 0);
>  		if (ret < 0)
>  			break;
> -		ctrl->last_scanned = cluster_end + 1;
>  		if (ret > 0) {
>  			ret = 0;
>  			break;
> -- 
> 2.34.1
> 
