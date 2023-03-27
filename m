Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93A46C9A49
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Mar 2023 05:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjC0DlD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 26 Mar 2023 23:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjC0DlC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 26 Mar 2023 23:41:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507074C05
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Mar 2023 20:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RsG9BlhLL9TyDviFNFxF89mDLDcC1MCtzlJrd1zBPFI=; b=lwGT7Zaj6RSeRx5wadNNPsRbfc
        fjOMkrHG2Q04xxcQ4H8lzFvlcXwAWx+G0hu1XP7+355rfPgCPXGvVmvyBrxfX8zoqe7CO6/QeqYHO
        1tXhBq1+Q7TIY026Oho6+c1efZEL1t8KLh22II2ddDY6UuUYdUZUSUs0BNMwUvC9VINUWrwzpqpYB
        RdtBFrqfJM0R6D9deTWemjxvrzFhAkjg4Bfo3HGI24Oat6wyLAAZI5EkbrAFJXDXQrGVvkS7k7VaZ
        3JHn9Z7NZnrPdjbyWfZdQgiPlxif6PFaCh/BvN8WFKvuKCInMR2ooHuqj5fhwLkx4HFyrvEssXJdB
        Nxi2zMdQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pgdjB-009gFP-0O;
        Mon, 27 Mar 2023 03:41:01 +0000
Date:   Sun, 26 Mar 2023 20:41:01 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v4 01/13] btrfs: scrub: use dedicated super block
 verification function to scrub one super block
Message-ID: <ZCEQTSDNOsCH/+ua@infradead.org>
References: <cover.1679826088.git.wqu@suse.com>
 <7e5544dfc26a6d0673dde60e07b1ef3bc91b98a3.1679826088.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e5544dfc26a6d0673dde60e07b1ef3bc91b98a3.1679826088.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 26, 2023 at 07:06:30PM +0800, Qu Wenruo wrote:
> There is really no need to go through the super complex scrub_sectors()
> to just handle super blocks.
> 
> This patch will introduce a dedicated function (less than 50 lines) to
> handle super block scrubing.
> 
> This new function will introduce a behavior change, instead of using the
> complex but concurrent scrub_bio system, here we just go
> submit-and-wait.
> 
> There is really not much sense to care the performance of super block
> scrubbing. It only has 3 super blocks at most, and they are all scattered
> around the devices already.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/scrub.c | 54 +++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 46 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 3cdf73277e7e..e765eb8b8bcf 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -4243,18 +4243,59 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
>  	return ret;
>  }
>  
> +static int scrub_one_super(struct scrub_ctx *sctx, struct btrfs_device *dev,
> +			   struct page *page, u64 physical, u64 generation)
> +{
> +	struct btrfs_fs_info *fs_info = sctx->fs_info;
> +	struct bio_vec bvec;
> +	struct bio bio;
> +	struct btrfs_super_block *sb = page_address(page);
> +	int ret;
> +
> +	bio_init(&bio, dev->bdev, &bvec, 1, REQ_OP_READ);
> +	bio.bi_iter.bi_sector = physical >> SECTOR_SHIFT;
> +	bio_add_page(&bio, page, BTRFS_SUPER_INFO_SIZE, 0);

bio_add_page wants its return value checked.  Now here we obviously
don't need that, but please just use __bio_add_page which has the
proper assert for that.
