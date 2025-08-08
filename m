Return-Path: <linux-btrfs+bounces-15935-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EBEB1EA3E
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 16:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7349C18C6398
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 14:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CB027702B;
	Fri,  8 Aug 2025 14:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="GOlazzeA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2D1277CB1
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Aug 2025 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754662877; cv=none; b=Gr/E7J1U1O7rIgG7JwSk1EkE7XNobrez2AECC5+87KGG7QUwJO0Lpt+icZtYLAlWzFxjzrO2h08ZQYo1CiaBVT1uAuzb4Vdoy3ypPL1CO/z0XosIlAMw1JL7fujI3fdHLyR5RfrbNZtzY4CsPH5FZ1+pI1fPX6vNzD2Laua/TuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754662877; c=relaxed/simple;
	bh=4aOXfwBD85Bc/OBnovoDeYZxBpn4Lk+gNpV2OP9LlKA=;
	h=Message-ID:Date:Mime-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UDj5QzSWxJtoH1tYgNvnL+1eZz6LoBGRSYhZFZ0GQriRCDurR/yrSn9H/afGZR5FWVNY5hHnfjk3sXC/bpvyvSOrz0emFrwgAnZpbCZ66brv48ztfKKBD3AcD1M+3/2BDknb5G87PlihhXkN2AkyhAWgLqaxZ88GvLygTnpF8DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=GOlazzeA; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from [IPV6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2] (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id 1707C2A4E29;
	Fri,  8 Aug 2025 15:12:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1754662331;
	bh=QjExCDNH09kTMETHsMBY6vnl8+VGG3g3gMAf55l5Aq8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GOlazzeA2FLFx/zs6+Fa8zcQg+n7frEpRwE4aJE26EZjHrfwFqXkQn7b7HqYy1w2R
	 CtTHR8kLxonwu/PYNrmQTQ5dlmDpxjZQITKzc3DwDiWc3+Jns8wTIho+z7krWkb5FM
	 2cARSNufZ36jDgzNnw675Avl0vAZkZRJ/dumyqJ4=
Message-ID: <5918c2a5-7145-46a9-9ab4-779e172c7c83@harmstone.com>
Date: Fri, 8 Aug 2025 15:12:10 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH 03/12] btrfs: allow remapped chunks to have zero stripes
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <20250605162345.2561026-1-maharmstone@fb.com>
 <20250605162345.2561026-4-maharmstone@fb.com>
 <20250613214107.GC3621880@zen.localdomain>
Content-Language: en-US
From: Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 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
In-Reply-To: <20250613214107.GC3621880@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/06/2025 10.41 pm, Boris Burkov wrote:

...snip...

 >> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
>> index 0505f8d76581..fd83df06e3fb 100644
>> --- a/fs/btrfs/tree-checker.c
>> +++ b/fs/btrfs/tree-checker.c
>> @@ -829,7 +829,7 @@ int btrfs_check_chunk_valid(const struct btrfs_fs_info *fs_info,
>>   	u64 type;
>>   	u64 features;
>>   	u32 chunk_sector_size;
>> -	bool mixed = false;
>> +	bool mixed = false, remapped;
> 
> nit:
> I *personally* don't like such declarations. I think they are lightly if
> not decisively discouraged in the Linux Coding Style document as well
> (at least to my reading). In our code, I found some examples where they
> are used where both values are related and get assigned. But I haven't
> seen any like this for unrelated variables with mixed assignment.
> 
>>   	int raid_index;
>>   	int nparity;
>>   	int ncopies;
>> @@ -853,12 +853,14 @@ int btrfs_check_chunk_valid(const struct btrfs_fs_info *fs_info, >  	ncopies = btrfs_raid_array[raid_index].ncopies;
>>   	nparity = btrfs_raid_array[raid_index].nparity;
>>   
>> -	if (unlikely(!num_stripes)) {
>> +	remapped = type & BTRFS_BLOCK_GROUP_REMAPPED;
>> +
>> +	if (unlikely(!remapped && !num_stripes)) {
>>   		chunk_err(fs_info, leaf, chunk, logical,
>>   			  "invalid chunk num_stripes, have %u", num_stripes);
>>   		return -EUCLEAN;
>>   	}
>> -	if (unlikely(num_stripes < ncopies)) {
>> +	if (unlikely(!remapped && num_stripes < ncopies)) {
> 
> I think remapped only permits you exactly num_stripes == 0, not
> num_stripes = 2 if ncopies = 3, right? Though it makes the logic less
> neat, I would make the check as precise as possible on the invariants.

I'm changing the check here to num_stripes != 0 && num_stripes < ncopies,
which I hope makes things a little clearer. It also means that we have an
error if something goes wrong with a partially remapped chunk.

The current logic is that we keep the RAID flags as they are when a chunk
is remapped, and ncopies is derived from the RAID flags. I'm not entirely
sure this is the right thing to do, but it hopefully might make it easier
to discover what happened if something goes wrong. Similarly with
sub_stripes etc.

>>   		chunk_err(fs_info, leaf, chunk, logical,
>>   			  "invalid chunk num_stripes < ncopies, have %u < %d",
>>   			  num_stripes, ncopies);
>> @@ -960,7 +962,7 @@ int btrfs_check_chunk_valid(const struct btrfs_fs_info *fs_info,
>>   		}
>>   	}
>>   
>> -	if (unlikely((type & BTRFS_BLOCK_GROUP_RAID10 &&
>> +	if (unlikely(!remapped && ((type & BTRFS_BLOCK_GROUP_RAID10 &&
>>   		      sub_stripes != btrfs_raid_array[BTRFS_RAID_RAID10].sub_stripes) ||
>>   		     (type & BTRFS_BLOCK_GROUP_RAID1 &&
>>   		      num_stripes != btrfs_raid_array[BTRFS_RAID_RAID1].devs_min) ||
>> @@ -975,7 +977,7 @@ int btrfs_check_chunk_valid(const struct btrfs_fs_info *fs_info,
>>   		     (type & BTRFS_BLOCK_GROUP_DUP &&
>>   		      num_stripes != btrfs_raid_array[BTRFS_RAID_DUP].dev_stripes) ||
>>   		     ((type & BTRFS_BLOCK_GROUP_PROFILE_MASK) == 0 &&
>> -		      num_stripes != btrfs_raid_array[BTRFS_RAID_SINGLE].dev_stripes))) {
>> +		      num_stripes != btrfs_raid_array[BTRFS_RAID_SINGLE].dev_stripes)))) {
>>   		chunk_err(fs_info, leaf, chunk, logical,
>>   			"invalid num_stripes:sub_stripes %u:%u for profile %llu",
>>   			num_stripes, sub_stripes,
>> @@ -999,11 +1001,11 @@ static int check_leaf_chunk_item(struct extent_buffer *leaf,
>>   	struct btrfs_fs_info *fs_info = leaf->fs_info;
>>   	int num_stripes;
>>   
>> -	if (unlikely(btrfs_item_size(leaf, slot) < sizeof(struct btrfs_chunk))) {
>> +	if (unlikely(btrfs_item_size(leaf, slot) < offsetof(struct btrfs_chunk, stripe))) {
>>   		chunk_err(fs_info, leaf, chunk, key->offset,
>>   			"invalid chunk item size: have %u expect [%zu, %u)",
>>   			btrfs_item_size(leaf, slot),
>> -			sizeof(struct btrfs_chunk),
>> +			offsetof(struct btrfs_chunk, stripe),
>>   			BTRFS_LEAF_DATA_SIZE(fs_info));
>>   		return -EUCLEAN;
> 
> Same complaint as above for nstripes < ncopies. Is there some way to
> more generically bypass stripe checking if we detect the case we care
> about: (remapped && num_stripes == 0) ?

I'm presuming this comment is for the if beginning on line 964. I'm moving this whole
bit to a helper function, it's too confusing as it is.

> 
>>   	}
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index e7c467b6af46..9159d11cb143 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -6133,6 +6133,12 @@ struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
>>   		goto out_free_map;
>>   	}
>>   
>> +	/* avoid divide by zero on fully-remapped chunks */
>> +	if (map->num_stripes == 0) {
>> +		ret = -EOPNOTSUPP;
>> +		goto out_free_map;
>> +	}
>> +
> 
> This seems kinda sketchy to me. Presumably once we have remapped a block
> group, we do want to discard it. But this makes that impossible? Does
> the discarding happen before we set num_stripes to 0? Even with
> discard=async?
> 
>>   	offset = logical - map->start;
>>   	length = min_t(u64, map->start + map->chunk_len - logical, length);
>>   	*length_ret = length;
>> @@ -6953,7 +6959,7 @@ u64 btrfs_calc_stripe_length(const struct btrfs_chunk_map *map)
>>   {
>>   	const int data_stripes = calc_data_stripes(map->type, map->num_stripes);
>>   
>> -	return div_u64(map->chunk_len, data_stripes);
>> +	return data_stripes ? div_u64(map->chunk_len, data_stripes) : 0;
> 
> Rather than making 0 a special value meaning remapped, would it be
> useful/clearer to also include a remapped flag on the btrfs_chunk_map?
> This function would have to behave the same way, presumably, but it
> would be less implicit, and we could make assertions on chunk maps that
> they have 0 stripes iff remapped at various places where we use the
> stripe length. That would raise confidence that all the uses of stripe
> logic account for remapped chunks.

It's less that 0 is a special value, more that btrfs_calc_stripe_length()
gets called from read_one_chunk(), and will divide-by-zero otherwise. I could
have put a check in read_one_chunk() instead, but this seems less footgunny.
If a chunk is fully remapped all I/O to it will be redirected elsewhere, so its
stripe length won't actually be used.

The BTRFS_BLOCK_GROUP_REMAPPED flag already gets set in the btrfs_chunk_map,
as does the num_stripes == 0 meaning fully remapped.

> 
>>   }
>>   
>>   #if BITS_PER_LONG == 32
>> -- 
>> 2.49.0
>>
> 


