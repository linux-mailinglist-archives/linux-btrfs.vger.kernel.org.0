Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D377122BF78
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jul 2020 09:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgGXHhB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jul 2020 03:37:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:44572 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbgGXHhA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jul 2020 03:37:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 68885ABD2
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jul 2020 07:37:07 +0000 (UTC)
Subject: Re: [PATCH 5/5] btrfs: Switch seed device to list api
To:     linux-btrfs@vger.kernel.org
References: <20200715104850.19071-1-nborisov@suse.com>
 <20200715104850.19071-6-nborisov@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <4d9c5a7c-05c0-67d3-49a9-a19a6f34b56e@suse.com>
Date:   Fri, 24 Jul 2020 10:36:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200715104850.19071-6-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 15.07.20 г. 13:48 ч., Nikolay Borisov wrote:
> While this patch touches a bunch of files the conversion is
> straighforward. Instead of using the implicit linked list anchored at
> btrfs_fs_devices::seed the code is switched to using
> list_for_each_entry. Previous patches in the series already factored out
> code that processed both main and seed devices so in those cases
> the factored out functions are called on the main fs_devices and then
> on every seed dev inside list_for_each_entry.
> 
> Using list api also allows to simplify deletion from the seed dev list
> performed in btrfs_rm_device and btrfs_rm_dev_replace_free_srcdev by
> substituting a while() loop with a simple list_del_init.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

<snip>

> @@ -6728,8 +6718,8 @@ static struct btrfs_fs_devices *open_seed_devices(struct btrfs_fs_info *fs_info,
>  		goto out;
>  	}
>  
> -	fs_devices->seed = fs_info->fs_devices->seed;
> -	fs_info->fs_devices->seed = fs_devices;
> +	ASSERT(list_empty(&fs_devices->seed_list));

That assert is useless, since fs_devices at this point are a clone from
clone_fs_devices hence its seed_list cannot be non-empty. Consider this
when removing merging it.

> +	list_add_tail(&fs_devices->seed_list, &fs_info->fs_devices->seed_list);
>  out:
>  	return fs_devices;
>  }
> @@ -7141,17 +7131,23 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
>  
>  void btrfs_init_devices_late(struct btrfs_fs_info *fs_info)
>  {
> -	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
> +	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices, *seed_devs;
>  	struct btrfs_device *device;
>  
> -	while (fs_devices) {
> -		mutex_lock(&fs_devices->device_list_mutex);
> -		list_for_each_entry(device, &fs_devices->devices, dev_list)
> +	fs_devices->fs_info = fs_info;
> +
> +	mutex_lock(&fs_devices->device_list_mutex);
> +	list_for_each_entry(device, &fs_devices->devices, dev_list)
> +		device->fs_info = fs_info;
> +	mutex_unlock(&fs_devices->device_list_mutex);
> +
> +	list_for_each_entry(seed_devs, &fs_devices->seed_list, seed_list) {
> +		mutex_lock(&seed_devs->device_list_mutex);
> +		list_for_each_entry(device, &seed_devs->devices, dev_list)
>  			device->fs_info = fs_info;
> -		mutex_unlock(&fs_devices->device_list_mutex);
> +		mutex_unlock(&seed_devs->device_list_mutex);
>  
> -		fs_devices->fs_info = fs_info;
> -		fs_devices = fs_devices->seed;
> +		seed_devs->fs_info = fs_info;
>  	}
>  }
>  
> @@ -7527,8 +7523,10 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
>  
>  	/* It's possible this device is a dummy for seed device */
>  	if (dev->disk_total_bytes == 0) {
> -		dev = btrfs_find_device(fs_info->fs_devices->seed, devid, NULL,
> -					NULL, false);
> +		struct btrfs_fs_devices *devs;
> +		devs = list_first_entry(&fs_info->fs_devices->seed_list,
> +					struct btrfs_fs_devices, seed_list);
> +		dev = btrfs_find_device(devs, devid, NULL, NULL, false);
>  		if (!dev) {
>  			btrfs_err(fs_info, "failed to find seed devid %llu",
>  				  devid);
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index fc283fdbcece..709f4aacbd3f 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -246,7 +246,7 @@ struct btrfs_fs_devices {
>  	 */
>  	struct list_head alloc_list;
>  
> -	struct btrfs_fs_devices *seed;
> +	struct list_head seed_list;
>  	bool seeding;
>  
>  	int opened;
> 
