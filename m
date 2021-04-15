Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9D736127E
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Apr 2021 20:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbhDOSuv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Apr 2021 14:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbhDOSuu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Apr 2021 14:50:50 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F35C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Apr 2021 11:50:23 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id dp18so7589829qvb.5
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Apr 2021 11:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=+vru5Z9XQq0ENbsuJrPvWEpYPOiq+p+L0itm826R8Vo=;
        b=uzn+Ztib4F+aAmXBSUMCc2yi9aD/80UoRY6yseRSSh7Z6ngZ/JG+Sqxo30LGYIie0Z
         xdtLK0ew0h4tqXKPMHT3x+FrJ6tRYlr/CP6JY4er9L2N8/8XYRBNKHds93yJ7uoAgRMP
         TgoZYjwdNy5JZPIjHygwe7uo9/GLvABzbp7shGarPPfxrPJMqVjBLdJ5DJ/X+H000QZk
         h9PAEz0tPtrDN1fdIJciMcViF7dug7GCKQwUdO6Lax+Cp4pQ90F/YEBSlEZ1eErlWx2R
         HiPD9cSHhABnEzoZZqJTan629G8tzYfOkVHEy99gt/QbCWS6T31YioSomhkJRtyIjlyh
         nvbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+vru5Z9XQq0ENbsuJrPvWEpYPOiq+p+L0itm826R8Vo=;
        b=cd/IYdRF9L42ZZTEeT7j7sR23mt6l5mCENFOYVlFQrXVyLH7LcO/LxILwmwQMfW/tG
         6pGL1it99N2ZhAz0ACgLWOfHwzdkFucF2TsbVuw2SMTycHlrz2TEDrEV/xhDmxYH0jKM
         calSHyPI5ZZ99S1SukjHlSsaLkwCpZDTdIAAr8UnbudPcH4fxKs8vdlEm3I7S/QAFkoP
         JhR15nsJkhHEB8q2F3pwGpOajqXi8qU6lOwmJhZyWvA2lpOuy8lzRNXAfb9TSus3jZaG
         xpwz5UW3ExB1Zj/l+qzyh9Wdy4AFfxrrBZAUwLhZj+VePWl9bS8jenVVE8ZAfhwWqk1R
         ZN9A==
X-Gm-Message-State: AOAM533eX43vBFuNHKihnKUL8DbRcat4W01l//lzOUg72oy7cNZLHyTi
        tHo9NJ4wSzeg5vIT+xsTniaFSAESxcuF3g==
X-Google-Smtp-Source: ABdhPJxgXD13ZgI9yQM9PcQBOzSI6g2F1DlQHEWLMQ7eTC71Xd96yK1WhQmvEXOFRNqqIwPUvzKbhQ==
X-Received: by 2002:a0c:f247:: with SMTP id z7mr4892287qvl.24.1618512622764;
        Thu, 15 Apr 2021 11:50:22 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11c9::1288? ([2620:10d:c091:480::1:2677])
        by smtp.gmail.com with ESMTPSA id c145sm2603467qkg.48.2021.04.15.11.50.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 11:50:22 -0700 (PDT)
Subject: Re: [PATCH 01/42] btrfs: introduce end_bio_subpage_eb_writepage()
 function
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210415050448.267306-1-wqu@suse.com>
 <20210415050448.267306-2-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <5af1169e-1558-c1f5-14a5-08bde9c5cf15@toxicpanda.com>
Date:   Thu, 15 Apr 2021 14:50:21 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210415050448.267306-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/15/21 1:04 AM, Qu Wenruo wrote:
> The new function, end_bio_subpage_eb_writepage(), will handle the
> metadata writeback endio.
> 
> The major differences involved are:
> - How to grab extent buffer
>    Now page::private is a pointer to btrfs_subpage, we can no longer grab
>    extent buffer directly.
>    Thus we need to use the bv_offset to locate the extent buffer manually
>    and iterate through the whole range.
> 
> - Use btrfs_subpage_end_writeback() caller
>    This helper will handle the subpage writeback for us.
> 
> Since this function is executed under endio context, when grabbing
> extent buffers it can't grab eb->refs_lock as that lock is not designed
> to be grabbed under hardirq context.
> 
> So here introduce a helper, find_extent_buffer_nospinlock(), for such
> situation, and convert find_extent_buffer() to use that helper.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/extent_io.c | 135 +++++++++++++++++++++++++++++++++----------
>   1 file changed, 106 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index a50adbd8808d..21a14b1cb065 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -4080,13 +4080,97 @@ static void set_btree_ioerr(struct page *page, struct extent_buffer *eb)
>   	}
>   }
>   
> +/*
> + * This is the endio specific version which won't touch any unsafe spinlock
> + * in endio context.
> + */
> +static struct extent_buffer *find_extent_buffer_nospinlock(
> +		struct btrfs_fs_info *fs_info, u64 start)
> +{
> +	struct extent_buffer *eb;
> +
> +	rcu_read_lock();
> +	eb = radix_tree_lookup(&fs_info->buffer_radix,
> +			       start >> fs_info->sectorsize_bits);
> +	if (eb && atomic_inc_not_zero(&eb->refs)) {
> +		rcu_read_unlock();
> +		return eb;
> +	}
> +	rcu_read_unlock();
> +	return NULL;
> +}
> +/*
> + * The endio function for subpage extent buffer write.
> + *
> + * Unlike end_bio_extent_buffer_writepage(), we only call end_page_writeback()
> + * after all extent buffers in the page has finished their writeback.
> + */
> +static void end_bio_subpage_eb_writepage(struct btrfs_fs_info *fs_info,
> +					 struct bio *bio)
> +{
> +	struct bio_vec *bvec;
> +	struct bvec_iter_all iter_all;
> +
> +	ASSERT(!bio_flagged(bio, BIO_CLONED));
> +	bio_for_each_segment_all(bvec, bio, iter_all) {
> +		struct page *page = bvec->bv_page;
> +		u64 bvec_start = page_offset(page) + bvec->bv_offset;
> +		u64 bvec_end = bvec_start + bvec->bv_len - 1;
> +		u64 cur_bytenr = bvec_start;
> +
> +		ASSERT(IS_ALIGNED(bvec->bv_len, fs_info->nodesize));
> +
> +		/* Iterate through all extent buffers in the range */
> +		while (cur_bytenr <= bvec_end) {
> +			struct extent_buffer *eb;
> +			int done;
> +
> +			/*
> +			 * Here we can't use find_extent_buffer(), as it may
> +			 * try to lock eb->refs_lock, which is not safe in endio
> +			 * context.
> +			 */
> +			eb = find_extent_buffer_nospinlock(fs_info, cur_bytenr);
> +			ASSERT(eb);
> +
> +			cur_bytenr = eb->start + eb->len;
> +
> +			ASSERT(test_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags));
> +			done = atomic_dec_and_test(&eb->io_pages);
> +			ASSERT(done);
> +
> +			if (bio->bi_status ||
> +			    test_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags)) {
> +				ClearPageUptodate(page);
> +				set_btree_ioerr(page, eb);
> +			}
> +
> +			btrfs_subpage_clear_writeback(fs_info, page, eb->start,
> +						      eb->len);
> +			end_extent_buffer_writeback(eb);
> +			/*
> +			 * free_extent_buffer() will grab spinlock which is not
> +			 * safe in endio context. Thus here we manually dec
> +			 * the ref.
> +			 */
> +			atomic_dec(&eb->refs);
> +		}
> +	}
> +	bio_put(bio);
> +}
> +
>   static void end_bio_extent_buffer_writepage(struct bio *bio)
>   {
> +	struct btrfs_fs_info *fs_info;
>   	struct bio_vec *bvec;
>   	struct extent_buffer *eb;
>   	int done;
>   	struct bvec_iter_all iter_all;
>   
> +	fs_info = btrfs_sb(bio_first_page_all(bio)->mapping->host->i_sb);
> +	if (fs_info->sectorsize < PAGE_SIZE)
> +		return end_bio_subpage_eb_writepage(fs_info, bio);
> +

You replace the write_one_eb() call with one specifically for subpage, why not 
just use your special endio from there without polluting the normal writepage 
helper?  Thanks,

Josef
