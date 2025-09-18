Return-Path: <linux-btrfs+bounces-16133-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 915CEB2AF53
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Aug 2025 19:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04ED7189519F
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Aug 2025 17:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9AB34573E;
	Mon, 18 Aug 2025 17:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="y+492tKM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF330271453
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Aug 2025 17:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755537812; cv=none; b=oC1X4xWTn4MlkR6avh8ywoA/3yNubuXom7rkIij3Kxd5bdM3WTxWe/ZLFtP/THEw5pOKz+dzDAQIESKx6pLLr1Bmr6+ETzLkZt993wMxfQW1cYTuQRGRD48O3MpGjuLO1xZ6E6+uw45c0EOyKdZi4RdYFw2jZf0+0eBvGx6HEaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755537812; c=relaxed/simple;
	bh=QzHetNWX43eRuHQX8MGO9LB7qR1NzXt3ZSxBrThIpDQ=;
	h=Message-ID:Date:Mime-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fJGzv+6wniBsfxEtGDoHxwbHBTv8z+YEM4j5+Jwd+qWKs8b6VSRbxfc1iccSHb9nbp70/TuJ/njut2vHT0knQ+dAmsuL0bN/cxCfx+uPXVSO5fn5M0Ya0Hfp3weWUSe5YA+b8G+E+8+ZfZQYvkc6YvHQsdTS+tuYfCvYyQoSFgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=y+492tKM; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from [IPV6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2] (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id 848D42A9CB7;
	Mon, 18 Aug 2025 18:23:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1755537806;
	bh=8dWS+Mq4w3K6PrwxiwVdjAK7LU5m4WniaCtVOaqDTi4=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=y+492tKM0gI5w8caS7mPr6Qvtfd1PDxPKHT5bOPFy7QJreyeU+46fhd2ZNn0OLV1Z
	 zEdYBvvLvndMfC7Mj20jVWvyzSRMnijRrBTJ8Q0rbmSV6Z9vlye9TDkSS8+WfYE2YK
	 /r9IHREzwI/vY0zPX8+16lktKSI19qTbyPI+qnYg=
Message-ID: <8792a8b4-486c-4292-81b2-87c696781d06@harmstone.com>
Date: Mon, 18 Aug 2025 18:23:26 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v2 01/16] btrfs: add definitions and constants for
 remap-tree
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20250813143509.31073-1-mark@harmstone.com>
 <20250813143509.31073-2-mark@harmstone.com>
 <329f94a3-fef9-4d5f-acb1-362a1dd6ec68@suse.com>
 <a7e7460c-5355-45c6-a84b-bbb2492042ed@suse.com>
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
In-Reply-To: <a7e7460c-5355-45c6-a84b-bbb2492042ed@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks Qu. Yes, BTRFS_BLOCK_GROUP_REMAPPED is the block group type,
BTRFS_BLOCK_GROUP_REMAP is the flag saying that you should run any
addresses within this block group through the remap tree.

On 16/08/2025 1.17 am, Qu Wenruo wrote:
> 
> 
> 在 2025/8/16 09:31, Qu Wenruo 写道:
>>
>>
>> 在 2025/8/14 00:04, Mark Harmstone 写道:
>>> Add an incompat flag for the new remap-tree feature, and the constants
>>> and definitions needed to support it.
>>>
>>> Signed-off-by: Mark Harmstone <mark@harmstone.com>
>>> ---
>>>   fs/btrfs/accessors.h            |  3 +++
>>>   fs/btrfs/locking.c              |  1 +
>>>   fs/btrfs/sysfs.c                |  2 ++
>>>   fs/btrfs/tree-checker.c         |  6 ++----
>>>   fs/btrfs/tree-checker.h         |  5 +++++
>>>   fs/btrfs/volumes.c              |  1 +
>>>   include/uapi/linux/btrfs.h      |  1 +
>>>   include/uapi/linux/btrfs_tree.h | 12 ++++++++++++
>>>   8 files changed, 27 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
>>> index 99b3ced12805..95a1ca8c099b 100644
>>> --- a/fs/btrfs/accessors.h
>>> +++ b/fs/btrfs/accessors.h
>>> @@ -1009,6 +1009,9 @@ BTRFS_SETGET_STACK_FUNCS(stack_verity_descriptor_encryption,
>>>   BTRFS_SETGET_STACK_FUNCS(stack_verity_descriptor_size,
>>>                struct btrfs_verity_descriptor_item, size, 64);
>>> +BTRFS_SETGET_FUNCS(remap_address, struct btrfs_remap, address, 64);
>>> +BTRFS_SETGET_STACK_FUNCS(stack_remap_address, struct btrfs_remap, address, 64);
>>> +
>>>   /* Cast into the data area of the leaf. */
>>>   #define btrfs_item_ptr(leaf, slot, type)                \
>>>       ((type *)(btrfs_item_nr_offset(leaf, 0) + btrfs_item_offset(leaf, slot)))
>>> diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
>>> index a3e6d9616e60..26f810258486 100644
>>> --- a/fs/btrfs/locking.c
>>> +++ b/fs/btrfs/locking.c
>>> @@ -73,6 +73,7 @@ static struct btrfs_lockdep_keyset {
>>>       { .id = BTRFS_FREE_SPACE_TREE_OBJECTID,    DEFINE_NAME("free- space") },
>>>       { .id = BTRFS_BLOCK_GROUP_TREE_OBJECTID, DEFINE_NAME("block- group") },
>>>       { .id = BTRFS_RAID_STRIPE_TREE_OBJECTID, DEFINE_NAME("raid- stripe") },
>>> +    { .id = BTRFS_REMAP_TREE_OBJECTID,      DEFINE_NAME("remap-tree") },
>>>       { .id = 0,                DEFINE_NAME("tree")    },
>>>   };
>>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
>>> index 81f52c1f55ce..857d2772db1c 100644
>>> --- a/fs/btrfs/sysfs.c
>>> +++ b/fs/btrfs/sysfs.c
>>> @@ -291,6 +291,7 @@ BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
>>>   BTRFS_FEAT_ATTR_COMPAT_RO(block_group_tree, BLOCK_GROUP_TREE);
>>>   BTRFS_FEAT_ATTR_INCOMPAT(raid1c34, RAID1C34);
>>>   BTRFS_FEAT_ATTR_INCOMPAT(simple_quota, SIMPLE_QUOTA);
>>> +BTRFS_FEAT_ATTR_INCOMPAT(remap_tree, REMAP_TREE);
>>>   #ifdef CONFIG_BLK_DEV_ZONED
>>>   BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);
>>>   #endif
>>> @@ -325,6 +326,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
>>>       BTRFS_FEAT_ATTR_PTR(raid1c34),
>>>       BTRFS_FEAT_ATTR_PTR(block_group_tree),
>>>       BTRFS_FEAT_ATTR_PTR(simple_quota),
>>> +    BTRFS_FEAT_ATTR_PTR(remap_tree),
>>>   #ifdef CONFIG_BLK_DEV_ZONED
>>>       BTRFS_FEAT_ATTR_PTR(zoned),
>>>   #endif
>>> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
>>> index 0f556f4de3f9..76ec3698f197 100644
>>> --- a/fs/btrfs/tree-checker.c
>>> +++ b/fs/btrfs/tree-checker.c
>>> @@ -912,12 +912,10 @@ int btrfs_check_chunk_valid(const struct btrfs_fs_info *fs_info,
>>>                 length, btrfs_stripe_nr_to_offset(U32_MAX));
>>>           return -EUCLEAN;
>>>       }
>>> -    if (unlikely(type & ~(BTRFS_BLOCK_GROUP_TYPE_MASK |
>>> -                  BTRFS_BLOCK_GROUP_PROFILE_MASK))) {
>>> +    if (unlikely(type & ~BTRFS_BLOCK_GROUP_VALID)) {
>>>           chunk_err(fs_info, leaf, chunk, logical,
>>>                 "unrecognized chunk type: 0x%llx",
>>> -              ~(BTRFS_BLOCK_GROUP_TYPE_MASK |
>>> -                BTRFS_BLOCK_GROUP_PROFILE_MASK) & type);
>>> +              type & ~BTRFS_BLOCK_GROUP_VALID);
>>>           return -EUCLEAN;
>>>       }
>>> diff --git a/fs/btrfs/tree-checker.h b/fs/btrfs/tree-checker.h
>>> index eb201f4ec3c7..833e2fd989eb 100644
>>> --- a/fs/btrfs/tree-checker.h
>>> +++ b/fs/btrfs/tree-checker.h
>>> @@ -57,6 +57,11 @@ enum btrfs_tree_block_status {
>>>       BTRFS_TREE_BLOCK_WRITTEN_NOT_SET,
>>>   };
>>> +
>>> +#define BTRFS_BLOCK_GROUP_VALID    (BTRFS_BLOCK_GROUP_TYPE_MASK | \
>>> +                 BTRFS_BLOCK_GROUP_PROFILE_MASK | \
>>> +                 BTRFS_BLOCK_GROUP_REMAPPED)
>>
>> So far it looks like the remapped flag is a new bg type.
>> Can we just put it into BLOCK_GROUP_TYPE_MASK?
> 
> Nevermind, we can not put the new type into TYPE_MASK, as tree-checker will warn about remapped block groups as they have both METADATA and REMAPPED flags set.
> 
> So this definition looks good.
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 
> Thanks,
> Qu
> 
>>
>> Otherwise looks good to me.
>>
>> Thanks,
>> Qu
>>
>>> +
>>>   /*
>>>    * Exported simply for btrfs-progs which wants to have the
>>>    * btrfs_tree_block_status return codes.
>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>> index fa7a929a0461..e067e9cd68a5 100644
>>> --- a/fs/btrfs/volumes.c
>>> +++ b/fs/btrfs/volumes.c
>>> @@ -231,6 +231,7 @@ void btrfs_describe_block_groups(u64 bg_flags, char *buf, u32 size_buf)
>>>       DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_DATA, "data");
>>>       DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_SYSTEM, "system");
>>>       DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_METADATA, "metadata");
>>> +    DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_REMAPPED, "remapped");
>>>       DESCRIBE_FLAG(BTRFS_AVAIL_ALLOC_BIT_SINGLE, "single");
>>>       for (i = 0; i < BTRFS_NR_RAID_TYPES; i++)
>>> diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
>>> index 8e710bbb688e..fba303ed49e6 100644
>>> --- a/include/uapi/linux/btrfs.h
>>> +++ b/include/uapi/linux/btrfs.h
>>> @@ -336,6 +336,7 @@ struct btrfs_ioctl_fs_info_args {
>>>   #define BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2    (1ULL << 13)
>>>   #define BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE    (1ULL << 14)
>>>   #define BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA    (1ULL << 16)
>>> +#define BTRFS_FEATURE_INCOMPAT_REMAP_TREE    (1ULL << 17)
>>>   struct btrfs_ioctl_feature_flags {
>>>       __u64 compat_flags;
>>> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/ btrfs_tree.h
>>> index fc29d273845d..4439d77a7252 100644
>>> --- a/include/uapi/linux/btrfs_tree.h
>>> +++ b/include/uapi/linux/btrfs_tree.h
>>> @@ -76,6 +76,9 @@
>>>   /* Tracks RAID stripes in block groups. */
>>>   #define BTRFS_RAID_STRIPE_TREE_OBJECTID 12ULL
>>> +/* Holds details of remapped addresses after relocation. */
>>> +#define BTRFS_REMAP_TREE_OBJECTID 13ULL
>>> +
>>>   /* device stats in the device tree */
>>>   #define BTRFS_DEV_STATS_OBJECTID 0ULL
>>> @@ -282,6 +285,10 @@
>>>   #define BTRFS_RAID_STRIPE_KEY    230
>>> +#define BTRFS_IDENTITY_REMAP_KEY     234
>>> +#define BTRFS_REMAP_KEY             235
>>> +#define BTRFS_REMAP_BACKREF_KEY         236
>>> +
>>>   /*
>>>    * Records the overall state of the qgroups.
>>>    * There's only one instance of this key present,
>>> @@ -1161,6 +1168,7 @@ struct btrfs_dev_replace_item {
>>>   #define BTRFS_BLOCK_GROUP_RAID6         (1ULL << 8)
>>>   #define BTRFS_BLOCK_GROUP_RAID1C3       (1ULL << 9)
>>>   #define BTRFS_BLOCK_GROUP_RAID1C4       (1ULL << 10)
>>> +#define BTRFS_BLOCK_GROUP_REMAPPED      (1ULL << 11)
>>>   #define BTRFS_BLOCK_GROUP_RESERVED    (BTRFS_AVAIL_ALLOC_BIT_SINGLE | \
>>>                        BTRFS_SPACE_INFO_GLOBAL_RSV)
>>> @@ -1323,4 +1331,8 @@ struct btrfs_verity_descriptor_item {
>>>       __u8 encryption;
>>>   } __attribute__ ((__packed__));
>>> +struct btrfs_remap {
>>> +    __le64 address;
>>> +} __attribute__ ((__packed__));
>>> +
>>>   #endif /* _BTRFS_CTREE_H_ */
>>
>>
> 


