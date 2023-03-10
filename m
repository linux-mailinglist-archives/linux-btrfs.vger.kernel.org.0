Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB29B6B391A
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Mar 2023 09:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjCJIrl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Mar 2023 03:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjCJIrG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Mar 2023 03:47:06 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A291091F7
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Mar 2023 00:45:19 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M2O6e-1pYtPD1t0w-003sUs; Fri, 10
 Mar 2023 09:44:42 +0100
Message-ID: <b2f12bbc-e08a-ae91-f7b8-8cbdf9117eb8@gmx.com>
Date:   Fri, 10 Mar 2023 16:44:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230309090526.332550-1-hch@lst.de>
 <20230309090526.332550-14-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 13/20] btrfs: simplify the extent_buffer write end_io
 handler
In-Reply-To: <20230309090526.332550-14-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:/Qo9BSG7b5zNXua9dZ0CMdtP04taIXShoRM0VbzAcu6/LBhkhYt
 4sEeg2ilh5tn3FUM1LK+BSZz21JQe5oiWk+8oNgpfgUTQ++hpvNCVmXagmd8SZq/CRkO8VW
 NqrT+lzCOiyCNR3Vj5UQjtxu6wNLRnspXt2HbDY+CVgpQ7sQLiza/FoL7tASnJIMwDMxY2Q
 XEi9FV9R9YBs8Q0t5kyag==
UI-OutboundReport: notjunk:1;M01:P0:bTqX+uzcJIU=;0ZMntBIY9iIcTxumkFgPJEJbtIh
 nPMA8xfoib+F3JQgZF5IJRUaUWNh4lYW00RUr1Uvv1foocohy+rzF9GFvVsNcMsKQ2IhaDezz
 zzAtAFJw4+VquiJxdYK4ubTrNceuyM6NIPykfV4PyIM7QHiaNaoU1zHyU5J/Ea2vfNAnPQ6aH
 20A5JvXSjyl0qXIJ6/3VX572HwN6JZxF8pUHnE0nKe5a2iiN2kCwPaRs5SrMgzat3HKtOJu6B
 uFI2V3yh7rh8A0G745jTdHSby0RGacMAm+30yY+6iNXJSh2Mmk1yIXwR1xjramoJzy0w4x2Q6
 309MY+i+UcF5WaoBQH39ON5wSifjZhljnHf9gRATXJx5StakHAchKSI3EwvQmiD4xwBKv9oSR
 Qbt1pIdvhchv4APjZ3eXxwEVCTOUUnggQYLLEl34AhI7nLvMAqMS0RgCntRBpys7wo2SsMWkd
 f4SWWctZpt0h6h348eeZ7jMaVlcSoxXpPioDmXYhGQKK2id96pVqB+GyfSFyigD3P8xKCVxEr
 ZGDZeHVzP0+UwG2som5qIEq4HIHBfVnNe5YXAwwR7/UFHHZCupfN78tcz9m2KzKQf/ybS7Ud8
 PmKoCZqKxr3SQ8wD3cKkVILVVOYW2lk3ENpJQKfZE9PYctrV2i0ycs4n7L33zbdzf3cACM896
 k7qbjQDiibbhjuUeOswJohIZOyxldZOJWeLm3eiXAWc9KW1vq2+6wh7n3hWOSnRUTN2KcW34L
 bqFFXVp26VHU38DXl1fdBewKDVAEHQcvc/OMr2KZX/5j2of3133YG2hPQkdmLyGJy7XLoyTdi
 YV0D5/Z1KEx1/CP80wKQOPbGLlSq7VWNh+pslyw1ndBmzuYguExCVsk2ZgCzqU+uzoUkiBHvG
 orOD3oOuLpw+RSunwWOhV1s7v1ht60Ejvq5+QbTunnwmesV5bpZoNTkmMBpyU1i0awwpuyEqI
 Y55hHRriBt9p8rRwpdZ4gsuceyU=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/9 17:05, Christoph Hellwig wrote:
> Now that we always use a single bio to write an extent_buffer, the buffer
> can be passed to the end_io handler as private data.  This allows
> to simplify the metadata write end I/O handler, and merge the subpage
> version into the main one with just a single conditional.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/extent_io.c | 112 +++++++++----------------------------------
>   1 file changed, 23 insertions(+), 89 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 1d7f48190ee9b9..16522bcf5d4a10 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1663,13 +1663,11 @@ static bool lock_extent_buffer_for_io(struct extent_buffer *eb,
>   	return ret;
>   }
>   
> -static void set_btree_ioerr(struct page *page, struct extent_buffer *eb)
> +static void set_btree_ioerr(struct extent_buffer *eb)
>   {
>   	struct btrfs_fs_info *fs_info = eb->fs_info;
>   
> -	btrfs_page_set_error(fs_info, page, eb->start, eb->len);
> -	if (test_and_set_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags))
> -		return;
> +	set_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags);
>   
>   	/*
>   	 * A read may stumble upon this buffer later, make sure that it gets an
> @@ -1683,7 +1681,7 @@ static void set_btree_ioerr(struct page *page, struct extent_buffer *eb)
>   	 * return a 0 because we are readonly if we don't modify the err seq for
>   	 * the superblock.
>   	 */
> -	mapping_set_error(page->mapping, -EIO);
> +	mapping_set_error(eb->fs_info->btree_inode->i_mapping, -EIO);
>   
>   	/*
>   	 * If writeback for a btree extent that doesn't belong to a log tree
> @@ -1758,101 +1756,37 @@ static struct extent_buffer *find_extent_buffer_nolock(
>   	return NULL;
>   }
>   
> -/*
> - * The endio function for subpage extent buffer write.
> - *
> - * Unlike end_bio_extent_buffer_writepage(), we only call end_page_writeback()
> - * after all extent buffers in the page has finished their writeback.
> - */
> -static void end_bio_subpage_eb_writepage(struct btrfs_bio *bbio)
> +static void extent_buffer_write_end_io(struct btrfs_bio *bbio)
>   {
> -	struct bio *bio = &bbio->bio;
> -	struct btrfs_fs_info *fs_info;
> -	struct bio_vec *bvec;
> +	struct extent_buffer *eb = bbio->private;
> +	struct btrfs_fs_info *fs_info = eb->fs_info;
> +	bool uptodate = !bbio->bio.bi_status;
>   	struct bvec_iter_all iter_all;
> -
> -	fs_info = btrfs_sb(bio_first_page_all(bio)->mapping->host->i_sb);
> -	ASSERT(fs_info->nodesize < PAGE_SIZE);
> -
> -	ASSERT(!bio_flagged(bio, BIO_CLONED));
> -	bio_for_each_segment_all(bvec, bio, iter_all) {
> -		struct page *page = bvec->bv_page;
> -		u64 bvec_start = page_offset(page) + bvec->bv_offset;
> -		u64 bvec_end = bvec_start + bvec->bv_len - 1;
> -		u64 cur_bytenr = bvec_start;
> -
> -		ASSERT(IS_ALIGNED(bvec->bv_len, fs_info->nodesize));
> -
> -		/* Iterate through all extent buffers in the range */
> -		while (cur_bytenr <= bvec_end) {
> -			struct extent_buffer *eb;
> -			int done;
> -
> -			/*
> -			 * Here we can't use find_extent_buffer(), as it may
> -			 * try to lock eb->refs_lock, which is not safe in endio
> -			 * context.
> -			 */
> -			eb = find_extent_buffer_nolock(fs_info, cur_bytenr);
> -			ASSERT(eb);
> -
> -			cur_bytenr = eb->start + eb->len;
> -
> -			ASSERT(test_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags));
> -			done = atomic_dec_and_test(&eb->io_pages);
> -			ASSERT(done);
> -
> -			if (bio->bi_status ||
> -			    test_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags)) {
> -				ClearPageUptodate(page);
> -				set_btree_ioerr(page, eb);
> -			}
> -
> -			btrfs_subpage_clear_writeback(fs_info, page, eb->start,
> -						      eb->len);
> -			end_extent_buffer_writeback(eb);
> -			/*
> -			 * free_extent_buffer() will grab spinlock which is not
> -			 * safe in endio context. Thus here we manually dec
> -			 * the ref.
> -			 */
> -			atomic_dec(&eb->refs);
> -		}
> -	}
> -	bio_put(bio);
> -}
> -
> -static void end_bio_extent_buffer_writepage(struct btrfs_bio *bbio)
> -{
> -	struct bio *bio = &bbio->bio;
>   	struct bio_vec *bvec;
> -	struct extent_buffer *eb;
> -	int done;
> -	struct bvec_iter_all iter_all;
>   
> -	ASSERT(!bio_flagged(bio, BIO_CLONED));
> -	bio_for_each_segment_all(bvec, bio, iter_all) {
> +	if (!uptodate)
> +		set_btree_ioerr(eb);
> +
> +	bio_for_each_segment_all(bvec, &bbio->bio, iter_all) {
>   		struct page *page = bvec->bv_page;
>   
> -		eb = (struct extent_buffer *)page->private;
> -		BUG_ON(!eb);
> -		done = atomic_dec_and_test(&eb->io_pages);
> +		atomic_dec(&eb->io_pages);
>   
> -		if (bio->bi_status ||
> -		    test_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags)) {
> +		if (!uptodate) {
>   			ClearPageUptodate(page);

There seems to be an existing bug in the endio function for subpage.

We should call btrfs_page_clear_uptodate() helper.
Or we subpage uptodate bitmap and the page uptodate flag would get out 
of sync.

> -			set_btree_ioerr(page, eb);
> +			btrfs_page_set_error(fs_info, page, eb->start, eb->len); >   		}
>   
> -		end_page_writeback(page);
> -
> -		if (!done)
> -			continue;
> +		if (fs_info->nodesize < PAGE_SIZE)
> +			btrfs_subpage_clear_writeback(fs_info, page, eb->start,
> +						      eb->len);
> +		else
> +			end_page_writeback(page);


Here we can just call btrfs_clear_writeback(), which can handle both 
subpage and regular cases.

Thanks,
Qu

>   
> -		end_extent_buffer_writeback(eb);
>   	}
> +	end_extent_buffer_writeback(eb);
>   
> -	bio_put(bio);
> +	bio_put(&bbio->bio);
>   }
>   
>   static void prepare_eb_write(struct extent_buffer *eb)
> @@ -1911,7 +1845,7 @@ static void write_one_subpage_eb(struct extent_buffer *eb,
>   	bbio = btrfs_bio_alloc(INLINE_EXTENT_BUFFER_PAGES,
>   			       REQ_OP_WRITE | REQ_META | wbc_to_write_flags(wbc),
>   			       BTRFS_I(eb->fs_info->btree_inode),
> -			       end_bio_subpage_eb_writepage, NULL);
> +			       extent_buffer_write_end_io, eb);
>   	bbio->bio.bi_iter.bi_sector = eb->start >> SECTOR_SHIFT;
>   	bbio->file_offset = eb->start;
>   	__bio_add_page(&bbio->bio, page, eb->len, eb->start - page_offset(page));
> @@ -1937,7 +1871,7 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
>   	bbio = btrfs_bio_alloc(INLINE_EXTENT_BUFFER_PAGES,
>   			       REQ_OP_WRITE | REQ_META | wbc_to_write_flags(wbc),
>   			       BTRFS_I(eb->fs_info->btree_inode),
> -			       end_bio_extent_buffer_writepage, NULL);
> +			       extent_buffer_write_end_io, eb);
>   	bbio->bio.bi_iter.bi_sector = eb->start >> SECTOR_SHIFT;
>   	bbio->file_offset = eb->start;
>   
