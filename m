Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3AE57EA6A
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Jul 2022 01:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236314AbiGVXtt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jul 2022 19:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234919AbiGVXts (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jul 2022 19:49:48 -0400
Received: from out20-157.mail.aliyun.com (out20-157.mail.aliyun.com [115.124.20.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B16DC06C2
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Jul 2022 16:49:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04832241|-1;BR=01201311R161S84rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00578754-9.82518e-06-0.994203;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047207;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.ObE0iWJ_1658533774;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.ObE0iWJ_1658533774)
          by smtp.aliyun-inc.com;
          Sat, 23 Jul 2022 07:49:34 +0800
Date:   Sat, 23 Jul 2022 07:49:37 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Stefan Roesch <shr@fb.com>
Subject: Re: [PATCH v6 1/4] btrfs: store chunk size in space-info struct.
Cc:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
In-Reply-To: <20211203220445.2312182-2-shr@fb.com>
References: <20211203220445.2312182-1-shr@fb.com> <20211203220445.2312182-2-shr@fb.com>
Message-Id: <20220723074936.30FD.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

In this patch, the max chunk size is changed from 
BTRFS_MAX_DATA_CHUNK_SIZE(10G) to SZ_1G without any comment ?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/07/23

> The chunk size is stored in the btrfs_space_info structure.
> It is initialized at the start and is then used.
> 
> A new api is added to update the current chunk size.
> 
> This api is used to be able to expose the chunk_size
> as a sysfs setting.
> 
> Signed-off-by: Stefan Roesch <shr@fb.com>
> ---
>  fs/btrfs/space-info.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/space-info.h |  3 +++
>  fs/btrfs/volumes.c    | 28 +++++++++-------------------
>  3 files changed, 53 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 79fe0ad17acf..437d1240f491 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -181,6 +181,46 @@ void btrfs_clear_space_info_full(struct btrfs_fs_info *info)
>  		found->full = 0;
>  }
>  
> +/*
> + * Compute chunk size depending on block type for regular volumes.
> + */
> +static u64 compute_chunk_size_regular(struct btrfs_fs_info *info, u64 flags)
> +{
> +	ASSERT(flags & BTRFS_BLOCK_GROUP_TYPE_MASK);
> +
> +	if (flags & BTRFS_BLOCK_GROUP_DATA)
> +		return SZ_1G;
> +	else if (flags & BTRFS_BLOCK_GROUP_SYSTEM)
> +		return SZ_32M;
> +
> +	/* Handle BTRFS_BLOCK_GROUP_METADATA */
> +	if (info->fs_devices->total_rw_bytes > 50ULL * SZ_1G)
> +		return SZ_1G;
> +
> +	return SZ_256M;
> +}
> +
> +/*
> + * Compute chunk size depending on volume type.
> + */
> +static u64 compute_chunk_size(struct btrfs_fs_info *info, u64 flags)
> +{
> +	if (btrfs_is_zoned(info))
> +		return info->zone_size;
> +
> +	return compute_chunk_size_regular(info, flags);
> +}
> +
> +/*
> + * Update default chunk size.
> + *
> + */
> +void btrfs_update_space_info_chunk_size(struct btrfs_space_info *space_info,
> +					u64 chunk_size)
> +{
> +	atomic64_set(&space_info->chunk_size, chunk_size);
> +}
> +
>  static int create_space_info(struct btrfs_fs_info *info, u64 flags)
>  {
>  
> @@ -202,6 +242,7 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
>  	INIT_LIST_HEAD(&space_info->tickets);
>  	INIT_LIST_HEAD(&space_info->priority_tickets);
>  	space_info->clamp = 1;
> +	btrfs_update_space_info_chunk_size(space_info, compute_chunk_size(info, flags));
>  
>  	ret = btrfs_sysfs_add_space_info_type(info, space_info);
>  	if (ret)
> diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
> index d841fed73492..c1a64bbfb6d1 100644
> --- a/fs/btrfs/space-info.h
> +++ b/fs/btrfs/space-info.h
> @@ -23,6 +23,7 @@ struct btrfs_space_info {
>  	u64 max_extent_size;	/* This will hold the maximum extent size of
>  				   the space info if we had an ENOSPC in the
>  				   allocator. */
> +	atomic64_t chunk_size;  /* chunk size in bytes */
>  
>  	int clamp;		/* Used to scale our threshold for preemptive
>  				   flushing. The value is >> clamp, so turns
> @@ -115,6 +116,8 @@ void btrfs_update_space_info(struct btrfs_fs_info *info, u64 flags,
>  			     u64 total_bytes, u64 bytes_used,
>  			     u64 bytes_readonly, u64 bytes_zone_unusable,
>  			     struct btrfs_space_info **space_info);
> +void btrfs_update_space_info_chunk_size(struct btrfs_space_info *space_info,
> +			     u64 chunk_size);
>  struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *info,
>  					       u64 flags);
>  u64 __pure btrfs_space_info_used(struct btrfs_space_info *s_info,
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index f38c230111be..546c39551648 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5106,26 +5106,16 @@ static void init_alloc_chunk_ctl_policy_regular(
>  				struct btrfs_fs_devices *fs_devices,
>  				struct alloc_chunk_ctl *ctl)
>  {
> -	u64 type = ctl->type;
> +	struct btrfs_space_info *space_info;
>  
> -	if (type & BTRFS_BLOCK_GROUP_DATA) {
> -		ctl->max_stripe_size = SZ_1G;
> -		ctl->max_chunk_size = BTRFS_MAX_DATA_CHUNK_SIZE;
> -	} else if (type & BTRFS_BLOCK_GROUP_METADATA) {
> -		/* For larger filesystems, use larger metadata chunks */
> -		if (fs_devices->total_rw_bytes > 50ULL * SZ_1G)
> -			ctl->max_stripe_size = SZ_1G;
> -		else
> -			ctl->max_stripe_size = SZ_256M;
> -		ctl->max_chunk_size = ctl->max_stripe_size;
> -	} else if (type & BTRFS_BLOCK_GROUP_SYSTEM) {
> -		ctl->max_stripe_size = SZ_32M;
> -		ctl->max_chunk_size = 2 * ctl->max_stripe_size;
> -		ctl->devs_max = min_t(int, ctl->devs_max,
> -				      BTRFS_MAX_DEVS_SYS_CHUNK);
> -	} else {
> -		BUG();
> -	}
> +	space_info = btrfs_find_space_info(fs_devices->fs_info, ctl->type);
> +	ASSERT(space_info);
> +
> +	ctl->max_chunk_size = atomic64_read(&space_info->chunk_size);
> +	ctl->max_stripe_size = ctl->max_chunk_size;
> +
> +	if (ctl->type & BTRFS_BLOCK_GROUP_SYSTEM)
> +		ctl->devs_max = min_t(int, ctl->devs_max, BTRFS_MAX_DEVS_SYS_CHUNK);
>  
>  	/* We don't want a chunk larger than 10% of writable space */
>  	ctl->max_chunk_size = min(div_factor(fs_devices->total_rw_bytes, 1),
> -- 
> 2.30.2


