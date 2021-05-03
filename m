Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C77371E16
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 May 2021 19:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbhECRKS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 May 2021 13:10:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:53838 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234101AbhECRIY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 May 2021 13:08:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DB0DCAEEE;
        Mon,  3 May 2021 17:07:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7BDD6DA7AA; Mon,  3 May 2021 19:05:04 +0200 (CEST)
Date:   Mon, 3 May 2021 19:05:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 1/4] btrfs: remove the dead branch in
 btrfs_io_needs_validation()
Message-ID: <20210503170504.GN7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210503020856.93333-1-wqu@suse.com>
 <20210503020856.93333-2-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210503020856.93333-2-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 03, 2021 at 10:08:53AM +0800, Qu Wenruo wrote:
> In function btrfs_io_needs_validation() we are ensured to get a
> non-cloned bio.
> The only caller, end_bio_extent_readpage(), already has an ASSERT() to
> make sure we only get non-cloned bios.
> 
> Thus the (bio_flagged(bio, BIO_CLONED)) branch will never get executed.
> 
> Remove the dead branch and updated the comment.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c | 29 +++++++----------------------
>  1 file changed, 7 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 14ab11381d49..0787fae5f7f1 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2644,8 +2644,10 @@ static bool btrfs_check_repairable(struct inode *inode, bool needs_validation,
>  
>  static bool btrfs_io_needs_validation(struct inode *inode, struct bio *bio)
>  {
> +	struct bio_vec *bvec;
>  	u64 len = 0;
>  	const u32 blocksize = inode->i_sb->s_blocksize;
> +	int i;
>  
>  	/*
>  	 * If bi_status is BLK_STS_OK, then this was a checksum error, not an
> @@ -2669,30 +2671,13 @@ static bool btrfs_io_needs_validation(struct inode *inode, struct bio *bio)
>  	if (blocksize < PAGE_SIZE)
>  		return false;
>  	/*
> -	 * We need to validate each sector individually if the failed I/O was
> -	 * for multiple sectors.
> -	 *
> -	 * There are a few possible bios that can end up here:
> -	 * 1. A buffered read bio, which is not cloned.
> -	 * 2. A direct I/O read bio, which is cloned.

Ok, so the cloned bio was expected only due to direct io but now it's
done via iomap so it makes sense to simplify it.

> -	 * 3. A (buffered or direct) repair bio, which is not cloned.
> -	 *
> -	 * For cloned bios (case 2), we can get the size from
> -	 * btrfs_io_bio->iter; for non-cloned bios (cases 1 and 3), we can get
> -	 * it from the bvecs.
> +	 * We're ensured we won't get cloned bio in end_bio_extent_readpage(),
> +	 * thus we can get the length from the bvecs.
>  	 */
> -	if (bio_flagged(bio, BIO_CLONED)) {
> -		if (btrfs_io_bio(bio)->iter.bi_size > blocksize)
> +	bio_for_each_bvec_all(bvec, bio, i) {
> +		len += bvec->bv_len;
> +		if (len > blocksize)
>  			return true;
> -	} else {
> -		struct bio_vec *bvec;
> -		int i;
> -
> -		bio_for_each_bvec_all(bvec, bio, i) {
> -			len += bvec->bv_len;
> -			if (len > blocksize)
> -				return true;
> -		}
>  	}
>  	return false;
>  }
> -- 
> 2.31.1
