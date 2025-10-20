Return-Path: <linux-btrfs+bounces-18042-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E99BF059E
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 11:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0FB5189407B
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 09:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7AB2F6173;
	Mon, 20 Oct 2025 09:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="SP7aenWC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (unknown [62.3.69.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37742F5A1E
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 09:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.3.69.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760954350; cv=none; b=sVgbANwNh5Q4utT6Gssunzwy/na/kaTctL2BjPkdzsTAY7dMgbPFqmPeAamkTgPqazxyqA5BhT6AzfuLb3qa4KONLxgCna41BAaHl0nZsq+gL0v4PN4qFRGVdoakOhYVXsFU/InGk5B3srSjgeVXFJnMABQMa8q14HkgHDtTcPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760954350; c=relaxed/simple;
	bh=nKawjlMuowq0dyjjSSeqMfJqDM8ONIlQ+sRunvkVmYM=;
	h=Message-ID:Date:Mime-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lYhYDLXrKzS5dGibps7ffa0V2iRpHyfoPUA484al8ba6+uJWnmzL8LmLMNIJ+yOi1u/d2mBfpQUXbc4EuPxX+DoSFvCQZKXaQv1ZRG/BAruuX+jRTNrFnBQbbEov3HFk6I09/dFscojwz67AwFTnqoAsLmjVxRjcuOZvpC8ycoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=fail smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=SP7aenWC; arc=none smtp.client-ip=62.3.69.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=harmstone.com
Received: from [IPV6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2] (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id 0C9222CD40F;
	Mon, 20 Oct 2025 10:58:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1760954336;
	bh=UgV+I+4d3oo5ItWcU1Rpt1EhKakEML5j/GHLKpa89qk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=SP7aenWCmLLF0EA1OcatcRG8OY1eE8CYmFWpzQQFYwy1DymQJW+pgIFSmMfALus+H
	 T4Jz+W34XUhcZaudRRZEoNrmI9mGGbIAyWfRRd9g6wSu7ZG08r437ASXVBHpIjLjjr
	 y66fHy2kTMaKBeCxxiDqJbTFYPuE8giVdJGIOwCQ=
Message-ID: <7a6877f7-371b-4421-a1c7-91bf3a46e91d@harmstone.com>
Date: Mon, 20 Oct 2025 10:58:55 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v3 02/17] btrfs: add REMAP chunk type
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <20251009112814.13942-1-mark@harmstone.com>
 <20251009112814.13942-3-mark@harmstone.com>
 <20251015033707.GD1702774@zen.localdomain>
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
In-Reply-To: <20251015033707.GD1702774@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks Boris. Have a look at the third paragraph of the commit message, I
explain the volumes.h changes there.

On 15/10/2025 4.37 am, Boris Burkov wrote:
> On Thu, Oct 09, 2025 at 12:27:57PM +0100, Mark Harmstone wrote:
>> Add a new REMAP chunk type, which is a metadata chunk that holds the
>> remap tree.
>>
>> This is needed for bootstrapping purposes: the remap tree can't itself
>> be remapped, and must be relocated the existing way, by COWing every
>> leaf. The remap tree can't go in the SYSTEM chunk as space there is
>> limited, because a copy of the chunk item gets placed in the superblock.
>>
>> The changes in fs/btrfs/volumes.h are because we're adding a new block
>> group type bit after the profile bits, and so can no longer rely on the
>> const_ilog2 trick.
>>
>> The sizing to 32MB per chunk, matching the SYSTEM chunk, is an estimate
>> here, we can adjust it later if it proves to be too big or too small.
>> This works out to be ~500,000 remap items, which for a 4KB block size
>> covers ~2GB of remapped data in the worst case and ~500TB in the best case.
>>
> 
> Asked a relatively inconsequential question about static asserts in
> volumes.h. Otherwise,
> 
> Reviewed-by: Boris Burkov <boris@bur.io>
> 
>> Signed-off-by: Mark Harmstone <mark@harmstone.com>
>> ---
>>   fs/btrfs/block-rsv.c            |  8 ++++++++
>>   fs/btrfs/block-rsv.h            |  1 +
>>   fs/btrfs/disk-io.c              |  1 +
>>   fs/btrfs/fs.h                   |  2 ++
>>   fs/btrfs/space-info.c           | 13 ++++++++++++-
>>   fs/btrfs/sysfs.c                |  2 ++
>>   fs/btrfs/tree-checker.c         | 13 +++++++++++--
>>   fs/btrfs/volumes.c              |  3 +++
>>   fs/btrfs/volumes.h              | 11 +++++++++--
>>   include/uapi/linux/btrfs_tree.h |  4 +++-
>>   10 files changed, 52 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
>> index 5ad6de738aee..2678cd3bed29 100644
>> --- a/fs/btrfs/block-rsv.c
>> +++ b/fs/btrfs/block-rsv.c
>> @@ -421,6 +421,9 @@ void btrfs_init_root_block_rsv(struct btrfs_root *root)
>>   	case BTRFS_TREE_LOG_OBJECTID:
>>   		root->block_rsv = &fs_info->treelog_rsv;
>>   		break;
>> +	case BTRFS_REMAP_TREE_OBJECTID:
>> +		root->block_rsv = &fs_info->remap_block_rsv;
>> +		break;
>>   	default:
>>   		root->block_rsv = NULL;
>>   		break;
>> @@ -434,6 +437,9 @@ void btrfs_init_global_block_rsv(struct btrfs_fs_info *fs_info)
>>   	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_SYSTEM);
>>   	fs_info->chunk_block_rsv.space_info = space_info;
>>   
>> +	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_REMAP);
>> +	fs_info->remap_block_rsv.space_info = space_info;
>> +
>>   	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
>>   	fs_info->global_block_rsv.space_info = space_info;
>>   	fs_info->trans_block_rsv.space_info = space_info;
>> @@ -460,6 +466,8 @@ void btrfs_release_global_block_rsv(struct btrfs_fs_info *fs_info)
>>   	WARN_ON(fs_info->trans_block_rsv.reserved > 0);
>>   	WARN_ON(fs_info->chunk_block_rsv.size > 0);
>>   	WARN_ON(fs_info->chunk_block_rsv.reserved > 0);
>> +	WARN_ON(fs_info->remap_block_rsv.size > 0);
>> +	WARN_ON(fs_info->remap_block_rsv.reserved > 0);
>>   	WARN_ON(fs_info->delayed_block_rsv.size > 0);
>>   	WARN_ON(fs_info->delayed_block_rsv.reserved > 0);
>>   	WARN_ON(fs_info->delayed_refs_rsv.reserved > 0);
>> diff --git a/fs/btrfs/block-rsv.h b/fs/btrfs/block-rsv.h
>> index 79ae9d05cd91..8359fb96bc3c 100644
>> --- a/fs/btrfs/block-rsv.h
>> +++ b/fs/btrfs/block-rsv.h
>> @@ -22,6 +22,7 @@ enum btrfs_rsv_type {
>>   	BTRFS_BLOCK_RSV_DELALLOC,
>>   	BTRFS_BLOCK_RSV_TRANS,
>>   	BTRFS_BLOCK_RSV_CHUNK,
>> +	BTRFS_BLOCK_RSV_REMAP,
>>   	BTRFS_BLOCK_RSV_DELOPS,
>>   	BTRFS_BLOCK_RSV_DELREFS,
>>   	BTRFS_BLOCK_RSV_TREELOG,
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index f475fb2272ac..102e5e0ad10c 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -2815,6 +2815,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
>>   			     BTRFS_BLOCK_RSV_GLOBAL);
>>   	btrfs_init_block_rsv(&fs_info->trans_block_rsv, BTRFS_BLOCK_RSV_TRANS);
>>   	btrfs_init_block_rsv(&fs_info->chunk_block_rsv, BTRFS_BLOCK_RSV_CHUNK);
>> +	btrfs_init_block_rsv(&fs_info->remap_block_rsv, BTRFS_BLOCK_RSV_REMAP);
>>   	btrfs_init_block_rsv(&fs_info->treelog_rsv, BTRFS_BLOCK_RSV_TREELOG);
>>   	btrfs_init_block_rsv(&fs_info->empty_block_rsv, BTRFS_BLOCK_RSV_EMPTY);
>>   	btrfs_init_block_rsv(&fs_info->delayed_block_rsv,
>> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
>> index 814bbc9417d2..c4dba7e7ce5a 100644
>> --- a/fs/btrfs/fs.h
>> +++ b/fs/btrfs/fs.h
>> @@ -485,6 +485,8 @@ struct btrfs_fs_info {
>>   	struct btrfs_block_rsv trans_block_rsv;
>>   	/* Block reservation for chunk tree */
>>   	struct btrfs_block_rsv chunk_block_rsv;
>> +	/* Block reservation for remap tree */
>> +	struct btrfs_block_rsv remap_block_rsv;
>>   	/* Block reservation for delayed operations */
>>   	struct btrfs_block_rsv delayed_block_rsv;
>>   	/* Block reservation for delayed refs */
>> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
>> index 04a07d6f8537..22bc95f33a6f 100644
>> --- a/fs/btrfs/space-info.c
>> +++ b/fs/btrfs/space-info.c
>> @@ -215,7 +215,7 @@ static u64 calc_chunk_size(const struct btrfs_fs_info *fs_info, u64 flags)
>>   
>>   	if (flags & BTRFS_BLOCK_GROUP_DATA)
>>   		return BTRFS_MAX_DATA_CHUNK_SIZE;
>> -	else if (flags & BTRFS_BLOCK_GROUP_SYSTEM)
>> +	else if (flags & (BTRFS_BLOCK_GROUP_SYSTEM | BTRFS_BLOCK_GROUP_REMAP))
>>   		return SZ_32M;
>>   
>>   	/* Handle BTRFS_BLOCK_GROUP_METADATA */
>> @@ -343,6 +343,8 @@ int btrfs_init_space_info(struct btrfs_fs_info *fs_info)
>>   	if (mixed) {
>>   		flags = BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_DATA;
>>   		ret = create_space_info(fs_info, flags);
>> +		if (ret)
>> +			goto out;
>>   	} else {
>>   		flags = BTRFS_BLOCK_GROUP_METADATA;
>>   		ret = create_space_info(fs_info, flags);
>> @@ -351,7 +353,15 @@ int btrfs_init_space_info(struct btrfs_fs_info *fs_info)
>>   
>>   		flags = BTRFS_BLOCK_GROUP_DATA;
>>   		ret = create_space_info(fs_info, flags);
>> +		if (ret)
>> +			goto out;
>> +	}
>> +
>> +	if (features & BTRFS_FEATURE_INCOMPAT_REMAP_TREE) {
>> +		flags = BTRFS_BLOCK_GROUP_REMAP;
>> +		ret = create_space_info(fs_info, flags);
>>   	}
>> +
>>   out:
>>   	return ret;
>>   }
>> @@ -590,6 +600,7 @@ static void dump_global_block_rsv(struct btrfs_fs_info *fs_info)
>>   	DUMP_BLOCK_RSV(fs_info, global_block_rsv);
>>   	DUMP_BLOCK_RSV(fs_info, trans_block_rsv);
>>   	DUMP_BLOCK_RSV(fs_info, chunk_block_rsv);
>> +	DUMP_BLOCK_RSV(fs_info, remap_block_rsv);
>>   	DUMP_BLOCK_RSV(fs_info, delayed_block_rsv);
>>   	DUMP_BLOCK_RSV(fs_info, delayed_refs_rsv);
>>   }
>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
>> index 857d2772db1c..f942fde1d936 100644
>> --- a/fs/btrfs/sysfs.c
>> +++ b/fs/btrfs/sysfs.c
>> @@ -1973,6 +1973,8 @@ static const char *alloc_name(struct btrfs_space_info *space_info)
>>   	case BTRFS_BLOCK_GROUP_SYSTEM:
>>   		ASSERT(space_info->subgroup_id == BTRFS_SUB_GROUP_PRIMARY);
>>   		return "system";
>> +	case BTRFS_BLOCK_GROUP_REMAP:
>> +		return "remap";
>>   	default:
>>   		WARN_ON(1);
>>   		return "invalid-combination";
>> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
>> index 9c03aeb6f2c7..62f35338a555 100644
>> --- a/fs/btrfs/tree-checker.c
>> +++ b/fs/btrfs/tree-checker.c
>> @@ -748,17 +748,26 @@ static int check_block_group_item(struct extent_buffer *leaf,
>>   		return -EUCLEAN;
>>   	}
>>   
>> +	if (flags & BTRFS_BLOCK_GROUP_REMAP &&
>> +		!btrfs_fs_incompat(fs_info, REMAP_TREE)) {
>> +		block_group_err(leaf, slot,
>> +"invalid flags, have 0x%llx (REMAP flag set) but no remap-tree incompat flag",
>> +				flags);
>> +		return -EUCLEAN;
>> +	}
>> +
>>   	type = flags & BTRFS_BLOCK_GROUP_TYPE_MASK;
>>   	if (unlikely(type != BTRFS_BLOCK_GROUP_DATA &&
>>   		     type != BTRFS_BLOCK_GROUP_METADATA &&
>>   		     type != BTRFS_BLOCK_GROUP_SYSTEM &&
>> +		     type != BTRFS_BLOCK_GROUP_REMAP &&
>>   		     type != (BTRFS_BLOCK_GROUP_METADATA |
>>   			      BTRFS_BLOCK_GROUP_DATA))) {
>>   		block_group_err(leaf, slot,
>> -"invalid type, have 0x%llx (%lu bits set) expect either 0x%llx, 0x%llx, 0x%llx or 0x%llx",
>> +"invalid type, have 0x%llx (%lu bits set) expect either 0x%llx, 0x%llx, 0x%llx, 0x%llx or 0x%llx",
>>   			type, hweight64(type),
>>   			BTRFS_BLOCK_GROUP_DATA, BTRFS_BLOCK_GROUP_METADATA,
>> -			BTRFS_BLOCK_GROUP_SYSTEM,
>> +			BTRFS_BLOCK_GROUP_SYSTEM, BTRFS_BLOCK_GROUP_REMAP,
>>   			BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_DATA);
>>   		return -EUCLEAN;
>>   	}
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 2e144ebd56ac..e14b86e2996b 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -231,6 +231,9 @@ void btrfs_describe_block_groups(u64 bg_flags, char *buf, u32 size_buf)
>>   	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_DATA, "data");
>>   	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_SYSTEM, "system");
>>   	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_METADATA, "metadata");
>> +	/* block groups containing the remap tree */
>> +	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_REMAP, "remap");
>> +	/* block group that has been remapped */
>>   	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_REMAPPED, "remapped");
>>   
>>   	DESCRIBE_FLAG(BTRFS_AVAIL_ALLOC_BIT_SINGLE, "single");
>> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
>> index 2cbf8080eade..b0fa8eb38060 100644
>> --- a/fs/btrfs/volumes.h
>> +++ b/fs/btrfs/volumes.h
>> @@ -58,8 +58,6 @@ static_assert(const_ilog2(BTRFS_STRIPE_LEN) == BTRFS_STRIPE_LEN_SHIFT);
>>    */
>>   static_assert(const_ffs(BTRFS_BLOCK_GROUP_RAID0) <
>>   	      const_ffs(BTRFS_BLOCK_GROUP_PROFILE_MASK & ~BTRFS_BLOCK_GROUP_RAID0));
>> -static_assert(const_ilog2(BTRFS_BLOCK_GROUP_RAID0) >
>> -	      ilog2(BTRFS_BLOCK_GROUP_TYPE_MASK));
>>   
>>   /* ilog2() can handle both constants and variables */
>>   #define BTRFS_BG_FLAG_TO_INDEX(profile)					\
>> @@ -81,6 +79,15 @@ enum btrfs_raid_types {
>>   	BTRFS_NR_RAID_TYPES
>>   };
>>   
>> +static_assert(BTRFS_RAID_RAID0 == 1);
>> +static_assert(BTRFS_RAID_RAID1 == 2);
>> +static_assert(BTRFS_RAID_DUP == 3);
>> +static_assert(BTRFS_RAID_RAID10 == 4);
>> +static_assert(BTRFS_RAID_RAID5 == 5);
>> +static_assert(BTRFS_RAID_RAID6 == 6);
>> +static_assert(BTRFS_RAID_RAID1C3 == 7);
>> +static_assert(BTRFS_RAID_RAID1C4 == 8);
>> +
> 
> What is the significance of these static_assert changes?
> 
>>   /*
>>    * Use sequence counter to get consistent device stat data on
>>    * 32-bit processors.
>> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
>> index 4439d77a7252..9a36f0206d90 100644
>> --- a/include/uapi/linux/btrfs_tree.h
>> +++ b/include/uapi/linux/btrfs_tree.h
>> @@ -1169,12 +1169,14 @@ struct btrfs_dev_replace_item {
>>   #define BTRFS_BLOCK_GROUP_RAID1C3       (1ULL << 9)
>>   #define BTRFS_BLOCK_GROUP_RAID1C4       (1ULL << 10)
>>   #define BTRFS_BLOCK_GROUP_REMAPPED      (1ULL << 11)
>> +#define BTRFS_BLOCK_GROUP_REMAP         (1ULL << 12)
>>   #define BTRFS_BLOCK_GROUP_RESERVED	(BTRFS_AVAIL_ALLOC_BIT_SINGLE | \
>>   					 BTRFS_SPACE_INFO_GLOBAL_RSV)
>>   
>>   #define BTRFS_BLOCK_GROUP_TYPE_MASK	(BTRFS_BLOCK_GROUP_DATA |    \
>>   					 BTRFS_BLOCK_GROUP_SYSTEM |  \
>> -					 BTRFS_BLOCK_GROUP_METADATA)
>> +					 BTRFS_BLOCK_GROUP_METADATA | \
>> +					 BTRFS_BLOCK_GROUP_REMAP)
>>   
>>   #define BTRFS_BLOCK_GROUP_PROFILE_MASK	(BTRFS_BLOCK_GROUP_RAID0 |   \
>>   					 BTRFS_BLOCK_GROUP_RAID1 |   \
>> -- 
>> 2.49.1
>>


