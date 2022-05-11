Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2D1523D4C
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 May 2022 21:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242629AbiEKTUx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 May 2022 15:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345297AbiEKTUw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 May 2022 15:20:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522DE23161
        for <linux-btrfs@vger.kernel.org>; Wed, 11 May 2022 12:20:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 701851F8D7;
        Wed, 11 May 2022 19:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652296849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qhJDqL7ccRmzQqIryQLhktQUmyTw/1iZf9CZeZnP03w=;
        b=EoUiYeUmiu6QnXzw63c0Om5BMMZpfVevL30ALoUSYxqAFPC7owl7LnveGipRp3moEtxYp6
        xVYYbd9Nn3Ce2UaWfYDQLlkFRVjXtPCGGxCfVOsPPPeeYxjQWk6im84f9DWBk2X7uBlDSf
        FvF6F3+ukWqY+Wk3j0fluX9jKXx4PPc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1401A13A76;
        Wed, 11 May 2022 19:20:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WfAOApEMfGIsCwAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 11 May 2022 19:20:49 +0000
Message-ID: <f8d90519-9911-fde0-9b18-3e4f339590c3@suse.com>
Date:   Wed, 11 May 2022 22:20:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 06/10] btrfs: don't use btrfs_bio_wq_end_io for compressed
 writes
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220504122524.558088-1-hch@lst.de>
 <20220504122524.558088-7-hch@lst.de>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220504122524.558088-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 4.05.22 г. 15:25 ч., Christoph Hellwig wrote:
> Compressed write bio completion is the only user of btrfs_bio_wq_end_io
> for writes, and the use of btrfs_bio_wq_end_io is a little suboptimal
> here as we only real need user context for the final completion of a
> compressed_bio structure, and not every single bio completion.
> 
> Add a work_struct to struct compressed_bio instead and use that to call
> finish_compressed_bio_write.  This allows to remove all handling of
> write bios in the btrfs_bio_wq_end_io infrastructure.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/compression.c | 45 +++++++++++++++++++++---------------------
>   fs/btrfs/compression.h |  7 +++++--
>   fs/btrfs/ctree.h       |  2 +-
>   fs/btrfs/disk-io.c     | 30 +++++++++++-----------------
>   fs/btrfs/super.c       |  2 --
>   5 files changed, 41 insertions(+), 45 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index f4564f32f6d93..9d5986a30a4a2 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -403,6 +403,14 @@ static void finish_compressed_bio_write(struct compressed_bio *cb)
>   	kfree(cb);
>   }
>   
> +static void btrfs_finish_compressed_write_work(struct work_struct *work)
> +{
> +	struct compressed_bio *cb =
> +		container_of(work, struct compressed_bio, write_end_work);
> +
> +	finish_compressed_bio_write(cb);
> +}
> +
>   /*
>    * Do the cleanup once all the compressed pages hit the disk.  This will clear
>    * writeback on the file pages and free the compressed pages.
> @@ -414,29 +422,16 @@ static void end_compressed_bio_write(struct bio *bio)
>   {
>   	struct compressed_bio *cb = bio->bi_private;
>   
> -	if (!dec_and_test_compressed_bio(cb, bio))
> -		goto out;
> -
> -	btrfs_record_physical_zoned(cb->inode, cb->start, bio);
> +	if (dec_and_test_compressed_bio(cb, bio)) {
> +		struct btrfs_fs_info *fs_info = btrfs_sb(cb->inode->i_sb);
>   
> -	finish_compressed_bio_write(cb);
> -out:
> +		btrfs_record_physical_zoned(cb->inode, cb->start, bio);
> +		queue_work(fs_info->compressed_write_workers,
> +			   &cb->write_end_work);
> +	}
>   	bio_put(bio);
>   }
>   
> -static blk_status_t submit_compressed_bio(struct btrfs_fs_info *fs_info,
> -					  struct bio *bio, int mirror_num)
> -{
> -	blk_status_t ret;
> -
> -	ASSERT(bio->bi_iter.bi_size);
> -	ret = btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
> -	if (ret)
> -		return ret;
> -	ret = btrfs_map_bio(fs_info, bio, mirror_num);
> -	return ret;
> -}
> -
>   /*
>    * Allocate a compressed_bio, which will be used to read/write on-disk
>    * (aka, compressed) * data.
> @@ -533,7 +528,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
>   	cb->compressed_pages = compressed_pages;
>   	cb->compressed_len = compressed_len;
>   	cb->writeback = writeback;
> -	cb->orig_bio = NULL;
> +	INIT_WORK(&cb->write_end_work, btrfs_finish_compressed_write_work);
>   	cb->nr_pages = nr_pages;
>   
>   	if (blkcg_css)
> @@ -603,7 +598,8 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
>   					goto finish_cb;
>   			}
>   
> -			ret = submit_compressed_bio(fs_info, bio, 0);
> +			ASSERT(bio->bi_iter.bi_size);
> +			ret = btrfs_map_bio(fs_info, bio, 0);
>   			if (ret)
>   				goto finish_cb;
>   			bio = NULL;
> @@ -941,7 +937,12 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>   						  fs_info->sectorsize);
>   			sums += fs_info->csum_size * nr_sectors;
>   
> -			ret = submit_compressed_bio(fs_info, comp_bio, mirror_num);
> +			ASSERT(comp_bio->bi_iter.bi_size);
> +			ret = btrfs_bio_wq_end_io(fs_info, comp_bio,
> +						  BTRFS_WQ_ENDIO_DATA);
> +			if (ret)
> +				goto finish_cb;
> +			ret = btrfs_map_bio(fs_info, comp_bio, mirror_num);
>   			if (ret)
>   				goto finish_cb;
>   			comp_bio = NULL;
> diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
> index 2707404389a5d..4a40725cbf1db 100644
> --- a/fs/btrfs/compression.h
> +++ b/fs/btrfs/compression.h
> @@ -61,8 +61,11 @@ struct compressed_bio {
>   	blk_status_t status;
>   	int mirror_num;
>   
> -	/* for reads, this is the bio we are copying the data into */
> -	struct bio *orig_bio;
> +	union {
> +		/* for reads, this is the bio we are copying the data into */
> +		struct bio *orig_bio;
> +		struct work_struct write_end_work;
> +	};
>   
>   	/*
>   	 * the start of a variable length array of checksums only
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index a3739143bf44c..6cf699959286d 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -855,7 +855,7 @@ struct btrfs_fs_info {
>   	struct btrfs_workqueue *endio_meta_workers;
>   	struct workqueue_struct *endio_raid56_workers;
>   	struct workqueue_struct *rmw_workers;
> -	struct btrfs_workqueue *endio_meta_write_workers;
> +	struct workqueue_struct *compressed_write_workers;
>   	struct btrfs_workqueue *endio_write_workers;
>   	struct btrfs_workqueue *endio_freespace_worker;
>   	struct btrfs_workqueue *caching_workers;
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index ef117eaab468c..aa56ba9378e1f 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -748,19 +748,10 @@ static void end_workqueue_bio(struct bio *bio)
>   	fs_info = end_io_wq->info;
>   	end_io_wq->status = bio->bi_status;
>   
> -	if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
> -		if (end_io_wq->metadata == BTRFS_WQ_ENDIO_METADATA)
> -			wq = fs_info->endio_meta_write_workers;
> -		else if (end_io_wq->metadata == BTRFS_WQ_ENDIO_FREE_SPACE)
> -			wq = fs_info->endio_freespace_worker;
> -		else
> -			wq = fs_info->endio_write_workers;
> -	} else {
> -		if (end_io_wq->metadata)
> -			wq = fs_info->endio_meta_workers;
> -		else
> -			wq = fs_info->endio_workers;
> -	}
> +	if (end_io_wq->metadata)
> +		wq = fs_info->endio_meta_workers;
> +	else
> +		wq = fs_info->endio_workers;
>   
>   	btrfs_init_work(&end_io_wq->work, end_workqueue_fn, NULL, NULL);
>   	btrfs_queue_work(wq, &end_io_wq->work);
> @@ -771,6 +762,9 @@ blk_status_t btrfs_bio_wq_end_io(struct btrfs_fs_info *info, struct bio *bio,
>   {
>   	struct btrfs_end_io_wq *end_io_wq;
>   
> +	if (WARN_ON_ONCE(btrfs_op(bio) != BTRFS_MAP_WRITE))
> +		return BLK_STS_IOERR;

This is broken w.r.t to btrfs_submit_metadata_bio since in
that function the code is:

  if (btrfs_op(bio) != BTRFS_MAP_WRITE) {
                       /*
                        * called for a read, do the setup so that checksum validation
                        * can happen in the async kernel threads
                        */
                     ret = btrfs_bio_wq_end_io(fs_info, bio,
                                                 BTRFS_WQ_ENDIO_METADATA);
                       if (!ret)
                               ret = btrfs_map_bio(fs_info, bio, mirror_num);



So metadata reads  will end up in function which disallows reads..
This results in failure to mount when reading various metadata.

I guess the correct fix is to include the following hunk from patch 8 in this series:

@@ -916,14 +839,7 @@ void btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio, int mirror_
  	bio->bi_opf |= REQ_META;
  
  	if (btrfs_op(bio) != BTRFS_MAP_WRITE) {
-		/*
-		 * called for a read, do the setup so that checksum validation
-		 * can happen in the async kernel threads
-		 */
-		ret = btrfs_bio_wq_end_io(fs_info, bio,
-					  BTRFS_WQ_ENDIO_METADATA);
-		if (!ret)
-			ret = btrfs_map_bio(fs_info, bio, mirror_num);
+		ret = btrfs_map_bio(fs_info, bio, mirror_num);





> +
>   	end_io_wq = kmem_cache_alloc(btrfs_end_io_wq_cache, GFP_NOFS);
>   	if (!end_io_wq)
>   		return BLK_STS_RESOURCE;
> @@ -2273,6 +2267,8 @@ static void btrfs_stop_all_workers(struct btrfs_fs_info *fs_info)
>   		destroy_workqueue(fs_info->endio_raid56_workers);
>   	if (fs_info->rmw_workers)
>   		destroy_workqueue(fs_info->rmw_workers);
> +	if (fs_info->compressed_write_workers)
> +		destroy_workqueue(fs_info->compressed_write_workers);
>   	btrfs_destroy_workqueue(fs_info->endio_write_workers);
>   	btrfs_destroy_workqueue(fs_info->endio_freespace_worker);
>   	btrfs_destroy_workqueue(fs_info->delayed_workers);
> @@ -2287,7 +2283,6 @@ static void btrfs_stop_all_workers(struct btrfs_fs_info *fs_info)
>   	 * queues can do metadata I/O operations.
>   	 */
>   	btrfs_destroy_workqueue(fs_info->endio_meta_workers);
> -	btrfs_destroy_workqueue(fs_info->endio_meta_write_workers);
>   }
>   
>   static void free_root_extent_buffers(struct btrfs_root *root)
> @@ -2469,15 +2464,14 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
>   	fs_info->endio_meta_workers =
>   		btrfs_alloc_workqueue(fs_info, "endio-meta", flags,
>   				      max_active, 4);
> -	fs_info->endio_meta_write_workers =
> -		btrfs_alloc_workqueue(fs_info, "endio-meta-write", flags,
> -				      max_active, 2);
>   	fs_info->endio_raid56_workers =
>   		alloc_workqueue("btrfs-endio-raid56", flags, max_active);
>   	fs_info->rmw_workers = alloc_workqueue("btrfs-rmw", flags, max_active);
>   	fs_info->endio_write_workers =
>   		btrfs_alloc_workqueue(fs_info, "endio-write", flags,
>   				      max_active, 2);
> +	fs_info->compressed_write_workers =
> +		alloc_workqueue("btrfs-compressed-write", flags, max_active);
>   	fs_info->endio_freespace_worker =
>   		btrfs_alloc_workqueue(fs_info, "freespace-write", flags,
>   				      max_active, 0);
> @@ -2492,7 +2486,7 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
>   	if (!(fs_info->workers && fs_info->hipri_workers &&
>   	      fs_info->delalloc_workers && fs_info->flush_workers &&
>   	      fs_info->endio_workers && fs_info->endio_meta_workers &&
> -	      fs_info->endio_meta_write_workers &&
> +	      fs_info->compressed_write_workers &&
>   	      fs_info->endio_write_workers && fs_info->endio_raid56_workers &&
>   	      fs_info->endio_freespace_worker && fs_info->rmw_workers &&
>   	      fs_info->caching_workers && fs_info->fixup_workers &&
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index b1fdc6a26c76e..9c683c466d585 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -1908,8 +1908,6 @@ static void btrfs_resize_thread_pool(struct btrfs_fs_info *fs_info,
>   	btrfs_workqueue_set_max(fs_info->caching_workers, new_pool_size);
>   	btrfs_workqueue_set_max(fs_info->endio_workers, new_pool_size);
>   	btrfs_workqueue_set_max(fs_info->endio_meta_workers, new_pool_size);
> -	btrfs_workqueue_set_max(fs_info->endio_meta_write_workers,
> -				new_pool_size);
>   	btrfs_workqueue_set_max(fs_info->endio_write_workers, new_pool_size);
>   	btrfs_workqueue_set_max(fs_info->endio_freespace_worker, new_pool_size);
>   	btrfs_workqueue_set_max(fs_info->delayed_workers, new_pool_size);
