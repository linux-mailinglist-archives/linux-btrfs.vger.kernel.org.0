Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8CA4B2B8A
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Feb 2022 18:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348321AbiBKRQS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Feb 2022 12:16:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbiBKRQR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Feb 2022 12:16:17 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C530F95
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 09:16:15 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 80BB42113A;
        Fri, 11 Feb 2022 17:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644599774;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+vH7kc3IT0ucFGO/9gwS8kFPGtBg3+D2xbb6I7Y26Nk=;
        b=NkD3MfVeZNj0hwePyEWNulLLmgOuK5z2pSOgpg1D4pJcZhjJfN9xrE3Kd6HKlZer6px9to
        qOQqvxXHEBM5TeMSW3CpHo8yHBHFXxajStDQKz6VnbRv0cYQ/xIFR3HxKzgaurGxBlqZnc
        8Ox/VB2Kf/l/Fn95nuAW4Zevm2rIPoo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644599774;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+vH7kc3IT0ucFGO/9gwS8kFPGtBg3+D2xbb6I7Y26Nk=;
        b=3cyPb3pK7wTuuKjv/L+ZKyW3y1pZ4ukEP9UvXAne9vaWk3DpnV4pflI6tjo66/g/z7cUBC
        0YNf2yU3pC70KcCQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 75258A3B87;
        Fri, 11 Feb 2022 17:16:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7F6F8DA823; Fri, 11 Feb 2022 18:12:32 +0100 (CET)
Date:   Fri, 11 Feb 2022 18:12:32 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v13 04/17] btrfs: add ram_bytes and offset to
 btrfs_ordered_extent
Message-ID: <20220211171232.GB12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1644519257.git.osandov@fb.com>
 <0b3f7ed73c87963a3ab5513494e9a3d4d248c59c.1644519257.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b3f7ed73c87963a3ab5513494e9a3d4d248c59c.1644519257.git.osandov@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 10, 2022 at 11:09:54AM -0800, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Currently, we only create ordered extents when ram_bytes == num_bytes
> and offset == 0. However, BTRFS_IOC_ENCODED_WRITE writes may create
> extents which only refer to a subset of the full unencoded extent, so we
> need to plumb these fields through the ordered extent infrastructure and
> pass them down to insert_reserved_file_extent().
> 
> Since we're changing the btrfs_add_ordered_extent* signature, let's get
> rid of the trivial wrappers and add a kernel-doc.
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  fs/btrfs/inode.c        |  58 ++++++++++++--------
>  fs/btrfs/ordered-data.c | 119 ++++++++++++----------------------------
>  fs/btrfs/ordered-data.h |  22 +++++---
>  3 files changed, 82 insertions(+), 117 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 1fadbdc25168..55fa13221f5c 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -985,11 +985,14 @@ static int submit_one_async_extent(struct btrfs_inode *inode,
>  	}
>  	free_extent_map(em);
>  
> -	ret = btrfs_add_ordered_extent_compress(inode, start,	/* file_offset */
> -					ins.objectid,		/* disk_bytenr */
> -					async_extent->ram_size, /* num_bytes */
> -					ins.offset,		/* disk_num_bytes */
> -					async_extent->compress_type);
> +	ret = btrfs_add_ordered_extent(inode, start,		/* file_offset */
> +				       async_extent->ram_size,	/* num_bytes */
> +				       async_extent->ram_size,	/* ram_bytes */
> +				       ins.objectid,		/* disk_bytenr */
> +				       ins.offset,		/* disk_num_bytes */
> +				       0,			/* offset */
> +				       1 << BTRFS_ORDERED_COMPRESSED,
> +				       async_extent->compress_type);
>  	if (ret) {
>  		btrfs_drop_extent_cache(inode, start, end, 0);
>  		goto out_free_reserve;
> @@ -1238,9 +1241,10 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>  		}
>  		free_extent_map(em);
>  
> -		ret = btrfs_add_ordered_extent(inode, start, ins.objectid,
> -					       ram_size, cur_alloc_size,
> -					       BTRFS_ORDERED_REGULAR);
> +		ret = btrfs_add_ordered_extent(inode, start, ram_size, ram_size,
> +					       ins.objectid, cur_alloc_size, 0,
> +					       1 << BTRFS_ORDERED_REGULAR,
> +					       BTRFS_COMPRESS_NONE);
>  		if (ret)
>  			goto out_drop_extent_cache;
>  
> @@ -1899,10 +1903,11 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
>  				goto error;
>  			}
>  			free_extent_map(em);
> -			ret = btrfs_add_ordered_extent(inode, cur_offset,
> -						       disk_bytenr, num_bytes,
> -						       num_bytes,
> -						       BTRFS_ORDERED_PREALLOC);
> +			ret = btrfs_add_ordered_extent(inode,
> +					cur_offset, num_bytes, num_bytes,
> +					disk_bytenr, num_bytes, 0,
> +					1 << BTRFS_ORDERED_PREALLOC,
> +					BTRFS_COMPRESS_NONE);
>  			if (ret) {
>  				btrfs_drop_extent_cache(inode, cur_offset,
>  							cur_offset + num_bytes - 1,
> @@ -1911,9 +1916,11 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
>  			}
>  		} else {
>  			ret = btrfs_add_ordered_extent(inode, cur_offset,
> +						       num_bytes, num_bytes,
>  						       disk_bytenr, num_bytes,
> -						       num_bytes,
> -						       BTRFS_ORDERED_NOCOW);
> +						       0,
> +						       1 << BTRFS_ORDERED_NOCOW,
> +						       BTRFS_COMPRESS_NONE);
>  			if (ret)
>  				goto error;
>  		}
> @@ -2874,6 +2881,7 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
>  	struct btrfs_key ins;
>  	u64 disk_num_bytes = btrfs_stack_file_extent_disk_num_bytes(stack_fi);
>  	u64 disk_bytenr = btrfs_stack_file_extent_disk_bytenr(stack_fi);
> +	u64 offset = btrfs_stack_file_extent_offset(stack_fi);
>  	u64 num_bytes = btrfs_stack_file_extent_num_bytes(stack_fi);
>  	u64 ram_bytes = btrfs_stack_file_extent_ram_bytes(stack_fi);
>  	struct btrfs_drop_extents_args drop_args = { 0 };
> @@ -2948,7 +2956,8 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
>  		goto out;
>  
>  	ret = btrfs_alloc_reserved_file_extent(trans, root, btrfs_ino(inode),
> -					       file_pos, qgroup_reserved, &ins);
> +					       file_pos - offset,
> +					       qgroup_reserved, &ins);
>  out:
>  	btrfs_free_path(path);
>  
> @@ -2974,20 +2983,20 @@ static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
>  					     struct btrfs_ordered_extent *oe)
>  {
>  	struct btrfs_file_extent_item stack_fi;
> -	u64 logical_len;
>  	bool update_inode_bytes;
> +	u64 num_bytes = oe->num_bytes;
> +	u64 ram_bytes = oe->ram_bytes;
>  
>  	memset(&stack_fi, 0, sizeof(stack_fi));
>  	btrfs_set_stack_file_extent_type(&stack_fi, BTRFS_FILE_EXTENT_REG);
>  	btrfs_set_stack_file_extent_disk_bytenr(&stack_fi, oe->disk_bytenr);
>  	btrfs_set_stack_file_extent_disk_num_bytes(&stack_fi,
>  						   oe->disk_num_bytes);
> +	btrfs_set_stack_file_extent_offset(&stack_fi, oe->offset);
>  	if (test_bit(BTRFS_ORDERED_TRUNCATED, &oe->flags))
> -		logical_len = oe->truncated_len;
> -	else
> -		logical_len = oe->num_bytes;
> -	btrfs_set_stack_file_extent_num_bytes(&stack_fi, logical_len);
> -	btrfs_set_stack_file_extent_ram_bytes(&stack_fi, logical_len);
> +		num_bytes = ram_bytes = oe->truncated_len;
> +	btrfs_set_stack_file_extent_num_bytes(&stack_fi, num_bytes);
> +	btrfs_set_stack_file_extent_ram_bytes(&stack_fi, ram_bytes);
>  	btrfs_set_stack_file_extent_compression(&stack_fi, oe->compress_type);
>  	/* Encryption and other encoding is reserved and all 0 */
>  
> @@ -7054,8 +7063,11 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
>  		if (IS_ERR(em))
>  			goto out;
>  	}
> -	ret = btrfs_add_ordered_extent_dio(inode, start, block_start, len,
> -					   block_len, type);
> +	ret = btrfs_add_ordered_extent(inode, start, len, len, block_start,
> +				       block_len, 0,
> +				       (1 << type) |
> +				       (1 << BTRFS_ORDERED_DIRECT),
> +				       BTRFS_COMPRESS_NONE);
>  	if (ret) {
>  		if (em) {
>  			free_extent_map(em);
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index 6b51fd2ec5ac..5e4c59b00b01 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -143,16 +143,27 @@ static inline struct rb_node *tree_search(struct btrfs_ordered_inode_tree *tree,
>  	return ret;
>  }
>  
> -/*
> - * Allocate and add a new ordered_extent into the per-inode tree.
> +/**
> + * btrfs_add_ordered_extent - Add an ordered extent to the per-inode tree.
> + * @inode: inode that this extent is for.
> + * @file_offset: Logical offset in file where the extent starts.
> + * @num_bytes: Logical length of extent in file.
> + * @ram_bytes: Full length of unencoded data.
> + * @disk_bytenr: Offset of extent on disk.
> + * @disk_num_bytes: Size of extent on disk.
> + * @offset: Offset into unencoded data where file data starts.
> + * @flags: Flags specifying type of extent (1 << BTRFS_ORDERED_*).
> + * @compress_type: Compression algorithm used for data.

The parameter descriptions should be aligned, also you can drop the
function name from the first line. Fixed.

>   *
> - * The tree is given a single reference on the ordered extent that was
> - * inserted.
> + * Most of these parameters correspond to &struct btrfs_file_extent_item. The
> + * tree is given a single reference on the ordered extent that was inserted.
> + *
> + * Return: 0 or -ENOMEM.
>   */
> -static int __btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
> -				      u64 disk_bytenr, u64 num_bytes,
> -				      u64 disk_num_bytes, int type, int dio,
> -				      int compress_type)
> +int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
> +			     u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
> +			     u64 disk_num_bytes, u64 offset, int flags,

All flags variables should be unsgined, so the bitwise ops work safely.
