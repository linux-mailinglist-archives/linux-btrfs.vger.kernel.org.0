Return-Path: <linux-btrfs+bounces-10801-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9D5A06781
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 22:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53DA1167069
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 21:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17B820408A;
	Wed,  8 Jan 2025 21:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="atC7xzIl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xqV5IqB+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CC81F426E;
	Wed,  8 Jan 2025 21:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736373125; cv=none; b=eBdWNQRvu7K40DlxY23HJCv3OlU4xJu5WITMqstAiJCxIb+lBuKIPbwwHDD9ERIM14mGVq37oDBg0ZT2P02U9O9zegVg9F6Kw05kHx232SJqWaHEqTJFkPdZZLwv6aQQi+zHfJn3hDvkZ+Y6VVF6RDKqqN/1Wj74hF28rvGjHR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736373125; c=relaxed/simple;
	bh=8JQcmp3gMKrtVTrfGoSvc2nQ+bjVdU48rxC6yUOKto8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewW5wFu08UkIAHB+bw/ZimUjVHhP9ZVUBO+5znunUA4GzAOONNPXiiMve/X69HuUKfEHJHQnqEHzGr9TY84unItV+4qpsgGyA34Hpvx/Z4GWCHBL2jzNkoiKuCGAjgtxuoLLZe2LyKwMX7WIPAEOd3/gO+/nK04qYAz7NzBPYwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=atC7xzIl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xqV5IqB+; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 597501140187;
	Wed,  8 Jan 2025 16:52:01 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 08 Jan 2025 16:52:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1736373121; x=1736459521; bh=VUPDEEwYhG
	CMmyLlChHZfHD+O/1htB9uQualJZ6WCUE=; b=atC7xzIlO6K7a5THp1yYZlTG9a
	4EcUG2R/BmXuV82MKa2U2cAE6wXU7p+kWgHUPDHak6+F6e3ES5AxoEqTMZxBW3t+
	eHT+lvqS66+Wsk5+AS5+Y3xQPzYPYqdoB7Lqm208ztIp1oERM0Jl2uKfho9SpNEo
	U+ILmqsE0Z7gCf2QeQEvoGIuO1I78n9IHnNc+Mm0igeiHOt8YlvVLVu9qU5U/EIo
	yCvsXtNhzFnfu7vJXsMprvBwMUqLJtQ8hrbLbkbc7dzBP96hBMVS7rtmh2RECDNb
	4oViqVo4N5lIGVa/bav1TCXu/P5CA0YspN8tUvrGwcjbQtbPudzOg5FJycZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736373121; x=1736459521; bh=VUPDEEwYhGCMmyLlChHZfHD+O/1htB9uQua
	lJZ6WCUE=; b=xqV5IqB+EQMytx+FZcA45hUprgfCHh0Y0hjW9IaEeSpHhol77tw
	YwcLrs25fYGvU7w/R+EC/lSSyqq4B8hdWOHnc9YO6Hlndx42SPj++G3ezRAsFNBt
	gHuBFcU4CfT1c3Nfm+0BlDyiPTvhuh/W1NKMN6BA9KyCi+7YRULDR49kqqI/2DWi
	uLOl+41gtS7O/whdITvpN3BPBhUA+ruRm6E/i0sh3GjOjAoQ4Tpd/i/jM2gxL9JS
	Jaqkxe4pzeZP/8NXDa+A1wM9q3Q/x1U/4AQjh4SpU8h1gzz8whSxsbNwPpymFcwY
	9sQPz5idgioMC8l746lS8NbMYWyKBsE4mQQ==
X-ME-Sender: <xms:gPN-Z_LvNAPZ3OlWejnrX4kRUzq7ai2elVPB6g1M8LxGaBYpvvlBbg>
    <xme:gPN-ZzKyK0RlA8q8t8jhPu8D1HwAk9RwR5Gq7mLNWPynBZD4SVeZBUEm0X2msnfKk
    ibwzah1qZrxGaz5wuM>
X-ME-Received: <xmr:gPN-Z3sjLOLEl0HkfKj2FxAdLB4dQQCy3j5ncE2dMxZ9Xf900BP1dRd9D0HdoVmiWJ8KU7vQb7GiRy-nXnsFXkxjKqs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggedgudehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqne
    cuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfg
    uefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopeifqhhusehsuhhsvgdrtghomhdprhgtphhtthhope
    hlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    shhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:gPN-Z4YJ85jwE_mVOxcnktrWScv5o-WFUZjlAD8qGSfH8c26PIExBg>
    <xmx:gPN-Z2Y21bEedQG9LMKjeMiIf2E5CQvtAq6AH_eKvcKR0k84I-aHOg>
    <xmx:gPN-Z8BplmGAIaZTzjGkBWYkBDERFudSodlKBnUWYCWXXVEfDEQx0w>
    <xmx:gPN-Z0YYqx9msXBbeqQKmbAXjiBmzGcXagEp88Rcdw9K_njdPhYuLg>
    <xmx:gfN-Z2FHem7Xgt7X900RJq8X1l9gjUo2NNwBCToxYVjMXeDKNRFbwL-E>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jan 2025 16:52:00 -0500 (EST)
Date: Wed, 8 Jan 2025 13:52:33 -0800
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/9] btrfs: fix double accounting race when
 btrfs_run_delalloc_range() failed
Message-ID: <20250108215233.GA1456944@zen.localdomain>
References: <cover.1733983488.git.wqu@suse.com>
 <cc3ceda915ac4832fe8e706f3cb0fd2f5971efcc.1733983488.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc3ceda915ac4832fe8e706f3cb0fd2f5971efcc.1733983488.git.wqu@suse.com>

On Thu, Dec 12, 2024 at 04:43:55PM +1030, Qu Wenruo wrote:
> [BUG]
> When running btrfs with block size (4K) smaller than page size (64K,
> aarch64), there is a very high chance to crash the kernel at
> generic/750, with the following messages:
> (before the call traces, there are 3 extra debug messages added)
> 
>  BTRFS warning (device dm-3): read-write for sector size 4096 with page size 65536 is experimental
>  BTRFS info (device dm-3): checking UUID tree
>  hrtimer: interrupt took 5451385 ns
>  BTRFS error (device dm-3): cow_file_range failed, root=4957 inode=257 start=1605632 len=69632: -28
>  BTRFS error (device dm-3): run_delalloc_nocow failed, root=4957 inode=257 start=1605632 len=69632: -28
>  BTRFS error (device dm-3): failed to run delalloc range, root=4957 ino=257 folio=1572864 submit_bitmap=8-15 start=1605632 len=69632: -28
>  ------------[ cut here ]------------
>  WARNING: CPU: 2 PID: 3020984 at ordered-data.c:360 can_finish_ordered_extent+0x370/0x3b8 [btrfs]
>  CPU: 2 UID: 0 PID: 3020984 Comm: kworker/u24:1 Tainted: G           OE      6.13.0-rc1-custom+ #89
>  Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
>  Hardware name: QEMU KVM Virtual Machine, BIOS unknown 2/2/2022
>  Workqueue: events_unbound btrfs_async_reclaim_data_space [btrfs]
>  pc : can_finish_ordered_extent+0x370/0x3b8 [btrfs]
>  lr : can_finish_ordered_extent+0x1ec/0x3b8 [btrfs]
>  Call trace:
>   can_finish_ordered_extent+0x370/0x3b8 [btrfs] (P)
>   can_finish_ordered_extent+0x1ec/0x3b8 [btrfs] (L)
>   btrfs_mark_ordered_io_finished+0x130/0x2b8 [btrfs]
>   extent_writepage+0x10c/0x3b8 [btrfs]
>   extent_write_cache_pages+0x21c/0x4e8 [btrfs]
>   btrfs_writepages+0x94/0x160 [btrfs]
>   do_writepages+0x74/0x190
>   filemap_fdatawrite_wbc+0x74/0xa0
>   start_delalloc_inodes+0x17c/0x3b0 [btrfs]
>   btrfs_start_delalloc_roots+0x17c/0x288 [btrfs]
>   shrink_delalloc+0x11c/0x280 [btrfs]
>   flush_space+0x288/0x328 [btrfs]
>   btrfs_async_reclaim_data_space+0x180/0x228 [btrfs]
>   process_one_work+0x228/0x680
>   worker_thread+0x1bc/0x360
>   kthread+0x100/0x118
>   ret_from_fork+0x10/0x20
>  ---[ end trace 0000000000000000 ]---
>  BTRFS critical (device dm-3): bad ordered extent accounting, root=4957 ino=257 OE offset=1605632 OE len=16384 to_dec=16384 left=0
>  BTRFS critical (device dm-3): bad ordered extent accounting, root=4957 ino=257 OE offset=1622016 OE len=12288 to_dec=12288 left=0
>  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
>  BTRFS critical (device dm-3): bad ordered extent accounting, root=4957 ino=257 OE offset=1634304 OE len=8192 to_dec=4096 left=0
>  CPU: 1 UID: 0 PID: 3286940 Comm: kworker/u24:3 Tainted: G        W  OE      6.13.0-rc1-custom+ #89
>  Hardware name: QEMU KVM Virtual Machine, BIOS unknown 2/2/2022
>  Workqueue:  btrfs_work_helper [btrfs] (btrfs-endio-write)
>  pstate: 404000c5 (nZcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>  pc : process_one_work+0x110/0x680
>  lr : worker_thread+0x1bc/0x360
>  Call trace:
>   process_one_work+0x110/0x680 (P)
>   worker_thread+0x1bc/0x360 (L)
>   worker_thread+0x1bc/0x360
>   kthread+0x100/0x118
>   ret_from_fork+0x10/0x20
>  Code: f84086a1 f9000fe1 53041c21 b9003361 (f9400661)
>  ---[ end trace 0000000000000000 ]---
>  Kernel panic - not syncing: Oops: Fatal exception
>  SMP: stopping secondary CPUs
>  SMP: failed to stop secondary CPUs 2-3
>  Dumping ftrace buffer:
>     (ftrace buffer empty)
>  Kernel Offset: 0x275bb9540000 from 0xffff800080000000
>  PHYS_OFFSET: 0xffff8fbba0000000
>  CPU features: 0x100,00000070,00801250,8201720b
> 
> [CAUSE]
> The above warning is triggered immediately after the delalloc range
> failure, this happens in the following sequence:
> 
> - Range [1568K, 1636K) is dirty
> 
>    1536K  1568K     1600K    1636K  1664K
>    |      |/////////|////////|      |
> 
>   Where 1536K, 1600K and 1664K are page boundaries (64K page size)
> 
> - Enter extent_writepage() for page 1536K
> 
> - Enter run_delalloc_nocow() with locked page 1536K and range
>   [1568K, 1636K)
>   This is due to the inode has preallocated extents.
> 
> - Enter cow_file_range() with locked page 1536K and range
>   [1568K, 1636K)
> 
> - btrfs_reserve_extent() only reserved two extents
>   The main loop of cow_file_range() only reserved two data extents,
> 
>   Now we have:
> 
>    1536K  1568K        1600K    1636K  1664K
>    |      |<-->|<--->|/|///////|      |
>                1584K  1596K
>   Range [1568K, 1596K) has ordered extent reserved.
> 
> - btrfs_reserve_extent() failed inside cow_file_range() for file offset
>   1596K
>   This is already a bug in our space reservation code, but for now let's
>   focus on the error handling path.
> 
>   Now cow_file_range() returned -ENOSPC.
> 
> - btrfs_run_delalloc_range() do error cleanup <<< ROOT CAUSE
>   Call btrfs_cleanup_ordered_extents() with locked folio 1536K and range
>   [1568K, 1636K)
> 
>   Function btrfs_cleanup_ordered_extents() normally needs to skip the
>   ranges inside the folio, as it will normally be cleaned up by
>   extent_writepage().
> 
>   Such split error handling is already problematic in the first place.
> 
>   What's worse is the folio range skipping itself, which is not taking
>   subpage cases into consideration at all, it will only skip the range
>   if the page start >= the range start.
>   In our case, the page start < the range start, since for subpage cases
>   we can have delalloc ranges inside the folio but not covering the
>   folio.
> 
>   So it doesn't skip the page range at all.
>   This means all the ordered extents, both [1568K, 1584K) and
>   [1584K, 1596K) will be marked as IOERR.
> 
>   And those two ordered extents have no more pending ios, it is marked
>   finished, and *QUEUED* to be deleted from the io tree.
> 
> - extent_writepage() do error cleanup
>   Call btrfs_mark_ordered_io_finished() for the range [1536K, 1600K).
> 
>   Although ranges [1568K, 1584K) and [1584K, 1596K) are finished, the
>   deletion from io tree is async, it may or may not happen at this
>   timing.
> 
>   If the ranges are not yet removed, we will do double cleaning on those
>   ranges, triggers the above ordered extent warnings.
> 
> In theory there are other bugs, like the cleanup in extent_writepage()
> can cause double accounting on ranges that are submitted async
> (compression for example).
> 
> But that's much harder to trigger because normally we do not mix regular
> and compression delalloc ranges.
> 
> [FIX]
> The folio range split is already buggy and not subpage compatible, it's
> introduced a long time ago where subpage support is not even considered.
> 
> So instead of splitting the ordered extents cleanup into the folio range
> and out of folio range, do all the cleanup inside writepage_delalloc().
> 
> - Pass @NULL as locked_folio for btrfs_cleanup_ordered_extents() in
>   btrfs_run_delalloc_range()
> 
> - Skip the btrfs_cleanup_ordered_extents() if writepage_delalloc()
>   failed
> 
>   So all ordered extents are only cleaned up by
>   btrfs_run_delalloc_range().
> 
> - Handle the ranges that already have ordered extents allocated
>   If part of the folio already has ordered extent allocated, and
>   btrfs_run_delalloc_range() failed, we also need to cleanup that range.
> 
> Now we have a concentrated error handling for ordered extents during
> btrfs_run_delalloc_range().

Great investigation and writeup, thanks!

The explanation and fix both make sense to me. I traced the change in
error handling and I see how we are avoiding double ending the
ordered_extent. So with that said, feel free to add:
Reviewed-by: Boris Burkov <boris@bur.io>

However, I would like to request one thing, if I may.
While this is all still relatively fresh in your mind, could you please
document the intended behavior of the various functions (at least the
ones you modify/reason about) with regards to:
- cleanup state of the various objects involved like ordered_extents
  and subpages (e.g., writepage_delalloc cleans up ordered extents, so
  callers should not, etc.)
- return values (e.g., when precisely does btrfs_run_delalloc_range
  return >= 0 ?)
- anything else you think would be helpful for reasoning about these
  functions in an abstract way while you are at it.

That request is obviously optional for landing these fixes, but I really
think it would help if we went through the bother every time we
deciphered one of these undocumented paths. A restatement of your best
understanding of the behavior now will really pay off for the next
person reading this code :)

Thanks,
Boris

> 
> Cc: stable@vger.kernel.org # 5.15+
> Fixes: d1051d6ebf8e ("btrfs: Fix error handling in btrfs_cleanup_ordered_extents")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c | 37 ++++++++++++++++++++++++++++++++-----
>  fs/btrfs/inode.c     |  2 +-
>  2 files changed, 33 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 9725ff7f274d..417c710c55ca 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1167,6 +1167,12 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
>  	 * last delalloc end.
>  	 */
>  	u64 last_delalloc_end = 0;
> +	/*
> +	 * Save the last successfully ran delalloc range end (exclusive).
> +	 * This is for error handling to avoid ranges with ordered extent created
> +	 * but no IO will be submitted due to error.
> +	 */

nit: last_finished what? I feel this name or comment could use some
extra work.

> +	u64 last_finished = page_start;
>  	u64 delalloc_start = page_start;
>  	u64 delalloc_end = page_end;
>  	u64 delalloc_to_write = 0;
> @@ -1235,11 +1241,19 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
>  			found_len = last_delalloc_end + 1 - found_start;
>  
>  		if (ret >= 0) {
> +			/*
> +			 * Some delalloc range may be created by previous folios.
> +			 * Thus we still need to clean those range up during error
> +			 * handling.
> +			 */
> +			last_finished = found_start;
>  			/* No errors hit so far, run the current delalloc range. */
>  			ret = btrfs_run_delalloc_range(inode, folio,
>  						       found_start,
>  						       found_start + found_len - 1,
>  						       wbc);
> +			if (ret >= 0)
> +				last_finished = found_start + found_len;
>  		} else {
>  			/*
>  			 * We've hit an error during previous delalloc range,
> @@ -1274,8 +1288,21 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
>  
>  		delalloc_start = found_start + found_len;
>  	}
> -	if (ret < 0)
> +	/*
> +	 * It's possible we have some ordered extents created before we hit
> +	 * an error, cleanup non-async successfully created delalloc ranges.
> +	 */
> +	if (unlikely(ret < 0)) {
> +		unsigned int bitmap_size = min(
> +			(last_finished - page_start) >> fs_info->sectorsize_bits,
> +			fs_info->sectors_per_page);
> +
> +		for_each_set_bit(bit, &bio_ctrl->submit_bitmap, bitmap_size)
> +			btrfs_mark_ordered_io_finished(inode, folio,
> +				page_start + (bit << fs_info->sectorsize_bits),
> +				fs_info->sectorsize, false);
>  		return ret;
> +	}
>  out:
>  	if (last_delalloc_end)
>  		delalloc_end = last_delalloc_end;
> @@ -1509,13 +1536,13 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
>  
>  	bio_ctrl->wbc->nr_to_write--;
>  
> -done:
> -	if (ret) {
> +	if (ret)
>  		btrfs_mark_ordered_io_finished(BTRFS_I(inode), folio,
>  					       page_start, PAGE_SIZE, !ret);
> -		mapping_set_error(folio->mapping, ret);
> -	}
>  
> +done:
> +	if (ret < 0)
> +		mapping_set_error(folio->mapping, ret);
>  	/*
>  	 * Only unlock ranges that are submitted. As there can be some async
>  	 * submitted ranges inside the folio.
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index c4997200dbb2..d41bb47d59fb 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2305,7 +2305,7 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct folio *locked_fol
>  
>  out:
>  	if (ret < 0)
> -		btrfs_cleanup_ordered_extents(inode, locked_folio, start,
> +		btrfs_cleanup_ordered_extents(inode, NULL, start,
>  					      end - start + 1);
>  	return ret;
>  }
> -- 
> 2.47.1
> 

