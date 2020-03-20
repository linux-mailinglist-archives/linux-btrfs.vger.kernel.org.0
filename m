Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 653E318DA1D
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Mar 2020 22:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgCTV22 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Mar 2020 17:28:28 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33732 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgCTV21 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Mar 2020 17:28:27 -0400
Received: by mail-pl1-f193.google.com with SMTP id g18so3058261plq.0
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Mar 2020 14:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=q8tMbuJA1VnuK3Ey2P2gansHoN29WmbAOWI3pSgiJms=;
        b=aIF8iJQpIF+egvAxNDDhibPNSvP13Ff1HSuWJLcs3Wupl8qSE06jfoaBe+NmneB53o
         veNIGgv8EZRwIJCyT2UFAYHTtg4QT9Zt56Y5QUaDNtCgmYWRogKRaMrWuWphrqcEV2BZ
         5wPPPrIZH/8aWmFHgSBd5ITmBpHD7W+QKKNM+MCDUlB8LsbXbDxDRoVI8fJRC9Gu388o
         E3OjwFNPmpkeZXkypztSRjUceq87wA5F0YkmFn0QOIXNYbVhIAcR8MmZmo7uxwQw8hqp
         I3oUv/iHUE8BRqeOPXP0L/846ld6dK4ccfg/Ny+9iW/DS02CQPWVj2MC0CYIaX5VqjDN
         Tmpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=q8tMbuJA1VnuK3Ey2P2gansHoN29WmbAOWI3pSgiJms=;
        b=Ts4NaPcuSo/ajAM9nLKQFjhupajEjiNnrvoMkxXZAeij+TGF361QjfLdu5tJlWn83N
         gSj4YYyyd62a7fRGNlbDO5bv0u3YBUL723ZQnD4mIZKId5b3/kr7/T4/iouQxMYpTSMC
         bdV3US3iKJ1Z4hHzJe07xCeBF0SHdA4WvHcGquhgkUJelTV6pqFtfqJwCcRgRvtiTF8k
         cdTVf6T9dnoRrUFvJKboqGzHcBKWYJq71oMxDj9CNEl69tQ5Cj7FbWciD432XK4vbpuj
         Ymz/T1w+IObb/glwmCIZ3s5dInO2IDDbt/dRD5/tVJmiNyaJG/qYa5zUHcYm2Y3DsmuT
         Nr0g==
X-Gm-Message-State: ANhLgQ2PDjCgDRlvWc+PagqxFl30VupB5xZy7aw5LyRi2zvk1nEcntRU
        4d4qMnBZ2r3mfvXokYFIz6Pb2Q==
X-Google-Smtp-Source: ADFU+vsSsAJELJv2ovCQpxuUZpUieMyLCf4aYrXoErTXfQsjMWF6WUFraIAOB/hYtWIOKoAks1/udQ==
X-Received: by 2002:a17:902:eb11:: with SMTP id l17mr10146844plb.52.1584739704555;
        Fri, 20 Mar 2020 14:28:24 -0700 (PDT)
Received: from vader ([2620:10d:c090:400::5:c783])
        by smtp.gmail.com with ESMTPSA id 6sm6264129pfx.69.2020.03.20.14.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 14:28:24 -0700 (PDT)
Date:   Fri, 20 Mar 2020 14:28:22 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 15/15] btrfs: unify buffered and direct I/O read repair
Message-ID: <20200320212822.GD32817@vader>
References: <cover.1583789410.git.osandov@fb.com>
 <7c593decda73deb58515d94e979db6a68527970b.1583789410.git.osandov@fb.com>
 <37bf11cc-92b3-2b15-ee87-0cbe8c662cc7@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37bf11cc-92b3-2b15-ee87-0cbe8c662cc7@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 19, 2020 at 10:53:22AM +0200, Nikolay Borisov wrote:
> 
> 
> On 9.03.20 г. 23:32 ч., Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > Currently, direct I/O has its own versions of bio_readpage_error() and
> > btrfs_check_repairable() (dio_read_error() and
> > btrfs_check_dio_repairable(), respectively). The main difference is that
> > the direct I/O version doesn't do read validation. The rework of direct
> > I/O repair makes it possible to do validation, so we can get rid of
> > btrfs_check_dio_repairable() and combine bio_readpage_error() and
> > dio_read_error() into a new helper, btrfs_submit_read_repair().
> > 
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> >  fs/btrfs/extent_io.c | 126 +++++++++++++++++++------------------------
> >  fs/btrfs/extent_io.h |  17 +++---
> >  fs/btrfs/inode.c     | 103 ++++-------------------------------
> >  3 files changed, 76 insertions(+), 170 deletions(-)
> > 
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index fad86ef4d09d..a5cbe04da803 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> 
> <snip>
> 
> > -/*
> > - * This is a generic handler for readpage errors. If other copies exist, read
> > - * those and write back good data to the failed position. Does not investigate
> > - * in remapping the failed extent elsewhere, hoping the device will be smart
> > - * enough to do this as needed
> > - */
> > -static int bio_readpage_error(struct bio *failed_bio, u64 phy_offset,
> > -			      struct page *page, u64 start, u64 end,
> > -			      int failed_mirror)
> > +blk_status_t btrfs_submit_read_repair(struct inode *inode,
> > +				      struct bio *failed_bio, u64 phy_offset,
> > +				      struct page *page, unsigned int pgoff,
> > +				      u64 start, u64 end, int failed_mirror,
> > +				      submit_bio_hook_t *submit_bio_hook)
> >  {
> >  	struct io_failure_record *failrec;
> > -	struct inode *inode = page->mapping->host;
> > +	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> >  	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
> >  	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
> > +	struct btrfs_io_bio *failed_io_bio = btrfs_io_bio(failed_bio);
> > +	struct btrfs_io_bio *io_bio;
> > +	int icsum = phy_offset >> inode->i_sb->s_blocksize_bits;
> >  	bool need_validation = false;
> >  	struct bio *bio;
> > -	int read_mode = 0;
> >  	blk_status_t status;
> >  	int ret;
> >  
> > +	btrfs_info(btrfs_sb(inode->i_sb),
> > +		   "Repair Read Error: read error at %llu", start);
> > +
> >  	BUG_ON(bio_op(failed_bio) == REQ_OP_WRITE);
> >  
> >  	ret = btrfs_get_io_failure_record(inode, start, end, &failrec);
> >  	if (ret)
> > -		return ret;
> > +		return errno_to_blk_status(ret);
> >  
> >  	/*
> >  	 * If there was an I/O error and the I/O was for multiple sectors, we
> >  	 * need to validate each sector individually.
> >  	 */
> >  	if (failed_bio->bi_status != BLK_STS_OK) {
> 
> Is this correct though, in case of buffered reads we are always called
> with bi_status != BLK_STS_OK (we are called from end_bio_extent_readpage
> in case uptodate is false,  which happens if failed_bio->bi_status is
> non-zero. Additionally the bio is guaranteed to not be cloned because
> there is : ASSERT(!bio_flagged(bio, BIO_CLONED));
> 
> The end effect of all of this is in case of buffered bios we never set
> need_revalidate, is this intentional?

For buffered I/O, this is called when bi_status != BLK_STS_OK OR
readpage_end_io_hook (i.e., check_data_csum()) failed. This check
distinguishes between those two cases: if we didn't hit an I/O error
(bi_status == BLK_STS_OK), then we don't need validation, otherwise, we
need validation if the bio is more than one sector.

> > -		u64 len = 0;
> > -		int i;
> > -
> > -		for (i = 0; i < failed_bio->bi_vcnt; i++) {
> > -			len += failed_bio->bi_io_vec[i].bv_len;
> > -			if (len > inode->i_sb->s_blocksize) {
> > +		if (bio_flagged(failed_bio, BIO_CLONED)) {
> 
> If I understand this correctly this is the "this is a DIO " branch. IMO
> it'd be clearer if you had bool is_dio = bio_flagged(failed_bio,
> BIO_CLONED) at the top of the function and you used that.

Repair bios for direct I/O aren't cloned, so is_dio isn't accurate. IMO
it shouldn't matter whether it came from direct I/O or not. If it's a
cloned bio, you get the size out of io_bio->iter, and if it's not, you
get it out of bi_io_vec.

> > +			if (failed_io_bio->iter.bi_size >
> > +			    inode->i_sb->s_blocksize)
> >  				need_validation = true;
> > -				break;
> > +		} else {
> 
> This branch will only ever be executed in case of DIO with csum failure.
> So either add a comment to demarcate when various leaves of the 2 'if'
> should be called or, and I think this would be the better solution,
> rewrite it.

As commented above, this outer branch is for I/O errors (not checksum
errors), and this specific branch is for non-cloned bios, which happens
to be buffered read bios and buffered or direct I/O repair bios. Would
it be clearer as:

static u64 btrfs_bio_size(struct bio *bio)
{
	if (bio_flagged(bio, BIO_CLONED))
		return bio->iter.bi_size;
	else
		return bio_size_all(bio);
}

blk_status_t btrfs_submit_read_repair(...)
{
	...
	/*
	 * If there was an I/O error and the I/O was for multiple sectors, we
	 * need to validate each sector individually.
	 */
	need_validation = (failed_bio->bi_status != BLK_STS_OK &&
			   btrfs_bio_size() > inode->i_sb->s_blocksize);
	...
}
