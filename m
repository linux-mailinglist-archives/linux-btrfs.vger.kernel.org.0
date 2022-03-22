Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B424E4530
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Mar 2022 18:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239573AbiCVReR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Mar 2022 13:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236813AbiCVReR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Mar 2022 13:34:17 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067518CD9E
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 10:32:49 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id s16so14519219qks.4
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 10:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JtYvdZRFT2Ivy1v/zc8k6mKjS4IYfl3QPmvDOstsEOQ=;
        b=kZZ2UvGrsBSfNabVLU/+poh4VkCC4l0Njmpzf3QnGSCSQ1fYoS600FLcKehWPNojgF
         FHl5kAj3Eko9p/aikwP5nKpio5uxeQEod0o4Hp7Gi6XIWnLzw2s0bcbQAAVKIAQ5Z9hl
         qJtbhsf0A/izX2FjDUW6VTO6E6Nnf55SHgZ0rsTddPZE8heFZ4YIs6o4XwWAdaRu4d7j
         PWlv7NUsqzEIi5JAc80aNgsBWlhmfF8QGJPxyTlAtIndqJr8ApZVVjPTgFWVFpu8yI0c
         8hp25amGzu4JJ06/5cq7151pqXbraVprhxQ9Lw2nV19IjNS5hAla6jJ29cWCBdLOCjIk
         QcXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JtYvdZRFT2Ivy1v/zc8k6mKjS4IYfl3QPmvDOstsEOQ=;
        b=X9zim++wUeHiGQ5qWmG0t6FAIrk7n/0gWT8N/Ji9NiU45oVoU/555eTRFJA0E7YmRJ
         727uWXRNS7JJ6GMDJKpJKPXezMA5KViKsA3azqid4CYTBIL8nFZICuIfU/ONvcA/Zqd8
         eyZ4Xr4L6C0o3tuaY9Td7YqRMb5Xsl/Y7/1S+L1Y6nnP7xlyA0Xbj7scf7k2znU4Cqkw
         5jD8yek4/BcwQr2CofBTI6OiHT/QHzjZTnWBLDHx2fPIfOJPtVBU2Os/EiWsNLFKpfVu
         RZM+WiVD/S9uCMRn794TwgOTrjBQ4wCl2FXvaXoiKgeZHttco4XyYKD3hzYpLxCs8WzJ
         ih3Q==
X-Gm-Message-State: AOAM533VyrcgrZ1zmcevcexW1xrNxDkZW9VXhr/lKoSrKziTGX6m2BYa
        JL2T/8eW4k75IypH9QX9DWKOcA==
X-Google-Smtp-Source: ABdhPJxjwhSmIS+/Gle98bJqRhtkzZ0s5hLlsmNwHnu7q4NacOe9U7/3CW+D36r+fDxtPed/g6RB7w==
X-Received: by 2002:a05:620a:13fb:b0:67b:12dd:27c5 with SMTP id h27-20020a05620a13fb00b0067b12dd27c5mr16030697qkl.498.1647970367809;
        Tue, 22 Mar 2022 10:32:47 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e15-20020ac8670f000000b002e22d9c756dsm45294qtp.30.2022.03.22.10.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 10:32:47 -0700 (PDT)
Date:   Tue, 22 Mar 2022 13:32:45 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 1/5] btrfs: make the bg_reclaim_threshold per-space info
Message-ID: <YjoIPZtKly5+jBfV@localhost.localdomain>
References: <cover.1647878642.git.johannes.thumshirn@wdc.com>
 <63d4d206dd2e652aa968ab0fa30dd9aab98a666b.1647878642.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63d4d206dd2e652aa968ab0fa30dd9aab98a666b.1647878642.git.johannes.thumshirn@wdc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 21, 2022 at 09:14:10AM -0700, Johannes Thumshirn wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> For !zoned file systems it's useful to have the auto reclaim feature,
> however there are different use cases for !zoned, for example we may not
> want to reclaim metadata chunks ever, only data chunks.  Move this sysfs
> flag to per-space_info.  This won't affect current users because this
> tunable only ever did anything for zoned, and that is currently hidden
> behind BTRFS_CONFIG_DEBUG.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ jth restore global bg_reclaim_threshold ]
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/free-space-cache.c |  7 +++++--
>  fs/btrfs/space-info.c       |  9 +++++++++
>  fs/btrfs/space-info.h       |  6 ++++++
>  fs/btrfs/sysfs.c            | 37 +++++++++++++++++++++++++++++++++++++
>  fs/btrfs/zoned.h            |  6 +-----
>  5 files changed, 58 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index 01a408db5683..ef84bc5030cd 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -2630,16 +2630,19 @@ int __btrfs_add_free_space(struct btrfs_block_group *block_group,
>  static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
>  					u64 bytenr, u64 size, bool used)
>  {
> -	struct btrfs_fs_info *fs_info = block_group->fs_info;
> +	struct btrfs_space_info *sinfo = block_group->space_info;
>  	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
>  	u64 offset = bytenr - block_group->start;
>  	u64 to_free, to_unusable;
> -	const int bg_reclaim_threshold = READ_ONCE(fs_info->bg_reclaim_threshold);
> +	int bg_reclaim_threshold = 0;
>  	bool initial = (size == block_group->length);
>  	u64 reclaimable_unusable;
>  
>  	WARN_ON(!initial && offset + size > block_group->zone_capacity);
>  
> +	if (!initial)
> +		bg_reclaim_threshold = READ_ONCE(sinfo->bg_reclaim_threshold);
> +
>  	spin_lock(&ctl->tree_lock);
>  	if (!used)
>  		to_free = size;
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index b87931a458eb..60d0a58c4644 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -181,6 +181,12 @@ void btrfs_clear_space_info_full(struct btrfs_fs_info *info)
>  		found->full = 0;
>  }
>  
> +/*
> + * Block groups with more than this value (percents) of unusable space will be
> + * scheduled for background reclaim.
> + */
> +#define BTRFS_DEFAULT_ZONED_RECLAIM_THRESH	75
> +
>  static int create_space_info(struct btrfs_fs_info *info, u64 flags)
>  {
>  
> @@ -203,6 +209,9 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
>  	INIT_LIST_HEAD(&space_info->priority_tickets);
>  	space_info->clamp = 1;
>  
> +	if (btrfs_is_zoned(info))
> +		space_info->bg_reclaim_threshold = BTRFS_DEFAULT_ZONED_RECLAIM_THRESH;
> +
>  	ret = btrfs_sysfs_add_space_info_type(info, space_info);
>  	if (ret)
>  		return ret;
> diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
> index d841fed73492..0c45f539e3cf 100644
> --- a/fs/btrfs/space-info.h
> +++ b/fs/btrfs/space-info.h
> @@ -24,6 +24,12 @@ struct btrfs_space_info {
>  				   the space info if we had an ENOSPC in the
>  				   allocator. */
>  
> +	/*
> +	 * Once a block group drops below this threshold we'll schedule it for
> +	 * reclaim.
> +	 */
> +	int bg_reclaim_threshold;
> +
>  	int clamp;		/* Used to scale our threshold for preemptive
>  				   flushing. The value is >> clamp, so turns
>  				   out to be a 2^clamp divisor. */
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 17389a42a3ab..90da1ea0cae0 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -722,6 +722,42 @@ SPACE_INFO_ATTR(bytes_zone_unusable);
>  SPACE_INFO_ATTR(disk_used);
>  SPACE_INFO_ATTR(disk_total);
>  
> +static ssize_t btrfs_sinfo_bg_reclaim_threshold_show(struct kobject *kobj,
> +						     struct kobj_attribute *a,
> +						     char *buf)
> +{
> +	struct btrfs_space_info *space_info = to_space_info(kobj);
> +	ssize_t ret;
> +
> +	ret = sysfs_emit(buf, "%d\n", READ_ONCE(space_info->bg_reclaim_threshold));
> +
> +	return ret;
> +}
> +
> +static ssize_t btrfs_sinfo_bg_reclaim_threshold_store(struct kobject *kobj,
> +						      struct kobj_attribute *a,
> +						      const char *buf, size_t len)
> +{
> +	struct btrfs_space_info *space_info = to_space_info(kobj);
> +	int thresh;
> +	int ret;
> +
> +	ret = kstrtoint(buf, 10, &thresh);
> +	if (ret)
> +		return ret;
> +
> +	if (thresh != 0 && (thresh <= 50 || thresh > 100))
> +		return -EINVAL;
> +
> +	WRITE_ONCE(space_info->bg_reclaim_threshold, thresh);
> +
> +	return len;
> +}
> +
> +BTRFS_ATTR_RW(space_info, bg_reclaim_threshold,
> +	      btrfs_sinfo_bg_reclaim_threshold_show,
> +	      btrfs_sinfo_bg_reclaim_threshold_store);
> +
>  /*
>   * Allocation information about block group types.
>   *
> @@ -738,6 +774,7 @@ static struct attribute *space_info_attrs[] = {
>  	BTRFS_ATTR_PTR(space_info, bytes_zone_unusable),
>  	BTRFS_ATTR_PTR(space_info, disk_used),
>  	BTRFS_ATTR_PTR(space_info, disk_total),
> +	BTRFS_ATTR_PTR(space_info, bg_reclaim_threshold),
>  	NULL,
>  };
>  ATTRIBUTE_GROUPS(space_info);
> diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
> index cbf016a7bb5d..c489c08d7fd5 100644
> --- a/fs/btrfs/zoned.h
> +++ b/fs/btrfs/zoned.h
> @@ -10,11 +10,7 @@
>  #include "block-group.h"
>  #include "btrfs_inode.h"
>  
> -/*
> - * Block groups with more than this value (percents) of unusable space will be
> - * scheduled for background reclaim.
> - */
> -#define BTRFS_DEFAULT_RECLAIM_THRESH		75
> +#define BTRFS_DEFAULT_RECLAIM_THRESH           75
> 

Looks like you added this back by accident?

Josef 
