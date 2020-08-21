Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290CD24D767
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Aug 2020 16:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgHUOgN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Aug 2020 10:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgHUOgJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Aug 2020 10:36:09 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF53C061573
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Aug 2020 07:36:08 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b14so1536422qkn.4
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Aug 2020 07:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=l9KyUeszAkrBD/HqerCZTSys0KKGRRGTxFfySTjiuTI=;
        b=g5Xz8c3/HsL+N9/ipSWOumTFP19VRmNTG33kmcOTuk2VdLv953T6VAvWSKLe/eHYpH
         quIVEsZbvOMXZhNW6H/IuaFeZBz3vN3GP2aNiUVLhGQps/gtuOeB3lOM6gnh3zDnRjSs
         3ujHRXUcSbXi+vIc0NNIHPpzjdIY0RUc2GCXlbP7/oweWwmejUaWzYapMbj6CEvYmGhZ
         eYYkdSuHKJ6zXHqQkPDRyvuPO0rHXVnWUuV0I7aQU47d4bMEjArrNG0MorKt3/sX7gyp
         czz7q9YlBhPWH6XaL3u/6Cgo1MGftKKNPELE2GArQs/OLytYvLfjyiBQGQz3NpEGpHVD
         TPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l9KyUeszAkrBD/HqerCZTSys0KKGRRGTxFfySTjiuTI=;
        b=Z2uys6g3/mZvRfIxmg/Zsjq+4p/+nRUzgDffxByS/yBVT/AlFbo2R1ryHsvPDu/PPC
         B4/1XhvmWFjw0wROKDCytQdG4sgsjzD+m56a0kaQa4YLMxccFvspOfyXp5+fzpdaSEgI
         TzoQrTccjm9vQBCFyL8GpIcobMdeOnPl/2/HQumYd6cqnLX2Q5+gw2jwY1Wf15LnWdM1
         7qlfndbGjY+YWqEl1UMGy9boJ/KJujRbFf0z6gJsi18DgxTedTf4032v0pR69kRLj06i
         cUJ7zBr+d8L2jOEyTTxguZRSsmtsVE+qJa4nKTfPWGZ0+SL8GPCs5ChOWASKXT4iUK94
         4gfQ==
X-Gm-Message-State: AOAM532PI80K3jUVCjycyXcqjhZxgP4HocIugFV3ZbX3cUrI5Pt5s76v
        BSVQ2FmJAdl3AfbbS6y2FbDFvJzbGs832Q==
X-Google-Smtp-Source: ABdhPJwIT7fze9ykJjAC79AuEHrkVcKCtHEX1g21mfOJ1wMAldrFDxB4MRzvuRtgE/AJ0LvN3Y5WPw==
X-Received: by 2002:ae9:e882:: with SMTP id a124mr2968806qkg.24.1598020566849;
        Fri, 21 Aug 2020 07:36:06 -0700 (PDT)
Received: from localhost.localdomain ([2600:380:a347:d293:267e:e50:f799:d6f0])
        by smtp.gmail.com with ESMTPSA id t83sm1687495qke.133.2020.08.21.07.36.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 07:36:06 -0700 (PDT)
Subject: Re: [PATCH 1/2] btrfs: initialize sysfs devid and device link for
 seed device
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <d82dc7d38ac43d88381eaa5260cee3dc9907e810.1598011271.git.anand.jain@oracle.com>
 <2c7ca821f53d71d6c1a4e1f1c969c1d8e686021a.1598012410.git.anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <779bd819-d320-39e3-0a0b-80c0c8455243@toxicpanda.com>
Date:   Fri, 21 Aug 2020 10:36:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2c7ca821f53d71d6c1a4e1f1c969c1d8e686021a.1598012410.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/21/20 9:15 AM, Anand Jain wrote:
> The following test case leads to null kobject-being-freed error.
> 
>   mount seed /mnt
>   add sprout to /mnt
>   umount /mnt
>   mount sprout to /mnt
>   delete seed
> 
>   kobject: '(null)' (00000000dd2b87e4): is not initialized, yet kobject_put() is being called.
>   WARNING: CPU: 1 PID: 15784 at lib/kobject.c:736 kobject_put+0x80/0x350
>   RIP: 0010:kobject_put+0x80/0x350
>   ::
>   Call Trace:
>   btrfs_sysfs_remove_devices_dir+0x6e/0x160 [btrfs]
>   btrfs_rm_device.cold+0xa8/0x298 [btrfs]
>   btrfs_ioctl+0x206c/0x22a0 [btrfs]
>   ksys_ioctl+0xe2/0x140
>   __x64_sys_ioctl+0x1e/0x29
>   do_syscall_64+0x96/0x150
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
>   RIP: 0033:0x7f4047c6288b
>   ::
> 
> This is because, at the end of the seed device-delete, we try to remove
> the seed's devid sysfs entry. But for the seed devices under the sprout
> fs, we don't initialize the devid kobject yet. So this patch initializes
> the seed device devid kobject and the device link in the sysfs. This takes
> care of the Warning.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>   fs/btrfs/sysfs.c | 30 ++++++++++++++++++++----------
>   1 file changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 88fd4ce937b8..85403fc3d5c7 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -1154,20 +1154,20 @@ int btrfs_sysfs_add_space_info_type(struct btrfs_fs_info *fs_info,
>   /* when one_device is NULL, it removes all device links */
>   
>   int btrfs_sysfs_remove_devices_dir(struct btrfs_fs_devices *fs_devices,
> -		struct btrfs_device *one_device)
> +				   struct btrfs_device *one_device)
>   {
>   	struct hd_struct *disk;
>   	struct kobject *disk_kobj;
> +	struct kobject *devices_kobj = fs_devices->devices_kobj;
>   
> -	if (!fs_devices->devices_kobj)
> +	if (!devices_kobj)
>   		return -EINVAL;
>   
>   	if (one_device) {
>   		if (one_device->bdev) {
>   			disk = one_device->bdev->bd_part;
>   			disk_kobj = &part_to_dev(disk)->kobj;
> -			sysfs_remove_link(fs_devices->devices_kobj,
> -					  disk_kobj->name);
> +			sysfs_remove_link(devices_kobj, disk_kobj->name);
>   		}
>   
>   		kobject_del(&one_device->devid_kobj);
> @@ -1178,19 +1178,23 @@ int btrfs_sysfs_remove_devices_dir(struct btrfs_fs_devices *fs_devices,
>   		return 0;
>   	}
>   
> +again:
>   	list_for_each_entry(one_device, &fs_devices->devices, dev_list) {
>   
>   		if (one_device->bdev) {
>   			disk = one_device->bdev->bd_part;
>   			disk_kobj = &part_to_dev(disk)->kobj;
> -			sysfs_remove_link(fs_devices->devices_kobj,
> -					  disk_kobj->name);
> +			sysfs_remove_link(devices_kobj, disk_kobj->name);
>   		}
>   		kobject_del(&one_device->devid_kobj);
>   		kobject_put(&one_device->devid_kobj);
>   
>   		wait_for_completion(&one_device->kobj_unregister);
>   	}
> +	while (fs_devices->seed) {
> +		fs_devices = fs_devices->seed;
> +		goto again;
> +	}
>   
>   	return 0;
>   }
> @@ -1279,8 +1283,11 @@ int btrfs_sysfs_add_devices_dir(struct btrfs_fs_devices *fs_devices,
>   	int error = 0;
>   	struct btrfs_device *dev;
>   	unsigned int nofs_flag;
> +	struct kobject *devices_kobj = fs_devices->devices_kobj;
> +	struct kobject *devinfo_kobj = fs_devices->devinfo_kobj;
>   
>   	nofs_flag = memalloc_nofs_save();
> +again:
>   	list_for_each_entry(dev, &fs_devices->devices, dev_list) {
>   
>   		if (one_device && one_device != dev)
> @@ -1293,21 +1300,24 @@ int btrfs_sysfs_add_devices_dir(struct btrfs_fs_devices *fs_devices,
>   			disk = dev->bdev->bd_part;
>   			disk_kobj = &part_to_dev(disk)->kobj;
>   
> -			error = sysfs_create_link(fs_devices->devices_kobj,
> -						  disk_kobj, disk_kobj->name);
> +			error = sysfs_create_link(devices_kobj, disk_kobj,
> +						  disk_kobj->name);
>   			if (error)
>   				break;
>   		}
>   
>   		init_completion(&dev->kobj_unregister);
>   		error = kobject_init_and_add(&dev->devid_kobj, &devid_ktype,
> -					     fs_devices->devinfo_kobj, "%llu",
> -					     dev->devid);
> +					     devinfo_kobj, "%llu", dev->devid);
>   		if (error) {
>   			kobject_put(&dev->devid_kobj);
>   			break;
>   		}
>   	}
> +	while(fs_devices->seed) {
> +		fs_devices = fs_devices->seed;
> +		goto again;
> +	}
>   	memalloc_nofs_restore(nofs_flag);
>   
>   	return error;
> 

So now we're using the main fs_devices->devices_kobj, which is the main 
fs_devices with fs_devices->seed being the seed fs_devices.  This is 
fine, except when we actually mount a seed device, and in that case we 
have fs_devices as the seed devices being used, and then if we add a 
device we'll actually swap in the new fs_devices for the main 
fs_devices, and we have the seed devices with the actual devices_kobj 
that we used set in fs_devices->seed, and thus we'll leak the sysfs 
objects for the seed devices.  Thanks,

Josef
