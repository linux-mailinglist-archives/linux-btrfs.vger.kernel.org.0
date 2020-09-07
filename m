Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B32E25FA11
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Sep 2020 14:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgIGMAe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Sep 2020 08:00:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52268 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729188AbgIGL7j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Sep 2020 07:59:39 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 087Bs5Uq056595;
        Mon, 7 Sep 2020 11:59:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=iVEHe1oJoGiZ4cc8e5Uca4pGe+dj4LIvOe3TshU16Ks=;
 b=FMHedXr4X/fqrC3W4Rp65ggo+ucFbWrpbkFCFEsgtxgdNvoEmO7RQWcSvNPl/sRPRuoa
 0NTPDzwBTFTS/ZfhCQ//Bme1TSWY2e1ILSVJM4r0kQ/c8ON6BELRJwbNEOwooCVZAUTh
 GdA3dS0jcq0w6tGkMthcVXHq6CYWbunVhhGfeWRCQwsa3ysTAAlmOIhYqR8BZI/u/ZaJ
 TQ75Y0OyqSgB63S2rV2Dk5++qA+XVwNgLcZXjQ6hpmw9kMgg4WX1ns5bcfhmGbWU4Fk8
 /BhuJy5cx3rhoL4c0IoEwKgBFRWCuO0WxsaURU5nW1U7Ej+sdn8Ho5t2Tz8geKF6mCnY gw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 33c3amp86b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 07 Sep 2020 11:59:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 087BsuAr175911;
        Mon, 7 Sep 2020 11:57:24 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 33cmk0fa8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Sep 2020 11:57:24 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 087BvNKH025132;
        Mon, 7 Sep 2020 11:57:23 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Sep 2020 04:57:22 -0700
Subject: Re: [PATCH 01/16] btrfs: fix put of uninitialized kobject after seed
 device delete
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Cc:     "dsterba@suse.com" <dsterba@suse.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "nborisov@suse.com" <nborisov@suse.com>
References: <cover.1599234146.git.anand.jain@oracle.com>
 <5432348a53c7ec3fb97d4a21121d435fd3a1be74.1599234146.git.anand.jain@oracle.com>
 <SN4PR0401MB35988315D6DF0068151AE2359B280@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <SN4PR0401MB3598B2EC32C25D601E59BF879B280@SN4PR0401MB3598.namprd04.prod.outlook.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <a0f3b051-b9e6-e881-cdb1-0c75224f6760@oracle.com>
Date:   Mon, 7 Sep 2020 19:57:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <SN4PR0401MB3598B2EC32C25D601E59BF879B280@SN4PR0401MB3598.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9736 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009070118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9736 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009070118
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 7/9/20 7:30 pm, Johannes Thumshirn wrote:
> On 07/09/2020 13:29, Johannes Thumshirn wrote:
>> On 04/09/2020 19:37, Anand Jain wrote:
>>> The following test case leads to null kobject-being-freed error.
>>>
>>>   mount seed /mnt
>>>   add sprout to /mnt
>>>   umount /mnt
>>>   mount sprout to /mnt
>>>   delete seed
>>>
>>>   kobject: '(null)' (00000000dd2b87e4): is not initialized, yet kobject_put() is being called.
>>>   WARNING: CPU: 1 PID: 15784 at lib/kobject.c:736 kobject_put+0x80/0x350
>>>   RIP: 0010:kobject_put+0x80/0x350
>>>   ::
>>>   Call Trace:
>>>   btrfs_sysfs_remove_devices_dir+0x6e/0x160 [btrfs]
>>>   btrfs_rm_device.cold+0xa8/0x298 [btrfs]
>>>   btrfs_ioctl+0x206c/0x22a0 [btrfs]
>>>   ksys_ioctl+0xe2/0x140
>>>   __x64_sys_ioctl+0x1e/0x29
>>>   do_syscall_64+0x96/0x150
>>>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>>   RIP: 0033:0x7f4047c6288b
>>>   ::
>>>
>>> This is because, at the end of the seed device-delete, we try to remove
>>> the seed's devid sysfs entry. But for the seed devices under the sprout
>>> fs, we don't initialize the devid kobject yet. So add a kobject state
>>> check, which takes care of the Warning.
>>>
>>> Fixes: 668e48af btrfs: sysfs, add devid/dev_state kobject and device attributes
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>> ---
>>>   fs/btrfs/sysfs.c | 16 ++++++++++------
>>>   1 file changed, 10 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
>>> index 190e59152be5..438a367371c4 100644
>>> --- a/fs/btrfs/sysfs.c
>>> +++ b/fs/btrfs/sysfs.c
>>> @@ -1168,10 +1168,12 @@ int btrfs_sysfs_remove_devices_dir(struct btrfs_fs_devices *fs_devices,
>>>   					  disk_kobj->name);
>>>   		}
>>>   
>>> -		kobject_del(&one_device->devid_kobj);
>>> -		kobject_put(&one_device->devid_kobj);
>>> +		if (one_device->devid_kobj.state_initialized) {
>>> +			kobject_del(&one_device->devid_kobj);
>>> +			kobject_put(&one_device->devid_kobj);
>>>   
>>> -		wait_for_completion(&one_device->kobj_unregister);
>>> +			wait_for_completion(&one_device->kobj_unregister);
>>> +		}
>>>   
>>>   		return 0;
>>>   	}
>>> @@ -1184,10 +1186,12 @@ int btrfs_sysfs_remove_devices_dir(struct btrfs_fs_devices *fs_devices,
>>>   			sysfs_remove_link(fs_devices->devices_kobj,
>>>   					  disk_kobj->name);
>>>   		}
>>> -		kobject_del(&one_device->devid_kobj);
>>> -		kobject_put(&one_device->devid_kobj);
>>> +		if (one_device->devid_kobj.state_initialized) {
>>> +			kobject_del(&one_device->devid_kobj);
>>> +			kobject_put(&one_device->devid_kobj);
>>>   
>>> -		wait_for_completion(&one_device->kobj_unregister);
>>> +			wait_for_completion(&one_device->kobj_unregister);
>>> +		}
>>>   	}
>>>   
>>>   	return 0;
>>>
>>
>> Hmm this is a lot of duplicated code. It was before as well, this patch only adds
>> to the code duplication.
>>
>> Can't we do sth like this:
>>
> 
> 
> Hit sent too early I'm sorry. I meant add this (untested) as a prep patch:


David and I decided to avoid cleanups in the patch 1/16, and are
pushed into the patch 3-7/16, mainly to make the bug fix patch easy
to backport.

Thanks, Anand


> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 190e59152be5..84114a1ec502 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -1151,44 +1151,40 @@ int btrfs_sysfs_add_space_info_type(struct btrfs_fs_info *fs_info,
>   
>   /* when one_device is NULL, it removes all device links */
>   
> +
> +static void btrfs_sysfs_remove_one_devices_dir(struct btrfs_device *dev)
> +{
> +       if (one_device->bdev) {
> +               struct hd_struct *disk;
> +               struct kobject *disk_kobj;
> +
> +               disk = one_device->bdev->bd_part;
> +               disk_kobj = &part_to_dev(disk)->kobj;
> +               sysfs_remove_link(fs_devices->devices_kobj,
> +                                 disk_kobj->name);
> +       }
> +
> +       kobject_del(&one_device->devid_kobj);
> +       kobject_put(&one_device->devid_kobj);
> +
> +       wait_for_completion(&one_device->kobj_unregister);
> +
> +       return;
> +}
> +
>   int btrfs_sysfs_remove_devices_dir(struct btrfs_fs_devices *fs_devices,
>                  struct btrfs_device *one_device)
>   {
> -       struct hd_struct *disk;
> -       struct kobject *disk_kobj;
> -
>          if (!fs_devices->devices_kobj)
>                  return -EINVAL;
>   
>          if (one_device) {
> -               if (one_device->bdev) {
> -                       disk = one_device->bdev->bd_part;
> -                       disk_kobj = &part_to_dev(disk)->kobj;
> -                       sysfs_remove_link(fs_devices->devices_kobj,
> -                                         disk_kobj->name);
> -               }
> -
> -               kobject_del(&one_device->devid_kobj);
> -               kobject_put(&one_device->devid_kobj);
> -
> -               wait_for_completion(&one_device->kobj_unregister);
> -
> +               btrfs_sysfs_remove_one_devices_dir(one_device);
>                  return 0;
>          }
>   
> -       list_for_each_entry(one_device, &fs_devices->devices, dev_list) {
> -
> -               if (one_device->bdev) {
> -                       disk = one_device->bdev->bd_part;
> -                       disk_kobj = &part_to_dev(disk)->kobj;
> -                       sysfs_remove_link(fs_devices->devices_kobj,
> -                                         disk_kobj->name);
> -               }
> -               kobject_del(&one_device->devid_kobj);
> -               kobject_put(&one_device->devid_kobj);
> -
> -               wait_for_completion(&one_device->kobj_unregister);
> -       }
> +       list_for_each_entry(one_device, &fs_devices->devices, dev_list)
> +               btrfs_sysfs_remove_one_devices_dir(one_device);
>   
>          return 0;
>   }
> 
