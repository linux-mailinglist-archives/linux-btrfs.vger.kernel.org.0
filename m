Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F30164BC33
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 19:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236419AbiLMSjW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 13:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235699AbiLMSjV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 13:39:21 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469471097
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 10:39:20 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id i20so562915qtw.9
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 10:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P3X5kNUzlUrmiUVO+2TfHeDqfhEek74mBc/MxtAq5wU=;
        b=n5hEz4ydM7EIgHhSKBxL2pe/to7slAgC7mXGBk5V2oyK/Bzy/QFkOgHUQaRhnd+ZUc
         R81j+KTgszYX6XHojCKFMFwybX2Kkc+zybcvK7c/Ll6EQ4q1zY8NyWXHVA2TCV//92AR
         b4HoNzmLockMJphiAsz+IlmFvRWjUZhaAa4jYSMXyPwxMX0b5pAHilV1SP4QYJ80MsjZ
         WkuzttUbjtzghxMycEiIKkZxtAYSWxl9FY84oDlNA18ynl6P9ROBSwxrgEgmh2VY4bLM
         sDuIDpE6TgqPAlJUwndAE9bEhfL0VWO1DZ4t3b2jjCGLOgXsCvSrXTjABqHzy4JCz6gY
         5cHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3X5kNUzlUrmiUVO+2TfHeDqfhEek74mBc/MxtAq5wU=;
        b=f147jSf0meb2fzZK9IlxepVFceXcIYMnQ9MEsogX6oC89LqFZWUD93aTAnGIdkP7rf
         x/IIu9C3PLlODVd2nA4UQyxFNrKrhqkyhkGl98DIV1s8xz/5kAl6CIyoDMsjv9GbgwMD
         i7OOf+2ZdZ9u7N5tRxk0VqkDb7mRFWQCB4zHCAuPKEE1S4DiMSTDIWgzgYX75x5a48tF
         5sw5q3r1zsMuwdCMDgQp9E1ybwkmoSiOx82t8Mwy/U7dPs12B1Th6jThOI0PiY3Y+OYN
         x8YnKJEn2Zv32xl/BK6x85i0DHI8U7cOX51V7eabxhVIApLtbDW9ly7fe5YxXVSuhZ5w
         rdHg==
X-Gm-Message-State: ANoB5pmkU5SMMTN0qeDJDWnK/92sg+0A6YEsejJwNpL68w9STT9r5pRW
        vuSYQz2fKGE7SlF5j5yMdu7Ojw==
X-Google-Smtp-Source: AA0mqf5mMAew/QTltD4FBAgol7M4sx2BQ2nEmKNN8BOyNlLwgUYG58/A9DkBSF+mSp2FS3M1iYHxWQ==
X-Received: by 2002:a05:622a:4cca:b0:3a5:309c:4b68 with SMTP id fa10-20020a05622a4cca00b003a5309c4b68mr35056649qtb.5.1670956759237;
        Tue, 13 Dec 2022 10:39:19 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id w9-20020ac87189000000b003a6a19ee4f0sm315791qto.33.2022.12.13.10.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 10:39:18 -0800 (PST)
Date:   Tue, 13 Dec 2022 13:39:17 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 06/16] btrfs: Lock extents before pages in writepages
Message-ID: <Y5jG1Rdy+6QPjy0c@localhost.localdomain>
References: <cover.1668530684.git.rgoldwyn@suse.com>
 <28cb7dbc0216d2a5f55efd296113f9f9576dda41.1668530684.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28cb7dbc0216d2a5f55efd296113f9f9576dda41.1668530684.git.rgoldwyn@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 15, 2022 at 12:00:24PM -0600, Goldwyn Rodrigues wrote:
> writepages() locks the extents in find_lock_delalloc_range() and unlocks
> using clear_bit EXTENT_LOCKED operations is cow/delalloc operations.
> 
> Call extent locking/unlocking around writepages() sequence as opposed to
> while performing delayed allocation.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/extent_io.c |  5 -----
>  fs/btrfs/inode.c     | 43 +++++++++++++++++++++++++++++++------------
>  2 files changed, 31 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 92068e4ff9c3..42bae149f923 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -464,15 +464,10 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
>  		}
>  	}
>  
> -	/* step three, lock the state bits for the whole range */
> -	lock_extent(tree, delalloc_start, delalloc_end, &cached_state);
> -
>  	/* then test to make sure it is all still delalloc */
>  	ret = test_range_bit(tree, delalloc_start, delalloc_end,
>  			     EXTENT_DELALLOC, 1, cached_state);
>  	if (!ret) {
> -		unlock_extent(tree, delalloc_start, delalloc_end,
> -			      &cached_state);
>  		__unlock_for_delalloc(inode, locked_page,
>  			      delalloc_start, delalloc_end);
>  		cond_resched();
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 4bfa51871ddc..92726831dd5d 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -992,7 +992,6 @@ static int submit_one_async_extent(struct btrfs_inode *inode,
>  				   struct async_extent *async_extent,
>  				   u64 *alloc_hint)
>  {
> -	struct extent_io_tree *io_tree = &inode->io_tree;
>  	struct btrfs_root *root = inode->root;
>  	struct btrfs_fs_info *fs_info = root->fs_info;
>  	struct btrfs_key ins;
> @@ -1013,7 +1012,6 @@ static int submit_one_async_extent(struct btrfs_inode *inode,
>  		if (!(start >= locked_page_end || end <= locked_page_start))
>  			locked_page = async_chunk->locked_page;
>  	}
> -	lock_extent(io_tree, start, end, NULL);
>  
>  	/* We have fall back to uncompressed write */
>  	if (!async_extent->pages)
> @@ -1067,7 +1065,7 @@ static int submit_one_async_extent(struct btrfs_inode *inode,
>  
>  	/* Clear dirty, set writeback and unlock the pages. */
>  	extent_clear_unlock_delalloc(inode, start, end,
> -			NULL, EXTENT_LOCKED | EXTENT_DELALLOC,
> +			NULL, EXTENT_DELALLOC,
>  			PAGE_UNLOCK | PAGE_START_WRITEBACK);
>  	if (btrfs_submit_compressed_write(inode, start,	/* file_offset */
>  			    async_extent->ram_size,	/* num_bytes */
> @@ -1095,7 +1093,7 @@ static int submit_one_async_extent(struct btrfs_inode *inode,
>  	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, 1);
>  out_free:
>  	extent_clear_unlock_delalloc(inode, start, end,
> -				     NULL, EXTENT_LOCKED | EXTENT_DELALLOC |
> +				     NULL, EXTENT_DELALLOC |
>  				     EXTENT_DELALLOC_NEW |
>  				     EXTENT_DEFRAG | EXTENT_DO_ACCOUNTING,
>  				     PAGE_UNLOCK | PAGE_START_WRITEBACK |
> @@ -1263,7 +1261,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>  			 */
>  			extent_clear_unlock_delalloc(inode, start, end,
>  				     locked_page,
> -				     EXTENT_LOCKED | EXTENT_DELALLOC |
> +				     EXTENT_DELALLOC |
>  				     EXTENT_DELALLOC_NEW | EXTENT_DEFRAG |
>  				     EXTENT_DO_ACCOUNTING, PAGE_UNLOCK |
>  				     PAGE_START_WRITEBACK | PAGE_END_WRITEBACK);
> @@ -1374,7 +1372,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>  
>  		extent_clear_unlock_delalloc(inode, start, start + ram_size - 1,
>  					     locked_page,
> -					     EXTENT_LOCKED | EXTENT_DELALLOC,
> +					     EXTENT_DELALLOC,
>  					     page_ops);
>  		if (num_bytes < cur_alloc_size)
>  			num_bytes = 0;
> @@ -1425,7 +1423,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>  	 * We process each region below.
>  	 */
>  
> -	clear_bits = EXTENT_LOCKED | EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
> +	clear_bits = EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
>  		EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV;
>  	page_ops = PAGE_UNLOCK | PAGE_START_WRITEBACK | PAGE_END_WRITEBACK;
>  
> @@ -1575,7 +1573,7 @@ static int cow_file_range_async(struct btrfs_inode *inode,
>  	memalloc_nofs_restore(nofs_flag);
>  
>  	if (!ctx) {
> -		unsigned clear_bits = EXTENT_LOCKED | EXTENT_DELALLOC |
> +		unsigned clear_bits = EXTENT_DELALLOC |
>  			EXTENT_DELALLOC_NEW | EXTENT_DEFRAG |
>  			EXTENT_DO_ACCOUNTING;
>  		unsigned long page_ops = PAGE_UNLOCK | PAGE_START_WRITEBACK |
> @@ -1955,7 +1953,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
>  	path = btrfs_alloc_path();
>  	if (!path) {
>  		extent_clear_unlock_delalloc(inode, start, end, locked_page,
> -					     EXTENT_LOCKED | EXTENT_DELALLOC |
> +					     EXTENT_DELALLOC |
>  					     EXTENT_DO_ACCOUNTING |
>  					     EXTENT_DEFRAG, PAGE_UNLOCK |
>  					     PAGE_START_WRITEBACK |
> @@ -2169,7 +2167,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
>  						      nocow_args.num_bytes);
>  
>  		extent_clear_unlock_delalloc(inode, cur_offset, nocow_end,
> -					     locked_page, EXTENT_LOCKED |
> +					     locked_page,
>  					     EXTENT_DELALLOC |
>  					     EXTENT_CLEAR_DATA_RESV,
>  					     PAGE_UNLOCK | PAGE_SET_ORDERED);
> @@ -2205,7 +2203,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
>  
>  	if (ret && cur_offset < end)
>  		extent_clear_unlock_delalloc(inode, cur_offset, end,
> -					     locked_page, EXTENT_LOCKED |
> +					     locked_page,
>  					     EXTENT_DELALLOC | EXTENT_DEFRAG |
>  					     EXTENT_DO_ACCOUNTING, PAGE_UNLOCK |
>  					     PAGE_START_WRITEBACK |
> @@ -8223,7 +8221,28 @@ static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  static int btrfs_writepages(struct address_space *mapping,
>  			    struct writeback_control *wbc)
>  {
> -	return extent_writepages(mapping, wbc);
> +	u64 start, end;
> +	struct inode *inode = mapping->host;
> +	struct extent_state *cached = NULL;
> +	int ret;
> +	u64 isize = round_up(i_size_read(inode), PAGE_SIZE) - 1;
> +
> +	if (wbc->range_cyclic) {
> +		start = mapping->writeback_index << PAGE_SHIFT;
> +		end = isize;

I had to go look, but ->range_cyclic can be used by the background flushing
thread, which of course will be single threaded.  However we can also trigger
this with memcg flushing during balance_dirty_pages(), which means that
writeback_index can change.  Additionally isize can change arbitrarily between
now and extent_writepages.

I think you're going to have to change extent_writepages to take the start and
end index in order to make sure we're not writing things we haven't locked.

Alternatively you could keep track of range_cyclic here, update the wbc with the
range_start and range_end that you calculate here, and reset it on the way out.

Personally I think it would be cleaner to pass in the start and end into
extent_writepages, and move the ->writeback_index update into this function, as
well as the logic for start and end.  Thanks,

Josef
