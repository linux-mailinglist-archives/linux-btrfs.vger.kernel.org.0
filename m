Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9822D43B997
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Oct 2021 20:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbhJZScS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Oct 2021 14:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbhJZScR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Oct 2021 14:32:17 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3110BC061745
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Oct 2021 11:29:53 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id h11so28267qvk.4
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Oct 2021 11:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xrH/nldbVG8gW9iGweZCw6J6mPJ73gASP+U+UdAEqaA=;
        b=mut06j4Alsy7lvFF7NOKHI5GVqNJB7T53cY9Zf6oAlSX7f7upBZE9wvi5ASWzGP5CC
         byPzhu1iGNXobfhjTZ0wodmywcK5K+BDHQsodgMjd7tMdxvAFVDoyGq4dtcNB/SXoAD6
         Foy3Yz+8OJ6y7D5jW1ua1x6WM9fxDuYxm5rZMyOE2h3yNXPQuyoxue/UvIgkMQjCkT5B
         z8VogaWRm8Vy1v2Lj9R0UStp3EbTSuQrK/JG8o5l3v/wV/I7DTh9YxQmPMXlb4dLvZ+3
         jDm9amCYjnAsJ+qhIQk+NtYxvfNcLwpo/z06Gozsf8csSZET9T0CP3YTA1/g0XlDkthJ
         zX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xrH/nldbVG8gW9iGweZCw6J6mPJ73gASP+U+UdAEqaA=;
        b=1mN89CfRsYZm+V9XFgetkP+8JYVR96jGL/ALDXiiS+qNudil3SqnHUiT7uJGc8+uWu
         fPyo9AW2wh96wt33X8mMuLWZdnpdqjrpO/a5/zPID4Gj1AVSfW8x215WQhp8j58AGBoZ
         AsTNUx2CG28mrpt6BWNJj/GUX/PQGK8e419wPOry5CPXWfs46a35hw5lbyNTVxJNjIch
         0aidjdv58jfWg76tkpSd4PFbWBqUsQuXjWRzZQPBBbEOry1Olo5s7uq7+7tuRKrZAe3D
         RLu1SvhN5DR3CFzocXwHhu50c/19AnWBteXoCjS1OcsALnP80v9LRLxWy5J+KukVHNXh
         CPTA==
X-Gm-Message-State: AOAM530im7Y24M7Yd/WVKdPZ40t43r+tC2SJF12Fik1BkFXKJRYLwCIa
        hChaWRD89NcvzyMXdEj2UVLmNQ==
X-Google-Smtp-Source: ABdhPJwZNtChh/3duOTum7VDpNeeaoKhKolhQGJjdgVCyx6u6tDpZ5SEuCco1xTsaR8qIhXAPNDkfQ==
X-Received: by 2002:ad4:4144:: with SMTP id z4mr23996757qvp.22.1635272992139;
        Tue, 26 Oct 2021 11:29:52 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z6sm11596625qtj.90.2021.10.26.11.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 11:29:51 -0700 (PDT)
Date:   Tue, 26 Oct 2021 14:29:50 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Stefan Roesch <shr@fb.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: sysfs: set / query btrfs stripe size
Message-ID: <YXhJHqqyx4+FUPRj@localhost.localdomain>
References: <20211026165915.553834-1-shr@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026165915.553834-1-shr@fb.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 26, 2021 at 09:59:15AM -0700, Stefan Roesch wrote:
> Motivation:
> The btrfs allocator is currently not ideal for all workloads. It tends
> to suffer from overallocating data block groups and underallocating
> metadata block groups. This results in filesystems becoming read-only
> even though there is plenty of "free" space.
> This is naturally confusing and distressing to users.
> 
> Changes:
>   - Increase the default chunk size allocation for metadata to 5GB
>     for devices with > 50GB storage space.
> 
>   - Add a new sysfs setting to control the stripe size
>       /sys/fs/btrfs/<UUID>/allocation/<block_type>/stripe_size
> 
>   - For testing add a new sysfs setting to force a chunk allocation.
>     This setting is only available if the kernel is compiled with
>     CONFIG_BTRFS_DEBUG.
>       /sys/fs/btrfs/<UUID>/allocation/<block_type>/force_chunk_alloc
> 
> Testing:
>   A new test is being added to the xfstest suite. For reference the
>   corresponding patch has the title:
>     [PATCH] btrfs: Test chunk allocation with different sizes
> 
>   In addition also manual testing has been performed.
>     - Run xfstests with the changes and the new test. It does not
>       show new diffs.
>     - Test with storage devices 10G, 20G, 30G, 50G, 60G
>       - Default allocation
>       - Increase of chunk size
>       - If the stripe size is > the free space, it allocates
>         free space - 1MB. The 1MB is left as free space.
>       - If the device has a storage size > 50G, it uses a 5GB
>         chunk size for new allocations.
> 
> Signed-off-by: Stefan Roesch <shr@fb.com>

This should be 4 patches, 1 to do the force allocation sysfs thing, 1 to
implement the new chunk size stuff, and then another to add the sysfs interface
to make the alloc sizes adjustable, and finally 1 to change the default from
1gib metadata chunks to 5gib metadata chunks.

> ---
>  fs/btrfs/space-info.c |  52 +++++++++++++++
>  fs/btrfs/space-info.h |   4 ++
>  fs/btrfs/sysfs.c      | 145 ++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/volumes.c    |  30 ++++-----
>  4 files changed, 212 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 48d77f360a24..e082654c85f1 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -181,6 +181,54 @@ void btrfs_clear_space_info_full(struct btrfs_fs_info *info)
>  		found->full = 0;
>  }
>  
> +/*
> + * Compute stripe size depending on block type.
> + */
> +static u64 compute_stripe_size(struct btrfs_fs_info *info, u64 flags)
> +{
> +	if (flags & BTRFS_BLOCK_GROUP_DATA) {
> +		return SZ_1G;
> +	} else if (flags & BTRFS_BLOCK_GROUP_METADATA) {
> +		/* For larger filesystems, use larger metadata chunks */
> +		return info->fs_devices->total_rw_bytes > 50ULL * SZ_1G
> +			? 5ULL * SZ_1G
> +			: SZ_256M;
> +	} else if (flags & BTRFS_BLOCK_GROUP_SYSTEM) {
> +		return SZ_32M;

For the last one we prefer to just fall through, so

if (flags & BTRFS_BLOCK_GROUP_DATA)
	return SZ_1G;
else if (flags & BTRFS_BLOCK_GROUP_SYSTEM)
	return SZ_32M;

/* BTRFS_BLOCK_GROUP_METADATA. */
if (info->fs_devices->total_rw_bytes > 50ULL * SZ_1G)
	return 5ULL * SZ_1G;
return SZ_256M;

> +	}
> +
> +	BUG();

We want to avoid adding BUG()'s to new code, instead add this to the beginning

ASSERT(flags & BTRFS_BLOCK_GROUP_TYPE_MASK);

> +}
> +
> +/*
> + * Compute chunk size depending on block type and stripe size.
> + */
> +static u64 compute_chunk_size(u64 flags, u64 max_stripe_size)
> +{
> +	if (flags & BTRFS_BLOCK_GROUP_DATA)
> +		return BTRFS_MAX_DATA_CHUNK_SIZE;
> +	else if (flags & BTRFS_BLOCK_GROUP_METADATA)
> +		return max_stripe_size;
> +	else if (flags & BTRFS_BLOCK_GROUP_SYSTEM)
> +		return 2 * max_stripe_size;
> +
> +	BUG();
> +}

Same comment as above.

> +
> +/*
> + * Update maximum stripe size and chunk size.
> + *
> + */
> +void btrfs_update_space_info_max_alloc_sizes(struct btrfs_space_info *space_info,
> +					     u64 flags, u64 max_stripe_size)
> +{
> +	spin_lock(&space_info->lock);
> +	space_info->max_stripe_size = max_stripe_size;
> +	space_info->max_chunk_size = compute_chunk_size(flags,
> +						space_info->max_stripe_size);
> +	spin_unlock(&space_info->lock);
> +}
> +
>  static int create_space_info(struct btrfs_fs_info *info, u64 flags)
>  {
>  
> @@ -203,6 +251,10 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
>  	INIT_LIST_HEAD(&space_info->priority_tickets);
>  	space_info->clamp = 1;
>  
> +	space_info->max_stripe_size = compute_stripe_size(info, flags);
> +	space_info->max_chunk_size = compute_chunk_size(flags,
> +						space_info->max_stripe_size);
> +
>  	ret = btrfs_sysfs_add_space_info_type(info, space_info);
>  	if (ret)
>  		return ret;
> diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
> index cb5056472e79..5ee3e381de38 100644
> --- a/fs/btrfs/space-info.h
> +++ b/fs/btrfs/space-info.h
> @@ -23,6 +23,8 @@ struct btrfs_space_info {
>  	u64 max_extent_size;	/* This will hold the maximum extent size of
>  				   the space info if we had an ENOSPC in the
>  				   allocator. */
> +	u64 max_chunk_size; /* maximum chunk size in bytes */
> +	u64 max_stripe_size; /* maximum stripe size in bytes */
>  
>  	int clamp;		/* Used to scale our threshold for preemptive
>  				   flushing. The value is >> clamp, so turns
> @@ -115,6 +117,8 @@ void btrfs_update_space_info(struct btrfs_fs_info *info, u64 flags,
>  			     u64 total_bytes, u64 bytes_used,
>  			     u64 bytes_readonly, u64 bytes_zone_unusable,
>  			     struct btrfs_space_info **space_info);
> +void btrfs_update_space_info_max_alloc_sizes(struct btrfs_space_info *space_info,
> +			     u64 flags, u64 max_stripe_size);
>  struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *info,
>  					       u64 flags);
>  u64 __pure btrfs_space_info_used(struct btrfs_space_info *s_info,
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 25a6f587852b..df3913027df9 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -21,6 +21,7 @@
>  #include "space-info.h"
>  #include "block-group.h"
>  #include "qgroup.h"
> +#include "misc.h"
>  
>  /*
>   * Structure name                       Path
> @@ -92,6 +93,7 @@ static struct btrfs_feature_attr btrfs_attr_features_##_name = {	     \
>  
>  static inline struct btrfs_fs_info *to_fs_info(struct kobject *kobj);
>  static inline struct btrfs_fs_devices *to_fs_devs(struct kobject *kobj);
> +static inline struct kobject *get_btrfs_kobj(struct kobject *kobj);
>  
>  static struct btrfs_feature_attr *to_btrfs_feature_attr(struct kobj_attribute *a)
>  {
> @@ -709,6 +711,125 @@ static ssize_t btrfs_space_info_show_##field(struct kobject *kobj,	\
>  }									\
>  BTRFS_ATTR(space_info, field, btrfs_space_info_show_##field)
>  
> +/*
> + * Return space info stripe size.
> + */
> +static ssize_t btrfs_stripe_size_show(struct kobject *kobj,
> +				      struct kobj_attribute *a, char *buf)
> +{
> +	struct btrfs_space_info *sinfo = to_space_info(kobj);
> +
> +	return btrfs_show_u64(&sinfo->max_stripe_size, &sinfo->lock, buf);
> +}
> +
> +/*
> + * Store new user supplied stripe size in space info.
> + *
> + * Note: If the new stripe size value is larger than 10% of free space it is
> + *       reduced to match that limit.
> + */
> +static ssize_t btrfs_stripe_size_store(struct kobject *kobj,
> +				       struct kobj_attribute *a,
> +				       const char *buf, size_t len)
> +{
> +	struct btrfs_space_info *space_info = to_space_info(kobj);
> +	struct btrfs_fs_info *fs_info = to_fs_info(get_btrfs_kobj(kobj));
> +	u64 val;
> +	int ret;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	if (!fs_info) {
> +		pr_err("couldn't get fs_info\n");
> +		return -EPERM;
> +	}
> +
> +	if (sb_rdonly(fs_info->sb))
> +		return -EROFS;
> +
> +	if (!fs_info->fs_devices)
> +		return -EINVAL;
> +
> +	if (fs_info->fs_devices->chunk_alloc_policy == BTRFS_CHUNK_ALLOC_ZONED)
> +		return -EINVAL;
> +
> +	if (!space_info) {
> +		btrfs_err(fs_info, "couldn't get space_info\n");
> +		return -EPERM;
> +	}
> +
> +	ret = kstrtoull(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Limit stripe size to 10% of available space.
> +	 */
> +	val = min(div_factor(fs_info->fs_devices->total_rw_bytes, 1), val);
> +	btrfs_update_space_info_max_alloc_sizes(space_info, space_info->flags, val);
> +
> +	return val;
> +}
> +
> +#ifdef CONFIG_BTRFS_DEBUG
> +/*
> + * Return if space info force allocation chunk flag is set.
> + */
> +static ssize_t btrfs_force_chunk_alloc_show(struct kobject *kobj,
> +					    struct kobj_attribute *a,
> +					    char *buf)
> +{
> +	return snprintf(buf, PAGE_SIZE, "0\n");
> +}
> +
> +/*
> + * Request chunk allocation with current chunk size.
> + */
> +static ssize_t btrfs_force_chunk_alloc_store(struct kobject *kobj,
> +					     struct kobj_attribute *a,
> +					     const char *buf, size_t len)
> +{
> +	struct btrfs_space_info *space_info = to_space_info(kobj);
> +	struct btrfs_fs_info *fs_info = to_fs_info(get_btrfs_kobj(kobj));
> +	struct btrfs_trans_handle *trans;
> +	unsigned long val;
> +	int ret;
> +
> +	if (!fs_info) {
> +		pr_err("couldn't get fs_info\n");
> +		return -EPERM;
> +	}
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	if (sb_rdonly(fs_info->sb))
> +		return -EROFS;
> +
> +	ret = kstrtoul(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val == 0)
> +		return -EINVAL;
> +
> +	/*
> +	 * Allocate new chunk.
> +	 */
> +	trans = btrfs_start_transaction(fs_info->extent_root, 0);
> +	if (!trans)
> +		return PTR_ERR(trans);
> +	ret = btrfs_force_chunk_alloc(trans, space_info->flags);
> +	btrfs_end_transaction(trans);
> +
> +	if (ret == 1)
> +		return len;
> +
> +	return -ENOSPC;
> +}
> +#endif
> +
>  SPACE_INFO_ATTR(flags);
>  SPACE_INFO_ATTR(total_bytes);
>  SPACE_INFO_ATTR(bytes_used);
> @@ -719,6 +840,12 @@ SPACE_INFO_ATTR(bytes_readonly);
>  SPACE_INFO_ATTR(bytes_zone_unusable);
>  SPACE_INFO_ATTR(disk_used);
>  SPACE_INFO_ATTR(disk_total);
> +BTRFS_ATTR_RW(space_info, stripe_size, btrfs_stripe_size_show,
> +	      btrfs_stripe_size_store);
> +#ifdef CONFIG_BTRFS_DEBUG
> +BTRFS_ATTR_RW(space_info, force_chunk_alloc, btrfs_force_chunk_alloc_show,
> +	      btrfs_force_chunk_alloc_store);
> +#endif
>  
>  /*
>   * Allocation information about block group types.
> @@ -736,6 +863,10 @@ static struct attribute *space_info_attrs[] = {
>  	BTRFS_ATTR_PTR(space_info, bytes_zone_unusable),
>  	BTRFS_ATTR_PTR(space_info, disk_used),
>  	BTRFS_ATTR_PTR(space_info, disk_total),
> +	BTRFS_ATTR_PTR(space_info, stripe_size),
> +#ifdef CONFIG_BTRFS_DEBUG
> +	BTRFS_ATTR_PTR(space_info, force_chunk_alloc),
> +#endif
>  	NULL,
>  };
>  ATTRIBUTE_GROUPS(space_info);
> @@ -1103,6 +1234,20 @@ static inline struct btrfs_fs_info *to_fs_info(struct kobject *kobj)
>  	return to_fs_devs(kobj)->fs_info;
>  }
>  
> +/*
> + * Get btrfs sysfs kobject.
> + */
> +static inline struct kobject *get_btrfs_kobj(struct kobject *kobj)
> +{
> +	while (kobj) {
> +		if (kobj->ktype == &btrfs_ktype)
> +			return kobj;
> +		kobj = kobj->parent;
> +	}
> +
> +	return NULL;
> +}
> +
>  #define NUM_FEATURE_BITS 64
>  #define BTRFS_FEATURE_NAME_MAX 13
>  static char btrfs_unknown_feature_names[FEAT_MAX][NUM_FEATURE_BITS][BTRFS_FEATURE_NAME_MAX];
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 6031e2f4c6bc..4ab581c03cda 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -4990,7 +4990,9 @@ struct alloc_chunk_ctl {
>  	int ncopies;
>  	/* Number of stripes worth of bytes to store parity information */
>  	int nparity;
> +	/* Maximum stripe size */
>  	u64 max_stripe_size;
> +	/* Maximum chunk size */
>  	u64 max_chunk_size;
>  	u64 dev_extent_min;
>  	u64 stripe_size;

This is superflous, you can drop this bit.  Thanks,

Josef
