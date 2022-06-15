Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AC954CF44
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 19:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355474AbiFORB2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jun 2022 13:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349890AbiFOQ7E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jun 2022 12:59:04 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785BB2DAB3
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 09:59:02 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 9780D5C013B;
        Wed, 15 Jun 2022 12:59:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 15 Jun 2022 12:59:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1655312341; x=1655398741; bh=6kfTnqx9sc
        Xfdlf6eD4y7UtdKew/3Kos5liPoyVjN4Y=; b=CiamRvOC/NK0OfQ3Q2EUSt4opW
        cINwuCdQG0fyF14ZVykFV20ni8J93CT4RqC4FaxXA4L4CX9EAIrpeVpcpTBxOKZ3
        cszIdtDP4Xkw8BlGmESY3TWeggMAWhazZgHGYUfzn6W2LkkNfiJJ0ZcDJC2SMsag
        dR9Yzsb+GHfDTrjtaXsj4QmZeNBHrGrIBrjJ85/w7VyNK4s/PWIkyeSwuvV8GFME
        dBtqStiKOPqBUohWs2Mclw11OHxTGQJvTIWpD/aLTOmQBVoB1nbSNFwe2lfJ0exd
        VuQvVauhRa9tWCEBN23f21NawiVQx3Kju8073mCFCI0DLmgmIpOC7eOvPf1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1655312341; x=1655398741; bh=6kfTnqx9scXfdlf6eD4y7UtdKew/
        3Kos5liPoyVjN4Y=; b=ECwvbmLja40i7s232QqcvetY1KFu9R11c0IezzQg90Ji
        FcX0lMDjW6XG2uulvivmquAGwpFRgOKrJ5Vm+k3hqj9usQiPjknvf0xC3X/Jwwfy
        XEISa5JOxU6yRyQGz+k3ohb7rXmtJwYtDhfk4RXR2XkGqPrGKncB6kWkk0b1z+pY
        BTc3MDB1cop+R7lE9B9VEXWFIhgRAOVDeli7PLh7WQw6nPZ79nF1HYGIWiee0pGP
        fgCJV0Dha38VVIrHVUOoISXGFg+k1317qN6VGtFfbNl/Spc/rJYUQiJru9LbCIBA
        bWCBu2ZTo4bOpq9fn5vvfHpefJPUdQwbfKzLofICgA==
X-ME-Sender: <xms:1Q-qYhlifwzbxrSnoL88dm_B62tOeTFF2ndre7b9hNv8Y720OKTbjQ>
    <xme:1Q-qYs1WYSmcqt9YUd-6uSC0GNrI9PoV2c_iYrqmjiRNX0KcHfxIDxi1CyY3AQtmQ
    x7YtpOv3L96YFvvC0A>
X-ME-Received: <xmr:1Q-qYnp7ytR3ZfZ8PktwD35hPEJpJbiE8clcUq8QlUOGKZ4aL_hiX5CVgpkKEOUwBczYx4D4rBjsvRtvk6ddrIhEiuh3AA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddvuddguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:1Q-qYhmbgWprM8hFhlp2pI0eRSggtp98WKbUK8FLbMGNVl2DOF9arQ>
    <xmx:1Q-qYv1D168TZX7YvFr07Ns8LAXZZ61yxgDMDfeJ_BTuC9_uRygd0A>
    <xmx:1Q-qYgvd39lzzTc8uxwM-F4gL1QOXJX-qOhlTiQdwvbrnYMnKX3eBg>
    <xmx:1Q-qYgy5ZM3QP3b_raNEMxt6kC8umIjIYUWi-6lhqQO-Oot7QI6JLw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jun 2022 12:59:00 -0400 (EDT)
Date:   Wed, 15 Jun 2022 09:59:38 -0700
From:   Boris Burkov <boris@bur.io>
To:     Christoph Hellwig <hch@lst.de>
Cc:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/5] btrfs: remove the btrfs_map_bio return value
Message-ID: <YqoP+t4bNsgPd6u7@zen>
References: <20220615151515.888424-1-hch@lst.de>
 <20220615151515.888424-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615151515.888424-4-hch@lst.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 15, 2022 at 05:15:13PM +0200, Christoph Hellwig wrote:
> Always consume the bio and call the end_io handler on error instead of
> returning an error and letting the caller handle it.  This matches
> what the block layer submission does and avoids any confusion on who
> needs to handle errors.
> 
> As this requires touching all the callers, rename the function to
> btrfs_submit_bio, which describes the functionality much better.

One high level question: should we make btrfs_wq_submit_bio follow the
same API of not having the caller call bio_endio? The names are similar
enough that having them behave the same seems useful.

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/btrfs/compression.c |  8 ++------
>  fs/btrfs/disk-io.c     | 21 ++++++++++-----------
>  fs/btrfs/inode.c       | 25 ++++++++++---------------
>  fs/btrfs/volumes.c     | 13 ++++++++-----
>  fs/btrfs/volumes.h     |  4 ++--
>  5 files changed, 32 insertions(+), 39 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 63d542961b78a..907fc8a4c092c 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -593,9 +593,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
>  			}
>  
>  			ASSERT(bio->bi_iter.bi_size);
> -			ret = btrfs_map_bio(fs_info, bio, 0);
> -			if (ret)
> -				goto finish_cb;
> +			btrfs_submit_bio(fs_info, bio, 0);
>  			bio = NULL;
>  		}
>  		cond_resched();
> @@ -931,9 +929,7 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>  			sums += fs_info->csum_size * nr_sectors;
>  
>  			ASSERT(comp_bio->bi_iter.bi_size);
> -			ret = btrfs_map_bio(fs_info, comp_bio, mirror_num);
> -			if (ret)
> -				goto finish_cb;
> +			btrfs_submit_bio(fs_info, comp_bio, mirror_num);
>  			comp_bio = NULL;
>  		}
>  	}
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 800ad3a9c68ed..5df6865428a5c 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -728,7 +728,6 @@ static void run_one_async_done(struct btrfs_work *work)
>  {
>  	struct async_submit_bio *async;
>  	struct inode *inode;
> -	blk_status_t ret;
>  
>  	async = container_of(work, struct  async_submit_bio, work);
>  	inode = async->inode;
> @@ -746,11 +745,7 @@ static void run_one_async_done(struct btrfs_work *work)
>  	 * This changes nothing when cgroups aren't in use.
>  	 */
>  	async->bio->bi_opf |= REQ_CGROUP_PUNT;
> -	ret = btrfs_map_bio(btrfs_sb(inode->i_sb), async->bio, async->mirror_num);
> -	if (ret) {
> -		async->bio->bi_status = ret;
> -		bio_endio(async->bio);
> -	}
> +	btrfs_submit_bio(btrfs_sb(inode->i_sb), async->bio, async->mirror_num);
>  }
>  
>  static void run_one_async_free(struct btrfs_work *work)
> @@ -814,7 +809,7 @@ static blk_status_t btree_submit_bio_start(struct inode *inode, struct bio *bio,
>  {
>  	/*
>  	 * when we're called for a write, we're already in the async
> -	 * submission context.  Just jump into btrfs_map_bio
> +	 * submission context.  Just jump into btrfs_submit_bio.
>  	 */
>  	return btree_csum_one_bio(bio);
>  }
> @@ -839,11 +834,15 @@ void btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio, int mirror_
>  	bio->bi_opf |= REQ_META;
>  
>  	if (btrfs_op(bio) != BTRFS_MAP_WRITE) {
> -		ret = btrfs_map_bio(fs_info, bio, mirror_num);
> -	} else if (!should_async_write(fs_info, BTRFS_I(inode))) {
> +		btrfs_submit_bio(fs_info, bio, mirror_num);
> +		return;
> +	}
> +	if (!should_async_write(fs_info, BTRFS_I(inode))) {
>  		ret = btree_csum_one_bio(bio);
> -		if (!ret)
> -			ret = btrfs_map_bio(fs_info, bio, mirror_num);
> +		if (!ret) {
> +			btrfs_submit_bio(fs_info, bio, mirror_num);
> +			return;
> +		}
>  	} else {
>  		/*
>  		 * kthread helpers are used to submit writes so that
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 7a54f964ff378..6f665bf59f620 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2617,7 +2617,8 @@ void btrfs_submit_data_write_bio(struct inode *inode, struct bio *bio, int mirro
>  			goto out;
>  		}
>  	}
> -	ret = btrfs_map_bio(fs_info, bio, mirror_num);
> +	btrfs_submit_bio(fs_info, bio, mirror_num);
> +	return;
>  out:
>  	if (ret) {
>  		bio->bi_status = ret;
> @@ -2645,14 +2646,13 @@ void btrfs_submit_data_read_bio(struct inode *inode, struct bio *bio,
>  	 * not, which is why we ignore skip_sum here.
>  	 */
>  	ret = btrfs_lookup_bio_sums(inode, bio, NULL);
> -	if (ret)
> -		goto out;
> -	ret = btrfs_map_bio(fs_info, bio, mirror_num);
> -out:
>  	if (ret) {
>  		bio->bi_status = ret;
>  		bio_endio(bio);
> +		return;
>  	}
> +
> +	btrfs_submit_bio(fs_info, bio, mirror_num);
>  }
>  
>  /*
> @@ -7863,8 +7863,7 @@ static void submit_dio_repair_bio(struct inode *inode, struct bio *bio,
>  	BUG_ON(bio_op(bio) == REQ_OP_WRITE);
>  
>  	refcount_inc(&dip->refs);
> -	if (btrfs_map_bio(fs_info, bio, mirror_num))

With this change, won't we no longer do this refcount_dec on error?
Does bio_endio do it or something? On the other hand, I feel like we
would not have called bio_endio in this path before and now we do.

More generally, were you able to exercise the error paths in this code?

> -		refcount_dec(&dip->refs);
> +	btrfs_submit_bio(fs_info, bio, mirror_num);
>  }
>  
>  static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
> @@ -7972,7 +7971,8 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
>  						      file_offset - dip->file_offset);
>  	}
>  map:
> -	return btrfs_map_bio(fs_info, bio, 0);
> +	btrfs_submit_bio(fs_info, bio, 0);
> +	return BLK_STS_OK;
>  }
>  
>  static void btrfs_submit_direct(const struct iomap_iter *iter,
> @@ -10277,7 +10277,6 @@ static blk_status_t submit_encoded_read_bio(struct btrfs_inode *inode,
>  					    struct bio *bio, int mirror_num)
>  {
>  	struct btrfs_encoded_read_private *priv = bio->bi_private;
> -	struct btrfs_bio *bbio = btrfs_bio(bio);
>  	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>  	blk_status_t ret;
>  
> @@ -10288,12 +10287,8 @@ static blk_status_t submit_encoded_read_bio(struct btrfs_inode *inode,
>  	}
>  
>  	atomic_inc(&priv->pending);
> -	ret = btrfs_map_bio(fs_info, bio, mirror_num);
> -	if (ret) {
> -		atomic_dec(&priv->pending);

Same question as above

> -		btrfs_bio_free_csum(bbio);
> -	}
> -	return ret;
> +	btrfs_submit_bio(fs_info, bio, mirror_num);
> +	return BLK_STS_OK;
>  }
>  
>  static blk_status_t btrfs_encoded_read_verify_csum(struct btrfs_bio *bbio)
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index ff777e39d5f4a..739676944e94d 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6724,8 +6724,8 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc,
>  		}
>  	}
>  	btrfs_debug_in_rcu(fs_info,
> -	"btrfs_map_bio: rw %d 0x%x, sector=%llu, dev=%lu (%s id %llu), size=%u",
> -		bio_op(bio), bio->bi_opf, bio->bi_iter.bi_sector,
> +	"%s: rw %d 0x%x, sector=%llu, dev=%lu (%s id %llu), size=%u",
> +		__func__, bio_op(bio), bio->bi_opf, bio->bi_iter.bi_sector,
>  		(unsigned long)dev->bdev->bd_dev, rcu_str_deref(dev->name),
>  		dev->devid, bio->bi_iter.bi_size);
>  
> @@ -6735,8 +6735,8 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc,
>  	submit_bio(bio);
>  }
>  
> -blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
> -			   int mirror_num)
> +void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
> +		      int mirror_num)
>  {
>  	u64 logical = bio->bi_iter.bi_sector << 9;
>  	u64 length = bio->bi_iter.bi_size;
> @@ -6781,7 +6781,10 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
>  	}
>  out_dec:
>  	btrfs_bio_counter_dec(fs_info);
> -	return errno_to_blk_status(ret);
> +	if (ret) {
> +		bio->bi_status = errno_to_blk_status(ret);
> +		bio_endio(bio);
> +	}
>  }
>  
>  static bool dev_args_match_fs_devices(const struct btrfs_dev_lookup_args *args,
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 588367c76c463..c0f5bbba9c6ac 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -573,8 +573,8 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info);
>  struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
>  					    u64 type);
>  void btrfs_mapping_tree_free(struct extent_map_tree *tree);
> -blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
> -			   int mirror_num);
> +void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
> +		      int mirror_num);
>  int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
>  		       fmode_t flags, void *holder);
>  struct btrfs_device *btrfs_scan_one_device(const char *path,
> -- 
> 2.30.2
> 
