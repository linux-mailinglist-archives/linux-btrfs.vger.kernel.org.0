Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024842A4C79
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 18:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbgKCRPK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 12:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728694AbgKCRPK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Nov 2020 12:15:10 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31847C0613D1
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Nov 2020 09:15:10 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id i17so6046549qvp.11
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Nov 2020 09:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wI6aDHqAyrqgSXfdmRBLowx7wp+QgLFCmIHLRsJP9Ks=;
        b=iIrEbaReeqf0YU28wbExaxtf7O0kMmH4TcfzBWLGMIZrsNBba9Uah8aiAmKfJPdyPt
         rc7STmsGoTItUsxN92WBJGI3KV0ujlZpP0X7PdGQI+uJRnrzt374AtdsQc2bO3SPyfPn
         8UVloNltDVmoK1okCBDoyyzoUqkjSPU57fadW2gD9td2shzyf2WlD3dtm6DeWJnOUX3w
         pyufuth/6RumFWcuW0ZhZbywxUTWVPzb5b+P3U2/j00IM35bGceeq3pFyeGyllMMnuwW
         zMrLSgvhyqqtZBQ6OB/DxIt6CEoHrYCTRQ+eWhkiOL9Le3OR0tRq0wTllyYSiKG0UQck
         Laew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wI6aDHqAyrqgSXfdmRBLowx7wp+QgLFCmIHLRsJP9Ks=;
        b=eEZlCaG+SVQ7uJXkVgyg6+acNFyOOR0uVmBJ2ZuJsTWiXf6tSIDuvAmgjlOCBIVxDc
         XURYfDtv9ramYPHt2+4nbK7o1yfzDgvuiGPAko/MoDjw53WAEMfm1OfEAE6GR59Ceogu
         3+FPjTgDZYw4Yutgz/g7zqthsjCcSkJJm+QzbJgfmPX6qIlJB2huKTPEnPs4+gteR6nr
         i6i9FuTqLjaUAO29tv/DDdntvD05AAoMRsyNymOiGk5J6jWDw/Jma9uGiFPKt+zkrBsx
         j9kbAzzsWii1WKG6PFt+VW9ZZLWYBnD7/wKwLv65Gim/XkRCtQjxPwZz5g//P2McxvjK
         cuxw==
X-Gm-Message-State: AOAM5326hFZMMk/BeU2zz7/W82ihsh9kH5GseVHpngfd2k4umGQ3Is58
        Ohc0g6o+6dzLW68iiElO1510utoNDRUSzMaQ
X-Google-Smtp-Source: ABdhPJwheNkZV/9jR1Ea5q2dLZ4MTTqlGWst4d/gFTp5grXwe2wwg0c3i451b5KSt2KoxDJTVduDjQ==
X-Received: by 2002:a0c:e346:: with SMTP id a6mr28719446qvm.9.1604423709392;
        Tue, 03 Nov 2020 09:15:09 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a25sm5073361qko.17.2020.11.03.09.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 09:15:08 -0800 (PST)
Subject: Re: [PATCH v9 32/41] btrfs: implement cloning for ZONED
 device-replace
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <a65d400de20403db088a8093073735cd1f783e22.1604065695.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <aac09fed-3522-806b-be53-b6a8e6b0b5c5@toxicpanda.com>
Date:   Tue, 3 Nov 2020 12:15:07 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <a65d400de20403db088a8093073735cd1f783e22.1604065695.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/30/20 9:51 AM, Naohiro Aota wrote:
> This is 2/4 patch to implement device-replace for ZONED mode.
> 
> On zoned mode, a block group must be either copied (from the source device
> to the destination device) or cloned (to the both device).
> 
> This commit implements the cloning part. If a block group targeted by an IO
> is marked to copy, we should not clone the IO to the destination device,
> because the block group is eventually copied by the replace process.
> 
> This commit also handles cloning of device reset.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   fs/btrfs/dev-replace.c |  4 ++--
>   fs/btrfs/extent-tree.c | 20 ++++++++++++++++++--
>   fs/btrfs/scrub.c       |  2 +-
>   fs/btrfs/volumes.c     | 33 +++++++++++++++++++++++++++++++--
>   fs/btrfs/zoned.c       | 11 +++++++++++
>   5 files changed, 63 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> index e86aff38aea4..848f8063dc1c 100644
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -454,7 +454,7 @@ static int mark_block_group_to_copy(struct btrfs_fs_info *fs_info,
>   	u64 chunk_offset, length;
>   
>   	/* Do not use "to_copy" on non-ZONED for now */
> -	if (!btrfs_fs_incompat(fs_info, ZONED))
> +	if (!btrfs_is_zoned(fs_info))
>   		return 0;
>   
>   	mutex_lock(&fs_info->chunk_mutex);
> @@ -565,7 +565,7 @@ bool btrfs_finish_block_group_to_copy(struct btrfs_device *srcdev,
>   	int i;
>   
>   	/* Do not use "to_copy" on non-ZONED for now */
> -	if (!btrfs_fs_incompat(fs_info, ZONED))
> +	if (!btrfs_is_zoned(fs_info))
>   		return true;
>   

Heh these
>   	spin_lock(&cache->lock);
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 57454ef4c91e..1bb95d5aaed2 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -35,6 +35,7 @@
>   #include "discard.h"
>   #include "rcu-string.h"
>   #include "zoned.h"
> +#include "dev-replace.h"
>   
>   #undef SCRAMBLE_DELAYED_REFS
>   
> @@ -1336,6 +1337,8 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
>   			u64 length = stripe->length;
>   			u64 bytes;
>   			struct request_queue *req_q;
> +			struct btrfs_dev_replace *dev_replace =
> +				&fs_info->dev_replace;
>   
>   			if (!stripe->dev->bdev) {
>   				ASSERT(btrfs_test_opt(fs_info, DEGRADED));
> @@ -1344,15 +1347,28 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
>   
>   			req_q = bdev_get_queue(stripe->dev->bdev);
>   			/* zone reset in ZONED mode */
> -			if (btrfs_can_zone_reset(dev, physical, length))
> +			if (btrfs_can_zone_reset(dev, physical, length)) {
>   				ret = btrfs_reset_device_zone(dev, physical,
>   							      length, &bytes);
> -			else if (blk_queue_discard(req_q))
> +				if (ret)
> +					goto next;
> +				if (!btrfs_dev_replace_is_ongoing(
> +					    dev_replace) ||
> +				    dev != dev_replace->srcdev)
> +					goto next;
> +
> +				discarded_bytes += bytes;
> +				/* send to replace target as well */
> +				ret = btrfs_reset_device_zone(
> +					dev_replace->tgtdev,
> +					physical, length, &bytes);
> +			} else if (blk_queue_discard(req_q))

And this needs to go into a helper, because lord it's not pretty.  Thanks,

Josef
