Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0654542C43
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2019 18:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502106AbfFLQ3H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jun 2019 12:29:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:43196 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2438104AbfFLQ3H (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jun 2019 12:29:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 38E0CAC9B
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jun 2019 16:29:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 59228DA8F5; Wed, 12 Jun 2019 18:29:56 +0200 (CEST)
Date:   Wed, 12 Jun 2019 18:29:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs: Use btrfs_io_geometry appropriately
Message-ID: <20190612162956.GR3563@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190603090505.16800-1-nborisov@suse.com>
 <20190603090505.16800-4-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603090505.16800-4-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 03, 2019 at 12:05:05PM +0300, Nikolay Borisov wrote:
> Presently btrfs_map_block is used not only to do everything necessary
> to map a bio to the underlying allocation profile but it's also used to
> identify how much data could be written based on btrfs' stripe logic
> without actually submitting anything. This is achieved by passing NULL
> for 'bbio_ret' parameter.
> 
> This patch refactors all callers that require just the mapping length
> by switching them to using btrfs_io_geometry instead of calling
> btrfs_map_block with a special NULL value for 'bbio_ret'. No functional
> change.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/inode.c   | 25 +++++++--------
>  fs/btrfs/volumes.c | 77 +++++++++-------------------------------------
>  2 files changed, 27 insertions(+), 75 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 80fdf6f21f74..a3abba4c2e2c 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1932,17 +1932,19 @@ int btrfs_bio_fits_in_stripe(struct page *page, size_t size, struct bio *bio,
>  	u64 length = 0;
>  	u64 map_length;
>  	int ret;
> +	struct btrfs_io_geometry geom;

Stack bloatometer does not like it:

__btrfs_map_block                                                 +56 (200 -> 256)
btrfs_submit_direct                                               +40 (176 -> 216)
btrfs_bio_fits_in_stripe                                          +40 (40 -> 80)

OLD/NEW DELTA:     +104
PRE/POST DELTA:     +240

>  
>  	if (bio_flags & EXTENT_BIO_COMPRESSED)
>  		return 0;
>  
>  	length = bio->bi_iter.bi_size;
>  	map_length = length;
> -	ret = btrfs_map_block(fs_info, btrfs_op(bio), logical, &map_length,
> -			      NULL, 0);
> +	ret = btrfs_io_geometry(fs_info, btrfs_op(bio), logical, map_length,
> +				&geom);
>  	if (ret < 0)
>  		return ret;
> -	if (map_length < length + size)
> +
> +	if (geom.len < length + size)

All the function needs from the geometry is one member 'len'.

>  		return 1;
>  	return 0;
>  }
> @@ -8331,15 +8333,15 @@ static int btrfs_submit_direct_hook(struct btrfs_dio_private *dip)
>  	int clone_len;
>  	int ret;
>  	blk_status_t status;
> +	struct btrfs_io_geometry geom;

And btrfs_submit_direct_hook does not seem to use the geom members at
all, which looks like the parameters are only validated in some way.
