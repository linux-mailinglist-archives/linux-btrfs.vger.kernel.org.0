Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D923061A9
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 18:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbhA0RPr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 12:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233624AbhA0ROv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 12:14:51 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51533C06178C
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 09:13:30 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id a19so2450612qka.2
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 09:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xrnPNg9PW24xoNDW3O+I/Ll+vPfkshD6140tic6uKrA=;
        b=2MJazwrf9PqPW2+5Wg8NV8BrY4mPjNZJKxg9XEaCjJ+POBPzvtvARE286vz3gDpmu1
         l29geoy2ElDj5ERhC2isGvcI/4OlMittWfgpT0YZYLuCEdFDj19W8jUpuXNQPgWd+SNj
         EHI+9RHaKIoVXcgJD3tZVVX2XFG8W5nMSt8x2Ou2hXXMkUnc0aHuF4GSGCkYiRicYYPH
         Mfl1w3H5TeOBGKV3/anKyZM18JWwp8fWev5AZVdTMeQb08BEIfqWyUDEM1cC9nQ9KtSZ
         grkklgN7RM8rNeLi5+Fgyz6E6Oc0dxry1zzxaHI3iuQpD+qfyknqs7OUJxtDLSt9Lvb4
         itOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xrnPNg9PW24xoNDW3O+I/Ll+vPfkshD6140tic6uKrA=;
        b=KUJ9udc2CGnJqUt3EzUwfuDYGY6eKQPR+LzDkPhB1WXWmVKu0bi4glbhFxkE3DLR/b
         UGRwm0T6YwVft9xM89IRGHX+D5YT9ARA8uMjFdim4FFcaR4nkYBMDyispQq3vl2wKLtR
         q1iR0/mibZlbv9S+At9VecuSrajdF9hd89+Yuwh7yiwJeAACXxW0Ifm2WnOSjbtWvXmF
         q63TZmj7lI8e57t/HK9uWtG3l+lojSajM7dES5PnpSK8M8FYrwey50IXzvGUZGO9A2Zg
         I+23D4U9opSEK+DOC7/uos9HprP9OHf79ST6mg8YE/f/SRdHQk/50DLlz/YCoBUJJjE5
         LPfA==
X-Gm-Message-State: AOAM5327MKoLoy2gD5wnt0dSLsHRdlkdoe3LAPoEVkA8VERAdk2/cJuw
        mCWQx1JD90Qo/bSdgrbwQp4Q6PGGzvx53VQ2
X-Google-Smtp-Source: ABdhPJxSRprdhzZ2g5mD1RmJ8PzqFirsIn5QUIQzPeIfHCg0t60CNs9ZxLCBledv83eO1F9/8fTekQ==
X-Received: by 2002:a37:4116:: with SMTP id o22mr11410605qka.236.1611767609410;
        Wed, 27 Jan 2021 09:13:29 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 202sm1575285qkj.92.2021.01.27.09.13.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 09:13:28 -0800 (PST)
Subject: Re: [PATCH v5 17/18] btrfs: integrate page status update for data
 read path into begin/end_page_read()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
References: <20210126083402.142577-1-wqu@suse.com>
 <20210126083402.142577-18-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <dd190a49-9c70-c6a5-1c2d-896d290c1a76@toxicpanda.com>
Date:   Wed, 27 Jan 2021 12:13:27 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210126083402.142577-18-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/26/21 3:34 AM, Qu Wenruo wrote:
> In btrfs data page read path, the page status update are handled in two
> different locations:
> 
>    btrfs_do_read_page()
>    {
> 	while (cur <= end) {
> 		/* No need to read from disk */
> 		if (HOLE/PREALLOC/INLINE){
> 			memset();
> 			set_extent_uptodate();
> 			continue;
> 		}
> 		/* Read from disk */
> 		ret = submit_extent_page(end_bio_extent_readpage);
>    }
> 
>    end_bio_extent_readpage()
>    {
> 	endio_readpage_uptodate_page_status();
>    }
> 
> This is fine for sectorsize == PAGE_SIZE case, as for above loop we
> should only hit one branch and then exit.
> 
> But for subpage, there are more works to be done in page status update:
> - Page Unlock condition
>    Unlike regular page size == sectorsize case, we can no longer just
>    unlock a page without a brain.
>    Only the last reader of the page can unlock the page.
>    This means, we can unlock the page either in the while() loop, or in
>    the endio function.
> 
> - Page uptodate condition
>    Since we have multiple sectors to read for a page, we can only mark
>    the full page uptodate if all sectors are uptodate.
> 
> To handle both subpage and regular cases, introduce a pair of functions
> to help handling page status update:
> 
> - being_page_read()
>    For regular case, it does nothing.
>    For subpage case, it update the reader counters so that later
>    end_page_read() can know who is the last one to unlock the page.
> 
> - end_page_read()
>    This is just endio_readpage_uptodate_page_status() renamed.
>    The original name is a little too long and too specific for endio.
> 
>    The only new trick added is the condition for page unlock.
>    Now for subage data, we unlock the page if we're the last reader.
> 
> This does not only provide the basis for subpage data read, but also
> hide the special handling of page read from the main read loop.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/extent_io.c | 38 ++++++++++++++++++++----------
>   fs/btrfs/subpage.c   | 56 ++++++++++++++++++++++++++++++++++----------
>   fs/btrfs/subpage.h   |  8 +++++++
>   3 files changed, 78 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index eeee3213daaa..7fc2c62d4eb9 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2839,8 +2839,17 @@ static void endio_readpage_release_extent(struct processed_extent *processed,
>   	processed->uptodate = uptodate;
>   }
>   
> -static void endio_readpage_update_page_status(struct page *page, bool uptodate,
> -					      u64 start, u32 len)
> +static void begin_data_page_read(struct btrfs_fs_info *fs_info, struct page *page)
> +{
> +	ASSERT(PageLocked(page));
> +	if (fs_info->sectorsize == PAGE_SIZE)
> +		return;
> +
> +	ASSERT(PagePrivate(page));
> +	btrfs_subpage_start_reader(fs_info, page, page_offset(page), PAGE_SIZE);
> +}
> +
> +static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
>   {
>   	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
>   
> @@ -2856,7 +2865,12 @@ static void endio_readpage_update_page_status(struct page *page, bool uptodate,
>   
>   	if (fs_info->sectorsize == PAGE_SIZE)
>   		unlock_page(page);
> -	/* Subpage locking will be handled in later patches */
> +	else if (is_data_inode(page->mapping->host))
> +		/*
> +		 * For subpage data, unlock the page if we're the last reader.
> +		 * For subpage metadata, page lock is not utilized for read.
> +		 */
> +		btrfs_subpage_end_reader(fs_info, page, start, len);
>   }
>   
>   /*
> @@ -2993,7 +3007,7 @@ static void end_bio_extent_readpage(struct bio *bio)
>   		bio_offset += len;
>   
>   		/* Update page status and unlock */
> -		endio_readpage_update_page_status(page, uptodate, start, len);
> +		end_page_read(page, uptodate, start, len);
>   		endio_readpage_release_extent(&processed, BTRFS_I(inode),
>   					      start, end, uptodate);
>   	}
> @@ -3263,6 +3277,7 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
>   		      unsigned int read_flags, u64 *prev_em_start)
>   {
>   	struct inode *inode = page->mapping->host;
> +	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>   	u64 start = page_offset(page);
>   	const u64 end = start + PAGE_SIZE - 1;
>   	u64 cur = start;
> @@ -3306,6 +3321,7 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
>   			kunmap_atomic(userpage);
>   		}
>   	}

You have two error cases above this

         ret = set_page_extent_mapped(page);
         if (ret < 0) {
                 unlock_extent(tree, start, end);
                 SetPageError(page);
                 goto out;
         }

and

         if (!PageUptodate(page)) {
                 if (cleancache_get_page(page) == 0) {
                         BUG_ON(blocksize != PAGE_SIZE);
                         unlock_extent(tree, start, end);
                         goto out;
                 }
         }

which will now leave the page locked when it errors out.  Not to mention I'm 
pretty sure you want to use btrfs_page_set_error() instead of SetPageError() in 
that first case.

> +	begin_data_page_read(fs_info, page);
>   	while (cur <= end) {
>   		bool force_bio_submit = false;
>   		u64 disk_bytenr;
> @@ -3323,13 +3339,14 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
>   					    &cached, GFP_NOFS);
>   			unlock_extent_cached(tree, cur,
>   					     cur + iosize - 1, &cached);
> +			end_page_read(page, true, cur, iosize);
>   			break;
>   		}
>   		em = __get_extent_map(inode, page, pg_offset, cur,
>   				      end - cur + 1, em_cached);
>   		if (IS_ERR_OR_NULL(em)) {
> -			SetPageError(page);
>   			unlock_extent(tree, cur, end);
> +			end_page_read(page, false, cur, end + 1 - cur);
>   			break;
>   		}
>   		extent_offset = cur - em->start;
> @@ -3412,6 +3429,7 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
>   					    &cached, GFP_NOFS);
>   			unlock_extent_cached(tree, cur,
>   					     cur + iosize - 1, &cached);
> +			end_page_read(page, true, cur, iosize);
>   			cur = cur + iosize;
>   			pg_offset += iosize;
>   			continue;
> @@ -3421,6 +3439,7 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
>   				   EXTENT_UPTODATE, 1, NULL)) {
>   			check_page_uptodate(tree, page);
>   			unlock_extent(tree, cur, cur + iosize - 1);
> +			end_page_read(page, true, cur, iosize);
>   			cur = cur + iosize;
>   			pg_offset += iosize;
>   			continue;
> @@ -3429,8 +3448,8 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
>   		 * to date.  Error out
>   		 */
>   		if (block_start == EXTENT_MAP_INLINE) {
> -			SetPageError(page);
>   			unlock_extent(tree, cur, cur + iosize - 1);
> +			end_page_read(page, false, cur, iosize);
>   			cur = cur + iosize;
>   			pg_offset += iosize;
>   			continue;
> @@ -3447,19 +3466,14 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
>   			nr++;
>   			*bio_flags = this_bio_flag;
>   		} else {
> -			SetPageError(page);
>   			unlock_extent(tree, cur, cur + iosize - 1);
> +			end_page_read(page, false, cur, iosize);
>   			goto out;
>   		}
>   		cur = cur + iosize;
>   		pg_offset += iosize;
>   	}
>   out:
> -	if (!nr) {
> -		if (!PageError(page))
> -			SetPageUptodate(page);
> -		unlock_page(page);
> -	}

We can just delete out: here and either return on error or break from the main 
loop.  Thanks,

Josef
