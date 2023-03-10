Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B7A6B37B7
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Mar 2023 08:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCJHsX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Mar 2023 02:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjCJHsP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Mar 2023 02:48:15 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3145A93E
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 23:47:34 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N7R1J-1qdVQ22sPd-017mG3; Fri, 10
 Mar 2023 08:42:08 +0100
Message-ID: <52d760f4-dec8-7162-40b7-4f0be14848b8@gmx.com>
Date:   Fri, 10 Mar 2023 15:42:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230309090526.332550-1-hch@lst.de>
 <20230309090526.332550-6-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 05/20] btrfs: simplify extent buffer reading
In-Reply-To: <20230309090526.332550-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:G8n+dVTD7vTHwJ3IzI5PfKRCxhxKYZNF4B28kd8DZivYSeLDdA8
 yjLn9dOABjUqyZ3B/4u7j0nVSCBFFOWtWNuUYE4mTPx0j9r4AV6sJK9Odj8Sobf8U24zu/R
 LK+euDlJms1LmJsVK0Y7sO7ljQAxp+Ayi6b2Kuw21iunoOmJ9pBeubHGrnseegcm+kjStDD
 GMJpKQcM/yr/UrJ2qpMVQ==
UI-OutboundReport: notjunk:1;M01:P0:IWzifDwf56s=;yD5jyJsdZX8BPfWQ4yVmKpre8Fe
 iEasbAHhVtyuMf0+VDQCDWiY8Jmecs7cyNANlpns19eLNSUgQMm/WkmqGXbEE8nmmpl5gPZHX
 6xZ4DlKhNeMbuE3Vuc//gLPHIbb4unf7H0eSBmZDRxW6hGyKMvZ2f/LtaaDx9Cixo8dgyucCQ
 G16H9Q8AgoVwtN22edaO0KG80SLV7JbJwFzSpHqg59z3bqDLbtI3vlYHIHTp5wKcdN1FwKtHY
 faHcJVkl7UuijLrgtk//3DvLYl4V7DvROygH9NGKYObynvNG2HK8GMAbMZ+vRUAbzvpL0O56K
 HXYwm4/BFUuD6pwCELJwD3zLGquDj1G6Xg8/h5I1qKmy/qmqPxnEkEbCa/J/Ha05/4KApQqHU
 gXX9TWIL9EwzMEUeIdKkXWdMsOMiAQww5SG1yak6KT9sw+ENonFee8Pu+7/sLa6SEHTKiPLWl
 LvUK8A8MCoDedkcNYCS2YtabkNbPMelNyQQ3xJ0IJhmEkioLgNq2ddU/nTiKAoUdsTNGwYssO
 woqkUUODouSn6lv2E/i/ytcdCCldkfopNDjMeClFm1qNRpgjKkKbFIUJ4OFZrta3YxQIor0Ck
 y3WnjK05Kmfn3+Pe4J7L+SQ+jHhQoXfGyGWxEyWolPbhCHHsOUaiJaJgo2oreXonnohqBeG0y
 sSraZYDnQcZLQ1vvDsPDwDcTKfPrFexxyO1uqVdU9kYVEB59SlCBl0bv2vIhIXsZGO8zQC/jR
 9mbFnfciNf+lr9VRS3jEeT9P/QwRhjdnTqkCJ0vptp0Sqr+VZcTqUMvLqrZHSbRHvJf6CCgPA
 xDadKo4K2aZYlohOZYqUO8ZmEI17wiG4eXtS8wW+rmR3WbwTYpOzM/z8uYDDQdXsIH6R60/Pi
 H38ZJjF0ACMrrPsnYSIuI4VMguLiaViS71OqgozId8zwjnYfAl63/mmG1TFSeTcFwmHAWEeFt
 2i8zYYAHnhT8fVA2dK05a0aBaW0=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/9 17:05, Christoph Hellwig wrote:
> The btrfs_bio_ctrl machinery is overkill for reading extent_buffers
> as we always operate on PAGE SIZE chunks (or one smaller one for the
> subpage case) that are contigous and are guaranteed to fit into a
> single bio.

This is the legacy left by older stripe boundary based bio split code.
(Please note that, metadata crossing stripe boundaries is not ideal and 
is very rare nowadays, but we should still support it).

But now we have btrfs_submit_bio() handling such cases, thus it should 
be fine.

>  Replace it with open coded btrfs_bio_alloc, __bio_add_page
> and btrfs_submit_bio calls in a helper function shared between
> the subpage and node size >= PAGE_SIZE cases.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/extent_io.c | 99 ++++++++++++++++----------------------------
>   1 file changed, 36 insertions(+), 63 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 26d8162bee000d..5169e73ffea647 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -98,22 +98,12 @@ void btrfs_extent_buffer_leak_debug_check(struct btrfs_fs_info *fs_info)
>    */
>   struct btrfs_bio_ctrl {
>   	struct btrfs_bio *bbio;
> -	int mirror_num;
>   	enum btrfs_compression_type compress_type;
>   	u32 len_to_oe_boundary;
>   	blk_opf_t opf;
>   	btrfs_bio_end_io_t end_io_func;
>   	struct writeback_control *wbc;
>   
> -	/*
> -	 * This is for metadata read, to provide the extra needed verification
> -	 * info.  This has to be provided for submit_one_bio(), as
> -	 * submit_one_bio() can submit a bio if it ends at stripe boundary.  If
> -	 * no such parent_check is provided, the metadata can hit false alert at
> -	 * endio time.
> -	 */
> -	struct btrfs_tree_parent_check *parent_check;
> -
>   	/*
>   	 * Tell writepage not to lock the state bits for this range, it still
>   	 * does the unlocking.
> @@ -124,7 +114,6 @@ struct btrfs_bio_ctrl {
>   static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
>   {
>   	struct btrfs_bio *bbio = bio_ctrl->bbio;
> -	int mirror_num = bio_ctrl->mirror_num;
>   
>   	if (!bbio)
>   		return;
> @@ -132,25 +121,14 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
>   	/* Caller should ensure the bio has at least some range added */
>   	ASSERT(bbio->bio.bi_iter.bi_size);
>   
> -	if (!is_data_inode(&bbio->inode->vfs_inode)) {
> -		if (btrfs_op(&bbio->bio) != BTRFS_MAP_WRITE) {
> -			/*
> -			 * For metadata read, we should have the parent_check,
> -			 * and copy it to bbio for metadata verification.
> -			 */
> -			ASSERT(bio_ctrl->parent_check);
> -			memcpy(&bbio->parent_check,
> -			       bio_ctrl->parent_check,
> -			       sizeof(struct btrfs_tree_parent_check));
> -		}
> +	if (!is_data_inode(&bbio->inode->vfs_inode))
>   		bbio->bio.bi_opf |= REQ_META;
> -	}
>   
>   	if (btrfs_op(&bbio->bio) == BTRFS_MAP_READ &&
>   	    bio_ctrl->compress_type != BTRFS_COMPRESS_NONE)
> -		btrfs_submit_compressed_read(bbio, mirror_num);
> +		btrfs_submit_compressed_read(bbio, 0);
>   	else
> -		btrfs_submit_bio(bbio, mirror_num);
> +		btrfs_submit_bio(bbio, 0);
>   
>   	/* The bbio is owned by the end_io handler now */
>   	bio_ctrl->bbio = NULL;
> @@ -4241,6 +4219,36 @@ void set_extent_buffer_uptodate(struct extent_buffer *eb)
>   	}
>   }
>   
> +static void __read_extent_buffer_pages(struct extent_buffer *eb, int mirror_num,
> +				       struct btrfs_tree_parent_check *check)
> +{
> +	int num_pages = num_extent_pages(eb), i;
> +	struct btrfs_bio *bbio;
> +
> +	clear_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags);
> +	eb->read_mirror = 0;
> +	atomic_set(&eb->io_pages, num_pages);
> +	check_buffer_tree_ref(eb);
> +
> +	bbio = btrfs_bio_alloc(INLINE_EXTENT_BUFFER_PAGES,
> +			       REQ_OP_READ | REQ_META,
> +			       BTRFS_I(eb->fs_info->btree_inode),
> +			       end_bio_extent_readpage, NULL);
> +	bbio->bio.bi_iter.bi_sector = eb->start >> SECTOR_SHIFT;
> +	bbio->file_offset = eb->start;
> +	memcpy(&bbio->parent_check, check, sizeof(*check));
> +	if (eb->fs_info->nodesize < PAGE_SIZE) {
> +		__bio_add_page(&bbio->bio, eb->pages[0], eb->len,
> +			       eb->start - page_offset(eb->pages[0]));
> +	} else {
> +		for (i = 0; i < num_pages; i++) {
> +			ClearPageError(eb->pages[i]);
> +			__bio_add_page(&bbio->bio, eb->pages[i], PAGE_SIZE, 0);
> +		}
> +	}
> +	btrfs_submit_bio(bbio, mirror_num);
> +}
> +
>   static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
>   				      int mirror_num,
>   				      struct btrfs_tree_parent_check *check)
> @@ -4249,11 +4257,6 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
>   	struct extent_io_tree *io_tree;
>   	struct page *page = eb->pages[0];
>   	struct extent_state *cached_state = NULL;
> -	struct btrfs_bio_ctrl bio_ctrl = {
> -		.opf = REQ_OP_READ,
> -		.mirror_num = mirror_num,
> -		.parent_check = check,
> -	};
>   	int ret;
>   
>   	ASSERT(!test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags));
> @@ -4281,18 +4284,10 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
>   		return 0;
>   	}
>   
> -	clear_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags);
> -	eb->read_mirror = 0;
> -	atomic_set(&eb->io_pages, 1);
> -	check_buffer_tree_ref(eb);
> -	bio_ctrl.end_io_func = end_bio_extent_readpage;
> -
>   	btrfs_subpage_clear_error(fs_info, page, eb->start, eb->len);
> -
>   	btrfs_subpage_start_reader(fs_info, page, eb->start, eb->len);
> -	submit_extent_page(&bio_ctrl, eb->start, page, eb->len,
> -			   eb->start - page_offset(page));
> -	submit_one_bio(&bio_ctrl);
> +
> +	__read_extent_buffer_pages(eb, mirror_num, check);
>   	if (wait != WAIT_COMPLETE) {
>   		free_extent_state(cached_state);
>   		return 0;
> @@ -4313,11 +4308,6 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
>   	int locked_pages = 0;
>   	int all_uptodate = 1;
>   	int num_pages;
> -	struct btrfs_bio_ctrl bio_ctrl = {
> -		.opf = REQ_OP_READ,
> -		.mirror_num = mirror_num,
> -		.parent_check = check,
> -	};
>   
>   	if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
>   		return 0;
> @@ -4367,24 +4357,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
>   		goto unlock_exit;
>   	}
>   
> -	clear_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags);
> -	eb->read_mirror = 0;
> -	atomic_set(&eb->io_pages, num_pages);
> -	/*
> -	 * It is possible for release_folio to clear the TREE_REF bit before we
> -	 * set io_pages. See check_buffer_tree_ref for a more detailed comment.
> -	 */
> -	check_buffer_tree_ref(eb);
> -	bio_ctrl.end_io_func = end_bio_extent_readpage;
> -	for (i = 0; i < num_pages; i++) {
> -		page = eb->pages[i];
> -
> -		ClearPageError(page);
> -		submit_extent_page(&bio_ctrl, page_offset(page), page,
> -				   PAGE_SIZE, 0);
> -	}
> -
> -	submit_one_bio(&bio_ctrl);
> +	__read_extent_buffer_pages(eb, mirror_num, check);
>   
>   	if (wait != WAIT_COMPLETE)
>   		return 0;
