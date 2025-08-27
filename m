Return-Path: <linux-btrfs+bounces-16455-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D689B3884B
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Aug 2025 19:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0638B1B606DB
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Aug 2025 17:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278C22FFDF6;
	Wed, 27 Aug 2025 17:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="MixYYyvV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39202417DE
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Aug 2025 17:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756314695; cv=none; b=blDluLVIv8uHMeP4Z3146tETYKRgzQPuV2j65XP2lGZ58oWxSnkCZ5ISlxsaKNv/Hp68nKH9zMyE7c7D9z5PgCALWtRTb5PR4QovZSfgojk71vTrTMxln9mOAMKSeBc9cTV/i+5Ra42lfVrNnymBQ6qMCB4LnMSPNsVigroEvYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756314695; c=relaxed/simple;
	bh=DAJFkejaIVJcslszeNTokvRnSvwJYybmRvKq4DHoAxs=;
	h=Message-ID:Date:Mime-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CGBQSXELw2oy+cd4J7cnamT4wiyvTG3TnDwCvyoJCQve6mPkPke5VOtfdxJm+LW6ndjlZgdehO/WfOu0Mb6xJ5WiiKUmfhYLaUeuiMjBv/hiwD5R+5zlulrha8QX8Aep2pTG6HsomxRVZAAJrSDVYGTzaY9NlbIoTmoVZEVcoxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=MixYYyvV; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from [IPV6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2] (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id 790052AE312;
	Wed, 27 Aug 2025 18:11:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1756314686;
	bh=vL5yF31Qf5S2szLwv8dcsDNFgKmCDLTSKqr6YFAIaaY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MixYYyvV1CFphSyG7xXjq8UuY2zoAU5SR9nPoI6SFQhFP86U3hGys5ZUnYG3tbLlV
	 Mx8B6A2du6H5ql0R2vk/++LQlVWhsoZDXoo5i19l5kqTist2RdDIAxsYybxJufr7GH
	 NQ1fCMTAaAbc8G+dj+d/6Q51TvSm46+osxC0t5Ps=
Message-ID: <8794e565-9b8a-4944-91ff-eb34cd04fd1b@harmstone.com>
Date: Wed, 27 Aug 2025 18:11:26 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v2 10/16] btrfs: handle deletions from remapped block
 group
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <20250813143509.31073-1-mark@harmstone.com>
 <20250813143509.31073-11-mark@harmstone.com>
 <20250816002822.GE3042054@zen.localdomain>
Content-Language: en-US
From: Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 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
In-Reply-To: <20250816002822.GE3042054@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/08/2025 1.28 am, Boris Burkov wrote:
> On Wed, Aug 13, 2025 at 03:34:52PM +0100, Mark Harmstone wrote:
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
>>   fs/btrfs/block-group.c |  82 ++++---
>>   fs/btrfs/block-group.h |   1 +
>>   fs/btrfs/disk-io.c     |   1 +
>>   fs/btrfs/extent-tree.c |  28 ++-
>>   fs/btrfs/fs.h          |   1 +
>>   fs/btrfs/relocation.c  | 510 +++++++++++++++++++++++++++++++++++++++++
>>   fs/btrfs/relocation.h  |   3 +
>>   fs/btrfs/volumes.c     |  56 +++--
>>   fs/btrfs/volumes.h     |   6 +
>>   9 files changed, 630 insertions(+), 58 deletions(-)
>>
>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>> index 8c28f829547e..7a0524138235 100644
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
>> @@ -1539,6 +1548,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>>   	while (!list_empty(&fs_info->unused_bgs)) {
>>   		u64 used;
>>   		int trimming;
>> +		bool made_ro = false;
>>   
>>   		block_group = list_first_entry(&fs_info->unused_bgs,
>>   					       struct btrfs_block_group,
>> @@ -1575,7 +1585,8 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>>   
>>   		spin_lock(&space_info->lock);
>>   		spin_lock(&block_group->lock);
>> -		if (btrfs_is_block_group_used(block_group) || block_group->ro ||
>> +		if (btrfs_is_block_group_used(block_group) ||
>> +		    (block_group->ro && !(block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED)) ||
>>   		    list_is_singular(&block_group->list)) {
>>   			/*
>>   			 * We want to bail if we made new allocations or have
>> @@ -1617,9 +1628,10 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>>   		 * needing to allocate extents from the block group.
>>   		 */
>>   		used = btrfs_space_info_used(space_info, true);
>> -		if ((space_info->total_bytes - block_group->length < used &&
>> +		if (((space_info->total_bytes - block_group->length < used &&
>>   		     block_group->zone_unusable < block_group->length) ||
>> -		    has_unwritten_metadata(block_group)) {
>> +		    has_unwritten_metadata(block_group)) &&
>> +			!(block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED)) {
>>   			spin_unlock(&block_group->lock);
>>   
>>   			/*
>> @@ -1638,8 +1650,14 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
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
>> @@ -1648,7 +1666,8 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>>   
>>   		ret = btrfs_zone_finish(block_group);
>>   		if (ret < 0) {
>> -			btrfs_dec_block_group_ro(block_group);
>> +			if (made_ro)
>> +				btrfs_dec_block_group_ro(block_group);
>>   			if (ret == -EAGAIN) {
>>   				btrfs_link_bg_list(block_group, &retry_list);
>>   				ret = 0;
>> @@ -1663,7 +1682,8 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>>   		trans = btrfs_start_trans_remove_block_group(fs_info,
>>   						     block_group->start);
>>   		if (IS_ERR(trans)) {
>> -			btrfs_dec_block_group_ro(block_group);
>> +			if (made_ro)
>> +				btrfs_dec_block_group_ro(block_group);
>>   			ret = PTR_ERR(trans);
>>   			goto next;
>>   		}
>> @@ -1673,7 +1693,8 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>>   		 * just delete them, we don't care about them anymore.
>>   		 */
>>   		if (!clean_pinned_extents(trans, block_group)) {
>> -			btrfs_dec_block_group_ro(block_group);
>> +			if (made_ro)
>> +				btrfs_dec_block_group_ro(block_group);
>>   			goto end_trans;
>>   		}
>>   
>> @@ -1687,7 +1708,8 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>>   		spin_lock(&fs_info->discard_ctl.lock);
>>   		if (!list_empty(&block_group->discard_list)) {
>>   			spin_unlock(&fs_info->discard_ctl.lock);
>> -			btrfs_dec_block_group_ro(block_group);
>> +			if (made_ro)
>> +				btrfs_dec_block_group_ro(block_group);
>>   			btrfs_discard_queue_work(&fs_info->discard_ctl,
>>   						 block_group);
>>   			goto end_trans;
>> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
>> index ecc89701b2ea..0433b0127ed8 100644
>> --- a/fs/btrfs/block-group.h
>> +++ b/fs/btrfs/block-group.h
>> @@ -336,6 +336,7 @@ int btrfs_add_new_free_space(struct btrfs_block_group *block_group,
>>   struct btrfs_trans_handle *btrfs_start_trans_remove_block_group(
>>   				struct btrfs_fs_info *fs_info,
>>   				const u64 chunk_offset);
>> +void btrfs_remove_bg_from_sinfo(struct btrfs_block_group *block_group);
>>   int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
>>   			     struct btrfs_chunk_map *map);
>>   void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info);
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index 563aea5e3b1b..d92d08316322 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -2907,6 +2907,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
>>   	mutex_init(&fs_info->chunk_mutex);
>>   	mutex_init(&fs_info->transaction_kthread_mutex);
>>   	mutex_init(&fs_info->cleaner_mutex);
>> +	mutex_init(&fs_info->remap_mutex);
>>   	mutex_init(&fs_info->ro_block_group_mutex);
>>   	init_rwsem(&fs_info->commit_root_sem);
>>   	init_rwsem(&fs_info->cleanup_work_sem);
>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>> index c1b96c728fe6..ca3f6d6bb5ba 100644
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
>> @@ -2999,7 +3000,8 @@ u64 btrfs_get_extent_owner_root(struct btrfs_fs_info *fs_info,
>>   }
>>   
>>   static int do_free_extent_accounting(struct btrfs_trans_handle *trans,
>> -				     u64 bytenr, struct btrfs_squota_delta *delta)
>> +				     u64 bytenr, struct btrfs_squota_delta *delta,
>> +				     bool remapped)
>>   {
>>   	int ret;
>>   	u64 num_bytes = delta->num_bytes;
>> @@ -3027,10 +3029,16 @@ static int do_free_extent_accounting(struct btrfs_trans_handle *trans,
>>   		return ret;
>>   	}
>>   
>> -	ret = btrfs_add_to_free_space_tree(trans, bytenr, num_bytes);
>> -	if (ret) {
>> -		btrfs_abort_transaction(trans, ret);
>> -		return ret;
>> +	/*
>> +	 * If remapped, FST has already been taken care of in
>> +	 * remove_range_from_remap_tree().
>> +	 */
> 
> Why not do btrfs_remove_extent_from_remap_tree() here in
> do_free_extent_accounting() rather than the caller?
> 
>> +	if (!remapped) {
>> +		ret = btrfs_add_to_free_space_tree(trans, bytenr, num_bytes);
>> +		if (ret) {
>> +			btrfs_abort_transaction(trans, ret);
>> +			return ret;
>> +		}
>>   	}
>>   
>>   	ret = btrfs_update_block_group(trans, bytenr, num_bytes, false);
> 
> So in the normal case, this will trigger updating the block group bytes
> counters, and when they hit 0 put the block group on the unused list,
> which queues it for deletion and ultimately removing from space info
> etc.
> 
> I fail to see what is special about remapped block groups from that
> perspective. I would strongly prefer to see you integrate with
> btrsf_delete_unused_bgs() rather than special case skipping it there and
> copying parts of the logic elsewhere.
> 
> Unless there is some very good reason for the special treatment that I
> am not seeing.

Two reasons:

1) The FST uses underlying addresses, and bytenr here is a (potentially)
remapped address. So if the BG has the remapped flag set, the range needs
to be run through the remap tree.

2) It's conditional: if it's an identity remap it's already had its FST
entries removed when we started relocation. If it's a normal remap, we
need to remove the FST entries for the translated address. And of course
an extent can be covered by multiple remap entries in multiple block groups.

>> @@ -3396,7 +3404,15 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
>>   		}
>>   		btrfs_release_path(path);
>>   
>> -		ret = do_free_extent_accounting(trans, bytenr, &delta);
>> +		/* returns 1 on success and 0 on no-op */
>> +		ret = btrfs_remove_extent_from_remap_tree(trans, path, bytenr,
>> +							  num_bytes);
>> +		if (ret < 0) {
>> +			btrfs_abort_transaction(trans, ret);
>> +			goto out;
>> +		}
>> +
>> +		ret = do_free_extent_accounting(trans, bytenr, &delta, ret);
>>   	}
>>   	btrfs_release_path(path);
>>   
>> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
>> index 6ea96e76655e..dbb7de95241b 100644
>> --- a/fs/btrfs/fs.h
>> +++ b/fs/btrfs/fs.h
>> @@ -547,6 +547,7 @@ struct btrfs_fs_info {
>>   	struct mutex transaction_kthread_mutex;
>>   	struct mutex cleaner_mutex;
>>   	struct mutex chunk_mutex;
>> +	struct mutex remap_mutex;
>>   
>>   	/*
>>   	 * This is taken to make sure we don't set block groups ro after the
>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>> index e1f1da9336e7..03a1246af678 100644
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
>> @@ -3884,6 +3885,148 @@ static const char *stage_to_string(enum reloc_stage stage)
>>   	return "unknown";
>>   }
>>   
>> +static void adjust_block_group_remap_bytes(struct btrfs_trans_handle *trans,
>> +					   struct btrfs_block_group *bg,
>> +					   s64 diff)
>> +{
>> +	struct btrfs_fs_info *fs_info = trans->fs_info;
>> +	bool bg_already_dirty = true;
>> +
>> +	bg->remap_bytes += diff;
>> +
>> +	if (bg->used == 0 && bg->remap_bytes == 0)
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
> 
> Same question as elsewhere, but placed here for clarity:
> Why can't this be queued for normal unused bgs deletion, rather than
> having a special remap bg deletion function?

remove_chunk_stripes() is called when a block group becomes fully remapped,
i.e. its last identity remap has gone. We're not deleting a block group
here.

>> +static int last_identity_remap_gone(struct btrfs_trans_handle *trans,
>> +				    struct btrfs_chunk_map *chunk,
>> +				    struct btrfs_block_group *bg,
>> +				    struct btrfs_path *path)
>> +{
>> +	int ret;
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
>> +	ret = remove_chunk_stripes(trans, chunk, path);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +
>> +static int adjust_identity_remap_count(struct btrfs_trans_handle *trans,
>> +				       struct btrfs_path *path,
>> +				       struct btrfs_block_group *bg, int delta)
>> +{
>> +	struct btrfs_fs_info *fs_info = trans->fs_info;
>> +	struct btrfs_chunk_map *chunk;
>> +	bool bg_already_dirty = true;
>> +	int ret;
>> +
>> +	WARN_ON(delta < 0 && -delta > bg->identity_remap_count);
>> +
>> +	bg->identity_remap_count += delta;
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
>> +	if (bg->identity_remap_count != 0)
>> +		return 0;
>> +
>> +	chunk = btrfs_find_chunk_map(fs_info, bg->start, 1);
>> +	if (!chunk)
>> +		return -ENOENT;
>> +
>> +	ret = last_identity_remap_gone(trans, chunk, bg, path);
>> +	if (ret)
>> +		goto end;
>> +
>> +	ret = 0;
>> +end:
>> +	btrfs_free_chunk_map(chunk);
>> +	return ret;
>> +}
>> +
>>   int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
>>   			  u64 *length, bool nolock)
>>   {
>> @@ -4504,3 +4647,370 @@ u64 btrfs_get_reloc_bg_bytenr(const struct btrfs_fs_info *fs_info)
>>   		logical = fs_info->reloc_ctl->block_group->start;
>>   	return logical;
>>   }
>> +
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
>> +			ret = adjust_identity_remap_count(trans, path, bg, -1);
>> +			if (ret)
>> +				goto end;
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
>> +			ret = adjust_identity_remap_count(trans, path, bg, 1);
>> +			if (ret)
>> +				goto end;
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
>> index a653c42a25a3..4b0bb34b3fc1 100644
>> --- a/fs/btrfs/relocation.h
>> +++ b/fs/btrfs/relocation.h
>> @@ -33,5 +33,8 @@ bool btrfs_should_ignore_reloc_root(const struct btrfs_root *root);
>>   u64 btrfs_get_reloc_bg_bytenr(const struct btrfs_fs_info *fs_info);
>>   int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
>>   			  u64 *length, bool nolock);
>> +int btrfs_remove_extent_from_remap_tree(struct btrfs_trans_handle *trans,
>> +					struct btrfs_path *path,
>> +					u64 bytenr, u64 num_bytes);
>>   
>>   #endif
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index a2c49cb8bfc6..fc2b3e7de32e 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -2941,8 +2941,8 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>>   	return ret;
>>   }
>>   
>> -static noinline int btrfs_update_device(struct btrfs_trans_handle *trans,
>> -					struct btrfs_device *device)
>> +int btrfs_update_device(struct btrfs_trans_handle *trans,
>> +			struct btrfs_device *device)
>>   {
>>   	int ret;
>>   	struct btrfs_path *path;
>> @@ -3246,25 +3246,13 @@ static int remove_chunk_item(struct btrfs_trans_handle *trans,
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
>> @@ -3285,7 +3273,7 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
>>   		if (ret) {
>>   			mutex_unlock(&fs_devices->device_list_mutex);
>>   			btrfs_abort_transaction(trans, ret);
>> -			goto out;
>> +			return ret;
>>   		}
>>   
>>   		if (device->bytes_used > 0) {
>> @@ -3305,6 +3293,30 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
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
>> @@ -5448,7 +5460,7 @@ static void chunk_map_device_set_bits(struct btrfs_chunk_map *map, unsigned int
>>   	}
>>   }
>>   
>> -static void chunk_map_device_clear_bits(struct btrfs_chunk_map *map, unsigned int bits)
>> +void btrfs_chunk_map_device_clear_bits(struct btrfs_chunk_map *map, unsigned int bits)
>>   {
>>   	for (int i = 0; i < map->num_stripes; i++) {
>>   		struct btrfs_io_stripe *stripe = &map->stripes[i];
>> @@ -5465,7 +5477,7 @@ void btrfs_remove_chunk_map(struct btrfs_fs_info *fs_info, struct btrfs_chunk_ma
>>   	write_lock(&fs_info->mapping_tree_lock);
>>   	rb_erase_cached(&map->rb_node, &fs_info->mapping_tree);
>>   	RB_CLEAR_NODE(&map->rb_node);
>> -	chunk_map_device_clear_bits(map, CHUNK_ALLOCATED);
>> +	btrfs_chunk_map_device_clear_bits(map, CHUNK_ALLOCATED);
>>   	write_unlock(&fs_info->mapping_tree_lock);
>>   
>>   	/* Once for the tree reference. */
>> @@ -5501,7 +5513,7 @@ int btrfs_add_chunk_map(struct btrfs_fs_info *fs_info, struct btrfs_chunk_map *m
>>   		return -EEXIST;
>>   	}
>>   	chunk_map_device_set_bits(map, CHUNK_ALLOCATED);
>> -	chunk_map_device_clear_bits(map, CHUNK_TRIMMED);
>> +	btrfs_chunk_map_device_clear_bits(map, CHUNK_TRIMMED);
>>   	write_unlock(&fs_info->mapping_tree_lock);
>>   
>>   	return 0;
>> @@ -5866,7 +5878,7 @@ void btrfs_mapping_tree_free(struct btrfs_fs_info *fs_info)
>>   		map = rb_entry(node, struct btrfs_chunk_map, rb_node);
>>   		rb_erase_cached(&map->rb_node, &fs_info->mapping_tree);
>>   		RB_CLEAR_NODE(&map->rb_node);
>> -		chunk_map_device_clear_bits(map, CHUNK_ALLOCATED);
>> +		btrfs_chunk_map_device_clear_bits(map, CHUNK_ALLOCATED);
>>   		/* Once for the tree ref. */
>>   		btrfs_free_chunk_map(map);
>>   		cond_resched_rwlock_write(&fs_info->mapping_tree_lock);
>> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
>> index 430be12fd5e7..64b34710b68b 100644
>> --- a/fs/btrfs/volumes.h
>> +++ b/fs/btrfs/volumes.h
>> @@ -789,6 +789,8 @@ u64 btrfs_calc_stripe_length(const struct btrfs_chunk_map *map);
>>   int btrfs_nr_parity_stripes(u64 type);
>>   int btrfs_chunk_alloc_add_chunk_item(struct btrfs_trans_handle *trans,
>>   				     struct btrfs_block_group *bg);
>> +int btrfs_remove_dev_extents(struct btrfs_trans_handle *trans,
>> +			     struct btrfs_chunk_map *map);
>>   int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset);
>>   
>>   #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
>> @@ -900,6 +902,10 @@ bool btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical);
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


