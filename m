Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC55C6B11DA
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Mar 2023 20:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjCHTNu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Mar 2023 14:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjCHTNt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Mar 2023 14:13:49 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21CD8F702
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Mar 2023 11:13:46 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id C0A3C5C007E;
        Wed,  8 Mar 2023 14:13:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 08 Mar 2023 14:13:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1678302822; x=1678389222; bh=vc
        lgRDxUzofPzl1Fo+AFqsHbMlUFzwQN/C/LkivSay8=; b=NbQEbNNR6S/jIUA19S
        YRWU/vAz2jBLTQCwLU1zuN5JakhGescCVK56+EnWQVtlWRHb3fMXXoGCE+0E0hI4
        S/Y26IxXqJ/M8oGawIQg8Iix0rohuxUUBjBzH+bTtCWdG56r9ge73na0rgSgEMBc
        8ibB4jRmuWZQddlPrlRJN3SdNlcPslRvfFDt/IdYEcANzhnsweS7V8jx9sPjGBWo
        e3B+L6qn5hWBQYRZmI1bSDWudJ9Xa8wQoia40ubskjhzDcYc2xr2zFUadQEsJyqM
        MmeKiSiVJSHupg3DNjhbY8hUggZROEHT9BLtpYFbbkSdhz3LPGRVM16aI3r9XKTX
        zJgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1678302822; x=1678389222; bh=vclgRDxUzofPz
        l1Fo+AFqsHbMlUFzwQN/C/LkivSay8=; b=HLLgXBx06HxskrE2PVOQ3Ju857iXE
        Q6zMFZqyEn2qTfk+LLhE6R9Rk1Uy30lUIRpJhcQv8WLXhwvB0snBsZu/Wm4jKtMV
        QND10roILIzUv8JmsPrMZ5eaQ9+PEvZtlhyi2+jWbCPYM4qAJUNyw+/WxFQBdqZV
        5srFe0UkVPzu0uBQIZ0ctVkvi9DTaPg4RDsyF0bryBP1oTvBNx7n+kU3eMj0qrOY
        Fei19bU3/2CUHFWHZn6TkNFqKSaMTCrRGOcmqajRh3V0p061FL99ykvauuO3ZD5+
        svTgCAUSaWYPJoTEbccmm8xZ+XJRxQCiP8KbnpBtzZDARd1RyLu2QKWfQ==
X-ME-Sender: <xms:Zt4IZO_5r_0eErGlOhfvo-X3Pe2uIKWtuFa-bpKLPMyMre_jAfIa7w>
    <xme:Zt4IZOtAxBBEt_sJgqhrBfr8VADNF6OSMCRgsZte4mRtYwW_en6wc8Pa_p49inBHB
    RbE_wZ-q9l4yYG22dI>
X-ME-Received: <xmr:Zt4IZEAe5w8qg_V9b-AZAtGwnuFod0zENrVzSprTOlbNKK9SRlHGfCE0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddufedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:Zt4IZGfNeBLD8woDAM5nOkENfyede2u9S4Pz-o6m7k74VG2FftDm8w>
    <xmx:Zt4IZDPDMU90bdZoiq3fABLiX10VinDo_yTFk5ZnwT5YGrpiTzg8-Q>
    <xmx:Zt4IZAmLehu8hvcRSW4ILDQSnpfipyFYgiAipQtrpF9ferCeKaba6A>
    <xmx:Zt4IZJ1-Xy2qMnLQvRHw18LzrOfofxXdSAluB8pI26lMedD8b02oqA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Mar 2023 14:13:42 -0500 (EST)
Date:   Wed, 8 Mar 2023 11:13:40 -0800
From:   Boris Burkov <boris@bur.io>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 11/21] btrfs: locking extents for async writeback
Message-ID: <20230308191340.GB30177@zen>
References: <cover.1677793433.git.rgoldwyn@suse.com>
 <2aecd82ddb64139b04ccc51c5e625a7e6b3dc08e.1677793433.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2aecd82ddb64139b04ccc51c5e625a7e6b3dc08e.1677793433.git.rgoldwyn@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 02, 2023 at 04:24:56PM -0600, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> For async writebacks, lock the extents and then perform the cow file
> range for async. Unlock when async_chunk is free'd.
> 
> Since writeback is performed in range, so locked_page can be removed
> from the structures and function parameters. Similarly for page_started
> and nr_written.
> 
> A writeback could involve a hole, so check if the range locked covers
> the entire extent returned by find_lock_delalloc_range().
> If not try to lock the entire range or unlock the pages locked.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/compression.c |   4 +
>  fs/btrfs/extent_io.c   |  10 +--
>  fs/btrfs/extent_io.h   |   2 +
>  fs/btrfs/inode.c       | 184 ++++++++++++++++++-----------------------
>  4 files changed, 92 insertions(+), 108 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index b0dd01e31078..a8fa7f2049ce 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -1424,6 +1424,10 @@ static void heuristic_collect_sample(struct inode *inode, u64 start, u64 end,
>  	curr_sample_pos = 0;
>  	while (index < index_end) {
>  		page = find_get_page(inode->i_mapping, index);
> +		if (!page) {
> +			index++;
> +			continue;
> +		}
>  		in_data = kmap_local_page(page);
>  		/* Handle case where the start is not aligned to PAGE_SIZE */
>  		i = start % PAGE_SIZE;
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index cdce2db82d7e..12aa7eaf12c5 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -358,7 +358,7 @@ static int __process_pages_contig(struct address_space *mapping,
>  	return err;
>  }
>  
> -static noinline void __unlock_for_delalloc(struct inode *inode,
> +noinline void __unlock_for_delalloc(struct inode *inode,
>  					   struct page *locked_page,
>  					   u64 start, u64 end)
>  {
> @@ -383,8 +383,7 @@ static noinline int lock_delalloc_pages(struct inode *inode,
>  	u64 processed_end = delalloc_start;
>  	int ret;
>  
> -	ASSERT(locked_page);
> -	if (index == locked_page->index && index == end_index)
> +	if (locked_page && index == locked_page->index && index == end_index)
>  		return 0;
>  
>  	ret = __process_pages_contig(inode->i_mapping, locked_page, delalloc_start,
> @@ -432,8 +431,9 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
>  	ASSERT(orig_end > orig_start);
>  
>  	/* The range should at least cover part of the page */
> -	ASSERT(!(orig_start >= page_offset(locked_page) + PAGE_SIZE ||
> -		 orig_end <= page_offset(locked_page)));
> +	if (locked_page)
> +		ASSERT(!(orig_start >= page_offset(locked_page) + PAGE_SIZE ||
> +			 orig_end <= page_offset(locked_page)));
>  again:
>  	/* step one, find a bunch of delalloc bytes starting at start */
>  	delalloc_start = *start;
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 4341ad978fb8..ddfa100ab629 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -279,6 +279,8 @@ void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
>  int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array);
>  
>  void end_extent_writepage(struct page *page, int err, u64 start, u64 end);
> +void __unlock_for_delalloc(struct inode *inode, struct page *locked_page,
> +		u64 start, u64 end);
>  
>  #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
>  bool find_lock_delalloc_range(struct inode *inode,
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index eeddd7cdff58..fb02b2b3ac2e 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -506,7 +506,6 @@ struct async_extent {
>  
>  struct async_chunk {
>  	struct btrfs_inode *inode;
> -	struct page *locked_page;
>  	u64 start;
>  	u64 end;
>  	blk_opf_t write_flags;
> @@ -887,18 +886,6 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
>  		}
>  	}
>  cleanup_and_bail_uncompressed:
> -	/*
> -	 * No compression, but we still need to write the pages in the file
> -	 * we've been given so far.  redirty the locked page if it corresponds
> -	 * to our extent and set things up for the async work queue to run
> -	 * cow_file_range to do the normal delalloc dance.
> -	 */
> -	if (async_chunk->locked_page &&
> -	    (page_offset(async_chunk->locked_page) >= start &&
> -	     page_offset(async_chunk->locked_page)) <= end) {
> -		__set_page_dirty_nobuffers(async_chunk->locked_page);
> -		/* unlocked later on in the async handlers */
> -	}
>  
>  	if (redirty)
>  		extent_range_redirty_for_io(&inode->vfs_inode, start, end);
> @@ -926,8 +913,7 @@ static void free_async_extent_pages(struct async_extent *async_extent)
>  }
>  
>  static int submit_uncompressed_range(struct btrfs_inode *inode,
> -				     struct async_extent *async_extent,
> -				     struct page *locked_page)
> +				     struct async_extent *async_extent)
>  {
>  	u64 start = async_extent->start;
>  	u64 end = async_extent->start + async_extent->ram_size - 1;
> @@ -942,7 +928,7 @@ static int submit_uncompressed_range(struct btrfs_inode *inode,
>  	 * Also we call cow_file_range() with @unlock_page == 0, so that we
>  	 * can directly submit them without interruption.
>  	 */
> -	ret = cow_file_range(inode, locked_page, start, end, &page_started,
> +	ret = cow_file_range(inode, NULL, start, end, &page_started,
>  			     &nr_written, 0, NULL);
>  	/* Inline extent inserted, page gets unlocked and everything is done */
>  	if (page_started) {
> @@ -950,23 +936,12 @@ static int submit_uncompressed_range(struct btrfs_inode *inode,
>  		goto out;
>  	}
>  	if (ret < 0) {
> -		btrfs_cleanup_ordered_extents(inode, locked_page, start, end - start + 1);
> -		if (locked_page) {
> -			const u64 page_start = page_offset(locked_page);
> -			const u64 page_end = page_start + PAGE_SIZE - 1;
> -
> -			btrfs_page_set_error(inode->root->fs_info, locked_page,
> -					     page_start, PAGE_SIZE);
> -			set_page_writeback(locked_page);
> -			end_page_writeback(locked_page);
> -			end_extent_writepage(locked_page, ret, page_start, page_end);
> -			unlock_page(locked_page);
> -		}
> +		btrfs_cleanup_ordered_extents(inode, NULL, start, end - start + 1);
>  		goto out;
>  	}
>  
>  	ret = extent_write_locked_range(&inode->vfs_inode, start, end);
> -	/* All pages will be unlocked, including @locked_page */
> +	/* All pages will be unlocked */
>  out:
>  	kfree(async_extent);
>  	return ret;
> @@ -980,27 +955,14 @@ static int submit_one_async_extent(struct btrfs_inode *inode,
>  	struct btrfs_root *root = inode->root;
>  	struct btrfs_fs_info *fs_info = root->fs_info;
>  	struct btrfs_key ins;
> -	struct page *locked_page = NULL;
>  	struct extent_map *em;
>  	int ret = 0;
>  	u64 start = async_extent->start;
>  	u64 end = async_extent->start + async_extent->ram_size - 1;
>  
> -	/*
> -	 * If async_chunk->locked_page is in the async_extent range, we need to
> -	 * handle it.
> -	 */
> -	if (async_chunk->locked_page) {
> -		u64 locked_page_start = page_offset(async_chunk->locked_page);
> -		u64 locked_page_end = locked_page_start + PAGE_SIZE - 1;
> -
> -		if (!(start >= locked_page_end || end <= locked_page_start))
> -			locked_page = async_chunk->locked_page;
> -	}
> -
>  	/* We have fall back to uncompressed write */
>  	if (!async_extent->pages)
> -		return submit_uncompressed_range(inode, async_extent, locked_page);
> +		return submit_uncompressed_range(inode, async_extent);
>  
>  	ret = btrfs_reserve_extent(root, async_extent->ram_size,
>  				   async_extent->compressed_size,
> @@ -1476,6 +1438,8 @@ static noinline void async_cow_start(struct btrfs_work *work)
>  
>  	compressed_extents = compress_file_range(async_chunk);
>  	if (compressed_extents == 0) {
> +		unlock_extent(&async_chunk->inode->io_tree,
> +				async_chunk->start, async_chunk->end, NULL);
>  		btrfs_add_delayed_iput(async_chunk->inode);
>  		async_chunk->inode = NULL;
>  	}
> @@ -1515,11 +1479,15 @@ static noinline void async_cow_free(struct btrfs_work *work)
>  	struct async_cow *async_cow;
>  
>  	async_chunk = container_of(work, struct async_chunk, work);
> -	if (async_chunk->inode)
> +	if (async_chunk->inode) {
> +		unlock_extent(&async_chunk->inode->io_tree,
> +				async_chunk->start, async_chunk->end, NULL);
>  		btrfs_add_delayed_iput(async_chunk->inode);
> +	}
>  	if (async_chunk->blkcg_css)
>  		css_put(async_chunk->blkcg_css);
>  
> +
>  	async_cow = async_chunk->async_cow;
>  	if (atomic_dec_and_test(&async_cow->num_chunks))
>  		kvfree(async_cow);
> @@ -1527,9 +1495,7 @@ static noinline void async_cow_free(struct btrfs_work *work)
>  
>  static int cow_file_range_async(struct btrfs_inode *inode,
>  				struct writeback_control *wbc,
> -				struct page *locked_page,
> -				u64 start, u64 end, int *page_started,
> -				unsigned long *nr_written)
> +				u64 start, u64 end)
>  {
>  	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>  	struct cgroup_subsys_state *blkcg_css = wbc_blkcg_css(wbc);
> @@ -1539,20 +1505,9 @@ static int cow_file_range_async(struct btrfs_inode *inode,
>  	u64 cur_end;
>  	u64 num_chunks = DIV_ROUND_UP(end - start, SZ_512K);
>  	int i;
> -	bool should_compress;
>  	unsigned nofs_flag;
>  	const blk_opf_t write_flags = wbc_to_write_flags(wbc);
>  
> -	unlock_extent(&inode->io_tree, start, end, NULL);
> -
> -	if (inode->flags & BTRFS_INODE_NOCOMPRESS &&
> -	    !btrfs_test_opt(fs_info, FORCE_COMPRESS)) {
> -		num_chunks = 1;
> -		should_compress = false;
> -	} else {
> -		should_compress = true;
> -	}
> -
>  	nofs_flag = memalloc_nofs_save();
>  	ctx = kvmalloc(struct_size(ctx, chunks, num_chunks), GFP_KERNEL);
>  	memalloc_nofs_restore(nofs_flag);
> @@ -1564,19 +1519,17 @@ static int cow_file_range_async(struct btrfs_inode *inode,
>  		unsigned long page_ops = PAGE_UNLOCK | PAGE_START_WRITEBACK |
>  					 PAGE_END_WRITEBACK | PAGE_SET_ERROR;
>  
> -		extent_clear_unlock_delalloc(inode, start, end, locked_page,
> +		extent_clear_unlock_delalloc(inode, start, end, NULL,
>  					     clear_bits, page_ops);
>  		return -ENOMEM;
>  	}
>  
> +	set_bit(BTRFS_INODE_HAS_ASYNC_EXTENT, &inode->runtime_flags);
>  	async_chunk = ctx->chunks;
>  	atomic_set(&ctx->num_chunks, num_chunks);
>  
>  	for (i = 0; i < num_chunks; i++) {
> -		if (should_compress)
> -			cur_end = min(end, start + SZ_512K - 1);
> -		else
> -			cur_end = end;
> +		cur_end = min(end, start + SZ_512K - 1);
>  
>  		/*
>  		 * igrab is called higher up in the call chain, take only the
> @@ -1590,33 +1543,6 @@ static int cow_file_range_async(struct btrfs_inode *inode,
>  		async_chunk[i].write_flags = write_flags;
>  		INIT_LIST_HEAD(&async_chunk[i].extents);
>  
> -		/*
> -		 * The locked_page comes all the way from writepage and its
> -		 * the original page we were actually given.  As we spread
> -		 * this large delalloc region across multiple async_chunk
> -		 * structs, only the first struct needs a pointer to locked_page
> -		 *
> -		 * This way we don't need racey decisions about who is supposed
> -		 * to unlock it.
> -		 */
> -		if (locked_page) {
> -			/*
> -			 * Depending on the compressibility, the pages might or
> -			 * might not go through async.  We want all of them to
> -			 * be accounted against wbc once.  Let's do it here
> -			 * before the paths diverge.  wbc accounting is used
> -			 * only for foreign writeback detection and doesn't
> -			 * need full accuracy.  Just account the whole thing
> -			 * against the first page.
> -			 */
> -			wbc_account_cgroup_owner(wbc, locked_page,
> -						 cur_end - start);
> -			async_chunk[i].locked_page = locked_page;
> -			locked_page = NULL;
> -		} else {
> -			async_chunk[i].locked_page = NULL;
> -		}
> -
>  		if (blkcg_css != blkcg_root_css) {
>  			css_get(blkcg_css);
>  			async_chunk[i].blkcg_css = blkcg_css;
> @@ -1632,10 +1558,8 @@ static int cow_file_range_async(struct btrfs_inode *inode,
>  
>  		btrfs_queue_work(fs_info->delalloc_workers, &async_chunk[i].work);
>  
> -		*nr_written += nr_pages;
>  		start = cur_end + 1;
>  	}
> -	*page_started = 1;
>  	return 0;
>  }
>  
> @@ -2238,18 +2162,13 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
>  		ASSERT(!zoned || btrfs_is_data_reloc_root(inode->root));
>  		ret = run_delalloc_nocow(inode, locked_page, start, end,
>  					 page_started, nr_written);
> -	} else if (!btrfs_inode_can_compress(inode) ||
> -		   !inode_need_compress(inode, start, end)) {
> +	} else {
>  		if (zoned)
>  			ret = run_delalloc_zoned(inode, locked_page, start, end,
>  						 page_started, nr_written);
>  		else
>  			ret = cow_file_range(inode, locked_page, start, end,
>  					     page_started, nr_written, 1, NULL);
> -	} else {
> -		set_bit(BTRFS_INODE_HAS_ASYNC_EXTENT, &inode->runtime_flags);
> -		ret = cow_file_range_async(inode, wbc, locked_page, start, end,
> -					   page_started, nr_written);
>  	}
>  	ASSERT(ret <= 0);
>  	if (ret)
> @@ -7840,14 +7759,68 @@ static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  	return extent_fiemap(BTRFS_I(inode), fieinfo, start, len);
>  }
>  
> +static int btrfs_writepages_async(struct btrfs_inode *inode, struct writeback_control *wbc, u64 start, u64 end)
> +{
> +	u64 last_start, cur_start = start;
> +	u64 cur_end;
> +	int ret = 0;
> +
> +	lock_extent(&inode->io_tree, start, end, NULL);
> +
> +	while (cur_start < end) {
> +		bool found;
> +		last_start = cur_start;
> +		cur_end = end;
> +
> +		found = find_lock_delalloc_range(&inode->vfs_inode, NULL, &cur_start, &cur_end);

This call to find_lock_delalloc_range makes it so inode.c doesn't
compile unless CONFIG_BTRFS_FS_RUN_SANITY_TESTS is set.

> +		/* Nothing to writeback */
> +		if (!found) {
> +			unlock_extent(&inode->io_tree, cur_start, cur_end, NULL);
> +			cur_start = cur_end + 1;
> +			continue;
> +		}
> +
> +		/* A hole with no pages, unlock part therof */
> +		if (cur_start > last_start)
> +			unlock_extent(&inode->io_tree, last_start, cur_start - 1, NULL);
> +
> +		/* Got more than we requested for */
> +		if (cur_end > end) {
> +			if (try_lock_extent(&inode->io_tree, end + 1, cur_end, NULL)) {
> +				/* Try writing the whole extent */
> +				end = cur_end;
> +			} else {
> +				/*
> +				 * Someone is holding the extent lock.
> +				 * Unlock pages from last part of extent, and
> +				 * write just as much writepage requested for
> +				 */
> +				__unlock_for_delalloc(&inode->vfs_inode, NULL, end + 1, cur_end);
> +				cur_end = end;
> +			}
> +		}
> +
> +		ret = cow_file_range_async(inode, wbc, cur_start, cur_end);
> +		if (ret < 0) {
> +			unlock_extent(&inode->io_tree, cur_start, end, NULL);
> +			break;
> +		}
> +
> +		cur_start = cur_end + 1;
> +	}
> +
> +	return ret;
> +}
> +
>  static int btrfs_writepages(struct address_space *mapping,
>  			    struct writeback_control *wbc)
>  {
>  	u64 start = 0, end = LLONG_MAX;
> -	struct inode *inode = mapping->host;
> +	struct btrfs_inode *inode = BTRFS_I(mapping->host);
> +	struct btrfs_fs_info *fs_info = btrfs_sb(inode->vfs_inode.i_sb);
>  	struct extent_state *cached = NULL;
>  	int ret;
> -	loff_t isize = i_size_read(inode);
> +	loff_t isize = i_size_read(&inode->vfs_inode);
>  	struct writeback_control new_wbc = *wbc;
>  
>  	if (new_wbc.range_cyclic) {
> @@ -7864,9 +7837,14 @@ static int btrfs_writepages(struct address_space *mapping,
>  	if (start >= end)
>  		return 0;
>  
> -	lock_extent(&BTRFS_I(inode)->io_tree, start, end, &cached);
> -	ret = extent_writepages(mapping, wbc);
> -	unlock_extent(&BTRFS_I(inode)->io_tree, start, end, &cached);
> +	if (btrfs_test_opt(fs_info, COMPRESS) &&
> +			btrfs_inode_can_compress(inode)) {
> +		ret = btrfs_writepages_async(inode, wbc, start, end);
> +	} else {
> +		lock_extent(&inode->io_tree, start, end, &cached);
> +		ret = extent_writepages(mapping, wbc);
> +		unlock_extent(&inode->io_tree, start, end, &cached);
> +	}
>  
>  	if (new_wbc.range_cyclic) {
>  		wbc->range_start = new_wbc.range_start;
> -- 
> 2.39.2
> 
