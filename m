Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7732161E723
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Nov 2022 23:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiKFW5M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Nov 2022 17:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiKFW5L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Nov 2022 17:57:11 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F346153
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Nov 2022 14:57:07 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MYeR1-1oWefb0DY3-00ViWf; Sun, 06
 Nov 2022 23:57:04 +0100
Message-ID: <b748d106-4a20-0c33-8e87-dfa6de0b281a@gmx.com>
Date:   Mon, 7 Nov 2022 06:57:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] btrfs: scrub: fix failed to detect checksum error
Content-Language: en-US
To:     Li Zhang <zhanglikernel@gmail.com>, linux-btrfs@vger.kernel.org
References: <1667745304-11470-1-git-send-email-zhanglikernel@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <1667745304-11470-1-git-send-email-zhanglikernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:JQCAssXG8dNolAF0wbjRmc+YeRviO7yqjerRNcWHrJoGo6n63sd
 37Fgpu8YHaASYvqulOwm3ECx1P34Q+co6+azC3VPZo4vxRErkJ29Kj5pp2NNvTRRpPHc7vm
 e4YLeXkLK1y1CPYSZfU+itB9ucvqHlTLStGrE6u63cbexe1UdHO7nr48uG2aBhpAp14MQ+H
 CPWFnLX5tnHOTa+Eh3yUA==
UI-OutboundReport: notjunk:1;M01:P0:RMT0TtAJ2W0=;0UEgPZ9rDOLTg9jXkDhIVVLAUYX
 wMggKvcOg15ZEMZMBD+RvwtoHOruxQpXYtxrKaio2SkEfrh1AfzIyFEK2oYoY4omhz0H6XVOK
 a9F2Ma0SdGDA/n+ddWe4n4UXZwCJZ54qux90/tx6NURmQwNEuTltTSJ1549LKJqKBTECRfjpD
 AEXCbZnokrWf690siri/KYFbJ7yI1LrfE4AWCLi4XAUVhGDVcJSvAPWdYPfGZ0geMvRVb7I3N
 J9SRyoBJZ1ARNZMX5tYdzkjo1I6Sae0drjvb8UYhnRs/TtBtAxbNdeVGi0mTh+bd/C/GfNJ/H
 bvu7oS6pwW1BgSsNoybEc0Akz61ENlI93N9y3hWY0lYPwR8cL48MUWveP/q/qh0YupysogQT+
 t9/x1UJoII4if9P/pWygWbZVFs2CLpLY258FyREBpcuRlqObH0A/WIzU2txXcsELfKyZrrsWi
 5UaqxsjBBk2A2LAEMw1YCc/gF4azTTiT8HPS5xS7xT4zeU17ASBW1fgbNKTTJF10tEDZeIePo
 iUqzHaV0pcaYb5XkjbNMlCbZ0bZ803a5zMyl0gcuGGjddsz2SXA+niS/08BK1Jo/69mfr+M2A
 +gHH+D0tCwQokwuyFWMalioqamR1zCN4CtVJ2TA28ACHFeIXdiUdO9Sm4FXc99Hoy/X7rY9+l
 9DXr8SM2c/a8SscIRlyDktWyNkEfXtx3JneKGAEDGHolNgrBLP36tuNT+HJVAhYuE+3LoXEka
 IoUtlWlNIiNV4gIEJr4CnowKtZKWyKTAyKDeaiHSfyURWkIusD38qAdHdFwbAHhjoZil2Ncq6
 Jwa4Y9R8aJOsKSaVhLlwgz+vxXiyeX3JAzpZKvB85RIrQoSOZaMkmkYyONGlrpnyx6aeZntUE
 K+ZB4z6RCxTcdtNayk3/kU2Rh4OkgSqKtavfeJsGfaBDzFA64pFT3R0CMXzkRX8LbCnZqmh1c
 dUeNgw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/6 22:35, Li Zhang wrote:
> [bug]
> Scrub fails to detect checksum errors
> To reproduce the problem:
> 
> $ truncate -s 250M loop_dev1
> $ truncate -s 250M loop_dev2
> $ losetup /dev/loop1 loop_dev1
> $ losetup /dev/loop2 loop_dev2
> $ mkfs.btrfs -mraid1 -draid1 /dev/loop1 /dev/loop2 -f
> $ mount /dev/loop1 /mnt/
> $ cp ~/btrfs/btrfs-progs/mkfs/main.c /mnt/
> 
> $ vim -b loop_dev1
> 
> ....
>           free(label);
>           free(source_dir);
>           exit(1);
> success:
>           exit(0);
> }zhangli
> 
> ....
> 
> $ sudo btrfs scrub start /mnt/
> fsid:b66aa912-ae76-4b4b-881b-6a6840f06870 sock_path:/var/lib/btrfs/scrub.progress.b66aa912-ae76-4b4b-881b-6a6840f06870.
> scrub started on /mnt/, fsid b66aa912-ae76-4b4b-881b-6a6840f06870 (pid=9894)
> 
> $ sudo btrfs scrub status /mnt/
> UUID:             b66aa912-ae76-4b4b-881b-6a6840f06870
> Scrub started:    Sun Nov  6 21:51:50 2022
> Status:           finished
> Duration:         0:00:00
> Total to scrub:   392.00KiB
> Rate:             0.00B/s
> Error summary:    no errors found
> 
> [reason]
> Because scrub only checks the first sector (scrub_sector) of
> the sblock (scrub_block), it does not check other sectors.

That's caused by commit 786672e9e1a3 ("btrfs: scrub: use larger block 
size for data extent scrub"), which enlarged data scrub extent size 
(previously always sectorsize, thus there will only be one sector per 
scrub_block, thus it always works before that commit).

I'd prefer a revert before we have better fix.

> 
> [implementation]
> 1. Move the set sector (scrub_sector) csum from scrub_extent
> to scrub_sectors, since each sector has an independent checksum.
> 2. In the scrub_checksum_data function, check all
> sectors in the sblock.
> 3. In the scrub_setup_recheck_block function,
> use sector_index to set the sector csum.
> 
> [test]
> The test method is the same as the problem reproduction.
> Can detect checksum errors and fix checksum errors
> Below is the scrub output.
> 
> $ sudo btrfs scrub start /mnt/
> fsid:b66aa912-ae76-4b4b-881b-6a6840f06870 sock_path:/var/lib/btrfs/scrub.progress.b66aa912-ae76-4b4b-881b-6a6840f06870.
> scrub started on /mnt/, fsid b66aa912-ae76-4b4b-881b-6a6840f06870 (pid=11089)
> $ sudo btrfs scrub status /mnt/WARNING: errors detected during scrubbing, corrected
> 
> UUID:             b66aa912-ae76-4b4b-881b-6a6840f06870
> Scrub started:    Sun Nov  6 22:15:02 2022
> Status:           finished
> Duration:         0:00:00
> Total to scrub:   392.00KiB
> Rate:             0.00B/s
> Error summary:    csum=1
>    Corrected:      1
>    Uncorrectable:  0
>    Unverified:     0
> 
> Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
> ---
> Issue: 537
> 
>   fs/btrfs/scrub.c | 58 ++++++++++++++++++++++++++++----------------------------
>   1 file changed, 29 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index f260c53..56ee600 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -404,7 +404,7 @@ static int scrub_write_sector_to_dev_replace(struct scrub_block *sblock,
>   static void scrub_parity_put(struct scrub_parity *sparity);
>   static int scrub_sectors(struct scrub_ctx *sctx, u64 logical, u32 len,
>   			 u64 physical, struct btrfs_device *dev, u64 flags,
> -			 u64 gen, int mirror_num, u8 *csum,
> +			 u64 gen, int mirror_num,
>   			 u64 physical_for_dev_replace);
>   static void scrub_bio_end_io(struct bio *bio);
>   static void scrub_bio_end_io_worker(struct work_struct *work);
> @@ -420,6 +420,8 @@ static int scrub_add_sector_to_wr_bio(struct scrub_ctx *sctx,
>   static void scrub_wr_bio_end_io(struct bio *bio);
>   static void scrub_wr_bio_end_io_worker(struct work_struct *work);
>   static void scrub_put_ctx(struct scrub_ctx *sctx);
> +static int scrub_find_csum(struct scrub_ctx *sctx, u64 logical, u8 *csum);
> +

I don't think this is the way to go, since we can have a extent up to 
STRIPE_LEN, going csum search again and again is not the proper way to go.

We need a function to grab a batch of csum in just one go.

>   
>   static inline int scrub_is_page_on_raid56(struct scrub_sector *sector)
>   {
> @@ -1516,7 +1518,7 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
>   			sector->have_csum = have_csum;
>   			if (have_csum)
>   				memcpy(sector->csum,
> -				       original_sblock->sectors[0]->csum,
> +				       original_sblock->sectors[sector_index]->csum,
>   				       sctx->fs_info->csum_size);
>   
>   			scrub_stripe_index_and_offset(logical,
> @@ -1984,21 +1986,22 @@ static int scrub_checksum_data(struct scrub_block *sblock)
>   	u8 csum[BTRFS_CSUM_SIZE];
>   	struct scrub_sector *sector;
>   	char *kaddr;
> +	int i;
>   
>   	BUG_ON(sblock->sector_count < 1);
> -	sector = sblock->sectors[0];
> -	if (!sector->have_csum)
> -		return 0;
> -
> -	kaddr = scrub_sector_get_kaddr(sector);
>   
>   	shash->tfm = fs_info->csum_shash;
>   	crypto_shash_init(shash);
> +	for (i = 0; i < sblock->sector_count; i++) {
> +		sector = sblock->sectors[i];
> +		if (!sector->have_csum)
> +			continue;
>   
> -	crypto_shash_digest(shash, kaddr, fs_info->sectorsize, csum);
> -
> -	if (memcmp(csum, sector->csum, fs_info->csum_size))
> -		sblock->checksum_error = 1;
> +		kaddr = scrub_sector_get_kaddr(sector);
> +		crypto_shash_digest(shash, kaddr, fs_info->sectorsize, csum);
> +		if (memcmp(csum, sector->csum, fs_info->csum_size))
> +			sblock->checksum_error = 1;

That would only increase checksum error by 1, but we may have multiple 
corruptions in that extent.

This hotfix is going to screw up scrub error reporting.

Thanks,
Qu
> +	}
>   	return sblock->checksum_error;
>   }
>   
> @@ -2400,12 +2403,14 @@ static void scrub_missing_raid56_pages(struct scrub_block *sblock)
>   
>   static int scrub_sectors(struct scrub_ctx *sctx, u64 logical, u32 len,
>   		       u64 physical, struct btrfs_device *dev, u64 flags,
> -		       u64 gen, int mirror_num, u8 *csum,
> +		       u64 gen, int mirror_num,
>   		       u64 physical_for_dev_replace)
>   {
>   	struct scrub_block *sblock;
>   	const u32 sectorsize = sctx->fs_info->sectorsize;
>   	int index;
> +	u8 csum[BTRFS_CSUM_SIZE];
> +	int have_csum;
>   
>   	sblock = alloc_scrub_block(sctx, dev, logical, physical,
>   				   physical_for_dev_replace, mirror_num);
> @@ -2424,7 +2429,6 @@ static int scrub_sectors(struct scrub_ctx *sctx, u64 logical, u32 len,
>   		 * more memory for PAGE_SIZE > sectorsize case.
>   		 */
>   		u32 l = min(sectorsize, len);
> -
>   		sector = alloc_scrub_sector(sblock, logical, GFP_KERNEL);
>   		if (!sector) {
>   			spin_lock(&sctx->stat_lock);
> @@ -2435,11 +2439,16 @@ static int scrub_sectors(struct scrub_ctx *sctx, u64 logical, u32 len,
>   		}
>   		sector->flags = flags;
>   		sector->generation = gen;
> -		if (csum) {
> -			sector->have_csum = 1;
> -			memcpy(sector->csum, csum, sctx->fs_info->csum_size);
> -		} else {
> -			sector->have_csum = 0;
> +		if (flags & BTRFS_EXTENT_FLAG_DATA) {
> +			/* push csums to sbio */
> +			have_csum = scrub_find_csum(sctx, logical, csum);
> +			if (have_csum == 0) {
> +				++sctx->stat.no_csum;
> +				sector->have_csum = 0;
> +			} else {
> +				sector->have_csum = 1;
> +				memcpy(sector->csum, csum, sctx->fs_info->csum_size);
> +			}
>   		}
>   		len -= l;
>   		logical += l;
> @@ -2669,7 +2678,6 @@ static int scrub_extent(struct scrub_ctx *sctx, struct map_lookup *map,
>   	u64 src_physical = physical;
>   	int src_mirror = mirror_num;
>   	int ret;
> -	u8 csum[BTRFS_CSUM_SIZE];
>   	u32 blocksize;
>   
>   	/*
> @@ -2715,17 +2723,9 @@ static int scrub_extent(struct scrub_ctx *sctx, struct map_lookup *map,
>   				     &src_dev, &src_mirror);
>   	while (len) {
>   		u32 l = min(len, blocksize);
> -		int have_csum = 0;
> -
> -		if (flags & BTRFS_EXTENT_FLAG_DATA) {
> -			/* push csums to sbio */
> -			have_csum = scrub_find_csum(sctx, logical, csum);
> -			if (have_csum == 0)
> -				++sctx->stat.no_csum;
> -		}
>   		ret = scrub_sectors(sctx, logical, l, src_physical, src_dev,
>   				    flags, gen, src_mirror,
> -				    have_csum ? csum : NULL, physical);
> +				    physical);
>   		if (ret)
>   			return ret;
>   		len -= l;
> @@ -4155,7 +4155,7 @@ static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
>   
>   		ret = scrub_sectors(sctx, bytenr, BTRFS_SUPER_INFO_SIZE, bytenr,
>   				    scrub_dev, BTRFS_EXTENT_FLAG_SUPER, gen, i,
> -				    NULL, bytenr);
> +				    bytenr);
>   		if (ret)
>   			return ret;
>   	}
