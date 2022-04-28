Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0B9513557
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 15:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347432AbiD1Nk4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 09:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347436AbiD1Nkv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 09:40:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34D8B368C
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 06:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oylcV2gN21U3Dea7FQaCb52yBaysIcU/7QsglR4IYsI=; b=JtKT40JZiVbN9hFEbFOYSHbFSS
        rfrrKBry6AYMKYv/IY03dLWBEU6nAEHm4npjAF+8PqR5OIRffbKNiLTWo15UvfkYnjcEMFoRX+1ta
        1BFqUrZJWHqHj19xMZWwVsa63Hn7uFApdmPIV9N0c03zQsm3lqy+y/xjmgQXbOUmB1/2U73Kyalei
        jL7yWwYhpI5T4mc45srRVRuHhX8EncYgj/6vl9ZgV69kLW2LsBWcrWIkt1GtDfG5d56IKwHrganmz
        Cwe0ZfRhDCpciXtOTL4JpaFYVmGLfTsl1KFpxvdJFxnWtbtjWCl6r1WdDEfyFRLTgDdVYssWacq/3
        hXQPVn9Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nk4Kp-00771Q-9f; Thu, 28 Apr 2022 13:37:31 +0000
Date:   Thu, 28 Apr 2022 06:37:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC v2 04/12] btrfs: add btrfs_read_repair_ctrl to record
 corrupted sectors
Message-ID: <YmqYm+iFDSRTbV5W@infradead.org>
References: <cover.1651043617.git.wqu@suse.com>
 <ad61ab273c5f591cb4963f348c4b34302f705705.1651043617.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad61ab273c5f591cb4963f348c4b34302f705705.1651043617.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 27, 2022 at 03:18:50PM +0800, Qu Wenruo wrote:
> Currently we only allocate two bitmaps and initialize various members,
> no real work done yet.

I'm rather worried about these allocations.  These are called from
the I/O completion work queues, which can be rather deadlock heavy.
Never mind that just failing an I/O repair/recovery when we are out
of memory seems like a rather bad idea.

> +	if (!ctrl->initialized) {

I don't think you need the initialize field.  Just check for
failed_bio being non-NULL to simplify this.

> +		const u32 sectorsize = fs_info->sectorsize;
> +
> +		ASSERT(ctrl->cur_bad_bitmap == NULL &&
> +		       ctrl->prev_bad_bitmap == NULL);
> +		/*
> +		 * failed_bio->bi_iter is not reliable at endio time, thus we
> +		 * must rely on btrfs_bio::iter to grab the original logical
> +		 * bytenr.
> +		 */
> +		ASSERT(btrfs_bio(failed_bio)->iter.bi_size);

Also things would be lot more readable if the code inside this branch
just moved into a helper that you call if ->failed_bio is not set.

> +		ctrl->cur_bad_bitmap = bitmap_alloc(ctrl->bio_size >>
> +					fs_info->sectorsize_bits, GFP_NOFS);
> +		ctrl->prev_bad_bitmap = bitmap_alloc(ctrl->bio_size >>
> +					fs_info->sectorsize_bits, GFP_NOFS);
> +		/* Just set the error bit, so we will never try repair */
> +		if (!ctrl->cur_bad_bitmap || !ctrl->prev_bad_bitmap) {
> +			kfree(ctrl->cur_bad_bitmap);
> +			kfree(ctrl->prev_bad_bitmap);
> +			ctrl->cur_bad_bitmap = NULL;
> +			ctrl->prev_bad_bitmap = NULL;
> +			ctrl->error = true;
> +		}

I don't think we need the extra error value either, you can just check
one of the bitmap pointers for NULL.  That being said, as mentioned
above I'm really worried about these huge allocations that can fail.
I think we need a mempool of some fixed size here and use that, and just
change the algorithm to work in chunks based on this upper bound.

> +/* Strucutre for data read time repair. */
> +struct btrfs_read_repair_ctrl {

Can we keep that structure private?  Based on the rest of the series
there actually is a fair amount of code using it, what about isolating
it in a new read_repair.c instead of in the giant extent_io.c and
inode.c files?
