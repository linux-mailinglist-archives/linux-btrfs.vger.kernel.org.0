Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783282FD6AF
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jan 2021 18:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732934AbhATPqq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jan 2021 10:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732423AbhATPmR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jan 2021 10:42:17 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0FBC061757
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jan 2021 07:41:36 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id d15so11100695qtw.12
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jan 2021 07:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=47rEKaHYb19AbpnrHwPe94yPmH6lEZF0FSJAQ3Eljpo=;
        b=CmtvaYXnX3JNpux5eWVkFctiiKGBBxrrqdm6hbKjYK2EdOXvu0rrKWaKg/qyJ7t+/a
         ksW4yW5Na2sXUmpvVHvu0bdPZAK0R28RxtxZCtEVfzjtXMW77t9czM49vrHGaGYNN+RY
         B54nnRb4q5fFuug+gJtDebP012SUdyoLy4lk4GoMSBRAtLY+rDF7hUN+mLQmo9deKVjz
         aRTyrNyaiJOnf9GziE23EL+rdPCC+iUBEAh0lvUqFcmk1ZBCnhwP07hHh9X/Mn3L7qVL
         /Q31xBXI0Sealiuj+rcnQ6i7lyUWQjt/4M9NcDI5eA63ysEtr8TwXBDu2T6jXpBDfOUD
         U9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=47rEKaHYb19AbpnrHwPe94yPmH6lEZF0FSJAQ3Eljpo=;
        b=kT3dYOVdW7swkw5D9+2Wikv8tD6YYgbVhZ96OwuRjPEtuZLupdvMw/uFniW5x/qXfk
         6zthrX1xBQZne0IyHRLSxN4Vb0PE7AAi0xUf8nUdVVKlO6n2LfskyYnsPY7/a9fW9atN
         xdjZgTgeRqyyfhhs9h+xKvHi6UWDoSmBH/P91okR1REF1YCihdzI99PAp2fDaXcbvJjO
         TnFwHL80woOM1VN7MUHtKiZDrCSBXP/g/QwD8YxCojW21jzz8KqcHWIC/ZS6jEe2OjJ5
         ixPadIllaEQRWfkTiEfrL/sQpHNlXnSGiWDaUf+TeGJ8/J4hzdHHK+lwMWe/x5+ETN4b
         206g==
X-Gm-Message-State: AOAM531+XTOP0U91X+k88ijMqDYfi7/BRud+W6ob+Aap7MYtd/8TZRHm
        M7rIEXFNzOWt+8E1jbCMrAncYPPE8FkQ5xcYfJ0=
X-Google-Smtp-Source: ABdhPJwPePRpyqtGgQGj55tOfUzdeQ2i+AFxAjfPrORyvRMSkw/bfIL9VJ/aY6QZ8TRsGEsGWL+Fyg==
X-Received: by 2002:ac8:16f2:: with SMTP id y47mr9487906qtk.96.1611157295038;
        Wed, 20 Jan 2021 07:41:35 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s186sm1546520qka.98.2021.01.20.07.41.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 07:41:34 -0800 (PST)
Subject: Re: [PATCH v4 17/18] btrfs: integrate page status update for data
 read path into begin/end_page_read()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210116071533.105780-1-wqu@suse.com>
 <20210116071533.105780-18-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b5e21d24-d2db-dc0f-bd96-1cbcad1a634e@toxicpanda.com>
Date:   Wed, 20 Jan 2021 10:41:33 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210116071533.105780-18-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/16/21 2:15 AM, Qu Wenruo wrote:
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
> ---
>   fs/btrfs/extent_io.c | 38 +++++++++++++++++++----------
>   fs/btrfs/subpage.h   | 57 +++++++++++++++++++++++++++++++++++---------
>   2 files changed, 72 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 4bce03fed205..6ae820144ec7 100644
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
> @@ -3267,6 +3281,7 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
>   		      unsigned int read_flags, u64 *prev_em_start)
>   {
>   	struct inode *inode = page->mapping->host;
> +	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>   	u64 start = page_offset(page);
>   	const u64 end = start + PAGE_SIZE - 1;
>   	u64 cur = start;
> @@ -3310,6 +3325,7 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
>   			kunmap_atomic(userpage);
>   		}
>   	}
> +	begin_data_page_read(fs_info, page);
>   	while (cur <= end) {
>   		bool force_bio_submit = false;
>   		u64 disk_bytenr;
> @@ -3327,13 +3343,14 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
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
> @@ -3416,6 +3433,7 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
>   					    &cached, GFP_NOFS);
>   			unlock_extent_cached(tree, cur,
>   					     cur + iosize - 1, &cached);
> +			end_page_read(page, true, cur, iosize);
>   			cur = cur + iosize;
>   			pg_offset += iosize;
>   			continue;
> @@ -3425,6 +3443,7 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
>   				   EXTENT_UPTODATE, 1, NULL)) {
>   			check_page_uptodate(tree, page);
>   			unlock_extent(tree, cur, cur + iosize - 1);
> +			end_page_read(page, true, cur, iosize);
>   			cur = cur + iosize;
>   			pg_offset += iosize;
>   			continue;
> @@ -3433,8 +3452,8 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
>   		 * to date.  Error out
>   		 */
>   		if (block_start == EXTENT_MAP_INLINE) {
> -			SetPageError(page);
>   			unlock_extent(tree, cur, cur + iosize - 1);
> +			end_page_read(page, false, cur, iosize);
>   			cur = cur + iosize;
>   			pg_offset += iosize;
>   			continue;
> @@ -3451,19 +3470,14 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
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

Huh?  Now in the normal case we're not getting an unlocked page.  Not only that 
we're not setting it uptodate if we had to 0 the whole page, so we're just left 
dangling here because the endio will never be called.

Not to mention you're deleting all of teh SetPageError() calls for no reason 
that I can see, and not replacing it with anything else, so you've essentially 
ripped out any error handling on memory allocation.  Thanks,

Josef
