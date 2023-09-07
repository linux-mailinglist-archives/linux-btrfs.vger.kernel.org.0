Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F70797662
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Sep 2023 18:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbjIGQIk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 12:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238407AbjIGQHv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 12:07:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF1230E5
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 09:00:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3960D1F8AE;
        Thu,  7 Sep 2023 14:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694097811;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=alY2gmxa1BhT3V1dMJNaXoi//BPyI2ysm0J8kiIEpE0=;
        b=dTHlN32xB4r5d7a3icP3Dgz95MxJXykVTWy4iqO91uPYRUtN4yslkCi0iP/i7pK00rLpv5
        vvjL5q4jhwrffVxv0QPNZSUwdaWrhSRGroJKDC250JaIZqnBC9ijyq8qCmLi6IOHBfjFat
        ZeXNbsOhv1F+msglcZSbRaIwCjHu3rg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694097811;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=alY2gmxa1BhT3V1dMJNaXoi//BPyI2ysm0J8kiIEpE0=;
        b=i0hWm1n4JzDzfTYYWPDeC+a9g/KKsjT8yoLGCAXBjM9Hv21VOt38YSp9jrRcNCdw25yAgr
        tQJKOTTxtYGzojAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EEE94138F9;
        Thu,  7 Sep 2023 14:43:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Dy/eOJLh+WQBZQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 07 Sep 2023 14:43:30 +0000
Date:   Thu, 7 Sep 2023 16:36:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: pseudo device-scan for single-device filesystems
Message-ID: <20230907143658.GQ3159@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <b0e0240254557461c137cd9b943f00b0d5048083.1693959204.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0e0240254557461c137cd9b943f00b0d5048083.1693959204.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 07, 2023 at 12:27:41AM +0800, Anand Jain wrote:
> After the commit [1], we unregister the device from the kernel memory upon
> unmounting for a single device.
> 
>   [1] 5f58d783fd78 ("btrfs: free device in btrfs_close_devices for a single device filesystem")

You can write patch references into the text, the [1] references are
more suitable for links.

> So, device registration that was performed before mounting if any is no
> longer in the kernel memory.
> 
> However, in fact, note that device registration is unnecessary for a
> single-device Btrfs filesystem unless it's a seed device.
> 
> So for commands like 'btrfs device scan' or 'btrfs device ready' with a
> non-seed single-device Btrfs filesystem, they can return success without
> the actual device scan.

Just to clarify, the device will be scanned as read by kernel, signature
verified but not added to the fs_devices lists, right?

> The seed device must remain in the kernel memory to allow the sprout
> device to mount without the need to specify the seed device explicitly.

And in case the seeding status of the already scanned and registered
device is changed another scan will happen by udev due to openning for
write. So I guess it's safe.

> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> 
> Passes fstests with a fstests fix as below.
> 
>   [PATCH] fstests: btrfs/185 update for single device pseudo device-scan
> 
> Testing as a boot device is going on.
> 
>  fs/btrfs/super.c   | 21 +++++++++++++++------
>  fs/btrfs/volumes.c | 12 +++++++++++-
>  fs/btrfs/volumes.h |  3 ++-
>  3 files changed, 28 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 32ff441d2c13..22910e0d39a2 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -891,7 +891,7 @@ static int btrfs_parse_device_options(const char *options, blk_mode_t flags)
>  				error = -ENOMEM;
>  				goto out;
>  			}
> -			device = btrfs_scan_one_device(device_name, flags);
> +			device = btrfs_scan_one_device(device_name, flags, false);
>  			kfree(device_name);
>  			if (IS_ERR(device)) {
>  				error = PTR_ERR(device);
> @@ -1486,10 +1486,17 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
>  		goto error_fs_info;
>  	}
>  
> -	device = btrfs_scan_one_device(device_name, mode);
> -	if (IS_ERR(device)) {
> +	device = btrfs_scan_one_device(device_name, mode, true);
> +	if (IS_ERR_OR_NULL(device)) {
>  		mutex_unlock(&uuid_mutex);
>  		error = PTR_ERR(device);
> +		/*
> +		 * As 3rd argument in the funtion
> +		 * btrfs_scan_one_device( , ,mount_arg_dev) above is true, the
> +		 * 'device' or the 'error' won't be NULL or 0 respectively
> +		 * unless for a bug.
> +		 */
> +		ASSERT(error);

Could the case when device is NULL be handled separately? That way it's
not so obvious that we expect an error and also a NULL pointer.

>  		goto error_fs_info;
>  	}
>  
> @@ -2199,7 +2206,8 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
>  	switch (cmd) {
>  	case BTRFS_IOC_SCAN_DEV:
>  		mutex_lock(&uuid_mutex);
> -		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ);
> +		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ, false);
> +		/* Return success i.e. 0 for device == NULL */
>  		ret = PTR_ERR_OR_ZERO(device);
>  		mutex_unlock(&uuid_mutex);
>  		break;
> @@ -2213,9 +2221,10 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
>  		break;
>  	case BTRFS_IOC_DEVICES_READY:
>  		mutex_lock(&uuid_mutex);
> -		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ);
> -		if (IS_ERR(device)) {
> +		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ, false);
> +		if (IS_ERR_OR_NULL(device)) {
>  			mutex_unlock(&uuid_mutex);
> +			/* Return success i.e. 0 for device == NULL */
>  			ret = PTR_ERR(device);
>  			break;
>  		}
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index fa18ea7ef8e3..38e714661286 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1218,7 +1218,8 @@ int btrfs_forget_devices(dev_t devt)
>   * and we are not allowed to call set_blocksize during the scan. The superblock
>   * is read via pagecache
>   */
> -struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags)
> +struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
> +					   bool mount_arg_dev)
>  {
>  	struct btrfs_super_block *disk_super;
>  	bool new_device_added = false;
> @@ -1263,10 +1264,19 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags)
>  		goto error_bdev_put;
>  	}
>  
> +	if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 1 &&
> +	    !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING)) {
> +		pr_info("skip registering single non seed device path %s\n",
> +			path);

Wouldn't this be too noisy in the logs? With the scanning and
registration repeated scans of a device there will be only the first
message, but on a system with potentially many single-dev devices each
time udev would want to scan it and it'd get logged.

> +		device = NULL;
> +		goto free_disk_super;
> +	}
> +
>  	device = device_list_add(path, disk_super, &new_device_added);
>  	if (!IS_ERR(device) && new_device_added)
>  		btrfs_free_stale_devices(device->devt, device);
>  
> +free_disk_super:
>  	btrfs_release_disk_super(disk_super);
>  
>  error_bdev_put:
