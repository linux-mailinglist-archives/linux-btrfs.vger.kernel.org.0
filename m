Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3244B2F20E7
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jan 2021 21:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733049AbhAKUgI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jan 2021 15:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730079AbhAKUgH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jan 2021 15:36:07 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA39C061795
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jan 2021 12:35:27 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id b64so46716qkc.12
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jan 2021 12:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8/y5cwd0VZW6Cu2z3AkF3Ho3DIWg/GNVfRoypNv3Y7s=;
        b=ELTpDE2q+UC7dcuA+W4TKsSwaXSP3uI/ZYMeQrkjz8MoKty9ail9DU/O4ZJWUFPFMP
         aPRS/qIXddE9z542n/KL9gcuSO3EGt+8kz4vY5p1ai1tfX5ZQ3j+etps49venl3OSn2b
         zxcvBsgTMVpDT5VceVTop/iWYobNPtz/jfYGFjxxuVPdZQb3PRzPEM0qjIHinOsX/ick
         3xo4/e/qJAtqQnTXv+4kXqiWIy1BVwU5DGaNtMQ7LOGsyxoKEd5l72nB3CZrcbAn+Pbe
         d6uJD+wtf0K6qpTFfjxQ2jiF38Xm+fvqB/eHtmKNJgNhzrqjbGofBa0mKFpibNN0r904
         h8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8/y5cwd0VZW6Cu2z3AkF3Ho3DIWg/GNVfRoypNv3Y7s=;
        b=Q44E/37USWnnv97MZllmA8C92tNWoMamwo2UXcHGLesuPLm+xDvFesScR6F2nkaOKL
         Lc/Ke4SHA3RORpW2rBG/Wv86HEtEcJuEBAuvkPVM9sHEDUajY8stXy5+H6BSwYHMDWZ9
         eeBUOqd79XmxsnjtCHGPHW6Rpl2C1Sdk4O++BfdE454iqNu3OO4izd+NqcCkSUU3jPSK
         yf+kt9VokjCfADdvxGK0aYIIM2KZdDuIWXYu8oD4CGoSOxTUBsU2IibsuzDJcH5oQEMm
         16ktYzwPGhwaMnpMLW7i1Qvnsm8yGJhfAFO0m/HQXRWiWKyvgpeCJxeZsXJPK7ILaF/S
         iDNw==
X-Gm-Message-State: AOAM533CAiZVs/wUeG1kQFEFq4hKY8ika/cI8NkG402IsIItccO6901C
        k9qy4+Gvmk1ttK1kkZqmiTITVQ==
X-Google-Smtp-Source: ABdhPJwPYAwMbyVxFvDWcuAVahRiCJpi53qZeEoQ7daWJRIysV6Lb8xHP6IAG4nYUbpc97/6Z7ihMg==
X-Received: by 2002:a05:620a:958:: with SMTP id w24mr1161785qkw.99.1610397326240;
        Mon, 11 Jan 2021 12:35:26 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x130sm496954qkb.78.2021.01.11.12.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 12:35:25 -0800 (PST)
Subject: Re: [PATCH v6 10/11] btrfs: implement RWF_ENCODED reads
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1605723568.git.osandov@fb.com>
 <da0b3c6b349ed47e02251e671ba6c33dd8628e1d.1605723568.git.osandov@fb.com>
 <d911c093-476e-0b24-1c46-b59b6c4a2d59@toxicpanda.com>
 <X/yzZyZVZBOBnvVH@relinquished.localdomain>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <1286c8c7-521f-d60c-97d5-c42dc57ce6a9@toxicpanda.com>
Date:   Mon, 11 Jan 2021 15:35:24 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <X/yzZyZVZBOBnvVH@relinquished.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/11/21 3:21 PM, Omar Sandoval wrote:
> On Thu, Dec 03, 2020 at 09:32:37AM -0500, Josef Bacik wrote:
>> On 11/18/20 2:18 PM, Omar Sandoval wrote:
>>> From: Omar Sandoval <osandov@fb.com>
>>>
>>> There are 4 main cases:
>>>
>>> 1. Inline extents: we copy the data straight out of the extent buffer.
>>> 2. Hole/preallocated extents: we fill in zeroes.
>>> 3. Regular, uncompressed extents: we read the sectors we need directly
>>>      from disk.
>>> 4. Regular, compressed extents: we read the entire compressed extent
>>>      from disk and indicate what subset of the decompressed extent is in
>>>      the file.
>>>
>>> This initial implementation simplifies a few things that can be improved
>>> in the future:
>>>
>>> - We hold the inode lock during the operation.
>>> - Cases 1, 3, and 4 allocate temporary memory to read into before
>>>     copying out to userspace.
>>> - We don't do read repair, because it turns out that read repair is
>>>     currently broken for compressed data.
>>>
>>> Signed-off-by: Omar Sandoval <osandov@fb.com>
>>> ---
>>>    fs/btrfs/ctree.h |   2 +
>>>    fs/btrfs/file.c  |   5 +
>>>    fs/btrfs/inode.c | 496 +++++++++++++++++++++++++++++++++++++++++++++++
>>>    3 files changed, 503 insertions(+)
>>>
>>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>>> index 6ab2ab002bf6..ce78424f1d98 100644
>>> --- a/fs/btrfs/ctree.h
>>> +++ b/fs/btrfs/ctree.h
>>> @@ -3133,6 +3133,8 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
>>>    int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end);
>>>    void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
>>>    					  u64 end, int uptodate);
>>> +ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter);
>>> +
>>>    extern const struct dentry_operations btrfs_dentry_operations;
>>>    extern const struct iomap_ops btrfs_dio_iomap_ops;
>>>    extern const struct iomap_dio_ops btrfs_dio_ops;
>>> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
>>> index 224295f8f1e1..193477565200 100644
>>> --- a/fs/btrfs/file.c
>>> +++ b/fs/btrfs/file.c
>>> @@ -3629,6 +3629,11 @@ static ssize_t btrfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>>>    {
>>>    	ssize_t ret = 0;
>>> +	if (iocb->ki_flags & IOCB_ENCODED) {
>>> +		if (iocb->ki_flags & IOCB_NOWAIT)
>>> +			return -EOPNOTSUPP;
>>> +		return btrfs_encoded_read(iocb, to);
>>> +	}
>>>    	if (iocb->ki_flags & IOCB_DIRECT) {
>>>    		ret = btrfs_direct_read(iocb, to);
>>>    		if (ret < 0 || !iov_iter_count(to) ||
>>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>>> index 1ff903f5c5a4..b0e800897b3b 100644
>>> --- a/fs/btrfs/inode.c
>>> +++ b/fs/btrfs/inode.c
>>> @@ -9936,6 +9936,502 @@ void btrfs_set_range_writeback(struct extent_io_tree *tree, u64 start, u64 end)
>>>    	}
>>>    }
>>> +static int encoded_iov_compression_from_btrfs(unsigned int compress_type)
>>> +{
>>> +	switch (compress_type) {
>>> +	case BTRFS_COMPRESS_NONE:
>>> +		return ENCODED_IOV_COMPRESSION_NONE;
>>> +	case BTRFS_COMPRESS_ZLIB:
>>> +		return ENCODED_IOV_COMPRESSION_BTRFS_ZLIB;
>>> +	case BTRFS_COMPRESS_LZO:
>>> +		/*
>>> +		 * The LZO format depends on the page size. 64k is the maximum
>>> +		 * sectorsize (and thus page size) that we support.
>>> +		 */
>>> +		if (PAGE_SIZE < SZ_4K || PAGE_SIZE > SZ_64K)
>>> +			return -EINVAL;
>>> +		return ENCODED_IOV_COMPRESSION_BTRFS_LZO_4K + (PAGE_SHIFT - 12);
>>> +	case BTRFS_COMPRESS_ZSTD:
>>> +		return ENCODED_IOV_COMPRESSION_BTRFS_ZSTD;
>>> +	default:
>>> +		return -EUCLEAN;
>>> +	}
>>> +}
>>> +
>>> +static ssize_t btrfs_encoded_read_inline(struct kiocb *iocb,
>>> +					 struct iov_iter *iter, u64 start,
>>> +					 u64 lockend,
>>> +					 struct extent_state **cached_state,
>>> +					 u64 extent_start, size_t count,
>>> +					 struct encoded_iov *encoded,
>>> +					 bool *unlocked)
>>> +{
>>> +	struct inode *inode = file_inode(iocb->ki_filp);
>>> +	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
>>> +	struct btrfs_path *path;
>>> +	struct extent_buffer *leaf;
>>> +	struct btrfs_file_extent_item *item;
>>> +	u64 ram_bytes;
>>> +	unsigned long ptr;
>>> +	void *tmp;
>>> +	ssize_t ret;
>>> +
>>> +	path = btrfs_alloc_path();
>>> +	if (!path) {
>>> +		ret = -ENOMEM;
>>> +		goto out;
>>> +	}
>>> +	ret = btrfs_lookup_file_extent(NULL, BTRFS_I(inode)->root, path,
>>> +				       btrfs_ino(BTRFS_I(inode)), extent_start,
>>> +				       0);
>>> +	if (ret) {
>>> +		if (ret > 0) {
>>> +			/* The extent item disappeared? */
>>> +			ret = -EIO;
>>> +		}
>>> +		goto out;
>>> +	}
>>> +	leaf = path->nodes[0];
>>> +	item = btrfs_item_ptr(leaf, path->slots[0],
>>> +			      struct btrfs_file_extent_item);
>>> +
>>> +	ram_bytes = btrfs_file_extent_ram_bytes(leaf, item);
>>> +	ptr = btrfs_file_extent_inline_start(item);
>>> +
>>> +	encoded->len = (min_t(u64, extent_start + ram_bytes, inode->i_size) -
>>> +			iocb->ki_pos);
>>> +	ret = encoded_iov_compression_from_btrfs(
>>> +				 btrfs_file_extent_compression(leaf, item));
>>> +	if (ret < 0)
>>> +		goto out;
>>> +	encoded->compression = ret;
>>> +	if (encoded->compression) {
>>> +		size_t inline_size;
>>> +
>>> +		inline_size = btrfs_file_extent_inline_item_len(leaf,
>>> +						btrfs_item_nr(path->slots[0]));
>>> +		if (inline_size > count) {
>>> +			ret = -ENOBUFS;
>>> +			goto out;
>>> +		}
>>> +		count = inline_size;
>>> +		encoded->unencoded_len = ram_bytes;
>>> +		encoded->unencoded_offset = iocb->ki_pos - extent_start;
>>> +	} else {
>>> +		encoded->len = encoded->unencoded_len = count =
>>> +			min_t(u64, count, encoded->len);
>>> +		ptr += iocb->ki_pos - extent_start;
>>> +	}
>>> +
>>> +	tmp = kmalloc(count, GFP_NOFS);
>>> +	if (!tmp) {
>>> +		ret = -ENOMEM;
>>> +		goto out;
>>> +	}
>>> +	read_extent_buffer(leaf, tmp, ptr, count);
>>> +	btrfs_release_path(path);
>>> +	unlock_extent_cached(io_tree, start, lockend, cached_state);
>>> +	inode_unlock_shared(inode);
>>> +	*unlocked = true;
>>> +
>>> +	ret = copy_encoded_iov_to_iter(encoded, iter);
>>> +	if (ret)
>>> +		goto out_free;
>>> +	ret = copy_to_iter(tmp, count, iter);
>>> +	if (ret != count)
>>> +		ret = -EFAULT;
>>> +out_free:
>>> +	kfree(tmp);
>>> +out:
>>> +	btrfs_free_path(path);
>>> +	return ret;
>>> +}
>>> +
>>> +struct btrfs_encoded_read_private {
>>> +	struct inode *inode;
>>> +	wait_queue_head_t wait;
>>> +	atomic_t pending;
>>> +	blk_status_t status;
>>> +	bool skip_csum;
>>> +};
>>> +
>>> +static blk_status_t submit_encoded_read_bio(struct inode *inode,
>>> +					    struct bio *bio, int mirror_num,
>>> +					    unsigned long bio_flags)
>>> +{
>>> +	struct btrfs_encoded_read_private *priv = bio->bi_private;
>>> +	struct btrfs_io_bio *io_bio = btrfs_io_bio(bio);
>>> +	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>>> +	blk_status_t ret;
>>> +
>>> +	if (!priv->skip_csum) {
>>> +		ret = btrfs_lookup_bio_sums(inode, bio, io_bio->logical, NULL);
>>> +		if (ret)
>>> +			return ret;
>>> +	}
>>> +
>>> +	ret = btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
>>> +	if (ret) {
>>> +		btrfs_io_bio_free_csum(io_bio);
>>> +		return ret;
>>> +	}
>>> +
>>> +	atomic_inc(&priv->pending);
>>> +	ret = btrfs_map_bio(fs_info, bio, mirror_num);
>>> +	if (ret) {
>>> +		atomic_dec(&priv->pending);
>>> +		btrfs_io_bio_free_csum(io_bio);
>>> +	}
>>> +	return ret;
>>> +}
>>> +
>>> +static blk_status_t btrfs_encoded_read_check_bio(struct btrfs_io_bio *io_bio)
>>> +{
>>> +	const bool uptodate = io_bio->bio.bi_status == BLK_STS_OK;
>>> +	struct btrfs_encoded_read_private *priv = io_bio->bio.bi_private;
>>> +	struct inode *inode = priv->inode;
>>> +	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>>> +	u32 sectorsize = fs_info->sectorsize;
>>> +	struct bio_vec *bvec;
>>> +	struct bvec_iter_all iter_all;
>>> +	u64 start = io_bio->logical;
>>> +	int icsum = 0;
>>> +
>>> +	if (priv->skip_csum || !uptodate)
>>> +		return io_bio->bio.bi_status;
>>> +
>>> +	bio_for_each_segment_all(bvec, &io_bio->bio, iter_all) {
>>> +		unsigned int i, nr_sectors, pgoff;
>>> +
>>> +		nr_sectors = BTRFS_BYTES_TO_BLKS(fs_info, bvec->bv_len);
>>> +		pgoff = bvec->bv_offset;
>>> +		for (i = 0; i < nr_sectors; i++) {
>>> +			ASSERT(pgoff < PAGE_SIZE);
>>> +			if (check_data_csum(inode, io_bio, icsum, bvec->bv_page,
>>> +					    pgoff, start))
>>> +				return BLK_STS_IOERR;
>>> +			start += sectorsize;
>>> +			icsum++;
>>> +			pgoff += sectorsize;
>>> +		}
>>> +	}
>>> +	return BLK_STS_OK;
>>> +}
>>> +
>>> +static void btrfs_encoded_read_endio(struct bio *bio)
>>> +{
>>> +	struct btrfs_encoded_read_private *priv = bio->bi_private;
>>> +	struct btrfs_io_bio *io_bio = btrfs_io_bio(bio);
>>> +	blk_status_t status;
>>> +
>>> +	status = btrfs_encoded_read_check_bio(io_bio);
>>> +	if (status) {
>>> +		/*
>>> +		 * The memory barrier implied by the atomic_dec_return() here
>>> +		 * pairs with the memory barrier implied by the
>>> +		 * atomic_dec_return() or io_wait_event() in
>>> +		 * btrfs_encoded_read_regular_fill_pages() to ensure that this
>>> +		 * write is observed before the load of status in
>>> +		 * btrfs_encoded_read_regular_fill_pages().
>>> +		 */
>>> +		WRITE_ONCE(priv->status, status);
>>> +	}
>>> +	if (!atomic_dec_return(&priv->pending))
>>> +		wake_up(&priv->wait);
>>> +	btrfs_io_bio_free_csum(io_bio);
>>> +	bio_put(bio);
>>> +}
>>> +
>>> +static int btrfs_encoded_read_regular_fill_pages(struct inode *inode, u64 offset,
>>> +						 u64 disk_io_size, struct page **pages)
>>> +{
>>> +	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>>> +	struct btrfs_encoded_read_private priv = {
>>> +		.inode = inode,
>>> +		.pending = ATOMIC_INIT(1),
>>> +		.skip_csum = BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM,
>>> +	};
>>> +	unsigned long i = 0;
>>> +	u64 cur = 0;
>>> +	int ret;
>>> +
>>> +	init_waitqueue_head(&priv.wait);
>>> +	/*
>>> +	 * Submit bios for the extent, splitting due to bio or stripe limits as
>>> +	 * necessary.
>>> +	 */
>>> +	while (cur < disk_io_size) {
>>> +		struct btrfs_io_geometry geom;
>>> +		struct bio *bio = NULL;
>>> +		u64 remaining;
>>> +
>>> +		ret = btrfs_get_io_geometry(fs_info, BTRFS_MAP_READ,
>>> +					    offset + cur, disk_io_size - cur,
>>> +					    &geom);
>>> +		if (ret) {
>>> +			WRITE_ONCE(priv.status, errno_to_blk_status(ret));
>>> +			break;
>>> +		}
>>> +		remaining = min(geom.len, disk_io_size - cur);
>>> +		while (bio || remaining) {
>>> +			size_t bytes = min_t(u64, remaining, PAGE_SIZE);
>>> +
>>> +			if (!bio) {
>>> +				bio = btrfs_bio_alloc(offset + cur);
>>> +				bio->bi_end_io = btrfs_encoded_read_endio;
>>> +				bio->bi_private = &priv;
>>> +				bio->bi_opf = REQ_OP_READ;
>>> +			}
>>> +
>>> +			if (!bytes ||
>>> +			    bio_add_page(bio, pages[i], bytes, 0) < bytes) {
>>> +				blk_status_t status;
>>> +
>>> +				status = submit_encoded_read_bio(inode, bio, 0,
>>> +								 0);
>>> +				if (status) {
>>> +					WRITE_ONCE(priv.status, status);
>>> +					bio_put(bio);
>>> +					goto out;
>>> +				}
>>> +				bio = NULL;
>>> +				continue;
>>> +			}
>>> +
>>> +			i++;
>>> +			cur += bytes;
>>> +			remaining -= bytes;
>>> +		}
>>> +	}
>>> +
>>> +out:
>>> +	if (atomic_dec_return(&priv.pending))
>>> +		io_wait_event(priv.wait, !atomic_read(&priv.pending));
>>> +	/* See btrfs_encoded_read_endio() for ordering. */
>>> +	return blk_status_to_errno(READ_ONCE(priv.status));
>>> +}
>>> +
>>> +static ssize_t btrfs_encoded_read_regular(struct kiocb *iocb,
>>> +					  struct iov_iter *iter,
>>> +					  u64 start, u64 lockend,
>>> +					  struct extent_state **cached_state,
>>> +					  u64 offset, u64 disk_io_size,
>>> +					  size_t count,
>>> +					  const struct encoded_iov *encoded,
>>> +					  bool *unlocked)
>>> +{
>>> +	struct inode *inode = file_inode(iocb->ki_filp);
>>> +	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
>>> +	struct page **pages;
>>> +	unsigned long nr_pages, i;
>>> +	u64 cur;
>>> +	size_t page_offset;
>>> +	ssize_t ret;
>>> +
>>> +	nr_pages = DIV_ROUND_UP(disk_io_size, PAGE_SIZE);
>>> +	pages = kcalloc(nr_pages, sizeof(struct page *), GFP_NOFS);
>>> +	if (!pages)
>>> +		return -ENOMEM;
>>> +	for (i = 0; i < nr_pages; i++) {
>>> +		pages[i] = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
>>> +		if (!pages[i]) {
>>> +			ret = -ENOMEM;
>>> +			goto out;
>>> +		}
>>> +	}
>>> +
>>> +	ret = btrfs_encoded_read_regular_fill_pages(inode, offset, disk_io_size,
>>> +						    pages);
>>> +	if (ret)
>>> +		goto out;
>>> +
>>> +	unlock_extent_cached(io_tree, start, lockend, cached_state);
>>> +	inode_unlock_shared(inode);
>>> +	*unlocked = true;
>>> +
>>> +	ret = copy_encoded_iov_to_iter(encoded, iter);
>>> +	if (ret)
>>> +		goto out;
>>> +	if (encoded->compression) {
>>> +		i = 0;
>>> +		page_offset = 0;
>>> +	} else {
>>> +		i = (iocb->ki_pos - start) >> PAGE_SHIFT;
>>> +		page_offset = (iocb->ki_pos - start) & (PAGE_SIZE - 1);
>>> +	}
>>> +	cur = 0;
>>> +	while (cur < count) {
>>> +		size_t bytes = min_t(size_t, count - cur,
>>> +				     PAGE_SIZE - page_offset);
>>> +
>>> +		if (copy_page_to_iter(pages[i], page_offset, bytes,
>>> +				      iter) != bytes) {
>>> +			ret = -EFAULT;
>>> +			goto out;
>>> +		}
>>> +		i++;
>>> +		cur += bytes;
>>> +		page_offset = 0;
>>> +	}
>>> +	ret = count;
>>> +out:
>>> +	for (i = 0; i < nr_pages; i++) {
>>> +		if (pages[i])
>>> +			__free_page(pages[i]);
>>> +	}
>>> +	kfree(pages);
>>> +	return ret;
>>> +}
>>> +
>>> +ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter)
>>> +{
>>> +	struct inode *inode = file_inode(iocb->ki_filp);
>>> +	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>>> +	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
>>> +	ssize_t ret;
>>> +	size_t count;
>>> +	u64 start, lockend, offset, disk_io_size;
>>> +	struct extent_state *cached_state = NULL;
>>> +	struct extent_map *em;
>>> +	struct encoded_iov encoded = {};
>>> +	bool unlocked = false;
>>> +
>>> +	ret = generic_encoded_read_checks(iocb, iter);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +	if (ret == 0)
>>> +		return copy_encoded_iov_to_iter(&encoded, iter);
>>> +	count = ret;
>>> +
>>> +	file_accessed(iocb->ki_filp);
>>> +
>>> +	inode_lock_shared(inode);
>>> +
>>> +	if (iocb->ki_pos >= inode->i_size) {
>>> +		inode_unlock_shared(inode);
>>> +		return copy_encoded_iov_to_iter(&encoded, iter);
>>> +	}
>>> +	start = ALIGN_DOWN(iocb->ki_pos, fs_info->sectorsize);
>>> +	/*
>>> +	 * We don't know how long the extent containing iocb->ki_pos is, but if
>>> +	 * it's compressed we know that it won't be longer than this.
>>> +	 */
>>> +	lockend = start + BTRFS_MAX_UNCOMPRESSED - 1;
>>> +
>>> +	for (;;) {
>>> +		struct btrfs_ordered_extent *ordered;
>>> +
>>> +		ret = btrfs_wait_ordered_range(inode, start,
>>> +					       lockend - start + 1);
>>> +		if (ret)
>>> +			goto out_unlock_inode;
>>> +		lock_extent_bits(io_tree, start, lockend, &cached_state);
>>> +		ordered = btrfs_lookup_ordered_range(BTRFS_I(inode), start,
>>> +						     lockend - start + 1);
>>> +		if (!ordered)
>>> +			break;
>>> +		btrfs_put_ordered_extent(ordered);
>>> +		unlock_extent_cached(io_tree, start, lockend, &cached_state);
>>> +		cond_resched();
>>> +	}
>>
>> This can be replaced with btrfs_lock_and_flush_ordered_range().  Then you can add
> 
> Sorry, finally getting back to this after the break. Please correct me
> if I'm wrong, but I don't think btrfs_lock_and_flush_ordered_range() is
> strong enough here.
> 
> An encoded read needs to make sure that any buffered writes are on disk
> (since it's basically direct I/O). btrfs_lock_and_flush_ordered_range()
> bails immediately if there aren't any ordered extents. As far as I can
> tell, ordered extents aren't created until writepage, so if I do some
> buffered writes and call btrfs_lock_and_flush_ordered_range() before
> writepage creates the ordered extents, it won't flush the buffered
> writes like I need it to. This loop with btrfs_wait_ordered_range()
> does.
> 

I didn't realize that btrfs_wait_ordered_range() does the fdatawrite_range, 
awesome.  You can leave it then and add my reviewed-by.  Thanks,

Josef
