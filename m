Return-Path: <linux-btrfs+bounces-19302-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 933BFC82010
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 19:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 89E114E7253
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 18:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD553148AF;
	Mon, 24 Nov 2025 18:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="iSiW4Ne6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1CE217722
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Nov 2025 18:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764007300; cv=none; b=civfBG7Ecckb3NKeiZAWeaJaTUINtrOoodXGDJmcFg/ONGh8EJ/DyBlhur7Os0C4o18X/9gwAPvtspV1Aem2wAueMJ3bE8FmOLWPzWenwROdlNZGPsxX3BAN8VzNWX4uoESyKeMMPvm7y+GEQhFqK01z/kqT2nLlq2M5xrSzalE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764007300; c=relaxed/simple;
	bh=96SBsnjb4CLfK43ehNfp426j8qT81JryDlQVxiqqDS0=;
	h=Message-ID:Date:Mime-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MOi0+EK50YYjBKVBftj5ek4vnx8LuTnra9pqoUFC+e73um/5mASZ1kGUaIo/lA0H2H7RYiHJ71XNWeNziS9FACo3CCi6Ev0LoSjc+li7mHxrsrpCNfJMXjixfe96CN2YqyX0XspN/CETYvCEW2YeqsjYBOb4UvmcSKorCNur8uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=iSiW4Ne6; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from [IPV6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2] (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id 59B722DEC23;
	Mon, 24 Nov 2025 18:01:33 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1764007293;
	bh=SK+8ZZ/trTykfodx8yF5GXi/CoFyRDvua3HXAWF4dig=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=iSiW4Ne6Y++8Y6kJjT6loLrnitHIeU0ksgj+WMuD7hSg5jUYI18NQNCIZpGCZEHbP
	 07GdqPZ08DnjSkBzijfo/tuw2+MhF6y1wVUPoIR/28DPDRP390rDRHtovQftBTzKTy
	 W/X2brWB7HLXV7KuXMuBM7grPS9R6g7dKzsxTWkg=
Message-ID: <22efae79-71e8-4b2f-b190-9767beac7f31@harmstone.com>
Date: Mon, 24 Nov 2025 18:01:41 +0000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v6 10/16] btrfs: handle setting up relocation of block
 group with remap-tree
To: Sun Yangkai <sunk67188@gmail.com>
Cc: boris@bur.io, linux-btrfs@vger.kernel.org
References: <20251114184745.9304-11-mark@harmstone.com>
 <18c7ae32-7cfb-427a-be9a-44fa97577359@gmail.com>
Content-Language: en-US
From: Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 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
In-Reply-To: <18c7ae32-7cfb-427a-be9a-44fa97577359@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thank you Sun, I agree that that's better. I'll roll it into the patch 
for version 7.

On 15/11/2025 2.52 pm, Sun Yangkai wrote:
> While reading the thread, I noticed the logic that builds the identity_remap
> entries was a bit hard to follow.
> I took the liberty of rewriting the function so that the two high-level cases
> are immediately visible inside a single if/else. The result has no behavioral
> change, and (at least to me) makes it obvious where the head/tail gaps are handled.
> The modified code is shown below; feel free to pick it up if you find it useful.
> Please let me know if I missed anything.
> 
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
> 
> We can group the empty and non-empty space_runs cases into an if/else to make
> the two main flows obvious and reduce scattered conditions:
> 
>   	num_entries = 0;
> 
>   	if (num_space_runs == 0) {
>   		entries[num_entries].objectid = bg->start;
>   		entries[num_entries].type = BTRFS_IDENTITY_REMAP_KEY;
>   		entries[num_entries].offset = bg->length;
>   		num_entries++;
>   	} else {
>   		if (space_runs[0].start > bg->start) {
>   			entries[num_entries].objectid = bg->start;
>   			entries[num_entries].type = BTRFS_IDENTITY_REMAP_KEY;
>   			entries[num_entries].offset = space_runs[0].start - bg->start;
>   			num_entries++;
>   		}
>   		for (unsigned int i = 1; i < num_space_runs; i++) {
>   			entries[num_entries].objectid = space_runs[i - 1].end;
>   			entries[num_entries].type = BTRFS_IDENTITY_REMAP_KEY;
>   			entries[num_entries].offset =
>   				space_runs[i].start - space_runs[i - 1].end;
>   			num_entries++;
>   		}
>   		if (space_runs[num_space_runs - 1].end < bg->start + bg->length) {
>   			entries[num_entries].objectid = space_runs[num_space_runs - 1].end;
>   			entries[num_entries].type = BTRFS_IDENTITY_REMAP_KEY;
>   			entries[num_entries].offset =
>   				bg->start + bg->length - space_runs[num_space_runs - 1].end;
>   			num_entries++;
>   		}
>   		if (num_entries == 0)
>   			goto out;
>   	}
> 
> 	// I'm not sure if it's necessary but we can free space_runs earlier
> 	// since we're also doing allocation in add_remap_tree_entries().
> 	// kfree(space_runs);
> 	// space_runs = NULL;
> 
>   	bg->identity_remap_count = num_entries;
> 
>   	ret = add_remap_tree_entries(trans, path, entries, num_entries);
> 
> 
>> +
>> +out:
>> +	kfree(entries);
>> +	kfree(space_runs);
>> +
>> +	return ret;
>> +}
> 
> Regards,
> Sun Yangkai


