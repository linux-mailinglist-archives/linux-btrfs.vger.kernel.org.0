Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60EA63612AA
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Apr 2021 21:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbhDOTDl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Apr 2021 15:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbhDOTDl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Apr 2021 15:03:41 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E33C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Apr 2021 12:03:15 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id b139so20951481qkc.10
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Apr 2021 12:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=uoayL1ozZaJsEOgv5lq5l6vSIdfCH9k4jPSzJnQZ/Wg=;
        b=LzpIWahpQSwuhF5r6j+xQTOX94m0be7hFes1/XY69L+4Vkovo3vVs6uFni20l848Ow
         xB8Qx6PmSSn3JmfXlChq+ye6ClnBajScitixre5MAjztxGlq06hFFkcWc6FrP1dDEjw+
         w4sxXIEnubBtApm1m03nW4uguXxWex78v4o+Wmlb75nPy0vt4V7KHtlZ2RVPec9YgHH6
         PsA2SCwUFQHfPHTpCTlUG29/UJoiR+KOxhI/OH8dLfaWF+71TriNcZg3rVrs6sQ8r6mL
         tHxJ3Utj4ZU/uTQHM/rDxtCfh3tLZKW5c9Pv6fYWnOQ8WVsAZI0qwhuKIzHDbZd3tcWZ
         zwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uoayL1ozZaJsEOgv5lq5l6vSIdfCH9k4jPSzJnQZ/Wg=;
        b=VZ6AFBpYdLjfo2bhPSv8GnxffMSjMpeHi5kXDL2EelAn3eEmLyaDN5gVu/jRkoIyZs
         5OcA5C6rTl2KjD2Q6VmB18G83oKB94ntPNBP0evkCJIV4Yy8KjE0GA+3XslvZ4aTaFvW
         JVyMFl2sk8SmatZDy5avN4VLrM5aLSW/Ericfvk2ulkuuMrC8asDdpV5Hz0qH+5lj5hx
         UG9gi59MKZTwXiUERLM3yjwZY/PIW+M8xWUedVYSxRwpLX99IqpaAIkKwGVWOMEMOUpP
         TulY3ggnr6xDZGMIBZRxcnRj8RodWcRSj6If8CpsfDw30dEfmXdRI0hxAF/Xd3PvehXE
         XoQQ==
X-Gm-Message-State: AOAM531nVqUoI3WDrOfGUc9ZedfZY0nSlkF9dd+ZoJB2pAUDuaLGB/tU
        jzvEg/NthG+3TKbIPjIJEzaJ/92KEP7UuQ==
X-Google-Smtp-Source: ABdhPJylPruGoFhgh3XjlNm3DWM/SdVTTaSMNN8IfkqxsJJje7EtSVQsKMC/QQ95e1VVICMdb/FHOg==
X-Received: by 2002:a37:f505:: with SMTP id l5mr5213329qkk.382.1618513393787;
        Thu, 15 Apr 2021 12:03:13 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11c9::1288? ([2620:10d:c091:480::1:2677])
        by smtp.gmail.com with ESMTPSA id v192sm2575103qkb.83.2021.04.15.12.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 12:03:13 -0700 (PDT)
Subject: Re: [PATCH 02/42] btrfs: introduce write_one_subpage_eb() function
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210415050448.267306-1-wqu@suse.com>
 <20210415050448.267306-3-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <7cff2211-b74a-647e-12f5-fb5994d9f3f0@toxicpanda.com>
Date:   Thu, 15 Apr 2021 15:03:12 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210415050448.267306-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/15/21 1:04 AM, Qu Wenruo wrote:
> The new function, write_one_subpage_eb(), as a subroutine for subpage
> metadata write, will handle the extent buffer bio submission.
> 
> The major differences between the new write_one_subpage_eb() and
> write_one_eb() is:
> - No page locking
>    When entering write_one_subpage_eb() the page is no longer locked.
>    We only lock the page for its status update, and unlock immediately.
>    Now we completely rely on extent io tree locking.
> 
> - Extra bitmap update along with page status update
>    Now page dirty and writeback is controlled by
>    btrfs_subpage::dirty_bitmap and btrfs_subpage::writeback_bitmap.
>    They both follow the schema that any sector is dirty/writeback, then
>    the full page get dirty/writeback.
> 
> - When to update the nr_written number
>    Now we take a short cut, if we have cleared the last dirty bit of the
>    page, we update nr_written.
>    This is not completely perfect, but should emulate the old behavior
>    good enough.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/extent_io.c | 55 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 55 insertions(+)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 21a14b1cb065..f32163a465ec 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -4196,6 +4196,58 @@ static void end_bio_extent_buffer_writepage(struct bio *bio)
>   	bio_put(bio);
>   }
>   
> +/*
> + * Unlike the work in write_one_eb(), we rely completely on extent locking.
> + * Page locking is only utizlied at minimal to keep the VM code happy.
> + *
> + * Caller should still call write_one_eb() other than this function directly.
> + * As write_one_eb() has extra prepration before submitting the extent buffer.
> + */
> +static int write_one_subpage_eb(struct extent_buffer *eb,
> +				struct writeback_control *wbc,
> +				struct extent_page_data *epd)
> +{
> +	struct btrfs_fs_info *fs_info = eb->fs_info;
> +	struct page *page = eb->pages[0];
> +	unsigned int write_flags = wbc_to_write_flags(wbc) | REQ_META;
> +	bool no_dirty_ebs = false;
> +	int ret;
> +
> +	/* clear_page_dirty_for_io() in subpage helper need page locked. */
> +	lock_page(page);
> +	btrfs_subpage_set_writeback(fs_info, page, eb->start, eb->len);
> +
> +	/* If we're the last dirty bit to update nr_written */
> +	no_dirty_ebs = btrfs_subpage_clear_and_test_dirty(fs_info, page,
> +							  eb->start, eb->len);
> +	if (no_dirty_ebs)
> +		clear_page_dirty_for_io(page);
> +
> +	ret = submit_extent_page(REQ_OP_WRITE | write_flags, wbc, page,
> +			eb->start, eb->len, eb->start - page_offset(page),
> +			&epd->bio, end_bio_extent_buffer_writepage, 0, 0, 0,
> +			false);
> +	if (ret) {
> +		btrfs_subpage_clear_writeback(fs_info, page, eb->start,
> +					      eb->len);
> +		set_btree_ioerr(page, eb);
> +		unlock_page(page);
> +
> +		if (atomic_dec_and_test(&eb->io_pages))
> +			end_extent_buffer_writeback(eb);
> +		return -EIO;
> +	}
> +	unlock_page(page);
> +	/*
> +	 * Submission finishes without problem, if no range of the page is
> +	 * dirty anymore, we have submitted a page.
> +	 * Update the nr_written in wbc.
> +	 */
> +	if (no_dirty_ebs)
> +		update_nr_written(wbc, 1);
> +	return ret;
> +}
> +
>   static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
>   			struct writeback_control *wbc,
>   			struct extent_page_data *epd)
> @@ -4227,6 +4279,9 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
>   		memzero_extent_buffer(eb, start, end - start);
>   	}
>   
> +	if (eb->fs_info->sectorsize < PAGE_SIZE)
> +		return write_one_subpage_eb(eb, wbc, epd);
> +

Same comment here, again you're calling write_one_eb() which expects to do the 
eb thing, but then later have an entirely different path for the subpage stuff, 
and thus could just call your write_one_subpage_eb() helper from there instead 
of stuffing it into write_one_eb().

Also, I generally don't care about ordering of patches as long as they make 
sense generally.

However in this case if you were to bisect to just this patch you would be 
completely screwed, as the normal write path would just fail to write the other 
eb's on the page.  You really need to have the patches that do the 
write_cache_pages part done first, and then have this patch.

Or alternatively, leave the order as it is, and simply don't wire the helper up 
until you implement the subpage writepages further down.  That may be better, 
you won't have to re-order anything and you can maintain these smaller chunks 
for review, which may not be possible if you re-order them.  Thanks,

Josef
