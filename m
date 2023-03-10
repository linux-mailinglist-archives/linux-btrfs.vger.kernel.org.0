Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEE16B38CC
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Mar 2023 09:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjCJIfC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Mar 2023 03:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjCJIe0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Mar 2023 03:34:26 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A6A5D265
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Mar 2023 00:34:22 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MO9z7-1puZ002ru5-00OVqi; Fri, 10
 Mar 2023 09:34:14 +0100
Message-ID: <1ec86c37-b5d9-639e-fb9a-f78088164b9f@gmx.com>
Date:   Fri, 10 Mar 2023 16:34:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 12/20] btrfs: simplify extent buffer writing
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230309090526.332550-1-hch@lst.de>
 <20230309090526.332550-13-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230309090526.332550-13-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:s8LZrp2mmGjS65OG4xorXOLdr9leJ+J+doz9/gTNyuM8OvmL0nn
 c9u17Py/D8V164bkCX0a3Ghm38gBitMtgvcQiF34kW0Qe9n/vb/8Uw+cyfjiNcbEjGuL9Xh
 SkcHi6rpHSpNZc6sH1PV412mxKzUjv/6wcUoN1RUwqkCfEWq3IlEzbBQChAOM99K5oSgpQF
 UymuZaMyCTpYfVEQ5FEyw==
UI-OutboundReport: notjunk:1;M01:P0:YxIMvKf3yEs=;zJadYCHbwLiiab9bs28fQMbQA0t
 b4AhxsXU3r0Rx+7v3F0JAiprYHO4WYj1lrnEExJU968ibLk9oOc1kny0EB3L64gVEzWFlAVUn
 RstAmZKqOMgGOUxwxTY6IMQyfWOQMb+3DWpDSaGwkURsL6YY1kYbTvHiHg6FErBEdyLlo0c7P
 T95BBGzWHJ8csCfF/qVsNOGep7Y9P4KjXcOgC6d1ggGnNYI2PyFcWTuFiEzVf+NNmMQuxfVYq
 fcr/3cwxHTVEHfbuPUWaKqWQcCAvCSbwG0cy3mBIGQwWzjjJ6v2ej/YPQJRzMhRKhgW2WabAi
 2kQIEX219dL1+GyEqc620r/j6rnYangTWm+4qggx21x4syRC0ZzMKoSeWGZOEfWGo4fSHskcL
 2ETqS07mnp2HTK1Tt/KFjIIn9zn8SYkUx/S3gp4yAQsTy3nJfEB4a5JaDMXK9uYTQaDxVuPMU
 T1WO2euV6L9Fyz138N5ZxuZ3XMeAFF71h7s05Yi3cLnR3GukWStzlnpU8LEFL4uREju1llpOI
 pZyV1f40xKfO3J1JtMiiBouaTu4BTN6KMg/ZtjzEaSkVa9+fQHWPyuFuNSGLtD0zzHg1+fD/O
 XGweL7k7NUBjBKXEK42mK3fqTuWrAQsCFeTa7mNATSpPmBK481LpLB8w8kiz/tIfoCCKko87y
 Y4ptOGD/MZqX4rGvcS6oQJHys+VibanopxW1JwRtg+KY3/klLorpbFZxmL3fYqoN8cvsHOwZc
 xfZeCNpG+vj78Fg2K4gzBb6d1bl77xWOw8WeJjwv22W7tQ8Mh4cYh97+pot5xT2Jq/K+UqdRW
 oPrj6tx8sKj7VwvD3Om54jZBlTZ6DqsVCSoGzp5V3kI8/m+tBW/RhJPD9S+/z47yIlEhoggRZ
 kKx8sWZmzeotlP4JHB5rph8cL1uJl/wLnyZFNYw6vchMDK/ZXJOwUBwNhRnoK3BxnhdV6wJmY
 JDhOKYkU4jK8laWEvFTns8eRkP8=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/9 17:05, Christoph Hellwig wrote:
> The btrfs_bio_ctrl machinery is overkill for writing extent_buffers
> as we always operate on PAGE SIZE chunks (or one smaller one for the
> subpage case) that are contigous and are guaranteed to fit into a
> single bio.  Replace it with open coded btrfs_bio_alloc, __bio_add_page
> and btrfs_submit_bio calls.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Does this also mean, the only benefit of manually merging continuous 
pages into a larger bio, compared to multiple smaller adjacent bios, is 
just memory saving?

Thanks,
Qu
> ---
>   fs/btrfs/extent_io.c | 40 ++++++++++++++++++++--------------------
>   1 file changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 1fc50d1402cef8..1d7f48190ee9b9 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -121,9 +121,6 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
>   	/* Caller should ensure the bio has at least some range added */
>   	ASSERT(bbio->bio.bi_iter.bi_size);
>   
> -	if (!is_data_inode(&bbio->inode->vfs_inode))
> -		bbio->bio.bi_opf |= REQ_META;
> -
>   	if (btrfs_op(&bbio->bio) == BTRFS_MAP_READ &&
>   	    bio_ctrl->compress_type != BTRFS_COMPRESS_NONE)
>   		btrfs_submit_compressed_read(bbio);
> @@ -1897,11 +1894,7 @@ static void write_one_subpage_eb(struct extent_buffer *eb,
>   	struct btrfs_fs_info *fs_info = eb->fs_info;
>   	struct page *page = eb->pages[0];
>   	bool no_dirty_ebs = false;
> -	struct btrfs_bio_ctrl bio_ctrl = {
> -		.wbc = wbc,
> -		.opf = REQ_OP_WRITE | wbc_to_write_flags(wbc),
> -		.end_io_func = end_bio_subpage_eb_writepage,
> -	};
> +	struct btrfs_bio *bbio;
>   
>   	prepare_eb_write(eb);
>   
> @@ -1915,10 +1908,16 @@ static void write_one_subpage_eb(struct extent_buffer *eb,
>   	if (no_dirty_ebs)
>   		clear_page_dirty_for_io(page);
>   
> -	submit_extent_page(&bio_ctrl, eb->start, page, eb->len,
> -			   eb->start - page_offset(page));
> +	bbio = btrfs_bio_alloc(INLINE_EXTENT_BUFFER_PAGES,
> +			       REQ_OP_WRITE | REQ_META | wbc_to_write_flags(wbc),
> +			       BTRFS_I(eb->fs_info->btree_inode),
> +			       end_bio_subpage_eb_writepage, NULL);
> +	bbio->bio.bi_iter.bi_sector = eb->start >> SECTOR_SHIFT;
> +	bbio->file_offset = eb->start;
> +	__bio_add_page(&bbio->bio, page, eb->len, eb->start - page_offset(page));
>   	unlock_page(page);
> -	submit_one_bio(&bio_ctrl);
> +	btrfs_submit_bio(bbio, 0);
> +
>   	/*
>   	 * Submission finished without problem, if no range of the page is
>   	 * dirty anymore, we have submitted a page.  Update nr_written in wbc.
> @@ -1930,16 +1929,18 @@ static void write_one_subpage_eb(struct extent_buffer *eb,
>   static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
>   					    struct writeback_control *wbc)
>   {
> -	u64 disk_bytenr = eb->start;
> +	struct btrfs_bio *bbio;
>   	int i, num_pages;
> -	struct btrfs_bio_ctrl bio_ctrl = {
> -		.wbc = wbc,
> -		.opf = REQ_OP_WRITE | wbc_to_write_flags(wbc),
> -		.end_io_func = end_bio_extent_buffer_writepage,
> -	};
>   
>   	prepare_eb_write(eb);
>   
> +	bbio = btrfs_bio_alloc(INLINE_EXTENT_BUFFER_PAGES,
> +			       REQ_OP_WRITE | REQ_META | wbc_to_write_flags(wbc),
> +			       BTRFS_I(eb->fs_info->btree_inode),
> +			       end_bio_extent_buffer_writepage, NULL);
> +	bbio->bio.bi_iter.bi_sector = eb->start >> SECTOR_SHIFT;
> +	bbio->file_offset = eb->start;
> +
>   	num_pages = num_extent_pages(eb);
>   	for (i = 0; i < num_pages; i++) {
>   		struct page *p = eb->pages[i];
> @@ -1947,12 +1948,11 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
>   		lock_page(p);
>   		clear_page_dirty_for_io(p);
>   		set_page_writeback(p);
> -		submit_extent_page(&bio_ctrl, disk_bytenr, p, PAGE_SIZE, 0);
> -		disk_bytenr += PAGE_SIZE;
> +		__bio_add_page(&bbio->bio, p, PAGE_SIZE, 0);
>   		wbc->nr_to_write--;
>   		unlock_page(p);
>   	}
> -	submit_one_bio(&bio_ctrl);
> +	btrfs_submit_bio(bbio, 0);
>   }
>   
>   /*
