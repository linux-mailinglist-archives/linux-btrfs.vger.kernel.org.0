Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95CD7242898
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Aug 2020 13:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgHLLYz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Aug 2020 07:24:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:54634 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbgHLLYy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Aug 2020 07:24:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 99EE8B6D5;
        Wed, 12 Aug 2020 11:25:14 +0000 (UTC)
Subject: Re: [PATCH v5] btrfs: trim: fix underflow in trim length to prevent
 access beyond device boundary
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.cz,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
References: <20200731112911.115665-1-wqu@suse.com>
 <20200812064312.GW2026@twin.jikos.cz>
 <fcf7972e-6579-01ee-add1-6bab2903cdf0@gmx.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9fbab6c1-ca45-3a88-9853-749bc666b949@suse.com>
Date:   Wed, 12 Aug 2020 14:24:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <fcf7972e-6579-01ee-add1-6bab2903cdf0@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 12.08.20 г. 14:14 ч., Qu Wenruo wrote:
> 
> 
> On 2020/8/12 下午2:43, David Sterba wrote:
>> The v5 changes were discussed but were not all trivial to be just
>> committed. I need to add the patch to pull request branch soon so am
>> not waiting for your v5
>>
>> v5:
>>
>> - add mask for chunk state bits and use that to clear the range a after
>>   device shrink; on a second thought doing all ones did not look clean
>>   to me
> 
> Extra idea inspired by this patch.
> 
> We can do extra extent_io_tree bits sanity check for DEBUG build.
> 
> In the past, extent_io_tree got its owner member, which each
> extent_io_tree should have one. (Unfortunately, when alloc_state is
> added, we didn't add a new entry for it)
> 
> With that, we can easily verify the set/clear bits against its owner to
> ensure we don't set wrong bits for wrong extent_io_tree.
> E.g. CHUNK_* bits are only for alloc_state, while
> DELALLOC/QGROUP_RESERVED are only for inode io tree.

Will this work given the CHUNK_* bits are defined to 2 existing flags,
chosen such that to not clash with the special logic in bit management
functions? (check comment above CHUNK_* bits defines).


> 
> Of course, this would be in a new patch.
> 
> Thanks,
> Qu
>>
>> - removed assert after clear_extent_bits - make it consistent with all
>>   other calls where we don't check the return value for now
>>
>> - reworded comments
>>
>> ---
>>
>> From: Qu Wenruo <wqu@suse.com>
>> Subject: [PATCH] btrfs: trim: fix underflow in trim length to prevent access
>>  beyond device boundary
>>
>> [BUG]
>> The following script can lead to tons of beyond device boundary access:
>>
>>   mkfs.btrfs -f $dev -b 10G
>>   mount $dev $mnt
>>   trimfs $mnt
>>   btrfs filesystem resize 1:-1G $mnt
>>   trimfs $mnt
>>
>> [CAUSE]
>> Since commit 929be17a9b49 ("btrfs: Switch btrfs_trim_free_extents to
>> find_first_clear_extent_bit"), we try to avoid trimming ranges that's
>> already trimmed.
>>
>> So we check device->alloc_state by finding the first range which doesn't
>> have CHUNK_TRIMMED and CHUNK_ALLOCATED not set.
>>
>> But if we shrunk the device, that bits are not cleared, thus we could
>> easily got a range starts beyond the shrunk device size.
>>
>> This results the returned @start and @end are all beyond device size,
>> then we call "end = min(end, device->total_bytes -1);" making @end
>> smaller than device size.
>>
>> Then finally we goes "len = end - start + 1", totally underflow the
>> result, and lead to the beyond-device-boundary access.
>>
>> [FIX]
>> This patch will fix the problem in two ways:
>>
>> - Clear CHUNK_TRIMMED | CHUNK_ALLOCATED bits when shrinking device
>>   This is the root fix
>>
>> - Add extra safety check when trimming free device extents
>>   We check and warn if the returned range is already beyond current
>>   device.
>>
>> Link: https://github.com/kdave/btrfs-progs/issues/282
>> Fixes: 929be17a9b49 ("btrfs: Switch btrfs_trim_free_extents to find_first_clear_extent_bit")
>> CC: stable@vger.kernel.org # 5.4+
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>> Signed-off-by: David Sterba <dsterba@suse.com>
>> ---
>>  fs/btrfs/extent-io-tree.h |  2 ++
>>  fs/btrfs/extent-tree.c    | 14 ++++++++++++++
>>  fs/btrfs/volumes.c        |  4 ++++
>>  3 files changed, 20 insertions(+)
>>
>> diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
>> index f39d47a2d01a..219a09a2b734 100644
>> --- a/fs/btrfs/extent-io-tree.h
>> +++ b/fs/btrfs/extent-io-tree.h
>> @@ -34,6 +34,8 @@ struct io_failure_record;
>>   */
>>  #define CHUNK_ALLOCATED				EXTENT_DIRTY
>>  #define CHUNK_TRIMMED				EXTENT_DEFRAG
>> +#define CHUNK_STATE_MASK			(CHUNK_ALLOCATED |		\
>> +						 CHUNK_TRIMMED)
>>
>>  enum {
>>  	IO_TREE_FS_PINNED_EXTENTS,
>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>> index fa7d83051587..597505df90b4 100644
>> --- a/fs/btrfs/extent-tree.c
>> +++ b/fs/btrfs/extent-tree.c
>> @@ -33,6 +33,7 @@
>>  #include "delalloc-space.h"
>>  #include "block-group.h"
>>  #include "discard.h"
>> +#include "rcu-string.h"
>>
>>  #undef SCRAMBLE_DELAYED_REFS
>>
>> @@ -5669,6 +5670,19 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
>>  					    &start, &end,
>>  					    CHUNK_TRIMMED | CHUNK_ALLOCATED);
>>
>> +		/* Check if there are any CHUNK_* bits left */
>> +		if (start > device->total_bytes) {
>> +			WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
>> +			btrfs_warn_in_rcu(fs_info,
>> +"ignoring attempt to trim beyond device size: offset %llu length %llu device %s device size %llu",
>> +					  start, end - start + 1,
>> +					  rcu_str_deref(device->name),
>> +					  device->total_bytes);
>> +			mutex_unlock(&fs_info->chunk_mutex);
>> +			ret = 0;
>> +			break;
>> +		}
>> +
>>  		/* Ensure we skip the reserved area in the first 1M */
>>  		start = max_t(u64, start, SZ_1M);
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index d7670e2a9f39..ee96c5869f57 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -4720,6 +4720,10 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
>>  	}
>>
>>  	mutex_lock(&fs_info->chunk_mutex);
>> +	/* Clear all state bits beyond the shrunk device size */
>> +	clear_extent_bits(&device->alloc_state, new_size, (u64)-1,
>> +			  CHUNK_STATE_MASK);
>> +
>>  	btrfs_device_set_disk_total_bytes(device, new_size);
>>  	if (list_empty(&device->post_commit_list))
>>  		list_add_tail(&device->post_commit_list,
>>
> 
