Return-Path: <linux-btrfs+bounces-10882-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B278A08371
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 00:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A02F4188B5D8
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 23:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD382063C0;
	Thu,  9 Jan 2025 23:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="rJv8zJ1t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eR+q8o92"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA840205E30;
	Thu,  9 Jan 2025 23:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736465192; cv=none; b=pDhR07yuLdr/cPbwrCmm7xa85v27E+jbvR2jMuBS+IHTT+lEqDvKh4azxk9kPC+3Lu3vt6iC9oOqycd5M/Xkaa1NMjvPV1lJhroz4FatIRuoa0d8Qgky9PqDHqficg5TAAoWe94Pn5gWXPy+AdMa6PPrHkSxypp36sV8eUydY1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736465192; c=relaxed/simple;
	bh=exPMReI/b0TZ/aBCXQYKUc1kHYKCj7hDOJB4p7sUi4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ft9C0jrUUb8KboxHV6RUNSug1Xrbq4BO3hcFRhujB5C3no42+g605y6QLahPihaNfNZoCky94WDNJASou+qAheH6fg+58neQMnxFPgJdYiXHGEcmd+oNUI5Cf4tU4ER4Wum7OedVMSSJhFoLVBiYoErqdaQNS4CNRNNjvjzOkJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=rJv8zJ1t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eR+q8o92; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B82DF25401B8;
	Thu,  9 Jan 2025 18:26:28 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 09 Jan 2025 18:26:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1736465188; x=1736551588; bh=WJy4ycPBIF
	vy2d1Ny3Hf3i/FlN7fDDpwKN3+dlifEYU=; b=rJv8zJ1tROpHxUb6q1m+AIu5LF
	lTmX86Riyjuw1wtArUYda9/C2MVzJMYiLWN2CxhwKL42senxxGsnVJzG6AmXDQC5
	tAAnpaOJxiyRWPnaFg1l31Q0Aec2/+dKx8pC8UEJoMUf9XgB57171ACb17ft0NWy
	3tVF+66GYAZIwhfuWoAhb7mDKBFDNHxRGaa/PedrGdo6ycUA81iUeCBPJ6SGEQqN
	W3beDhmotupqPEdwY8A3E8vatkzr7QJVtv/Usu7qY/sV5Dfbt6PHR+h2Z7o/VOOr
	GuD+2/Yvcswhmj8ISSCdMz0+vRtQ7c3Pl6ewqAnUT95ysT+V/FdcRZyAJ0Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736465188; x=1736551588; bh=WJy4ycPBIFvy2d1Ny3Hf3i/FlN7fDDpwKN3
	+dlifEYU=; b=eR+q8o92j3c/z3Hhl5BSV1Te2/GKeSm3FMt3BbUUbol708QKLOm
	tQheUd+4D4VVZHx4lGr6mWhY1lJ29O/8yenryH6YoXX23GhXdDsdPQqhH+yybV9f
	sxBBHl5h4x3pePbtlIPELBdj5BMJJYabnyrcgKCjnJWyCdG7Wmf5drymyzU6iblO
	1aA10IxmA9mE3Lv9GFs9JRIdvizixBptenenl1P9PCowcL1RfGu4zzBeQDzARXFj
	kxEqGZAElAUv410wwgXTMnF3gYfLdWqCCwoyMdmYfClMUB3xZXLOuHxejBByiad5
	lzZDJQu8IK/74K7SbnCDw1w+fkXTTYO3QqQ==
X-ME-Sender: <xms:JFuAZ9C61izSBDZ1rIPtVKPBZmZHx74yMpS_93qqtV2WqDoOxYzU8Q>
    <xme:JFuAZ7iG-uIz023LdiHqLo5xcwU13Fz_U3p3iqVh5XMw_XwEF3fJAOi6TJDyNFJ96
    iVw7W_E9EN2ykYBSw0>
X-ME-Received: <xmr:JFuAZ4kEtXJ6wip9gcjWN0Qd4Gxd9NBuc9rGjxn-9chskhdoLVVseOQS50swjfVkJrQuzL0OfVEI5p3fQaonmogLGuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegjedgtdekucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:JFuAZ3xwVbphcVmTjEZgnNPwHAoRxnHJKKAEwCyXiVtYv1ZCdrPw_Q>
    <xmx:JFuAZyQRBJBNasqJ6l9NiNdC2HWe7ZOuqyhrn4hHZpiRz715Waj-Ng>
    <xmx:JFuAZ6ZAOH8HYY72F2qZok3bKShQrlbLJGCe_CgVKxhkE5S5MkXsLg>
    <xmx:JFuAZzQ8rrR4fIpCS--P_NAZyFkqVY0X1ybFIXj0p5wfu89oqXTvaA>
    <xmx:JFuAZwfVDa5bHs57D4K4Glo71OQayOoye_wQ-VFwM8zkmIkviIyi4QEY>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jan 2025 18:26:27 -0500 (EST)
Date: Thu, 9 Jan 2025 15:26:59 -0800
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 5/9] btrfs: do proper folio cleanup when
 run_delalloc_nocow() failed
Message-ID: <20250109232659.GB2153241@zen.localdomain>
References: <cover.1733983488.git.wqu@suse.com>
 <d3a8799772abd1efd309a61f695a1774a742bfb9.1733983488.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3a8799772abd1efd309a61f695a1774a742bfb9.1733983488.git.wqu@suse.com>

On Thu, Dec 12, 2024 at 04:43:59PM +1030, Qu Wenruo wrote:
> [BUG]
> With CONFIG_DEBUG_VM set, test case generic/476 has some chance to crash
> with the following VM_BUG_ON_FOLIO():
> 
>  BTRFS error (device dm-3): cow_file_range failed, start 1146880 end 1253375 len 106496 ret -28
>  BTRFS error (device dm-3): run_delalloc_nocow failed, start 1146880 end 1253375 len 106496 ret -28
>  page: refcount:4 mapcount:0 mapping:00000000592787cc index:0x12 pfn:0x10664
>  aops:btrfs_aops [btrfs] ino:101 dentry name(?):"f1774"
>  flags: 0x2fffff80004028(uptodate|lru|private|node=0|zone=2|lastcpupid=0xfffff)
>  page dumped because: VM_BUG_ON_FOLIO(!folio_test_locked(folio))
>  ------------[ cut here ]------------
>  kernel BUG at mm/page-writeback.c:2992!
>  Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
>  CPU: 2 UID: 0 PID: 3943513 Comm: kworker/u24:15 Tainted: G           OE      6.12.0-rc7-custom+ #87
>  Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
>  Hardware name: QEMU KVM Virtual Machine, BIOS unknown 2/2/2022
>  Workqueue: events_unbound btrfs_async_reclaim_data_space [btrfs]
>  pc : folio_clear_dirty_for_io+0x128/0x258
>  lr : folio_clear_dirty_for_io+0x128/0x258
>  Call trace:
>   folio_clear_dirty_for_io+0x128/0x258
>   btrfs_folio_clamp_clear_dirty+0x80/0xd0 [btrfs]
>   __process_folios_contig+0x154/0x268 [btrfs]
>   extent_clear_unlock_delalloc+0x5c/0x80 [btrfs]
>   run_delalloc_nocow+0x5f8/0x760 [btrfs]
>   btrfs_run_delalloc_range+0xa8/0x220 [btrfs]
>   writepage_delalloc+0x230/0x4c8 [btrfs]
>   extent_writepage+0xb8/0x358 [btrfs]
>   extent_write_cache_pages+0x21c/0x4e8 [btrfs]
>   btrfs_writepages+0x94/0x150 [btrfs]
>   do_writepages+0x74/0x190
>   filemap_fdatawrite_wbc+0x88/0xc8
>   start_delalloc_inodes+0x178/0x3a8 [btrfs]
>   btrfs_start_delalloc_roots+0x174/0x280 [btrfs]
>   shrink_delalloc+0x114/0x280 [btrfs]
>   flush_space+0x250/0x2f8 [btrfs]
>   btrfs_async_reclaim_data_space+0x180/0x228 [btrfs]
>   process_one_work+0x164/0x408
>   worker_thread+0x25c/0x388
>   kthread+0x100/0x118
>   ret_from_fork+0x10/0x20
>  Code: 910a8021 a90363f7 a9046bf9 94012379 (d4210000)
>  ---[ end trace 0000000000000000 ]---
> 
> [CAUSE]
> The first two lines of extra debug messages show the problem is caused
> by the error handling of run_delalloc_nocow().
> 
> E.g. we have the following dirtied range (4K blocksize 4K page size):
> 
>     0                 16K                  32K
>     |//////////////////////////////////////|
>     |  Pre-allocated  |
> 
> And the range [0, 16K) has a preallocated extent.
> 
> - Enter run_delalloc_nocow() for range [0, 16K)
>   Which found range [0, 16K) is preallocated, can do the proper NOCOW
>   write.
> 
> - Enter fallback_to_fow() for range [16K, 32K)
>   Since the range [16K, 32K) is not backed by preallocated extent, we
>   have to go COW.
> 
> - cow_file_range() failed for range [16K, 32K)
>   So cow_file_range() will do the clean up by clearing folio dirty,
>   unlock the folios.
> 
>   Now the folios in range [16K, 32K) is unlocked.
> 
> - Enter extent_clear_unlock_delalloc() from run_delalloc_nocow()
>   Which is called with PAGE_START_WRITEBACK to start page writeback.
>   But folios can only be marked writeback when it's properly locked,
>   thus this triggered the VM_BUG_ON_FOLIO().
> 
> Furthermore there is another hidden but common bug that
> run_delalloc_nocow() is not clearing the folio dirty flags in its error
> handling path.
> This is the common bug shared between run_delalloc_nocow() and
> cow_file_range().
> 
> [FIX]
> - Clear folio dirty for range [@start, @cur_offset)
>   Introduce a helper, cleanup_dirty_folios(), which
>   will find and lock the folio in the range, clear the dirty flag and
>   start/end the writeback, with the extra handling for the
>   @locked_folio.
> 
> - Introduce a helper to record the last failed COW range end
>   This is to trace which range we should skip, to avoid double
>   unlocking.
> 
> - Skip the failed COW range for the error handling
> 
> Cc: stable@vger.kernel.org

Reviewed-by: Boris Burkov <boris@bur.io>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/inode.c | 93 ++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 86 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 19c88b7d0363..bae8aceb3eae 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1961,6 +1961,48 @@ static int can_nocow_file_extent(struct btrfs_path *path,
>  	return ret < 0 ? ret : can_nocow;
>  }
>  

I like this function. Can you add a simple doc with pre and post
conditions please?

> +static void cleanup_dirty_folios(struct btrfs_inode *inode,
> +				 struct folio *locked_folio,
> +				 u64 start, u64 end, int error)
> +{
> +	struct btrfs_fs_info *fs_info = inode->root->fs_info;
> +	struct address_space *mapping = inode->vfs_inode.i_mapping;
> +	pgoff_t start_index = start >> PAGE_SHIFT;
> +	pgoff_t end_index = end >> PAGE_SHIFT;
> +	u32 len;
> +
> +	ASSERT(end + 1 - start < U32_MAX);
> +	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
> +	       IS_ALIGNED(end + 1, fs_info->sectorsize));
> +	len = end + 1 - start;
> +
> +	/*
> +	 * Handle the locked folio first.
> +	 * btrfs_folio_clamp_*() helpers can handle range out of the folio case.
> +	 */
> +	btrfs_folio_clamp_clear_dirty(fs_info, locked_folio, start, len);
> +	btrfs_folio_clamp_set_writeback(fs_info, locked_folio, start, len);
> +	btrfs_folio_clamp_clear_writeback(fs_info, locked_folio, start, len);

Could this clear dirty; set writeback; clear writeback sequence benefit
from a good name and a helper function too?

> +
> +	for (pgoff_t index = start_index; index <= end_index; index++) {
> +		struct folio *folio;
> +
> +		/* Already handled at the beginning. */
> +		if (index == locked_folio->index)
> +			continue;
> +		folio = __filemap_get_folio(mapping, index, FGP_LOCK, GFP_NOFS);
> +		/* Cache already dropped, no need to do any cleanup. */
> +		if (IS_ERR(folio))
> +			continue;
> +		btrfs_folio_clamp_clear_dirty(fs_info, folio, start, len);
> +		btrfs_folio_clamp_set_writeback(fs_info, folio, start, len);
> +		btrfs_folio_clamp_clear_writeback(fs_info, folio, start, len);
> +		folio_unlock(folio);
> +		folio_put(folio);
> +	}
> +	mapping_set_error(mapping, error);
> +}
> +
>  /*
>   * when nowcow writeback call back.  This checks for snapshots or COW copies
>   * of the extents that exist in the file, and COWs the file as required.
> @@ -1976,6 +2018,11 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
>  	struct btrfs_root *root = inode->root;
>  	struct btrfs_path *path;
>  	u64 cow_start = (u64)-1;
> +	/*
> +	 * If not 0, represents the inclusive end of the last fallback_to_cow()
> +	 * range. Only for error handling.
> +	 */
> +	u64 cow_end = 0;
>  	u64 cur_offset = start;
>  	int ret;
>  	bool check_prev = true;
> @@ -2136,6 +2183,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
>  					      found_key.offset - 1);
>  			cow_start = (u64)-1;
>  			if (ret) {
> +				cow_end = found_key.offset - 1;
>  				btrfs_dec_nocow_writers(nocow_bg);
>  				goto error;
>  			}
> @@ -2209,11 +2257,12 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
>  		cow_start = cur_offset;
>  
>  	if (cow_start != (u64)-1) {
> -		cur_offset = end;
>  		ret = fallback_to_cow(inode, locked_folio, cow_start, end);
>  		cow_start = (u64)-1;
> -		if (ret)
> +		if (ret) {
> +			cow_end = end;
>  			goto error;
> +		}
>  	}
>  
>  	btrfs_free_path(path);
> @@ -2221,12 +2270,42 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
>  
>  error:
>  	/*
> -	 * If an error happened while a COW region is outstanding, cur_offset
> -	 * needs to be reset to cow_start to ensure the COW region is unlocked
> -	 * as well.
> +	 * There are several error cases:
> +	 *
> +	 * 1) Failed without falling back to COW
> +	 *    start         cur_start              end
> +	 *    |/////////////|                      |
> +	 *
> +	 *    For range [start, cur_start) the folios are already unlocked (except
> +	 *    @locked_folio), EXTENT_DELALLOC already removed.
> +	 *    Only need to clear the dirty flag as they will never be submitted.
> +	 *    Ordered extent and extent maps are handled by
> +	 *    btrfs_mark_ordered_io_finished() inside run_delalloc_range().
> +	 *
> +	 * 2) Failed with error from fallback_to_cow()
> +	 *    start         cur_start   cow_end    end
> +	 *    |/////////////|-----------|          |
> +	 *
> +	 *    For range [start, cur_start) it's the same as case 1).
> +	 *    But for range [cur_start, cow_end), the folios have dirty flag
> +	 *    cleared and unlocked, EXTENT_DEALLLOC cleared.
> +	 *    There may or may not be any ordered extents/extent maps allocated.
> +	 *
> +	 *    We should not call extent_clear_unlock_delalloc() on range [cur_start,
> +	 *    cow_end), as the folios are already unlocked.
> +	 *

I think it would be helpful to include cur_offset in your drawings.

> +	 * So clear the folio dirty flags for [start, cur_offset) first.
>  	 */
> -	if (cow_start != (u64)-1)
> -		cur_offset = cow_start;
> +	if (cur_offset > start)
> +		cleanup_dirty_folios(inode, locked_folio, start, cur_offset - 1, ret);
> +
> +	/*
> +	 * If an error happened while a COW region is outstanding, cur_offset
> +	 * needs to be reset to @cow_end + 1 to skip the COW range, as
> +	 * cow_file_range() will do the proper cleanup at error.
> +	 */
> +	if (cow_end)
> +		cur_offset = cow_end + 1;
>  
>  	/*
>  	 * We need to lock the extent here because we're clearing DELALLOC and
> -- 
> 2.47.1
> 

