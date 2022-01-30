Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972CB4A3AAA
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 Jan 2022 23:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347690AbiA3WPD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 Jan 2022 17:15:03 -0500
Received: from smtp-34.italiaonline.it ([213.209.10.34]:33577 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232281AbiA3WPD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 Jan 2022 17:15:03 -0500
Received: from [192.168.1.27] ([78.14.151.50])
        by smtp-34.iol.local with ESMTPA
        id EITMnQ7ur4gIpEITMndt0F; Sun, 30 Jan 2022 23:15:01 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1643580901; bh=DRtoYJqC58Syj04/qgJsJ71u8Bn7s537lx08QSZ6yHI=;
        h=From;
        b=mSRptXn/mYDwlFvsJp5M8dfEnhypys7kRsrOVkeU/X0wDWgh2OJgkds2oWV3hBIgC
         2uQNtUXv0K9UQ0OfZTbl6dliVGB5jtMWEOa0+SVCwe0y0hvyKdlRHxXEV6Ot01N4Fd
         KvQiDhW3ibgVKqgVMhP9hnHxpwQ/JGO88HBOzdF91Ui5z7k/1sVoOG+G5rO90b0vyV
         0HMz0ST2b32EZtfBc71mZ3I7HDr/gkY6E46bu+XQN8ekNZLTNMxeLXg4YU8xxC9k7A
         OS2vn3G+OfKYYOSoH7EOfRc8a9E716se6DotENPWEyc8wAg+KJV88zjMZ+ypFujwU3
         SjXxbww7chdVA==
X-CNFS-Analysis: v=2.4 cv=d4QwdTvE c=1 sm=1 tr=0 ts=61f70de5 cx=a_exe
 a=d4nNsk+SGr75ik5id+62uA==:117 a=d4nNsk+SGr75ik5id+62uA==:17
 a=IkcTkHD0fZMA:10 a=yPCof4ZbAAAA:8 a=nB6kQpg0_y-kKXtNlPYA:9 a=QEXdDO2ut3YA:10
Message-ID: <cc5907e6-12e0-e12c-05c8-a12d019432ad@libero.it>
Date:   Sun, 30 Jan 2022 23:15:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 2/2] btrfs: create chunk device type aware
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org
References: <cover.1642518245.git.anand.jain@oracle.com>
 <4ac12d6661470b18e1145f98c355bc1a93ebf214.1642518245.git.anand.jain@oracle.com>
 <20220126173838.GE14046@twin.jikos.cz>
 <08748658-b139-5b41-9008-cbadea76ce5e@oracle.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <08748658-b139-5b41-9008-cbadea76ce5e@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfKd5yCxePsVk7wYLwet2rNhwhoHjxzGi+NGui5AgNGCJC3p6f8O8PcVEgydh++sfw9vPYpglPYD6YfpQCZ23IEXe3YQPcHqvyjFaytV9p9keTgLKs4n6
 l3SSoDVMnQGft1xSlpRQ3bXUKshvkPBVrxBsiJe1ppvtq2Yp03F7OVVXM6EDg6ogVNStF78vC3uqULyOevA4/xDbVvr8lyEg2poPQvMibw/HAeifpf1AuWzH
 HN7B9/myNlz7ZixLN9FA9A==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/01/2022 17.46, Anand Jain wrote:
> 
> 
> On 27/01/2022 01:38, David Sterba wrote:
>> On Tue, Jan 18, 2022 at 11:18:02PM +0800, Anand Jain wrote:
>>> Mixed device types configuration exist. Most commonly, HDD mixed with
>>> SSD/NVME device types. This use case prefers that the data chunk
>>> allocates on HDD and the metadata chunk allocates on the SSD/NVME.
>>>
>>> As of now, in the function gather_device_info() called from
>>> btrfs_create_chunk(), we sort the devices based on unallocated space
>>> only.
>>
> 
>> Yes, and this guarantees maximizing the used space for the raid
>> profiles.
> 
>   Oops. Thanks for reminding me of that. More below.
> 
>>> After this patch, this function will check for mixed device types. And
>>> will sort the devices based on enum btrfs_device_types. That is, sort if
>>> the allocation type is metadata and reverse-sort if the allocation type
>>> is data.
>>
>> And this changes the above, because a small fast device can be depleted
>> first.
> 
> 
> Both sort by size or latency do _not_ help if
>   given_raid.devs_max == 0 (raid0, raid5, raid6) OR given_raid.devs_max == num_devices.
> 
> It helps only when given_raid.devs_max != 0 and given_raid.devs_max < num_devices.
> 
> Sort by size does not help Single and Dup profiles.
> 
> So, if (given_raid.devs_max != 0 && given_raid.devs_max < num_devices) {
> 
> Mixed devs types with different sizes if sorted by free size:
>   is pro for  raid1, raid1c3, raid1c4, raid10
>   doesn't matter for single, dup
> 
> Mixed devs types with different sizes if sorted by latency:
>   is pro for single and dup
>   is con for raid1, raid1c3, raid1c4, raid10 (depends)
> }

May be I remember bad; but in the "single" cases a new BG is allocated
in the "more empty" disks. The same for the "dup". In this it is not different from
RAID1xx. Only in the case of RAID5/6 the size doesn't matter, because a new chunk is
allocate in each disk anyway.

Pay attention that you can have a "mixed" environment of different disks sizes:
  2 x ssd (100GB + 200GB)
  2 x HDD (1T + 2T)

So it could make sense to spread the metadata by priority (only to ssd) AND by "emptiness"
(i.e. each 3 BG, one is allocated on the smaller disks and two in the bigger one).

> 
> So,
> 
> If given_raid.devs_max == num_devices we don't need any type of sorting.
> 
> If given_raid.devs_max = 0 (raid0, raid5, raid6) we don't need any type of sorting.
> 
> And sort devs by latency for Single and Dup profiles only.
> 
> For rest of profiles sort devs by size only if given_raid.devs_max < num_devices.
> 
> 
>>> The advantage of this method is that data/metadata allocation distribution
>>> based on the device type happens automatically without any manual
>>> configuration.
>>
>> Yeah, but the default behaviour may not be suitable for all users so
>> some policy will have to be done anyway.
> 
>   Right. If nothing is configured even when provided then also it should
>   fallback to the default behaviour.
> 
>> I vaguely remember some comments regarding mixed setups, along lines
>> that "if there's a fast flash device I'd rather see ENOSPC and either
>> delete files or add more devices than to let everything work but with
>> the risk of storing metadata on the slow devices."
> 
>   It entirely depends on the use-case. An option like following will
>   solve it better:
>     mount -o metadata_nospc_on_faster_devs=<use-slower-devs>|<error>
> 
>   If metadata_nospc_on_faster_devs=error is preferred then it also
>   implies that data_nospc_on_slower_devs=error.
> 
>   Also, the use cases which prefer to use the error option should
>   remember it is difficult to estimate the data/metadata ratio
>   beforehand.
> 
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>> ---
>>>   fs/btrfs/volumes.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 45 insertions(+)
>>>
>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>> index da3d6d0f5bc3..77fba78555d7 100644
>>> --- a/fs/btrfs/volumes.c
>>> +++ b/fs/btrfs/volumes.c
>>> @@ -5060,6 +5060,37 @@ static int btrfs_add_system_chunk(struct btrfs_fs_info *fs_info,
>>>       return 0;
>>>   }
>>> +/*
>>> + * Sort the devices in its ascending order of latency value.
>>> + */
>>> +static int btrfs_cmp_device_latency(const void *a, const void *b)
>>> +{
>>> +    const struct btrfs_device_info *di_a = a;
>>> +    const struct btrfs_device_info *di_b = b;
>>> +    struct btrfs_device *dev_a = di_a->dev;
>>> +    struct btrfs_device *dev_b = di_b->dev;
>>> +
>>> +    if (dev_a->dev_type > dev_b->dev_type)
>>> +        return 1;
>>> +    if (dev_a->dev_type < dev_b->dev_type)
>>> +        return -1;
>>> +    return 0;
>>> +}
>>> +
>>> +static int btrfs_cmp_device_rev_latency(const void *a, const void *b)
>>> +{
>>> +    const struct btrfs_device_info *di_a = a;
>>> +    const struct btrfs_device_info *di_b = b;
>>> +    struct btrfs_device *dev_a = di_a->dev;
>>> +    struct btrfs_device *dev_b = di_b->dev;
>>> +
>>> +    if (dev_a->dev_type > dev_b->dev_type)
>>> +        return -1;
>>> +    if (dev_a->dev_type < dev_b->dev_type)
>>> +        return 1;
>>> +    return 0;
>>> +}
>>> +
>>>   /*
>>>    * sort the devices in descending order by max_avail, total_avail
>>>    */
>>> @@ -5292,6 +5323,20 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
>>>       sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
>>>            btrfs_cmp_device_info, NULL);
>>> +    /*
>>> +     * Sort devices by their latency. Ascending order of latency for
>>> +     * metadata and descending order of latency for the data chunks for
>>> +     * mixed device types.
>>> +     */
>>> +    if (fs_devices->mixed_dev_types) {
>>> +        if (ctl->type & BTRFS_BLOCK_GROUP_DATA)
>>> +            sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
>>> +                 btrfs_cmp_device_rev_latency, NULL);
>>> +        else
>>> +            sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
>>> +                 btrfs_cmp_device_latency, NULL);
>>
>> In case there are mixed devices the sort happens twice and because as
>> implemented in kernel sort() is not stable so even if device have same
>> amount of data they can get reorderd wildly. The remaingin space is
>> still a factor we need to take into account to avoid ENOSPC on the chunk
>> level.
> 
> 
> I didn't get this part. How about if it is this way:
> 
>     if (mixed && metadata && (single || dup)) {
>       ndevs=0
>       pick all non-rotational ndevs++ with free space >= required space
>       if (ndevs == 0) {
>         if (user_option->metadata_nospc_on_faster_devs == error)
>              return -ENOSPC;
>         pick all rotational
>       }
>       sort-by-size-select-top
>     }
> 
>     if (mixed && data && (single || dup)) {
>       ndevs=0
>       pick all rotational ndevs++ with free space >= required space
>       if (ndevs == 0) {
>         if (user_option->data_nospc_on_faster_devs == error)
>              return -ENOSPC;
>         pick all non-rotational
>       }
>       sort-by-size-select-top
>     }
> 
> Thanks, Anand

I think that you have to behave as allocation_hint patches set:
The sort is one, and it sorts by
- by priority
- if the disks have the same priority, by free space
- if the disks have the same priority and free space, by max avail
...


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
