Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE3461E04D
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Nov 2022 06:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiKFFIg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Nov 2022 01:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiKFFIe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Nov 2022 01:08:34 -0400
Received: from out20-73.mail.aliyun.com (out20-73.mail.aliyun.com [115.124.20.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FE66308
        for <linux-btrfs@vger.kernel.org>; Sat,  5 Nov 2022 22:08:31 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04561902|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.390617-0.0082983-0.601085;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047203;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.Q0S23Fz_1667711308;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Q0S23Fz_1667711308)
          by smtp.aliyun-inc.com;
          Sun, 06 Nov 2022 13:08:29 +0800
Date:   Sun, 06 Nov 2022 13:08:29 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: auto enable discard=async when possible
In-Reply-To: <20220727150158.GT13489@suse.cz>
References: <20220727150158.GT13489@suse.cz>
Message-Id: <20221106130828.17B1.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> There's a request to automatically enable async discard for capable
> devices. We can do that, the async mode is designed to wait for larger
> freed extents and is not intrusive, with limits to iops, kbps or latency.
> 
> The status and tunables will be exported in /sys/fs/btrfs/FSID/discard .
> 
> The automatic selection is done if there's at least one discard capable
> device in the filesystem (not capable devices are skipped). Mounting
> with any other discard option will honor that option, notably mounting
> with nodiscard will keep it disabled.
> 
> Link: https://lore.kernel.org/linux-btrfs/CAEg-Je_b1YtdsCR0zS5XZ_SbvJgN70ezwvRwLiCZgDGLbeMB=w@mail.gmail.com/
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/ctree.h   |  1 +
>  fs/btrfs/disk-io.c | 14 ++++++++++++++
>  fs/btrfs/super.c   |  2 ++
>  fs/btrfs/volumes.c |  3 +++
>  fs/btrfs/volumes.h |  2 ++
>  5 files changed, 22 insertions(+)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 4db85b9dc7ed..0a338311f8e2 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1503,6 +1503,7 @@ enum {
>  	BTRFS_MOUNT_DISCARD_ASYNC		= (1UL << 28),
>  	BTRFS_MOUNT_IGNOREBADROOTS		= (1UL << 29),
>  	BTRFS_MOUNT_IGNOREDATACSUMS		= (1UL << 30),
> +	BTRFS_MOUNT_NODISCARD			= (1UL << 31),
>  };
>  
>  #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 3fac429cf8a4..8f8e33219d4d 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3767,6 +3767,20 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>  		btrfs_set_and_info(fs_info, SSD, "enabling ssd optimizations");
>  	}
>  
> +	/*
> +	 * For devices supporting discard turn on discard=async automatically,
> +	 * unless it's already set or disabled. This could be turned off by
> +	 * nodiscard for the same mount.
> +	 */
> +	if (!(btrfs_test_opt(fs_info, DISCARD_SYNC) ||
> +	      btrfs_test_opt(fs_info, DISCARD_ASYNC) ||
> +	      btrfs_test_opt(fs_info, NODISCARD)) &&
> +	    fs_info->fs_devices->discardable) {
> +		btrfs_set_and_info(fs_info, DISCARD_ASYNC,
> +				"auto enabling discard=async");
> +	      btrfs_clear_opt(fs_info->mount_opt, NODISCARD);

We do not need 'btrfs_clear_opt(fs_info->mount_opt, NODISCARD);' here?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/11/06

> +	}
> +
>  	/*
>  	 * Mount does not set all options immediately, we can do it now and do
>  	 * not have to wait for transaction commit
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 4c7089b1681b..1032aaa2c2f4 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -915,12 +915,14 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
>  				ret = -EINVAL;
>  				goto out;
>  			}
> +			btrfs_clear_opt(info->mount_opt, NODISCARD);
>  			break;
>  		case Opt_nodiscard:
>  			btrfs_clear_and_info(info, DISCARD_SYNC,
>  					     "turning off discard");
>  			btrfs_clear_and_info(info, DISCARD_ASYNC,
>  					     "turning off async discard");
> +			btrfs_set_opt(info->mount_opt, NODISCARD);
>  			break;
>  		case Opt_space_cache:
>  		case Opt_space_cache_version:
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 272901514b0c..22bfc7806ccb 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -639,6 +639,9 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>  	if (!bdev_nonrot(bdev))
>  		fs_devices->rotating = true;
>  
> +	if (bdev_max_discard_sectors(bdev))
> +		fs_devices->discardable = true;
> +
>  	device->bdev = bdev;
>  	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
>  	device->mode = flags;
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 5639961b3626..4c716603449d 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -329,6 +329,8 @@ struct btrfs_fs_devices {
>  	 * nonrot flag set
>  	 */
>  	bool rotating;
> +	/* Devices support TRIM/discard commands */
> +	bool discardable;
>  
>  	struct btrfs_fs_info *fs_info;
>  	/* sysfs kobjects */
> -- 
> 2.36.1


