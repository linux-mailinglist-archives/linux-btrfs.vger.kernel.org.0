Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A6C716CC3
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 May 2023 20:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjE3Sq1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 May 2023 14:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjE3Sq0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 May 2023 14:46:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BAFC9
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 11:46:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 518AD211BC;
        Tue, 30 May 2023 18:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685472380;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v/6+Csoxp9XRn66JGmH7iMAXogfOjLut9G+8BraR85E=;
        b=ccc6XbFQOScOCSEUOJBl+fDCkOJf+xiL6x3qoeV21oBfpLCtJFo82m/jAPcjLCS5OV0JPo
        pWHohlQ67PLcTW9eZogU+rn473K6VN0wkw0fngW/GS5oUG5giDrhTunoLssJge95cUetWn
        LH01EZM9Q6vVvRQsi2Wwd3ia6IOncQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685472380;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v/6+Csoxp9XRn66JGmH7iMAXogfOjLut9G+8BraR85E=;
        b=0KOWfLz1PGvXMEdzuVbI/VdBz25CAUvBTuORyoqeZrkiEyN34cRnwyEWhuB5qkQn+IOaWZ
        kK+FvSdJCiUeCfBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D263913597;
        Tue, 30 May 2023 18:46:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lHOgMXtEdmS6cwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 30 May 2023 18:46:19 +0000
Date:   Tue, 30 May 2023 20:40:08 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 13/14] btrfs: defer splitting of ordered extents until
 I/O completion
Message-ID: <20230530184008.GA32581@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230524150317.1767981-1-hch@lst.de>
 <20230524150317.1767981-14-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524150317.1767981-14-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 24, 2023 at 05:03:16PM +0200, Christoph Hellwig wrote:
> The btrfs zoned completion code currently needs an ordered_extent and
> extent_map per bio so that it can account for the non-predictable
> write location from Zone Append.  To archive that it currently splits
> the ordered_extent and extent_map at I/O submission time, and then
> records the actual physical address in the ->physical field of the
> ordered_extent.
> 
> This patch instead switches to record the "original" physical address
> that the btrfs allocator assigned in spare space in the btrfs_bio,
> and then rewrites the logical address in the btrfs_ordered_sum
> structure at I/O completion time.  This allows the ordered extent
> completion handler to simply walk the list of ordered csums and
> split the ordered extent as needed.  This removes an extra ordered
> extent and extent_map lookup and manipulation during the I/O
> submission path, and instead batches it in the I/O completion path
> where we need to touch these anyway.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/btrfs/bio.c          | 17 ------------
>  fs/btrfs/btrfs_inode.h  |  2 --
>  fs/btrfs/inode.c        | 18 ++++++++-----
>  fs/btrfs/ordered-data.h |  1 +
>  fs/btrfs/zoned.c        | 57 ++++++++++++++++++++++++++++++++++++-----
>  fs/btrfs/zoned.h        |  6 ++---
>  6 files changed, 65 insertions(+), 36 deletions(-)
> 
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 8a4d3b707dd1b2..ae6345668d2d01 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -61,20 +61,6 @@ struct btrfs_bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
>  	return bbio;
>  }
>  
> -static blk_status_t btrfs_bio_extract_ordered_extent(struct btrfs_bio *bbio)
> -{
> -	struct btrfs_ordered_extent *ordered;
> -	int ret;
> -
> -	ordered = btrfs_lookup_ordered_extent(bbio->inode, bbio->file_offset);
> -	if (WARN_ON_ONCE(!ordered))
> -		return BLK_STS_IOERR;
> -	ret = btrfs_extract_ordered_extent(bbio, ordered);
> -	btrfs_put_ordered_extent(ordered);
> -
> -	return errno_to_blk_status(ret);
> -}
> -
>  static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
>  					 struct btrfs_bio *orig_bbio,
>  					 u64 map_length, bool use_append)
> @@ -667,9 +653,6 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
>  		if (use_append) {
>  			bio->bi_opf &= ~REQ_OP_WRITE;
>  			bio->bi_opf |= REQ_OP_ZONE_APPEND;
> -			ret = btrfs_bio_extract_ordered_extent(bbio);
> -			if (ret)
> -				goto fail_put_bio;
>  		}
>  
>  		/*
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index 08c99602339408..8abf96cfea8fae 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -410,8 +410,6 @@ static inline bool btrfs_inode_can_compress(const struct btrfs_inode *inode)
>  
>  int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
>  			    u32 pgoff, u8 *csum, const u8 * const csum_expected);
> -int btrfs_extract_ordered_extent(struct btrfs_bio *bbio,
> -				 struct btrfs_ordered_extent *ordered);
>  bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
>  			u32 bio_offset, struct bio_vec *bv);
>  noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index cee71eaec7cff9..eee4eefb279780 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2714,8 +2714,8 @@ void btrfs_clear_delalloc_extent(struct btrfs_inode *inode,
>  	}
>  }
>  
> -int btrfs_extract_ordered_extent(struct btrfs_bio *bbio,
> -				 struct btrfs_ordered_extent *ordered)
> +static int btrfs_extract_ordered_extent(struct btrfs_bio *bbio,
> +					struct btrfs_ordered_extent *ordered)
>  {
>  	u64 start = (u64)bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT;
>  	u64 len = bbio->bio.bi_iter.bi_size;
> @@ -3180,7 +3180,7 @@ static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
>   * an ordered extent if the range of bytes in the file it covers are
>   * fully written.
>   */
> -void btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
> +void btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
>  {
>  	struct btrfs_inode *inode = BTRFS_I(ordered_extent->inode);
>  	struct btrfs_root *root = inode->root;
> @@ -3215,11 +3215,9 @@ void btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
>  		goto out;
>  	}
>  
> -	if (btrfs_is_zoned(fs_info)) {
> -		btrfs_rewrite_logical_zoned(ordered_extent);
> +	if (btrfs_is_zoned(fs_info))
>  		btrfs_zone_finish_endio(fs_info, ordered_extent->disk_bytenr,
>  					ordered_extent->disk_num_bytes);
> -	}
>  
>  	if (test_bit(BTRFS_ORDERED_TRUNCATED, &ordered_extent->flags)) {
>  		truncated = true;
> @@ -3385,6 +3383,14 @@ void btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
>  	btrfs_put_ordered_extent(ordered_extent);
>  }
>  
> +void btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered)
> +{
> +	if (btrfs_is_zoned(btrfs_sb(ordered->inode->i_sb)) &&
> +	    !test_bit(BTRFS_ORDERED_IOERR, &ordered->flags))
> +		btrfs_finish_ordered_zoned(ordered);
> +	btrfs_finish_one_ordered(ordered);

I've left out the void type change of btrfs_finish_ordered_io in the
previous patch so to keep the same semantics I've changed this back to
int so btrfs_finish_ordered_io forwards return value of
btrfs_finish_one_ordered(). This has no sigfnificant effect of the
patchset and I'd like to deal with the error handling separately.
