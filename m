Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743FC21964D
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jul 2020 04:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgGICip (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jul 2020 22:38:45 -0400
Received: from mail.synology.com ([211.23.38.101]:46134 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726117AbgGICio (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Jul 2020 22:38:44 -0400
Subject: Re: [PATCH v2] btrfs: speedup mount time with readahead chunk tree
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1594262322; bh=wUhK/jcLXBQs2wqFjk2Nqq0qWIkJKssfJlfu8pI33ME=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=ePtd4BhRoXhVjVQVIw3/sizftYd8iFJCYh633wa0mI89rAAFU4mT58qcX61laRuAv
         dTSP402v6WxHFqOMMxh3OHvgW++sNHodFiRNcoac9eU24phvXM7wOAT/jXvCBQYs1N
         WA1HpjgHXb71rPhtru6+Ko7pW/OJS8uEe8KLwvoY=
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, wqu@suse.com
References: <20200707035944.15150-1-robbieko@synology.com>
 <20200707192511.GE16141@twin.jikos.cz> <20200708211142.GD28832@twin.jikos.cz>
From:   Robbie Ko <robbieko@synology.com>
Message-ID: <0358f6f6-da68-94a4-f3ed-718e5caeded4@synology.com>
Date:   Thu, 9 Jul 2020 10:38:42 +0800
MIME-Version: 1.0
In-Reply-To: <20200708211142.GD28832@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


David Sterba 於 2020/7/9 上午5:11 寫道:
> On Tue, Jul 07, 2020 at 09:25:11PM +0200, David Sterba wrote:
>> On Tue, Jul 07, 2020 at 11:59:44AM +0800, robbieko wrote:
>>> From: Robbie Ko <robbieko@synology.com>
>>>
>>> When mounting, we always need to read the whole chunk tree,
>>> when there are too many chunk items, most of the time is
>>> spent on btrfs_read_chunk_tree, because we only read one
>>> leaf at a time.
>>>
>>> It is unreasonable to limit the readahead mechanism to a
>>> range of 64k, so we have removed that limit.
>>>
>>> In addition we added reada_maximum_size to customize the
>>> size of the pre-reader, The default is 64k to maintain the
>>> original behavior.
>>>
>>> So we fix this by used readahead mechanism, and set readahead
>>> max size to ULLONG_MAX which reads all the leaves after the
>>> key in the node when reading a level 1 node.
>> The readahead of chunk tree is a special case as we know we will need
>> the whole tree, in all other cases the search readahead needs is
>> supposed to read only one leaf.
>>
>> For that reason I don't want to touch the current path readahead logic
>> at all and do the chunk tree readahead in one go instead of the
>> per-search.
>>
>> Also I don't like to see size increase of btrfs_path just to use the
>> custom once.
>>
>> The idea of the whole tree readahead is to do something like:
>>
>> - find first item
>> - start readahead on all leaves from its level 1 node parent
>>    (readahead_tree_block)
>> - when the level 1 parent changes during iterating items, start the
>>    readahead again
>>
>> This skips readahead of all nodes above level 1, if you find a nicer way
>> to readahead the whole tree I won't object, but for the first
>> implementation the level 1 seems ok to me.
> Patch below, I tried to create large system chunk by fallocate on a
> sparse loop device, but got only 1 node on level 1 so the readahead
> cannot show off.
>
> # btrfs fi df .
> Data, single: total=59.83TiB, used=59.83TiB
> System, single: total=36.00MiB, used=6.20MiB
> Metadata, single: total=1.01GiB, used=91.78MiB
> GlobalReserve, single: total=26.80MiB, used=0.00B
>
> There were 395 leaf nodes that got read ahead, time between the first
> and last is 0.83s and the block group tree read took about 40 seconds.
> This was in a VM with file-backed images, and the loop device was
> constructed from these devices so it's spinning rust.
>
> I don't have results for non-prefetched mount to compare at the moment.
>
I think what you're doing is working.

But there are many similar problems that need to be improved.

1. load_free_space_tree
We need to read all BTRFS_FREE_SPACE_BITMAP_KEY and
BTRFS_FREE_SPACE_EXTENT_KEY until the next FREE_SPACE_INFO_KEY.

2. populate_free_space_tree
We need to read all BTRFS_EXTENT_ITEM_KEY and BTRFS_METADATA_ITEM_KEY 
until the end of the block group

3. btrfs_real_readdir
We need as many reads as possible (inode, BTRFS_DIR_INDEX_KEY).

4. btrfs_clone
We need as many reads as possible (inode, BTRFS_EXTENT_DATA_KEY).

5. btrfs_verify_dev_extents
We need to read all the BTRFS_DEV_EXTENT_KEYs.

6. caching_kthread (inode-map.c)
We need all the BTRFS_INODE_ITEM_KEY of fs_tree to build the inode map

For the above cases.
It is not possible to write a special readahead code for each case.
We have to provide a new readaread framework
Enable the caller to determine the scope of readaheads needed.
The possible parameters of the readahead are as follows
1. reada_maximum_nr : Read a maximum of several leaves at a time.
2. reada_max_key : READA_FORWARD Early Suspension Condition
3. reada_min_key : READA_BACK Abort condition ahead of time.

We need to review all users of readahead to confirm that the The 
behavior of readahead.
For example, in scrub_enumerate_chunks readahead has the effect of Very 
small,
Because most of the time is spent on scrub_chunk,
The processing of scrub_chunk for all DEV_EXTENT in a leaf is A long time.
If the dev tree has been modified in the meantime, the previously 
pre-reading leaf may be useless.


> ----
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index c7a3d4d730a3..e19891243199 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -7013,6 +7013,19 @@ bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info,
>   	return ret;
>   }
>   
> +void readahead_tree_node_children(struct extent_buffer *node)
> +{
> +	int i;
> +	const int nr_items = btrfs_header_nritems(node);
> +
> +	for (i = 0; i < nr_items; i++) {
> +		u64 start;
> +
> +		start = btrfs_node_blockptr(node, i);
> +		readahead_tree_block(node->fs_info, start);
> +	}
> +}
> +
>   int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
>   {
>   	struct btrfs_root *root = fs_info->chunk_root;
> @@ -7023,6 +7036,7 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
>   	int ret;
>   	int slot;
>   	u64 total_dev = 0;
> +	u64 last_ra_node = 0;
>   
>   	path = btrfs_alloc_path();
>   	if (!path)
> @@ -7048,6 +7062,8 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
>   	if (ret < 0)
>   		goto error;
>   	while (1) {
> +		struct extent_buffer *node;
> +
>   		leaf = path->nodes[0];
>   		slot = path->slots[0];
>   		if (slot >= btrfs_header_nritems(leaf)) {
> @@ -7058,6 +7074,13 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
>   				goto error;
>   			break;
>   		}
> +		node = path->nodes[1];
> +		if (node) {
> +			if (last_ra_node != node->start) {
> +				readahead_tree_node_children(node);
> +				last_ra_node = node->start;
> +			}
> +		}
>   		btrfs_item_key_to_cpu(leaf, &found_key, slot);
>   		if (found_key.type == BTRFS_DEV_ITEM_KEY) {
>   			struct btrfs_dev_item *dev_item;
