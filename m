Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1DB3BEA9F
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jul 2021 17:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbhGGPYO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jul 2021 11:24:14 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43354 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbhGGPYO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jul 2021 11:24:14 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2122822630;
        Wed,  7 Jul 2021 15:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625671293;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ANxDJhwDrw0cO8J1jQ08ilZGAsr75xAiZo8fw2Jc61s=;
        b=oJHFcPq7r9AzAxUkl0Juw9KAKVEwb4uwaUoy0NHheIdqyQP8x2wQCNpG/l3mUlDf9DOkIJ
        9VLyZpnLhuqZObvb+jVH3RufhTJ3MWMEgiTaCDzgsSQB8VWgu5X8p6QeHdfvTlej7HdUro
        a6LlwCJV3QA0i/W1kqhxTpmVmMlRbr0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625671293;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ANxDJhwDrw0cO8J1jQ08ilZGAsr75xAiZo8fw2Jc61s=;
        b=8+DiWTjQLTVfiicnUGa+OBTbQsR6ToF2xLidQoboFhRHZ9c6XdNjvfrLcJW+g+6g8q+nEX
        URctLlkqnVu35MCQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1A68FA3B98;
        Wed,  7 Jul 2021 15:21:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5A16BDA6FD; Wed,  7 Jul 2021 17:18:59 +0200 (CEST)
Date:   Wed, 7 Jul 2021 17:18:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3] btrfs: make btrfs_finish_chunk_alloc private to
 block-group.c
Message-ID: <20210707151859.GO2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210705092919.3408670-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705092919.3408670-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 05, 2021 at 12:29:19PM +0300, Nikolay Borisov wrote:
> One of the final things that must be done to add a new chunk is
> inserting its device extent items in the device tree. They describe
> the portion of allocated device physical space during phase 1 of
> chunk allocation. This is currently done in btrfs_finish_chunk_alloc
> whose name isn't very informative. What's more, this function is only
> used in block-group.c but is defined as public. There isn't anything
> special about it that would warrant it being defined in volumes.c.
> 
> Just move btrfs_finish_chunk_alloc and alloc_chunk_dev_extent to
> block-group.c, make the former static and rename both functions to
> insert_dev_extents and insert_dev_extent respectively.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Added to misc-next, thanks.

> ---
> V3:
>  * Fixed some typos in changelog and a factual mistake.
>  * Removed 2 extra new lines.
> V2:
>  * Give the 2 moved functions better names.
>  * Improve changelog to correctly reflect reality.
> 
>  fs/btrfs/block-group.c | 96 +++++++++++++++++++++++++++++++++++++++++-
>  fs/btrfs/volumes.c     | 92 ----------------------------------------
>  fs/btrfs/volumes.h     |  2 -
>  3 files changed, 94 insertions(+), 96 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index c557327b4545..d62760aaf041 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -2236,6 +2236,98 @@ static int insert_block_group_item(struct btrfs_trans_handle *trans,
>  	return btrfs_insert_item(trans, root, &key, &bgi, sizeof(bgi));
>  }
> 
> +static int insert_dev_extent(struct btrfs_trans_handle *trans,
> +			    struct btrfs_device *device, u64 chunk_offset,
> +			    u64 start, u64 num_bytes)
> +{
> +	int ret;
> +	struct btrfs_path *path;
> +	struct btrfs_fs_info *fs_info = device->fs_info;
> +	struct btrfs_root *root = fs_info->dev_root;
> +	struct btrfs_dev_extent *extent;
> +	struct extent_buffer *leaf;
> +	struct btrfs_key key;
> +
> +	WARN_ON(!test_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state));
> +	WARN_ON(test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state));
> +	path = btrfs_alloc_path();
> +	if (!path)
> +		return -ENOMEM;
> +
> +	key.objectid = device->devid;
> +	key.offset = start;
> +	key.type = BTRFS_DEV_EXTENT_KEY;
> +	ret = btrfs_insert_empty_item(trans, root, path, &key,
> +				      sizeof(*extent));

The code got moved, so in this case you can fix the style like here the
sizeof(*extent) can be glued to the previous line

> +	if (ret)
> +		goto out;
> +
> +	leaf = path->nodes[0];
> +	extent = btrfs_item_ptr(leaf, path->slots[0],
> +				struct btrfs_dev_extent);

similar here

> +	btrfs_set_dev_extent_chunk_tree(leaf, extent,
> +					BTRFS_CHUNK_TREE_OBJECTID);

and here.

No big deal if you don't as I do a style only pass for each patch once
the functional review is done, but this is the on of the few
opportunities to fix style of old code.
