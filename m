Return-Path: <linux-btrfs+bounces-16018-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7335B225BA
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 13:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99AA8188BFA0
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 11:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C082D5C64;
	Tue, 12 Aug 2025 11:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="5cAR098G"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4306D2586EB
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Aug 2025 11:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754997624; cv=none; b=NpAtSe/Ei99fwhWtEf2n92/S8gQqxSeSQ15qvdR22lkZSkXz98fv89ttdPGWDQWSrWNht/w8OyufxGYu/HPYFFlJnVU+Utzo07qB33fFoN5so9wQAqJW7NefGx29KsKeNoJFuRvCMiysh56N0E4bmWaZ0lleB8N9GO7u2en+fJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754997624; c=relaxed/simple;
	bh=CpUsNnRWQxq2itDc3M2XEhj+Pqs98ayuu8fiUdXdyl8=;
	h=Message-ID:Date:Mime-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H5c5A0Ns7o/uKLmotec3orDM6srLVmDZthIalgH7nRJQM3QAfi6UjZnywqKPY9jyIr3duJd7IWdX38OfYfhZj6Lj0tza70kvGVdUzhx95GsX0WaeG7QGyUCUgoLHf/G2GCM/KMb5p99CDBvt2us0hEXNsqa9lwG/Tn+MUaqnHcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=5cAR098G; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from [IPV6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2] (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id 66D4F2A6BF7;
	Tue, 12 Aug 2025 12:20:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1754997615;
	bh=wDo/tYSITmPOpTOVL3rBU7hH2yGxaUq9d46iOxKIBuU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=5cAR098G1xF8o9Fp6Kqg78IoOeHdCPJLSQ9jBIEyORa1spdtLY9w5hHQZndeQCjG5
	 qfTHoYvcd8JYUedS1sYjlmEp3t7d/OiPqIpplUafnIUC4qsAHj/K7qLHBsBcMaiuen
	 gE4szkR8f3fknjdQU/KllgI6Snpr7JI8dprykbnE=
Message-ID: <48d131df-b64f-42f0-8ec1-3c9bfcd07942@harmstone.com>
Date: Tue, 12 Aug 2025 12:20:15 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH 10/12] btrfs: handle setting up relocation of block group
 with remap-tree
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <20250605162345.2561026-1-maharmstone@fb.com>
 <20250605162345.2561026-11-maharmstone@fb.com>
 <20250613232515.GF3621880@zen.localdomain>
Content-Language: en-US
From: Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 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
In-Reply-To: <20250613232515.GF3621880@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/06/2025 12.25 am, Boris Burkov wrote:
> On Thu, Jun 05, 2025 at 05:23:40PM +0100, Mark Harmstone wrote:
>> Handle the preliminary work for relocating a block group in a filesystem
>> with the remap-tree flag set.
>>
>> If the block group is SYSTEM or REMAP btrfs_relocate_block_group()
>> proceeds as it does already, as bootstrapping issues mean that these
>> block groups have to be processed the existing way.
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
>> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
>> ---
>>   fs/btrfs/disk-io.c         |  30 +--
>>   fs/btrfs/free-space-tree.c |   4 +-
>>   fs/btrfs/free-space-tree.h |   5 +-
>>   fs/btrfs/relocation.c      | 452 ++++++++++++++++++++++++++++++++++++-
>>   fs/btrfs/relocation.h      |   3 +-
>>   fs/btrfs/space-info.c      |   9 +-
>>   fs/btrfs/volumes.c         |  15 +-
>>   7 files changed, 483 insertions(+), 35 deletions(-)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index dac22efd2332..f2a9192293b1 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -2268,22 +2268,22 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
>>   		root->root_key.objectid = BTRFS_REMAP_TREE_OBJECTID;
>>   		root->root_key.type = BTRFS_ROOT_ITEM_KEY;
>>   		root->root_key.offset = 0;
>> -	}
>> -
>> -	/*
>> -	 * This tree can share blocks with some other fs tree during relocation
>> -	 * and we need a proper setup by btrfs_get_fs_root
>> -	 */
>> -	root = btrfs_get_fs_root(tree_root->fs_info,
>> -				 BTRFS_DATA_RELOC_TREE_OBJECTID, true);
>> -	if (IS_ERR(root)) {
>> -		if (!btrfs_test_opt(fs_info, IGNOREBADROOTS)) {
>> -			ret = PTR_ERR(root);
>> -			goto out;
>> -		}
>>   	} else {
>> -		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
>> -		fs_info->data_reloc_root = root;
>> +		/*
>> +		 * This tree can share blocks with some other fs tree during
>> +		 * relocation and we need a proper setup by btrfs_get_fs_root
>> +		 */
>> +		root = btrfs_get_fs_root(tree_root->fs_info,
>> +					 BTRFS_DATA_RELOC_TREE_OBJECTID, true);
>> +		if (IS_ERR(root)) {
>> +			if (!btrfs_test_opt(fs_info, IGNOREBADROOTS)) {
>> +				ret = PTR_ERR(root);
>> +				goto out;
>> +			}
>> +		} else {
>> +			set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
>> +			fs_info->data_reloc_root = root;
>> +		}
> 
> Why not do this change to the else case for remap tree along with the if
> case in the earlier patch (allow mounting filesystems with remap-tree
> incompat flag)?
> 
>>   	}
>>   
>>   	location.objectid = BTRFS_QUOTA_TREE_OBJECTID;
>> diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
>> index af51cf784a5b..eb579c17a79f 100644
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
>> @@ -96,7 +95,6 @@ static int add_new_free_space_info(struct btrfs_trans_handle *trans,
>>   	return ret;
>>   }
>>   
>> -EXPORT_FOR_TESTS
>>   struct btrfs_free_space_info *search_free_space_info(
>>   		struct btrfs_trans_handle *trans,
>>   		struct btrfs_block_group *block_group,
>> diff --git a/fs/btrfs/free-space-tree.h b/fs/btrfs/free-space-tree.h
>> index e6c6d6f4f221..1b804544730a 100644
>> --- a/fs/btrfs/free-space-tree.h
>> +++ b/fs/btrfs/free-space-tree.h
>> @@ -35,12 +35,13 @@ int add_to_free_space_tree(struct btrfs_trans_handle *trans,
>>   			   u64 start, u64 size);
>>   int remove_from_free_space_tree(struct btrfs_trans_handle *trans,
>>   				u64 start, u64 size);
>> -
>> -#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
>>   struct btrfs_free_space_info *
>>   search_free_space_info(struct btrfs_trans_handle *trans,
>>   		       struct btrfs_block_group *block_group,
>>   		       struct btrfs_path *path, int cow);
>> +struct btrfs_root *btrfs_free_space_root(struct btrfs_block_group *block_group);
>> +
>> +#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
>>   int __add_to_free_space_tree(struct btrfs_trans_handle *trans,
>>   			     struct btrfs_block_group *block_group,
>>   			     struct btrfs_path *path, u64 start, u64 size);
>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>> index 54c3e99c7dab..acf2fefedc96 100644
>> --- a/fs/btrfs/relocation.c
>> +++ b/fs/btrfs/relocation.c
>> @@ -3659,7 +3659,7 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
>>   		btrfs_btree_balance_dirty(fs_info);
>>   	}
>>   
>> -	if (!err) {
>> +	if (!err && !btrfs_fs_incompat(fs_info, REMAP_TREE)) {
>>   		ret = relocate_file_extent_cluster(rc);
>>   		if (ret < 0)
>>   			err = ret;
>> @@ -3906,6 +3906,90 @@ static const char *stage_to_string(enum reloc_stage stage)
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
>> @@ -3931,6 +4015,227 @@ static void adjust_block_group_remap_bytes(struct btrfs_trans_handle *trans,
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
>> +		ret = add_block_group_free_space(trans, bg);
>> +		if (ret)
>> +			return ret;
>> +
>> +		mutex_lock(&bg->free_space_lock);
>> +	}
>> +
>> +	fsi = search_free_space_info(trans, bg, path, 0);
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
>> +				space_runs[num_space_runs].start = found_key.objectid;
>> +				space_runs[num_space_runs].end =
>> +					found_key.objectid + found_key.offset;
>> +
>> +				num_space_runs++;
>> +
>> +				BUG_ON(num_space_runs > extent_count);
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
> 
> free space tree does this with alloc_bitmap, as far as I can tell.

It does, but that's because it uses alloc_bitmap() to calculate the size.
Here we already know the size, so we alloc for the whole thing.

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
>> +	if (num_space_runs > 0 && space_runs[0].start > bg->start) {
>> +		entries[num_entries].objectid = bg->start;
>> +		entries[num_entries].type = BTRFS_IDENTITY_REMAP_KEY;
>> +		entries[num_entries].offset = space_runs[0].start - bg->start;
>> +		num_entries++;
>> +	}
>> +
>> +	for (unsigned int i = 1; i < num_space_runs; i++) {
>> +		entries[num_entries].objectid = space_runs[i - 1].end;
>> +		entries[num_entries].type = BTRFS_IDENTITY_REMAP_KEY;
>> +		entries[num_entries].offset =
>> +			space_runs[i].start - space_runs[i - 1].end;
>> +		num_entries++;
>> +	}
>> +
>> +	if (num_space_runs == 0) {
>> +		entries[num_entries].objectid = bg->start;
>> +		entries[num_entries].type = BTRFS_IDENTITY_REMAP_KEY;
>> +		entries[num_entries].offset = bg->length;
>> +		num_entries++;
>> +	} else if (space_runs[num_space_runs - 1].end < bg->start + bg->length) {
>> +		entries[num_entries].objectid = space_runs[num_space_runs - 1].end;
>> +		entries[num_entries].type = BTRFS_IDENTITY_REMAP_KEY;
>> +		entries[num_entries].offset =
>> +			bg->start + bg->length - space_runs[num_space_runs - 1].end;
>> +		num_entries++;
>> +	}
>> +
>> +	if (num_entries == 0)
>> +		goto out;
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
>> +static int mark_bg_remapped(struct btrfs_trans_handle *trans,
>> +			    struct btrfs_path *path,
>> +			    struct btrfs_block_group *bg)
>> +{
>> +	struct btrfs_fs_info *fs_info = trans->fs_info;
>> +	unsigned long bi;
>> +	struct extent_buffer *leaf;
>> +	struct btrfs_block_group_item_v2 bgi;
>> +	struct btrfs_key key;
>> +	int ret;
>> +
> 
> Do the changes to the in memory bg flags / commit_identity_remap_count
> need any locking? What happens if we see the flag set but don't yet see
> the identity remap count set from some other context?

It's okay here, we're behind fs_info->remap_mutex.

I'm not 100% that having a big per-filesystem mutex is the way to go, but
I'd rather initially have something safe but slow before moving onto
something more refined.

>> +	bg->flags |= BTRFS_BLOCK_GROUP_REMAPPED;
>> +
>> +	key.objectid = bg->start;
>> +	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
>> +	key.offset = bg->length;
>> +
>> +	ret = btrfs_search_slot(trans, fs_info->block_group_root, &key,
>> +				path, 0, 1);
>> +	if (ret) {
>> +		if (ret > 0)
>> +			ret = -ENOENT;
>> +		goto out;
>> +	}
>> +
>> +	leaf = path->nodes[0];
>> +	bi = btrfs_item_ptr_offset(leaf, path->slots[0]);
>> +	read_extent_buffer(leaf, &bgi, bi, sizeof(bgi));
> 
> ASSERT the incompat flag?
> 
>> +	btrfs_set_stack_block_group_v2_flags(&bgi, bg->flags);
>> +	btrfs_set_stack_block_group_v2_identity_remap_count(&bgi,
>> +						bg->identity_remap_count);
>> +	write_extent_buffer(leaf, &bgi, bi, sizeof(bgi));
>> +
>> +	btrfs_mark_buffer_dirty(trans, leaf);
>> +
>> +	bg->commit_identity_remap_count = bg->identity_remap_count;
>> +
>> +	ret = 0;
>> +out:
>> +	btrfs_release_path(path);
>> +	return ret;
>> +}
>> +
>>   static int remove_chunk_stripes(struct btrfs_trans_handle *trans,
>>   				struct btrfs_chunk_map *chunk,
>>   				struct btrfs_path *path)
>> @@ -4050,6 +4355,55 @@ static int adjust_identity_remap_count(struct btrfs_trans_handle *trans,
>>   	return ret;
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
>>   			  u64 *length, bool nolock)
>>   {
>> @@ -4109,16 +4463,78 @@ int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
>>   	return 0;
>>   }
>>   
>> +static int start_block_group_remapping(struct btrfs_fs_info *fs_info,
>> +				       struct btrfs_path *path,
>> +				       struct btrfs_block_group *bg)
>> +{
>> +	struct btrfs_trans_handle *trans;
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
>> +		btrfs_abort_transaction(trans, ret);
>> +		goto end;
>> +	}
>> +
>> +	ret = mark_bg_remapped(trans, path, bg);
>> +	if (ret) {
>> +		btrfs_abort_transaction(trans, ret);
>> +		goto end;
>> +	}
>> +
>> +	ret = mark_chunk_remapped(trans, path, bg->start);
>> +	if (ret) {
>> +		btrfs_abort_transaction(trans, ret);
>> +		goto end;
>> +	}
>> +
>> +	ret = remove_block_group_free_space(trans, bg);
>> +	if (ret)
>> +		btrfs_abort_transaction(trans, ret);
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
>>   /*
>>    * function to relocate all extents in a block group.
>>    */
>> -int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
>> +int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start,
>> +			       bool *using_remap_tree)
>>   {
>>   	struct btrfs_block_group *bg;
>>   	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, group_start);
>>   	struct reloc_control *rc;
>>   	struct inode *inode;
>> -	struct btrfs_path *path;
>> +	struct btrfs_path *path = NULL;
>>   	int ret;
>>   	int rw = 0;
>>   	int err = 0;
>> @@ -4185,7 +4601,7 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
>>   	}
>>   
>>   	inode = lookup_free_space_inode(rc->block_group, path);
>> -	btrfs_free_path(path);
>> +	btrfs_release_path(path);
>>   
>>   	if (!IS_ERR(inode))
>>   		ret = delete_block_group_cache(rc->block_group, inode, 0);
>> @@ -4197,11 +4613,17 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
>>   		goto out;
>>   	}
>>   
>> -	rc->data_inode = create_reloc_inode(rc->block_group);
>> -	if (IS_ERR(rc->data_inode)) {
>> -		err = PTR_ERR(rc->data_inode);
>> -		rc->data_inode = NULL;
>> -		goto out;
>> +	*using_remap_tree = btrfs_fs_incompat(fs_info, REMAP_TREE) &&
>> +		!(bg->flags & BTRFS_BLOCK_GROUP_SYSTEM) &&
>> +		!(bg->flags & BTRFS_BLOCK_GROUP_REMAP);
>> +
>> +	if (!btrfs_fs_incompat(fs_info, REMAP_TREE)) {
>> +		rc->data_inode = create_reloc_inode(rc->block_group);
>> +		if (IS_ERR(rc->data_inode)) {
>> +			err = PTR_ERR(rc->data_inode);
>> +			rc->data_inode = NULL;
>> +			goto out;
>> +		}
>>   	}
>>   
>>   	describe_relocation(rc->block_group);
>> @@ -4213,6 +4635,12 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
>>   	ret = btrfs_zone_finish(rc->block_group);
>>   	WARN_ON(ret && ret != -EAGAIN);
>>   
>> +	if (*using_remap_tree) {
>> +		err = start_block_group_remapping(fs_info, path, bg);
>> +
>> +		goto out;
>> +	}
>> +
>>   	while (1) {
>>   		enum reloc_stage finishes_stage;
>>   
>> @@ -4258,7 +4686,9 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
>>   out:
>>   	if (err && rw)
>>   		btrfs_dec_block_group_ro(rc->block_group);
>> -	iput(rc->data_inode);
>> +	if (!btrfs_fs_incompat(fs_info, REMAP_TREE))
>> +		iput(rc->data_inode);
>> +	btrfs_free_path(path);
>>   out_put_bg:
>>   	btrfs_put_block_group(bg);
>>   	reloc_chunk_end(fs_info);
>> @@ -4452,7 +4882,7 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
>>   
>>   	btrfs_free_path(path);
>>   
>> -	if (ret == 0) {
>> +	if (ret == 0 && !btrfs_fs_incompat(fs_info, REMAP_TREE)) {
>>   		/* cleanup orphan inode in data relocation tree */
>>   		fs_root = btrfs_grab_root(fs_info->data_reloc_root);
>>   		ASSERT(fs_root);
>> diff --git a/fs/btrfs/relocation.h b/fs/btrfs/relocation.h
>> index 0021f812b12c..49bd48296ddb 100644
>> --- a/fs/btrfs/relocation.h
>> +++ b/fs/btrfs/relocation.h
>> @@ -12,7 +12,8 @@ struct btrfs_trans_handle;
>>   struct btrfs_ordered_extent;
>>   struct btrfs_pending_snapshot;
>>   
>> -int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start);
>> +int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start,
>> +			       bool *using_remap_tree);
>>   int btrfs_init_reloc_root(struct btrfs_trans_handle *trans, struct btrfs_root *root);
>>   int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
>>   			    struct btrfs_root *root);
>> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
>> index 6471861c4b25..ab4a70c420de 100644
>> --- a/fs/btrfs/space-info.c
>> +++ b/fs/btrfs/space-info.c
>> @@ -375,8 +375,13 @@ void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
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
>> index 6c0a67da92f1..771415139dc0 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -3425,6 +3425,7 @@ int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
>>   	struct btrfs_block_group *block_group;
>>   	u64 length;
>>   	int ret;
>> +	bool using_remap_tree;
>>   
>>   	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
>>   		btrfs_err(fs_info,
>> @@ -3448,7 +3449,8 @@ int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
>>   
>>   	/* step one, relocate all the extents inside this chunk */
>>   	btrfs_scrub_pause(fs_info);
>> -	ret = btrfs_relocate_block_group(fs_info, chunk_offset);
>> +	ret = btrfs_relocate_block_group(fs_info, chunk_offset,
>> +					 &using_remap_tree);
>>   	btrfs_scrub_continue(fs_info);
>>   	if (ret) {
>>   		/*
>> @@ -3467,6 +3469,9 @@ int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
>>   	length = block_group->length;
>>   	btrfs_put_block_group(block_group);
>>   
>> +	if (using_remap_tree)
>> +		return 0;
>> +
>>   	/*
>>   	 * On a zoned file system, discard the whole block group, this will
>>   	 * trigger a REQ_OP_ZONE_RESET operation on the device zone. If
>> @@ -4165,6 +4170,14 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
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
>> 2.49.0
>>
> 


