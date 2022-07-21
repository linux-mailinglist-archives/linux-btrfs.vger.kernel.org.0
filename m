Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A58657CDB9
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jul 2022 16:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiGUOcq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Jul 2022 10:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiGUOcp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Jul 2022 10:32:45 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B1385D40
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Jul 2022 07:32:44 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 67240810B2;
        Thu, 21 Jul 2022 10:32:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1658413964; bh=mXvwpRngQOekKbzesRzrF1gBVcWwxLfTG4+4c/NsJt4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=w5GsGf5U3QVgqGyoI5v2J2SDd/PjKx5C0iA3+vlivkDdWjS/azqNIUsg2Ei73frzj
         eyYIUbk6ffHysDqPm9pduxjqm75J2Ui+aKEO/kM6AHFk0k/rTDYjCBSAqyNEJbC8bL
         q7HCcivVPvoTff9VmvsOoBH85xmXORvo8XglDfl1kEAi2AwPOhbSWQy4TJY5RE+z1S
         Q7Bj03p0ccveMMMCXGJzE3S00TFsPcSoV+onO2X4bgnGs8w/U9wruWyDF2WiQLqhYj
         dEVaGvIjtH1oqS1xNYciS7Y2H3pQTs/0xuKa4QlPQOYhpuWa43+mnlPnEW2B3jMnPF
         ib24hydN4qI9Q==
Message-ID: <b9bc5d1b-f299-f543-7be3-f61e77e05e0f@dorminy.me>
Date:   Thu, 21 Jul 2022 10:32:42 -0400
MIME-Version: 1.0
Subject: Re: [PATCH v2] btrfs: do not batch insert non-consecutive dir indexes
 during log replay
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Cc:     Filipe Manana <fdmanana@suse.com>
References: <a69adbc22b4b4340a7289d8b9bbb9878d6c00192.1658411151.git.josef@toxicpanda.com>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <a69adbc22b4b4340a7289d8b9bbb9878d6c00192.1658411151.git.josef@toxicpanda.com>
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



On 7/21/22 09:47, Josef Bacik wrote:
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
> batching if there's a gap in the key space.
> 
> This file system was left broken from the fstest, I tested this patch
> against the broken fs to make sure it replayed the log properly, and
> then btrfs check'ed the file system after the log replay to verify
> everything was ok.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/delayed-inode.c | 35 +++++++++++++++++++++++++++++++++--
>   1 file changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index 823aa05b3e38..e7f34871a132 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -691,9 +691,22 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
>   	int total_size;
>   	char *ins_data = NULL;
>   	int ret;
> +	bool continuous_keys_only = false;
>   
>   	lockdep_assert_held(&node->mutex);
>   
> +	/*
> +	 * During normal operation the delayed index offset is continuously
> +	 * increasing, so we can batch insert all items as there will not be any
> +	 * overlapping keys in the tree.
> +	 *
> +	 * The exception to this is log replay, where we may have interleaved
> +	 * offsets in the tree, so our batch needs to be continuous keys only in
> +	 * order to ensure we do not end up with out of order items in our leaf.
> +	 */
> +	if (test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags))
> +		continuous_keys_only = true;
> +
>   	/*
>   	 * For delayed items to insert, we track reserved metadata bytes based
>   	 * on the number of leaves that we will use.
> @@ -715,6 +728,14 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
>   		if (!next)
>   			break;
>   
> +		/*
> +		 * We cannot allow gaps in the key space if we're doing log
> +		 * replay.
> +		 */
> +		if (continuous_keys_only &&
> +		    (next->key.offset != curr->key.offset + 1))
> +			break;
> +
>   		ASSERT(next->bytes_reserved == 0);
>   
>   		next_size = next->data_len + sizeof(struct btrfs_item);
> @@ -775,7 +796,17 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
>   
>   	ASSERT(node->index_item_leaves > 0);
>   
> -	if (next) {
> +	/*
> +	 * For normal operations we will batch an entire leaf's worth of delayed
> +	 * items, so if there are more items to process we can decrement
> +	 * index_item_leaves by 1 as we inserted 1 leaf's worth of items.
> +	 *
> +	 * However for log replay we may not have inserted an entire leaf's
> +	 * worth of items, we may have not had continuous items, so decrementing
> +	 * here would mess up the index_item_leaves accounting.  For this case
> +	 * only clean up the accounting when there are no items left.
> +	 */
> +	if (next && !continuous_keys_only) {
>   		/*
>   		 * We inserted one batch of items into a leaf a there are more
>   		 * items to flush in a future batch, now release one unit of
> @@ -784,7 +815,7 @@ static int btrfs_insert_delayed_item(struct btrfs_trans_handle *trans,
>   		 */
>   		btrfs_delayed_item_release_leaves(node, 1);
>   		node->index_item_leaves--;
> -	} else {
> +	} else if (!next) {
>   		/*
>   		 * There are no more items to insert. We can have a number of
>   		 * reserved leaves > 1 here - this happens when many dir index
Looks great, thank you!
