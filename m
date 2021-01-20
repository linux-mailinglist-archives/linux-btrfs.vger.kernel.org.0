Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF2F2FC834
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jan 2021 03:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731035AbhATCqk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jan 2021 21:46:40 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57990 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbhATCqC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jan 2021 21:46:02 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10K2e4jQ086267;
        Wed, 20 Jan 2021 02:45:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ow3GRI/oubic+4/dRbZ4Mxt5v/lk1kBXabfnw5xGEFs=;
 b=Rif+y0D/31al/DTRbptHY8r/E7H+ydmcrEcabv/wI/bQoHDag9gcGYCt14PAWpUQzryi
 2wSlCOgFqQuG6uuAyqrWW/OuVQbudWrKMrHFD8LmwU6DRRLajT7Wa6SRtdtJetEOFvl3
 8Hl1Z+fHlWqrXLFxRUzqfWmTWSkWxYHBHHjkQ2Wimp/gbu8C6wnRy+VRaQzc91JeztuF
 fOsuJJ9Hnsk99ScSEujpYY9tb49EZZmfNy4uG7pahaJtss+YtFnSnLfQUEVyXidQbP3T
 JPBDY6fMPX160oZGdCtSdSRNHQsvefU6Z8pVhqJ7Oa6Ac+ax/k8PLHshXbC0BUVPmJKV Gw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 3668qa8epm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 02:45:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10K2dheD042811;
        Wed, 20 Jan 2021 02:43:16 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 3668rc8j6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 02:43:16 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10K2hFRK001059;
        Wed, 20 Jan 2021 02:43:15 GMT
Received: from [192.168.10.137] (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Jan 2021 18:43:14 -0800
Subject: Re: [PATCH v3 1/4] btrfs: add read_policy latency
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <cover.1610324448.git.anand.jain@oracle.com>
 <64bb4905dc4b77e9fa22d8ba2635a36d15a33469.1610324448.git.anand.jain@oracle.com>
 <bf3eed32-6653-4151-85b6-1f249e601cf0@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <6df17b6b-d88e-93d6-5b6d-1cf026b0b402@oracle.com>
Date:   Wed, 20 Jan 2021 10:43:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <bf3eed32-6653-4151-85b6-1f249e601cf0@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9869 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101200014
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9869 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101200014
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 20/1/21 3:36 am, Josef Bacik wrote:
> On 1/11/21 4:41 AM, Anand Jain wrote:
>> The read policy type latency routes the read IO based on the historical
>> average wait-time experienced by the read IOs through the individual
>> device. This patch obtains the historical read IO stats from the kernel
>> block layer and calculates its average.
>>
>> Example usage:
>>   echo "latency" > /sys/fs/btrfs/$uuid/read_policy
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> v3: The block layer commit 0d02129e76ed (block: merge struct 
>> block_device and
>>      struct hd_struct) has changed the first argument in the function
>>      part_stat_read_all() in 5.11-rc1. So the compilation will fail. 
>> This patch
>>      fixes it.
>>      Commit log updated.
>>
>> v2: Use btrfs_debug_rl() instead of btrfs_info_rl()
>>      It is better we have this debug until we test this on at least few
>>      hardwares.
>>      Drop the unrelated changes.
>>      Update change log.
>>
>> v1: Drop part_stat_read_all instead use part_stat_read
>>      Drop inflight
>>
>>
>>   fs/btrfs/sysfs.c   |  3 ++-
>>   fs/btrfs/volumes.c | 38 ++++++++++++++++++++++++++++++++++++++
>>   fs/btrfs/volumes.h |  2 ++
>>   3 files changed, 42 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
>> index 19b9fffa2c9c..96ca7bef6357 100644
>> --- a/fs/btrfs/sysfs.c
>> +++ b/fs/btrfs/sysfs.c
>> @@ -915,7 +915,8 @@ static bool strmatch(const char *buffer, const 
>> char *string)
>>       return false;
>>   }
>> -static const char * const btrfs_read_policy_name[] = { "pid" };
>> +/* Must follow the order as in enum btrfs_read_policy */
>> +static const char * const btrfs_read_policy_name[] = { "pid", 
>> "latency" };
>>   static ssize_t btrfs_read_policy_show(struct kobject *kobj,
>>                         struct kobj_attribute *a, char *buf)
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index f4037a6bd926..f7a0a83d2cd4 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -14,6 +14,7 @@
>>   #include <linux/semaphore.h>
>>   #include <linux/uuid.h>
>>   #include <linux/list_sort.h>
>> +#include <linux/part_stat.h>
>>   #include "misc.h"
>>   #include "ctree.h"
>>   #include "extent_map.h"
>> @@ -5490,6 +5491,39 @@ int btrfs_is_parity_mirror(struct btrfs_fs_info 
>> *fs_info, u64 logical, u64 len)
>>       return ret;
>>   }
>> +static int btrfs_find_best_stripe(struct btrfs_fs_info *fs_info,
>> +                  struct map_lookup *map, int first,
>> +                  int num_stripe)
>> +{
>> +    u64 est_wait = 0;
>> +    int best_stripe = 0;
>> +    int index;
>> +
>> +    for (index = first; index < first + num_stripe; index++) {
>> +        u64 read_wait;
>> +        u64 avg_wait = 0;
>> +        unsigned long read_ios;
>> +        struct btrfs_device *device = map->stripes[index].dev;
>> +
>> +        read_wait = part_stat_read(device->bdev, nsecs[READ]);
>> +        read_ios = part_stat_read(device->bdev, ios[READ]);
>> +
>> +        if (read_wait && read_ios && read_wait >= read_ios)
>> +            avg_wait = div_u64(read_wait, read_ios);
>> +        else
>> +            btrfs_debug_rl(device->fs_devices->fs_info,
> 
> You can just use fs_info here, you already have it.  I'm not in love 
> with doing this check every time, I'd rather cache the results 
> somewhere.  However if we're read-only I can't think of a mechanism we 
> could piggy back on, RW we could just do it every transaction commit.  
> Fix the fs_info thing and you can add
> 

  Oh. I will fix it. Thanks for the review here and in other patches.
-Anand

> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> 
> Thanks,
> 
> Josef

