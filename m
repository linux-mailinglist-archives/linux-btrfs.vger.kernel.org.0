Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F91D567157
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Jul 2022 16:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbiGEOkd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jul 2022 10:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbiGEOk0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Jul 2022 10:40:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B69A1AD
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 07:40:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C0D8B2246E;
        Tue,  5 Jul 2022 14:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657032023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x5rBuowXigbhMsh7vUUQ2PFeU+YwmWf7EM48N0N2T/s=;
        b=RDbnaCjVz0WKl7Y3/Z6S3HRKag5OCtT0dVj6s5pSiRe92CCjvQ4psU5IIqclf37SWZwDmK
        4uo6rjGhhj/yMuDHzNKde7LtIrYi4ZJUYNf3zjiVEPuVPxoz7aBuFUG6PNRMIba6xd0F6G
        xdfcQvo7zA8H6luykI6eFYaHX/p4ckA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5C2AF1339A;
        Tue,  5 Jul 2022 14:40:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3dq4E1dNxGIjBgAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 05 Jul 2022 14:40:23 +0000
Message-ID: <47d3c2ee-e602-b6be-bd48-d6d913455a29@suse.com>
Date:   Tue, 5 Jul 2022 17:40:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/4] btrfs: simplify the pending I/O counting in struct
 compressed_bio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Boris Burkov <boris@bur.io>
References: <20220630160130.2550001-1-hch@lst.de>
 <20220630160130.2550001-2-hch@lst.de>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220630160130.2550001-2-hch@lst.de>
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



On 30.06.22 г. 19:01 ч., Christoph Hellwig wrote:
> Instead of counting the bytes just count the bios, with an extra
> reference held during submission.  This significantly simplifies the
> submission side error handling.
> 
> This reverts the change commit 6ec9765d746d ("btrfs: introduce
> compressed_bio::pending_sectors to trace compressed bio") that moved to
> counting sectors, but unlike the state before that commit the extra
> reference held during the submission actually keeps the refcounting
> sane.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>   fs/btrfs/compression.c | 126 ++++++++++-------------------------------
>   fs/btrfs/compression.h |   4 +-
>   2 files changed, 33 insertions(+), 97 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 907fc8a4c092c..e756da640fd7b 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -191,44 +191,6 @@ static int check_compressed_csum(struct btrfs_inode *inode, struct bio *bio,
>   	return 0;
>   }
>   

<snip>


>   		btrfs_record_physical_zoned(cb->inode, cb->start, bio);
> @@ -476,7 +444,7 @@ static struct bio *alloc_compressed_bio(struct compressed_bio *cb, u64 disk_byte
>   		return ERR_PTR(ret);
>   	}
>   	*next_stripe_start = disk_bytenr + geom.len;
> -
> +	refcount_inc(&cb->pending_ios);
>   	return bio;
>   }
>   
> @@ -503,17 +471,17 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
>   	struct compressed_bio *cb;
>   	u64 cur_disk_bytenr = disk_start;
>   	u64 next_stripe_start;
> -	blk_status_t ret;
>   	int skip_sum = inode->flags & BTRFS_INODE_NODATASUM;
>   	const bool use_append = btrfs_use_zone_append(inode, disk_start);
>   	const unsigned int bio_op = use_append ? REQ_OP_ZONE_APPEND : REQ_OP_WRITE;
> +	blk_status_t ret = BLK_STS_OK;
>   
>   	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
>   	       IS_ALIGNED(len, fs_info->sectorsize));
>   	cb = kmalloc(compressed_bio_size(fs_info, compressed_len), GFP_NOFS);
>   	if (!cb)
>   		return BLK_STS_RESOURCE;
> -	refcount_set(&cb->pending_sectors, compressed_len >> fs_info->sectorsize_bits);
> +	refcount_set(&cb->pending_ios, 1);
>   	cb->status = BLK_STS_OK;
>   	cb->inode = &inode->vfs_inode;
>   	cb->start = start;
> @@ -543,8 +511,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
>   				&next_stripe_start);
>   			if (IS_ERR(bio)) {
>   				ret = errno_to_blk_status(PTR_ERR(bio));
> -				bio = NULL;
> -				goto finish_cb;
> +				break;
>   			}
>   			if (blkcg_css)
>   				bio->bi_opf |= REQ_CGROUP_PUNT;
> @@ -588,8 +555,11 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
>   		if (submit) {
>   			if (!skip_sum) {
>   				ret = btrfs_csum_one_bio(inode, bio, start, true);
> -				if (ret)
> -					goto finish_cb;
> +				if (ret) {
> +					bio->bi_status = ret;
> +					bio_endio(bio);
> +					break;
> +				}
>   			}
>   
>   			ASSERT(bio->bi_iter.bi_size);
> @@ -598,33 +568,12 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
>   		}
>   		cond_resched();
>   	}
> -	if (blkcg_css)
> -		kthread_associate_blkcg(NULL);
>   
> -	return 0;
> -
> -finish_cb:
>   	if (blkcg_css)
>   		kthread_associate_blkcg(NULL);
>   
> -	if (bio) {
> -		bio->bi_status = ret;
> -		bio_endio(bio);
> -	}
> -	/* Last byte of @cb is submitted, endio will free @cb */
> -	if (cur_disk_bytenr == disk_start + compressed_len)
> -		return ret;
> -
> -	wait_var_event(cb, refcount_read(&cb->pending_sectors) ==
> -			   (disk_start + compressed_len - cur_disk_bytenr) >>
> -			   fs_info->sectorsize_bits);
> -	/*
> -	 * Even with previous bio ended, we should still have io not yet
> -	 * submitted, thus need to finish manually.
> -	 */
> -	ASSERT(refcount_read(&cb->pending_sectors));
> -	/* Now we are the only one referring @cb, can finish it safely. */
> -	finish_compressed_bio_write(cb);
> +	if (refcount_dec_and_test(&cb->pending_ios))
> +		finish_compressed_bio_write(cb);

nit: This slightly changes the semantics of the function because with 
the old code the bio could have been completed in 
submit_compressed_write iff there was an error during submission for one 
of the sub-bios. Whilst with this new code there is a chance even in the 
success case this happens (if the sub bios complete by the time we 
arrive at this code). Generally that'd be very unlikely due to io 
latency and indeed this code becomes effective iff there is an error. 
Personally I'd like such changes to be called out explicitly in the 
change log or at least with a comment. I guess this ties into the "keeps 
ref counting sane" in the changelog but what exactly do you mean by 
sane? I guess it ties into what Qu mentions in his changelog about 
ensuring the compressed bio is not freed/finished by some completing 
sub-bio _before_ the submitter had a chance to submit all sub-bios and 
that the old code was doing another subtle thing - setting the counter 
the pending bios to 1, and noot incrementing it when doing the final 
submission, thus ensuring everything works out.

I agree your code is much better however I'd like to have the above 
details put (perhaps slightly reworded) in the changelog so that those 
subtle aspects are more visible to someone reading it some months down 
the line :) .

<snip>
