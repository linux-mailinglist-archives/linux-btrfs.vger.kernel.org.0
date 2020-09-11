Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165F0265D15
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Sep 2020 11:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725777AbgIKJ4r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Sep 2020 05:56:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:43950 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbgIKJ4b (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Sep 2020 05:56:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AC8BCAB8B;
        Fri, 11 Sep 2020 09:56:45 +0000 (UTC)
Subject: Re: [PATCH 02/17] btrfs: calculate inline extent buffer page size
 based on page size
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200908075230.86856-1-wqu@suse.com>
 <20200908075230.86856-3-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9bc8bd10-dc66-3215-1ef2-b5df3cd00883@suse.com>
Date:   Fri, 11 Sep 2020 12:56:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908075230.86856-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 8.09.20 г. 10:52 ч., Qu Wenruo wrote:
> Btrfs only support 64K as max node size, thus for 4K page system, we
> would have at most 16 pages for one extent buffer.
> 
> But for 64K system, we only need and always need one page for extent
> buffer.

-EAMBIGIOUS. It should be "For a system using 64k pages we would really
have have just a single page"

> This stays true even for future subpage sized sector size support (as
> long as extent buffer doesn't cross 64K boundary).
> 
> So this patch will change how INLINE_EXTENT_BUFFER_PAGES is calculated.
> 
> Instead of using fixed 16 pages, use (64K / PAGE_SIZE) as the result.
> This should save some bytes for extent buffer structure for 64K
> systems.

I'd rephrase the whole changelog as something along the lines of :

"Currently btrfs hardcodes the number of inline pages it uses to 16
which in turn has an effect on MAX_INLINE_EXTENT_BUFFER_SIZE effectively
defining the upper limit of the size of extent buffer. For systems using
4k pages this works out fine but on 64k page systems this results in
unnecessary memory overhead. That's due to the fact
BTRFS_MAX_METADATA_BLOCKSIZE is defined as 64k so having
INLINE_EXTENT_BUFFER_PAGES set to 16 on a 64k system results in
extent_buffer::pages being unnecessarily large since an eb can be mapped
with just a single page but the pages array would be 16 entries large.

Fix this by changing the way we calculate the size of the pages array by
exploiting the fact an eb can't be larger than 64k so choosing enough
pages to fit it"


> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

This patch must be split into 2:
1. Changing the defines
2. Simplifying num_extent_pages

> ---
>  fs/btrfs/extent_io.h | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 00a88f2eb5ab..e16c5449ba48 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -86,8 +86,8 @@ struct extent_io_ops {
>  };
>  
>  
> -#define INLINE_EXTENT_BUFFER_PAGES 16
> -#define MAX_INLINE_EXTENT_BUFFER_SIZE (INLINE_EXTENT_BUFFER_PAGES * PAGE_SIZE)
> +#define MAX_INLINE_EXTENT_BUFFER_SIZE 	SZ_64K
> +#define INLINE_EXTENT_BUFFER_PAGES 	(MAX_INLINE_EXTENT_BUFFER_SIZE / PAGE_SIZE)

Actually having the defines like that it makes no sense to keep
MAX_INLINE_EXTENT_BUFFER_SIZE around since it has the same value as
BTRFS_MAX_METADATA_BLOCKSIZE. So why not just remove
MAX_INLINE_EXTENT_BUFFER_SIZE and use BTRFS_MAX_METADATA_BLOCKSIZE when
calculating INLINE_EXTENT_BUFFER_PAGES.


>  struct extent_buffer {
>  	u64 start;
>  	unsigned long len;
> @@ -227,8 +227,15 @@ void wait_on_extent_buffer_writeback(struct extent_buffer *eb);
>  
>  static inline int num_extent_pages(const struct extent_buffer *eb)
>  {
> -	return (round_up(eb->start + eb->len, PAGE_SIZE) >> PAGE_SHIFT) -
> -	       (eb->start >> PAGE_SHIFT);
> +	/*
> +	 * For sectorsize == PAGE_SIZE case, since eb is always aligned to
> +	 * sectorsize, it's just (eb->len / PAGE_SIZE) >> PAGE_SHIFT.
> +	 *
> +	 * For sectorsize < PAGE_SIZE case, we only want to support 64K
> +	 * PAGE_SIZE, and ensured all tree blocks won't cross page boundary.
> +	 * So in that case we always got 1 page.
> +	 */
> +	return (round_up(eb->len, PAGE_SIZE) >> PAGE_SHIFT);
>  }
>  
>  static inline int extent_buffer_uptodate(const struct extent_buffer *eb)
> 
