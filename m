Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDB2A155550
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 11:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgBGKIF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Feb 2020 05:08:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:51278 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726954AbgBGKIE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 Feb 2020 05:08:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 69D0EB120;
        Fri,  7 Feb 2020 10:08:01 +0000 (UTC)
Subject: Re: [PATCH v5 2/7] btrfs: use the page-cache for super block reading
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.cz>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
References: <20200207072005.22867-1-johannes.thumshirn@wdc.com>
 <20200207072005.22867-3-johannes.thumshirn@wdc.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <1905a50e-a008-0b67-ff56-080e07eaa2da@suse.com>
Date:   Fri, 7 Feb 2020 12:08:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200207072005.22867-3-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 7.02.20 г. 9:20 ч., Johannes Thumshirn wrote:
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
> Changes to v4:
> - Remove mapping_gfp_constraint() and GFP_NOFAIL (hch)
> 
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
>  fs/btrfs/disk-io.c | 76 +++++++++++++++++++++++++---------------------
>  fs/btrfs/disk-io.h |  4 +--
>  fs/btrfs/volumes.c | 57 ++++++++++++++++++----------------
>  fs/btrfs/volumes.h |  2 --
>  4 files changed, 74 insertions(+), 65 deletions(-)
> 

<snip>

>  
> @@ -3355,40 +3363,38 @@ static void btrfs_end_buffer_write_sync(struct buffer_head *bh, int uptodate)
>  }
>  
>  int btrfs_read_dev_one_super(struct block_device *bdev, int copy_num,
> -			struct buffer_head **bh_ret)
> +			struct page **super_page)
>  {
> -	struct buffer_head *bh;
>  	struct btrfs_super_block *super;
> +	struct page *page;
>  	u64 bytenr;
> +	struct address_space *mapping = bdev->bd_inode->i_mapping;
>  
>  	bytenr = btrfs_sb_offset(copy_num);
>  	if (bytenr + BTRFS_SUPER_INFO_SIZE >= i_size_read(bdev->bd_inode))
>  		return -EINVAL;

You don't use page_offset(bytenr) here but you do it in
btrfs_scratch_superblocks. I'm aware that this could be omitted entirely
since the sb is always aligned on a 4k. But in this case either you omit
it everywhere or you use it everywhere for the sake of consistency.

>  
> -	bh = __bread(bdev, bytenr / BTRFS_BDEV_BLOCKSIZE, BTRFS_SUPER_INFO_SIZE);
> -	/*
> -	 * If we fail to read from the underlying devices, as of now
> -	 * the best option we have is to mark it EIO.
> -	 */
> -	if (!bh)
> -		return -EIO;
> +	page = read_cache_page_gfp(mapping, bytenr >> PAGE_SHIFT, GFP_NOFS);
> +	if (IS_ERR_OR_NULL(page))
> +		return -ENOMEM;

read_cache_page can return an error from ->readpage as well. Also
looking at do_read_cache_page it doesn't seem like it can return a NULL
pointer.

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

<snip>
