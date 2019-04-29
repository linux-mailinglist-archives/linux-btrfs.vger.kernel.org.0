Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47B4CEA28
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2019 20:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbfD2ScX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Apr 2019 14:32:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:39834 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728844AbfD2ScX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Apr 2019 14:32:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F2F68AE8B;
        Mon, 29 Apr 2019 18:32:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 993B8DA86C; Mon, 29 Apr 2019 20:33:22 +0200 (CEST)
Date:   Mon, 29 Apr 2019 20:33:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: reserve delalloc metadata differently
Message-ID: <20190429183322.GY20156@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org
References: <20190410195610.84110-1-josef@toxicpanda.com>
 <20190410195610.84110-3-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410195610.84110-3-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 10, 2019 at 03:56:10PM -0400, Josef Bacik wrote:
> With the per-inode block rsvs we started refilling the reserve based on
> the calculated size of the outstanding csum bytes and extents for the
> inode, including the amount we were adding with the new operation.
> 
> However generic/224 exposed a problem with this approach.  With 1000
> files all writing at the same time we ended up with a bunch of bytes
> being reserved but unusable.
> 
> When you write to a file we reserve space for the csum leaves for those
> bytes, the number of extent items required to cover those bytes, and a
> single credit for updating the inode at ordered extent finish for that
> range of bytes.  This is held until the ordered extent finishes and we
> release all of the reserved space.
> 
> If a second write comes in at this point we would add a single
> reservation for the new outstanding extent and however many reservations
> for the csum leaves.  At this point we find the delta of how much we
> have reserved and how much outstanding size this is and attempt to
> reserve this delta.  If the first write finishes it will not release any
> space, because the space it had reserved for the initial write is still
> needed for the second write.  However some space would have been used,
> as we have added csums, extent items, and dirtied the inode.  Our
> reserved space would be > 0 but < the total needed reserved space.
> 
> This is just for a single inode, now consider generic/224.  This has
> 1000 inodes writing in parallel to a very small file system, 1gib.  In
> my testing this usually means we get about a 120mib metadata area to
> work with, more than enough to allow the writes to continue, but not
> enough if all of the inodes are stuck trying to reserve the slack space
> while continuing to hold their leftovers from their initial writes.
> 
> Fix this by pre-reserved _only_ for the space we are currently trying to
> add.  Then once that is successful modify our inodes csum count and
> outstanding extents, and then add the newly reserved space to the inodes
> block_rsv.  This allows us to actually pass generic/224 without running
> out of metadata space.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/extent-tree.c | 145 ++++++++++++++++++-------------------------------
>  1 file changed, 53 insertions(+), 92 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 0982456ebabb..9aff7a8817d9 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -5811,85 +5811,6 @@ int btrfs_block_rsv_refill(struct btrfs_root *root,
>  	return ret;
>  }
>  
> -static void calc_refill_bytes(struct btrfs_block_rsv *block_rsv,
> -				u64 *metadata_bytes, u64 *qgroup_bytes)
> -{
> -	*metadata_bytes = 0;
> -	*qgroup_bytes = 0;
> -
> -	spin_lock(&block_rsv->lock);
> -	if (block_rsv->reserved < block_rsv->size)
> -		*metadata_bytes = block_rsv->size - block_rsv->reserved;
> -	if (block_rsv->qgroup_rsv_reserved < block_rsv->qgroup_rsv_size)
> -		*qgroup_bytes = block_rsv->qgroup_rsv_size -
> -			block_rsv->qgroup_rsv_reserved;
> -	spin_unlock(&block_rsv->lock);
> -}
> -
> -/**
> - * btrfs_inode_rsv_refill - refill the inode block rsv.
> - * @inode - the inode we are refilling.
> - * @flush - the flushing restriction.
> - *
> - * Essentially the same as btrfs_block_rsv_refill, except it uses the
> - * block_rsv->size as the minimum size.  We'll either refill the missing amount
> - * or return if we already have enough space.  This will also handle the reserve
> - * tracepoint for the reserved amount.
> - */
> -static int btrfs_inode_rsv_refill(struct btrfs_inode *inode,
> -				  enum btrfs_reserve_flush_enum flush)
> -{
> -	struct btrfs_root *root = inode->root;
> -	struct btrfs_block_rsv *block_rsv = &inode->block_rsv;
> -	u64 num_bytes, last = 0;
> -	u64 qgroup_num_bytes;
> -	int ret = -ENOSPC;
> -
> -	calc_refill_bytes(block_rsv, &num_bytes, &qgroup_num_bytes);
> -	if (num_bytes == 0)
> -		return 0;
> -
> -	do {
> -		ret = btrfs_qgroup_reserve_meta_prealloc(root, qgroup_num_bytes,
> -							 true);
> -		if (ret)
> -			return ret;
> -		ret = reserve_metadata_bytes(root, block_rsv, num_bytes, flush);
> -		if (ret) {
> -			btrfs_qgroup_free_meta_prealloc(root, qgroup_num_bytes);
> -			last = num_bytes;
> -			/*
> -			 * If we are fragmented we can end up with a lot of
> -			 * outstanding extents which will make our size be much
> -			 * larger than our reserved amount.
> -			 *
> -			 * If the reservation happens here, it might be very
> -			 * big though not needed in the end, if the delalloc
> -			 * flushing happens.
> -			 *
> -			 * If this is the case try and do the reserve again.
> -			 */
> -			if (flush == BTRFS_RESERVE_FLUSH_ALL)
> -				calc_refill_bytes(block_rsv, &num_bytes,
> -						   &qgroup_num_bytes);
> -			if (num_bytes == 0)
> -				return 0;
> -		}
> -	} while (ret && last != num_bytes);
> -
> -	if (!ret) {
> -		block_rsv_add_bytes(block_rsv, num_bytes, false);
> -		trace_btrfs_space_reservation(root->fs_info, "delalloc",
> -					      btrfs_ino(inode), num_bytes, 1);
> -
> -		/* Don't forget to increase qgroup_rsv_reserved */
> -		spin_lock(&block_rsv->lock);
> -		block_rsv->qgroup_rsv_reserved += qgroup_num_bytes;
> -		spin_unlock(&block_rsv->lock);
> -	}
> -	return ret;
> -}
> -
>  static u64 __btrfs_block_rsv_release(struct btrfs_fs_info *fs_info,
>  				     struct btrfs_block_rsv *block_rsv,
>  				     u64 num_bytes, u64 *qgroup_to_release)
> @@ -6190,9 +6111,26 @@ static void btrfs_calculate_inode_block_rsv_size(struct btrfs_fs_info *fs_info,
>  	spin_unlock(&block_rsv->lock);
>  }
>  
> +static inline void calc_inode_reservations(struct btrfs_fs_info *fs_info,

I don't think this needs to be a static inline, just static.

> +					   struct btrfs_inode *inode,

Unused patameter.

> +					   u64 num_bytes, u64 *meta_reserve,
> +					   u64 *qgroup_reserve)
> +{
> +	u64 nr_extents = count_max_extents(num_bytes);
> +	u64 csum_leaves = btrfs_csum_bytes_to_leaves(fs_info, num_bytes);
> +
> +	/* We add one for the inode update at finish ordered time. */
> +	*meta_reserve = btrfs_calc_trans_metadata_size(fs_info,
> +						nr_extents + csum_leaves + 1);
> +	*qgroup_reserve = nr_extents * fs_info->nodesize;
> +}
> +
>  int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
>  {
> -	struct btrfs_fs_info *fs_info = inode->root->fs_info;
> +	struct btrfs_root *root = inode->root;
> +	struct btrfs_fs_info *fs_info = root->fs_info;
> +	struct btrfs_block_rsv *block_rsv = &inode->block_rsv;
> +	u64 meta_reserve, qgroup_reserve;
>  	unsigned nr_extents;
>  	enum btrfs_reserve_flush_enum flush = BTRFS_RESERVE_FLUSH_ALL;
>  	int ret = 0;
> @@ -6222,7 +6160,31 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
>  
>  	num_bytes = ALIGN(num_bytes, fs_info->sectorsize);
>  
> -	/* Add our new extents and calculate the new rsv size. */
> +	/*
> +	 * Josef, we always want to do it this way, every other way is wrong and

Come on, talking to yourself in comments again?

> +	 * ends in tears.  Pre-reserving the amount we are going to add will
> +	 * always be the right way, because otherwise if we have enough
> +	 * parallelism we could end up with thousands of inodes all holding
> +	 * little bits of reservations they were able to make previously and the
> +	 * only way to reclaim that space is to ENOSPC out the operations and
> +	 * clear everything out and try again, which is shitty.  This way we

'shitty' replaced by 'bad'

Otherwise, patches updated and added to misc-next, thanks.
