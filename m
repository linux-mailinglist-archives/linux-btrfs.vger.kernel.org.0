Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A71A1E8399
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 May 2020 18:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgE2Q0q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 May 2020 12:26:46 -0400
Received: from smtp-34.italiaonline.it ([213.209.10.34]:55517 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725601AbgE2Q0o (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 May 2020 12:26:44 -0400
Received: from venice.bhome ([78.12.136.199])
        by smtp-34.iol.local with ESMTPA
        id ehqAjvrrOtrlwehqAjTKZw; Fri, 29 May 2020 18:26:41 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1590769601; bh=70T8zdHnTfPbA5yNLbiYGjWOWz3/L1nnckVxdmSW8H8=;
        h=From;
        b=dNmSoeXt9unXPE+/Gg2y/HiHSY8E4vxUvYeMmaOD4aBebjx8KJ1KEuyJATqopGkpg
         2FMzgezbqwIwovZE2HSUFI+gtznFdhfuF59flds/mtEiJyBVBm+dLPES4iSik2ubAi
         1WuAouLKsq34NrepUPZKyzB/+2g5mlQpF7D8CUF2tUgs7QKCKfpYQCnlVIEhRMpSub
         ZhZiN/tgs9xcdmEPhtWCarfqvaXTXxBixdk0vzRpF3hQJEfz5acrQY0Zw1/PMl8qBH
         cCz4jm0vleK0NFayjUd4No6CYau9uZo9SeJ0gtNzDWzdxo4sBZakKodyDzTSjjTZPq
         2owMSY7Rf1bAw==
X-CNFS-Analysis: v=2.3 cv=TOE7tGta c=1 sm=1 tr=0
 a=kx39m2EDZI1V9vDwKCQCcA==:117 a=kx39m2EDZI1V9vDwKCQCcA==:17
 a=IkcTkHD0fZMA:10 a=QON92jhBR0XcCgRq9rIA:9 a=QEXdDO2ut3YA:10
 a=pHzHmUro8NiASowvMSCR:22 a=nt3jZW36AmriUCFCBwmW:22
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 4/4] btrfs: add preferred_metadata mode
To:     Hans van Kranenburg <hans@knorrie.org>, linux-btrfs@vger.kernel.org
Cc:     Michael <mclaud@roznica.com.ua>, Hugo Mills <hugo@carfax.org.uk>,
        Martin Svec <martin.svec@zoner.cz>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Paul Jones <paul@pauljones.id.au>,
        Adam Borowski <kilobyte@angband.pl>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Goffredo Baroncelli <kreijack@inwind.it>
References: <20200528183451.16654-1-kreijack@libero.it>
 <20200528183451.16654-5-kreijack@libero.it>
 <61d2188a-290c-5d6f-ec32-6cacd3f63ce8@knorrie.org>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <83e19781-1733-47bb-dc07-876ca82e94c1@libero.it>
Date:   Fri, 29 May 2020 18:26:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <61d2188a-290c-5d6f-ec32-6cacd3f63ce8@knorrie.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOPJS3yE8yYAiC3cVrd+9JytA4xOZgBdDnnZziR7KjAPtKcuSa+SqlLUiRnhLKz7ta1VdfsfZGtp31oE8jHzbEASFncTS5WJUO91+773FVSDjKaSm33V
 Zv/loB1BMMuMscNx3EsbQYXH8yWNYcFunQIRuB8a36ZXAAhimnC9yPpAAqfZfnfQx2vNqzA02aj9bPAPGOY9dq9ynu4VmM6BvbrszT1k+BtzEikiHPYiVasN
 CyD0MlhcrIrVnRwoicG7l1TcCrGDZ9OqL2aexSeEjp3L+FAbx92aThp9BqKyZyO2W48MeyiBYKj9EPloqZ39W+J6gErQET2+YpLT3zf016mGwqpYquyOpe8u
 LTAg8NXiDOYGTk4C+YV0R/U7VrTz2AMsh13bARdZUn85sjQF8FgP6t9154g5q0BiGK4k02HPSxdEiJQ1JCffq8HRSFCJUSsqh+mccuvrm8dBbtdpD8A=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/29/20 12:02 AM, Hans van Kranenburg wrote:
> Hi,
> 
> On 5/28/20 8:34 PM, Goffredo Baroncelli wrote:
>> From: Goffredo Baroncelli <kreijack@inwind.it>
>>
>> When this mode is enabled,
> 
> The commit message does not mention if this is either only a convenience
> during development and testing of the feature to be able to quickly turn
> it on/off, or if you intend to have this into the final change set.

Good question. IMHO for the initial devel phase I think that it is useful to have
a preferred_metadata disk (opt-in). Then we could reverse the logic and
default to preferred_metadata. Of course then we will have a
no-preferred_metadata flag (opt-out)
> 
>> the allocation policy of the chunk
>> is so modified:
>> - allocation of metadata chunk: priority is given to preferred_metadata
>>    disks.
>> - allocation of data chunk: priority is given to a non preferred_metadata
>>    disk.
>>
>> When a striped profile is involved (like RAID0,5,6), the logic
>> is a bit more complex. If there are enough disks, the data profiles
>> are stored on the non preferred_metadata disks; instead the metadata
>> profiles are stored on the preferred_metadata disk.
>> If the disks are not enough, then the profile is allocated on all
>> the disks.
>>
>> Example: assuming that sda, sdb, sdc are ssd disks, and sde, sdf are
>> non preferred_metadata ones.
>> A data profile raid6, will be stored on sda, sdb, sdc, sde, sdf (sde
>> and sdf are not enough to host a raid5 profile).
>> A metadata profile raid6, will be stored on sda, sdb, sdc (these
>> are enough to host a raid6 profile).
>>
>> To enable this mode pass -o dedicated_metadata at mount time.
> 
> Is it dedicated_metadata or preferred_metadata?

It was an copy&paste error. It should be preferred_metadata
> 
>> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
>> ---
>>   fs/btrfs/ctree.h   |  1 +
>>   fs/btrfs/super.c   |  8 +++++
>>   fs/btrfs/volumes.c | 89 ++++++++++++++++++++++++++++++++++++++++++++--
>>   fs/btrfs/volumes.h |  1 +
>>   4 files changed, 97 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>> index 03ea7370aea7..779760fd27b1 100644
>> --- a/fs/btrfs/ctree.h
>> +++ b/fs/btrfs/ctree.h
>> @@ -1239,6 +1239,7 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
>>   #define BTRFS_MOUNT_NOLOGREPLAY		(1 << 27)
>>   #define BTRFS_MOUNT_REF_VERIFY		(1 << 28)
>>   #define BTRFS_MOUNT_DISCARD_ASYNC	(1 << 29)
>> +#define BTRFS_MOUNT_PREFERRED_METADATA	(1 << 30)
>>   
>>   #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
>>   #define BTRFS_DEFAULT_MAX_INLINE	(2048)
>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>> index 438ecba26557..80700dc9dcf8 100644
>> --- a/fs/btrfs/super.c
>> +++ b/fs/btrfs/super.c
>> @@ -359,6 +359,7 @@ enum {
>>   #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>>   	Opt_ref_verify,
>>   #endif
>> +	Opt_preferred_metadata,
>>   	Opt_err,
>>   };
>>   
>> @@ -430,6 +431,7 @@ static const match_table_t tokens = {
>>   #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>>   	{Opt_ref_verify, "ref_verify"},
>>   #endif
>> +	{Opt_preferred_metadata, "preferred_metadata"},
>>   	{Opt_err, NULL},
>>   };
>>   
>> @@ -881,6 +883,10 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
>>   			btrfs_set_opt(info->mount_opt, REF_VERIFY);
>>   			break;
>>   #endif
>> +		case Opt_preferred_metadata:
>> +			btrfs_set_and_info(info, PREFERRED_METADATA,
>> +					"enabling preferred_metadata");
>> +			break;
>>   		case Opt_err:
>>   			btrfs_err(info, "unrecognized mount option '%s'", p);
>>   			ret = -EINVAL;
>> @@ -1403,6 +1409,8 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
>>   #endif
>>   	if (btrfs_test_opt(info, REF_VERIFY))
>>   		seq_puts(seq, ",ref_verify");
>> +	if (btrfs_test_opt(info, PREFERRED_METADATA))
>> +		seq_puts(seq, ",preferred_metadata");
>>   	seq_printf(seq, ",subvolid=%llu",
>>   		  BTRFS_I(d_inode(dentry))->root->root_key.objectid);
>>   	seq_puts(seq, ",subvol=");
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 5265f54c2931..c68efb15e473 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -4770,6 +4770,56 @@ static int btrfs_cmp_device_info(const void *a, const void *b)
>>   	return 0;
>>   }
>>   
>> +/*
>> + * sort the devices in descending order by preferred_metadata,
>> + * max_avail, total_avail
>> + */
>> +static int btrfs_cmp_device_info_metadata(const void *a, const void *b)
>> +{
>> +	const struct btrfs_device_info *di_a = a;
>> +	const struct btrfs_device_info *di_b = b;
>> +
>> +	/* metadata -> preferred_metadata first */
>> +	if (di_a->preferred_metadata && !di_b->preferred_metadata)
>> +		return -1;
>> +	if (!di_a->preferred_metadata && di_b->preferred_metadata)
>> +		return 1;
>> +	if (di_a->max_avail > di_b->max_avail)
>> +		return -1;
>> +	if (di_a->max_avail < di_b->max_avail)
>> +		return 1;
>> +	if (di_a->total_avail > di_b->total_avail)
>> +		return -1;
>> +	if (di_a->total_avail < di_b->total_avail)
>> +		return 1;
>> +	return 0;
>> +}
>> +
>> +/*
>> + * sort the devices in descending order by !preferred_metadata,
>> + * max_avail, total_avail
>> + */
>> +static int btrfs_cmp_device_info_data(const void *a, const void *b)
>> +{
>> +	const struct btrfs_device_info *di_a = a;
>> +	const struct btrfs_device_info *di_b = b;
>> +
>> +	/* data -> preferred_metadata last */
>> +	if (di_a->preferred_metadata && !di_b->preferred_metadata)
>> +		return 1;
>> +	if (!di_a->preferred_metadata && di_b->preferred_metadata)
>> +		return -1;
>> +	if (di_a->max_avail > di_b->max_avail)
>> +		return -1;
>> +	if (di_a->max_avail < di_b->max_avail)
>> +		return 1;
>> +	if (di_a->total_avail > di_b->total_avail)
>> +		return -1;
>> +	if (di_a->total_avail < di_b->total_avail)
>> +		return 1;
>> +	return 0;
>> +}
>> +
>>   static void check_raid56_incompat_flag(struct btrfs_fs_info *info, u64 type)
>>   {
>>   	if (!(type & BTRFS_BLOCK_GROUP_RAID56_MASK))
>> @@ -4885,6 +4935,7 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
>>   	int ndevs = 0;
>>   	u64 max_avail;
>>   	u64 dev_offset;
>> +	int nr_preferred_metadata = 0;
>>   
>>   	/*
>>   	 * in the first pass through the devices list, we gather information
>> @@ -4937,15 +4988,49 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
>>   		devices_info[ndevs].max_avail = max_avail;
>>   		devices_info[ndevs].total_avail = total_avail;
>>   		devices_info[ndevs].dev = device;
>> +		devices_info[ndevs].preferred_metadata = !!(device->type &
>> +			BTRFS_DEV_PREFERRED_METADATA);
>> +		if (devices_info[ndevs].preferred_metadata)
>> +			nr_preferred_metadata++;
>>   		++ndevs;
>>   	}
>>   	ctl->ndevs = ndevs;
>>   
>> +	BUG_ON(nr_preferred_metadata > ndevs);
>>   	/*
>>   	 * now sort the devices by hole size / available space
>>   	 */
>> -	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
>> -	     btrfs_cmp_device_info, NULL);
>> +	if (((ctl->type & BTRFS_BLOCK_GROUP_DATA) &&
>> +	     (ctl->type & BTRFS_BLOCK_GROUP_METADATA)) ||
>> +	    !btrfs_test_opt(info, PREFERRED_METADATA)) {
>> +		/* mixed bg or PREFERRED_METADATA not set */
>> +		sort(devices_info, ctl->ndevs, sizeof(struct btrfs_device_info),
>> +			     btrfs_cmp_device_info, NULL);
>> +	} else {
>> +		/*
>> +		 * if PREFERRED_METADATA is set, sort the device considering
>> +		 * also the kind (preferred_metadata or not). Limit the
>> +		 * availables devices to the ones of the same kind, to avoid
>> +		 * that a striped profile, like raid5, spreads to all kind of
>> +		 * devices.
>> +		 * It is allowed to use different kinds of devices if the ones
>> +		 * of the same kind are not enough alone.
>> +		 */
>> +		if (ctl->type & BTRFS_BLOCK_GROUP_DATA) {
>> +			int nr_data = ctl->ndevs - nr_preferred_metadata;
>> +			sort(devices_info, ctl->ndevs,
>> +				     sizeof(struct btrfs_device_info),
>> +				     btrfs_cmp_device_info_data, NULL);
>> +			if (nr_data >= ctl->devs_min)
>> +				ctl->ndevs = nr_data;
>> +		} else { /* non data -> metadata and system */
>> +			sort(devices_info, ctl->ndevs,
>> +				     sizeof(struct btrfs_device_info),
>> +				     btrfs_cmp_device_info_metadata, NULL);
>> +			if (nr_preferred_metadata >= ctl->devs_min)
>> +				ctl->ndevs = nr_preferred_metadata;
>> +		}
>> +	}
>>   
>>   	return 0;
>>   }
>> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
>> index 0ac5bf2b95e6..d39c3b0e7569 100644
>> --- a/fs/btrfs/volumes.h
>> +++ b/fs/btrfs/volumes.h
>> @@ -347,6 +347,7 @@ struct btrfs_device_info {
>>   	u64 dev_offset;
>>   	u64 max_avail;
>>   	u64 total_avail;
>> +	int preferred_metadata:1;
>>   };
>>   
>>   struct btrfs_raid_attr {
>>
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
