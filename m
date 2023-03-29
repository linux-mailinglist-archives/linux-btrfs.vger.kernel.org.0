Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703356CF73B
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Mar 2023 01:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjC2Xcw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Mar 2023 19:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjC2Xcv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Mar 2023 19:32:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B488C3C20
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 16:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nPIOfeAdj2StRhBoff9573fnPIJRkdRTefWEjBaHSSo=; b=wWqwNey03IokRvFJ/xNhSN0zw8
        KdiA9p7ANKUu4LWjICiqHHPl+s0NczipiHu1v6/VEYjtvkqrHYnDCPkHoQGFbBClpoZeDj6lXtAgJ
        IfjfRnUL5SnT8T8zociDK/bN5pDFlZiIa3myG+GkB3SLluBL+fioJDYXUfm/qN8jsMW+EHSpVbcRo
        PRDTa5+NfF9aHy7nsWXy9hr+RUIwjNlDygjZc2qAmzvcLPCQpwbLD80smr+lDVr7FEOExDvMmsUbd
        8Nrhak4pDaw4Y8qLERKMRb7HrJk0wnSWRatjQRe+LMAJGnrH01uDBkwADpE9Aj7HpSbivxO+n0hI/
        igSpuiFQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1phfHe-0024FZ-1g;
        Wed, 29 Mar 2023 23:32:50 +0000
Date:   Wed, 29 Mar 2023 16:32:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v7 02/13] btrfs: introduce a new allocator for scrub
 specific btrfs_bio
Message-ID: <ZCTKola6a+tbtyrL@infradead.org>
References: <cover.1680047473.git.wqu@suse.com>
 <c77fd4fd93c34a6d229765088ce0a88f7f8718d4.1680047473.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c77fd4fd93c34a6d229765088ce0a88f7f8718d4.1680047473.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> +struct btrfs_bio *btrfs_scrub_bio_alloc(blk_opf_t opf,
> +					struct btrfs_fs_info *fs_info,
> +					btrfs_bio_end_io_t end_io, void *private)
> +{
> +	struct btrfs_bio *bbio;
> +	struct bio *bio;
> +
> +	bio = bio_alloc_bioset(NULL, BTRFS_STRIPE_LEN >> fs_info->sectorsize_bits,
> +			       opf, GFP_NOFS, &btrfs_bioset);
> +	bbio = btrfs_bio(bio);
> +	memset(bbio, 0, offsetof(struct btrfs_bio, bio));
> +	bbio->fs_info = fs_info;
> +	bbio->end_io = end_io;
> +	bbio->private = private;
> +	atomic_set(&bbio->pending_ios, 1);
> +	return bbio;

As mentioned in the last round, I'm not too happy with this.  With
the inode and file_offset being optional now we might as well drop them
as arguments from btrfs_bio_alloc/btrfs_bio_init and just pass a nr_vecs
instead and make this new allocator obsolete, and it would be a much
better result.

I'd prefer to just do it now rather than doing another series changing
it a little later.

> +	/*
> +	 * Inode and offset into it that this I/O operates on.
> +	 *
> +	 * @inode can be NULL for callers who don't want any advanced features
> +	 * like read-time repair.
> +	 */
>  	struct btrfs_inode *inode;
>  	u64 file_offset;

I don't think these negative comments are nice for the reader.  I'd do:

	/*
	 * Inode and offset into it that this I/O operates on.
	 * Only set for data I/O.
	 */

> +	/*
> +	 * For cases where callers only want to read/write from a logical
> +	 * bytenr, in that case @inode can be NULL, and we need such
> +	 * @fs_info pointer to grab the corresponding fs_info.
> +	 *
> +	 * Should always be populated.
> +	 */
> +	struct btrfs_fs_info *fs_info;

Again here, this comment only makes sense for people following the
development history of this particular patch series.  Once that is in
the reason why people use an inode before is irrelevant.  The only
useful bit left here is that it must always be populated, but I'm not
even sure I'd add that.  So all we might need is:

	/* File system that this I/O operates on. */

What would be good in this patch is to replace the
existing bbio->inode->root->fs_info dereferences with bbio->fs_info
ASAP, though.
