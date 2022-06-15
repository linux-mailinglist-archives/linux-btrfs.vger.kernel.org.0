Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D80954D0C5
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 20:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345877AbiFOSQS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jun 2022 14:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244186AbiFOSQR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jun 2022 14:16:17 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA44544FD
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 11:16:15 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 666DC5C0129;
        Wed, 15 Jun 2022 14:16:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 15 Jun 2022 14:16:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1655316971; x=1655403371; bh=JKNCP8rEMz
        6SXC3Bmb4euVnVAjmqEKZN8czGVSyDE4o=; b=l0o5BmHVH/G1JRMqDr28hTUfQk
        hFwbqoDBgLF7tXAvXkoYfGo31kRMWuiC+AHIMCItH75uNVHTIlSvC0W+LyyeoNbN
        siPpNsxFI94UOexlkFHzi2oyJA2VW52CqTFdMC8WkDb4p/W9L6TR+o7NzuKohQRJ
        lC2PrtPChaEMqPjyvX7OYlVlPp3MUKr0wnwQSQ43Xu1SyNbLfWAJNohCicQMG4ny
        bFyINSpPYzdIL0RNhk0p2GP2lXcfE0tsiMxmni0nf9EG761T8/R0jxdHW7k7fP/V
        TtI4urXQUiSuLMNhH7x7Gjfew9QV7nia0/i8Sckfez52jbFptL6uH117i1lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1655316971; x=1655403371; bh=JKNCP8rEMz6SXC3Bmb4euVnVAjmq
        EKZN8czGVSyDE4o=; b=iUItAF9jZYSKLKhkCWukcAHwiis54GZ1A8UE6/smD3al
        2rTDI8qSbG0xZy6FcXAaX1upEAA2A76Vs+CbX2SalKHrlDWYkUI7pN6HejGxFPtW
        pfz55depI7zPKg6S9VxPV08U9UbKW3e0Gp0kvSJisSD1Suktb4NdVLii6ug1rYB4
        SztLIlCde1+0T54hlN+7LR3wghKXRmWzOlYfQ7/o3oADj7UuuFFvC/x9OZ6nddMr
        yVnVA72wLznBEthbk0efMVFC3Qhd3kpUy77OAT4A9dJSX8PBb4t46pEV5H2PRIKY
        zqC42ejutm06p1lmh+E54bM+FlR+E4RS11Ws0NEe5Q==
X-ME-Sender: <xms:6iGqYlm9TyyH_-dRz5L9uWeAnDgyFHE0kaS5B563hnWZegbnvaVkgQ>
    <xme:6iGqYg2xE4YCwqz9VFbL6OAyZ9pzhNcYPgsKB1Hw32lIOrbp-Up3B1EBvb8N9P6gH
    fX-bwqpN16AiKJrnrk>
X-ME-Received: <xmr:6iGqYrpo0Dwyu1pZ45i9UdUxAvZqCXk8MTaTRKnqo4csOOfTJ0kf45qlPGM38JNAZboNxHIvWwkr9YRU-9n71Ap8lXRatg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddvuddguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:6yGqYlkfLz86fqjrPs9aoE5BOUay-cIe24dJjBEoqDJ7bpUX3rxsYw>
    <xmx:6yGqYj0Tio3pxVO7Bzwwv9VmJ6tmHl7yFbkDVL9zgVNyNtPg-QD_JQ>
    <xmx:6yGqYkubNXS6wDl4CWyEF2iElEsZyWdt99DXp5M6ZW4WhGqY8QwXlQ>
    <xmx:6yGqYkz_2zIJUvtDD1V70T6gYWkugAMvjxkfXibAEvuna4hPNm1WYg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jun 2022 14:16:10 -0400 (EDT)
Date:   Wed, 15 Jun 2022 11:16:46 -0700
From:   Boris Burkov <boris@bur.io>
To:     Christoph Hellwig <hch@lst.de>
Cc:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 5/5] btrfs: remove bioc->stripes_pending
Message-ID: <YqoiDrxfriDiW9Js@zen>
References: <20220615151515.888424-1-hch@lst.de>
 <20220615151515.888424-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615151515.888424-6-hch@lst.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 15, 2022 at 05:15:15PM +0200, Christoph Hellwig wrote:
> Replace the the stripes_pending field with the pending counter in the
> bio.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/btrfs/volumes.c | 100 ++++++++++++++++++++++-----------------------
>  fs/btrfs/volumes.h |   1 -
>  2 files changed, 48 insertions(+), 53 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 3a8c437bdd65b..bf80a850347cd 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5889,7 +5889,6 @@ static struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_
>  		sizeof(u64) * (total_stripes),
>  		GFP_NOFS|__GFP_NOFAIL);
>  
> -	atomic_set(&bioc->error, 0);
>  	refcount_set(&bioc->refs, 1);
>  
>  	bioc->fs_info = fs_info;
> @@ -6619,46 +6618,21 @@ static void btrfs_end_bio_work(struct work_struct *work)
>  	struct btrfs_bio *bbio =
>  		container_of(work, struct btrfs_bio, end_io_work);
>  
> -	bio_endio(&bbio->bio);
> -}
> -
> -static void btrfs_end_bioc(struct btrfs_io_context *bioc, bool async)
> -{
> -	struct bio *orig_bio = bioc->orig_bio;
> -	struct btrfs_bio *bbio = btrfs_bio(orig_bio);
> -
> -	bbio->mirror_num = bioc->mirror_num;
> -	orig_bio->bi_private = bioc->private;
> -	orig_bio->bi_end_io = bioc->end_io;
> -
> -	/*
> -	 * Only send an error to the higher layers if it is beyond the tolerance
> -	 * threshold.
> -	 */
> -	if (atomic_read(&bioc->error) > bioc->max_errors)
> -		orig_bio->bi_status = BLK_STS_IOERR;
> -	else
> -		orig_bio->bi_status = BLK_STS_OK;
> -
> -	if (btrfs_op(orig_bio) == BTRFS_MAP_READ && async) {
> -		INIT_WORK(&bbio->end_io_work, btrfs_end_bio_work);
> -		queue_work(btrfs_end_io_wq(bioc), &bbio->end_io_work);
> -	} else {
> -		bio_endio(orig_bio);
> -	}
> -
> -	btrfs_put_bioc(bioc);
> +	bbio->bio.bi_end_io(&bbio->bio);
>  }
>  
>  static void btrfs_end_bio(struct bio *bio)
>  {
>  	struct btrfs_io_stripe *stripe = bio->bi_private;
>  	struct btrfs_io_context *bioc = stripe->bioc;
> +	struct bio *orig_bio = bioc->orig_bio;
> +	struct btrfs_bio *bbio = btrfs_bio(orig_bio);
>  
>  	if (bio->bi_status) {
>  		atomic_inc(&bioc->error);
> -		if (bio->bi_status == BLK_STS_IOERR ||
> -		    bio->bi_status == BLK_STS_TARGET) {
> +		if (stripe->dev && stripe->dev->bdev &&
> +		    (bio->bi_status == BLK_STS_IOERR ||
> +		     bio->bi_status == BLK_STS_TARGET)) {
>  			if (btrfs_op(bio) == BTRFS_MAP_WRITE)
>  				btrfs_dev_stat_inc_and_print(stripe->dev,
>  						BTRFS_DEV_STAT_WRITE_ERRS);
> @@ -6671,12 +6645,35 @@ static void btrfs_end_bio(struct bio *bio)
>  		}
>  	}
>  
> -	if (bio != bioc->orig_bio)
> +	btrfs_bio_counter_dec(bioc->fs_info);
> +
> +	if (bio != orig_bio) {
> +		bio_endio(orig_bio);
>  		bio_put(bio);
> +		return;
> +	}
>  
> -	btrfs_bio_counter_dec(bioc->fs_info);
> -	if (atomic_dec_and_test(&bioc->stripes_pending))
> -		btrfs_end_bioc(bioc, true);
> +	/*
> +	 * Only send an error to the higher layers if it is beyond the tolerance
> +	 * threshold.
> +	 */
> +	if (atomic_read(&bioc->error) > bioc->max_errors)
> +		orig_bio->bi_status = BLK_STS_IOERR;
> +	else
> +		orig_bio->bi_status = BLK_STS_OK;
> +
> +	bbio->mirror_num = bioc->mirror_num;
> +	orig_bio->bi_end_io = bioc->end_io;
> +	orig_bio->bi_private = bioc->private;
> +	if (btrfs_op(orig_bio) == BTRFS_MAP_READ) {
> +		bbio->device = stripe->dev;
> +		INIT_WORK(&bbio->end_io_work, btrfs_end_bio_work);
> +		queue_work(btrfs_end_io_wq(bioc), &bbio->end_io_work);
> +	} else {
> +		orig_bio->bi_end_io(orig_bio);
> +	}
> +
> +	btrfs_put_bioc(bioc);
>  }
>  
>  static void submit_stripe_bio(struct btrfs_io_context *bioc,
> @@ -6687,28 +6684,30 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc,
>  	u64 physical = bioc->stripes[dev_nr].physical;
>  	struct bio *bio;
>  
> -	if (!dev || !dev->bdev ||
> -	    test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state) ||
> -	    (btrfs_op(orig_bio) == BTRFS_MAP_WRITE &&
> -	     !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))) {
> -		atomic_inc(&bioc->error);
> -		if (atomic_dec_and_test(&bioc->stripes_pending))
> -			btrfs_end_bioc(bioc, false);
> -		return;
> -	}
> -
>  	if (clone) {
> -		bio = bio_alloc_clone(dev->bdev, orig_bio, GFP_NOFS, &fs_bio_set);
> +		bio = bio_alloc_clone(NULL, orig_bio, GFP_NOFS, &fs_bio_set);
> +		bio_inc_remaining(orig_bio);
>  	} else {
>  		bio = orig_bio;
> -		bio_set_dev(bio, dev->bdev);
> -		btrfs_bio(bio)->device = dev;
>  	}
>  
>  	bioc->stripes[dev_nr].bioc = bioc;
>  	bio->bi_private = &bioc->stripes[dev_nr];
>  	bio->bi_end_io = btrfs_end_bio;
>  	bio->bi_iter.bi_sector = physical >> 9;
> +
> +	btrfs_bio_counter_inc_noblocked(fs_info);
> +
> +	if (!dev || !dev->bdev ||
> +	    test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state) ||
> +	    (btrfs_op(bio) == BTRFS_MAP_WRITE &&
> +	     !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))) {
> +		bio_io_error(bio);
> +		return;
> +	}
> +
> +	bio_set_dev(bio, dev->bdev);
> +	

Extra tabbed newline. There's at least one more checkpatch failure like
this one in the series.

>  	/*
>  	 * For zone append writing, bi_sector must point the beginning of the
>  	 * zone
> @@ -6729,8 +6728,6 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc,
>  		(unsigned long)dev->bdev->bd_dev, rcu_str_deref(dev->name),
>  		dev->devid, bio->bi_iter.bi_size);
>  
> -	btrfs_bio_counter_inc_noblocked(fs_info);
> -
>  	btrfsic_check_bio(bio);
>  	submit_bio(bio);
>  }
> @@ -6760,7 +6757,6 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
>  	bioc->orig_bio = bio;
>  	bioc->private = bio->bi_private;
>  	bioc->end_io = bio->bi_end_io;
> -	atomic_set(&bioc->stripes_pending, total_devs);
>  
>  	if ((bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) &&
>  	    ((btrfs_op(bio) == BTRFS_MAP_WRITE) || (mirror_num > 1))) {
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index c0f5bbba9c6ac..ecbaf92323030 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -444,7 +444,6 @@ struct btrfs_discard_stripe {
>   */
>  struct btrfs_io_context {
>  	refcount_t refs;
> -	atomic_t stripes_pending;
>  	struct btrfs_fs_info *fs_info;
>  	u64 map_type; /* get from map_lookup->type */
>  	bio_end_io_t *end_io;
> -- 
> 2.30.2
> 
