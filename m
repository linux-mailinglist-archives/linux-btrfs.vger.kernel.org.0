Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA5743E280
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Oct 2021 15:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhJ1NvO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Oct 2021 09:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbhJ1NvM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Oct 2021 09:51:12 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A717BC061570
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Oct 2021 06:48:45 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id x123so5797061qke.7
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Oct 2021 06:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mhs3+xHyHcdySvVV9+x8lHddL/djMhYu+n/ISTVf83g=;
        b=FSVLIJ6gMlmD+euuobzgzvQF4D5qUYM2zFKYzWF1yac1BEPIuSnNIoxQRUukR8Ls9C
         E4lvI331xtRr34CWLFhpSI8CqeJgfl9FsRdeT7z/vkbGk54j4sjF2wwPyTk8oe266yXl
         mSDpwlS4Ci3nM2Z9t1hBFlhFtIzwwpCz07OgGTmZTTwXFCAmPY1jZvW/wq1bz1MMvuUq
         sNVJKb2ihmya910CN8vQ4+YamvfpdwLM8sqBOJDIsHhIM0YkQ83wvKT10hm+l+MsQ8+L
         WSbTHacSZz8fyXncF6gpCmsj4IBsDD0BYE1bUOyodRb/KJE4lDueg29gYw6HzTPMmivj
         p7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mhs3+xHyHcdySvVV9+x8lHddL/djMhYu+n/ISTVf83g=;
        b=TuYk2YTYJxaa1dM3FskSaEMS1AnaL6kdt0xdIFdUgancdaR3hVIJSm+ygbLt8vFyNu
         fbJVolpT+rhJku9a0hryM6rPTXROyV7a6OuTe58IpGM9NI0SE10vHBmEtoYr6zJeYxsu
         81uX+zQcIo04KSp9LGawMjS7tLYtZh1C76M+87BQuDrwuA2R1smpoE8gxATpMYjT++IJ
         kdHBtRDkTledkv+dtECXz2zbfJkAvfbmwGY2hu2ttrtu8px+0qFEOO9gfR8RLjPfEw0A
         YgTUHa0kp4cz5D6nzBP1ysGeHjyYrQIu4WTItsOE7O/BwwtwtP/xAp4WLt84g0l6X3AQ
         r1Rw==
X-Gm-Message-State: AOAM531DmIMk7QIMTRYbjlwVvIRnz4H4X8b3Kgd/HaBtUhs/v50X8z+w
        V5lt58faigmI7EU8HO4+r82gLeNbjMaxyw==
X-Google-Smtp-Source: ABdhPJx3R5Ml9ruLIB2PGi0CFW+qObPlrcocj0v59p4HJ6R9+IDMkkeowSl5SRykObusz3VsoLnxdA==
X-Received: by 2002:a37:b385:: with SMTP id c127mr3661669qkf.206.1635428924605;
        Thu, 28 Oct 2021 06:48:44 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b2sm1929241qtg.88.2021.10.28.06.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 06:48:44 -0700 (PDT)
Date:   Thu, 28 Oct 2021 09:48:43 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Stefan Roesch <shr@fb.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 1/4] btrfs: store stripe size and chunk size in
 space-info struct.
Message-ID: <YXqqO7Le8sSWpOEG@localhost.localdomain>
References: <20211027201441.3813178-1-shr@fb.com>
 <20211027201441.3813178-2-shr@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027201441.3813178-2-shr@fb.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 27, 2021 at 01:14:38PM -0700, Stefan Roesch wrote:
> The stripe size and chunk size are stored in the btrfs_space_info
> structure. They are initialized at the start and are then used.
> 
> Two api's are added to get the current value and one to update
> the value.
> 
> These api's will be used to be able to expose the stripe_size
> as a sysfs setting.
> 
> Signed-off-by: Stefan Roesch <shr@fb.com>
> ---
>  fs/btrfs/space-info.c | 72 +++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/space-info.h |  4 +++
>  fs/btrfs/volumes.c    | 28 ++++++-----------
>  3 files changed, 85 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 48d77f360a24..570acfebeae4 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -181,6 +181,74 @@ void btrfs_clear_space_info_full(struct btrfs_fs_info *info)
>  		found->full = 0;
>  }
>  
> +/*
> + * Compute stripe size depending on block type for regular volumes.
> + */
> +static u64 compute_stripe_size_regular(struct btrfs_fs_info *info, u64 flags)
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
> + * Compute stripe size for zoned volumes.
> + */
> +static u64 compute_stripe_size_zoned(struct btrfs_fs_info *info)
> +{
> +	return info->zone_size;
> +}
> +
> +/*
> + * Compute stripe size depending on volume type.
> + */
> +static u64 compute_stripe_size(struct btrfs_fs_info *info, u64 flags)
> +{
> +	if (btrfs_is_zoned(info))
> +		return compute_stripe_size_zoned(info);
> +
> +	return compute_stripe_size_regular(info, flags);
> +}
> +
> +/*
> + * Compute chunk size depending on block type and stripe size.
> + */
> +static u64 compute_chunk_size(u64 flags, u64 max_stripe_size)
> +{
> +	ASSERT(flags & BTRFS_BLOCK_GROUP_TYPE_MASK);
> +
> +	if (flags & BTRFS_BLOCK_GROUP_DATA)
> +		return BTRFS_MAX_DATA_CHUNK_SIZE;
> +	else if (flags & BTRFS_BLOCK_GROUP_METADATA)
> +		return max_stripe_size;
> +
> +	/* Handle BTRFS_BLOCK_GROUP_SYSTEM */
> +	return 2 * max_stripe_size;
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
> @@ -203,6 +271,10 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
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

max_chunk_size isn't user set-able, and can be calculated from the
max_stripe_size.  You may change the names based on my previous emails, but
whatever it ends up being you only need one of these stored, the other can be
inferred.  Thanks,

Josef
