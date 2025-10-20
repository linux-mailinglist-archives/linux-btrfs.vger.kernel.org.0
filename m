Return-Path: <linux-btrfs+bounces-18047-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A9025BF0D8C
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 13:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DAC674F1594
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 11:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCAD23D7D2;
	Mon, 20 Oct 2025 11:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="yLVY39T9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (unknown [62.3.69.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880AC242910
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 11:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.3.69.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760959987; cv=none; b=RdBs1BaJ+gTysRSmxRCNTh7qM+gJELhkW/Zyb6H5LAHCyM3Lq74R7WWfDJ75uiyu6q61J0fvxmJTDmM6wWIScm+kGse+T07bOn1F9Sun48VabBw7xMpmDDJNWw4gNx0i3LK+XzzbOmulsVNDdomML9FnqpHgC+Bo7SNk+cb7EMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760959987; c=relaxed/simple;
	bh=f7Yr/SQd/+rjEk83Sf3BqbgI2hmdxiVnGGURqf6eIOc=;
	h=Message-ID:Date:Mime-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RSN4L4gKJRlja2Q4YZtONXpkvveCSYGTsPZXGSrvfBUqe/Fv//ptl8n/q3tcrms2qtbCQ+647UHV1zjGbnwxdADg310jnK7aDa/l0/gf4wOwpHIPUXL58a9YNw1/AjnlFAu8fEguEhITYOF1zocOPAF0xldI5Q9+gzojGNiJ4iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=fail smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=yLVY39T9; arc=none smtp.client-ip=62.3.69.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=harmstone.com
Received: from [IPV6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2] (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id 63B482CD4F8;
	Mon, 20 Oct 2025 12:32:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1760959977;
	bh=1jz1SJBft2z5D28bDPQJjtm+DVCJXTLHIo7uEsiZzVw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=yLVY39T9hY93wA4YpBU0P6KUbp+DwHMLUDUmVwak/mVTQzbXA4tYw+EmTZQFp1c7S
	 8hl4ALSjeX3LCyHEH8RVNhp0CgxRWwulw26MX4E6iYaptAk37wFJtKLjXvxwXXl7aX
	 Nupzq/7Tmw3SYLwkQOvkMQVMa24Ytnu3yYmg2GNo=
Message-ID: <64405423-edf8-4c60-b8f1-4064d1f1d21f@harmstone.com>
Date: Mon, 20 Oct 2025 12:32:57 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v3 07/17] btrfs: allow mounting filesystems with
 remap-tree incompat flag
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <20251009112814.13942-1-mark@harmstone.com>
 <20251009112814.13942-8-mark@harmstone.com>
 <20251015035548.GF1702774@zen.localdomain>
Content-Language: en-US
From: Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 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
In-Reply-To: <20251015035548.GF1702774@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/10/2025 4.55 am, Boris Burkov wrote:
> On Thu, Oct 09, 2025 at 12:28:02PM +0100, Mark Harmstone wrote:
>> If we encounter a filesystem with the remap-tree incompat flag set,
>> valdiate its compatibility with the other flags, and load the remap tree
>> using the values that have been added to the superblock.
>>
>> The remap-tree feature depends on the free space tere, but no-holes and
>> block-group-tree have been made dependencies to reduce the testing
>> matrix. Similarly I'm not aware of any reason why mixed-bg and zoned would be
>> incompatible with remap-tree, but this is blocked for the time being
>> until it can be fully tested.
>>
> 
> Bonus points on offer for moving the open ctree bit as late as humanly
> possible for that good "partial ordering" self documentation. (Or
> explaining why it is already so).
> 
> Thanks.
> 
> Reviewed-by: Boris Burkov <boris@bur.io>
> 
>> Signed-off-by: Mark Harmstone <mark@harmstone.com>
>> ---
>>   fs/btrfs/Kconfig                |   2 +
>>   fs/btrfs/accessors.h            |   6 ++
>>   fs/btrfs/disk-io.c              | 101 ++++++++++++++++++++++++++++----
>>   fs/btrfs/extent-tree.c          |   2 +
>>   fs/btrfs/fs.h                   |   4 +-
>>   fs/btrfs/transaction.c          |   7 +++
>>   include/uapi/linux/btrfs_tree.h |   5 +-
>>   7 files changed, 113 insertions(+), 14 deletions(-)
>>
>> diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
>> index 4438637c8900..77b5a9f27840 100644
>> --- a/fs/btrfs/Kconfig
>> +++ b/fs/btrfs/Kconfig
>> @@ -117,4 +117,6 @@ config BTRFS_EXPERIMENTAL
>>   
>>   	  - large folio support
>>   
>> +	  - remap-tree - logical address remapping tree
>> +
>>   	  If unsure, say N.
>> diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
>> index 0dd161ee6863..392eaad75e72 100644
>> --- a/fs/btrfs/accessors.h
>> +++ b/fs/btrfs/accessors.h
>> @@ -882,6 +882,12 @@ BTRFS_SETGET_STACK_FUNCS(super_uuid_tree_generation, struct btrfs_super_block,
>>   			 uuid_tree_generation, 64);
>>   BTRFS_SETGET_STACK_FUNCS(super_nr_global_roots, struct btrfs_super_block,
>>   			 nr_global_roots, 64);
>> +BTRFS_SETGET_STACK_FUNCS(super_remap_root, struct btrfs_super_block,
>> +			 remap_root, 64);
>> +BTRFS_SETGET_STACK_FUNCS(super_remap_root_generation, struct btrfs_super_block,
>> +			 remap_root_generation, 64);
>> +BTRFS_SETGET_STACK_FUNCS(super_remap_root_level, struct btrfs_super_block,
>> +			 remap_root_level, 8);
>>   
>>   /* struct btrfs_file_extent_item */
>>   BTRFS_SETGET_STACK_FUNCS(stack_file_extent_type, struct btrfs_file_extent_item,
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index 92cb789957b4..60507e971aad 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -1180,6 +1180,8 @@ static struct btrfs_root *btrfs_get_global_root(struct btrfs_fs_info *fs_info,
>>   		return btrfs_grab_root(btrfs_global_root(fs_info, &key));
>>   	case BTRFS_RAID_STRIPE_TREE_OBJECTID:
>>   		return btrfs_grab_root(fs_info->stripe_root);
>> +	case BTRFS_REMAP_TREE_OBJECTID:
>> +		return btrfs_grab_root(fs_info->remap_root);
>>   	default:
>>   		return NULL;
>>   	}
>> @@ -1271,6 +1273,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
>>   	btrfs_put_root(fs_info->data_reloc_root);
>>   	btrfs_put_root(fs_info->block_group_root);
>>   	btrfs_put_root(fs_info->stripe_root);
>> +	btrfs_put_root(fs_info->remap_root);
>>   	btrfs_check_leaked_roots(fs_info);
>>   	btrfs_extent_buffer_leak_debug_check(fs_info);
>>   	kfree(fs_info->super_copy);
>> @@ -1825,6 +1828,7 @@ static void free_root_pointers(struct btrfs_fs_info *info, bool free_chunk_root)
>>   	free_root_extent_buffers(info->data_reloc_root);
>>   	free_root_extent_buffers(info->block_group_root);
>>   	free_root_extent_buffers(info->stripe_root);
>> +	free_root_extent_buffers(info->remap_root);
>>   	if (free_chunk_root)
>>   		free_root_extent_buffers(info->chunk_root);
>>   }
>> @@ -2256,20 +2260,45 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
>>   	if (ret)
>>   		goto out;
>>   
>> -	/*
>> -	 * This tree can share blocks with some other fs tree during relocation
>> -	 * and we need a proper setup by btrfs_get_fs_root
>> -	 */
>> -	root = btrfs_get_fs_root(tree_root->fs_info,
>> -				 BTRFS_DATA_RELOC_TREE_OBJECTID, true);
>> -	if (IS_ERR(root)) {
>> -		if (!btrfs_test_opt(fs_info, IGNOREBADROOTS)) {
>> -			ret = PTR_ERR(root);
>> -			goto out;
>> +	if (btrfs_fs_incompat(fs_info, REMAP_TREE)) {
>> +		/* remap_root already loaded in load_important_roots() */
>> +		root = fs_info->remap_root;
>> +
>> +		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
>> +
>> +		root->root_key.objectid = BTRFS_REMAP_TREE_OBJECTID;
>> +		root->root_key.type = BTRFS_ROOT_ITEM_KEY;
>> +		root->root_key.offset = 0;
>> +
>> +		/* Check that data reloc tree doesn't also exist */
>> +		location.objectid = BTRFS_DATA_RELOC_TREE_OBJECTID;
>> +		root = btrfs_read_tree_root(fs_info->tree_root, &location);
>> +		if (!IS_ERR(root)) {
>> +			btrfs_err(fs_info,
>> +			   "data reloc tree exists when remap-tree enabled");
>> +			btrfs_put_root(root);
>> +			return -EIO;
>> +		} else if (PTR_ERR(root) != -ENOENT) {
>> +			btrfs_warn(fs_info,
>> +			   "error %ld when checking for data reloc tree",
>> +				   PTR_ERR(root));
>>   		}
>>   	} else {
>> -		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
>> -		fs_info->data_reloc_root = root;
>> +		/*
>> +		 * This tree can share blocks with some other fs tree during
>> +		 * relocation and we need a proper setup by btrfs_get_fs_root
>> +		 */
>> +		root = btrfs_get_fs_root(tree_root->fs_info,
>> +					 BTRFS_DATA_RELOC_TREE_OBJECTID, true);
>> +		if (IS_ERR(root)) {
>> +			if (!btrfs_test_opt(fs_info, IGNOREBADROOTS)) {
>> +				ret = PTR_ERR(root);
>> +				goto out;
>> +			}
>> +		} else {
>> +			set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
>> +			fs_info->data_reloc_root = root;
>> +		}
>>   	}
>>   
>>   	location.objectid = BTRFS_QUOTA_TREE_OBJECTID;
>> @@ -2509,6 +2538,31 @@ int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
>>   		ret = -EINVAL;
>>   	}
>>   
>> +	/*
>> +	 * Reduce test matrix for remap tree by requiring block-group-tree
>> +	 * and no-holes. Free-space-tree is a hard requirement.
>> +	 */
>> +	if (btrfs_fs_incompat(fs_info, REMAP_TREE) &&
>> +	    (!btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID) ||
>> +	     !btrfs_fs_incompat(fs_info, NO_HOLES) ||
>> +	     !btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE))) {
>> +		btrfs_err(fs_info,
>> +"remap-tree feature requires free-space-tree, no-holes, and block-group-tree");
>> +		ret = -EINVAL;
>> +	}
>> +
>> +	if (btrfs_fs_incompat(fs_info, REMAP_TREE) &&
>> +	    btrfs_fs_incompat(fs_info, MIXED_GROUPS)) {
>> +		btrfs_err(fs_info, "remap-tree not supported with mixed-bg");
>> +		ret = -EINVAL;
>> +	}
>> +
>> +	if (btrfs_fs_incompat(fs_info, REMAP_TREE) &&
>> +	    btrfs_fs_incompat(fs_info, ZONED)) {
>> +		btrfs_err(fs_info, "remap-tree not supported with zoned devices");
>> +		ret = -EINVAL;
>> +	}
>> +
>>   	/*
>>   	 * Hint to catch really bogus numbers, bitflips or so, more exact checks are
>>   	 * done later
>> @@ -2667,6 +2721,18 @@ static int load_important_roots(struct btrfs_fs_info *fs_info)
>>   		btrfs_warn(fs_info, "couldn't read tree root");
>>   		return ret;
>>   	}
>> +
>> +	if (btrfs_fs_incompat(fs_info, REMAP_TREE)) {
>> +		bytenr = btrfs_super_remap_root(sb);
>> +		gen = btrfs_super_remap_root_generation(sb);
>> +		level = btrfs_super_remap_root_level(sb);
>> +		ret = load_super_root(fs_info->remap_root, bytenr, gen, level);
>> +		if (ret) {
>> +			btrfs_warn(fs_info, "couldn't read remap root");
>> +			return ret;
>> +		}
>> +	}
>> +
>>   	return 0;
>>   }
>>   
>> @@ -3284,6 +3350,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>>   	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
>>   	struct btrfs_root *tree_root;
>>   	struct btrfs_root *chunk_root;
>> +	struct btrfs_root *remap_root;
>>   	int ret;
>>   	int level;
>>   
>> @@ -3417,6 +3484,16 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>>   	if (ret < 0)
>>   		goto fail_alloc;
>>   
>> +	if (btrfs_super_incompat_flags(disk_super) & BTRFS_FEATURE_INCOMPAT_REMAP_TREE) {
>> +		remap_root = btrfs_alloc_root(fs_info, BTRFS_REMAP_TREE_OBJECTID,
>> +					      GFP_KERNEL);
>> +		fs_info->remap_root = remap_root;
>> +		if (!remap_root) {
>> +			ret = -ENOMEM;
>> +			goto fail_alloc;
>> +		}
>> +	}
>> +
> 
> Thanks for scooting it down. Does this need to be before reading the sys
> array / chunk tree? I would guess no, as we can't remap that, but
> perhaps I have misunderstood.

Yes, that's right. The dependency ordering when loading is:

1. System chunks (contained in superblock)
2. Chunk tree (located in system chunks)
3. Remap tree (needs chunk tree to map logicals to physicals, logical address is in superblock)
4. Root tree (may be remapped)
5. All other trees (found in root tree)
>>   	/*
>>   	 * At this point our mount options are validated, if we set ->max_inline
>>   	 * to something non-standard make sure we truncate it to sectorsize.
>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>> index d964147b8097..7805a148bbd8 100644
>> --- a/fs/btrfs/extent-tree.c
>> +++ b/fs/btrfs/extent-tree.c
>> @@ -2589,6 +2589,8 @@ static u64 get_alloc_profile_by_root(struct btrfs_root *root, int data)
>>   		flags = BTRFS_BLOCK_GROUP_DATA;
>>   	else if (root == fs_info->chunk_root)
>>   		flags = BTRFS_BLOCK_GROUP_SYSTEM;
>> +	else if (root == fs_info->remap_root)
>> +		flags = BTRFS_BLOCK_GROUP_REMAP;
>>   	else
>>   		flags = BTRFS_BLOCK_GROUP_METADATA;
>>   
>> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
>> index c4dba7e7ce5a..c76f4c2701f9 100644
>> --- a/fs/btrfs/fs.h
>> +++ b/fs/btrfs/fs.h
>> @@ -291,7 +291,8 @@ enum {
>>   #define BTRFS_FEATURE_INCOMPAT_SUPP		\
>>   	(BTRFS_FEATURE_INCOMPAT_SUPP_STABLE |	\
>>   	 BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE | \
>> -	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2)
>> +	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2 | \
>> +	 BTRFS_FEATURE_INCOMPAT_REMAP_TREE)
>>   
>>   #else
>>   
>> @@ -451,6 +452,7 @@ struct btrfs_fs_info {
>>   	struct btrfs_root *data_reloc_root;
>>   	struct btrfs_root *block_group_root;
>>   	struct btrfs_root *stripe_root;
>> +	struct btrfs_root *remap_root;
>>   
>>   	/* The log root tree is a directory of all the other log roots */
>>   	struct btrfs_root *log_root_tree;
>> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
>> index 89ae0c7a610a..b1c41982e7b2 100644
>> --- a/fs/btrfs/transaction.c
>> +++ b/fs/btrfs/transaction.c
>> @@ -1950,6 +1950,13 @@ static void update_super_roots(struct btrfs_fs_info *fs_info)
>>   		super->cache_generation = 0;
>>   	if (test_bit(BTRFS_FS_UPDATE_UUID_TREE_GEN, &fs_info->flags))
>>   		super->uuid_tree_generation = root_item->generation;
>> +
>> +	if (btrfs_fs_incompat(fs_info, REMAP_TREE)) {
>> +		root_item = &fs_info->remap_root->root_item;
>> +		super->remap_root = root_item->bytenr;
>> +		super->remap_root_generation = root_item->generation;
>> +		super->remap_root_level = root_item->level;
>> +	}
>>   }
>>   
>>   int btrfs_transaction_blocked(struct btrfs_fs_info *info)
>> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
>> index 500e3a7df90b..89bcb80081a6 100644
>> --- a/include/uapi/linux/btrfs_tree.h
>> +++ b/include/uapi/linux/btrfs_tree.h
>> @@ -721,9 +721,12 @@ struct btrfs_super_block {
>>   	__u8 metadata_uuid[BTRFS_FSID_SIZE];
>>   
>>   	__u64 nr_global_roots;
>> +	__le64 remap_root;
>> +	__le64 remap_root_generation;
>> +	__u8 remap_root_level;
>>   
>>   	/* Future expansion */
>> -	__le64 reserved[27];
>> +	__u8 reserved[199];
>>   	__u8 sys_chunk_array[BTRFS_SYSTEM_CHUNK_ARRAY_SIZE];
>>   	struct btrfs_root_backup super_roots[BTRFS_NUM_BACKUP_ROOTS];
>>   
>> -- 
>> 2.49.1
>>


