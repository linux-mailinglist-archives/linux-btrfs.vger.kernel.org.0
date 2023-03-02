Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293226A8D0F
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Mar 2023 00:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjCBXcJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 18:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjCBXcI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 18:32:08 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059FC58493
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 15:32:06 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N7iCg-1qcZuJ32CQ-014o70; Fri, 03
 Mar 2023 00:31:58 +0100
Message-ID: <7fb0a5cd-2fd2-cd46-da60-2bb594bc2a9c@gmx.com>
Date:   Fri, 3 Mar 2023 07:31:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 09/10] btrfs: return a btrfs_bio from btrfs_bio_alloc
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230301134244.1378533-1-hch@lst.de>
 <20230301134244.1378533-10-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230301134244.1378533-10-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:DJxGGqefjLO3b9uIAzXK8yvgLqX/ph1yAichsYB4+j0INgedLiA
 aCzssTNgxRmnz2CXc5LcG0Ejv9HF0VNgNA1RE+CcAI+mg7nJ3QfZB5MeyW5c7ynhAdJ4GGS
 PgY/zUvAEbm6AxnwtWlpyLiI9WvWb8ODAH4ObLzTIWzJmFd+TsNyZtGhMiZtsEPhNVHoBOY
 EMg5WHAwys1C1wlL6uaKw==
UI-OutboundReport: notjunk:1;M01:P0:sDgkGnkYlXE=;8pIK0C1/bbZ6jSXaZxZzTkoGP2K
 Dg6m8BTQ0OWgS7BR3TkWblhVogT/NcycVFf1A3EpoX/LmLXHdGSW2rRSRPInqk9z8A+qsS7Nt
 a5KDPgSyMvCGKqhki18i3nhdZvtjjev1WUIfHXuKkY1MhgRkLmVOYRaI8IAIl2yQCq5q+noUN
 wx3tre2cAdjS7Refum+o/lp3LeFfHuGqz53pKS5DKqYn8qMn7DBSH2ky1wYqHWCYS5NW4teTn
 sBIp+8Oi5NfQpI/7sPAGvjfValgc4AytqAivsLlz6CFt9r4TZmvqybKyIHp8K0n43xhoGfFIE
 IuC1sW7j2x262IB+Zu7ScQjpyifkJCd7JBavtkDLW88BTJ9077yz9OUm8ILCSEmqu42hm/EUI
 QHZ4WnKtCQpAWNonL3cW66kUyuVadF5oARiOIB73X4rj+hDPMC/NcKcqeUcFtKzItODpillBB
 CMFVUnkGZH9Wqt0w6XCZimCAGUxTWGxiU7JpyfgYqyPrGsnnBBzdgUBNPGlsD+t+g7FWQ+vGW
 claNHWsL5tMBMByyJM3mTEp934pvLGY44hOGlVC6fQueFk9cNpl+3mztHf7pKkbWORCPC8+8G
 UpqjL7JoAY3vC0xO4YfEPNasD6OXw05Ght2vzIGSjOgA56ljfeIIiVHG7AdpA9MorNYsmQiSV
 CoSGFqIiZwyM8m3AfQLO8hyl67FRLYyOSa0XrN/CcJalT//1VD28yrAzBFI6X/0+N0iWv0mCQ
 4/vuOlmzCGkA76d60Ca6IWgw8kqrwmI9kr1YeMrq0hcmvFz8ITCHmBaENoZBnAjn696Hp68b2
 1Rlrdgn5ds3QK8fgWEvXR3e1dAVgknbRntg9Q7XC39nJOGJGF2J6hYWbXisALGD1oDxbsjp0S
 DRsN0HjMJzRU9nE/0schfGV7t/ehmPgvHtjVWS6hsQjc2ZmCsvVSJE1fd8P580Ajms4IYLZQ/
 UElJTvujgqr8pbtzsAtWbPoOktM=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/1 21:42, Christoph Hellwig wrote:
> Return the conaining struct btrfs_bio instead of the less type safe
> struct bio from btrfs_bio_alloc.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/bio.c       | 12 +++++++-----
>   fs/btrfs/bio.h       |  6 +++---
>   fs/btrfs/extent_io.c | 18 +++++++++---------
>   fs/btrfs/inode.c     | 18 +++++++++---------
>   4 files changed, 28 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index c04e103f876853..527081abca026f 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -48,15 +48,17 @@ void btrfs_bio_init(struct btrfs_bio *bbio, struct btrfs_inode *inode,
>    * Just like the underlying bio_alloc_bioset it will not fail as it is backed by
>    * a mempool.
>    */
> -struct bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
> -			    struct btrfs_inode *inode,
> -			    btrfs_bio_end_io_t end_io, void *private)
> +struct btrfs_bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
> +				  struct btrfs_inode *inode,
> +				  btrfs_bio_end_io_t end_io, void *private)
>   {
> +	struct btrfs_bio *bbio;
>   	struct bio *bio;
>   
>   	bio = bio_alloc_bioset(NULL, nr_vecs, opf, GFP_NOFS, &btrfs_bioset);
> -	btrfs_bio_init(btrfs_bio(bio), inode, end_io, private);
> -	return bio;
> +	bbio = btrfs_bio(bio);
> +	btrfs_bio_init(bbio, inode, end_io, private);
> +	return bbio;
>   }
>   
>   static struct bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
> diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
> index b4e7d5ab7d236d..dbf125f6fa336d 100644
> --- a/fs/btrfs/bio.h
> +++ b/fs/btrfs/bio.h
> @@ -75,9 +75,9 @@ void __cold btrfs_bioset_exit(void);
>   
>   void btrfs_bio_init(struct btrfs_bio *bbio, struct btrfs_inode *inode,
>   		    btrfs_bio_end_io_t end_io, void *private);
> -struct bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
> -			    struct btrfs_inode *inode,
> -			    btrfs_bio_end_io_t end_io, void *private);
> +struct btrfs_bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
> +				  struct btrfs_inode *inode,
> +				  btrfs_bio_end_io_t end_io, void *private);
>   
>   static inline void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
>   {
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index df143c5267e61b..2d5e4df3419b0f 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -896,13 +896,13 @@ static void alloc_new_bio(struct btrfs_inode *inode,
>   			  u64 disk_bytenr, u64 file_offset)
>   {
>   	struct btrfs_fs_info *fs_info = inode->root->fs_info;
> -	struct bio *bio;
> +	struct btrfs_bio *bbio;
>   
> -	bio = btrfs_bio_alloc(BIO_MAX_VECS, bio_ctrl->opf, inode,
> -			      bio_ctrl->end_io_func, NULL);
> -	bio->bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
> -	btrfs_bio(bio)->file_offset = file_offset;
> -	bio_ctrl->bbio = btrfs_bio(bio);
> +	bbio = btrfs_bio_alloc(BIO_MAX_VECS, bio_ctrl->opf, inode,
> +			       bio_ctrl->end_io_func, NULL);
> +	bbio->bio.bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
> +	bbio->file_offset = file_offset;
> +	bio_ctrl->bbio = bbio;
>   	bio_ctrl->len_to_oe_boundary = U32_MAX;
>   
>   	/*
> @@ -911,7 +911,7 @@ static void alloc_new_bio(struct btrfs_inode *inode,
>   	 * them.
>   	 */
>   	if (bio_ctrl->compress_type == BTRFS_COMPRESS_NONE &&
> -	    btrfs_use_zone_append(btrfs_bio(bio))) {
> +	    btrfs_use_zone_append(bbio)) {
>   		struct btrfs_ordered_extent *ordered;
>   
>   		ordered = btrfs_lookup_ordered_extent(inode, file_offset);
> @@ -930,8 +930,8 @@ static void alloc_new_bio(struct btrfs_inode *inode,
>   		 * to always be set on the last added/replaced device.
>   		 * This is a bit odd but has been like that for a long time.
>   		 */
> -		bio_set_dev(bio, fs_info->fs_devices->latest_dev->bdev);
> -		wbc_init_bio(bio_ctrl->wbc, bio);
> +		bio_set_dev(&bbio->bio, fs_info->fs_devices->latest_dev->bdev);
> +		wbc_init_bio(bio_ctrl->wbc, &bbio->bio);
>   	}
>   }
>   
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index ed96c84f5be71d..7e691bab72dffa 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -9959,24 +9959,24 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
>   		.pending = ATOMIC_INIT(1),
>   	};
>   	unsigned long i = 0;
> -	struct bio *bio;
> +	struct btrfs_bio *bbio;
>   
>   	init_waitqueue_head(&priv.wait);
>   
> -	bio = btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_READ, inode,
> +	bbio = btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_READ, inode,
>   			      btrfs_encoded_read_endio, &priv);
> -	bio->bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
> +	bbio->bio.bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
>   
>   	do {
>   		size_t bytes = min_t(u64, disk_io_size, PAGE_SIZE);
>   
> -		if (bio_add_page(bio, pages[i], bytes, 0) < bytes) {
> +		if (bio_add_page(&bbio->bio, pages[i], bytes, 0) < bytes) {
>   			atomic_inc(&priv.pending);
> -			btrfs_submit_bio(btrfs_bio(bio), 0);
> +			btrfs_submit_bio(bbio, 0);
>   
> -			bio = btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_READ, inode,
> -					      btrfs_encoded_read_endio, &priv);
> -			bio->bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
> +			bbio = btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_READ, inode,
> +					       btrfs_encoded_read_endio, &priv);
> +			bbio->bio.bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
>   			continue;
>   		}
>   
> @@ -9986,7 +9986,7 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
>   	} while (disk_io_size);
>   
>   	atomic_inc(&priv.pending);
> -	btrfs_submit_bio(btrfs_bio(bio), 0);
> +	btrfs_submit_bio(bbio, 0);
>   
>   	if (atomic_dec_return(&priv.pending))
>   		io_wait_event(priv.wait, !atomic_read(&priv.pending));
