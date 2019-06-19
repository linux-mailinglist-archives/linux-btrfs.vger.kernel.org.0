Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDB54B25F
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 08:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730990AbfFSGtj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 02:49:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:58332 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725854AbfFSGtj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 02:49:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2ED23AF97
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2019 06:49:37 +0000 (UTC)
Subject: Re: [PATCH] btrfs-progs: Fix false ENOSPC alert by tracking used
 space correctly
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Cc:     David Sterba <DSterba@suse.com>
References: <20190524233243.4780-1-wqu@suse.com>
 <55b8c4a9-0db9-72f5-fc1c-9b8a0d9ac30b@suse.com>
From:   Qu Wenruo <wqu@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=wqu@suse.de; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0F1F1IFdlbnJ1byA8d3F1QHN1c2UuZGU+iQFUBBMBCAA+AhsDBQsJCAcCBhUICQoLAgQW
 AgMBAh4BAheAFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlnVgp0FCQlmAm4ACgkQwj2R86El
 /qilmgf/cUq9kFQo577ku5gc6rFpVg68ublBwjYpwjw0b//xo+Wo1wm+RRbUGs+djSZAqw12
 D4F3r0mBTI7abUCNWAbFkYZSAIFVi0DMkjypIVS7PSaEt04rM9VBTToE+YqU6WENeJ57R2p2
 +hI0wZrBwxObdsdaOtxWtsp3bmhIbdqxSKrtXuRawy4KnQYcLuGzOce9okdlbAE0W3KHm1gQ
 oNAe6FX8nC9qo14m8LqEbThYH+qj4iCMlN8HIfbSx4F3e7nHZ+UAMW+E/lnMRkIB9Df+JyVd
 /NlXzIjZAggcWsqpx6D4wyAuexKWkiGQeUeArUNihAwXjmyqWPGmjVyIh+oC6LkBDQRZ1YGv
 AQgAqlPrYeBLMv3PAZ75YhQIwH6c4SNcB++hQ9TCT5gIQNw51+SQzkXIGgmzxMIS49cZcE4K
 Xk/kHw5hieQeQZa60BWVRNXwoRI4ib8okgDuMkD5Kz1WEyO149+BZ7HD4/yK0VFJGuvDJR8T
 7RZwB69uVSLjkuNZZmCmDcDzS0c/SJOg5nkxt1iTtgUETb1wNKV6yR9XzRkrEW/qShChyrS9
 fNN8e9c0MQsC4fsyz9Ylx1TOY/IF/c6rqYoEEfwnpdlz0uOM1nA1vK+wdKtXluCa79MdfaeD
 /dt76Kp/o6CAKLLcjU1Iwnkq1HSrYfY3HZWpvV9g84gPwxwxX0uXquHxLwARAQABiQE8BBgB
 CAAmFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlnVga8CGwwFCQPCZwAACgkQwj2R86El/qgN
 8Qf+M0vM2Idwm5txZZSs+/kSgcPxEwYmxUinnUJGyc0ZWYQXPl0cBetZon9El0naijGzNWvf
 HxIPB+ZFehk6Otgc78p1a3/xck/s1myFRLrmbbTJNoFiyL25ljcq0J8z5Zp4yuABL2RiLdaZ
 Pt/jfwjBHwGR+QKp6dD2qMrUWf9b7TFzYDMZXzZ2/eoIgtyjEelNBPrIgOFe24iKMjaGjd97
 fJuRcBMHdhUAxvXQF1oRtd83JvYJ5OtwTd8MgkEfl+fo7HwWkuHbzc70L4fFKv2BowqFdaHy
 mId1ijGPGr46tuZ5a4cw/zbaPYx6fJ4sK9tSv/6V1QPNUdqml6hm6pfs6A==
Message-ID: <cdcad5fc-1861-3a28-2e5e-b615d95d26ee@suse.de>
Date:   Wed, 19 Jun 2019 14:49:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <55b8c4a9-0db9-72f5-fc1c-9b8a0d9ac30b@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/6/19 下午2:32, Nikolay Borisov wrote:
> 
> 
> On 25.05.19 г. 2:32 ч., Qu Wenruo wrote:
>> [BUG]
>> There is a bug report of unexpected ENOSPC from btrfs-convert.
>> https://github.com/kdave/btrfs-progs/issues/123#
>>
>> After some debug, even when we have enough unallocated space, we still
>> hit ENOSPC at btrfs_reserve_extent().
>>
>> [CAUSE]
>> Btrfs-progs relies on chunk preallocator to make enough space for
>> data/metadata.
>>
>> However after the introduction of delayed-ref, it's no longer reliable
>> to relie on btrfs_space_info::bytes_used and
>> btrfs_space_info::bytes_pinned to calculate used metadata space.
>>
>> For a running transaction with a lot of allocated tree blocks,
>> btrfs_space_info::bytes_used stays its original value, and will only be
>> updated when running delayed ref.
>>
>> This makes btrfs-progs chunk preallocator completely useless. And for
>> btrfs-convert/mkfs.btrfs --rootdir, if we're going to have enough
>> metadata to fill a metadata block group in one transaction, we will hit
>> ENOSPC no matter whether we have enough unallocated space.
>>
>> [FIX]
>> This patch will introduce btrfs_space_info::bytes_reserved to trace how
>> many space we have reserved but not yet committed to extent tree.
>>
>> To support this change, this commit also introduces the following
>> modification:
>> - More comment on btrfs_space_info::bytes_*
>>   To make code a little easier to read
>>
>> - Export update_space_info() to preallocate empty data/metadata space
>>   info for mkfs.
>>   For mkfs, we only have a temporary fs image with SYSTEM chunk only.
>>   Export update_space_info() so that we can preallocate empty
>>   data/metadata space info before we start a transaction.
>>
>> - Proper btrfs_space_info::bytes_reserved update
>>   The timing is the as kernel (except we don't need to update
>>   bytes_reserved for data extents)
>>   * Increase bytes_reserved when call alloc_reserved_tree_block()
>>   * Decrease bytes_reserved when running delayed refs
>>     With the help of head->must_insert_reserved to determine whether we
>>     need to decrease.
> 
> This text is opposite to what the code is doing. At the time of
> alloc_reserved_tree_block we actually decrement bytes_reserved since the
> allocated block is going to be added to bytes_used via
> update_block_group. This is done when delayed refs are being run.

My bad. I selected wrong alloc_* completion item for the increase part.

The increase is at alloc_tree_block().
The decrease part is correct, it's alloc_reserved_tree_block() which get
called at run delayed ref time.

I skipped several function call names in the call chain as I thought
it's obvious at patch write time, but not so obvious when re-viewing
this comment.

Thanks,
Qu

> 
> At alloc_tree_block you increment bytes_reserved since this is the time
> when space for the extent is reserved.
> 
>>
>> Issue: #123
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  ctree.h       | 24 ++++++++++++++++++++++++
>>  extent-tree.c | 43 +++++++++++++++++++++++++++++++++++++------
>>  mkfs/main.c   | 11 +++++++++++
>>  transaction.c |  8 ++++++++
>>  4 files changed, 80 insertions(+), 6 deletions(-)
>>
>> diff --git a/ctree.h b/ctree.h
>> index 76f52b1c9b08..93f96a578f2c 100644
>> --- a/ctree.h
>> +++ b/ctree.h
>> @@ -1060,8 +1060,29 @@ struct btrfs_qgroup_limit_item {
>>  struct btrfs_space_info {
>>  	u64 flags;
>>  	u64 total_bytes;
>> +	/*
>> +	 * Space already used.
>> +	 * Only accounting space in current extent tree, thus delayed ref
>> +	 * won't be accounted here.
>> +	 */
>>  	u64 bytes_used;
>> +
>> +	/*
>> +	 * Space being pinned down.
>> +	 * So extent allocator will not try to allocate space from them.
>> +	 *
>> +	 * For cases like extents being freed in current transaction, or
>> +	 * manually pinned bytes for re-initializing certain trees.
>> +	 */
>>  	u64 bytes_pinned;
>> +
>> +	/*
>> +	 * Space being reserved.
>> +	 * Space has already being reserved but not yet reach extent tree.
>> +	 *
>> +	 * New tree blocks allocated in current transaction goes here.
>> +	 */
>> +	u64 bytes_reserved;
>>  	int full;
>>  	struct list_head list;
>>  };
>> @@ -2528,6 +2549,9 @@ int btrfs_update_extent_ref(struct btrfs_trans_handle *trans,
>>  			    u64 root_objectid, u64 ref_generation,
>>  			    u64 owner_objectid);
>>  int btrfs_write_dirty_block_groups(struct btrfs_trans_handle *trans);
>> +int update_space_info(struct btrfs_fs_info *info, u64 flags,
>> +		      u64 total_bytes, u64 bytes_used,
>> +		      struct btrfs_space_info **space_info);
>>  int btrfs_free_block_groups(struct btrfs_fs_info *info);
>>  int btrfs_read_block_groups(struct btrfs_root *root);
>>  struct btrfs_block_group_cache *
>> diff --git a/extent-tree.c b/extent-tree.c
>> index e62ee8c2ba13..c7ca49bccd8b 100644
>> --- a/extent-tree.c
>> +++ b/extent-tree.c
>> @@ -1786,9 +1786,9 @@ static int free_space_info(struct btrfs_fs_info *fs_info, u64 flags,
>>  	return 0;
>>  }
>>  
>> -static int update_space_info(struct btrfs_fs_info *info, u64 flags,
>> -			     u64 total_bytes, u64 bytes_used,
>> -			     struct btrfs_space_info **space_info)
>> +int update_space_info(struct btrfs_fs_info *info, u64 flags,
>> +		      u64 total_bytes, u64 bytes_used,
>> +		      struct btrfs_space_info **space_info)
>>  {
>>  	struct btrfs_space_info *found;
>>  
>> @@ -1814,6 +1814,7 @@ static int update_space_info(struct btrfs_fs_info *info, u64 flags,
>>  	found->total_bytes = total_bytes;
>>  	found->bytes_used = bytes_used;
>>  	found->bytes_pinned = 0;
>> +	found->bytes_reserved = 0;
>>  	found->full = 0;
>>  	*space_info = found;
>>  	return 0;
>> @@ -1859,8 +1860,8 @@ static int do_chunk_alloc(struct btrfs_trans_handle *trans,
>>  		return 0;
>>  
>>  	thresh = div_factor(space_info->total_bytes, 7);
>> -	if ((space_info->bytes_used + space_info->bytes_pinned + alloc_bytes) <
>> -	    thresh)
>> +	if ((space_info->bytes_used + space_info->bytes_pinned +
>> +	     space_info->bytes_reserved + alloc_bytes) < thresh)
>>  		return 0;
>>  
>>  	/*
>> @@ -2538,6 +2539,7 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
>>  	struct btrfs_fs_info *fs_info = trans->fs_info;
>>  	struct btrfs_extent_item *extent_item;
>>  	struct btrfs_extent_inline_ref *iref;
>> +	struct btrfs_space_info *sinfo;
>>  	struct extent_buffer *leaf;
>>  	struct btrfs_path *path;
>>  	struct btrfs_key ins;
>> @@ -2545,6 +2547,9 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
>>  	u64 start, end;
>>  	int ret;
>>  
>> +	sinfo = __find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
>> +	ASSERT(sinfo);
>> +
>>  	ins.objectid = node->bytenr;
>>  	if (skinny_metadata) {
>>  		ins.offset = ref->level;
>> @@ -2605,6 +2610,14 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
>>  
>>  	ret = update_block_group(fs_info, ins.objectid, fs_info->nodesize, 1,
>>  				 0);
>> +	if (sinfo) {
>> +		if (fs_info->nodesize > sinfo->bytes_reserved) {
>> +			WARN_ON(1);
>> +			sinfo->bytes_reserved = 0;
>> +		} else {
>> +			sinfo->bytes_reserved -= fs_info->nodesize;
>> +		}
>> +	}
>>  
>>  	if (ref->root == BTRFS_EXTENT_TREE_OBJECTID) {
>>  		clear_extent_bits(&trans->fs_info->extent_ins, start, end,
>> @@ -2624,6 +2637,8 @@ static int alloc_tree_block(struct btrfs_trans_handle *trans,
>>  	int ret;
>>  	u64 extent_size;
>>  	struct btrfs_delayed_extent_op *extent_op;
>> +	struct btrfs_space_info *sinfo;
>> +	struct btrfs_fs_info *fs_info = root->fs_info;
>>  	bool skinny_metadata = btrfs_fs_incompat(root->fs_info,
>>  						 SKINNY_METADATA);
>>  
>> @@ -2631,6 +2646,8 @@ static int alloc_tree_block(struct btrfs_trans_handle *trans,
>>  	if (!extent_op)
>>  		return -ENOMEM;
>>  
>> +	sinfo = __find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
>> +	ASSERT(sinfo);
>>  	ret = btrfs_reserve_extent(trans, root, num_bytes, empty_size,
>>  				   hint_byte, search_end, ins, 0);
>>  	if (ret < 0)
>> @@ -2663,6 +2680,7 @@ static int alloc_tree_block(struct btrfs_trans_handle *trans,
>>  		BUG_ON(ret);
>>  	}
>>  
>> +	sinfo->bytes_reserved += extent_size;
>>  	ret = btrfs_add_delayed_tree_ref(root->fs_info, trans, ins->objectid,
>>  					 extent_size, 0, root_objectid,
>>  					 level, BTRFS_ADD_DELAYED_EXTENT,
>> @@ -3000,6 +3018,10 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
>>  		sinfo = list_entry(info->space_info.next,
>>  				   struct btrfs_space_info, list);
>>  		list_del_init(&sinfo->list);
>> +		if (sinfo->bytes_reserved)
>> +			warning(
>> +		"reserved space leaked, flag=0x%llx bytes_reserved=%llu",
>> +				sinfo->flags, sinfo->bytes_reserved);
>>  		kfree(sinfo);
>>  	}
>>  	return 0;
>> @@ -4106,8 +4128,17 @@ int cleanup_ref_head(struct btrfs_trans_handle *trans,
>>  	rb_erase(&head->href_node, &delayed_refs->href_root);
>>  	RB_CLEAR_NODE(&head->href_node);
>>  
>> -	if (head->must_insert_reserved)
>> +	if (head->must_insert_reserved) {
>>  		btrfs_pin_extent(fs_info, head->bytenr, head->num_bytes);
>> +		if (!head->is_data) {
>> +			struct btrfs_space_info *sinfo;
>> +
>> +			sinfo = __find_space_info(trans->fs_info,
>> +					BTRFS_BLOCK_GROUP_METADATA);
>> +			ASSERT(sinfo);
>> +			sinfo->bytes_reserved -= head->num_bytes;
>> +		}
>> +	}
>>  
>>  	btrfs_put_delayed_ref_head(head);
>>  	return 0;
>> diff --git a/mkfs/main.c b/mkfs/main.c
>> index b442e6e40c37..1d03ec52ddd6 100644
>> --- a/mkfs/main.c
>> +++ b/mkfs/main.c
>> @@ -58,11 +58,22 @@ static int create_metadata_block_groups(struct btrfs_root *root, int mixed,
>>  {
>>  	struct btrfs_fs_info *fs_info = root->fs_info;
>>  	struct btrfs_trans_handle *trans;
>> +	struct btrfs_space_info *sinfo;
>>  	u64 bytes_used;
>>  	u64 chunk_start = 0;
>>  	u64 chunk_size = 0;
>>  	int ret;
>>  
>> +	/* Create needed space info to trace extents reservation */
>> +	ret = update_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA,
>> +				0, 0, &sinfo);
>> +	if (ret < 0)
>> +		return ret;
>> +	ret = update_space_info(fs_info, BTRFS_BLOCK_GROUP_DATA,
>> +				0, 0, &sinfo);
>> +	if (ret < 0)
>> +		return ret;
>> +
>>  	trans = btrfs_start_transaction(root, 1);
>>  	BUG_ON(IS_ERR(trans));
>>  	bytes_used = btrfs_super_bytes_used(fs_info->super_copy);
>> diff --git a/transaction.c b/transaction.c
>> index 138e10f0d6cc..d2c7f4829eda 100644
>> --- a/transaction.c
>> +++ b/transaction.c
>> @@ -158,6 +158,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans,
>>  	u64 transid = trans->transid;
>>  	int ret = 0;
>>  	struct btrfs_fs_info *fs_info = root->fs_info;
>> +	struct btrfs_space_info *sinfo;
>>  
>>  	if (trans->fs_info->transaction_aborted)
>>  		return -EROFS;
>> @@ -209,6 +210,13 @@ commit_tree:
>>  	root->commit_root = NULL;
>>  	fs_info->running_transaction = NULL;
>>  	fs_info->last_trans_committed = transid;
>> +	list_for_each_entry(sinfo, &fs_info->space_info, list) {
>> +		if (sinfo->bytes_reserved) {
>> +			warning(
>> +	"reserved space leaked, transid=%llu flag=0x%llx bytes_reserved=%llu",
>> +				transid, sinfo->flags, sinfo->bytes_reserved);
>> +		}
>> +	}
>>  	return ret;
>>  error:
>>  	btrfs_destroy_delayed_refs(trans);
>>
