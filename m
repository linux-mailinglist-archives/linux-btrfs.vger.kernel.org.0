Return-Path: <linux-btrfs+bounces-16442-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE3FB3846E
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Aug 2025 16:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC2C71B658F4
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Aug 2025 14:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA7C35A290;
	Wed, 27 Aug 2025 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="JIJYyx9x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9750350D41
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Aug 2025 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756303702; cv=none; b=u9k8dDruneDDUQBQa/8azktALX0ijv7S3hDvF00q2UvSmXk9Qf5gU8WLDjw4c1itOfx9aZy6NWhbbqHaMDh3MG4EYNOCxxgi72eGPQ6HMgEHw8QDXUsiA0PfaeEVuYz7XftoeTNKLUDWzkh75OpPbyW5JLQtIUBUed/idu1hTHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756303702; c=relaxed/simple;
	bh=NCkEVLLCAh6KIkKdudm7E3AqCD0Q0I1JQVmXHPhHOFg=;
	h=Message-ID:Date:Mime-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qW+Ph5I3aAavO6EkEx92+QVHaY335v7Aj/+/vkIc+zooyrhaecz/c30eTSrvdkbeLtUPEFNqcLnkRRTFh7x1aMoeu1tg1sj+dyCkUUaLj8w4GEC2uACD3D40wv0/j1hsUD0POigoS2W+2sDUWqPNJLsUiczYNrBszCv2tRkiNpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=JIJYyx9x; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from [IPV6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2] (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id 98A4D2AE209;
	Wed, 27 Aug 2025 15:08:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1756303693;
	bh=cEXJC/TOf0xpMj8jOAGkNiOrYe6TUbAYFmUq2IONXjw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JIJYyx9xacezZXwQI9jT3hdsjimTpy/W/NOOkpQ7++966ZNN3gLuYrIQuQ8wyPQzT
	 WeAq7fQqVuYkIeKjrTt314uz7tlG/ZVaC7qJdUCfj1DQvn+dHMK+uNCESyuKWYBJ9S
	 Vvmg0PPxuiGAMjPkk4h94G97NBVEQoBF0VqJaMj8=
Message-ID: <a8949df0-adad-48b6-a27b-6cf6c3e38f9f@harmstone.com>
Date: Wed, 27 Aug 2025 15:08:13 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v2 08/16] btrfs: redirect I/O for remapped block groups
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <20250813143509.31073-1-mark@harmstone.com>
 <20250813143509.31073-9-mark@harmstone.com>
 <20250822194241.GB492925@zen.localdomain>
Content-Language: en-US
From: Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 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
In-Reply-To: <20250822194241.GB492925@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/08/2025 8.42 pm, Boris Burkov wrote:
> On Wed, Aug 13, 2025 at 03:34:50PM +0100, Mark Harmstone wrote:
>> Change btrfs_map_block() so that if the block group has the REMAPPED
>> flag set, we call btrfs_translate_remap() to obtain a new address.
>>
>> btrfs_translate_remap() searches the remap tree for a range
>> corresponding to the logical address passed to btrfs_map_block(). If it
>> is within an identity remap, this part of the block group hasn't yet
>> been relocated, and so we use the existing address.
>>
>> If it is within an actual remap, we subtract the start of the remap
>> range and add the address of its destination, contained in the item's
>> payload.
>>
>> Signed-off-by: Mark Harmstone <mark@harmstone.com>
>> ---
>>   fs/btrfs/relocation.c | 59 +++++++++++++++++++++++++++++++++++++++++++
>>   fs/btrfs/relocation.h |  2 ++
>>   fs/btrfs/volumes.c    | 31 +++++++++++++++++++++++
>>   3 files changed, 92 insertions(+)
>>
>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>> index 7256f6748c8f..e1f1da9336e7 100644
>> --- a/fs/btrfs/relocation.c
>> +++ b/fs/btrfs/relocation.c
>> @@ -3884,6 +3884,65 @@ static const char *stage_to_string(enum reloc_stage stage)
>>   	return "unknown";
>>   }
>>   
>> +int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
>> +			  u64 *length, bool nolock)
>> +{
>> +	int ret;
>> +	struct btrfs_key key, found_key;
>> +	struct extent_buffer *leaf;
>> +	struct btrfs_remap *remap;
>> +	BTRFS_PATH_AUTO_FREE(path);
>> +
>> +	path = btrfs_alloc_path();
>> +	if (!path)
>> +		return -ENOMEM;
>> +
>> +	if (nolock) {
>> +		path->search_commit_root = 1;
>> +		path->skip_locking = 1;
>> +	}
> 
> We are calling this without a transaction and in a loop in
> btrfs_submit_bbio:
> 
> btrfs_submit_bbio
>    while (blah); btrfs_submit_chunk
>      btrfs_map_block
>        btrfs_translate_remap
> 
> So that means in that loop we can have one remap tree in one step of the
> loop and then a transaction can finish and then the next chunk is
> remapped on the next remap tree in the next step.
> 
> Is that acceptable? Otherwise you need to hold the commit_root_sem for
> the whole loop. It seems OK because both copies ought to be around while
> we're in the middle of remapping, but let's be sure. I'm also curious
> about the paths that are removing things from the remap tree. I would
> expect live IO that would use that remapping would block them, as it
> is like removing an extent, but also worth considering.

Yes, this should be fine, as both copies will be valid. The only problem is
there's a race with DIO, which we know about.

The current discard code delays all discards until the last identity remap
has gone, rather than discarding as we go along, so there shouldn't be an
issue with reading data that's just been discarded.

> 
>> +
>> +	key.objectid = *logical;
>> +	key.type = (u8)-1;
>> +	key.offset = (u64)-1;
>> +
>> +	ret = btrfs_search_slot(NULL, fs_info->remap_root, &key, path,
>> +				0, 0);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	leaf = path->nodes[0];
>> +
>> +	if (path->slots[0] == 0)
>> +		return -ENOENT;
>> +
>> +	path->slots[0]--;
>> +
>> +	btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
>> +
>> +	if (found_key.type != BTRFS_REMAP_KEY &&
>> +	    found_key.type != BTRFS_IDENTITY_REMAP_KEY) {
>> +		return -ENOENT;
>> +	}
>> +
>> +	if (found_key.objectid > *logical ||
>> +	    found_key.objectid + found_key.offset <= *logical) {
>> +		return -ENOENT;
>> +	}
>> +
>> +	if (*logical + *length > found_key.objectid + found_key.offset)
>> +		*length = found_key.objectid + found_key.offset - *logical;
>> +
>> +	if (found_key.type == BTRFS_IDENTITY_REMAP_KEY)
>> +		return 0;
>> +
>> +	remap = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_remap);
>> +
>> +	*logical = *logical - found_key.objectid + btrfs_remap_address(leaf, remap);
> 
> nit: I think the readability of this would benefit from some "offset"
> helper variable, but your commit message does make it clear enough.

Rearranging it to...

*logical += btrfs_remap_address(leaf, remap) - found_key.objectid;

...looks a lot less ugly.

> 
>> +
>> +	return 0;
>> +}
>> +
>>   /*
>>    * function to relocate all extents in a block group.
>>    */
>> diff --git a/fs/btrfs/relocation.h b/fs/btrfs/relocation.h
>> index 5c36b3f84b57..a653c42a25a3 100644
>> --- a/fs/btrfs/relocation.h
>> +++ b/fs/btrfs/relocation.h
>> @@ -31,5 +31,7 @@ int btrfs_should_cancel_balance(const struct btrfs_fs_info *fs_info);
>>   struct btrfs_root *find_reloc_root(struct btrfs_fs_info *fs_info, u64 bytenr);
>>   bool btrfs_should_ignore_reloc_root(const struct btrfs_root *root);
>>   u64 btrfs_get_reloc_bg_bytenr(const struct btrfs_fs_info *fs_info);
>> +int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
>> +			  u64 *length, bool nolock);
>>   
>>   #endif
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 678e5d4cd780..a2c49cb8bfc6 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -6635,6 +6635,37 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
>>   	if (IS_ERR(map))
>>   		return PTR_ERR(map);
>>   
>> +	if (map->type & BTRFS_BLOCK_GROUP_REMAPPED) {
> 
> potential optimization (not blocking for this version IMO):
> if you can cache the type on the extent_map (I actually think it ought
> to already be done, essentially, as we know data vs. not data) then you
> don't need to lookup the map at all for a remapped block, and can go
> straight to looking up the remap.
> 
>> +		u64 new_logical = logical;
>> +		bool nolock = !(map->type & BTRFS_BLOCK_GROUP_DATA);
>> +
>> +		/*
>> +		 * We use search_commit_root in btrfs_translate_remap for
>> +		 * metadata blocks, to avoid lockdep complaining about
>> +		 * recursive locking.
> 
> real risk of deadlock or "complaining"?

Complaining. Reading any tree other than the chunk tree can result in a
read of the remap tree, but reading the remap tree won't read any other
tree.

I added a btrfs_lockdep_keyset for the remap-tree as a result of another
issue, which I think might well have fixed this too. But search_commit_root
is a desirable optimization regardless, which is why I've kept it in.

> 
>> +		 * If we get -ENOENT this means this is a BG that has just had
>> +		 * its REMAPPED flag set, and so nothing has yet been actually
>> +		 * remapped.
>> +		 */
>> +		ret = btrfs_translate_remap(fs_info, &new_logical, length,
>> +					    nolock);
>> +		if (ret && (!nolock || ret != -ENOENT))
>> +			return ret;
>> +
>> +		if (ret != -ENOENT && new_logical != logical) {
>> +			btrfs_free_chunk_map(map);
>> +
>> +			map = btrfs_get_chunk_map(fs_info, new_logical,
>> +						  *length);
>> +			if (IS_ERR(map))
>> +				return PTR_ERR(map);
>> +
>> +			logical = new_logical;
>> +		}
>> +
>> +		ret = 0;
>> +	}
>> +
>>   	num_copies = btrfs_chunk_map_num_copies(map);
>>   	if (io_geom.mirror_num > num_copies)
>>   		return -EINVAL;
>> -- 
>> 2.49.1
>>


