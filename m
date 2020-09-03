Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17A425BE8E
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 11:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgICJhC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 05:37:02 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33070 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgICJgx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Sep 2020 05:36:53 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0839ZG77073745;
        Thu, 3 Sep 2020 09:36:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=fVnBK/QPZGTlcYbkL8Z49wM03MZTPcTDurcJgjuCo04=;
 b=gkrpugLl43NJXol6NxUQcmHeaduX9ZGZv0Fgw73fQXnA/m/7OpT/clrjmCzvvN8Kxitw
 lzBxgY0EJ36DP4VgZ6JVqFso6Fub18enSSV03AOjNmHu4Z4hj3e0V58zE4I7FDPpVgnK
 LXPjEWJoYQKLGWX5pjpvMoxdlwr4ky4j4MTr8Q71G5cLSXJjyj/nz57mNSsFi0mZONPs
 X4ppgvPq24H/avO5LuhnEKToQVLGcraQeLK14U0/KjTMWdLpLFFZ/gi9KYlNdJdQlqf9
 ahY2WTPOnnySfWjARzdvRzJKzeinrODn1o+ZLRApq2o+kX5PEtqPEG/zMCX7UThlnn0Z rg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 337eer7rdn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 03 Sep 2020 09:36:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0839ZI8X066937;
        Thu, 3 Sep 2020 09:36:48 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 3380krfgka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Sep 2020 09:36:48 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0839al69011111;
        Thu, 3 Sep 2020 09:36:47 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Sep 2020 02:36:47 -0700
Subject: Re: [PATCH 01/15] btrfs: add btrfs_sysfs_add_device helper
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1599091832.git.anand.jain@oracle.com>
 <5f8aa8a03a1712adba0023fc1efa18623571c588.1599091832.git.anand.jain@oracle.com>
 <25dcceb5-631f-3fde-1326-024d0ff02ba8@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <462d6dba-f7fa-93de-2fe8-e66202cad8a5@oracle.com>
Date:   Thu, 3 Sep 2020 17:36:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <25dcceb5-631f-3fde-1326-024d0ff02ba8@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009030087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009030087
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 3/9/20 4:40 pm, Nikolay Borisov wrote:
> 
> 
> On 3.09.20 г. 3:57 ч., Anand Jain wrote:
>> btrfs_sysfs_add_devices_dir() adds device link and devid kobject
>> (sysfs entries) for a device or all the devices in the btrfs_fs_devices.
>> In preparation to add these sysfs entries for the seed as well, add
>> a btrfs_sysfs_add_device() helper function and avoid code duplication.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/sysfs.c | 79 ++++++++++++++++++++++++++++++++----------------
>>   1 file changed, 53 insertions(+), 26 deletions(-)
>>
>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
>> index 190e59152be5..3381a91d7deb 100644
>> --- a/fs/btrfs/sysfs.c
>> +++ b/fs/btrfs/sysfs.c
>> @@ -1271,44 +1271,71 @@ static struct kobj_type devid_ktype = {
>>   	.release	= btrfs_release_devid_kobj,
>>   };
>>   
>> -int btrfs_sysfs_add_devices_dir(struct btrfs_fs_devices *fs_devices,
>> -				struct btrfs_device *one_device)
>> +static int btrfs_sysfs_add_device(struct btrfs_device *device)
>>   {
>> -	int error = 0;
>> -	struct btrfs_device *dev;
>> +	int ret;
>>   	unsigned int nofs_flag;
>> +	struct kobject *devices_kobj;
>> +        struct kobject *devinfo_kobj;
> 
> Whitespace damage

  oops.


> 
>>   
>> -	nofs_flag = memalloc_nofs_save();
>> -	list_for_each_entry(dev, &fs_devices->devices, dev_list) {
>> +	/*
>> +	 * make sure we use the fs_info::fs_devices to fetch the kobjects
>> +	 * even for the seed fs_devices
>> +	 */
>> +	devices_kobj = device->fs_devices->fs_info->fs_devices->devices_kobj;
>> +	devinfo_kobj = device->fs_devices->fs_info->fs_devices->devinfo_kobj;
> 
> This function and its callers are called after the fs_info of devices is
> initialized so can't you simply do 'device->fs_info->fs_devices->'...
> reduces a level of pointer chasing.
> 

  Oh. Right. Will fix.

>> +	ASSERT(devices_kobj);
>> +	ASSERT(devinfo_kobj);
> <snip>
> 
> 
>>   
>> -	return error;
>> +int btrfs_sysfs_add_devices_dir(struct btrfs_fs_devices *fs_devices,
>> +				struct btrfs_device *one_device)
>> +{
>> +	int ret;
> 
> That variable can be defined inside the list_for_each-entry as it's
> being used only in that context.

ok.

Thanks!
Anand

>> +
>> +	if (one_device)
>> +		return btrfs_sysfs_add_device(one_device);
>> +
>> +	list_for_each_entry(one_device, &fs_devices->devices, dev_list) {
>> +		ret = btrfs_sysfs_add_device(one_device);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>>   }
>>   
>>   void btrfs_kobject_uevent(struct block_device *bdev, enum kobject_action action)
>>
