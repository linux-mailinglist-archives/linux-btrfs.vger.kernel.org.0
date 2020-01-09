Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C298C135C87
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2020 16:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbgAIPUy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jan 2020 10:20:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:33850 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727945AbgAIPUx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Jan 2020 10:20:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 85CB0AB9D;
        Thu,  9 Jan 2020 15:20:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D1C34DA7FF; Thu,  9 Jan 2020 16:20:40 +0100 (CET)
Date:   Thu, 9 Jan 2020 16:20:40 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 4/4] btrfs: sysfs, add devid/dev_state kobject and
 attribute
Message-ID: <20200109152040.GP3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <20191205112706.8125-5-anand.jain@oracle.com>
 <1578310711-20887-1-git-send-email-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578310711-20887-1-git-send-email-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 06, 2020 at 07:38:31PM +0800, Anand Jain wrote:
> New sysfs attributes
>   in_fs_metadata  missing  replace_target  writeable
> are added under a new kobject
>   UUID/devinfo/<devid>
> 
> These attributes reflects the state of the device from the kernel
> fed by %btrfs_device::dev_state.
> These attributes are born during mount and goes along with the dynamic
> nature of the device add and delete, otherwise these attribute and kobject
> gets deleted at unmount.
> 
> Sample output:
> pwd
>  /sys/fs/btrfs/6e1961f1-5918-4ecc-a22f-948897b409f7/devinfo/1/
> ls
>   in_fs_metadata  missing  replace_target  writeable
> cat missing
>   0
> 
> The output from these attributes are 0 or 1. 0 indicates unset and 1
> indicates set.
> 
> As of now these attributes are readonly.
> 
> It is observed that the device delete thread and sysfs read thread will
> not race because the delete thread calls sysfs kobject_put() which in turn
> waits for existing sysfs read to complete.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v4:
>    after patch
>    [PATCH v5 2/2] btrfs: reset device back to allocation state when removing
>    in misc-next, the device::devid_kobj remains stale, fix it by using
>    release.
> 
> v3:
>   Use optional groupid devid in BTRFS_ATTR(), it was blank in v2.
> 
> V2:
>   Make the devinfo attribute to carry one parameter, so now
>   instead of dev_state attribute, we create in_fs_metadata,
>   writeable, missing and replace_target attributes.
> 
>  fs/btrfs/sysfs.c   | 142 ++++++++++++++++++++++++++++++++++++++++++++---------
>  fs/btrfs/volumes.h |   3 ++
>  2 files changed, 122 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 834f712ed60c..18dac99188ce 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -978,29 +978,116 @@ int btrfs_sysfs_remove_devices_attr(struct btrfs_fs_devices *fs_devices,
>  	if (!fs_devices->devices_kobj)
>  		return -EINVAL;
>  
> -	if (one_device && one_device->bdev) {
> -		disk = one_device->bdev->bd_part;
> -		disk_kobj = &part_to_dev(disk)->kobj;
> +	if (one_device) {
> +		if (one_device->bdev) {
> +			disk = one_device->bdev->bd_part;
> +			disk_kobj = &part_to_dev(disk)->kobj;
> +			sysfs_remove_link(fs_devices->devices_kobj, disk_kobj->name);
> +		}
>  
> -		sysfs_remove_link(fs_devices->devices_kobj, disk_kobj->name);
> -	}
> +		kobject_del(&one_device->devid_kobj);
> +		kobject_put(&one_device->devid_kobj);
> +
> +		wait_for_completion(&one_device->kobj_unregister);
>  
> -	if (one_device)
>  		return 0;
> +	}
>  
> -	list_for_each_entry(one_device,
> -			&fs_devices->devices, dev_list) {
> -		if (!one_device->bdev)
> -			continue;
> -		disk = one_device->bdev->bd_part;
> -		disk_kobj = &part_to_dev(disk)->kobj;
> +	list_for_each_entry(one_device, &fs_devices->devices, dev_list) {
> +
> +		if (one_device->bdev) {
> +			disk = one_device->bdev->bd_part;
> +			disk_kobj = &part_to_dev(disk)->kobj;
> +			sysfs_remove_link(fs_devices->devices_kobj, disk_kobj->name);
> +		}
> +		kobject_del(&one_device->devid_kobj);
> +		kobject_put(&one_device->devid_kobj);
>  
> -		sysfs_remove_link(fs_devices->devices_kobj, disk_kobj->name);
> +		wait_for_completion(&one_device->kobj_unregister);
>  	}
>  
>  	return 0;
>  }
>  
> +static ssize_t btrfs_sysfs_writeable_show(struct kobject *kobj,

This could be btrfs_devinfo_writeable_show as the _sysfs_ part means
it's something generic and possibly exported for other parts to use.
Same for the other callbacks.

> +static struct attribute *devid_attrs[] = {
> +	BTRFS_ATTR_PTR(devid, writeable),
> +	BTRFS_ATTR_PTR(devid, in_fs_metadata),
> +	BTRFS_ATTR_PTR(devid, missing),
> +	BTRFS_ATTR_PTR(devid, replace_target),

Sorted alphabetically.

All will be fixed at commit time. The device state bits could be
interestig to user in some cases and they're probably going to stay so
we have some future guarantee of the sort-of-ABI for sysfs.

The first 3 patches are deep in misc-next so I'll reorder them so the
whole series is grouped together.
