Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085D26B395E
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Mar 2023 10:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjCJJAv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Mar 2023 04:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjCJJAE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Mar 2023 04:00:04 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF1FF4033
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Mar 2023 00:53:25 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MryXN-1qOANk38Vh-00nvB5; Fri, 10
 Mar 2023 09:53:18 +0100
Message-ID: <c14567d9-ff8a-620a-575a-1673a82c4b24@gmx.com>
Date:   Fri, 10 Mar 2023 16:53:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 15/20] btrfs: remove the io_pages field in struct
 extent_buffer
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230309090526.332550-1-hch@lst.de>
 <20230309090526.332550-16-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230309090526.332550-16-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:djw/b1ICXRyIcTBb5b/BtTDQZCqMEj6NS97gZpv/CH380Zpg9U2
 egTaRPkmqUyjfrdpoll4vF+HZCta9C08DSGq9EloX/PWPY/Of/nVIBKPHod3aqHrvsrTJEB
 h6lvq5s5fI+Jlk67HRtx7o8jY509zJ56ZyprdVyKwKLc5H+ckjB97Y5w3Ggi/eV8vBwPA7l
 CC8jPIJJ5cLlp5dJ+L5og==
UI-OutboundReport: notjunk:1;M01:P0:+VfrTGovCc0=;6QePY8ENBBZdxjJTK1var70x66X
 26bGWsrmz4M2UDahzpEDlMQyLlJ4YR+fy+fYfxaeeLYj6bQ+dSeekOr9tWAfR4ATmJ0QGExJU
 PSgiWUAba6YWR8QmXh5qkSiGzUxZzzc/kMGzUxYL0CtXmJKAVmoMw8BfDDeDUif7KqpYWYHnP
 pYOe96wqCCN6fEDcABuYMxZH+8sG4Cy4MBn6gatSg1Apr6xRfANg1ma47v5/kNRKtRGaovD3h
 4rf9Zhakzm4b5sdBWwjBW+7lG34VyAZdbkncXEyELpf6xTWzDt0vvnLLBcaNVnBApWfgdG0Vj
 7MVmjtNvs1VBLY2WGO4zO+sh8WQ+cBRYP4ZDrV9DGEYV90g/aUHYGSWIoDqqoF36dPl7C/QSZ
 4GjnAXN1hP9XKx2tIqjs6d8IIPxxSo4iUyi0fYVpZxdTCY67w9z7ExfB7C9O4VbHdQdSIO7oc
 MaJWPY+GCIwloJQr2KL04Uz5w3mFhFsuUaMtFi4x9rITJJQnP2ZHs134e0EP1COLMk8jVwHco
 0iQBxcN87zSnaHoE93MIZPloPMpuf7pNSAMXPgFs6XPvHALxo0RsuOi0W408bWkmDbEedMxDv
 nq2S1S2CpW+iJWuSdlGc0HyqGNhVsYVF33a+ujhvZdAdPTZrC4XgBOyrAVAHFhy+ZP0atJtLV
 NM61mxq4I72dF2nvBdH/Ns364aTeaXLe2166Vq/+EpbMtUH14kmkSsMRiWC9dTcgwCrXrqVkS
 6D0TRSg4PqWEfql/Uc3qJ6fEiVBgt15ITrOI6izjRQwzqjApi2gDEGBmz1VBBA+mwzKxh2PC5
 Gh7VG6l56PtrCPbwO/NKQxgPtaZktxOSfq5EbC22AcxaPP+iUF0XkudaijW+QLbwJvmNrBDZb
 XVol1WXRXo6TVibLAj2OCrQCBliBYa+WcmFLv4urR2qhrZl6eiMhQFuPkS2jfHgEbr0Ue5OUF
 rgq8OrAuRsTRKHh+yBpqsmCNomM=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/9 17:05, Christoph Hellwig wrote:
> No need to track the number of pages under I/O now that each
> extent_buffer is read and written using a single bio.  For the
> read side we need to grab an extra reference for the duration of
> the I/O to prevent eviction, though.

But don't we already have an aomtic_inc_not_zero(&eb->refs) call in the 
old submit_eb_pages() function?

And I didn't find that function got modified in the series.

Thanks,
Qu

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/extent_io.c | 17 +++++------------
>   fs/btrfs/extent_io.h |  1 -
>   2 files changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 16522bcf5d4a10..24df1247d81d88 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1770,8 +1770,6 @@ static void extent_buffer_write_end_io(struct btrfs_bio *bbio)
>   	bio_for_each_segment_all(bvec, &bbio->bio, iter_all) {
>   		struct page *page = bvec->bv_page;
>   
> -		atomic_dec(&eb->io_pages);
> -
>   		if (!uptodate) {
>   			ClearPageUptodate(page);
>   			btrfs_page_set_error(fs_info, page, eb->start, eb->len);
> @@ -1796,7 +1794,6 @@ static void prepare_eb_write(struct extent_buffer *eb)
>   	unsigned long end;
>   
>   	clear_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags);
> -	atomic_set(&eb->io_pages, num_extent_pages(eb));
>   
>   	/* Set btree blocks beyond nritems with 0 to avoid stale content */
>   	nritems = btrfs_header_nritems(eb);
> @@ -3236,8 +3233,7 @@ static void __free_extent_buffer(struct extent_buffer *eb)
>   
>   static int extent_buffer_under_io(const struct extent_buffer *eb)
>   {
> -	return (atomic_read(&eb->io_pages) ||
> -		test_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags) ||
> +	return (test_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags) ||
>   		test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
>   }
>   
> @@ -3374,7 +3370,6 @@ __alloc_extent_buffer(struct btrfs_fs_info *fs_info, u64 start,
>   
>   	spin_lock_init(&eb->refs_lock);
>   	atomic_set(&eb->refs, 1);
> -	atomic_set(&eb->io_pages, 0);
>   
>   	ASSERT(len <= BTRFS_MAX_METADATA_BLOCKSIZE);
>   
> @@ -3491,9 +3486,9 @@ static void check_buffer_tree_ref(struct extent_buffer *eb)
>   	 * adequately protected by the refcount, but the TREE_REF bit and
>   	 * its corresponding reference are not. To protect against this
>   	 * class of races, we call check_buffer_tree_ref from the codepaths
> -	 * which trigger io after they set eb->io_pages. Note that once io is
> -	 * initiated, TREE_REF can no longer be cleared, so that is the
> -	 * moment at which any such race is best fixed.
> +	 * which trigger io. Note that once io is initiated, TREE_REF can no
> +	 * longer be cleared, so that is the moment at which any such race is
> +	 * best fixed.
>   	 */
>   	refs = atomic_read(&eb->refs);
>   	if (refs >= 2 && test_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags))
> @@ -4063,7 +4058,6 @@ static void extent_buffer_read_end_io(struct btrfs_bio *bbio)
>   	struct bio_vec *bvec;
>   	u32 bio_offset = 0;
>   
> -	atomic_inc(&eb->refs);
>   	eb->read_mirror = bbio->mirror_num;
>   
>   	if (uptodate &&
> @@ -4078,7 +4072,6 @@ static void extent_buffer_read_end_io(struct btrfs_bio *bbio)
>   	}
>   
>   	bio_for_each_segment_all(bvec, &bbio->bio, iter_all) {
> -		atomic_dec(&eb->io_pages);
>   		end_page_read(bvec->bv_page, uptodate, eb->start + bio_offset,
>   			      bvec->bv_len);
>   		bio_offset += bvec->bv_len;
> @@ -4101,8 +4094,8 @@ static void __read_extent_buffer_pages(struct extent_buffer *eb, int mirror_num,
>   
>   	clear_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags);
>   	eb->read_mirror = 0;
> -	atomic_set(&eb->io_pages, num_pages);
>   	check_buffer_tree_ref(eb);
> +	atomic_inc(&eb->refs);
>   
>   	bbio = btrfs_bio_alloc(INLINE_EXTENT_BUFFER_PAGES,
>   			       REQ_OP_READ | REQ_META,
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 342412d37a7b4b..12854a2b48f060 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -79,7 +79,6 @@ struct extent_buffer {
>   	struct btrfs_fs_info *fs_info;
>   	spinlock_t refs_lock;
>   	atomic_t refs;
> -	atomic_t io_pages;
>   	int read_mirror;
>   	struct rcu_head rcu_head;
>   	pid_t lock_owner;
