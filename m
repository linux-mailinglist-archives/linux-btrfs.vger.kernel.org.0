Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265F32575FD
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 11:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgHaJIB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 05:08:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:36274 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727918AbgHaJH7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 05:07:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 49320B62F;
        Mon, 31 Aug 2020 09:08:31 +0000 (UTC)
Subject: Re: [PATCH 01/11] btrfs: initialize sysfs devid and device link for
 seed device
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com
References: <cover.1598792561.git.anand.jain@oracle.com>
 <2db650ec206db1cb3e68590951b59e222fb10116.1598792561.git.anand.jain@oracle.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e6175fbf-3439-f290-d3d6-7fb1320f91e6@suse.com>
Date:   Mon, 31 Aug 2020 12:07:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2db650ec206db1cb3e68590951b59e222fb10116.1598792561.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 30.08.20 г. 17:40 ч., Anand Jain wrote:
> The following test case leads to null kobject-being-freed error.
> 
>  mount seed /mnt
>  add sprout to /mnt
>  umount /mnt
>  mount sprout to /mnt
>  delete seed
> 
>  kobject: '(null)' (00000000dd2b87e4): is not initialized, yet kobject_put() is being called.
>  WARNING: CPU: 1 PID: 15784 at lib/kobject.c:736 kobject_put+0x80/0x350
>  RIP: 0010:kobject_put+0x80/0x350
>  ::
>  Call Trace:
>  btrfs_sysfs_remove_devices_dir+0x6e/0x160 [btrfs]
>  btrfs_rm_device.cold+0xa8/0x298 [btrfs]
>  btrfs_ioctl+0x206c/0x22a0 [btrfs]
>  ksys_ioctl+0xe2/0x140
>  __x64_sys_ioctl+0x1e/0x29
>  do_syscall_64+0x96/0x150
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>  RIP: 0033:0x7f4047c6288b
>  ::
> 
> This is because, at the end of the seed device-delete, we try to remove
> the seed's devid sysfs entry. But for the seed devices under the sprout
> fs, we don't initialize the devid kobject yet. So this patch initializes
> the seed device devid kobject and the device link in the sysfs. This takes
> care of the Warning.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>


This patch is doing too many things at once. Split it so that:
1. You first add the new functions add_device/remove_device in 2
separate patches.
2. Switch btrfs_sysfs_add_devices_dir/btrfs_sysfs_remove_devices_dir to
ousing the newly added helpers, again in 2 separate patches

> ---
>  fs/btrfs/sysfs.c | 146 ++++++++++++++++++++++++++++++-----------------
>  1 file changed, 93 insertions(+), 53 deletions(-)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 190e59152be5..9b5e58091fae 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -1149,45 +1149,48 @@ int btrfs_sysfs_add_space_info_type(struct btrfs_fs_info *fs_info,
>  	return 0;
>  }
>  
> -/* when one_device is NULL, it removes all device links */
> -
> -int btrfs_sysfs_remove_devices_dir(struct btrfs_fs_devices *fs_devices,
> -		struct btrfs_device *one_device)
> +static void btrfs_sysfs_remove_device(struct btrfs_device *device)
>  {
>  	struct hd_struct *disk;
>  	struct kobject *disk_kobj;
> +	struct kobject *devices_kobj;
>  
> -	if (!fs_devices->devices_kobj)
> -		return -EINVAL;
> +	/*
> +	 * Seed fs_devices devices_kobj aren't used, fetch kobject from the
> +	 * fs_info::fs_devices.
> +	 */
> +	devices_kobj = device->fs_info->fs_devices->devices_kobj;
> +	ASSERT(devices_kobj);
>  
> -	if (one_device) {
> -		if (one_device->bdev) {
> -			disk = one_device->bdev->bd_part;
> -			disk_kobj = &part_to_dev(disk)->kobj;
> -			sysfs_remove_link(fs_devices->devices_kobj,
> -					  disk_kobj->name);
> -		}
> +	if (device->bdev) {
> +		disk = device->bdev->bd_part;
> +		disk_kobj = &part_to_dev(disk)->kobj;
> +		sysfs_remove_link(devices_kobj, disk_kobj->name);
> +	}
>  
> -		kobject_del(&one_device->devid_kobj);
> -		kobject_put(&one_device->devid_kobj);
> +	kobject_del(&device->devid_kobj);
> +	kobject_put(&device->devid_kobj);
>  
> -		wait_for_completion(&one_device->kobj_unregister);
> +	wait_for_completion(&device->kobj_unregister);
> +}
>  
> +/* when 2nd argument device is NULL, it removes all devices link */
> +int btrfs_sysfs_remove_devices_dir(struct btrfs_fs_devices *fs_devices,
> +				   struct btrfs_device *device)
> +{
> +	struct btrfs_fs_devices *seed_fs_devices;
> +
> +	if (device) {
> +		btrfs_sysfs_remove_device(device);
>  		return 0;
>  	}
>  
> -	list_for_each_entry(one_device, &fs_devices->devices, dev_list) {
> -
> -		if (one_device->bdev) {
> -			disk = one_device->bdev->bd_part;
> -			disk_kobj = &part_to_dev(disk)->kobj;
> -			sysfs_remove_link(fs_devices->devices_kobj,
> -					  disk_kobj->name);
> -		}
> -		kobject_del(&one_device->devid_kobj);
> -		kobject_put(&one_device->devid_kobj);
> +	list_for_each_entry(device, &fs_devices->devices, dev_list)
> +		btrfs_sysfs_remove_device(device);
>  
> -		wait_for_completion(&one_device->kobj_unregister);
> +	list_for_each_entry(seed_fs_devices, &fs_devices->seed_list, seed_list) {
> +		list_for_each_entry(device, &seed_fs_devices->devices, dev_list)
> +			btrfs_sysfs_remove_device(device);
>  	}
>  
>  	return 0;
> @@ -1271,44 +1274,81 @@ static struct kobj_type devid_ktype = {
>  	.release	= btrfs_release_devid_kobj,
>  };
>  
> +static int btrfs_sysfs_add_device(struct btrfs_device *device)
> +{
> +	int ret;
> +	struct kobject *devices_kobj;
> +        struct kobject *devinfo_kobj;
> +
> +	/*
> +	 * make sure we use the fs_info::fs_devices to fetch the kobjects
> +	 * even for the seed fs_devices
> +	 */
> +	devices_kobj = device->fs_devices->fs_info->fs_devices->devices_kobj;
> +	devinfo_kobj = device->fs_devices->fs_info->fs_devices->devinfo_kobj;
> +	ASSERT(devices_kobj);
> +	ASSERT(devinfo_kobj);
> +
> +	if (device->bdev) {
> +		struct hd_struct *disk;
> +		struct kobject *disk_kobj;
> +
> +		disk = device->bdev->bd_part;
> +		disk_kobj = &part_to_dev(disk)->kobj;
> +
> +		ret = sysfs_create_link(devices_kobj, disk_kobj,
> +					disk_kobj->name);
> +		if (ret) {
> +			btrfs_warn(device->fs_info,
> +			   "sysfs create device link failed %d devid %llu",
> +				   ret, device->devid);
> +			return ret;
> +		}
> +	}
> +
> +	init_completion(&device->kobj_unregister);
> +	ret = kobject_init_and_add(&device->devid_kobj, &devid_ktype,
> +				   devinfo_kobj, "%llu", device->devid);
> +	if (ret) {
> +		kobject_put(&device->devid_kobj);
> +		btrfs_warn(device->fs_info,
> +			   "sysfs devinfo init failed %d devid %llu",
> +			   ret, device->devid);
> +	}
> +
> +	return ret;
> +}
> +
>  int btrfs_sysfs_add_devices_dir(struct btrfs_fs_devices *fs_devices,
> -				struct btrfs_device *one_device)
> +				struct btrfs_device *device)
>  {
> -	int error = 0;
> -	struct btrfs_device *dev;
> +	int ret = 0;
>  	unsigned int nofs_flag;
> +	struct btrfs_fs_devices *seed_fs_devices;
>  
>  	nofs_flag = memalloc_nofs_save();
> -	list_for_each_entry(dev, &fs_devices->devices, dev_list) {
>  
> -		if (one_device && one_device != dev)
> -			continue;
> +	if (device)
> +		return btrfs_sysfs_add_device(device);
>  
> -		if (dev->bdev) {
> -			struct hd_struct *disk;
> -			struct kobject *disk_kobj;
> -
> -			disk = dev->bdev->bd_part;
> -			disk_kobj = &part_to_dev(disk)->kobj;
> -
> -			error = sysfs_create_link(fs_devices->devices_kobj,
> -						  disk_kobj, disk_kobj->name);
> -			if (error)
> -				break;
> -		}
> +	list_for_each_entry(device, &fs_devices->devices, dev_list) {
> +		ret = btrfs_sysfs_add_device(device);
> +		if (ret)
> +			goto out;
> +	}
>  
> -		init_completion(&dev->kobj_unregister);
> -		error = kobject_init_and_add(&dev->devid_kobj, &devid_ktype,
> -					     fs_devices->devinfo_kobj, "%llu",
> -					     dev->devid);
> -		if (error) {
> -			kobject_put(&dev->devid_kobj);
> -			break;
> +	list_for_each_entry(seed_fs_devices, &fs_devices->seed_list, seed_list) {
> +		list_for_each_entry(device, &seed_fs_devices->devices, dev_list) {
> +			ret = btrfs_sysfs_add_device(device);
> +			if (ret)
> +				goto out;
>  		}
>  	}
> +
> +out:
>  	memalloc_nofs_restore(nofs_flag);
>  
> -	return error;
> +	return ret;
>  }
>  
>  void btrfs_kobject_uevent(struct block_device *bdev, enum kobject_action action)
> 
