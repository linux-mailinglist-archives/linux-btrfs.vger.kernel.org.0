Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A754D9D58
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 15:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237890AbiCOOWG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 10:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbiCOOWE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 10:22:04 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF80651313
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 07:20:52 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id n11so10270952qtk.4
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 07:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F/tm1aFE3M3/pAvKDtv2NwVHr+fl/awODhzOoJc2qRA=;
        b=b8aKR8TSyIq5CKT8HckV9ik7dcCzM0UrSb0wQ8kx5eR4sDSPAPdHu62cqZCIlQoJAt
         1dF06+BfwGBVJB/N+i5jyBamZC5V2UjjZ8D7vkLDu91Tv/zTQpVi26dd2jv0TOJSq4LL
         HbAcOSFKDzhppydQN1GLZdl0lGaRSTp+VAKePdHQzbEjDc+juPqOnMPTEPGjYWI8iFQG
         HAz+2X/EtD4T7dspChpbwYGx1Jr5IvxcpcKaDGmy0Xj3+E7/bxeotFVMJyz3pVAvYv3F
         i+2oZRldVUsiEGpwsya/Jt+1D7EKARnR1NnTkxPuKlBjOyeEr3uvFNjFlWfUCMlCTmly
         Daew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F/tm1aFE3M3/pAvKDtv2NwVHr+fl/awODhzOoJc2qRA=;
        b=Ic1QjVhePf+Apo0wPJw2hPNzyYyT4wGXYQn3I55c6xbYk1WmbRvK4QM2q8fe7umGV1
         iDOPB1ofLRG5bL3Z62mvLK64r6AOgiKHCBTdFGNOBjNNv+TvIx7bFIG9V2DWVuUYQTMT
         CwwXQI303ZyVDbAiwy6EFM90aJlZy3mwGzL8annCwqtJPnstJCBqxyvTySt+w3CkXUh1
         /6YtmiKUodNbxJt/qQcO3dVohDT8YVxO+HhtwDFfbBZ5FzJorbBlgaiYhzp+OqJ/AU42
         j62J5Pb1jmpWCthuarZLCTg7Gg91BSoJjdcGi7x1ib2YShY7Gwbox2/1S5D8fEz0Kigh
         qzfg==
X-Gm-Message-State: AOAM533aCqdtQc4JdCDvz/qrbD/dJvEpJPIiRL2kokAukErGpvTiiAA/
        3EJ8Oarpl/TI7szjzLThLuf31YtmvzeOsw==
X-Google-Smtp-Source: ABdhPJyulMi5ERcsJoNwM/r9IrCpBBIUQISUIXj718rKdNh3YvLAuMf+GB/oDnBlhJnxf2dXcIpcyw==
X-Received: by 2002:a05:622a:13c7:b0:2de:6f6e:2fe7 with SMTP id p7-20020a05622a13c700b002de6f6e2fe7mr22689290qtk.198.1647354051557;
        Tue, 15 Mar 2022 07:20:51 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e14-20020a05622a110e00b002d9d03dfe06sm13382126qty.2.2022.03.15.07.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 07:20:50 -0700 (PDT)
Date:   Tue, 15 Mar 2022 10:20:49 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3] btrfs: zoned: make auto-reclaim less aggressive
Message-ID: <YjCgwU3uyz4FA4qL@localhost.localdomain>
References: <74cbd8cdefe76136b3f9fb9b96bddfcbcd5b5861.1647342146.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74cbd8cdefe76136b3f9fb9b96bddfcbcd5b5861.1647342146.git.johannes.thumshirn@wdc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 15, 2022 at 04:02:57AM -0700, Johannes Thumshirn wrote:
> The current auto-reclaim algorithm starts reclaiming all block-group's
> with a zone_unusable value above a configured threshold. This is causing a
> lot of reclaim IO even if there would be enough free zones on the device.
> 
> Instead of only accounting a block-group's zone_unusable value, also take
> the number of empty zones into account.
> 
> Cc: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> ---
> Changes since v4:
> * Use div_u64()
> 
> Changes since RFC:
> * Fix logic error
> * Skip unavailable devices
> * Use different metric working for non-zoned devices as well
> ---
>  fs/btrfs/block-group.c |  3 +++
>  fs/btrfs/zoned.c       | 30 ++++++++++++++++++++++++++++++
>  fs/btrfs/zoned.h       |  6 ++++++
>  3 files changed, 39 insertions(+)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index c22d287e020b..2e77b38c538b 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1522,6 +1522,9 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
>  	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
>  		return;
>  
> +	if (!btrfs_zoned_should_reclaim(fs_info))
> +		return;
> +

Noooo I just purposefully turned it on for everybody.

>  	sb_start_write(fs_info->sb);
>  
>  	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE)) {
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 49446bb5a5d1..dc62a14594de 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -15,6 +15,7 @@
>  #include "transaction.h"
>  #include "dev-replace.h"
>  #include "space-info.h"
> +#include "misc.h"
>  
>  /* Maximum number of zones to report per blkdev_report_zones() call */
>  #define BTRFS_REPORT_NR_ZONES   4096
> @@ -2078,3 +2079,32 @@ void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info)
>  	}
>  	mutex_unlock(&fs_devices->device_list_mutex);
>  }
> +
> +bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info)
> +{
> +	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
> +	struct btrfs_device *device;
> +	u64 bytes_used = 0;
> +	u64 total_bytes = 0;
> +	u64 factor;
> +
> +	if (!btrfs_is_zoned(fs_info))
> +		return false;
> +
> +	if (!fs_info->bg_reclaim_threshold)
> +		return false;
> +
> +	mutex_lock(&fs_devices->device_list_mutex);
> +	list_for_each_entry(device, &fs_devices->devices, dev_list) {
> +		if (!device->bdev)
> +			continue;
> +
> +		total_bytes += device->disk_total_bytes;
> +		bytes_used += device->bytes_used;
> +
> +	}
> +	mutex_unlock(&fs_devices->device_list_mutex);

We can probably export calc_available_free_space() and use that here instead,
I'd rather not be grabbing the device_list_mutex here if we can avoid it.

> +
> +	factor = div_u64(bytes_used * 100, total_bytes);
> +	return factor >= fs_info->bg_reclaim_threshold;

My patches removed the fs_info->bg_reclaim_threshold btw.  Thanks,

Josef
