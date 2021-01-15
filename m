Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45EAC2F8830
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Jan 2021 23:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbhAOWIL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Jan 2021 17:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbhAOWIK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Jan 2021 17:08:10 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A24C061757
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jan 2021 14:07:29 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id b64so13223504qkc.12
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jan 2021 14:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uNzL673GdviGLPz+r57IyRVxYAdl4OzcJ2xyxyIRfo0=;
        b=uk1p8nQuxM+wcf1gz1dHqIyhfinS6CMkT9Gzkxr1Urqh/QJAgvSB3II5AsQ84unwSG
         1ACmKfjXqaeRYN0lujwhUCL0TN2R8tuEykFPp87lSL4aheMyicyPh+YeiuyU+hAUJnsT
         zXN3TeWVKY+szlBuMrK2y4TBf4ZB0UjG0J/65NjfBB8BE9B67cf5oFP0j/PBQGR07sry
         PtmZ2cbyhHa9bCKR/zFSt4cfbaSoxUmQZKJ1q2fXmDC3ZBcud09nhc+Jl0EHAeAcQNPl
         viWG6AKKA4pOGurJgCH4BDEdmzK2w9xEffyoS/fU9wV6AMIDFSYEoR5YdLhLrvUfLQMh
         dmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uNzL673GdviGLPz+r57IyRVxYAdl4OzcJ2xyxyIRfo0=;
        b=fjPOP6DYtAFTwoNq4v+4AN/U7ZtAZ8zkaj4xUciASYXO1uRwM9yMraiM0WHi9Tab7c
         fRoaAmaHcD6SVK2ATbbUVvrbNj+IcDUps57RFbIPTl5Pfuyw9lO+oZAJNxR7ccLwaLdR
         ipxgL6sssHCZHPKqgFZnTJn2hzyTABK2q3K25DO9UrEq+NIrBjMcUj3O01X/6wYk5VRE
         khAIplnWc0OFqjLZvLUG5kTqQ5WexB90tqtsRHEKrjxuE0t7oPTVHLrMzEAQ2PpprqtF
         uyEVy40FmeaCAkzY9/HpV0tsj3fFYtGOpAfBlJNX5sqOBkIa0zRjAffDytrQ42H9rmXe
         HMRA==
X-Gm-Message-State: AOAM533KPkPdFaL1Hpd6PgCIj42HfXN8tWaUIr0BFk+mQSo5XYIMqQGn
        bBkN3H3kIbBN9brzLPUGm6YUQw==
X-Google-Smtp-Source: ABdhPJy8LJ3vY+ygYvG5UTSU/TrRD21jDXS4xq85RrA1oK/tCEYIK3ZBNYMe9dnFJr3RZEnsKnm4fA==
X-Received: by 2002:a37:bcc6:: with SMTP id m189mr14595003qkf.88.1610748449043;
        Fri, 15 Jan 2021 14:07:29 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:11e1::105d? ([2620:10d:c091:480::1:cc17])
        by smtp.gmail.com with ESMTPSA id m85sm5959788qke.33.2021.01.15.14.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 14:07:28 -0800 (PST)
Subject: Re: [PATCH v12 08/41] btrfs: allow zoned mode on non-zoned block
 devices
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <cover.1610693036.git.naohiro.aota@wdc.com>
 <b80a551167d92406924050e9ccbcd872f84fa857.1610693037.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e026431f-1cbe-fd28-c4f8-0bee4b26de16@toxicpanda.com>
Date:   Fri, 15 Jan 2021 17:07:26 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <b80a551167d92406924050e9ccbcd872f84fa857.1610693037.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/15/21 1:53 AM, Naohiro Aota wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Run zoned btrfs mode on non-zoned devices. This is done by "slicing
> up" the block-device into static sized chunks and fake a conventional zone
> on each of them. The emulated zone size is determined from the size of
> device extent.
> 
> This is mainly aimed at testing parts of the zoned mode, i.e. the zoned
> chunk allocator, on regular block devices.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   fs/btrfs/zoned.c | 149 +++++++++++++++++++++++++++++++++++++++++++----
>   fs/btrfs/zoned.h |  14 +++--
>   2 files changed, 147 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 684dad749a8c..13b240e5db4e 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -119,6 +119,37 @@ static inline u32 sb_zone_number(int shift, int mirror)
>   	return 0;
>   }
>   
> +/*
> + * Emulate blkdev_report_zones() for a non-zoned device. It slice up
> + * the block device into static sized chunks and fake a conventional zone
> + * on each of them.
> + */
> +static int emulate_report_zones(struct btrfs_device *device, u64 pos,
> +				struct blk_zone *zones, unsigned int nr_zones)
> +{
> +	const sector_t zone_sectors =
> +		device->fs_info->zone_size >> SECTOR_SHIFT;
> +	sector_t bdev_size = device->bdev->bd_part->nr_sects;

This needs to be changed to bdev_nr_sectors(), it fails to compile on misc-next. 
  This patch also fails to apply to misc-next as well.  Thanks,

Josef
