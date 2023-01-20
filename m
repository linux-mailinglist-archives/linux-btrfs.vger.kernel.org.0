Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1AC674EEE
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jan 2023 09:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjATIFZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Jan 2023 03:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjATIFY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Jan 2023 03:05:24 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC42A40D6
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Jan 2023 00:05:22 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MtwUm-1oQwrD3yKS-00uF7R; Fri, 20
 Jan 2023 09:05:12 +0100
Message-ID: <b6561756-40f9-67a3-49e6-d11cf5605fe5@gmx.com>
Date:   Fri, 20 Jan 2023 16:05:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] btrfs: the raid56 code does not need irqsafe locking
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
References: <20230120074657.1095829-1-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230120074657.1095829-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:lKdcDfpaZvRy9pUc9ym6pying/xwPvDFPRkJuX1V5Ickf/1AVrN
 bXLtEUzjN/upvdm9Kx+7+sGJCZFtsgQ+iuWWjsQ4rCXnNUianZ0Wau7EbgQcrqGttMv4khJ
 8tfAHF9OHf13GH5YVBMR7HhUDRA/aSI9/rdsfYyfU+EjeuALfRl8pbqT8s/iPsO/fseFfL0
 /q3f30EZih3hJ4xEQVDJw==
UI-OutboundReport: notjunk:1;M01:P0:1H2ujuHJiJw=;I2uZ3SF42aJ+g5IgpWv8tXXA74o
 h84ZzTilBQw8BwtK+V6MooXhquSde3pwlLSMSn45Z0o3dpFItEDotkjjkwMGrmn7EVkLoHCYm
 BJRbALBlWoaJjbScWu1v2P33bvsSE1DoxsFHO/Hi9M7Zl1PclEVMMHa/9zhYUSGht7wUyNvH4
 tcQy4qN0wYuiWchr76GOZsNMQlt6Eo1AlGNBrtOkqmMv7rpCeJc/ciiPFEikpHSTxPQoMNcZM
 DloZ7kJqul3ZOdaOJOnsKQe03akQ3/vgUVUO3HNbJfMrOIgO+G8Uxv7lZenWdInZBGJJVWa/V
 DrYY3qcICpqqHKKjfpmnwsiPl4wrXTQv0YKg3cFQsNSrJKb9YEcK8zUuklGnvkHhaW6j0V2u0
 x5SnAL9fs6mPfQNNTFAFcBaPegw3FHZZ1EZQlhkArvb3JGadw9CTNh6AwUSNN+QI69R0GY9nV
 h6ETUnC8MKhK9t3AzxSKz0DMPAjWxO0dFVnS8S3uIzy4Z47Sg1VYmWTdPjB9hagAe2bwXk0lg
 8iuhOTKA8/0uBdbyD+CN7v8xm9WdxOQ+0Y1knkCX5TyXjYqZSGnF9RDeeI7mTG4rEDh/SKs0A
 V3fE6VA5MqARnX+3NBF7UMWomZdbGiX9DoF4tv7avlD19DE5UsyajgziBlNMPaUqIRb6e5p9p
 Mhwv3lbRoq2VADLZBfANuvdqTU8O6/U890xjAtcKjmRdoqM/1XAGpMFypGMKHpqCqVBCcHq0t
 rZnS92EXgPDuUbYuQ3BVRJCBU4NNLjTZKai1EK0qGgm75Sm9G4DGTy7ipmBsAimTh4x3LF8B0
 iVHI5AP5KN5WczuELH6WMtDE58lf1bz+b+Teqko9UT4qTOjgrgMqo4ob6FebJS7G3Ya0rK+D+
 blL6nn1tjwO9qt+G/XLDM5WHPfPB9hd8qMS91MFcWG3ouQ83woNMcldylY0gkUesvMA96nz5F
 XyxRFUmgCKlg/hTDpwclafdxIjA=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/20 15:46, Christoph Hellwig wrote:
> These days all the operations that take locks in the raid56.c code
> are run from user context (mostly workqueues).  Drop all the irqsafe
> locking that is not required any more.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Indeed the only functions inside raid_wait_read_end_io() and 
raid_wait_write_end_io() needs spinlock.


And thanks to the patch, I exposed that for read/write endio, we lacks 
spinlocks for bitmap operations.

As we still have chances to have multiple bios for the same stripe, and 
bitmap operations themselves are not atomic.

Thanks,
Qu

> ---
> 
> Note: this sits on top of the "small raid56 cleanups v3" series
> 
>   fs/btrfs/raid56.c | 50 +++++++++++++++++++++--------------------------
>   1 file changed, 22 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index d8dd25a8155a52..23f6550ea663d5 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -407,16 +407,15 @@ static void __remove_rbio_from_cache(struct btrfs_raid_bio *rbio)
>   static void remove_rbio_from_cache(struct btrfs_raid_bio *rbio)
>   {
>   	struct btrfs_stripe_hash_table *table;
> -	unsigned long flags;
>   
>   	if (!test_bit(RBIO_CACHE_BIT, &rbio->flags))
>   		return;
>   
>   	table = rbio->bioc->fs_info->stripe_hash_table;
>   
> -	spin_lock_irqsave(&table->cache_lock, flags);
> +	spin_lock(&table->cache_lock);
>   	__remove_rbio_from_cache(rbio);
> -	spin_unlock_irqrestore(&table->cache_lock, flags);
> +	spin_unlock(&table->cache_lock);
>   }
>   
>   /*
> @@ -425,19 +424,18 @@ static void remove_rbio_from_cache(struct btrfs_raid_bio *rbio)
>   static void btrfs_clear_rbio_cache(struct btrfs_fs_info *info)
>   {
>   	struct btrfs_stripe_hash_table *table;
> -	unsigned long flags;
>   	struct btrfs_raid_bio *rbio;
>   
>   	table = info->stripe_hash_table;
>   
> -	spin_lock_irqsave(&table->cache_lock, flags);
> +	spin_lock(&table->cache_lock);
>   	while (!list_empty(&table->stripe_cache)) {
>   		rbio = list_entry(table->stripe_cache.next,
>   				  struct btrfs_raid_bio,
>   				  stripe_cache);
>   		__remove_rbio_from_cache(rbio);
>   	}
> -	spin_unlock_irqrestore(&table->cache_lock, flags);
> +	spin_unlock(&table->cache_lock);
>   }
>   
>   /*
> @@ -467,14 +465,13 @@ void btrfs_free_stripe_hash_table(struct btrfs_fs_info *info)
>   static void cache_rbio(struct btrfs_raid_bio *rbio)
>   {
>   	struct btrfs_stripe_hash_table *table;
> -	unsigned long flags;
>   
>   	if (!test_bit(RBIO_CACHE_READY_BIT, &rbio->flags))
>   		return;
>   
>   	table = rbio->bioc->fs_info->stripe_hash_table;
>   
> -	spin_lock_irqsave(&table->cache_lock, flags);
> +	spin_lock(&table->cache_lock);
>   	spin_lock(&rbio->bio_list_lock);
>   
>   	/* bump our ref if we were not in the list before */
> @@ -501,7 +498,7 @@ static void cache_rbio(struct btrfs_raid_bio *rbio)
>   			__remove_rbio_from_cache(found);
>   	}
>   
> -	spin_unlock_irqrestore(&table->cache_lock, flags);
> +	spin_unlock(&table->cache_lock);
>   }
>   
>   /*
> @@ -530,15 +527,14 @@ static void run_xor(void **pages, int src_cnt, ssize_t len)
>    */
>   static int rbio_is_full(struct btrfs_raid_bio *rbio)
>   {
> -	unsigned long flags;
>   	unsigned long size = rbio->bio_list_bytes;
>   	int ret = 1;
>   
> -	spin_lock_irqsave(&rbio->bio_list_lock, flags);
> +	spin_lock(&rbio->bio_list_lock);
>   	if (size != rbio->nr_data * BTRFS_STRIPE_LEN)
>   		ret = 0;
>   	BUG_ON(size > rbio->nr_data * BTRFS_STRIPE_LEN);
> -	spin_unlock_irqrestore(&rbio->bio_list_lock, flags);
> +	spin_unlock(&rbio->bio_list_lock);
>   
>   	return ret;
>   }
> @@ -657,14 +653,13 @@ static noinline int lock_stripe_add(struct btrfs_raid_bio *rbio)
>   	struct btrfs_stripe_hash *h;
>   	struct btrfs_raid_bio *cur;
>   	struct btrfs_raid_bio *pending;
> -	unsigned long flags;
>   	struct btrfs_raid_bio *freeit = NULL;
>   	struct btrfs_raid_bio *cache_drop = NULL;
>   	int ret = 0;
>   
>   	h = rbio->bioc->fs_info->stripe_hash_table->table + rbio_bucket(rbio);
>   
> -	spin_lock_irqsave(&h->lock, flags);
> +	spin_lock(&h->lock);
>   	list_for_each_entry(cur, &h->hash_list, hash_list) {
>   		if (cur->bioc->raid_map[0] != rbio->bioc->raid_map[0])
>   			continue;
> @@ -724,7 +719,7 @@ static noinline int lock_stripe_add(struct btrfs_raid_bio *rbio)
>   	refcount_inc(&rbio->refs);
>   	list_add(&rbio->hash_list, &h->hash_list);
>   out:
> -	spin_unlock_irqrestore(&h->lock, flags);
> +	spin_unlock(&h->lock);
>   	if (cache_drop)
>   		remove_rbio_from_cache(cache_drop);
>   	if (freeit)
> @@ -742,7 +737,6 @@ static noinline void unlock_stripe(struct btrfs_raid_bio *rbio)
>   {
>   	int bucket;
>   	struct btrfs_stripe_hash *h;
> -	unsigned long flags;
>   	int keep_cache = 0;
>   
>   	bucket = rbio_bucket(rbio);
> @@ -751,7 +745,7 @@ static noinline void unlock_stripe(struct btrfs_raid_bio *rbio)
>   	if (list_empty(&rbio->plug_list))
>   		cache_rbio(rbio);
>   
> -	spin_lock_irqsave(&h->lock, flags);
> +	spin_lock(&h->lock);
>   	spin_lock(&rbio->bio_list_lock);
>   
>   	if (!list_empty(&rbio->hash_list)) {
> @@ -788,7 +782,7 @@ static noinline void unlock_stripe(struct btrfs_raid_bio *rbio)
>   			list_add(&next->hash_list, &h->hash_list);
>   			refcount_inc(&next->refs);
>   			spin_unlock(&rbio->bio_list_lock);
> -			spin_unlock_irqrestore(&h->lock, flags);
> +			spin_unlock(&h->lock);
>   
>   			if (next->operation == BTRFS_RBIO_READ_REBUILD)
>   				start_async_work(next, recover_rbio_work_locked);
> @@ -808,7 +802,7 @@ static noinline void unlock_stripe(struct btrfs_raid_bio *rbio)
>   	}
>   done:
>   	spin_unlock(&rbio->bio_list_lock);
> -	spin_unlock_irqrestore(&h->lock, flags);
> +	spin_unlock(&h->lock);
>   
>   done_nolock:
>   	if (!keep_cache)
> @@ -891,16 +885,16 @@ static struct sector_ptr *sector_in_rbio(struct btrfs_raid_bio *rbio,
>   	index = stripe_nr * rbio->stripe_nsectors + sector_nr;
>   	ASSERT(index >= 0 && index < rbio->nr_sectors);
>   
> -	spin_lock_irq(&rbio->bio_list_lock);
> +	spin_lock(&rbio->bio_list_lock);
>   	sector = &rbio->bio_sectors[index];
>   	if (sector->page || bio_list_only) {
>   		/* Don't return sector without a valid page pointer */
>   		if (!sector->page)
>   			sector = NULL;
> -		spin_unlock_irq(&rbio->bio_list_lock);
> +		spin_unlock(&rbio->bio_list_lock);
>   		return sector;
>   	}
> -	spin_unlock_irq(&rbio->bio_list_lock);
> +	spin_unlock(&rbio->bio_list_lock);
>   
>   	return &rbio->stripe_sectors[index];
>   }
> @@ -1148,11 +1142,11 @@ static void index_rbio_pages(struct btrfs_raid_bio *rbio)
>   {
>   	struct bio *bio;
>   
> -	spin_lock_irq(&rbio->bio_list_lock);
> +	spin_lock(&rbio->bio_list_lock);
>   	bio_list_for_each(bio, &rbio->bio_list)
>   		index_one_bio(rbio, bio);
>   
> -	spin_unlock_irq(&rbio->bio_list_lock);
> +	spin_unlock(&rbio->bio_list_lock);
>   }
>   
>   static void bio_get_trace_info(struct btrfs_raid_bio *rbio, struct bio *bio,
> @@ -1888,9 +1882,9 @@ static int recover_sectors(struct btrfs_raid_bio *rbio)
>   
>   	if (rbio->operation == BTRFS_RBIO_READ_REBUILD ||
>   	    rbio->operation == BTRFS_RBIO_REBUILD_MISSING) {
> -		spin_lock_irq(&rbio->bio_list_lock);
> +		spin_lock(&rbio->bio_list_lock);
>   		set_bit(RBIO_RMW_LOCKED_BIT, &rbio->flags);
> -		spin_unlock_irq(&rbio->bio_list_lock);
> +		spin_unlock(&rbio->bio_list_lock);
>   	}
>   
>   	index_rbio_pages(rbio);
> @@ -2259,9 +2253,9 @@ static void rmw_rbio(struct btrfs_raid_bio *rbio)
>   	 * bio list any more, anyone else that wants to change this stripe
>   	 * needs to do their own rmw.
>   	 */
> -	spin_lock_irq(&rbio->bio_list_lock);
> +	spin_lock(&rbio->bio_list_lock);
>   	set_bit(RBIO_RMW_LOCKED_BIT, &rbio->flags);
> -	spin_unlock_irq(&rbio->bio_list_lock);
> +	spin_unlock(&rbio->bio_list_lock);
>   
>   	bitmap_clear(rbio->error_bitmap, 0, rbio->nr_sectors);
>   
