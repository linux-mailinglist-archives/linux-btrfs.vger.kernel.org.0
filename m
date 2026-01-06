Return-Path: <linux-btrfs+bounces-20156-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 351A3CF857B
	for <lists+linux-btrfs@lfdr.de>; Tue, 06 Jan 2026 13:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 920C230390EA
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jan 2026 12:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5802EFD86;
	Tue,  6 Jan 2026 12:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="q9A28cCh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334541624C5
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Jan 2026 12:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767702500; cv=none; b=L9l6u0+usyx9l+I70uWC3Mx0aqImgMPkmUcvzi2oKRg6PN95eENZCn+qdiO5rNlpTV/FnZhXq61u+jSZqkUm+ot1adfyOqe7u9Bl0yyYAbXxzkWt3ZjzYQODfu1XhbnI8F//ChX5eseVHfox2wvkf7l8AlIx39lP9S9Xl2L2E7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767702500; c=relaxed/simple;
	bh=vZP7e1rPTIDLjzjeOoOY4zymylTQH0xeHf7PZjEzweY=;
	h=Message-ID:Date:Mime-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V3OIsi8kRxByi94FK6AfeEmBkEqt4XYumuiIyG0UbBUWWr+pZnkaNxNNS2HvWZi9TqYA9wu0wvk3urTtn8hPn2ipDhaFQ9m1sWNT0ohnllNVJ9SlcPkuDtjH+miQdCZqC49IDw1bve555tT+R4J7WF/KBGBToIg+0Yie5AyJz/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=q9A28cCh; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from [IPV6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2] (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id 2148E2F10C2;
	Tue,  6 Jan 2026 12:20:56 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1767702056;
	bh=Mh2UDc/MFdFdlSLjkyiNUY/D3H+4CZOws22xlmKZY3Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=q9A28cChdBUh2ru53KY5TQSiuOnOwaFGr0B8dtcA8Gp41LpEoJnBV769yCfXNxbvk
	 oEZ/GzTecg0x5m0kMns0RjLVG55mfsjCQMVRU13sf4gDktHHcGkIIfkav+gn0Mun/8
	 9e0PjOJ2eW1gNGxDkXFeexyyfnqHhDlKdBEu9aCE=
Message-ID: <e30eea6e-d864-45db-905f-fc3c6db7e262@harmstone.com>
Date: Tue, 6 Jan 2026 12:20:55 +0000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v7 10/16] btrfs: handle setting up relocation of block
 group with remap-tree
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org, Boris Burkov <boris@bur.io>
References: <20251124185335.16556-1-mark@harmstone.com>
 <20251124185335.16556-11-mark@harmstone.com>
 <20251219015605.GY3195@twin.jikos.cz>
Content-Language: en-US
From: Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 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
In-Reply-To: <20251219015605.GY3195@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/12/2025 1.56 am, David Sterba wrote:
> On Mon, Nov 24, 2025 at 06:53:02PM +0000, Mark Harmstone wrote:
>> Handle the preliminary work for relocating a block group in a filesystem
>> with the remap-tree flag set.
>>
>> If the block group is SYSTEM btrfs_relocate_block_group() proceeds as it
>> does already, as bootstrapping issues mean that these block groups have
>> to be processed the existing way. Similarly with REMAP blocks, which are
>> dealt with in a later patch.
>>
>> Otherwise we walk the free-space tree for the block group in question,
>> recording any holes. These get converted into identity remaps and placed
>> in the remap tree, and the block group's REMAPPED flag is set. From now
>> on no new allocations are possible within this block group, and any I/O
>> to it will be funnelled through btrfs_translate_remap(). We store the
>> number of identity remaps in `identity_remap_count`, so that we know
>> when we've removed the last one and the block group is fully remapped.
>>
>> The change in btrfs_read_roots() is because data relocations no longer
>> rely on the data reloc tree as a hidden subvolume in which to do
>> snapshots.
>>
>> (Thanks to Sun YangKai for his suggestions.)
>>
>> Signed-off-by: Mark Harmstone <mark@harmstone.com>
>> Reviewed-by: Boris Burkov <boris@bur.io>
>> ---
>>   fs/btrfs/block-group.c     |   6 +-
>>   fs/btrfs/block-group.h     |   4 +
>>   fs/btrfs/free-space-tree.c |   4 +-
>>   fs/btrfs/free-space-tree.h |   5 +-
>>   fs/btrfs/relocation.c      | 516 +++++++++++++++++++++++++++++++++----
>>   fs/btrfs/relocation.h      |  11 +
>>   fs/btrfs/space-info.c      |   9 +-
>>   fs/btrfs/volumes.c         |  91 ++++---
>>   8 files changed, 553 insertions(+), 93 deletions(-)
>>
>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>> index 16a828d3d910..5fa6910e9813 100644
>> --- a/fs/btrfs/block-group.c
>> +++ b/fs/btrfs/block-group.c
>> @@ -2413,6 +2413,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
>>   	cache->used = btrfs_stack_block_group_v2_used(bgi);
>>   	cache->commit_used = cache->used;
>>   	cache->flags = btrfs_stack_block_group_v2_flags(bgi);
>> +	cache->commit_flags = cache->flags;
>>   	cache->global_root_id = btrfs_stack_block_group_v2_chunk_objectid(bgi);
>>   	cache->space_info = btrfs_find_space_info(info, cache->flags);
>>   	cache->remap_bytes = btrfs_stack_block_group_v2_remap_bytes(bgi);
>> @@ -2722,6 +2723,7 @@ static int insert_block_group_item(struct btrfs_trans_handle *trans,
>>   	block_group->commit_remap_bytes = block_group->remap_bytes;
>>   	block_group->commit_identity_remap_count =
>>   		block_group->identity_remap_count;
>> +	block_group->commit_flags = block_group->flags;
>>   	key.objectid = block_group->start;
>>   	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
>>   	key.offset = block_group->length;
>> @@ -3210,13 +3212,15 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
>>   	/* No change in values, can safely skip it. */
>>   	if (cache->commit_used == used &&
>>   	    cache->commit_remap_bytes == remap_bytes &&
>> -	    cache->commit_identity_remap_count == identity_remap_count) {
>> +	    cache->commit_identity_remap_count == identity_remap_count &&
>> +	    cache->commit_flags == cache->flags) {
>>   		spin_unlock(&cache->lock);
>>   		return 0;
>>   	}
>>   	cache->commit_used = used;
>>   	cache->commit_remap_bytes = remap_bytes;
>>   	cache->commit_identity_remap_count = identity_remap_count;
>> +	cache->commit_flags = cache->flags;
>>   	spin_unlock(&cache->lock);
>>   
>>   	key.objectid = cache->start;
>> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
>> index 45a512910666..fd28353b4511 100644
>> --- a/fs/btrfs/block-group.h
>> +++ b/fs/btrfs/block-group.h
>> @@ -146,6 +146,10 @@ struct btrfs_block_group {
>>   	 * The last commited identity_remap_count value of this block group.
>>   	 */
>>   	u32 commit_identity_remap_count;
>> +	/*
>> +	 * The last committed flags value for this block group.
>> +	 */
>> +	u64 commit_flags;
> 
> This is a bit confusing as it's not clear it means the 'last' committed
> flags, so I suggest to use "last_" prefix, also for other struct members
> in block group.
> 
>>   
>>   	/*
>>   	 * If the free space extent count exceeds this number, convert the block
>> diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
>> index 1ad2ad384b9e..ae2f39af9ba0 100644
>> --- a/fs/btrfs/free-space-tree.c
>> +++ b/fs/btrfs/free-space-tree.c
>> @@ -21,8 +21,7 @@ static int __add_block_group_free_space(struct btrfs_trans_handle *trans,
>>   					struct btrfs_block_group *block_group,
>>   					struct btrfs_path *path);
>>   
>> -static struct btrfs_root *btrfs_free_space_root(
>> -				struct btrfs_block_group *block_group)
>> +struct btrfs_root *btrfs_free_space_root(struct btrfs_block_group *block_group)
>>   {
>>   	struct btrfs_key key = {
>>   		.objectid = BTRFS_FREE_SPACE_TREE_OBJECTID,
>> @@ -93,7 +92,6 @@ static int add_new_free_space_info(struct btrfs_trans_handle *trans,
>>   	return 0;
>>   }
>>   
>> -EXPORT_FOR_TESTS
>>   struct btrfs_free_space_info *btrfs_search_free_space_info(
>>   		struct btrfs_trans_handle *trans,
>>   		struct btrfs_block_group *block_group,
>> diff --git a/fs/btrfs/free-space-tree.h b/fs/btrfs/free-space-tree.h
>> index 3d9a5d4477fc..89d2ff7e5c18 100644
>> --- a/fs/btrfs/free-space-tree.h
>> +++ b/fs/btrfs/free-space-tree.h
>> @@ -35,12 +35,13 @@ int btrfs_add_to_free_space_tree(struct btrfs_trans_handle *trans,
>>   				 u64 start, u64 size);
>>   int btrfs_remove_from_free_space_tree(struct btrfs_trans_handle *trans,
>>   				      u64 start, u64 size);
>> -
>> -#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
>>   struct btrfs_free_space_info *
>>   btrfs_search_free_space_info(struct btrfs_trans_handle *trans,
>>   			     struct btrfs_block_group *block_group,
>>   			     struct btrfs_path *path, int cow);
>> +struct btrfs_root *btrfs_free_space_root(struct btrfs_block_group *block_group);
>> +
>> +#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
>>   int __btrfs_add_to_free_space_tree(struct btrfs_trans_handle *trans,
>>   				   struct btrfs_block_group *block_group,
>>   				   struct btrfs_path *path, u64 start, u64 size);
>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>> index 055cbddf962f..a73d2b69d0dd 100644
>> --- a/fs/btrfs/relocation.c
>> +++ b/fs/btrfs/relocation.c
>> @@ -3617,7 +3617,7 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
>>   		btrfs_btree_balance_dirty(fs_info);
>>   	}
>>   
>> -	if (!err) {
>> +	if (!err && !btrfs_fs_incompat(fs_info, REMAP_TREE)) {
>>   		ret = relocate_file_extent_cluster(rc);
>>   		if (ret < 0)
>>   			err = ret;
>> @@ -3861,6 +3861,90 @@ static const char *stage_to_string(enum reloc_stage stage)
>>   	return "unknown";
>>   }
>>   
>> +static int add_remap_tree_entries(struct btrfs_trans_handle *trans,
>> +				  struct btrfs_path *path,
>> +				  struct btrfs_key *entries,
>> +				  unsigned int num_entries)
>> +{
>> +	int ret;
>> +	struct btrfs_fs_info *fs_info = trans->fs_info;
>> +	struct btrfs_item_batch batch;
>> +	u32 *data_sizes;
>> +	u32 max_items;
>> +
>> +	max_items = BTRFS_LEAF_DATA_SIZE(trans->fs_info) / sizeof(struct btrfs_item);
>> +
>> +	data_sizes = kzalloc(sizeof(u32) * min_t(u32, num_entries, max_items),
>> +			     GFP_NOFS);
>> +	if (!data_sizes)
>> +		return -ENOMEM;
>> +
>> +	while (true) {
>> +		batch.keys = entries;
>> +		batch.data_sizes = data_sizes;
>> +		batch.total_data_size = 0;
>> +		batch.nr = min_t(u32, num_entries, max_items);
>> +
>> +		ret = btrfs_insert_empty_items(trans, fs_info->remap_root, path,
>> +					       &batch);
>> +		btrfs_release_path(path);
>> +
>> +		if (num_entries <= max_items)
>> +			break;
>> +
>> +		num_entries -= max_items;
>> +		entries += max_items;
>> +	}
>> +
>> +	kfree(data_sizes);
>> +
>> +	return ret;
>> +}
>> +
>> +struct space_run {
>> +	u64 start;
>> +	u64 end;
>> +};
>> +
>> +static void parse_bitmap(u64 block_size, const unsigned long *bitmap,
>> +			 unsigned long size, u64 address,
>> +			 struct space_run *space_runs,
>> +			 unsigned int *num_space_runs)
>> +{
>> +	unsigned long pos, end;
>> +	u64 run_start, run_length;
>> +
>> +	pos = find_first_bit(bitmap, size);
>> +
>> +	if (pos == size)
>> +		return;
>> +
>> +	while (true) {
>> +		end = find_next_zero_bit(bitmap, size, pos);
>> +
>> +		run_start = address + (pos * block_size);
>> +		run_length = (end - pos) * block_size;
>> +
>> +		if (*num_space_runs != 0 &&
>> +		    space_runs[*num_space_runs - 1].end == run_start) {
>> +			space_runs[*num_space_runs - 1].end += run_length;
>> +		} else {
>> +			space_runs[*num_space_runs].start = run_start;
>> +			space_runs[*num_space_runs].end = run_start + run_length;
>> +
>> +			(*num_space_runs)++;
>> +		}
>> +
>> +		if (end == size)
>> +			break;
>> +
>> +		pos = find_next_bit(bitmap, size, end + 1);
>> +
>> +		if (pos == size)
>> +			break;
>> +	}
>> +}
>> +
>>   static void adjust_block_group_remap_bytes(struct btrfs_trans_handle *trans,
>>   					   struct btrfs_block_group *bg,
>>   					   s64 diff)
>> @@ -3893,6 +3977,188 @@ static void adjust_block_group_remap_bytes(struct btrfs_trans_handle *trans,
>>   		btrfs_inc_delayed_refs_rsv_bg_updates(fs_info);
>>   }
>>   
>> +static int create_remap_tree_entries(struct btrfs_trans_handle *trans,
>> +				     struct btrfs_path *path,
>> +				     struct btrfs_block_group *bg)
>> +{
>> +	struct btrfs_fs_info *fs_info = trans->fs_info;
>> +	struct btrfs_free_space_info *fsi;
>> +	struct btrfs_key key, found_key;
>> +	struct extent_buffer *leaf;
>> +	struct btrfs_root *space_root;
>> +	u32 extent_count;
>> +	struct space_run *space_runs = NULL;
>> +	unsigned int num_space_runs = 0;
>> +	struct btrfs_key *entries = NULL;
>> +	unsigned int max_entries, num_entries;
>> +	int ret;
>> +
>> +	mutex_lock(&bg->free_space_lock);
>> +
>> +	if (test_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE, &bg->runtime_flags)) {
>> +		mutex_unlock(&bg->free_space_lock);
>> +
>> +		ret = btrfs_add_block_group_free_space(trans, bg);
>> +		if (ret)
>> +			return ret;
>> +
>> +		mutex_lock(&bg->free_space_lock);
>> +	}
>> +
>> +	fsi = btrfs_search_free_space_info(trans, bg, path, 0);
>> +	if (IS_ERR(fsi)) {
>> +		mutex_unlock(&bg->free_space_lock);
>> +		return PTR_ERR(fsi);
>> +	}
>> +
>> +	extent_count = btrfs_free_space_extent_count(path->nodes[0], fsi);
>> +
>> +	btrfs_release_path(path);
>> +
>> +	space_runs = kmalloc(sizeof(*space_runs) * extent_count, GFP_NOFS);
>> +	if (!space_runs) {
>> +		mutex_unlock(&bg->free_space_lock);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	key.objectid = bg->start;
>> +	key.type = 0;
>> +	key.offset = 0;
>> +
>> +	space_root = btrfs_free_space_root(bg);
>> +
>> +	ret = btrfs_search_slot(trans, space_root, &key, path, 0, 0);
>> +	if (ret < 0) {
>> +		mutex_unlock(&bg->free_space_lock);
>> +		goto out;
>> +	}
>> +
>> +	ret = 0;
>> +
>> +	while (true) {
>> +		leaf = path->nodes[0];
>> +
>> +		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
>> +
>> +		if (found_key.objectid >= bg->start + bg->length)
>> +			break;
>> +
>> +		if (found_key.type == BTRFS_FREE_SPACE_EXTENT_KEY) {
>> +			if (num_space_runs != 0 &&
>> +			    space_runs[num_space_runs - 1].end == found_key.objectid) {
>> +				space_runs[num_space_runs - 1].end =
>> +					found_key.objectid + found_key.offset;
>> +			} else {
>> +				BUG_ON(num_space_runs >= extent_count);
>> +
>> +				space_runs[num_space_runs].start = found_key.objectid;
>> +				space_runs[num_space_runs].end =
>> +					found_key.objectid + found_key.offset;
>> +
>> +				num_space_runs++;
>> +			}
>> +		} else if (found_key.type == BTRFS_FREE_SPACE_BITMAP_KEY) {
>> +			void *bitmap;
>> +			unsigned long offset;
>> +			u32 data_size;
>> +
>> +			offset = btrfs_item_ptr_offset(leaf, path->slots[0]);
>> +			data_size = btrfs_item_size(leaf, path->slots[0]);
>> +
>> +			if (data_size != 0) {
>> +				bitmap = kmalloc(data_size, GFP_NOFS);
>> +				if (!bitmap) {
>> +					mutex_unlock(&bg->free_space_lock);
>> +					ret = -ENOMEM;
>> +					goto out;
>> +				}
>> +
>> +				read_extent_buffer(leaf, bitmap, offset,
>> +						   data_size);
>> +
>> +				parse_bitmap(fs_info->sectorsize, bitmap,
>> +					     data_size * BITS_PER_BYTE,
>> +					     found_key.objectid, space_runs,
>> +					     &num_space_runs);
>> +
>> +				BUG_ON(num_space_runs > extent_count);
> 
> Please don't add new BUG_ON()s. Either it's an error that needs to be
> handled or it's a development ASSERT.
> 
>> +
>> +				kfree(bitmap);
>> +			}
>> +		}
>> +
>> +		path->slots[0]++;
>> +
>> +		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
>> +			ret = btrfs_next_leaf(space_root, path);
>> +			if (ret != 0) {
>> +				if (ret == 1)
>> +					ret = 0;
>> +				break;
>> +			}
>> +			leaf = path->nodes[0];
>> +		}
>> +	}
>> +
>> +	btrfs_release_path(path);
>> +
>> +	mutex_unlock(&bg->free_space_lock);
>> +
>> +	max_entries = extent_count + 2;
>> +	entries = kmalloc(sizeof(*entries) * max_entries, GFP_NOFS);
>> +	if (!entries) {
>> +		ret = -ENOMEM;
>> +		goto out;
>> +	}
>> +
>> +	num_entries = 0;
>> +
>> +	if (num_space_runs == 0) {
>> +		entries[num_entries].objectid = bg->start;
>> +		entries[num_entries].type = BTRFS_IDENTITY_REMAP_KEY;
>> +		entries[num_entries].offset = bg->length;
>> +		num_entries++;
>> +	} else {
>> +		if (space_runs[0].start > bg->start) {
>> +			entries[num_entries].objectid = bg->start;
>> +			entries[num_entries].type = BTRFS_IDENTITY_REMAP_KEY;
>> +			entries[num_entries].offset =
>> +				space_runs[0].start - bg->start;
>> +			num_entries++;
>> +		}
>> +
>> +		for (unsigned int i = 1; i < num_space_runs; i++) {
>> +			entries[num_entries].objectid = space_runs[i - 1].end;
>> +			entries[num_entries].type = BTRFS_IDENTITY_REMAP_KEY;
>> +			entries[num_entries].offset =
>> +				space_runs[i].start - space_runs[i - 1].end;
>> +			num_entries++;
>> +		}
>> +
>> +		if (space_runs[num_space_runs - 1].end < bg->start + bg->length) {
>> +			entries[num_entries].objectid =
>> +				space_runs[num_space_runs - 1].end;
>> +			entries[num_entries].type = BTRFS_IDENTITY_REMAP_KEY;
>> +			entries[num_entries].offset =
>> +				bg->start + bg->length - space_runs[num_space_runs - 1].end;
>> +			num_entries++;
>> +		}
>> +
>> +		if (num_entries == 0)
>> +			goto out;
>> +	}
>> +
>> +	bg->identity_remap_count = num_entries;
>> +
>> +	ret = add_remap_tree_entries(trans, path, entries, num_entries);
>> +
>> +out:
>> +	kfree(entries);
>> +	kfree(space_runs);
>> +
>> +	return ret;
>> +}
>> +
>>   static int remove_chunk_stripes(struct btrfs_trans_handle *trans,
>>   				struct btrfs_chunk_map *chunk,
>>   				struct btrfs_path *path)
>> @@ -4038,6 +4304,55 @@ static void adjust_identity_remap_count(struct btrfs_trans_handle *trans,
>>   		btrfs_mark_bg_fully_remapped(bg, trans);
>>   }
>>   
>> +static int mark_chunk_remapped(struct btrfs_trans_handle *trans,
>> +			       struct btrfs_path *path, uint64_t start)
>> +{
>> +	struct btrfs_fs_info *fs_info = trans->fs_info;
>> +	struct btrfs_chunk_map *chunk;
>> +	struct btrfs_key key;
>> +	u64 type;
>> +	int ret;
>> +	struct extent_buffer *leaf;
>> +	struct btrfs_chunk *c;
> 
>                              chunk
> 
>> +
>> +	read_lock(&fs_info->mapping_tree_lock);
>> +
>> +	chunk = btrfs_find_chunk_map_nolock(fs_info, start, 1);
>> +	if (!chunk) {
>> +		read_unlock(&fs_info->mapping_tree_lock);
>> +		return -ENOENT;
>> +	}
>> +
>> +	chunk->type |= BTRFS_BLOCK_GROUP_REMAPPED;
>> +	type = chunk->type;
>> +
>> +	read_unlock(&fs_info->mapping_tree_lock);
>> +
>> +	key.objectid = BTRFS_FIRST_CHUNK_TREE_OBJECTID;
>> +	key.type = BTRFS_CHUNK_ITEM_KEY;
>> +	key.offset = start;
>> +
>> +	ret = btrfs_search_slot(trans, fs_info->chunk_root, &key, path,
>> +				0, 1);
>> +	if (ret == 1) {
>> +		ret = -ENOENT;
>> +		goto end;
>> +	} else if (ret < 0)
>> +		goto end;
>> +
>> +	leaf = path->nodes[0];
>> +
>> +	c = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_chunk);
>> +	btrfs_set_chunk_type(leaf, c, type);
>> +	btrfs_mark_buffer_dirty(trans, leaf);
>> +
>> +	ret = 0;
>> +end:
>> +	btrfs_free_chunk_map(chunk);
>> +	btrfs_release_path(path);
>> +	return ret;
>> +}
>> +
>>   int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
>>   			  u64 *length)
>>   {
>> @@ -4092,6 +4407,136 @@ int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
>>   	return 0;
>>   }
>>   
>> +static int start_block_group_remapping(struct btrfs_fs_info *fs_info,
>> +				       struct btrfs_path *path,
>> +				       struct btrfs_block_group *bg)
>> +{
>> +	struct btrfs_trans_handle *trans;
>> +	bool bg_already_dirty = true;
>> +	int ret, ret2;
>> +
>> +	ret = btrfs_cache_block_group(bg, true);
>> +	if (ret)
>> +		return ret;
>> +
>> +	trans = btrfs_start_transaction(fs_info->remap_root, 0);
>> +	if (IS_ERR(trans))
>> +		return PTR_ERR(trans);
>> +
>> +	/* We need to run delayed refs, to make sure FST is up to date. */
>> +	ret = btrfs_run_delayed_refs(trans, U64_MAX);
>> +	if (ret) {
>> +		btrfs_end_transaction(trans);
>> +		return ret;
>> +	}
>> +
>> +	mutex_lock(&fs_info->remap_mutex);
>> +
>> +	if (bg->flags & BTRFS_BLOCK_GROUP_REMAPPED) {
>> +		ret = 0;
>> +		goto end;
>> +	}
>> +
>> +	ret = create_remap_tree_entries(trans, path, bg);
>> +	if (ret) {
> 
> 	if (unlikely...
> 
>> +		btrfs_abort_transaction(trans, ret);
> 
> Is the abort necessary? create_remap_tree_entries() does a lot of memory
> allocations and can fail, but it seems that this is restartable.

Yes, because it calls add_remap_tree_entries(), and if this fails 
halfway through it'll be in an inconsistent state.

One future improvement that's been discussed is to make it so that 
create_remap_tree_entries() takes place over multiple transactions - 
maybe something like adding a flag that says "this is inconsistent, 
don't trust it". So when that happens I imagine this abort will also go 
away.

>> +		goto end;
>> +	}
>> +
>> +	spin_lock(&bg->lock);
>> +	bg->flags |= BTRFS_BLOCK_GROUP_REMAPPED;
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
>> +		btrfs_inc_delayed_refs_rsv_bg_updates(fs_info);
>> +
>> +	ret = mark_chunk_remapped(trans, path, bg->start);
>> +	if (ret) {
>> +		btrfs_abort_transaction(trans, ret);
>> +		goto end;
>> +	}
>> +
>> +	ret = btrfs_remove_block_group_free_space(trans, bg);
>> +	if (ret) {
>> +		btrfs_abort_transaction(trans, ret);
>> +		goto end;
>> +	}
>> +
>> +	btrfs_remove_free_space_cache(bg);
>> +
>> +end:
>> +	mutex_unlock(&fs_info->remap_mutex);
>> +
>> +	ret2 = btrfs_end_transaction(trans);
>> +	if (!ret)
>> +		ret = ret2;
>> +
>> +	return ret;
>> +}
>> +
>> +static int do_nonremap_reloc(struct btrfs_fs_info *fs_info, bool verbose,
>> +			     struct reloc_control *rc)
>> +{
>> +	int ret;
>> +
>> +	while (1) {
>> +		enum reloc_stage finishes_stage;
>> +
>> +		mutex_lock(&fs_info->cleaner_mutex);
>> +		ret = relocate_block_group(rc);
>> +		mutex_unlock(&fs_info->cleaner_mutex);
>> +
>> +		finishes_stage = rc->stage;
>> +		/*
>> +		 * We may have gotten ENOSPC after we already dirtied some
>> +		 * extents.  If writeout happens while we're relocating a
>> +		 * different block group we could end up hitting the
>> +		 * BUG_ON(rc->stage == UPDATE_DATA_PTRS) in
>> +		 * btrfs_reloc_cow_block.  Make sure we write everything out
>> +		 * properly so we don't trip over this problem, and then break
>> +		 * out of the loop if we hit an error.
>> +		 */
>> +		if (rc->stage == MOVE_DATA_EXTENTS && rc->found_file_extent) {
>> +			int wb_ret;
>> +
>> +			wb_ret = btrfs_wait_ordered_range(BTRFS_I(rc->data_inode),
>> +								0, (u64)-1);
>> +			if (wb_ret && ret == 0)
>> +				ret = wb_ret;
>> +			invalidate_mapping_pages(rc->data_inode->i_mapping,
>> +							0, -1);
>> +			rc->stage = UPDATE_DATA_PTRS;
>> +		}
>> +
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		if (rc->extents_found == 0)
>> +			break;
>> +
>> +		if (verbose)
>> +			btrfs_info(fs_info, "found %llu extents, stage: %s",
>> +				   rc->extents_found,
>> +				   stage_to_string(finishes_stage));
>> +	}
>> +
>> +	WARN_ON(rc->block_group->pinned > 0);
>> +	WARN_ON(rc->block_group->reserved > 0);
>> +	WARN_ON(rc->block_group->used > 0);
>> +
>> +	return 0;
>> +}
>> +
>>   /*
>>    * function to relocate all extents in a block group.
>>    */
>> @@ -4102,7 +4547,7 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start,
>>   	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, group_start);
>>   	struct reloc_control *rc;
>>   	struct inode *inode;
>> -	struct btrfs_path *path;
>> +	struct btrfs_path *path = NULL;
>>   	int ret;
>>   	bool bg_is_ro = false;
>>   
>> @@ -4164,7 +4609,7 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start,
>>   	}
>>   
>>   	inode = lookup_free_space_inode(rc->block_group, path);
>> -	btrfs_free_path(path);
>> +	btrfs_release_path(path);
>>   
>>   	if (!IS_ERR(inode))
>>   		ret = delete_block_group_cache(rc->block_group, inode, 0);
>> @@ -4174,11 +4619,13 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start,
>>   	if (ret && ret != -ENOENT)
>>   		goto out;
>>   
>> -	rc->data_inode = create_reloc_inode(rc->block_group);
>> -	if (IS_ERR(rc->data_inode)) {
>> -		ret = PTR_ERR(rc->data_inode);
>> -		rc->data_inode = NULL;
>> -		goto out;
>> +	if (!btrfs_fs_incompat(fs_info, REMAP_TREE)) {
>> +		rc->data_inode = create_reloc_inode(rc->block_group);
>> +		if (IS_ERR(rc->data_inode)) {
>> +			ret = PTR_ERR(rc->data_inode);
>> +			rc->data_inode = NULL;
>> +			goto out;
>> +		}
>>   	}
>>   
>>   	if (verbose)
>> @@ -4191,54 +4638,17 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start,
>>   	ret = btrfs_zone_finish(rc->block_group);
>>   	WARN_ON(ret && ret != -EAGAIN);
>>   
>> -	while (1) {
>> -		enum reloc_stage finishes_stage;
>> -
>> -		mutex_lock(&fs_info->cleaner_mutex);
>> -		ret = relocate_block_group(rc);
>> -		mutex_unlock(&fs_info->cleaner_mutex);
>> -
>> -		finishes_stage = rc->stage;
>> -		/*
>> -		 * We may have gotten ENOSPC after we already dirtied some
>> -		 * extents.  If writeout happens while we're relocating a
>> -		 * different block group we could end up hitting the
>> -		 * BUG_ON(rc->stage == UPDATE_DATA_PTRS) in
>> -		 * btrfs_reloc_cow_block.  Make sure we write everything out
>> -		 * properly so we don't trip over this problem, and then break
>> -		 * out of the loop if we hit an error.
>> -		 */
>> -		if (rc->stage == MOVE_DATA_EXTENTS && rc->found_file_extent) {
>> -			int wb_ret;
>> -
>> -			wb_ret = btrfs_wait_ordered_range(BTRFS_I(rc->data_inode), 0,
>> -							  (u64)-1);
>> -			if (wb_ret && ret == 0)
>> -				ret = wb_ret;
>> -			invalidate_mapping_pages(rc->data_inode->i_mapping,
>> -						 0, -1);
>> -			rc->stage = UPDATE_DATA_PTRS;
>> -		}
>> -
>> -		if (ret < 0)
>> -			goto out;
>> -
>> -		if (rc->extents_found == 0)
>> -			break;
>> -
>> -		if (verbose)
>> -			btrfs_info(fs_info, "found %llu extents, stage: %s",
>> -				   rc->extents_found,
>> -				   stage_to_string(finishes_stage));
>> +	if (should_relocate_using_remap_tree(bg)) {
>> +		ret = start_block_group_remapping(fs_info, path, bg);
>> +	} else {
>> +		ret = do_nonremap_reloc(fs_info, verbose, rc);
>>   	}
>> -
>> -	WARN_ON(rc->block_group->pinned > 0);
>> -	WARN_ON(rc->block_group->reserved > 0);
>> -	WARN_ON(rc->block_group->used > 0);
>>   out:
>>   	if (ret && bg_is_ro)
>>   		btrfs_dec_block_group_ro(rc->block_group);
>> -	iput(rc->data_inode);
>> +	if (!btrfs_fs_incompat(fs_info, REMAP_TREE))
>> +		iput(rc->data_inode);
>> +	btrfs_free_path(path);
>>   	reloc_chunk_end(fs_info);
>>   out_put_bg:
>>   	btrfs_put_block_group(bg);
>> @@ -4432,7 +4842,7 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
>>   
>>   	btrfs_free_path(path);
>>   
>> -	if (ret == 0) {
>> +	if (ret == 0 && !btrfs_fs_incompat(fs_info, REMAP_TREE)) {
>>   		/* cleanup orphan inode in data relocation tree */
>>   		fs_root = btrfs_grab_root(fs_info->data_reloc_root);
>>   		ASSERT(fs_root);
>> diff --git a/fs/btrfs/relocation.h b/fs/btrfs/relocation.h
>> index ffb497f27889..9f166b900d46 100644
>> --- a/fs/btrfs/relocation.h
>> +++ b/fs/btrfs/relocation.h
>> @@ -12,6 +12,17 @@ struct btrfs_trans_handle;
>>   struct btrfs_ordered_extent;
>>   struct btrfs_pending_snapshot;
>>   
>> +static inline bool should_relocate_using_remap_tree(struct btrfs_block_group *bg)
>> +{
>> +	if (!btrfs_fs_incompat(bg->fs_info, REMAP_TREE))
>> +		return false;
>> +
>> +	if (bg->flags & (BTRFS_BLOCK_GROUP_SYSTEM | BTRFS_BLOCK_GROUP_REMAP))
>> +		return false;
>> +
>> +	return true;
>> +}
>> +
>>   int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start,
>>   			       bool verbose);
>>   int btrfs_init_reloc_root(struct btrfs_trans_handle *trans, struct btrfs_root *root);
>> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
>> index 8e040dcea64a..9b9f7e38dbc9 100644
>> --- a/fs/btrfs/space-info.c
>> +++ b/fs/btrfs/space-info.c
>> @@ -376,8 +376,13 @@ void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
>>   	factor = btrfs_bg_type_to_factor(block_group->flags);
>>   
>>   	spin_lock(&space_info->lock);
>> -	space_info->total_bytes += block_group->length;
>> -	space_info->disk_total += block_group->length * factor;
>> +
>> +	if (!(block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED) ||
>> +	    block_group->identity_remap_count != 0) {
>> +		space_info->total_bytes += block_group->length;
>> +		space_info->disk_total += block_group->length * factor;
>> +	}
>> +
>>   	space_info->bytes_used += block_group->used;
>>   	space_info->disk_used += block_group->used * factor;
>>   	space_info->bytes_readonly += block_group->bytes_super;
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 686e9abcf4cf..d676addf6ef4 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -3409,15 +3409,57 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
>>   	return ret;
>>   }
>>   
>> -int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset,
>> -			 bool verbose)
>> +static int btrfs_relocate_chunk_finish(struct btrfs_fs_info *fs_info,
>> +				       struct btrfs_block_group *block_group)
>>   {
>>   	struct btrfs_root *root = fs_info->chunk_root;
>>   	struct btrfs_trans_handle *trans;
>> -	struct btrfs_block_group *block_group;
>>   	u64 length;
>>   	int ret;
>>   
>> +	btrfs_discard_cancel_work(&fs_info->discard_ctl, block_group);
>> +	length = block_group->length;
>> +	btrfs_put_block_group(block_group);
>> +
>> +	/*
>> +	 * On a zoned file system, discard the whole block group, this will
>> +	 * trigger a REQ_OP_ZONE_RESET operation on the device zone. If
>> +	 * resetting the zone fails, don't treat it as a fatal problem from the
>> +	 * filesystem's point of view.
>> +	 */
>> +	if (btrfs_is_zoned(fs_info)) {
>> +		ret = btrfs_discard_extent(fs_info, block_group->start, length,
>> +					   NULL);
>> +		if (ret)
>> +			btrfs_info(fs_info,
>> +				   "failed to reset zone %llu after relocation",
>> +				   block_group->start);
>> +	}
>> +
>> +	trans = btrfs_start_trans_remove_block_group(root->fs_info,
>> +						     block_group->start);
>> +	if (IS_ERR(trans)) {
>> +		ret = PTR_ERR(trans);
>> +		btrfs_handle_fs_error(root->fs_info, ret, NULL);
>> +		return ret;
>> +	}
>> +
>> +	/*
>> +	 * step two, delete the device extents and the
>> +	 * chunk tree entries
> 
> If moving code please fix comments to the current style.
> 
>> +	 */
>> +	ret = btrfs_remove_chunk(trans, block_group->start);
>> +	btrfs_end_transaction(trans);
>> +
>> +	return ret;
>> +}
>> +
>> +int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset,
>> +			 bool verbose)
>> +{
>> +	struct btrfs_block_group *block_group;
>> +	int ret;
>> +
>>   	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
>>   		btrfs_err(fs_info,
>>   			  "relocate: not supported on extent tree v2 yet");
>> @@ -3455,38 +3497,15 @@ int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset,
>>   	block_group = btrfs_lookup_block_group(fs_info, chunk_offset);
>>   	if (!block_group)
>>   		return -ENOENT;
>> -	btrfs_discard_cancel_work(&fs_info->discard_ctl, block_group);
>> -	length = block_group->length;
>> -	btrfs_put_block_group(block_group);
>> -
>> -	/*
>> -	 * On a zoned file system, discard the whole block group, this will
>> -	 * trigger a REQ_OP_ZONE_RESET operation on the device zone. If
>> -	 * resetting the zone fails, don't treat it as a fatal problem from the
>> -	 * filesystem's point of view.
>> -	 */
>> -	if (btrfs_is_zoned(fs_info)) {
>> -		ret = btrfs_discard_extent(fs_info, chunk_offset, length, NULL);
>> -		if (ret)
>> -			btrfs_info(fs_info,
>> -				"failed to reset zone %llu after relocation",
>> -				chunk_offset);
>> -	}
>>   
>> -	trans = btrfs_start_trans_remove_block_group(root->fs_info,
>> -						     chunk_offset);
>> -	if (IS_ERR(trans)) {
>> -		ret = PTR_ERR(trans);
>> -		btrfs_handle_fs_error(root->fs_info, ret, NULL);
>> -		return ret;
>> +	if (should_relocate_using_remap_tree(block_group)) {
>> +		/* If we're relocating using the remap tree we're now done. */
>> +		btrfs_put_block_group(block_group);
>> +		ret = 0;
>> +	} else {
>> +		ret = btrfs_relocate_chunk_finish(fs_info, block_group);
>>   	}
>>   
>> -	/*
>> -	 * step two, delete the device extents and the
>> -	 * chunk tree entries
>> -	 */
>> -	ret = btrfs_remove_chunk(trans, chunk_offset);
>> -	btrfs_end_transaction(trans);
>>   	return ret;
>>   }
>>   
>> @@ -4155,6 +4174,14 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
>>   		chunk = btrfs_item_ptr(leaf, slot, struct btrfs_chunk);
>>   		chunk_type = btrfs_chunk_type(leaf, chunk);
>>   
>> +		/* Check if chunk has already been fully relocated. */
>> +		if (chunk_type & BTRFS_BLOCK_GROUP_REMAPPED &&
>> +		    btrfs_chunk_num_stripes(leaf, chunk) == 0) {
>> +			btrfs_release_path(path);
>> +			mutex_unlock(&fs_info->reclaim_bgs_lock);
>> +			goto loop;
>> +		}
>> +
>>   		if (!counting) {
>>   			spin_lock(&fs_info->balance_lock);
>>   			bctl->stat.considered++;
>> -- 
>> 2.51.0
>>


