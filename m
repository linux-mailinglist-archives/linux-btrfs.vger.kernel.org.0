Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8786A54D3B3
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 23:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344427AbiFOV2h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jun 2022 17:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347137AbiFOV2d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jun 2022 17:28:33 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC5156236
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 14:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655328507;
        bh=k5vJByfD3jQeceL/TsQ12JrCwOGhrWIWgKGSA2Dx9kI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=gkvvNxRoMmEUz1dauQ7C+e6+p5dQNp3BxT/68Yj/+QrrVcWmSE3Ru7zZQ/WKP8zPe
         TXkYuPXjGzrlBnNWaMX8N2zFg9h+0UQ1siR78GOgCN807N7+ZjTk4ovTEUIsUq21ST
         7acWgNJpCfJrhsF0eJ5OUHIYa2i17+hVnZYZMO74=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1OXT-1nYo9x1zOl-012r8F; Wed, 15
 Jun 2022 23:28:27 +0200
Message-ID: <468e1b0d-7e2e-0312-9e51-c53eb0e7e782@gmx.com>
Date:   Thu, 16 Jun 2022 05:28:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/5] btrfs: remove a bunch of pointles stripe_len
 arguments
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220615151515.888424-1-hch@lst.de>
 <20220615151515.888424-2-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220615151515.888424-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FjMBgmricMn0MbDjLRksj001SB/2nUy0975HkhHE1oshtPz5MMa
 Ty7+q62eBH8OYCPg03PaPNatVU5GvHiY/LreJgp/FOyKzCaAXlbb+L15hz8VA9fx7ZUcpmt
 w20k0X8BdC3Pq8ZFD891pu6vHoOFMQpk5fgTW6SZcuc+jcSuNxUPZCvxhwN5CzwPNVzCsTu
 u8zcHrls6fAs9d/gmfvrg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:slRTNbv07wM=:HMm4URXsIn/+LsYulNDhks
 F48f7AmAxtX5nyUN3j0a9OQsknIkv8Wo5vw3LrIaTWx/Ca+O7E/x4tCEJDmkWJkQ1glwgXlHY
 sKq+7sN034AmciYNwdjrWfZw3sFat9jWX8FrQNkM7vfK9vweumwXJPkAQGPzvoi5DCjOc/sim
 27AJWYlDzHmdFaBkZRgoeH9SPhVxwJfTeqTLKzXj7P0wdKcPvFQbPS+Ps6ZAngYB6GQNPFKWO
 WpTQRP8LkL4q1CA2e4KX6uPH/XR1/zoZGU1f0LXo/a0s04PUnS8xQF3R7pwFgAMFzWKcrO8ei
 gfLwBHNY+DNtamzHvDeAkhqnuNk4Hu/RVmEsOxSrxG+vcw1H5eRnLF54Lf/LNtklOCXeKPHFg
 GsPW4OuU1B6ZndUJ0n21FeVzqSKMi901fEi+SPuziVShZ/roaHJcSo8qhYVVM37/KTXSDkB0P
 6nIMdIzgh0rJyHaVcR0NcufP1/s2UN8ApTdmsufGuyYb6XnYmhjazFd3xdBCCnDNYAjpac0j1
 D54MEwfOH1kpKiKvvzwasZ0oAiSHk0UHkXfVDO8l2Z1Aqz6nqNgR0X7kRHAgljy44sxpbTZH2
 Zo8hHyS9AXjVH6iYamJ1GxhVAHgqopwgI7seDaRTCMGmHw1AB/lelGNd+tTgcTUohrV6CK0r4
 jcVkCybWHcLmVjHJ3rhZqhx0ioO/KeEG5r9XvIc2yxToXApRp23621+QFrbanrIekwoTkd9Jj
 IUGAgpPXCB1uW4891bQZxZBW3rw4AWME/sw86/mJeKdqTIfDyq1pDFOvV15z59NAh0NowUZbu
 qrtSQ0VTlAsDGkjk70TIVXOysqJYDGEFP3mKZysZXu4Yza3uBlr3koOcRQdRpYZySjsa9qqWe
 Djr7tmZtmT4I0Vn19y1X3d+PZnAnLvJUuqSlXmmLluE48as0Ypb8Vb/70QzfgHElP7PidI+g9
 AA+zJoBNopOtNkl3zvFIQTFNeIQ5pGcpTTSay/391nna67HlrHn5kvtOfoRNnS5+Y6lArwrGV
 QNRGwG7ga30r8yJWbw0ouR/XXpZhze8y9dtaRKoR2qo485LxfGsVZxO8H13mOsHjfGG2F9d3V
 iP3xWBLJCmX3NSkQ0K90BKjFrlAcfpHG/mkVBKrjXsN+Qlbs5QKOVxugw==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/15 23:15, Christoph Hellwig wrote:
> The raid56 code assumes a fixed stripe length.  To start simplifying the
> bio mapping code remove a few arguments and explicitly hard code that
> fixes stripe length.
>
> Partially based on a patch from Qu Wenruo.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Glad someone would finally cleanup the unnecessary stripe_len code.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/raid56.c  | 61 ++++++++++++++++++++--------------------------
>   fs/btrfs/raid56.h  | 12 +++------
>   fs/btrfs/scrub.c   |  9 +++----
>   fs/btrfs/volumes.c | 13 ++++------
>   4 files changed, 39 insertions(+), 56 deletions(-)
>
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index f002334d244a7..e071648f2c591 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -474,9 +474,9 @@ static int rbio_is_full(struct btrfs_raid_bio *rbio)
>   	int ret =3D 1;
>
>   	spin_lock_irqsave(&rbio->bio_list_lock, flags);
> -	if (size !=3D rbio->nr_data * rbio->stripe_len)
> +	if (size !=3D rbio->nr_data * BTRFS_STRIPE_LEN)
>   		ret =3D 0;
> -	BUG_ON(size > rbio->nr_data * rbio->stripe_len);
> +	BUG_ON(size > rbio->nr_data * BTRFS_STRIPE_LEN);
>   	spin_unlock_irqrestore(&rbio->bio_list_lock, flags);
>
>   	return ret;
> @@ -913,19 +913,18 @@ static struct sector_ptr *sector_in_rbio(struct bt=
rfs_raid_bio *rbio,
>    * this does not allocate any pages for rbio->pages.
>    */
>   static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info=
,
> -					 struct btrfs_io_context *bioc,
> -					 u32 stripe_len)
> +					 struct btrfs_io_context *bioc)
>   {
>   	const unsigned int real_stripes =3D bioc->num_stripes - bioc->num_tgt=
devs;
> -	const unsigned int stripe_npages =3D stripe_len >> PAGE_SHIFT;
> +	const unsigned int stripe_npages =3D BTRFS_STRIPE_LEN >> PAGE_SHIFT;
>   	const unsigned int num_pages =3D stripe_npages * real_stripes;
> -	const unsigned int stripe_nsectors =3D stripe_len >> fs_info->sectorsi=
ze_bits;
> +	const unsigned int stripe_nsectors =3D
> +		BTRFS_STRIPE_LEN >> fs_info->sectorsize_bits;
>   	const unsigned int num_sectors =3D stripe_nsectors * real_stripes;
>   	struct btrfs_raid_bio *rbio;
>   	int nr_data =3D 0;
>   	void *p;
>
> -	ASSERT(IS_ALIGNED(stripe_len, PAGE_SIZE));
>   	/* PAGE_SIZE must also be aligned to sectorsize for subpage support *=
/
>   	ASSERT(IS_ALIGNED(PAGE_SIZE, fs_info->sectorsize));
>   	/*
> @@ -949,7 +948,6 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrf=
s_fs_info *fs_info,
>   	INIT_LIST_HEAD(&rbio->stripe_cache);
>   	INIT_LIST_HEAD(&rbio->hash_list);
>   	rbio->bioc =3D bioc;
> -	rbio->stripe_len =3D stripe_len;
>   	rbio->nr_pages =3D num_pages;
>   	rbio->nr_sectors =3D num_sectors;
>   	rbio->real_stripes =3D real_stripes;
> @@ -1026,7 +1024,6 @@ static int rbio_add_io_sector(struct btrfs_raid_bi=
o *rbio,
>   			      struct sector_ptr *sector,
>   			      unsigned int stripe_nr,
>   			      unsigned int sector_nr,
> -			      unsigned long bio_max_len,
>   			      unsigned int opf)
>   {
>   	const u32 sectorsize =3D rbio->bioc->fs_info->sectorsize;
> @@ -1071,7 +1068,8 @@ static int rbio_add_io_sector(struct btrfs_raid_bi=
o *rbio,
>   	}
>
>   	/* put a new bio on the list */
> -	bio =3D bio_alloc(stripe->dev->bdev, max(bio_max_len >> PAGE_SHIFT, 1U=
L),
> +	bio =3D bio_alloc(stripe->dev->bdev,
> +			max(BTRFS_STRIPE_LEN >> PAGE_SHIFT, 1),
>   			opf, GFP_NOFS);
>   	bio->bi_iter.bi_sector =3D disk_start >> 9;
>   	bio->bi_private =3D rbio;
> @@ -1293,8 +1291,7 @@ static noinline void finish_rmw(struct btrfs_raid_=
bio *rbio)
>   		}
>
>   		ret =3D rbio_add_io_sector(rbio, &bio_list, sector, stripe,
> -					 sectornr, rbio->stripe_len,
> -					 REQ_OP_WRITE);
> +					 sectornr, REQ_OP_WRITE);
>   		if (ret)
>   			goto cleanup;
>   	}
> @@ -1333,8 +1330,7 @@ static noinline void finish_rmw(struct btrfs_raid_=
bio *rbio)
>
>   		ret =3D rbio_add_io_sector(rbio, &bio_list, sector,
>   					 rbio->bioc->tgtdev_map[stripe],
> -					 sectornr, rbio->stripe_len,
> -					 REQ_OP_WRITE);
> +					 sectornr, REQ_OP_WRITE);
>   		if (ret)
>   			goto cleanup;
>   	}
> @@ -1379,7 +1375,7 @@ static int find_bio_stripe(struct btrfs_raid_bio *=
rbio,
>
>   	for (i =3D 0; i < rbio->bioc->num_stripes; i++) {
>   		stripe =3D &rbio->bioc->stripes[i];
> -		if (in_range(physical, stripe->physical, rbio->stripe_len) &&
> +		if (in_range(physical, stripe->physical, BTRFS_STRIPE_LEN) &&
>   		    stripe->dev->bdev && bio->bi_bdev =3D=3D stripe->dev->bdev) {
>   			return i;
>   		}
> @@ -1401,7 +1397,7 @@ static int find_logical_bio_stripe(struct btrfs_ra=
id_bio *rbio,
>   	for (i =3D 0; i < rbio->nr_data; i++) {
>   		u64 stripe_start =3D rbio->bioc->raid_map[i];
>
> -		if (in_range(logical, stripe_start, rbio->stripe_len))
> +		if (in_range(logical, stripe_start, BTRFS_STRIPE_LEN))
>   			return i;
>   	}
>   	return -1;
> @@ -1586,8 +1582,7 @@ static int raid56_rmw_stripe(struct btrfs_raid_bio=
 *rbio)
>   			continue;
>
>   		ret =3D rbio_add_io_sector(rbio, &bio_list, sector,
> -			       stripe, sectornr, rbio->stripe_len,
> -			       REQ_OP_READ);
> +			       stripe, sectornr, REQ_OP_READ);
>   		if (ret)
>   			goto cleanup;
>   	}
> @@ -1796,7 +1791,7 @@ static void rbio_add_bio(struct btrfs_raid_bio *rb=
io, struct bio *orig_bio)
>
>   	ASSERT(orig_logical >=3D full_stripe_start &&
>   	       orig_logical + orig_len <=3D full_stripe_start +
> -	       rbio->nr_data * rbio->stripe_len);
> +	       rbio->nr_data * BTRFS_STRIPE_LEN);
>
>   	bio_list_add(&rbio->bio_list, orig_bio);
>   	rbio->bio_list_bytes +=3D orig_bio->bi_iter.bi_size;
> @@ -1814,7 +1809,7 @@ static void rbio_add_bio(struct btrfs_raid_bio *rb=
io, struct bio *orig_bio)
>   /*
>    * our main entry point for writes from the rest of the FS.
>    */
> -int raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc,=
 u32 stripe_len)
> +int raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)
>   {
>   	struct btrfs_fs_info *fs_info =3D bioc->fs_info;
>   	struct btrfs_raid_bio *rbio;
> @@ -1822,7 +1817,7 @@ int raid56_parity_write(struct bio *bio, struct bt=
rfs_io_context *bioc, u32 stri
>   	struct blk_plug_cb *cb;
>   	int ret;
>
> -	rbio =3D alloc_rbio(fs_info, bioc, stripe_len);
> +	rbio =3D alloc_rbio(fs_info, bioc);
>   	if (IS_ERR(rbio)) {
>   		btrfs_put_bioc(bioc);
>   		return PTR_ERR(rbio);
> @@ -2147,8 +2142,7 @@ static int __raid56_parity_recover(struct btrfs_ra=
id_bio *rbio)
>   			continue;
>
>   		ret =3D rbio_add_io_sector(rbio, &bio_list, sector, stripe,
> -					 sectornr, rbio->stripe_len,
> -					 REQ_OP_READ);
> +					 sectornr, REQ_OP_READ);
>   		if (ret < 0)
>   			goto cleanup;
>   	}
> @@ -2206,7 +2200,7 @@ static int __raid56_parity_recover(struct btrfs_ra=
id_bio *rbio)
>    * of the drive.
>    */
>   int raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bi=
oc,
> -			  u32 stripe_len, int mirror_num, int generic_io)
> +			  int mirror_num, int generic_io)
>   {
>   	struct btrfs_fs_info *fs_info =3D bioc->fs_info;
>   	struct btrfs_raid_bio *rbio;
> @@ -2217,7 +2211,7 @@ int raid56_parity_recover(struct bio *bio, struct =
btrfs_io_context *bioc,
>   		btrfs_bio(bio)->mirror_num =3D mirror_num;
>   	}
>
> -	rbio =3D alloc_rbio(fs_info, bioc, stripe_len);
> +	rbio =3D alloc_rbio(fs_info, bioc);
>   	if (IS_ERR(rbio)) {
>   		if (generic_io)
>   			btrfs_put_bioc(bioc);
> @@ -2311,14 +2305,14 @@ static void read_rebuild_work(struct work_struct=
 *work)
>
>   struct btrfs_raid_bio *raid56_parity_alloc_scrub_rbio(struct bio *bio,
>   				struct btrfs_io_context *bioc,
> -				u32 stripe_len, struct btrfs_device *scrub_dev,
> +				struct btrfs_device *scrub_dev,
>   				unsigned long *dbitmap, int stripe_nsectors)
>   {
>   	struct btrfs_fs_info *fs_info =3D bioc->fs_info;
>   	struct btrfs_raid_bio *rbio;
>   	int i;
>
> -	rbio =3D alloc_rbio(fs_info, bioc, stripe_len);
> +	rbio =3D alloc_rbio(fs_info, bioc);
>   	if (IS_ERR(rbio))
>   		return NULL;
>   	bio_list_add(&rbio->bio_list, bio);
> @@ -2363,7 +2357,7 @@ void raid56_add_scrub_pages(struct btrfs_raid_bio =
*rbio, struct page *page,
>
>   	ASSERT(logical >=3D rbio->bioc->raid_map[0]);
>   	ASSERT(logical + sectorsize <=3D rbio->bioc->raid_map[0] +
> -				rbio->stripe_len * rbio->nr_data);
> +				BTRFS_STRIPE_LEN * rbio->nr_data);
>   	stripe_offset =3D (int)(logical - rbio->bioc->raid_map[0]);
>   	index =3D stripe_offset / sectorsize;
>   	rbio->bio_sectors[index].page =3D page;
> @@ -2519,7 +2513,7 @@ static noinline void finish_parity_scrub(struct bt=
rfs_raid_bio *rbio,
>
>   		sector =3D rbio_stripe_sector(rbio, rbio->scrubp, sectornr);
>   		ret =3D rbio_add_io_sector(rbio, &bio_list, sector, rbio->scrubp,
> -					 sectornr, rbio->stripe_len, REQ_OP_WRITE);
> +					 sectornr, REQ_OP_WRITE);
>   		if (ret)
>   			goto cleanup;
>   	}
> @@ -2533,7 +2527,7 @@ static noinline void finish_parity_scrub(struct bt=
rfs_raid_bio *rbio,
>   		sector =3D rbio_stripe_sector(rbio, rbio->scrubp, sectornr);
>   		ret =3D rbio_add_io_sector(rbio, &bio_list, sector,
>   				       bioc->tgtdev_map[rbio->scrubp],
> -				       sectornr, rbio->stripe_len, REQ_OP_WRITE);
> +				       sectornr, REQ_OP_WRITE);
>   		if (ret)
>   			goto cleanup;
>   	}
> @@ -2700,7 +2694,7 @@ static void raid56_parity_scrub_stripe(struct btrf=
s_raid_bio *rbio)
>   			continue;
>
>   		ret =3D rbio_add_io_sector(rbio, &bio_list, sector, stripe,
> -					 sectornr, rbio->stripe_len, REQ_OP_READ);
> +					 sectornr, REQ_OP_READ);
>   		if (ret)
>   			goto cleanup;
>   	}
> @@ -2765,13 +2759,12 @@ void raid56_parity_submit_scrub_rbio(struct btrf=
s_raid_bio *rbio)
>   /* The following code is used for dev replace of a missing RAID 5/6 de=
vice. */
>
>   struct btrfs_raid_bio *
> -raid56_alloc_missing_rbio(struct bio *bio, struct btrfs_io_context *bio=
c,
> -			  u64 length)
> +raid56_alloc_missing_rbio(struct bio *bio, struct btrfs_io_context *bio=
c)
>   {
>   	struct btrfs_fs_info *fs_info =3D bioc->fs_info;
>   	struct btrfs_raid_bio *rbio;
>
> -	rbio =3D alloc_rbio(fs_info, bioc, length);
> +	rbio =3D alloc_rbio(fs_info, bioc);
>   	if (IS_ERR(rbio))
>   		return NULL;
>
> diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
> index 3b22657ca857e..9e4e0501e4e89 100644
> --- a/fs/btrfs/raid56.h
> +++ b/fs/btrfs/raid56.h
> @@ -56,9 +56,6 @@ struct btrfs_raid_bio {
>   	 */
>   	enum btrfs_rbio_ops operation;
>
> -	/* Size of each individual stripe on disk */
> -	u32 stripe_len;
> -
>   	/* How many pages there are for the full stripe including P/Q */
>   	u16 nr_pages;
>
> @@ -179,21 +176,20 @@ static inline int nr_data_stripes(const struct map=
_lookup *map)
>   struct btrfs_device;
>
>   int raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bi=
oc,
> -			  u32 stripe_len, int mirror_num, int generic_io);
> -int raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc,=
 u32 stripe_len);
> +			  int mirror_num, int generic_io);
> +int raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)=
;
>
>   void raid56_add_scrub_pages(struct btrfs_raid_bio *rbio, struct page *=
page,
>   			    unsigned int pgoff, u64 logical);
>
>   struct btrfs_raid_bio *raid56_parity_alloc_scrub_rbio(struct bio *bio,
> -				struct btrfs_io_context *bioc, u32 stripe_len,
> +				struct btrfs_io_context *bioc,
>   				struct btrfs_device *scrub_dev,
>   				unsigned long *dbitmap, int stripe_nsectors);
>   void raid56_parity_submit_scrub_rbio(struct btrfs_raid_bio *rbio);
>
>   struct btrfs_raid_bio *
> -raid56_alloc_missing_rbio(struct bio *bio, struct btrfs_io_context *bio=
c,
> -			  u64 length);
> +raid56_alloc_missing_rbio(struct bio *bio, struct btrfs_io_context *bio=
c);
>   void raid56_submit_missing_rbio(struct btrfs_raid_bio *rbio);
>
>   int btrfs_alloc_stripe_hash_table(struct btrfs_fs_info *info);
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index db700e6ec5a93..18986d062cf63 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -1216,7 +1216,6 @@ static inline int scrub_nr_raid_mirrors(struct btr=
fs_io_context *bioc)
>
>   static inline void scrub_stripe_index_and_offset(u64 logical, u64 map_=
type,
>   						 u64 *raid_map,
> -						 u64 mapped_length,
>   						 int nstripes, int mirror,
>   						 int *stripe_index,
>   						 u64 *stripe_offset)
> @@ -1231,7 +1230,7 @@ static inline void scrub_stripe_index_and_offset(u=
64 logical, u64 map_type,
>   				continue;
>
>   			if (logical >=3D raid_map[i] &&
> -			    logical < raid_map[i] + mapped_length)
> +			    logical < raid_map[i] + BTRFS_STRIPE_LEN)
>   				break;
>   		}
>
> @@ -1335,7 +1334,6 @@ static int scrub_setup_recheck_block(struct scrub_=
block *original_sblock,
>   			scrub_stripe_index_and_offset(logical,
>   						      bioc->map_type,
>   						      bioc->raid_map,
> -						      mapped_length,
>   						      bioc->num_stripes -
>   						      bioc->num_tgtdevs,
>   						      mirror_index,
> @@ -1387,7 +1385,6 @@ static int scrub_submit_raid56_bio_wait(struct btr=
fs_fs_info *fs_info,
>
>   	mirror_num =3D sector->sblock->sectors[0]->mirror_num;
>   	ret =3D raid56_parity_recover(bio, sector->recover->bioc,
> -				    sector->recover->map_length,
>   				    mirror_num, 0);
>   	if (ret)
>   		return ret;
> @@ -2195,7 +2192,7 @@ static void scrub_missing_raid56_pages(struct scru=
b_block *sblock)
>   	bio->bi_private =3D sblock;
>   	bio->bi_end_io =3D scrub_missing_raid56_end_io;
>
> -	rbio =3D raid56_alloc_missing_rbio(bio, bioc, length);
> +	rbio =3D raid56_alloc_missing_rbio(bio, bioc);
>   	if (!rbio)
>   		goto rbio_out;
>
> @@ -2829,7 +2826,7 @@ static void scrub_parity_check_and_repair(struct s=
crub_parity *sparity)
>   	bio->bi_private =3D sparity;
>   	bio->bi_end_io =3D scrub_parity_bio_endio;
>
> -	rbio =3D raid56_parity_alloc_scrub_rbio(bio, bioc, length,
> +	rbio =3D raid56_parity_alloc_scrub_rbio(bio, bioc,
>   					      sparity->scrub_dev,
>   					      &sparity->dbitmap,
>   					      sparity->nsectors);
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 12a6150ee19d2..07b1e005d89df 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6459,6 +6459,7 @@ static int __btrfs_map_block(struct btrfs_fs_info =
*fs_info,
>   		}
>
>   	} else if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
> +		ASSERT(map->stripe_len =3D=3D BTRFS_STRIPE_LEN);
>   		if (need_raid_map && (need_full_stripe(op) || mirror_num > 1)) {
>   			/* push stripe_nr back to the start of the full stripe */
>   			stripe_nr =3D div64_u64(raid56_full_stripe_start,
> @@ -6756,14 +6757,10 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info =
*fs_info, struct bio *bio,
>
>   	if ((bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) &&
>   	    ((btrfs_op(bio) =3D=3D BTRFS_MAP_WRITE) || (mirror_num > 1))) {
> -		/* In this case, map_length has been set to the length of
> -		   a single stripe; not the whole write */
> -		if (btrfs_op(bio) =3D=3D BTRFS_MAP_WRITE) {
> -			ret =3D raid56_parity_write(bio, bioc, map_length);
> -		} else {
> -			ret =3D raid56_parity_recover(bio, bioc, map_length,
> -						    mirror_num, 1);
> -		}
> +		if (btrfs_op(bio) =3D=3D BTRFS_MAP_WRITE)
> +			ret =3D raid56_parity_write(bio, bioc);
> +		else
> +			ret =3D raid56_parity_recover(bio, bioc, mirror_num, 1);
>   		goto out_dec;
>   	}
>
