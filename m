Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967B2487A34
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jan 2022 17:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239937AbiAGQRL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jan 2022 11:17:11 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:36366 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239828AbiAGQRL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Jan 2022 11:17:11 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 150A3212BF;
        Fri,  7 Jan 2022 16:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641572230;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gE/QppKE8SB0vffZghA3dVxelhBu+Y3o7iup1F2RsfM=;
        b=Kwu63MwWgnhDY3II5OjdvJqOHxun/FbqfHQhACQmRPsJW5bHbu1/Vee+Wd+JD0NmXLw9sr
        qs8WYDOzdWOYmvWPfgvoSxAuTLgJX18Nzv/B2MiOOQ649vtrZ5KgCCucDq3zPRmJ/lLYK9
        8oxrIQpEb/gs5XP3nZ4zuQu1KbnFA70=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641572230;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gE/QppKE8SB0vffZghA3dVxelhBu+Y3o7iup1F2RsfM=;
        b=TEFysUj+W3yaPrGIqcG40+KfNSulHI8rC0Bsq7xnTwhfWL0TwwT/mAuGX/F32nfUDqOOkp
        PE6PRk0Ka+g9S3Cw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 6E62DA3B83;
        Fri,  7 Jan 2022 16:17:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 05ABDDA7A9; Fri,  7 Jan 2022 17:16:38 +0100 (CET)
Date:   Fri, 7 Jan 2022 17:16:38 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
        dsterba@suse.com, nborisov@suse.com, l@damenly.su
Subject: Re: [PATCH v3 2/4] btrfs: redeclare btrfs_stale_devices arg1 to dev_t
Message-ID: <20220107161638.GM14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, josef@toxicpanda.com, dsterba@suse.com,
        nborisov@suse.com, l@damenly.su
References: <cover.1641535030.git.anand.jain@oracle.com>
 <513f904de2c8c7a5268424cc6a525cfbeea0e39e.1641535030.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <513f904de2c8c7a5268424cc6a525cfbeea0e39e.1641535030.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 07, 2022 at 09:04:14PM +0800, Anand Jain wrote:
> After the commit cb57afa39796 ("btrfs: harden identification of the stale

Please drop the commit id when referencing patches that haven't been in
released branch, the subject should be sufficient.

> device"), we don't have to match the device path anymore. Instead, we
> match the dev_t. So pass in the dev_t instead of the device-path, in the call
> chain btrfs_forget_devices()->btrfs_free_stale_devices().
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v3: -
> 
>  fs/btrfs/super.c   |  8 +++++++-
>  fs/btrfs/volumes.c | 45 +++++++++++++++++++++++----------------------
>  fs/btrfs/volumes.h |  2 +-
>  3 files changed, 31 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 1ff03fb6c64a..bdf54b2673fe 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2386,6 +2386,7 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
>  {
>  	struct btrfs_ioctl_vol_args *vol;
>  	struct btrfs_device *device = NULL;
> +	dev_t devt = 0;
>  	int ret = -ENOTTY;
>  
>  	if (!capable(CAP_SYS_ADMIN))
> @@ -2405,7 +2406,12 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
>  		mutex_unlock(&uuid_mutex);
>  		break;
>  	case BTRFS_IOC_FORGET_DEV:
> -		ret = btrfs_forget_devices(vol->name);
> +		if (strlen(vol->name)) {

The full strlen() is not necessary, just check the first byte.

> +			ret = lookup_bdev(vol->name, &devt);
> +			if (ret)
> +				break;
> +		}
> +		ret = btrfs_forget_devices(devt);
>  		break;
>  	case BTRFS_IOC_DEVICES_READY:
>  		mutex_lock(&uuid_mutex);
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index ad9e08c3199c..cb43ee5925ad 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -543,11 +543,10 @@ btrfs_get_bdev_and_sb(const char *device_path, fmode_t flags, void *holder,
>   *	1	If it is not the same device.
>   *	-errno	For error.
>   */
> -static int device_matched(struct btrfs_device *device, const char *path)
> +static int device_matched(struct btrfs_device *device, dev_t dev_new)
>  {
>  	char *device_name;
>  	dev_t dev_old;
> -	dev_t dev_new;
>  	int ret;
>  
>  	device_name = kzalloc(BTRFS_PATH_NAME_MAX, GFP_KERNEL);
> @@ -567,10 +566,6 @@ static int device_matched(struct btrfs_device *device, const char *path)
>  	if (ret)
>  		return ret;
>  
> -	ret = lookup_bdev(path, &dev_new);
> -	if (ret)
> -		return ret;
> -
>  	if (dev_old == dev_new)
>  		return 0;
>  
> @@ -580,16 +575,16 @@ static int device_matched(struct btrfs_device *device, const char *path)
>  /*
>   *  Search and remove all stale (devices which are not mounted) devices.
>   *  When both inputs are NULL, it will search and release all stale devices.
> - *  path:	Optional. When provided will it release all unmounted devices
> - *		matching this path only.
> + *  devt:	Optional. When provided will it release all unmounted devices
> + *		matching this devt only.
>   *  skip_dev:	Optional. Will skip this device when searching for the stale
>   *		devices.
> - *  Return:	0 for success or if @path is NULL.
> - * 		-EBUSY if @path is a mounted device.
> - * 		-ENOENT if @path does not match any device in the list.
> + *  Return:	0 for success or if @devt is 0.
> + *		-EBUSY if @devt is a mounted device.
> + *		-ENOENT if @devt does not match any device in the list.
>   */
> -static int btrfs_free_stale_devices(const char *path,
> -				     struct btrfs_device *skip_device)
> +static int btrfs_free_stale_devices(dev_t devt,
> +				    struct btrfs_device *skip_device)
>  {
>  	struct btrfs_fs_devices *fs_devices, *tmp_fs_devices;
>  	struct btrfs_device *device, *tmp_device;
> @@ -597,7 +592,7 @@ static int btrfs_free_stale_devices(const char *path,
>  
>  	lockdep_assert_held(&uuid_mutex);
>  
> -	if (path)
> +	if (devt)
>  		ret = -ENOENT;
>  
>  	list_for_each_entry_safe(fs_devices, tmp_fs_devices, &fs_uuids, fs_list) {
> @@ -607,13 +602,13 @@ static int btrfs_free_stale_devices(const char *path,
>  					 &fs_devices->devices, dev_list) {
>  			if (skip_device && skip_device == device)
>  				continue;
> -			if (path && !device->name)
> +			if (devt && !device->name)
>  				continue;
> -			if (path && device_matched(device, path) != 0)
> +			if (devt && device_matched(device, devt) != 0)
>  				continue;
>  			if (fs_devices->opened) {
>  				/* for an already deleted device return 0 */
> -				if (path && ret != 0)
> +				if (devt && ret != 0)
>  					ret = -EBUSY;
>  				break;
>  			}
> @@ -1372,12 +1367,12 @@ static struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev
>  	return disk_super;
>  }
> -int btrfs_forget_devices(const char *path)
> +int btrfs_forget_devices(dev_t devt)
>  {
>  	int ret;
>  
>  	mutex_lock(&uuid_mutex);
> -	ret = btrfs_free_stale_devices(strlen(path) ? path : NULL, NULL);
> +	ret = btrfs_free_stale_devices(devt, NULL);
>  	mutex_unlock(&uuid_mutex);
>  
>  	return ret;
> @@ -1427,8 +1422,12 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
>  
>  	device = device_list_add(path, disk_super, &new_device_added);
>  	if (!IS_ERR(device)) {
> -		if (new_device_added)
> -			btrfs_free_stale_devices(path, device);
> +		if (new_device_added) {
> +			dev_t devt;
> +
> +			if (!lookup_bdev(path, &devt))

This reads like some negative condition, while what we expect is "if the
device exists and can be looked up" and not "if we can't look up the
device". Please write it like (lookup_bdev(...) == 0), and maybe add a
comment why we can ignore errors.

> +				btrfs_free_stale_devices(devt, device);
> +		}
>  	}
>  
>  	btrfs_release_disk_super(disk_super);
> @@ -2659,6 +2658,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>  	int ret = 0;
>  	bool seeding_dev = false;
>  	bool locked = false;
> +	dev_t devt;
>  
>  	if (sb_rdonly(sb) && !fs_devices->seeding)
>  		return -EROFS;
> @@ -2853,7 +2853,8 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>  	 * We can ignore the return value as it typically returns -EINVAL and
>  	 * only succeeds if the device was an alien.
>  	 */
> -	btrfs_forget_devices(device_path);
> +	if (!lookup_bdev(device_path, &devt))

Same here.

> +		btrfs_forget_devices(devt);
>  
>  	/* Update ctime/mtime for blkid or udev */
>  	update_dev_time(device_path);
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 98bbb293a3f9..76215de8ce34 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -529,7 +529,7 @@ int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
>  		       fmode_t flags, void *holder);
>  struct btrfs_device *btrfs_scan_one_device(const char *path,
>  					   fmode_t flags, void *holder);
> -int btrfs_forget_devices(const char *path);
> +int btrfs_forget_devices(dev_t devt);
>  void btrfs_close_devices(struct btrfs_fs_devices *fs_devices);
>  void btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices);
>  void btrfs_assign_next_active_device(struct btrfs_device *device,
> -- 
> 2.33.1
