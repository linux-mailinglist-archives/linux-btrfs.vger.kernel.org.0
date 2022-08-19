Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FA459A4E0
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Aug 2022 20:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354626AbiHSRfS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Aug 2022 13:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354687AbiHSRes (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Aug 2022 13:34:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80F73CBFD
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Aug 2022 09:53:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFBE361899
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Aug 2022 16:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4B3C433C1;
        Fri, 19 Aug 2022 16:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660927819;
        bh=QCJq3dlz4OeOaniJxAatfqVTa+7Opl6ErQdm438J/44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h/xiP2zNgetAUEdyGj63KUB3qwRcejaS/UEbmtaBY/NBGh3cQdi+Ra7GF0KTGOZXI
         c4gQi66/ofPLZFQBR2RF9ijVFPGmL7qJnau5d1ADp/P3SAhSp9S4KlHiMsptnE8mTa
         i2rc3vrjtJXwHjw5qkhO9BWOnMi2SgQD1F8ZGsnfPQ2KnZMN99z1qWIyLIxnGPe0I4
         Pbeh8Bc/iTac0vnRdctoX6AL7fwFagA9DQBrjm4zbZbnxIyb2GroNiIL7gkfax0HPN
         rwXnouazXKVC/bFVejhJ3EPOp0WXARhjEm9IMjN5PikvI2lGu1hiUUz9XDwLJe4cI5
         Hjx3iP5I7iG2A==
Date:   Fri, 19 Aug 2022 17:50:16 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dylan Yudaken <dylany@fb.com>
Subject: Re: [PATCH] btrfs: don't allow large NOWAIT direct reads
Message-ID: <20220819165016.GB3012163@falcondesktop>
References: <882730e60b58b8d970bd8bc3a670e598184eefef.1660924379.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <882730e60b58b8d970bd8bc3a670e598184eefef.1660924379.git.josef@toxicpanda.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 19, 2022 at 11:53:39AM -0400, Josef Bacik wrote:
> Dylan and Jens reported a problem where they had an io_uring test that
> was returning short reads, and bisected it to ee5b46a353af ("btrfs:
> increase direct io read size limit to 256 sectors").
> 
> The root cause is their test was doing larger reads via io_uring with
> NOWAIT and async.  This was triggering a page fault during the direct
> read, however the first page was able to work just fine and thus we
> submitted a 4k read for a larger iocb.
> 
> Btrfs allows for partial IO's in this case specifically because we don't
> allow page faults, and thus we'll attempt to do any io that we can,
> submit what we could, come back and fault in the rest of the range and
> try to do the remaining IO.
> 
> However for !is_sync_kiocb() we'll call ->ki_complete() as soon as the
> partial dio is done, which is incorrect.  In the sync case we can exit
> the iomap code, submit more io's, and return with the amount of IO we
> were able to complete successfully.
> 
> We were always doing short reads in this case, but for NOWAIT we were
> getting saved by the fact that we were limiting direct reads to
> sectorsize, and if we were larger than that we would return EAGAIN.
> 
> Fix the regression by simply returning EAGAIN in the NOWAIT case with
> larger reads, that way io_uring can retry and get the larger IO and have
> the fault logic handle everything properly.
> 
> This still leaves the AIO short read case, but that existed before this
> change.  The way to properly fix this would be to handle partial iocb
> completions, but that's a lot of work, for now deal with the regression
> in the most straightforward way possible.
> 
> Reported-by: Dylan Yudaken <dylany@fb.com>
> Fixes: ee5b46a353af ("btrfs: increase direct io read size limit to 256 sectors")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/inode.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 5101111c5557..b39673e49732 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7694,6 +7694,20 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
>  	const u64 data_alloc_len = length;
>  	bool unlock_extents = false;
>  
> +	/*
> +	 * We could potentially fault if we have a buffer > PAGE_SIZE, and if
> +	 * we're NOWAIT we may submit a bio for a partial range and return
> +	 * EIOCBQUEUED, which would result in an errant short read.
> +	 *
> +	 * The best way to handle this would be to allow for partial completions
> +	 * of iocb's, so we could submit the partial bio, return and fault in
> +	 * the rest of the pages, and then submit the io for the rest of the
> +	 * range.  However we don't have that currently, so simply return
> +	 * -EAGAIN at this point so that the normal path is used.
> +	 */
> +	if (!write && (flags & IOMAP_NOWAIT) && length > PAGE_SIZE)
> +		return -EAGAIN;
> +
>  	/*
>  	 * Cap the size of reads to that usually seen in buffered I/O as we need
>  	 * to allocate a contiguous array for the checksums.
> -- 
> 2.26.3
> 
