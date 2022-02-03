Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898254A89BF
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Feb 2022 18:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352754AbiBCRRc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Feb 2022 12:17:32 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36506 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352543AbiBCRRb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Feb 2022 12:17:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEDC461669
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Feb 2022 17:17:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8442C340E8;
        Thu,  3 Feb 2022 17:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643908650;
        bh=Y2zQZVk//nCLz/j3oDql8yXXcPQ1H8bhEdgTLbS9fTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hkHwsQi4l89H21PnDNmlWPLiQtjA7XWwz8j4rQe4cnM904akVWUmtSK6zG7Nj0fmJ
         hZ48n5iJtVvti3RRoSMyeHb/ybcAo9z7XSP9vI0jTvlnQREof0GctTut0XzxN8GjD7
         JZQKL4jGxrYy3nUXJf2m03+1gmBZhKEHcLhe/qJVqhezMleZ/GTO+iuh0pypm4DQdj
         ti+EpNdFP48z42VU+Ph30PUB+S8vybmOnHB93EtlZr1a2d4PP3UHBJE3O/BR2NfO6S
         mKx917tbRvFIBGHpzWmcL/sIfXosO6xMJNZP/m/af+v2kO8bD4nsm2y12LuezvVAvb
         ht1n4CuREAI7g==
Date:   Thu, 3 Feb 2022 17:17:27 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/4] btrfs: defrag: use btrfs_defrag_ctrl to replace
 btrfs_ioctl_defrag_range_args for btrfs_defrag_file()
Message-ID: <YfwOJ0UT5t64BhVG@debian9.Home>
References: <cover.1643357469.git.wqu@suse.com>
 <34c2aa1e7c5e196420d68de1f67b8973d49e284b.1643357469.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34c2aa1e7c5e196420d68de1f67b8973d49e284b.1643357469.git.wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 28, 2022 at 04:12:57PM +0800, Qu Wenruo wrote:
> This brings the following benefits:
> 
> - No more strange range->start update to indicate last scanned bytenr
>   We have btrfs_defrag_ctrl::last_scanned (exclusive) for it directly.
> 
> - No more return value to indicate defragged sectors
>   Now btrfs_defrag_file() will just return 0 if no error happened.
>   And btrfs_defrag_ctrl::sectors_defragged will show that value.
> 
> - Less parameters to carry around
>   Now most defrag_* functions only need to fetch its policy parameters
>   from btrfs_defrag_ctrl directly.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/ctree.h |   3 +-
>  fs/btrfs/file.c  |  17 +++---
>  fs/btrfs/ioctl.c | 144 +++++++++++++++++++++--------------------------
>  3 files changed, 73 insertions(+), 91 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 0a441bd703a0..b30271676e15 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3287,8 +3287,7 @@ int btrfs_defrag_ioctl_args_to_ctrl(struct btrfs_fs_info *fs_info,
>  				    struct btrfs_defrag_ctrl *ctrl,
>  				    u64 max_sectors_to_defrag, u64 newer_than);
>  int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
> -		      struct btrfs_ioctl_defrag_range_args *range,
> -		      u64 newer_than, unsigned long max_to_defrag);
> +		      struct btrfs_defrag_ctrl *ctrl);
>  void btrfs_get_block_group_info(struct list_head *groups_list,
>  				struct btrfs_ioctl_space_info *space);
>  void btrfs_update_ioctl_balance_args(struct btrfs_fs_info *fs_info,
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 11204dbbe053..f5de8ab9787e 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -277,8 +277,7 @@ static int __btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
>  {
>  	struct btrfs_root *inode_root;
>  	struct inode *inode;
> -	struct btrfs_ioctl_defrag_range_args range;
> -	int num_defrag;
> +	struct btrfs_defrag_ctrl ctrl = {};

Most of the code base uses { 0 } for this type of initialization.
IIRC some compiler versions complained about {} and preferred the
version with 0.

I think we should try to be consistent. Personally I find the 0 version
more clear. Though this might be bike shedding territory.


>  	int ret;
>  
>  	/* get the inode */
> @@ -297,21 +296,21 @@ static int __btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
>  
>  	/* do a chunk of defrag */
>  	clear_bit(BTRFS_INODE_IN_DEFRAG, &BTRFS_I(inode)->runtime_flags);
> -	memset(&range, 0, sizeof(range));
> -	range.len = (u64)-1;
> -	range.start = defrag->last_offset;
> +	ctrl.len = (u64)-1;
> +	ctrl.start = defrag->last_offset;
> +	ctrl.newer_than = defrag->transid;
> +	ctrl.max_sectors_to_defrag = BTRFS_DEFRAG_BATCH;
>  
>  	sb_start_write(fs_info->sb);
> -	num_defrag = btrfs_defrag_file(inode, NULL, &range, defrag->transid,
> -				       BTRFS_DEFRAG_BATCH);
> +	ret = btrfs_defrag_file(inode, NULL, &ctrl);
>  	sb_end_write(fs_info->sb);
>  	/*
>  	 * if we filled the whole defrag batch, there
>  	 * must be more work to do.  Queue this defrag
>  	 * again
>  	 */
> -	if (num_defrag == BTRFS_DEFRAG_BATCH) {
> -		defrag->last_offset = range.start;
> +	if (ctrl.sectors_defragged == BTRFS_DEFRAG_BATCH) {
> +		defrag->last_offset = ctrl.last_scanned;
>  		btrfs_requeue_inode_defrag(BTRFS_I(inode), defrag);
>  	} else if (defrag->last_offset && !defrag->cycled) {
>  		/*
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index f9b9ee6c50da..67ba934be99e 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1189,22 +1189,18 @@ struct defrag_target_range {
>  /*
>   * Collect all valid target extents.
>   *
> + * @ctrl:	   extra defrag policy control
>   * @start:	   file offset to lookup
>   * @len:	   length to lookup
> - * @extent_thresh: file extent size threshold, any extent size >= this value
> - *		   will be ignored
> - * @newer_than:    only defrag extents newer than this value
> - * @do_compress:   whether the defrag is doing compression
> - *		   if true, @extent_thresh will be ignored and all regular
> - *		   file extents meeting @newer_than will be targets.
>   * @locked:	   if the range has already held extent lock
>   * @target_list:   list of targets file extents
>   */
>  static int defrag_collect_targets(struct btrfs_inode *inode,
> -				  u64 start, u64 len, u32 extent_thresh,
> -				  u64 newer_than, bool do_compress,
> -				  bool locked, struct list_head *target_list)
> +				  const struct btrfs_defrag_ctrl *ctrl,
> +				  u64 start, u32 len, bool locked,
> +				  struct list_head *target_list)
>  {
> +	bool do_compress = ctrl->flags & BTRFS_DEFRAG_RANGE_COMPRESS;
>  	u64 cur = start;
>  	int ret = 0;
>  
> @@ -1224,7 +1220,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
>  			goto next;
>  
>  		/* Skip older extent */
> -		if (em->generation < newer_than)
> +		if (em->generation < ctrl->newer_than)
>  			goto next;
>  
>  		/*
> @@ -1235,7 +1231,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
>  			goto add;
>  
>  		/* Skip too large extent */
> -		if (em->len >= extent_thresh)
> +		if (em->len >= ctrl->extent_thresh)
>  			goto next;
>  
>  		/*
> @@ -1363,8 +1359,9 @@ static int defrag_one_locked_target(struct btrfs_inode *inode,
>  	return ret;
>  }
>  
> -static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
> -			    u32 extent_thresh, u64 newer_than, bool do_compress)
> +static int defrag_one_range(struct btrfs_inode *inode,
> +			    const struct btrfs_defrag_ctrl *ctrl,
> +			    u64 start, u32 len)
>  {
>  	struct extent_state *cached_state = NULL;
>  	struct defrag_target_range *entry;
> @@ -1408,8 +1405,7 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
>  	 * And this time we have extent locked already, pass @locked = true
>  	 * so that we won't relock the extent range and cause deadlock.
>  	 */
> -	ret = defrag_collect_targets(inode, start, len, extent_thresh,
> -				     newer_than, do_compress, true,
> +	ret = defrag_collect_targets(inode, ctrl, start, len, true,
>  				     &target_list);
>  	if (ret < 0)
>  		goto unlock_extent;
> @@ -1440,12 +1436,16 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
>  	return ret;
>  }
>  
> +/*
> + * Return <0 for error.
> + * Return >0 if we hit the ctrl->max_sectors_to_defrag limit
> + * Return 0 if we finished the range without error.
> + *
> + * For >= 0 case, ctrl->last_scanned and ctrl->sectors_defragged will be updated.
> + */
>  static int defrag_one_cluster(struct btrfs_inode *inode,
>  			      struct file_ra_state *ra,
> -			      u64 start, u32 len, u32 extent_thresh,
> -			      u64 newer_than, bool do_compress,
> -			      unsigned long *sectors_defragged,
> -			      unsigned long max_sectors)
> +			      struct btrfs_defrag_ctrl *ctrl, u32 len)
>  {
>  	const u32 sectorsize = inode->root->fs_info->sectorsize;
>  	struct defrag_target_range *entry;
> @@ -1454,9 +1454,8 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
>  	int ret;
>  
>  	BUILD_BUG_ON(!IS_ALIGNED(CLUSTER_SIZE, PAGE_SIZE));
> -	ret = defrag_collect_targets(inode, start, len, extent_thresh,
> -				     newer_than, do_compress, false,
> -				     &target_list);
> +	ret = defrag_collect_targets(inode, ctrl, ctrl->last_scanned, len,
> +				     false, &target_list);
>  	if (ret < 0)
>  		goto out;
>  
> @@ -1464,14 +1463,16 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
>  		u32 range_len = entry->len;
>  
>  		/* Reached or beyond the limit */
> -		if (max_sectors && *sectors_defragged >= max_sectors) {
> +		if (ctrl->max_sectors_to_defrag &&
> +		    ctrl->sectors_defragged >= ctrl->max_sectors_to_defrag) {
>  			ret = 1;
>  			break;
>  		}
>  
> -		if (max_sectors)
> +		if (ctrl->max_sectors_to_defrag)
>  			range_len = min_t(u32, range_len,
> -				(max_sectors - *sectors_defragged) * sectorsize);
> +					  (ctrl->max_sectors_to_defrag -
> +					   ctrl->sectors_defragged) * sectorsize);
>  
>  		if (ra)
>  			page_cache_sync_readahead(inode->vfs_inode.i_mapping,
> @@ -1484,12 +1485,11 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
>  		 * But that's fine, it only affects the @sectors_defragged
>  		 * accounting.
>  		 */
> -		ret = defrag_one_range(inode, entry->start, range_len,
> -				       extent_thresh, newer_than, do_compress);
> +		ret = defrag_one_range(inode, ctrl, entry->start, range_len);
>  		if (ret < 0)
>  			break;
> -		*sectors_defragged += range_len >>
> -				      inode->root->fs_info->sectorsize_bits;
> +		ctrl->sectors_defragged += range_len >>
> +					  inode->root->fs_info->sectorsize_bits;
>  	}
>  out:
>  	list_for_each_entry_safe(entry, tmp, &target_list, list) {
> @@ -1545,58 +1545,43 @@ int btrfs_defrag_ioctl_args_to_ctrl(struct btrfs_fs_info *fs_info,
>   *
>   * @inode:	   inode to be defragged
>   * @ra:		   readahead state (can be NUL)
> - * @range:	   defrag options including range and flags
> - * @newer_than:	   minimum transid to defrag
> - * @max_to_defrag: max number of sectors to be defragged, if 0, the whole inode
> - *		   will be defragged.
> + * @ctrl:	   defrag options including range and various policy parameters
>   *
>   * Return <0 for error.
> - * Return >=0 for the number of sectors defragged, and range->start will be updated
> - * to indicate the file offset where next defrag should be started at.
> - * (Mostly for autodefrag, which sets @max_to_defrag thus we may exit early without
> - *  defragging all the range).
> + * Return 0 if the defrag is done without error, ctrl->last_scanned and
> + * ctrl->sectors_defragged will be updated.
>   */
>  int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
> -		      struct btrfs_ioctl_defrag_range_args *range,
> -		      u64 newer_than, unsigned long max_to_defrag)
> +		      struct btrfs_defrag_ctrl *ctrl)
>  {
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> -	unsigned long sectors_defragged = 0;
>  	u64 isize = i_size_read(inode);
> -	u64 cur;
>  	u64 last_byte;
> -	bool do_compress = range->flags & BTRFS_DEFRAG_RANGE_COMPRESS;
> +	bool do_compress = ctrl->flags & BTRFS_DEFRAG_RANGE_COMPRESS;
>  	bool ra_allocated = false;
> -	int compress_type = BTRFS_COMPRESS_ZLIB;
>  	int ret = 0;
> -	u32 extent_thresh = range->extent_thresh;
>  
>  	if (isize == 0)
>  		return 0;
>  
> -	if (range->start >= isize)
> +	if (ctrl->start >= isize)
>  		return -EINVAL;
>  
> -	if (do_compress) {
> -		if (range->compress_type >= BTRFS_NR_COMPRESS_TYPES)
> -			return -EINVAL;
> -		if (range->compress_type)
> -			compress_type = range->compress_type;
> -	}
> -
> -	if (extent_thresh == 0)
> -		extent_thresh = SZ_256K;
> +	if (do_compress)
> +		ASSERT(ctrl->compress < BTRFS_NR_COMPRESS_TYPES);
>  
> -	if (range->start + range->len > range->start) {
> +	if (ctrl->start + ctrl->len > ctrl->start) {
>  		/* Got a specific range */
> -		last_byte = min(isize, range->start + range->len);
> +		last_byte = min(isize, ctrl->start + ctrl->len);
>  	} else {
>  		/* Defrag until file end */
>  		last_byte = isize;
>  	}
> +	if (ctrl->extent_thresh == 0)
> +		ctrl->extent_thresh = SZ_256K;

Why did you move the logic for checking/setting the extent threshold?
You placed it now in the middle of the logic that sets 'last_byte', which is
not logical and makes it harder to follow.

I adjust the setup of 'last_byte' recently to avoid that:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6b34cd8e175bfbf4f3f01b6d19eae18245e1a8cc

>  
> -	/* Align the range */
> -	cur = round_down(range->start, fs_info->sectorsize);
> +	ASSERT(IS_ALIGNED(ctrl->start, fs_info->sectorsize));
> +	ctrl->last_scanned = ctrl->start;
>  	last_byte = round_up(last_byte, fs_info->sectorsize) - 1;
>  
>  	/*
> @@ -1611,14 +1596,14 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
>  			file_ra_state_init(ra, inode->i_mapping);
>  	}
>  
> -	while (cur < last_byte) {
> +	while (ctrl->last_scanned < last_byte) {
>  		u64 cluster_end;
>  
>  		/* The cluster size 256K should always be page aligned */
>  		BUILD_BUG_ON(!IS_ALIGNED(CLUSTER_SIZE, PAGE_SIZE));
>  
>  		/* We want the cluster end at page boundary when possible */
> -		cluster_end = (((cur >> PAGE_SHIFT) +
> +		cluster_end = (((ctrl->last_scanned >> PAGE_SHIFT) +
>  			       (SZ_256K >> PAGE_SHIFT)) << PAGE_SHIFT) - 1;
>  		cluster_end = min(cluster_end, last_byte);
>  
> @@ -1633,15 +1618,13 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
>  			break;
>  		}
>  		if (do_compress)
> -			BTRFS_I(inode)->defrag_compress = compress_type;
> -		ret = defrag_one_cluster(BTRFS_I(inode), ra, cur,
> -				cluster_end + 1 - cur, extent_thresh,
> -				newer_than, do_compress,
> -				&sectors_defragged, max_to_defrag);
> +			BTRFS_I(inode)->defrag_compress = ctrl->compress;
> +		ret = defrag_one_cluster(BTRFS_I(inode), ra, ctrl,
> +				cluster_end + 1 - ctrl->last_scanned);
>  		btrfs_inode_unlock(inode, 0);
>  		if (ret < 0)
>  			break;
> -		cur = cluster_end + 1;
> +		ctrl->last_scanned = cluster_end + 1;
>  		if (ret > 0) {
>  			ret = 0;
>  			break;
> @@ -1650,27 +1633,21 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
>  
>  	if (ra_allocated)
>  		kfree(ra);
> -	/*
> -	 * Update range.start for autodefrag, this will indicate where to start
> -	 * in next run.
> -	 */
> -	range->start = cur;
> -	if (sectors_defragged) {
> +	if (ctrl->sectors_defragged) {
>  		/*
>  		 * We have defragged some sectors, for compression case they
>  		 * need to be written back immediately.
>  		 */
> -		if (range->flags & BTRFS_DEFRAG_RANGE_START_IO) {
> +		if (ctrl->flags & BTRFS_DEFRAG_RANGE_START_IO) {
>  			filemap_flush(inode->i_mapping);
>  			if (test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
>  				     &BTRFS_I(inode)->runtime_flags))
>  				filemap_flush(inode->i_mapping);
>  		}
> -		if (range->compress_type == BTRFS_COMPRESS_LZO)
> +		if (ctrl->compress == BTRFS_COMPRESS_LZO)
>  			btrfs_set_fs_incompat(fs_info, COMPRESS_LZO);
> -		else if (range->compress_type == BTRFS_COMPRESS_ZSTD)
> +		else if (ctrl->compress == BTRFS_COMPRESS_ZSTD)
>  			btrfs_set_fs_incompat(fs_info, COMPRESS_ZSTD);
> -		ret = sectors_defragged;
>  	}
>  	if (do_compress) {
>  		btrfs_inode_lock(inode, 0);
> @@ -3193,6 +3170,7 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
>  	struct inode *inode = file_inode(file);
>  	struct btrfs_root *root = BTRFS_I(inode)->root;
>  	struct btrfs_ioctl_defrag_range_args range = {0};
> +	struct btrfs_defrag_ctrl ctrl = {};

Same here, but more confusing here since both styles are used one after
another.

Other than that, it looks fine. Thanks.

>  	int ret;
>  
>  	ret = mnt_want_write_file(file);
> @@ -3238,10 +3216,16 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
>  			/* the rest are all set to zero by kzalloc */
>  			range.len = (u64)-1;
>  		}
> -		ret = btrfs_defrag_file(file_inode(file), &file->f_ra,
> -					&range, BTRFS_OLDEST_GENERATION, 0);
> -		if (ret > 0)
> -			ret = 0;
> +		ret = btrfs_defrag_ioctl_args_to_ctrl(root->fs_info, &range,
> +						      &ctrl, 0, BTRFS_OLDEST_GENERATION);
> +		if (ret < 0)
> +			break;
> +		ret = btrfs_defrag_file(file_inode(file), &file->f_ra, &ctrl);
> +		/*
> +		 * Although progs doesn't check range->start, still try to keep
> +		 * the same behavior to make direct ioctl caller happy.
> +		 */
> +		range.start = ctrl.last_scanned;
>  		break;
>  	default:
>  		ret = -EINVAL;
> -- 
> 2.34.1
> 
