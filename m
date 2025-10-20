Return-Path: <linux-btrfs+bounces-18063-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 368D9BF1ED3
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 16:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4DCDE4F52D0
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 14:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F5B2288E3;
	Mon, 20 Oct 2025 14:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="DhMFVLPA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (unknown [62.3.69.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FFC2222A9
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 14:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.3.69.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760971959; cv=none; b=YOw3++y4o9E7c2o+HRs1lYNkgliY+GAgtVERDdDpWFqVgYrzJeP0kFz1278Z6fCLZAN3NSqU00gH4VJ7huxsxLd3xfYc4JhNLPptinx+Pk1dgbUxHzun76OXrit30gJ+BoMevQokcsoQ7bmqzZAv5rdhg0t5wl6Q4349Zl95WOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760971959; c=relaxed/simple;
	bh=LegPWj5q9m8zkRRWPmL4TN5qRACX3NoNuEY7gWivPfQ=;
	h=Message-ID:Date:Mime-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GLa+Gl3dL4aaI/Y9qNv+maH295FnGdTZnFdXpfvRfn1htWYJDoCsiz9UWFWHQe/T9Vkp4ZfXjyWV0pAezv9LTrnab5YJIPGW3zU4ug/jm5g+8dm4h/+8YtIjVW/MD2ElVcBTDTu/eNvPdH66sKk4tbglmvIzoVDTYA9hPxetwTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=fail smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=DhMFVLPA; arc=none smtp.client-ip=62.3.69.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=harmstone.com
Received: from [IPV6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2] (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id 220DA2CD6A6;
	Mon, 20 Oct 2025 15:52:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1760971954;
	bh=aFooCPpdV2XXiNSjWXJKJ2rLGbJ0hfdCRSbLoFQ0qE8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DhMFVLPAYkiZWK2hJ5vVVIsA+nWG6EE6nwIpsdJuWBSjJngDaj6sJbx+wvjH5vgs0
	 kSJlAJAImcz5GH1vYxsCsPjArluVO49FCfJb9CUlpH8v+4b+0WufLilbKmg1TcRPO5
	 pKZi29GJL/3iNyBgDcYHSRDMNFlxtJdx//Qae/+c=
Message-ID: <9bd6fb1e-500e-48df-aa9f-6ec82caeaba2@harmstone.com>
Date: Mon, 20 Oct 2025 15:52:34 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v3 17/17] btrfs: add stripe removal pending flag
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <20251009112814.13942-1-mark@harmstone.com>
 <20251009112814.13942-18-mark@harmstone.com>
 <20251015050537.GJ1702774@zen.localdomain>
Content-Language: en-US
From: Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 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
In-Reply-To: <20251015050537.GJ1702774@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/10/2025 6.05 am, Boris Burkov wrote:
> On Thu, Oct 09, 2025 at 12:28:12PM +0100, Mark Harmstone wrote:
>> If the filesystem is unmounted while the async discard of a fully remapped
>> block group is in progress, its unused device extents will never be freed.
>>
>> To counter this, add a new flag BTRFS_BLOCK_GROUP_STRIPE_REMOVAL_PENDING
>> to say that this has been interrupted. Set it in the transaction in which
>> the last identity remap has been removed, clear it when we remove the
>> device extents, and if we encounter it on mount queue that block group
>> up for discard.
> 
> I don't see how this is special for remapped block groups.
> 
> in read_one_block_group() for empty block groups we queue them for async
> discard unconditionally. There is a comment to this effect in discard.c
> about crashes and mounts behaving the same.
> 
> And either way, if we go down at any point before we remove the bg, then
> we will be re-discarding everything we already discarded (possibly the
> whole thing) so this is optimistic anyway, right?
> 
> I don't think the benefit of this is worth the special case compared to
> normal unused bgs, and I don't think it makes sense to "take advantage"
> of this format change opportunity to also add the persisted "needs
> discard" bit for all discard.
> 
> A persisted "discard state" on the extents would actually be
> interesting, I think, but I don't think that is in scope or even
> necessarily a good idea.
> 
> Thanks,
> Boris

So here we need to find block groups that:
* have the REMAPPED flag set
* have identity_remap_count == 0 (i.e. are fully remapped)
* have a corresponding chunk item where num_stripes != 0

They aren't empty in the same way as empty BGs are now: their used value
might be non-zero, meaning that there's extents that are nominally within
the range. The device extents don't get freed until discard has run, so
it's pretty important that this gets done.

The problem is that num_stripes is on the chunk item rather than the BG
item, so you would need to do a lookup in the other tree on mount for
every single fully-remapped BG, on the off chance that one of them hasn't
had its stripes removed. The flag's there to prevent us having to do the
lookup, as we know in advance which BG they will be.

Probably in an ideal world we'd have a merged BG and chunk tree, but we
are where we are.

>>
>> Signed-off-by: Mark Harmstone <mark@harmstone.com>
>> ---
>>   fs/btrfs/block-group.c          | 35 ++++++++++++++++++++++++++++++++-
>>   fs/btrfs/free-space-cache.c     |  5 +++++
>>   fs/btrfs/relocation.c           | 18 +++++++++++++++++
>>   include/uapi/linux/btrfs_tree.h |  1 +
>>   4 files changed, 58 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>> index a7dfa6c95223..851d76ce8ec9 100644
>> --- a/fs/btrfs/block-group.c
>> +++ b/fs/btrfs/block-group.c
>> @@ -2530,6 +2530,16 @@ static int read_one_block_group(struct btrfs_fs_info *info,
>>   		inc_block_group_ro(cache, 1);
>>   	}
>>   
>> +	if (cache->flags & BTRFS_BLOCK_GROUP_STRIPE_REMOVAL_PENDING) {
>> +		btrfs_get_block_group(cache);
>> +		spin_lock(&info->unused_bgs_lock);
>> +		list_add_tail(&cache->bg_list, &info->fully_remapped_bgs);
>> +		spin_unlock(&info->unused_bgs_lock);
>> +
>> +		if (btrfs_test_opt(info, DISCARD_ASYNC))
>> +			btrfs_discard_queue_work(&info->discard_ctl, cache);
>> +	}
>> +
>>   	return 0;
>>   error:
>>   	btrfs_put_block_group(cache);
>> @@ -4828,6 +4838,29 @@ void btrfs_mark_bg_fully_remapped(struct btrfs_block_group *bg,
>>   
>>   	spin_unlock(&fs_info->unused_bgs_lock);
>>   
>> -	if (btrfs_test_opt(fs_info, DISCARD_ASYNC))
>> +	if (btrfs_test_opt(fs_info, DISCARD_ASYNC)) {
>> +		bool bg_already_dirty = true;
>> +
>> +		spin_lock(&bg->lock);
>> +		bg->flags |= BTRFS_BLOCK_GROUP_STRIPE_REMOVAL_PENDING;
>> +		spin_unlock(&bg->lock);
>> +
>> +		spin_lock(&trans->transaction->dirty_bgs_lock);
>> +		if (list_empty(&bg->dirty_list)) {
>> +			list_add_tail(&bg->dirty_list,
>> +				      &trans->transaction->dirty_bgs);
>> +			bg_already_dirty = false;
>> +			btrfs_get_block_group(bg);
>> +		}
>> +		spin_unlock(&trans->transaction->dirty_bgs_lock);
>> +
>> +		/*
>> +		 * Modified block groups are accounted for in
>> +		 * the delayed_refs_rsv.
>> +		 */
>> +		if (!bg_already_dirty)
>> +			btrfs_inc_delayed_refs_rsv_bg_updates(trans->fs_info);
>> +
>>   		btrfs_discard_queue_work(&fs_info->discard_ctl, bg);
>> +	}
>>   }
>> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
>> index 56f27487b632..813b82294341 100644
>> --- a/fs/btrfs/free-space-cache.c
>> +++ b/fs/btrfs/free-space-cache.c
>> @@ -3065,6 +3065,7 @@ bool btrfs_is_free_space_trimmed(struct btrfs_block_group *block_group)
>>   	bool ret = true;
>>   
>>   	if (block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED &&
>> +	    !(block_group->flags & BTRFS_BLOCK_GROUP_STRIPE_REMOVAL_PENDING) &&
>>   	    block_group->remap_bytes == 0 &&
>>   	    block_group->identity_remap_count == 0) {
>>   		return true;
>> @@ -3845,6 +3846,9 @@ void btrfs_trim_fully_remapped_block_group(struct btrfs_block_group *bg)
>>   	struct btrfs_trans_handle *trans;
>>   	struct btrfs_chunk_map *map;
>>   
>> +	if (!(bg->flags & BTRFS_BLOCK_GROUP_STRIPE_REMOVAL_PENDING))
>> +		goto skip_discard;
>> +
>>   	while (bg->discard_cursor < end) {
>>   		u64 trimmed;
>>   
>> @@ -3897,6 +3901,7 @@ void btrfs_trim_fully_remapped_block_group(struct btrfs_block_group *bg)
>>   
>>   	btrfs_free_chunk_map(map);
>>   
>> +skip_discard:
>>   	if (bg->used == 0) {
>>   		spin_lock(&fs_info->unused_bgs_lock);
>>   		list_move_tail(&bg->bg_list, &fs_info->unused_bgs);
>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>> index 7bad8d65d145..a179e4a8e960 100644
>> --- a/fs/btrfs/relocation.c
>> +++ b/fs/btrfs/relocation.c
>> @@ -4733,6 +4733,7 @@ int btrfs_last_identity_remap_gone(struct btrfs_trans_handle *trans,
>>   				   struct btrfs_block_group *bg)
>>   {
>>   	int ret;
>> +	bool bg_already_dirty = true;
>>   	BTRFS_PATH_AUTO_FREE(path);
>>   
>>   	ret = btrfs_remove_dev_extents(trans, chunk);
>> @@ -4757,6 +4758,23 @@ int btrfs_last_identity_remap_gone(struct btrfs_trans_handle *trans,
>>   
>>   	btrfs_remove_bg_from_sinfo(bg);
>>   
>> +	spin_lock(&bg->lock);
>> +	bg->flags &= ~BTRFS_BLOCK_GROUP_STRIPE_REMOVAL_PENDING;
>> +	spin_unlock(&bg->lock);
>> +
>> +	spin_lock(&trans->transaction->dirty_bgs_lock);
>> +	if (list_empty(&bg->dirty_list)) {
>> +		list_add_tail(&bg->dirty_list,
>> +			      &trans->transaction->dirty_bgs);
>> +		bg_already_dirty = false;
>> +		btrfs_get_block_group(bg);
>> +	}
>> +	spin_unlock(&trans->transaction->dirty_bgs_lock);
>> +
>> +	/* Modified block groups are accounted for in the delayed_refs_rsv. */
>> +	if (!bg_already_dirty)
>> +		btrfs_inc_delayed_refs_rsv_bg_updates(trans->fs_info);
>> +
>>   	path = btrfs_alloc_path();
>>   	if (!path)
>>   		return -ENOMEM;
>> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
>> index 89bcb80081a6..36a7d1a3cbe3 100644
>> --- a/include/uapi/linux/btrfs_tree.h
>> +++ b/include/uapi/linux/btrfs_tree.h
>> @@ -1173,6 +1173,7 @@ struct btrfs_dev_replace_item {
>>   #define BTRFS_BLOCK_GROUP_RAID1C4       (1ULL << 10)
>>   #define BTRFS_BLOCK_GROUP_REMAPPED      (1ULL << 11)
>>   #define BTRFS_BLOCK_GROUP_REMAP         (1ULL << 12)
>> +#define BTRFS_BLOCK_GROUP_STRIPE_REMOVAL_PENDING	(1ULL << 13)
>>   #define BTRFS_BLOCK_GROUP_RESERVED	(BTRFS_AVAIL_ALLOC_BIT_SINGLE | \
>>   					 BTRFS_SPACE_INFO_GLOBAL_RSV)
>>   
>> -- 
>> 2.49.1
>>


