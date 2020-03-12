Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12B7D182EB7
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Mar 2020 12:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgCLLM5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Mar 2020 07:12:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53994 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgCLLM5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Mar 2020 07:12:57 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CB9SFt141568;
        Thu, 12 Mar 2020 11:12:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=qKdyQtwH06zDV/8ZFUlmdfcQZ5Rnfl1TYNwky1GvDS4=;
 b=v1UEU2CMamqMAjOGflj3v74J+SsTqAfyXvSoG93TXsf/abU4MHsLBoWgWEXNll05lYPH
 WDtSDV0R9HFjaXPd68puM2tKv/PS8xOzjk0OEyp+R+vF4zwpCj87fLBG+V9o13BeIaHA
 HKB87/LCMKGMKxT3VnQhmXy258je6jDTNwRCHCmFln9vA6a6GS93NvWHoJG//Yyi6TEo
 feL6LRleC0WCUKGKAn/EvMR0FpcwqNQD9nFF3JC/d0aYPJ3y9GdSa0Wy1sqDuyDgmqVv
 gKtpNBeuesu5VRe4R+oZe/aKJFRXZ2QE2PGwfJsxW7I/mJUF4lOh8CzHZls0C8vkNJgU 4Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2yqkg884u8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 11:12:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CBCA6j058379;
        Thu, 12 Mar 2020 11:12:53 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2yqgvcph4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 11:12:53 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02CBCpds004973;
        Thu, 12 Mar 2020 11:12:52 GMT
Received: from [192.168.1.145] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Mar 2020 04:12:50 -0700
Subject: Re: [PATCH] btrfs-progs: match the max chunk size to the kernel
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <1583926429-28485-1-git-send-email-anand.jain@oracle.com>
 <7e91f1a2-cb34-1330-9a11-1edca8232d4c@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <6b56d946-922f-c69f-a478-0f7f7244b98f@oracle.com>
Date:   Thu, 12 Mar 2020 19:12:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <7e91f1a2-cb34-1330-9a11-1edca8232d4c@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9557 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=2 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120061
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9557 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 suspectscore=2 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120060
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/11/20 9:01 PM, Qu Wenruo wrote:
> 
> 
> On 2020/3/11 下午7:33, Anand Jain wrote:
>> For chunk type Single, %metadata_profile and %data_profile in
>> create_raid_groups() is NULL, so we continue to use the initially
>> created 8MB chunks for both metadata and data.
>>
>> 8MB is too small. Kernel default chunk size for type Single is 256MB.
>> Further the mkfs.btrfs created chunk will stay unless relocated or
>> cleanup during balance. Consider an ENOSPC case due to 8MB metadata
>> full.
>>
>> I don't see any reason that mkfs.btrfs should create 8MB chunks for
>> chunk type Single instead it could match it with the kernel allocation
>> size of 256MB for the chunk type Single.
>>
>> For other chunk-types the create_one_raid_group() is called and creates
>> the required bigger chunks and there is no change with this patch. Also
>> for fs sizes (-b option) smaller than 256MB there is no issue as the
>> chunks sizes are 10% of the requested fs-size until the maximum of
>> 256MB.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> The fio in generic/299 is failing to create the files which shall be
>> deleted in the later part of the test case and the failure happens
>> only with the MKFS_OPTIONS="-n64K -msingle" only and not with other types
>> of chunks. This is bit inconsistent. And it appears that in case of
>> Single chunk type it fails to create (or touch) the necessary file
>> as the metadata is full, so increasing the metadata chunk size to the
>> sizes as kernel would create will add consistency.
> 
> Have you tried all existing btrfs-progs test cases?
> IIRC there are some minimal device related corner cases preventing us
> from using larger default chunk size.
> 

  I forgot btrfs-progs tests. Will run them.

> Despite that, for generic/299 error, I believe it should be more
> appropriate to address the problem in ticket space system

  Agreed.

> other than
> initial metadata chunk size.

> As btrfs can do metadata overcommit as long as we have enough
> unallocated space, thus the initial chunk size should make minimal impact.

  IMO problem is if all the unallocated space has been occupied by
  the data chunks leading to enospc for the metadata then we have an
  imbalance which we didn't design in the kernel.

  To further debug enospc issues, the approach should be an ability to
  tune chunk sizes on demand. Generally inconsistency makes debugging
  more difficult. IMO it ok to fix the inconsistency in the chunk sizes.

Thanks, Anand

> But don't get me wrong, I'm pretty fine with the unified minimal chunk size.
> Just don't believe it's the proper fix for your problem, and want to be
> extra safe before we hit some strange problems.
> 
> Thanks,
> Qu
> 
>>
>>   volumes.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/volumes.c b/volumes.c
>> index b46bf5988a95..d56f2fc897e3 100644
>> --- a/volumes.c
>> +++ b/volumes.c
>> @@ -1004,7 +1004,7 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
>>   	struct list_head *cur;
>>   	struct map_lookup *map;
>>   	int min_stripe_size = SZ_1M;
>> -	u64 calc_size = SZ_8M;
>> +	u64 calc_size = SZ_256M;
>>   	u64 min_free;
>>   	u64 max_chunk_size = 4 * calc_size;
>>   	u64 avail = 0;
>>
> 

