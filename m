Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF13B18AECC
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Mar 2020 09:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgCSIx3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Mar 2020 04:53:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:36028 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgCSIx3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Mar 2020 04:53:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 01869B11F;
        Thu, 19 Mar 2020 08:53:23 +0000 (UTC)
Subject: Re: [PATCH 15/15] btrfs: unify buffered and direct I/O read repair
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Christoph Hellwig <hch@lst.de>
References: <cover.1583789410.git.osandov@fb.com>
 <7c593decda73deb58515d94e979db6a68527970b.1583789410.git.osandov@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <37bf11cc-92b3-2b15-ee87-0cbe8c662cc7@suse.com>
Date:   Thu, 19 Mar 2020 10:53:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <7c593decda73deb58515d94e979db6a68527970b.1583789410.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 9.03.20 г. 23:32 ч., Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Currently, direct I/O has its own versions of bio_readpage_error() and
> btrfs_check_repairable() (dio_read_error() and
> btrfs_check_dio_repairable(), respectively). The main difference is that
> the direct I/O version doesn't do read validation. The rework of direct
> I/O repair makes it possible to do validation, so we can get rid of
> btrfs_check_dio_repairable() and combine bio_readpage_error() and
> dio_read_error() into a new helper, btrfs_submit_read_repair().
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  fs/btrfs/extent_io.c | 126 +++++++++++++++++++------------------------
>  fs/btrfs/extent_io.h |  17 +++---
>  fs/btrfs/inode.c     | 103 ++++-------------------------------
>  3 files changed, 76 insertions(+), 170 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index fad86ef4d09d..a5cbe04da803 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c

<snip>

> -/*
> - * This is a generic handler for readpage errors. If other copies exist, read
> - * those and write back good data to the failed position. Does not investigate
> - * in remapping the failed extent elsewhere, hoping the device will be smart
> - * enough to do this as needed
> - */
> -static int bio_readpage_error(struct bio *failed_bio, u64 phy_offset,
> -			      struct page *page, u64 start, u64 end,
> -			      int failed_mirror)
> +blk_status_t btrfs_submit_read_repair(struct inode *inode,
> +				      struct bio *failed_bio, u64 phy_offset,
> +				      struct page *page, unsigned int pgoff,
> +				      u64 start, u64 end, int failed_mirror,
> +				      submit_bio_hook_t *submit_bio_hook)
>  {
>  	struct io_failure_record *failrec;
> -	struct inode *inode = page->mapping->host;
> +	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>  	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
>  	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
> +	struct btrfs_io_bio *failed_io_bio = btrfs_io_bio(failed_bio);
> +	struct btrfs_io_bio *io_bio;
> +	int icsum = phy_offset >> inode->i_sb->s_blocksize_bits;
>  	bool need_validation = false;
>  	struct bio *bio;
> -	int read_mode = 0;
>  	blk_status_t status;
>  	int ret;
>  
> +	btrfs_info(btrfs_sb(inode->i_sb),
> +		   "Repair Read Error: read error at %llu", start);
> +
>  	BUG_ON(bio_op(failed_bio) == REQ_OP_WRITE);
>  
>  	ret = btrfs_get_io_failure_record(inode, start, end, &failrec);
>  	if (ret)
> -		return ret;
> +		return errno_to_blk_status(ret);
>  
>  	/*
>  	 * If there was an I/O error and the I/O was for multiple sectors, we
>  	 * need to validate each sector individually.
>  	 */
>  	if (failed_bio->bi_status != BLK_STS_OK) {

Is this correct though, in case of buffered reads we are always called
with bi_status != BLK_STS_OK (we are called from end_bio_extent_readpage
in case uptodate is false,  which happens if failed_bio->bi_status is
non-zero. Additionally the bio is guaranteed to not be cloned because
there is : ASSERT(!bio_flagged(bio, BIO_CLONED));

The end effect of all of this is in case of buffered bios we never set
need_revalidate, is this intentional?

> -		u64 len = 0;
> -		int i;
> -
> -		for (i = 0; i < failed_bio->bi_vcnt; i++) {
> -			len += failed_bio->bi_io_vec[i].bv_len;
> -			if (len > inode->i_sb->s_blocksize) {
> +		if (bio_flagged(failed_bio, BIO_CLONED)) {

If I understand this correctly this is the "this is a DIO " branch. IMO
it'd be clearer if you had bool is_dio = bio_flagged(failed_bio,
BIO_CLONED) at the top of the function and you used that.

> +			if (failed_io_bio->iter.bi_size >
> +			    inode->i_sb->s_blocksize)
>  				need_validation = true;
> -				break;
> +		} else {

This branch will only ever be executed in case of DIO with csum failure.
So either add a comment to demarcate when various leaves of the 2 'if'
should be called or, and I think this would be the better solution,
rewrite it.
> +			u64 len = 0;
> +			int i;
> +
> +			for (i = 0; i < failed_bio->bi_vcnt; i++) {
> +				len += failed_bio->bi_io_vec[i].bv_len;
> +				if (len > inode->i_sb->s_blocksize) {
> +					need_validation = true;
> +					break;
> +				}
>  			}


>  		}
>  	}
> @@ -2674,32 +2646,41 @@ static int bio_readpage_error(struct bio *failed_bio, u64 phy_offset,
>  	if (!btrfs_check_repairable(inode, need_validation, failrec,
>  				    failed_mirror)) {
>  		free_io_failure(failure_tree, tree, failrec);
> -		return -EIO;
> +		return BLK_STS_IOERR;
>  	}
>  
> +	bio = btrfs_io_bio_alloc(1);
> +	io_bio = btrfs_io_bio(bio);
> +	bio->bi_opf = REQ_OP_READ;
>  	if (need_validation)
> -		read_mode |= REQ_FAILFAST_DEV;
> +		bio->bi_opf |= REQ_FAILFAST_DEV;
> +	bio->bi_end_io = failed_bio->bi_end_io;
> +	bio->bi_iter.bi_sector = failrec->logical >> 9;
> +	bio->bi_private = failed_bio->bi_private;
nit: I'd rather have this named as repair_bio, right now the function has:

failed_bio, failed_io_bio and simply bio. But in fact the latter is a
repair bio derived from the io_failured_record.
>  
> -	phy_offset >>= inode->i_sb->s_blocksize_bits;
> -	bio = btrfs_create_repair_bio(inode, failed_bio, failrec, page,
> -				      start - page_offset(page),
> -				      (int)phy_offset, failed_bio->bi_end_io,
> -				      NULL);
> -	bio->bi_opf = REQ_OP_READ | read_mode;
> +	if (failed_io_bio->csum) {
> +		u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
> +
> +		io_bio->csum = io_bio->csum_inline;
> +		memcpy(io_bio->csum, failed_io_bio->csum + csum_size * icsum,
> +		       csum_size);
> +	}
> +
> +	bio_add_page(bio, page, failrec->len, pgoff);
> +	io_bio->logical = failrec->start;
> +	io_bio->iter = bio->bi_iter;
>  
>  	btrfs_debug(btrfs_sb(inode->i_sb),
> -		"Repair Read Error: submitting new read[%#x] to this_mirror=%d, in_validation=%d",
> -		read_mode, failrec->this_mirror, failrec->in_validation);
> +"Repair Read Error: submitting new read to this_mirror=%d, in_validation=%d",
> +		    failrec->this_mirror, failrec->in_validation);
>  
> -	status = tree->ops->submit_bio_hook(tree->private_data, bio, failrec->this_mirror,
> -					 failrec->bio_flags);
> +	status = submit_bio_hook(inode, bio, failrec->this_mirror,
> +				 failrec->bio_flags);
>  	if (status) {
>  		free_io_failure(failure_tree, tree, failrec);
>  		bio_put(bio);
> -		ret = blk_status_to_errno(status);
>  	}
> -
> -	return ret;
> +	return status;
>  }
>  
>  /* lots and lots of room for performance fixes in the end_bio funcs */

<snip>

> 
