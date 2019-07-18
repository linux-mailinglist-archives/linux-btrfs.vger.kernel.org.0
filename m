Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49E856CD4D
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jul 2019 13:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbfGRLXL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Jul 2019 07:23:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:53534 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727655AbfGRLXL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Jul 2019 07:23:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F4019AF8A;
        Thu, 18 Jul 2019 11:23:08 +0000 (UTC)
Subject: Re: [PATCH] btrfs: Remove the duplicated and sometimes too cautious
 btrfs_can_relocate()
To:     fdmanana@gmail.com, WenRuo Qu <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20190718054857.8970-1-wqu@suse.com>
 <CAL3q7H5H1BV92bZBv4SmuZ2-c99wOwJz8T8b5MFWV76YvCzmCw@mail.gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <27f65713-87c1-8e68-de9f-dab7face93de@suse.com>
Date:   Thu, 18 Jul 2019 14:23:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H5H1BV92bZBv4SmuZ2-c99wOwJz8T8b5MFWV76YvCzmCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 18.07.19 г. 14:16 ч., Filipe Manana wrote:
> On Thu, Jul 18, 2019 at 6:50 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [BUG]
>> The following script can easily cause unexpected ENOSPC:
>>   umount $dev &> /dev/null
>>   umount $mnt &> /dev/null
>>
>>   mkfs.btrfs -b 1G -m single -d single $dev -f > /dev/null
>>
>>   mount $dev $mnt -o enospc_debug
>>
>>   for i in $(seq -w 0 511); do
>>         xfs_io -f -c "pwrite 0 1m" $mnt/inline_$i > /dev/null
>>   done
>>   sync
>>
>>   btrfs balance start --full $mnt || return 1
>>   sync
>>
>>   # This will report -ENOSPC
>>   btrfs balance start --full $mnt || return 1
>>   umount $mnt
>>
>> Also, btrfs/156 can also fail due to ENOSPC.
> 
> Well, that script you pasted is btrfs/156 essentially.
> 
> When did the test started failing? When the test was added, it didn't
> fail, did it?
> 
>>
>> [CAUSE]
>> The ENOSPC is reported by btrfs_can_relocate().
>>
>> In btrfs_can_relocate(), it does the following check:
>> - If the block group is empty
>>   If empty, definitely we can relocate this block group.
>> - If we are not the only block group and we have enough space
>>   Then we can relocate this block group.
>>
>> Above two checks are completely OK, although I could argue they doesn't
>> make much sense, but the following check is vague and even sometimes
>> too cautious to cause ENOSPC:
>> - If we can allocate a new block group as large as current one.
>>   If we failed previous two checks, we must pass this to relocate this
>>   block group.
>>
>> There are several problems here:
>> 1. We don't need to allocate as large as the source block group.
>>    E.g. source block group is 1G sized, but only 1M used. We only need
>>    to allocated a data chunk larger than 1M to continue relocation.
> 
> Right. But where does btrfs_can_relocate() do such assumption?
> It only tries to check if there's enough space for an amount that
> corresponds to the amount used in the block group, that is, not the
> size of the block group (unless the block group is completely full).
> 
>>
>> 2. The check in btrfs_can_relocate() is vague and impossible to be as
>>    accurate as __btrfs_alloc_chunk()
>>    How could this less than 200 lines code do the same work as
>>    __btrfs_alloc_chunk()? And it's hard to maintain two different
>>    functions to do similar work.
>>
>> 3. We have more accurate check in btrfs_inc_block_group_ro().
>>    Btrfs_inc_block_group_ro() is doing similar check but much better.
>>    In btrfs_inc_block_group_ro() we do:
>>    * Forced chunk allocation if we're converting
>>
>>    * Try to mark block group ro first
>>      in inc_btrfs_block_group_ro(), we will do comprehensive space
>>      check to ensure we have enough free space for the used and reserved
>>      space of the block group.
>>      If succeeded, we're done.
>>
>>    * Force chunk allocation for more space
>>      If we failed here, we indeed hits ENOSPC.
>>
>>    * Try to mark block group ro again
>>      As we have extra space, we can try again.
>>      This is the last chance, either we have enough space now and
>>      success, or the newly allocated space is not large enough, ENOSPC
>>      is returned.
>>
>>    Such try-allocate-try behavior is way more accurate in every way
>>    compared to btrfs_can_relocate(), we can rely on
>>    btrfs_inc_block_group_ro() to replace btrfs_can_relocate()
>>    completely.
>>
>> [FIX]
>> Since regular balance routine already has a better ENOSPC detector,
>> there is no need to keep the false-alert-prone btrfs_can_relocate().
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/ctree.h       |   1 -
>>  fs/btrfs/extent-tree.c | 141 -----------------------------------------
>>  fs/btrfs/volumes.c     |   4 --
>>  3 files changed, 146 deletions(-)
>>
>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>> index 0a61dff27f57..965d1e5a4af7 100644
>> --- a/fs/btrfs/ctree.h
>> +++ b/fs/btrfs/ctree.h
>> @@ -2772,7 +2772,6 @@ int btrfs_setup_space_cache(struct btrfs_trans_handle *trans);
>>  int btrfs_extent_readonly(struct btrfs_fs_info *fs_info, u64 bytenr);
>>  int btrfs_free_block_groups(struct btrfs_fs_info *info);
>>  int btrfs_read_block_groups(struct btrfs_fs_info *info);
>> -int btrfs_can_relocate(struct btrfs_fs_info *fs_info, u64 bytenr);
>>  int btrfs_make_block_group(struct btrfs_trans_handle *trans,
>>                            u64 bytes_used, u64 type, u64 chunk_offset,
>>                            u64 size);
>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>> index 5faf057f6f37..822a4102980d 100644
>> --- a/fs/btrfs/extent-tree.c
>> +++ b/fs/btrfs/extent-tree.c
>> @@ -9774,147 +9774,6 @@ void btrfs_dec_block_group_ro(struct btrfs_block_group_cache *cache)
>>         spin_unlock(&sinfo->lock);
>>  }
>>
>> -/*
>> - * Checks to see if it's even possible to relocate this block group.
>> - *
>> - * @return - -1 if it's not a good idea to relocate this block group, 0 if its
>> - * ok to go ahead and try.
>> - */
>> -int btrfs_can_relocate(struct btrfs_fs_info *fs_info, u64 bytenr)
>> -{
>> -       struct btrfs_block_group_cache *block_group;
>> -       struct btrfs_space_info *space_info;
>> -       struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
>> -       struct btrfs_device *device;
>> -       u64 min_free;
>> -       u64 dev_min = 1;
>> -       u64 dev_nr = 0;
>> -       u64 target;
>> -       int debug;
>> -       int index;
>> -       int full = 0;
>> -       int ret = 0;
>> -
>> -       debug = btrfs_test_opt(fs_info, ENOSPC_DEBUG);
>> -
>> -       block_group = btrfs_lookup_block_group(fs_info, bytenr);
>> -
>> -       /* odd, couldn't find the block group, leave it alone */
>> -       if (!block_group) {
>> -               if (debug)
>> -                       btrfs_warn(fs_info,
>> -                                  "can't find block group for bytenr %llu",
>> -                                  bytenr);
>> -               return -1;
>> -       }
>> -
>> -       min_free = btrfs_block_group_used(&block_group->item);
>> -
>> -       /* no bytes used, we're good */
>> -       if (!min_free)
>> -               goto out;
>> -
>> -       space_info = block_group->space_info;
>> -       spin_lock(&space_info->lock);
>> -
>> -       full = space_info->full;
>> -
>> -       /*
>> -        * if this is the last block group we have in this space, we can't
>> -        * relocate it unless we're able to allocate a new chunk below.
>> -        *
>> -        * Otherwise, we need to make sure we have room in the space to handle
>> -        * all of the extents from this block group.  If we can, we're good
>> -        */
>> -       if ((space_info->total_bytes != block_group->key.offset) &&
>> -           (btrfs_space_info_used(space_info, false) + min_free <
>> -            space_info->total_bytes)) {
>> -               spin_unlock(&space_info->lock);
>> -               goto out;
>> -       }
>> -       spin_unlock(&space_info->lock);
>> -
>> -       /*
>> -        * ok we don't have enough space, but maybe we have free space on our
>> -        * devices to allocate new chunks for relocation, so loop through our
>> -        * alloc devices and guess if we have enough space.  if this block
>> -        * group is going to be restriped, run checks against the target
>> -        * profile instead of the current one.
>> -        */
>> -       ret = -1;
>> -
>> -       /*
>> -        * index:
>> -        *      0: raid10
>> -        *      1: raid1
>> -        *      2: dup
>> -        *      3: raid0
>> -        *      4: single
>> -        */
>> -       target = get_restripe_target(fs_info, block_group->flags);
>> -       if (target) {
>> -               index = btrfs_bg_flags_to_raid_index(extended_to_chunk(target));
>> -       } else {
>> -               /*
>> -                * this is just a balance, so if we were marked as full
>> -                * we know there is no space for a new chunk
>> -                */
>> -               if (full) {
>> -                       if (debug)
>> -                               btrfs_warn(fs_info,
>> -                                          "no space to alloc new chunk for block group %llu",
>> -                                          block_group->key.objectid);
>> -                       goto out;
>> -               }
>> -
>> -               index = btrfs_bg_flags_to_raid_index(block_group->flags);
>> -       }
>> -
>> -       if (index == BTRFS_RAID_RAID10) {
>> -               dev_min = 4;
>> -               /* Divide by 2 */
>> -               min_free >>= 1;
>> -       } else if (index == BTRFS_RAID_RAID1) {
>> -               dev_min = 2;
>> -       } else if (index == BTRFS_RAID_DUP) {
>> -               /* Multiply by 2 */
>> -               min_free <<= 1;
>> -       } else if (index == BTRFS_RAID_RAID0) {
>> -               dev_min = fs_devices->rw_devices;
>> -               min_free = div64_u64(min_free, dev_min);
>> -       }
>> -
>> -       mutex_lock(&fs_info->chunk_mutex);
>> -       list_for_each_entry(device, &fs_devices->alloc_list, dev_alloc_list) {
>> -               u64 dev_offset;
>> -
>> -               /*
>> -                * check to make sure we can actually find a chunk with enough
>> -                * space to fit our block group in.
>> -                */
>> -               if (device->total_bytes > device->bytes_used + min_free &&
>> -                   !test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state)) {
>> -                       ret = find_free_dev_extent(device, min_free,
>> -                                                  &dev_offset, NULL);
>> -                       if (!ret)
>> -                               dev_nr++;
>> -
>> -                       if (dev_nr >= dev_min)
>> -                               break;
> 
> And here's a bug in that code. Before breaking out of the loop, ret
> should be set to 0.

I have looked at that and actually it's correct. because if
find_free_dev_extent has returned successfully and dev_nr >= dev_min
is true then we break out of the loop with ret = 0. Though this logic is
somewhat implied and it took me some time to rationalize it.

> 
> In general I'm ok with the change, but would like an answer to those questions.
> 
> Thanks.
> 
>> -
>> -                       ret = -1;
>> -               }
>> -       }
>> -       if (debug && ret == -1)
>> -               btrfs_warn(fs_info,
>> -                          "no space to allocate a new chunk for block group %llu",
>> -                          block_group->key.objectid);
>> -       mutex_unlock(&fs_info->chunk_mutex);
>> -out:
>> -       btrfs_put_block_group(block_group);
>> -       return ret;
>> -}
>> -
>>  static int find_first_block_group(struct btrfs_fs_info *fs_info,
>>                                   struct btrfs_path *path,
>>                                   struct btrfs_key *key)
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 1c2a6e4b39da..f209127a8bc6 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -3071,10 +3071,6 @@ static int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
>>          */
>>         lockdep_assert_held(&fs_info->delete_unused_bgs_mutex);
>>
>> -       ret = btrfs_can_relocate(fs_info, chunk_offset);
>> -       if (ret)
>> -               return -ENOSPC;
>> -
>>         /* step one, relocate all the extents inside this chunk */
>>         btrfs_scrub_pause(fs_info);
>>         ret = btrfs_relocate_block_group(fs_info, chunk_offset);
>> --
>> 2.22.0
>>
> 
> 
