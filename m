Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37C3215DB3D
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2020 16:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgBNPoK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Feb 2020 10:44:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:57994 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728264AbgBNPoK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Feb 2020 10:44:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 37477B049;
        Fri, 14 Feb 2020 15:44:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8080CDA703; Fri, 14 Feb 2020 16:43:36 +0100 (CET)
Date:   Fri, 14 Feb 2020 16:43:36 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.cz>,
        Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v8 8/8] btrfs: remove buffer_heads form superblock mirror
 integrity checking
Message-ID: <20200214154336.GA2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20200213152436.13276-1-johannes.thumshirn@wdc.com>
 <20200213152436.13276-9-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200213152436.13276-9-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 14, 2020 at 12:24:36AM +0900, Johannes Thumshirn wrote:
> The integrity checking code for the superblock mirrors is the last remaining
> user of buffer_heads in BTRFS, change it to using plain BIOs as well.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> 
> ---
> Changes to v7:
> - Use read_Cache_page_gfp()
> - Don't kmap() block device mappings (David)
> 
> Changes to v4:
> - Remove mapping_gfp_constraint()
> 
> Changes to v2:
> - Open-code kunmap() + put_page() (David)
> - Remove __GFP_NOFAIL from allocation (Josef)
> - Merge error paths (David)
> 
> Changes to v1:
> - Convert from alloc_page() to find_or_create_page()
> ---
>  fs/btrfs/check-integrity.c | 42 +++++++++++++++++++++-----------------
>  1 file changed, 23 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
> index 4f6db2fe482a..d8d915d7beda 100644
> --- a/fs/btrfs/check-integrity.c
> +++ b/fs/btrfs/check-integrity.c
> @@ -77,7 +77,6 @@
>  
>  #include <linux/sched.h>
>  #include <linux/slab.h>
> -#include <linux/buffer_head.h>
>  #include <linux/mutex.h>
>  #include <linux/genhd.h>
>  #include <linux/blkdev.h>
> @@ -762,29 +761,33 @@ static int btrfsic_process_superblock_dev_mirror(
>  	struct btrfs_fs_info *fs_info = state->fs_info;
>  	struct btrfs_super_block *super_tmp;
>  	u64 dev_bytenr;
> -	struct buffer_head *bh;
>  	struct btrfsic_block *superblock_tmp;
>  	int pass;
>  	struct block_device *const superblock_bdev = device->bdev;
> +	struct page *page;
> +	struct bio bio;
> +	struct bio_vec bio_vec;
> +	struct address_space *mapping = superblock_bdev->bd_inode->i_mapping;
> +	int ret;
>  
>  	/* super block bytenr is always the unmapped device bytenr */
>  	dev_bytenr = btrfs_sb_offset(superblock_mirror_num);
>  	if (dev_bytenr + BTRFS_SUPER_INFO_SIZE > device->commit_total_bytes)
>  		return -1;
> -	bh = __bread(superblock_bdev, dev_bytenr / BTRFS_BDEV_BLOCKSIZE,
> -		     BTRFS_SUPER_INFO_SIZE);
> -	if (NULL == bh)
> +
> +	page = reed_cache_page_gfp(mapping, dev_bytenr >> PAGE_SHIFT, GFP_NOFS);

Reed-Solomon error correction in page cache? Have I missed the news? :)

  CC [M]  fs/btrfs/check-integrity.o
fs/btrfs/check-integrity.c: In function ‘btrfsic_process_superblock_dev_mirror’:
fs/btrfs/check-integrity.c:778:9: error: implicit declaration of function ‘reed_cache_page_gfp’; did you mean ‘read_cache_page_gfp’? [-Werror=implicit-function-declaration]
  778 |  page = reed_cache_page_gfp(mapping, dev_bytenr >> PAGE_SHIFT, GFP_NOFS);
      |         ^~~~~~~~~~~~~~~~~~~
      |         read_cache_page_gfp

And with that fixed there are still the following warnings.

fs/btrfs/check-integrity.c:778:7: warning: assignment to ‘struct page *’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
  778 |  page = reed_cache_page_gfp(mapping, dev_bytenr >> PAGE_SHIFT, GFP_NOFS);
      |       ^
fs/btrfs/check-integrity.c:769:17: warning: unused variable ‘bio_vec’ [-Wunused-variable]
  769 |  struct bio_vec bio_vec;
      |                 ^~~~~~~
fs/btrfs/check-integrity.c:768:13: warning: unused variable ‘bio’ [-Wunused-variable]
  768 |  struct bio bio;
      |             ^~~
