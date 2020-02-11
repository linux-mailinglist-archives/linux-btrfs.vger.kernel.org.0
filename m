Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 983EF158B43
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2020 09:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbgBKIb7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Feb 2020 03:31:59 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:53078 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727578AbgBKIb7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Feb 2020 03:31:59 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01B8SLmu089672;
        Tue, 11 Feb 2020 08:31:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Qe+njH+SeoezKPVk8h5odBVAN0wl8ao3iLVYDIODdKw=;
 b=UZk90J8xTx4mJ8nxqygvgjJZNXLNJydqbgBz1ivFCYPh+KwISvz8eIqEc0o0bjB0YRVf
 RyO2YxunFA/sOHOMl5ZiUh5JN2lDPdMA3ZHVgbJvaHhH9vWx1HWqu4T+/OO/BlYj6isr
 agD9+xBEBqMQ7iRvql0r2QkM8lDtabo5KUnp0rfhX0A6q7VxvDcfzPDl2G7CTDJeHtlN
 UQa/eD35hHyYI6fHonbS3fgM44ftdQKY2v2wk1WI6cdrg+WfXIfDVssX+zaIojPgryt0
 S8F8V3R3TEwpOgaDV+v/PvU+IzBLO3hOObbg3vKQU2XIar++YX75itRsd/To6XM0Wx5C dQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2y2k881pfu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Feb 2020 08:31:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01B8QwVw017758;
        Tue, 11 Feb 2020 08:31:40 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2y26fgrfrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Feb 2020 08:31:40 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01B8Vc2v022600;
        Tue, 11 Feb 2020 08:31:38 GMT
Received: from [192.168.1.145] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Feb 2020 00:31:38 -0800
Subject: Re: [PATCH 1/2] btrfs: add read_policy framework
To:     dsterba@suse.cz
References: <20200105151402.1440-1-anand.jain@oracle.com>
 <20200105151402.1440-2-anand.jain@oracle.com>
 <20200129182623.GL3929@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
        btrfs-list@steev.me.uk
Message-ID: <140500ce-c245-1608-474b-772e51326eb8@oracle.com>
Date:   Tue, 11 Feb 2020 16:31:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200129182623.GL3929@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9527 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=1
 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002110063
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9527 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 suspectscore=1 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 impostorscore=0 clxscore=1011 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002110063
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/30/20 2:26 AM, David Sterba wrote:
> On Sun, Jan 05, 2020 at 11:14:01PM +0800, Anand Jain wrote:
>> As of now we use %pid method to read stripped mirrored data, which means
>> application's process id determines the stripe id to be read. This type
>> of read IO routing typically helps in a system with many small
>> independent applications tying to read random data. On the other hand
>> the %pid based read IO distribution policy is inefficient because if
>> there is a single application trying to read large data the overall disk
>> bandwidth remains under-utilized.
> 
> AFAIK it's not always the application pid, for compression or metadata
> it's the pid of btrfs worker thread. So it depends.
> 
>> So this patch introduces read policy framework so that we could add more
>> read policies, such as IO routing based on device's wait-queue or manual
>> when we have a read-preferred device or a policy based on the target
>> storage caching.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> [Patch name changed]
>>
>> v3: Declare fs_devices::readmirror as enum btrfs_readmirror_policy_type
>> v2: Declare fs_devices::readmirror as u8 instead of atomic_t
>>      A small change in comment and change log wordings.
>>
>>   fs/btrfs/volumes.c | 16 +++++++++++++++-
>>   fs/btrfs/volumes.h |  9 +++++++++
>>   2 files changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index c95e47aa84f8..2ffffdf1d314 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -1162,6 +1162,8 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
>>   	fs_devices->opened = 1;
>>   	fs_devices->latest_bdev = latest_dev->bdev;
>>   	fs_devices->total_rw_bytes = 0;
>> +	/* Set the default read policy */
> 
> You can drop this comment
> 
>> +	fs_devices->read_policy = BTRFS_READ_POLICY_DEFAULT;
>>   out:
>>   	return ret;
>>   }
>> @@ -5300,7 +5302,19 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
>>   	else
>>   		num_stripes = map->num_stripes;
>>   
>> -	preferred_mirror = first + current->pid % num_stripes;
>> +	switch (fs_info->fs_devices->read_policy) {
>> +	case BTRFS_READ_BY_PID:
>> +		preferred_mirror = first + current->pid % num_stripes;
>> +		break;
>> +	default:
>> +		/*
>> +		 * Shouln't happen, just warn and use by_pid instead of failing.
>> +		 */
>> +		btrfs_warn_rl(fs_info,
>> +			      "unknown read_policy type %u, fallback to by_pid",
>> +			      fs_info->fs_devices->read_policy);
>> +		preferred_mirror = first + current->pid % num_stripes;
> 
> This is repeating the BY_PID code, please move the defaut: case above it
> so the code is shared.
> 
>> +	}
>>   
>>   	if (dev_replace_is_ongoing &&
>>   	    fs_info->dev_replace.cont_reading_from_srcdev_mode ==
>> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
>> index 68021d1ee216..3bbf0e51433f 100644
>> --- a/fs/btrfs/volumes.h
>> +++ b/fs/btrfs/volumes.h
>> @@ -209,6 +209,13 @@ BTRFS_DEVICE_GETSET_FUNCS(total_bytes);
>>   BTRFS_DEVICE_GETSET_FUNCS(disk_total_bytes);
>>   BTRFS_DEVICE_GETSET_FUNCS(bytes_used);
>>   
>> +/* read_policy types */
> 
> More explanation would be nice
> 
>> +#define BTRFS_READ_POLICY_DEFAULT	BTRFS_READ_BY_PID
> 
> Add this to the enums so we don't have mixed enums and defines
> 
>> +enum btrfs_read_policy_type {
> 
> I think you can drop _type here, the 'enum' must be spelled everywhere
> is used so the type name can be shorter without losing descriptivity.
> 
>> +	BTRFS_READ_BY_PID,
> 
> This should share the namespace so, BTRFS_READ_POLICY_PID
> 
>> +	BTRFS_NR_READ_POLICY_TYPE,
>> +};
>> +
>>   struct btrfs_fs_devices {
>>   	u8 fsid[BTRFS_FSID_SIZE]; /* FS specific uuid */
>>   	u8 metadata_uuid[BTRFS_FSID_SIZE];
>> @@ -260,6 +267,8 @@ struct btrfs_fs_devices {
>>   	struct kobject *devices_kobj;
>>   	struct kobject *devinfo_kobj;
>>   	struct completion kobj_unregister;
>> +
>> +	enum btrfs_read_policy_type read_policy;
> 

  All the comments above are accepted. Thanks.

> What's the reason to add this to btrfs_fs_devices rather than to
> btrfs_fs_info? The lifetime of the policy and the related sysfs object
> is the same as of the mounted filesystem.

   Reasons to choose struct btrfs_fs_devices instead of struct
   btrfs_fs_info:
   Theoretically:
     - Its about the device and most of our device related stuffs
       including dev_state is in struct btrfs_devices in volumes.h
       (read_policy::by_devid (new patch not in ML yet) uses dev_state).
     - The core of the read_policy which is in find_live_mirror() is also
       in volumes.h
     - enum btrfs_read_policy is also in volumes.h

   If at some point we decide to make read_policy persistent, which then
   open_ctree() would read the relevant item and update the
   btrfs_fs_devices::read_policy. If read_policy is persistent (at some
   point), then we should apply the stored policy even if its a seed
   device and the only place where we can apply it is fs_device.
   Being theoretically correct pays off.

Thanks, Anand


> 
>>   };
>>   
>>   #define BTRFS_BIO_INLINE_CSUM_SIZE	64

