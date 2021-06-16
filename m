Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCBA3A9D0A
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jun 2021 16:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbhFPONC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Jun 2021 10:13:02 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59384 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbhFPONB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Jun 2021 10:13:01 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 292D71FD6C;
        Wed, 16 Jun 2021 14:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623852655;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=497D1OerN6dxu3gxb1PfpnHEZPyZUKA03N44p1mfBek=;
        b=K0YccrlnfOT7TIlvT1LeCyMCid5d1gHiOwddOZTQIAzZt9/Xel2lRXGJ1475xiMc2cI8iy
        +7m8Yl357tFyDMa/gaTgFaqR5u6lkcbnP42UIVBdrUITnEAObEwZTQRNCD+yT6LJXLigzI
        Xsd/NKQSoLqDPczaHMxw8lvMuuxMG8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623852655;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=497D1OerN6dxu3gxb1PfpnHEZPyZUKA03N44p1mfBek=;
        b=WmPqXuwNou6siOSDD4zWafkHS2hcRctamwSli+6JK4JI0tF3b/L2/2r6zCwmPP7yJ0lnFU
        p77rSk1jt+/NkaBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 23237A3B81;
        Wed, 16 Jun 2021 14:10:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 51F7EDAF29; Wed, 16 Jun 2021 16:08:07 +0200 (CEST)
Date:   Wed, 16 Jun 2021 16:08:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 6/9] btrfs: introduce alloc_submit_compressed_bio()
 for compression
Message-ID: <20210616140806.GO28158@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210615121836.365105-1-wqu@suse.com>
 <20210615121836.365105-7-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615121836.365105-7-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 15, 2021 at 08:18:33PM +0800, Qu Wenruo wrote:
> Just aggregate the bio allocation code into one helper, so that we can
> replace 4 call sites.
> 
> There is one special note for zoned write.
> 
> Currently btrfs_submit_compressed_write() will only allocate the first
> bio using ZONE_APPEND.
> If we have to submit current bio due to stripe boundary, the new bio
> allocated will not use ZONE_APPEND.
> 
> In theory this should be a bug, but considering zoned mode currently
> only support SINGLE profile, which doesn't have any stripe boundary
> limit, it should never be a problem.
> 
> This function will provide a good entrance for any work which needs to be
> done at bio allocation time. Like determining the stripe boundary.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/compression.c | 91 +++++++++++++++++++++++++++++-------------
>  1 file changed, 63 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 608e9325b7c8..a00f8f8d7512 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -440,6 +440,41 @@ static blk_status_t submit_compressed_bio(struct btrfs_fs_info *fs_info,
>  	return ret;
>  }
>  
> +/*
> + * To allocate a compressed_bio, which will be used to read/write on-disk data.
> + *
> + * @disk_bytenr:	Disk bytenr of the IO
> + * @opf:		Bio opf
> + * @endio_func:		Endio function

Variable comments that basically repeat the name are useless. Followup
patches add some other parameters that are not that trivial but still.

> + */
> +static struct bio *alloc_compressed_bio(struct compressed_bio *cb, u64 disk_bytenr,
> +					unsigned int opf, bio_end_io_t endio_func)
> +{
> +	struct bio *bio;
> +
> +	bio = btrfs_bio_alloc(disk_bytenr);
> +	/* bioset allocation should not fail */
> +	ASSERT(bio);

Please drop the comment and assert, that it does not fail is documented
next to btrfs_bio_alloc so it's not necessary to repeat it at each call
site.

> +
> +	bio->bi_opf = opf;
> +	bio->bi_private = cb;
> +	bio->bi_end_io = endio_func;
> +
> +	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
> +		struct btrfs_fs_info *fs_info = btrfs_sb(cb->inode->i_sb);
> +		struct btrfs_device *device;
> +
> +		device = btrfs_zoned_get_device(fs_info, disk_bytenr,
> +						fs_info->sectorsize);
> +		if (IS_ERR(device)) {
> +			bio_put(bio);
> +			return ERR_CAST(device);
> +		}
> +		bio_set_dev(bio, device->bdev);
> +	}
> +	return bio;
> +}
> +
>  /*
>   * worker function to build and submit bios for previously compressed pages.
>   * The corresponding pages in the inode should be marked for writeback
> @@ -486,22 +521,11 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
>  	cb->orig_bio = NULL;
>  	cb->nr_pages = nr_pages;
>  
> -	bio = btrfs_bio_alloc(first_byte);
> -	bio->bi_opf = bio_op | write_flags;
> -	bio->bi_private = cb;
> -	bio->bi_end_io = end_compressed_bio_write;
> -
> -	if (use_append) {
> -		struct btrfs_device *device;
> -
> -		device = btrfs_zoned_get_device(fs_info, disk_start, PAGE_SIZE);
> -		if (IS_ERR(device)) {
> -			kfree(cb);
> -			bio_put(bio);
> -			return BLK_STS_NOTSUPP;
> -		}
> -
> -		bio_set_dev(bio, device->bdev);
> +	bio = alloc_compressed_bio(cb, first_byte, bio_op | write_flags,
> +				   end_compressed_bio_write);
> +	if (IS_ERR(bio)) {
> +		kfree(cb);
> +		return errno_to_blk_status(PTR_ERR(bio));
>  	}
>  
>  	if (blkcg_css) {
> @@ -545,10 +569,14 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
>  			if (ret)
>  				goto finish_cb;
>  
> -			bio = btrfs_bio_alloc(first_byte);
> -			bio->bi_opf = bio_op | write_flags;
> -			bio->bi_private = cb;
> -			bio->bi_end_io = end_compressed_bio_write;
> +			bio = alloc_compressed_bio(cb, first_byte,
> +					bio_op | write_flags,
> +					end_compressed_bio_write);
> +			if (IS_ERR(bio)) {
> +				ret = errno_to_blk_status(PTR_ERR(bio));
> +				bio = NULL;
> +				goto finish_cb;
> +			}
>  			if (blkcg_css)
>  				bio->bi_opf |= REQ_CGROUP_PUNT;
>  			/*
> @@ -812,10 +840,13 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>  	/* include any pages we added in add_ra-bio_pages */
>  	cb->len = bio->bi_iter.bi_size;
>  
> -	comp_bio = btrfs_bio_alloc(cur_disk_byte);
> -	comp_bio->bi_opf = REQ_OP_READ;
> -	comp_bio->bi_private = cb;
> -	comp_bio->bi_end_io = end_compressed_bio_read;
> +	comp_bio = alloc_compressed_bio(cb, cur_disk_byte, REQ_OP_READ,
> +					end_compressed_bio_read);
> +	if (IS_ERR(comp_bio)) {
> +		ret = errno_to_blk_status(PTR_ERR(comp_bio));
> +		comp_bio = NULL;
> +		goto fail2;
> +	}
>  
>  	for (pg_index = 0; pg_index < nr_pages; pg_index++) {
>  		u32 pg_len = PAGE_SIZE;
> @@ -856,10 +887,14 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>  			if (ret)
>  				goto finish_cb;
>  
> -			comp_bio = btrfs_bio_alloc(cur_disk_byte);
> -			comp_bio->bi_opf = REQ_OP_READ;
> -			comp_bio->bi_private = cb;
> -			comp_bio->bi_end_io = end_compressed_bio_read;
> +			comp_bio = alloc_compressed_bio(cb, cur_disk_byte,
> +					REQ_OP_READ,
> +					end_compressed_bio_read);
> +			if (IS_ERR(comp_bio)) {
> +				ret = errno_to_blk_status(PTR_ERR(comp_bio));
> +				comp_bio = NULL;
> +				goto finish_cb;
> +			}
>  
>  			bio_add_page(comp_bio, page, pg_len, 0);
>  		}
> -- 
> 2.32.0
