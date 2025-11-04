Return-Path: <linux-btrfs+bounces-18661-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E42E0C30FCC
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 13:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC336189FC70
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 12:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01EE19F40B;
	Tue,  4 Nov 2025 12:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="Bn1RDH4f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52DF1DA55
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Nov 2025 12:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762259456; cv=none; b=k8Xkg7ZUpd6QaQHKE76m+oKJXA2LnX+pnPzRCT3rE1UL4VWLG+HydUe7Z/guWC7N5QcXEjgehCWnPiJVxDmcCRT/E72/VeOy+dYZNcH3HD2bekrgLILZXlQKFa0xkeLlhY29YrRF11VV2G2Udwu2V1KuqRVaVKoGCHH7M5S8EP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762259456; c=relaxed/simple;
	bh=yJFysTTsfte1GBcUMcvKWnzyOOC+KWhx+t26piE4/sw=;
	h=Message-ID:Date:Mime-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aVUkl/3COGz16XIyewkhj9LGFPEz2dPYBR6p1TrYWMc61I+hyNnWfgmdHIDCnVnepYVDgnWmm46tsb3qk5d4MKZXC2/CNmvZNfa32nhnB1N0viedGxLWtuiDCwa38T6jL/NRMIlleDcnmDYYvpV3gA/VRlw/KYI67ln23JDBGtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=Bn1RDH4f; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from [IPV6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2] (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id 4EFAE2D5D95;
	Tue,  4 Nov 2025 12:30:38 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1762259438;
	bh=SlZ4iyByXfFrKJ8sUz5SVyugawLYxQebiRKflvX53O0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Bn1RDH4fhWKRTzxwyJw6oECu60CzLB4MlpmKWFCQB10o/O9MXHGui6M9/13m0UKYB
	 UnRUZCgZeFY3cxkBZgiGPQXehU/nyYjnRJp61dkXCdvrqdPt466suXw59FETAmtsV3
	 XF3FgFa0CcUM9jk35PgERqkgv+enWewcNtlgS8A0=
Message-ID: <a29115be-fc5d-440a-b237-cf3a5c25c4e5@harmstone.com>
Date: Tue, 4 Nov 2025 12:30:38 +0000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v4 09/16] btrfs: handle deletions from remapped block
 group
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <20251024181227.32228-1-mark@harmstone.com>
 <20251024181227.32228-10-mark@harmstone.com>
 <aQVGi1amjtN3xs0H@devvm12410.ftw0.facebook.com>
Content-Language: en-US
From: Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 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
In-Reply-To: <aQVGi1amjtN3xs0H@devvm12410.ftw0.facebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/10/2025 11.30 pm, Boris Burkov wrote:
> On Fri, Oct 24, 2025 at 07:12:10PM +0100, Mark Harmstone wrote:
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
>> zero we call last_identity_remap_gone(), which removes the chunk's
>> stripes and device extents - it is now fully remapped.
>>
>> The changes which involve the block group's ro flag are because the
>> REMAPPED flag itself prevents a block group from having any new
>> allocations within it, and so we don't need to account for this
>> separately.
>>
>> Signed-off-by: Mark Harmstone <mark@harmstone.com>
>> ---
>>   fs/btrfs/block-group.c | 118 +++++++---
>>   fs/btrfs/block-group.h |   4 +
>>   fs/btrfs/disk-io.c     |   2 +
>>   fs/btrfs/extent-tree.c |  77 ++++++-
>>   fs/btrfs/extent-tree.h |   1 +
>>   fs/btrfs/fs.h          |   4 +-
>>   fs/btrfs/relocation.c  | 509 +++++++++++++++++++++++++++++++++++++++++
>>   fs/btrfs/relocation.h  |   6 +
>>   fs/btrfs/transaction.c |   4 +
>>   fs/btrfs/volumes.c     |  56 +++--
>>   fs/btrfs/volumes.h     |   6 +
>>   11 files changed, 728 insertions(+), 59 deletions(-)
>>
>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>> index 27173aca6fc1..3bf5f20d90ec 100644
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
>> @@ -1538,6 +1547,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>>   	while (!list_empty(&fs_info->unused_bgs)) {
>>   		u64 used;
>>   		int trimming;
>> +		bool made_ro = false;
>>   
>>   		block_group = list_first_entry(&fs_info->unused_bgs,
>>   					       struct btrfs_block_group,
>> @@ -1574,7 +1584,8 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>>   
>>   		spin_lock(&space_info->lock);
>>   		spin_lock(&block_group->lock);
>> -		if (btrfs_is_block_group_used(block_group) || block_group->ro ||
>> +		if (btrfs_is_block_group_used(block_group) ||
>> +		    (block_group->ro && !(block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED)) ||
>>   		    list_is_singular(&block_group->list)) {
>>   			/*
>>   			 * We want to bail if we made new allocations or have
>> @@ -1616,9 +1627,10 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>>   		 * needing to allocate extents from the block group.
>>   		 */
>>   		used = btrfs_space_info_used(space_info, true);
>> -		if ((space_info->total_bytes - block_group->length < used &&
>> +		if (((space_info->total_bytes - block_group->length < used &&
>>   		     block_group->zone_unusable < block_group->length) ||
>> -		    has_unwritten_metadata(block_group)) {
>> +		    has_unwritten_metadata(block_group)) &&
>> +			!(block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED)) {
>>   			/*
>>   			 * Add a reference for the list, compensate for the ref
>>   			 * drop under the "next" label for the
>> @@ -1636,8 +1648,14 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>>   		spin_unlock(&block_group->lock);
>>   		spin_unlock(&space_info->lock);
>>   
>> -		/* We don't want to force the issue, only flip if it's ok. */
>> -		ret = inc_block_group_ro(block_group, 0);
>> +		if (!(block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED)) {
>> +			/* We don't want to force the issue, only flip if it's ok. */
>> +			ret = inc_block_group_ro(block_group, 0);
>> +			made_ro = true;
>> +		} else {
>> +			ret = 0;
>> +		}
>> +
>>   		up_write(&space_info->groups_sem);
>>   		if (ret < 0) {
>>   			ret = 0;
>> @@ -1646,7 +1664,8 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>>   
>>   		ret = btrfs_zone_finish(block_group);
>>   		if (ret < 0) {
>> -			btrfs_dec_block_group_ro(block_group);
>> +			if (made_ro)
>> +				btrfs_dec_block_group_ro(block_group);
>>   			if (ret == -EAGAIN) {
>>   				btrfs_link_bg_list(block_group, &retry_list);
>>   				ret = 0;
>> @@ -1661,7 +1680,8 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>>   		trans = btrfs_start_trans_remove_block_group(fs_info,
>>   						     block_group->start);
>>   		if (IS_ERR(trans)) {
>> -			btrfs_dec_block_group_ro(block_group);
>> +			if (made_ro)
>> +				btrfs_dec_block_group_ro(block_group);
>>   			ret = PTR_ERR(trans);
>>   			goto next;
>>   		}
>> @@ -1671,7 +1691,8 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>>   		 * just delete them, we don't care about them anymore.
>>   		 */
>>   		if (!clean_pinned_extents(trans, block_group)) {
>> -			btrfs_dec_block_group_ro(block_group);
>> +			if (made_ro)
>> +				btrfs_dec_block_group_ro(block_group);
>>   			goto end_trans;
>>   		}
>>   
>> @@ -1685,7 +1706,8 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>>   		spin_lock(&fs_info->discard_ctl.lock);
>>   		if (!list_empty(&block_group->discard_list)) {
>>   			spin_unlock(&fs_info->discard_ctl.lock);
>> -			btrfs_dec_block_group_ro(block_group);
>> +			if (made_ro)
>> +				btrfs_dec_block_group_ro(block_group);
>>   			btrfs_discard_queue_work(&fs_info->discard_ctl,
>>   						 block_group);
>>   			goto end_trans;
>> @@ -1779,6 +1801,15 @@ void btrfs_mark_bg_unused(struct btrfs_block_group *bg)
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
>>   	if (list_empty(&bg->bg_list)) {
>>   		btrfs_get_block_group(bg);
>>   		trace_btrfs_add_unused_block_group(bg);
>> @@ -4772,3 +4803,30 @@ bool btrfs_block_group_should_use_size_class(const struct btrfs_block_group *bg)
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
> 
> which list could it be on in this case? reclaim? do we not take those
> off before reclaiming them?

Probably none I don't think, I've just copied what we do elsewhere. I'll 
replace the check with ASSERT(list_empty(&bg->bg_list)), so we know if 
something does go wrong.
>> +	if (!list_empty(&bg->bg_list))
>> +		list_del(&bg->bg_list);
>> +	else
>> +		btrfs_get_block_group(bg);
>> +
>> +	list_add_tail(&bg->bg_list, &fs_info->fully_remapped_bgs);
>> +
>> +	spin_unlock(&fs_info->unused_bgs_lock);
>> +
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
>> index d3ff148311d8..1a3e525f3d1a 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -2870,6 +2870,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
>>   	INIT_LIST_HEAD(&fs_info->tree_mod_seq_list);
>>   	INIT_LIST_HEAD(&fs_info->unused_bgs);
>>   	INIT_LIST_HEAD(&fs_info->reclaim_bgs);
>> +	INIT_LIST_HEAD(&fs_info->fully_remapped_bgs);
>>   	INIT_LIST_HEAD(&fs_info->zone_active_bgs);
>>   #ifdef CONFIG_BTRFS_DEBUG
>>   	INIT_LIST_HEAD(&fs_info->allocated_roots);
>> @@ -2925,6 +2926,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
>>   	mutex_init(&fs_info->chunk_mutex);
>>   	mutex_init(&fs_info->transaction_kthread_mutex);
>>   	mutex_init(&fs_info->cleaner_mutex);
>> +	mutex_init(&fs_info->remap_mutex);
>>   	mutex_init(&fs_info->ro_block_group_mutex);
>>   	init_rwsem(&fs_info->commit_root_sem);
>>   	init_rwsem(&fs_info->cleanup_work_sem);
>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>> index d3ca8105ffc7..1c14e0c82c03 100644
>> --- a/fs/btrfs/extent-tree.c
>> +++ b/fs/btrfs/extent-tree.c
>> @@ -40,6 +40,7 @@
>>   #include "orphan.h"
>>   #include "tree-checker.h"
>>   #include "raid-stripe-tree.h"
>> +#include "relocation.h"
>>   
>>   #undef SCRAMBLE_DELAYED_REFS
>>   
>> @@ -2847,6 +2848,52 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
>>   	return ret;
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
>> @@ -2999,11 +3046,23 @@ u64 btrfs_get_extent_owner_root(struct btrfs_fs_info *fs_info,
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
>> @@ -3027,10 +3086,16 @@ static int do_free_extent_accounting(struct btrfs_trans_handle *trans,
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
>> @@ -3396,7 +3461,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
>>   		}
>>   		btrfs_release_path(path);
>>   
>> -		ret = do_free_extent_accounting(trans, bytenr, &delta);
>> +		ret = do_free_extent_accounting(trans, bytenr, &delta, path);
>>   	}
>>   	btrfs_release_path(path);
>>   
>> diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
>> index e970ac42a871..6b67a4e528da 100644
>> --- a/fs/btrfs/extent-tree.h
>> +++ b/fs/btrfs/extent-tree.h
>> @@ -164,5 +164,6 @@ void btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info, u64 start, u6
>>   int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
>>   			 u64 num_bytes, u64 *actual_bytes);
>>   int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range);
>> +int btrfs_handle_fully_remapped_bgs(struct btrfs_trans_handle *trans);
>>   
>>   #endif
>> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
>> index 62057e8006a9..c3dacbfe118c 100644
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
>> @@ -827,10 +828,11 @@ struct btrfs_fs_info {
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
>> index a8abe24de8d7..9f3ce3395d6a 100644
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
>> @@ -3870,6 +3871,151 @@ static const char *stage_to_string(enum reloc_stage stage)
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
>> @@ -4478,3 +4624,366 @@ u64 btrfs_get_reloc_bg_bytenr(const struct btrfs_fs_info *fs_info)
>>   		logical = fs_info->reloc_ctl->block_group->start;
>>   	return logical;
>>   }
>> +
> 
> Please document the expectation on the path passed (and other params)
> 
>> +static int remove_range_from_remap_tree(struct btrfs_trans_handle *trans,
>> +					struct btrfs_path *path,
>> +					struct btrfs_block_group *bg,
>> +					u64 bytenr, u64 num_bytes)
>> +{
>> +	int ret;
>> +	struct btrfs_fs_info *fs_info = trans->fs_info;
>> +	struct extent_buffer *leaf = path->nodes[0];
>> +	struct btrfs_key key, new_key;
>> +	struct btrfs_remap *remap_ptr = NULL, remap;
>> +	struct btrfs_block_group *dest_bg = NULL;
>> +	u64 end, new_addr = 0, remap_start, remap_length, overlap_length;
>> +	bool is_identity_remap;
>> +
>> +	end = bytenr + num_bytes;
>> +
>> +	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
>> +
>> +	is_identity_remap = key.type == BTRFS_IDENTITY_REMAP_KEY;
>> +
>> +	remap_start = key.objectid;
>> +	remap_length = key.offset;
>> +
>> +	if (!is_identity_remap) {
>> +		remap_ptr = btrfs_item_ptr(leaf, path->slots[0],
>> +					   struct btrfs_remap);
>> +		new_addr = btrfs_remap_address(leaf, remap_ptr);
>> +
>> +		dest_bg = btrfs_lookup_block_group(fs_info, new_addr);
>> +	}
>> +
> 
> These open-coded cases are all quite large and I suspect redundant (I'll
> try to catch concretely how) so it would make it more readable to break
> them out into static functions (remove_remapping, trim_remapping, etc.)
> 
> The most readable might be to simply always delete the entire remapping
> item and replace it with the needed new ones rather than modifying in-place.

That feels clumsier to me... but it is the approach followed by 
remove_free_space_extent(). I suppose clear code is better than being 
clever.

>> +	if (bytenr == remap_start && num_bytes >= remap_length) {
>> +		/* Remove entirely. */
>> +
>> +		ret = btrfs_del_item(trans, fs_info->remap_root, path);
>> +		if (ret)
>> +			goto end;
>> +
>> +		btrfs_release_path(path);
>> +
>> +		overlap_length = remap_length;
>> +
>> +		if (!is_identity_remap) {
>> +			/* Remove backref. */
>> +
>> +			key.objectid = new_addr;
>> +			key.type = BTRFS_REMAP_BACKREF_KEY;
>> +			key.offset = remap_length;
>> +
>> +			ret = btrfs_search_slot(trans, fs_info->remap_root,
>> +						&key, path, -1, 1);
>> +			if (ret) {
>> +				if (ret == 1) {
>> +					btrfs_release_path(path);
>> +					ret = -ENOENT;
>> +				}
>> +				goto end;
>> +			}
>> +
>> +			ret = btrfs_del_item(trans, fs_info->remap_root, path);
>> +
>> +			btrfs_release_path(path);
>> +
>> +			if (ret)
>> +				goto end;
>> +
>> +			adjust_block_group_remap_bytes(trans, dest_bg,
>> +						       -remap_length);
>> +		} else {
>> +			adjust_identity_remap_count(trans, bg, -1);
>> +		}
>> +	} else if (bytenr == remap_start) {
>> +		/* Remove beginning. */
>> +
>> +		new_key.objectid = end;
>> +		new_key.type = key.type;
>> +		new_key.offset = remap_length + remap_start - end;
>> +
>> +		btrfs_set_item_key_safe(trans, path, &new_key);
>> +		btrfs_mark_buffer_dirty(trans, leaf);
>> +
>> +		overlap_length = num_bytes;
>> +
>> +		if (!is_identity_remap) {
>> +			btrfs_set_remap_address(leaf, remap_ptr,
>> +						new_addr + end - remap_start);
>> +			btrfs_release_path(path);
>> +
>> +			/* Adjust backref. */
>> +
>> +			key.objectid = new_addr;
>> +			key.type = BTRFS_REMAP_BACKREF_KEY;
>> +			key.offset = remap_length;
>> +
>> +			ret = btrfs_search_slot(trans, fs_info->remap_root,
>> +						&key, path, -1, 1);
>> +			if (ret) {
>> +				if (ret == 1) {
>> +					btrfs_release_path(path);
>> +					ret = -ENOENT;
>> +				}
>> +				goto end;
>> +			}
>> +
>> +			leaf = path->nodes[0];
>> +
>> +			new_key.objectid = new_addr + end - remap_start;
>> +			new_key.type = BTRFS_REMAP_BACKREF_KEY;
>> +			new_key.offset = remap_length + remap_start - end;
>> +
>> +			btrfs_set_item_key_safe(trans, path, &new_key);
>> +
>> +			remap_ptr = btrfs_item_ptr(leaf, path->slots[0],
>> +						   struct btrfs_remap);
>> +			btrfs_set_remap_address(leaf, remap_ptr, end);
>> +
>> +			btrfs_mark_buffer_dirty(trans, path->nodes[0]);
>> +
>> +			btrfs_release_path(path);
>> +
>> +			adjust_block_group_remap_bytes(trans, dest_bg,
>> +						       -num_bytes);
>> +		}
>> +	} else if (bytenr + num_bytes < remap_start + remap_length) {
>> +		/* Remove middle. */
>> +
>> +		new_key.objectid = remap_start;
>> +		new_key.type = key.type;
>> +		new_key.offset = bytenr - remap_start;
>> +
>> +		btrfs_set_item_key_safe(trans, path, &new_key);
>> +		btrfs_mark_buffer_dirty(trans, leaf);
>> +
>> +		new_key.objectid = end;
>> +		new_key.offset = remap_start + remap_length - end;
>> +
>> +		btrfs_release_path(path);
>> +
>> +		overlap_length = num_bytes;
>> +
>> +		if (!is_identity_remap) {
>> +			/* Add second remap entry. */
>> +
>> +			ret = btrfs_insert_empty_item(trans, fs_info->remap_root,
>> +						path, &new_key,
>> +						sizeof(struct btrfs_remap));
>> +			if (ret)
>> +				goto end;
>> +
>> +			btrfs_set_stack_remap_address(&remap,
>> +						new_addr + end - remap_start);
>> +
>> +			write_extent_buffer(path->nodes[0], &remap,
>> +				btrfs_item_ptr_offset(path->nodes[0], path->slots[0]),
>> +				sizeof(struct btrfs_remap));
>> +
>> +			btrfs_release_path(path);
>> +
>> +			/* Shorten backref entry. */
>> +
>> +			key.objectid = new_addr;
>> +			key.type = BTRFS_REMAP_BACKREF_KEY;
>> +			key.offset = remap_length;
>> +
>> +			ret = btrfs_search_slot(trans, fs_info->remap_root,
>> +						&key, path, -1, 1);
>> +			if (ret) {
>> +				if (ret == 1) {
>> +					btrfs_release_path(path);
>> +					ret = -ENOENT;
>> +				}
>> +				goto end;
>> +			}
>> +
>> +			new_key.objectid = new_addr;
>> +			new_key.type = BTRFS_REMAP_BACKREF_KEY;
>> +			new_key.offset = bytenr - remap_start;
>> +
>> +			btrfs_set_item_key_safe(trans, path, &new_key);
>> +			btrfs_mark_buffer_dirty(trans, path->nodes[0]);
>> +
>> +			btrfs_release_path(path);
>> +
>> +			/* Add second backref entry. */
>> +
>> +			new_key.objectid = new_addr + end - remap_start;
>> +			new_key.type = BTRFS_REMAP_BACKREF_KEY;
>> +			new_key.offset = remap_start + remap_length - end;
>> +
>> +			ret = btrfs_insert_empty_item(trans, fs_info->remap_root,
>> +						path, &new_key,
>> +						sizeof(struct btrfs_remap));
>> +			if (ret)
>> +				goto end;
>> +
>> +			btrfs_set_stack_remap_address(&remap, end);
>> +
>> +			write_extent_buffer(path->nodes[0], &remap,
>> +				btrfs_item_ptr_offset(path->nodes[0], path->slots[0]),
>> +				sizeof(struct btrfs_remap));
>> +
>> +			btrfs_release_path(path);
>> +
>> +			adjust_block_group_remap_bytes(trans, dest_bg,
>> +						       -num_bytes);
>> +		} else {
>> +			/* Add second identity remap entry. */
>> +
>> +			ret = btrfs_insert_empty_item(trans, fs_info->remap_root,
>> +						      path, &new_key, 0);
>> +			if (ret)
>> +				goto end;
>> +
>> +			btrfs_release_path(path);
>> +
>> +			adjust_identity_remap_count(trans, bg, 1);
>> +		}
>> +	} else {
>> +		/* Remove end. */
>> +
>> +		new_key.objectid = remap_start;
>> +		new_key.type = key.type;
>> +		new_key.offset = bytenr - remap_start;
>> +
>> +		btrfs_set_item_key_safe(trans, path, &new_key);
>> +		btrfs_mark_buffer_dirty(trans, leaf);
>> +
>> +		btrfs_release_path(path);
>> +
>> +		overlap_length = remap_start + remap_length - bytenr;
>> +
>> +		if (!is_identity_remap) {
>> +			/* Shorten backref entry. */
>> +
>> +			key.objectid = new_addr;
>> +			key.type = BTRFS_REMAP_BACKREF_KEY;
>> +			key.offset = remap_length;
>> +
>> +			ret = btrfs_search_slot(trans, fs_info->remap_root,
>> +						&key, path, -1, 1);
>> +			if (ret) {
>> +				if (ret == 1) {
>> +					btrfs_release_path(path);
>> +					ret = -ENOENT;
>> +				}
>> +				goto end;
>> +			}
>> +
>> +			new_key.objectid = new_addr;
>> +			new_key.type = BTRFS_REMAP_BACKREF_KEY;
>> +			new_key.offset = bytenr - remap_start;
>> +
>> +			btrfs_set_item_key_safe(trans, path, &new_key);
>> +			btrfs_mark_buffer_dirty(trans, path->nodes[0]);
>> +
>> +			btrfs_release_path(path);
>> +
>> +			adjust_block_group_remap_bytes(trans, dest_bg,
>> +					bytenr - remap_start - remap_length);
>> +		}
>> +	}
>> +
>> +	if (!is_identity_remap) {
>> +		ret = btrfs_add_to_free_space_tree(trans,
>> +					     bytenr - remap_start + new_addr,
>> +					     overlap_length);
>> +		if (ret)
>> +			goto end;
>> +	}
> 
> why do this here instead of just letting it happen normally in
> do_free_extent_accounting (where you added the new skipping logic)?

Because the addresses in the free-space tree are all after translation, 
whereas the bytenr passed to do_free_extent_accounting() is before 
translation. And you can't even call btrfs_translate_remap() in 
do_free_extent_accounting(), because you've just deleted the remap items.

>> +
>> +	ret = overlap_length;
>> +
>> +end:
>> +	if (dest_bg)
>> +		btrfs_put_block_group(dest_bg);
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
>> index de3eeb37408a..ffee6c285182 100644
>> --- a/fs/btrfs/transaction.c
>> +++ b/fs/btrfs/transaction.c
>> @@ -2437,6 +2437,10 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>>   	if (ret)
>>   		goto unlock_reloc;
>>   
> 
> Does this need to be in the transaction critical section or can it
> happen asynchronously like other bg cleanup tasks?
> 
> If so, that should be justified in the commit message.

btrfs_handle_fully_remapped_bgs() does the following:

* For async discard, it queues the BG up for the worker thread to finish 
off (and, as of the later patch, sets the stripe removal pending flag)

* For nodiscard, it removes the chunk stripes and device extents, 
freeing the BG's space so it can be used again by the chunk allocator

* For sync discard, it does the same but also discards the whole range

So it's only in the case of sync discard that it does anything 
particularly heavy.

We can e.g. delay deleting unused BGs because they can be used again, 
but here it's dead space until the stripes and device extents get 
removed: delaying it would make the chunk allocator more likely to 
ENOSPC. (Which doesn't help us with async discard, but we've discussed 
off-list how a later improvement would be to make the chunk allocator 
flush the pending fully remapped discard list before it ENOSPCs.)
>> +	ret = btrfs_handle_fully_remapped_bgs(trans);
>> +	if (ret)
>> +		goto unlock_reloc;
>> +
>>   	/*
>>   	 * make sure none of the code above managed to slip in a
>>   	 * delayed item
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index d117f74e08c1..99ad95e1c300 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -2929,8 +2929,8 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
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
>> @@ -3228,25 +3228,13 @@ static int remove_chunk_item(struct btrfs_trans_handle *trans,
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
>> @@ -3267,7 +3255,7 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
>>   		if (unlikely(ret)) {
>>   			mutex_unlock(&fs_devices->device_list_mutex);
>>   			btrfs_abort_transaction(trans, ret);
>> -			goto out;
>> +			return ret;
>>   		}
>>   
>>   		if (device->bytes_used > 0) {
>> @@ -3287,6 +3275,30 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
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
>> @@ -5422,7 +5434,7 @@ static void chunk_map_device_set_bits(struct btrfs_chunk_map *map, unsigned int
>>   	}
>>   }
>>   
>> -static void chunk_map_device_clear_bits(struct btrfs_chunk_map *map, unsigned int bits)
>> +void btrfs_chunk_map_device_clear_bits(struct btrfs_chunk_map *map, unsigned int bits)
>>   {
>>   	for (int i = 0; i < map->num_stripes; i++) {
>>   		struct btrfs_io_stripe *stripe = &map->stripes[i];
>> @@ -5439,7 +5451,7 @@ void btrfs_remove_chunk_map(struct btrfs_fs_info *fs_info, struct btrfs_chunk_ma
>>   	write_lock(&fs_info->mapping_tree_lock);
>>   	rb_erase_cached(&map->rb_node, &fs_info->mapping_tree);
>>   	RB_CLEAR_NODE(&map->rb_node);
>> -	chunk_map_device_clear_bits(map, CHUNK_ALLOCATED);
>> +	btrfs_chunk_map_device_clear_bits(map, CHUNK_ALLOCATED);
>>   	write_unlock(&fs_info->mapping_tree_lock);
>>   
>>   	/* Once for the tree reference. */
>> @@ -5475,7 +5487,7 @@ int btrfs_add_chunk_map(struct btrfs_fs_info *fs_info, struct btrfs_chunk_map *m
>>   		return -EEXIST;
>>   	}
>>   	chunk_map_device_set_bits(map, CHUNK_ALLOCATED);
>> -	chunk_map_device_clear_bits(map, CHUNK_TRIMMED);
>> +	btrfs_chunk_map_device_clear_bits(map, CHUNK_TRIMMED);
>>   	write_unlock(&fs_info->mapping_tree_lock);
>>   
>>   	return 0;
>> @@ -5840,7 +5852,7 @@ void btrfs_mapping_tree_free(struct btrfs_fs_info *fs_info)
>>   		map = rb_entry(node, struct btrfs_chunk_map, rb_node);
>>   		rb_erase_cached(&map->rb_node, &fs_info->mapping_tree);
>>   		RB_CLEAR_NODE(&map->rb_node);
>> -		chunk_map_device_clear_bits(map, CHUNK_ALLOCATED);
>> +		btrfs_chunk_map_device_clear_bits(map, CHUNK_ALLOCATED);
>>   		/* Once for the tree ref. */
>>   		btrfs_free_chunk_map(map);
>>   		cond_resched_rwlock_write(&fs_info->mapping_tree_lock);
>> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
>> index 7cf76bffcab6..0c64cae59f1c 100644
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
>> 2.49.1
>>


