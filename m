Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48C4551279
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jun 2022 10:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239845AbiFTISH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jun 2022 04:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239850AbiFTISH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jun 2022 04:18:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3A511A27
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jun 2022 01:18:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C5F2B1F896;
        Mon, 20 Jun 2022 08:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655713084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=di41xd9o8K4yGx25hoAH/bgX4NWJswv9lqyhPpGiiIA=;
        b=NyZMPTA20syfL1tv41p4soIkT7Q9NjgadZAtq64JiewrV1bKkvC2q3iQ6WJcD180rWn/oD
        Dv6F/3XG9mzfrbNrJn+Y+NBKAkpkJFUKbM3fEauPxbtS5YdbomYotCasj4hkUG+Wxkg4OG
        oFuksGkgy5Kz0Nrwze8uMj9EHmSXeBk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7AF1513638;
        Mon, 20 Jun 2022 08:18:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8oFaGzwtsGI1HwAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 20 Jun 2022 08:18:04 +0000
Message-ID: <bc18e270-371c-98ee-28c2-fd4305206d7a@suse.com>
Date:   Mon, 20 Jun 2022 11:18:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 10/10] btrfs: remove bioc->stripes_pending
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220617100414.1159680-1-hch@lst.de>
 <20220617100414.1159680-11-hch@lst.de>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220617100414.1159680-11-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 17.06.22 г. 13:04 ч., Christoph Hellwig wrote:
> Replace the stripes_pending field with the pending counter in the bio.
> This avoid an extra field and prepares splitting the btrfs_bio at the
> stripe boundary.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/volumes.c | 100 ++++++++++++++++++++++-----------------------
>   fs/btrfs/volumes.h |   1 -
>   2 files changed, 48 insertions(+), 53 deletions(-)
> 

<snip>

>   
>   static void btrfs_end_bio(struct bio *bio)
>   {
>   	struct btrfs_io_stripe *stripe = bio->bi_private;
>   	struct btrfs_io_context *bioc = stripe->bioc;
> +	struct bio *orig_bio = bioc->orig_bio;
> +	struct btrfs_bio *bbio = btrfs_bio(orig_bio);
>   
>   	if (bio->bi_status) {
>   		atomic_inc(&bioc->error);
> -		if (bio->bi_status == BLK_STS_IOERR ||
> -		    bio->bi_status == BLK_STS_TARGET) {
> +		if (stripe->dev && stripe->dev->bdev &&
> +		    (bio->bi_status == BLK_STS_IOERR ||
> +		     bio->bi_status == BLK_STS_TARGET)) {
>   			if (btrfs_op(bio) == BTRFS_MAP_WRITE)
>   				btrfs_dev_stat_inc_and_print(stripe->dev,
>   						BTRFS_DEV_STAT_WRITE_ERRS);
> @@ -6678,12 +6652,35 @@ static void btrfs_end_bio(struct bio *bio)
>   		}
>   	}
>   
> -	if (bio != bioc->orig_bio)
> +	btrfs_bio_counter_dec(bioc->fs_info);
> +
> +	if (bio != orig_bio) {
> +		bio_endio(orig_bio);
>   		bio_put(bio);
> +		return;
> +	}

What if the the currently completed stripe bio is the last - then 
bio_endio would be called for orig_bio, which will executed bi_end_io() 
in softirq context, but for reads we want to execute this in process 
context (as per the below code) ?


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

The old code guaranteed that btrfs_end_bioc() is executed when the last 
stripe bio was completed. With this new scheme, say we have 3 bios - 2 
cloned, 1 being the orig, what guarantees that the orig_bio won't be 
finished before the remaining 2 (or 1) cloned/stripe bios thus calling 
btrfs_end_bio() on orig bio with __bi_remaining potentially being 2 or 1 
and finally calling orig_bio->bi_end_io() again with __bi_remaining 
being elevated?

>   }
>   
>   static void submit_stripe_bio(struct btrfs_io_context *bioc,
> @@ -6694,28 +6691,30 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc,
>   	u64 physical = bioc->stripes[dev_nr].physical;
>   	struct bio *bio;
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
>   	if (clone) {
> -		bio = bio_alloc_clone(dev->bdev, orig_bio, GFP_NOFS, &fs_bio_set);
> +		bio = bio_alloc_clone(NULL, orig_bio, GFP_NOFS, &fs_bio_set);
> +		bio_inc_remaining(orig_bio);

When cloning why aren't you passing dev->bdev but instead set it after 
the checks via bio_set_dev ? Is it because of the

if (bio->bi_bdev && bio_flagged(bio, BIO_TRACE_COMPLETION))

check inside bio_endio in case bio_io_error is called in submit_stripe_bio?

<snip>
