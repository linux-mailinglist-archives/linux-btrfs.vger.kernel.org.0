Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FB9591949
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Aug 2022 09:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiHMHjP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Aug 2022 03:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiHMHjO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Aug 2022 03:39:14 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AD39568F
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Aug 2022 00:39:13 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 11D4868AA6; Sat, 13 Aug 2022 09:39:10 +0200 (CEST)
Date:   Sat, 13 Aug 2022 09:39:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] btrfs: don't merge pages into bio if their page offset
 is not continuous
Message-ID: <20220813073909.GA11586@lst.de>
References: <8641e5e791942d86de0a1b3ee120570441616fdc.1660375698.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8641e5e791942d86de0a1b3ee120570441616fdc.1660375698.git.wqu@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> +	if (bio_ctrl->compress_type != BTRFS_COMPRESS_NONE) {
>  		contig = bio->bi_iter.bi_sector == sector;
> -	else
> -		contig = bio_end_sector(bio) == sector;
> +	} else {

I don't tink we can lose the bio_end_sector check here.

Also if you touch this, invrting the check so that it is

	if (bio_ctrl->compress_type == BTRFS_COMPRESS_NONE) {
		/* main version here */
	} else {
		/* compressed special case */
	}

might make it a bit readable.

> +		struct bio_vec *bvec;
> +
> +		/* Empty bio, we can always add page into it. */
> +		if (bio->bi_iter.bi_size == 0) {

This is also true for the compressed case, isn't it?

So maybe:

	if (bio->bi_iter.bi_size == 0) {
		contig = true;
	} else if (bio_ctrl->compress_type == BTRFS_COMPRESS_NONE) {
		struct bio_vec *bvec = bio_last_bvec_all(bio);

		/*
		 * The contig check requires the following conditions to be met:
		 * 1) The pages are belonging to the same inode
		 * 2) The range has adjacent logical bytenr
		 * 3) The range has adjacent file offset (NEW)
		 *    This is required for the usage of btrfs_bio->file_offset.
		 */
		contig = bio_end_sector(bio) == sector &&
			    page_offset(bvec->bv_page) + bvec->bv_offset +
			    bvec->bv_len == page_offset(page) + pg_offset);
	} else {
		contig = bio->bi_iter.bi_sector == sector;
	}

(we don't need the mapping check, as all the submit_extent_page
always loops over the same mapping)
