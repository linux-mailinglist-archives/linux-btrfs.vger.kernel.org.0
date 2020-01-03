Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83DF812F670
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2020 10:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbgACJ53 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jan 2020 04:57:29 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:41800 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgACJ53 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Jan 2020 04:57:29 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0039tCRW173035;
        Fri, 3 Jan 2020 09:57:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=TuVuN3o4/scRb6BqMqjrqUmN8GhLqJFV3GRv0MmL+7s=;
 b=FGtKG8LYSofJ8GuONvqlAm4+j6ZV/htGhdGMBP+orJ6vFfXL3gV7VTYBOvFbdv2SE9EC
 xoYUwufBmDWEevWJ6d47gaNnJY/NDb94yhVf0+4VnYzKto37m5NOenpPkKT0PG1f8kth
 2xsDln+TkIhCeG9fagKvcQYK55Abrm3nJGF/izWfslSQU+xlpcmshKjg8++PyQ2lUNfv
 3eQtoWYZMe/RujkIdAbSeC/qK/dvgmQQ1PKtPBH0XUATBypTqf97J7zjoQBBeCi25EUi
 PAQPjpo6WjW5bxCR+kzwrmKyYRcEly2/xLcSKeMhcfat1YiSEinrTayveowxF73+AMKN vg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2x5y0puk8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Jan 2020 09:57:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0039siDk041472;
        Fri, 3 Jan 2020 09:57:27 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2x8guwh6m9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Jan 2020 09:57:26 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0039vPcF021234;
        Fri, 3 Jan 2020 09:57:25 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 Jan 2020 01:57:25 -0800
Subject: Re: [PATCH v2 1/3] btrfs: add readmirror type framework
To:     Josef Bacik <josef@toxicpanda.com>
References: <1577959968-19427-1-git-send-email-anand.jain@oracle.com>
 <1577959968-19427-2-git-send-email-anand.jain@oracle.com>
 <e6585b93-a585-15e1-ea2a-de6279c317a8@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <4abd93cc-eb99-d977-ba48-2754b15390bd@oracle.com>
Date:   Fri, 3 Jan 2020 17:57:16 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e6585b93-a585-15e1-ea2a-de6279c317a8@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9488 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001030094
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9488 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001030094
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 3/1/20 12:24 AM, Josef Bacik wrote:
> On 1/2/20 5:12 AM, Anand Jain wrote:
>> As of now we use %pid method to read stripped mirrored data. So
>> application's process id determines the stripe id to be read. This type
>> of read IO routing typically helps in a system with many small
>> independent applications tying to read random data. On the other hand
>> the %pid based read IO distribution policy is inefficient if there is a
>> single application trying to read large data and the overall disk
>> bandwidth remains under utilized.
>>
>> So this patch introduces a framework where we could add more readmirror
>> policies, such as routing the IO based on device's wait-queue or manual
>> when we have a read-preferred device or a policy based on the target
>> storage caching.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> v2: Declare fs_devices::readmirror as u8 instead of atomic_t
>>      A small change in comment and change log wordings.
>>
>>   fs/btrfs/volumes.c | 16 +++++++++++++++-
>>   fs/btrfs/volumes.h |  8 ++++++++
>>   2 files changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index c95e47aa84f8..e26af766f2b9 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -1162,6 +1162,8 @@ static int open_fs_devices(struct 
>> btrfs_fs_devices *fs_devices,
>>       fs_devices->opened = 1;
>>       fs_devices->latest_bdev = latest_dev->bdev;
>>       fs_devices->total_rw_bytes = 0;
>> +    /* Set the default readmirror policy */
>> +    fs_devices->readmirror = BTRFS_READMIRROR_DEFAULT;
>>   out:
>>       return ret;
>>   }
>> @@ -5300,7 +5302,19 @@ static int find_live_mirror(struct 
>> btrfs_fs_info *fs_info,
>>       else
>>           num_stripes = map->num_stripes;
>> -    preferred_mirror = first + current->pid % num_stripes;
>> +    switch (fs_info->fs_devices->readmirror) {
>> +    case BTRFS_READMIRROR_BY_PID:
>> +        preferred_mirror = first + current->pid % num_stripes;
>> +        break;
>> +    default:
>> +        /*
>> +         * Shouln't happen, just warn and use by_pid instead of failing.
>> +         */
>> +        btrfs_warn_rl(fs_info,
>> +                  "unknown readmirror type %u, fallback to by_pid",
>> +                  fs_info->fs_devices->readmirror);
>> +        preferred_mirror = first + current->pid % num_stripes;
>> +    }
>>       if (dev_replace_is_ongoing &&
>>           fs_info->dev_replace.cont_reading_from_srcdev_mode ==
>> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
>> index 68021d1ee216..f5f091f3c72b 100644
>> --- a/fs/btrfs/volumes.h
>> +++ b/fs/btrfs/volumes.h
>> @@ -209,6 +209,12 @@ struct btrfs_device {
>>   BTRFS_DEVICE_GETSET_FUNCS(disk_total_bytes);
>>   BTRFS_DEVICE_GETSET_FUNCS(bytes_used);
>> +/* readmirror_policy types */
>> +#define BTRFS_READMIRROR_DEFAULT    BTRFS_READMIRROR_BY_PID
>> +enum btrfs_readmirror_policy_type {
>> +    BTRFS_READMIRROR_BY_PID,
>> +};
>> +
>>   struct btrfs_fs_devices {
>>       u8 fsid[BTRFS_FSID_SIZE]; /* FS specific uuid */
>>       u8 metadata_uuid[BTRFS_FSID_SIZE];
>> @@ -260,6 +266,8 @@ struct btrfs_fs_devices {
>>       struct kobject *devices_kobj;
>>       struct kobject *devinfo_kobj;
>>       struct completion kobj_unregister;
>> +
>> +    u8 readmirror;
> 
> The only valid values for this are the enum, so make this
> 
> enum btrfs_readmirror_policy_type readmirror;

  Oh. Ok.

Thanks, Anand


> Thanks,
> 
> Josef
