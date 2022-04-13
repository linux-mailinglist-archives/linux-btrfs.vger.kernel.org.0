Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834B44FFF0C
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Apr 2022 21:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238233AbiDMTV3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Apr 2022 15:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237919AbiDMTV2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Apr 2022 15:21:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBF74993A
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Apr 2022 12:19:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DC5DE1FCFD;
        Wed, 13 Apr 2022 19:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649877543;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QXQiEWOc7PC4FZVWXPxn/7Ms/Kuoo7c5kyuiPY/rPvk=;
        b=c/RzRHgE2cSRBA2iZzAZfAOFCgObgS93e9Hk59DA6u37QljXLFkLDfIBlMFy+5egseA4uj
        YO9KePhm+qfcy6zE7pTMgK45HXCS9co2hPUsQJZGBMVF1SYIa11IFp1yNOqFrqngONOmXa
        1lNgceOqFHJs1ErhceqEomWDsnSuVOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649877543;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QXQiEWOc7PC4FZVWXPxn/7Ms/Kuoo7c5kyuiPY/rPvk=;
        b=IJ6FSc1X2YcPZdMgY20TG/W1fm/Vi2eLRIPUaUNHBKc0UqILalvIIefI6SizWiqd2VGHjR
        yeqy52C6SkJRKhAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A39E313A91;
        Wed, 13 Apr 2022 19:19:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bDkNJyciV2LKBQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 13 Apr 2022 19:19:03 +0000
Date:   Wed, 13 Apr 2022 21:14:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 07/17] btrfs: make rbio_add_io_page() subpage
 compatible
Message-ID: <20220413191456.GN15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1649753690.git.wqu@suse.com>
 <d2873b5f3a00e9bb966150b4dd0253f4db107c12.1649753690.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2873b5f3a00e9bb966150b4dd0253f4db107c12.1649753690.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There's an assertion failure reported by btrfs/023

On Tue, Apr 12, 2022 at 05:32:57PM +0800, Qu Wenruo wrote:
> +static int rbio_add_io_sector(struct btrfs_raid_bio *rbio,
> +			      struct bio_list *bio_list,
> +			      struct sector_ptr *sector,
> +			      unsigned int stripe_nr,
> +			      unsigned int sector_nr,
> +			      unsigned long bio_max_len, unsigned int opf)
>  {
> +	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
>  	struct bio *last = bio_list->tail;
>  	int ret;
>  	struct bio *bio;
>  	struct btrfs_io_stripe *stripe;
>  	u64 disk_start;
>  
> +	/*
> +	 * NOTE: here stripe_nr has taken device replace into consideration,
> +	 * thus it can be larger than rbio->real_stripe.
> +	 * So here we check against bioc->num_stripes, not rbio->real_stripes.
> +	 */
> +	ASSERT(stripe_nr >= 0 && stripe_nr < rbio->bioc->num_stripes);
> +	ASSERT(sector_nr >= 0 && sector_nr < rbio->stripe_nsectors);
> +	ASSERT(sector->page);

This one ^^^

[ 2280.705765] assertion failed: sector->page, in fs/btrfs/raid56.c:1145
[ 2280.707844] ------------[ cut here ]------------
[ 2280.709401] kernel BUG at fs/btrfs/ctree.h:3614!
[ 2280.711084] invalid opcode: 0000 [#1] PREEMPT SMP
[ 2280.712822] CPU: 3 PID: 4084 Comm: kworker/u8:2 Not tainted 5.18.0-rc2-default+ #1697
[ 2280.715648] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
[ 2280.719656] Workqueue: btrfs-rmw btrfs_work_helper [btrfs]
[ 2280.721775] RIP: 0010:assertfail.constprop.0+0x18/0x1a [btrfs]
[ 2280.729575] RSP: 0018:ffffad6d071afda0 EFLAGS: 00010246
[ 2280.730844] RAX: 0000000000000039 RBX: 0000000000000000 RCX: 0000000000000000
[ 2280.732449] RDX: 0000000000000000 RSI: 0000000000000003 RDI: 00000000ffffffff
[ 2280.733992] RBP: ffff8e51d5465000 R08: 0000000000000003 R09: 0000000000000002
[ 2280.735535] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000003
[ 2280.737093] R13: ffff8e51d5465000 R14: ffff8e51d5465d78 R15: 0000000000001000
[ 2280.738613] FS:  0000000000000000(0000) GS:ffff8e523dc00000(0000) knlGS:0000000000000000
[ 2280.740392] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2280.741794] CR2: 000055f48fe51ab0 CR3: 000000001f805001 CR4: 0000000000170ea0
[ 2280.743532] Call Trace:
[ 2280.744136]  <TASK>
[ 2280.744701]  rbio_add_io_sector.cold+0x11/0x33 [btrfs]
[ 2280.745846]  ? _raw_spin_unlock_irq+0x2f/0x50
[ 2280.746782]  raid56_rmw_stripe.isra.0+0x153/0x320 [btrfs]
[ 2280.747965]  btrfs_work_helper+0xd6/0x1d0 [btrfs]
[ 2280.749018]  process_one_work+0x264/0x5f0
[ 2280.749806]  worker_thread+0x52/0x3b0
[ 2280.750523]  ? process_one_work+0x5f0/0x5f0
[ 2280.751395]  kthread+0xea/0x110
[ 2280.752097]  ? kthread_complete_and_exit+0x20/0x20
[ 2280.753112]  ret_from_fork+0x1f/0x30


> +
> +	/* We don't yet support subpage, thus pgoff should always be 0 */
> +	ASSERT(sector->pgoff == 0);
> +
>  	stripe = &rbio->bioc->stripes[stripe_nr];
> -	disk_start = stripe->physical + (page_index << PAGE_SHIFT);
> +	disk_start = stripe->physical + sector_nr * sectorsize;
>  
>  	/* if the device is missing, just fail this stripe */
>  	if (!stripe->dev->bdev)
> @@ -1156,8 +1226,9 @@ static int rbio_add_io_page(struct btrfs_raid_bio *rbio,
>  		 */
>  		if (last_end == disk_start && !last->bi_status &&
>  		    last->bi_bdev == stripe->dev->bdev) {
> -			ret = bio_add_page(last, page, PAGE_SIZE, 0);
> -			if (ret == PAGE_SIZE)
> +			ret = bio_add_page(last, sector->page, sectorsize,
> +					   sector->pgoff);
> +			if (ret == sectorsize)
>  				return 0;
>  		}
>  	}
> @@ -1168,7 +1239,7 @@ static int rbio_add_io_page(struct btrfs_raid_bio *rbio,
>  	bio->bi_iter.bi_sector = disk_start >> 9;
>  	bio->bi_private = rbio;
>  
> -	bio_add_page(bio, page, PAGE_SIZE, 0);
> +	bio_add_page(bio, sector->page, sectorsize, sector->pgoff);
>  	bio_list_add(bio_list, bio);
>  	return 0;
>  }
> @@ -1265,7 +1336,7 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
>  	void **pointers = rbio->finish_pointers;
>  	int nr_data = rbio->nr_data;
>  	int stripe;
> -	int pagenr;
> +	int sectornr;
>  	bool has_qstripe;
>  	struct bio_list bio_list;
>  	struct bio *bio;
> @@ -1309,16 +1380,16 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
>  	else
>  		clear_bit(RBIO_CACHE_READY_BIT, &rbio->flags);
>  
> -	for (pagenr = 0; pagenr < rbio->stripe_npages; pagenr++) {
> +	for (sectornr = 0; sectornr < rbio->stripe_nsectors; sectornr++) {
>  		struct page *p;
>  		/* first collect one page from each data stripe */
>  		for (stripe = 0; stripe < nr_data; stripe++) {
> -			p = page_in_rbio(rbio, stripe, pagenr, 0);
> +			p = page_in_rbio(rbio, stripe, sectornr, 0);
>  			pointers[stripe] = kmap_local_page(p);
>  		}
>  
>  		/* then add the parity stripe */
> -		p = rbio_pstripe_page(rbio, pagenr);
> +		p = rbio_pstripe_page(rbio, sectornr);
>  		SetPageUptodate(p);
>  		pointers[stripe++] = kmap_local_page(p);
>  
> @@ -1328,7 +1399,7 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
>  			 * raid6, add the qstripe and call the
>  			 * library function to fill in our p/q
>  			 */
> -			p = rbio_qstripe_page(rbio, pagenr);
> +			p = rbio_qstripe_page(rbio, sectornr);
>  			SetPageUptodate(p);
>  			pointers[stripe++] = kmap_local_page(p);
>  
> @@ -1349,19 +1420,19 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
>  	 * everything else.
>  	 */
>  	for (stripe = 0; stripe < rbio->real_stripes; stripe++) {
> -		for (pagenr = 0; pagenr < rbio->stripe_npages; pagenr++) {
> -			struct page *page;
> +		for (sectornr = 0; sectornr < rbio->stripe_nsectors; sectornr++) {
> +			struct sector_ptr *sector;
> +
>  			if (stripe < rbio->nr_data) {
> -				page = page_in_rbio(rbio, stripe, pagenr, 1);
> -				if (!page)
> +				sector = sector_in_rbio(rbio, stripe, sectornr, 1);
> +				if (!sector)
>  					continue;
>  			} else {
> -			       page = rbio_stripe_page(rbio, stripe, pagenr);
> +				sector = rbio_stripe_sector(rbio, stripe, sectornr);
>  			}
>  
> -			ret = rbio_add_io_page(rbio, &bio_list,
> -				       page, stripe, pagenr, rbio->stripe_len,
> -				       REQ_OP_WRITE);
> +			ret = rbio_add_io_sector(rbio, &bio_list, sector, stripe,
> +						 sectornr, rbio->stripe_len, REQ_OP_WRITE);
>  			if (ret)
>  				goto cleanup;
>  		}
> @@ -1374,20 +1445,21 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
>  		if (!bioc->tgtdev_map[stripe])
>  			continue;
>  
> -		for (pagenr = 0; pagenr < rbio->stripe_npages; pagenr++) {
> -			struct page *page;
> +		for (sectornr = 0; sectornr < rbio->stripe_nsectors; sectornr++) {
> +			struct sector_ptr *sector;
> +
>  			if (stripe < rbio->nr_data) {
> -				page = page_in_rbio(rbio, stripe, pagenr, 1);
> -				if (!page)
> +				sector = sector_in_rbio(rbio, stripe, sectornr, 1);
> +				if (!sector)
>  					continue;
>  			} else {
> -			       page = rbio_stripe_page(rbio, stripe, pagenr);
> +				sector = rbio_stripe_sector(rbio, stripe, sectornr);
>  			}
>  
> -			ret = rbio_add_io_page(rbio, &bio_list, page,
> -					       rbio->bioc->tgtdev_map[stripe],
> -					       pagenr, rbio->stripe_len,
> -					       REQ_OP_WRITE);
> +			ret = rbio_add_io_sector(rbio, &bio_list, sector,
> +						 rbio->bioc->tgtdev_map[stripe],
> +						 sectornr, rbio->stripe_len,
> +						 REQ_OP_WRITE);
>  			if (ret)
>  				goto cleanup;
>  		}
> @@ -1563,7 +1635,7 @@ static int raid56_rmw_stripe(struct btrfs_raid_bio *rbio)
>  	int bios_to_read = 0;
>  	struct bio_list bio_list;
>  	int ret;
> -	int pagenr;
> +	int sectornr;
>  	int stripe;
>  	struct bio *bio;
>  
> @@ -1581,28 +1653,29 @@ static int raid56_rmw_stripe(struct btrfs_raid_bio *rbio)
>  	 * stripe
>  	 */
>  	for (stripe = 0; stripe < rbio->nr_data; stripe++) {
> -		for (pagenr = 0; pagenr < rbio->stripe_npages; pagenr++) {
> -			struct page *page;
> +		for (sectornr = 0; sectornr < rbio->stripe_nsectors; sectornr++) {
> +			struct sector_ptr *sector;
> +
>  			/*
> -			 * we want to find all the pages missing from
> +			 * We want to find all the sectors missing from
>  			 * the rbio and read them from the disk.  If
> -			 * page_in_rbio finds a page in the bio list
> +			 * sector_in_rbio() finds a page in the bio list
>  			 * we don't need to read it off the stripe.
>  			 */
> -			page = page_in_rbio(rbio, stripe, pagenr, 1);
> -			if (page)
> +			sector = sector_in_rbio(rbio, stripe, sectornr, 1);
> +			if (sector)
>  				continue;
>  
> -			page = rbio_stripe_page(rbio, stripe, pagenr);
> +			sector = rbio_stripe_sector(rbio, stripe, sectornr);
>  			/*
> -			 * the bio cache may have handed us an uptodate
> +			 * The bio cache may have handed us an uptodate
>  			 * page.  If so, be happy and use it
>  			 */
> -			if (PageUptodate(page))
> +			if (sector->uptodate)
>  				continue;
>  
> -			ret = rbio_add_io_page(rbio, &bio_list, page,
> -				       stripe, pagenr, rbio->stripe_len,
> +			ret = rbio_add_io_sector(rbio, &bio_list, sector,
> +				       stripe, sectornr, rbio->stripe_len,
>  				       REQ_OP_READ);
>  			if (ret)
>  				goto cleanup;
> @@ -2107,7 +2180,7 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
>  	int bios_to_read = 0;
>  	struct bio_list bio_list;
>  	int ret;
> -	int pagenr;
> +	int sectornr;
>  	int stripe;
>  	struct bio *bio;
>  
> @@ -2130,21 +2203,20 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
>  			continue;
>  		}
>  
> -		for (pagenr = 0; pagenr < rbio->stripe_npages; pagenr++) {
> -			struct page *p;
> +		for (sectornr = 0; sectornr < rbio->stripe_nsectors; sectornr++) {
> +			struct sector_ptr *sector;
>  
>  			/*
>  			 * the rmw code may have already read this
>  			 * page in
>  			 */
> -			p = rbio_stripe_page(rbio, stripe, pagenr);
> -			if (PageUptodate(p))
> +			sector = rbio_stripe_sector(rbio, stripe, sectornr);
> +			if (sector->uptodate)
>  				continue;
>  
> -			ret = rbio_add_io_page(rbio, &bio_list,
> -				       rbio_stripe_page(rbio, stripe, pagenr),
> -				       stripe, pagenr, rbio->stripe_len,
> -				       REQ_OP_READ);
> +			ret = rbio_add_io_sector(rbio, &bio_list, sector,
> +						 stripe, sectornr,
> +						 rbio->stripe_len, REQ_OP_READ);
>  			if (ret < 0)
>  				goto cleanup;
>  		}
> @@ -2399,7 +2471,7 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
>  	unsigned long *pbitmap = rbio->finish_pbitmap;
>  	int nr_data = rbio->nr_data;
>  	int stripe;
> -	int pagenr;
> +	int sectornr;
>  	bool has_qstripe;
>  	struct page *p_page = NULL;
>  	struct page *q_page = NULL;
> @@ -2419,7 +2491,7 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
>  
>  	if (bioc->num_tgtdevs && bioc->tgtdev_map[rbio->scrubp]) {
>  		is_replace = 1;
> -		bitmap_copy(pbitmap, rbio->dbitmap, rbio->stripe_npages);
> +		bitmap_copy(pbitmap, rbio->dbitmap, rbio->stripe_nsectors);
>  	}
>  
>  	/*
> @@ -2453,12 +2525,12 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
>  	/* Map the parity stripe just once */
>  	pointers[nr_data] = kmap_local_page(p_page);
>  
> -	for_each_set_bit(pagenr, rbio->dbitmap, rbio->stripe_npages) {
> +	for_each_set_bit(sectornr, rbio->dbitmap, rbio->stripe_nsectors) {
>  		struct page *p;
>  		void *parity;
>  		/* first collect one page from each data stripe */
>  		for (stripe = 0; stripe < nr_data; stripe++) {
> -			p = page_in_rbio(rbio, stripe, pagenr, 0);
> +			p = page_in_rbio(rbio, stripe, sectornr, 0);
>  			pointers[stripe] = kmap_local_page(p);
>  		}
>  
> @@ -2473,13 +2545,13 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
>  		}
>  
>  		/* Check scrubbing parity and repair it */
> -		p = rbio_stripe_page(rbio, rbio->scrubp, pagenr);
> +		p = rbio_stripe_page(rbio, rbio->scrubp, sectornr);
>  		parity = kmap_local_page(p);
>  		if (memcmp(parity, pointers[rbio->scrubp], PAGE_SIZE))
>  			copy_page(parity, pointers[rbio->scrubp]);
>  		else
>  			/* Parity is right, needn't writeback */
> -			bitmap_clear(rbio->dbitmap, pagenr, 1);
> +			bitmap_clear(rbio->dbitmap, sectornr, 1);
>  		kunmap_local(parity);
>  
>  		for (stripe = nr_data - 1; stripe >= 0; stripe--)
> @@ -2499,12 +2571,13 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
>  	 * higher layers (the bio_list in our rbio) and our p/q.  Ignore
>  	 * everything else.
>  	 */
> -	for_each_set_bit(pagenr, rbio->dbitmap, rbio->stripe_npages) {
> -		struct page *page;
> +	for_each_set_bit(sectornr, rbio->dbitmap, rbio->stripe_nsectors) {
> +		struct sector_ptr *sector;
>  
> -		page = rbio_stripe_page(rbio, rbio->scrubp, pagenr);
> -		ret = rbio_add_io_page(rbio, &bio_list, page, rbio->scrubp,
> -				       pagenr, rbio->stripe_len, REQ_OP_WRITE);
> +		sector = rbio_stripe_sector(rbio, rbio->scrubp, sectornr);
> +		ret = rbio_add_io_sector(rbio, &bio_list, sector, rbio->scrubp,
> +					 sectornr, rbio->stripe_len,
> +					 REQ_OP_WRITE);
>  		if (ret)
>  			goto cleanup;
>  	}
> @@ -2512,13 +2585,13 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
>  	if (!is_replace)
>  		goto submit_write;
>  
> -	for_each_set_bit(pagenr, pbitmap, rbio->stripe_npages) {
> -		struct page *page;
> +	for_each_set_bit(sectornr, pbitmap, rbio->stripe_nsectors) {
> +		struct sector_ptr *sector;
>  
> -		page = rbio_stripe_page(rbio, rbio->scrubp, pagenr);
> -		ret = rbio_add_io_page(rbio, &bio_list, page,
> +		sector = rbio_stripe_sector(rbio, rbio->scrubp, sectornr);
> +		ret = rbio_add_io_sector(rbio, &bio_list, sector,
>  				       bioc->tgtdev_map[rbio->scrubp],
> -				       pagenr, rbio->stripe_len, REQ_OP_WRITE);
> +				       sectornr, rbio->stripe_len, REQ_OP_WRITE);
>  		if (ret)
>  			goto cleanup;
>  	}
> @@ -2650,7 +2723,7 @@ static void raid56_parity_scrub_stripe(struct btrfs_raid_bio *rbio)
>  	int bios_to_read = 0;
>  	struct bio_list bio_list;
>  	int ret;
> -	int pagenr;
> +	int sectornr;
>  	int stripe;
>  	struct bio *bio;
>  
> @@ -2666,28 +2739,30 @@ static void raid56_parity_scrub_stripe(struct btrfs_raid_bio *rbio)
>  	 * stripe
>  	 */
>  	for (stripe = 0; stripe < rbio->real_stripes; stripe++) {
> -		for_each_set_bit(pagenr, rbio->dbitmap, rbio->stripe_npages) {
> -			struct page *page;
> +		for_each_set_bit(sectornr, rbio->dbitmap,
> +				 rbio->stripe_nsectors) {
> +			struct sector_ptr *sector;
>  			/*
> -			 * we want to find all the pages missing from
> +			 * We want to find all the sectors missing from
>  			 * the rbio and read them from the disk.  If
> -			 * page_in_rbio finds a page in the bio list
> +			 * sector_in_rbio() finds a sector in the bio list
>  			 * we don't need to read it off the stripe.
>  			 */
> -			page = page_in_rbio(rbio, stripe, pagenr, 1);
> -			if (page)
> +			sector = sector_in_rbio(rbio, stripe, sectornr, 1);
> +			if (sector)
>  				continue;
>  
> -			page = rbio_stripe_page(rbio, stripe, pagenr);
> +			sector = rbio_stripe_sector(rbio, stripe, sectornr);
>  			/*
> -			 * the bio cache may have handed us an uptodate
> -			 * page.  If so, be happy and use it
> +			 * The bio cache may have handed us an uptodate
> +			 * sector.  If so, be happy and use it
>  			 */
> -			if (PageUptodate(page))
> +			if (sector->uptodate)
>  				continue;
>  
> -			ret = rbio_add_io_page(rbio, &bio_list, page, stripe,
> -					       pagenr, rbio->stripe_len, REQ_OP_READ);
> +			ret = rbio_add_io_sector(rbio, &bio_list, sector,
> +						 stripe, sectornr,
> +						 rbio->stripe_len, REQ_OP_READ);
>  			if (ret)
>  				goto cleanup;
>  		}
> -- 
> 2.35.1
