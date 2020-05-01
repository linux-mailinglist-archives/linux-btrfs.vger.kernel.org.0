Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A287D1C11D1
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 May 2020 14:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbgEAMD6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 May 2020 08:03:58 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37206 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbgEAMD6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 May 2020 08:03:58 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 041C2xo9151758;
        Fri, 1 May 2020 12:03:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=6+lWGoZN1WaaPkACnaadGK7eaF4ZAyO1fxIKRwe4rYo=;
 b=FIZQqsvVKvMISQlF1XMc8OqDItyKLjkPT7omM7chKomcQLQkq9R2wJXXwi3FTfkOVJX2
 fxq6Mvra3YYAPJmk+9oEjdhtizMlsv2GgOmdDbRzAseoJlNIODxRwTUdda1yRa283quL
 OziHYqM41rWAKUA8vPa86VbdZRAN1J6eVHWlgWhFcZP+TbUy8G505iDFMWgEeeFKKFSC
 xZEuB7xANye8+wsBUIaqydFkcS8fOhfwkLeBeO2taTofiyxhbc0g7Egafea3XzfTSuzE
 9cQQq2wbqLbIc7uQsNFijpoHV++LG8/JpWEMwn59ElTn5YtQT7Xv0rTMe1VPODD9b1x7 CA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 30r7f3hx1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 May 2020 12:03:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 041BqVcB079130;
        Fri, 1 May 2020 12:01:50 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 30r7f3swpd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 May 2020 12:01:50 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 041C1nXA023159;
        Fri, 1 May 2020 12:01:49 GMT
Received: from [192.168.1.102] (/39.109.243.230)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 01 May 2020 05:01:49 -0700
Subject: Re: [PATCH 3/3] btrfs: free alien device due to device add
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, dsterba@suse.com,
        nborisov@suse.com, josef@toxicpanda.com
References: <20200428152227.8331-1-anand.jain@oracle.com>
 <20200428152227.8331-4-anand.jain@oracle.com>
 <20200430133111.GL18421@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <af735fb7-e03d-b143-5eef-5b1b32c283bd@oracle.com>
Date:   Sat, 2 May 2020 04:01:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430133111.GL18421@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9607 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 phishscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005010093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9607 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=2
 phishscore=0 mlxlogscore=999 impostorscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005010094
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 30/4/20 9:31 pm, David Sterba wrote:
> On Tue, Apr 28, 2020 at 11:22:27PM +0800, Anand Jain wrote:
>> When the old device has new fsid through btrfs device add -f <dev> our
>> fs_devices list has an alien device in one of the fs_devices. So this is
>> a trigger and not the root cause of the issue. This patch fixes the trigger.
>>
>> By having an alien device in fs_devices, we have two issues so far
>>
>> 1. missing device is not shows as missing in the userland
>>
>> Which is due to cracks in the function btrfs_open_one_device() and
>> hardened by the pending patches in the ml.
>>   btrfs: remove identified alien device in open_fs_devices
>>   btrfs: remove identified alien btrfs device in open_fs_devices
>>
>> 2. mount of a degraded fs_devices fails
>>
>> Which is due to cracks in the function btrfs_free_extra_devids() and
>> hardened by patch (included in the set).
>>   btrfs: include non-missing as a qualifier for the latest_bdev
>>
>> Now the trigger for both of this issue is that there is an alien (does not
>> contain the intended fsid/btrfs_magic) device in the fs_devices.
>>
>> We know a device can be scanned/added through
>> btrfs-control::BTRFS_IOC_SCAN_DEV|BTRFS_IOC_DEVICES_READY
>> or by
>> ioctl::BTRFS_IOC_ADD_DEV
>>
>> And device coming through btrfs-control is checked against the all other
>> devices in btrfs kernel but not coming through BTRFS_IOC_ADD_DEV.
>>
>> This patch checks if the device add is alienating any other scanned
>> device and deletes it.
>>
>> In fact, this patch fixes both the issues 1 and 2 (above) by eliminating
>> the trigger of the issue, but still they have their own patch as well
>> because its the right way to harden the functions and fill the cracks.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>> v3-rebased: change log updated.
>>
>>   fs/btrfs/volumes.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index a67af16d960d..300ee5f0bfa2 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -2665,6 +2665,19 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>>   
>>   	/* Update ctime/mtime for libblkid */
>>   	update_dev_time(device_path);
>> +
>> +	/*
>> +	 * Now that we have written a new sb into this device, check all other
>> +	 * fs_devices list if it alienates any scanned device.
>> +	 */
>> +	mutex_lock(&uuid_mutex);
>> +	/*
>> +	 * Ignore the return as we are successfull in the core task - to added
>> +	 * the device
>> +	 */
>> +	btrfs_free_stale_devices(device_path, NULL);
> 
> So this is open coding btrfs_forget_devices, so the helper should be
> used.
> 

  Ah. I didn't notice that. Will fix.

> As there's NULL passed, 

  NULL is passed to the 2nd argument skip_device

> all stale devices will be removed from the list,

  No, It means it does not have any particular device to skip.
  Added device is already part of mounted fs_device list,
  the loop skips its check. So no need to skip_device.

> but we can remove just the device being added, no?

  It does exactly that.
  btrfs_free_stale_devices(device_path, NULL);

  It removes the device from all other fs_devices which are _unmounted_.

> And before the whole
> operation starts, not after. 

  What if the add fails? Then we have to add scanned device back to avoid
  that mess. why not remove after we have successfully add the device
  to the mounted fsid.

> The closest moment is before
> btrfs_commit_transaction, that's where the superblock gets overwritten.
> 

Thanks, Anand


>> +	mutex_unlock(&uuid_mutex);
>> +
>>   	return ret;
>>   
>>   error_sysfs:
>> -- 
>> 2.23.0
