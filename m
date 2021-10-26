Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E2843B911
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Oct 2021 20:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbhJZSMj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Oct 2021 14:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbhJZSMi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Oct 2021 14:12:38 -0400
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D35DC061745
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Oct 2021 11:10:14 -0700 (PDT)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1mfQrl-0000gL-65; Tue, 26 Oct 2021 19:08:05 +0100
Date:   Tue, 26 Oct 2021 19:08:05 +0100
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Stefan Roesch <shr@fb.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: sysfs: set / query btrfs stripe size
Message-ID: <20211026180805.GE3478@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Stefan Roesch <shr@fb.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20211026165915.553834-1-shr@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026165915.553834-1-shr@fb.com>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
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

   10% of the FS used for metadata on a 50 GB device? That's a
*lot*. We see up to 5% for typical / and /home workloads, dropping
down to 0.1%-0.2% for bulk storage of large static files.

   More importantly, it's not clear here (in documentation terms) what
*stripe size* means in this context. Are you talking about the number
of block groups allocated at a time in RAID-0, -10, 5 and -6? (We've
usually called this "stripe width" in discussions). Are you talking
about the amount of data written to each device in the striping before
it moves on to the next one? (64k by default, and this is what I'd
call "stripe size", although the RAID terminology standards people may
have a different name for it). Are you talking about the block group
size? (Until now, 1 GiB by default, 256 MiB for metadata).

   Thanks,
   Hugo.

> Signed-off-by: Stefan Roesch <shr@fb.com>
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
> +	}
> +
> +	BUG();
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
> @@ -5002,26 +5004,16 @@ static void init_alloc_chunk_ctl_policy_regular(
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
> +	ctl->max_stripe_size = space_info->max_stripe_size;
> +	ctl->max_chunk_size = space_info->max_chunk_size;
> +
> +	if (ctl->type & BTRFS_BLOCK_GROUP_SYSTEM)
> +		ctl->devs_max = min_t(int, ctl->devs_max, BTRFS_MAX_DEVS_SYS_CHUNK);
>  
>  	/* We don't want a chunk larger than 10% of writable space */
>  	ctl->max_chunk_size = min(div_factor(fs_devices->total_rw_bytes, 1),

-- 
Hugo Mills             | Beware geeks bearing GIFs
hugo@... carfax.org.uk |
http://carfax.org.uk/  |
PGP: E2AB1DE4          |
