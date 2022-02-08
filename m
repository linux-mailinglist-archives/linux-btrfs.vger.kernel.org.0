Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626904AE37D
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Feb 2022 23:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387203AbiBHWVw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Feb 2022 17:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386325AbiBHUIz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Feb 2022 15:08:55 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725AFC0613CB
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Feb 2022 12:08:53 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id n23so431925pfo.1
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Feb 2022 12:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0fdRl8R9HluiuIZGi4UNrBia+o8X/DL5HS/AotFQrqE=;
        b=qij35JsdCnyyqKdxuCbGLhWMdMCWnGZS9hAGQuE6FGVWjCd7GSSiIIJd16svNO+mRN
         +SFzmr0hqep5V/jvOXrHt5uG6zoU4+3wJDvaqnP0CmnuxpQw4vdUo9G3JPX5kwDijI67
         ZkKW852iUcJ2We0PsOuKf0gfgE6LAAB6/CIk3GilqmGB4AN0/54A90AkmIQdWuiCYS/7
         PmV5lODOu4k7LUsHsA6fDUMBdN7xIppLleTbiQ4YBEdgcjI3VWgmFcM1yaGqDTXSptW2
         GIx6dNRK7rBAnTpzx3vh5guG9wqDtseNE+URjyrSTztbtgOiFw6wtd+jIgxb5loCdcK6
         Rqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0fdRl8R9HluiuIZGi4UNrBia+o8X/DL5HS/AotFQrqE=;
        b=yTD4feIU98Dv/uiISeYUX8m9CpczzVWgpUjAOthKjtzrgJA6e6w6HSWLcpyXR24xqN
         rry79zou2PS+TvruyYlGNcumyhipBKnF+qxKW2jZDvOrZlc7ZdYW5yolLavinpygpHhB
         25qH7i/2gURgMOChZ0Ka++LDJ/3inKJAsoMiOV021yuoWCBxIyCl97wO7/AV+IS4laHD
         QmVtfu0Ago3rIul0SU1GKI1lgBxYYSjBy/G3erdEm2I4H+luTwwutRY62mmg2hQuayZc
         0Ee7zn3hRydM6zZ7zscpjZ8Rw7hOYgv5Y3/srhE7y/cuCyJ9YhMzU79QjMlfwia4rVxL
         FJGQ==
X-Gm-Message-State: AOAM530/xG+wD5QCLPQiBgXUMrqyAegMm87bJUh8Xys4WD61mEmHFc0P
        HPsOaJ58VjclwCVtXZh0FlSguRQTKL+Y2Q==
X-Google-Smtp-Source: ABdhPJzH9DQU9Lv3DIRztUlKw8kiYETWaYbTfyZmi+RJbUlr6Ah6c5mU8xLooFeWp6NQXybdEOXKlg==
X-Received: by 2002:a63:286:: with SMTP id 128mr4739716pgc.216.1644350932716;
        Tue, 08 Feb 2022 12:08:52 -0800 (PST)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:172a])
        by smtp.gmail.com with ESMTPSA id rj1sm3766037pjb.49.2022.02.08.12.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 12:08:52 -0800 (PST)
Date:   Tue, 8 Feb 2022 12:08:50 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v12 09/17] btrfs: add BTRFS_IOC_ENCODED_READ
Message-ID: <YgLN0iG/T4RnwZrt@relinquished.localdomain>
References: <cover.1637179348.git.osandov@fb.com>
 <111c7aadb3fa218b7926a49acf3fb34654d89a75.1637179348.git.osandov@fb.com>
 <20220124222632.GL14046@twin.jikos.cz>
 <YfBq/aXT4D/fm3ae@relinquished.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfBq/aXT4D/fm3ae@relinquished.localdomain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 25, 2022 at 01:26:21PM -0800, Omar Sandoval wrote:
> On Mon, Jan 24, 2022 at 11:26:32PM +0100, David Sterba wrote:
> > On Wed, Nov 17, 2021 at 12:19:19PM -0800, Omar Sandoval wrote:
> > > From: Omar Sandoval <osandov@fb.com>
> > > 
> > > There are 4 main cases:
> > > 
> > > 1. Inline extents: we copy the data straight out of the extent buffer.
> > > 2. Hole/preallocated extents: we fill in zeroes.
> > > 3. Regular, uncompressed extents: we read the sectors we need directly
> > >    from disk.
> > > 4. Regular, compressed extents: we read the entire compressed extent
> > >    from disk and indicate what subset of the decompressed extent is in
> > >    the file.
> > > 
> > > This initial implementation simplifies a few things that can be improved
> > > in the future:
> > > 
> > > - We hold the inode lock during the operation.
> > > - Cases 1, 3, and 4 allocate temporary memory to read into before
> > >   copying out to userspace.
> > > - We don't do read repair, because it turns out that read repair is
> > >   currently broken for compressed data.
> > > 
> > > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > > ---
> > >  fs/btrfs/ctree.h |   4 +
> > >  fs/btrfs/inode.c | 496 +++++++++++++++++++++++++++++++++++++++++++++++
> > >  fs/btrfs/ioctl.c | 106 ++++++++++
> > >  3 files changed, 606 insertions(+)
> > > 
> > > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > > index 2e7f74060a14..70034e33abe6 100644
> > > --- a/fs/btrfs/ctree.h
> > > +++ b/fs/btrfs/ctree.h
> > > @@ -3275,6 +3275,10 @@ int btrfs_writepage_cow_fixup(struct page *page);
> > >  void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
> > >  					  struct page *page, u64 start,
> > >  					  u64 end, bool uptodate);
> > > +struct btrfs_ioctl_encoded_io_args;
> > > +ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
> > > +			   struct btrfs_ioctl_encoded_io_args *encoded);
> > > +
> > >  extern const struct dentry_operations btrfs_dentry_operations;
> > >  extern const struct iomap_ops btrfs_dio_iomap_ops;
> > >  extern const struct iomap_dio_ops btrfs_dio_ops;
> > > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > > index c2efea101f61..d29e968fd18b 100644
> > > --- a/fs/btrfs/inode.c
> > > +++ b/fs/btrfs/inode.c
> > > @@ -10525,6 +10525,502 @@ void btrfs_set_range_writeback(struct btrfs_inode *inode, u64 start, u64 end)
> > >  	}
> > >  }
> > >  
> > > +static int btrfs_encoded_io_compression_from_extent(int compress_type)
> > > +{
> > > +	switch (compress_type) {
> > > +	case BTRFS_COMPRESS_NONE:
> > > +		return BTRFS_ENCODED_IO_COMPRESSION_NONE;
> > > +	case BTRFS_COMPRESS_ZLIB:
> > > +		return BTRFS_ENCODED_IO_COMPRESSION_ZLIB;
> > > +	case BTRFS_COMPRESS_LZO:
> > > +		/*
> > > +		 * The LZO format depends on the page size. 64k is the maximum
> > > +		 * sectorsize (and thus page size) that we support.
> > > +		 */
> > > +		if (PAGE_SIZE < SZ_4K || PAGE_SIZE > SZ_64K)
> > > +			return -EINVAL;
> > > +		return BTRFS_ENCODED_IO_COMPRESSION_LZO_4K + (PAGE_SHIFT - 12);
> > > +	case BTRFS_COMPRESS_ZSTD:
> > > +		return BTRFS_ENCODED_IO_COMPRESSION_ZSTD;
> > > +	default:
> > > +		return -EUCLEAN;
> > > +	}
> > > +}
> > > +
> > > +static ssize_t btrfs_encoded_read_inline(
> > > +				struct kiocb *iocb,
> > > +				struct iov_iter *iter, u64 start,
> > > +				u64 lockend,
> > > +				struct extent_state **cached_state,
> > > +				u64 extent_start, size_t count,
> > > +				struct btrfs_ioctl_encoded_io_args *encoded,
> > > +				bool *unlocked)
> > > +{
> > > +	struct inode *inode = file_inode(iocb->ki_filp);
> > 
> > Please use btrfs_inode in all internal helpers, either as parameters or
> > as local variable, to avoid the BTRFS_I and btrfs_sb conversions everywhere.
> > 
> > > +	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
> > > +	struct btrfs_path *path;
> > > +	struct extent_buffer *leaf;
> > > +	struct btrfs_file_extent_item *item;
> > > +	u64 ram_bytes;
> > > +	unsigned long ptr;
> > > +	void *tmp;
> > > +	ssize_t ret;
> > > +
> > > +	path = btrfs_alloc_path();
> > > +	if (!path) {
> > > +		ret = -ENOMEM;
> > > +		goto out;
> > > +	}
> > > +	ret = btrfs_lookup_file_extent(NULL, BTRFS_I(inode)->root, path,
> > > +				       btrfs_ino(BTRFS_I(inode)), extent_start,
> > > +				       0);
> > > +	if (ret) {
> > > +		if (ret > 0) {
> > > +			/* The extent item disappeared? */
> > > +			ret = -EIO;
> > > +		}
> > > +		goto out;
> > > +	}
> > > +	leaf = path->nodes[0];
> > > +	item = btrfs_item_ptr(leaf, path->slots[0],
> > > +			      struct btrfs_file_extent_item);
> > > +
> > > +	ram_bytes = btrfs_file_extent_ram_bytes(leaf, item);
> > > +	ptr = btrfs_file_extent_inline_start(item);
> > > +
> > > +	encoded->len = (min_t(u64, extent_start + ram_bytes, inode->i_size) -
> > > +			iocb->ki_pos);
> > 
> > No need for the outer ( )
> > 
> > > +	ret = btrfs_encoded_io_compression_from_extent(
> > > +				 btrfs_file_extent_compression(leaf, item));
> > > +	if (ret < 0)
> > > +		goto out;
> > > +	encoded->compression = ret;
> > > +	if (encoded->compression) {
> > > +		size_t inline_size;
> > > +
> > > +		inline_size = btrfs_file_extent_inline_item_len(leaf,
> > > +								path->slots[0]);
> > > +		if (inline_size > count) {
> > > +			ret = -ENOBUFS;
> > > +			goto out;
> > > +		}
> > > +		count = inline_size;
> > > +		encoded->unencoded_len = ram_bytes;
> > > +		encoded->unencoded_offset = iocb->ki_pos - extent_start;
> > > +	} else {
> > > +		encoded->len = encoded->unencoded_len = count =
> > > +			min_t(u64, count, encoded->len);
> > 
> > I'm sure I have commented on that in the past, please don't use chained
> > intializations. In this case something like:
> > 
> > 		count = min_t(u64, count, encoded->len);
> > 		encoded->len = count;
> > 		encoded->unencoded_len = count;
> > 
> > > +		ptr += iocb->ki_pos - extent_start;
> > > +	}
> > > +
> > > +	tmp = kmalloc(count, GFP_NOFS);
> > > +	if (!tmp) {
> > > +		ret = -ENOMEM;
> > > +		goto out;
> > > +	}
> > > +	read_extent_buffer(leaf, tmp, ptr, count);
> > > +	btrfs_release_path(path);
> > > +	unlock_extent_cached(io_tree, start, lockend, cached_state);
> > > +	inode_unlock_shared(inode);
> > > +	*unlocked = true;
> > > +
> > > +	ret = copy_to_iter(tmp, count, iter);
> > > +	if (ret != count)
> > > +		ret = -EFAULT;
> > > +	kfree(tmp);
> > > +out:
> > > +	btrfs_free_path(path);
> > > +	return ret;
> > > +}
> > > +
> > > +struct btrfs_encoded_read_private {
> > > +	struct inode *inode;
> > 
> > This should also be btrfs_inode
> > 
> > > +	u64 file_offset;
> > > +	wait_queue_head_t wait;
> > > +	atomic_t pending;
> > > +	blk_status_t status;
> > > +	bool skip_csum;
> > > +};
> > > +
> > > +static blk_status_t submit_encoded_read_bio(struct inode *inode,
> > 
> > struct btrfs_inode
> > 
> > > +					    struct bio *bio, int mirror_num,
> > > +					    unsigned long bio_flags)
> > 
> > bio_flags is unused here (and in the encoded patches afaics)
> > 
> > > +{
> > > +	struct btrfs_encoded_read_private *priv = bio->bi_private;
> > > +	struct btrfs_bio *bbio = btrfs_bio(bio);
> > > +	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> > > +	blk_status_t ret;
> > > +
> > > +	if (!priv->skip_csum) {
> > > +		ret = btrfs_lookup_bio_sums(inode, bio, NULL);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > > +	ret = btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
> > > +	if (ret) {
> > > +		btrfs_bio_free_csum(bbio);
> > > +		return ret;
> > > +	}
> > > +
> > > +	atomic_inc(&priv->pending);
> > > +	ret = btrfs_map_bio(fs_info, bio, mirror_num);
> > > +	if (ret) {
> > > +		atomic_dec(&priv->pending);
> > > +		btrfs_bio_free_csum(bbio);
> > > +	}
> > > +	return ret;
> > > +}
> > > +
> > > +static blk_status_t btrfs_encoded_read_verify_csum(struct btrfs_bio *bbio)
> > > +{
> > > +	const bool uptodate = bbio->bio.bi_status == BLK_STS_OK;
> > 
> > 	const bool uptodate = (bbio->bio.bi_status == BLK_STS_OK);
> > 
> > > +	struct btrfs_encoded_read_private *priv = bbio->bio.bi_private;
> > > +	struct inode *inode = priv->inode;
> > > +	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> > > +	u32 sectorsize = fs_info->sectorsize;
> > > +	struct bio_vec *bvec;
> > > +	struct bvec_iter_all iter_all;
> > > +	u64 start = priv->file_offset;
> > > +	u32 bio_offset = 0;
> > > +
> > > +	if (priv->skip_csum || !uptodate)
> > > +		return bbio->bio.bi_status;
> > > +
> > > +	bio_for_each_segment_all(bvec, &bbio->bio, iter_all) {
> > > +		unsigned int i, nr_sectors, pgoff;
> > > +
> > > +		nr_sectors = BTRFS_BYTES_TO_BLKS(fs_info, bvec->bv_len);
> > > +		pgoff = bvec->bv_offset;
> > > +		for (i = 0; i < nr_sectors; i++) {
> > > +			ASSERT(pgoff < PAGE_SIZE);
> > > +			if (check_data_csum(inode, bbio, bio_offset,
> > > +					    bvec->bv_page, pgoff, start))
> > > +				return BLK_STS_IOERR;
> > > +			start += sectorsize;
> > > +			bio_offset += sectorsize;
> > > +			pgoff += sectorsize;
> > > +		}
> > > +	}
> > > +	return BLK_STS_OK;
> > > +}
> > > +
> > > +static void btrfs_encoded_read_endio(struct bio *bio)
> > > +{
> > > +	struct btrfs_encoded_read_private *priv = bio->bi_private;
> > > +	struct btrfs_bio *bbio = btrfs_bio(bio);
> > > +	blk_status_t status;
> > > +
> > > +	status = btrfs_encoded_read_verify_csum(bbio);
> > > +	if (status) {
> > > +		/*
> > > +		 * The memory barrier implied by the atomic_dec_return() here
> > > +		 * pairs with the memory barrier implied by the
> > > +		 * atomic_dec_return() or io_wait_event() in
> > > +		 * btrfs_encoded_read_regular_fill_pages() to ensure that this
> > > +		 * write is observed before the load of status in
> > > +		 * btrfs_encoded_read_regular_fill_pages().
> > > +		 */
> > > +		WRITE_ONCE(priv->status, status);
> > > +	}
> > > +	if (!atomic_dec_return(&priv->pending))
> > > +		wake_up(&priv->wait);
> > > +	btrfs_bio_free_csum(bbio);
> > > +	bio_put(bio);
> > > +}
> > > +
> > > +static int btrfs_encoded_read_regular_fill_pages(struct inode *inode,
> > > +						 u64 file_offset,
> > > +						 u64 disk_bytenr,
> > > +						 u64 disk_io_size,
> > > +						 struct page **pages)
> > > +{
> > > +	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> > > +	struct btrfs_encoded_read_private priv = {
> > > +		.inode = inode,
> > > +		.file_offset = file_offset,
> > > +		.pending = ATOMIC_INIT(1),
> > > +		.skip_csum = BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM,
> > > +	};
> > > +	unsigned long i = 0;
> > > +	u64 cur = 0;
> > > +	int ret;
> > > +
> > > +	init_waitqueue_head(&priv.wait);
> > > +	/*
> > > +	 * Submit bios for the extent, splitting due to bio or stripe limits as
> > > +	 * necessary.
> > > +	 */
> > > +	while (cur < disk_io_size) {
> > > +		struct extent_map *em;
> > > +		struct btrfs_io_geometry geom;
> > > +		struct bio *bio = NULL;
> > > +		u64 remaining;
> > > +
> > > +		em = btrfs_get_chunk_map(fs_info, disk_bytenr + cur,
> > > +					 disk_io_size - cur);
> > > +		if (IS_ERR(em)) {
> > > +			ret = PTR_ERR(em);
> > > +		} else {
> > > +			ret = btrfs_get_io_geometry(fs_info, em, BTRFS_MAP_READ,
> > > +						    disk_bytenr + cur, &geom);
> > > +			free_extent_map(em);
> > > +		}
> > > +		if (ret) {
> > > +			WRITE_ONCE(priv.status, errno_to_blk_status(ret));
> > > +			break;
> > > +		}
> > > +		remaining = min(geom.len, disk_io_size - cur);
> > > +		while (bio || remaining) {
> > > +			size_t bytes = min_t(u64, remaining, PAGE_SIZE);
> > > +
> > > +			if (!bio) {
> > > +				bio = btrfs_bio_alloc(BIO_MAX_VECS);
> > > +				bio->bi_iter.bi_sector =
> > > +					(disk_bytenr + cur) >> SECTOR_SHIFT;
> > > +				bio->bi_end_io = btrfs_encoded_read_endio;
> > > +				bio->bi_private = &priv;
> > > +				bio->bi_opf = REQ_OP_READ;
> > > +			}
> > > +
> > > +			if (!bytes ||
> > > +			    bio_add_page(bio, pages[i], bytes, 0) < bytes) {
> > > +				blk_status_t status;
> > > +
> > > +				status = submit_encoded_read_bio(inode, bio, 0,
> > > +								 0);
> > > +				if (status) {
> > > +					WRITE_ONCE(priv.status, status);
> > > +					bio_put(bio);
> > > +					goto out;
> > > +				}
> > > +				bio = NULL;
> > > +				continue;
> > > +			}
> > > +
> > > +			i++;
> > > +			cur += bytes;
> > > +			remaining -= bytes;
> > > +		}
> > > +	}
> > > +
> > > +out:
> > > +	if (atomic_dec_return(&priv.pending))
> > > +		io_wait_event(priv.wait, !atomic_read(&priv.pending));
> > > +	/* See btrfs_encoded_read_endio() for ordering. */
> > > +	return blk_status_to_errno(READ_ONCE(priv.status));
> > > +}
> > > +
> > > +static ssize_t btrfs_encoded_read_regular(struct kiocb *iocb,
> > > +					  struct iov_iter *iter,
> > > +					  u64 start, u64 lockend,
> > > +					  struct extent_state **cached_state,
> > > +					  u64 disk_bytenr, u64 disk_io_size,
> > > +					  size_t count, bool compressed,
> > > +					  bool *unlocked)
> > > +{
> > > +	struct inode *inode = file_inode(iocb->ki_filp);
> > > +	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
> > > +	struct page **pages;
> > > +	unsigned long nr_pages, i;
> > > +	u64 cur;
> > > +	size_t page_offset;
> > > +	ssize_t ret;
> > > +
> > > +	nr_pages = DIV_ROUND_UP(disk_io_size, PAGE_SIZE);
> > > +	pages = kcalloc(nr_pages, sizeof(struct page *), GFP_NOFS);
> > > +	if (!pages)
> > > +		return -ENOMEM;
> > > +	for (i = 0; i < nr_pages; i++) {
> > > +		pages[i] = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
> > 
> > No HIGHMEM please.
> > 
> > > +		if (!pages[i]) {
> > > +			ret = -ENOMEM;
> > > +			goto out;
> > > +		}
> > > +	}
> > > +
> > > +	ret = btrfs_encoded_read_regular_fill_pages(inode, start, disk_bytenr,
> > > +						    disk_io_size, pages);
> > > +	if (ret)
> > > +		goto out;
> > > +
> > > +	unlock_extent_cached(io_tree, start, lockend, cached_state);
> > > +	inode_unlock_shared(inode);
> > > +	*unlocked = true;
> > > +
> > > +	if (compressed) {
> > > +		i = 0;
> > > +		page_offset = 0;
> > > +	} else {
> > > +		i = (iocb->ki_pos - start) >> PAGE_SHIFT;
> > > +		page_offset = (iocb->ki_pos - start) & (PAGE_SIZE - 1);
> > > +	}
> > > +	cur = 0;
> > > +	while (cur < count) {
> > > +		size_t bytes = min_t(size_t, count - cur,
> > > +				     PAGE_SIZE - page_offset);
> > > +
> > > +		if (copy_page_to_iter(pages[i], page_offset, bytes,
> > > +				      iter) != bytes) {
> > > +			ret = -EFAULT;
> > > +			goto out;
> > > +		}
> > > +		i++;
> > > +		cur += bytes;
> > > +		page_offset = 0;
> > > +	}
> > > +	ret = count;
> > > +out:
> > > +	for (i = 0; i < nr_pages; i++) {
> > > +		if (pages[i])
> > > +			__free_page(pages[i]);
> > > +	}
> > > +	kfree(pages);
> > > +	return ret;
> > > +}
> > > +
> > > +ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
> > > +			   struct btrfs_ioctl_encoded_io_args *encoded)
> > > +{
> > > +	struct inode *inode = file_inode(iocb->ki_filp);
> > > +	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> > > +	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
> > > +	ssize_t ret;
> > > +	size_t count = iov_iter_count(iter);
> > > +	u64 start, lockend, disk_bytenr, disk_io_size;
> > > +	struct extent_state *cached_state = NULL;
> > > +	struct extent_map *em;
> > > +	bool unlocked = false;
> > > +
> > > +	file_accessed(iocb->ki_filp);
> > > +
> > > +	inode_lock_shared(inode);
> > 
> > We have helpers for inode locking now, btrfs_inode_lock, that take
> > additional parameter for cases where we want to exclude certain
> > locking combinations.
> > 
> > Which also brings the question if the encoded read/write should be
> > excluded against some other operations like eg. deduplication has to do
> > against mmap.
> 
> I _think_ we want to exclude mmap, but I need to think some more about
> it. Other than this comment, I believe I've addressed your other
> outstanding comments and rebased my branches:
> 
> https://github.com/osandov/linux/tree/btrfs-send-encoded
> https://github.com/osandov/btrfs-progs/tree/send-encoded
> 
> I'm guessing you're still looking at the send parts, so I'll figure out
> mmap and await further comments before resending.

After looking at the code some more, I don't think we need to exclude
mmap after all.

The only thing that can happen is that with this interleaving:

btrfs_page_mkwrite         btrfs_encoded_read
---------------------------------------------------
(enter)                    (enter)
                           btrfs_wait_ordered_range
lock_extent_bits
btrfs_page_set_dirty
unlock_extent_cached
(exit)
                           lock_extent_bits
			   read extent
                           unlock_extent_cached
                           (exit)

we read the old data from before the page was dirtied. But there are
other interleavings of a concurrent btrfs_page_mkwrite and
btrfs_encoded_read that would read the old data, like:

btrfs_page_mkwrite         btrfs_encoded_read
---------------------------------------------------
(enter)                    (enter)
                           btrfs_wait_ordered_range
                           lock_extent_bits
lock_extent_bits blocked
			   read extent
                           unlock_extent_cached
                           (exit)
lock_extent_bits returns
btrfs_page_set_dirty
unlock_extent_cached
(exit)

Or even if we were to use BTRFS_ILOCK_MMAP:

btrfs_page_mkwrite               btrfs_encoded_read
-------------------------------------------------------------------
(enter)                          (enter)
			         btrfs_inode_lock(BTRFS_ILOCK_MMAP)
down_read(i_mmap_lock) (blocked)
                                 btrfs_wait_ordered_range
                                 lock_extent_bits
			         read extent
                                 unlock_extent_cached
			         btrfs_inode_unlock(BTRFS_ILOCK_MMAP)
down_read(i_mmap_lock) returns
lock_extent_bits
btrfs_page_set_dirty
unlock_extent_cached

In other words, this is inherently racy, so it's fine that we return the
old data in this tiny window.

I pushed the change to use btrfs_inode_lock()/btrfs_inode_unlock() with
BTRFS_ILOCK_SHARED to my branch. I'll resend the series as well.
