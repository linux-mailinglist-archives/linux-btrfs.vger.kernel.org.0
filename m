Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875972B24E5
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 20:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgKMTrU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 14:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgKMTrU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 14:47:20 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49ADC0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 11:47:19 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id q22so9926614qkq.6
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 11:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lSGNNjUojj6u8xs8UdMOeQKVbLtq9eSmyz0fdU6LbDI=;
        b=PKWuBSwr0/SPXKWcLbYjrWp9uwvVN3AhIstJN5fsIxogTZCmwYn3tQjDzXjgfy2GF6
         9EmScxUVeihDs237Ilp0gwMEcAODKIxxXvIYUQruWtvWo27aIzvz5sNLHck62gDbbi62
         QreGCdw8xu56wSFXKUphO3y4AL+fYn23OJ6eVrYvfU6d8Re2i9c9V1Gr8aeePgKEtvn8
         sF5WnqIL5RIGc0vY8MZCUzFUwcImwOB5Xvf3OfgoPmeNNlG3lLcJ8CxThSnIRxFZhu2/
         zDkcqHLreEmgV6O4slVn9pBZl4LuAFt+kZWVQHV55D+ctgf9V0FQZ6ao6uSnqfOvwUWc
         OJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lSGNNjUojj6u8xs8UdMOeQKVbLtq9eSmyz0fdU6LbDI=;
        b=HZZwZSNRe9CrZDxNa18G2ED+UvF41VNJleeidD8lXVI2LrLnhW5/e9eD8rxr4VlyTJ
         LR5znueoU8oc9Ka+WLrFIuRurjtv+pXqIZ1jDCV/+Lto7KaOVsEP9zSjMGW2/SzUsQTk
         /8kUvt9wXLWKHXEGWjns9tdxioxsGWhFssYY8JEu5lLTesbmS47fejKpRnBGW+adW0p4
         ayAlypr14xVE+htVZQ6b979yB5xJ4eyDE2GbzggSvyX3GJ6rh5aY698dHf+G3/juSEST
         TqVZG6IOmSUb038UJ7csDWcsKUUvrix9wY9+H7LAorhK4vEXYBhocNzMos1fk8hz83lG
         iLgQ==
X-Gm-Message-State: AOAM533cbkCEwAwOBwogMRGBwkmiyGRs6VedTUnCBR10cnidtiTkctAo
        Fe/p+vuHFELiNEvoEfxT58ccb2kiyGPdBA==
X-Google-Smtp-Source: ABdhPJzg0tZMlBBh1pr4SUCZ+dnGuXQhAL26vJqq0AsZDnoUaWjX2w/nWdxfCcTR+YIZ+AzBc93WqA==
X-Received: by 2002:a05:620a:14b2:: with SMTP id x18mr3569027qkj.440.1605296839097;
        Fri, 13 Nov 2020 11:47:19 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q189sm7556409qkd.41.2020.11.13.11.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 11:47:18 -0800 (PST)
Subject: Re: [PATCH v2 09/24] btrfs: extent_io: calculate inline extent buffer
 page size based on page size
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>
References: <20201113125149.140836-1-wqu@suse.com>
 <20201113125149.140836-10-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e9046ea1-abf0-3352-8e4f-f454410b7dc8@toxicpanda.com>
Date:   Fri, 13 Nov 2020 14:47:17 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201113125149.140836-10-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/13/20 7:51 AM, Qu Wenruo wrote:
> Btrfs only support 64K as max node size, thus for 4K page system, we
> would have at most 16 pages for one extent buffer.
> 
> For a system using 64K page size, we would really have just one
> single page.
> 
> While we always use 16 pages for extent_buffer::pages[], this means for
> systems using 64K pages, we are wasting memory for the 15 pages which
> will never be utilized.
> 
> So this patch will change how the extent_buffer::pages[] array size is
> calclulated, now it will be calculated using
> BTRFS_MAX_METADATA_BLOCKSIZE and PAGE_SIZE.
> 
> For systems using 4K page size, it will stay 16 pages.
> For systems using 64K page size, it will be just 1 page.
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/extent_io.c | 7 +------
>   fs/btrfs/extent_io.h | 8 +++++---
>   2 files changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 37dd103213f9..ca3eb095a298 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -5042,12 +5042,7 @@ __alloc_extent_buffer(struct btrfs_fs_info *fs_info, u64 start,
>   	atomic_set(&eb->refs, 1);
>   	atomic_set(&eb->io_pages, 0);
>   
> -	/*
> -	 * Sanity checks, currently the maximum is 64k covered by 16x 4k pages
> -	 */
> -	BUILD_BUG_ON(BTRFS_MAX_METADATA_BLOCKSIZE
> -		> MAX_INLINE_EXTENT_BUFFER_SIZE);
> -	BUG_ON(len > MAX_INLINE_EXTENT_BUFFER_SIZE);
> +	ASSERT(len <= BTRFS_MAX_METADATA_BLOCKSIZE);
>   
>   	return eb;
>   }
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index c76697fc3120..dfdef9c5c379 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -73,9 +73,11 @@ typedef blk_status_t (submit_bio_hook_t)(struct inode *inode, struct bio *bio,
>   
>   typedef blk_status_t (extent_submit_bio_start_t)(struct inode *inode,
>   		struct bio *bio, u64 bio_offset);
> -
> -#define INLINE_EXTENT_BUFFER_PAGES 16
> -#define MAX_INLINE_EXTENT_BUFFER_SIZE (INLINE_EXTENT_BUFFER_PAGES * PAGE_SIZE)
> +/*
> + * The SZ_64K is BTRFS_MAX_METADATA_BLOCKSIZE, here just to avoid circle
> + * including "ctree.h".
> + */

Just a passing thought, maybe we should move that definition into btrfs_tree.h.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
