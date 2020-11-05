Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE0A2A7AF2
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Nov 2020 10:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgKEJqm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 04:46:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:41136 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbgKEJqm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Nov 2020 04:46:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604569600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=yZwg98HF1lnWi518ArCyNs/5HaNyV2xG7u1BboqUT3A=;
        b=XjxNc3HzbJRxFU5pOkuXE4SpwUOIFWAT69Y8LRyRRpxg5AunqPncB9TfH0qUmaU6nn2GWh
        a+Dp35cwrGs7F8g04EraFrjusQQUqN3y3llORAiL0/cZUHjF70Gu+5H6Wp4BKWVQtOGJVA
        KXhiz3RmJdrPCNyqXgp0tRWS99yfJ1E=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 52598AAF1;
        Thu,  5 Nov 2020 09:46:40 +0000 (UTC)
Subject: Re: [PATCH 01/32] btrfs: extent_io: remove the
 extent_start/extent_len for end_bio_extent_readpage()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
References: <20201103133108.148112-1-wqu@suse.com>
 <20201103133108.148112-2-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <831ff919-f4f4-7f1b-1e60-ce8df4697651@suse.com>
Date:   Thu, 5 Nov 2020 11:46:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201103133108.148112-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 3.11.20 г. 15:30 ч., Qu Wenruo wrote:
> In end_bio_extent_readpage() we had a strange dance around
> extent_start/extent_len.
> 
> Hides behind the strange dance is, it's just calling
> endio_readpage_release_extent() on each bvec range.
> 
> Here is an example to explain the original work flow:
>   Bio is for inode 257, containing 2 pages, for range [1M, 1M+8K)
> 
>   end_bio_extent_extent_readpage() entered
>   |- extent_start = 0;
>   |- extent_end = 0;
>   |- bio_for_each_segment_all() {
>   |  |- /* Got the 1st bvec */
>   |  |- start = SZ_1M;
>   |  |- end = SZ_1M + SZ_4K - 1;
>   |  |- update = 1;
>   |  |- if (extent_len == 0) {
>   |  |  |- extent_start = start; /* SZ_1M */
>   |  |  |- extent_len = end + 1 - start; /* SZ_1M */
>   |  |  }
>   |  |
>   |  |- /* Got the 2nd bvec */
>   |  |- start = SZ_1M + 4K;
>   |  |- end = SZ_1M + 4K - 1;
>   |  |- update = 1;
>   |  |- if (extent_start + extent_len == start) {
>   |  |  |- extent_len += end + 1 - start; /* SZ_8K */
>   |  |  }
>   |  } /* All bio vec iterated */
>   |
>   |- if (extent_len) {
>      |- endio_readpage_release_extent(tree, extent_start, extent_len,
> 				      update);
> 	/* extent_start == SZ_1M, extent_len == SZ_8K, uptodate = 1 */
> 
> As the above flow shows, the existing code in end_bio_extent_readpage()
> is just accumulate extent_start/extent_len, and when the contiguous range
> breaks, call endio_readpage_release_extent() for the range.
> 
> The contiguous range breaks at two locations:
> - The total else {} branch
>   This means we had a page in a bio where it's not contiguous.
>   Currently this branch will never be triggered. As all our bio is
>   submitted as contiguous pages.
> 

The endio routine cares about logical file contiguity as evidenced by
the fact it uses page_offset() to calculate 'start', however our recent
discussion on irc with the contiguity in csums bios clearly showed that
we can have bios which contains pages that are contiguous in their disk
byte nr but not in their logical offset, in fact Josef even mentioned on
slack that a single bio can contain pages for different inodes so long
as their logical disk byte nr are contiguous. I think this is not an
issue in this case because you are doing the unlock on a bvec
granularity but just the above statement is somewhat misleading.

> - After the bio_for_each_segment_all() loop ends
>   This is the normal call sites where we iterated all bvecs of a bio,
>   and all pages should be contiguous, thus we can call
>   endio_readpage_release_extent() on the full range.
> 
> The original code has also considered cases like (!uptodate), so it will
> mark the uptodate range with EXTENT_UPTODATE.
> 
> So this patch will remove the extent_start/extent_len dancing, replace
> it with regular endio_readpage_release_extent() call on each bvec.
> 
> This brings one behavior change:
> - Temporary memory usage increase
>   Unlike the old call which only modify the extent tree once, now we
>   update the extent tree for each bvec.

I suspect for large bios with a lot of bvecs this would likely increase
latency because we will now invoke endio_readpage_release_extent
proportionally to the number of bvecs.

> 
>   Although the end result is the same, since we may need more extent
>   state split/allocation, we need more temporary memory during that
>   bvec iteration.

Also bear in mind that this happens in a critical endio context, which
uses GFP_ATOMIC allocations so if we get ENOSPC it would be rather bad.

> 
> But considering how streamline the new code is, the temporary memory
> usage increase should be acceptable.

I definitely like the new code however without quantifying what's the
increase of number of calls of endio_readpage_release_extent I'd rather
not merge it.

On a different note, one minor cleanup that could be done is replace all
those "end + 1 - start" expressions with simply "len" as this is
effectively the length of the current bvec.

<snip>
