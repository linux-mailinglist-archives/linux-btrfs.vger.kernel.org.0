Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC823A1CAF
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jun 2021 20:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbhFIS0T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Jun 2021 14:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhFIS0S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Jun 2021 14:26:18 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF12C061574
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Jun 2021 11:24:24 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id y12so8421335pgk.6
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Jun 2021 11:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Lq1QI/JdiW0FtykJqMBo5IboZTXncD9r64lIXT0SSEo=;
        b=R3QxG3849JnCrUHqHs53zN/GEGeZ4NI0Skd8Ugu9z+7HGwZFzgRhZK+PF9sE82xQKA
         rj/HCIQcLYQMHGDNuXs/Y1Q6yCXcfGbuCewj2/yX4CzZTQuStGI/Fvs0BrbCBAOlE5B2
         eRc0VF5fesudBlx8PwlHRXT5axPgin9/dt/qJru407y3NTekVLjwMxRK1EhWqq8lVGZj
         pd/JVLAY/X1wLmpTG4c4l8/kXdkPGqRXcVJSWb2llMwAH/C6N3YD0l4KvKFWGqgI1pnK
         3+fXXsgJ2gprZfuvcJzrPQZDgEF/BsGjeCk44nMLt0ou/v89XlbwSgcLgqpi62DTwsuN
         9xlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lq1QI/JdiW0FtykJqMBo5IboZTXncD9r64lIXT0SSEo=;
        b=fw3SS0P6N3sqvTYETdSx6SR0xKBsdwx4HfCnGCvrVezlMp6zB9vRLMTYJVgYQmge7V
         EpVAlrpgKPXj4IzKmSm97U4jj7y3By5dfKNcq5e2trK2umsuN2iIOkMClDd/ib5zBFfx
         pkyr+YrXrpXqD7FEeyOqSSBokMEF29Nx1uKmuBRrlkV+k+kh3QiAVbih5LZxJL3hN+3r
         +w49DXlZZAfxBM1MAUt/yj0yC6iiNqexb1fREnk8PR1Lac/qZ5cuk/OwKiiISG2xV3vK
         TgXA8KkdgF2c6PYFAQ6TMiG8Ndj5+sI6N60Qbchx+zAuZepqSJxS0rx5NANFRrgfyhSk
         49vw==
X-Gm-Message-State: AOAM531XvzkLT38Fsg/l17kWxJfjGeDCri9edOD4sl8DY/JkfnrishLp
        RvTgjrDUeKiYATCuhAMK1QuceMjskrCSYw==
X-Google-Smtp-Source: ABdhPJw1ELRSYSSmQZTI50ITRfTW/BNmV9Ba7SZ8szHlA4T7RFd01+sgUgSbgV+l8Aq+dm8/P+vUzg==
X-Received: by 2002:a63:6e87:: with SMTP id j129mr985068pgc.45.1623263063536;
        Wed, 09 Jun 2021 11:24:23 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:a169])
        by smtp.gmail.com with ESMTPSA id o5sm447026pgn.44.2021.06.09.11.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 11:24:23 -0700 (PDT)
Date:   Wed, 9 Jun 2021 11:24:21 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: sysfs: export dev stats in devinfo directory
Message-ID: <YMEHVWTrcJ6ol5bH@relinquished.localdomain>
References: <20210604132058.11334-1-dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604132058.11334-1-dsterba@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 04, 2021 at 03:20:58PM +0200, David Sterba wrote:
> The device stats can be read by ioctl, wrapped by command 'btrfs device
> stats'. Provide another source where to read the information in
> /sys/fs/btrfs/FSID/devinfo/DEVID/stats . The format is a list of
> 'key value' pairs one per line, which is common in other stat files.
> The names are the same as used in other device stat outputs.
> 
> The stats are all in one file as it's the snapshot of all available
> stats. The 'one value per file' is not very suitable here. The stats
> should be valid right after the stats item is read from disk, shortly
> after initializing the device, but in any case also print the validity
> status.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/sysfs.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 4b508938e728..3d4c806c4f73 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -1495,11 +1495,39 @@ static ssize_t btrfs_devinfo_writeable_show(struct kobject *kobj,
>  }
>  BTRFS_ATTR(devid, writeable, btrfs_devinfo_writeable_show);
>  
> +static ssize_t btrfs_devinfo_stats_show(struct kobject *kobj,
> +		struct kobj_attribute *a, char *buf)
> +{
> +	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
> +						   devid_kobj);
> +
> +	/*
> +	 * Print all at once so we get a snapshot of all values from the same
> +	 * time. Keep them in sync and in order of definition of
> +	 * btrfs_dev_stat_values.
> +	 */
> +	return scnprintf(buf, PAGE_SIZE,
> +		"stats_valid %d\n",
> +		"write_errs %d\n"
> +		"read_errs %d\n"
> +		"flush_errs %d\n"
> +		"corruption_errs %d\n"
> +		"generation_errs %d\n",
> +		!!(device->dev_stats_valid),

The ioctl returns ENODEV is !dev_stats_valid, maybe this file should do
the same? It seems a little awkward to have a flag that means that the
rest of the file is meaningless.

> +		btrfs_dev_stat_read(device, BTRFS_DEV_STAT_WRITE_ERRS),
> +		btrfs_dev_stat_read(device, BTRFS_DEV_STAT_READ_ERRS),
> +		btrfs_dev_stat_read(device, BTRFS_DEV_STAT_FLUSH_ERRS),
> +		btrfs_dev_stat_read(device, BTRFS_DEV_STAT_CORRUPTION_ERRS),
> +		btrfs_dev_stat_read(device, BTRFS_DEV_STAT_GENERATION_ERRS));
> +}
> +BTRFS_ATTR(devid, stats, btrfs_devinfo_stats_show);
> +
>  static struct attribute *devid_attrs[] = {
>  	BTRFS_ATTR_PTR(devid, in_fs_metadata),
>  	BTRFS_ATTR_PTR(devid, missing),
>  	BTRFS_ATTR_PTR(devid, replace_target),
>  	BTRFS_ATTR_PTR(devid, scrub_speed_max),
> +	BTRFS_ATTR_PTR(devid, stats),
>  	BTRFS_ATTR_PTR(devid, writeable),
>  	NULL
>  };
> -- 
> 2.31.1
> 
