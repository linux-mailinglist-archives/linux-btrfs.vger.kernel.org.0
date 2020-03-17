Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0526188B11
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Mar 2020 17:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgCQQsj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Mar 2020 12:48:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:48660 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbgCQQsi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Mar 2020 12:48:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 72D92AD11;
        Tue, 17 Mar 2020 16:48:37 +0000 (UTC)
Subject: Re: [PATCH 12/15] btrfs: get rid of one layer of bios in direct I/O
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Christoph Hellwig <hch@lst.de>
References: <cover.1583789410.git.osandov@fb.com>
 <f9d0f9e8b8d11ff103654387f4370f50c6c074ae.1583789410.git.osandov@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a34e17d4-45d2-a745-cc06-f76d529cec54@suse.com>
Date:   Tue, 17 Mar 2020 18:48:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <f9d0f9e8b8d11ff103654387f4370f50c6c074ae.1583789410.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 9.03.20 г. 23:32 ч., Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> In the worst case, there are _4_ layers of bios in the Btrfs direct I/O
> path:
> 
> 1. The bio created by the generic direct I/O code (dio_bio).
> 2. A clone of dio_bio we create in btrfs_submit_direct() to represent
>    the entire direct I/O range (orig_bio).
> 3. A partial clone of orig_bio limited to the size of a RAID stripe that
>    we create in btrfs_submit_direct_hook().
> 4. Clones of each of those split bios for each RAID stripe that we
>    create in btrfs_map_bio().
> 
> As of the previous commit, the second layer (orig_bio) is no longer
> needed for anything: we can split dio_bio instead, and complete dio_bio
> directly when all of the cloned bios complete. This lets us clean up a
> bunch of cruft, including dip->subio_endio and dip->errors (we can use
> dio_bio->bi_status instead). It also enables the next big cleanup of
> direct I/O read repair.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  fs/btrfs/inode.c | 213 +++++++++++++++--------------------------------
>  1 file changed, 66 insertions(+), 147 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 4a2e44f3e66e..40c1562704e9 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -54,11 +54,8 @@ struct btrfs_iget_args {
>  	struct btrfs_root *root;
>  };
>  

<snip>

> @@ -7400,6 +7384,29 @@ static int btrfs_get_blocks_direct(struct inode *inode, sector_t iblock,
>  	return ret;
>  }
>  
> +static void btrfs_dio_private_put(struct btrfs_dio_private *dip)
> +{
> +	/*
> +	 * This implies a barrier so that stores to dio_bio->bi_status before
> +	 * this and the following load are fully ordered.
> +	 */

It's not obvious which load this refers to. It's not obvious where this
ordering matters i.e what are the threads that care?

> +	if (!refcount_dec_and_test(&dip->refs))
> +		return;
> +
> +	if (bio_op(dip->dio_bio) == REQ_OP_WRITE) {
> +		__endio_write_update_ordered(dip->inode, dip->logical_offset,
> +					     dip->bytes,
> +					     !dip->dio_bio->bi_status);
> +	} else {
> +		unlock_extent(&BTRFS_I(dip->inode)->io_tree,
> +			      dip->logical_offset,
> +			      dip->logical_offset + dip->bytes - 1);
> +	}
> +
> +	dio_end_io(dip->dio_bio);
> +	kfree(dip);
> +}
> +
>  static inline blk_status_t submit_dio_repair_bio(struct inode *inode,
>  						 struct bio *bio,
>  						 int mirror_num)

<snip>

> @@ -7920,98 +7876,77 @@ static void btrfs_submit_direct_hook(struct btrfs_dio_private *dip)
>  	struct inode *inode = dip->inode;
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>  	struct bio *bio;
> -	struct bio *orig_bio = dip->orig_bio;
> -	u64 start_sector = orig_bio->bi_iter.bi_sector;
> +	struct bio *dio_bio = dip->dio_bio;
> +	u64 start_sector = dio_bio->bi_iter.bi_sector;
>  	u64 file_offset = dip->logical_offset;
>  	int async_submit = 0;
> -	u64 submit_len;
> +	u64 submit_len = dio_bio->bi_iter.bi_size;
>  	int clone_offset = 0;
>  	int clone_len;
>  	int ret;
>  	blk_status_t status;
>  	struct btrfs_io_geometry geom;
>  
> -	submit_len = orig_bio->bi_iter.bi_size;
> -	ret = btrfs_get_io_geometry(fs_info, btrfs_op(orig_bio),
> -				    start_sector << 9, submit_len, &geom);
> -	if (ret)
> -		goto out_err;
> -
> -	if (geom.len >= submit_len) {
> -		bio = orig_bio;
> -		dip->flags |= BTRFS_DIO_ORIG_BIO_SUBMITTED;
> -		goto submit;
> -	}
> -
>  	/* async crcs make it difficult to collect full stripe writes. */
>  	if (btrfs_data_alloc_profile(fs_info) & BTRFS_BLOCK_GROUP_RAID56_MASK)
>  		async_submit = 0;
>  	else
>  		async_submit = 1;
>  
> -	/* bio split */
>  	ASSERT(geom.len <= INT_MAX);

geom.len now contains some random data since it's no longer initialised,
meaning this ASSERT hasn't triggered by pure luck. It should be
(re)moved inside the do {} while loop.

>  	do {
> +		ret = btrfs_get_io_geometry(fs_info, btrfs_op(dio_bio),
> +					    start_sector << 9, submit_len,
> +					    &geom);
> +		if (ret) {
> +			status = errno_to_blk_status(ret);
> +			goto out_err;
> +		}
> +
>  		clone_len = min_t(int, submit_len, geom.len);
>  
>  		/*
>  		 * This will never fail as it's passing GPF_NOFS and
>  		 * the allocation is backed by btrfs_bioset.
>  		 */
> -		bio = btrfs_bio_clone_partial(orig_bio, clone_offset,
> -					      clone_len);
> +		bio = btrfs_bio_clone_partial(dio_bio, clone_offset, clone_len);
>  		bio->bi_private = dip;
>  		bio->bi_end_io = btrfs_end_dio_bio;
>  		btrfs_io_bio(bio)->logical = file_offset;
>  
>  		ASSERT(submit_len >= clone_len);
>  		submit_len -= clone_len;
> -		if (submit_len == 0)
> -			break;
>  
>  		/*
>  		 * Increase the count before we submit the bio so we know
>  		 * the end IO handler won't happen before we increase the
>  		 * count. Otherwise, the dip might get freed before we're
>  		 * done setting it up.
> +		 *
> +		 * We transfer the initial reference to the last bio, so we
> +		 * don't need to increment the reference count for the last one.
>  		 */
> -		refcount_inc(&dip->refs);
> +		if (submit_len > 0)
> +			refcount_inc(&dip->refs);
>  
>  		status = btrfs_submit_dio_bio(bio, inode, file_offset,
>  						async_submit);
>  		if (status) {
>  			bio_put(bio);
> -			refcount_dec(&dip->refs);
> +			if (submit_len > 0)
> +				refcount_dec(&dip->refs);
>  			goto out_err;
>  		}
>  
>  		clone_offset += clone_len;
>  		start_sector += clone_len >> 9;
>  		file_offset += clone_len;
> -
> -		ret = btrfs_get_io_geometry(fs_info, btrfs_op(orig_bio),
> -				      start_sector << 9, submit_len, &geom);
> -		if (ret)
> -			goto out_err;
>  	} while (submit_len > 0);> +	return;

<snip>
