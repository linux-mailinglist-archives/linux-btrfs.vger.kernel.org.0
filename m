Return-Path: <linux-btrfs+bounces-18670-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B87A2C31902
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 15:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635AF420ED9
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 14:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A711330337;
	Tue,  4 Nov 2025 14:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="oljp7I0e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C89A207DF7
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Nov 2025 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762266684; cv=none; b=L7A/3OQKTE6WGUtAX07MIqu8UtBS5h2SKz+K5YHH4UoLeaUTmEj3vuiOxLLjgNq3hr7L+NIHyEksX756krbc4ED78sSzchPtBYWEL9WVgG9rsyyFMebM8XLtqcdlkyQw69k6mNUOzPnE31msYzSzgcUHLNi9HLDtodPE1mXWheI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762266684; c=relaxed/simple;
	bh=jLMlMWO0ti1xCygBnYwVf8C3jwzH+LigKNXnon86xmM=;
	h=Message-ID:Date:Mime-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R89M5aPLQ93aDeSdkJwdx+oOtmKVh+tf8BYkdTK1iAI52uLX26YTW+JyyKQh+i8xD9ErRfLLkRjIzRqzxqZwQ2TpzHrBYxo6gi5BhDbWg1cS/Hf8UQtBNBMA48eodyWHZOdCZ70NDIfPQZKg+KLwsm8pcK/JEvUsIzbxhRmYmzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=oljp7I0e; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from [IPV6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2] (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id 4E5892D5E8F;
	Tue,  4 Nov 2025 14:31:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1762266676;
	bh=8F6KcrQghle6FkXoXtU5+lUZFyimGZAwgvnHhvnao+A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=oljp7I0eX+SCPduWXZVpg3UxNn5XEBavwCRizkhlwd8PDA1/FyCLXMrR6eRHkE4xj
	 px7qZWNQXSkNL/30ThdsBGx9wasHYYH16yUtAT8PQ/Hu4rvjySnFknYP1eHRrMLoNz
	 h24Ncb/kNKbvjiMwlA44dIKW6y01fmVf2fEuD9jw=
Message-ID: <0db6db44-cbc2-45e4-8d1f-716dfde90d9e@harmstone.com>
Date: Tue, 4 Nov 2025 14:31:16 +0000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v4 12/16] btrfs: replace identity remaps with actual
 remaps when doing relocations
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <20251024181227.32228-1-mark@harmstone.com>
 <20251024181227.32228-13-mark@harmstone.com>
 <aQVPoWsIvwLXWePB@devvm12410.ftw0.facebook.com>
Content-Language: en-US
From: Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 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
In-Reply-To: <aQVPoWsIvwLXWePB@devvm12410.ftw0.facebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/11/2025 12.09 am, Boris Burkov wrote:
> On Fri, Oct 24, 2025 at 07:12:13PM +0100, Mark Harmstone wrote:
>> Add a function do_remap_tree_reloc(), which does the actual work of
>> doing a relocation using the remap tree.
>>
>> In a loop we call do_remap_tree_reloc_trans(), which searches for the
>> first identity remap for the block group. We call btrfs_reserve_extent()
>> to find space elsewhere for it, and read the data into memory and write
>> it to the new location. We then carve out the identity remap and replace
>> it with an actual remap, which points to the new location in which to
>> look.
>>
>> Once the last identity remap has been removed we call
>> last_identity_remap_gone(), which, as with deletions, removes the
>> chunk's stripes and device extents.
>>
>> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> 
> Want to be as clear as possible on the reservation fragmentation
> stuff, but otherwise LGTM.
> 
> Reviewed-by: Boris Burkov <boris@bur.io>
>> ---
>>   fs/btrfs/relocation.c | 317 ++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 317 insertions(+)
>>
>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>> index d31817379078..ebbc619be682 100644
>> --- a/fs/btrfs/relocation.c
>> +++ b/fs/btrfs/relocation.c
>> @@ -4640,6 +4640,61 @@ static int create_remap_tree_entries(struct btrfs_trans_handle *trans,
>>   	return ret;
>>   }
>>   
>> +static int find_next_identity_remap(struct btrfs_trans_handle *trans,
>> +				    struct btrfs_path *path, u64 bg_end,
>> +				    u64 last_start, u64 *start,
>> +				    u64 *length)
>> +{
>> +	int ret;
>> +	struct btrfs_key key, found_key;
>> +	struct btrfs_root *remap_root = trans->fs_info->remap_root;
>> +	struct extent_buffer *leaf;
>> +
>> +	key.objectid = last_start;
>> +	key.type = BTRFS_IDENTITY_REMAP_KEY;
>> +	key.offset = 0;
>> +
>> +	ret = btrfs_search_slot(trans, remap_root, &key, path, 0, 0);
>> +	if (ret < 0)
>> +		goto out;
>> +
>> +	leaf = path->nodes[0];
>> +	while (true) {
>> +		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
>> +			ret = btrfs_next_leaf(remap_root, path);
>> +
>> +			if (ret != 0) {
>> +				if (ret == 1)
>> +					ret = -ENOENT;
>> +				goto out;
>> +			}
>> +
>> +			leaf = path->nodes[0];
>> +		}
>> +
>> +		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
>> +
>> +		if (found_key.objectid >= bg_end) {
>> +			ret = -ENOENT;
>> +			goto out;
>> +		}
>> +
>> +		if (found_key.type == BTRFS_IDENTITY_REMAP_KEY) {
>> +			*start = found_key.objectid;
>> +			*length = found_key.offset;
>> +			ret = 0;
>> +			goto out;
>> +		}
>> +
>> +		path->slots[0]++;
>> +	}
>> +
>> +out:
>> +	btrfs_release_path(path);
>> +
>> +	return ret;
>> +}
>> +
>>   static int remove_chunk_stripes(struct btrfs_trans_handle *trans,
>>   				struct btrfs_chunk_map *chunk,
>>   				struct btrfs_path *path)
>> @@ -4753,6 +4808,96 @@ static void adjust_identity_remap_count(struct btrfs_trans_handle *trans,
>>   		btrfs_mark_bg_fully_remapped(bg, trans);
>>   }
>>   
>> +static int add_remap_entry(struct btrfs_trans_handle *trans,
>> +			   struct btrfs_path *path,
>> +			   struct btrfs_block_group *src_bg, u64 old_addr,
>> +			   u64 new_addr, u64 length)
>> +{
>> +	struct btrfs_fs_info *fs_info = trans->fs_info;
>> +	struct btrfs_key key, new_key;
>> +	int ret;
>> +	int identity_count_delta = 0;
>> +
>> +	key.objectid = old_addr;
>> +	key.type = (u8)-1;
>> +	key.offset = (u64)-1;
>> +
>> +	ret = btrfs_search_slot(trans, fs_info->remap_root, &key, path, -1, 1);
>> +	if (ret < 0)
>> +		goto end;
>> +
>> +	if (path->slots[0] == 0) {
>> +		ret = -ENOENT;
>> +		goto end;
>> +	}
>> +
>> +	path->slots[0]--;
>> +
>> +	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
>> +
>> +	if (key.type != BTRFS_IDENTITY_REMAP_KEY ||
>> +	    key.objectid > old_addr ||
>> +	    key.objectid + key.offset <= old_addr) {
>> +		ret = -ENOENT;
>> +		goto end;
>> +	}
>> +
>> +	/* Shorten or delete identity mapping entry. */
>> +
>> +	if (key.objectid == old_addr) {
>> +		ret = btrfs_del_item(trans, fs_info->remap_root, path);
>> +		if (ret)
>> +			goto end;
>> +
>> +		identity_count_delta--;
>> +	} else {
>> +		new_key.objectid = key.objectid;
>> +		new_key.type = BTRFS_IDENTITY_REMAP_KEY;
>> +		new_key.offset = old_addr - key.objectid;
>> +
>> +		btrfs_set_item_key_safe(trans, path, &new_key);
>> +	}
>> +
>> +	btrfs_release_path(path);
>> +
>> +	/* Create new remap entry. */
>> +
>> +	ret = add_remap_item(trans, path, new_addr, length, old_addr);
>> +	if (ret)
>> +		goto end;
>> +
>> +	/* Add entry for remainder of identity mapping, if necessary. */
>> +
>> +	if (key.objectid + key.offset != old_addr + length) {
>> +		new_key.objectid = old_addr + length;
>> +		new_key.type = BTRFS_IDENTITY_REMAP_KEY;
>> +		new_key.offset = key.objectid + key.offset - old_addr - length;
>> +
>> +		ret = btrfs_insert_empty_item(trans, fs_info->remap_root,
>> +					      path, &new_key, 0);
>> +		if (ret)
>> +			goto end;
>> +
>> +		btrfs_release_path(path);
>> +
>> +		identity_count_delta++;
>> +	}
>> +
>> +	/* Add backref. */
>> +
>> +	ret = add_remap_backref_item(trans, path, new_addr, length, old_addr);
>> +	if (ret)
>> +		goto end;
>> +
>> +	if (identity_count_delta != 0)
>> +		adjust_identity_remap_count(trans, src_bg, identity_count_delta);
>> +
>> +end:
>> +	btrfs_release_path(path);
>> +
>> +	return ret;
>> +}
>> +
>>   static int mark_chunk_remapped(struct btrfs_trans_handle *trans,
>>   			       struct btrfs_path *path, uint64_t start)
>>   {
>> @@ -4802,6 +4947,169 @@ static int mark_chunk_remapped(struct btrfs_trans_handle *trans,
>>   	return ret;
>>   }
>>   
>> +static int do_remap_tree_reloc_trans(struct btrfs_fs_info *fs_info,
>> +				     struct btrfs_block_group *src_bg,
>> +				     struct btrfs_path *path, u64 *last_start)
>> +{
>> +	struct btrfs_trans_handle *trans;
>> +	struct btrfs_root *extent_root;
>> +	struct btrfs_key ins;
>> +	struct btrfs_block_group *dest_bg = NULL;
>> +	u64 start, remap_length, length, new_addr, min_size;
>> +	int ret;
>> +	bool no_more = false;
>> +	bool is_data = src_bg->flags & BTRFS_BLOCK_GROUP_DATA;
>> +	bool made_reservation = false, bg_needs_free_space;
>> +	struct btrfs_space_info *sinfo = src_bg->space_info;
>> +
>> +	extent_root = btrfs_extent_root(fs_info, src_bg->start);
>> +
>> +	trans = btrfs_start_transaction(extent_root, 0);
>> +	if (IS_ERR(trans))
>> +		return PTR_ERR(trans);
>> +
>> +	mutex_lock(&fs_info->remap_mutex);
>> +
>> +	ret = find_next_identity_remap(trans, path, src_bg->start + src_bg->length,
>> +				       *last_start, &start, &remap_length);
>> +	if (ret == -ENOENT) {
>> +		no_more = true;
>> +		goto next;
>> +	} else if (ret) {
>> +		mutex_unlock(&fs_info->remap_mutex);
>> +		btrfs_end_transaction(trans);
>> +		return ret;
>> +	}
>> +
>> +	/* Try to reserve enough space for block. */
>> +
>> +	spin_lock(&sinfo->lock);
>> +	btrfs_space_info_update_bytes_may_use(sinfo, remap_length);
>> +	spin_unlock(&sinfo->lock);
>> +
>> +	if (is_data)
>> +		min_size = fs_info->sectorsize;
>> +	else
>> +		min_size = fs_info->nodesize;
> 
> As Qu mentioned, I think it makes sense to not change too much at once
> and not add the extra fragmentation factor baked in with remap tree.
> This isn't a format change so we can change it later if we have data
> about lots of failing relocations to support that.
> 
> On the other hand, we are going contiguous non-free at a time rather
> than extent at a time, so maybe this is actually quite necessary.

Exactly, this is a contiguous non-free range, rather than an extent in 
the same sense as in the extent tree. I'll add a comment here as the 
call to btrfs_reserve_extent() is misleading.

Reworking this to deal with actual extents would make it considerably 
more complicated: the initial state of the remap tree is derived from 
the free-space tree, and the free-space tree doesn't know about extents.
> Let's document / highlight that if it's the reasoning.
> 
>> +
>> +	ret = btrfs_reserve_extent(fs_info->fs_root, remap_length,
>> +				   remap_length, min_size,
>> +				   0, 0, &ins, is_data, false);
>> +	if (ret) {
>> +		spin_lock(&sinfo->lock);
>> +		btrfs_space_info_update_bytes_may_use(sinfo, -remap_length);
>> +		spin_unlock(&sinfo->lock);
>> +
>> +		mutex_unlock(&fs_info->remap_mutex);
>> +		btrfs_end_transaction(trans);
>> +		return ret;
>> +	}
>> +
>> +	made_reservation = true;
>> +
>> +	new_addr = ins.objectid;
>> +	length = ins.offset;
>> +
>> +	if (!is_data && !IS_ALIGNED(length, fs_info->nodesize)) {
>> +		u64 new_length = ALIGN_DOWN(length, fs_info->nodesize);
>> +
>> +		btrfs_free_reserved_extent(fs_info, new_addr + new_length,
>> +					   length - new_length, 0);
>> +
>> +		length = new_length;
>> +	}
>> +
>> +	dest_bg = btrfs_lookup_block_group(fs_info, new_addr);
>> +
>> +	mutex_lock(&dest_bg->free_space_lock);
>> +	bg_needs_free_space = test_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE,
>> +				       &dest_bg->runtime_flags);
>> +	mutex_unlock(&dest_bg->free_space_lock);
>> +
>> +	if (bg_needs_free_space) {
>> +		ret = btrfs_add_block_group_free_space(trans, dest_bg);
>> +		if (ret)
>> +			goto fail;
>> +	}
>> +
>> +	ret = do_copy(fs_info, start, new_addr, length);
>> +	if (ret)
>> +		goto fail;
>> +
>> +	ret = btrfs_remove_from_free_space_tree(trans, new_addr, length);
>> +	if (ret)
>> +		goto fail;
>> +
>> +	ret = add_remap_entry(trans, path, src_bg, start, new_addr, length);
>> +	if (ret) {
>> +		btrfs_add_to_free_space_tree(trans, new_addr, length);
>> +		goto fail;
>> +	}
>> +
>> +	adjust_block_group_remap_bytes(trans, dest_bg, length);
>> +	btrfs_free_reserved_bytes(dest_bg, length, 0);
>> +
>> +	spin_lock(&sinfo->lock);
>> +	sinfo->bytes_readonly += length;
>> +	spin_unlock(&sinfo->lock);
>> +
>> +next:
>> +	if (dest_bg)
>> +		btrfs_put_block_group(dest_bg);
>> +
>> +	if (made_reservation)
>> +		btrfs_dec_block_group_reservations(fs_info, new_addr);
>> +
>> +	mutex_unlock(&fs_info->remap_mutex);
>> +
>> +	if (src_bg->identity_remap_count == 0)
>> +		btrfs_mark_bg_fully_remapped(src_bg, trans);
>> +
>> +	ret = btrfs_end_transaction(trans);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (no_more)
>> +		return 1;
>> +
>> +	*last_start = start;
>> +
>> +	return 0;
>> +
>> +fail:
>> +	if (dest_bg)
>> +		btrfs_put_block_group(dest_bg);
>> +
>> +	btrfs_free_reserved_extent(fs_info, new_addr, length, 0);
>> +
>> +	mutex_unlock(&fs_info->remap_mutex);
>> +	btrfs_end_transaction(trans);
>> +
>> +	return ret;
>> +}
>> +
>> +static int do_remap_tree_reloc(struct btrfs_fs_info *fs_info,
>> +			       struct btrfs_path *path,
>> +			       struct btrfs_block_group *bg)
>> +{
>> +	u64 last_start;
>> +	int ret;
>> +
>> +	last_start = bg->start;
>> +
>> +	while (true) {
>> +		ret = do_remap_tree_reloc_trans(fs_info, bg, path,
>> +						&last_start);
>> +		if (ret) {
>> +			if (ret == 1)
>> +				ret = 0;
>> +			break;
>> +		}
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>>   int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
>>   			  u64 *length)
>>   {
>> @@ -5046,6 +5354,15 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start,
>>   		}
>>   
>>   		ret = start_block_group_remapping(fs_info, path, bg);
>> +		if (ret)
>> +			goto out;
>> +
>> +		ret = do_remap_tree_reloc(fs_info, path, rc->block_group);
>> +		if (ret)
>> +			goto out;
>> +
>> +		btrfs_delete_unused_bgs(fs_info);
>> +
>>   		goto out;
>>   	}
>>   
>> -- 
>> 2.49.1
>>



