Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8E43C2AE6
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jul 2021 23:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbhGIVjV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jul 2021 17:39:21 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39844 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhGIVjU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Jul 2021 17:39:20 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DAE7D21FB2
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jul 2021 21:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625866595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hsSy6yPxTzygjDusj7IT2AbG06AobAPOR2OE45SSb0I=;
        b=x7a3QpwZnIKqdRzIGq8bZM6hN8cdumuRXEyT+kvGhEt8t/vhyRU0nf1+QYPW3gdKIwN8aL
        PhDQFQeix7ZBYDlBajK9Wcd/baIX4kYrfSGz4ZdjYCzaFAoS9qX1igK09tE4rP39iyrGBR
        BhEEqUV6t4H1anCTmlf/DpNOmPX6EHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625866595;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hsSy6yPxTzygjDusj7IT2AbG06AobAPOR2OE45SSb0I=;
        b=rXXEd9UZHXQhAp1PkcXTbEnnVIefLvldd4Spa/ihcKXDacE6SwMxp+0bv0B392h9ig+a2N
        eRq0b0flytQhZ9Bg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 6A9111348A
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jul 2021 21:36:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id JrG9EGPB6GBrZwAAGKfGzw
        (envelope-from <rgoldwyn@suse.de>)
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Jul 2021 21:36:35 +0000
Date:   Fri, 9 Jul 2021 16:36:33 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Use io_bio->mirror_num for all mirror_num needs
Message-ID: <20210709213633.auhzkvexxcbf6arg@fiona>
References: <20210708163630.dd7uw6hhgim2gaxd@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708163630.dd7uw6hhgim2gaxd@fiona>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Nack. This will not work for direct I/O. Sorry for the noise.

On 11:36 08/07, Goldwyn Rodrigues wrote:
> Simplification.
> 
> btrfs_io_bio has a mirror_num field which is under-used. The mirror_num
> is available when the io_bio is allocated, ie as an argument to the
> function where bio is allocated. Set it when a new bio (and in
> essence io_bio) is allocated. The makes passing mirror_num as function
> arguments unnecessary.
> 
> The io_bio->mirror_num is also used as the failed mirror number of the
> failed_bio as opposed to explicitly being passed as the function
> argument.
> 
> Similarly, async_submit_bio.mirror_num is also made unnecessary because it
> carries the pointer to the bio.
> 
> compressed_bio->mirror_num is also set by the bio passed (which
> eventually becomes compressed_bio->orig_bio). So any io_bio allocated by
> compressed_bio sequence is also assigned from cb->mirror_num.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/compression.c | 14 ++++++++------
>  fs/btrfs/compression.h |  2 +-
>  fs/btrfs/ctree.h       |  2 +-
>  fs/btrfs/disk-io.c     | 14 ++++++--------
>  fs/btrfs/disk-io.h     |  4 ++--
>  fs/btrfs/extent_io.c   | 28 +++++++++++++++-------------
>  fs/btrfs/extent_io.h   |  6 ++----
>  fs/btrfs/inode.c       | 18 ++++++++----------
>  fs/btrfs/volumes.c     |  4 ++--
>  fs/btrfs/volumes.h     |  3 +--
>  10 files changed, 46 insertions(+), 49 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 9a023ae0f98b..576e22ab0932 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -485,7 +485,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
>  				BUG_ON(ret); /* -ENOMEM */
>  			}
>  
> -			ret = btrfs_map_bio(fs_info, bio, 0);
> +			ret = btrfs_map_bio(fs_info, bio);
>  			if (ret) {
>  				bio->bi_status = ret;
>  				bio_endio(bio);
> @@ -521,7 +521,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
>  		BUG_ON(ret); /* -ENOMEM */
>  	}
>  
> -	ret = btrfs_map_bio(fs_info, bio, 0);
> +	ret = btrfs_map_bio(fs_info, bio);
>  	if (ret) {
>  		bio->bi_status = ret;
>  		bio_endio(bio);
> @@ -662,7 +662,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
>   * bio we were passed and then call the bio end_io calls
>   */
>  blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
> -				 int mirror_num, unsigned long bio_flags)
> +				 unsigned long bio_flags)
>  {
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>  	struct extent_map_tree *em_tree;
> @@ -699,7 +699,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>  	refcount_set(&cb->pending_bios, 0);
>  	cb->errors = 0;
>  	cb->inode = inode;
> -	cb->mirror_num = mirror_num;
> +	cb->mirror_num = btrfs_io_bio(bio)->mirror_num;
>  	sums = cb->sums;
>  
>  	cb->start = em->orig_start;
> @@ -741,6 +741,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>  	comp_bio->bi_opf = REQ_OP_READ;
>  	comp_bio->bi_private = cb;
>  	comp_bio->bi_end_io = end_compressed_bio_read;
> +	btrfs_io_bio(comp_bio)->mirror_num = cb->mirror_num;
>  	refcount_set(&cb->pending_bios, 1);
>  
>  	for (pg_index = 0; pg_index < nr_pages; pg_index++) {
> @@ -789,7 +790,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>  						  fs_info->sectorsize);
>  			sums += fs_info->csum_size * nr_sectors;
>  
> -			ret = btrfs_map_bio(fs_info, comp_bio, mirror_num);
> +			ret = btrfs_map_bio(fs_info, comp_bio);
>  			if (ret) {
>  				comp_bio->bi_status = ret;
>  				bio_endio(comp_bio);
> @@ -799,6 +800,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>  			comp_bio->bi_opf = REQ_OP_READ;
>  			comp_bio->bi_private = cb;
>  			comp_bio->bi_end_io = end_compressed_bio_read;
> +			btrfs_io_bio(comp_bio)->mirror_num = cb->mirror_num;
>  
>  			bio_add_page(comp_bio, page, pg_len, 0);
>  		}
> @@ -811,7 +813,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>  	ret = btrfs_lookup_bio_sums(inode, comp_bio, sums);
>  	BUG_ON(ret); /* -ENOMEM */
>  
> -	ret = btrfs_map_bio(fs_info, comp_bio, mirror_num);
> +	ret = btrfs_map_bio(fs_info, comp_bio);
>  	if (ret) {
>  		comp_bio->bi_status = ret;
>  		bio_endio(comp_bio);
> diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
> index c359f20920d0..1476d58d2dc3 100644
> --- a/fs/btrfs/compression.h
> +++ b/fs/btrfs/compression.h
> @@ -98,7 +98,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
>  				  unsigned int write_flags,
>  				  struct cgroup_subsys_state *blkcg_css);
>  blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
> -				 int mirror_num, unsigned long bio_flags);
> +				 unsigned long bio_flags);
>  
>  unsigned int btrfs_compress_str2level(unsigned int type, const char *str);
>  
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 4a69aa604ac5..087c6b3edb61 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3107,7 +3107,7 @@ u64 btrfs_file_extent_end(const struct btrfs_path *path);
>  
>  /* inode.c */
>  blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
> -				   int mirror_num, unsigned long bio_flags);
> +				   unsigned long bio_flags);
>  unsigned int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u32 bio_offset,
>  				    struct page *page, u64 start, u64 end);
>  struct extent_map *btrfs_get_extent_fiemap(struct btrfs_inode *inode,
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index b117dd3b8172..fdf95c832099 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -113,7 +113,6 @@ struct async_submit_bio {
>  	struct inode *inode;
>  	struct bio *bio;
>  	extent_submit_bio_start_t *submit_bio_start;
> -	int mirror_num;
>  
>  	/* Optional parameter for submit_bio_start used by direct io */
>  	u64 dio_file_offset;
> @@ -827,7 +826,7 @@ static void run_one_async_done(struct btrfs_work *work)
>  	 * This changes nothing when cgroups aren't in use.
>  	 */
>  	async->bio->bi_opf |= REQ_CGROUP_PUNT;
> -	ret = btrfs_map_bio(btrfs_sb(inode->i_sb), async->bio, async->mirror_num);
> +	ret = btrfs_map_bio(btrfs_sb(inode->i_sb), async->bio);
>  	if (ret) {
>  		async->bio->bi_status = ret;
>  		bio_endio(async->bio);
> @@ -843,7 +842,7 @@ static void run_one_async_free(struct btrfs_work *work)
>  }
>  
>  blk_status_t btrfs_wq_submit_bio(struct inode *inode, struct bio *bio,
> -				 int mirror_num, unsigned long bio_flags,
> +				 unsigned long bio_flags,
>  				 u64 dio_file_offset,
>  				 extent_submit_bio_start_t *submit_bio_start)
>  {
> @@ -856,7 +855,6 @@ blk_status_t btrfs_wq_submit_bio(struct inode *inode, struct bio *bio,
>  
>  	async->inode = inode;
>  	async->bio = bio;
> -	async->mirror_num = mirror_num;
>  	async->submit_bio_start = submit_bio_start;
>  
>  	btrfs_init_work(&async->work, run_one_async_start, run_one_async_done,
> @@ -914,7 +912,7 @@ static bool should_async_write(struct btrfs_fs_info *fs_info,
>  }
>  
>  blk_status_t btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio,
> -				       int mirror_num, unsigned long bio_flags)
> +				       unsigned long bio_flags)
>  {
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>  	blk_status_t ret;
> @@ -928,18 +926,18 @@ blk_status_t btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio,
>  					  BTRFS_WQ_ENDIO_METADATA);
>  		if (ret)
>  			goto out_w_error;
> -		ret = btrfs_map_bio(fs_info, bio, mirror_num);
> +		ret = btrfs_map_bio(fs_info, bio);
>  	} else if (!should_async_write(fs_info, BTRFS_I(inode))) {
>  		ret = btree_csum_one_bio(bio);
>  		if (ret)
>  			goto out_w_error;
> -		ret = btrfs_map_bio(fs_info, bio, mirror_num);
> +		ret = btrfs_map_bio(fs_info, bio);
>  	} else {
>  		/*
>  		 * kthread helpers are used to submit writes so that
>  		 * checksumming can happen in parallel across all CPUs
>  		 */
> -		ret = btrfs_wq_submit_bio(inode, bio, mirror_num, 0,
> +		ret = btrfs_wq_submit_bio(inode, bio, 0,
>  					  0, btree_submit_bio_start);
>  	}
>  
> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
> index 0e7e9526b6a8..7ca535655f47 100644
> --- a/fs/btrfs/disk-io.h
> +++ b/fs/btrfs/disk-io.h
> @@ -85,7 +85,7 @@ int btrfs_validate_metadata_buffer(struct btrfs_io_bio *io_bio,
>  				   struct page *page, u64 start, u64 end,
>  				   int mirror);
>  blk_status_t btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio,
> -				       int mirror_num, unsigned long bio_flags);
> +				       unsigned long bio_flags);
>  #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
>  struct btrfs_root *btrfs_alloc_dummy_root(struct btrfs_fs_info *fs_info);
>  #endif
> @@ -115,7 +115,7 @@ int btrfs_read_buffer(struct extent_buffer *buf, u64 parent_transid, int level,
>  blk_status_t btrfs_bio_wq_end_io(struct btrfs_fs_info *info, struct bio *bio,
>  			enum btrfs_wq_endio_type metadata);
>  blk_status_t btrfs_wq_submit_bio(struct inode *inode, struct bio *bio,
> -				 int mirror_num, unsigned long bio_flags,
> +				 unsigned long bio_flags,
>  				 u64 dio_file_offset,
>  				 extent_submit_bio_start_t *submit_bio_start);
>  blk_status_t btrfs_submit_bio_done(void *private_data, struct bio *bio,
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 54f96767cddc..e5bc1eeb0c44 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -164,8 +164,7 @@ static int add_extent_changeset(struct extent_state *state, u32 bits,
>  	return ret;
>  }
>  
> -int __must_check submit_one_bio(struct bio *bio, int mirror_num,
> -				unsigned long bio_flags)
> +int __must_check submit_one_bio(struct bio *bio, unsigned long bio_flags)
>  {
>  	blk_status_t ret = 0;
>  	struct extent_io_tree *tree = bio->bi_private;
> @@ -173,11 +172,11 @@ int __must_check submit_one_bio(struct bio *bio, int mirror_num,
>  	bio->bi_private = NULL;
>  
>  	if (is_data_inode(tree->private_data))
> -		ret = btrfs_submit_data_bio(tree->private_data, bio, mirror_num,
> +		ret = btrfs_submit_data_bio(tree->private_data, bio,
>  					    bio_flags);
>  	else
>  		ret = btrfs_submit_metadata_bio(tree->private_data, bio,
> -						mirror_num, bio_flags);
> +						bio_flags);
>  
>  	return blk_status_to_errno(ret);
>  }
> @@ -206,7 +205,7 @@ static int __must_check flush_write_bio(struct extent_page_data *epd)
>  	struct bio *bio = epd->bio_ctrl.bio;
>  
>  	if (bio) {
> -		ret = submit_one_bio(bio, 0, 0);
> +		ret = submit_one_bio(bio, 0);
>  		/*
>  		 * Clean up of epd->bio is handled by its endio function.
>  		 * And endio is either triggered by successful bio execution
> @@ -2620,7 +2619,7 @@ static bool btrfs_check_repairable(struct inode *inode,
>  int btrfs_repair_one_sector(struct inode *inode,
>  			    struct bio *failed_bio, u32 bio_offset,
>  			    struct page *page, unsigned int pgoff,
> -			    u64 start, int failed_mirror,
> +			    u64 start,
>  			    submit_bio_hook_t *submit_bio_hook)
>  {
>  	struct io_failure_record *failrec;
> @@ -2628,6 +2627,7 @@ int btrfs_repair_one_sector(struct inode *inode,
>  	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
>  	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
>  	struct btrfs_io_bio *failed_io_bio = btrfs_io_bio(failed_bio);
> +	int failed_mirror = failed_io_bio->mirror_num;
>  	const int icsum = bio_offset >> fs_info->sectorsize_bits;
>  	struct bio *repair_bio;
>  	struct btrfs_io_bio *repair_io_bio;
> @@ -2654,6 +2654,7 @@ int btrfs_repair_one_sector(struct inode *inode,
>  	repair_bio->bi_end_io = failed_bio->bi_end_io;
>  	repair_bio->bi_iter.bi_sector = failrec->logical >> 9;
>  	repair_bio->bi_private = failed_bio->bi_private;
> +	btrfs_io_bio(repair_bio)->mirror_num = failrec->this_mirror;
>  
>  	if (failed_io_bio->csum) {
>  		const u32 csum_size = fs_info->csum_size;
> @@ -2671,8 +2672,7 @@ int btrfs_repair_one_sector(struct inode *inode,
>  		    "repair read error: submitting new read to mirror %d",
>  		    failrec->this_mirror);
>  
> -	status = submit_bio_hook(inode, repair_bio, failrec->this_mirror,
> -				 failrec->bio_flags);
> +	status = submit_bio_hook(inode, repair_bio, failrec->bio_flags);
>  	if (status) {
>  		free_io_failure(failure_tree, tree, failrec);
>  		bio_put(repair_bio);
> @@ -2743,7 +2743,7 @@ static blk_status_t submit_read_repair(struct inode *inode,
>  		ret = btrfs_repair_one_sector(inode, failed_bio,
>  				bio_offset + offset,
>  				page, pgoff + offset, start + offset,
> -				failed_mirror, submit_bio_hook);
> +				submit_bio_hook);
>  		if (!ret) {
>  			/*
>  			 * We have submitted the read repair, the page release
> @@ -3139,6 +3139,7 @@ struct bio *btrfs_bio_clone(struct bio *bio)
>  	btrfs_bio = btrfs_io_bio(new);
>  	btrfs_io_bio_init(btrfs_bio);
>  	btrfs_bio->iter = bio->bi_iter;
> +	btrfs_bio->mirror_num = btrfs_io_bio(bio)->mirror_num;
>  	return new;
>  }
>  
> @@ -3318,7 +3319,7 @@ static int submit_extent_page(unsigned int opf,
>  		if (force_bio_submit ||
>  		    !btrfs_bio_add_page(bio_ctrl, page, disk_bytenr, io_size,
>  					pg_offset, bio_flags)) {
> -			ret = submit_one_bio(bio, mirror_num, bio_ctrl->bio_flags);
> +			ret = submit_one_bio(bio, bio_ctrl->bio_flags);
>  			bio_ctrl->bio = NULL;
>  			if (ret < 0)
>  				return ret;
> @@ -3335,6 +3336,7 @@ static int submit_extent_page(unsigned int opf,
>  	bio->bi_private = tree;
>  	bio->bi_write_hint = page->mapping->host->i_write_hint;
>  	bio->bi_opf = opf;
> +	btrfs_io_bio(bio)->mirror_num = mirror_num;
>  	if (wbc) {
>  		struct block_device *bdev;
>  
> @@ -5039,7 +5041,7 @@ void extent_readahead(struct readahead_control *rac)
>  		free_extent_map(em_cached);
>  
>  	if (bio_ctrl.bio) {
> -		if (submit_one_bio(bio_ctrl.bio, 0, bio_ctrl.bio_flags))
> +		if (submit_one_bio(bio_ctrl.bio, bio_ctrl.bio_flags))
>  			return;
>  	}
>  }
> @@ -6383,7 +6385,7 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
>  	if (bio_ctrl.bio) {
>  		int tmp;
>  
> -		tmp = submit_one_bio(bio_ctrl.bio, mirror_num, 0);
> +		tmp = submit_one_bio(bio_ctrl.bio, 0);
>  		bio_ctrl.bio = NULL;
>  		if (tmp < 0)
>  			return tmp;
> @@ -6491,7 +6493,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
>  	}
>  
>  	if (bio_ctrl.bio) {
> -		err = submit_one_bio(bio_ctrl.bio, mirror_num, bio_ctrl.bio_flags);
> +		err = submit_one_bio(bio_ctrl.bio, bio_ctrl.bio_flags);
>  		bio_ctrl.bio = NULL;
>  		if (err)
>  			return err;
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 62027f551b44..8568f5bfe089 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -71,7 +71,6 @@ struct io_failure_record;
>  struct extent_io_tree;
>  
>  typedef blk_status_t (submit_bio_hook_t)(struct inode *inode, struct bio *bio,
> -					 int mirror_num,
>  					 unsigned long bio_flags);
>  
>  typedef blk_status_t (extent_submit_bio_start_t)(struct inode *inode,
> @@ -177,8 +176,7 @@ typedef struct extent_map *(get_extent_t)(struct btrfs_inode *inode,
>  int try_release_extent_mapping(struct page *page, gfp_t mask);
>  int try_release_extent_buffer(struct page *page);
>  
> -int __must_check submit_one_bio(struct bio *bio, int mirror_num,
> -				unsigned long bio_flags);
> +int __must_check submit_one_bio(struct bio *bio, unsigned long bio_flags);
>  int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
>  		      struct btrfs_bio_ctrl *bio_ctrl,
>  		      unsigned int read_flags, u64 *prev_em_start);
> @@ -309,7 +307,7 @@ struct io_failure_record {
>  int btrfs_repair_one_sector(struct inode *inode,
>  			    struct bio *failed_bio, u32 bio_offset,
>  			    struct page *page, unsigned int pgoff,
> -			    u64 start, int failed_mirror,
> +			    u64 start,
>  			    submit_bio_hook_t *submit_bio_hook);
>  
>  #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 8f60314c36c5..ad4308546006 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2465,7 +2465,7 @@ static blk_status_t extract_ordered_extent(struct btrfs_inode *inode,
>   *    c-3) otherwise:			async submit
>   */
>  blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
> -				   int mirror_num, unsigned long bio_flags)
> +				   unsigned long bio_flags)
>  
>  {
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> @@ -2497,7 +2497,6 @@ blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
>  
>  		if (bio_flags & EXTENT_BIO_COMPRESSED) {
>  			ret = btrfs_submit_compressed_read(inode, bio,
> -							   mirror_num,
>  							   bio_flags);
>  			goto out;
>  		} else {
> @@ -2516,7 +2515,7 @@ blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
>  		if (root->root_key.objectid == BTRFS_DATA_RELOC_TREE_OBJECTID)
>  			goto mapit;
>  		/* we're doing a write, do the async checksumming */
> -		ret = btrfs_wq_submit_bio(inode, bio, mirror_num, bio_flags,
> +		ret = btrfs_wq_submit_bio(inode, bio, bio_flags,
>  					  0, btrfs_submit_bio_start);
>  		goto out;
>  	} else if (!skip_sum) {
> @@ -2526,7 +2525,7 @@ blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
>  	}
>  
>  mapit:
> -	ret = btrfs_map_bio(fs_info, bio, mirror_num);
> +	ret = btrfs_map_bio(fs_info, bio);
>  
>  out:
>  	if (ret) {
> @@ -7999,7 +7998,6 @@ static void btrfs_dio_private_put(struct btrfs_dio_private *dip)
>  }
>  
>  static blk_status_t submit_dio_repair_bio(struct inode *inode, struct bio *bio,
> -					  int mirror_num,
>  					  unsigned long bio_flags)
>  {
>  	struct btrfs_dio_private *dip = bio->bi_private;
> @@ -8013,7 +8011,7 @@ static blk_status_t submit_dio_repair_bio(struct inode *inode, struct bio *bio,
>  		return ret;
>  
>  	refcount_inc(&dip->refs);
> -	ret = btrfs_map_bio(fs_info, bio, mirror_num);
> +	ret = btrfs_map_bio(fs_info, bio);
>  	if (ret)
>  		refcount_dec(&dip->refs);
>  	return ret;
> @@ -8057,7 +8055,7 @@ static blk_status_t btrfs_check_read_dio_bio(struct inode *inode,
>  						&io_bio->bio,
>  						start - io_bio->logical,
>  						bvec.bv_page, pgoff,
> -						start, io_bio->mirror_num,
> +						start,
>  						submit_dio_repair_bio);
>  				if (ret)
>  					err = errno_to_blk_status(ret);
> @@ -8134,7 +8132,7 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
>  		goto map;
>  
>  	if (write && async_submit) {
> -		ret = btrfs_wq_submit_bio(inode, bio, 0, 0, file_offset,
> +		ret = btrfs_wq_submit_bio(inode, bio, 0, file_offset,
>  					  btrfs_submit_bio_start_direct_io);
>  		goto err;
>  	} else if (write) {
> @@ -8154,7 +8152,7 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
>  		btrfs_io_bio(bio)->csum = dip->csums + csum_offset;
>  	}
>  map:
> -	ret = btrfs_map_bio(fs_info, bio, 0);
> +	ret = btrfs_map_bio(fs_info, bio);
>  err:
>  	return ret;
>  }

BTRFS doesn't allocate this bio, so this will not be encapsulated in io_bio.
This is provided by the iomap code.


> @@ -8361,7 +8359,7 @@ int btrfs_readpage(struct file *file, struct page *page)
>  
>  	ret = btrfs_do_readpage(page, NULL, &bio_ctrl, 0, NULL);
>  	if (bio_ctrl.bio)
> -		ret = submit_one_bio(bio_ctrl.bio, 0, bio_ctrl.bio_flags);
> +		ret = submit_one_bio(bio_ctrl.bio, bio_ctrl.bio_flags);
>  	return ret;
>  }
>  
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index c6c14315b1c9..9485e71dce0d 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6758,8 +6758,7 @@ static void bbio_error(struct btrfs_bio *bbio, struct bio *bio, u64 logical)
>  	}
>  }
>  
> -blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
> -			   int mirror_num)
> +blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio)
>  {
>  	struct btrfs_device *dev;
>  	struct bio *first_bio = bio;
> @@ -6770,6 +6769,7 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
>  	int dev_nr;
>  	int total_devs;
>  	struct btrfs_bio *bbio = NULL;
> +	int mirror_num = btrfs_io_bio(bio)->mirror_num;
>  
>  	length = bio->bi_iter.bi_size;
>  	map_length = length;
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 55a8ba244716..776f45f4299b 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -453,8 +453,7 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info);
>  struct btrfs_block_group *btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
>  					    u64 type);
>  void btrfs_mapping_tree_free(struct extent_map_tree *tree);
> -blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
> -			   int mirror_num);
> +blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio);
>  int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
>  		       fmode_t flags, void *holder);
>  struct btrfs_device *btrfs_scan_one_device(const char *path,
> -- 
> 2.32.0
> 
> 
> -- 
> Goldwyn

-- 
Goldwyn
