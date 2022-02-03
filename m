Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4014A893F
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Feb 2022 18:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352483AbiBCRGi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Feb 2022 12:06:38 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57976 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiBCRGi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Feb 2022 12:06:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E731F615B0
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Feb 2022 17:06:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C592AC340E8;
        Thu,  3 Feb 2022 17:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643907997;
        bh=wQH681429GyuqcZBm7X3GUyayeTOOQNsvzX0Z3yE7p0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=slbXKrXkHLyqD8y0ZnjstKN4BidKAMAWHt0o+dcb/UFdCK06tdaM986syC+zogPPc
         5LWQhwphk744cxanxNIyYmaWTjxJhW+cxuFK5wX2Ce/2aG9nW/2jTfJk55XvS3Ds0p
         IBlPQVY7Zb/6fqWoj90utTQL957ZmvOMBk7NX5+B1gVaC6CvDWunkFhZeD1QP+cdxk
         4N7OBKgeW9YjfpLcHgptMleqPo3eR9tc3aHW+zykVNWdr5iXBoGXtoFdxjar+fYp2m
         RbMG/7dqNCmL9toe2xChCOZZCYRNVUqCScH3afwFRKXY4N7bdsEHhgM8TFbAaesoLL
         HUD+33e69EpHg==
Date:   Thu, 3 Feb 2022 17:06:34 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/4] btrfs: defrag: introduce btrfs_defrag_ctrl structure
 for later usage
Message-ID: <YfwLmju1qylfUHUo@debian9.Home>
References: <cover.1643357469.git.wqu@suse.com>
 <d5da1d1dc6ebc1395621e4fd6391a73e55a7ac8c.1643357469.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5da1d1dc6ebc1395621e4fd6391a73e55a7ac8c.1643357469.git.wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 28, 2022 at 04:12:56PM +0800, Qu Wenruo wrote:
> Currently btrfs_defrag_file() accepts not only
> btrfs_ioctl_defrag_range_args but also other parameters like @newer_than
> and @max_sectors_to_defrag for extra policies.
> 
> Those extra values are hidden from defrag ioctl and even caused bugs in
> the past due to different behaviors based on those extra values.
> 
> Here we introduce a new structure, btrfs_defrag_ctrl, to include:
> 
> - all members in btrfs_ioctl_defrag_range_args
> 
> - @max_sectors_to_defrag and @newer_than
> 
> - Extra values which callers of btrfs_defrag_file() may care
>   Like @sectors_defragged and @last_scanned.
> 
> With the new structure, also introduce a new helper,
> btrfs_defrag_ioctl_args_to_ctrl() to:
> 
> - Do extra sanity check on @compress and @flags
> 
> - Do range alignment when possible
> 
> - Set the default value.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/ctree.h | 19 +++++++++++++++++++
>  fs/btrfs/ioctl.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 60 insertions(+)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index b4a9b1c58d22..0a441bd703a0 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3267,6 +3267,25 @@ int btrfs_fileattr_set(struct user_namespace *mnt_userns,
>  int btrfs_ioctl_get_supported_features(void __user *arg);
>  void btrfs_sync_inode_flags_to_i_flags(struct inode *inode);
>  int __pure btrfs_is_empty_uuid(u8 *uuid);
> +
> +struct btrfs_defrag_ctrl {
> +	/* Values below are for defrag policy */

I think you meant input, read-only, only fields.

> +	u64	start;
> +	u64	len;
> +	u32	extent_thresh;
> +	u64	newer_than;
> +	u64	max_sectors_to_defrag;
> +	u8	compress;
> +	u8	flags;
> +
> +	/* Values below are the defrag result */

And here to say that they are output fields.
Makes it a lot more clear IMHO.

> +	u64	sectors_defragged;
> +	u64	last_scanned;	/* Exclusive bytenr */
> +};
> +int btrfs_defrag_ioctl_args_to_ctrl(struct btrfs_fs_info *fs_info,
> +				    struct btrfs_ioctl_defrag_range_args *args,
> +				    struct btrfs_defrag_ctrl *ctrl,
> +				    u64 max_sectors_to_defrag, u64 newer_than);
>  int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
>  		      struct btrfs_ioctl_defrag_range_args *range,
>  		      u64 newer_than, unsigned long max_to_defrag);
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 3d3331dd0902..f9b9ee6c50da 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1499,6 +1499,47 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
>  	return ret;
>  }
>  
> +/*
> + * Convert the old ioctl format to the new btrfs_defrag_ctrl structure.
> + *
> + * Will also do basic task like setting default values and sanity check.

task -> tasks, sanity check -> sanity checks

It's a bit awful to have two structures now, but I don't see a better
way around it.

Thanks.

> + */
> +int btrfs_defrag_ioctl_args_to_ctrl(struct btrfs_fs_info *fs_info,
> +				    struct btrfs_ioctl_defrag_range_args *args,
> +				    struct btrfs_defrag_ctrl *ctrl,
> +				    u64 max_sectors_to_defrag, u64 newer_than)
> +{
> +	u64 range_end;
> +
> +	if (args->flags & ~BTRFS_DEFRAG_RANGE_FLAGS_MASK)
> +		return -EOPNOTSUPP;
> +	if (args->compress_type >= BTRFS_NR_COMPRESS_TYPES)
> +		return -EOPNOTSUPP;
> +
> +	ctrl->start = round_down(args->start, fs_info->sectorsize);
> +	/*
> +	 * If @len does not overflow with @start nor is -1, align the length.
> +	 * Otherwise set it to (u64)-1 so later btrfs_defrag_file() will
> +	 * determine the length using isize.
> +	 */
> +	if (!check_add_overflow(args->start, args->len, &range_end) &&
> +	    args->len != (u64)-1)
> +		ctrl->len = round_up(range_end, fs_info->sectorsize) -
> +			    ctrl->start;
> +	else
> +		ctrl->len = -1;
> +	ctrl->flags = args->flags;
> +	ctrl->compress = args->compress_type;
> +	if (args->extent_thresh == 0)
> +		ctrl->extent_thresh = SZ_256K;
> +	else
> +		ctrl->extent_thresh = args->extent_thresh;
> +	ctrl->newer_than = newer_than;
> +	ctrl->last_scanned = 0;
> +	ctrl->sectors_defragged = 0;
> +	return 0;
> +}
> +
>  /*
>   * Entry point to file defragmentation.
>   *
> -- 
> 2.34.1
> 
