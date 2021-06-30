Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113AA3B82B0
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jun 2021 15:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234702AbhF3NLh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Jun 2021 09:11:37 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58546 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbhF3NLf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Jun 2021 09:11:35 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 619AF1FE79;
        Wed, 30 Jun 2021 13:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625058546;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ign9RGO4jtzKI405BYbDFg5wzmZKZDQyEMgyhbOJG9c=;
        b=RPFbSPk8qfclJ4uHFd7kl/m1s8TeRtKM/KG47OseBTONdGwxKLKucgnlLshRAF0LZ+tccu
        CVysC1X2Ue3mt8Bra6/DBFZp7iuTFmIa+mL0RDiZzbW2ph5pvi3ankEvyA8oMaW4642KD3
        6elR98QcsQDB0cx3XiLaHc9sLR9MHDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625058546;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ign9RGO4jtzKI405BYbDFg5wzmZKZDQyEMgyhbOJG9c=;
        b=YOWQVZ0W6U+Y46NAaUaxamQ/ZZALH1zOlJ8FzwhMdbfza9Hyqh9/jr0ldL5V4zd2BPTFOz
        xaOYGWzOiYjfEvDw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 5A6A4A3B88;
        Wed, 30 Jun 2021 13:09:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5ADABDA7A2; Wed, 30 Jun 2021 15:06:36 +0200 (CEST)
Date:   Wed, 30 Jun 2021 15:06:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/4] btrfs: remove the GFP_HIGHMEM flag for compression
 code
Message-ID: <20210630130636.GK2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210630093233.238032-1-wqu@suse.com>
 <20210630093233.238032-3-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630093233.238032-3-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 30, 2021 at 05:32:31PM +0800, Qu Wenruo wrote:
> This allows later decompress functions to get rid of kmap()/kunmap()
> pairs.
> 
> And since all other filesystems are getting rid of HIGHMEM, it should
> not be a problem for btrfs.
> 
> Although we removed the HIGHMEM allocation, we still keep the
> kmap()/kunmap() pairs.
> They will be removed when involved functions are refactored later.

Without removing the kmaps it's incomplete so I'll post the series
removing it from the compression code at least.

> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/compression.c | 3 +--
>  fs/btrfs/lzo.c         | 4 ++--
>  fs/btrfs/zlib.c        | 6 +++---
>  fs/btrfs/zstd.c        | 6 +++---
>  4 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 19da933c5f1c..8318e56b5ab4 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -724,8 +724,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>  		goto fail1;
>  
>  	for (pg_index = 0; pg_index < nr_pages; pg_index++) {
> -		cb->compressed_pages[pg_index] = alloc_page(GFP_NOFS |
> -							      __GFP_HIGHMEM);
> +		cb->compressed_pages[pg_index] = alloc_page(GFP_NOFS);
>  		if (!cb->compressed_pages[pg_index]) {
>  			faili = pg_index - 1;
>  			ret = BLK_STS_RESOURCE;
> diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
> index cd042c7567a4..2bebb60c5830 100644
> --- a/fs/btrfs/lzo.c
> +++ b/fs/btrfs/lzo.c
> @@ -146,7 +146,7 @@ int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
>  	 * store the size of all chunks of compressed data in
>  	 * the first 4 bytes
>  	 */
> -	out_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
> +	out_page = alloc_page(GFP_NOFS);
>  	if (out_page == NULL) {
>  		ret = -ENOMEM;
>  		goto out;
> @@ -216,7 +216,7 @@ int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
>  					goto out;
>  				}
>  
> -				out_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
> +				out_page = alloc_page(GFP_NOFS);
>  				if (out_page == NULL) {
>  					ret = -ENOMEM;
>  					goto out;
> diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
> index c3fa7d3fa770..2c792bc5a987 100644
> --- a/fs/btrfs/zlib.c
> +++ b/fs/btrfs/zlib.c
> @@ -121,7 +121,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
>  	workspace->strm.total_in = 0;
>  	workspace->strm.total_out = 0;
>  
> -	out_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
> +	out_page = alloc_page(GFP_NOFS);
>  	if (out_page == NULL) {
>  		ret = -ENOMEM;
>  		goto out;
> @@ -202,7 +202,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
>  				ret = -E2BIG;
>  				goto out;
>  			}
> -			out_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
> +			out_page = alloc_page(GFP_NOFS);
>  			if (out_page == NULL) {
>  				ret = -ENOMEM;
>  				goto out;
> @@ -240,7 +240,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
>  				ret = -E2BIG;
>  				goto out;
>  			}
> -			out_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
> +			out_page = alloc_page(GFP_NOFS);
>  			if (out_page == NULL) {
>  				ret = -ENOMEM;
>  				goto out;
> diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
> index 3e26b466476a..9451d2bb984e 100644
> --- a/fs/btrfs/zstd.c
> +++ b/fs/btrfs/zstd.c
> @@ -405,7 +405,7 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
>  
>  
>  	/* Allocate and map in the output buffer */
> -	out_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
> +	out_page = alloc_page(GFP_NOFS);
>  	if (out_page == NULL) {
>  		ret = -ENOMEM;
>  		goto out;
> @@ -452,7 +452,7 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
>  				ret = -E2BIG;
>  				goto out;
>  			}
> -			out_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
> +			out_page = alloc_page(GFP_NOFS);
>  			if (out_page == NULL) {
>  				ret = -ENOMEM;
>  				goto out;
> @@ -512,7 +512,7 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
>  			ret = -E2BIG;
>  			goto out;
>  		}
> -		out_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
> +		out_page = alloc_page(GFP_NOFS);
>  		if (out_page == NULL) {
>  			ret = -ENOMEM;
>  			goto out;
> -- 
> 2.32.0
