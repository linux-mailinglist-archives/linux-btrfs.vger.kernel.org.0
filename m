Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56442A9E05
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 20:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgKFTaF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 14:30:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:40092 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbgKFTaF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Nov 2020 14:30:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A4ED4AC2F;
        Fri,  6 Nov 2020 19:30:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 41E66DA6E3; Fri,  6 Nov 2020 20:28:24 +0100 (CET)
Date:   Fri, 6 Nov 2020 20:28:24 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 14/32] btrfs: inode: make btrfs_readpage_end_io_hook()
 follow sector size
Message-ID: <20201106192824.GW6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20201103133108.148112-1-wqu@suse.com>
 <20201103133108.148112-15-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103133108.148112-15-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 03, 2020 at 09:30:50PM +0800, Qu Wenruo wrote:
> Currently btrfs_readpage_end_io_hook() just pass the whole page to
> check_data_csum(), which is fine since we only support sectorsize ==
> PAGE_SIZE.
> 
> To support subpage, we need to properly honor per-sector
> checksum verification, just like what we did in dio read path.
> 
> This patch will do the csum verification in a for loop, starts with
> pg_off == start - page_offset(page), with sectorsize increasement for
> each loop.
> 
> For sectorsize == PAGE_SIZE case, the pg_off will always be 0, and we
> will only finish with just one loop.
> 
> For subpage case, we do the loop to iterate each sector and if we found
> any error, we return error.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/inode.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index c54e0ed0b938..0432ca58eade 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2888,9 +2888,11 @@ int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u64 phy_offset,
>  			   struct page *page, u64 start, u64 end, int mirror)
>  {
>  	size_t offset = start - page_offset(page);
> +	size_t pg_off;
>  	struct inode *inode = page->mapping->host;
>  	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
>  	struct btrfs_root *root = BTRFS_I(inode)->root;
> +	u32 sectorsize = root->fs_info->sectorsize;
>  
>  	if (PageChecked(page)) {
>  		ClearPageChecked(page);
> @@ -2910,7 +2912,15 @@ int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u64 phy_offset,
>  	}
>  
>  	phy_offset >>= root->fs_info->sectorsize_bits;
> -	return check_data_csum(inode, io_bio, phy_offset, page, offset);
> +	for (pg_off = offset; pg_off < end - page_offset(page);

You can reause offset and not add pg_off.

> +	     pg_off += sectorsize, phy_offset++) {

phy_offsset is u64

> +		int ret;
> +
> +		ret = check_data_csum(inode, io_bio, phy_offset, page, pg_off);

Here it's passed as 'int icsum' to check_data_csum and pg_off is 'int
pgoff', like what's on here ...

> +		if (ret < 0)
> +			return -EIO;
> +	}
> +	return 0;
>  }
>  
>  /*
> -- 
> 2.29.2
