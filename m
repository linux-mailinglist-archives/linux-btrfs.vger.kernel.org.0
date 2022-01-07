Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCCE487A39
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jan 2022 17:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348203AbiAGQUf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jan 2022 11:20:35 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:36516 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348184AbiAGQUe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Jan 2022 11:20:34 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 93863212C4;
        Fri,  7 Jan 2022 16:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641572433;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZirEkx+CY74rBVj7rsgv4GtInse27EelonIgzoSit3s=;
        b=nHBBXsqsgulEWid2fPNRVA6QvMS/95Axo9HEyZyLnKuEqGIrLaCErqktu+/UwWAmbni1bf
        V0D/FLJIhMA4jQxCwaHZxTFu4QVlkFl1UOeBAmqBTMgQhfcDip27Zy0MgH8dElJFV4e3tk
        Y9lh/93qgkcJHenYisxV1auzyy59ncQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641572433;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZirEkx+CY74rBVj7rsgv4GtInse27EelonIgzoSit3s=;
        b=fnR0+kVFRncA8kB+di6zrD3RV0ZMhEEAWel8uThl8KWgXeBniDQBS1O0Xt4qexs0z/sY+m
        WbdQWCP9vFsq98Cg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id EC662A3B84;
        Fri,  7 Jan 2022 16:20:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6FC65DA7A9; Fri,  7 Jan 2022 17:20:01 +0100 (CET)
Date:   Fri, 7 Jan 2022 17:20:01 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
        dsterba@suse.com, nborisov@suse.com, l@damenly.su
Subject: Re: [PATCH v3 3/4] btrfs: add device major-minor info in the struct
 btrfs_device
Message-ID: <20220107162001.GN14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, josef@toxicpanda.com, dsterba@suse.com,
        nborisov@suse.com, l@damenly.su
References: <cover.1641535030.git.anand.jain@oracle.com>
 <6531891b2bcb2d68baf4e0cfbc37e6d9d614cbef.1641535030.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6531891b2bcb2d68baf4e0cfbc37e6d9d614cbef.1641535030.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 07, 2022 at 09:04:15PM +0800, Anand Jain wrote:
> Internally it is common to use the major-minor number to identify a device
> and, at a few locations in btrfs, we use the major-minor number to match
> the device.
> 
> So when we identify a new btrfs device through device add or device
> replace or device-scan/ready save the device's major-minor (dev_t) in the
> struct btrfs_device so that we don't have to call lookup_bdev() again.

Sounds good.

> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v3: -
> 
>  fs/btrfs/dev-replace.c |  3 +++
>  fs/btrfs/volumes.c     | 36 +++++++++++++++---------------------
>  fs/btrfs/volumes.h     |  1 +
>  3 files changed, 19 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> index 62b9651ea662..289d6cc1f5db 100644
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -302,6 +302,9 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
>  		goto error;
>  	}
>  	rcu_assign_pointer(device->name, name);
> +	ret = lookup_bdev(device_path, &device->devt);
> +	if (ret)
> +		goto error;
>  
>  	set_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
>  	device->generation = 0;
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index cb43ee5925ad..33b5f40d030a 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -817,11 +817,17 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>  	struct rcu_string *name;
>  	u64 found_transid = btrfs_super_generation(disk_super);
>  	u64 devid = btrfs_stack_device_id(&disk_super->dev_item);
> +	dev_t path_devt;
> +	int error;
>  	bool has_metadata_uuid = (btrfs_super_incompat_flags(disk_super) &
>  		BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
>  	bool fsid_change_in_progress = (btrfs_super_flags(disk_super) &
>  					BTRFS_SUPER_FLAG_CHANGING_FSID_V2);
>  
> +	error = lookup_bdev(path, &path_devt);
> +	if (error)
> +		return ERR_PTR(error);
> +
>  	if (fsid_change_in_progress) {
>  		if (!has_metadata_uuid)
>  			fs_devices = find_fsid_inprogress(disk_super);
> @@ -904,6 +910,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>  			return ERR_PTR(-ENOMEM);
>  		}
>  		rcu_assign_pointer(device->name, name);
> +		device->devt = path_devt;
>  
>  		list_add_rcu(&device->dev_list, &fs_devices->devices);
>  		fs_devices->num_devices++;
> @@ -966,16 +973,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>  		 * make sure it's the same device if the device is mounted
>  		 */
>  		if (device->bdev) {
> -			int error;
> -			dev_t path_dev;
> -
> -			error = lookup_bdev(path, &path_dev);
> -			if (error) {
> -				mutex_unlock(&fs_devices->device_list_mutex);
> -				return ERR_PTR(error);
> -			}
> -
> -			if (device->bdev->bd_dev != path_dev) {
> +			if (device->devt != path_devt) {
>  				mutex_unlock(&fs_devices->device_list_mutex);
>  				/*
>  				 * device->fs_info may not be reliable here, so
> @@ -1008,6 +1006,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>  			fs_devices->missing_devices--;
>  			clear_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state);
>  		}
> +		device->devt = path_devt;
>  	}
>  
>  	/*
> @@ -1421,14 +1420,8 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
>  	}
>  
>  	device = device_list_add(path, disk_super, &new_device_added);
> -	if (!IS_ERR(device)) {
> -		if (new_device_added) {
> -			dev_t devt;
> -
> -			if (!lookup_bdev(path, &devt))
> -				btrfs_free_stale_devices(devt, device);
> -		}
> -	}
> +	if (!IS_ERR(device) && new_device_added)
> +		btrfs_free_stale_devices(device->devt, device);
>  
>  	btrfs_release_disk_super(disk_super);
>  
> @@ -2658,7 +2651,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>  	int ret = 0;
>  	bool seeding_dev = false;
>  	bool locked = false;
> -	dev_t devt;
>  
>  	if (sb_rdonly(sb) && !fs_devices->seeding)
>  		return -EROFS;
> @@ -2708,6 +2700,9 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>  
>  	device->fs_info = fs_info;
>  	device->bdev = bdev;
> +	ret = lookup_bdev(device_path, &device->devt);
> +	if (ret)
> +		goto error_free_device;
>  
>  	ret = btrfs_get_dev_zone_info(device, false);
>  	if (ret)
> @@ -2853,8 +2848,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>  	 * We can ignore the return value as it typically returns -EINVAL and
>  	 * only succeeds if the device was an alien.
>  	 */
> -	if (!lookup_bdev(device_path, &devt))
> -		btrfs_forget_devices(devt);
> +	btrfs_forget_devices(device->devt);
>  
>  	/* Update ctime/mtime for blkid or udev */
>  	update_dev_time(device_path);
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 76215de8ce34..d75450a11713 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -73,6 +73,7 @@ struct btrfs_device {
>  	/* the mode sent to blkdev_get */
>  	fmode_t mode;
>  
> +	dev_t devt;

Please add a comment.

>  	unsigned long dev_state;
>  	blk_status_t last_flush_error;
>  
> -- 
> 2.33.1
