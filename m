Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7E24B21D
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 08:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbfFSGcJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 02:32:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:55380 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725881AbfFSGcI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 02:32:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4B67AAC8E
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2019 06:32:07 +0000 (UTC)
Subject: Re: [PATCH] btrfs-progs: Fix false ENOSPC alert by tracking used
 space correctly
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20190524233243.4780-1-wqu@suse.com>
Cc:     David Sterba <dsterba@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <55b8c4a9-0db9-72f5-fc1c-9b8a0d9ac30b@suse.com>
Date:   Wed, 19 Jun 2019 09:32:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190524233243.4780-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 25.05.19 г. 2:32 ч., Qu Wenruo wrote:
> [BUG]
> There is a bug report of unexpected ENOSPC from btrfs-convert.
> https://github.com/kdave/btrfs-progs/issues/123#
> 
> After some debug, even when we have enough unallocated space, we still
> hit ENOSPC at btrfs_reserve_extent().
> 
> [CAUSE]
> Btrfs-progs relies on chunk preallocator to make enough space for
> data/metadata.
> 
> However after the introduction of delayed-ref, it's no longer reliable
> to relie on btrfs_space_info::bytes_used and
> btrfs_space_info::bytes_pinned to calculate used metadata space.
> 
> For a running transaction with a lot of allocated tree blocks,
> btrfs_space_info::bytes_used stays its original value, and will only be
> updated when running delayed ref.
> 
> This makes btrfs-progs chunk preallocator completely useless. And for
> btrfs-convert/mkfs.btrfs --rootdir, if we're going to have enough
> metadata to fill a metadata block group in one transaction, we will hit
> ENOSPC no matter whether we have enough unallocated space.
> 
> [FIX]
> This patch will introduce btrfs_space_info::bytes_reserved to trace how
> many space we have reserved but not yet committed to extent tree.
> 
> To support this change, this commit also introduces the following
> modification:
> - More comment on btrfs_space_info::bytes_*
>   To make code a little easier to read
> 
> - Export update_space_info() to preallocate empty data/metadata space
>   info for mkfs.
>   For mkfs, we only have a temporary fs image with SYSTEM chunk only.
>   Export update_space_info() so that we can preallocate empty
>   data/metadata space info before we start a transaction.
> 
> - Proper btrfs_space_info::bytes_reserved update
>   The timing is the as kernel (except we don't need to update
>   bytes_reserved for data extents)
>   * Increase bytes_reserved when call alloc_reserved_tree_block()
>   * Decrease bytes_reserved when running delayed refs
>     With the help of head->must_insert_reserved to determine whether we
>     need to decrease.

This text is opposite to what the code is doing. At the time of
alloc_reserved_tree_block we actually decrement bytes_reserved since the
allocated block is going to be added to bytes_used via
update_block_group. This is done when delayed refs are being run.

At alloc_tree_block you increment bytes_reserved since this is the time
when space for the extent is reserved.

> 
> Issue: #123
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  ctree.h       | 24 ++++++++++++++++++++++++
>  extent-tree.c | 43 +++++++++++++++++++++++++++++++++++++------
>  mkfs/main.c   | 11 +++++++++++
>  transaction.c |  8 ++++++++
>  4 files changed, 80 insertions(+), 6 deletions(-)
> 
> diff --git a/ctree.h b/ctree.h
> index 76f52b1c9b08..93f96a578f2c 100644
> --- a/ctree.h
> +++ b/ctree.h
> @@ -1060,8 +1060,29 @@ struct btrfs_qgroup_limit_item {
>  struct btrfs_space_info {
>  	u64 flags;
>  	u64 total_bytes;
> +	/*
> +	 * Space already used.
> +	 * Only accounting space in current extent tree, thus delayed ref
> +	 * won't be accounted here.
> +	 */
>  	u64 bytes_used;
> +
> +	/*
> +	 * Space being pinned down.
> +	 * So extent allocator will not try to allocate space from them.
> +	 *
> +	 * For cases like extents being freed in current transaction, or
> +	 * manually pinned bytes for re-initializing certain trees.
> +	 */
>  	u64 bytes_pinned;
> +
> +	/*
> +	 * Space being reserved.
> +	 * Space has already being reserved but not yet reach extent tree.
> +	 *
> +	 * New tree blocks allocated in current transaction goes here.
> +	 */
> +	u64 bytes_reserved;
>  	int full;
>  	struct list_head list;
>  };
> @@ -2528,6 +2549,9 @@ int btrfs_update_extent_ref(struct btrfs_trans_handle *trans,
>  			    u64 root_objectid, u64 ref_generation,
>  			    u64 owner_objectid);
>  int btrfs_write_dirty_block_groups(struct btrfs_trans_handle *trans);
> +int update_space_info(struct btrfs_fs_info *info, u64 flags,
> +		      u64 total_bytes, u64 bytes_used,
> +		      struct btrfs_space_info **space_info);
>  int btrfs_free_block_groups(struct btrfs_fs_info *info);
>  int btrfs_read_block_groups(struct btrfs_root *root);
>  struct btrfs_block_group_cache *
> diff --git a/extent-tree.c b/extent-tree.c
> index e62ee8c2ba13..c7ca49bccd8b 100644
> --- a/extent-tree.c
> +++ b/extent-tree.c
> @@ -1786,9 +1786,9 @@ static int free_space_info(struct btrfs_fs_info *fs_info, u64 flags,
>  	return 0;
>  }
>  
> -static int update_space_info(struct btrfs_fs_info *info, u64 flags,
> -			     u64 total_bytes, u64 bytes_used,
> -			     struct btrfs_space_info **space_info)
> +int update_space_info(struct btrfs_fs_info *info, u64 flags,
> +		      u64 total_bytes, u64 bytes_used,
> +		      struct btrfs_space_info **space_info)
>  {
>  	struct btrfs_space_info *found;
>  
> @@ -1814,6 +1814,7 @@ static int update_space_info(struct btrfs_fs_info *info, u64 flags,
>  	found->total_bytes = total_bytes;
>  	found->bytes_used = bytes_used;
>  	found->bytes_pinned = 0;
> +	found->bytes_reserved = 0;
>  	found->full = 0;
>  	*space_info = found;
>  	return 0;
> @@ -1859,8 +1860,8 @@ static int do_chunk_alloc(struct btrfs_trans_handle *trans,
>  		return 0;
>  
>  	thresh = div_factor(space_info->total_bytes, 7);
> -	if ((space_info->bytes_used + space_info->bytes_pinned + alloc_bytes) <
> -	    thresh)
> +	if ((space_info->bytes_used + space_info->bytes_pinned +
> +	     space_info->bytes_reserved + alloc_bytes) < thresh)
>  		return 0;
>  
>  	/*
> @@ -2538,6 +2539,7 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
>  	struct btrfs_fs_info *fs_info = trans->fs_info;
>  	struct btrfs_extent_item *extent_item;
>  	struct btrfs_extent_inline_ref *iref;
> +	struct btrfs_space_info *sinfo;
>  	struct extent_buffer *leaf;
>  	struct btrfs_path *path;
>  	struct btrfs_key ins;
> @@ -2545,6 +2547,9 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
>  	u64 start, end;
>  	int ret;
>  
> +	sinfo = __find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
> +	ASSERT(sinfo);
> +
>  	ins.objectid = node->bytenr;
>  	if (skinny_metadata) {
>  		ins.offset = ref->level;
> @@ -2605,6 +2610,14 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
>  
>  	ret = update_block_group(fs_info, ins.objectid, fs_info->nodesize, 1,
>  				 0);
> +	if (sinfo) {
> +		if (fs_info->nodesize > sinfo->bytes_reserved) {
> +			WARN_ON(1);
> +			sinfo->bytes_reserved = 0;
> +		} else {
> +			sinfo->bytes_reserved -= fs_info->nodesize;
> +		}
> +	}
>  
>  	if (ref->root == BTRFS_EXTENT_TREE_OBJECTID) {
>  		clear_extent_bits(&trans->fs_info->extent_ins, start, end,
> @@ -2624,6 +2637,8 @@ static int alloc_tree_block(struct btrfs_trans_handle *trans,
>  	int ret;
>  	u64 extent_size;
>  	struct btrfs_delayed_extent_op *extent_op;
> +	struct btrfs_space_info *sinfo;
> +	struct btrfs_fs_info *fs_info = root->fs_info;
>  	bool skinny_metadata = btrfs_fs_incompat(root->fs_info,
>  						 SKINNY_METADATA);
>  
> @@ -2631,6 +2646,8 @@ static int alloc_tree_block(struct btrfs_trans_handle *trans,
>  	if (!extent_op)
>  		return -ENOMEM;
>  
> +	sinfo = __find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
> +	ASSERT(sinfo);
>  	ret = btrfs_reserve_extent(trans, root, num_bytes, empty_size,
>  				   hint_byte, search_end, ins, 0);
>  	if (ret < 0)
> @@ -2663,6 +2680,7 @@ static int alloc_tree_block(struct btrfs_trans_handle *trans,
>  		BUG_ON(ret);
>  	}
>  
> +	sinfo->bytes_reserved += extent_size;
>  	ret = btrfs_add_delayed_tree_ref(root->fs_info, trans, ins->objectid,
>  					 extent_size, 0, root_objectid,
>  					 level, BTRFS_ADD_DELAYED_EXTENT,
> @@ -3000,6 +3018,10 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
>  		sinfo = list_entry(info->space_info.next,
>  				   struct btrfs_space_info, list);
>  		list_del_init(&sinfo->list);
> +		if (sinfo->bytes_reserved)
> +			warning(
> +		"reserved space leaked, flag=0x%llx bytes_reserved=%llu",
> +				sinfo->flags, sinfo->bytes_reserved);
>  		kfree(sinfo);
>  	}
>  	return 0;
> @@ -4106,8 +4128,17 @@ int cleanup_ref_head(struct btrfs_trans_handle *trans,
>  	rb_erase(&head->href_node, &delayed_refs->href_root);
>  	RB_CLEAR_NODE(&head->href_node);
>  
> -	if (head->must_insert_reserved)
> +	if (head->must_insert_reserved) {
>  		btrfs_pin_extent(fs_info, head->bytenr, head->num_bytes);
> +		if (!head->is_data) {
> +			struct btrfs_space_info *sinfo;
> +
> +			sinfo = __find_space_info(trans->fs_info,
> +					BTRFS_BLOCK_GROUP_METADATA);
> +			ASSERT(sinfo);
> +			sinfo->bytes_reserved -= head->num_bytes;
> +		}
> +	}
>  
>  	btrfs_put_delayed_ref_head(head);
>  	return 0;
> diff --git a/mkfs/main.c b/mkfs/main.c
> index b442e6e40c37..1d03ec52ddd6 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -58,11 +58,22 @@ static int create_metadata_block_groups(struct btrfs_root *root, int mixed,
>  {
>  	struct btrfs_fs_info *fs_info = root->fs_info;
>  	struct btrfs_trans_handle *trans;
> +	struct btrfs_space_info *sinfo;
>  	u64 bytes_used;
>  	u64 chunk_start = 0;
>  	u64 chunk_size = 0;
>  	int ret;
>  
> +	/* Create needed space info to trace extents reservation */
> +	ret = update_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA,
> +				0, 0, &sinfo);
> +	if (ret < 0)
> +		return ret;
> +	ret = update_space_info(fs_info, BTRFS_BLOCK_GROUP_DATA,
> +				0, 0, &sinfo);
> +	if (ret < 0)
> +		return ret;
> +
>  	trans = btrfs_start_transaction(root, 1);
>  	BUG_ON(IS_ERR(trans));
>  	bytes_used = btrfs_super_bytes_used(fs_info->super_copy);
> diff --git a/transaction.c b/transaction.c
> index 138e10f0d6cc..d2c7f4829eda 100644
> --- a/transaction.c
> +++ b/transaction.c
> @@ -158,6 +158,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans,
>  	u64 transid = trans->transid;
>  	int ret = 0;
>  	struct btrfs_fs_info *fs_info = root->fs_info;
> +	struct btrfs_space_info *sinfo;
>  
>  	if (trans->fs_info->transaction_aborted)
>  		return -EROFS;
> @@ -209,6 +210,13 @@ commit_tree:
>  	root->commit_root = NULL;
>  	fs_info->running_transaction = NULL;
>  	fs_info->last_trans_committed = transid;
> +	list_for_each_entry(sinfo, &fs_info->space_info, list) {
> +		if (sinfo->bytes_reserved) {
> +			warning(
> +	"reserved space leaked, transid=%llu flag=0x%llx bytes_reserved=%llu",
> +				transid, sinfo->flags, sinfo->bytes_reserved);
> +		}
> +	}
>  	return ret;
>  error:
>  	btrfs_destroy_delayed_refs(trans);
> 
