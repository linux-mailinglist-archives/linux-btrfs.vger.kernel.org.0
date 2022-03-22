Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944694E47DE
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Mar 2022 21:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbiCVU6B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Mar 2022 16:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235125AbiCVU5v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Mar 2022 16:57:51 -0400
Received: from libero.it (smtp-32.italiaonline.it [213.209.10.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AFEDB0
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 13:56:19 -0700 (PDT)
Received: from [192.168.1.27] ([84.220.27.216])
        by smtp-32.iol.local with ESMTPA
        id WlY6nrlRBptnyWlY7ngCz5; Tue, 22 Mar 2022 21:56:16 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1647982576; bh=K17nVTbR5jbwhwAgbG661poVVyzSN7l434DPLsZSydk=;
        h=From;
        b=hFRYCOtiMOGNj6RRsjM4URPEjMVV+Js2+CQEBIi6mDAtJMWKqdoOxLxHMa/eeH4GT
         8nzfe1yblqbjrxo5WK7F8cRacQOndX4vCKJeKQdDNY04JJSos3URtdyz8ZOnx8NKkB
         OIhPSB/TI0V6MGxc9uYJM7aUfvS3s0mbVRD4FsM4sjCOZwFh15mEf+ZavyyVTj2kKM
         3ZXit98mRA28Ogb4cpHTH+KptuNae5/3mMZU/7kbMXm2966LE1A4U3WG3w5MdlxF0s
         gr85Wr0yw8XCr1nLGG/6MNiWlJ8lub88NnxEruRI8MTAUpPqDBjYcMfm/UNLuUP84J
         onmsgtNICo8UA==
X-CNFS-Analysis: v=2.4 cv=fIX8YbWe c=1 sm=1 tr=0 ts=623a37f0 cx=a_exe
 a=jMrWlYnwW16pavatx/Gsew==:117 a=jMrWlYnwW16pavatx/Gsew==:17
 a=IkcTkHD0fZMA:10 a=tNX9MkOAtzHEg2Rdr94A:9 a=QEXdDO2ut3YA:10
Message-ID: <1fefb6df-1124-14de-d756-ac4e66c9c036@libero.it>
Date:   Tue, 22 Mar 2022 21:56:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 4/5] btrfs: add allocation_hint mode
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>, Boris Burkov <boris@bur.io>
References: <cover.1646589622.git.kreijack@inwind.it>
 <2291ba747c6c9701952fa75140684535cfe4ab3e.1646589622.git.kreijack@inwind.it>
 <Yjon7DClcBkw2V9i@localhost.localdomain>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <Yjon7DClcBkw2V9i@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfOpx3vJsHMI4pdkVvyQBJmPdPsOm7Mzu6f1fr8xuXZWdsBBYwFaMYJ3gjKC7zV2H/qbeXwL60tF/SaehYY0FevUG0ipvI+wMffm9OXfOxdADQNv/Rxnq
 W1ImgAgs4vowo11i3F1FLLxki0zco2flJDzD6spFN5wkMMEXISvjH5+boK7GjZq74BUewMdkDvmZuM1LxD8MPoPytxcTOIh9QaM+kXdhQcvpeca7cRMEKRwJ
 3pFrqxLf3UZ8Pr1NXzX+MEauPq06la9aspk5YzkBE9jUM7pgtQt9BSwLappjij3XWlhIf4Dm1sVQKEoLmY2pLCksWvvkRp6xfggFPmLj3RIBa4eGnS20nKax
 DER05YbC51dj35sJvdM3S2HImxYlHQ==
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22/03/2022 20.47, Josef Bacik wrote:
> On Sun, Mar 06, 2022 at 07:14:42PM +0100, Goffredo Baroncelli wrote:
>> From: Goffredo Baroncelli <kreijack@inwind.it>
>>
>> The chunk allocation policy is modified as follow.
>>
>> Each disk may have one of the following tags:
>> - BTRFS_DEV_ALLOCATION_METADATA_PREFERRED
>> - BTRFS_DEV_ALLOCATION_METADATA_ONLY
>> - BTRFS_DEV_ALLOCATION_DATA_ONLY
>> - BTRFS_DEV_ALLOCATION_DATA_PREFERRED (default)
>>
>> During a *mixed data/metadata* chunk allocation, BTRFS works as
>> usual.
>>
>> During a *data* chunk allocation, the space are searched first in
>> BTRFS_DEV_ALLOCATION_DATA_ONLY. If the space found is not enough (eg.
>> in raid5, only two disks are available), then the disks tagged
>> BTRFS_DEV_ALLOCATION_DATA_PREFERRED are considered. If the space is not
>> enough again, the disks tagged BTRFS_DEV_ALLOCATION_METADATA_PREFERRED
>> are also considered. If even in this case the space is not
>> sufficient, -ENOSPC is raised.
>> A disk tagged with BTRFS_DEV_ALLOCATION_METADATA_ONLY is never considered
>> for a data BG allocation.
>>
>> During a *metadata* chunk allocation, the same algorithm applies swapping
>> _DATA_ and _METADATA_.
>>
>> By default the disks are tagged as BTRFS_DEV_ALLOCATION_DATA_PREFERRED,
>> so BTRFS behaves as usual.
>>
>> If the user prefers to store the metadata in the faster disks (e.g. SSD),
>> he can tag these with BTRFS_DEV_ALLOCATION_METADATA_PREFERRED: in this
>> case the metadata BG go in the BTRFS_DEV_ALLOCATION_METADATA_PREFERRED
>> disks and the data BG in the others ones. When a disks set is filled, the
>> other is considered.
>>
>> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
>> ---
>>   fs/btrfs/volumes.c | 113 +++++++++++++++++++++++++++++++++++++++++++--
>>   fs/btrfs/volumes.h |   1 +
>>   2 files changed, 111 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index d4ac90f5c949..7b37db9bb887 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -184,6 +184,27 @@ enum btrfs_raid_types __attribute_const__ btrfs_bg_flags_to_raid_index(u64 flags
>>   	return BTRFS_RAID_SINGLE; /* BTRFS_BLOCK_GROUP_SINGLE */
>>   }
>>   
>> +#define BTRFS_DEV_ALLOCATION_HINT_COUNT (1ULL << \
>> +		BTRFS_DEV_ALLOCATION_HINT_BIT_COUNT)
>> +
>> +/*
>> + *	The order of BTRFS_DEV_ALLOCATION_HINT_* values are not
>> + *	good, because BTRFS_DEV_ALLOCATION_HINT_DATA_PREFERRED is 0
>> + *	(for backward compatibility reason), and the other
>> + *	values are greater (because the field is unsigned). So we
>> + *	need a map that rearranges the order giving to _DATA_PREFERRED
>> + *	an intermediate priority.
>> + *	These values give to METADATA_ONLY the highest priority, and are
>> + *	valid for metadata BG allocation. When a data
>> + *	BG is allocated we negate these values to reverse the priority.
>> + */
>> +static const char alloc_hint_map[BTRFS_DEV_ALLOCATION_HINT_COUNT] = {
>> +	[BTRFS_DEV_ALLOCATION_HINT_DATA_ONLY] = -1,
>> +	[BTRFS_DEV_ALLOCATION_HINT_DATA_PREFERRED] = 0,
>> +	[BTRFS_DEV_ALLOCATION_HINT_METADATA_PREFERRED] = 1,
>> +	[BTRFS_DEV_ALLOCATION_HINT_METADATA_ONLY] = 2,
>> +};
> 
> This should be const int, not const char.  Also the formatting for the comment
> is awkward, it's 1 space between the * and the word, so
> 
Ok

> /*
>   * The order of ....
>   *
>   * These values give METADATA_ONLY the highest priority...
>   */
> 
> Also the -1 thing is weird and unclear.  In fact I think it's problematic, I'll
> explain below.

To me it was more natural to have BTRFS_DEV_ALLOCATION_HINT_DATA_PREFERRED -> 0.
However we can rearrange this as we want, like below.

+static const int alloc_hint_map[BTRFS_DEV_ALLOCATION_HINT_COUNT] = {
+	[BTRFS_DEV_ALLOCATION_HINT_DATA_ONLY] = 0,
+	[BTRFS_DEV_ALLOCATION_HINT_DATA_PREFERRED] = 1,
+	[BTRFS_DEV_ALLOCATION_HINT_METADATA_PREFERRED] = 2,
+	[BTRFS_DEV_ALLOCATION_HINT_METADATA_ONLY] = 3,
+};

I don't see any problem

> 
>> +
>>   const char *btrfs_bg_type_to_raid_name(u64 flags)
>>   {
>>   	const int index = btrfs_bg_flags_to_raid_index(flags);
>> @@ -5030,13 +5051,18 @@ static int btrfs_add_system_chunk(struct btrfs_fs_info *fs_info,
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
> 
> This is making things awkward, instead I think we change this to sort_r, which
> uses cmp(a, b, priv).  You pass in priv which is the type we want, DATA or
> METADATA or whatever.  Then you can do

To me it seemed a natural extension of the previous code.

What I dislike is the use (see below) of alloc_hint_map[]:

	hint = device->type & BTRFS_DEV_ALLOCATION_HINT_MASK;
	devices_info[ndevs].alloc_hint = -alloc_hint_map[hint]; /* for data */

and
	hint = device->type & BTRFS_DEV_ALLOCATION_HINT_MASK;
	devices_info[ndevs].alloc_hint = +alloc_hint_map[hint]; /* for metadata */

However this is necessary because the values of device->type & BTRFS_DEV_ALLOCATION_HINT_MASK
are not in the same order of priority allocation. And this is due to the fact that
device->type & BTRFS_DEV_ALLOCATION_HINT_MASK == 0 means DATA_PREFERRED

Let me to summarize:

device->type & 					    alloc_hint_map[hint]
BTRFS_DEV_ALLOCATION_HINT_MASK    meaning           (aka priority)
-------------------------------  ------------------ --------------------
0                                DATA_PREFERRED		 0
1				 METADATA_PREFERRED      1
2				 METADATA_ONLY           2
3                                DATA_ONLY              -1


If you sort the table above by priority, you have the hints in the correct order


device->type & 					    alloc_hint_map[hint]
BTRFS_DEV_ALLOCATION_HINT_MASK    meaning           (aka priority)
-------------------------------  ------------------ --------------------
3                                DATA_ONLY              -1
0                                DATA_PREFERRED		 0
1				 METADATA_PREFERRED      1
2				 METADATA_ONLY           2


To understand the tables above, I have to point out:
- device->type & BTRFS_DEV_ALLOCATION_HINT_MASK is zero by default
- when all the disks are in a default state, we don't want that the
   allocation_hint policy creates mess
- this means that the default state has to be DATA_PREFERRED (or METADATA_PREFERRED),
   otherwise we cannot allocate METADATA (or DATA)
- for now we have only four values. But I am expect to have more in the future (e.g.
   different priorities because different disks speeds: hdd vs sdd vs nvme). So
   I preferred to avoid more complex scheme like: first bit=data|medata,
   second bit=only|preferred. Instead having an array that maps the values stored to disk
   to a priority give us the maximum of flexibility.

> 
> if (priv == data) {
> 	/* do the sorting so DATA_ONLY is on top, then DATA_PREFERRED, etc. */
> } else {
> 	/* do the METADATA thing instead. */
> }
> 

Yes, in the past I thought about something similar.

However, pay attention that you need to ignore the DATA_ONLY when you need to allocate METADATA.
I don't see a simple way to do that in btrfs_cmp_device_info().
So in any case you need some "if(s)" in gather_device_info() to skip the unwanted devices.
And because of that, it is simpler to adjust the field "devices_info[ndevs].alloc_hint"
to the sorting that we need (data, metadata o nothing) in these "if(s)"

Moreover I liked the simplicity of btrfs_cmp_device_info(), so I preferred to don't complicate it.

>>   	if (di_a->max_avail > di_b->max_avail)
>>   		return -1;
>>   	if (di_a->max_avail < di_b->max_avail)
>> @@ -5199,6 +5225,7 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
>>   	int ndevs = 0;
>>   	u64 max_avail;
>>   	u64 dev_offset;
>> +	int hint;
>>   
>>   	/*
>>   	 * in the first pass through the devices list, we gather information
>> @@ -5251,17 +5278,95 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
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
>> +			 * if a metadata chunk must be allocated,
>> +			 * sort also by hint (metadata hint
>> +			 * higher priority)
>> +			 */
>> +			devices_info[ndevs].alloc_hint = alloc_hint_map[hint];
>> +		}
>> +
> 
> Shouldn't we be doing this before adding the device to devices_info?  That way
> for _ONLY we just don't even add the disk to the devices_info.

Yes, it can be safely moved before
> 
>>   		++ndevs;
>>   	}
>>   	ctl->ndevs = ndevs;
>>   
>> +	return 0;
>> +}
>> +
>> +static void sort_and_reduce_device_info(struct alloc_chunk_ctl *ctl,
>> +					struct btrfs_device_info *devices_info)
>> +{
>> +	int ndevs, hint, i;
>> +
>> +	ndevs = ctl->ndevs;
>>   	/*
>> -	 * now sort the devices by hole size / available space
>> +	 * now sort the devices by hint / hole size / available space
>>   	 */
>>   	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
>>   	     btrfs_cmp_device_info, NULL);
>>   
>> -	return 0;
>> +	/*
>> +	 * select the minimum set of disks grouped by hint that
>> +	 * can host the chunk
>> +	 */
>> +	ndevs = 0;
>> +	while (ndevs < ctl->ndevs) {
>> +		hint = devices_info[ndevs++].alloc_hint;
>> +		while (ndevs < ctl->ndevs) {
>> +			if (devices_info[ndevs].alloc_hint != hint)
>> +				break;
>> +			ndevs++;
>> +		}
>> +		if (ndevs >= ctl->devs_min)
>> +			break;
>> +	}
>> +
>> +	ctl->ndevs = ndevs;
>> +
>> +	/*
>> +	 * the next layers require the devices_info ordered by
>> +	 * max_avail. If we are returning two (or more) different
>> +	 * group of alloc_hint, this is not always true. So sort
>> +	 * these again.
>> +	 */
>> +
>> +	for (i = 0 ; i < ndevs ; i++)
>> +		devices_info[i].alloc_hint = 0;
>> +
>> +	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
>> +	     btrfs_cmp_device_info, NULL);
> 
> With my sort_r suggestion I think we no longer need the second sort.  It'll get
> you the devices you want in order of most preferred alloc hint, and with the
> max_avail.  I'd double check with printk's, but you should be able to drop all
> this.  Thanks,

It is not so simple. Assuming that you have the following situation
(after the first sort):

sda: DATA_PREFERRED		free=1GB
sdb: DATA_PREFERRED		free=0GB
sdc: METADATA_PREFERRED		free=2GB
sdd: METADATA_PREFERRED		free=1GB

And you need to allocate 1 DATA chunk in RAID1, you need to use the
following combination:

sda: DATA_PREFERRED		free=1GB
sdc: METADATA_PREFERRED		free=2GB

However, as the comment report, you need to pass the array sorted by free avail in
the next layers; this is the reason why you need a 2nd sort.



> 
> Josef


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
