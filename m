Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F2876DCF8
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Aug 2023 03:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjHCBBl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Aug 2023 21:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjHCBBj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Aug 2023 21:01:39 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E92011F
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Aug 2023 18:01:38 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 5443832001FF;
        Wed,  2 Aug 2023 21:01:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 02 Aug 2023 21:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1691024496; x=1691110896; bh=BZ
        U0byHrawYDPd4TYfypnzLPkuDmb23imLp3KKpZ10o=; b=EgLBCDYrTb4KkeqFpn
        OIaGk1kMYI+1+a7OG2Q1SS8PQo3cnUmdYOqcXaaHCTXOxG1GAzEa5/Wp5Ns1W4Gx
        XWpWbB5cQaRXleo8KNZ8dDGLIdyz9hyeb75F9+kxk5YNbJ7CPPjtXKLPHtrwomtV
        6L1fwAcjO8UxQR4kL7SsY1+l9N+624WST5xeDYIiZRoSVM/gG4piyyjBnxBWIwMj
        8PtO9xQCM+0K4Brhq2ar89PttvBsieLLolCJAG1VfZACc6V5axCqcC/rXxO+uKkZ
        8txXjFxNif39BQKDBWRQnbUITjNE4u5RaQVBTci1qfnI7+K37k54aC6DGWMLb2HI
        1Z2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691024496; x=1691110896; bh=BZU0byHrawYDP
        d4TYfypnzLPkuDmb23imLp3KKpZ10o=; b=PQC2+y0CElBZWBeXpo4EgcAf4Ni9T
        LUdmLdXKB0uCY6Zk7r6HfjYM/3786+yLhlD2yjbdFNUMABYpTgxFmqjyhTCTxSi1
        GlTh0bphwk2vHk2peCus8L7BSBDryCjKcOJor9FBvDGyzYSmwLCNheRrnRbe71Mo
        8yDuSDOJGO/5FDPgRr80HgcepnjBEARScKEB99ysxg3Na1kb1BVtATThvc7i+gvJ
        NoQ4GMEDgUzmp0TAog0I/3hsiaOMh5+OerH1ho+22msDFY81c2aBEODrMz4JREm7
        sVtURapw0TV63AbghNTODA2YL/n/fcNBHXTj1r4BtTUjXfg6WnTqNK45w==
X-ME-Sender: <xms:cPzKZBaZLiJCgqSQLh61Bi5m3yDKqCLDr7jslV37GEFuhaKWmiNyHQ>
    <xme:cPzKZIYOn-fADfMN-wktddmMsg4FrFn8bcAzziQ6vyfnlOTqE0jWmhSAqH62y0IRZ
    PwT9SkYJ1qw3WGhYxs>
X-ME-Received: <xmr:cPzKZD_rrRRga4XjborYsc7_U898sxwk_uKS2b5wXsNpS5hVAOvPp41i4dcWCP1AxDU_94-vL85hj3VOwsMHQv9tYag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrkedugdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepke
    dvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihho
X-ME-Proxy: <xmx:cPzKZPovX9TCOj8NFl5VRNmsX4e-ZzVhgJ2EW6Kjfd4SixEZq2a0Ow>
    <xmx:cPzKZMrNXTTYC38R05GbLuzTWMPBA8oYcGErhhyan0izLpHVGkSnbA>
    <xmx:cPzKZFS38vWodjstdM0Fb6Lr6VfD90ws4AwYz2Rk5KeBLbJwv4ByAg>
    <xmx:cPzKZHUz8wRK_qBaxAHiF8NBIQnY43WQ5kD8fJvYOdkngcT7pNAfcQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Aug 2023 21:01:36 -0400 (EDT)
Date:   Wed, 2 Aug 2023 17:59:46 -0700
From:   Boris Burkov <boris@bur.io>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 7/9] btrfs: fix a race in clearing the writeback bit for
 sub-page I/O
Message-ID: <20230803005946.GD1934467@zen>
References: <20230724132701.816771-1-hch@lst.de>
 <20230724132701.816771-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724132701.816771-8-hch@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 24, 2023 at 06:26:59AM -0700, Christoph Hellwig wrote:
> For sub-page I/O, a fast I/O completion can clear the page writeback bit
> in the I/O completion handler before subsequent bios were submitted.
> Use a trick from iomap and defer submission of bios until we're reached
> the end of the page to avoid this race.

This LGTM in that I don't see a bug.

However, I'm confused why it's exactly necessary: doesn't the existing
logic already only allocate one bio and calls bio_add_page on it in a
loop. And bio_add_page handles the subpage blocksize case.

As far as I can tell, it tries to do it sequentially so it should be
contiguous. Are you worried about non-contiguous writes within one page
resulting in separate bios? In that case, why would a completion clear
the writeback bit on the page if the whole page isn't written back? I
guess that could be tricky to do and this is the correct solution?

Thanks,
Boris

> 
> Fixes: c5ef5c6c733a ("btrfs: make __extent_writepage_io() only submit dirty range for subpage")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/extent_io.c | 54 ++++++++++++++++++++++++++++++++++----------
>  1 file changed, 42 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index fada7a1931b130..48a49c57daa6fd 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -105,7 +105,8 @@ struct btrfs_bio_ctrl {
>  	struct writeback_control *wbc;
>  };
>  
> -static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
> +static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl,
> +			   struct bio_list *bio_list)
>  {
>  	struct btrfs_bio *bbio = bio_ctrl->bbio;
>  
> @@ -118,6 +119,8 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
>  	if (btrfs_op(&bbio->bio) == BTRFS_MAP_READ &&
>  	    bio_ctrl->compress_type != BTRFS_COMPRESS_NONE)
>  		btrfs_submit_compressed_read(bbio);
> +	else if (bio_list)
> +		bio_list_add(bio_list, &bbio->bio);
>  	else
>  		btrfs_submit_bio(bbio, 0);
>  
> @@ -141,7 +144,22 @@ static void submit_write_bio(struct btrfs_bio_ctrl *bio_ctrl, int ret)
>  		/* The bio is owned by the end_io handler now */
>  		bio_ctrl->bbio = NULL;
>  	} else {
> -		submit_one_bio(bio_ctrl);
> +		submit_one_bio(bio_ctrl, NULL);
> +	}
> +}
> +
> +static void btrfs_submit_pending_bios(struct bio_list *bio_list, int ret)
> +{
> +	struct bio *bio;
> +
> +	if (ret) {
> +		blk_status_t status = errno_to_blk_status(ret);
> +
> +		while ((bio = bio_list_pop(bio_list)))
> +			btrfs_bio_end_io(btrfs_bio(bio), status);
> +	} else {
> +		while ((bio = bio_list_pop(bio_list)))
> +			btrfs_submit_bio(btrfs_bio(bio), 0);
>  	}
>  }
>  
> @@ -791,7 +809,8 @@ static void alloc_new_bio(struct btrfs_inode *inode,
>   */
>  static void submit_extent_page(struct btrfs_bio_ctrl *bio_ctrl,
>  			       u64 disk_bytenr, struct page *page,
> -			       size_t size, unsigned long pg_offset)
> +			       size_t size, unsigned long pg_offset,
> +			       struct bio_list *bio_list)
>  {
>  	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
>  
> @@ -800,7 +819,7 @@ static void submit_extent_page(struct btrfs_bio_ctrl *bio_ctrl,
>  
>  	if (bio_ctrl->bbio &&
>  	    !btrfs_bio_is_contig(bio_ctrl, page, disk_bytenr, pg_offset))
> -		submit_one_bio(bio_ctrl);
> +		submit_one_bio(bio_ctrl, bio_list);
>  
>  	do {
>  		u32 len = size;
> @@ -820,7 +839,7 @@ static void submit_extent_page(struct btrfs_bio_ctrl *bio_ctrl,
>  
>  		if (bio_add_page(&bio_ctrl->bbio->bio, page, len, pg_offset) != len) {
>  			/* bio full: move on to a new one */
> -			submit_one_bio(bio_ctrl);
> +			submit_one_bio(bio_ctrl, bio_list);
>  			continue;
>  		}
>  
> @@ -834,7 +853,7 @@ static void submit_extent_page(struct btrfs_bio_ctrl *bio_ctrl,
>  
>  		/* Ordered extent boundary: move on to a new bio. */
>  		if (bio_ctrl->len_to_oe_boundary == 0)
> -			submit_one_bio(bio_ctrl);
> +			submit_one_bio(bio_ctrl, bio_list);
>  	} while (size);
>  }
>  
> @@ -1082,14 +1101,14 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
>  		}
>  
>  		if (bio_ctrl->compress_type != compress_type) {
> -			submit_one_bio(bio_ctrl);
> +			submit_one_bio(bio_ctrl, NULL);
>  			bio_ctrl->compress_type = compress_type;
>  		}
>  
>  		if (force_bio_submit)
> -			submit_one_bio(bio_ctrl);
> +			submit_one_bio(bio_ctrl, NULL);
>  		submit_extent_page(bio_ctrl, disk_bytenr, page, iosize,
> -				   pg_offset);
> +				   pg_offset, NULL);
>  		cur = cur + iosize;
>  		pg_offset += iosize;
>  	}
> @@ -1113,7 +1132,7 @@ int btrfs_read_folio(struct file *file, struct folio *folio)
>  	 * If btrfs_do_readpage() failed we will want to submit the assembled
>  	 * bio to do the cleanup.
>  	 */
> -	submit_one_bio(&bio_ctrl);
> +	submit_one_bio(&bio_ctrl, NULL);
>  	return ret;
>  }
>  
> @@ -1287,6 +1306,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
>  	u64 extent_offset;
>  	u64 block_start;
>  	struct extent_map *em;
> +	struct bio_list bio_list = BIO_EMPTY_LIST;
>  	int ret = 0;
>  	int nr = 0;
>  
> @@ -1365,7 +1385,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
>  		btrfs_page_clear_dirty(fs_info, page, cur, iosize);
>  
>  		submit_extent_page(bio_ctrl, disk_bytenr, page, iosize,
> -				   cur - page_offset(page));
> +				   cur - page_offset(page), &bio_list);
>  		cur += iosize;
>  		nr++;
>  	}
> @@ -1378,6 +1398,16 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
>  		set_page_writeback(page);
>  		end_page_writeback(page);
>  	}
> +
> +	/*
> +	 * Submit all bios we queued up for this page.
> +	 *
> +	 * The bios are not submitted directly after building them as otherwise
> +	 * a very fast I/O completion on an earlier bio could clear the page
> +	 * writeback bit before the subsequent bios are even submitted.
> +	 */
> +	btrfs_submit_pending_bios(&bio_list, ret);
> +
>  	if (ret) {
>  		u32 remaining = end + 1 - cur;
>  
> @@ -2243,7 +2273,7 @@ void extent_readahead(struct readahead_control *rac)
>  
>  	if (em_cached)
>  		free_extent_map(em_cached);
> -	submit_one_bio(&bio_ctrl);
> +	submit_one_bio(&bio_ctrl, NULL);
>  }
>  
>  /*
> -- 
> 2.39.2
> 
