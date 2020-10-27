Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89EB29C6A7
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Oct 2020 19:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1827140AbgJ0SVn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Oct 2020 14:21:43 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44090 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1826542AbgJ0SUU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Oct 2020 14:20:20 -0400
Received: by mail-qk1-f193.google.com with SMTP id s14so2103668qkg.11
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Oct 2020 11:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=vIAKaGjcwmOF1up/6zKn+I6+l61S+EWMea2OeCH///Q=;
        b=joB/Mc2uNYoLQa2NFIo2WIzC5Ohm/lRJcq2SNKI3xVVZq/xuD9nR0OvSOkjH/7qAdu
         CCaR4yuqBKH4gEi10/PvSZujV2b1Md1iLXCQF6V9qtTUkgyEOiow2gk5Ht5ekDAtCLmj
         TeImeWIlyJUHu20hokISiRCJ7ugysNsDNr6QZvkSdOp4vcfnWUnEDFPn17UeKpj1YLN4
         QiVVeWDMk4OlDOePFyiEwNPdhZ+R+DvooUhUGm5myLpMShXwnJKHEaMrjttRAZX29o8x
         hNjqZ8OCz/H8zdp2lgsnrekqjYhlYG0yZ4ip9czYY3gSp4nZ4C5PWhDkc5uXRNSuFCk/
         4htA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vIAKaGjcwmOF1up/6zKn+I6+l61S+EWMea2OeCH///Q=;
        b=Q/5yxtVPELjqfwIMRlNRp4ffbQ7tyW0t0m68i0bnugi1KfkPR2IDoZ3BvSoDVYzcva
         R+FEU/tNC4MUTLUg9VRngyjSF+HfIrSz/+BeiB/1oFd/Ltnez8y6NEtzc0Ldl8WvlNAv
         l+V/Nv+sc5pmvm5SxT6nzp1jb699+6MM3wQ+Kk85z36pI5f/LHJ4oUw0tUvZs/n1osRo
         xpg7Smdg92+FvqmNBo4DD8F3m6Z2+lIPfCRSkT9dtS2zQK2mv6MGbmww7SXy5WtvMEsL
         Fii72gHrRVftYGQeco0lQKrOsPZdlhGAgqm3pd5oavw9xAOVJRy84M7zvkrCjMZ3JoNy
         MW0A==
X-Gm-Message-State: AOAM533rKQo+tBBS9zEaJLeI4O8oOduECSKGtnjDcyVSgN6uRXvqvcbe
        JJX1+/u1/yan9DmV7XuAemcpKoNjS974jO2n
X-Google-Smtp-Source: ABdhPJzgKBuVWVTv4mfOcCKb3Yl1B3RTQwY4AVLYEd4f0+goa7ayt9nWWwuz77E35DPrbBVPDb9LFw==
X-Received: by 2002:a37:c8c:: with SMTP id 134mr3397056qkm.53.1603822817972;
        Tue, 27 Oct 2020 11:20:17 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j25sm1233086qkk.124.2020.10.27.11.20.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 11:20:17 -0700 (PDT)
Subject: Re: [PATCH RFC 3/7] btrfs: add read_policy latency
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <cover.1603751876.git.anand.jain@oracle.com>
 <de0a28ed406c84c84d40d4bdad5f45250aabfdea.1603751876.git.anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e3a90960-8edd-6dfd-7b82-2c5c9a68874b@toxicpanda.com>
Date:   Tue, 27 Oct 2020 14:20:16 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <de0a28ed406c84c84d40d4bdad5f45250aabfdea.1603751876.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/26/20 7:55 PM, Anand Jain wrote:
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
>   fs/btrfs/sysfs.c   |  3 +-
>   fs/btrfs/volumes.c | 74 +++++++++++++++++++++++++++++++++++++++++++++-
>   fs/btrfs/volumes.h |  1 +
>   3 files changed, 76 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index d159f7c70bcd..6690abeeb889 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -874,7 +874,8 @@ static int btrfs_strmatch(const char *given, const char *golden)
>   	return -EINVAL;
>   }
>   
> -static const char * const btrfs_read_policy_name[] = { "pid" };
> +/* Must follow the order as in enum btrfs_read_policy */
> +static const char * const btrfs_read_policy_name[] = { "pid", "latency"};
>   
>   static ssize_t btrfs_read_policy_show(struct kobject *kobj,
>   				      struct kobj_attribute *a, char *buf)
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index da31b11ceb61..9bab6080cebf 100644
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
> @@ -5465,6 +5466,66 @@ int btrfs_is_parity_mirror(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
>   	return ret;
>   }
>   
> +static u64 btrfs_estimate_read(struct btrfs_device *device,
> +			       unsigned long *inflight)
> +{
> +	u64 read_wait;
> +	u64 avg_wait = 0;
> +	unsigned long read_ios;
> +	struct disk_stats stat;
> +
> +	/* Commands in flight on this partition/device */
> +	*inflight = part_stat_read_inflight(bdev_get_queue(device->bdev),
> +					    device->bdev->bd_part);
> +	part_stat_read_all(device->bdev->bd_part, &stat);
> +
> +	read_wait = stat.nsecs[STAT_READ];
> +	read_ios = stat.ios[STAT_READ];
> +
> +	if (read_wait && read_ios && read_wait >= read_ios)
> +		avg_wait = div_u64(read_wait, read_ios);
> +	else
> +		btrfs_info_rl(device->fs_devices->fs_info,
> +			"devid: %llu avg_wait ZERO read_wait %llu read_ios %lu",
> +			      device->devid, read_wait, read_ios);
> +
> +	return avg_wait;
> +}
> +
> +static int btrfs_find_best_stripe(struct btrfs_fs_info *fs_info,
> +				  struct map_lookup *map, int first,
> +				  int num_stripe)
> +{
> +	int index;
> +	int best_stripe = 0;
> +	int est_wait = -EINVAL;
> +	int last = first + num_stripe;
> +	unsigned long inflight;
> +
> +	for (index = first; index < last; index++) {
> +		struct btrfs_device *device = map->stripes[index].dev;
> +
> +		if (!blk_queue_io_stat(bdev_get_queue(device->bdev)))
> +			return -ENOENT;
> +	}
> +
> +	for (index = first; index < last; index++) {
> +		struct btrfs_device *device = map->stripes[index].dev;
> +		u64 avg_wait;
> +		u64 final_wait;
> +
> +		avg_wait = btrfs_estimate_read(device, &inflight);
> +		final_wait = avg_wait + (avg_wait * (inflight / 10));

Inflight is going to lag because it's only going to account for bio's that 
actually have been attached to requests here.  Since we're already on fuzzy 
ground, why not just skip the inflight and go with the average latencies.  If we 
heavily load one side it's latencies will creep up and then we'll favor the 
other side.  If we want to really aim for the lowest latency, we could add our 
own inflight counter to the stripe itself, and this would account for actual 
IO's that we have inflight currently, and would be much less fuzzy than relying 
on the block inflight counters.  Thanks,

Josef
