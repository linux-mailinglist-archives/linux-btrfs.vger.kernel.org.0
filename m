Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B8A484825
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jan 2022 19:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236413AbiADS4m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Jan 2022 13:56:42 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:58962 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbiADS4l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Jan 2022 13:56:41 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9BD4621117;
        Tue,  4 Jan 2022 18:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641322600;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yisbuH+a3tA6YgqUsrwz4SnBD63raXymeb0w9CA8FT4=;
        b=ovoqzlrwKYx0OhtOUtml6ba0LY6h4CByB8Vui0yLMfh3yef5fB1IdS0+YvTy7vEsLi/iBm
        M+MvvqFh8ftucnPToGhZlmUPqooRgWcEhkhigu1pOXttW6YFyxoys0wrFYsfnVb1+QUI46
        w7Gy6QBbSuLruNE0wMdGbaBWZcEgfSg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641322600;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yisbuH+a3tA6YgqUsrwz4SnBD63raXymeb0w9CA8FT4=;
        b=yR/O5otuSHWfv4OA5NAR1zbauL0I4BG1usr3hRqNSHsu/8ySSV111o7CF6Dixrl4bLgxVC
        YHDgLTc4KJOcF0Cg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 93E6DA3B84;
        Tue,  4 Jan 2022 18:56:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 42721DA729; Tue,  4 Jan 2022 19:56:11 +0100 (CET)
Date:   Tue, 4 Jan 2022 19:56:11 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com
Subject: Re: [PATCH v2 1/2] btrfs: harden identification of the stale device
Message-ID: <20220104185611.GX28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, josef@toxicpanda.com
References: <cover.1639155519.git.anand.jain@oracle.com>
 <612eac6f9309cbee107afbbd4817c0a628207438.1639155519.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <612eac6f9309cbee107afbbd4817c0a628207438.1639155519.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Dec 11, 2021 at 02:15:29AM +0800, Anand Jain wrote:
> Identifying and removing the stale device from the fs_uuids list is done
> by the function btrfs_free_stale_devices().
> btrfs_free_stale_devices() in turn depends on the function
> device_path_matched() to check if the device repeats in more than one
> btrfs_device structure.
> 
> The matching of the device happens by its path, the device path. However,
> when dm mapper is in use, the dm device paths are nothing but a link to
> the actual block device, which leads to the device_path_matched() failing
> to match.
> 
> Fix this by matching the dev_t as provided by lookup_bdev() instead of
> plain strcmp() the device paths.
> 
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> 
> v2: Fix 
>      sparse: warning: incorrect type in argument 1 (different address spaces)
>      For using device->name->str
> 
>     Fix Josef suggestion to pass dev_t instead of device-path in the
>      patch 2/2.
> 
>  fs/btrfs/volumes.c | 41 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 36 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 1b02c03a882c..559fdb0c4a0e 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -534,15 +534,46 @@ btrfs_get_bdev_and_sb(const char *device_path, fmode_t flags, void *holder,
>  	return ret;
>  }
>  
> -static bool device_path_matched(const char *path, struct btrfs_device *device)
> +/*
> + * Check if the device in the 'path' matches with the device in the given
> + * struct btrfs_device '*device'.
> + * Returns:
> + *	0	If it is the same device.
> + *	1	If it is not the same device.
> + *	-errno	For error.
> + */
> +static int device_matched(struct btrfs_device *device, const char *path)
>  {
> -	int found;
> +	char *device_name;
> +	dev_t dev_old;
> +	dev_t dev_new;
> +	int ret;
> +
> +	device_name = kzalloc(BTRFS_PATH_NAME_MAX, GFP_KERNEL);
> +	if (!device_name)
> +		return -ENOMEM;
>  
>  	rcu_read_lock();
> -	found = strcmp(rcu_str_deref(device->name), path);
> +	ret = sprintf(device_name, "%s", rcu_str_deref(device->name));

I wonder if the temporary allocation could be avoided, as it's the
exactly same path of the device, so it could be passed to lookup_bdev.

>  	rcu_read_unlock();
> +	if (!ret) {
> +		kfree(device_name);
> +		return -EINVAL;
> +	}
>  
> -	return found == 0;
> +	ret = lookup_bdev(device_name, &dev_old);
> +	kfree(device_name);
> +	if (ret)
> +		return ret;
> +
> +	ret = lookup_bdev(path, &dev_new);
> +	if (ret)
> +		return ret;
> +
> +	if (dev_old == dev_new)
> +		return 0;
> +
> +	return 1;
>  }
>  
>  /*
> @@ -577,7 +608,7 @@ static int btrfs_free_stale_devices(const char *path,
>  				continue;
>  			if (path && !device->name)
>  				continue;
> -			if (path && !device_path_matched(path, device))
> +			if (path && device_matched(device, path) != 0)

You've changed the fuction to return errors but it's not checked,
besides the memory allocation failure, the lookup functions could fail
for various reasons so I don't think it's safe to ignore the errors.

>  				continue;
>  			if (fs_devices->opened) {
>  				/* for an already deleted device return 0 */
> -- 
> 2.33.1
