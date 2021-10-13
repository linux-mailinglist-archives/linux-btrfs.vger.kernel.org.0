Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83EFE42C26A
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Oct 2021 16:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbhJMOME (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Oct 2021 10:12:04 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40188 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhJMOMD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Oct 2021 10:12:03 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 846CB223D2;
        Wed, 13 Oct 2021 14:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634134199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BQX8K/jJMrRnI6labpeh5OIHftb5yFfdXE/2MvsEn4I=;
        b=vWGeWNeLJBCkPq9WG9SYvH+Q6vzMT2uRXpv70TlQ42Sg6LgqdA+gtkS4VmeZbN1s1OudKL
        8sQ+8fSxo/++lZ90R01cItxKewrmULHehnXEBkuqRhgO022YKET8B3I93IBxYLjtmXWv80
        8R8B3CHj7+oX2IFKBTxgQMWEttmyD7o=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 51A5813CEC;
        Wed, 13 Oct 2021 14:09:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gOd+EbfoZmFoRwAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 13 Oct 2021 14:09:59 +0000
Subject: Re: [PATCH v3 1/2] btrfs: fix deadlock between chunk allocation and
 chunk btree modifications
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1634115580.git.fdmanana@suse.com>
 <0747812264412ce1a8474ff2ec223010a6dce3a0.1634115580.git.fdmanana@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <f281ca42-cd64-7978-b4c0-17756dd7689c@suse.com>
Date:   Wed, 13 Oct 2021 17:09:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <0747812264412ce1a8474ff2ec223010a6dce3a0.1634115580.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 13.10.21 г. 12:12, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 

<snip>

> 
> Reported-by: Hao Sun <sunhao.th@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/CACkBjsax51i4mu6C0C3vJqQN3NR_iVuucoeG3U1HXjrgzn5FFQ@mail.gmail.com/
> Fixes: 79bd37120b1495 ("btrfs: rework chunk allocation to avoid exhaustion of the system chunk array")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/block-group.c | 145 +++++++++++++++++++++++++----------------
>  fs/btrfs/block-group.h |   2 +
>  fs/btrfs/relocation.c  |   4 ++
>  fs/btrfs/volumes.c     |  15 ++++-
>  4 files changed, 110 insertions(+), 56 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 46fdef7bbe20..e790ea0798c7 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -3403,25 +3403,6 @@ static int do_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags)
>  		goto out;
>  	}
>  
> -	/*
> -	 * If this is a system chunk allocation then stop right here and do not
> -	 * add the chunk item to the chunk btree. This is to prevent a deadlock
> -	 * because this system chunk allocation can be triggered while COWing
> -	 * some extent buffer of the chunk btree and while holding a lock on a
> -	 * parent extent buffer, in which case attempting to insert the chunk
> -	 * item (or update the device item) would result in a deadlock on that
> -	 * parent extent buffer. In this case defer the chunk btree updates to
> -	 * the second phase of chunk allocation and keep our reservation until
> -	 * the second phase completes.
> -	 *
> -	 * This is a rare case and can only be triggered by the very few cases
> -	 * we have where we need to touch the chunk btree outside chunk allocation
> -	 * and chunk removal. These cases are basically adding a device, removing
> -	 * a device or resizing a device.
> -	 */
> -	if (flags & BTRFS_BLOCK_GROUP_SYSTEM)
> -		return 0;
> -
>  	ret = btrfs_chunk_alloc_add_chunk_item(trans, bg);
>  	/*
>  	 * Normally we are not expected to fail with -ENOSPC here, since we have
> @@ -3554,14 +3535,14 @@ static int do_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags)
>   * This has happened before and commit eafa4fd0ad0607 ("btrfs: fix exhaustion of
>   * the system chunk array due to concurrent allocations") provides more details.
>   *
> - * For allocation of system chunks, we defer the updates and insertions into the
> - * chunk btree to phase 2. This is to prevent deadlocks on extent buffers because
> - * if the chunk allocation is triggered while COWing an extent buffer of the
> - * chunk btree, we are holding a lock on the parent of that extent buffer and
> - * doing the chunk btree updates and insertions can require locking that parent.
> - * This is for the very few and rare cases where we update the chunk btree that
> - * are not chunk allocation or chunk removal: adding a device, removing a device
> - * or resizing a device.
> + * Allocation of system chunks does not happen through this function. A task that
> + * needs to update the chunk btree (the only btree that uses system chunks), must
> + * preallocate chunk space by calling either check_system_chunk() or
> + * btrfs_reserve_chunk_metadata() - the former is used when allocating a data or
> + * metadata chunk or when removing a chunk, while the later is used before doing
> + * a modification to the chunk btree - use cases for the later are adding,
> + * removing and resizing a device as well as relocation of a system chunk.
> + * See the comment below for more details.
>   *
>   * The reservation of system space, done through check_system_chunk(), as well
>   * as all the updates and insertions into the chunk btree must be done while
> @@ -3598,11 +3579,27 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
>  	if (trans->allocating_chunk)
>  		return -ENOSPC;
>  	/*
> -	 * If we are removing a chunk, don't re-enter or we would deadlock.
> -	 * System space reservation and system chunk allocation is done by the
> -	 * chunk remove operation (btrfs_remove_chunk()).
> +	 * Allocation of system chunks can not happen through this path, as we
> +	 * could end up in a deadlock if we are allocating a data or metadata
> +	 * chunk and there is another task modifying the chunk btree.
> +	 *
> +	 * This is because while we are holding the chunk mutex, we will attempt
> +	 * to add the new chunk item to the chunk btree or update an existing
> +	 * device item in the chunk btree, while the other task that is modifying
> +	 * the chunk btree is attempting to COW an extent buffer while holding a
> +	 * lock on it and on its parent - if the COW operation triggers a system
> +	 * chunk allocation, then we can deadlock because we are holding the
> +	 * chunk mutex and we may need to access that extent buffer or its parent
> +	 * in order to add the chunk item or update a device item.
> +	 *
> +	 * Tasks that want to modify the chunk tree should reserve system space
> +	 * before updating the chunk btree, by calling either
> +	 * btrfs_reserve_chunk_metadata() or check_system_chunk().
> +	 * It's possible that after a task reserves the space, it still ends up
> +	 * here - this happens in the cases described above at do_chunk_alloc().
> +	 * The task will have to either retry or fail.
>  	 */
> -	if (trans->removing_chunk)
> +	if (flags & BTRFS_BLOCK_GROUP_SYSTEM)
>  		return -ENOSPC;
>  
>  	space_info = btrfs_find_space_info(fs_info, flags);
> @@ -3701,17 +3698,14 @@ static u64 get_profile_num_devs(struct btrfs_fs_info *fs_info, u64 type)
>  	return num_dev;
>  }
>  
> -/*
> - * Reserve space in the system space for allocating or removing a chunk
> - */
> -void check_system_chunk(struct btrfs_trans_handle *trans, u64 type)
> +static void reserve_chunk_space(struct btrfs_trans_handle *trans,
> +				u64 bytes,
> +				u64 type)
>  {
>  	struct btrfs_fs_info *fs_info = trans->fs_info;
>  	struct btrfs_space_info *info;
>  	u64 left;
> -	u64 thresh;
>  	int ret = 0;
> -	u64 num_devs;
>  
>  	/*
>  	 * Needed because we can end up allocating a system chunk and for an
> @@ -3724,19 +3718,13 @@ void check_system_chunk(struct btrfs_trans_handle *trans, u64 type)
>  	left = info->total_bytes - btrfs_space_info_used(info, true);
>  	spin_unlock(&info->lock);
>  
> -	num_devs = get_profile_num_devs(fs_info, type);
> -
> -	/* num_devs device items to update and 1 chunk item to add or remove */
> -	thresh = btrfs_calc_metadata_size(fs_info, num_devs) +
> -		btrfs_calc_insert_metadata_size(fs_info, 1);
> -
> -	if (left < thresh && btrfs_test_opt(fs_info, ENOSPC_DEBUG)) {
> +	if (left < bytes && btrfs_test_opt(fs_info, ENOSPC_DEBUG)) {
>  		btrfs_info(fs_info, "left=%llu, need=%llu, flags=%llu",
> -			   left, thresh, type);
> +			   left, bytes, type);
>  		btrfs_dump_space_info(fs_info, info, 0, 0);
>  	}

This can be simplified to if (btrfs_test_opt(fs_info, ENOSPC_DEBUG)) 
and nested inside the next if (left < bytes). I checked 
and even with the extra nesting the code doesn't break the 76 char limit. 

>  
> -	if (left < thresh) {
> +	if (left < bytes) {
>  		u64 flags = btrfs_system_alloc_profile(fs_info);
>  		struct btrfs_block_group *bg;
>  
> @@ -3745,21 +3733,20 @@ void check_system_chunk(struct btrfs_trans_handle *trans, u64 type)
>  		 * needing it, as we might not need to COW all nodes/leafs from
>  		 * the paths we visit in the chunk tree (they were already COWed
>  		 * or created in the current transaction for example).
> -		 *
> -		 * Also, if our caller is allocating a system chunk, do not
> -		 * attempt to insert the chunk item in the chunk btree, as we
> -		 * could deadlock on an extent buffer since our caller may be
> -		 * COWing an extent buffer from the chunk btree.
>  		 */
>  		bg = btrfs_create_chunk(trans, flags);
>  		if (IS_ERR(bg)) {
>  			ret = PTR_ERR(bg);
> -		} else if (!(type & BTRFS_BLOCK_GROUP_SYSTEM)) {
> +		} else {

This can be turned into a simple if (!IS_ERR(bg)) {}


>  			/*
>  			 * If we fail to add the chunk item here, we end up
>  			 * trying again at phase 2 of chunk allocation, at
>  			 * btrfs_create_pending_block_groups(). So ignore
> -			 * any error here.
> +			 * any error here. An ENOSPC here could happen, due to
> +			 * the cases described at do_chunk_alloc() - the system
> +			 * block group we just created was just turned into RO
> +			 * mode by a scrub for example, or a running discard
> +			 * temporarily removed its free space entries, etc.
>  			 */
>  			btrfs_chunk_alloc_add_chunk_item(trans, bg);
>  		}
> @@ -3768,12 +3755,60 @@ void check_system_chunk(struct btrfs_trans_handle *trans, u64 type)
>  	if (!ret) {
>  		ret = btrfs_block_rsv_add(fs_info->chunk_root,
>  					  &fs_info->chunk_block_rsv,
> -					  thresh, BTRFS_RESERVE_NO_FLUSH);
> +					  bytes, BTRFS_RESERVE_NO_FLUSH);
>  		if (!ret)
> -			trans->chunk_bytes_reserved += thresh;
> +			trans->chunk_bytes_reserved += bytes;
>  	}

The single btrfs_block_rsv_add call and the addition of bytes to chunk_bytes_reserved 
can be collapsed into the above branch. The end result looks like: https://pastebin.com/F09TjVWp

This is results in slightly shorter and more linear code => easy to read. 


>  }
>  
> +/*
> + * Reserve space in the system space for allocating or removing a chunk.
> + * The caller must be holding fs_info->chunk_mutex.

Better to use lockdep_assert_held. 

> + */
> +void check_system_chunk(struct btrfs_trans_handle *trans, u64 type)
> +{
> +	struct btrfs_fs_info *fs_info = trans->fs_info;
> +	const u64 num_devs = get_profile_num_devs(fs_info, type);
> +	u64 bytes;
> +
> +	/* num_devs device items to update and 1 chunk item to add or remove. */
> +	bytes = btrfs_calc_metadata_size(fs_info, num_devs) +
> +		btrfs_calc_insert_metadata_size(fs_info, 1);
> +
> +	reserve_chunk_space(trans, bytes, type);
> +}
> +

<snip>
