Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFBE136485
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2020 02:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbgAJBEJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jan 2020 20:04:09 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:54310 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730352AbgAJBEJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Jan 2020 20:04:09 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00A138Pb049462;
        Fri, 10 Jan 2020 01:04:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=PSjffazeU2f2us8APFfJ3+efFvBA5f0t9KyRWY9HZcE=;
 b=P0fjusZmB+fEOhGr3+58Bd/dbGRkCLrsS3+40tTqNfyEQhV4dWBHPe4HYCZDL6cBm8YD
 6vH0KJPMO6uVQ5nQWK1sdtkOKtKPPYwg3lXsaQXEwee35gEbgxNf4OugjHXUUCxQf3f3
 rlLU/9OjeNu4/SSSo2Gr3ir6wZTgLnEV9UW6DFNUHmMEkh/h45JsIn7Bv+x96b4WmPlk
 bOH+gCk99ZTxkFKTm5ewWrmHhFdOkNsusklfBEeuNzNCabe0Ex25CsTZqfXNFUlKi/ku
 WAjuGxQEE4DEGpBTE0cGrAkVd6KWTmT15hRRE/GqnisdT1toA6avVZyOunmIa5bdjAwG Og== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2xakbr6ed6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jan 2020 01:04:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00A13x4M116071;
        Fri, 10 Jan 2020 01:04:04 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2xdms0fsdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jan 2020 01:04:00 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00A13V37007374;
        Fri, 10 Jan 2020 01:03:31 GMT
Received: from [192.168.44.21] (/183.90.37.125)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 Jan 2020 17:03:29 -0800
Subject: Re: [PATCH v4 4/4] btrfs: sysfs, add devid/dev_state kobject and
 attribute
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20191205112706.8125-5-anand.jain@oracle.com>
 <1578310711-20887-1-git-send-email-anand.jain@oracle.com>
 <20200109152040.GP3929@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <d30de4d8-d492-b517-364d-c85d9bbf485d@oracle.com>
Date:   Fri, 10 Jan 2020 09:03:19 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200109152040.GP3929@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9495 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001100008
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9495 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001100008
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 9/1/20 11:20 PM, David Sterba wrote:
> On Mon, Jan 06, 2020 at 07:38:31PM +0800, Anand Jain wrote:
>> New sysfs attributes
>>    in_fs_metadata  missing  replace_target  writeable
>> are added under a new kobject
>>    UUID/devinfo/<devid>
>>
>> These attributes reflects the state of the device from the kernel
>> fed by %btrfs_device::dev_state.
>> These attributes are born during mount and goes along with the dynamic
>> nature of the device add and delete, otherwise these attribute and kobject
>> gets deleted at unmount.
>>
>> Sample output:
>> pwd
>>   /sys/fs/btrfs/6e1961f1-5918-4ecc-a22f-948897b409f7/devinfo/1/
>> ls
>>    in_fs_metadata  missing  replace_target  writeable
>> cat missing
>>    0
>>
>> The output from these attributes are 0 or 1. 0 indicates unset and 1
>> indicates set.
>>
>> As of now these attributes are readonly.
>>
>> It is observed that the device delete thread and sysfs read thread will
>> not race because the delete thread calls sysfs kobject_put() which in turn
>> waits for existing sysfs read to complete.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> v4:
>>     after patch
>>     [PATCH v5 2/2] btrfs: reset device back to allocation state when removing
>>     in misc-next, the device::devid_kobj remains stale, fix it by using
>>     release.
>>
>> v3:
>>    Use optional groupid devid in BTRFS_ATTR(), it was blank in v2.
>>
>> V2:
>>    Make the devinfo attribute to carry one parameter, so now
>>    instead of dev_state attribute, we create in_fs_metadata,
>>    writeable, missing and replace_target attributes.
>>
>>   fs/btrfs/sysfs.c   | 142 ++++++++++++++++++++++++++++++++++++++++++++---------
>>   fs/btrfs/volumes.h |   3 ++
>>   2 files changed, 122 insertions(+), 23 deletions(-)
>>
>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
>> index 834f712ed60c..18dac99188ce 100644
>> --- a/fs/btrfs/sysfs.c
>> +++ b/fs/btrfs/sysfs.c
>> @@ -978,29 +978,116 @@ int btrfs_sysfs_remove_devices_attr(struct btrfs_fs_devices *fs_devices,
>>   	if (!fs_devices->devices_kobj)
>>   		return -EINVAL;
>>   
>> -	if (one_device && one_device->bdev) {
>> -		disk = one_device->bdev->bd_part;
>> -		disk_kobj = &part_to_dev(disk)->kobj;
>> +	if (one_device) {
>> +		if (one_device->bdev) {
>> +			disk = one_device->bdev->bd_part;
>> +			disk_kobj = &part_to_dev(disk)->kobj;
>> +			sysfs_remove_link(fs_devices->devices_kobj, disk_kobj->name);
>> +		}
>>   
>> -		sysfs_remove_link(fs_devices->devices_kobj, disk_kobj->name);
>> -	}
>> +		kobject_del(&one_device->devid_kobj);
>> +		kobject_put(&one_device->devid_kobj);
>> +
>> +		wait_for_completion(&one_device->kobj_unregister);
>>   
>> -	if (one_device)
>>   		return 0;
>> +	}
>>   
>> -	list_for_each_entry(one_device,
>> -			&fs_devices->devices, dev_list) {
>> -		if (!one_device->bdev)
>> -			continue;
>> -		disk = one_device->bdev->bd_part;
>> -		disk_kobj = &part_to_dev(disk)->kobj;
>> +	list_for_each_entry(one_device, &fs_devices->devices, dev_list) {
>> +
>> +		if (one_device->bdev) {
>> +			disk = one_device->bdev->bd_part;
>> +			disk_kobj = &part_to_dev(disk)->kobj;
>> +			sysfs_remove_link(fs_devices->devices_kobj, disk_kobj->name);
>> +		}
>> +		kobject_del(&one_device->devid_kobj);
>> +		kobject_put(&one_device->devid_kobj);
>>   
>> -		sysfs_remove_link(fs_devices->devices_kobj, disk_kobj->name);
>> +		wait_for_completion(&one_device->kobj_unregister);
>>   	}
>>   
>>   	return 0;
>>   }
>>   
>> +static ssize_t btrfs_sysfs_writeable_show(struct kobject *kobj,
> 
> This could be btrfs_devinfo_writeable_show as the _sysfs_ part means
> it's something generic and possibly exported for other parts to use.
> Same for the other callbacks.
> 
>> +static struct attribute *devid_attrs[] = {
>> +	BTRFS_ATTR_PTR(devid, writeable),
>> +	BTRFS_ATTR_PTR(devid, in_fs_metadata),
>> +	BTRFS_ATTR_PTR(devid, missing),
>> +	BTRFS_ATTR_PTR(devid, replace_target),
> 
> Sorted alphabetically.
> 
> All will be fixed at commit time. The device state bits could be
> interestig to user in some cases and they're probably going to stay so
> we have some future guarantee of the sort-of-ABI for sysfs.
> 
> The first 3 patches are deep in misc-next so I'll reorder them so the
> whole series is grouped together.
> 

  I agree with your suggestions, thanks for correcting them before commit.
Anand
