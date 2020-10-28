Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5F929D4EB
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Oct 2020 22:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbgJ1Vzd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Oct 2020 17:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728459AbgJ1Vzc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Oct 2020 17:55:32 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99586C0613CF
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Oct 2020 14:55:32 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id z5so1155376iob.1
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Oct 2020 14:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hQNnm+mpULCg8G/9Dl0lri/cFn56wFV+nQfEj/MGxh0=;
        b=u2gAA+WnzvZQu4wgbtYFg6LDt3fQQP8OBEAIGLnRYtV/hsOudgXn6WZqxtuT+3kCzP
         /LCndPOqDmH27brW/Digvcp4TB3BLsra5fh+0sBtjdxXBGHQ1k5o/9x4uvJKdBIoG8Aj
         xKsQHBy4dtq9D11CVd9/hHj88N2EBfSRIfTBn6FgU83PMfSsRyoGnYdIE+78/G6u9sIP
         Z7A/9hgOjK+5+riOteFgnwE6GrCTHQkJ6gMUzRipQAhDerGrygB/VRSh05B2qUEx1oTS
         QFgXDInPnler0yPVvi86JTQ3qBjzNZ8a7qZHCnSlGXvIdA7HEbK5HwHZRK0QNZnyPfBh
         +iJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hQNnm+mpULCg8G/9Dl0lri/cFn56wFV+nQfEj/MGxh0=;
        b=hy6LxBEyxwjnoAjKRZF+9dRUP1xWyKbR7CipGBdY5Hi+796VLR5oEmcUmkLr1Hm2Be
         MB8QHFFKmmyPS9Du4IAp4bXKODXnYpzTfSkeqs3oDPzZBhDK+Vtd7XtfprxJfEPGXQuL
         AktiWMvLbPe6RGN+Qf1XoRjqieih1Od7jsRBPwouEao2J2qYN9ocL/40LxNbOhMNlMdW
         g8YCEMh+zOmBoM8FEjTHMzB14JQ3V2Zt28YGu9EEhp2RrLiyOixoM6ekgpxdEQztwqAB
         N+6O2eLkGUe9LBOzxna6a/xi2z9J+IFxIp0y/PznFA0ACLIgaeqQYmfhxtpLdiAVa+Kq
         k0zA==
X-Gm-Message-State: AOAM532R161VY8YoprAyhihstPtsyhCiV02LUB2Ee2V++7lN67BbApit
        Sl+xI7K9NbInRZ3IGXGEOk6BWVIMSMFk6nDt
X-Google-Smtp-Source: ABdhPJzQmv5YvjdGUce4g4x8jyRVpQ3ugt+jo2/hDcPcidIQOUZELssvIuydBRnr3jMbDieVx4vOcg==
X-Received: by 2002:ac8:5ccc:: with SMTP id s12mr2888906qta.179.1603895453019;
        Wed, 28 Oct 2020 07:30:53 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 198sm3101309qki.117.2020.10.28.07.30.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 07:30:52 -0700 (PDT)
Subject: Re: [PATCH 1/4] btrfs: add read_policy latency
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <cover.1603884539.git.anand.jain@oracle.com>
 <ae5e526c1549d4e6f602c09d8235aa406c5a1404.1603884539.git.anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <77b4e2b8-da2f-b539-76e3-881046ee9101@toxicpanda.com>
Date:   Wed, 28 Oct 2020 10:30:51 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <ae5e526c1549d4e6f602c09d8235aa406c5a1404.1603884539.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/28/20 9:26 AM, Anand Jain wrote:
> The read policy type latency routes the read IO based on the historical
> average wait time experienced by the read IOs through the individual
> device factored by 1/10 of inflight commands in the queue. The factor
> 1/10 is because generally the block device queue depth is more than 1,
> so there can be commands in the queue even before the previous commands
> have been completed. This patch obtains the historical read IO stats from
> the kernel block layer.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v1: Drop part_stat_read_all instead use part_stat_read
>      Drop inflight
>      
>   fs/btrfs/sysfs.c   |  3 ++-
>   fs/btrfs/volumes.c | 39 ++++++++++++++++++++++++++++++++++++++-
>   fs/btrfs/volumes.h |  1 +
>   3 files changed, 41 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 4dbf90ff088a..88cbf7b2edf0 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -906,7 +906,8 @@ static bool btrfs_strmatch(const char *given, const char *golden)
>   	return false;
>   }
>   
> -static const char * const btrfs_read_policy_name[] = { "pid" };
> +/* Must follow the order as in enum btrfs_read_policy */
> +static const char * const btrfs_read_policy_name[] = { "pid", "latency" };
>   
>   static ssize_t btrfs_read_policy_show(struct kobject *kobj,
>   				      struct kobj_attribute *a, char *buf)
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 6bf487626f23..48587009b656 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -14,6 +14,7 @@
>   #include <linux/semaphore.h>
>   #include <linux/uuid.h>
>   #include <linux/list_sort.h>
> +#include <linux/part_stat.h>
>   #include "misc.h"
>   #include "ctree.h"
>   #include "extent_map.h"
> @@ -5468,6 +5469,39 @@ int btrfs_is_parity_mirror(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
>   	return ret;
>   }
>   
> +static int btrfs_find_best_stripe(struct btrfs_fs_info *fs_info,
> +				  struct map_lookup *map, int first,
> +				  int num_stripe)
> +{
> +	u64 est_wait = 0;
> +	int best_stripe = 0;
> +	int index;
> +
> +	for (index = first; index < first + num_stripe; index++) {
> +		u64 read_wait;
> +		u64 avg_wait = 0;
> +		unsigned long read_ios;
> +		struct btrfs_device *device = map->stripes[index].dev;
> +
> +		read_wait = part_stat_read(device->bdev->bd_part, nsecs[READ]);
> +		read_ios = part_stat_read(device->bdev->bd_part, ios[READ]);
> +
> +		if (read_wait && read_ios && read_wait >= read_ios)
> +			avg_wait = div_u64(read_wait, read_ios);
> +		else
> +			btrfs_info_rl(device->fs_devices->fs_info,
> +			"devid: %llu avg_wait ZERO read_wait %llu read_ios %lu",
> +				      device->devid, read_wait, read_ios);

Do we even care about this?  I feel like if we do at all it can be btrfs_debug 
or something.

> +
> +		if (est_wait == 0 || est_wait > avg_wait) {
> +			est_wait = avg_wait;
> +			best_stripe = index;
> +		}
> +	}
> +
> +	return best_stripe;
> +}
> +
>   static int find_live_mirror(struct btrfs_fs_info *fs_info,
>   			    struct map_lookup *map, int first,
>   			    int dev_replace_is_ongoing)
> @@ -5498,6 +5532,10 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
>   	case BTRFS_READ_POLICY_PID:
>   		preferred_mirror = first + current->pid % num_stripes;
>   		break;
> +	case BTRFS_READ_POLICY_LATENCY:
> +		preferred_mirror = btrfs_find_best_stripe(fs_info, map, first,
> +							  num_stripes);
> +		break;
>   	}
>   
>   	if (dev_replace_is_ongoing &&
> @@ -6114,7 +6152,6 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
>   
>   	} else if (map->type & BTRFS_BLOCK_GROUP_RAID10) {
>   		u32 factor = map->num_stripes / map->sub_stripes;
> -

Unrelated change.  Thanks,

Josef
