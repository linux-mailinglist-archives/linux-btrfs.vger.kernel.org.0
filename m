Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2413C6654BA
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jan 2023 07:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjAKGjD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 01:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbjAKGjC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 01:39:02 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E40F011
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 22:39:00 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M26vB-1pDYof1Wy9-002W6W; Wed, 11
 Jan 2023 07:38:53 +0100
Message-ID: <b3c8c296-4c14-96bd-f5a3-9ac8f960a2e3@gmx.com>
Date:   Wed, 11 Jan 2023 14:38:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 04/10] btrfs: add a bio_list_put helper
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20230111062335.1023353-1-hch@lst.de>
 <20230111062335.1023353-5-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230111062335.1023353-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:gijOg2eD9LUj+gDfYemXUXTBF2LgHDoxwL7M/yriESzTD2tqnPU
 BcP+PG+M1W0POxZ9o3lRDz8dXg6cKyJD2CSzfLaO4/Hsu/3NIBMLUfq2PC8bedchDPXf4qF
 d7XbAzTftC4+91ZcBBm28MIarKnMTeRn9k3kHcBZ5LpVxUa3ZI3EoDr7x7xN4ieLG5uz97c
 GEEcXxLzGYntdII3s7zOQ==
UI-OutboundReport: notjunk:1;M01:P0:FSjF+XJrMyw=;P5bg5bzTSnb50LA9hqDzSbypX9V
 jK9d6wSMtNI0B8Zpq0D2+lIkvLnuS7gOwjBveinjoFOSAQehRSIMImbphHHwLT9WX1Zl8HiXj
 apTG9zdwfzxaSkAGZTZLg5N4ZA2gIrv59Dinb69yoNmA+tdURhgBjG85uLMxiCt7rndWseajE
 OeTqoknr0gI69g7H2glbgWD9wDb9XQ6Jb5ObWkBjaHDb1afgjIuroplB3OFpP/qyW+Q1iMssr
 jivLD87zqxymwWSGDez9hiBs4xystjXAqqjY/uHXrBequMPxA/WizAf3GVJfyjh7aKFNL4oIm
 bJa16PlVL46ybk2eOmcPgbFGzGAmggOvQ65+0uc3IGOYuJVx2ytVqO4pn5OYmOgK+XDr8LHqs
 y2VOrc1tK6hWWtdqXqiFmuumHxA2WyOHHcKxG92/YM9PJ7j6sN04pL6pYBkg2R3mQKDTIlm2A
 EebvXopb5piv4dI14BCSucAcaebu8/aJRjUXdXDLI0ZfSfbJ7WzKTSZgYNkd16629NzAKp+k+
 6CrAM9z88KL2Yyp+qS4yTLSamnkPNOnLieEKdgPOnyMi8QRhpTKS7F+kIzCJbnOPwKP+9w3wg
 my8heCJ6ogBRt8ZoJsf1SOMzY+WuNCjXCEbTD46PjRpZV8BCWxQDoBG2IOGDaeJew329fZUv4
 z5tSyHP0iEAOgu45+wDXbFo+iInvgcccFxT9Q/mIKKGstCeC5BaFC4hXlzJzmxB0I7JhsZHxh
 T0UeVFHtjf4qurWSid0nvNlMN7CFObYDCGPemt/W4+oIqdaCzIvHQC9H6NlRw47YrenF1s4pI
 PnSeInhHeFYv9/Kh+Lc/OW9/7Ln1STiKSmIHFhjMM91aELfOksYprmwyXhgLp/TFQEQsgl88A
 BQpeCcrdmz0JBMJRZr1QX4OKPY71jYlRbUq0k9b6P9aih4RPIJlfg0WNa7QHvKdHS9npoI1WO
 39ioNzB+F5Zy9mGGALDb1C/Z86Q=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/11 14:23, Christoph Hellwig wrote:
> Add a helper to put all bios in a list.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/raid56.c | 44 ++++++++++++++++----------------------------
>   1 file changed, 16 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index e3fef81a4d96d3..666d634f0ba2c1 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -1183,6 +1183,14 @@ static void bio_get_trace_info(struct btrfs_raid_bio *rbio, struct bio *bio,
>   	trace_info->stripe_nr = -1;
>   }
>   
> +static inline void bio_list_put(struct bio_list *bio_list)
> +{
> +	struct bio *bio;
> +
> +	while ((bio = bio_list_pop(bio_list)))
> +		bio_put(bio);
> +}
> +
>   /* Generate PQ for one veritical stripe. */
>   static void generate_pq_vertical(struct btrfs_raid_bio *rbio, int sectornr)
>   {
> @@ -1228,7 +1236,6 @@ static void generate_pq_vertical(struct btrfs_raid_bio *rbio, int sectornr)
>   static int rmw_assemble_write_bios(struct btrfs_raid_bio *rbio,
>   				   struct bio_list *bio_list)
>   {
> -	struct bio *bio;
>   	/* The total sector number inside the full stripe. */
>   	int total_sector_nr;
>   	int sectornr;
> @@ -1317,8 +1324,7 @@ static int rmw_assemble_write_bios(struct btrfs_raid_bio *rbio,
>   
>   	return 0;
>   error:
> -	while ((bio = bio_list_pop(bio_list)))
> -		bio_put(bio);
> +	bio_list_put(bio_list);
>   	return -EIO;
>   }
>   
> @@ -1514,7 +1520,6 @@ static void submit_read_wait_bio_list(struct btrfs_raid_bio *rbio,
>   static int rmw_assemble_read_bios(struct btrfs_raid_bio *rbio,
>   				  struct bio_list *bio_list)
>   {
> -	struct bio *bio;
>   	int total_sector_nr;
>   	int ret = 0;
>   
> @@ -1541,8 +1546,7 @@ static int rmw_assemble_read_bios(struct btrfs_raid_bio *rbio,
>   	return 0;
>   
>   cleanup:
> -	while ((bio = bio_list_pop(bio_list)))
> -		bio_put(bio);
> +	bio_list_put(bio_list);
>   	return ret;
>   }
>   
> @@ -1939,7 +1943,6 @@ static int recover_sectors(struct btrfs_raid_bio *rbio)
>   static int recover_assemble_read_bios(struct btrfs_raid_bio *rbio,
>   				      struct bio_list *bio_list)
>   {
> -	struct bio *bio;
>   	int total_sector_nr;
>   	int ret = 0;
>   
> @@ -1981,16 +1984,13 @@ static int recover_assemble_read_bios(struct btrfs_raid_bio *rbio,
>   	}
>   	return 0;
>   error:
> -	while ((bio = bio_list_pop(bio_list)))
> -		bio_put(bio);
> -
> +	bio_list_put(bio_list);
>   	return -EIO;
>   }
>   
>   static int recover_rbio(struct btrfs_raid_bio *rbio)
>   {
>   	struct bio_list bio_list;
> -	struct bio *bio;
>   	int ret;
>   
>   	/*
> @@ -2016,9 +2016,7 @@ static int recover_rbio(struct btrfs_raid_bio *rbio)
>   	ret = recover_sectors(rbio);
>   
>   out:
> -	while ((bio = bio_list_pop(&bio_list)))
> -		bio_put(bio);
> -
> +	bio_list_put(&bio_list);
>   	return ret;
>   }
>   
> @@ -2191,7 +2189,6 @@ static void fill_data_csums(struct btrfs_raid_bio *rbio)
>   static int rmw_read_wait_recover(struct btrfs_raid_bio *rbio)
>   {
>   	struct bio_list bio_list;
> -	struct bio *bio;
>   	int ret;
>   
>   	bio_list_init(&bio_list);
> @@ -2216,9 +2213,7 @@ static int rmw_read_wait_recover(struct btrfs_raid_bio *rbio)
>   	ret = recover_sectors(rbio);
>   	return ret;
>   out:
> -	while ((bio = bio_list_pop(&bio_list)))
> -		bio_put(bio);
> -
> +	bio_list_put(&bio_list);
>   	return ret;
>   }
>   
> @@ -2489,7 +2484,6 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio, int need_check)
>   	struct sector_ptr p_sector = { 0 };
>   	struct sector_ptr q_sector = { 0 };
>   	struct bio_list bio_list;
> -	struct bio *bio;
>   	int is_replace = 0;
>   	int ret;
>   
> @@ -2620,8 +2614,7 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio, int need_check)
>   	return 0;
>   
>   cleanup:
> -	while ((bio = bio_list_pop(&bio_list)))
> -		bio_put(bio);
> +	bio_list_put(&bio_list);
>   	return ret;
>   }
>   
> @@ -2719,7 +2712,6 @@ static int recover_scrub_rbio(struct btrfs_raid_bio *rbio)
>   static int scrub_assemble_read_bios(struct btrfs_raid_bio *rbio,
>   				    struct bio_list *bio_list)
>   {
> -	struct bio *bio;
>   	int total_sector_nr;
>   	int ret = 0;
>   
> @@ -2760,8 +2752,7 @@ static int scrub_assemble_read_bios(struct btrfs_raid_bio *rbio,
>   	}
>   	return 0;
>   error:
> -	while ((bio = bio_list_pop(bio_list)))
> -		bio_put(bio);
> +	bio_list_put(bio_list);
>   	return ret;
>   }
>   
> @@ -2771,7 +2762,6 @@ static int scrub_rbio(struct btrfs_raid_bio *rbio)
>   	struct bio_list bio_list;
>   	int sector_nr;
>   	int ret;
> -	struct bio *bio;
>   
>   	bio_list_init(&bio_list);
>   
> @@ -2810,9 +2800,7 @@ static int scrub_rbio(struct btrfs_raid_bio *rbio)
>   	return ret;
>   
>   cleanup:
> -	while ((bio = bio_list_pop(&bio_list)))
> -		bio_put(bio);
> -
> +	bio_list_put(&bio_list);
>   	return ret;
>   }
>   
