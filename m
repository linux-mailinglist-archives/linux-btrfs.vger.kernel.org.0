Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577F26FF561
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 May 2023 17:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238429AbjEKPCe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 May 2023 11:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238299AbjEKPCa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 May 2023 11:02:30 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA6C1BC6
        for <linux-btrfs@vger.kernel.org>; Thu, 11 May 2023 08:02:26 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-24df6bbf765so7612758a91.0
        for <linux-btrfs@vger.kernel.org>; Thu, 11 May 2023 08:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1683817346; x=1686409346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AFev04fHtkPn60cPL7EJXz93DbIsIS7xjAYx8SSt8HI=;
        b=IiQZZ5DlpEE/3UgnUy3HkPm86ipfW1Rx2Q/Ko0r2pUSV8ALcURRprnAROn9WuevOBR
         BAXLSMkBldUuW9WDAxPbBkOgWXeD8rmKO8QNit+8s/oU3LT8FRSQ8FKcGPZlBIYBnwH/
         vqs6b6aIPr8kmShc21zZCKD6TMVxKy0t65igdK3yEALqeXQ0DJ8lyqUC/Ur2QMblXANl
         1Lztd0bb7LCg0ltuaQk4zKTrFkI6lDTraOmCyF0OEcFKQDf1GEJqE+giAlmxRjI935qI
         YtezHn6pq4swBIpTDikh6TRMQtGt3zDj2969e7dptmb1kVUKjNhtdEQ+6g5R19ZKtoTp
         tviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683817346; x=1686409346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFev04fHtkPn60cPL7EJXz93DbIsIS7xjAYx8SSt8HI=;
        b=e9bm/fk76qOQSb3AAiUdF385YRbIQHtk3BfonzgFOo9N9jBlls14osqVJyPE3+cN4d
         JS0OYoavzX6AGDxt964J0m6pfQ3hBqz2v0r3p6gTKRGgLPmlxLTQYGjdUZnAn9YpJpRN
         gmMMnO6tI3gPtAP2KbAKSK76/A6dsdyZCL1eSu2a1G9GuRL2BtiaU3uz/NdLfu9rpOdx
         OaOdIu0VO2OMyAzRDt1Ysx9uHiv+IONtprXTqzO6Bg57/o52p3gv0q26Yx8OGssrIVMp
         szjuTuZeFTwuQrZy/xfSv6dWV4/ORGMvbgM/7zaHeHLOSWUN/kdfE4l0zxH3uCdJu4lZ
         lqqQ==
X-Gm-Message-State: AC+VfDz+qVGcZy4KcnZBl/kWSTl4MDel+BL1dLPiSysg1u9I6671gZ+N
        hX7b9YujRgnZbwJwDbkHyf5mRg==
X-Google-Smtp-Source: ACHHUZ7VM+Qb+0/Fb2zK2SirEzNQURf/2+SKvAGinpOnQQTUDv1KUP7ib4M2igU0Roe9OUpvlL+xYQ==
X-Received: by 2002:a17:90a:ca96:b0:23b:38b2:f0bd with SMTP id y22-20020a17090aca9600b0023b38b2f0bdmr21430842pjt.15.1683817345652;
        Thu, 11 May 2023 08:02:25 -0700 (PDT)
Received: from localhost ([64.141.80.140])
        by smtp.gmail.com with ESMTPSA id d6-20020a17090ad3c600b002501908faffsm12458451pjw.36.2023.05.11.08.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 08:02:24 -0700 (PDT)
Date:   Thu, 11 May 2023 11:02:24 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 14/21] btrfs: use a separate end_io handler for
 extent_buffer writing
Message-ID: <20230511150224.GA75508@localhost.localdomain>
References: <20230503152441.1141019-1-hch@lst.de>
 <20230503152441.1141019-15-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503152441.1141019-15-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 03, 2023 at 05:24:34PM +0200, Christoph Hellwig wrote:
> Now that we always use a single bio to write an extent_buffer, the buffer
> can be passed to the end_io handler as private data.  This allows
> to simplify the metadata write end I/O handler, and merge the subpage
> end_io handler into the main one.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/extent_io.c | 128 +++++++++----------------------------------
>  1 file changed, 27 insertions(+), 101 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 68cdc6bed60c19..28088b751f8021 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1614,13 +1614,6 @@ void wait_on_extent_buffer_writeback(struct extent_buffer *eb)
>  		       TASK_UNINTERRUPTIBLE);
>  }
>  
> -static void end_extent_buffer_writeback(struct extent_buffer *eb)
> -{
> -	clear_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags);
> -	smp_mb__after_atomic();
> -	wake_up_bit(&eb->bflags, EXTENT_BUFFER_WRITEBACK);
> -}
> -
>  /*
>   * Lock extent buffer status and pages for writeback.
>   *
> @@ -1664,13 +1657,11 @@ static bool lock_extent_buffer_for_io(struct extent_buffer *eb,
>  	return ret;
>  }
>  
> -static void set_btree_ioerr(struct page *page, struct extent_buffer *eb)
> +static void set_btree_ioerr(struct extent_buffer *eb)
>  {
>  	struct btrfs_fs_info *fs_info = eb->fs_info;
>  
> -	btrfs_page_set_error(fs_info, page, eb->start, eb->len);
> -	if (test_and_set_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags))
> -		return;
> +	set_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags);
>  
>  	/*
>  	 * A read may stumble upon this buffer later, make sure that it gets an
> @@ -1684,7 +1675,7 @@ static void set_btree_ioerr(struct page *page, struct extent_buffer *eb)
>  	 * return a 0 because we are readonly if we don't modify the err seq for
>  	 * the superblock.
>  	 */
> -	mapping_set_error(page->mapping, -EIO);
> +	mapping_set_error(eb->fs_info->btree_inode->i_mapping, -EIO);
>  
>  	/*
>  	 * If writeback for a btree extent that doesn't belong to a log tree
> @@ -1759,102 +1750,38 @@ static struct extent_buffer *find_extent_buffer_nolock(
>  	return NULL;
>  }
>  
> -/*
> - * The endio function for subpage extent buffer write.
> - *
> - * Unlike end_bio_extent_buffer_writepage(), we only call end_page_writeback()
> - * after all extent buffers in the page has finished their writeback.
> - */
> -static void end_bio_subpage_eb_writepage(struct btrfs_bio *bbio)
> +static void extent_buffer_write_end_io(struct btrfs_bio *bbio)
>  {
> -	struct bio *bio = &bbio->bio;
> -	struct btrfs_fs_info *fs_info;
> -	struct bio_vec *bvec;
> +	struct extent_buffer *eb = bbio->private;
> +	struct btrfs_fs_info *fs_info = eb->fs_info;
> +	bool uptodate = !bbio->bio.bi_status;
>  	struct bvec_iter_all iter_all;
> +	struct bio_vec *bvec;
> +	u32 bio_offset = 0;
>  
> -	fs_info = btrfs_sb(bio_first_page_all(bio)->mapping->host->i_sb);
> -	ASSERT(fs_info->nodesize < PAGE_SIZE);
> +	if (!uptodate)
> +		set_btree_ioerr(eb);
>  
> -	ASSERT(!bio_flagged(bio, BIO_CLONED));
> -	bio_for_each_segment_all(bvec, bio, iter_all) {
> +	bio_for_each_segment_all(bvec, &bbio->bio, iter_all) {
> +		u64 start = eb->start + bio_offset;
>  		struct page *page = bvec->bv_page;
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
> -				btrfs_page_clear_uptodate(fs_info, page,
> -							  eb->start, eb->len);
> -				set_btree_ioerr(page, eb);
> -			}
> +		u32 len = bvec->bv_len;
> +				                

Whitespace error here btw.  Thanks,

Josef
