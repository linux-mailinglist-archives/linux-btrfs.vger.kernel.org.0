Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E83D712F943
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2020 15:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbgACOiU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jan 2020 09:38:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:34172 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727527AbgACOiU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Jan 2020 09:38:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1DE91ABD0;
        Fri,  3 Jan 2020 14:38:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AEE78DA795; Fri,  3 Jan 2020 15:38:07 +0100 (CET)
Date:   Fri, 3 Jan 2020 15:38:06 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 01/12] btrfs: calculate discard delay based on number of
 extents
Message-ID: <20200103143806.GS3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dennis Zhou <dennis@kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
References: <cover.1577999991.git.dennis@kernel.org>
 <d9cfb7e7a23e60845e6fc6213ee34e77946849a6.1577999991.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9cfb7e7a23e60845e6fc6213ee34e77946849a6.1577999991.git.dennis@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 02, 2020 at 04:26:35PM -0500, Dennis Zhou wrote:
> An earlier patch keeps track of discardable_extents. These are
> undiscarded extents managed by the free space cache. Here, we will use
> this to dynamically calculate the discard delay interval.
> 
> There are 3 rate to consider. The first is the target convergence rate,
> the rate to discard all discardable_extents over the
> BTRFS_DISCARD_TARGET_MSEC time frame. This is clamped by the lower
> limit, the iops limit or BTRFS_DISCARD_MIN_DELAY (1ms), and the upper
> limit, BTRFS_DISCARD_MAX_DELAY (1s). We reevaluate this delay every
> transaction commit.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/ctree.h       |  2 ++
>  fs/btrfs/discard.c     | 55 +++++++++++++++++++++++++++++++++++++++---
>  fs/btrfs/discard.h     |  1 +
>  fs/btrfs/extent-tree.c |  4 ++-
>  fs/btrfs/sysfs.c       | 31 ++++++++++++++++++++++++
>  5 files changed, 88 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 7c1c236d13ae..c73bbc7e4491 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -468,6 +468,8 @@ struct btrfs_discard_ctl {
>  	struct list_head discard_list[BTRFS_NR_DISCARD_LISTS];
>  	atomic_t discardable_extents;
>  	atomic64_t discardable_bytes;
> +	unsigned long delay;
> +	unsigned iops_limit;

As the kbps_limit uses u32, I switched that to u32 as well.

>  };
>  
>  /* delayed seq elem */
> diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> index 173770bf8a2d..abcc3b2189d1 100644
> --- a/fs/btrfs/discard.c
> +++ b/fs/btrfs/discard.c
> @@ -15,6 +15,12 @@
>  #define BTRFS_DISCARD_DELAY		(120ULL * NSEC_PER_SEC)
>  #define BTRFS_DISCARD_UNUSED_DELAY	(10ULL * NSEC_PER_SEC)
>  
> +/* Target completion latency of discarding all discardable extents */
> +#define BTRFS_DISCARD_TARGET_MSEC	(6 * 60 * 60UL * MSEC_PER_SEC)
> +#define BTRFS_DISCARD_MIN_DELAY_MSEC	(1UL)
> +#define BTRFS_DISCARD_MAX_DELAY_MSEC	(1000UL)
> +#define BTRFS_DISCARD_MAX_IOPS		(10U)
> +
>  static struct list_head *get_discard_list(struct btrfs_discard_ctl *discard_ctl,
>  					  struct btrfs_block_group *block_group)
>  {
> @@ -235,11 +241,18 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
>  
>  	block_group = find_next_block_group(discard_ctl, now);
>  	if (block_group) {
> -		u64 delay = 0;
> +		unsigned long delay = discard_ctl->delay;
> +
> +		/*
> +		 * This timeout is to hopefully prevent immediate discarding
> +		 * in a recently allocated block group.
> +		 */
> +		if (now < block_group->discard_eligible_time) {
> +			u64 bg_timeout = (block_group->discard_eligible_time -
> +					  now);
>  
> -		if (now < block_group->discard_eligible_time)
> -			delay = nsecs_to_jiffies(
> -				block_group->discard_eligible_time - now);
> +			delay = max(delay, nsecs_to_jiffies(bg_timeout));
> +		}
>  
>  		mod_delayed_work(discard_ctl->discard_workers,
>  				 &discard_ctl->work, delay);
> @@ -342,6 +355,38 @@ bool btrfs_run_discard_work(struct btrfs_discard_ctl *discard_ctl)
>  		test_bit(BTRFS_FS_DISCARD_RUNNING, &fs_info->flags));
>  }
>  
> +/**
> + * btrfs_discard_calc_delay - recalculate the base delay
> + * @discard_ctl: discard control
> + *
> + * Recalculate the base delay which is based off the total number of
> + * discardable_extents.  Clamp this between the lower_limit (iops_limit or 1ms)
> + * and the upper_limit (BTRFS_DISCARD_MAX_DELAY_MSEC).
> + */
> +void btrfs_discard_calc_delay(struct btrfs_discard_ctl *discard_ctl)
> +{
> +	s32 discardable_extents =
> +		atomic_read(&discard_ctl->discardable_extents);
> +	unsigned iops_limit;
> +	unsigned long delay, lower_limit = BTRFS_DISCARD_MIN_DELAY_MSEC;
> +
> +	if (!discardable_extents)
> +		return;
> +
> +	spin_lock(&discard_ctl->lock);
> +
> +	iops_limit = READ_ONCE(discard_ctl->iops_limit);
> +	if (iops_limit)
> +		lower_limit = max_t(unsigned long, lower_limit,
> +				    MSEC_PER_SEC / iops_limit);
> +
> +	delay = BTRFS_DISCARD_TARGET_MSEC / discardable_extents;
> +	delay = clamp(delay, lower_limit, BTRFS_DISCARD_MAX_DELAY_MSEC);
> +	discard_ctl->delay = msecs_to_jiffies(delay);
> +
> +	spin_unlock(&discard_ctl->lock);
> +}
> +
>  /**
>   * btrfs_discard_update_discardable - propagate discard counters
>   * @block_group: block_group of interest
> @@ -464,6 +509,8 @@ void btrfs_discard_init(struct btrfs_fs_info *fs_info)
>  
>  	atomic_set(&discard_ctl->discardable_extents, 0);
>  	atomic64_set(&discard_ctl->discardable_bytes, 0);
> +	discard_ctl->delay = BTRFS_DISCARD_MAX_DELAY_MSEC;
> +	discard_ctl->iops_limit = BTRFS_DISCARD_MAX_IOPS;
>  }
>  
>  void btrfs_discard_cleanup(struct btrfs_fs_info *fs_info)
> diff --git a/fs/btrfs/discard.h b/fs/btrfs/discard.h
> index 0f2f89b1b0b9..5250fe178e49 100644
> --- a/fs/btrfs/discard.h
> +++ b/fs/btrfs/discard.h
> @@ -17,6 +17,7 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
>  bool btrfs_run_discard_work(struct btrfs_discard_ctl *discard_ctl);
>  
>  /* Update operations */
> +void btrfs_discard_calc_delay(struct btrfs_discard_ctl *discard_ctl);
>  void btrfs_discard_update_discardable(struct btrfs_block_group *block_group,
>  				      struct btrfs_free_space_ctl *ctl);
>  
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 2c12366cfde5..0163fdd59f8f 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -2935,8 +2935,10 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
>  		cond_resched();
>  	}
>  
> -	if (btrfs_test_opt(fs_info, DISCARD_ASYNC))
> +	if (btrfs_test_opt(fs_info, DISCARD_ASYNC)) {
> +		btrfs_discard_calc_delay(&fs_info->discard_ctl);
>  		btrfs_discard_schedule_work(&fs_info->discard_ctl, true);
> +	}
>  
>  	/*
>  	 * Transaction is finished.  We don't need the lock anymore.  We
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index e9dbdbbbebeb..e175aaf7a1e6 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -344,6 +344,36 @@ static const struct attribute_group btrfs_static_feature_attr_group = {
>   */
>  #define discard_to_fs_info(_kobj)	to_fs_info((_kobj)->parent->parent)
>  
> +static ssize_t btrfs_discard_iops_limit_show(struct kobject *kobj,
> +					     struct kobj_attribute *a,
> +					     char *buf)
> +{
> +	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
> +
> +	return snprintf(buf, PAGE_SIZE, "%u\n",
> +			READ_ONCE(fs_info->discard_ctl.iops_limit));
> +}
> +
> +static ssize_t btrfs_discard_iops_limit_store(struct kobject *kobj,
> +					      struct kobj_attribute *a,
> +					      const char *buf, size_t len)
> +{
> +	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
> +	struct btrfs_discard_ctl *discard_ctl = &fs_info->discard_ctl;
> +	unsigned iops_limit;
> +	int ret;
> +
> +	ret = kstrtouint(buf, 10, &iops_limit);
> +	if (ret)
> +		return -EINVAL;
> +
> +	WRITE_ONCE(discard_ctl->iops_limit, iops_limit);
> +
> +	return len;
> +}
> +BTRFS_ATTR_RW(discard, iops_limit, btrfs_discard_iops_limit_show,
> +	      btrfs_discard_iops_limit_store);
> +
>  static ssize_t btrfs_discardable_extents_show(struct kobject *kobj,
>  					      struct kobj_attribute *a,
>  					      char *buf)
> @@ -367,6 +397,7 @@ static ssize_t btrfs_discardable_bytes_show(struct kobject *kobj,
>  BTRFS_ATTR(discard, discardable_bytes, btrfs_discardable_bytes_show);
>  
>  static const struct attribute *discard_debug_attrs[] = {
> +	BTRFS_ATTR_PTR(discard, iops_limit),
>  	BTRFS_ATTR_PTR(discard, discardable_extents),
>  	BTRFS_ATTR_PTR(discard, discardable_bytes),

I've reordered the callbacks and definitions so they're in alphabetical
order (in the base branch and in all the following patches).
