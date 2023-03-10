Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F466B3773
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Mar 2023 08:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjCJHfx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Mar 2023 02:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjCJHfi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Mar 2023 02:35:38 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E54E63C6
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 23:35:36 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mlf0U-1qHsjD2wz4-00ii2v; Fri, 10
 Mar 2023 08:35:30 +0100
Message-ID: <659eecea-d5fd-a966-d073-9dd85e34db60@gmx.com>
Date:   Fri, 10 Mar 2023 15:35:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230309090526.332550-1-hch@lst.de>
 <20230309090526.332550-5-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 04/20] btrfs: always read the entire extent_buffer
In-Reply-To: <20230309090526.332550-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:YBCJqtyCgu+6o74nCFXHJc9NuktVGGsgHkKF3IMMLoojQHk3OKz
 uIIJIFXwP5MO3OsumxvLX1Ox56lbUzps0enjxCm6HYFaC/r8jX3JRikm3URueNtd8otyN1v
 rii/26Z8Of4Y8IA8X5qHn3ZmqiQyPAMVW5ry3HYyZHzDvRZeqPNeCaO4jDOtk/WVy72gJ1W
 Y3kwXc5fbIOAQl2EDhjSA==
UI-OutboundReport: notjunk:1;M01:P0:KoEPpKFZf+Q=;FDkf075YLhR7L77EDGPppXi5vDn
 GBEQ3/rW5L1svyviFQmZoVyowW+x9cpYqlz9bALzv6IOH2CkpZD9r1e2ZHg9AHtKa7sBOO7BF
 p2hfUzd9igTFXBZ5u8/88M8/75L71nmtRNMzQYjPrrD7Br/YuS3spQ/dz1QpewztK1hn8TO/7
 83gSZiCLKzlDvmea8uVPS1QBvHckX/rhlC3vahbxDtPvs4QyeuV3NVNLcOVHOytt3HYto1uxj
 cQ8m7U2h3S7NmknJYrQdUizjKESSdP7YXrUBDdPu0UFSCQvnb2JIaf65rRsr6oPw5zEL0MauC
 7hoq3Bfak6zas743uXhhjmhT8JH2P4x9JkFYHJPGIIc8tsNuPcdX1ogzDUOu6EbxLA9AetDR9
 yEHgE5RvWWjSrs38+7LuQDHFWVXgcZylIbzkfbv/lR5pr5Mw0GGBfRF09j477jSzyd8ZV0Su3
 cJhDjeRsraXBODCD+qsLUv/prQ5WKXoxk5schetMMmpgsrtoeJl3BNwwek5AF4f//jLIdr7p0
 o9pTqSwnI8iJb+ynl5vNXSiSv5Dcdw6Feeh5gYtariGhRmC+d+jzsIgVzPVVkT2TE54sQIlUH
 XJSdgeTQrmyMwb3kmzT5TfPEnwL+nSdMVT3eMqK8/RMOdRyBnF1tQnlxvKf4hVxZjus5VkjJp
 jFKLw+Of+lD7yJImhT8EW+oI/Bu/WHclMAuBab6idNcgs5nVwU/E0VrzF8u2FIqOdNRc3aIOv
 JYFJIQUxFMdcCm/blLc/gjDRJDkeIuNfg6l9J9Tg5qr8QF0S5dDhNNe9YJrIAYnwWNiWSTqWz
 Bbr5fNbrYJm/QOw4oDvX0zJ5RZiI9v++F8zztqKdRvjeYTJkkSQNpqV4OpPyKur0QP/pcx23/
 9/J/pjysFxDaE11xpQtceWvwvaDDHn34RmyZYP/OlXAmSGKJohGbR1ZOkYN6Wuu8zp+aM/yq3
 rixigEQTx0I4EzxgrckOQygWdn8=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/9 17:05, Christoph Hellwig wrote:
> Currently read_extent_buffer_pages skips pages that are already uptodate
> when reading in an extent_buffer.  While this reduces the amount of data
> read, it increases the number of I/O operations as we now need to do
> multiple I/Os when reading an extent buffer with one or more uptodate
> pages in the middle of it.  On any modern storage device, be that hard
> drives or SSDs this actually decreases I/O performance.  Fortunately
> this case is pretty rare as the pages are always initially read together
> and then aged the same way.
>  Besides simplifying the code a bit as-is
> this will allow for major simplifications to the I/O completion handler
> later on.
> 
> Note that the case where all pages are uptodate is still handled by an
> optimized fast path that does not read any data from disk.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/extent_io.c | 17 +++++------------
>   1 file changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 302af9b01bda2a..26d8162bee000d 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -4313,7 +4313,6 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
>   	int locked_pages = 0;
>   	int all_uptodate = 1;
>   	int num_pages;
> -	unsigned long num_reads = 0;
>   	struct btrfs_bio_ctrl bio_ctrl = {
>   		.opf = REQ_OP_READ,
>   		.mirror_num = mirror_num,
> @@ -4359,10 +4358,8 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
>   	 */
>   	for (i = 0; i < num_pages; i++) {
>   		page = eb->pages[i];
> -		if (!PageUptodate(page)) {
> -			num_reads++;
> +		if (!PageUptodate(page))
>   			all_uptodate = 0;
> -		}
>   	}
>   
>   	if (all_uptodate) {
> @@ -4372,7 +4369,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
>   
>   	clear_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags);
>   	eb->read_mirror = 0;
> -	atomic_set(&eb->io_pages, num_reads);
> +	atomic_set(&eb->io_pages, num_pages);
>   	/*
>   	 * It is possible for release_folio to clear the TREE_REF bit before we
>   	 * set io_pages. See check_buffer_tree_ref for a more detailed comment.
> @@ -4382,13 +4379,9 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
>   	for (i = 0; i < num_pages; i++) {
>   		page = eb->pages[i];
>   
> -		if (!PageUptodate(page)) {
> -			ClearPageError(page);
> -			submit_extent_page(&bio_ctrl, page_offset(page), page,
> -					   PAGE_SIZE, 0);
> -		} else {
> -			unlock_page(page);
> -		}
> +		ClearPageError(page);
> +		submit_extent_page(&bio_ctrl, page_offset(page), page,
> +				   PAGE_SIZE, 0);
>   	}
>   
>   	submit_one_bio(&bio_ctrl);
