Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB8129E221
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 03:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgJ2CJe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Oct 2020 22:09:34 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49660 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbgJ2CI3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Oct 2020 22:08:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09T26SS8143373;
        Thu, 29 Oct 2020 02:08:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=1CB5bHVYAp+K5FgfmxOkGiMgYqUK1KoIgsLFkDJEwlI=;
 b=RR2a2c7rLm18qWXjiwP07kVCMH7r3/zzgn6ToGeztO9j7lkIBDaLhp/uqy7Pf4mO46XC
 NLyCGUiaI56QpkeFqMt235xMspHnZLXUmmnb9lT32fcnkCPC/Xy3D4yDRQp/mOYonVJ2
 6C13v5HfBfb5Z1UMoYWeTGh+EGR7+wT2txsV7y3FX49fl4FzoQsPm5atiOVRkjEXQpLO
 Ia31FfC8TKtBjpGRUNcBf52PIkTOou5eK8KX77NxWbJvitzYaYqbdLItII40nKmWzt7E
 nhAcilnogiOM9DvLOfa9+XjbHjP5pOihWhm8Deua+c4js3x31+J6vTeAikf/WnYqcnyj tA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 34cc7m2eva-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Oct 2020 02:08:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09T26MSi005360;
        Thu, 29 Oct 2020 02:06:23 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 34cx1sp8yf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Oct 2020 02:06:23 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09T26CD8028040;
        Thu, 29 Oct 2020 02:06:12 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Oct 2020 19:06:12 -0700
Subject: Re: [PATCH RFC 4/4] btrfs: introduce new read_policy round-robin
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <cover.1603884539.git.anand.jain@oracle.com>
 <3ef863dea2d61ab41e5767ee935d5411c3117fa0.1603884539.git.anand.jain@oracle.com>
 <1c3a5069-45ce-fd91-1abd-4104095d2b12@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <fede66ab-5ca3-14e2-ec7e-5e14bcf011db@oracle.com>
Date:   Thu, 29 Oct 2020 10:06:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1c3a5069-45ce-fd91-1abd-4104095d2b12@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9788 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=2 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010290010
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9788 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=2
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010290010
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 28/10/20 10:44 pm, Josef Bacik wrote:
> On 10/28/20 9:26 AM, Anand Jain wrote:
>> Add round-robin read policy to route the read IO to the next device in 
>> the
>> round-robin order. The chunk allocation and thus the stripe-index follows
>> the order of free space available on devices. So to make the round-robin
>> effective it shall follow the devid order instead of the stripe-index
>> order.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> RFC: because I am not too sure if any workload or block layer
>> configurations shall suit round-robin read_policy.
>>
>>   fs/btrfs/sysfs.c   |  2 +-
>>   fs/btrfs/volumes.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++
>>   fs/btrfs/volumes.h |  2 ++
>>   3 files changed, 53 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
>> index d2a974e1a1c4..293311c79321 100644
>> --- a/fs/btrfs/sysfs.c
>> +++ b/fs/btrfs/sysfs.c
>> @@ -908,7 +908,7 @@ static bool btrfs_strmatch(const char *given, 
>> const char *golden)
>>   /* Must follow the order as in enum btrfs_read_policy */
>>   static const char * const btrfs_read_policy_name[] = { "pid", 
>> "latency",
>> -                               "device" };
>> +                               "device", "roundrobin" };
>>   static ssize_t btrfs_read_policy_show(struct kobject *kobj,
>>                         struct kobj_attribute *a, char *buf)
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 7ac675504051..fa1b1a3ebc87 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -5469,6 +5469,52 @@ int btrfs_is_parity_mirror(struct btrfs_fs_info 
>> *fs_info, u64 logical, u64 len)
>>       return ret;
>>   }
>> +struct stripe_mirror {
>> +    u64 devid;
>> +    int map;
>> +};
>> +
>> +static int btrfs_cmp_devid(const void *a, const void *b)
>> +{
>> +    struct stripe_mirror *s1 = (struct stripe_mirror *)a;
>> +    struct stripe_mirror *s2 = (struct stripe_mirror *)b;
>> +
>> +    if (s1->devid < s2->devid)
>> +        return -1;
>> +    if (s1->devid > s2->devid)
>> +        return 1;
>> +    return 0;
>> +}
>> +
>> +static int btrfs_find_read_round_robin(struct map_lookup *map, int 
>> first,
>> +                       int num_stripe)
>> +{
>> +    struct stripe_mirror stripes[4] = {0}; //4: for testing, works 
>> for now.
>> +    struct btrfs_fs_devices *fs_devices;
>> +    u64 devid;
>> +    int index, j, cnt;
>> +    int next_stripe;
>> +
>> +    index = 0;
>> +    for (j = first; j < first + num_stripe; j++) {
>> +        devid = map->stripes[j].dev->devid;
>> +
>> +        stripes[index].devid = devid;
>> +        stripes[index].map = j;
>> +
>> +        index++;
>> +    }
>> +
>> +    sort(stripes, num_stripe, sizeof(struct stripe_mirror),
>> +         btrfs_cmp_devid, NULL);
>> +
>> +    fs_devices = map->stripes[first].dev->fs_devices;
>> +    cnt = atomic_inc_return(&fs_devices->total_reads);
>> +    next_stripe = stripes[cnt % num_stripe].map;
> 
> This is heavy handed for policy decisions, just do something like
> 
> stripe_nr = atomic_inc_return(&fs_devices->total_reds) % num_stripes;
> return stripes[stripe_nr].map;
> 
> There's no reason to sort the stripes by devid every time we call this.  
> Thanks,


But that won't be round-robin at the device level, which I think we are
trying to achieve. It shall be round-robin at the strip level. As
stripe id isn't guaranteed to be on the same device across chunks.
Because chunk allocation follows the device free space size order.

But I agree the proposal in this patch is heavy. So I was thinking if we 
could fix the chunk allocation to sort by devid instead of size.? Any idea?

Thanks, Anand

> 
> Josef
