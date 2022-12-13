Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBEA64BC76
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 19:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236572AbiLMS5r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 13:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236556AbiLMS5p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 13:57:45 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6964163A1
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 10:57:44 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id fz10so648616qtb.3
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 10:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XKjtnxtwpcN8iD7AEvf7TJ7OmPvyM/h5tgbzbY6XtcI=;
        b=A49/orKEXgtM03cgX+24I6J2WaNnehbD8SYK9Iiy2VUERJLy8l/YKLF92cKsc/Enyv
         n/6TkL32/M4BQPTTn7qD+Cd0zuW7jiENMg0u6MMQ4AuSTGYestaMfrHPY91bnBs1/RyH
         eSFLJTzLgiN1bfa9pTKjjpT2aW03id7I+fZz+ibOJswijdGepG/Tse3ozDdFXRXiFLS3
         Sl/xWjF7i1oAGpZ8haPNH5QkM5AilsW8zS/CHrDwEQ1zj3A3dHTJMdU4yasM750AvLFZ
         6ePaVWERW/5czPl0A+kK8vn1VBKJu8INVXApkhHwGxDbfiEbTgbgtFNeTLBT1mlygwxT
         SGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKjtnxtwpcN8iD7AEvf7TJ7OmPvyM/h5tgbzbY6XtcI=;
        b=aQKh1+Jsh8UgOGTAFxBzy9CRsWYK7cjbXWzwP5qIpND87+rujzI2zk5uWq7sIrQHAX
         21aVi31chB/uKaJCcKAy5hJLeSRFnmC1ZmoCf4R32PiyLn+dsIjzBc0prpUDBgCi1kHV
         VqQAO/Ev7Z2Bromy8NNBszek9o1Z9VBaw9YmgzIlOcKHl/AzXDNypu1jS+PS3Oqha1cK
         C3KRc0XAq+9AbbQtd4iyNwUCWLMQ/Vbqv18nQZwcd3cWvyiwDKWfLpK+20o5KJLLpUY6
         E+3cbES5TcbyzbHAUjTtFhOvLB56PqLfsS2sAe1JSpLwv54YZNlLUe1CsJ5a4B89E1v0
         CSNw==
X-Gm-Message-State: ANoB5plvFWnVRwmFZutCjbvfIpjkuBDPakWmpDmMTustyjFuMkpRaGHd
        44WTmNH1P/vCv7EDHjC0TYt/Ez7UUn6191t64w0=
X-Google-Smtp-Source: AA0mqf5gAeWeJg3ozxa39s8A/iCy26gODx/5jfNoyh/o+s2UyVU48li8UifT6Oy1BuzdYl5iic8Jjw==
X-Received: by 2002:a05:622a:5a0d:b0:3a5:1001:2057 with SMTP id fy13-20020a05622a5a0d00b003a510012057mr30320265qtb.30.1670957863244;
        Tue, 13 Dec 2022 10:57:43 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id m22-20020ac866d6000000b0039cc64bcb53sm351795qtp.27.2022.12.13.10.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 10:57:42 -0800 (PST)
Date:   Tue, 13 Dec 2022 13:57:41 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 07/16] btrfs: Lock extents before folio for read()s
Message-ID: <Y5jLJdlJA0arM9de@localhost.localdomain>
References: <cover.1668530684.git.rgoldwyn@suse.com>
 <5c7c77d0735c18cea82c347eef2ce2eb169681e6.1668530684.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c7c77d0735c18cea82c347eef2ce2eb169681e6.1668530684.git.rgoldwyn@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 15, 2022 at 12:00:25PM -0600, Goldwyn Rodrigues wrote:
> Perform extent locking around buffered reads as opposed to while
> performing folio reads.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/compression.c |  5 -----
>  fs/btrfs/extent_io.c   | 36 +-----------------------------------
>  fs/btrfs/file.c        | 17 ++++++++++++++---
>  3 files changed, 15 insertions(+), 43 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 30adf430241e..7f6452c4234e 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -526,11 +526,9 @@ static noinline int add_ra_bio_pages(struct inode *inode,
>  	struct extent_map *em;
>  	struct address_space *mapping = inode->i_mapping;
>  	struct extent_map_tree *em_tree;
> -	struct extent_io_tree *tree;
>  	int sectors_missed = 0;
>  
>  	em_tree = &BTRFS_I(inode)->extent_tree;
> -	tree = &BTRFS_I(inode)->io_tree;
>  
>  	if (isize == 0)
>  		return 0;
> @@ -597,7 +595,6 @@ static noinline int add_ra_bio_pages(struct inode *inode,
>  		}
>  
>  		page_end = (pg_index << PAGE_SHIFT) + PAGE_SIZE - 1;
> -		lock_extent(tree, cur, page_end, NULL);
>  		read_lock(&em_tree->lock);
>  		em = lookup_extent_mapping(em_tree, cur, page_end + 1 - cur);
>  		read_unlock(&em_tree->lock);
> @@ -611,7 +608,6 @@ static noinline int add_ra_bio_pages(struct inode *inode,
>  		    (cur + fs_info->sectorsize > extent_map_end(em)) ||
>  		    (em->block_start >> 9) != cb->orig_bio->bi_iter.bi_sector) {
>  			free_extent_map(em);
> -			unlock_extent(tree, cur, page_end, NULL);
>  			unlock_page(page);
>  			put_page(page);
>  			break;
> @@ -631,7 +627,6 @@ static noinline int add_ra_bio_pages(struct inode *inode,
>  		add_size = min(em->start + em->len, page_end + 1) - cur;
>  		ret = bio_add_page(cb->orig_bio, page, add_size, offset_in_page(cur));
>  		if (ret != add_size) {
> -			unlock_extent(tree, cur, page_end, NULL);
>  			unlock_page(page);
>  			put_page(page);
>  			break;
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 42bae149f923..c5430cabad62 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -891,15 +891,6 @@ static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
>  		btrfs_subpage_end_reader(fs_info, page, start, len);
>  }
>  
> -static void end_sector_io(struct page *page, u64 offset, bool uptodate)
> -{
> -	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
> -	const u32 sectorsize = inode->root->fs_info->sectorsize;
> -
> -	end_page_read(page, uptodate, offset, sectorsize);
> -	unlock_extent(&inode->io_tree, offset, offset + sectorsize - 1, NULL);
> -}
> -
>  static void submit_data_read_repair(struct inode *inode,
>  				    struct btrfs_bio *failed_bbio,
>  				    u32 bio_offset, const struct bio_vec *bvec,
> @@ -960,7 +951,7 @@ static void submit_data_read_repair(struct inode *inode,
>  		 * will not be properly unlocked.
>  		 */
>  next:
> -		end_sector_io(page, start + offset, uptodate);
> +		end_page_read(page, uptodate, start + offset, sectorsize);
>  	}
>  }
>  
> @@ -1072,9 +1063,6 @@ static void endio_readpage_release_extent(struct processed_extent *processed,
>  			      struct btrfs_inode *inode, u64 start, u64 end,
>  			      bool uptodate)
>  {
> -	struct extent_state *cached = NULL;
> -	struct extent_io_tree *tree;
> -
>  	/* The first extent, initialize @processed */
>  	if (!processed->inode)
>  		goto update;
> @@ -1096,13 +1084,6 @@ static void endio_readpage_release_extent(struct processed_extent *processed,
>  		return;
>  	}
>  
> -	tree = &processed->inode->io_tree;
> -	/*
> -	 * Now we don't have range contiguous to the processed range, release
> -	 * the processed range now.
> -	 */
> -	unlock_extent(tree, processed->start, processed->end, &cached);
> -
>  update:
>  	/* Update processed to current range */
>  	processed->inode = inode;
> @@ -1743,11 +1724,9 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
>  	size_t pg_offset = 0;
>  	size_t iosize;
>  	size_t blocksize = inode->i_sb->s_blocksize;
> -	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
>  
>  	ret = set_page_extent_mapped(page);
>  	if (ret < 0) {
> -		unlock_extent(tree, start, end, NULL);
>  		btrfs_page_set_error(fs_info, page, start, PAGE_SIZE);
>  		unlock_page(page);
>  		goto out;
> @@ -1772,14 +1751,12 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
>  		if (cur >= last_byte) {
>  			iosize = PAGE_SIZE - pg_offset;
>  			memzero_page(page, pg_offset, iosize);
> -			unlock_extent(tree, cur, cur + iosize - 1, NULL);
>  			end_page_read(page, true, cur, iosize);
>  			break;
>  		}
>  		em = __get_extent_map(inode, page, pg_offset, cur,
>  				      end - cur + 1, em_cached);
>  		if (IS_ERR(em)) {
> -			unlock_extent(tree, cur, end, NULL);
>  			end_page_read(page, false, cur, end + 1 - cur);
>  			ret = PTR_ERR(em);
>  			break;
> @@ -1849,8 +1826,6 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
>  		/* we've found a hole, just zero and go on */
>  		if (block_start == EXTENT_MAP_HOLE) {
>  			memzero_page(page, pg_offset, iosize);
> -
> -			unlock_extent(tree, cur, cur + iosize - 1, NULL);
>  			end_page_read(page, true, cur, iosize);
>  			cur = cur + iosize;
>  			pg_offset += iosize;
> @@ -1858,7 +1833,6 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
>  		}
>  		/* the get_extent function already copied into the page */
>  		if (block_start == EXTENT_MAP_INLINE) {
> -			unlock_extent(tree, cur, cur + iosize - 1, NULL);
>  			end_page_read(page, true, cur, iosize);
>  			cur = cur + iosize;
>  			pg_offset += iosize;
> @@ -1874,7 +1848,6 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
>  			 * We have to unlock the remaining range, or the page
>  			 * will never be unlocked.
>  			 */
> -			unlock_extent(tree, cur, end, NULL);
>  			end_page_read(page, false, cur, end + 1 - cur);
>  			goto out;
>  		}
> @@ -1888,13 +1861,9 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
>  int btrfs_read_folio(struct file *file, struct folio *folio)
>  {
>  	struct page *page = &folio->page;
> -	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
> -	u64 start = page_offset(page);
> -	u64 end = start + PAGE_SIZE - 1;
>  	struct btrfs_bio_ctrl bio_ctrl = { 0 };
>  	int ret;
>  
> -	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
>  
>  	ret = btrfs_do_readpage(page, NULL, &bio_ctrl, 0, NULL);
>  	/*
> @@ -1911,11 +1880,8 @@ static inline void contiguous_readpages(struct page *pages[], int nr_pages,
>  					struct btrfs_bio_ctrl *bio_ctrl,
>  					u64 *prev_em_start)
>  {
> -	struct btrfs_inode *inode = BTRFS_I(pages[0]->mapping->host);
>  	int index;
>  
> -	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
> -
>  	for (index = 0; index < nr_pages; index++) {
>  		btrfs_do_readpage(pages[index], em_cached, bio_ctrl,
>  				  REQ_RAHEAD, prev_em_start);
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 473a0743270b..9266ee6c1a61 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -3806,15 +3806,26 @@ static ssize_t btrfs_direct_read(struct kiocb *iocb, struct iov_iter *to)
>  static ssize_t btrfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  {
>  	ssize_t ret = 0;
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +	loff_t len = iov_iter_count(to);
> +	u64 start = round_down(iocb->ki_pos, PAGE_SIZE);
> +	u64 end = round_up(iocb->ki_pos + len, PAGE_SIZE) - 1;
> +	struct extent_state *cached = NULL;
>  
>  	if (iocb->ki_flags & IOCB_DIRECT) {
>  		ret = btrfs_direct_read(iocb, to);
> -		if (ret < 0 || !iov_iter_count(to) ||
> -		    iocb->ki_pos >= i_size_read(file_inode(iocb->ki_filp)))
> +		if (ret < 0 || !len ||
> +		    iocb->ki_pos >= i_size_read(inode))
>  			return ret;
>  	}
>  
> -	return filemap_read(iocb, to, ret);
> +	btrfs_lock_and_flush_ordered_range(BTRFS_I(inode), start,
> +			end, &cached);
> +

Ok I see why the buffered io thing fell apart, we're now flushing litterally
everything.

Consider what happened before, we search through pagecache, don't find pages,
send it down to readpages, and then we do a btrfs_lock_and_flush_ordered_range()
at that point.

99.99999999% of the time we find nothing, the only time we would is if there was
a O_DIRECT ordered extent outstanding, which is why we need the
btrfs_lock_and_flush_ordered_range(), we need to make sure the right file extent
is in place so we know what to read.

What you've done now is that we'll just flush all the dirty pages in the range
we're reading, instead of just finding an uptodate page and copying it into the
buffer.

What you need here is a btrfs_lock_and_flush_direct_ordered_range(), which only
flushes an ordered extent that has BTRFS_ORDERED_DIRECT set on it.

Additionally we're now incurring a extent lock when the pages would be already
in cache.  I would really rather add a ->readahead_unlocked or something like
this that was called before we started gathering pages, which would happen after
we have a cache missed, and then we do the
btrfs_lock_and_flush_direct_ordered_range() there, and then call into whatever
entry point that goes and does the readahead.  This way we get our locking order
with the same performance characteristics that exist now.  Thanks,

Josef
