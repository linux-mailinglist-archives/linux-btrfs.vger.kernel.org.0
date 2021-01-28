Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEB0307470
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Jan 2021 12:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbhA1LIr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Jan 2021 06:08:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:50934 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229640AbhA1LIk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Jan 2021 06:08:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6072BAE57;
        Thu, 28 Jan 2021 11:07:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B9699DA7D9; Thu, 28 Jan 2021 12:06:11 +0100 (CET)
Date:   Thu, 28 Jan 2021 12:06:11 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Michal Rostecki <mrostecki@suse.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michal Rostecki <mrostecki@suse.com>
Subject: Re: [PATCH v2] btrfs: Avoid calling btrfs_get_chunk_map() twice
Message-ID: <20210128110611.GK1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Michal Rostecki <mrostecki@suse.de>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michal Rostecki <mrostecki@suse.com>
References: <20210127135728.30276-1-mrostecki@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127135728.30276-1-mrostecki@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 27, 2021 at 02:57:27PM +0100, Michal Rostecki wrote:
> From: Michal Rostecki <mrostecki@suse.com>
> 
> Before this change, the btrfs_get_io_geometry() function was calling
> btrfs_get_chunk_map() to get the extent mapping, necessary for
> calculating the I/O geometry. It was using that extent mapping only
> internally and freeing the pointer after its execution.
> 
> That resulted in calling btrfs_get_chunk_map() de facto twice by the
> __btrfs_map_block() function. It was calling btrfs_get_io_geometry()
> first and then calling btrfs_get_chunk_map() directly to get the extent
> mapping, used by the rest of the function.
> 
> This change fixes that by passing the extent mapping to the
> btrfs_get_io_geometry() function as an argument.
> 
> v2:
> When btrfs_get_chunk_map() returns an error in btrfs_submit_direct():
> - Use errno_to_blk_status(PTR_ERR(em)) as the status
> - Set em to NULL

The version-to-version changelog belongs under the -- line. If there's
something relevant in v2 it should be put into the proper changelog but
normal fixups like 'set em to NULL' do not have the long-term value that
we want to record in the changelog.

> Signed-off-by: Michal Rostecki <mrostecki@suse.com>
> ---
>  fs/btrfs/inode.c   | 38 +++++++++++++++++++++++++++++---------
>  fs/btrfs/volumes.c | 39 ++++++++++++++++-----------------------
>  fs/btrfs/volumes.h |  5 +++--
>  3 files changed, 48 insertions(+), 34 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 0dbe1aaa0b71..e2ee3a9c1140 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2183,9 +2183,10 @@ int btrfs_bio_fits_in_stripe(struct page *page, size_t size, struct bio *bio,
>  	struct inode *inode = page->mapping->host;
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>  	u64 logical = bio->bi_iter.bi_sector << 9;
> +	struct extent_map *em;
>  	u64 length = 0;
>  	u64 map_length;
> -	int ret;
> +	int ret = 0;
>  	struct btrfs_io_geometry geom;
>  
>  	if (bio_flags & EXTENT_BIO_COMPRESSED)
> @@ -2193,14 +2194,21 @@ int btrfs_bio_fits_in_stripe(struct page *page, size_t size, struct bio *bio,
>  
>  	length = bio->bi_iter.bi_size;
>  	map_length = length;
> -	ret = btrfs_get_io_geometry(fs_info, btrfs_op(bio), logical, map_length,
> -				    &geom);
> +	em = btrfs_get_chunk_map(fs_info, logical, map_length);
> +	if (IS_ERR(em))
> +		return PTR_ERR(em);
> +	ret = btrfs_get_io_geometry(fs_info, em, btrfs_op(bio), logical,
> +				    map_length, &geom);
>  	if (ret < 0)
> -		return ret;
> +		goto out;
>  
> -	if (geom.len < length + size)
> -		return 1;
> -	return 0;
> +	if (geom.len < length + size) {
> +		ret = 1;
> +		goto out;
> +	}
> +out:
> +	free_extent_map(em);
> +	return ret;
>  }
>  
>  /*
> @@ -7941,10 +7949,12 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
>  	u64 submit_len;
>  	int clone_offset = 0;
>  	int clone_len;
> +	int logical;

This needs to be u64

>  	int ret;
>  	blk_status_t status;
>  	struct btrfs_io_geometry geom;
>  	struct btrfs_dio_data *dio_data = iomap->private;
> +	struct extent_map *em;
>  
>  	dip = btrfs_create_dio_private(dio_bio, inode, file_offset);
>  	if (!dip) {
> @@ -7970,11 +7980,18 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
>  	}
>  
>  	start_sector = dio_bio->bi_iter.bi_sector;
> +	logical = start_sector << 9;

Otherwise this overflows on logical address larger than 2^23 which is 8G.
