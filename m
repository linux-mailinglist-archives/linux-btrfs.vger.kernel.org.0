Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63471B288F
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Apr 2020 15:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbgDUNxh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Apr 2020 09:53:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:41670 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgDUNxg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Apr 2020 09:53:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E2C15AC5F;
        Tue, 21 Apr 2020 13:53:32 +0000 (UTC)
Subject: Re: [PATCH v2 13/15] btrfs: simplify direct I/O read repair
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
References: <cover.1587072977.git.osandov@fb.com>
 <ae795cbe844de282bb9efa6681d1dec2e043f7a0.1587072977.git.osandov@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <93f12e63-1a34-751f-7e05-2ccf7e1933da@suse.com>
Date:   Tue, 21 Apr 2020 16:53:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ae795cbe844de282bb9efa6681d1dec2e043f7a0.1587072977.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 17.04.20 г. 0:46 ч., Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Direct I/O read repair was originally implemented in commit 8b110e393c5a
> ("Btrfs: implement repair function when direct read fails"). This
> implementation is unnecessarily complicated. There is major code
> duplication between __btrfs_subio_endio_read() (checks checksums and
> handles I/O errors for files with checksums),
> __btrfs_correct_data_nocsum() (handles I/O errors for files without
> checksums), btrfs_retry_endio() (checks checksums and handles I/O errors
> for retries of files with checksums), and btrfs_retry_endio_nocsum()
> (handles I/O errors for retries of files without checksum). If it sounds
> like these should be one function, that's because they should.
> Additionally, these functions are very hard to follow due to their
> excessive use of goto.
> 
> This commit replaces the original implementation. After the previous
> commit getting rid of orig_bio, we can reuse the same endio callback for
> repair I/O and the original I/O, we just need to track the file offset
> and original iterator in the repair bio. We can also unify the handling
> of files with and without checksums and simplify the control flow. We
> also no longer have to wait for each repair I/O to complete one by one.
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  fs/btrfs/extent_io.c |   2 +
>  fs/btrfs/inode.c     | 268 +++++++------------------------------------
>  2 files changed, 44 insertions(+), 226 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 85e98ba349a8..6e1d97bb7652 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2631,6 +2631,8 @@ struct bio *btrfs_create_repair_bio(struct inode *inode, struct bio *failed_bio,
>  	}
>  
>  	bio_add_page(bio, page, failrec->len, pg_offset);
> +	btrfs_io_bio(bio)->logical = failrec->start;
> +	btrfs_io_bio(bio)->iter = bio->bi_iter;
>  
>  	return bio;
>  }
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 79b884d2f3ed..2580f2d251d4 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7435,19 +7435,17 @@ static int btrfs_check_dio_repairable(struct inode *inode,
>  
>  static blk_status_t dio_read_error(struct inode *inode, struct bio *failed_bio,
>  				   struct page *page, unsigned int pgoff,
> -				   u64 start, u64 end, int failed_mirror,
> -				   bio_end_io_t *repair_endio, void *repair_arg)
> +				   u64 start, u64 end, int failed_mirror)
>  {
> +	struct btrfs_dio_private *dip = failed_bio->bi_private;
>  	struct io_failure_record *failrec;
>  	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
>  	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
>  	struct bio *bio;
>  	int isector;
>  	unsigned int read_mode = 0;
> -	int segs;
>  	int ret;
>  	blk_status_t status;
> -	struct bio_vec bvec;
>  
>  	BUG_ON(bio_op(failed_bio) == REQ_OP_WRITE);
>  
> @@ -7462,261 +7460,79 @@ static blk_status_t dio_read_error(struct inode *inode, struct bio *failed_bio,
>  		return BLK_STS_IOERR;
>  	}
>  
> -	segs = bio_segments(failed_bio);
> -	bio_get_first_bvec(failed_bio, &bvec);
> -	if (segs > 1 ||
> -	    (bvec.bv_len > btrfs_inode_sectorsize(inode)))
> +	if (btrfs_io_bio(failed_bio)->iter.bi_size > inode->i_sb->s_blocksize)
>  		read_mode |= REQ_FAILFAST_DEV;
>  
>  	isector = start - btrfs_io_bio(failed_bio)->logical;
>  	isector >>= inode->i_sb->s_blocksize_bits;
> -	bio = btrfs_create_repair_bio(inode, failed_bio, failrec, page,
> -				pgoff, isector, repair_endio, repair_arg);
> +	bio = btrfs_create_repair_bio(inode, failed_bio, failrec, page, pgoff,
> +				      isector, failed_bio->bi_end_io, dip);
>  	bio->bi_opf = REQ_OP_READ | read_mode;
>  
>  	btrfs_debug(BTRFS_I(inode)->root->fs_info,
>  		    "repair DIO read error: submitting new dio read[%#x] to this_mirror=%d, in_validation=%d",
>  		    read_mode, failrec->this_mirror, failrec->in_validation);
>  
> +	refcount_inc(&dip->refs);
>  	status = submit_dio_repair_bio(inode, bio, failrec->this_mirror);
>  	if (status) {
>  		free_io_failure(failure_tree, io_tree, failrec);
>  		bio_put(bio);
> +		refcount_dec(&dip->refs);
>  	}
>  
>  	return status;
>  }
>  
> -struct btrfs_retry_complete {
> -	struct completion done;
> -	struct inode *inode;
> -	u64 start;
> -	int uptodate;
> -};
> -
> -static void btrfs_retry_endio_nocsum(struct bio *bio)
> -{
> -	struct btrfs_retry_complete *done = bio->bi_private;
> -	struct inode *inode = done->inode;
> -	struct bio_vec *bvec;
> -	struct extent_io_tree *io_tree, *failure_tree;
> -	struct bvec_iter_all iter_all;
> -
> -	if (bio->bi_status)
> -		goto end;
> -
> -	ASSERT(bio->bi_vcnt == 1);
> -	io_tree = &BTRFS_I(inode)->io_tree;
> -	failure_tree = &BTRFS_I(inode)->io_failure_tree;
> -	ASSERT(bio_first_bvec_all(bio)->bv_len == btrfs_inode_sectorsize(inode));
> -
> -	done->uptodate = 1;
> -	ASSERT(!bio_flagged(bio, BIO_CLONED));
> -	bio_for_each_segment_all(bvec, bio, iter_all)
> -		clean_io_failure(BTRFS_I(inode)->root->fs_info, failure_tree,
> -				 io_tree, done->start, bvec->bv_page,
> -				 btrfs_ino(BTRFS_I(inode)), 0);
> -end:
> -	complete(&done->done);
> -	bio_put(bio);
> -}
> -
> -static blk_status_t __btrfs_correct_data_nocsum(struct inode *inode,
> -						struct btrfs_io_bio *io_bio)
> +static blk_status_t btrfs_check_read_dio_bio(struct inode *inode,
> +					     struct btrfs_io_bio *io_bio,
> +					     const bool uptodate)
>  {
> -	struct btrfs_fs_info *fs_info;
> +	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
> +	u32 sectorsize = fs_info->sectorsize;
> +	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
> +	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
> +	const bool csum = !(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM);
>  	struct bio_vec bvec;
>  	struct bvec_iter iter;
> -	struct btrfs_retry_complete done;
> -	u64 start;
> -	unsigned int pgoff;
> -	u32 sectorsize;
> -	int nr_sectors;
> -	blk_status_t ret;
> +	u64 start = io_bio->logical;
> +	int icsum = 0;
>  	blk_status_t err = BLK_STS_OK;
>  
> -	fs_info = BTRFS_I(inode)->root->fs_info;
> -	sectorsize = fs_info->sectorsize;
> -
> -	start = io_bio->logical;
> -	done.inode = inode;
> -	io_bio->bio.bi_iter = io_bio->iter;
> +	__bio_for_each_segment(bvec, &io_bio->bio, iter, io_bio->iter) {
> +		unsigned int i, nr_sectors, pgoff;
>  		nr_sectors = BTRFS_BYTES_TO_BLKS(fs_info, bvec.bv_len);
>  		pgoff = bvec.bv_offset;
<snip>
> +		for (i = 0; i < nr_sectors; i++) {
>  			ASSERT(pgoff < PAGE_SIZE);
<snip>
> +			if (uptodate &&
> +			    (!csum || !check_data_csum(inode, io_bio, icsum,
> +						       bvec.bv_page, pgoff,
> +						       start, sectorsize))) {
> +				clean_io_failure(fs_info, failure_tree, io_tree,
> +						 start, bvec.bv_page,
> +						 btrfs_ino(BTRFS_I(inode)),
> +						 pgoff);

Why do you have to call clean_io_failure in case there isn't a failure
since that function:

a) Will return because the tree is empty altogether (count_range_bits
returns 0).

b) Or if there was a corruption a different segment - get_state_failrec
would return -ENOENT.

Can't this be reworked to:

if (!uptodate || (csum && check_data_csum)) {
dio_read_error
}

> +			} else {
> +				blk_status_t status;
> +
> +				status = dio_read_error(inode, &io_bio->bio,
> +							bvec.bv_page, pgoff,
> +							start,
> +							start + sectorsize - 1,
> +							io_bio->mirror_num);
> +				if (status)
> +					err = status;
> +			}
> +			start += sectorsize;
> +			icsum++;
>  			pgoff += sectorsize;
> -			ASSERT(pgoff < PAGE_SIZE);
> -			goto next_block;
>  		}
>  	}
> -
>  	return err;
>  }

<snip>
