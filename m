Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85CEE29DFF8
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 02:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404159AbgJ2BHJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Oct 2020 21:07:09 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56896 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404153AbgJ2BGg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Oct 2020 21:06:36 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09T167Ax049784;
        Thu, 29 Oct 2020 01:06:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=geFD89bjoVhJmsGSoaEuN22CjFjHdeC6lEvFl97L1eM=;
 b=hh103+5oH2kzrQZJoG735DvQRSTyZ+PhPvmhs5dBsc2siWY42F0twACxB2AYmE8kzJ2b
 WuA5b/CgtZsTN5kqofqxKzvueLo9xvFimiyF74Z8qS9+RnxZIbXO2TecXFzZiTZqdSjY
 hnXGzG4aArPAIP9IJFTIc0Y7YDpwEcDHFZOtYWELoDUEycuzkI2UhP6zpg8meLtCy96M
 mkTnIsi79DgWd1yJD4t8kvkiEg4v50qSTN0O4Bj/NK308wg8bQ/Bzc5X/kTILUeHEVFQ
 OFXcRw7chqQEjKHnjCCtcCwY9T/DWD0RDysKmPmoFsA3B8Lt26VAaJAfnF6YqlGgXIxd Dg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 34dgm47y94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Oct 2020 01:06:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09T15Ojx091072;
        Thu, 29 Oct 2020 01:06:30 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 34cx6xw1pt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Oct 2020 01:06:30 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09T16SBJ022786;
        Thu, 29 Oct 2020 01:06:28 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Oct 2020 18:06:27 -0700
Subject: Re: [PATCH 1/4] btrfs: add read_policy latency
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <cover.1603884539.git.anand.jain@oracle.com>
 <ae5e526c1549d4e6f602c09d8235aa406c5a1404.1603884539.git.anand.jain@oracle.com>
 <77b4e2b8-da2f-b539-76e3-881046ee9101@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <faf72f7e-aa1d-8c2a-de4f-f250b909b25d@oracle.com>
Date:   Thu, 29 Oct 2020 09:06:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <77b4e2b8-da2f-b539-76e3-881046ee9101@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9788 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010290002
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9788 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010290002
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 28/10/20 10:30 pm, Josef Bacik wrote:
> On 10/28/20 9:26 AM, Anand Jain wrote:
>> The read policy type latency routes the read IO based on the historical
>> average wait time experienced by the read IOs through the individual
>> device factored by 1/10 of inflight commands in the queue. The factor
>> 1/10 is because generally the block device queue depth is more than 1,
>> so there can be commands in the queue even before the previous commands
>> have been completed. This patch obtains the historical read IO stats from
>> the kernel block layer.

Oops I need to fix the change log.

>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> v1: Drop part_stat_read_all instead use part_stat_read
>>      Drop inflight
>>   fs/btrfs/sysfs.c   |  3 ++-
>>   fs/btrfs/volumes.c | 39 ++++++++++++++++++++++++++++++++++++++-
>>   fs/btrfs/volumes.h |  1 +
>>   3 files changed, 41 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
>> index 4dbf90ff088a..88cbf7b2edf0 100644
>> --- a/fs/btrfs/sysfs.c
>> +++ b/fs/btrfs/sysfs.c
>> @@ -906,7 +906,8 @@ static bool btrfs_strmatch(const char *given, 
>> const char *golden)
>>       return false;
>>   }
>> -static const char * const btrfs_read_policy_name[] = { "pid" };
>> +/* Must follow the order as in enum btrfs_read_policy */
>> +static const char * const btrfs_read_policy_name[] = { "pid", 
>> "latency" };
>>   static ssize_t btrfs_read_policy_show(struct kobject *kobj,
>>                         struct kobj_attribute *a, char *buf)
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 6bf487626f23..48587009b656 100644
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
>> @@ -5468,6 +5469,39 @@ int btrfs_is_parity_mirror(struct btrfs_fs_info 
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
>> +        read_wait = part_stat_read(device->bdev->bd_part, nsecs[READ]);
>> +        read_ios = part_stat_read(device->bdev->bd_part, ios[READ]);
>> +
>> +        if (read_wait && read_ios && read_wait >= read_ios)
>> +            avg_wait = div_u64(read_wait, read_ios);
>> +        else
>> +            btrfs_info_rl(device->fs_devices->fs_info,
>> +            "devid: %llu avg_wait ZERO read_wait %llu read_ios %lu",
>> +                      device->devid, read_wait, read_ios);
> 
> Do we even care about this?  I feel like if we do at all it can be 
> btrfs_debug or something.

  Yeah I think btrfs_debug is better until we cover most the hardware?

> 
>> +
>> +        if (est_wait == 0 || est_wait > avg_wait) {
>> +            est_wait = avg_wait;
>> +            best_stripe = index;
>> +        }
>> +    }
>> +
>> +    return best_stripe;
>> +}
>> +
>>   static int find_live_mirror(struct btrfs_fs_info *fs_info,
>>                   struct map_lookup *map, int first,
>>                   int dev_replace_is_ongoing)
>> @@ -5498,6 +5532,10 @@ static int find_live_mirror(struct 
>> btrfs_fs_info *fs_info,
>>       case BTRFS_READ_POLICY_PID:
>>           preferred_mirror = first + current->pid % num_stripes;
>>           break;
>> +    case BTRFS_READ_POLICY_LATENCY:
>> +        preferred_mirror = btrfs_find_best_stripe(fs_info, map, first,
>> +                              num_stripes);
>> +        break;
>>       }
>>       if (dev_replace_is_ongoing &&
>> @@ -6114,7 +6152,6 @@ static int __btrfs_map_block(struct 
>> btrfs_fs_info *fs_info,
>>       } else if (map->type & BTRFS_BLOCK_GROUP_RAID10) {
>>           u32 factor = map->num_stripes / map->sub_stripes;
>> -
> 
> Unrelated change.  Thanks,

Oops. Thanks You I will fix.

Anand

> 
> Josef
