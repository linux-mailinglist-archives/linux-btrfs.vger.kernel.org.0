Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1A32FD0DA
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jan 2021 14:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbhATM5e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jan 2021 07:57:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:48524 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730313AbhATMQy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jan 2021 07:16:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BB9A2AB7F;
        Wed, 20 Jan 2021 12:16:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B0C54DA6E3; Wed, 20 Jan 2021 13:14:16 +0100 (CET)
Date:   Wed, 20 Jan 2021 13:14:16 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, josef@toxicpanda.com
Subject: Re: [PATCH v4 1/3] btrfs: add read_policy latency
Message-ID: <20210120121416.GX6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, josef@toxicpanda.com
References: <cover.1611114341.git.anand.jain@oracle.com>
 <63f6f00e2ecc741efd2200c3c87b5db52c6be2fd.1611114341.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63f6f00e2ecc741efd2200c3c87b5db52c6be2fd.1611114341.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 19, 2021 at 11:52:05PM -0800, Anand Jain wrote:
> The read policy type latency routes the read IO based on the historical
> average wait-time experienced by the read IOs through the individual
> device. This patch obtains the historical read IO stats from the kernel
> block layer and calculates its average.

This does not say how the stripe is selected using the gathered numbers.
Ie. what is the criteria like minimum average time, "based on" is too
vague.

> Example usage:
>  echo "latency" > /sys/fs/btrfs/$uuid/read_policy

Do you have some sample results? I remember you posted something but it
would be good to have that in the changelog too.

> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> ---
> v4: For btrfs_debug_rl() use fs_info instead of
>     device->fs_devices->fs_info.
> 
> v3: The block layer commit 0d02129e76ed (block: merge struct block_device and
>     struct hd_struct) has changed the first argument in the function
>     part_stat_read_all() in 5.11-rc1. So the compilation will fail. This patch
>     fixes it.
>     Commit log updated.
> 
> v2: Use btrfs_debug_rl() instead of btrfs_info_rl()
>     It is better we have this debug until we test this on at least few
>     hardwares.
>     Drop the unrelated changes.
>     Update change log.
> 
> rfc->v1: Drop part_stat_read_all instead use part_stat_read
>     Drop inflight
> 
>  fs/btrfs/sysfs.c   |  3 ++-
>  fs/btrfs/volumes.c | 38 ++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/volumes.h |  2 ++
>  3 files changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 4522a1c4cd08..7c0324fe97b2 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -915,7 +915,8 @@ static bool strmatch(const char *buffer, const char *string)
>  	return false;
>  }
>  
> -static const char * const btrfs_read_policy_name[] = { "pid" };
> +/* Must follow the order as in enum btrfs_read_policy */
> +static const char * const btrfs_read_policy_name[] = { "pid", "latency" };
>  
>  static ssize_t btrfs_read_policy_show(struct kobject *kobj,
>  				      struct kobj_attribute *a, char *buf)
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 62d6a890fc50..f361f1c87eb6 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -14,6 +14,7 @@
>  #include <linux/semaphore.h>
>  #include <linux/uuid.h>
>  #include <linux/list_sort.h>
> +#include <linux/part_stat.h>
>  #include "misc.h"
>  #include "ctree.h"
>  #include "extent_map.h"
> @@ -5490,6 +5491,39 @@ int btrfs_is_parity_mirror(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
>  	return ret;
>  }
>  
> +static int btrfs_find_best_stripe(struct btrfs_fs_info *fs_info,

The name btrfs_find_best_stripe should be more descriptive about the
selection criteria.

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
> +		read_wait = part_stat_read(device->bdev, nsecs[READ]);

This should use STAT_READ as this is supposed to be indexing the stats
members. READ is some generic constant with the same value.

> +		read_ios = part_stat_read(device->bdev, ios[READ]);
> +
> +		if (read_wait && read_ios && read_wait >= read_ios)
> +			avg_wait = div_u64(read_wait, read_ios);
> +		else
> +			btrfs_debug_rl(fs_info,
> +			"devid: %llu avg_wait ZERO read_wait %llu read_ios %lu",
> +				       device->devid, read_wait, read_ios);
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
>  static int find_live_mirror(struct btrfs_fs_info *fs_info,
>  			    struct map_lookup *map, int first,
>  			    int dev_replace_is_ongoing)
> @@ -5519,6 +5553,10 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
>  	case BTRFS_READ_POLICY_PID:
>  		preferred_mirror = first + (current->pid % num_stripes);
>  		break;
> +	case BTRFS_READ_POLICY_LATENCY:
> +		preferred_mirror = btrfs_find_best_stripe(fs_info, map, first,
> +							  num_stripes);
> +		break;
>  	}
>  
>  	if (dev_replace_is_ongoing &&
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 1997a4649a66..71ba1f0e93f4 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -222,6 +222,8 @@ enum btrfs_chunk_allocation_policy {
>  enum btrfs_read_policy {
>  	/* Use process PID to choose the stripe */
>  	BTRFS_READ_POLICY_PID,
> +	/* Find and use device with the lowest latency */
> +	BTRFS_READ_POLICY_LATENCY,
>  	BTRFS_NR_READ_POLICY,
>  };
>  
> -- 
> 2.28.0
