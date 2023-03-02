Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9176A8D0E
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Mar 2023 00:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjCBXbe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 18:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjCBXbd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 18:31:33 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626025849E
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 15:31:32 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MmULx-1qFhTI0oK1-00iSST; Fri, 03
 Mar 2023 00:31:25 +0100
Message-ID: <0a7aa6ea-4b42-ee7e-b5ca-0f97da5075df@gmx.com>
Date:   Fri, 3 Mar 2023 07:31:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 08/10] btrfs: store a pointer to a btrfs_bio in struct
 btrfs_bio_ctrl
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230301134244.1378533-1-hch@lst.de>
 <20230301134244.1378533-9-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230301134244.1378533-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:AV83+fb/oYFmATMr+lm+iyfhaB7ujP9xj5dBRt7a5P3DVw1gPrF
 xeMYNPWbL7U6GhJiUEGZXnSniYgwAitAA0aZuHV+cMpNSVHBLulHx15+gDBuQpkcNY30plc
 bk5vrACUDVsmjTJd1sz1WSY4j8wAKutKTTLGuhBejs3fb/5URVJPv1+oivn7CWf9m0K79/P
 t7DJ8NfvCsakojUeWH/gQ==
UI-OutboundReport: notjunk:1;M01:P0:lO8bMzLXhF8=;PbKYyFjlKrAHdqIgHcmcJNzwddN
 ZrJQ5NfzznNRpUj0lWBrU7//fsNB0wpRGTNPS9uCmjud16I6IoUuqByI4x5Rznd4wJYWuTKof
 GNGrvIdGE8+u1y1wYvzyB38q9J3JuRqrQQZCpJSBI4MAs/Q9AU2XXK/9czTFhBOLG38FINNX7
 Xzfg04lGx8ZGopXB/Pkgab08WPPGLHfXuM7F5EQ/LAjeprRXYO3aP83fCDSy3cNo4XBFMQlTr
 PaFDSB0OaMX14smePg31nGQoleBsuC8W09+HR3t9s3dgVpXh1C17bHbcII9T17dJD4/dvlROA
 FEv8Smuy+mz20QKXIMexhdG8wa0lzS6Z16mWuoM2FUCeQ+QlEBZBDc7KudZ9wF7VKBeX1DmKG
 Vz0ThdXRx6juRCkZkSWrdlrEF0maDw9Czs2cnnm53ZTqi2ulsikhmd1VJQ893O31w0GvCLS4p
 a0SfMAIXZwRHQvCutAlkc3tYFBnQ9SsGOxBmDC1B/ZJSNmeAbiFqBRqBTydZCy7TO5m5y2dOx
 w3JaTW9DgfwgDNmFLJEGXQ7S9QGK2FVd/YGq41OyzOHF4NlkFOlQhaWa9obLy/a7aWj43mvaG
 r+o7iRbCdN0uFDQH27txkqPPCdd2da87pJ+X1ytsRViUP3IUwLJQEaHRBtJqmNfp43LmbTeDj
 Nkm5ezuMQVG6TMSXsY4b2k+7eFO3DSD3oRPtOT+ztcQ7iu8eLhh6vRQ/egDaiM6H9PzXSDmGc
 9L5yarP357YFyhSZsJ8Te4dOxdKifPAyxCZ1oXwUIjMIllbXZpwJzSiZ0uOolGHHuvUIpAavX
 GMWuJj7spyT1jzx3feyYNk7WxdJXYWtmbtWmkKfDfk6QCgbAOc+mJ7wcWRYj7BTOdT/8OFmt9
 ItjEooaeGt8EH/wE1LEAkxyz3qKiGYIbV6MpGTWylVMYuLPVLDIRdqVNVZd7tdEWbodA9Ta3g
 kcecX3yAkFTAO8dSWB2dpNHX13o=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/1 21:42, Christoph Hellwig wrote:
> The bio in struct btrfs_bio_ctrl must be a btrfs_bio, so store a pointer
> to the btrfs_bio for better type checking.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/extent_io.c | 47 ++++++++++++++++++++++----------------------
>   1 file changed, 24 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 05b96a77fba104..df143c5267e61b 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -97,7 +97,7 @@ void btrfs_extent_buffer_leak_debug_check(struct btrfs_fs_info *fs_info)
>    * how many bytes are there before stripe/ordered extent boundary.
>    */
>   struct btrfs_bio_ctrl {
> -	struct bio *bio;
> +	struct btrfs_bio *bbio;
>   	int mirror_num;
>   	enum btrfs_compression_type compress_type;
>   	u32 len_to_oe_boundary;
> @@ -123,37 +123,37 @@ struct btrfs_bio_ctrl {
>   
>   static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
>   {
> -	struct bio *bio = bio_ctrl->bio;
> +	struct btrfs_bio *bbio = bio_ctrl->bbio;
>   	int mirror_num = bio_ctrl->mirror_num;
>   
> -	if (!bio)
> +	if (!bbio)
>   		return;
>   
>   	/* Caller should ensure the bio has at least some range added */
> -	ASSERT(bio->bi_iter.bi_size);
> +	ASSERT(bbio->bio.bi_iter.bi_size);
>   
> -	if (!is_data_inode(&btrfs_bio(bio)->inode->vfs_inode)) {
> -		if (btrfs_op(bio) != BTRFS_MAP_WRITE) {
> +	if (!is_data_inode(&bbio->inode->vfs_inode)) {
> +		if (btrfs_op(&bbio->bio) != BTRFS_MAP_WRITE) {
>   			/*
>   			 * For metadata read, we should have the parent_check,
>   			 * and copy it to bbio for metadata verification.
>   			 */
>   			ASSERT(bio_ctrl->parent_check);
> -			memcpy(&btrfs_bio(bio)->parent_check,
> +			memcpy(&bbio->parent_check,
>   			       bio_ctrl->parent_check,
>   			       sizeof(struct btrfs_tree_parent_check));
>   		}
> -		bio->bi_opf |= REQ_META;
> +		bbio->bio.bi_opf |= REQ_META;
>   	}
>   
> -	if (btrfs_op(bio) == BTRFS_MAP_READ &&
> +	if (btrfs_op(&bbio->bio) == BTRFS_MAP_READ &&
>   	    bio_ctrl->compress_type != BTRFS_COMPRESS_NONE)
> -		btrfs_submit_compressed_read(btrfs_bio(bio), mirror_num);
> +		btrfs_submit_compressed_read(bbio, mirror_num);
>   	else
> -		btrfs_submit_bio(btrfs_bio(bio), mirror_num);
> +		btrfs_submit_bio(bbio, mirror_num);
>   
>   	/* The bio is owned by the end_io handler now */
> -	bio_ctrl->bio = NULL;
> +	bio_ctrl->bbio = NULL;
>   }
>   
>   /*
> @@ -161,16 +161,16 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
>    */
>   static void submit_write_bio(struct btrfs_bio_ctrl *bio_ctrl, int ret)
>   {
> -	struct bio *bio = bio_ctrl->bio;
> +	struct btrfs_bio *bbio = bio_ctrl->bbio;
>   
> -	if (!bio)
> +	if (!bbio)
>   		return;
>   
>   	if (ret) {
>   		ASSERT(ret < 0);
> -		btrfs_bio_end_io(btrfs_bio(bio), errno_to_blk_status(ret));
> +		btrfs_bio_end_io(bbio, errno_to_blk_status(ret));
>   		/* The bio is owned by the end_io handler now */
> -		bio_ctrl->bio = NULL;
> +		bio_ctrl->bbio = NULL;
>   	} else {
>   		submit_one_bio(bio_ctrl);
>   	}
> @@ -863,7 +863,7 @@ static bool btrfs_bio_is_contig(struct btrfs_bio_ctrl *bio_ctrl,
>   				struct page *page, u64 disk_bytenr,
>   				unsigned int pg_offset)
>   {
> -	struct bio *bio = bio_ctrl->bio;
> +	struct bio *bio = &bio_ctrl->bbio->bio;
>   	struct bio_vec *bvec = bio_last_bvec_all(bio);
>   	const sector_t sector = disk_bytenr >> SECTOR_SHIFT;
>   
> @@ -902,7 +902,7 @@ static void alloc_new_bio(struct btrfs_inode *inode,
>   			      bio_ctrl->end_io_func, NULL);
>   	bio->bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
>   	btrfs_bio(bio)->file_offset = file_offset;
> -	bio_ctrl->bio = bio;
> +	bio_ctrl->bbio = btrfs_bio(bio);
>   	bio_ctrl->len_to_oe_boundary = U32_MAX;
>   
>   	/*
> @@ -942,8 +942,8 @@ static void alloc_new_bio(struct btrfs_inode *inode,
>    * @pg_offset:	offset of the new bio or to check whether we are adding
>    *              a contiguous page to the previous one
>    *
> - * The will either add the page into the existing @bio_ctrl->bio, or allocate a
> - * new one in @bio_ctrl->bio.
> + * The will either add the page into the existing @bio_ctrl->bbio, or allocate a
> + * new one in @bio_ctrl->bbio.
>    * The mirror number for this IO should already be initizlied in
>    * @bio_ctrl->mirror_num.
>    */
> @@ -956,7 +956,7 @@ static void submit_extent_page(struct btrfs_bio_ctrl *bio_ctrl,
>   	ASSERT(pg_offset + size <= PAGE_SIZE);
>   	ASSERT(bio_ctrl->end_io_func);
>   
> -	if (bio_ctrl->bio &&
> +	if (bio_ctrl->bbio &&
>   	    !btrfs_bio_is_contig(bio_ctrl, page, disk_bytenr, pg_offset))
>   		submit_one_bio(bio_ctrl);
>   
> @@ -964,7 +964,7 @@ static void submit_extent_page(struct btrfs_bio_ctrl *bio_ctrl,
>   		u32 len = size;
>   
>   		/* Allocate new bio if needed */
> -		if (!bio_ctrl->bio) {
> +		if (!bio_ctrl->bbio) {
>   			alloc_new_bio(inode, bio_ctrl, disk_bytenr,
>   				      page_offset(page) + pg_offset);
>   		}
> @@ -976,7 +976,8 @@ static void submit_extent_page(struct btrfs_bio_ctrl *bio_ctrl,
>   			len = bio_ctrl->len_to_oe_boundary;
>   		}
>   
> -		if (bio_add_page(bio_ctrl->bio, page, len, pg_offset) != len) {
> +		if (bio_add_page(&bio_ctrl->bbio->bio, page, len, pg_offset) !=
> +				len) {
>   			/* bio full: move on to a new one */
>   			submit_one_bio(bio_ctrl);
>   			continue;
