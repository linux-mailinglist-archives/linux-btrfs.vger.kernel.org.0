Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 609821535A0
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2020 17:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgBEQxY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Feb 2020 11:53:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48916 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgBEQxY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Feb 2020 11:53:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Hts3IxM0M+kQCDFrmgLQ5fGKAqg2RUUFBgWdkP5EVss=; b=YKXGmzxU2SWaIa38iYp/J69vUp
        7FQIqybu3xMVGu18wZvuRGwUX+8AAImbc66UUvbm7Z8UoSRJ5tlUGE2G6zdbOjNqGwAgGwdPaj0yo
        sDiCA9WmmrZ3/jfj60wxaFEEG7vhSuxBo/RdjNh5gi3NysOWKHQP6lQ8D5qi17aK7s8fsMRejszhV
        pzYeGe3YbUzTti30/XP4lO5xKCOPPf8sbXnkL3slPJqUjJwL/ufeRT38MFiGblxlVAnfBI+wpxmEf
        kiSlfSY00xIvt4sh/mOZY2dqudO3DG4uNCE457xpINqN8PLFYPou3LUHo7q5POxpLrxdeM/QdlJzK
        SPWlP7JA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izNvT-0003g0-33; Wed, 05 Feb 2020 16:53:19 +0000
Date:   Wed, 5 Feb 2020 08:53:19 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.cz>,
        Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v4 1/5] btrfs: use the page-cache for super block reading
Message-ID: <20200205165319.GA6326@infradead.org>
References: <20200205143831.13959-1-johannes.thumshirn@wdc.com>
 <20200205143831.13959-2-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205143831.13959-2-johannes.thumshirn@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 05, 2020 at 11:38:27PM +0900, Johannes Thumshirn wrote:
> Super-block reading in BTRFS is done using buffer_heads. Buffer_heads have
> some drawbacks, like not being able to propagate errors from the lower
> layers.
> 
> Directly use the page cache for reading the super-blocks from disk or
> invalidating an on-disk super-block. We have to use the page-cache so to
> avoid races between mkfs and udev. See also 6f60cbd3ae44 ("btrfs: access
> superblock via pagecache in scan_one_device").
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> ---
> Changes to v3:
> - Use read_cache_pages() and write_one_page() for IO (hch)
> - Changed subject (David)
> - Dropped Josef's R-b due to change
> 
> Changes to v2:
> - open-code kunmap() + put_page() (David)
> - fix double kunmap() (David)
> - don't use bi_set_op_attrs() (David)
> 
> Changes to v1:
> - move 'super_page' into for-loop in btrfs_scratch_superblocks() (Nikolay)
> - switch to using pagecahce instead of alloc_pages() (Nikolay, David)
> ---
>  fs/btrfs/disk-io.c | 78 +++++++++++++++++++++++++---------------------
>  fs/btrfs/disk-io.h |  4 +--
>  fs/btrfs/volumes.c | 57 +++++++++++++++++----------------
>  fs/btrfs/volumes.h |  2 --
>  4 files changed, 76 insertions(+), 65 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 28622de9e642..bc14ef1aadda 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2617,11 +2617,12 @@ int __cold open_ctree(struct super_block *sb,
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

I thought you agree to turn this into a struct btrfs_super_block
pointer?

>  	bytenr = btrfs_sb_offset(copy_num);
>  	if (bytenr + BTRFS_SUPER_INFO_SIZE >= i_size_read(bdev->bd_inode))
>  		return -EINVAL;
>  
> -	bh = __bread(bdev, bytenr / BTRFS_BDEV_BLOCKSIZE, BTRFS_SUPER_INFO_SIZE);
> -	/*
> -	 * If we fail to read from the underlying devices, as of now
> -	 * the best option we have is to mark it EIO.
> -	 */
> -	if (!bh)
> -		return -EIO;
> +	gfp_mask = mapping_gfp_constraint(mapping, ~__GFP_FS) | __GFP_NOFAIL;
> +	page = read_cache_page_gfp(mapping, bytenr >> PAGE_SHIFT, gfp_mask);
> +	if (IS_ERR_OR_NULL(page))
> +		return -ENOMEM;

Why do you need the __GFP_NOFAIL given that failures are handled
properly here?  Also I think instead of using mapping_gfp_constraint you
can use GFP_NOFS directly here.

>  
> -	super = (struct btrfs_super_block *)bh->b_data;
> +	super = kmap(page);
>  	if (btrfs_super_bytenr(super) != bytenr ||
>  		    btrfs_super_magic(super) != BTRFS_MAGIC) {
> -		brelse(bh);
> +		kunmap(page);
> +		put_page(page);
>  		return -EINVAL;
>  	}
> +	kunmap(page);

Also last time I wondered why we can't leave the page mapped for the
caller and also return the virtual address?  That would keep the
callers a little cleaner.  Note that you don't need to pass the
struct page in that case as the unmap helper can use kmap_to_page (and
I think a helper would be really nice for the unmap and put anyway).
