Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5764B28D
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 09:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfFSHC4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 03:02:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:60806 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725854AbfFSHC4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 03:02:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AB03DAFDB
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2019 07:02:54 +0000 (UTC)
Subject: Re: [PATCH 6/6] btrfs: lift bio_set_dev from bio allocation helpers
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1560880630.git.dsterba@suse.com>
 <78e6abb1da3bb93961254526172dc70138f8f39b.1560880630.git.dsterba@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d36987c6-2e18-5b2e-0760-0cf151446586@suse.com>
Date:   Wed, 19 Jun 2019 10:02:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <78e6abb1da3bb93961254526172dc70138f8f39b.1560880630.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 18.06.19 г. 21:00 ч., David Sterba wrote:
> The block device is passed around for the only purpose to set it in new
> bios. Move the assignment one level up. This is a preparatory patch for
> further bdev cleanups.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

Albeit I'd go as far as suggesting to make btrfs_bio_alloc a void
function similar to the generic bio alloc functions. It should be up to
the callers of bio alloc functions to initialize the bio in one place.
Even after your patch initialization is split across btrfs_bio_alloc and
its caller which seems a bit idiosyncratic.

> ---
>  fs/btrfs/compression.c | 12 ++++++++----
>  fs/btrfs/extent_io.c   |  6 +++---
>  fs/btrfs/extent_io.h   |  2 +-
>  3 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index db41315f11eb..60c47b417a4b 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -340,7 +340,8 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
>  
>  	bdev = fs_info->fs_devices->latest_bdev;
>  
> -	bio = btrfs_bio_alloc(bdev, first_byte);
> +	bio = btrfs_bio_alloc(first_byte);
> +	bio_set_dev(bio, bdev);
>  	bio->bi_opf = REQ_OP_WRITE | write_flags;
>  	bio->bi_private = cb;
>  	bio->bi_end_io = end_compressed_bio_write;
> @@ -382,7 +383,8 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
>  				bio_endio(bio);
>  			}
>  
> -			bio = btrfs_bio_alloc(bdev, first_byte);
> +			bio = btrfs_bio_alloc(first_byte);
> +			bio_set_dev(bio, bdev);
>  			bio->bi_opf = REQ_OP_WRITE | write_flags;
>  			bio->bi_private = cb;
>  			bio->bi_end_io = end_compressed_bio_write;
> @@ -620,7 +622,8 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>  	/* include any pages we added in add_ra-bio_pages */
>  	cb->len = bio->bi_iter.bi_size;
>  
> -	comp_bio = btrfs_bio_alloc(bdev, cur_disk_byte);
> +	comp_bio = btrfs_bio_alloc(cur_disk_byte);
> +	bio_set_dev(comp_bio, bdev);
>  	comp_bio->bi_opf = REQ_OP_READ;
>  	comp_bio->bi_private = cb;
>  	comp_bio->bi_end_io = end_compressed_bio_read;
> @@ -670,7 +673,8 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>  				bio_endio(comp_bio);
>  			}
>  
> -			comp_bio = btrfs_bio_alloc(bdev, cur_disk_byte);
> +			comp_bio = btrfs_bio_alloc(cur_disk_byte);
> +			bio_set_dev(comp_bio, bdev);
>  			comp_bio->bi_opf = REQ_OP_READ;
>  			comp_bio->bi_private = cb;
>  			comp_bio->bi_end_io = end_compressed_bio_read;
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index a6ad2f6f2bf7..f21be5d3724f 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2863,12 +2863,11 @@ static inline void btrfs_io_bio_init(struct btrfs_io_bio *btrfs_bio)
>   * never fail.  We're returning a bio right now but you can call btrfs_io_bio
>   * for the appropriate container_of magic
>   */
> -struct bio *btrfs_bio_alloc(struct block_device *bdev, u64 first_byte)
> +struct bio *btrfs_bio_alloc(u64 first_byte)
>  {
>  	struct bio *bio;
>  
>  	bio = bio_alloc_bioset(GFP_NOFS, BIO_MAX_PAGES, &btrfs_bioset);
> -	bio_set_dev(bio, bdev);
>  	bio->bi_iter.bi_sector = first_byte >> 9;
>  	btrfs_io_bio_init(btrfs_io_bio(bio));
>  	return bio;
> @@ -2979,7 +2978,8 @@ static int submit_extent_page(unsigned int opf, struct extent_io_tree *tree,
>  		}
>  	}
>  
> -	bio = btrfs_bio_alloc(bdev, offset);
> +	bio = btrfs_bio_alloc(offset);
> +	bio_set_dev(bio, bdev);
>  	bio_add_page(bio, page, page_size, pg_offset);
>  	bio->bi_end_io = end_io_func;
>  	bio->bi_private = tree;
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 844e595cde5b..6e13a62a2974 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -497,7 +497,7 @@ void extent_clear_unlock_delalloc(struct inode *inode, u64 start, u64 end,
>  				 u64 delalloc_end, struct page *locked_page,
>  				 unsigned bits_to_clear,
>  				 unsigned long page_ops);
> -struct bio *btrfs_bio_alloc(struct block_device *bdev, u64 first_byte);
> +struct bio *btrfs_bio_alloc(u64 first_byte);
>  struct bio *btrfs_io_bio_alloc(unsigned int nr_iovecs);
>  struct bio *btrfs_bio_clone(struct bio *bio);
>  struct bio *btrfs_bio_clone_partial(struct bio *orig, int offset, int size);
> 
