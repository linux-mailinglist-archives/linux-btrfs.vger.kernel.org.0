Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838FD2954AC
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Oct 2020 00:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441077AbgJUWLo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 18:11:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:60724 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408372AbgJUWLo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 18:11:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603318302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e4k94YB5A87/F/zYXrpzH/CABPi++MgOqZRODhJZUyk=;
        b=cxb7OlNOthUVGyHvkhXuPvEGxz/Ab38ci4INdDN+f6vwYUVhD89U0ucMGzMwRs8DWIWPER
        3V/ql8mjcUi8+o6TX6XhmFVuMYJV06ycaQr3fqNzM0s14r+x0LU6V/VS1LP5hCJLd/88JN
        xEOfE+rB0bAH1lMcXKlCNBWyIgOeK2c=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 88F62ABD1;
        Wed, 21 Oct 2020 22:11:42 +0000 (UTC)
Date:   Wed, 21 Oct 2020 17:11:40 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 08/68] btrfs: inode: sink parameter @start and @len
 for check_data_csum()
Message-ID: <20201021221140.vrp4yqnxyshx4k75@fiona>
References: <20201021062554.68132-1-wqu@suse.com>
 <20201021062554.68132-9-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021062554.68132-9-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In $SUBJECT, will prefer s/sink/remove/

On 14:24 21/10, Qu Wenruo wrote:
> For check_data_csum(), the page we're using is directly from inode
> mapping, thus it has valid page_offset().
> 
> We can use (page_offset() + pg_off) to replace @start parameter
> completely, while the @len should always be sectorsize.
> 
> Since we're here, also add some comment, as there are quite some
> confusion in words like start/offset, without explaining whether it's
> file_offset or logical bytenr.
> 
> This should not affect the existing behavior, as for current sectorsize
> == PAGE_SIZE case, @pgoff should always be 0, and len is always
> PAGE_SIZE (or sectorsize from the dio read path).
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

> ---
>  fs/btrfs/inode.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 2a56d3b8eff4..24fbf2c46e56 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2791,17 +2791,30 @@ void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
>  	btrfs_queue_work(wq, &ordered_extent->work);
>  }
>  
> +/*
> + * Verify the checksum of one sector of uncompressed data.
> + *
> + * @inode:	The inode.
> + * @io_bio:	The btrfs_io_bio which contains the csum.
> + * @icsum:	The csum offset (by number of sectors).
> + * @page:	The page where the data to be verified is.
> + * @pgoff:	The offset inside the page.
> + *
> + * The length of such check is always one sector size.
> + */
>  static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
> -			   int icsum, struct page *page, int pgoff, u64 start,
> -			   size_t len)
> +			   int icsum, struct page *page, int pgoff)
>  {
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>  	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
>  	char *kaddr;
> +	u32 len = fs_info->sectorsize;
>  	u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
>  	u8 *csum_expected;
>  	u8 csum[BTRFS_CSUM_SIZE];
>  
> +	ASSERT(pgoff + len <= PAGE_SIZE);
> +
>  	csum_expected = ((u8 *)io_bio->csum) + icsum * csum_size;
>  
>  	kaddr = kmap_atomic(page);
> @@ -2815,8 +2828,8 @@ static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
>  	kunmap_atomic(kaddr);
>  	return 0;
>  zeroit:
> -	btrfs_print_data_csum_error(BTRFS_I(inode), start, csum, csum_expected,
> -				    io_bio->mirror_num);
> +	btrfs_print_data_csum_error(BTRFS_I(inode), page_offset(page) + pgoff,
> +				    csum, csum_expected, io_bio->mirror_num);
>  	if (io_bio->device)
>  		btrfs_dev_stat_inc_and_print(io_bio->device,
>  					     BTRFS_DEV_STAT_CORRUPTION_ERRS);
> @@ -2855,8 +2868,7 @@ static int btrfs_readpage_end_io_hook(struct btrfs_io_bio *io_bio,
>  	}
>  
>  	phy_offset >>= inode->i_sb->s_blocksize_bits;
> -	return check_data_csum(inode, io_bio, phy_offset, page, offset, start,
> -			       (size_t)(end - start + 1));
> +	return check_data_csum(inode, io_bio, phy_offset, page, offset);
>  }
>  
>  /*
> @@ -7542,8 +7554,7 @@ static blk_status_t btrfs_check_read_dio_bio(struct inode *inode,
>  			ASSERT(pgoff < PAGE_SIZE);
>  			if (uptodate &&
>  			    (!csum || !check_data_csum(inode, io_bio, icsum,
> -						       bvec.bv_page, pgoff,
> -						       start, sectorsize))) {
> +						       bvec.bv_page, pgoff))) {
>  				clean_io_failure(fs_info, failure_tree, io_tree,
>  						 start, bvec.bv_page,
>  						 btrfs_ino(BTRFS_I(inode)),
> -- 
> 2.28.0
> 

-- 
Goldwyn
