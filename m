Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F1837C087
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 May 2021 16:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbhELOpy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 May 2021 10:45:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:42730 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230474AbhELOpw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 May 2021 10:45:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CEA28AECB;
        Wed, 12 May 2021 14:44:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E7DFCDA818; Wed, 12 May 2021 16:42:13 +0200 (CEST)
Date:   Wed, 12 May 2021 16:42:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: zoned: fix compressed writes
Message-ID: <20210512144213.GS7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1620824721.git.johannes.thumshirn@wdc.com>
 <52c1251218441dfeec909b34069d654aa45311c1.1620824721.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52c1251218441dfeec909b34069d654aa45311c1.1620824721.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 12, 2021 at 11:01:40PM +0900, Johannes Thumshirn wrote:
> When multiple processes write data to the same block group on a compressed
> zoned filesystem, the underlying device could report I/O errors and data
> corruption is possible.
> 
> This happens because on a zoned file system, compressed data writes where
> sent to the device via a REQ_OP_WRITE instead of a REQ_OP_ZONE_APPEND
> operation. But with REQ_OP_WRITE and parallel submission it cannot be
> guaranteed that the data is always submitted aligned to the underlying
> zone's write pointer.
> 
> The change to using REQ_OP_ZONE_APPEND instead of REQ_OP_WRITE on a zoned
> filesystem is non intrusive on a regular file system or when submitting to
> a conventional zone on a zoned filesystem, as it is guarded by
> btrfs_use_zone_append.
> 
> Reported-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/compression.c | 44 ++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 40 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 2bea01d23a5b..d27205791483 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -28,6 +28,7 @@
>  #include "compression.h"
>  #include "extent_io.h"
>  #include "extent_map.h"
> +#include "zoned.h"
>  
>  static const char* const btrfs_compress_types[] = { "", "zlib", "lzo", "zstd" };
>  
> @@ -349,6 +350,7 @@ static void end_compressed_bio_write(struct bio *bio)
>  	 */
>  	inode = cb->inode;
>  	cb->compressed_pages[0]->mapping = cb->inode->i_mapping;
> +	btrfs_record_physical_zoned(inode, cb->start, bio);
>  	btrfs_writepage_endio_finish_ordered(cb->compressed_pages[0],
>  			cb->start, cb->start + cb->len - 1,
>  			bio->bi_status == BLK_STS_OK);
> @@ -401,6 +403,10 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
>  	u64 first_byte = disk_start;
>  	blk_status_t ret;
>  	int skip_sum = inode->flags & BTRFS_INODE_NODATASUM;
> +	struct block_device *bdev;
> +	const bool use_append = btrfs_use_zone_append(inode, disk_start);
> +	const unsigned int bio_op =
> +		use_append ? REQ_OP_ZONE_APPEND : REQ_OP_WRITE;
>  
>  	WARN_ON(!PAGE_ALIGNED(start));
>  	cb = kmalloc(compressed_bio_size(fs_info, compressed_len), GFP_NOFS);
> @@ -418,10 +424,31 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
>  	cb->nr_pages = nr_pages;
>  
>  	bio = btrfs_bio_alloc(first_byte);
> -	bio->bi_opf = REQ_OP_WRITE | write_flags;
> +	bio->bi_opf = bio_op | write_flags;
>  	bio->bi_private = cb;
>  	bio->bi_end_io = end_compressed_bio_write;
>  
> +	if (use_append) {
> +		struct extent_map *em;
> +		struct map_lookup *map;
> +
> +		em = btrfs_get_chunk_map(fs_info, disk_start, PAGE_SIZE);

The caller already does the em lookup, so this is duplicate, allocating
memory, taking locks and doing a tree lookup. All happening on write out
path so this seems heavy.

> +		if (IS_ERR(em)) {
> +			kfree(cb);
> +			bio_put(bio);
> +			return BLK_STS_NOTSUPP;
> +		}
> +
> +		map = em->map_lookup;
> +		/* We only support single profile for now */
> +		ASSERT(map->num_stripes == 1);
> +		bdev = map->stripes[0].dev->bdev;
> +
> +		free_extent_map(em);
> +
> +		bio_set_dev(bio, bdev);

bdev seems to be used just to set it for the bio, so it does not need to
be declared in the function scope (or for one-time use at all)

The same sequence of calls is done in submit_extent_page so this should
be in a helper.

> +	}
> +
>  	if (blkcg_css) {
>  		bio->bi_opf |= REQ_CGROUP_PUNT;
>  		kthread_associate_blkcg(blkcg_css);
