Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0EE6256737
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Aug 2020 13:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgH2Lqg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Aug 2020 07:46:36 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46388 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728089AbgH2LpE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Aug 2020 07:45:04 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07TBdV4M157494;
        Sat, 29 Aug 2020 11:44:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=HouKbXTSiUN7s2wR5TqtK9NDdt5nl93ql+q0/P4wHho=;
 b=S0bY96IgA5FJ88E/p4iBW7w+RRY6IzRkbjbZOKwyLVWdqs8m1hlFulEFlDzznoAi2IMs
 MU8kEudcyOP1w6dNEnm6vHBoNtXC9zsQF+lI87GFut2J4Q267wZrj7reO6wqcJLRCBtY
 pZBxjNsts3lV4Bvko4kWeNBGadMWI6cxh4+y+TerVXr1+nS8qXE/0gFftNy0IiYeJJef
 GB0JAXcqQuBnf/JpElu+wUO9uAuT0pcwGB1Ot+nqNKozvR5BQgEBb+AH1bBCnXIdCiQh
 XdVKIwPa86W3PRolYf3pNojQEJMnIOJGj0M4+2cUeYMVhB4aRLYKG1E9MQzSP+0YejLg 3g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 337fnmrppc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 29 Aug 2020 11:44:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07TBePZj038245;
        Sat, 29 Aug 2020 11:44:42 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 337eu0v56x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Aug 2020 11:44:41 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07TBie6p022643;
        Sat, 29 Aug 2020 11:44:40 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 29 Aug 2020 04:44:40 -0700
Subject: Re: [PATCH 1/2] btrfs: initialize sysfs devid and device link for
 seed device
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com
References: <d82dc7d38ac43d88381eaa5260cee3dc9907e810.1598011271.git.anand.jain@oracle.com>
 <2c7ca821f53d71d6c1a4e1f1c969c1d8e686021a.1598012410.git.anand.jain@oracle.com>
Message-ID: <f2c983eb-cb9a-f343-15f4-ce0705dd5aff@oracle.com>
Date:   Sat, 29 Aug 2020 19:44:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <2c7ca821f53d71d6c1a4e1f1c969c1d8e686021a.1598012410.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9727 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 adultscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008290093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9727 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 suspectscore=1 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008290093
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org




On 21/8/20 9:15 pm, Anand Jain wrote:
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


Ping?

Thanks, Anand
