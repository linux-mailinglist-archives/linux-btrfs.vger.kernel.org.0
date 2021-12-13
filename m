Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA01247300C
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Dec 2021 16:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239933AbhLMPEP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Dec 2021 10:04:15 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:50236 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239929AbhLMPEN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Dec 2021 10:04:13 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 59CBB212B9;
        Mon, 13 Dec 2021 15:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639407852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F8kNhlZii6E0JumHwOXbG7yN8BQLp+ypZpXi4YkGEXI=;
        b=s0XAGQT0wY7b6/n3+CW8vpPyl4r+s5iBHigVMG8RxzUhoH7VBIH7nelUXJoNwvptSDokP7
        i9PH7hxtZwFKek0CLm8CeTQVMk6SKYZyug7gNVdAIsnXFl+VHJGqxeL2y506jWVASrFM2J
        gA4X4jYJ971ugqJjPGvqNmL9tnbI+0U=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 16B2013DE2;
        Mon, 13 Dec 2021 15:04:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id juWuAuxgt2HAOgAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 13 Dec 2021 15:04:12 +0000
Subject: Re: [PATCH v2 1/2] btrfs: harden identification of the stale device
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com
References: <cover.1639155519.git.anand.jain@oracle.com>
 <612eac6f9309cbee107afbbd4817c0a628207438.1639155519.git.anand.jain@oracle.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <12c701b1-d8c8-e645-201f-ac5a411ab03f@suse.com>
Date:   Mon, 13 Dec 2021 17:04:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <612eac6f9309cbee107afbbd4817c0a628207438.1639155519.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10.12.21 г. 20:15, Anand Jain wrote:
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

This convention is somewhat confusing. This function returns a boolean
meaniing if a device matched or not, yet the retval follows strcmp
convention of return values. That is make 1 mean "device matched" and
"0" mean device not matched. Because ultimately that's what we care for.

Furthermore you give it the ability to return an error which not
consumed at all. Simply make the function boolean and return false if an
error is encountered by some of the internal calls.

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
>  	rcu_read_unlock();
> +	if (!ret) {
> +		kfree(device_name);
> +		return -EINVAL;
> +	}
>  
> -	return found == 0;
> +	ret = lookup_bdev(device_name, &dev_old);

Instead of allocating memory for storing device->name and freeing it,
AFAICS lookup_bdev can be called under rcu read section so you can
simply call lookup_bdev under rcu_read_lock which simplifies memory
management.


In the end this function really boils down to making 2 calls to
lookup_bdev and comparing their values for equality, no need for
anything more fancy than that.


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

What's more lookinng at the body of free_stale_device I find the name of
the function somewhat confusing. What it does is really delete all
devices from all fs_devices which match a particular criterion for a
device path i.e the function's body doesn't deal with the concept of
"stale" at all. As such I think it should be renamed and given a more
generic name like btrfs_free_specific_device or something along those
lines.

>  				continue;
>  			if (path && !device->name)
>  				continue;
> -			if (path && !device_path_matched(path, device))
> +			if (path && device_matched(device, path) != 0)
>  				continue;
>  			if (fs_devices->opened) {
>  				/* for an already deleted device return 0 */
> 
