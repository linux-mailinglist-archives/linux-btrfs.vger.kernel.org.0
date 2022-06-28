Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C918E55E63B
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jun 2022 18:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347809AbiF1PUe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jun 2022 11:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344555AbiF1PUd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jun 2022 11:20:33 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1960232EE0
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Jun 2022 08:20:33 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id C5FF15C0228;
        Tue, 28 Jun 2022 11:20:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 28 Jun 2022 11:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1656429630; x=1656516030; bh=sXF3mLb8Vs
        rDVhMLtHQwLAZmAVUGuQDVK9xORm1vGrg=; b=Xi6vCq29yguPYjO1bbL5EdJA5Q
        DNnCF5ekn3UMhTEMqBVqcQkyIQTzDuTSz9J0nVQXthg/81otZX3rJkoE6+NXv6Nt
        HtSmr/ZZgnR8xPc04YrMnr+5wtj/svCw0KWQzXbhuBETjXEbMAlC9gochXgJbA60
        NMI85A78VnRlNeFn42M/wZPLKaqwHmU+i6trL5G6moIu5llsTXB2W969j/nqHV+s
        9wLHsIkUxRuoyKx9IK0ZssSGWb8uxM6SbPYpHbk3NjuYk7B4V1nXY5A+wMEroFmb
        RaImr0soVpyND6C7LZw0Sp6KEWP8/+ql+6CONYPRIgPLuPwhdPRLauqZbhog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1656429630; x=1656516030; bh=sXF3mLb8VsrDVhMLtHQwLAZmAVUG
        uQDVK9xORm1vGrg=; b=YqUQLdOwC5kivVkX+ECaC5q7mJeDSGF3UykCAkCubmnd
        imCjuJu7LCifqv5qIg/AiRahEw+4Yu1K03OrKw0xqvHiKpC/Z5xt+EFntRJPZB+i
        8O1kNF1f5qAXVrEbHQfaKIzEbrCK0qmfOnAWVPwIFjkp/tfwItOGOblwpFvRI4wS
        OV75cFgGIT13WKcl1c/NmLR1zbuXZ2/z2mnhjZibnLWz0o0v6gpf/xJpXVGUkR84
        +Fs3loy5CLrhC+00hO2OobGlexYtOqb6ayLvuPw6uBFqQqlSURQ3jOX2fQWsMkUW
        2yXBYSUwpijehTIROft0Q2Ywix4oLXYNkkg6G95Hmg==
X-ME-Sender: <xms:Phy7YlAtAL_hMbdjTZObC9CwgV02idpgk9ncPQUSFB_-4FMddJwFHA>
    <xme:Phy7YjhHf-nX9C5LDLUfbxVBR-FCpuammAA6O4KoXIPoaa5V5kB06rq0SYIXPmTx6
    4xqTyyRjgQ76mxL9jw>
X-ME-Received: <xmr:Phy7Ygn7LfQQ7b8kHmqVL0F0XFjY4dwrlKUD4LJ4wLSBbEC2I905en9FDMx-aR59IBEiX5HzXFVfjLjmYa4wc7Sa4QbD3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudegjedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:Phy7YvxkTcbEglxeBV7QFkO3iIjwbRNc8JeEl2r0u3WmLLSj7NKFEg>
    <xmx:Phy7YqQrQtSHLT-OVWKy8j9z6sZfeGcPsHB9e9jSKtWt4o7KBrCCRw>
    <xmx:Phy7YiaJeMdKTbZD9dYb-Ippat5qnce1qBbMc85z-9nMZMb0bCytZA>
    <xmx:Phy7Yoet3uV7VwnsazKU202S2oR765Fsk-sldqz4PNmhUUzvZcHtsQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jun 2022 11:20:30 -0400 (EDT)
Date:   Tue, 28 Jun 2022 08:20:28 -0700
From:   Boris Burkov <boris@bur.io>
To:     Christoph Hellwig <hch@lst.de>
Cc:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 08/10] btrfs: handle allocation failure in
 btrfs_wq_submit_bio gracefully
Message-ID: <YrscPJ1DuQZ6Po8j@zen>
References: <20220617100414.1159680-1-hch@lst.de>
 <20220617100414.1159680-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617100414.1159680-9-hch@lst.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 17, 2022 at 12:04:12PM +0200, Christoph Hellwig wrote:
> btrfs_wq_submit_bio is used for writeback under memory pressure.  Instead
> of failing the I/O when we can't allocate the async_submit_bio, just
> punt back to the synchronous submission path.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/disk-io.c | 37 ++++++++++++++++++-------------------
>  fs/btrfs/disk-io.h |  6 +++---
>  fs/btrfs/inode.c   | 17 +++++++++--------
>  3 files changed, 30 insertions(+), 30 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 5df6865428a5c..eaa643f38783c 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -756,16 +756,16 @@ static void run_one_async_free(struct btrfs_work *work)
>  	kfree(async);
>  }
>  
> -blk_status_t btrfs_wq_submit_bio(struct inode *inode, struct bio *bio,
> -				 int mirror_num, u64 dio_file_offset,
> -				 extent_submit_bio_start_t *submit_bio_start)
> +bool btrfs_wq_submit_bio(struct inode *inode, struct bio *bio, int mirror_num,
> +			 u64 dio_file_offset,
> +			 extent_submit_bio_start_t *submit_bio_start)
>  {
>  	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
>  	struct async_submit_bio *async;
>  
>  	async = kmalloc(sizeof(*async), GFP_NOFS);
>  	if (!async)
> -		return BLK_STS_RESOURCE;
> +		return false;
>  
>  	async->inode = inode;
>  	async->bio = bio;
> @@ -783,7 +783,7 @@ blk_status_t btrfs_wq_submit_bio(struct inode *inode, struct bio *bio,
>  		btrfs_queue_work(fs_info->hipri_workers, &async->work);
>  	else
>  		btrfs_queue_work(fs_info->workers, &async->work);
> -	return 0;
> +	return true;
>  }
>  
>  static blk_status_t btree_csum_one_bio(struct bio *bio)
> @@ -837,25 +837,24 @@ void btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio, int mirror_
>  		btrfs_submit_bio(fs_info, bio, mirror_num);
>  		return;
>  	}
> -	if (!should_async_write(fs_info, BTRFS_I(inode))) {
> -		ret = btree_csum_one_bio(bio);
> -		if (!ret) {
> -			btrfs_submit_bio(fs_info, bio, mirror_num);
> -			return;
> -		}
> -	} else {
> -		/*
> -		 * kthread helpers are used to submit writes so that
> -		 * checksumming can happen in parallel across all CPUs
> -		 */
> -		ret = btrfs_wq_submit_bio(inode, bio, mirror_num, 0,
> -					  btree_submit_bio_start);
> -	}
>  
> +	/*
> +	 * Kthread helpers are used to submit writes so that checksumming can
> +	 * happen in parallel across all CPUs
> +	 */
> +	if (should_async_write(fs_info, BTRFS_I(inode)) &&
> +	    btrfs_wq_submit_bio(inode, bio, mirror_num, 0,
> +				btree_submit_bio_start))
> +		return;
> +
> +	ret = btree_csum_one_bio(bio);
>  	if (ret) {
>  		bio->bi_status = ret;
>  		bio_endio(bio);
> +		return;
>  	}
> +
> +	btrfs_submit_bio(fs_info, bio, mirror_num);
>  }
>  
>  #ifdef CONFIG_MIGRATION
> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
> index 05e779a41a997..8993b428e09ce 100644
> --- a/fs/btrfs/disk-io.h
> +++ b/fs/btrfs/disk-io.h
> @@ -114,9 +114,9 @@ int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid,
>  			  int atomic);
>  int btrfs_read_extent_buffer(struct extent_buffer *buf, u64 parent_transid,
>  			     int level, struct btrfs_key *first_key);
> -blk_status_t btrfs_wq_submit_bio(struct inode *inode, struct bio *bio,
> -				 int mirror_num, u64 dio_file_offset,
> -				 extent_submit_bio_start_t *submit_bio_start);
> +bool btrfs_wq_submit_bio(struct inode *inode, struct bio *bio, int mirror_num,
> +			 u64 dio_file_offset,
> +			 extent_submit_bio_start_t *submit_bio_start);
>  blk_status_t btrfs_submit_bio_done(void *private_data, struct bio *bio,
>  			  int mirror_num);
>  int btrfs_alloc_log_tree_node(struct btrfs_trans_handle *trans,
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 5a90fc129aea9..38af980d1cf1f 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2604,11 +2604,10 @@ void btrfs_submit_data_write_bio(struct inode *inode, struct bio *bio, int mirro
>  	if (!(bi->flags & BTRFS_INODE_NODATASUM) &&
>  	    !test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state) &&
>  	    !btrfs_is_data_reloc_root(bi->root)) {
> -		if (!atomic_read(&bi->sync_writers)) {
> -			ret = btrfs_wq_submit_bio(inode, bio, mirror_num, 0,
> -						  btrfs_submit_bio_start);
> -			goto out;
> -		}
> +		if (!atomic_read(&bi->sync_writers) &&
> +		    btrfs_wq_submit_bio(inode, bio, mirror_num, 0,
> +					btrfs_submit_bio_start))
> +			return;
>  
>  		ret = btrfs_csum_one_bio(bi, bio, (u64)-1, false);
>  		if (ret)
> @@ -7953,9 +7952,11 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
>  
>  	if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
>  		/* Check btrfs_submit_data_write_bio() for async submit rules */
> -		if (async_submit && !atomic_read(&BTRFS_I(inode)->sync_writers))
> -			return btrfs_wq_submit_bio(inode, bio, 0, file_offset,
> -					btrfs_submit_bio_start_direct_io);
> +		if (async_submit && !atomic_read(&BTRFS_I(inode)->sync_writers) &&
> +		    btrfs_wq_submit_bio(inode, bio, 0, file_offset,
> +					btrfs_submit_bio_start_direct_io))
> +			return BLK_STS_OK;
> +
>  		/*
>  		 * If we aren't doing async submit, calculate the csum of the
>  		 * bio now.
> -- 
> 2.30.2
> 
