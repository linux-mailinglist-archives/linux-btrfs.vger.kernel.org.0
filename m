Return-Path: <linux-btrfs+bounces-16465-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26994B389D3
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Aug 2025 20:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2871C1B27540
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Aug 2025 18:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AFA2E0921;
	Wed, 27 Aug 2025 18:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="DtzeRR5C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27711C8632
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Aug 2025 18:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756320713; cv=none; b=LRZoso57AEZIgWdU/mwSGnh7hJANAqUvrBCYMyOrgfG1EeSSbuIOnO891enwu6AW8965Ege4wrdjl4++fkFPtsa3abo/j8k1Uq2GuZNVkSBfcrJLJFRV3TYnYyW+iHvqmYA5ppFQuYPyP9TFGhXwrvalhaecg8rbLRab08oNxtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756320713; c=relaxed/simple;
	bh=JDVEBnEu9WlXh+iB0+WgMI2kuygAowI8xD5YWgyo2ew=;
	h=Message-ID:Date:Mime-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P2lhH8vJWIByS3TY06to1vQjKoMAkp4qwv7jwEuiMWxTU1xFzhWdJ5Kn0RieEjRHHhxxbEBWH+M+rlI4QbMaazMrERxfEiE3zHzZFnXYv08GeuBDNVW1UloC/XmazyrZQEYOyJkqDuRG0KT+mpZYBiU/bT32uXwgfpq/EistQqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=DtzeRR5C; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from [IPV6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2] (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id A05A72AE38F;
	Wed, 27 Aug 2025 19:51:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1756320704;
	bh=Hz/olG3O9LbOEqJrn17WSKOBu7dc/GwU3Lc8MglatuY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DtzeRR5C/zRq917yaM4Sy75U9Ta1YPU8h0H91PEKURM6jzrzwDsCVkkrhdzLwRZ4p
	 7CsEHy7RWkSNRwYFf3/SFEN8F3NVlyuesMZHjy6JRygzPoLxZQlZ7gAOiOzoDuHpWs
	 U6WfQ/kZUCdZkYT2mBNEtwClqSsyPIcXqPciK5Zg=
Message-ID: <838dae19-cd6f-4763-9d61-494fa3986c69@harmstone.com>
Date: Wed, 27 Aug 2025 19:51:44 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v2 15/16] btrfs: add fully_remapped_bgs list
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <20250813143509.31073-1-mark@harmstone.com>
 <20250813143509.31073-16-mark@harmstone.com>
 <20250816005609.GG3042054@zen.localdomain>
Content-Language: en-US
From: Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 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
In-Reply-To: <20250816005609.GG3042054@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/08/2025 1.56 am, Boris Burkov wrote:
> On Wed, Aug 13, 2025 at 03:34:57PM +0100, Mark Harmstone wrote:
>> Add a fully_remapped_bgs list to struct btrfs_transaction, which holds
>> block groups which have just had their last identity remap removed.
>>
>> In btrfs_finish_extent_commit() we can then discard their full dev
>> extents, as we're also setting their num_stripes to 0. Finally if the BG
>> is now empty, i.e. there's neither identity remaps nor normal remaps,
>> add it to the unused_bgs list to be taken care of there.
>>
>> Signed-off-by: Mark Harmstone <mark@harmstone.com>
>> ---
>>   fs/btrfs/block-group.c | 26 ++++++++++++++++++++++++++
>>   fs/btrfs/block-group.h |  2 ++
>>   fs/btrfs/extent-tree.c | 37 ++++++++++++++++++++++++++++++++++++-
>>   fs/btrfs/relocation.c  |  2 ++
>>   fs/btrfs/transaction.c |  1 +
>>   fs/btrfs/transaction.h |  1 +
>>   6 files changed, 68 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>> index 7a0524138235..7f8707dfd62c 100644
>> --- a/fs/btrfs/block-group.c
>> +++ b/fs/btrfs/block-group.c
>> @@ -1803,6 +1803,14 @@ void btrfs_mark_bg_unused(struct btrfs_block_group *bg)
>>   	struct btrfs_fs_info *fs_info = bg->fs_info;
>>   
>>   	spin_lock(&fs_info->unused_bgs_lock);
>> +
>> +	/* Leave fully remapped block groups on the fully_remapped_bgs list. */
>> +	if (bg->flags & BTRFS_BLOCK_GROUP_REMAPPED &&
>> +	    bg->identity_remap_count == 0) {
>> +		spin_unlock(&fs_info->unused_bgs_lock);
>> +		return;
>> +	}
>> +
>>   	if (list_empty(&bg->bg_list)) {
>>   		btrfs_get_block_group(bg);
>>   		trace_btrfs_add_unused_block_group(bg);
>> @@ -4792,3 +4800,21 @@ bool btrfs_block_group_should_use_size_class(const struct btrfs_block_group *bg)
>>   		return false;
>>   	return true;
>>   }
>> +
>> +void btrfs_mark_bg_fully_remapped(struct btrfs_block_group *bg,
>> +				  struct btrfs_trans_handle *trans)
>> +{
>> +	struct btrfs_fs_info *fs_info = trans->fs_info;
>> +
>> +	spin_lock(&fs_info->unused_bgs_lock);
>> +
>> +	if (!list_empty(&bg->bg_list))
>> +		list_del(&bg->bg_list);
>> +	else
>> +		btrfs_get_block_group(bg);
>> +
>> +	list_add_tail(&bg->bg_list, &trans->transaction->fully_remapped_bgs);
>> +
>> +	spin_unlock(&fs_info->unused_bgs_lock);
>> +
>> +}
> 
> Why does the fully remapped bg list takeover from other lists rather
> than use the link function?

Because it's possible in the same transaction for a block group to become
both fully remapped (no identity remaps left) and unused (no addresses
nominally in this address range). In this case it goes on the fully
remapped list for its chunk stripes and dev extents to be removed, then
gets moved to the unused list for its block group item to be removed.

> What protection is in place to ensure that we never mark it fully
> remapped while it is on the new_bgs list (as with the unused list)?

Relocating a block group starts a transaction, so it won't be on the
new_bgs list anymore. btrfs_relocate_chunk() provides the BG offset
to btrfs_relocate_block_group(), which in turn starts multiple
transactions, which ensure that that particular BG isn't on new_bgs.
Or am I misunderstanding?

> I suspect such a block group won't ever be reclaimed even with explicit
> balances, but it is important to check and be sure.

I'll need to double-check that a remapped BG can't be placed on the
reclaimed_bgs list. In effect it's already been "reclaimed".
  > If this *is* strictly necessary, I would like to see an extension to
> btrfs_link_bg_list that can handle the list_move_tail variant.
> 
> Another option is to generalize this one together with mark_unused()
> and just check the NEW flag here.
> 
>> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
>> index 0433b0127ed8..025ea2c6f8a8 100644
>> --- a/fs/btrfs/block-group.h
>> +++ b/fs/btrfs/block-group.h
>> @@ -408,5 +408,7 @@ int btrfs_use_block_group_size_class(struct btrfs_block_group *bg,
>>   				     enum btrfs_block_group_size_class size_class,
>>   				     bool force_wrong_size_class);
>>   bool btrfs_block_group_should_use_size_class(const struct btrfs_block_group *bg);
>> +void btrfs_mark_bg_fully_remapped(struct btrfs_block_group *bg,
>> +				  struct btrfs_trans_handle *trans);
>>   
>>   #endif /* BTRFS_BLOCK_GROUP_H */
>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>> index b02e99b41553..157a032df128 100644
>> --- a/fs/btrfs/extent-tree.c
>> +++ b/fs/btrfs/extent-tree.c
>> @@ -2853,7 +2853,7 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
>>   {
>>   	struct btrfs_fs_info *fs_info = trans->fs_info;
>>   	struct btrfs_block_group *block_group, *tmp;
>> -	struct list_head *deleted_bgs;
>> +	struct list_head *deleted_bgs, *fully_remapped_bgs;
>>   	struct extent_io_tree *unpin = &trans->transaction->pinned_extents;
>>   	struct extent_state *cached_state = NULL;
>>   	u64 start;
>> @@ -2951,6 +2951,41 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
>>   		}
>>   	}
>>   
> 
> 1. This will block the next transaction waiting on TRANS_STATE_COMPLETED
> 
> 2. This is not compatible with the spirit and purpose of async discard,
> which is our default and best discard mode.
> 
> 3. This doesn't check discard mode at all, it just defaults to
> DISCARD_SYNC style behavior, so it doesn't respect NODISCARD either.

I think at the least this should be shunted off to a work queue, as I've said to
you off-list.

So the current logic is that no discards get done for removals within a remapped
BG, nor by the relocation process, on the grounds that the whole thing is going
away imminently. Once the last identity remap has gone, we do a discard for the
whole range. That means only one discard per stripe, and prevents any problems
with search_commit_root.

Leaving aside the blocking of the next transaction, is this the right way to
do things, or should it be done somehow else?

>> +	fully_remapped_bgs = &trans->transaction->fully_remapped_bgs;
>> +	list_for_each_entry_safe(block_group, tmp, fully_remapped_bgs, bg_list) {
>> +		struct btrfs_chunk_map *map;
>> +
>> +		if (!TRANS_ABORTED(trans))
>> +			ret = btrfs_discard_extent(fs_info, block_group->start,
>> +						   block_group->length, NULL,
>> +						   false);
>> +
>> +		map = btrfs_get_chunk_map(fs_info, block_group->start, 1);
>> +		if (IS_ERR(map))
>> +			return PTR_ERR(map);
>> +
>> +		/*
>> +		 * Set num_stripes to 0, so that btrfs_remove_dev_extents()
>> +		 * won't run a second time.
>> +		 */
>> +		map->num_stripes = 0;
>> +
>> +		btrfs_free_chunk_map(map);
>> +
>> +		if (block_group->used == 0 && block_group->remap_bytes == 0) {
>> +			spin_lock(&fs_info->unused_bgs_lock);
>> +			list_move_tail(&block_group->bg_list,
>> +				       &fs_info->unused_bgs);
>> +			spin_unlock(&fs_info->unused_bgs_lock);
> 
> Please use the helpers, it's important for ensuring correct ref counting
> in the long run. I also think that the previous patch had some
> discussion for more standardized integration with unused_bgs so I sort
> of hope this code goes away entirely.
> 
>> +		} else {
>> +			spin_lock(&fs_info->unused_bgs_lock);
>> +			list_del_init(&block_group->bg_list);
>> +			spin_unlock(&fs_info->unused_bgs_lock);
>> +
>> +			btrfs_put_block_group(block_group);
>> +		}
>> +	}
>> +
>>   	return unpin_error;
>>   }
>>   
>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>> index 84ff59866e96..0745a3d1c867 100644
>> --- a/fs/btrfs/relocation.c
>> +++ b/fs/btrfs/relocation.c
>> @@ -4819,6 +4819,8 @@ static int last_identity_remap_gone(struct btrfs_trans_handle *trans,
>>   	if (ret)
>>   		return ret;
>>   
>> +	btrfs_mark_bg_fully_remapped(bg, trans);
>> +
>>   	return 0;
>>   }
>>   
>> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
>> index 64b9c427af6a..7c308d33e767 100644
>> --- a/fs/btrfs/transaction.c
>> +++ b/fs/btrfs/transaction.c
>> @@ -381,6 +381,7 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
>>   	mutex_init(&cur_trans->cache_write_mutex);
>>   	spin_lock_init(&cur_trans->dirty_bgs_lock);
>>   	INIT_LIST_HEAD(&cur_trans->deleted_bgs);
>> +	INIT_LIST_HEAD(&cur_trans->fully_remapped_bgs);
>>   	spin_lock_init(&cur_trans->dropped_roots_lock);
>>   	list_add_tail(&cur_trans->list, &fs_info->trans_list);
>>   	btrfs_extent_io_tree_init(fs_info, &cur_trans->dirty_pages,
>> diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
>> index 9f7c777af635..b362915288b5 100644
>> --- a/fs/btrfs/transaction.h
>> +++ b/fs/btrfs/transaction.h
>> @@ -109,6 +109,7 @@ struct btrfs_transaction {
>>   	spinlock_t dirty_bgs_lock;
>>   	/* Protected by spin lock fs_info->unused_bgs_lock. */
>>   	struct list_head deleted_bgs;
>> +	struct list_head fully_remapped_bgs;
>>   	spinlock_t dropped_roots_lock;
>>   	struct btrfs_delayed_ref_root delayed_refs;
>>   	struct btrfs_fs_info *fs_info;
>> -- 
>> 2.49.1
>>


