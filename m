Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD124D9A98
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 12:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242461AbiCOLsJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 07:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343754AbiCOLsI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 07:48:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053DB5005A
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 04:46:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3F36614C6
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 11:46:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9AEDC340E8;
        Tue, 15 Mar 2022 11:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647344808;
        bh=/cPGSXo6SCLZCEsU+UTNLu0PeAz0rnaMFL2HPm/XxUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cYb2iWpBjNyMkdPYsQtM/Gcu1vRZS7LLdeHMpCc5CKcpPjLFVS1D33OH8jdQpRi5X
         9nNvjoD8Ax54wF+YPv0JGQielFRzFw9YtduXsftJRxSAzJFDAdHYfwAmX6suLXR7iF
         F80V8eLIY7+De3ISoHw29C3gWF6JpqBPJ409/gMd+Hzz4LrPUwEnK9bpOUmQJ7J6x0
         EfL0eQZa55fcdyTcptGaRxwZKdaTaRcBNvhy8SV4/LJAedeMy5joUBYQWvSJj6FYZ3
         SVo+UzanfLzomzf4niVBYbOt7tSp315z3o/2+cd76eTf02r1ex2Xs1sYjuwpuorHCv
         a/7YdCTfY+qSA==
Date:   Tue, 15 Mar 2022 11:46:45 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3] btrfs: zoned: make auto-reclaim less aggressive
Message-ID: <YjB8perl04WEeTnE@debian9.Home>
References: <74cbd8cdefe76136b3f9fb9b96bddfcbcd5b5861.1647342146.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74cbd8cdefe76136b3f9fb9b96bddfcbcd5b5861.1647342146.git.johannes.thumshirn@wdc.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Why is this included added?
Did you intended to use div_factor()?

Thanks.

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
> +
> +	factor = div_u64(bytes_used * 100, total_bytes);
> +	return factor >= fs_info->bg_reclaim_threshold;
> +}
> diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
> index cbf016a7bb5d..d0d0e5c02606 100644
> --- a/fs/btrfs/zoned.h
> +++ b/fs/btrfs/zoned.h
> @@ -78,6 +78,7 @@ void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical,
>  			     u64 length);
>  void btrfs_clear_data_reloc_bg(struct btrfs_block_group *bg);
>  void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info);
> +bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info);
>  #else /* CONFIG_BLK_DEV_ZONED */
>  static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
>  				     struct blk_zone *zone)
> @@ -236,6 +237,11 @@ static inline void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info,
>  static inline void btrfs_clear_data_reloc_bg(struct btrfs_block_group *bg) { }
>  
>  static inline void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info) { }
> +
> +static inline bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info)
> +{
> +	return false;
> +}
>  #endif
>  
>  static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
> -- 
> 2.35.1
> 
