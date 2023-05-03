Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B136F4F19
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 05:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjECDRu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 23:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjECDRs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 23:17:48 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E2B3C0A
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 20:17:25 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N7iCg-1qGPBR40P4-014kmL; Wed, 03
 May 2023 05:17:16 +0200
Message-ID: <c10a17cb-506a-2540-eb19-c79c6c00f788@gmx.com>
Date:   Wed, 3 May 2023 11:17:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/9] btrfs: track original extent subvol in a new inline
 ref
Content-Language: en-US
To:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1683075170.git.boris@bur.io>
 <7a4b78e240d2f26eb3d7be82d4c0b8ddaa409519.1683075170.git.boris@bur.io>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <7a4b78e240d2f26eb3d7be82d4c0b8ddaa409519.1683075170.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:dcVIzTx90zsjYAvCD5gR4/nwQy3mfQez+e4bAi8Cn4ryJFesPTy
 TxEDUf3YQY9VeguQ0+e9C3zF1TLNSaic0ATaY3T9tdLZF7Yzh74joEfgF9tZyK2PNXHcKXt
 b/rqLt1Jy7Rw/rVleptTD2TI+WmBKC5gdw0dLZFZ9FE11SpZIl0JukxKL+MClDGH2k9i/EO
 bx6hXQhs7W9pEWlhMmwOA==
UI-OutboundReport: notjunk:1;M01:P0:6kyDPNO4zZw=;ajwg0XsK0K/X28zrSe9lVKKGNG6
 +K2k7vpxvOEnlv0zYl0wE7Z/332Y74QGtGvBcgsnWQ+cXgfBaGovvzIX4dFlWrU6MScZSMuvh
 LX8eHT9EN1+k4uaMqqlvYrQQ8T0huERODJoPZgu8hwoO4KG8Jd7Q68P+B84od1+91GfNYjTsw
 o4E61pNrbEgpqRRdoEbKQXOHcfqCR7t56rBT9FlcZUVrBN1jDMgKdG88hD/5ndIrfrrp+Rw3r
 J2UTck/DLwTGv7Rcbxw2NG9sj8BikNZb6nesoi9FAaOfYRNDZAVwu0qxqbuiDueKvSb/mFql+
 Ovbxka4g9Zxs/ls9Ou6UO6N2kkqRLG803ytIBt2K5eaNpcshZJ0fbUtEs6a1xNWI7ZnCf/c4v
 nkjeSTuc3tIXJ2Krp36cXonodBNKjH5iLs9n6EO0v520GSyLWTwiIxCTXLZSHNyyGP9JiAe8D
 Rcb3P/3xu7uduuyOYSPhViT3Y/TJacB3kJvY6trHm2DePTBQgTax/Q0yeXGHut8c85AZ5wJK2
 s59HWOlc5GNniftl48kiqITbZMY2RCEQyESPP3iI/ESDgBaOT1ZHv+V6bT4gYtbfC4MAVfAJ9
 7/vMga5vH8ffHPgQfofCCRX+diZH4S5VQd+JuG/GO2WzyPGbguCSY4BBn2cNiaKjEdr0imv55
 22NXjk5KdCjwvr6ULb2QkJbCFI4j0M6lahRdsxfozp5569vixGdsnbVZlRxC4fEZpn5FPpCCD
 BxYra/+yy8geI8BZsXs7p9GkGMVLouBOYOjKGZ9ZsD4EmqId3B5vj4mfpmeoMT+FVUb78hG+I
 brmBXbKGXqgR6iBejRtKRwchsoElkYk2HP9wr+X7xU8WIF8nbEx6VHwDyIgD2ttaLTRz4oRXf
 jw8Bb4pkKSuR0zzUYkj7ogKF9wQEqQBR/IbUxGTER8uxbwD6pz0EpZQN+e6MulrQxfvWOKaS9
 6XmmXZdb0kvKLZ4k3kVCxPl+FWY=
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/3 08:59, Boris Burkov wrote:
> In order to implement simple quota groups, we need to be able to
> associate a data extent with the subvolume that created it. Once you
> account for reflink, this information cannot be recovered without
> explicitly storing it. Options for storing it are:
> - a new key/item
> - a new extent inline ref item
> 
> The former is backwards compatible, but wastes space, the latter is
> incompat, but is efficient in space and reuses the existing inline ref
> machinery, while only abusing it a tiny amount -- specifically, the new
> item is not a ref, per-se.

Even we introduce new extent tree items, we can still mark the fs compat_ro.

As long as we don't do any writes, we can still read the fs without any 
compatibility problem, and the enable/disable should be addressed by 
btrfstune/mkfs anyway.

Thanks,
Qu
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>   fs/btrfs/accessors.h            |  4 +++
>   fs/btrfs/backref.c              |  3 ++
>   fs/btrfs/extent-tree.c          | 50 +++++++++++++++++++++++++--------
>   fs/btrfs/print-tree.c           | 12 ++++++++
>   fs/btrfs/ref-verify.c           |  3 ++
>   fs/btrfs/tree-checker.c         |  3 ++
>   include/uapi/linux/btrfs_tree.h |  6 ++++
>   7 files changed, 70 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
> index ceadfc5d6c66..aab61312e4e8 100644
> --- a/fs/btrfs/accessors.h
> +++ b/fs/btrfs/accessors.h
> @@ -350,6 +350,8 @@ BTRFS_SETGET_FUNCS(extent_data_ref_count, struct btrfs_extent_data_ref, count, 3
>   
>   BTRFS_SETGET_FUNCS(shared_data_ref_count, struct btrfs_shared_data_ref, count, 32);
>   
> +BTRFS_SETGET_FUNCS(extent_owner_ref_root_id, struct btrfs_extent_owner_ref, root_id, 64);
> +
>   BTRFS_SETGET_FUNCS(extent_inline_ref_type, struct btrfs_extent_inline_ref,
>   		   type, 8);
>   BTRFS_SETGET_FUNCS(extent_inline_ref_offset, struct btrfs_extent_inline_ref,
> @@ -366,6 +368,8 @@ static inline u32 btrfs_extent_inline_ref_size(int type)
>   	if (type == BTRFS_EXTENT_DATA_REF_KEY)
>   		return sizeof(struct btrfs_extent_data_ref) +
>   		       offsetof(struct btrfs_extent_inline_ref, offset);
> +	if (type == BTRFS_EXTENT_OWNER_REF_KEY)
> +		return sizeof(struct btrfs_extent_inline_ref);
>   	return 0;
>   }
>   
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index e54f0884802a..8cd8ed6c572f 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -1128,6 +1128,9 @@ static int add_inline_refs(struct btrfs_backref_walk_ctx *ctx,
>   						       count, sc, GFP_NOFS);
>   			break;
>   		}
> +		case BTRFS_EXTENT_OWNER_REF_KEY:
> +			WARN_ON(!btrfs_fs_incompat(ctx->fs_info, SIMPLE_QUOTA));
> +			break;
>   		default:
>   			WARN_ON(1);
>   		}
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 5cd289de4e92..b9a2f1e355b7 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -363,9 +363,13 @@ int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
>   				     struct btrfs_extent_inline_ref *iref,
>   				     enum btrfs_inline_ref_type is_data)
>   {
> +	struct btrfs_fs_info *fs_info = eb->fs_info;
>   	int type = btrfs_extent_inline_ref_type(eb, iref);
>   	u64 offset = btrfs_extent_inline_ref_offset(eb, iref);
>   
> +	if (type == BTRFS_EXTENT_OWNER_REF_KEY && btrfs_fs_incompat(fs_info, SIMPLE_QUOTA))
> +		return type;
> +
>   	if (type == BTRFS_TREE_BLOCK_REF_KEY ||
>   	    type == BTRFS_SHARED_BLOCK_REF_KEY ||
>   	    type == BTRFS_SHARED_DATA_REF_KEY ||
> @@ -374,26 +378,25 @@ int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
>   			if (type == BTRFS_TREE_BLOCK_REF_KEY)
>   				return type;
>   			if (type == BTRFS_SHARED_BLOCK_REF_KEY) {
> -				ASSERT(eb->fs_info);
> +				ASSERT(fs_info);
>   				/*
>   				 * Every shared one has parent tree block,
>   				 * which must be aligned to sector size.
>   				 */
> -				if (offset &&
> -				    IS_ALIGNED(offset, eb->fs_info->sectorsize))
> +				if (offset && IS_ALIGNED(offset, fs_info->sectorsize))
>   					return type;
>   			}
>   		} else if (is_data == BTRFS_REF_TYPE_DATA) {
>   			if (type == BTRFS_EXTENT_DATA_REF_KEY)
>   				return type;
>   			if (type == BTRFS_SHARED_DATA_REF_KEY) {
> -				ASSERT(eb->fs_info);
> +				ASSERT(fs_info);
>   				/*
>   				 * Every shared one has parent tree block,
>   				 * which must be aligned to sector size.
>   				 */
>   				if (offset &&
> -				    IS_ALIGNED(offset, eb->fs_info->sectorsize))
> +				    IS_ALIGNED(offset, fs_info->sectorsize))
>   					return type;
>   			}
>   		} else {
> @@ -403,7 +406,7 @@ int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
>   	}
>   
>   	btrfs_print_leaf((struct extent_buffer *)eb);
> -	btrfs_err(eb->fs_info,
> +	btrfs_err(fs_info,
>   		  "eb %llu iref 0x%lx invalid extent inline ref type %d",
>   		  eb->start, (unsigned long)iref, type);
>   	WARN_ON(1);
> @@ -912,6 +915,11 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
>   		}
>   		iref = (struct btrfs_extent_inline_ref *)ptr;
>   		type = btrfs_get_extent_inline_ref_type(leaf, iref, needed);
> +		if (type == BTRFS_EXTENT_OWNER_REF_KEY) {
> +			WARN_ON(!btrfs_fs_incompat(fs_info, SIMPLE_QUOTA));
> +			ptr += btrfs_extent_inline_ref_size(type);
> +			continue;
> +		}
>   		if (type == BTRFS_REF_TYPE_INVALID) {
>   			err = -EUCLEAN;
>   			goto out;
> @@ -1708,6 +1716,8 @@ static int run_one_delayed_ref(struct btrfs_trans_handle *trans,
>   		 node->type == BTRFS_SHARED_DATA_REF_KEY)
>   		ret = run_delayed_data_ref(trans, node, extent_op,
>   					   insert_reserved);
> +	else if (node->type == BTRFS_EXTENT_OWNER_REF_KEY)
> +		ret = 0;
>   	else
>   		BUG();
>   	if (ret && insert_reserved)
> @@ -2275,6 +2285,7 @@ static noinline int check_committed_ref(struct btrfs_root *root,
>   	struct btrfs_extent_item *ei;
>   	struct btrfs_key key;
>   	u32 item_size;
> +	u32 expected_size;
>   	int type;
>   	int ret;
>   
> @@ -2301,10 +2312,17 @@ static noinline int check_committed_ref(struct btrfs_root *root,
>   	ret = 1;
>   	item_size = btrfs_item_size(leaf, path->slots[0]);
>   	ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_extent_item);
> +	expected_size = sizeof(*ei) + btrfs_extent_inline_ref_size(BTRFS_EXTENT_DATA_REF_KEY);
> +
> +	iref = (struct btrfs_extent_inline_ref *)(ei + 1);
> +	type = btrfs_get_extent_inline_ref_type(leaf, iref, BTRFS_REF_TYPE_DATA);
> +	if (btrfs_fs_incompat(fs_info, SIMPLE_QUOTA) && type == BTRFS_EXTENT_OWNER_REF_KEY) {
> +		expected_size += btrfs_extent_inline_ref_size(BTRFS_EXTENT_OWNER_REF_KEY);
> +		iref = (struct btrfs_extent_inline_ref *)(iref + 1);
> +	}
>   
>   	/* If extent item has more than 1 inline ref then it's shared */
> -	if (item_size != sizeof(*ei) +
> -	    btrfs_extent_inline_ref_size(BTRFS_EXTENT_DATA_REF_KEY))
> +	if (item_size != expected_size)
>   		goto out;
>   
>   	/*
> @@ -2316,8 +2334,6 @@ static noinline int check_committed_ref(struct btrfs_root *root,
>   	     btrfs_root_last_snapshot(&root->root_item)))
>   		goto out;
>   
> -	iref = (struct btrfs_extent_inline_ref *)(ei + 1);
> -
>   	/* If this extent has SHARED_DATA_REF then it's shared */
>   	type = btrfs_get_extent_inline_ref_type(leaf, iref, BTRFS_REF_TYPE_DATA);
>   	if (type != BTRFS_EXTENT_DATA_REF_KEY)
> @@ -4572,6 +4588,7 @@ static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
>   	struct btrfs_root *extent_root;
>   	int ret;
>   	struct btrfs_extent_item *extent_item;
> +	struct btrfs_extent_owner_ref *oref;
>   	struct btrfs_extent_inline_ref *iref;
>   	struct btrfs_path *path;
>   	struct extent_buffer *leaf;
> @@ -4583,7 +4600,10 @@ static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
>   	else
>   		type = BTRFS_EXTENT_DATA_REF_KEY;
>   
> -	size = sizeof(*extent_item) + btrfs_extent_inline_ref_size(type);
> +	size = sizeof(*extent_item);
> +	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE)
> +		size += btrfs_extent_inline_ref_size(BTRFS_EXTENT_OWNER_REF_KEY);
> +	size += btrfs_extent_inline_ref_size(type);
>   
>   	path = btrfs_alloc_path();
>   	if (!path)
> @@ -4604,8 +4624,16 @@ static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
>   	btrfs_set_extent_flags(leaf, extent_item,
>   			       flags | BTRFS_EXTENT_FLAG_DATA);
>   
> +
>   	iref = (struct btrfs_extent_inline_ref *)(extent_item + 1);
> +	if (btrfs_fs_incompat(fs_info, SIMPLE_QUOTA)) {
> +		btrfs_set_extent_inline_ref_type(leaf, iref, BTRFS_EXTENT_OWNER_REF_KEY);
> +		oref = (struct btrfs_extent_owner_ref *)(&iref->offset);
> +		btrfs_set_extent_owner_ref_root_id(leaf, oref, root_objectid);
> +		iref = (struct btrfs_extent_inline_ref *)(oref + 1);
> +	}
>   	btrfs_set_extent_inline_ref_type(leaf, iref, type);
> +
>   	if (parent > 0) {
>   		struct btrfs_shared_data_ref *ref;
>   		ref = (struct btrfs_shared_data_ref *)(iref + 1);
> diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
> index b93c96213304..1114cd915bd8 100644
> --- a/fs/btrfs/print-tree.c
> +++ b/fs/btrfs/print-tree.c
> @@ -80,12 +80,20 @@ static void print_extent_data_ref(struct extent_buffer *eb,
>   	       btrfs_extent_data_ref_count(eb, ref));
>   }
>   
> +static void print_extent_owner_ref(struct extent_buffer *eb,
> +				   struct btrfs_extent_owner_ref *ref)
> +{
> +	WARN_ON(!btrfs_fs_incompat(eb->fs_info, SIMPLE_QUOTA));
> +	pr_cont("extent data owner root %llu\n", btrfs_extent_owner_ref_root_id(eb, ref));
> +}
> +
>   static void print_extent_item(struct extent_buffer *eb, int slot, int type)
>   {
>   	struct btrfs_extent_item *ei;
>   	struct btrfs_extent_inline_ref *iref;
>   	struct btrfs_extent_data_ref *dref;
>   	struct btrfs_shared_data_ref *sref;
> +	struct btrfs_extent_owner_ref *oref;
>   	struct btrfs_disk_key key;
>   	unsigned long end;
>   	unsigned long ptr;
> @@ -159,6 +167,10 @@ static void print_extent_item(struct extent_buffer *eb, int slot, int type)
>   			"\t\t\t(parent %llu not aligned to sectorsize %u)\n",
>   				     offset, eb->fs_info->sectorsize);
>   			break;
> +		case BTRFS_EXTENT_OWNER_REF_KEY:
> +			oref = (struct btrfs_extent_owner_ref *)(&iref->offset);
> +			print_extent_owner_ref(eb, oref);
> +			break;
>   		default:
>   			pr_cont("(extent %llu has INVALID ref type %d)\n",
>   				  eb->start, type);
> diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
> index 95d28497de7c..9edc87eaff1f 100644
> --- a/fs/btrfs/ref-verify.c
> +++ b/fs/btrfs/ref-verify.c
> @@ -485,6 +485,9 @@ static int process_extent_item(struct btrfs_fs_info *fs_info,
>   			ret = add_shared_data_ref(fs_info, offset, count,
>   						  key->objectid, key->offset);
>   			break;
> +		case BTRFS_EXTENT_OWNER_REF_KEY:
> +			WARN_ON(!btrfs_fs_incompat(fs_info, SIMPLE_QUOTA));
> +			break;
>   		default:
>   			btrfs_err(fs_info, "invalid key type in iref");
>   			ret = -EINVAL;
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index e2b54793bf0c..27d4230a38a8 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -1451,6 +1451,9 @@ static int check_extent_item(struct extent_buffer *leaf,
>   			}
>   			inline_refs += btrfs_shared_data_ref_count(leaf, sref);
>   			break;
> +		case BTRFS_EXTENT_OWNER_REF_KEY:
> +			WARN_ON(!btrfs_fs_incompat(fs_info, SIMPLE_QUOTA));
> +			break;
>   		default:
>   			extent_err(leaf, slot, "unknown inline ref type: %u",
>   				   inline_type);
> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
> index ab38d0f411fa..424c7f342712 100644
> --- a/include/uapi/linux/btrfs_tree.h
> +++ b/include/uapi/linux/btrfs_tree.h
> @@ -226,6 +226,8 @@
>   
>   #define BTRFS_SHARED_DATA_REF_KEY	184
>   
> +#define BTRFS_EXTENT_OWNER_REF_KEY	190
> +
>   /*
>    * block groups give us hints into the extent allocation trees.  Which
>    * blocks are free etc etc
> @@ -783,6 +785,10 @@ struct btrfs_shared_data_ref {
>   	__le32 count;
>   } __attribute__ ((__packed__));
>   
> +struct btrfs_extent_owner_ref {
> +	u64 root_id;
> +} __attribute__ ((__packed__));
> +
>   struct btrfs_extent_inline_ref {
>   	__u8 type;
>   	__le64 offset;
