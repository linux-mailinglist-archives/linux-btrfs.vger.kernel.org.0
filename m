Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A817D560DB2
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jun 2022 01:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiF2XpE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jun 2022 19:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiF2XpE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jun 2022 19:45:04 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F691AF03
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jun 2022 16:45:03 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 162CD3200912;
        Wed, 29 Jun 2022 19:45:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 29 Jun 2022 19:45:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1656546301; x=1656632701; bh=/CvomtSod6
        V5RFq1chlCiqRz/FDWw2v2H78HJKV2pOc=; b=Enf9OQF1F38oKFqB/Ow05RdXHQ
        opFhCDjaFbk1P8QBd42x3ruiGmG6D7Lch/ge7yoBAr9GbenJNqqysC41287zfK/4
        +8t06Ris+fm7GyPaL4uo2PBJ/qX6Ul33ibXDUbyabmPjftTtKewuXRpvuegGzuo5
        yyVVm3G/9WRazWhHTYD8+WIblJX0lYbTnZtrbux81dvilgwOKbZsi2VW4NWcbd1k
        MFXo4MfNLpK+IsDt4yD6iVkva8DZ6LA8dukh0ohajjw0Lrr8DmHXGM7tBm8REY4T
        0vdRPz3qTnN8lNzf/58DJrI1QmxtisAjcNrddWjcIt+NuIVRMQB75xenti2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1656546301; x=1656632701; bh=/CvomtSod6V5RFq1chlCiqRz/FDW
        w2v2H78HJKV2pOc=; b=nHMvOq1SPtEDayVqmCqAfFxuQdU4Hsw7Wnn54MiMqK7C
        T7MXEHPbFqPQkJ8L7oNyaL6ueA7SXZIzdqJguasAPHzN4C+pjKVBjJzA9hGMv4e/
        Sk/85QIlfO9FRerIskDGhNE8s+eeKC8b/B3YAbq4IKgXnF6n+bSnTnyXjsFYbJhJ
        DAzH1K1lRnxkLQGlpv7YvDV0lSxAnFvN3xbmEhfkixTEcRpuq5Pm/RnEDn7LHM5R
        C5LhNx2QDPEIXLK+65DdbysPZc1UBpGHbpOOGDqJLzS2Bbv3nOlAMEiVph1eew64
        HMe9Afoqautszkn2PBJ9AVBii6/lwhT2Qq22Dr9Ykg==
X-ME-Sender: <xms:_eO8Yno816MU82jfL9pRnx8R7FrLnuNbWMQ6_WD15iSbzaPybpNinw>
    <xme:_eO8Yhp4aPdZ-n2om-mPCIsur9wePbRrssLz-MLhE_J6iyy_q_XMU-35cP1cJbyLF
    Ev_9nU0c3x1WNjnyVc>
X-ME-Received: <xmr:_eO8YkPXum53WBTXpICFdUkVIBBJK0AVqXhDsYu-3y-QwMi1t51gQV75q4TI30AjnZl2xm_hvheSOR8H1k1-VGa7YI81lA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehtddgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:_eO8Yq5Fm9MEDH3D0mvLl_DQ5gIj6fZ3njuINpB85YnclfANtnDLxw>
    <xmx:_eO8Ym7DYvbCQ61A3nU9qViWQPHtdzZfaj8t0Sd7Qg-u4c8t_D8Hng>
    <xmx:_eO8Yiim8LFJa6tNbQVPjZRKQwAPl8TIXsAViCamjg4bSzB2fUQT1g>
    <xmx:_eO8YsmoqCh7M1pBa45zJC_FIa9jlL4hVpegeVWAEq_7dLQO_F5osw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jun 2022 19:45:01 -0400 (EDT)
Date:   Wed, 29 Jun 2022 16:44:59 -0700
From:   Boris Burkov <boris@bur.io>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/4] btrfs: pass a btrfs_bio to btrfs_repair_one_sector
Message-ID: <Yrzj+8lk6aHaLjsD@zen>
References: <20220623055338.3833616-1-hch@lst.de>
 <20220623055338.3833616-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623055338.3833616-3-hch@lst.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 23, 2022 at 07:53:36AM +0200, Christoph Hellwig wrote:
> Pass the btrfs_bio instead of the plain bio to btrfs_repair_one_sector,
> an remove the start and failed_mirror arguments in favor of deriving
> them from the btrfs_bio.  For this to work ensure that the file_offset
> field is also initialized for buffered I/O.
nit: the field in volumes.h has a comment "for direct I/O" which we
should get rid of now.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/extent_io.c | 47 ++++++++++++++++++++++++--------------------
>  fs/btrfs/extent_io.h |  8 ++++----
>  fs/btrfs/inode.c     |  5 ++---
>  3 files changed, 32 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 3778d58092dea..ec7bdb3fa0921 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -182,6 +182,7 @@ static int add_extent_changeset(struct extent_state *state, u32 bits,
>  static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
>  {
>  	struct bio *bio;
> +	struct bio_vec *bv;
>  	struct inode *inode;
>  	int mirror_num;
>  
> @@ -189,12 +190,15 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
>  		return;
>  
>  	bio = bio_ctrl->bio;
> -	inode = bio_first_page_all(bio)->mapping->host;
> +	bv = bio_first_bvec_all(bio);
> +	inode = bv->bv_page->mapping->host;
>  	mirror_num = bio_ctrl->mirror_num;
>  
>  	/* Caller should ensure the bio has at least some range added */
>  	ASSERT(bio->bi_iter.bi_size);
>  
> +	btrfs_bio(bio)->file_offset = page_offset(bv->bv_page) + bv->bv_offset;
> +
>  	if (!is_data_inode(inode))
>  		btrfs_submit_metadata_bio(inode, bio, mirror_num);
>  	else if (btrfs_op(bio) == BTRFS_MAP_WRITE)
> @@ -2533,10 +2537,11 @@ void btrfs_free_io_failure_record(struct btrfs_inode *inode, u64 start, u64 end)
>  }
>  
>  static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode,
> -							     u64 start,
> -							     int failed_mirror)
> +							     struct btrfs_bio *bbio,
> +							     unsigned int bio_offset)
>  {
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> +	u64 start = bbio->file_offset + bio_offset;
>  	struct io_failure_record *failrec;
>  	struct extent_map *em;
>  	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
> @@ -2556,7 +2561,7 @@ static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode
>  		 * (e.g. with a list for failed_mirror) to make
>  		 * clean_io_failure() clean all those errors at once.
>  		 */
> -		ASSERT(failrec->this_mirror == failed_mirror);
> +		ASSERT(failrec->this_mirror == bbio->mirror_num);
>  		ASSERT(failrec->len == fs_info->sectorsize);
>  		return failrec;
>  	}
> @@ -2567,7 +2572,7 @@ static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode
>  
>  	failrec->start = start;
>  	failrec->len = sectorsize;
> -	failrec->failed_mirror = failrec->this_mirror = failed_mirror;
> +	failrec->failed_mirror = failrec->this_mirror = bbio->mirror_num;
>  	failrec->compress_type = BTRFS_COMPRESS_NONE;
>  
>  	read_lock(&em_tree->lock);
> @@ -2632,17 +2637,17 @@ static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode
>  	return failrec;
>  }
>  
> -int btrfs_repair_one_sector(struct inode *inode,
> -			    struct bio *failed_bio, u32 bio_offset,
> -			    struct page *page, unsigned int pgoff,
> -			    u64 start, int failed_mirror,
> +int btrfs_repair_one_sector(struct inode *inode, struct btrfs_bio *failed_bbio,
> +			    u32 bio_offset, struct page *page,
> +			    unsigned int pgoff,
>  			    submit_bio_hook_t *submit_bio_hook)
>  {
> +	u64 start = failed_bbio->file_offset + bio_offset;
>  	struct io_failure_record *failrec;
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>  	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
>  	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
> -	struct btrfs_bio *failed_bbio = btrfs_bio(failed_bio);
> +	struct bio *failed_bio = &failed_bbio->bio;
>  	const int icsum = bio_offset >> fs_info->sectorsize_bits;
>  	struct bio *repair_bio;
>  	struct btrfs_bio *repair_bbio;
> @@ -2652,7 +2657,7 @@ int btrfs_repair_one_sector(struct inode *inode,
>  
>  	BUG_ON(bio_op(failed_bio) == REQ_OP_WRITE);
>  
> -	failrec = btrfs_get_io_failure_record(inode, start, failed_mirror);
> +	failrec = btrfs_get_io_failure_record(inode, failed_bbio, bio_offset);
>  	if (IS_ERR(failrec))
>  		return PTR_ERR(failrec);
>  
> @@ -2750,9 +2755,10 @@ static void end_sector_io(struct page *page, u64 offset, bool uptodate)
>  				    offset + sectorsize - 1, &cached);
>  }
>  
> -static void submit_data_read_repair(struct inode *inode, struct bio *failed_bio,
> +static void submit_data_read_repair(struct inode *inode,
> +				    struct btrfs_bio *failed_bbio,
>  				    u32 bio_offset, const struct bio_vec *bvec,
> -				    int failed_mirror, unsigned int error_bitmap)
> +				    unsigned int error_bitmap)
>  {
>  	const unsigned int pgoff = bvec->bv_offset;
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> @@ -2763,7 +2769,7 @@ static void submit_data_read_repair(struct inode *inode, struct bio *failed_bio,
>  	const int nr_bits = (end + 1 - start) >> fs_info->sectorsize_bits;
>  	int i;
>  
> -	BUG_ON(bio_op(failed_bio) == REQ_OP_WRITE);
> +	BUG_ON(bio_op(&failed_bbio->bio) == REQ_OP_WRITE);
>  
>  	/* This repair is only for data */
>  	ASSERT(is_data_inode(inode));
> @@ -2775,7 +2781,7 @@ static void submit_data_read_repair(struct inode *inode, struct bio *failed_bio,
>  	 * We only get called on buffered IO, thus page must be mapped and bio
>  	 * must not be cloned.
>  	 */
> -	ASSERT(page->mapping && !bio_flagged(failed_bio, BIO_CLONED));
> +	ASSERT(page->mapping && !bio_flagged(&failed_bbio->bio, BIO_CLONED));
>  
>  	/* Iterate through all the sectors in the range */
>  	for (i = 0; i < nr_bits; i++) {
> @@ -2792,10 +2798,9 @@ static void submit_data_read_repair(struct inode *inode, struct bio *failed_bio,
>  			goto next;
>  		}
>  
> -		ret = btrfs_repair_one_sector(inode, failed_bio,
> -				bio_offset + offset,
> -				page, pgoff + offset, start + offset,
> -				failed_mirror, btrfs_submit_data_read_bio);
> +		ret = btrfs_repair_one_sector(inode, failed_bbio,
> +				bio_offset + offset, page, pgoff + offset,
> +				btrfs_submit_data_read_bio);
>  		if (!ret) {
>  			/*
>  			 * We have submitted the read repair, the page release
> @@ -3127,8 +3132,8 @@ static void end_bio_extent_readpage(struct bio *bio)
>  			 * submit_data_read_repair() will handle all the good
>  			 * and bad sectors, we just continue to the next bvec.
>  			 */
> -			submit_data_read_repair(inode, bio, bio_offset, bvec,
> -						mirror, error_bitmap);
> +			submit_data_read_repair(inode, bbio, bio_offset, bvec,
> +						error_bitmap);
>  		} else {
>  			/* Update page status and unlock */
>  			end_page_read(page, uptodate, start, len);
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 280af70c04953..a78051c7627c4 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -57,6 +57,7 @@ enum {
>  #define BITMAP_LAST_BYTE_MASK(nbits) \
>  	(BYTE_MASK >> (-(nbits) & (BITS_PER_BYTE - 1)))
>  
> +struct btrfs_bio;
>  struct btrfs_root;
>  struct btrfs_inode;
>  struct btrfs_io_bio;
> @@ -266,10 +267,9 @@ struct io_failure_record {
>  	int num_copies;
>  };
>  
> -int btrfs_repair_one_sector(struct inode *inode,
> -			    struct bio *failed_bio, u32 bio_offset,
> -			    struct page *page, unsigned int pgoff,
> -			    u64 start, int failed_mirror,
> +int btrfs_repair_one_sector(struct inode *inode, struct btrfs_bio *failed_bbio,
> +			    u32 bio_offset, struct page *page,
> +			    unsigned int pgoff,
>  			    submit_bio_hook_t *submit_bio_hook);
>  
>  #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 784c1ad4a9634..a627b2af9e243 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7953,9 +7953,8 @@ static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
>  		} else {
>  			int ret;
>  
> -			ret = btrfs_repair_one_sector(inode, &bbio->bio, offset,
> -					bv.bv_page, bv.bv_offset, start,
> -					bbio->mirror_num,
> +			ret = btrfs_repair_one_sector(inode, bbio, offset,
> +					bv.bv_page, bv.bv_offset,
>  					submit_dio_repair_bio);
>  			if (ret)
>  				err = errno_to_blk_status(ret);
> -- 
> 2.30.2
> 
