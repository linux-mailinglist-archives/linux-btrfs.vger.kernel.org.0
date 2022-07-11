Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF43D56D805
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jul 2022 10:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiGKIba (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jul 2022 04:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiGKIbB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jul 2022 04:31:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6E81F2E5
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jul 2022 01:30:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DD0482012C;
        Mon, 11 Jul 2022 08:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657528251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nPmAXsCMhgaiHpDWW8CIjvzwoipLvUxjzgKbGkiibAo=;
        b=lpHKn4fJV3BysMo/mqABldKc08XeDdVIPdIge65yDsGwUNAbkCUHNNZF9hK5wc6vkFW3kd
        Hm7cI4zQcsgUM4MwFSnDVC/Qj//ugEosLoIdIWzyQh0ldXHD8j5XF2c+58k6nSL+D8GChg
        t2FVJ741KkpY6T2qrTxCCip8Hayla/8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B080A13322;
        Mon, 11 Jul 2022 08:30:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sDc8KLvfy2JoJgAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 11 Jul 2022 08:30:51 +0000
Message-ID: <5db1f702-f6fa-3b0e-e34b-30c7ac6358e4@suse.com>
Date:   Mon, 11 Jul 2022 11:30:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] btrfs: don't update the block group item if used bytes
 are the same
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <64e4434370badd801a79a782613c405830475dde.1657521468.git.wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <64e4434370badd801a79a782613c405830475dde.1657521468.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11.07.22 г. 9:37 ч., Qu Wenruo wrote:
> When committing a transaction, we will update block group items for all
> dirty block groups.
> 
> But in fact, dirty block groups don't always need to update their block
> group items.
> It's pretty common to have a metadata block group which experienced
> several CoW operations, but still have the same amount of used bytes.

This could happen if for example the allocated/freed extents in a single 
transaction cancel each other out, right? Are there other cases where it 
could matter?

> 
> In that case, we may unnecessarily CoW a tree block doing nothing.
> 
> This patch will introduce btrfs_block_group::commit_used member to
> remember the last used bytes, and use that new member to skip
> unnecessary block group item update.
> 
> This would be more common for large fs, which metadata block group can
> be as large as 1GiB, containing at most 64K metadata items.
> 
> In that case, if CoW added and the deleted one metadata item near the end
> of the block group, then it's completely possible we don't need to touch
> the block group item at all.
> 
> I don't have any benchmark to prove this, but this should not cause any
> hurt either.

It should not but adds more state and is overall a maintenance burden. 
One way to test this would be to rig up the fs to count how many times 
the optimization has been hit over the course of, say, a full xfstest 
run or at least demonstrate a particular workload where this makes 
tangible difference.

> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/block-group.c | 6 ++++++
>   fs/btrfs/block-group.h | 6 ++++++
>   2 files changed, 12 insertions(+)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 0148a6d719a4..5b08ac282ace 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -2024,6 +2024,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
>   
>   	cache->length = key->offset;
>   	cache->used = btrfs_stack_block_group_used(bgi);
> +	cache->commit_used = cache->used;
>   	cache->flags = btrfs_stack_block_group_flags(bgi);
>   	cache->global_root_id = btrfs_stack_block_group_chunk_objectid(bgi);
>   
> @@ -2724,6 +2725,10 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
>   	struct btrfs_block_group_item bgi;
>   	struct btrfs_key key;
>   
> +	/* No change in used bytes, can safely skip it. */
> +	if (cache->commit_used == cache->used)
> +		return 0;
> +
>   	key.objectid = cache->start;
>   	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
>   	key.offset = cache->length;
> @@ -2743,6 +2748,7 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
>   	btrfs_set_stack_block_group_flags(&bgi, cache->flags);
>   	write_extent_buffer(leaf, &bgi, bi, sizeof(bgi));
>   	btrfs_mark_buffer_dirty(leaf);
> +	cache->commit_used = cache->used;
>   fail:
>   	btrfs_release_path(path);
>   	return ret;
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index 35e0e860cc0b..3f92b8eb9a05 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -74,6 +74,12 @@ struct btrfs_block_group {
>   	u64 cache_generation;
>   	u64 global_root_id;
>   
> +	/*
> +	 * The last committed used bytes of this block group, if above @used
> +	 * is still the same as @commit_used, we don't need to update block
> +	 * group item of this block group.
> +	 */
> +	u64 commit_used;
>   	/*
>   	 * If the free space extent count exceeds this number, convert the block
>   	 * group to bitmaps.
