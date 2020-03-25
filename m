Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9A4819228F
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Mar 2020 09:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgCYIXr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Mar 2020 04:23:47 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56756 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgCYIXr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Mar 2020 04:23:47 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02P8NM0C031967;
        Wed, 25 Mar 2020 08:23:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : message-id : date : mime-version : in-reply-to : content-type
 : content-transfer-encoding; s=corp-2020-01-29;
 bh=gVpszLb+BqKGJleokPyUph/EIaKvmEpqMZgiwZLBvoc=;
 b=0GDO3Li0W2MRy2ZlALqTHOZ257eaEoJjSUkoNCmK1b9Ji31hc3iTiDcYhAiFvWph8TCQ
 zSW1X5qg8PizQcaZBjL36sWycAtVPbbB6MI7iyXsuPWFYiSJfjX6T+Awvyz/j3JqaUFv
 bnxZIierB7kg2cQmLBtw4N1jBYD8eOPfvox20xN/D8UMFnVFcwaLBKaGCFWRUs1YTcOl
 pVqf/WaL0e0c0VWSGuF9ViQTjgdt63QBmsxjn682fwVXj82KyoXoLxeoyNFkW38YMKLI
 krBxE4NzTp39ZtgG6omJAE4Z8jvq0d/iBzmaXParcA5IkSDKhb0j3K0by+fhDjE4av+V Bg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2ywabr8dda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Mar 2020 08:23:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02P8LuqW036826;
        Wed, 25 Mar 2020 08:23:40 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2yxw945w7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Mar 2020 08:23:39 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02P8NcEW007773;
        Wed, 25 Mar 2020 08:23:38 GMT
Received: from [192.168.1.145] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 25 Mar 2020 01:23:38 -0700
Subject: Re: [PATCH] btrfs-progs: match the max chunk size to the kernel
From:   Anand Jain <anand.jain@oracle.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
        kreijack@inwind.it
References: <1583926429-28485-1-git-send-email-anand.jain@oracle.com>
 <7e91f1a2-cb34-1330-9a11-1edca8232d4c@gmx.com>
 <6b56d946-922f-c69f-a478-0f7f7244b98f@oracle.com>
Message-ID: <d8f32f65-70fc-cd18-bf20-e3569b396217@oracle.com>
Date:   Wed, 25 Mar 2020 16:23:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <6b56d946-922f-c69f-a478-0f7f7244b98f@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9570 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003250070
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9570 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003250070
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 3/12/20 7:12 PM, Anand Jain wrote:
> On 3/11/20 9:01 PM, Qu Wenruo wrote:
>>
>>
>> On 2020/3/11 下午7:33, Anand Jain wrote:
>>> For chunk type Single, %metadata_profile and %data_profile in
>>> create_raid_groups() is NULL, so we continue to use the initially
>>> created 8MB chunks for both metadata and data.
>>>
>>> 8MB is too small. Kernel default chunk size for type Single is 256MB.
>>> Further the mkfs.btrfs created chunk will stay unless relocated or
>>> cleanup during balance. Consider an ENOSPC case due to 8MB metadata
>>> full.
>>>
>>> I don't see any reason that mkfs.btrfs should create 8MB chunks for
>>> chunk type Single instead it could match it with the kernel allocation
>>> size of 256MB for the chunk type Single.
>>>
>>> For other chunk-types the create_one_raid_group() is called and creates
>>> the required bigger chunks and there is no change with this patch. Also
>>> for fs sizes (-b option) smaller than 256MB there is no issue as the
>>> chunks sizes are 10% of the requested fs-size until the maximum of
>>> 256MB.
>>>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>> ---
>>> The fio in generic/299 is failing to create the files which shall be
>>> deleted in the later part of the test case and the failure happens
>>> only with the MKFS_OPTIONS="-n64K -msingle" only and not with other 
>>> types
>>> of chunks. This is bit inconsistent. And it appears that in case of
>>> Single chunk type it fails to create (or touch) the necessary file
>>> as the metadata is full, so increasing the metadata chunk size to the
>>> sizes as kernel would create will add consistency.
>>
>> Have you tried all existing btrfs-progs test cases?
>> IIRC there are some minimal device related corner cases preventing us
>> from using larger default chunk size.
>>
> 

The test case which checks for the min-size is
   tests/mkfs-tests/010-minimal-size

Which depends on the mkfs to report the min size. Which in turn depends
on the function btrfs_min_dev_size() which does the static calculation
for the minimum size. IMO this can be updated to match with the kernel
allocations as its not a defined API.

But we are creating chunks in the userspace just to inform the kernel
about the user preferred chunk profile types (and Single profile gets
stuck at the initial temporary 8MB chunk).

Anyways I am recalling this patch as Goffredo is working [1] on
the way to communicate the user preferred profiles to the kernel,
which means there is no need to allocate the chunks in the userspace
so indirectly shall fix the single-chunk-size-inconsistency issue
between kernel and progs.

[1]
https://www.spinics.net/lists/linux-btrfs/msg99915.html

Thanks, Anand

>   I forgot btrfs-progs tests. Will run them.
> 
>> Despite that, for generic/299 error, I believe it should be more
>> appropriate to address the problem in ticket space system
> 
>   Agreed.
> 
>> other than
>> initial metadata chunk size.
> 
>> As btrfs can do metadata overcommit as long as we have enough
>> unallocated space, thus the initial chunk size should make minimal 
>> impact.
> 
>   IMO problem is if all the unallocated space has been occupied by
>   the data chunks leading to enospc for the metadata then we have an
>   imbalance which we didn't design in the kernel.
> 
>   To further debug enospc issues, the approach should be an ability to
>   tune chunk sizes on demand. Generally inconsistency makes debugging
>   more difficult. IMO it ok to fix the inconsistency in the chunk sizes.
> 
> Thanks, Anand
> 
>> But don't get me wrong, I'm pretty fine with the unified minimal chunk 
>> size.
>> Just don't believe it's the proper fix for your problem, and want to be
>> extra safe before we hit some strange problems.
>>
>> Thanks,
>> Qu
>>
>>>
>>>   volumes.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/volumes.c b/volumes.c
>>> index b46bf5988a95..d56f2fc897e3 100644
>>> --- a/volumes.c
>>> +++ b/volumes.c
>>> @@ -1004,7 +1004,7 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle 
>>> *trans,
>>>       struct list_head *cur;
>>>       struct map_lookup *map;
>>>       int min_stripe_size = SZ_1M;
>>> -    u64 calc_size = SZ_8M;
>>> +    u64 calc_size = SZ_256M;
>>>       u64 min_free;
>>>       u64 max_chunk_size = 4 * calc_size;
>>>       u64 avail = 0;
>>>
>>
> 
