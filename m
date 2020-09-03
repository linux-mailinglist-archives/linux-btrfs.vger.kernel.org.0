Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7FB25BEC4
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 12:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgICKDQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 06:03:16 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50976 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgICKDQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Sep 2020 06:03:16 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0839wwua116494;
        Thu, 3 Sep 2020 10:03:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=y1sxfLFjWJ2VdNOVXhFWND0IaE8Je/rx9rDbuelQfLE=;
 b=t8wGSJ+uV6BCQsKAqqGU27+ssNt0W1ADZ0mQCrjAIKadznZMhuxv2+rytv4aUILCrqv0
 Z0fHGZc9GQxKCO1Awc3HM1EtKvCOChvJznqxXYmtZc8aIdOyZ24at23iSCW3kdj/YITW
 GjG25FCHmfjJrocFQI4BtWJeM+wwwoSVarTmAdaQq6wQoveqJ0wbUlVus5Du5wuI5qLf
 zsku+iCMgGAEl2wZX9S5woSrWnjyEQ8f9rIyMtHgcd0EzWQssZWk518rYCMYIquk42mg
 Xnbz+7Rs3an2vCgo/QPlc9BvXRydvYzaF3aDOOY34ZzZgneV+MgYTVG9XHo55V7llEqZ Xw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 337eer7v0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 03 Sep 2020 10:03:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0839tn7r170945;
        Thu, 3 Sep 2020 10:03:10 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 3380y1m0cs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Sep 2020 10:03:09 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 083A38hY020044;
        Thu, 3 Sep 2020 10:03:08 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Sep 2020 03:03:08 -0700
Subject: Re: [PATCH 02/15] btrfs: add btrfs_sysfs_remove_device helper
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1599091832.git.anand.jain@oracle.com>
 <e86c1cd026973f7b65ccf26a523cc2e476fb13fc.1599091832.git.anand.jain@oracle.com>
 <3e4180cf-c43d-baa1-db94-2d5d6c8965ca@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <cbd33e03-87d7-ea17-8141-33b0ee8bf06b@oracle.com>
Date:   Thu, 3 Sep 2020 18:03:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <3e4180cf-c43d-baa1-db94-2d5d6c8965ca@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009030091
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009030091
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 3/9/20 4:44 pm, Nikolay Borisov wrote:
> 
> 
> On 3.09.20 г. 3:57 ч., Anand Jain wrote:
>> btrfs_sysfs_remove_devices_dir() removes device link and devid kobject
>> (sysfs entries) for a device or all the devices in the btrfs_fs_devices.
>> In preparation to remove these sysfs entries for the seed as well, add
>> a btrfs_sysfs_remove_device() helper function and avoid code
>> duplication.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> 
> LGTM, one nit below though:
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> 
>> ---
>>   fs/btrfs/sysfs.c | 54 ++++++++++++++++++++++--------------------------
>>   1 file changed, 25 insertions(+), 29 deletions(-)
>>
>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
>> index 3381a91d7deb..241ec0ad0379 100644
>> --- a/fs/btrfs/sysfs.c
>> +++ b/fs/btrfs/sysfs.c
>> @@ -1149,46 +1149,42 @@ int btrfs_sysfs_add_space_info_type(struct btrfs_fs_info *fs_info,
>>   	return 0;
>>   }
>>   
>> -/* when one_device is NULL, it removes all device links */
>> -
>> -int btrfs_sysfs_remove_devices_dir(struct btrfs_fs_devices *fs_devices,
>> -		struct btrfs_device *one_device)
>> +static void btrfs_sysfs_remove_device(struct btrfs_device *device)
>>   {
>>   	struct hd_struct *disk;
>>   	struct kobject *disk_kobj;
>> +	struct kobject *devices_kobj;
>>   
>> -	if (!fs_devices->devices_kobj)
>> -		return -EINVAL;
>> +	/*
>> +	 * Seed fs_devices devices_kobj aren't used, fetch kobject from the
>> +	 * fs_info::fs_devices.
>> +	 */
>> +	devices_kobj = device->fs_info->fs_devices->devices_kobj;
> 
> nit: device->fs_info->fs_devices

  Sorry what are you suggesting here? I didn't understand.

Thanks, Anand



> 
>> +	ASSERT(devices_kobj);
>>   
>> -	if (one_device) {
>> -		if (one_device->bdev) {
>> -			disk = one_device->bdev->bd_part;
>> -			disk_kobj = &part_to_dev(disk)->kobj;
>> -			sysfs_remove_link(fs_devices->devices_kobj,
>> -					  disk_kobj->name);
>> -		}
>> +	if (device->bdev) {
>> +		disk = device->bdev->bd_part;
>> +		disk_kobj = &part_to_dev(disk)->kobj;
>> +		sysfs_remove_link(devices_kobj, disk_kobj->name);
>> +	}
>>   
>> -		kobject_del(&one_device->devid_kobj);
>> -		kobject_put(&one_device->devid_kobj);
>> +	kobject_del(&device->devid_kobj);
>> +	kobject_put(&device->devid_kobj);
>>   
>> -		wait_for_completion(&one_device->kobj_unregister);
>> +	wait_for_completion(&device->kobj_unregister);
>> +}
>>   
>> +/* when 2nd argument device is NULL, it removes all devices link */
>> +int btrfs_sysfs_remove_devices_dir(struct btrfs_fs_devices *fs_devices,
>> +				   struct btrfs_device *one_device)
>> +{
>> +	if (one_device) {
>> +		btrfs_sysfs_remove_device(one_device);
>>   		return 0;
>>   	}
>>   
>> -	list_for_each_entry(one_device, &fs_devices->devices, dev_list) {
>> -
>> -		if (one_device->bdev) {
>> -			disk = one_device->bdev->bd_part;
>> -			disk_kobj = &part_to_dev(disk)->kobj;
>> -			sysfs_remove_link(fs_devices->devices_kobj,
>> -					  disk_kobj->name);
>> -		}
>> -		kobject_del(&one_device->devid_kobj);
>> -		kobject_put(&one_device->devid_kobj);
>> -
>> -		wait_for_completion(&one_device->kobj_unregister);
>> -	}
>> +	list_for_each_entry(one_device, &fs_devices->devices, dev_list)
>> +		btrfs_sysfs_remove_device(one_device);
>>   
>>   	return 0;
>>   }
>>
