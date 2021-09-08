Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A9D403E15
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Sep 2021 19:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352370AbhIHREw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Sep 2021 13:04:52 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:53113 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235666AbhIHREw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Sep 2021 13:04:52 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 7A5C15C003E;
        Wed,  8 Sep 2021 13:03:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 08 Sep 2021 13:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=Ezc+vm2SI58fjd6m2t778+wXJ4S
        HMPKxlm04xyho/kk=; b=scaRMpFgEtnEJ8iUIuFHwGqhrsGfBt6KtJ8DVqh8xeZ
        wcUHxjTsIRpXJ5EgYfs0/RIcDKhJkKpjZLk7+Fio47Su4tW4PZy4oso3yjk1ztWM
        4KBszf67r/vbqCZC3cd92opCVGi3QKhapesHCxWqD1CYiQlMUuRZRGLeF8iqfDLS
        kNhGvzF2wRx+nLjkIgQ828n12guqFiI7WiXxtsOwlB6hrXJRornvdnBvDeUSERfs
        N3u5lKkA09jcwcRkk4Jju5vtFKE9wavLU5Q25AAkPKtsJxqBcoeyb2RMR2I45oIx
        TpoZvdO7uSA2EJVH8UALWYyYxHXKKHozx/lYK3+osDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Ezc+vm
        2SI58fjd6m2t778+wXJ4SHMPKxlm04xyho/kk=; b=cPSVa8+Y6B0MpxNaDeu97K
        PdyxCj0GnVgdlNtmtzYr0gd0AA+zf4E0cPHRC2hdb4i5tqHPyo1OGpHEbpNiloMR
        w/imLH2tc0jGO1sVeGNfqfxhQ+97ODLrdcGyy1w6b8O2oJ0VRzPY8Jd6R1cYpj0d
        m40uuEC87hjlbORRi803lYiiBqA05yMS9DcnWX3TvCOynEst7eTdZs7a/07sE3bz
        FIio+7oaDdohFpEBoWURb0Jc9gnaRC+S990P37ME9cy+HBjLB4ZoOAZ1t8/yeauu
        gPUGdxJ0zHbFfcYma9Mpx9ve1bAqAL910SsY2M8Ra73uusqyylcMypbpMp5bz4BA
        ==
X-ME-Sender: <xms:7-w4YT0RMtip7GS4Mzpo0wzSyPqf14dEcqqJhv1wGw7jhL8dsrCj9Q>
    <xme:7-w4YSFBABvtG8janZmBka7OXwwMjXCQClVRWvBfxU950bdU_yqoJhTRBGKCfNFC_
    s1JygESmm3bwBLKxMY>
X-ME-Received: <xmr:7-w4YT65a1kKB8LahoiEhPLOXWA9yiqsfF7UJ9xdzeC1cqmuCCC3lndBDPlWAutDjfpvv9EJIJ3uaGjtIzCZ3_sr-_Sw4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudefjedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ehudevleekieetleevieeuhfduhedtiefgheekfeefgeelvdeuveeggfduueevfeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:7-w4YY3_VqlkEgucbU3qmrofcSnZlu_nydh4A-DFDO8RoI_MU_GBQg>
    <xmx:7-w4YWFB41syfSA43P88yCiat41A8V9N9SSfnciIdtAJ-KvAnFX8UA>
    <xmx:7-w4YZ-Y0jBxN4RgpkTc85B-RUBzRSmLL9Jjb_JMOqXJUmu_wnFOmQ>
    <xmx:7-w4YROAM9-Rh4a3fhBi0cGajyXo9WWjUvLUX0KNgK0_8osoGOC2Sw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Sep 2021 13:03:43 -0400 (EDT)
Date:   Wed, 8 Sep 2021 10:03:41 -0700
From:   Boris Burkov <boris@bur.io>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: don't call end_extent_writepage() in
 __extent_writepage() when IO failed
Message-ID: <YTjstM7duaGeAgwK@zen>
References: <20210803055348.170042-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803055348.170042-1-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 03, 2021 at 01:53:48PM +0800, Qu Wenruo wrote:
> [BUG]
> When running generic/475 with 64K page size and 4K sectorsize (aka
> subpage), it can trigger the following BUG_ON() inside
> btrfs_csum_one_bio(), the possibility is around 1/20 ~ 1/5:
> 
> 	bio_for_each_segment(bvec, bio, iter) {
> 		if (!contig)
> 			offset = page_offset(bvec.bv_page) + bvec.bv_offset;
> 
> 		if (!ordered) {
> 			ordered = btrfs_lookup_ordered_extent(inode, offset);
> 			BUG_ON(!ordered); /* Logic error */ <<<<
> 		}
> 
> 		nr_sectors = BTRFS_BYTES_TO_BLKS(fs_info,
> 
> [CAUSE]
> Test case generic/475 uses dm-errors to emulate IO failure.
> 
> Here if we have a page cache which has the following delalloc range:
> 
> 	0		32K		64K
> 	|/////|		|////|		|
> 	\- [0, 4K)	\- [32K, 36K)
> 
> And then __extent_writepage() can go through the following race:
> 
> 	T1 (writeback)		|	T2 (endio)
> --------------------------------+----------------------------------
> __extent_writepage()		|
> |- writepage_delalloc()		|
> |  |- run_delalloc_range()	|
> |  |  Add OE for [0, 4K)	|
> |  |- run_delalloc_range()	|
> |     Add OE for [32K, 36K)	|
> |				|
> |- __extent_writepage_io()	|
> |  |- submit_extent_page()	|
> |  |  |- Assemble the bio for	|
> |  |     range [0, 4K)		|
> |  |- submit_extent_page()	|
> |  |  |- Submit the bio for	|
> |  |  |  range [0, 4K)		|
> |  |  |				| end_bio_extent_writepage()
> |  |  |				| |- error = -EIO;
> |  |  |				| |- end_extent_writepage( error=-EIO);
> |  |  |				|    |- writepage_endio_finish_ordered()
> |  |  |				|    |  Remove OE for range [0, 4K)
> |  |  |				|    |- btrfs_page_set_error()
> |  |- submit_extent_page()	|
> |     |- Assemble the bio for	|
> |        range [32K, 36K)	|
> |- if (PageError(page))		|
> |- end_extent_writepage()	|
>    |- endio_finish_ordered()	|
>       Remove OE [32K, 36K)	|
> 				|
> Submit bio for [32K, 36K)	|
> |- btrfs_csum_one_bio()		|
>    |- BUG_ON(!ordered_extent)	|
>       OE [32K, 36K) is already  |
>       removed.			|
> 
> This can only happen for subpage case, as for regular sectorsize, we
> never submit current page, thus IO error will never mark the current
> page Error.
> 
> [FIX]
> Just remove the end_extent_writepage() call and the if (PageError())
> check.
> 
> As mentioned, the end_extent_writepage() never really get executed for
> regular sectorsize, and could cause above BUG_ON() for subpage.

I was a little surprised to see this assertion, because it begs the
question: "why was this call added in the first place?"

As best as I can tell, it was introduced by Filipe in
"Btrfs: fix hang on error (such as ENOSPC) when writing extent pages"

That looks like a reasonably niche case that might not be covered by
xfstests, so I was wondering if you had already convinced yourself that
it no longer applies.

I'll try to see if I can reproduce his issue with this patch, or if the
code has changed by enough that it no longer reproduces.

> 
> This also means, inside __extent_writepage() we should not bother any IO
> failure, but only focus on the error hit during bio assembly and
> submission.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index e665779c046d..a1a6ac787faf 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -4111,8 +4111,8 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
>  	 * Here we used to have a check for PageError() and then set @ret and
>  	 * call end_extent_writepage().
>  	 *
> -	 * But in fact setting @ret here will cause different error paths
> -	 * between subpage and regular sectorsize.
> +	 * But in fact setting @ret and call end_extent_writepage() here will
> +	 * cause different error paths between subpage and regular sectorsize.
>  	 *
>  	 * For regular page size, we never submit current page, but only add
>  	 * current page to current bio.
> @@ -4124,7 +4124,12 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
>  	 * thus can get PageError() set by submitted bio of the same page,
>  	 * while our @ret is still 0.
>  	 *
> -	 * So here we unify the behavior and don't set @ret.
> +	 * The same is also for end_extent_writepage(), which can finish
> +	 * ordered extent before submitting the real bio, causing
> +	 * BUG_ON() in btrfs_csum_one_bio().
> +	 *
> +	 * So here we unify the behavior and don't set @ret nor call
> +	 * end_extent_writepage().
>  	 * Error can still be properly passed to higher layer as page will
>  	 * be set error, here we just don't handle the IO failure.
>  	 *
> @@ -4138,8 +4143,7 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
>  	 * Currently the full page based __extent_writepage_io() is not
>  	 * capable of that.
>  	 */
> -	if (PageError(page))
> -		end_extent_writepage(page, ret, start, page_end);
> +
>  	unlock_page(page);
>  	ASSERT(ret <= 0);
>  	return ret;
> -- 
> 2.32.0
> 
