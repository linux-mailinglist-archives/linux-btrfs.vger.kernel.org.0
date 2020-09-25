Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFA92781B3
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Sep 2020 09:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgIYHda (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Sep 2020 03:33:30 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:55176 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbgIYHd3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Sep 2020 03:33:29 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08P7Tkbn062998;
        Fri, 25 Sep 2020 07:33:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=oCHjgckWROMNHjWCvE9FIxS4RP5vWdrMJp4URc6parQ=;
 b=ilQ/DGcAC65NOFI4ug1PiueUMJ1c9oo55MD0xLtYaFCOpnpEVrG3sWj7ewc+lpxT/+8j
 ztQsY2JlodC9IKlUUvs8mhSpx7skjxl6pidNrwb2VHAaWWr9Uc4qjAin+0WwJUJCocEt
 xU1Aa9T/QsmlS5Yw07gleBv2wW/6068xH9hX+ZfLVy89ZD9b6SNiezoJwalmJDX3Nfev
 iZPNX2veAPF7EwbyQx5q8r/BOoTJRSgaVrIc2NQeZgkVeJZsJXwHyqLJbfb5b6MLtDP5
 YtOdaTjNXZJbiKptfy5EkcrqArOwqHwT3JVeUQG27sY2kg++6+TFKzL1vnTt2/Haqavt KA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 33qcpu90c4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Sep 2020 07:33:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08P7QUq5118454;
        Fri, 25 Sep 2020 07:33:25 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 33s75jgwt3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Sep 2020 07:33:24 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08P7XNwT009037;
        Fri, 25 Sep 2020 07:33:24 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Sep 2020 00:33:23 -0700
Subject: Re: [PATCH 1/2] btrfs: drop never met condition of disk_total_bytes
 == 0
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Cc:     wqu@suse.com, dsterba@suse.com
References: <cover.1600940809.git.anand.jain@oracle.com>
 <4fea8a706aedf7407d6af7a545126511168e15f5.1600940809.git.anand.jain@oracle.com>
 <c9e538dd-c039-478c-d677-0e9dd95cfc39@suse.com>
 <bed38208-67ff-ac66-187e-7e8ad91e1968@oracle.com>
 <b7c8399b-e410-8748-d1f3-f8603a8980ae@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <e8b066ae-8436-d8b1-049b-2eb83ff47da4@oracle.com>
Date:   Fri, 25 Sep 2020 15:33:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <b7c8399b-e410-8748-d1f3-f8603a8980ae@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009250049
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009250049
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 25/9/20 2:19 pm, Nikolay Borisov wrote:
> 
> 
> On 25.09.20 г. 7:17 ч., Anand Jain wrote:
>>
>>
>> On 24/9/20 7:48 pm, Nikolay Borisov wrote:
>>>
>>>
>>> On 24.09.20 г. 13:11 ч., Anand Jain wrote:
>>>> btrfs_device::disk_total_bytes is set even for a seed device (the
>>>> comment is wrong).
>>>>
>>>> The function fill_device_from_item() does the job of reading it from the
>>>> item and updating btrfs_device::disk_total_bytes. So both the missing
>>>> device and the seed devices do have their disk_total_bytes updated.
>>>>
>>>> So this patch removes the check dev->disk_total_bytes == 0 in the
>>>> function verify_one_dev_extent()
>>>>
>>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>>> ---
>>>>    fs/btrfs/volumes.c | 15 ---------------
>>>>    1 file changed, 15 deletions(-)
>>>>
>>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>>> index 7f43ed88fffc..9be40eece8ed 100644
>>>> --- a/fs/btrfs/volumes.c
>>>> +++ b/fs/btrfs/volumes.c
>>>> @@ -7578,21 +7578,6 @@ static int verify_one_dev_extent(struct
>>>> btrfs_fs_info *fs_info,
>>>>            goto out;
>>>>        }
>>>>    -    /* It's possible this device is a dummy for seed device */
>>>> -    if (dev->disk_total_bytes == 0) {
>>>> -        struct btrfs_fs_devices *devs;
>>>> -
>>>> -        devs = list_first_entry(&fs_info->fs_devices->seed_list,
>>>> -                    struct btrfs_fs_devices, seed_list);
>>>> -        dev = btrfs_find_device(devs, devid, NULL, NULL, false);
>>>> -        if (!dev) {
>>>> -            btrfs_err(fs_info, "failed to find seed devid %llu",
>>>> -                  devid);
>>>> -            ret = -EUCLEAN;
>>>> -            goto out;
>>>> -        }
>>>> -    }
>>>
>>> The commit which introduced this check states that the device with a
>>> disk_total_bytes = 0 occurs from clone_fs_devices called from open_seed.
>>> It seems the check is legit and your changelog doesn't account for that
>>> if it's safe you should provide description why is that.
>>
>> yes the commit 1b3922a8bc74 (btrfs: Use real device structure to verify
>> dev extent) introduced it. In Qu's analysis, it is unclear why the
>> total_disk_bytes was 0.
>>
>> Theoretically, all devices (including missing and seed) marked with the
>> BTRFS_DEV_STATE_IN_FS_METADATA flag gets the total_disk_bytes updated at
>> fill_device_from_item().
>>
>> open_ctree()
>>   btrfs_read_chunk_tree()
>>    read_one_dev()
>>     open_seed_device()
> 
> This function returns the cloned fs_devices whose devices are not
> initialized. Later, in read_one_dev the 'device' is acquired from
> fs_info->fs_devices, not from the returned fs_devices :
> 
> device = btrfs_find_device(fs_info->fs_devices, devid, dev_uuid,
>                             fs_uuid, true);
> >
> And finally fill_device_from_item(leaf, dev_item, device); is called for
> the device which was found from fs_info->fs_devices and not from the
> returned 'fs_devices' from :
> 
> fs_devices = open_seed_devices(fs_info, fs_uuid);
> 
> What this means is that struct btrfs_device of devices in
> fs_info->seed_list is never fully initialized.


> 
>>     fill_device_from_item()

>>
>> Even if verify_one_dev_extent() reports total_disk_bytes == 0, then IMO
>> its a bug to be fixed somewhere else and not in verify_one_dev_extent()
>> as it's just a messenger. It is never expected that a total_disk_bytes
>> shall be zero.
> 
> I agree, however this would involve fixing clone_fs_devices to properly
> initialize struct btrfs_device. I'm in favor of removing special casing.
> 

  Cleanups are welcome. But function fill_device_from_item() is already 
properly initializing the struct btrfs_device. clone_fs_devices() is 
called at more than one place, so IMO it is fair.


> Looking closer into verify_one_dev_extent I see that the device is
> referenced from fs_info->fs_devices :
> 
> dev = btrfs_find_device(fs_info->fs_devices, devid, NULL, NULL, true);
> 
> And indeed, it seems that all devices of fs_info->fs_devices are
> initialized as per your above explanation. So yeah, your patch is


> codewise correct but the changelog is wrong:
 >
> disk_total_bytes is never set for seed devices (seed devices are after
> all housed in fs_info->seed_list which as I explained above doesn't
> fully initialize btrfs_devices)

  With all due respect, did you miss to check what 
fill_device_from_item() is doing?


> A better changelog would document following invariants:
> 
> 1. Seed devices don't have their disktotal bytes initialized
> 

  This is wrong.

> 2. In spite of (1), verify_dev_one_extent is never called for such
> devices so it's fine because devices anchored at fs_info->fs_devices are
> always properly initialized.
>

Even this is wrong. Generally seed's devid is 1, and
btrfs_verify_dev_extents() starts verifying from the dev object id = 1.
So typically, the seed will be the first device that gets verified. As 
btrfs_read_chunk_tree() is called before btrfs_verify_dev_extents() so 
the btrfs_device is properly initialized before the verify check.

2817 int __cold open_ctree

3073         ret = btrfs_read_chunk_tree(fs_info);  <-- seed init
::
3106         ret = btrfs_verify_dev_extents(fs_info);


Thanks, Anand

> 
> <snip>
> 
