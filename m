Return-Path: <linux-btrfs+bounces-18059-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0337BF1DF2
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 16:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAAC518A7D7E
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 14:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF35A1C3BFC;
	Mon, 20 Oct 2025 14:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="GQNhT5D1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (unknown [62.3.69.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B766E1E1E0B
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 14:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.3.69.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760970706; cv=none; b=QwBx+1Vc4DWW3rdzY7iuskw6OThzpKpVHowxlGBnVkWEwV9VgSntkgoaz957dGJ/NXMBJZmkHig/4T8FacDJ8z+w2/UARJ33ytjSvYgf9ipZaNqfBc5EPMFrta0G9Jms37PiYeSCkdeYU0TMRPMrclAhCuL+pbxzFJKmw+NML1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760970706; c=relaxed/simple;
	bh=GWS9JLdGPxIyRPkN7HgLagGR8YrDSdsXMfColWqzUFg=;
	h=Message-ID:Date:Mime-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K5qqYFN4HlehVorWNCkTUFbH6HNmGMCCS+RLPYKq3AfkwShb5yVdNdoa+uHQemWeQrFJwWDHEvW2a2BgKeS026vwIAuqGnJTk9u/jy1CKnAYnk5ne6bl3LuNjV4vZEok7L+xv7bsNU3nayI4SwXK0d1nF5t5J8xBNGzyDY5Lfeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=fail smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=GQNhT5D1; arc=none smtp.client-ip=62.3.69.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=harmstone.com
Received: from [IPV6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2] (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id BCD292CD679;
	Mon, 20 Oct 2025 15:31:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1760970699;
	bh=5RvFaMgirjwhxb3FLeS4f9Nr+F2vPXOpF28vf8GJbvU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GQNhT5D1WAovGGKvcpOqBtQWFwWY8tcYq35/lpbIQsiF8GfsgJ90rzVGmI7J4Pmfw
	 3n01ErLsK7fN16oASoFlcWpmjXCrTeVSiDLCaNHG1Wmjd+7vwyqQ6Lyo0uvE4+w5/P
	 eoqnqQJ+nA0W6YNlWLwFYHK3ttJtVTEaUkLYktrY=
Message-ID: <f74da96e-7b50-48f2-b9ad-a2aefc8ed9aa@harmstone.com>
Date: Mon, 20 Oct 2025 15:31:39 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v3 08/17] btrfs: redirect I/O for remapped block groups
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <20251009112814.13942-1-mark@harmstone.com>
 <20251009112814.13942-9-mark@harmstone.com>
 <20251015042136.GG1702774@zen.localdomain>
Content-Language: en-US
From: Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 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
In-Reply-To: <20251015042136.GG1702774@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/10/2025 5.21 am, Boris Burkov wrote:
> On Thu, Oct 09, 2025 at 12:28:03PM +0100, Mark Harmstone wrote:
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
>> index 748290758459..4f5d3aaf0f65 100644
>> --- a/fs/btrfs/relocation.c
>> +++ b/fs/btrfs/relocation.c
>> @@ -3870,6 +3870,65 @@ static const char *stage_to_string(enum reloc_stage stage)
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
>> +	*logical += btrfs_remap_address(leaf, remap) - found_key.objectid;
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
>> index 0abe02a7072f..f2d1203778aa 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -6635,6 +6635,37 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
>>   	if (IS_ERR(map))
>>   		return PTR_ERR(map);
>>   
>> +	if (map->type & BTRFS_BLOCK_GROUP_REMAPPED) {
>> +		u64 new_logical = logical;
>> +		bool nolock = !(map->type & BTRFS_BLOCK_GROUP_DATA);
> 
> Why not data?

Because I thought we'd maxed out our lockdep classes so this was the only way to
prevent lockdep from complaining about metadata reads - not yet knowing about
the btrfs_lockdep_keysets array.

I think I'm going to remove the search_commit_root stuff from this patchset, and
leave it for a future optimization. As you know it's full of gotchas.

>> +
>> +		/*
>> +		 * We use search_commit_root in btrfs_translate_remap for
>> +		 * metadata blocks, to avoid lockdep complaining about
>> +		 * recursive locking.
>> +		 * If we get -ENOENT this means this is a BG that has just had
>> +		 * its REMAPPED flag set, and so nothing has yet been actually
>> +		 * remapped.
>> +		 */
> 
> I'm actually kind of worried about this now. What is preventing the
> following racy interleaving:
> 
>        T1                                         T2
>                                          start_block_group_remapping() // in TXN-K set REMAPPED
> btrfs_map_block()
>    btrfs_translate_remap()
>      ENOENT // searched in commit root
>                                          do_remap_tree_reloc() // in TXN-K do all remaps
>                                          // fully remapped, removed, discarded
>                                          // TXN-K committed
>    // not remapped! but the original chunk map is gone gone
>    num_copies = ...

The bits on the right will be separate transactions, I thought that would save
us - does it not? I'm guessing this means that search_commit_root means to
search the last transaction that was flushed to disk, rather than the last
in-memory transaction.

Yes, I'm definitely saving this bit until later.

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


