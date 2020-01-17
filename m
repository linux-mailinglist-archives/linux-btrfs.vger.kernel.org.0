Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC91140D15
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 15:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgAQOvY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 09:51:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:39886 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726827AbgAQOvY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 09:51:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C0521BB04;
        Fri, 17 Jan 2020 14:51:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A6E16DA871; Fri, 17 Jan 2020 15:51:06 +0100 (CET)
Date:   Fri, 17 Jan 2020 15:51:06 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/5] btrfs: remove use of buffer_heads from superblock
 writeout
Message-ID: <20200117145106.GH3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200117125105.20989-1-johannes.thumshirn@wdc.com>
 <20200117125105.20989-3-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117125105.20989-3-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 17, 2020 at 09:51:02PM +0900, Johannes Thumshirn wrote:
> Similar to the superblock read path, change the write path to using BIOs
> and pages instead of buffer_heads.
> 
> This is based on a patch originally authored by Nikolay Borisov.
> 
> Co-developed-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/disk-io.c | 107 ++++++++++++++++++++++++++-------------------
>  1 file changed, 61 insertions(+), 46 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 50c93ffe8d03..51e7b832c8fd 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c

Grep pointed out that the #include <buffer_head> is still in disk-io.c,
(check-integrity.c got it removed).

> @@ -3353,25 +3353,33 @@ int __cold open_ctree(struct super_block *sb,
>  }
>  ALLOW_ERROR_INJECTION(open_ctree, ERRNO);
>  
> -static void btrfs_end_buffer_write_sync(struct buffer_head *bh, int uptodate)
> +static void btrfs_end_super_write(struct bio *bio)
>  {
> -	if (uptodate) {
> -		set_buffer_uptodate(bh);
> -	} else {
> -		struct btrfs_device *device = (struct btrfs_device *)
> -			bh->b_private;
> -
> -		btrfs_warn_rl_in_rcu(device->fs_info,
> -				"lost page write due to IO error on %s",
> -					  rcu_str_deref(device->name));
> -		/* note, we don't set_buffer_write_io_error because we have
> -		 * our own ways of dealing with the IO errors
> -		 */
> -		clear_buffer_uptodate(bh);
> -		btrfs_dev_stat_inc_and_print(device, BTRFS_DEV_STAT_WRITE_ERRS);
> +	struct btrfs_device *device = bio->bi_private;
> +	struct bio_vec *bvec;
> +	struct bvec_iter_all iter_all;
> +	struct page *page;
> +
> +	bio_for_each_segment_all(bvec, bio, iter_all) {
> +		page = bvec->bv_page;
> +
> +		if (blk_status_to_errno(bio->bi_status)) {
> +			btrfs_warn_rl_in_rcu(device->fs_info,
> +					     "lost page write due to IO error on %s",
> +					     rcu_str_deref(device->name));
> +			ClearPageUptodate(page);
> +			SetPageError(page);
> +			btrfs_dev_stat_inc_and_print(device,
> +						     BTRFS_DEV_STAT_WRITE_ERRS);
> +		} else {
> +			SetPageUptodate(page);
> +		}
> +
> +		put_page(page);
> +		unlock_page(page);
>  	}
> -	unlock_buffer(bh);
> -	put_bh(bh);
> +
> +	bio_put(bio);
>  }
>  
>  int btrfs_read_dev_one_super(struct block_device *bdev, int copy_num,
> @@ -3462,16 +3470,15 @@ int btrfs_read_dev_super(struct block_device *bdev, struct page **page)
>   * the expected device size at commit time. Note that max_mirrors must be
>   * same for write and wait phases.
>   *
> - * Return number of errors when buffer head is not found or submission fails.
> + * Return number of errors when page is not found or submission fails.
>   */
>  static int write_dev_supers(struct btrfs_device *device,
>  			    struct btrfs_super_block *sb, int max_mirrors)
>  {
>  	struct btrfs_fs_info *fs_info = device->fs_info;
>  	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
> -	struct buffer_head *bh;
> +	gfp_t gfp_mask;
>  	int i;
> -	int ret;
>  	int errors = 0;
>  	u64 bytenr;
>  	int op_flags;
> @@ -3481,7 +3488,13 @@ static int write_dev_supers(struct btrfs_device *device,
>  
>  	shash->tfm = fs_info->csum_shash;
>  
> +	gfp_mask = mapping_gfp_constraint(device->bdev->bd_inode->i_mapping,
> +					  ~__GFP_FS) | __GFP_NOFAIL;
> +
>  	for (i = 0; i < max_mirrors; i++) {
> +		struct page *page;
> +		struct bio *bio;
> +
>  		bytenr = btrfs_sb_offset(i);
>  		if (bytenr + BTRFS_SUPER_INFO_SIZE >=
>  		    device->commit_total_bytes)
> @@ -3494,26 +3507,20 @@ static int write_dev_supers(struct btrfs_device *device,
>  				    BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
>  		crypto_shash_final(shash, sb->csum);
>  
> -		/* One reference for us, and we leave it for the caller */
> -		bh = __getblk(device->bdev, bytenr / BTRFS_BDEV_BLOCKSIZE,
> -			      BTRFS_SUPER_INFO_SIZE);
> -		if (!bh) {
> +		page = find_or_create_page(device->bdev->bd_inode->i_mapping,
> +					   bytenr >> PAGE_SHIFT, gfp_mask);
> +		if (!page) {
>  			btrfs_err(device->fs_info,
> -			    "couldn't get super buffer head for bytenr %llu",
> +			    "couldn't get superblock page for bytenr %llu",
>  			    bytenr);
>  			errors++;
>  			continue;
>  		}
>  
> -		memcpy(bh->b_data, sb, BTRFS_SUPER_INFO_SIZE);
> +		/* Bump the refcount for wait_dev_supers() */
> +		get_page(page);
>  
> -		/* one reference for submit_bh */
> -		get_bh(bh);
> -
> -		set_buffer_uptodate(bh);
> -		lock_buffer(bh);
> -		bh->b_end_io = btrfs_end_buffer_write_sync;
> -		bh->b_private = device;
> +		memcpy(page_address(page), sb, BTRFS_SUPER_INFO_SIZE);
>  
>  		/*
>  		 * we fua the first super.  The others we allow
> @@ -3522,9 +3529,17 @@ static int write_dev_supers(struct btrfs_device *device,
>  		op_flags = REQ_SYNC | REQ_META | REQ_PRIO;
>  		if (i == 0 && !btrfs_test_opt(device->fs_info, NOBARRIER))
>  			op_flags |= REQ_FUA;
> -		ret = btrfsic_submit_bh(REQ_OP_WRITE, op_flags, bh);
> -		if (ret)
> -			errors++;
> +
> +		bio = bio_alloc(gfp_mask, 1);
> +		bio_set_dev(bio, device->bdev);
> +		bio->bi_iter.bi_sector = bytenr >> SECTOR_SHIFT;
> +		bio->bi_private = device;
> +		bio->bi_end_io = btrfs_end_super_write;
> +		bio_add_page(bio, page, BTRFS_SUPER_INFO_SIZE,
> +			     offset_in_page(bytenr));
> +
> +		bio_set_op_attrs(bio, REQ_OP_WRITE, op_flags);
> +		btrfsic_submit_bio(bio);
>  	}
>  	return errors < i ? 0 : -1;
>  }
> @@ -3533,12 +3548,11 @@ static int write_dev_supers(struct btrfs_device *device,
>   * Wait for write completion of superblocks done by write_dev_supers,
>   * @max_mirrors same for write and wait phases.
>   *
> - * Return number of errors when buffer head is not found or not marked up to
> + * Return number of errors when page is not found or not marked up to
>   * date.
>   */
>  static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
>  {
> -	struct buffer_head *bh;
>  	int i;
>  	int errors = 0;
>  	bool primary_failed = false;
> @@ -3548,32 +3562,33 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
>  		max_mirrors = BTRFS_SUPER_MIRROR_MAX;
>  
>  	for (i = 0; i < max_mirrors; i++) {
> +		struct page *page;
> +
>  		bytenr = btrfs_sb_offset(i);
>  		if (bytenr + BTRFS_SUPER_INFO_SIZE >=
>  		    device->commit_total_bytes)
>  			break;
>  
> -		bh = __find_get_block(device->bdev,
> -				      bytenr / BTRFS_BDEV_BLOCKSIZE,
> -				      BTRFS_SUPER_INFO_SIZE);
> -		if (!bh) {
> +		page = find_get_page(device->bdev->bd_inode->i_mapping,
> +				     bytenr >> PAGE_SHIFT);
> +		if (!page) {
>  			errors++;
>  			if (i == 0)
>  				primary_failed = true;
>  			continue;
>  		}
> -		wait_on_buffer(bh);
> -		if (!buffer_uptodate(bh)) {
> +		wait_on_page_locked(page);
> +		if (PageError(page)) {
>  			errors++;
>  			if (i == 0)
>  				primary_failed = true;
>  		}
>  
>  		/* drop our reference */
> -		brelse(bh);
> +		put_page(page);
>  
>  		/* drop the reference from the writing run */
> -		brelse(bh);
> +		put_page(page);
>  	}
>  
>  	/* log error, force error return */
> -- 
> 2.24.1
