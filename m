Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A93D814867C
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 15:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389350AbgAXODd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 09:03:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:44470 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387698AbgAXODd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 09:03:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 52D15B216;
        Fri, 24 Jan 2020 14:03:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4C2BADA730; Fri, 24 Jan 2020 15:03:13 +0100 (CET)
Date:   Fri, 24 Jan 2020 15:03:12 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] btrfs: remove buffer heads from super block
 reading
Message-ID: <20200124140312.GJ3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
References: <20200123081849.23397-1-johannes.thumshirn@wdc.com>
 <20200123081849.23397-3-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123081849.23397-3-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 23, 2020 at 05:18:45PM +0900, Johannes Thumshirn wrote:
> Super-block reading in BTRFS is done using buffer_heads. Buffer_heads have
> some drawbacks, like not being able to propagate errors from the lower
> layers.
> 
> Change the buffer_heads to BIOs and utilize the page cache for the page
> allocation. Compared to buffer_heads using BIOs are more lightweight and
> we skip several layers of buffer_head code until we either reach the page
> cache or build a BIO and submit it to read the blocks from disk.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> ---
> Changes to v1:
> - move 'super_page' into for-loop in btrfs_scratch_superblocks() (Nikolay)
> - switch to using pagecahce instead of alloc_pages() (Nikolay, David)
> ---
>  fs/btrfs/disk-io.c | 83 ++++++++++++++++++++++++++++++----------------
>  fs/btrfs/disk-io.h |  4 +--
>  fs/btrfs/volumes.c | 62 ++++++++++++++++++++--------------
>  fs/btrfs/volumes.h |  2 --
>  4 files changed, 94 insertions(+), 57 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index aea48d6ddc0c..b111f32108cc 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2635,11 +2635,12 @@ int __cold open_ctree(struct super_block *sb,
>  	u64 features;
>  	u16 csum_type;
>  	struct btrfs_key location;
> -	struct buffer_head *bh;
>  	struct btrfs_super_block *disk_super;
>  	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
>  	struct btrfs_root *tree_root;
>  	struct btrfs_root *chunk_root;
> +	struct page *super_page;
> +	u8 *superblock;
>  	int ret;
>  	int err = -EINVAL;
>  	int clear_free_space_tree = 0;
> @@ -2832,28 +2833,31 @@ int __cold open_ctree(struct super_block *sb,
>  	/*
>  	 * Read super block and check the signature bytes only
>  	 */
> -	bh = btrfs_read_dev_super(fs_devices->latest_bdev);
> -	if (IS_ERR(bh)) {
> -		err = PTR_ERR(bh);
> +	ret = btrfs_read_dev_super(fs_devices->latest_bdev, &super_page);
> +	if (ret) {
> +		err = ret;
>  		goto fail_alloc;
>  	}
>  
> +	superblock = kmap(super_page);
>  	/*
>  	 * Verify the type first, if that or the the checksum value are
>  	 * corrupted, we'll find out
>  	 */
> -	csum_type = btrfs_super_csum_type((struct btrfs_super_block *)bh->b_data);
> +	csum_type = btrfs_super_csum_type((struct btrfs_super_block *)
> +					  superblock);
>  	if (!btrfs_supported_super_csum(csum_type)) {
>  		btrfs_err(fs_info, "unsupported checksum algorithm: %u",
>  			  csum_type);
>  		err = -EINVAL;
> -		brelse(bh);
> +		btrfs_release_disk_super(super_page);
>  		goto fail_alloc;
>  	}
>  
>  	ret = btrfs_init_csum_hash(fs_info, csum_type);
>  	if (ret) {
>  		err = ret;
> +		btrfs_release_disk_super(super_page);
>  		goto fail_alloc;
>  	}
>  
> @@ -2861,10 +2865,10 @@ int __cold open_ctree(struct super_block *sb,
>  	 * We want to check superblock checksum, the type is stored inside.
>  	 * Pass the whole disk block of size BTRFS_SUPER_INFO_SIZE (4k).
>  	 */
> -	if (btrfs_check_super_csum(fs_info, bh->b_data)) {
> +	if (btrfs_check_super_csum(fs_info, superblock)) {
>  		btrfs_err(fs_info, "superblock checksum mismatch");
>  		err = -EINVAL;
> -		brelse(bh);
> +		btrfs_release_disk_super(super_page);
>  		goto fail_csum;
>  	}
>  
> @@ -2873,8 +2877,8 @@ int __cold open_ctree(struct super_block *sb,
>  	 * following bytes up to INFO_SIZE, the checksum is calculated from
>  	 * the whole block of INFO_SIZE
>  	 */
> -	memcpy(fs_info->super_copy, bh->b_data, sizeof(*fs_info->super_copy));
> -	brelse(bh);
> +	memcpy(fs_info->super_copy, superblock, sizeof(*fs_info->super_copy));
> +	btrfs_release_disk_super(super_page);
>  
>  	disk_super = fs_info->super_copy;
>  
> @@ -3374,40 +3378,60 @@ static void btrfs_end_buffer_write_sync(struct buffer_head *bh, int uptodate)
>  }
>  
>  int btrfs_read_dev_one_super(struct block_device *bdev, int copy_num,
> -			struct buffer_head **bh_ret)
> +			struct page **super_page)
>  {
> -	struct buffer_head *bh;
>  	struct btrfs_super_block *super;
> +	struct bio_vec bio_vec;
> +	struct bio bio;
> +	struct page *page;
>  	u64 bytenr;
> +	struct address_space *mapping = bdev->bd_inode->i_mapping;
> +	gfp_t gfp_mask;
> +	int ret;
>  
>  	bytenr = btrfs_sb_offset(copy_num);
>  	if (bytenr + BTRFS_SUPER_INFO_SIZE >= i_size_read(bdev->bd_inode))
>  		return -EINVAL;
>  
> -	bh = __bread(bdev, bytenr / BTRFS_BDEV_BLOCKSIZE, BTRFS_SUPER_INFO_SIZE);
> +	gfp_mask = mapping_gfp_constraint(mapping, ~__GFP_FS) | __GFP_NOFAIL;
> +	page = find_or_create_page(mapping, bytenr >> PAGE_SHIFT, gfp_mask);
> +	if (!page)
> +		return -ENOMEM;
> +
> +	bio_init(&bio, &bio_vec, 1);
> +	bio.bi_iter.bi_sector = bytenr >> SECTOR_SHIFT;
> +	bio_set_dev(&bio, bdev);
> +	bio_set_op_attrs(&bio, REQ_OP_READ, 0);

The comment in blk_types.h says:

390 /* obsolete, don't use in new code */
391 static inline void bio_set_op_attrs(struct bio *bio, unsigned op,
392                 unsigned op_flags)

please open code it. Other uses of bio_set_op_attrs have been cleaned up
already.

> +	bio_add_page(&bio, page, BTRFS_SUPER_INFO_SIZE,
> +		     offset_in_page(bytenr));

For a fresh bio this never fails right?

> +
> +	ret = submit_bio_wait(&bio);
> +	unlock_page(page);
>  	/*
>  	 * If we fail to read from the underlying devices, as of now
>  	 * the best option we have is to mark it EIO.
>  	 */
> -	if (!bh)
> +	if (ret) {
> +		put_page(page);
>  		return -EIO;
> +	}
>  
> -	super = (struct btrfs_super_block *)bh->b_data;
> +	super = kmap(page);
>  	if (btrfs_super_bytenr(super) != bytenr ||
>  		    btrfs_super_magic(super) != BTRFS_MAGIC) {
> -		brelse(bh);
> +		btrfs_release_disk_super(page);
>  		return -EINVAL;
>  	}
> +	kunmap(page);
>  
> -	*bh_ret = bh;
> +	*super_page = page;
>  	return 0;
>  }
>  
>  
> -struct buffer_head *btrfs_read_dev_super(struct block_device *bdev)
> +int btrfs_read_dev_super(struct block_device *bdev, struct page **page)
>  {
> -	struct buffer_head *bh;
> -	struct buffer_head *latest = NULL;
> +	struct page *latest = NULL;
>  	struct btrfs_super_block *super;
>  	int i;
>  	u64 transid = 0;
> @@ -3419,25 +3443,28 @@ struct buffer_head *btrfs_read_dev_super(struct block_device *bdev)
>  	 * later supers, using BTRFS_SUPER_MIRROR_MAX instead
>  	 */
>  	for (i = 0; i < 1; i++) {
> -		ret = btrfs_read_dev_one_super(bdev, i, &bh);
> +		ret = btrfs_read_dev_one_super(bdev, i, page);
>  		if (ret)
>  			continue;
>  
> -		super = (struct btrfs_super_block *)bh->b_data;
> +		super = kmap(*page);
>  
>  		if (!latest || btrfs_super_generation(super) > transid) {
> -			brelse(latest);
> -			latest = bh;
> +			if (latest)
> +				btrfs_release_disk_super(latest);
> +			latest = *page;
>  			transid = btrfs_super_generation(super);
>  		} else {
> -			brelse(bh);
> +			btrfs_release_disk_super(*page);
>  		}
> +
> +		kunmap(*page);

This looks like double unmap, once in btrfs_release_disk_super and then
unconditinally as kunmap.

The first part of the if/else block also calls kunmap, but depending on
latest.

So another point for opencoding btrfs_release_disk_super, this kind of
mistakes is too easy.

>  	}
>  
> -	if (!latest)
> -		return ERR_PTR(ret);
> +	if (ret)
> +		return ret;
>  
> -	return latest;
> +	return 0;
>  }
>  
>  /*
