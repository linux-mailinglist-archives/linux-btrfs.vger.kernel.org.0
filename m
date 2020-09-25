Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7650D277ED9
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Sep 2020 06:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgIYERj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Sep 2020 00:17:39 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47726 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgIYERj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Sep 2020 00:17:39 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08P4GXlC189604;
        Fri, 25 Sep 2020 04:17:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=V+jb8mf+feV/R4tp711eSIHV8HypUcIu9cLItDM6cX8=;
 b=w9qQAV+uWO7qyw7hPfRGV3fCdxb+6y1bZSWxNgezoUwmWZfONDYsPRUGMOlLUJLF1YKT
 t0RuzcuCRhKXtI1oDnsp+7wZSm/mPF+/uPMjqIQmYfmVVZ+swTrk5cfe9FfUnX8XjDBc
 oTc/9pCSbEYqhyd1s0Q6HLlh0ahOtiCA0w+Q8Pi2VnMB9Q4Mjr2346NqThwXE0rBhOQi
 xJRzN1NASzODliNwejQ5eDt4Ardtrs5rOLojYFiWLfB4yn9sEEVSsjjiQwkjHczf9k/c
 /iRxYhJtBra0MkcN4kWsFQBQULv5UWqNwz+MbU9FoEfwUab9qUI292Jk3T37fOxnBhl+ tg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 33q5rgsw3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Sep 2020 04:17:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08P4ASb6126919;
        Fri, 25 Sep 2020 04:17:34 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 33s75jb9bk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Sep 2020 04:17:34 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08P4HXGM009601;
        Fri, 25 Sep 2020 04:17:33 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Sep 2020 21:17:32 -0700
Subject: Re: [PATCH 1/2] btrfs: drop never met condition of disk_total_bytes
 == 0
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Cc:     wqu@suse.com, dsterba@suse.com
References: <cover.1600940809.git.anand.jain@oracle.com>
 <4fea8a706aedf7407d6af7a545126511168e15f5.1600940809.git.anand.jain@oracle.com>
 <c9e538dd-c039-478c-d677-0e9dd95cfc39@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <bed38208-67ff-ac66-187e-7e8ad91e1968@oracle.com>
Date:   Fri, 25 Sep 2020 12:17:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <c9e538dd-c039-478c-d677-0e9dd95cfc39@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009250028
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 impostorscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009250028
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 24/9/20 7:48 pm, Nikolay Borisov wrote:
> 
> 
> On 24.09.20 г. 13:11 ч., Anand Jain wrote:
>> btrfs_device::disk_total_bytes is set even for a seed device (the
>> comment is wrong).
>>
>> The function fill_device_from_item() does the job of reading it from the
>> item and updating btrfs_device::disk_total_bytes. So both the missing
>> device and the seed devices do have their disk_total_bytes updated.
>>
>> So this patch removes the check dev->disk_total_bytes == 0 in the
>> function verify_one_dev_extent()
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/volumes.c | 15 ---------------
>>   1 file changed, 15 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 7f43ed88fffc..9be40eece8ed 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -7578,21 +7578,6 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
>>   		goto out;
>>   	}
>>   
>> -	/* It's possible this device is a dummy for seed device */
>> -	if (dev->disk_total_bytes == 0) {
>> -		struct btrfs_fs_devices *devs;
>> -
>> -		devs = list_first_entry(&fs_info->fs_devices->seed_list,
>> -					struct btrfs_fs_devices, seed_list);
>> -		dev = btrfs_find_device(devs, devid, NULL, NULL, false);
>> -		if (!dev) {
>> -			btrfs_err(fs_info, "failed to find seed devid %llu",
>> -				  devid);
>> -			ret = -EUCLEAN;
>> -			goto out;
>> -		}
>> -	}
> 
> The commit which introduced this check states that the device with a
> disk_total_bytes = 0 occurs from clone_fs_devices called from open_seed.
> It seems the check is legit and your changelog doesn't account for that
> if it's safe you should provide description why is that.

yes the commit 1b3922a8bc74 (btrfs: Use real device structure to verify 
dev extent) introduced it. In Qu's analysis, it is unclear why the 
total_disk_bytes was 0.

Theoretically, all devices (including missing and seed) marked with the 
BTRFS_DEV_STATE_IN_FS_METADATA flag gets the total_disk_bytes updated at 
fill_device_from_item().

open_ctree()
  btrfs_read_chunk_tree()
   read_one_dev()
    open_seed_device()
    fill_device_from_item()

Even if verify_one_dev_extent() reports total_disk_bytes == 0, then IMO 
its a bug to be fixed somewhere else and not in verify_one_dev_extent() 
as it's just a messenger. It is never expected that a total_disk_bytes 
shall be zero.

So it is fine to drop the total_disk_bytes == 0 check.

Thanks, Anand



> 
>> -
>>   	if (physical_offset + physical_len > dev->disk_total_bytes) {
>>   		btrfs_err(fs_info,
>>   "dev extent devid %llu physical offset %llu len %llu is beyond device boundary %llu",
>>
