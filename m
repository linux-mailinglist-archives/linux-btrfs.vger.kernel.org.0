Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338A82634B8
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Sep 2020 19:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbgIIRfD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Sep 2020 13:35:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:58724 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgIIRfB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Sep 2020 13:35:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 795ABB36E;
        Wed,  9 Sep 2020 17:35:16 +0000 (UTC)
Date:   Wed, 9 Sep 2020 12:34:57 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 14/17] btrfs: make btrfs_readpage_end_io_hook() follow
 sector size
Message-ID: <20200909173457.e4gpsbwkcsxtdo4g@fiona>
References: <20200908075230.86856-1-wqu@suse.com>
 <20200908075230.86856-15-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908075230.86856-15-wqu@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15:52 08/09, Qu Wenruo wrote:
> Currently btrfs_readpage_end_io_hook() just pass the whole page to
> check_data_csum(), which is fine since we only support sectorsize ==
> PAGE_SIZE.
> 
> To support subpage RO support, we need to properly honor per-sector
> checksum verification, just like what we did in dio read path.
> 
> This patch will do the csum verification in a for loop, starts with
> pg_off == start - page_offset(page), with sectorsize increasement for
> each loop.
> 
> For sectorsize == PAGE_SIZE case, the pg_off will always be 0, and we
> will only finish with just one loop.
> 
> For subpage, we do the proper loop.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/inode.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 078735aa0f68..8bd14dda2067 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2851,9 +2851,12 @@ static int btrfs_readpage_end_io_hook(struct btrfs_io_bio *io_bio,
>  				      u64 start, u64 end, int mirror)
>  {
>  	size_t offset = start - page_offset(page);
> +	size_t pg_off;
>  	struct inode *inode = page->mapping->host;
>  	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
>  	struct btrfs_root *root = BTRFS_I(inode)->root;
> +	u32 sectorsize = root->fs_info->sectorsize;
> +	bool found_err = false;
>  
>  	if (PageChecked(page)) {
>  		ClearPageChecked(page);
> @@ -2870,7 +2873,17 @@ static int btrfs_readpage_end_io_hook(struct btrfs_io_bio *io_bio,
>  	}
>  
>  	phy_offset >>= inode->i_sb->s_blocksize_bits;
> -	return check_data_csum(inode, io_bio, phy_offset, page, offset);
> +	for (pg_off = offset; pg_off < end - page_offset(page);
> +	     pg_off += sectorsize, phy_offset++) {
> +		int ret;
> +
> +		ret = check_data_csum(inode, io_bio, phy_offset, page, pg_off);
> +		if (ret < 0)
> +			found_err = true;
> +	}
> +	if (found_err)
> +		return -EIO;
> +	return 0;
>  }

We don't need found_err here. Just return ret when you encounter the
first error.

-- 
Goldwyn
