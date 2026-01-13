Return-Path: <linux-btrfs+bounces-20464-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D94D1B031
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 20:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4ACBE30F84A9
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 19:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632ED36C0A2;
	Tue, 13 Jan 2026 19:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=urbackup.org header.i=@urbackup.org header.b="ooHTTJTL";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="DVlVpVoM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from a4-15.smtp-out.eu-west-1.amazonses.com (a4-15.smtp-out.eu-west-1.amazonses.com [54.240.4.15])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA2536E478
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Jan 2026 19:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.4.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768331755; cv=none; b=XsWYEzcrEu5hRSWWXpdjsN34HlZoDvhBylEt1s7BICxCMULDYGtreNru6sARqg92KBYAHFfgmn7V64BgJ84cUE3UP/KH9OrPQueXMjQHny8t48nEQCqRR7VQXk/nISpnKhT0Xdgo4BVWNy3Vz6wMwxo3TE5U7tJGfZyNEJmpVaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768331755; c=relaxed/simple;
	bh=ShAY3l6Q8229H8hDRuiefysRv8NgmztDVMwEJO5CMZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LoIq2lIAGtCXNAHdPblb8hyfJI9Sr6VHS2o68kr2TufkxlPlUqLyG5pU7NYnfZL7nI80N+z5tcNFvbmZ1GUSpOI27lrbVA3TfYQ7jl+WKVk4BK/FQiMF4JHfg9YhQkPSgcG7+zCdyy8Jqt6QKpHvRI17D2uh9MVgvqSgHIFFoNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=urbackup.org; spf=pass smtp.mailfrom=bounce.urbackup.org; dkim=pass (1024-bit key) header.d=urbackup.org header.i=@urbackup.org header.b=ooHTTJTL; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=DVlVpVoM; arc=none smtp.client-ip=54.240.4.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=urbackup.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.urbackup.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ob2ngmaigrjtzxgmrxn2h6b3gszyqty3; d=urbackup.org; t=1768331752;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=ShAY3l6Q8229H8hDRuiefysRv8NgmztDVMwEJO5CMZc=;
	b=ooHTTJTL4p7ObS0ypi0Ep3fvOGyhUZZXEG0/5Tu6nnW9hfZ2JhwcEQU8DUOeze9d
	5yOmuYtJg6uk8/GIz+HAwsIQqOyXbac1Fsrvq+rXHVLvgNOs6V2ZN0v6RcJN0b6kltZ
	NVM4wpG+dwExThUuT4Hy4iuWz3b4HSx1uD7vvLh8=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1768331752;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=ShAY3l6Q8229H8hDRuiefysRv8NgmztDVMwEJO5CMZc=;
	b=DVlVpVoMAQEVv/Iod7kTym7YrzSVJEbsbi2EVMdLZ4SP2j/X0zcRpM5Cy4K0nIbo
	Ava7Va6SUl0JkknOW5CzibfZG6fDHwZzdu9a8QKcZeBHwuZ38PQCfDiM8FfhHOda3lo
	U2E+ubrMO0g9KGerXi0B3KyW9V88Z0MXN8NrEP0A=
Message-ID: <0102019bb8c932c7-69c16125-754b-43ad-917d-043ab6be4ccc-000000@eu-west-1.amazonses.com>
Date: Tue, 13 Jan 2026 19:15:52 +0000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] btrfs: Use percpu semaphore for space info groups_sem
Content-Language: en-GB
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <20260112161549.2786827-1-martin@urbackup.org>
 <0102019bb2ff5805-8aa151b8-1fe7-4087-9610-4c3314b3b144-000000@eu-west-1.amazonses.com>
 <20260112225804.GB459994@zen.localdomain>
From: Martin Raiber <martin@urbackup.org>
In-Reply-To: <20260112225804.GB459994@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
X-SES-Outgoing: 2026.01.13-54.240.4.15

On 12/01/2026 23:58 Boris Burkov wrote:
> On Mon, Jan 12, 2026 at 04:17:17PM +0000, Martin Raiber wrote:
>> Groups_sem is locked for write mostly only when adding
>> or removing block groups, whereas it is locked for read
>> constantly by multiple CPUs.
>> Change it into a percpu semaphore to significantly
>> increase the performance of find_free_extent.
> This argument makes sense to me, and I don't think the proposal is wrong
> or anything.
>
> However, I am concerned about the low amount of evidence and detail for
> a major change like this.
>
> Can you share your benchmarking results?

To be honest the benchmarking was that I looked at the throughput of the 
one system
where it is having performance problems and then progressively fixed the 
find_free_extent
bottleneck.
I do not know how common a bottleneck there is. E.g. a 10x faster CPU 
could cause it
to be mostly be bottlenecked by IO and not by CPU synchronization 
contention.

So I was hoping someone has an already setup systematic performance test 
suite, that
has things like performance at nearly full, nearly empty, ssd_spread, 
during rebalance, etc.

>
> What, if any, changes in fairness behavior would we expect going from
> rwsem to percpu-rwsem?
>
> Can you characterize the effect on adding / removing block groups? How
> long does it currently take? How long does it take once you make it wait
> for an rcu grace period? That will affect ENOSPC flushing which can be
> blocking some task, so drastically hurting that performance could be bad.
It makes performance of locking for write really bad, so the ENOSPC 
flushing might be a
show stopper.

I suspect the whole block group updating could be handled by RCU, then 
group_sem could be
removed. I haven't used RCU before and would have to learn how to use it 
in this context
and it would not be  a straight-forward change. And as mentioned in the 
cover letter there
might be easier ways to optimize it on a higher level.

If someone tells me a valid work-around is to increase the chunk size 
(from currently max 10
GiB) for larger file systems, that would e.g. also be a perhaps valid 
path to fix this (albeit
not for existing file systems).

Thanks,
Martin

>
> I suspect it will be fine, though.
>
> Thanks,
> Boris
>
>> Signed-off-by: Martin Raiber <martin@urbackup.org>
>> ---
>>   fs/btrfs/extent-tree.c |  8 ++++----
>>   fs/btrfs/ioctl.c       |  8 ++++----
>>   fs/btrfs/space-info.c  | 29 +++++++++++++++++++----------
>>   fs/btrfs/space-info.h  |  2 +-
>>   fs/btrfs/sysfs.c       |  9 +++++----
>>   fs/btrfs/zoned.c       | 11 +++++------
>>   6 files changed, 38 insertions(+), 29 deletions(-)
>>
>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>> index 1dcd69fe97ed..ce2eef069663 100644
>> --- a/fs/btrfs/extent-tree.c
>> +++ b/fs/btrfs/extent-tree.c
>> @@ -4442,7 +4442,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
>>   		if (block_group && block_group_bits(block_group, ffe_ctl->flags) &&
>>   		    block_group->space_info == space_info &&
>>   		    block_group->cached != BTRFS_CACHE_NO) {
>> -			down_read(&space_info->groups_sem);
>> +			percpu_down_read(&space_info->groups_sem);
>>   			if (list_empty(&block_group->list) ||
>>   			    block_group->ro) {
>>   				/*
>> @@ -4452,7 +4452,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
>>   				 * valid
>>   				 */
>>   				btrfs_put_block_group(block_group);
>> -				up_read(&space_info->groups_sem);
>> +				percpu_up_read(&space_info->groups_sem);
>>   			} else {
>>   				ffe_ctl->index = btrfs_bg_flags_to_raid_index(
>>   							block_group->flags);
>> @@ -4471,7 +4471,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
>>   	if (ffe_ctl->index == btrfs_bg_flags_to_raid_index(ffe_ctl->flags) ||
>>   	    ffe_ctl->index == 0)
>>   		full_search = true;
>> -	down_read(&space_info->groups_sem);
>> +	percpu_down_read(&space_info->groups_sem);
>>   	list_for_each_entry(block_group,
>>   			    &space_info->block_groups[ffe_ctl->index], list) {
>>   		struct btrfs_block_group *bg_ret;
>> @@ -4609,7 +4609,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
>>   		release_block_group(block_group, ffe_ctl, ffe_ctl->delalloc);
>>   		cond_resched();
>>   	}
>> -	up_read(&space_info->groups_sem);
>> +	percpu_up_read(&space_info->groups_sem);
>>   
>>   	ret = find_free_extent_update_loop(fs_info, ins, ffe_ctl, space_info,
>>   					   full_search);
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index d9e7dd317670..73ff0efc0381 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -2940,12 +2940,12 @@ static long btrfs_ioctl_space_info(struct btrfs_fs_info *fs_info,
>>   		if (!info)
>>   			continue;
>>   
>> -		down_read(&info->groups_sem);
>> +		percpu_down_read(&info->groups_sem);
>>   		for (c = 0; c < BTRFS_NR_RAID_TYPES; c++) {
>>   			if (!list_empty(&info->block_groups[c]))
>>   				slot_count++;
>>   		}
>> -		up_read(&info->groups_sem);
>> +		percpu_up_read(&info->groups_sem);
>>   	}
>>   
>>   	/*
>> @@ -2992,7 +2992,7 @@ static long btrfs_ioctl_space_info(struct btrfs_fs_info *fs_info,
>>   
>>   		if (!info)
>>   			continue;
>> -		down_read(&info->groups_sem);
>> +		percpu_down_read(&info->groups_sem);
>>   		for (c = 0; c < BTRFS_NR_RAID_TYPES; c++) {
>>   			if (!list_empty(&info->block_groups[c])) {
>>   				get_block_group_info(&info->block_groups[c],
>> @@ -3005,7 +3005,7 @@ static long btrfs_ioctl_space_info(struct btrfs_fs_info *fs_info,
>>   			if (!slot_count)
>>   				break;
>>   		}
>> -		up_read(&info->groups_sem);
>> +		percpu_up_read(&info->groups_sem);
>>   	}
>>   
>>   	/*
>> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
>> index 857e4fd2c77e..ddedeccbdade 100644
>> --- a/fs/btrfs/space-info.c
>> +++ b/fs/btrfs/space-info.c
>> @@ -234,13 +234,14 @@ void btrfs_update_space_info_chunk_size(struct btrfs_space_info *space_info,
>>   	WRITE_ONCE(space_info->chunk_size, chunk_size);
>>   }
>>   
>> -static void init_space_info(struct btrfs_fs_info *info,
>> +static int init_space_info(struct btrfs_fs_info *info,
>>   			    struct btrfs_space_info *space_info, u64 flags)
>>   {
>>   	space_info->fs_info = info;
>>   	for (int i = 0; i < BTRFS_NR_RAID_TYPES; i++)
>>   		INIT_LIST_HEAD(&space_info->block_groups[i]);
>> -	init_rwsem(&space_info->groups_sem);
>> +	if (!percpu_init_rwsem(&space_info->groups_sem))
>> +		return -ENOMEM;
>>   	spin_lock_init(&space_info->lock);
>>   	space_info->flags = flags & BTRFS_BLOCK_GROUP_TYPE_MASK;
>>   	space_info->force_alloc = CHUNK_ALLOC_NO_FORCE;
>> @@ -253,6 +254,8 @@ static void init_space_info(struct btrfs_fs_info *info,
>>   
>>   	if (btrfs_is_zoned(info))
>>   		space_info->bg_reclaim_threshold = BTRFS_DEFAULT_ZONED_RECLAIM_THRESH;
>> +
>> +	return 0;
>>   }
>>   
>>   static int create_space_info_sub_group(struct btrfs_space_info *parent, u64 flags,
>> @@ -270,7 +273,10 @@ static int create_space_info_sub_group(struct btrfs_space_info *parent, u64 flag
>>   	if (!sub_group)
>>   		return -ENOMEM;
>>   
>> -	init_space_info(fs_info, sub_group, flags);
>> +	if (init_space_info(fs_info, sub_group, flags)) {
>> +		kfree(sub_group);
>> +		return -ENOMEM;
>> +	}
>>   	parent->sub_group[index] = sub_group;
>>   	sub_group->parent = parent;
>>   	sub_group->subgroup_id = id;
>> @@ -293,7 +299,10 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
>>   	if (!space_info)
>>   		return -ENOMEM;
>>   
>> -	init_space_info(info, space_info, flags);
>> +	if (init_space_info(info, space_info, flags)) {
>> +		kfree(space_info);
>> +		return -ENOMEM;
>> +	}
>>   
>>   	if (btrfs_is_zoned(info)) {
>>   		if (flags & BTRFS_BLOCK_GROUP_DATA)
>> @@ -384,9 +393,9 @@ void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
>>   	block_group->space_info = space_info;
>>   
>>   	index = btrfs_bg_flags_to_raid_index(block_group->flags);
>> -	down_write(&space_info->groups_sem);
>> +	percpu_down_write(&space_info->groups_sem);
>>   	list_add_tail(&block_group->list, &space_info->block_groups[index]);
>> -	up_write(&space_info->groups_sem);
>> +	percpu_up_write(&space_info->groups_sem);
>>   }
>>   
>>   struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *info,
>> @@ -650,7 +659,7 @@ void btrfs_dump_space_info(struct btrfs_space_info *info, u64 bytes,
>>   	if (!dump_block_groups)
>>   		return;
>>   
>> -	down_read(&info->groups_sem);
>> +	percpu_down_read(&info->groups_sem);
>>   again:
>>   	list_for_each_entry(cache, &info->block_groups[index], list) {
>>   		u64 avail;
>> @@ -670,7 +679,7 @@ void btrfs_dump_space_info(struct btrfs_space_info *info, u64 bytes,
>>   	}
>>   	if (++index < BTRFS_NR_RAID_TYPES)
>>   		goto again;
>> -	up_read(&info->groups_sem);
>> +	percpu_up_read(&info->groups_sem);
>>   
>>   	btrfs_info(fs_info, "%llu bytes available across all block groups", total_avail);
>>   }
>> @@ -2095,7 +2104,7 @@ static void do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
>>   	thresh_pct = btrfs_calc_reclaim_threshold(space_info);
>>   	spin_unlock(&space_info->lock);
>>   
>> -	down_read(&space_info->groups_sem);
>> +	percpu_down_read(&space_info->groups_sem);
>>   again:
>>   	list_for_each_entry(bg, &space_info->block_groups[raid], list) {
>>   		u64 thresh;
>> @@ -2127,7 +2136,7 @@ static void do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
>>   		goto again;
>>   	}
>>   
>> -	up_read(&space_info->groups_sem);
>> +	percpu_up_read(&space_info->groups_sem);
>>   }
>>   
>>   void btrfs_space_info_update_reclaimable(struct btrfs_space_info *space_info, s64 bytes)
>> diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
>> index 0703f24b23f7..f99624069391 100644
>> --- a/fs/btrfs/space-info.h
>> +++ b/fs/btrfs/space-info.h
>> @@ -175,7 +175,7 @@ struct btrfs_space_info {
>>   	 */
>>   	u64 tickets_id;
>>   
>> -	struct rw_semaphore groups_sem;
>> +	struct percpu_rw_semaphore groups_sem;
>>   	/* for block groups in our same type */
>>   	struct list_head block_groups[BTRFS_NR_RAID_TYPES];
>>   
>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
>> index ebd6d1d6778b..ccec9eb1fa4f 100644
>> --- a/fs/btrfs/sysfs.c
>> +++ b/fs/btrfs/sysfs.c
>> @@ -701,14 +701,14 @@ static ssize_t raid_bytes_show(struct kobject *kobj,
>>   	int index = btrfs_bg_flags_to_raid_index(to_raid_kobj(kobj)->flags);
>>   	u64 val = 0;
>>   
>> -	down_read(&sinfo->groups_sem);
>> +	percpu_down_read(&sinfo->groups_sem);
>>   	list_for_each_entry(block_group, &sinfo->block_groups[index], list) {
>>   		if (&attr->attr == BTRFS_ATTR_PTR(raid, total_bytes))
>>   			val += block_group->length;
>>   		else
>>   			val += block_group->used;
>>   	}
>> -	up_read(&sinfo->groups_sem);
>> +	percpu_up_read(&sinfo->groups_sem);
>>   	return sysfs_emit(buf, "%llu\n", val);
>>   }
>>   
>> @@ -816,7 +816,7 @@ static ssize_t btrfs_size_classes_show(struct kobject *kobj,
>>   	u32 large = 0;
>>   
>>   	for (int i = 0; i < BTRFS_NR_RAID_TYPES; ++i) {
>> -		down_read(&sinfo->groups_sem);
>> +		percpu_down_read(&sinfo->groups_sem);
>>   		list_for_each_entry(bg, &sinfo->block_groups[i], list) {
>>   			if (!btrfs_block_group_should_use_size_class(bg))
>>   				continue;
>> @@ -835,7 +835,7 @@ static ssize_t btrfs_size_classes_show(struct kobject *kobj,
>>   				break;
>>   			}
>>   		}
>> -		up_read(&sinfo->groups_sem);
>> +		percpu_up_read(&sinfo->groups_sem);
>>   	}
>>   	return sysfs_emit(buf, "none %u\n"
>>   			       "small %u\n"
>> @@ -1046,6 +1046,7 @@ ATTRIBUTE_GROUPS(space_info);
>>   static void space_info_release(struct kobject *kobj)
>>   {
>>   	struct btrfs_space_info *sinfo = to_space_info(kobj);
>> +	percpu_free_rwsem(&sinfo->groups_sem);
>>   	kfree(sinfo);
>>   }
>>   
>> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
>> index 2e861eef5cd8..da92b0d38a1b 100644
>> --- a/fs/btrfs/zoned.c
>> +++ b/fs/btrfs/zoned.c
>> @@ -2588,12 +2588,11 @@ void btrfs_zoned_reserve_data_reloc_bg(struct btrfs_fs_info *fs_info)
>>   			       "reloc_sinfo->subgroup_id=%d", reloc_sinfo->subgroup_id);
>>   			factor = btrfs_bg_type_to_factor(bg->flags);
>>   
>> -			down_write(&space_info->groups_sem);
>> +			percpu_down_write(&space_info->groups_sem);
>>   			list_del_init(&bg->list);
>>   			/* We can assume this as we choose the second empty one. */
>>   			ASSERT(!list_empty(&space_info->block_groups[index]));
>> -			up_write(&space_info->groups_sem);
>> -
>> +			percpu_up_write(&space_info->groups_sem);
>>   			spin_lock(&space_info->lock);
>>   			space_info->total_bytes -= bg->length;
>>   			space_info->disk_total -= bg->length * factor;
>> @@ -2771,7 +2770,7 @@ int btrfs_zoned_activate_one_bg(struct btrfs_space_info *space_info, bool do_fin
>>   		int ret;
>>   		bool need_finish = false;
>>   
>> -		down_read(&space_info->groups_sem);
>> +		percpu_down_read(&space_info->groups_sem);
>>   		for (index = 0; index < BTRFS_NR_RAID_TYPES; index++) {
>>   			list_for_each_entry(bg, &space_info->block_groups[index],
>>   					    list) {
>> @@ -2786,14 +2785,14 @@ int btrfs_zoned_activate_one_bg(struct btrfs_space_info *space_info, bool do_fin
>>   				spin_unlock(&bg->lock);
>>   
>>   				if (btrfs_zone_activate(bg)) {
>> -					up_read(&space_info->groups_sem);
>> +					percpu_up_read(&space_info->groups_sem);
>>   					return 1;
>>   				}
>>   
>>   				need_finish = true;
>>   			}
>>   		}
>> -		up_read(&space_info->groups_sem);
>> +		percpu_up_read(&space_info->groups_sem);
>>   
>>   		if (!do_finish || !need_finish)
>>   			break;
>> -- 
>> 2.39.5
>>


