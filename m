Return-Path: <linux-btrfs+bounces-16595-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4735B408D3
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 17:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DA5A188F968
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 15:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09388319864;
	Tue,  2 Sep 2025 15:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="kp/Dh5KT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (unknown [62.3.69.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E515320A0A
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Sep 2025 15:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.3.69.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756826521; cv=none; b=d4/IWI0YIYt5QMuWBoflXIbD1Hs1vrgPWVTF7LkK6lSlV6dgefJ8it7FMEj1gYfrbD5QHYvFJ6oYIS9sj586DJqoUZWfN9Q+dl35SQbRwzW8mF5Fs/zh4Pnb4eaFH57H3TfMU/r/7+gQk0VQR7mmShhdSzTsg6MTyxvEhUvEMWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756826521; c=relaxed/simple;
	bh=ztXfG9LXAVSHgPXqZpEgVxgv5XQQyXNJWPogVsX7jBw=;
	h=Message-ID:Date:Mime-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=im48gx5e30DgKaNDwkbMC9D3bryGpXpavW07NHWg0w+NQhjOOFmy8ZgvfJNNQRQxg5LRS9RUmBSeKvS7Z/KiJZhcVFKE9hHRHJlECSf7uEPZZHMDG1cDHnrcKZy5qEK5ZyRIuZX4Pg1gesra7No04GSVa5l4oz5+UAfehNrZCvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=fail smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=kp/Dh5KT; arc=none smtp.client-ip=62.3.69.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=harmstone.com
Received: from [IPV6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2] (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id 95CC02B11D3;
	Tue,  2 Sep 2025 16:21:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1756826516;
	bh=1/KEGTbt8R5Y4KjfxKD8PIQdoix5H3kjOkoFVufYndY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kp/Dh5KTMJfh6mT5wAXJtWCBYPDGsYt/EACxqK2D/VIJ3BWWlb07mynlMReGMyH3m
	 3XiM0ktBmtGrgf4iPGq+sjWH1y9JEUtL1amjmH18Ndmr3tg+5O476CANL9yqXdE/SV
	 M+rlMKeQL3XHhzRyre/XCSpW8fIHNIZvrPkDTK0E=
Message-ID: <1629f7a0-a2d8-400a-827d-eae9280de3cb@harmstone.com>
Date: Tue, 2 Sep 2025 16:21:56 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v2 16/16] btrfs: allow balancing remap tree
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <20250813143509.31073-1-mark@harmstone.com>
 <20250813143509.31073-17-mark@harmstone.com>
 <20250816010231.GH3042054@zen.localdomain>
Content-Language: en-US
From: Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 xsBNBFp/GMsBCACtFsuHZqHWpHtHuFkNZhMpiZMChyou4X8Ueur3XyF8KM2j6TKkZ5M/72qT
 EycEM0iU1TYVN/Rb39gBGtRclLFVY1bx4i+aUCzh/4naRxqHgzM2SeeLWHD0qva0gIwjvoRs
 FP333bWrFKPh5xUmmSXBtBCVqrW+LYX4404tDKUf5wUQ9bQd2ItFRM2mU/l6TUHVY2iMql6I
 s94Bz5/Zh4BVvs64CbgdyYyQuI4r2tk/Z9Z8M4IjEzQsjSOfArEmb4nj27R3GOauZTO2aKlM
 8821rvBjcsMk6iE/NV4SPsfCZ1jvL2UC3CnWYshsGGnfd8m2v0aLFSHZlNd+vedQOTgnABEB
 AAHNI01hcmsgSGFybXN0b25lIDxtYXJrQGhhcm1zdG9uZS5jb20+wsCRBBMBCAA7AhsvBQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheAFiEEG2JgKYgV0WRwIJAqbKyhHeAWK+0FAmRQOkICGQEA
 CgkQbKyhHeAWK+22wgf/dBOJ0pHdkDi5fNmWynlxteBsy3VCo0qC25DQzGItL1vEY95EV4uX
 re3+6eVRBy9gCKHBdFWk/rtLWKceWVZ86XfTMHgy+ZnIUkrD3XZa3oIV6+bzHgQ15rXXckiE
 A5N+6JeY/7hAQpSh/nOqqkNMmRkHAZ1ZA/8KzQITe1AEULOn+DphERBFD5S/EURvC8jJ5hEr
 lQj8Tt5BvA57sLNBmQCE19+IGFmq36EWRCRJuH0RU05p/MXPTZB78UN/oGT69UAIJAEzUzVe
 sN3jiXuUWBDvZz701dubdq3dEdwyrCiP+dmlvQcxVQqbGnqrVARsGCyhueRLnN7SCY1s5OHK
 ls7ATQRafxjLAQgAvkcSlqYuzsqLwPzuzoMzIiAwfvEW3AnZxmZn9bQ+ashB9WnkAy2FZCiI
 /BPwiiUjqgloaVS2dIrVFAYbynqSbjqhki+uwMliz7/jEporTDmxx7VGzdbcKSCe6rkE/72o
 6t7KG0r55cmWnkdOWQ965aRnRAFY7Zzd+WLqlzeoseYsNj36RMaqNR7aL7x+kDWnwbw+jgiX
 tgNBcnKtqmJc04z/sQTa+sUX53syht1Iv4wkATN1W+ZvQySxHNXK1r4NkcDA9ZyFA3NeeIE6
 ejiO7RyC0llKXk78t0VQPdGS6HspVhYGJJt21c5vwSzIeZaneKULaxXGwzgYFTroHD9n+QAR
 AQABwsGsBBgBCAAgFiEEG2JgKYgV0WRwIJAqbKyhHeAWK+0FAlp/GMsCGy4BQAkQbKyhHeAW
 K+3AdCAEGQEIAB0WIQR6bEAu0hwk2Q9ibSlt5UHXRQtUiwUCWn8YywAKCRBt5UHXRQtUiwdE
 B/9OpyjmrshY40kwpmPwUfode2Azufd3QRdthnNPAY8Tv9erwsMS3sMh+M9EP+iYJh+AIRO7
 fDN/u0AWIqZhHFzCndqZp8JRYULnspXSKPmVSVRIagylKew406XcAVFpEjloUtDhziBN7ykk
 srAMoLASaBHZpAfp8UAGDrr8Fx1on46rDxsWbh1K1h4LEmkkVooDELjsbN9jvxr8ym8Bkt54
 FcpypTOd8jkt/lJRvnKXoL3rZ83HFiUFtp/ZkveZKi53ANUaqy5/U5v0Q0Ppz9ujcRA9I/V3
 B66DKMg1UjiigJG6espeIPjXjw0n9BCa9jqGICyJTIZhnbEs1yEpsM87eUIH/0UFLv0b8IZe
 pL/3QfiFoYSqMEAwCVDFkCt4uUVFZczKTDXTFkwm7zflvRHdy5QyVFDWMyGnTN+Bq48Gwn1M
 uRT/Sg37LIjAUmKRJPDkVr/DQDbyL6rTvNbA3hTBu392v0CXFsvpgRNYaT8oz7DDBUUWj2Ny
 6bZCBtwr/O+CwVVqWRzKDQgVo4t1xk2ts1F0R1uHHLsX7mIgfXBYdo/y4UgFBAJH5NYUcBR+
 QQcOgUUZeF2MC9i0oUaHJOIuuN2q+m9eMpnJdxVKAUQcZxDDvNjZwZh+ejsgG4Ejd2XR/T0y
 XFoR/dLFIhf2zxRylN1xq27M9P2t1xfQFocuYToPsVk=
In-Reply-To: <20250816010231.GH3042054@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/08/2025 2.02 am, Boris Burkov wrote:
> On Wed, Aug 13, 2025 at 03:34:58PM +0100, Mark Harmstone wrote:
>> Balancing the REMAP chunk, i.e. the chunk in which the remap tree lives,
>> is a special case.
>>
>> We can't use the remap tree itself for this, as then we'd have no way to
>> boostrap it on mount. And we can't use the pre-remap tree code for this
>> as it relies on walking the extent tree, and we're not creating backrefs
>> for REMAP chunks.
>>
>> So instead, if a balance would relocate any REMAP block groups, mark
>> those block groups as readonly and COW every leaf of the remap tree.
>>
>> There's more sophisticated ways of doing this, such as only COWing nodes
>> within a block group that's to be relocated, but they're fiddly and with
>> lots of edge cases. Plus it's not anticipated that a) the number of
>> REMAP chunks is going to be particularly large, or b) that users will
>> want to only relocate some of these chunks - the main use case here is
>> to unbreak RAID conversion and device removal.
>>
>> Signed-off-by: Mark Harmstone <mark@harmstone.com>
>> ---
>>   fs/btrfs/volumes.c | 161 +++++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 157 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index e13f16a7a904..dc535ed90ae0 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -4011,8 +4011,11 @@ static bool should_balance_chunk(struct extent_buffer *leaf, struct btrfs_chunk
>>   	struct btrfs_balance_args *bargs = NULL;
>>   	u64 chunk_type = btrfs_chunk_type(leaf, chunk);
>>   
>> -	if (chunk_type & BTRFS_BLOCK_GROUP_REMAP)
>> -		return false;
>> +	/* treat REMAP chunks as METADATA */
>> +	if (chunk_type & BTRFS_BLOCK_GROUP_REMAP) {
>> +		chunk_type &= ~BTRFS_BLOCK_GROUP_REMAP;
>> +		chunk_type |= BTRFS_BLOCK_GROUP_METADATA;
> 
> why not honor the REMAP chunk type where appropriate?

This would imply adding a new flag to btrfs balance start, and a new
version of the ioctl, and I'm not sure it's worth it. Happy to argue
the toss though.

Doing btrfs balance start -m already implies -s, so it's not much of
a stretch for to cover REMAP as well.

Possibly it would make more sense for REMAP to be SYSTEM for balancing
purposes rather than METADATA.

>> +	}
>>   
>>   	/* type filter */
>>   	if (!((chunk_type & BTRFS_BLOCK_GROUP_TYPE_MASK) &
>> @@ -4095,6 +4098,113 @@ static bool should_balance_chunk(struct extent_buffer *leaf, struct btrfs_chunk
>>   	return true;
>>   }
>>   
>> +struct remap_chunk_info {
>> +	struct list_head list;
>> +	u64 offset;
>> +	struct btrfs_block_group *bg;
>> +	bool made_ro;
>> +};
>> +
>> +static int cow_remap_tree(struct btrfs_trans_handle *trans,
>> +			  struct btrfs_path *path)
>> +{
>> +	struct btrfs_fs_info *fs_info = trans->fs_info;
>> +	struct btrfs_key key = { 0 };
>> +	int ret;
>> +
>> +	ret = btrfs_search_slot(trans, fs_info->remap_root, &key, path, 0, 1);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	while (true) {
>> +		ret = btrfs_next_leaf(fs_info->remap_root, path);
>> +		if (ret < 0) {
>> +			return ret;
>> +		} else if (ret > 0) {
>> +			ret = 0;
>> +			break;
>> +		}
>> +
>> +		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
>> +
>> +		btrfs_release_path(path);
>> +
>> +		ret = btrfs_search_slot(trans, fs_info->remap_root, &key, path,
>> +					0, 1);
>> +		if (ret < 0)
>> +			break;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int balance_remap_chunks(struct btrfs_fs_info *fs_info,
>> +				struct btrfs_path *path,
>> +				struct list_head *chunks)
>> +{
>> +	struct remap_chunk_info *rci, *tmp;
>> +	struct btrfs_trans_handle *trans;
>> +	int ret;
>> +
>> +	list_for_each_entry_safe(rci, tmp, chunks, list) {
>> +		rci->bg = btrfs_lookup_block_group(fs_info, rci->offset);
>> +		if (!rci->bg) {
>> +			list_del(&rci->list);
>> +			kfree(rci);
>> +			continue;
>> +		}
>> +
>> +		ret = btrfs_inc_block_group_ro(rci->bg, false);
> 
> Just thinking out loud, what happens if we concurrently attempt a
> balance that would need to use the remap tree? Is something structurally
> blocking that at a higher level? Or will it fail? How will that failure
> be handled? Does the answer hold for btrfs-internal background reclaim
> rather than explicit balancing?
> 
>> +		if (ret)
>> +			goto end;
>> +
>> +		rci->made_ro = true;
>> +	}
>> +
>> +	if (list_empty(chunks))
>> +		return 0;
>> +
>> +	trans = btrfs_start_transaction(fs_info->remap_root, 0);
>> +	if (IS_ERR(trans)) {
>> +		ret = PTR_ERR(trans);
>> +		goto end;
>> +	}
>> +
>> +	mutex_lock(&fs_info->remap_mutex);
>> +
>> +	ret = cow_remap_tree(trans, path);
>> +
>> +	btrfs_release_path(path);
>> +
>> +	mutex_unlock(&fs_info->remap_mutex);
>> +
>> +	btrfs_commit_transaction(trans);
>> +
>> +end:
>> +	while (!list_empty(chunks)) {
>> +		bool unused;
>> +
>> +		rci = list_first_entry(chunks, struct remap_chunk_info, list);
>> +
>> +		spin_lock(&rci->bg->lock);
>> +		unused = !btrfs_is_block_group_used(rci->bg);
>> +		spin_unlock(&rci->bg->lock);
>> +
>> +		if (unused)
>> +			btrfs_mark_bg_unused(rci->bg);
>> +
>> +		if (rci->made_ro)
>> +			btrfs_dec_block_group_ro(rci->bg);
>> +
>> +		btrfs_put_block_group(rci->bg);
>> +
>> +		list_del(&rci->list);
>> +		kfree(rci);
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>>   static int __btrfs_balance(struct btrfs_fs_info *fs_info)
>>   {
>>   	struct btrfs_balance_control *bctl = fs_info->balance_ctl;
>> @@ -4117,6 +4227,9 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
>>   	u32 count_meta = 0;
>>   	u32 count_sys = 0;
>>   	int chunk_reserved = 0;
>> +	struct remap_chunk_info *rci;
>> +	unsigned int num_remap_chunks = 0;
>> +	LIST_HEAD(remap_chunks);
>>   
>>   	path = btrfs_alloc_path();
>>   	if (!path) {
>> @@ -4215,7 +4328,8 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
>>   				count_data++;
>>   			else if (chunk_type & BTRFS_BLOCK_GROUP_SYSTEM)
>>   				count_sys++;
>> -			else if (chunk_type & BTRFS_BLOCK_GROUP_METADATA)
>> +			else if (chunk_type & (BTRFS_BLOCK_GROUP_METADATA |
>> +					       BTRFS_BLOCK_GROUP_REMAP))
>>   				count_meta++;
>>   
>>   			goto loop;
>> @@ -4235,6 +4349,30 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
>>   			goto loop;
>>   		}
>>   
>> +		/*
>> +		 * Balancing REMAP chunks takes place separately - add the
>> +		 * details to a list so it can be processed later.
>> +		 */
>> +		if (chunk_type & BTRFS_BLOCK_GROUP_REMAP) {
>> +			mutex_unlock(&fs_info->reclaim_bgs_lock);
>> +
>> +			rci = kmalloc(sizeof(struct remap_chunk_info),
>> +				      GFP_NOFS);
>> +			if (!rci) {
>> +				ret = -ENOMEM;
>> +				goto error;
>> +			}
>> +
>> +			rci->offset = found_key.offset;
>> +			rci->bg = NULL;
>> +			rci->made_ro = false;
>> +			list_add_tail(&rci->list, &remap_chunks);
>> +
>> +			num_remap_chunks++;
>> +
>> +			goto loop;
>> +		}
>> +
>>   		if (!chunk_reserved) {
>>   			/*
>>   			 * We may be relocating the only data chunk we have,
>> @@ -4274,11 +4412,26 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
>>   		key.offset = found_key.offset - 1;
>>   	}
>>   
>> +	btrfs_release_path(path);
>> +
>>   	if (counting) {
>> -		btrfs_release_path(path);
>>   		counting = false;
>>   		goto again;
>>   	}
>> +
>> +	if (!list_empty(&remap_chunks)) {
>> +		ret = balance_remap_chunks(fs_info, path, &remap_chunks);
>> +		if (ret == -ENOSPC)
>> +			enospc_errors++;
>> +
>> +		if (!ret) {
>> +			btrfs_delete_unused_bgs(fs_info);
> 
> Why is this necessary here?
> 
>> +
>> +			spin_lock(&fs_info->balance_lock);
>> +			bctl->stat.completed += num_remap_chunks;
>> +			spin_unlock(&fs_info->balance_lock);
>> +		}
>> +	}
>>   error:
>>   	btrfs_free_path(path);
>>   	if (enospc_errors) {
>> -- 
>> 2.49.1
>>


