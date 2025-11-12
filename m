Return-Path: <linux-btrfs+bounces-18898-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AFEC5402B
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 19:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7FDDA3466DF
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 18:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF864335573;
	Wed, 12 Nov 2025 18:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="GkIhh5oq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8988134B1A2
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Nov 2025 18:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762973511; cv=none; b=qseayaWBkrwE0n51o6WksRtBvZSQZg28JC6j3tzK0eZmFoiYmHQ1tIqS85VCWZwvpGxCZZl7SjxMa2HIUol8v3vSoiEq+DI4PMuY9+GCFmzNAuQzh7Vh9tuj5vokDlkqIVsATN7bqhu1OmoEtqLYN2P78pa1LDpRdw0Y3sG+t9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762973511; c=relaxed/simple;
	bh=jlPtygbj3iITSchFoRr22BemzN6B0qrUlm76i6/JltE=;
	h=Message-ID:Date:Mime-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I4Zc8kF6Fdi/4MK9/6SwOfFEV8Y3K2cxw0D4/PCUL4CFIkPh8V9YRoNDqG2me8usJAD61dJGOc3bDs0X18CUK2b0IT9fvXzrfqJAAVLclOlD7lmHV9Gdu5LoR0imEGOj4THhjzYFj5otJNxYGQGjczQ4ZgNBYnBMluK/mHu7/KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=GkIhh5oq; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from [IPV6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2] (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id B7B842D9CC4;
	Wed, 12 Nov 2025 18:51:42 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1762973502;
	bh=bOeifQc2FboYTti/u/OUi7ldXY+VVLD6yZY+qbEzP9o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GkIhh5oqWvRPOjT03EjDfQBxNej+MQddoBiO9kzi3Z1kB2m3jRH1llwmOc3aIWOlE
	 kMYPtSXb4FbS5KO09R3OFwBbHzYvXGVkxuo5m8RIoVLsHBwi8F3V54I0vbn71Xa5XC
	 1D2OFhDfX/mepWpLz3xS3ONkgFA3nats9PjLBSdc=
Message-ID: <c2db973e-a5ff-4268-adc9-df36aa0e59a9@harmstone.com>
Date: Wed, 12 Nov 2025 18:51:42 +0000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v5 09/16] btrfs: handle deletions from remapped block
 group
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <20251110171511.20900-1-mark@harmstone.com>
 <20251110171511.20900-10-mark@harmstone.com>
 <aRQXxL7i/mc32zF6@devvm12410.ftw0.facebook.com>
Content-Language: en-US
From: Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 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
In-Reply-To: <aRQXxL7i/mc32zF6@devvm12410.ftw0.facebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/2025 5.14 am, Boris Burkov wrote:
> On Mon, Nov 10, 2025 at 05:14:33PM +0000, Mark Harmstone wrote:
>> Handle the case where we free an extent from a block group that has the
>> REMAPPED flag set. Because the remap tree is orthogonal to the extent
>> tree, for data this may be within any number of identity remaps or
>> actual remaps. If we're freeing a metadata node, this will be wholly
>> inside one or the other.
>>
>> btrfs_remove_extent_from_remap_tree() searches the remap tree for the
>> remaps that cover the range in question, then calls
>> remove_range_from_remap_tree() for each one, to punch a hole in the
>> remap and adjust the free-space tree.
>>
>> For an identity remap, remove_range_from_remap_tree() will adjust the
>> block group's `identity_remap_count` if this changes. If it reaches
>> zero we mark the block group as fully remapped.
>>
>> When we commit the transaction, fully remapped block groups have their
>> chunk stripes removed and their device extents freed, which makes the
>> disk space available again to the chunk allocator.
>>
>> This is done when committing the transaction because it's a quick, rare
>> operation which prevents the chunk allocator from ENOSPCing - but see
> 
> More special cases in the transaction commit requires more justification
> than this IMO. Did you see such enospcs in trivial cases? Can you
> characterize the impact more precisely? It also feels like something
> more appropriate for an enospc flusher than transaction commit if it is
> urgently needed to prevent enospc. A transaction commit isn't something
> that runs naturally that quickly, and from a quick read through the
> chunk allocation code, I don't think that it will trigger flushing that
> will commit a transaction. Perhaps by the time we get to chunk
> allocation we are in such a path, though.
> 
> To include this here (as opposed to a flush step or in the cleaner
> thread or some other worker) I would like to see concrete evidence for
> why it is needed, rather that optimistically maybe helpful for
> preventing ENOSPC.
> 
> I am convinced that it is quick, so if it is demonstrably helpful, I
> don't think I mind it being there.
> 
>> later patches which do this asynchronously for the case of async
>> discard.
>>
>> Signed-off-by: Mark Harmstone <mark@harmstone.com>
>> ---
>>   fs/btrfs/block-group.c | 110 ++++++++---
>>   fs/btrfs/block-group.h |   4 +
>>   fs/btrfs/disk-io.c     |   2 +
>>   fs/btrfs/extent-tree.c |  77 +++++++-
>>   fs/btrfs/extent-tree.h |   1 +
>>   fs/btrfs/fs.h          |   4 +-
>>   fs/btrfs/relocation.c  | 420 +++++++++++++++++++++++++++++++++++++++++
>>   fs/btrfs/relocation.h  |   6 +
>>   fs/btrfs/transaction.c |   4 +
>>   fs/btrfs/volumes.c     |  56 +++---
>>   fs/btrfs/volumes.h     |   6 +
>>   11 files changed, 636 insertions(+), 54 deletions(-)
>>
>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>> index 3ebce7d6aae0..0e41b311aa3d 100644
>> --- a/fs/btrfs/block-group.c
>> +++ b/fs/btrfs/block-group.c
>> @@ -1068,6 +1068,32 @@ static int remove_block_group_item(struct btrfs_trans_handle *trans,
>>   	return ret;
>>   }
>>   
>> +void btrfs_remove_bg_from_sinfo(struct btrfs_block_group *block_group)
>> +{
>> +	int factor = btrfs_bg_type_to_factor(block_group->flags);
>> +
>> +	spin_lock(&block_group->space_info->lock);
>> +
>> +	if (btrfs_test_opt(block_group->fs_info, ENOSPC_DEBUG)) {
>> +		WARN_ON(block_group->space_info->total_bytes
>> +			< block_group->length);
>> +		WARN_ON(block_group->space_info->bytes_readonly
>> +			< block_group->length - block_group->zone_unusable);
>> +		WARN_ON(block_group->space_info->bytes_zone_unusable
>> +			< block_group->zone_unusable);
>> +		WARN_ON(block_group->space_info->disk_total
>> +			< block_group->length * factor);
>> +	}
>> +	block_group->space_info->total_bytes -= block_group->length;
>> +	block_group->space_info->bytes_readonly -=
>> +		(block_group->length - block_group->zone_unusable);
>> +	btrfs_space_info_update_bytes_zone_unusable(block_group->space_info,
>> +						    -block_group->zone_unusable);
>> +	block_group->space_info->disk_total -= block_group->length * factor;
>> +
>> +	spin_unlock(&block_group->space_info->lock);
>> +}
>> +
>>   int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
>>   			     struct btrfs_chunk_map *map)
>>   {
>> @@ -1079,7 +1105,6 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
>>   	struct kobject *kobj = NULL;
>>   	int ret;
>>   	int index;
>> -	int factor;
>>   	struct btrfs_caching_control *caching_ctl = NULL;
>>   	bool remove_map;
>>   	bool remove_rsv = false;
>> @@ -1088,7 +1113,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
>>   	if (!block_group)
>>   		return -ENOENT;
>>   
>> -	BUG_ON(!block_group->ro);
>> +	BUG_ON(!block_group->ro && !(block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED));
>>   
>>   	trace_btrfs_remove_block_group(block_group);
>>   	/*
>> @@ -1100,7 +1125,6 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
>>   				  block_group->length);
>>   
>>   	index = btrfs_bg_flags_to_raid_index(block_group->flags);
>> -	factor = btrfs_bg_type_to_factor(block_group->flags);
>>   
>>   	/* make sure this block group isn't part of an allocation cluster */
>>   	cluster = &fs_info->data_alloc_cluster;
>> @@ -1224,26 +1248,11 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
>>   
>>   	spin_lock(&block_group->space_info->lock);
>>   	list_del_init(&block_group->ro_list);
>> -
>> -	if (btrfs_test_opt(fs_info, ENOSPC_DEBUG)) {
>> -		WARN_ON(block_group->space_info->total_bytes
>> -			< block_group->length);
>> -		WARN_ON(block_group->space_info->bytes_readonly
>> -			< block_group->length - block_group->zone_unusable);
>> -		WARN_ON(block_group->space_info->bytes_zone_unusable
>> -			< block_group->zone_unusable);
>> -		WARN_ON(block_group->space_info->disk_total
>> -			< block_group->length * factor);
>> -	}
>> -	block_group->space_info->total_bytes -= block_group->length;
>> -	block_group->space_info->bytes_readonly -=
>> -		(block_group->length - block_group->zone_unusable);
>> -	btrfs_space_info_update_bytes_zone_unusable(block_group->space_info,
>> -						    -block_group->zone_unusable);
>> -	block_group->space_info->disk_total -= block_group->length * factor;
>> -
>>   	spin_unlock(&block_group->space_info->lock);
>>   
>> +	if (!(block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED))
>> +		btrfs_remove_bg_from_sinfo(block_group);
>> +
>>   	/*
>>   	 * Remove the free space for the block group from the free space tree
>>   	 * and the block group's item from the extent tree before marking the
>> @@ -1578,7 +1587,8 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>>   
>>   		spin_lock(&space_info->lock);
>>   		spin_lock(&block_group->lock);
>> -		if (btrfs_is_block_group_used(block_group) || block_group->ro ||
>> +		if (btrfs_is_block_group_used(block_group) ||
>> +		    (block_group->ro && !(block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED)) ||
>>   		    list_is_singular(&block_group->list)) {
>>   			/*
>>   			 * We want to bail if we made new allocations or have
>> @@ -1620,9 +1630,10 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>>   		 * needing to allocate extents from the block group.
>>   		 */
>>   		used = btrfs_space_info_used(space_info, true);
>> -		if ((space_info->total_bytes - block_group->length < used &&
>> -		     block_group->zone_unusable < block_group->length) ||
>> -		    has_unwritten_metadata(block_group)) {
>> +		if (((space_info->total_bytes - block_group->length < used &&
>> +		      block_group->zone_unusable < block_group->length) ||
>> +		     has_unwritten_metadata(block_group)) &&
>> +		    !(block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED)) {
>>   			/*
>>   			 * Add a reference for the list, compensate for the ref
>>   			 * drop under the "next" label for the
>> @@ -1783,6 +1794,15 @@ void btrfs_mark_bg_unused(struct btrfs_block_group *bg)
>>   	struct btrfs_fs_info *fs_info = bg->fs_info;
>>   
>>   	spin_lock(&fs_info->unused_bgs_lock);
>> +
>> +	/* Leave fully remapped block groups on the fully_remapped_bgs list. */
>> +	if (bg->flags & BTRFS_BLOCK_GROUP_REMAPPED &&
>> +	    bg->identity_remap_count == 0 &&
>> +	    !list_empty(&bg->bg_list)) {
>> +		spin_unlock(&fs_info->unused_bgs_lock);
>> +		return;
>> +	}
>> +
> 
> Why not include this as an additional else-if after the if (list_empty)
> fails?
> 
> This is not blocking for this patch, but I just wanted to say it while
> I'm thinking it: I think it's probably time for an enum tracking which
> list bg_list is linked to which we assert on and set. I'll probably take
> a crack at that after you land this series.
> 
>>   	if (list_empty(&bg->bg_list)) {
>>   		btrfs_get_block_group(bg);
>>   		trace_btrfs_add_unused_block_group(bg);
>> @@ -4600,6 +4620,14 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
>>   		list_del_init(&block_group->bg_list);
>>   		btrfs_put_block_group(block_group);
>>   	}
>> +
>> +	while (!list_empty(&info->fully_remapped_bgs)) {
>> +		block_group = list_first_entry(&info->fully_remapped_bgs,
>> +					       struct btrfs_block_group,
>> +					       bg_list);
>> +		list_del_init(&block_group->bg_list);
>> +		btrfs_put_block_group(block_group);
>> +	}
>>   	spin_unlock(&info->unused_bgs_lock);
>>   
>>   	spin_lock(&info->zone_active_bgs_lock);
>> @@ -4787,3 +4815,35 @@ bool btrfs_block_group_should_use_size_class(const struct btrfs_block_group *bg)
>>   		return false;
>>   	return true;
>>   }
>> +
>> +void btrfs_mark_bg_fully_remapped(struct btrfs_block_group *bg,
>> +				  struct btrfs_trans_handle *trans)
>> +{
>> +	struct btrfs_fs_info *fs_info = trans->fs_info;
>> +	bool already_done;
>> +
>> +	spin_lock(&bg->lock);
>> +	already_done = bg->fully_remapped;
>> +	bg->fully_remapped = true;
>> +	spin_unlock(&bg->lock);
>> +
>> +	if (already_done)
>> +		return;
>> +
>> +	spin_lock(&fs_info->unused_bgs_lock);
>> +
>> +	/*
>> +	 * The block group might already be on the unused_bgs list, remove it
>> +	 * if it is. It'll get readded after the async discard worker finishes,
>> +	 * or in btrfs_handle_fully_remapped_bgs() if we're not using async
>> +	 * discard.
>> +	 */
> 
> As far as I can tell, this code is called from contexts which might not
> be holding the reclaim mutex (extent freeing delayed ref logic) which
> means it could run concurrently with btrfs_delete_unused_bgs(). Or is
> the fact that we are not yet fully remapped mean that the remap logic is
> still running while holding that mutex, so delete_unused_bgs can't run?
> 
> With that in mind, I am somewhat concerned about the possibility that we
> might be *on* the unused bgs list at this time, unless you know the
> delete can't run concurrently, or that the remapped handling all assumes
> it's possible we have concurrently run delete?

btrfs_mark_bg_fully_remapped() is called when the last identity remap of 
a BG is removed: either from the relocation thread, or from deleting an 
inode. So if balance is interrupted, it's possible for it to be run 
without the reclaim mutex being held.

I think I need to investigate exactly why this can be called for a BG 
that's on the unused_bgs list, it's not obvious why that can happen.

>> +	if (!list_empty(&bg->bg_list))
>> +		list_del(&bg->bg_list);
>> +	else
>> +		btrfs_get_block_group(bg);
>> +
>> +	list_add_tail(&bg->bg_list, &fs_info->fully_remapped_bgs);
>> +
>> +	spin_unlock(&fs_info->unused_bgs_lock);
>> +}
>> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
>> index af23fdb3cf4d..d85f3c2546d0 100644
>> --- a/fs/btrfs/block-group.h
>> +++ b/fs/btrfs/block-group.h
>> @@ -282,6 +282,7 @@ struct btrfs_block_group {
>>   	struct extent_buffer *last_eb;
>>   	enum btrfs_block_group_size_class size_class;
>>   	u64 reclaim_mark;
>> +	bool fully_remapped;
>>   };
>>   
>>   static inline u64 btrfs_block_group_end(const struct btrfs_block_group *block_group)
>> @@ -336,6 +337,7 @@ int btrfs_add_new_free_space(struct btrfs_block_group *block_group,
>>   struct btrfs_trans_handle *btrfs_start_trans_remove_block_group(
>>   				struct btrfs_fs_info *fs_info,
>>   				const u64 chunk_offset);
>> +void btrfs_remove_bg_from_sinfo(struct btrfs_block_group *block_group);
>>   int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
>>   			     struct btrfs_chunk_map *map);
>>   void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info);
>> @@ -407,5 +409,7 @@ int btrfs_use_block_group_size_class(struct btrfs_block_group *bg,
>>   				     enum btrfs_block_group_size_class size_class,
>>   				     bool force_wrong_size_class);
>>   bool btrfs_block_group_should_use_size_class(const struct btrfs_block_group *bg);
>> +void btrfs_mark_bg_fully_remapped(struct btrfs_block_group *bg,
>> +				  struct btrfs_trans_handle *trans);
>>   
>>   #endif /* BTRFS_BLOCK_GROUP_H */
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index 9012ecbf5b48..908f706cf409 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -2871,6 +2871,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
>>   	INIT_LIST_HEAD(&fs_info->tree_mod_seq_list);
>>   	INIT_LIST_HEAD(&fs_info->unused_bgs);
>>   	INIT_LIST_HEAD(&fs_info->reclaim_bgs);
>> +	INIT_LIST_HEAD(&fs_info->fully_remapped_bgs);
>>   	INIT_LIST_HEAD(&fs_info->zone_active_bgs);
>>   #ifdef CONFIG_BTRFS_DEBUG
>>   	INIT_LIST_HEAD(&fs_info->allocated_roots);
>> @@ -2926,6 +2927,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
>>   	mutex_init(&fs_info->chunk_mutex);
>>   	mutex_init(&fs_info->transaction_kthread_mutex);
>>   	mutex_init(&fs_info->cleaner_mutex);
>> +	mutex_init(&fs_info->remap_mutex);
>>   	mutex_init(&fs_info->ro_block_group_mutex);
>>   	init_rwsem(&fs_info->commit_root_sem);
>>   	init_rwsem(&fs_info->cleanup_work_sem);
>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>> index a7e522f67cca..4bda12cdf697 100644
>> --- a/fs/btrfs/extent-tree.c
>> +++ b/fs/btrfs/extent-tree.c
>> @@ -41,6 +41,7 @@
>>   #include "tree-checker.h"
>>   #include "raid-stripe-tree.h"
>>   #include "delayed-inode.h"
>> +#include "relocation.h"
>>   
>>   #undef SCRAMBLE_DELAYED_REFS
>>   
>> @@ -2846,6 +2847,52 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
>>   	return 0;
>>   }
>>   
>> +int btrfs_handle_fully_remapped_bgs(struct btrfs_trans_handle *trans)
>> +{
>> +	struct btrfs_fs_info *fs_info = trans->fs_info;
>> +	struct btrfs_block_group *block_group, *tmp;
>> +	struct list_head *fully_remapped_bgs;
>> +	int ret;
>> +
>> +	fully_remapped_bgs = &fs_info->fully_remapped_bgs;
>> +	list_for_each_entry_safe(block_group, tmp, fully_remapped_bgs, bg_list) {
> 
> I'm skeptical on deviating from the usual pattern of the while loop
> using the unused_bgs_lock and taking the first element used in the other
> bg_list iterations (delete_unused_bgs, reclaim_bgs_work).
> 
> Particularly the not taking the lock part, and not removing it from the
> list. I'm open to the lock not being important with the _safe iterator.
> 
> But I believe that not clearing factors into you having a custom
> re-implementation of btrfs_mark_bg_unused at the end of
> btrfs_trim_fully_remapped_block_groups, right?
> 
> Can you justify this?
> 
>> +		struct btrfs_chunk_map *map;
>> +
>> +		map = btrfs_get_chunk_map(fs_info, block_group->start, 1);
>> +		if (IS_ERR(map))
>> +			return PTR_ERR(map);
>> +
>> +		ret = btrfs_last_identity_remap_gone(trans, map, block_group);
>> +		if (ret) {
>> +			btrfs_free_chunk_map(map);
>> +			return ret;
>> +		}
>> +
>> +		/*
>> +		 * Set num_stripes to 0, so that btrfs_remove_dev_extents()
>> +		 * won't run a second time.
>> +		 */
>> +		map->num_stripes = 0;
>> +
>> +		btrfs_free_chunk_map(map);
>> +
>> +		if (block_group->used == 0) {
>> +			spin_lock(&fs_info->unused_bgs_lock);
>> +			list_move_tail(&block_group->bg_list,
>> +				       &fs_info->unused_bgs);
>> +			spin_unlock(&fs_info->unused_bgs_lock);
>> +		} else {
>> +			spin_lock(&fs_info->unused_bgs_lock);
>> +			list_del_init(&block_group->bg_list);
>> +			spin_unlock(&fs_info->unused_bgs_lock);
>> +
>> +			btrfs_put_block_group(block_group);
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
>>   {
>>   	struct btrfs_fs_info *fs_info = trans->fs_info;
>> @@ -2998,11 +3045,23 @@ u64 btrfs_get_extent_owner_root(struct btrfs_fs_info *fs_info,
>>   }
>>   
>>   static int do_free_extent_accounting(struct btrfs_trans_handle *trans,
>> -				     u64 bytenr, struct btrfs_squota_delta *delta)
>> +				     u64 bytenr, struct btrfs_squota_delta *delta,
>> +				     struct btrfs_path *path)
>>   {
>>   	int ret;
>> +	bool remapped = false;
>>   	u64 num_bytes = delta->num_bytes;
>>   
>> +	/* returns 1 on success and 0 on no-op */
>> +	ret = btrfs_remove_extent_from_remap_tree(trans, path, bytenr,
>> +						  num_bytes);
>> +	if (ret < 0) {
>> +		btrfs_abort_transaction(trans, ret);
>> +		return ret;
>> +	} else if (ret == 1) {
>> +		remapped = true;
>> +	}
>> +
>>   	if (delta->is_data) {
>>   		struct btrfs_root *csum_root;
>>   
>> @@ -3026,10 +3085,16 @@ static int do_free_extent_accounting(struct btrfs_trans_handle *trans,
>>   		return ret;
>>   	}
>>   
>> -	ret = btrfs_add_to_free_space_tree(trans, bytenr, num_bytes);
>> -	if (unlikely(ret)) {
>> -		btrfs_abort_transaction(trans, ret);
>> -		return ret;
>> +	/*
>> +	 * If remapped, FST has already been taken care of in
>> +	 * remove_range_from_remap_tree().
>> +	 */
>> +	if (!remapped) {
>> +		ret = btrfs_add_to_free_space_tree(trans, bytenr, num_bytes);
>> +		if (unlikely(ret)) {
>> +			btrfs_abort_transaction(trans, ret);
>> +			return ret;
>> +		}
>>   	}
>>   
>>   	ret = btrfs_update_block_group(trans, bytenr, num_bytes, false);
>> @@ -3395,7 +3460,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
>>   		}
>>   		btrfs_release_path(path);
>>   
>> -		ret = do_free_extent_accounting(trans, bytenr, &delta);
>> +		ret = do_free_extent_accounting(trans, bytenr, &delta, path);
>>   	}
>>   	btrfs_release_path(path);
>>   
>> diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
>> index e573509c5a71..01cb317677fa 100644
>> --- a/fs/btrfs/extent-tree.h
>> +++ b/fs/btrfs/extent-tree.h
>> @@ -163,5 +163,6 @@ void btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info, u64 start, u6
>>   int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
>>   			 u64 num_bytes, u64 *actual_bytes);
>>   int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range);
>> +int btrfs_handle_fully_remapped_bgs(struct btrfs_trans_handle *trans);
>>   
>>   #endif
>> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
>> index 03cb4aafbb2c..a1c97c3c5ed6 100644
>> --- a/fs/btrfs/fs.h
>> +++ b/fs/btrfs/fs.h
>> @@ -573,6 +573,7 @@ struct btrfs_fs_info {
>>   	struct mutex transaction_kthread_mutex;
>>   	struct mutex cleaner_mutex;
>>   	struct mutex chunk_mutex;
>> +	struct mutex remap_mutex;
>>   
>>   	/*
>>   	 * This is taken to make sure we don't set block groups ro after the
>> @@ -826,10 +827,11 @@ struct btrfs_fs_info {
>>   	struct list_head reclaim_bgs;
>>   	int bg_reclaim_threshold;
>>   
>> -	/* Protects the lists unused_bgs and reclaim_bgs. */
>> +	/* Protects the lists unused_bgs, reclaim_bgs, and fully_remapped_bgs. */
>>   	spinlock_t unused_bgs_lock;
>>   	/* Protected by unused_bgs_lock. */
>>   	struct list_head unused_bgs;
>> +	struct list_head fully_remapped_bgs;
>>   	struct mutex unused_bg_unpin_mutex;
>>   	/* Protect block groups that are going to be deleted */
>>   	struct mutex reclaim_bgs_lock;
>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>> index 00e1898edbbe..49488c125b5c 100644
>> --- a/fs/btrfs/relocation.c
>> +++ b/fs/btrfs/relocation.c
>> @@ -37,6 +37,7 @@
>>   #include "super.h"
>>   #include "tree-checker.h"
>>   #include "raid-stripe-tree.h"
>> +#include "free-space-tree.h"
>>   
>>   /*
>>    * Relocation overview
>> @@ -3860,6 +3861,151 @@ static const char *stage_to_string(enum reloc_stage stage)
>>   	return "unknown";
>>   }
>>   
>> +static void adjust_block_group_remap_bytes(struct btrfs_trans_handle *trans,
>> +					   struct btrfs_block_group *bg,
>> +					   s64 diff)
>> +{
>> +	struct btrfs_fs_info *fs_info = trans->fs_info;
>> +	bool bg_already_dirty = true, mark_unused = false;
>> +
>> +	spin_lock(&bg->lock);
>> +
>> +	bg->remap_bytes += diff;
>> +
>> +	if (bg->used == 0 && bg->remap_bytes == 0)
>> +		mark_unused = true;
>> +
>> +	spin_unlock(&bg->lock);
>> +
>> +	if (mark_unused)
>> +		btrfs_mark_bg_unused(bg);
> 
> This feels inconsistent with the other treatments of async discard and
> mark_bg_unused. Should we fold the async discard check into
> btrfs_mark_bg_unused?
> 
> Sorry if I missed you fixing this further in the later async discard
> patches but I couldn't find it.

This is a different thing, this is for the destination block group.

The three figures for the block groups are:

* used: the bytes nominally within the block group

* remap_bytes: the bytes physically within the block group, but 
nominally elsewhere. If REMAPPED flag set, remap_bytes must == 0

* identity_remap_count: the number of identity remaps for this block 
group. So must == 0 if REMAPPED flag not set. Count rather than bytes 
because we only care if it's 0 or not

So if you remap a 4KB identity remap it does the following:

			src_bg			dest_bg
			------			-------
used			unchanged		unchanged
remap_bytes		unchanged (== 0)	+4096
identity_remap_count	-1			unchanged (== 0)
>> +
>> +	spin_lock(&trans->transaction->dirty_bgs_lock);
>> +	if (list_empty(&bg->dirty_list)) {
>> +		list_add_tail(&bg->dirty_list, &trans->transaction->dirty_bgs);
>> +		bg_already_dirty = false;
>> +		btrfs_get_block_group(bg);
>> +	}
>> +	spin_unlock(&trans->transaction->dirty_bgs_lock);
>> +
>> +	/* Modified block groups are accounted for in the delayed_refs_rsv. */
>> +	if (!bg_already_dirty)
>> +		btrfs_inc_delayed_refs_rsv_bg_updates(fs_info);
>> +}
>> +
>> +static int remove_chunk_stripes(struct btrfs_trans_handle *trans,
>> +				struct btrfs_chunk_map *chunk,
>> +				struct btrfs_path *path)
>> +{
>> +	struct btrfs_fs_info *fs_info = trans->fs_info;
>> +	struct btrfs_key key;
>> +	struct extent_buffer *leaf;
>> +	struct btrfs_chunk *c;
>> +	int ret;
>> +
>> +	key.objectid = BTRFS_FIRST_CHUNK_TREE_OBJECTID;
>> +	key.type = BTRFS_CHUNK_ITEM_KEY;
>> +	key.offset = chunk->start;
>> +
>> +	ret = btrfs_search_slot(trans, fs_info->chunk_root, &key, path,
>> +				0, 1);
>> +	if (ret) {
>> +		if (ret == 1) {
>> +			btrfs_release_path(path);
>> +			ret = -ENOENT;
>> +		}
>> +		return ret;
>> +	}
>> +
>> +	leaf = path->nodes[0];
>> +
>> +	c = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_chunk);
>> +	btrfs_set_chunk_num_stripes(leaf, c, 0);
>> +	btrfs_set_chunk_sub_stripes(leaf, c, 0);
>> +
>> +	btrfs_truncate_item(trans, path, offsetof(struct btrfs_chunk, stripe),
>> +			    1);
>> +
>> +	btrfs_mark_buffer_dirty(trans, leaf);
>> +
>> +	btrfs_release_path(path);
>> +
>> +	return 0;
>> +}
>> +
>> +int btrfs_last_identity_remap_gone(struct btrfs_trans_handle *trans,
>> +				   struct btrfs_chunk_map *chunk,
>> +				   struct btrfs_block_group *bg)
>> +{
>> +	int ret;
>> +	BTRFS_PATH_AUTO_FREE(path);
>> +
>> +	ret = btrfs_remove_dev_extents(trans, chunk);
>> +	if (ret)
>> +		return ret;
>> +
>> +	mutex_lock(&trans->fs_info->chunk_mutex);
>> +
>> +	for (unsigned int i = 0; i < chunk->num_stripes; i++) {
>> +		ret = btrfs_update_device(trans, chunk->stripes[i].dev);
>> +		if (ret) {
>> +			mutex_unlock(&trans->fs_info->chunk_mutex);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	mutex_unlock(&trans->fs_info->chunk_mutex);
>> +
>> +	write_lock(&trans->fs_info->mapping_tree_lock);
>> +	btrfs_chunk_map_device_clear_bits(chunk, CHUNK_ALLOCATED);
>> +	write_unlock(&trans->fs_info->mapping_tree_lock);
>> +
>> +	btrfs_remove_bg_from_sinfo(bg);
>> +
>> +	path = btrfs_alloc_path();
>> +	if (!path)
>> +		return -ENOMEM;
>> +
>> +	ret = remove_chunk_stripes(trans, chunk, path);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +
>> +static void adjust_identity_remap_count(struct btrfs_trans_handle *trans,
>> +				        struct btrfs_block_group *bg, int delta)
>> +{
>> +	struct btrfs_fs_info *fs_info = trans->fs_info;
>> +	bool bg_already_dirty = true, mark_fully_remapped = false;
>> +
>> +	WARN_ON(delta < 0 && -delta > bg->identity_remap_count);
>> +
>> +	spin_lock(&bg->lock);
>> +
>> +	bg->identity_remap_count += delta;
>> +
>> +	if (!bg->fully_remapped && bg->identity_remap_count == 0)
>> +		mark_fully_remapped = true;
>> +
>> +	spin_unlock(&bg->lock);
>> +
>> +	spin_lock(&trans->transaction->dirty_bgs_lock);
>> +	if (list_empty(&bg->dirty_list)) {
>> +		list_add_tail(&bg->dirty_list, &trans->transaction->dirty_bgs);
>> +		bg_already_dirty = false;
>> +		btrfs_get_block_group(bg);
>> +	}
>> +	spin_unlock(&trans->transaction->dirty_bgs_lock);
>> +
>> +	/* Modified block groups are accounted for in the delayed_refs_rsv. */
>> +	if (!bg_already_dirty)
>> +		btrfs_inc_delayed_refs_rsv_bg_updates(fs_info);
>> +
>> +	if (mark_fully_remapped)
>> +		btrfs_mark_bg_fully_remapped(bg, trans);
>> +}
>> +
>>   int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
>>   			  u64 *length)
>>   {
>> @@ -4468,3 +4614,277 @@ u64 btrfs_get_reloc_bg_bytenr(const struct btrfs_fs_info *fs_info)
>>   		logical = fs_info->reloc_ctl->block_group->start;
>>   	return logical;
>>   }
>> +
>> +static int insert_remap_item(struct btrfs_trans_handle *trans,
>> +			     struct btrfs_path *path, u64 old_addr, u64 length,
>> +			     u64 new_addr)
>> +{
>> +	int ret;
>> +	struct btrfs_fs_info *fs_info = trans->fs_info;
>> +	struct btrfs_key key;
>> +	struct btrfs_remap remap;
>> +
>> +	if (old_addr == new_addr) {
>> +		/* Add new identity remap item. */
>> +
>> +		key.objectid = old_addr;
>> +		key.type = BTRFS_IDENTITY_REMAP_KEY;
>> +		key.offset = length;
>> +
>> +		ret = btrfs_insert_empty_item(trans, fs_info->remap_root,
>> +					      path, &key, 0);
>> +		if (ret)
>> +			return ret;
>> +	} else {
>> +		/* Add new remap item. */
>> +
>> +		key.objectid = old_addr;
>> +		key.type = BTRFS_REMAP_KEY;
>> +		key.offset = length;
>> +
>> +		ret = btrfs_insert_empty_item(trans, fs_info->remap_root,
>> +					      path, &key,
>> +					      sizeof(struct btrfs_remap));
>> +		if (ret)
>> +			return ret;
>> +
>> +		btrfs_set_stack_remap_address(&remap, new_addr);
>> +
>> +		write_extent_buffer(path->nodes[0], &remap,
>> +			btrfs_item_ptr_offset(path->nodes[0], path->slots[0]),
>> +			sizeof(struct btrfs_remap));
>> +
>> +		btrfs_release_path(path);
>> +
>> +		/* Add new backref item. */
>> +
>> +		key.objectid = new_addr;
>> +		key.type = BTRFS_REMAP_BACKREF_KEY;
>> +		key.offset = length;
>> +
>> +		ret = btrfs_insert_empty_item(trans, fs_info->remap_root,
>> +					      path, &key,
>> +					      sizeof(struct btrfs_remap));
>> +		if (ret)
>> +			return ret;
>> +
>> +		btrfs_set_stack_remap_address(&remap, old_addr);
>> +
>> +		write_extent_buffer(path->nodes[0], &remap,
>> +			btrfs_item_ptr_offset(path->nodes[0], path->slots[0]),
>> +			sizeof(struct btrfs_remap));
>> +	}
>> +
>> +	btrfs_release_path(path);
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Punch a hole in the remap item or identity remap item pointed to by path,
>> + * for the range [hole_start, hole_start + hole_length).
>> + */
>> +static int remove_range_from_remap_tree(struct btrfs_trans_handle *trans,
>> +					struct btrfs_path *path,
>> +					struct btrfs_block_group *bg,
>> +					u64 hole_start, u64 hole_length)
>> +{
>> +	int ret;
>> +	struct btrfs_fs_info *fs_info = trans->fs_info;
>> +	struct extent_buffer *leaf = path->nodes[0];
>> +	struct btrfs_key key;
>> +	u64 hole_end, new_addr, remap_start, remap_length, remap_end,
>> +	    overlap_length;
>> +	bool is_identity_remap;
>> +	int identity_count_delta = 0;
>> +
>> +	hole_end = hole_start + hole_length;
>> +
>> +	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
>> +
>> +	is_identity_remap = key.type == BTRFS_IDENTITY_REMAP_KEY;
>> +
>> +	remap_start = key.objectid;
>> +	remap_length = key.offset;
>> +
>> +	remap_end = remap_start + remap_length;
>> +
>> +	if (is_identity_remap) {
>> +		new_addr = remap_start;
>> +	} else {
>> +		struct btrfs_remap *remap_ptr;
>> +
>> +		remap_ptr = btrfs_item_ptr(leaf, path->slots[0],
>> +					   struct btrfs_remap);
>> +		new_addr = btrfs_remap_address(leaf, remap_ptr);
>> +	}
>> +
>> +	/* Delete old item. */
>> +
>> +	ret = btrfs_del_item(trans, fs_info->remap_root, path);
>> +
>> +	btrfs_release_path(path);
>> +
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (is_identity_remap) {
>> +		identity_count_delta = -1;
>> +	} else {
>> +		/* Remove backref. */
>> +
>> +		key.objectid = new_addr;
>> +		key.type = BTRFS_REMAP_BACKREF_KEY;
>> +		key.offset = remap_length;
>> +
>> +		ret = btrfs_search_slot(trans, fs_info->remap_root,
>> +					&key, path, -1, 1);
>> +		if (ret) {
>> +			if (ret == 1) {
>> +				btrfs_release_path(path);
>> +				ret = -ENOENT;
>> +			}
>> +			return ret;
>> +		}
>> +
>> +		ret = btrfs_del_item(trans, fs_info->remap_root, path);
>> +
>> +		btrfs_release_path(path);
>> +
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	/* If hole_start > remap_start, re-add the start of the remap item. */
>> +	if (hole_start > remap_start) {
>> +		ret = insert_remap_item(trans, path, remap_start,
>> +					hole_start - remap_start, new_addr);
>> +		if (ret)
>> +			return ret;
>> +
>> +		if (is_identity_remap)
>> +			identity_count_delta++;
>> +	}
>> +
>> +	/* If hole_end < remap_end, re-add the end of the remap item. */
>> +	if (hole_end < remap_end) {
>> +		ret = insert_remap_item(trans, path, hole_end,
>> +				remap_end - hole_end,
>> +				hole_end - remap_start + new_addr);
>> +		if (ret)
>> +			return ret;
>> +
>> +		if (is_identity_remap)
>> +			identity_count_delta++;
>> +	}
>> +
>> +	if (identity_count_delta != 0)
>> +		adjust_identity_remap_count(trans, bg, identity_count_delta);
>> +
>> +	overlap_length = min_t(u64, hole_end, remap_end) -
>> +			 max_t(u64, hole_start, remap_start);
>> +
>> +	if (!is_identity_remap) {
>> +		struct btrfs_block_group *dest_bg;
>> +
>> +		dest_bg = btrfs_lookup_block_group(fs_info, new_addr);
>> +
>> +		adjust_block_group_remap_bytes(trans, dest_bg, -overlap_length);
>> +
>> +		btrfs_put_block_group(dest_bg);
>> +
>> +		ret = btrfs_add_to_free_space_tree(trans,
>> +					     hole_start - remap_start + new_addr,
>> +					     overlap_length);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	ret = overlap_length;
>> +
>> +	return ret;
>> +}
>> +
>> +/*
>> + * Returns 1 if remove_range_from_remap_tree() has been called successfully,
>> + * 0 if block group wasn't remapped, and a negative number on error.
>> + */
>> +int btrfs_remove_extent_from_remap_tree(struct btrfs_trans_handle *trans,
>> +					struct btrfs_path *path,
>> +					u64 bytenr, u64 num_bytes)
>> +{
>> +	struct btrfs_fs_info *fs_info = trans->fs_info;
>> +	struct btrfs_key key, found_key;
>> +	struct extent_buffer *leaf;
>> +	struct btrfs_block_group *bg;
>> +	int ret, length;
>> +
>> +	if (!(btrfs_super_incompat_flags(fs_info->super_copy) &
>> +	      BTRFS_FEATURE_INCOMPAT_REMAP_TREE))
>> +		return 0;
>> +
>> +	bg = btrfs_lookup_block_group(fs_info, bytenr);
>> +	if (!bg)
>> +		return 0;
>> +
>> +	mutex_lock(&fs_info->remap_mutex);
>> +
>> +	if (!(bg->flags & BTRFS_BLOCK_GROUP_REMAPPED)) {
>> +		mutex_unlock(&fs_info->remap_mutex);
>> +		btrfs_put_block_group(bg);
>> +		return 0;
>> +	}
>> +
>> +	do {
>> +		key.objectid = bytenr;
>> +		key.type = (u8)-1;
>> +		key.offset = (u64)-1;
>> +
>> +		ret = btrfs_search_slot(trans, fs_info->remap_root, &key, path,
>> +					-1, 1);
>> +		if (ret < 0)
>> +			goto end;
>> +
>> +		leaf = path->nodes[0];
>> +
>> +		if (path->slots[0] == 0) {
>> +			ret = -ENOENT;
>> +			goto end;
>> +		}
>> +
>> +		path->slots[0]--;
>> +
>> +		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
>> +
>> +		if (found_key.type != BTRFS_IDENTITY_REMAP_KEY &&
>> +		    found_key.type != BTRFS_REMAP_KEY) {
>> +			ret = -ENOENT;
>> +			goto end;
>> +		}
>> +
>> +		if (bytenr < found_key.objectid ||
>> +		    bytenr >= found_key.objectid + found_key.offset) {
>> +			ret = -ENOENT;
>> +			goto end;
>> +		}
>> +
>> +		length = remove_range_from_remap_tree(trans, path, bg, bytenr,
>> +						      num_bytes);
>> +		if (length < 0) {
>> +			ret = length;
>> +			goto end;
>> +		}
>> +
>> +		bytenr += length;
>> +		num_bytes -= length;
>> +	} while (num_bytes > 0);
>> +
>> +	ret = 1;
>> +
>> +end:
>> +	mutex_unlock(&fs_info->remap_mutex);
>> +
>> +	btrfs_put_block_group(bg);
>> +	btrfs_release_path(path);
>> +	return ret;
>> +}
>> diff --git a/fs/btrfs/relocation.h b/fs/btrfs/relocation.h
>> index b2ba83966650..7cfe91971cab 100644
>> --- a/fs/btrfs/relocation.h
>> +++ b/fs/btrfs/relocation.h
>> @@ -33,5 +33,11 @@ bool btrfs_should_ignore_reloc_root(const struct btrfs_root *root);
>>   u64 btrfs_get_reloc_bg_bytenr(const struct btrfs_fs_info *fs_info);
>>   int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
>>   			  u64 *length);
>> +int btrfs_remove_extent_from_remap_tree(struct btrfs_trans_handle *trans,
>> +					struct btrfs_path *path,
>> +					u64 bytenr, u64 num_bytes);
>> +int btrfs_last_identity_remap_gone(struct btrfs_trans_handle *trans,
>> +				   struct btrfs_chunk_map *chunk,
>> +				   struct btrfs_block_group *bg);
>>   
>>   #endif
>> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
>> index 12921c4d7e56..b63cb5277a26 100644
>> --- a/fs/btrfs/transaction.c
>> +++ b/fs/btrfs/transaction.c
>> @@ -2439,6 +2439,10 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>>   	if (ret)
>>   		goto unlock_reloc;
>>   
>> +	ret = btrfs_handle_fully_remapped_bgs(trans);
>> +	if (ret)
>> +		goto unlock_reloc;
>> +
>>   	/*
>>   	 * make sure none of the code above managed to slip in a
>>   	 * delayed item
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 6a72c2a599a6..2347b37113b0 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -2928,8 +2928,8 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>>   	return ret;
>>   }
>>   
>> -static noinline int btrfs_update_device(struct btrfs_trans_handle *trans,
>> -					struct btrfs_device *device)
>> +int btrfs_update_device(struct btrfs_trans_handle *trans,
>> +			struct btrfs_device *device)
>>   {
>>   	int ret;
>>   	BTRFS_PATH_AUTO_FREE(path);
>> @@ -3227,25 +3227,13 @@ static int remove_chunk_item(struct btrfs_trans_handle *trans,
>>   	return btrfs_free_chunk(trans, chunk_offset);
>>   }
>>   
>> -int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
>> +int btrfs_remove_dev_extents(struct btrfs_trans_handle *trans,
>> +			     struct btrfs_chunk_map *map)
>>   {
>>   	struct btrfs_fs_info *fs_info = trans->fs_info;
>> -	struct btrfs_chunk_map *map;
>> +	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
>>   	u64 dev_extent_len = 0;
>>   	int i, ret = 0;
>> -	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
>> -
>> -	map = btrfs_get_chunk_map(fs_info, chunk_offset, 1);
>> -	if (IS_ERR(map)) {
>> -		/*
>> -		 * This is a logic error, but we don't want to just rely on the
>> -		 * user having built with ASSERT enabled, so if ASSERT doesn't
>> -		 * do anything we still error out.
>> -		 */
>> -		DEBUG_WARN("errr %ld reading chunk map at offset %llu",
>> -			   PTR_ERR(map), chunk_offset);
>> -		return PTR_ERR(map);
>> -	}
>>   
>>   	/*
>>   	 * First delete the device extent items from the devices btree.
>> @@ -3266,7 +3254,7 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
>>   		if (unlikely(ret)) {
>>   			mutex_unlock(&fs_devices->device_list_mutex);
>>   			btrfs_abort_transaction(trans, ret);
>> -			goto out;
>> +			return ret;
>>   		}
>>   
>>   		if (device->bytes_used > 0) {
>> @@ -3286,6 +3274,30 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
>>   	}
>>   	mutex_unlock(&fs_devices->device_list_mutex);
>>   
>> +	return 0;
>> +}
>> +
>> +int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
>> +{
>> +	struct btrfs_fs_info *fs_info = trans->fs_info;
>> +	struct btrfs_chunk_map *map;
>> +	int ret;
>> +
>> +	map = btrfs_get_chunk_map(fs_info, chunk_offset, 1);
>> +	if (IS_ERR(map)) {
>> +		/*
>> +		 * This is a logic error, but we don't want to just rely on the
>> +		 * user having built with ASSERT enabled, so if ASSERT doesn't
>> +		 * do anything we still error out.
>> +		 */
>> +		ASSERT(0);
>> +		return PTR_ERR(map);
>> +	}
>> +
>> +	ret = btrfs_remove_dev_extents(trans, map);
>> +	if (ret)
>> +		goto out;
>> +
>>   	/*
>>   	 * We acquire fs_info->chunk_mutex for 2 reasons:
>>   	 *
>> @@ -5419,7 +5431,7 @@ static void chunk_map_device_set_bits(struct btrfs_chunk_map *map, unsigned int
>>   	}
>>   }
>>   
>> -static void chunk_map_device_clear_bits(struct btrfs_chunk_map *map, unsigned int bits)
>> +void btrfs_chunk_map_device_clear_bits(struct btrfs_chunk_map *map, unsigned int bits)
>>   {
>>   	for (int i = 0; i < map->num_stripes; i++) {
>>   		struct btrfs_io_stripe *stripe = &map->stripes[i];
>> @@ -5436,7 +5448,7 @@ void btrfs_remove_chunk_map(struct btrfs_fs_info *fs_info, struct btrfs_chunk_ma
>>   	write_lock(&fs_info->mapping_tree_lock);
>>   	rb_erase_cached(&map->rb_node, &fs_info->mapping_tree);
>>   	RB_CLEAR_NODE(&map->rb_node);
>> -	chunk_map_device_clear_bits(map, CHUNK_ALLOCATED);
>> +	btrfs_chunk_map_device_clear_bits(map, CHUNK_ALLOCATED);
>>   	write_unlock(&fs_info->mapping_tree_lock);
>>   
>>   	/* Once for the tree reference. */
>> @@ -5472,7 +5484,7 @@ int btrfs_add_chunk_map(struct btrfs_fs_info *fs_info, struct btrfs_chunk_map *m
>>   		return -EEXIST;
>>   	}
>>   	chunk_map_device_set_bits(map, CHUNK_ALLOCATED);
>> -	chunk_map_device_clear_bits(map, CHUNK_TRIMMED);
>> +	btrfs_chunk_map_device_clear_bits(map, CHUNK_TRIMMED);
>>   	write_unlock(&fs_info->mapping_tree_lock);
>>   
>>   	return 0;
>> @@ -5828,7 +5840,7 @@ void btrfs_mapping_tree_free(struct btrfs_fs_info *fs_info)
>>   		map = rb_entry(node, struct btrfs_chunk_map, rb_node);
>>   		rb_erase_cached(&map->rb_node, &fs_info->mapping_tree);
>>   		RB_CLEAR_NODE(&map->rb_node);
>> -		chunk_map_device_clear_bits(map, CHUNK_ALLOCATED);
>> +		btrfs_chunk_map_device_clear_bits(map, CHUNK_ALLOCATED);
>>   		/* Once for the tree ref. */
>>   		btrfs_free_chunk_map(map);
>>   		cond_resched_rwlock_write(&fs_info->mapping_tree_lock);
>> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
>> index 4117fabb248b..ccf0a459180d 100644
>> --- a/fs/btrfs/volumes.h
>> +++ b/fs/btrfs/volumes.h
>> @@ -794,6 +794,8 @@ u64 btrfs_calc_stripe_length(const struct btrfs_chunk_map *map);
>>   int btrfs_nr_parity_stripes(u64 type);
>>   int btrfs_chunk_alloc_add_chunk_item(struct btrfs_trans_handle *trans,
>>   				     struct btrfs_block_group *bg);
>> +int btrfs_remove_dev_extents(struct btrfs_trans_handle *trans,
>> +			     struct btrfs_chunk_map *map);
>>   int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset);
>>   
>>   #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
>> @@ -905,6 +907,10 @@ bool btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical);
>>   
>>   bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr);
>>   const u8 *btrfs_sb_fsid_ptr(const struct btrfs_super_block *sb);
>> +int btrfs_update_device(struct btrfs_trans_handle *trans,
>> +			struct btrfs_device *device);
>> +void btrfs_chunk_map_device_clear_bits(struct btrfs_chunk_map *map,
>> +				       unsigned int bits);
>>   
>>   #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
>>   struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_info,
>> -- 
>> 2.51.0
>>


