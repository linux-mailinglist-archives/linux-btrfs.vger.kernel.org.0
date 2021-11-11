Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F83144D6E5
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Nov 2021 13:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbhKKM6G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Nov 2021 07:58:06 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:60262 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbhKKM6F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Nov 2021 07:58:05 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A68E121B3F;
        Thu, 11 Nov 2021 12:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636635315;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bQLovv2iIo9SZn4oxXUNgV4sdpVmp8FifOifz02lc8Q=;
        b=RbpiIxRKRYfiw4ovW2NnZj8K7dMA+qXDfKfWAaypnnIUoghYn58SJ1CPhVDj+b7EHMvVwc
        fWks1XewKAbT0NMf2vBIx7pjaiazBD0ZzlYqQjCk6B4rVgdeq/MCvNw+FkwWzz1Nl+sxwD
        1zXMnMkumFQETR8BJKL72baz4UKrBis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636635315;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bQLovv2iIo9SZn4oxXUNgV4sdpVmp8FifOifz02lc8Q=;
        b=3dS63ImRnAcwm2Zvs5PjviPjZTW1bMV+D4p+4Q2h+4uoZLfo5WHI/nLMH1hHqPPeZ0tGW4
        HNlvvvVS7C2ihrCw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 9F1F4A3CA8;
        Thu, 11 Nov 2021 12:55:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0D95DDA799; Thu, 11 Nov 2021 13:55:14 +0100 (CET)
Date:   Thu, 11 Nov 2021 13:55:14 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH] btrfs: cache reported zone during mount
Message-ID: <20211111125514.GC28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <20211111051438.4081012-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111051438.4081012-1-naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 11, 2021 at 02:14:38PM +0900, Naohiro Aota wrote:
> When mounting a device, we are reporting the zones twice: once for
> checking the zone attributes in btrfs_get_dev_zone_info and once for
> loading block groups' zone info in
> btrfs_load_block_group_zone_info(). With a lot of block groups, that
> leads to a lot of REPORT ZONE commands and slows down the mount
> process.
> 
> This patch introduces a zone info cache in struct
> btrfs_zoned_device_info. The cache is populated while in
> btrfs_get_dev_zone_info() and used for
> btrfs_load_block_group_zone_info() to reduce the number of REPORT ZONE
> commands. The zone cache is then released after loading the block
> groups, as it will not be much effective during the run time.
> 
> Benchmark: Mount an HDD with 57,007 block groups
> Before patch: 171.368 seconds
> After patch: 64.064 seconds
> 
> While it still takes a minute due to the slowness of loading all the
> block groups, the patch reduces the mount time by 1/3.
> 
> Link: https://lore.kernel.org/linux-btrfs/CAHQ7scUiLtcTqZOMMY5kbWUBOhGRwKo6J6wYPT5WY+C=cD49nQ@mail.gmail.com/
> Fixes: 5b316468983d ("btrfs: get zone information of zoned block devices")
> CC: stable@vger.kernel.org
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/dev-replace.c |  2 +-
>  fs/btrfs/disk-io.c     |  2 ++
>  fs/btrfs/volumes.c     |  2 +-
>  fs/btrfs/zoned.c       | 78 +++++++++++++++++++++++++++++++++++++++---
>  fs/btrfs/zoned.h       |  8 +++--
>  5 files changed, 84 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> index a39987e020e3..1c91f2203da4 100644
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -323,7 +323,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
>  	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
>  	device->fs_devices = fs_info->fs_devices;
>  
> -	ret = btrfs_get_dev_zone_info(device);
> +	ret = btrfs_get_dev_zone_info(device, false);
>  	if (ret)
>  		goto error;
>  
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 847aabb30676..369f84ff6bd3 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3563,6 +3563,8 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>  		goto fail_sysfs;
>  	}
>  
> +	btrfs_free_zone_cache(fs_info);
> +
>  	if (!sb_rdonly(sb) && fs_info->fs_devices->missing_devices &&
>  	    !btrfs_check_rw_degradable(fs_info, NULL)) {
>  		btrfs_warn(fs_info,
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 45c91a2f172c..dd1cbbb73ef0 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2667,7 +2667,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>  	device->fs_info = fs_info;
>  	device->bdev = bdev;
>  
> -	ret = btrfs_get_dev_zone_info(device);
> +	ret = btrfs_get_dev_zone_info(device, false);
>  	if (ret)
>  		goto error_free_device;
>  
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 67d932d70798..2300d9eff69a 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -213,6 +213,9 @@ static int emulate_report_zones(struct btrfs_device *device, u64 pos,
>  static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
>  			       struct blk_zone *zones, unsigned int *nr_zones)
>  {
> +	struct btrfs_zoned_device_info *zinfo = device->zone_info;
> +	struct blk_zone *zone_info;

Variables should be declared in the inner-most scope they're used, so
zone_info is in the for loop

> +	u32 zno;
>  	int ret;
>  
>  	if (!*nr_zones)
> @@ -224,6 +227,32 @@ static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
>  		return 0;
>  	}
>  
> +	if (zinfo->zone_cache) {
> +		/* Check cache */
> +		unsigned int i;

and u32 zno should be there.

> +
> +		ASSERT(IS_ALIGNED(pos, zinfo->zone_size));
> +		zno = pos >> zinfo->zone_size_shift;
> +		/*
> +		 * We cannot report zones beyond the zone end. So, it
> +		 * is OK to cap *nr_zones to at the end.
> +		 */
> +		*nr_zones = min_t(u32, *nr_zones, zinfo->nr_zones - zno);
> +
> +		for (i = 0; i < *nr_zones; i++) {
> +			zone_info = &zinfo->zone_cache[zno + i];

Creating a temporary variable to capture some weird array expresion is
fine and preferred. When the variable is not declared here it looks like
it could be needed elsewehre so it may take some scrolling around to
make sure it's not so.

Both fixed in the committed version.

> +			if (!zone_info->len)
> +				break;
> +		}
> +
> +		if (i == *nr_zones) {
> +			/* Cache hit on all the zones */
> +			memcpy(zones, zinfo->zone_cache + zno,
> +			       sizeof(*zinfo->zone_cache) * *nr_zones);
> +			return 0;
> +		}
> +	}
> +
>  	ret = blkdev_report_zones(device->bdev, pos >> SECTOR_SHIFT, *nr_zones,
>  				  copy_zone_info_cb, zones);
>  	if (ret < 0) {
> +}
