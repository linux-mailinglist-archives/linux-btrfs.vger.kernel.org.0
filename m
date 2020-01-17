Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4151C140D2E
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 16:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgAQPBk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 10:01:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:43762 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726988AbgAQPBj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 10:01:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 710F7BC82;
        Fri, 17 Jan 2020 15:01:36 +0000 (UTC)
Subject: Re: [PATCH 2/5] btrfs: remove use of buffer_heads from superblock
 writeout
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20200117125105.20989-1-johannes.thumshirn@wdc.com>
 <20200117125105.20989-3-johannes.thumshirn@wdc.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <6bdb46de-db12-27da-016d-773c362de254@suse.com>
Date:   Fri, 17 Jan 2020 17:01:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200117125105.20989-3-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 17.01.20 г. 14:51 ч., Johannes Thumshirn wrote:
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

Isn't this extra put page? Perhahps it's not because that would be the
reference from find_or_create_page in write_dev_supers. In any case I'd
rather have it in that function.

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

You introduce asymmetry here. Because the write path now utilizes the
page cache whereas the read path uses plain page alloc. I'm not sure but
could this lead to reading garbage from the super block because now you
don't have synchronization between the read and write path. This reminds
me why I was using the page cache and not a plain page. Also by
utilising the page cache you will potentially be reducing IO to disk
since you can be fetching the sb data directly from cache.

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
> 
