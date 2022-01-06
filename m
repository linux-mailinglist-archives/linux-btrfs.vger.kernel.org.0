Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6020B4862B7
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jan 2022 11:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237782AbiAFKJg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jan 2022 05:09:36 -0500
Received: from smtp-36.italiaonline.it ([213.209.10.36]:35764 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236858AbiAFKJf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 Jan 2022 05:09:35 -0500
Received: from [192.168.1.27] ([84.220.25.125])
        by smtp-36.iol.local with ESMTPA
        id 5Pi7nkOBueQ4z5Pi7nJjUN; Thu, 06 Jan 2022 11:09:33 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1641463773; bh=sduM0hh0nlnvAaO+UFB5/j0vm/aXRm3GUiB93G9jv1I=;
        h=From;
        b=aAgjasMOuNbMtj3dBVKUxR3jAWX+X37ACevglt/Alg9mliaEt4VVHjwNt9N/SHRW3
         KzQ03ycIrHEghHVw6j/FAYyUw6wNB5Q847cC9EtE767mKTcwMpf//nFJKpx52p1zyD
         /qpMAcBUPadhuF577+vhefGbxPi+F4PPSkYq/LQTgv3CLB0WzdplR8K4VEXk77WtCz
         IQBzwTj4gxowlw18ENyM8jNQk5W+89SaBVE9kJVMzwosUWiXL/nGenp9grocjOFuYY
         whZN/K3B9iiCKkn79wjfZ2UyOC5Df/LEGqOSjwWd4IR3bAvpBS3nQX4JHmZqV7qMtb
         rKx/wz9nWWEiQ==
X-CNFS-Analysis: v=2.4 cv=WK+64lgR c=1 sm=1 tr=0 ts=61d6bfdd cx=a_exe
 a=hx1hjU+azB0cnDRRU3Lo+Q==:117 a=hx1hjU+azB0cnDRRU3Lo+Q==:17
 a=IkcTkHD0fZMA:10 a=AqPUO8o5sSwRCn90JRUA:9 a=QEXdDO2ut3YA:10
Message-ID: <fe7f7662-1d85-bdf7-b0b5-a4d120f5d931@libero.it>
Date:   Thu, 6 Jan 2022 11:09:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 4/6] btrfs: add allocation_hint mode
Content-Language: en-US
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>,
        Goffredo Baroncelli <kreijack@inwind.it>
References: <cover.1639766364.git.kreijack@inwind.it>
 <c9f492a7ff1a0e4f0addc6cd451848404f0438db.1639766364.git.kreijack@inwind.it>
 <YdYuQIFF/yXa4z43@zen>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <YdYuQIFF/yXa4z43@zen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfFrsMIBZmJKdOoA9cgUn5LAXuUJ82iZUPQli/r2QOnW5P33VM6OkLjiF5H+DRYKDDt6AIafhfHICvl5b/nkQuWYK3HO7KfE7VVwzaQOlwF1YjoU2jUea
 BPYQsS4DIKSScYc8krqr73mB3CXNr9eF+87jkSXctmAvTyEIzcUyUsaNn9HbMkBFDnMzyt+WfNMezWicgGuozS8t8qo+HNKDwhJWaAu7zOa7yC0mLNkYDv+Z
 F1oOhBseW2TeL1IQ/XgiaZV68r5uM/8R8xPF+0e/wDNRqyOagw8GY2Dm6tLrpajL114pPhpKIzr0xrPosbqLYv8NQOABCRyZO5KTz4Ezwd2KsS8ylvXdOVW+
 aOMQ3WXpS3PX9vVmMq42NwowDwqKasp5g7AzMSUOhUvMl/JXdmVlYbOq8eHHCo3fpfpG2JpO
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 06/01/2022 00.48, Boris Burkov wrote:
> On Fri, Dec 17, 2021 at 07:47:20PM +0100, Goffredo Baroncelli wrote:
>> From: Goffredo Baroncelli <kreijack@inwind.it>
>>
>> The chunk allocation policy is modified as follow.
>>
>> Each disk may have one of the following tags:
>> - BTRFS_DEV_ALLOCATION_PREFERRED_METADATA
>> - BTRFS_DEV_ALLOCATION_METADATA_ONLY
>> - BTRFS_DEV_ALLOCATION_DATA_ONLY
>> - BTRFS_DEV_ALLOCATION_PREFERRED_DATA (default)
>>
>> During a *mixed data/metadata* chunk allocation, BTRFS works as
>> usual.
>>
>> During a *data* chunk allocation, the space are searched first in
>> BTRFS_DEV_ALLOCATION_DATA_ONLY and BTRFS_DEV_ALLOCATION_PREFERRED_DATA
>> tagged disks. If no space is found or the space found is not enough (eg.
>> in raid5, only two disks are available), then also the disks tagged
>> BTRFS_DEV_ALLOCATION_PREFERRED_METADATA are evaluated. If even in this
>> case this the space is not sufficient, -ENOSPC is raised.
>> A disk tagged with BTRFS_DEV_ALLOCATION_METADATA_ONLY is never considered
>> for a data BG allocation.
>>
>> During a *metadata* chunk allocation, the space are searched first in
>> BTRFS_DEV_ALLOCATION_METADATA_ONLY and BTRFS_DEV_ALLOCATION_PREFERRED_METADATA
>> tagged disks. If no space is found or the space found is not enough (eg.
>> in raid5, only two disks are available), then also the disks tagged
>> BTRFS_DEV_ALLOCATION_PREFERRED_DATA are considered. If even in this
>> case this the space is not sufficient, -ENOSPC is raised.
>> A disk tagged with BTRFS_DEV_ALLOCATION_DATA_ONLY is never considered
>> for a metadata BG allocation.
>>
>> By default the disks are tagged as BTRFS_DEV_ALLOCATION_PREFERRED_DATA,
>> so the default behavior happens. If the user prefer to store the
>> metadata in the faster disks (e.g. the SSD), he can tag these with
>> BTRFS_DEV_ALLOCATION_PREFERRED_DATA: in this case the data BG go in the
> 
> is this a typo? I would expect they should mark the disk with
> METADATA_PREFERRED to get metadata to go there. Also, that value is
> already the default, so setting it should be a no-op.

Yes it is a typo.
> 
>> BTRFS_DEV_ALLOCATION_PREFERRED_DATA disks and the metadata BG in the
>> others, until there is enough space. Only if one disks set is filled,
> 
> I think this may be another typo: "is not enough space" seems to make
> more sense.
> 

I rephrased a bit the commit message:
----------
btrfs: add allocation_hint mode

The chunk allocation policy is modified as follow.

Each disk may have one of the following tags:
- BTRFS_DEV_ALLOCATION_METADATA_PREFERRED
- BTRFS_DEV_ALLOCATION_METADATA_ONLY
- BTRFS_DEV_ALLOCATION_DATA_ONLY
- BTRFS_DEV_ALLOCATION_DATA_PREFERRED (default)

During a *mixed data/metadata* chunk allocation, BTRFS works as
usual.

During a *data* chunk allocation, the space are searched first in
BTRFS_DEV_ALLOCATION_DATA_ONLY. If the space found is not enough (eg.
in raid5, only two disks are available), then the disks taggged
BTRFS_DEV_ALLOCATION_DATA_PREFERRED are considered. If the space is not
enough again, the disks tagged BTRFS_DEV_ALLOCATION_METADATA_PREFERRED
are also considered. If even in this case this the space is not
sufficient, -ENOSPC is raised.
A disk tagged with BTRFS_DEV_ALLOCATION_METADATA_ONLY is never considered
for a data BG allocation.

During a *metadata* chunk allocation, the same algorithm applies swapping
_DATA_ and _METADATA_.

By default the disks are tagged as BTRFS_DEV_ALLOCATION_DATA_PREFERRED,
so BTRFS behaves as usual.

If the user prefers to store the metadata in the faster disks (e.g. SSD),
he can tag these with BTRFS_DEV_ALLOCATION_METADATA_PREFERRED: in this
case the metadata BG go in the BTRFS_DEV_ALLOCATION_METADATA_PREFERRED disks
and the data BG in the others ones. When a disks set is filled, the
other considered.

----------

>> the other is occupied.
>>
>> WARNING: if the user tags a disk with BTRFS_DEV_ALLOCATION_DATA_ONLY,
>> this means that this disk will never be used for allocating metadata
>> increasing the likelihood of exhausting the metadata space.
>>
>> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
>> ---
>>   fs/btrfs/volumes.c | 94 +++++++++++++++++++++++++++++++++++++++++++++-
>>   fs/btrfs/volumes.h |  1 +
>>   2 files changed, 94 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 806b599c6a46..beee7d1ae79d 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -184,6 +184,16 @@ enum btrfs_raid_types __attribute_const__ btrfs_bg_flags_to_raid_index(u64 flags
>>   	return BTRFS_RAID_SINGLE; /* BTRFS_BLOCK_GROUP_SINGLE */
>>   }
>>   
>> +#define BTRFS_DEV_ALLOCATION_HINT_COUNT (1ULL << \
>> +		BTRFS_DEV_ALLOCATION_HINT_BIT_COUNT)
>> +
> 
> This logic with -1..2 and then negating the hint is quite clever. I
> would add a comment to make it obvious what's happening, or a helper
> static function that sets a hint given the device_info, the ctl, and the
> device. You could also consider numbering from to 3 and flipping the
> order by doing (count - hint), which keeps things positive, at least.
> 
> I think your algorithm is fine, though

I add a comment like

   /*
    *      The order of BTRFS_DEV_ALLOCATION_HINT_* values are not
    *      good, because BTRFS_DEV_ALLOCATION_HINT_DATA_PREFERRED is 0
    *      (for backward compatibility reason), and the other
    *      values are greater (because the field is unsigned). So we
    *      need a map that rearranges the order giving to _DATA_PREFERRED
    *      an intermediate priority.
    *      These values give to METADATA_ONLY the highest priority, and are
    *      valid for metadata BG allocation. When a data
    *      BG is allocated we negate these values to reverse the priority.
    */
   static const char alloc_hint_map[BTRFS_DEV_ALLOCATION_HINT_COUNT] = {

.
> 
>> +static const char alloc_hint_map[BTRFS_DEV_ALLOCATION_HINT_COUNT] = {
>> +	[BTRFS_DEV_ALLOCATION_HINT_DATA_ONLY] = -1,
>> +	[BTRFS_DEV_ALLOCATION_HINT_PREFERRED_DATA] = 0,
>> +	[BTRFS_DEV_ALLOCATION_HINT_PREFERRED_METADATA] = 1,
>> +	[BTRFS_DEV_ALLOCATION_HINT_METADATA_ONLY] = 2,
>> +};
>> +
>>   const char *btrfs_bg_type_to_raid_name(u64 flags)
>>   {
>>   	const int index = btrfs_bg_flags_to_raid_index(flags);
>> @@ -5037,13 +5047,18 @@ static int btrfs_add_system_chunk(struct btrfs_fs_info *fs_info,
>>   }
>>   
>>   /*
>> - * sort the devices in descending order by max_avail, total_avail
>> + * sort the devices in descending order by alloc_hint,
>> + * max_avail, total_avail
>>    */
>>   static int btrfs_cmp_device_info(const void *a, const void *b)
>>   {
>>   	const struct btrfs_device_info *di_a = a;
>>   	const struct btrfs_device_info *di_b = b;
>>   
>> +	if (di_a->alloc_hint > di_b->alloc_hint)
>> +		return -1;
>> +	if (di_a->alloc_hint < di_b->alloc_hint)
>> +		return 1;
>>   	if (di_a->max_avail > di_b->max_avail)
>>   		return -1;
>>   	if (di_a->max_avail < di_b->max_avail)
>> @@ -5206,6 +5221,8 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
>>   	int ndevs = 0;
>>   	u64 max_avail;
>>   	u64 dev_offset;
>> +	int hint;
>> +	int i;
>>   
>>   	/*
>>   	 * in the first pass through the devices list, we gather information
>> @@ -5258,16 +5275,91 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
>>   		devices_info[ndevs].max_avail = max_avail;
>>   		devices_info[ndevs].total_avail = total_avail;
>>   		devices_info[ndevs].dev = device;
>> +
>> +		if ((ctl->type & BTRFS_BLOCK_GROUP_DATA) &&
>> +		     (ctl->type & BTRFS_BLOCK_GROUP_METADATA)) {
>> +			/*
>> +			 * if mixed bg set all the alloc_hint
>> +			 * fields to the same value, so the sorting
>> +			 * is not affected
>> +			 */
>> +			devices_info[ndevs].alloc_hint = 0;
>> +		} else if (ctl->type & BTRFS_BLOCK_GROUP_DATA) {
>> +			hint = device->type & BTRFS_DEV_ALLOCATION_HINT_MASK;
>> +
>> +			/*
>> +			 * skip BTRFS_DEV_METADATA_ONLY disks
>> +			 */
>> +			if (hint == BTRFS_DEV_ALLOCATION_HINT_METADATA_ONLY)
>> +				continue;
>> +			/*
>> +			 * if a data chunk must be allocated,
>> +			 * sort also by hint (data disk
>> +			 * higher priority)
>> +			 */
>> +			devices_info[ndevs].alloc_hint = -alloc_hint_map[hint];
>> +		} else { /* BTRFS_BLOCK_GROUP_METADATA */
>> +			hint = device->type & BTRFS_DEV_ALLOCATION_HINT_MASK;
>> +
>> +			/*
>> +			 * skip BTRFS_DEV_DATA_ONLY disks
>> +			 */
>> +			if (hint == BTRFS_DEV_ALLOCATION_HINT_DATA_ONLY)
>> +				continue;
>> +			/*
>> +			 * if a data chunk must be allocated,
> 
> typo: metadata chunk
> 
>> +			 * sort also by hint (metadata hint
>> +			 * higher priority)
>> +			 */
>> +			devices_info[ndevs].alloc_hint = alloc_hint_map[hint];
>> +		}
>> +
>>   		++ndevs;
>>   	}
>>   	ctl->ndevs = ndevs;
>>   
>> +	/*
>> +	 * no devices available
>> +	 */
>> +	if (!ndevs)
>> +		return 0;
>> +
> 
> What doesn't handle 0 devices properly? As far as I can tell, sort will
> be fine, and we'll skip the while and for loops.
It may be removed; however we already know that the rest of the code
is unneeded...

> 
>>   	/*
>>   	 * now sort the devices by hole size / available space
> 
> modify the comment to include that this sort cares about hint.
ok
> 
>>   	 */
>>   	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
>>   	     btrfs_cmp_device_info, NULL);
>>   
> 
> "restarting" the function here feels off to me. I'm wondering if you
> could refactor your logic to make it clearer and avoid the ugly logic
> reset mid function. You are going from:
> 
> - filter/prepare devices
> - sort by avail
> 
> to
> 
> - filter/prepare devices
> - sort by hint/avail
> - take all by hint until we take enough
> - sort by avail
> 
> that second step of "take by hint; sort by avail" could possibly be a
> new filter function run after gather_device_info and before
> decide_stripe_size. You could name it something like
> "reduce_devices_by_hint" or "take_devices_by_hint".

In the next iteration I am refactoring the code of sorting (from
sort by hint/avail') in a separate function.

>> +	/*
>> +	 * select the minimum set of disks grouped by hint that
>> +	 * can host the chunk
>> +	 */
>> +	ndevs = 0;
>> +	while (ndevs < ctl->ndevs) {
>> +		hint = devices_info[ndevs++].alloc_hint;
>> +		while (ndevs < ctl->ndevs &&
>> +		       devices_info[ndevs].alloc_hint == hint)
>> +				ndevs++;
>> +		if (ndevs >= ctl->devs_min)
>> +			break;
>> +	}
>> +
>> +	BUG_ON(ndevs > ctl->ndevs);
> 
> I think this BUG_ON is overly paranoid. Is it defensive against a future
> logic error with the nested while loops? (which I agree one should be
> careful with...)
> 

Yes, because this loop is not so obvious I preferred to leave a BOG_ON
to be sure. Until now it was never triggered, so now I am removing it.


>> +	ctl->ndevs = ndevs;
>> +
>> +	/*
>> +	 * the next layers require the devices_info ordered by
>> +	 * max_avail. If we are returing two (or more) different
> 
> typo: returning
Corrected
> 
>> +	 * group of alloc_hint, this is not always true. So sort
>> +	 * these gain.
> 
> typo: again
Corrected
> 
>> +	 */
>> +
>> +	for (i = 0 ; i < ndevs ; i++)
>> +		devices_info[i].alloc_hint = 0;
>> +
>> +	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
>> +	     btrfs_cmp_device_info, NULL);
>> +
>>   	return 0;
>>   }
>>   
>> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
>> index 5097c0c12a8e..61c0cba045e9 100644
>> --- a/fs/btrfs/volumes.h
>> +++ b/fs/btrfs/volumes.h
>> @@ -406,6 +406,7 @@ struct btrfs_device_info {
>>   	u64 dev_offset;
>>   	u64 max_avail;
>>   	u64 total_avail;
>> +	int alloc_hint;
>>   };
>>   
>>   struct btrfs_raid_attr {
>> -- 
>> 2.34.1
>>


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
