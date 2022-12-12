Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B68864A7CA
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Dec 2022 20:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbiLLTBN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 14:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbiLLTAl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 14:00:41 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7674B17A93
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 10:58:09 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id i20so3226192qtw.9
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 10:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sYiVZqJEBNwW8FLg32d3kMnL2qIG5Xckl11+tt4nbmo=;
        b=vdL2EVZZ/DtrzYP/3QRSAij4++NTi0H9tNLcjJ7LdIkr3rhHDeGU5nYCYNezD5Zko3
         OWJyIJjZBsQkLtRyGUUxdNYjgkCBq/NQF2YClIgyyu3pwve/qDnoQLwa2znDcZ1nRDNE
         JIiGE1nK2or10mukU9f56ZBum0FeNo67FrcEk6CaTuxWXga2rh4m0rGJGGA6hs0cCzox
         igKw+CigwKl6vHWlnBAE6FjzbJzXjnXNQ5qDUnmYojRnvTSjQhny0qbypVbhRk7a7CsV
         qxlve5XOyB81ypDSjEZ8RD3dhtsAMWbpD7EoeDbFghekIGxslJIVGTPDZIkC0gzED/q7
         H9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYiVZqJEBNwW8FLg32d3kMnL2qIG5Xckl11+tt4nbmo=;
        b=hPK6k15qvKb9NOowTsg42LYlia5Wi0XtBGGZk+GkyXZQ4tNfQZSfu1MYYKYeTp2oCr
         9oviquE7fSSDuUy63fcPOXnYqEgstVtVuMClFjeP302pljEokcQQtnde1VsKB3JqeEQ7
         PQbbeQRpPOPXdYf0Gvj9BKRRwjeF1N66ei41LGRtLB0k+JbF6wZt9C6NuZfH0iMYHWsp
         fE/4TofNElA/Lrgu5NS1RlkSRUxGWgSJ8+8gh4wGMw91Vv8Tghn564O6RERBTQ6cOosZ
         M/nC+LMTvazQjnwHnibL0WQ3NJdpQ2UYeb1Owl2lsTQClBo+2FI1V0221KahhWZbofQN
         FY/A==
X-Gm-Message-State: ANoB5plBpE4lhI+FH+iyJfcG0+0PMCk08jDaSWruEaY1kVvdjZq9506o
        d8pVyGP0csFaYqHvK/K7thufzg==
X-Google-Smtp-Source: AA0mqf6tSANmRJsNjA2ulXeCVC8nQ5LPeUFXIbCi4uppysXp0TR7vRCLZzK9YOKnesDXVJLiwt+mwg==
X-Received: by 2002:a05:622a:5a09:b0:39c:da20:634 with SMTP id fy9-20020a05622a5a0900b0039cda200634mr47472qtb.62.1670871488376;
        Mon, 12 Dec 2022 10:58:08 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id g1-20020ac84801000000b003a689a5b177sm6152625qtq.8.2022.12.12.10.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 10:58:07 -0800 (PST)
Date:   Mon, 12 Dec 2022 13:58:06 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/7] btrfs; rename the disk_bytenr in strut
 btrfs_ordered_extent
Message-ID: <Y5d5vuENR9vIltLs@localhost.localdomain>
References: <20221212073724.12637-1-hch@lst.de>
 <20221212073724.12637-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212073724.12637-3-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 12, 2022 at 08:37:19AM +0100, Christoph Hellwig wrote:
> Rename the disk_bytenr field to logical to make it clear it holds
> a btrfs logical address.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/btrfs/inode.c             | 18 +++++++++---------
>  fs/btrfs/ordered-data.c      | 10 +++++-----
>  fs/btrfs/ordered-data.h      |  2 +-
>  fs/btrfs/relocation.c        |  2 +-
>  fs/btrfs/zoned.c             |  4 ++--
>  include/trace/events/btrfs.h |  2 +-
>  6 files changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 373b7281f5c7dd..3a3a3e0e9484c6 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2667,9 +2667,9 @@ blk_status_t btrfs_extract_ordered_extent(struct btrfs_bio *bbio)
>  		goto out;
>  	}
>  
> -	ordered_end = ordered->disk_bytenr + ordered->disk_num_bytes;
> +	ordered_end = ordered->logical + ordered->disk_num_bytes;
>  	/* bio must be in one ordered extent */
> -	if (WARN_ON_ONCE(start < ordered->disk_bytenr || end > ordered_end)) {
> +	if (WARN_ON_ONCE(start < ordered->logical || end > ordered_end)) {
>  		ret = -EINVAL;
>  		goto out;
>  	}
> @@ -2681,7 +2681,7 @@ blk_status_t btrfs_extract_ordered_extent(struct btrfs_bio *bbio)
>  	}
>  
>  	file_len = ordered->num_bytes;
> -	pre = start - ordered->disk_bytenr;
> +	pre = start - ordered->logical;
>  	post = ordered_end - end;
>  
>  	ret = btrfs_split_ordered_extent(ordered, pre, post);
> @@ -3094,7 +3094,7 @@ static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
>  
>  	memset(&stack_fi, 0, sizeof(stack_fi));
>  	btrfs_set_stack_file_extent_type(&stack_fi, BTRFS_FILE_EXTENT_REG);
> -	btrfs_set_stack_file_extent_disk_bytenr(&stack_fi, oe->disk_bytenr);
> +	btrfs_set_stack_file_extent_disk_bytenr(&stack_fi, oe->logical);
>  	btrfs_set_stack_file_extent_disk_num_bytes(&stack_fi,
>  						   oe->disk_num_bytes);
>  	btrfs_set_stack_file_extent_offset(&stack_fi, oe->offset);
> @@ -3165,7 +3165,7 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
>  	/* A valid bdev implies a write on a sequential zone */
>  	if (ordered_extent->bdev) {
>  		btrfs_rewrite_logical_zoned(ordered_extent);
> -		btrfs_zone_finish_endio(fs_info, ordered_extent->disk_bytenr,
> +		btrfs_zone_finish_endio(fs_info, ordered_extent->logical,
>  					ordered_extent->disk_num_bytes);
>  	}
>  
> @@ -3220,7 +3220,7 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
>  						ordered_extent->file_offset,
>  						ordered_extent->file_offset +
>  						logical_len);
> -		btrfs_zoned_release_data_reloc_bg(fs_info, ordered_extent->disk_bytenr,
> +		btrfs_zoned_release_data_reloc_bg(fs_info, ordered_extent->logical,
>  						  ordered_extent->disk_num_bytes);
>  	} else {
>  		BUG_ON(root == fs_info->tree_root);
> @@ -3228,7 +3228,7 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
>  		if (!ret) {
>  			clear_reserved_extent = false;
>  			btrfs_release_delalloc_bytes(fs_info,
> -						ordered_extent->disk_bytenr,
> +						ordered_extent->logical,
>  						ordered_extent->disk_num_bytes);
>  		}
>  	}
> @@ -3312,11 +3312,11 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
>  			 */
>  			if (ret && btrfs_test_opt(fs_info, DISCARD_SYNC))
>  				btrfs_discard_extent(fs_info,
> -						ordered_extent->disk_bytenr,
> +						ordered_extent->logical,
>  						ordered_extent->disk_num_bytes,
>  						NULL);
>  			btrfs_free_reserved_extent(fs_info,
> -					ordered_extent->disk_bytenr,
> +					ordered_extent->logical,
>  					ordered_extent->disk_num_bytes, 1);
>  		}
>  	}
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index 4bed0839b64033..72e1acd4624169 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -199,7 +199,7 @@ int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
>  	entry->file_offset = file_offset;
>  	entry->num_bytes = num_bytes;
>  	entry->ram_bytes = ram_bytes;
> -	entry->disk_bytenr = disk_bytenr;
> +	entry->logical = disk_bytenr;
>  	entry->disk_num_bytes = disk_num_bytes;
>  	entry->offset = offset;
>  	entry->bytes_left = num_bytes;
> @@ -642,8 +642,8 @@ u64 btrfs_wait_ordered_extents(struct btrfs_root *root, u64 nr,
>  		ordered = list_first_entry(&splice, struct btrfs_ordered_extent,
>  					   root_extent_list);
>  
> -		if (range_end <= ordered->disk_bytenr ||
> -		    ordered->disk_bytenr + ordered->disk_num_bytes <= range_start) {
> +		if (range_end <= ordered->logical ||
> +		    ordered->logical + ordered->disk_num_bytes <= range_start) {
>  			list_move_tail(&ordered->root_extent_list, &skipped);
>  			cond_resched_lock(&root->ordered_extent_lock);
>  			continue;
> @@ -1098,7 +1098,7 @@ static int clone_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pos,
>  	struct inode *inode = ordered->inode;
>  	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
>  	u64 file_offset = ordered->file_offset + pos;
> -	u64 disk_bytenr = ordered->disk_bytenr + pos;
> +	u64 disk_bytenr = ordered->logical + pos;
>  	unsigned long flags = ordered->flags & BTRFS_ORDERED_TYPE_FLAGS;
>  
>  	/*
> @@ -1133,7 +1133,7 @@ int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pre,
>  		tree->last = NULL;
>  
>  	ordered->file_offset += pre;
> -	ordered->disk_bytenr += pre;
> +	ordered->logical += pre;
>  	ordered->num_bytes -= (pre + post);
>  	ordered->disk_num_bytes -= (pre + post);
>  	ordered->bytes_left -= (pre + post);
> diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
> index 89f82b78f590f3..71f200b14a9369 100644
> --- a/fs/btrfs/ordered-data.h
> +++ b/fs/btrfs/ordered-data.h
> @@ -96,7 +96,7 @@ struct btrfs_ordered_extent {
>  	 */
>  	u64 num_bytes;
>  	u64 ram_bytes;
> -	u64 disk_bytenr;
> +	u64 logical;

There's a comment above here that reads

        /*                                                                                                                            
         * These fields directly correspond to the same fields in                                                                     
         * btrfs_file_extent_item.
         */

which with this change is no longer true.  Please update the comment
appropriately, other than that the change is reasonable to me, you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

once you've updated the patch.  Thanks,

Josef
