Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA8E32FC028
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jan 2021 20:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389648AbhASTiD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jan 2021 14:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728519AbhASThk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jan 2021 14:37:40 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB44C061575
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jan 2021 11:37:00 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id d14so23014947qkc.13
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jan 2021 11:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4i9/719iQQaNu8YSl4cp7bsXNT7tfcuj1/K16rtMNeY=;
        b=nbpLZmv2zfzDctQzy7Ngc5VncgPdMC4ZvCRgCfQ4rZAuTOH0ki0Nuz6a2jA/2fm/FK
         B2ZedITVePCtuKEKPnw1aEgam4dg3HQ1tyoNuZPUYMm8MZTsJlHFhKqJHP7TrV5vrMiY
         GycB2YXpnJMymo2gMVWDttMDdRzqkrVS8Jaaki6F1liNoprs7OnLnhc6a3Azwr0257er
         y68EPIIvmZaGu5FnlSxbqG2cACcd05WhohzFax+YxX4xZQ9zT1wGG3Dir6IUlvL6zFjP
         eyHIoLRm2QitggIZGSmUH3FIeiTb4c0KuLS/T+EMYtPVhVHJG2ETRiBaYN30qzrNPdPy
         twIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4i9/719iQQaNu8YSl4cp7bsXNT7tfcuj1/K16rtMNeY=;
        b=ARdZThhMwqM34Q6uZTSwPnERwANBM78W37OUXS3/a6bmtZVL5h9t5j1rv3042bia2E
         ka3+AYallskXNAhJjf0b2k5SVBsQzFNvPR0O3836lRqtCTEkP5X+qKIfwUN1DaVoOICH
         19FzaoY36Z6a8c/Xv0tzUs2rD27KpvN0lGdmaQz+QFHhPx7ka50EMzty2t/+1VQ3mwwF
         8Gq8sgdlcWpi2U7Wm9ENJXCyQ1uLGlC6Cq/lw1z3jGQZUS60dSRH4cqQkau6z3/c7ras
         BR0cpKZmMAWKixtvJPGgdhetvX2YiRSq4DhCE/LpDbuwrIgUfFzJut2/jrWqWkj64+f1
         oXOA==
X-Gm-Message-State: AOAM533kWC4lSRFxYEdUxjeg+NVh85P7yjrrO3UMNQFqlPVD1Rw5OMGe
        VjMVemiCpirLOhfnLG0DjBeZvA==
X-Google-Smtp-Source: ABdhPJzDPKBoLyCz1HOQrw1CESUKJiKA04HbDQjx5GP8+8XGyhv9M/vKqf611DMK25wccdJ6O1K/eQ==
X-Received: by 2002:a05:620a:24a:: with SMTP id q10mr5973495qkn.388.1611085019353;
        Tue, 19 Jan 2021 11:36:59 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:11d1::1325? ([2620:10d:c091:480::1:a066])
        by smtp.gmail.com with ESMTPSA id 184sm13672930qkg.92.2021.01.19.11.36.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 11:36:58 -0800 (PST)
Subject: Re: [PATCH v3 1/4] btrfs: add read_policy latency
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <cover.1610324448.git.anand.jain@oracle.com>
 <64bb4905dc4b77e9fa22d8ba2635a36d15a33469.1610324448.git.anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <bf3eed32-6653-4151-85b6-1f249e601cf0@toxicpanda.com>
Date:   Tue, 19 Jan 2021 14:36:57 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <64bb4905dc4b77e9fa22d8ba2635a36d15a33469.1610324448.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/11/21 4:41 AM, Anand Jain wrote:
> The read policy type latency routes the read IO based on the historical
> average wait-time experienced by the read IOs through the individual
> device. This patch obtains the historical read IO stats from the kernel
> block layer and calculates its average.
> 
> Example usage:
>   echo "latency" > /sys/fs/btrfs/$uuid/read_policy
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v3: The block layer commit 0d02129e76ed (block: merge struct block_device and
>      struct hd_struct) has changed the first argument in the function
>      part_stat_read_all() in 5.11-rc1. So the compilation will fail. This patch
>      fixes it.
>      Commit log updated.
> 
> v2: Use btrfs_debug_rl() instead of btrfs_info_rl()
>      It is better we have this debug until we test this on at least few
>      hardwares.
>      Drop the unrelated changes.
>      Update change log.
> 
> v1: Drop part_stat_read_all instead use part_stat_read
>      Drop inflight
> 
> 
>   fs/btrfs/sysfs.c   |  3 ++-
>   fs/btrfs/volumes.c | 38 ++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/volumes.h |  2 ++
>   3 files changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 19b9fffa2c9c..96ca7bef6357 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -915,7 +915,8 @@ static bool strmatch(const char *buffer, const char *string)
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
> index f4037a6bd926..f7a0a83d2cd4 100644
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
> @@ -5490,6 +5491,39 @@ int btrfs_is_parity_mirror(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
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
> +		read_wait = part_stat_read(device->bdev, nsecs[READ]);
> +		read_ios = part_stat_read(device->bdev, ios[READ]);
> +
> +		if (read_wait && read_ios && read_wait >= read_ios)
> +			avg_wait = div_u64(read_wait, read_ios);
> +		else
> +			btrfs_debug_rl(device->fs_devices->fs_info,

You can just use fs_info here, you already have it.  I'm not in love with doing 
this check every time, I'd rather cache the results somewhere.  However if we're 
read-only I can't think of a mechanism we could piggy back on, RW we could just 
do it every transaction commit.  Fix the fs_info thing and you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
