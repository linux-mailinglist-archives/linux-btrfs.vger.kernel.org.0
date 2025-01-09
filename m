Return-Path: <linux-btrfs+bounces-10881-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF4FA0835E
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 00:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5D55168F8C
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 23:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA72D205E30;
	Thu,  9 Jan 2025 23:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="igXManb1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gSDdIMUO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF8E1FCFF7;
	Thu,  9 Jan 2025 23:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736464813; cv=none; b=E1pFAslsEIEwwAjMtmkYIk7hhvmKoGkQB9p9S1XXZ182JH3EAF+CTX7Sr3+O0VJJCwtvuD8yh8ndGR+L5kG+W92Qi9n/ltE1lDShda+j3x6F80QuiukTTkQyaTXP6YmmgXDtCQKufOTWJVFjYsafZdrNDfVZydeEWWSTZ/+UOkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736464813; c=relaxed/simple;
	bh=eMgrKYbxwOQDyDb2QE8MowyjffTT2nmXiYLJt6iltqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5CFip0H4a/plmRpDmUUnZBx5CTFKqLD1As3Ud1zKmZyUhVFqXSgkHvS+KaFoBmFLmPl6Vi5+D4EOd7nJLaxZj4PHs8v0xaHQWZyNj7Wh/nic80WjsOcSdkOAzsrsfw1JK7pBhXyM11KoQHAH1ruGLQwdvfw/KN+ci73a+Y2KPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=igXManb1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gSDdIMUO; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 699441140120;
	Thu,  9 Jan 2025 18:20:09 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 09 Jan 2025 18:20:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1736464809; x=1736551209; bh=aIfKdg5h4F
	3v6BQRqiM4gMDOvEdrKRego3UZMiH502s=; b=igXManb1h3aD683ulHnI5BCUT2
	xzhPAsiGbBryrRRpQ84c5IoZ+DAv1kX5zCBmePKin8+U7NFWFltPnueJULInn6Tg
	wEg3kviGzCYETAlqcFw+cY2yrNpsg3lX887q/ohBvps/+kjd/b+zP6z/VjleTCk5
	aZPg7NSw8urrGGohUUPTWefo+vnESX5JsLnMAB2xLcmBQ8eYgXDpYg2p+B2Cj/b5
	t2PLQdvn1hUaRrkavHYPz1n7VCab3ECmTkH/Ce5ygjmdxnUO9slEgSeZiNMqN1+w
	Rz6haSKkwLuHK+upzh1PHT2N7vZCxjlaLYt722MCapiaGhAwMe6odKjrNP5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736464809; x=1736551209; bh=aIfKdg5h4F3v6BQRqiM4gMDOvEdrKRego3U
	ZMiH502s=; b=gSDdIMUOH2YRjY1LDaP/CzlR5CQEi/wkoNMJgh6A1Pva2IRDai2
	ZeO8WdEP3Ef/u9A1+bXZgzD6k46GuoHkhEP9f7KzywkRfEeD1b18ZrsVxqDw1ZVi
	9u5u1978q5A0G6iN1dYpXD4coRL7JaO/nhgXJ8OpbQa3mTZoI+0ECf1Vjh4Bhxso
	5bLi/9EIJkJhlhf0BCv+EVXkJTfu5r6kvJIBpU5HfIbgVLS8MWYViLM3S32Lh07x
	tkPgNLAHq9FMyLQ5gtF4XECxGZJZbu8X+wx45hjsry6GYQuYGso/Ii+9rk6W4zrL
	gCcmacpuMvYjmWixnpk+FiLuSZD64FpNaMg==
X-ME-Sender: <xms:qVmAZyc1aTFieelvQt2htAufeP_0QH5EmEdrrNGjrsTWh4VnXNO2Xw>
    <xme:qVmAZ8PHdqniu100YHV-F78i9o5zijzPZ_RpaMJVHM3MfoNQxo_dtqPgtunYglarA
    UJXg7jkLJoC03WAbvk>
X-ME-Received: <xmr:qVmAZziYMBhJjcNdUI7isV-kNfuqWODxH9G_MG4Ru1Kk54Z_ju_9utj54hj-Oib6qvO8CYR0srrTtiIBVo8nLcXUjM4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegjedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenuc
    ggtffrrghtthgvrhhnpeekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeu
    gfdtjefgfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepfihquhesshhushgvrdgtohhmpdhrtghpthhtoheplh
    hinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehs
    thgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:qVmAZ_-L9h2LHyTA7UUuWwoPmlW_PxMMrXDRkdSCG5q9Uypk-MGoaA>
    <xmx:qVmAZ-t5GLHxEi-VE1AoVRBCbGd1LBJiOlBNTU3MrdKHPqa3fq2p8Q>
    <xmx:qVmAZ2GnfxROmJfnsCldlwAs8x3-N-NXaIyiftoyNRxJddx9f6di7w>
    <xmx:qVmAZ9P7xEgNgwXxQM9kzYuaNQ7tq0a-r2vdm6N0RWrnLBMUEJde0g>
    <xmx:qVmAZyI4F0OnvTBKyr8dPO7CVgT4FWPjN1xzo5sytcXJaCL0LJSGjb1V>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jan 2025 18:20:08 -0500 (EST)
Date: Thu, 9 Jan 2025 15:20:40 -0800
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 4/9] btrfs: do proper folio cleanup when
 cow_file_range() failed
Message-ID: <20250109232040.GA2153241@zen.localdomain>
References: <cover.1733983488.git.wqu@suse.com>
 <9f8aec2df9dfc39155d3b6f4448528675b97a955.1733983488.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f8aec2df9dfc39155d3b6f4448528675b97a955.1733983488.git.wqu@suse.com>

On Thu, Dec 12, 2024 at 04:43:58PM +1030, Qu Wenruo wrote:
> [BUG]
> When testing with COW fixup marked as BUG_ON() (this is involved with the
> new pin_user_pages*() change, which should not result new out-of-band
> dirty pages), I hit a crash triggered by the BUG_ON() from hitting COW
> fixup path.
> 
> This BUG_ON() happens just after a failed btrfs_run_delalloc_range():
> 
>  BTRFS error (device dm-2): failed to run delalloc range, root 348 ino 405 folio 65536 submit_bitmap 6-15 start 90112 len 106496: -28
>  ------------[ cut here ]------------
>  kernel BUG at fs/btrfs/extent_io.c:1444!
>  Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
>  CPU: 0 UID: 0 PID: 434621 Comm: kworker/u24:8 Tainted: G           OE      6.12.0-rc7-custom+ #86
>  Hardware name: QEMU KVM Virtual Machine, BIOS unknown 2/2/2022
>  Workqueue: events_unbound btrfs_async_reclaim_data_space [btrfs]
>  pc : extent_writepage_io+0x2d4/0x308 [btrfs]
>  lr : extent_writepage_io+0x2d4/0x308 [btrfs]
>  Call trace:
>   extent_writepage_io+0x2d4/0x308 [btrfs]
>   extent_writepage+0x218/0x330 [btrfs]
>   extent_write_cache_pages+0x1d4/0x4b0 [btrfs]
>   btrfs_writepages+0x94/0x150 [btrfs]
>   do_writepages+0x74/0x190
>   filemap_fdatawrite_wbc+0x88/0xc8
>   start_delalloc_inodes+0x180/0x3b0 [btrfs]
>   btrfs_start_delalloc_roots+0x174/0x280 [btrfs]
>   shrink_delalloc+0x114/0x280 [btrfs]
>   flush_space+0x250/0x2f8 [btrfs]
>   btrfs_async_reclaim_data_space+0x180/0x228 [btrfs]
>   process_one_work+0x164/0x408
>   worker_thread+0x25c/0x388
>   kthread+0x100/0x118
>   ret_from_fork+0x10/0x20
>  Code: aa1403e1 9402f3ef aa1403e0 9402f36f (d4210000)
>  ---[ end trace 0000000000000000 ]---
> 
> [CAUSE]
> That failure is mostly from cow_file_range(), where we can hit -ENOSPC.
> 
> Although the -ENOSPC is already a bug related to our space reservation
> code, let's just focus on the error handling.
> 
> For example, we have the following dirty range [0, 64K) of an inode,
> with 4K sector size and 4K page size:
> 
>    0        16K        32K       48K       64K
>    |///////////////////////////////////////|
>    |#######################################|
> 
> Where |///| means page are still dirty, and |###| means the extent io
> tree has EXTENT_DELALLOC flag.
> 
> - Enter extent_writepage() for page 0
> 
> - Enter btrfs_run_delalloc_range() for range [0, 64K)
> 
> - Enter cow_file_range() for range [0, 64K)
> 
> - Function btrfs_reserve_extent() only reserved one 16K extent
>   So we created extent map and ordered extent for range [0, 16K)
> 
>    0        16K        32K       48K       64K
>    |////////|//////////////////////////////|
>    |<- OE ->|##############################|
> 
>    And range [0, 16K) has its delalloc flag cleared.
>    But since we haven't yet submit any bio, involved 4 pages are still
>    dirty.
> 
> - Function btrfs_reserve_extent() return with -ENOSPC
>   Now we have to run error cleanup, which will clear all
>   EXTENT_DELALLOC* flags and clear the dirty flags for the remaining
>   ranges:
> 
>    0        16K        32K       48K       64K
>    |////////|                              |
>    |        |                              |
> 
>   Note that range [0, 16K) still has their pages dirty.
> 
> - Some time later, writeback are triggered again for the range [0, 16K)
>   since the page range still have dirty flags.
> 
> - btrfs_run_delalloc_range() will do nothing because there is no
>   EXTENT_DELALLOC flag.
> 
> - extent_writepage_io() find page 0 has no ordered flag
>   Which falls into the COW fixup path, triggering the BUG_ON().
> 
> Unfortunately this error handling bug dates back to the introduction of btrfs.
> Thankfully with the abuse of cow fixup, at least it won't crash the
> kernel.
> 
> [FIX]
> Instead of immediately unlock the extent and folios, we keep the extent
> and folios locked until either erroring out or the whole delalloc range
> finished.
> 
> When the whole delalloc range finished without error, we just unlock the
> whole range with PAGE_SET_ORDERED (and PAGE_UNLOCK for !keep_locked
> cases), with EXTENT_DELALLOC and EXTENT_LOCKED cleared.
> And those involved folios will be properly submitted, with their dirty
> flags cleared during submission.
> 
> For the error path, it will be a little more complex:
> 
> - The range with ordered extent allocated (range (1))
>   We only clear the EXTENT_DELALLOC and EXTENT_LOCKED, as the remaining
>   flags are cleaned up by
>   btrfs_mark_ordered_io_finished()->btrfs_finish_one_ordered().
> 
>   For folios we finish the IO (clear dirty, start writeback and
>   immediately finish the writeback) and unlock the folios.
> 
> - The range with reserved extent but no ordered extent (range(2))
> - The range we never touched (range(3))
>   For both range (2) and range(3) the behavior is not changed.
> 
> Now even if cow_file_range() failed halfway with some successfully
> reserved extents/ordered extents, we will keep all folios clean, so
> there will be no future writeback triggered on them.

2 qs, to make sure I understand:

This changes the happy path, in that IO can't start on the allocated
ordered extents until the whole range is done allocating and unlocked or
errors. But it shouldn't be a big deal unless we have this race a lot?

What is the new behavior in your test case? The whole range correctly is
not dirty, no IO happens, and the mapping has an error set on it? Have
you managed to demonstrate something to that effect more explicitly than
not hitting the BUG_ON in your new code?

However, assuming I understood correctly, LGTM.
Reviewed-by: Boris Burkov <boris@bur.io>

> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/inode.c | 65 ++++++++++++++++++++++++------------------------
>  1 file changed, 32 insertions(+), 33 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 5ba8d044757b..19c88b7d0363 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1364,6 +1364,17 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>  
>  	alloc_hint = btrfs_get_extent_allocation_hint(inode, start, num_bytes);
>  
> +	/*
> +	 * We're not doing compressed IO, don't unlock the first page
> +	 * (which the caller expects to stay locked), don't clear any
> +	 * dirty bits and don't set any writeback bits
> +	 *
> +	 * Do set the Ordered (Private2) bit so we know this page was
> +	 * properly setup for writepage.
> +	 */
> +	page_ops = (keep_locked ? 0 : PAGE_UNLOCK);
> +	page_ops |= PAGE_SET_ORDERED;
> +
>  	/*
>  	 * Relocation relies on the relocated extents to have exactly the same
>  	 * size as the original extents. Normally writeback for relocation data
> @@ -1423,6 +1434,10 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>  		file_extent.offset = 0;
>  		file_extent.compression = BTRFS_COMPRESS_NONE;
>  
> +		/*
> +		 * Locked range will be released either during error clean up or
> +		 * after the whole range is finished.
> +		 */
>  		lock_extent(&inode->io_tree, start, start + cur_alloc_size - 1,
>  			    &cached);
>  
> @@ -1468,21 +1483,6 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>  
>  		btrfs_dec_block_group_reservations(fs_info, ins.objectid);
>  
> -		/*
> -		 * We're not doing compressed IO, don't unlock the first page
> -		 * (which the caller expects to stay locked), don't clear any
> -		 * dirty bits and don't set any writeback bits
> -		 *
> -		 * Do set the Ordered flag so we know this page was
> -		 * properly setup for writepage.
> -		 */
> -		page_ops = (keep_locked ? 0 : PAGE_UNLOCK);
> -		page_ops |= PAGE_SET_ORDERED;
> -
> -		extent_clear_unlock_delalloc(inode, start, start + cur_alloc_size - 1,
> -					     locked_folio, &cached,
> -					     EXTENT_LOCKED | EXTENT_DELALLOC,
> -					     page_ops);
>  		if (num_bytes < cur_alloc_size)
>  			num_bytes = 0;
>  		else
> @@ -1499,6 +1499,9 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>  		if (ret)
>  			goto out_unlock;
>  	}
> +	extent_clear_unlock_delalloc(inode, orig_start, end, locked_folio, &cached,
> +				     EXTENT_LOCKED | EXTENT_DELALLOC,
> +				     page_ops);
>  done:
>  	if (done_offset)
>  		*done_offset = end;
> @@ -1519,35 +1522,31 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>  	 * We process each region below.
>  	 */
>  
> -	clear_bits = EXTENT_LOCKED | EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
> -		EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV;
> -	page_ops = PAGE_UNLOCK | PAGE_START_WRITEBACK | PAGE_END_WRITEBACK;
> -
>  	/*
>  	 * For the range (1). We have already instantiated the ordered extents
>  	 * for this region. They are cleaned up by
>  	 * btrfs_cleanup_ordered_extents() in e.g,
> -	 * btrfs_run_delalloc_range(). EXTENT_LOCKED | EXTENT_DELALLOC are
> -	 * already cleared in the above loop. And, EXTENT_DELALLOC_NEW |
> -	 * EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV are handled by the cleanup
> -	 * function.
> +	 * btrfs_run_delalloc_range().
> +	 * EXTENT_DELALLOC_NEW | EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV
> +	 * are also handled by the cleanup function.
>  	 *
> -	 * However, in case of @keep_locked, we still need to unlock the pages
> -	 * (except @locked_folio) to ensure all the pages are unlocked.
> +	 * So here we only clear EXTENT_LOCKED and EXTENT_DELALLOC flag,
> +	 * and finish the writeback of the involved folios, which will be
> +	 * never submitted.
>  	 */
> -	if (keep_locked && orig_start < start) {
> +	if (orig_start < start) {
> +		clear_bits = EXTENT_LOCKED | EXTENT_DELALLOC;
> +		page_ops = PAGE_UNLOCK | PAGE_START_WRITEBACK | PAGE_END_WRITEBACK;
> +
>  		if (!locked_folio)
>  			mapping_set_error(inode->vfs_inode.i_mapping, ret);
>  		extent_clear_unlock_delalloc(inode, orig_start, start - 1,
> -					     locked_folio, NULL, 0, page_ops);
> +					     locked_folio, NULL, clear_bits, page_ops);
>  	}
>  
> -	/*
> -	 * At this point we're unlocked, we want to make sure we're only
> -	 * clearing these flags under the extent lock, so lock the rest of the
> -	 * range and clear everything up.
> -	 */
> -	lock_extent(&inode->io_tree, start, end, NULL);
> +	clear_bits = EXTENT_LOCKED | EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
> +		EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV;
> +	page_ops = PAGE_UNLOCK | PAGE_START_WRITEBACK | PAGE_END_WRITEBACK;
>  
>  	/*
>  	 * For the range (2). If we reserved an extent for our delalloc range
> -- 
> 2.47.1
> 

