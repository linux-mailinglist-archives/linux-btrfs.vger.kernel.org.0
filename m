Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8395F54B5FE
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jun 2022 18:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243905AbiFNQZQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jun 2022 12:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241398AbiFNQZN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jun 2022 12:25:13 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAA82871C
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 09:25:11 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id n197so6781461qke.1
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 09:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/Y8Er4C3hgfg/r5bFvtUwBEBzeWCFWgt2gmmg5Ar10o=;
        b=G+IrsYNtbVkl3cQ+a0Q0PDt+zzIRsvGsoZvKfnSGzdZ9xZrW/47K75xQvlll6uHTDc
         Fx17HYF9eZ7rdRSAqTTBBsx0jAkYKm0Lzr+m99+4kv8f8v5QMNNngCkE6VU187gIozIC
         S2cX98gpOlC3TGkVoMSqv03MbCkbEfEQ+yEzTNIP6LWXBaPynhgEgXa0oc1uDdVUoN67
         0TX0CSVItMd4cXlJqRVWo8v9GELO104wqx4Xv96FlymeGI8X+TTJ8t8ScH+60gz5mOMl
         XbjkkUd6zURlGaXlCkJ3pwTvihThvamr5GwFG+QJOUpRSIRVd+eMCV34a8JQeODE0KwM
         LmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/Y8Er4C3hgfg/r5bFvtUwBEBzeWCFWgt2gmmg5Ar10o=;
        b=wyDzRgKsVk9j/plWhyaF1fNh80wWeGTfMKWRGnlVJKy+wdxYl9eB9EvuJ+bRcfd9XI
         DYBoYh/Z1QXYY1qXBpHBz1J/OOFqHSpKva28l698tD9gYW00FPgOVhvsU5DThaFcB0rX
         CxxCbFcHATQZCoYATFO+Tf0nut18gy1fO4mFzILIYGES03GzvB+Do8fZu/mLCWk/FgyF
         /lud3p5EhRvKKuyJrJ7QDOi5HJJioYjfp37lvwa7y6ygdFdLu6nxMa0mxmsbKWagb7H0
         ielIrjKQTAIUqVb1+zT+dpm4rTrKbPCV38skgh0tRtx4EGGLME1BPfP2REcBuHcQUprN
         bLjA==
X-Gm-Message-State: AOAM533u0athiBpbbboUirK1IaJARS2iLMKcqWs71hTttXfT+eyAWmqD
        Tl3RNqNnsYodwI2XkdPI245tOg==
X-Google-Smtp-Source: ABdhPJwMohrHUhJy253tvP3L9LDANJTFRyrOoinpXM4v9Uv+2hj6PPNGa5CzlOhw0x8gBJMI5+tsaw==
X-Received: by 2002:a05:620a:318a:b0:6a7:4d95:3526 with SMTP id bi10-20020a05620a318a00b006a74d953526mr4620038qkb.648.1655223909999;
        Tue, 14 Jun 2022 09:25:09 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s17-20020a05620a255100b006a6ab8f761csm10153954qko.62.2022.06.14.09.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 09:25:09 -0700 (PDT)
Date:   Tue, 14 Jun 2022 12:25:08 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 7/9] btrfs: use the new read repair code for buffered
 reads
Message-ID: <Yqi2ZMWV6H6Agb+2@localhost.localdomain>
References: <20220527084320.2130831-1-hch@lst.de>
 <20220527084320.2130831-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527084320.2130831-8-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 27, 2022 at 10:43:18AM +0200, Christoph Hellwig wrote:
> Start/end a repair session as needed in end_bio_extent_readpage and
> submit_data_read_repair.  Unlike direct I/O, the buffered I/O handler
> completes I/O on a per-sector basis and thus needs to pass an endio
> handler to the repair code, which unlocks all pages and marks them
> as either uptodate or not.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/btrfs/extent_io.c | 76 ++++++++++++++++++++------------------------
>  1 file changed, 35 insertions(+), 41 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 27775031ed2d4..9d7835ba6d396 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -30,6 +30,7 @@
>  #include "zoned.h"
>  #include "block-group.h"
>  #include "compression.h"
> +#include "read-repair.h"
>  
>  static struct kmem_cache *extent_state_cache;
>  static struct kmem_cache *extent_buffer_cache;
> @@ -2683,14 +2684,29 @@ static void end_sector_io(struct page *page, u64 offset, bool uptodate)
>  				    offset + sectorsize - 1, &cached);
>  }
>  
> +static void end_read_repair(struct btrfs_bio *repair_bbio, struct inode *inode,
> +		bool uptodate)
> +{
> +	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> +	struct bvec_iter iter;
> +	struct bio_vec bv;
> +	u32 offset;
> +
> +	btrfs_bio_for_each_sector(fs_info, bv, repair_bbio, iter, offset)
> +		end_sector_io(bv.bv_page, repair_bbio->file_offset + offset,
> +				uptodate);
> +}
> +
>  static void submit_data_read_repair(struct inode *inode, struct bio *failed_bio,
>  				    u32 bio_offset, const struct bio_vec *bvec,
> -				    int failed_mirror, unsigned int error_bitmap)
> +				    int failed_mirror,
> +				    unsigned int error_bitmap,
> +				    struct btrfs_read_repair *rr)
>  {
> -	const unsigned int pgoff = bvec->bv_offset;
> +	struct btrfs_bio *failed_bbio = btrfs_bio(failed_bio);
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> +	u64 start = page_offset(bvec->bv_page) + bvec->bv_offset;
>  	struct page *page = bvec->bv_page;
> -	const u64 start = page_offset(bvec->bv_page) + bvec->bv_offset;
>  	const u64 end = start + bvec->bv_len - 1;
>  	const u32 sectorsize = fs_info->sectorsize;
>  	const int nr_bits = (end + 1 - start) >> fs_info->sectorsize_bits;
> @@ -2712,38 +2728,17 @@ static void submit_data_read_repair(struct inode *inode, struct bio *failed_bio,
>  
>  	/* Iterate through all the sectors in the range */
>  	for (i = 0; i < nr_bits; i++) {
> -		const unsigned int offset = i * sectorsize;
> -		bool uptodate = false;
> -		int ret;
> -
> -		if (!(error_bitmap & (1U << i))) {
> -			/*
> -			 * This sector has no error, just end the page read
> -			 * and unlock the range.
> -			 */
> -			uptodate = true;
> -			goto next;
> +		bool uptodate = !(error_bitmap & (1U << i));
> +
> +		if (uptodate ||
> +		    !btrfs_read_repair_add(rr, failed_bbio, inode,
> +		    		bio_offset)) {
> +			btrfs_read_repair_finish(rr, failed_bbio, inode,
> +					bio_offset, end_read_repair);
> +			end_sector_io(page, start, uptodate);
>  		}
> -
> -		ret = btrfs_repair_one_sector(inode, failed_bio,
> -				bio_offset + offset,
> -				page, pgoff + offset, start + offset,
> -				failed_mirror, btrfs_submit_data_read_bio);
> -		if (!ret) {
> -			/*
> -			 * We have submitted the read repair, the page release
> -			 * will be handled by the endio function of the
> -			 * submitted repair bio.
> -			 * Thus we don't need to do any thing here.
> -			 */
> -			continue;
> -		}
> -		/*
> -		 * Continue on failed repair, otherwise the remaining sectors
> -		 * will not be properly unlocked.
> -		 */
> -next:
> -		end_sector_io(page, start + offset, uptodate);
> +		bio_offset += sectorsize;
> +		start += sectorsize;
>  	}
>  }
>  
> @@ -2954,8 +2949,6 @@ static void end_bio_extent_readpage(struct bio *bio)
>  	struct bio_vec *bvec;
>  	struct btrfs_bio *bbio = btrfs_bio(bio);
>  	int mirror = bbio->mirror_num;
> -	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
> -	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
>  	bool uptodate = !bio->bi_status;
>  	struct processed_extent processed = { 0 };
>  	/*
> @@ -2964,6 +2957,7 @@ static void end_bio_extent_readpage(struct bio *bio)
>  	 */
>  	u32 bio_offset = 0;
>  	struct bvec_iter_all iter_all;
> +	struct btrfs_read_repair rr = { };
>  
>  	btrfs_bio(bio)->file_offset =
>  		page_offset(first_vec->bv_page) + first_vec->bv_offset;
> @@ -3020,10 +3014,6 @@ static void end_bio_extent_readpage(struct bio *bio)
>  			loff_t i_size = i_size_read(inode);
>  			pgoff_t end_index = i_size >> PAGE_SHIFT;
>  
> -			clean_io_failure(BTRFS_I(inode)->root->fs_info,
> -					 failure_tree, tree, start, page,
> -					 btrfs_ino(BTRFS_I(inode)), 0);
> -
>  			/*
>  			 * Zero out the remaining part if this range straddles
>  			 * i_size.
> @@ -3063,9 +3053,11 @@ static void end_bio_extent_readpage(struct bio *bio)
>  			 * and bad sectors, we just continue to the next bvec.
>  			 */
>  			submit_data_read_repair(inode, bio, bio_offset, bvec,
> -						mirror, error_bitmap);
> +						mirror, error_bitmap, &rr);
>  		} else {
>  			/* Update page status and unlock */
> +			btrfs_read_repair_finish(&rr, btrfs_bio(bio), inode,
> +					bio_offset, end_read_repair);
>  			end_page_read(page, uptodate, start, len);
>  			endio_readpage_release_extent(&processed, BTRFS_I(inode),
>  					start, end, PageUptodate(page));
> @@ -3076,6 +3068,8 @@ static void end_bio_extent_readpage(struct bio *bio)
>  
>  	}
>  	/* Release the last extent */
> +	btrfs_read_repair_finish(&rr, btrfs_bio(bio), inode, bio_offset,
> +			end_read_repair);

This part is wrong, it's leading to BUG_ON(!locked_page(page)) when we do the
end_io.  We're essentially read_repair_finish for a page that is outside of our
bio.  The continuous testing caught this last week but I didn't notice it until
yesterday.  I pulled this part out and now btrfs/101 runs without panicing.
Thanks,

Josef
