Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE066A8D08
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Mar 2023 00:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjCBX3v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 18:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjCBX3s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 18:29:48 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9930F231F4
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 15:29:18 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MhD6g-1qC97f2BAA-00eJ60; Fri, 03
 Mar 2023 00:28:46 +0100
Message-ID: <f474b5c6-2cd9-29a6-9bb5-3af28090688e@gmx.com>
Date:   Fri, 3 Mar 2023 07:28:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 06/10] btrfs: store a pointer to the original btrfs_bio in
 struct compressed_bio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230301134244.1378533-1-hch@lst.de>
 <20230301134244.1378533-7-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230301134244.1378533-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:MPQuaFp70HuulMPZxoJ8f8bqcwg1bDpVmnhhAdp3nwJzp4etRiw
 oakUxARJdB7uwuDU6Z8aa7mx2rnDzLK8gTYVI3rnLoY7oCjiizMi1ZTud5ufvi7kJ0yYRRj
 rTNQ/VNmAY54x9yJHK9EM0fLAMCGbjk3NbNNubf7ceYJ1LaUAuQWDLPlQLblURHBrNuCNmx
 yQGkvsgFg8qImsE/IciiQ==
UI-OutboundReport: notjunk:1;M01:P0:lDAfVOiPKZE=;s3GDkh9BxqdNXITMkJuOsJHb6AU
 HPkqENKwFaW4DMKEfqsQJv8D/sicRyX4VhHGyNtx32ljGOfBvSHgR+W0JtR8EWTbJW311ujg6
 aXkFcG1kQcOzyUw2QsW9opmrUtoE5wblWGSZ6pyIXHuMy5he19VTSm2ycJygVpf/BsZbCxCul
 Kfe/ZPYj/Luizf/hIDtkfbDt3wrgUSekk4A+NmQ0Ozr/CdKd1b51GUk9vWQNl2ZcPeO55FdWC
 RBAebYpTF7g7Kx19bkQXn1cGKzSgfsKWJtxFjkGA8bkK7+/VzjsYy0BaWETfiLJicbYnNEiDZ
 j6PBOHbBdyJh8pxrpODv9uMCbuU9e+5c9hy9xU2kR9OtYKUAUiJGAWWg3GkrHLA/88g5kRzUl
 jKkdoJ4ifwvlTHMllBd1HFKZ90jgnNkb02xMKGabwWXfaMHGF/Y4zoRcNKSEqyKnT3vSaHv6a
 lQSCVvipO9Px4cnrHikKL960vQXxiAInt0lyadk+3DdVFGPPq5+SYrJhwrA8Sg3d/4l1By1tf
 ltEbeOLsACrw5KpYbvQR9AoBPdJG1yxoG/Q5GH8dpw95F6B5RCxzyAFQ/P98ed9B79MU7cFfQ
 dlwTw/Yf+X+2ViuGIUYKQW8kHvyiIhd0z2ikTAYLECDYERAezJsojFGEPTiCOVfX7eBIfuUd8
 s2m6rQKTysPy9l2lESpszsjrjPHqwdLEWy4wIY2KjJBAtwhfy4+rYO+xf+87bcOHtRk7jj/Fi
 uut027JjwjOARCmemLjacC++lamujOFgVpBeYczjjVM74E7AUt2J9Y7yOOYENa7j1NaXFG5DU
 BzC2QZ8Ug+krCxiS/Szli7yf1Z806KcFXbiECmjQyaugWeH8NOApIq7ml29dGnvKTLNprZyyT
 YdmeXpBaOKpVtXM7+dby0+oc6+pyyXHJl4A2Wm6pnzSPtOUv4fSnPNhC07ZgUOdwsCbaUPeMx
 YrKD2YnHHHEQgyAGi8pGHZe+93Y=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/1 21:42, Christoph Hellwig wrote:
> The original bio must be a btrfs_bio, so store a pointer to the
> btrfs_bio for better type checking.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/compression.c | 15 ++++++++-------
>   fs/btrfs/compression.h |  2 +-
>   2 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index c12e317e133624..c5839d04690d67 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -177,7 +177,7 @@ static void end_compressed_bio_read(struct btrfs_bio *bbio)
>   		status = errno_to_blk_status(btrfs_decompress_bio(cb));
>   
>   	btrfs_free_compressed_pages(cb);
> -	btrfs_bio_end_io(btrfs_bio(cb->orig_bio), status);
> +	btrfs_bio_end_io(cb->orig_bbio, status);
>   	bio_put(&bbio->bio);
>   }
>   
> @@ -357,7 +357,8 @@ static noinline int add_ra_bio_pages(struct inode *inode,
>   {
>   	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>   	unsigned long end_index;
> -	u64 cur = btrfs_bio(cb->orig_bio)->file_offset + cb->orig_bio->bi_iter.bi_size;
> +	struct bio *orig_bio = &cb->orig_bbio->bio;
> +	u64 cur = cb->orig_bbio->file_offset + orig_bio->bi_iter.bi_size;
>   	u64 isize = i_size_read(inode);
>   	int ret;
>   	struct page *page;
> @@ -447,7 +448,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
>   		 */
>   		if (!em || cur < em->start ||
>   		    (cur + fs_info->sectorsize > extent_map_end(em)) ||
> -		    (em->block_start >> 9) != cb->orig_bio->bi_iter.bi_sector) {
> +		    (em->block_start >> 9) != orig_bio->bi_iter.bi_sector) {
>   			free_extent_map(em);
>   			unlock_extent(tree, cur, page_end, NULL);
>   			unlock_page(page);
> @@ -467,7 +468,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
>   		}
>   
>   		add_size = min(em->start + em->len, page_end + 1) - cur;
> -		ret = bio_add_page(cb->orig_bio, page, add_size, offset_in_page(cur));
> +		ret = bio_add_page(orig_bio, page, add_size, offset_in_page(cur));
>   		if (ret != add_size) {
>   			unlock_extent(tree, cur, page_end, NULL);
>   			unlock_page(page);
> @@ -537,7 +538,7 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio, int mirror_num)
>   	cb->len = bbio->bio.bi_iter.bi_size;
>   	cb->compressed_len = compressed_len;
>   	cb->compress_type = em->compress_type;
> -	cb->orig_bio = &bbio->bio;
> +	cb->orig_bbio = bbio;
>   
>   	free_extent_map(em);
>   
> @@ -966,7 +967,7 @@ static int btrfs_decompress_bio(struct compressed_bio *cb)
>   	put_workspace(type, workspace);
>   
>   	if (!ret)
> -		zero_fill_bio(cb->orig_bio);
> +		zero_fill_bio(&cb->orig_bbio->bio);
>   	return ret;
>   }
>   
> @@ -1044,7 +1045,7 @@ void __cold btrfs_exit_compress(void)
>   int btrfs_decompress_buf2page(const char *buf, u32 buf_len,
>   			      struct compressed_bio *cb, u32 decompressed)
>   {
> -	struct bio *orig_bio = cb->orig_bio;
> +	struct bio *orig_bio = &cb->orig_bbio->bio;
>   	/* Offset inside the full decompressed extent */
>   	u32 cur_offset;
>   
> diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
> index 692bafa1050e8e..5d5146e72a860b 100644
> --- a/fs/btrfs/compression.h
> +++ b/fs/btrfs/compression.h
> @@ -55,7 +55,7 @@ struct compressed_bio {
>   
>   	union {
>   		/* For reads, this is the bio we are copying the data into */
> -		struct bio *orig_bio;
> +		struct btrfs_bio *orig_bbio;
>   		struct work_struct write_end_work;
>   	};
>   
