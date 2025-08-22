Return-Path: <linux-btrfs+bounces-16303-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC98B320ED
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 19:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C68F640378
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 17:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7514931352A;
	Fri, 22 Aug 2025 17:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="F4FW6U7c"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC67231A41
	for <linux-btrfs@vger.kernel.org>; Fri, 22 Aug 2025 17:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755882109; cv=none; b=aywls5SIJ45IcMoIGoCRS2Z3f9eYvMWZIFUgz5uevFpRi9E16vqnJQTg0NZPX6sHmlsBLr1Kwg/TzlqI656ZPx2YS2+wnc/SqIyYg+OsE67fhvnt+O/WPxboiFcVlhivZ0CzFayTA4oVf8UhNEq6CJE1Qc6weCg4eP1aPygCGEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755882109; c=relaxed/simple;
	bh=YQgzh3yts+6pKoWiwEvrviN0YD5X6Jwu9b8FZXSn+S0=;
	h=Message-ID:Date:Mime-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Py0SAC8ZqWaPeW498MkBgy1ALRti/sZj+5RdV+reP9DhivUU1YTW2CD1eSgIGh513Y6ytOiZSIoGPJeaJAiNmEKNSGqHmVLSl9WUX6kBsVs30uLsI/jB9iY166kg6/68tKBZAeLma3rZhAyx9udIsQ7UFoX9fM1K0iAbfRuM4Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=F4FW6U7c; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from [IPV6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2] (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id 9DF6E2ABD8D;
	Fri, 22 Aug 2025 18:01:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1755882092;
	bh=1QbXDNiFQfkTbPTBcfD/GslfPd50odb4jRN8TRC/9KQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=F4FW6U7cwACd2Nr6Iiof2KbM3LmHkiinHYP5sUNgUOu3P4w5CtIBIrpF2kPO9WxqE
	 TVJrCESh/fs2M8NzuS3xftfn5GumH7/lfl/alrZ+bH15BNcBICF7hX3VrhocCT6lLX
	 80kUJUsi5xY4e8EpbkQYPumCv2roOWtGxhK55c7M=
Message-ID: <43921b7c-ef78-478a-9e39-bd017c6bcd2d@harmstone.com>
Date: Fri, 22 Aug 2025 18:01:32 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v2 03/16] btrfs: allow remapped chunks to have zero
 stripes
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <20250813143509.31073-1-mark@harmstone.com>
 <20250813143509.31073-4-mark@harmstone.com>
 <20250816000310.GB3042054@zen.localdomain>
Content-Language: en-US
From: Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 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
In-Reply-To: <20250816000310.GB3042054@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/08/2025 1.03 am, Boris Burkov wrote:
> On Wed, Aug 13, 2025 at 03:34:45PM +0100, Mark Harmstone wrote:
>> When a chunk has been fully remapped, we are going to set its
>> num_stripes to 0, as it will no longer represent a physical location on
>> disk.
>>
>> Change tree-checker to allow for this, and fix a couple of
>> divide-by-zeroes seen elsewhere.
>>
>> Signed-off-by: Mark Harmstone <mark@harmstone.com>
>> ---
>>   fs/btrfs/tree-checker.c | 63 ++++++++++++++++++++++++++++-------------
>>   fs/btrfs/volumes.c      |  8 +++++-
>>   2 files changed, 50 insertions(+), 21 deletions(-)
>>
>> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
>> index ca898b1f12f1..20bfe333ffdd 100644
>> --- a/fs/btrfs/tree-checker.c
>> +++ b/fs/btrfs/tree-checker.c
>> @@ -815,6 +815,39 @@ static void chunk_err(const struct btrfs_fs_info *fs_info,
>>   	va_end(args);
>>   }
>>   
>> +static bool valid_stripe_count(u64 profile, u16 num_stripes,
>> +			       u16 sub_stripes)
>> +{
>> +	switch (profile) {
>> +	case BTRFS_BLOCK_GROUP_RAID10:
>> +		return sub_stripes ==
>> +			btrfs_raid_array[BTRFS_RAID_RAID10].sub_stripes;
>> +	case BTRFS_BLOCK_GROUP_RAID1:
>> +		return num_stripes ==
>> +			btrfs_raid_array[BTRFS_RAID_RAID1].devs_min;
>> +	case BTRFS_BLOCK_GROUP_RAID1C3:
>> +		return num_stripes ==
>> +			btrfs_raid_array[BTRFS_RAID_RAID1C3].devs_min;
>> +	case BTRFS_BLOCK_GROUP_RAID1C4:
>> +		return num_stripes ==
>> +			btrfs_raid_array[BTRFS_RAID_RAID1C4].devs_min;
>> +	case BTRFS_BLOCK_GROUP_RAID5:
>> +		return num_stripes >=
>> +			btrfs_raid_array[BTRFS_RAID_RAID5].devs_min;
>> +	case BTRFS_BLOCK_GROUP_RAID6:
>> +		return num_stripes >=
>> +			btrfs_raid_array[BTRFS_RAID_RAID6].devs_min;
>> +	case BTRFS_BLOCK_GROUP_DUP:
>> +		return num_stripes ==
>> +			btrfs_raid_array[BTRFS_RAID_DUP].dev_stripes;
>> +	case 0: /* SINGLE */
>> +		return num_stripes ==
>> +			btrfs_raid_array[BTRFS_RAID_SINGLE].dev_stripes;
>> +	default:
>> +		BUG();
>> +	}
>> +}
>> +
>>   /*
>>    * The common chunk check which could also work on super block sys chunk array.
>>    *
>> @@ -838,6 +871,7 @@ int btrfs_check_chunk_valid(const struct btrfs_fs_info *fs_info,
>>   	u64 features;
>>   	u32 chunk_sector_size;
>>   	bool mixed = false;
>> +	bool remapped;
>>   	int raid_index;
>>   	int nparity;
>>   	int ncopies;
>> @@ -861,12 +895,14 @@ int btrfs_check_chunk_valid(const struct btrfs_fs_info *fs_info,
>>   	ncopies = btrfs_raid_array[raid_index].ncopies;
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
>> +	if (unlikely(num_stripes != 0 && num_stripes < ncopies)) {
> 
> This relying on the above check for the remapped <=> !num_stripes aspect
> was still kinda confusing. Logically looks good now, though.
> 
>>   		chunk_err(fs_info, leaf, chunk, logical,
>>   			  "invalid chunk num_stripes < ncopies, have %u < %d",
>>   			  num_stripes, ncopies);
>> @@ -964,22 +1000,9 @@ int btrfs_check_chunk_valid(const struct btrfs_fs_info *fs_info,
>>   		}
>>   	}
>>   
>> -	if (unlikely((type & BTRFS_BLOCK_GROUP_RAID10 &&
>> -		      sub_stripes != btrfs_raid_array[BTRFS_RAID_RAID10].sub_stripes) ||
>> -		     (type & BTRFS_BLOCK_GROUP_RAID1 &&
>> -		      num_stripes != btrfs_raid_array[BTRFS_RAID_RAID1].devs_min) ||
>> -		     (type & BTRFS_BLOCK_GROUP_RAID1C3 &&
>> -		      num_stripes != btrfs_raid_array[BTRFS_RAID_RAID1C3].devs_min) ||
>> -		     (type & BTRFS_BLOCK_GROUP_RAID1C4 &&
>> -		      num_stripes != btrfs_raid_array[BTRFS_RAID_RAID1C4].devs_min) ||
>> -		     (type & BTRFS_BLOCK_GROUP_RAID5 &&
>> -		      num_stripes < btrfs_raid_array[BTRFS_RAID_RAID5].devs_min) ||
>> -		     (type & BTRFS_BLOCK_GROUP_RAID6 &&
>> -		      num_stripes < btrfs_raid_array[BTRFS_RAID_RAID6].devs_min) ||
>> -		     (type & BTRFS_BLOCK_GROUP_DUP &&
>> -		      num_stripes != btrfs_raid_array[BTRFS_RAID_DUP].dev_stripes) ||
>> -		     ((type & BTRFS_BLOCK_GROUP_PROFILE_MASK) == 0 &&
>> -		      num_stripes != btrfs_raid_array[BTRFS_RAID_SINGLE].dev_stripes))) {
>> +	if (!remapped &&
>> +	    !valid_stripe_count(type & BTRFS_BLOCK_GROUP_PROFILE_MASK,
>> +				num_stripes, sub_stripes)) {
> 
> This looks great, thanks.
> 
>>   		chunk_err(fs_info, leaf, chunk, logical,
>>   			"invalid num_stripes:sub_stripes %u:%u for profile %llu",
>>   			num_stripes, sub_stripes,
>> @@ -1003,11 +1026,11 @@ static int check_leaf_chunk_item(struct extent_buffer *leaf,
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
>>   	}
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index f4d1527f265e..c95f83305c82 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -6145,6 +6145,12 @@ struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
>>   		goto out_free_map;
>>   	}
>>   
>> +	/* avoid divide by zero on fully-remapped chunks */
>> +	if (map->num_stripes == 0) {
>> +		ret = -EOPNOTSUPP;
>> +		goto out_free_map;
>> +	}
>> +
>>   	offset = logical - map->start;
>>   	length = min_t(u64, map->start + map->chunk_len - logical, length);
>>   	*length_ret = length;
>> @@ -6965,7 +6971,7 @@ u64 btrfs_calc_stripe_length(const struct btrfs_chunk_map *map)
>>   {
>>   	const int data_stripes = calc_data_stripes(map->type, map->num_stripes);
>>   
>> -	return div_u64(map->chunk_len, data_stripes);
>> +	return data_stripes ? div_u64(map->chunk_len, data_stripes) : 0;
> 
> My point here was more that we are now including 0 in the range of this
> function, where it wasn't before, meaning that callers must properly
> handle it. And it's not a meaningful "stripe length", so it breaks that
> correspondence, so checking explicitly for "remapped-ness" vs. "length
> == 0" feels more robust to me.
> 
> I won't die on this hill, just making myself as clear as I can.

Thanks Boris, this makes sense - that's fair enough.

>>   }
>>   
>>   #if BITS_PER_LONG == 32
>> -- 
>> 2.49.1
>>


