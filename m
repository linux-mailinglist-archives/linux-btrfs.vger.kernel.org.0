Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE68357C1DB
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jul 2022 03:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiGUB1H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jul 2022 21:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiGUB1H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jul 2022 21:27:07 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A936574CD0
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 18:27:05 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id A247E8037E;
        Wed, 20 Jul 2022 21:27:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1658366825; bh=/m5UP13zWkJfO0tnd9fb+hCDTul0lrKEcSgvLaIe+IY=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=LvGv6TsxJ3U2jXvtZ6uy4okMRY1n7z9SXQjXfBTk8/iG0a6kKduSUK6YkDRRCRaRT
         ov2VrWP1uJdb4wlSIS8x9du3OjuE9PNiL3VbyL1GrzvLY2Vma9VOuxxnO3R2tPxqaL
         1RREHjneYoxLfVCI9I6/LdZqcwsU8Qp9YJcodcl4bsj2r0zrKqXwOvP3SN8HUuskum
         NxZFEN9iSETFK8VPtiaScnVk4UHMUEYhlC7MIKKXe7I3a+m1u7d1Oht6oJoDGvlKBm
         UQEsJ++DZxUVRXFvnHZpxLt+1iK+//iaLe6h12WUoy+ReXhf+nl5FuaQSmNa1XDdOP
         nqVJ21ld6K/Bg==
Message-ID: <f80b3b68-8aea-b1ac-c247-1cf18583c6b0@dorminy.me>
Date:   Wed, 20 Jul 2022 21:27:03 -0400
MIME-Version: 1.0
Subject: Re: [PATCH] btrfs: do not batch insert non-consecutive dir indexes
 during log replay
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <2afa2744e3ea3a2290ab683cac51907ef10f8582.1658332827.git.josef@toxicpanda.com>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <2afa2744e3ea3a2290ab683cac51907ef10f8582.1658332827.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks fine to me, just a couple of clarification questions and a request 
for a Fixes: if possible:

On 7/20/22 12:00, Josef Bacik wrote:
> While running generic/475 in a loop I got the following error
> 
> BTRFS critical (device dm-11): corrupt leaf: root=5 block=31096832 slot=69, bad key order, prev (263 96 531) current (263 96 524)
> <snip>
>   item 65 key (263 96 517) itemoff 14132 itemsize 33
>   item 66 key (263 96 523) itemoff 14099 itemsize 33
>   item 67 key (263 96 525) itemoff 14066 itemsize 33
>   item 68 key (263 96 531) itemoff 14033 itemsize 33
>   item 69 key (263 96 524) itemoff 14000 itemsize 33
> 
> As you can see here we have 3 dir index keys with the dir index value of
> 523, 524, and 525 inserted between 517 and 524.  This occurs because our
> dir index insertion code will bulk insert all dir index items on the
> node regardless of their actual key value.
> 
> This makes sense on a normally running system, because if there's a gap
> in between the items there was a deletion before the item was inserted,
> so there's not going to be an overlap of the dir index items that need
> to be inserted and what exists on disk.
> 
> However during log replay this isn't necessarily true, we could have any
> number of dir indexes in the tree already.
> 
> Fix this by seeing if we're replaying the log, and if we are simply skip
> batching if there's a gap in the key space. >
> This file system was left broken from the fstest, I tested this patch
> against the broken fs to make sure it replayed the log properly, and
> then btrfs check'ed the file system after the log replay to verify
> everything was ok.

Might need a Fixes: ?
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

> ---
>   fs/btrfs/delayed-inode.c | 33 +++++++++++++++++++++++++++++++--
>   1 file changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index 823aa05b3e38..0760578e0e86 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -691,9 +691,23 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
>   	int total_size;
>   	char *ins_data = NULL;
>   	int ret;
> +	bool need_consecutive = false;
>   
>   	lockdep_assert_held(&node->mutex);
>   
> +	/*
> +	 * We will just batch non-consecutive items for insertion while running,
> +	 * because the dir index offset is continuously increasing.  If there is
> +	 * a gap in the key.offset range we simply deleted that entry and that
> +	 * key won't exist in the tree.
> +	 *
> +	 * The exception to this is log replay, where we could have any pattern
> +	 * of keys in our fs tree.  If we're recovering the log we can only
> +	 * batch keys that are consecutive and have no gaps in their key space.
> +	 */

I think the comments state the consecutive requirement in a way that 
might confuse future readers. To me, it seems like a pain but 
potentially slightly more efficient to check the open gap in the leaf 
and batch everything that goes in that gap. I would prefer this comment 
emphasize that contiguity is a cheap way to make sure we can insert the 
whole batch, but isn't strictly necessary as the comment currently implies.

Maybe:
During normal operation, the dir index offset is continuously 
increasing, so we don't have to worry about existing dir index items 
with greater offsets in the tree already. Therefore, we can batch all 
items for a particular leaf.

For log replay, though, we could need to replay items whose sequence of 
offsets interleaves with the sequence of offsets already in the tree. 
For instance, we might need to replay items with offsets (523, 525, 531) 
into a leaf that already has items with offsets (517, 524). For 
simplicity, we only batch items with consecutive offsets, since we're 
guaranteed such a batch can be inserted in a consecutive range without 
any existing keys interfering.

(Maybe the variable should be named consecutive_only? Don't care much.)

> +	if (test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags))
> +		need_consecutive = true;
> +
>   	/*
>   	 * For delayed items to insert, we track reserved metadata bytes based
>   	 * on the number of leaves that we will use.
> @@ -715,6 +729,14 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
>   		if (!next)
>   			break;
>   
> +		/*
> +		 * We cannot allow gaps in the key space if we're doing log
> +		 * replay.
> +		 */
> +		if (need_consecutive &&
> +		    (next->key.offset != curr->key.offset + 1))
> +			break;
> +
>   		ASSERT(next->bytes_reserved == 0);
>   
>   		next_size = next->data_len + sizeof(struct btrfs_item);
> @@ -775,7 +797,14 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
>   
>   	ASSERT(node->index_item_leaves > 0);
>   
> -	if (next) {
> +	/*
> +	 * If we are need_consecutive we possibly stopped not because we batch
> +	 * inserted an entire leaf, but because there was a gap in the key
> +	 * space, so don't bother dropping the index_item_leaves here, simply
> +	 * wait until we've run all of our items and release all of the space at
> +	 * once.
> +	 */
Sort of a long sentence I had difficulty following. Maybe:
"Normally, we only stop if we batch inserted an entire leaf. However, 
during log replay, we may have inserted only one of several 
contiguous-offset batches for a particular leaf, and therefore should 
wait to drop index_item_leaves until all the items are run."
> +	if (next && !need_consecutive) {
>   		/*
>   		 * We inserted one batch of items into a leaf a there are more
>   		 * items to flush in a future batch, now release one unit of
> @@ -784,7 +813,7 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
>   		 */
>   		btrfs_delayed_item_release_leaves(node, 1);
>   		node->index_item_leaves--;
> -	} else {
> +	} else if (!next) {
>   		/*
>   		 * There are no more items to insert. We can have a number of
>   		 * reserved leaves > 1 here - this happens when many dir index
