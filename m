Return-Path: <linux-btrfs+bounces-18050-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 289B7BF11AF
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 14:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7DCD03485D8
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 12:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B321314A74;
	Mon, 20 Oct 2025 12:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="ZNqSjpy6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (unknown [62.3.69.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDB6257422
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 12:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.3.69.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760962514; cv=none; b=hf4zoRs7E9jMTgEpNYV6WxdHm8KjzMF2+xSsbQBgOi1+FU8ka3L2W9l6wJFnj8Igwt+UCVUVwxIAoqMktnN+JQ0zjq5dclXl+IIml7xoC3nJVnL0LjQYxa4mIt7XiFODxKxC0eRtWfxw3hKQy9VVfpLjDywTSdTVJAI1/4yX6Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760962514; c=relaxed/simple;
	bh=cU4SojUMNOLcsuYvndj17xpjdqfzpcBvE0QNil45Arg=;
	h=Message-ID:Date:Mime-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xm3Gg3wK9lfqpEwA8BBb9KxtNRO9qxKB3LCo/HmlhGh7bg1pkEAHblyZePL3WyAWzh1swomiJ3c8DrcCqqs/2jXISqQC293+VKCVEcWE7ciW15EDYc/ovZFDQ2JbV/Z/CAfavnGyCa8dmqd70prRa2IA3D/PmxHLTYkvSpj/zLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=fail smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=ZNqSjpy6; arc=none smtp.client-ip=62.3.69.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=harmstone.com
Received: from [IPV6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2] (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id 985EA2CD556;
	Mon, 20 Oct 2025 13:15:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1760962508;
	bh=TQL6MNIQO5xuSTjenPqitroM+7Cl80zSNtlGs7uDg2E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZNqSjpy6TlIoziHGqfRhq5Dc6+JFWaATuuLA/iRj5Xbh5DoUMMafr2iVr6TrHEq8P
	 Nhx89d2Ud0pV42sfl8jdbbdNs2zh0r9ui23ulneZsuDfEAzZ5i40OhJAIpu00p5og9
	 G2Ari8qjENXyXJ4UwB4o3PkWXvU2FTbh9Q/T0Meg=
Message-ID: <b1bfeb08-9059-42f4-b52a-f5e716aaa380@harmstone.com>
Date: Mon, 20 Oct 2025 13:15:08 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v3 03/17] btrfs: allow remapped chunks to have zero
 stripes
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <20251009112814.13942-1-mark@harmstone.com>
 <20251009112814.13942-4-mark@harmstone.com>
 <20251015034712.GE1702774@zen.localdomain>
Content-Language: en-US
From: Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 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
In-Reply-To: <20251015034712.GE1702774@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/10/2025 4.47 am, Boris Burkov wrote:
> On Thu, Oct 09, 2025 at 12:27:58PM +0100, Mark Harmstone wrote:
>> When a chunk has been fully remapped, we are going to set its
>> num_stripes to 0, as it will no longer represent a physical location on
>> disk.
>>
>> Change tree-checker to allow for this, and fix a couple of
>> divide-by-zeroes seen elsewhere.
>>
>> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> 
> This one feels close to me but I still have a few reservations. Happy to
> discuss the details a bit more, of course.
> 
>> ---
>>   fs/btrfs/tree-checker.c | 65 ++++++++++++++++++++++++++++-------------
>>   fs/btrfs/volumes.c      | 13 ++++++++-
>>   2 files changed, 57 insertions(+), 21 deletions(-)
>>
>> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
>> index 62f35338a555..59b1393e5018 100644
>> --- a/fs/btrfs/tree-checker.c
>> +++ b/fs/btrfs/tree-checker.c
>> @@ -816,6 +816,41 @@ static void chunk_err(const struct btrfs_fs_info *fs_info,
>>   	va_end(args);
>>   }
>>   
>> +static bool valid_stripe_count(u64 profile, u16 num_stripes,
>> +			       u16 sub_stripes)
>> +{
>> +	switch (profile) {
>> +	case BTRFS_BLOCK_GROUP_RAID0:
>> +		return true;
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
>> @@ -839,6 +874,7 @@ int btrfs_check_chunk_valid(const struct btrfs_fs_info *fs_info,
>>   	u64 features;
>>   	u32 chunk_sector_size;
>>   	bool mixed = false;
>> +	bool remapped;
>>   	int raid_index;
>>   	int nparity;
>>   	int ncopies;
>> @@ -862,12 +898,14 @@ int btrfs_check_chunk_valid(const struct btrfs_fs_info *fs_info,
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
>>   		chunk_err(fs_info, leaf, chunk, logical,
>>   			  "invalid chunk num_stripes < ncopies, have %u < %d",
>>   			  num_stripes, ncopies);
>> @@ -965,22 +1003,9 @@ int btrfs_check_chunk_valid(const struct btrfs_fs_info *fs_info,
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
> Is num_stripes == 0 valid for raid 0 aside from remapped?

It's not, but this is caught earlier in the function.

In an earlier version of this patchset I didn't notice that RAID0 wasn't accounted for
in the big if, which led to a BUG() that the robot caught.
valid_stripe_count() is replicating the functionality of the big if. From the looks of
things it's valid for RAID0 to have a single stripe, which is surprising.
>>   		chunk_err(fs_info, leaf, chunk, logical,
>>   			"invalid num_stripes:sub_stripes %u:%u for profile %llu",
>>   			num_stripes, sub_stripes,
>> @@ -1004,11 +1029,11 @@ static int check_leaf_chunk_item(struct extent_buffer *leaf,
>>   	struct btrfs_fs_info *fs_info = leaf->fs_info;
>>   	int num_stripes;
>>   
>> -	if (unlikely(btrfs_item_size(leaf, slot) < sizeof(struct btrfs_chunk))) {
>> +	if (unlikely(btrfs_item_size(leaf, slot) < offsetof(struct btrfs_chunk, stripe))) {
> 
> Does this need a remapped parameter as part of the check too?

Probably not. It's checking that the chunk item is long enough that the num_stripes we
read won't be nonsense, and then later on in the function checks the size again taking
this into account.

> 
>>   		chunk_err(fs_info, leaf, chunk, key->offset,
>>   			"invalid chunk item size: have %u expect [%zu, %u)",
>>   			btrfs_item_size(leaf, slot),
>> -			sizeof(struct btrfs_chunk),
>> +			offsetof(struct btrfs_chunk, stripe),
>>   			BTRFS_LEAF_DATA_SIZE(fs_info));
>>   		return -EUCLEAN;
>>   	}
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index e14b86e2996b..6750f6f0af59 100644
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
> 
> I'll reconsider this when I read the discard stuff more closely, but
> aren't you intending to discard fully remapped chunks? So this seems
> counter-intuitive at best. Since you tested it, I assume it must work,
> just saying since it stuck out to me..

This only kicks in when the do_remap parameter is false. Quite possibly this check isn't
necessary anymore, I wrote it before I did the async discard stuff. Let me check.

> 
>>   	offset = logical - map->start;
>>   	length = min_t(u64, map->start + map->chunk_len - logical, length);
>>   	*length_ret = length;
>> @@ -7088,7 +7094,12 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
>>   	 */
>>   	map->sub_stripes = btrfs_raid_array[index].sub_stripes;
>>   	map->verified_stripes = 0;
>> -	map->stripe_size = btrfs_calc_stripe_length(map);
>> +
>> +	if (num_stripes > 0)
>> +		map->stripe_size = btrfs_calc_stripe_length(map);
>> +	else
>> +		map->stripe_size = 0;
>> +
>>   	for (i = 0; i < num_stripes; i++) {
>>   		map->stripes[i].physical =
>>   			btrfs_stripe_offset_nr(leaf, chunk, i);
>> -- 
>> 2.49.1
>>


