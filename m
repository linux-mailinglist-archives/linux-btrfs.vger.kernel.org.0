Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4AB640F776
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Sep 2021 14:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbhIQM3K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Sep 2021 08:29:10 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56406 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhIQM3I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Sep 2021 08:29:08 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3197C22285;
        Fri, 17 Sep 2021 12:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631881665; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C5fl6GrP4i4BDqCwZa8Sy3i64txJGUSiSgLdeU2oh7A=;
        b=ST5ReenMkXX3YuQfgX5mj0jQynQlRxNBc9YxVxluXhMudGdWWTqarV/4iZodui04+iQAOS
        edpKVVMwlQ1gkoTVk6ckREdOePZSLOFCG9by5tyJP5IM5PUA+muwLr0DURvGCeXoj9YXdu
        rLmj2QGoDRWAfXncV8m+TEh9YjGLCc0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F1F5E13ABA;
        Fri, 17 Sep 2021 12:27:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TAWIOMCJRGELSgAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 17 Sep 2021 12:27:44 +0000
Subject: Re: [PATCH v3 2/3] btrfs: remove btrfs_bio_alloc() helper
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210915071718.59418-1-wqu@suse.com>
 <20210915071718.59418-3-wqu@suse.com>
Cc:     David Sterba <dsterba@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <a4380e7b-b728-fd85-b6c1-175a53f6a1ce@suse.com>
Date:   Fri, 17 Sep 2021 15:27:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210915071718.59418-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 15.09.21 г. 10:17, Qu Wenruo wrote:
> The helper btrfs_bio_alloc() is almost the same as btrfs_io_bio_alloc(),
> except it's allocating using BIO_MAX_VECS as @nr_iovecs, and initialize
> bio->bi_iter.bi_sector.
> 
> However the naming itself is not using "btrfs_io_bio" to indicate its
> parameter is "strcut btrfs_io_bio" and can be easily confused with
> "struct btrfs_bio".
> 
> Considering assigned bio->bi_iter.bi_sector is such a simple work and
> there are already tons of call sites doing that manually, there is no
> need to do that in a helper.
> 
> Remove btrfs_bio_alloc() helper, and enhance btrfs_io_bio_alloc()
> function to provide a fail-safe value for its @nr_iovecs.
> 
> And then replace all btrfs_bio_alloc() callers with
> btrfs_io_bio_alloc().
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/compression.c | 12 ++++++++----
>  fs/btrfs/extent_io.c   | 33 +++++++++++++++------------------
>  fs/btrfs/extent_io.h   |  1 -
>  3 files changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 7869ad12bc6e..2475dc0b1c22 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -418,7 +418,8 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
>  	cb->orig_bio = NULL;
>  	cb->nr_pages = nr_pages;
>  
> -	bio = btrfs_bio_alloc(first_byte);
> +	bio = btrfs_io_bio_alloc(0);
> +	bio->bi_iter.bi_sector = first_byte >> SECTOR_SHIFT;
>  	bio->bi_opf = bio_op | write_flags;
>  	bio->bi_private = cb;
>  	bio->bi_end_io = end_compressed_bio_write;
> @@ -490,7 +491,8 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
>  				bio_endio(bio);
>  			}
>  
> -			bio = btrfs_bio_alloc(first_byte);
> +			bio = btrfs_io_bio_alloc(0);
> +			bio->bi_iter.bi_sector = first_byte >> SECTOR_SHIFT;
>  			bio->bi_opf = bio_op | write_flags;
>  			bio->bi_private = cb;
>  			bio->bi_end_io = end_compressed_bio_write;
> @@ -748,7 +750,8 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>  	/* include any pages we added in add_ra-bio_pages */
>  	cb->len = bio->bi_iter.bi_size;
>  
> -	comp_bio = btrfs_bio_alloc(cur_disk_byte);
> +	comp_bio = btrfs_io_bio_alloc(0);
> +	comp_bio->bi_iter.bi_sector = cur_disk_byte >> SECTOR_SHIFT;
>  	comp_bio->bi_opf = REQ_OP_READ;
>  	comp_bio->bi_private = cb;
>  	comp_bio->bi_end_io = end_compressed_bio_read;
> @@ -806,7 +809,8 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>  				bio_endio(comp_bio);
>  			}
>  
> -			comp_bio = btrfs_bio_alloc(cur_disk_byte);
> +			comp_bio = btrfs_io_bio_alloc(0);
> +			comp_bio->bi_iter.bi_sector = cur_disk_byte >> SECTOR_SHIFT;
>  			comp_bio->bi_opf = REQ_OP_READ;
>  			comp_bio->bi_private = cb;
>  			comp_bio->bi_end_io = end_compressed_bio_read;
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 1aed03ef5f49..d3fcf7e8dc48 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3121,16 +3121,22 @@ static inline void btrfs_io_bio_init
After reading through the whole patch I agree with the naming, though
yeah it's a bit long, but we've been using this wordy naming. For
identifiers it's fine to use lbio and it's now clear from the context
that it's about the btrfs-specific features.(struct btrfs_io_bio *btrfs_bio)
>  }
>  
>  /*
> - * The following helpers allocate a bio. As it's backed by a bioset, it'll
> - * never fail.  We're returning a bio right now but you can call btrfs_io_bio
> - * for the appropriate container_of magic
> + * Allocate a btrfs_io_bio, with @nr_iovecs as maximum iovecs.
> + *
> + * If @nr_iovecs is 0, it will use BIO_MAX_VECS as @nr_iovces instead.
> + * This behavior is to provide a fail-safe default value.
> + *
> + * This helper uses bioset to allocate the bio, thus it's backed by mempool,
> + * and should not fail from process contexts.
>   */
> -struct bio *btrfs_bio_alloc(u64 first_byte)
> +struct bio *btrfs_io_bio_alloc(unsigned int nr_iovecs)
>  {
>  	struct bio *bio;
>  
> -	bio = bio_alloc_bioset(GFP_NOFS, BIO_MAX_VECS, &btrfs_bioset);
> -	bio->bi_iter.bi_sector = first_byte >> 9;
> +	ASSERT(nr_iovecs <= BIO_MAX_VECS);
> +	if (nr_iovecs == 0)
> +		nr_iovecs = BIO_MAX_VECS;

hell no! How come passing 0 actually means BIO_MAX_VEC. Instead of
having 0 everywhere and have the function translate this to
BIO_MAX_VECS, simply pass BIO_MAX_VECS in every call site where it's
needed.

David, please either fix the patch in the tree or retract it. Let's try
and refrain from adding such "gems" to the code base.

<snip>
