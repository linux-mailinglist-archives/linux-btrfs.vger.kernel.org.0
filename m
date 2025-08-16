Return-Path: <linux-btrfs+bounces-16103-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A04BB2892C
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Aug 2025 02:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65DD33B9D5D
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Aug 2025 00:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E2F4A0A;
	Sat, 16 Aug 2025 00:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="U/5lCapw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310F2944F
	for <linux-btrfs@vger.kernel.org>; Sat, 16 Aug 2025 00:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755303460; cv=none; b=OnBDw0okqLYhXC0ERW9QNfcO+O9CGdgjBSxpxtPDyORk1zcki6RU05rzfTjywXcrziummEcrxDaj1wflziwspg+opKIpnuPO0UQ++NnCg60IngoBomjfMyzvH9ruK2rqpu9pnJpvnx1CQx+hOOM9BsrktuU2GwwVzswYq10RzG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755303460; c=relaxed/simple;
	bh=vMAHpPovAHdzboJO2fW/+62KRDdoLDDE3+f0l/mf+q0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=u6GYaTu8OLNJs1qUm+JvLfvHqk9R0Us24Z0e7xDLIPVUQlW7N5tBGDTquDdDwiJs2cBx6ZzLLyhQFHLQdqLoS3PKSGhk5Ybj4i8kMYMbY32qC2/3H+kT8kGRb4rSzWD5MPUI04GgN/munQl5TJNx3FUE7Zx2MxsDRlZvE1OH1+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=U/5lCapw; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b9e418ba08so1320982f8f.3
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Aug 2025 17:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755303456; x=1755908256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C7cpU+Sq7nkl06v5TaN6US0zCeb4Uj1XTw0SRJERc9M=;
        b=U/5lCapwfOwlvGA1eLHAegQUeLVQ/yYmM9oosAxJb/vJgLkiOdZ8lOQY49F1vB5SlI
         Ny3YhT7T3fPGnrKtshMdXTNXs342n9tS8ACqDX2xtZZ87dnxT8lB1Rjd3FKgQpsIoJLR
         5LNW/kmK/26ka4tWJJlF8lqbsaSk+f1v9OadqSxpCrtjBwUCRSvC9useSDK/gxzGMB+o
         8oJ/foAE+cLQxyQr83uGudA2dW2gfgX/13WnjJ5bagces1MFsIhv1qIkA0O4MjQ+1XXC
         pIxL3+6U6UyzesHXbWVseMjoZeGdSMhrqs3CDb6bBeINIGmvecTOGsfqRR1B5cyH5UtG
         JA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755303456; x=1755908256;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C7cpU+Sq7nkl06v5TaN6US0zCeb4Uj1XTw0SRJERc9M=;
        b=Pp0DLUWbL0T3UqcMNdHy994ctHlmvw+IhvvpMdTCBW8rvvs9wqdaiMZRpKTwqwQw37
         mqHewnHfs6CZw6AMT47Z0q6SuInqtYOh/G3958niy5mC4/6BKznevLnQa4GnTnHJrYTo
         k3dP7S5s+wPPuouvFhht4unE6upobEHXNCOxQHPjPV/yZK6yOai6zRw1F7w47zrbJJVN
         g27FRakuUwCDW+Ystv/JIL/76Cx1KiagCfyUE/I2zDHHdN9fmETu1iZIqjs2i82fJ82z
         WZ6nmCNPbG3C/dW9CHNaSHdkiiK/72a8sHUzWyR8ONSTlThjlZZnnMBFgy2ikrAGZcaL
         ttLw==
X-Forwarded-Encrypted: i=1; AJvYcCXepKa7eKyVaQeSqzRrWU8yCwu1k31g/UjwyoCKVtBCWepMv+gX4UbPeJcZArxi+xr3P35lbRSRhjocGg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyS7WSlumt9EYNeCIEiqXM6ldxLN0mZS+kFuI6hi5oJtpKmM6p1
	34HuoNncJPwucXgNImIKd5n1W60eSuL/QbjnDurUZbeyN+MfvB+RG3J9BN3J6/ItW90=
X-Gm-Gg: ASbGncue0O0wRkfXiXuSEIStHu3iIPNSV1AKpHX53t1NkgDx5JyuCD0MLpItqQqUm8v
	yW2gG9bBdV7Fbz6eisScMHqjkL9olJ6CHnScwCtC7QUeWM8726uEApuXtQOsrM+aanAyPBl+HXh
	0LUfPI6dCdh+tdcV3EBJp6K9X/PT3NBhfdW4hPyepZfb67c3/XrtLO7wL7iIWcy1bDiw8GSDbvI
	okOYv9tlMbzmiwvQXpQxE7CVuFtR2gbE2ndrUnHKE9K3E+N9KGd9PZkEzgaDy5QsDv/Gmr54tCs
	n1zCg8pn8g6D+JGOqxFj7joKyNGa2bS+NP0eF77Sfzu7S4IcCzmzFMM91o4h1/+ehj3vKQKmbH4
	2VMS57e0n99ZsePEMYK0UQAqFxpm0oUzgMFzqCPuentMgZ7CEjA==
X-Google-Smtp-Source: AGHT+IEMWc7STqonrcUZ16dCXC4m9fCm46FAlpgJKUoFXLqhfaP20tcNWfwa1X3R64ncmDZwbmo4cg==
X-Received: by 2002:a05:6000:230c:b0:3b9:7bf0:88e1 with SMTP id ffacd0b85a97d-3bc6afea986mr672016f8f.56.1755303456247;
        Fri, 15 Aug 2025 17:17:36 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446ca9d99csm23398225ad.24.2025.08.15.17.17.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 17:17:35 -0700 (PDT)
Message-ID: <a7e7460c-5355-45c6-a84b-bbb2492042ed@suse.com>
Date: Sat, 16 Aug 2025 09:47:32 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/16] btrfs: add definitions and constants for
 remap-tree
From: Qu Wenruo <wqu@suse.com>
To: Mark Harmstone <mark@harmstone.com>, linux-btrfs@vger.kernel.org
References: <20250813143509.31073-1-mark@harmstone.com>
 <20250813143509.31073-2-mark@harmstone.com>
 <329f94a3-fef9-4d5f-acb1-362a1dd6ec68@suse.com>
Content-Language: en-US
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <329f94a3-fef9-4d5f-acb1-362a1dd6ec68@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/8/16 09:31, Qu Wenruo 写道:
> 
> 
> 在 2025/8/14 00:04, Mark Harmstone 写道:
>> Add an incompat flag for the new remap-tree feature, and the constants
>> and definitions needed to support it.
>>
>> Signed-off-by: Mark Harmstone <mark@harmstone.com>
>> ---
>>   fs/btrfs/accessors.h            |  3 +++
>>   fs/btrfs/locking.c              |  1 +
>>   fs/btrfs/sysfs.c                |  2 ++
>>   fs/btrfs/tree-checker.c         |  6 ++----
>>   fs/btrfs/tree-checker.h         |  5 +++++
>>   fs/btrfs/volumes.c              |  1 +
>>   include/uapi/linux/btrfs.h      |  1 +
>>   include/uapi/linux/btrfs_tree.h | 12 ++++++++++++
>>   8 files changed, 27 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
>> index 99b3ced12805..95a1ca8c099b 100644
>> --- a/fs/btrfs/accessors.h
>> +++ b/fs/btrfs/accessors.h
>> @@ -1009,6 +1009,9 @@ 
>> BTRFS_SETGET_STACK_FUNCS(stack_verity_descriptor_encryption,
>>   BTRFS_SETGET_STACK_FUNCS(stack_verity_descriptor_size,
>>                struct btrfs_verity_descriptor_item, size, 64);
>> +BTRFS_SETGET_FUNCS(remap_address, struct btrfs_remap, address, 64);
>> +BTRFS_SETGET_STACK_FUNCS(stack_remap_address, struct btrfs_remap, 
>> address, 64);
>> +
>>   /* Cast into the data area of the leaf. */
>>   #define btrfs_item_ptr(leaf, slot, type)                \
>>       ((type *)(btrfs_item_nr_offset(leaf, 0) + 
>> btrfs_item_offset(leaf, slot)))
>> diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
>> index a3e6d9616e60..26f810258486 100644
>> --- a/fs/btrfs/locking.c
>> +++ b/fs/btrfs/locking.c
>> @@ -73,6 +73,7 @@ static struct btrfs_lockdep_keyset {
>>       { .id = BTRFS_FREE_SPACE_TREE_OBJECTID,    DEFINE_NAME("free- 
>> space") },
>>       { .id = BTRFS_BLOCK_GROUP_TREE_OBJECTID, DEFINE_NAME("block- 
>> group") },
>>       { .id = BTRFS_RAID_STRIPE_TREE_OBJECTID, DEFINE_NAME("raid- 
>> stripe") },
>> +    { .id = BTRFS_REMAP_TREE_OBJECTID,      DEFINE_NAME("remap-tree") },
>>       { .id = 0,                DEFINE_NAME("tree")    },
>>   };
>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
>> index 81f52c1f55ce..857d2772db1c 100644
>> --- a/fs/btrfs/sysfs.c
>> +++ b/fs/btrfs/sysfs.c
>> @@ -291,6 +291,7 @@ BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, 
>> FREE_SPACE_TREE);
>>   BTRFS_FEAT_ATTR_COMPAT_RO(block_group_tree, BLOCK_GROUP_TREE);
>>   BTRFS_FEAT_ATTR_INCOMPAT(raid1c34, RAID1C34);
>>   BTRFS_FEAT_ATTR_INCOMPAT(simple_quota, SIMPLE_QUOTA);
>> +BTRFS_FEAT_ATTR_INCOMPAT(remap_tree, REMAP_TREE);
>>   #ifdef CONFIG_BLK_DEV_ZONED
>>   BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);
>>   #endif
>> @@ -325,6 +326,7 @@ static struct attribute 
>> *btrfs_supported_feature_attrs[] = {
>>       BTRFS_FEAT_ATTR_PTR(raid1c34),
>>       BTRFS_FEAT_ATTR_PTR(block_group_tree),
>>       BTRFS_FEAT_ATTR_PTR(simple_quota),
>> +    BTRFS_FEAT_ATTR_PTR(remap_tree),
>>   #ifdef CONFIG_BLK_DEV_ZONED
>>       BTRFS_FEAT_ATTR_PTR(zoned),
>>   #endif
>> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
>> index 0f556f4de3f9..76ec3698f197 100644
>> --- a/fs/btrfs/tree-checker.c
>> +++ b/fs/btrfs/tree-checker.c
>> @@ -912,12 +912,10 @@ int btrfs_check_chunk_valid(const struct 
>> btrfs_fs_info *fs_info,
>>                 length, btrfs_stripe_nr_to_offset(U32_MAX));
>>           return -EUCLEAN;
>>       }
>> -    if (unlikely(type & ~(BTRFS_BLOCK_GROUP_TYPE_MASK |
>> -                  BTRFS_BLOCK_GROUP_PROFILE_MASK))) {
>> +    if (unlikely(type & ~BTRFS_BLOCK_GROUP_VALID)) {
>>           chunk_err(fs_info, leaf, chunk, logical,
>>                 "unrecognized chunk type: 0x%llx",
>> -              ~(BTRFS_BLOCK_GROUP_TYPE_MASK |
>> -                BTRFS_BLOCK_GROUP_PROFILE_MASK) & type);
>> +              type & ~BTRFS_BLOCK_GROUP_VALID);
>>           return -EUCLEAN;
>>       }
>> diff --git a/fs/btrfs/tree-checker.h b/fs/btrfs/tree-checker.h
>> index eb201f4ec3c7..833e2fd989eb 100644
>> --- a/fs/btrfs/tree-checker.h
>> +++ b/fs/btrfs/tree-checker.h
>> @@ -57,6 +57,11 @@ enum btrfs_tree_block_status {
>>       BTRFS_TREE_BLOCK_WRITTEN_NOT_SET,
>>   };
>> +
>> +#define BTRFS_BLOCK_GROUP_VALID    (BTRFS_BLOCK_GROUP_TYPE_MASK | \
>> +                 BTRFS_BLOCK_GROUP_PROFILE_MASK | \
>> +                 BTRFS_BLOCK_GROUP_REMAPPED)
> 
> So far it looks like the remapped flag is a new bg type.
> Can we just put it into BLOCK_GROUP_TYPE_MASK?

Nevermind, we can not put the new type into TYPE_MASK, as tree-checker 
will warn about remapped block groups as they have both METADATA and 
REMAPPED flags set.

So this definition looks good.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> 
> Otherwise looks good to me.
> 
> Thanks,
> Qu
> 
>> +
>>   /*
>>    * Exported simply for btrfs-progs which wants to have the
>>    * btrfs_tree_block_status return codes.
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index fa7a929a0461..e067e9cd68a5 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -231,6 +231,7 @@ void btrfs_describe_block_groups(u64 bg_flags, 
>> char *buf, u32 size_buf)
>>       DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_DATA, "data");
>>       DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_SYSTEM, "system");
>>       DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_METADATA, "metadata");
>> +    DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_REMAPPED, "remapped");
>>       DESCRIBE_FLAG(BTRFS_AVAIL_ALLOC_BIT_SINGLE, "single");
>>       for (i = 0; i < BTRFS_NR_RAID_TYPES; i++)
>> diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
>> index 8e710bbb688e..fba303ed49e6 100644
>> --- a/include/uapi/linux/btrfs.h
>> +++ b/include/uapi/linux/btrfs.h
>> @@ -336,6 +336,7 @@ struct btrfs_ioctl_fs_info_args {
>>   #define BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2    (1ULL << 13)
>>   #define BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE    (1ULL << 14)
>>   #define BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA    (1ULL << 16)
>> +#define BTRFS_FEATURE_INCOMPAT_REMAP_TREE    (1ULL << 17)
>>   struct btrfs_ioctl_feature_flags {
>>       __u64 compat_flags;
>> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/ 
>> btrfs_tree.h
>> index fc29d273845d..4439d77a7252 100644
>> --- a/include/uapi/linux/btrfs_tree.h
>> +++ b/include/uapi/linux/btrfs_tree.h
>> @@ -76,6 +76,9 @@
>>   /* Tracks RAID stripes in block groups. */
>>   #define BTRFS_RAID_STRIPE_TREE_OBJECTID 12ULL
>> +/* Holds details of remapped addresses after relocation. */
>> +#define BTRFS_REMAP_TREE_OBJECTID 13ULL
>> +
>>   /* device stats in the device tree */
>>   #define BTRFS_DEV_STATS_OBJECTID 0ULL
>> @@ -282,6 +285,10 @@
>>   #define BTRFS_RAID_STRIPE_KEY    230
>> +#define BTRFS_IDENTITY_REMAP_KEY     234
>> +#define BTRFS_REMAP_KEY             235
>> +#define BTRFS_REMAP_BACKREF_KEY         236
>> +
>>   /*
>>    * Records the overall state of the qgroups.
>>    * There's only one instance of this key present,
>> @@ -1161,6 +1168,7 @@ struct btrfs_dev_replace_item {
>>   #define BTRFS_BLOCK_GROUP_RAID6         (1ULL << 8)
>>   #define BTRFS_BLOCK_GROUP_RAID1C3       (1ULL << 9)
>>   #define BTRFS_BLOCK_GROUP_RAID1C4       (1ULL << 10)
>> +#define BTRFS_BLOCK_GROUP_REMAPPED      (1ULL << 11)
>>   #define BTRFS_BLOCK_GROUP_RESERVED    (BTRFS_AVAIL_ALLOC_BIT_SINGLE | \
>>                        BTRFS_SPACE_INFO_GLOBAL_RSV)
>> @@ -1323,4 +1331,8 @@ struct btrfs_verity_descriptor_item {
>>       __u8 encryption;
>>   } __attribute__ ((__packed__));
>> +struct btrfs_remap {
>> +    __le64 address;
>> +} __attribute__ ((__packed__));
>> +
>>   #endif /* _BTRFS_CTREE_H_ */
> 
> 


