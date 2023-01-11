Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC9E6654C6
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jan 2023 07:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjAKGpt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 01:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjAKGpr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 01:45:47 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FBEFACE
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 22:45:45 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N7zFj-1okVWM3axn-0152sL; Wed, 11
 Jan 2023 07:45:38 +0100
Message-ID: <aa005e3f-9cc3-66e1-391c-970abf71af36@gmx.com>
Date:   Wed, 11 Jan 2023 14:45:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 06/10] btrfs: fold rmw_read_wait_recover into
 rmw_read_bios
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20230111062335.1023353-1-hch@lst.de>
 <20230111062335.1023353-7-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230111062335.1023353-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:I3eCY6z0ko/9AzbfORBiQCAtkR0YgJG28P4P/bZCC/CUqU73gc2
 +Q4i/Cr2UNNYMY1w/TmvJQe5IFL6Y62v6W1vBwLy+PnJLo96mRvdf/693U7Uy0c22RzEqjt
 v9sNZtx3YNqvDoBSt4qA9X7s0/wVsOIrnoDe/wOcefQ5+W3vZ6NJov7hmH0AMZoik96vkct
 oKUOXG/ozFLpZ/clC0sCA==
UI-OutboundReport: notjunk:1;M01:P0:hvaXf2zn/yI=;4ezutpWAAuh1Q4qdN93HYHVYOOw
 vz9YY/OenGuoLaRFNRG4UMjZ7EJSjl5AhpuQ1skDEpJdmbZXEo/qMmlEkHZKgcKNutzoSQxJL
 dZlr6638M4d1NyNZZ7MDgn5i/FMy5wj/LNtfniHY4WT//E+OqgC6OQz3muKufgxY137aw8l9w
 W4A1bf/6N3uUxffN2yMuzgRXHZwNpKLc/ZEzhjK55I/EsVL2bEUvCKHAwwddtI+u9JxJ21bSU
 qezEY/gFN99JghgddxoOdE8aiPxwD4FLxydZ55bokUYF4Dlq5IiM7quZxoDbgGhHOppQtL5Wa
 RPSmRuuOpG5OOoYji/5voRoSA0MYvVcRbISiZhGWpC+JvYQkkqsGaIQAgMwHMkF9ttr4GJOku
 j2iiSLGgzxwVjyNRL9sMmUfKvG2BI1YxevUTBBEz0SWPtHafhKI2cY4iOaAVB0sHnWgF1XNtT
 3sa9SMp7hV/bXXntE54PHLORqtlOGOTm/8FyjFyc34aEo8u+x8hKte3D0Da1CLaRChF5pHfdM
 5KM6JyTRkBnpE18Ncqnx7oCoaCv41Xtvq7RYSHGH43VBUijg8tt7cPB1l7Vygz+ThvU68fQCA
 iMro332Q0WRBuKziQvbCz37yzY+Oaa9mEwSpR9mDpjs7u0QtmIDuzch2givABJAKsLwaJT55B
 AmZbDmgQEmBtpIgXXNQtneA410hRleOuSQXSWOopnHD50cGhRM81cy95SEiRGgHKj8B73xxT2
 nlXHGztYK+OgHmi9v8kk7T0NzOzKDvFZEfn199rhYr7jvker/3rDgZ0OWJROjkkiaeSnTV2Ip
 TossqbDdyTtgUMbTrtdRMie65X7Louvfz6NW0vkl1wP33NFvev3Uilh/pzMmqj69ocIkHJR8z
 xoVBdGJnQ7juln10KY2aYtsiuuX7e2DZ3Zn5b4DA1I3yCxJovqvswch9hI5gd9SyEcDyEzdzE
 WNexffiPpyfoY1EqpELzFm8txSE=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/11 14:23, Christoph Hellwig wrote:
> There is very little extra code in rmw_read_bios, and a large part of it
> is the superflous extra cleanup of the bio list.  Merge the two
> functions, and only clean up the bio list after it has been added to
> but before it has been emptied again by submit_read_wait_bio_list.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/raid56.c | 70 ++++++++++++++++-------------------------------
>   1 file changed, 24 insertions(+), 46 deletions(-)
> 
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index 4e983ca8cd532c..88404a6b0b98e7 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -1517,39 +1517,6 @@ static void submit_read_wait_bio_list(struct btrfs_raid_bio *rbio,
>   	wait_event(rbio->io_wait, atomic_read(&rbio->stripes_pending) == 0);
>   }
>   
> -static int rmw_assemble_read_bios(struct btrfs_raid_bio *rbio,
> -				  struct bio_list *bio_list)
> -{
> -	int total_sector_nr;
> -	int ret = 0;
> -
> -	ASSERT(bio_list_size(bio_list) == 0);
> -
> -	/*
> -	 * Build a list of bios to read all sectors (including data and P/Q).
> -	 *
> -	 * This behaviro is to compensate the later csum verification and
> -	 * recovery.
> -	 */
> -	for (total_sector_nr = 0; total_sector_nr < rbio->nr_sectors;
> -	     total_sector_nr++) {
> -		struct sector_ptr *sector;
> -		int stripe = total_sector_nr / rbio->stripe_nsectors;
> -		int sectornr = total_sector_nr % rbio->stripe_nsectors;
> -
> -		sector = rbio_stripe_sector(rbio, stripe, sectornr);
> -		ret = rbio_add_io_sector(rbio, bio_list, sector,
> -			       stripe, sectornr, REQ_OP_READ);
> -		if (ret)
> -			goto cleanup;
> -	}
> -	return 0;
> -
> -cleanup:
> -	bio_list_put(bio_list);
> -	return ret;
> -}
> -
>   static int alloc_rbio_data_pages(struct btrfs_raid_bio *rbio)
>   {
>   	const int data_pages = rbio->nr_data * rbio->stripe_npages;
> @@ -2169,10 +2136,9 @@ static void fill_data_csums(struct btrfs_raid_bio *rbio)
>   
>   static int rmw_read_wait_recover(struct btrfs_raid_bio *rbio)
>   {
> -	struct bio_list bio_list;
> -	int ret;
> -
> -	bio_list_init(&bio_list);
> +	struct bio_list bio_list = BIO_EMPTY_LIST;
> +	int total_sector_nr;
> +	int ret = 0;
>   
>   	/*
>   	 * Fill the data csums we need for data verification.  We need to fill
> @@ -2181,21 +2147,33 @@ static int rmw_read_wait_recover(struct btrfs_raid_bio *rbio)
>   	 */
>   	fill_data_csums(rbio);
>   
> -	ret = rmw_assemble_read_bios(rbio, &bio_list);
> -	if (ret < 0)
> -		goto out;
> +	/*
> +	 * Build a list of bios to read all sectors (including data and P/Q).
> +	 *
> +	 * This behaviro is to compensate the later csum verification and
> +	 * recovery.
> +	 */
> +	for (total_sector_nr = 0; total_sector_nr < rbio->nr_sectors;
> +	     total_sector_nr++) {
> +		struct sector_ptr *sector;
> +		int stripe = total_sector_nr / rbio->stripe_nsectors;
> +		int sectornr = total_sector_nr % rbio->stripe_nsectors;
>   
> -	submit_read_wait_bio_list(rbio, &bio_list);
> +		sector = rbio_stripe_sector(rbio, stripe, sectornr);
> +		ret = rbio_add_io_sector(rbio, &bio_list, sector,
> +			       stripe, sectornr, REQ_OP_READ);
> +		if (ret) {
> +			bio_list_put(&bio_list);
> +			return ret;
> +		}
> +	}
>   
>   	/*
>   	 * We may or may not have any corrupted sectors (including missing dev
>   	 * and csum mismatch), just let recover_sectors() to handle them all.
>   	 */
> -	ret = recover_sectors(rbio);
> -	return ret;
> -out:
> -	bio_list_put(&bio_list);
> -	return ret;
> +	submit_read_wait_bio_list(rbio, &bio_list);
> +	return recover_sectors(rbio);
>   }
>   
>   static void raid_wait_write_end_io(struct bio *bio)
