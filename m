Return-Path: <linux-btrfs+bounces-15841-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 170BBB1AAFC
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 00:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D60A018A0D6E
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Aug 2025 22:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B32228D849;
	Mon,  4 Aug 2025 22:37:08 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out28-82.mail.aliyun.com (out28-82.mail.aliyun.com [115.124.28.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07E838FA6
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Aug 2025 22:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754347027; cv=none; b=GssXe2H3t7o0NtFYjzrIT/EkyByAqKKH++We9MTy/b9jRpOZUIAMEFBuRebp0YOStmQgYSkB93tUrc/uA2ZDfGGji62N5dWetMJVhLN1yb3hKMKNjx/RN0BsxL6LphlgeeruZA4HmPvfBN7z/1+Yk+EDypGBjWRTgJ88R8XAV5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754347027; c=relaxed/simple;
	bh=WOugLUZ+jC+ZWc9CocALlel6a2xfjgzjrqvA/oqIVlY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:Message-Id:
	 MIME-Version:Content-Type; b=jjdhfccPK7IFpbHi1FazMW3XhDiPwxmPeMA62uZ1lsJd/H9/HeJwXOxdPJRyVzYP11VadPNNT7l3DzJXLmze48k/LGG01E1XbjqpQV2YHdsFqw69fnD100eN1z7uPpIt1nDmhXj6VI9g/Zvmmam3wZa/653N1f5XM0gPaSymB1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=115.124.28.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.e6Tzen4_1754347018 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 05 Aug 2025 06:36:58 +0800
Date: Tue, 05 Aug 2025 06:36:59 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v2 4/4] btrfs: keep folios locked inside run_delalloc_nocow()
Cc: linux-btrfs@vger.kernel.org
In-Reply-To: <a5a3c2f37bbe0b32ffaa8a15a85515ab9f173a28.1753687685.git.wqu@suse.com>
References: <cover.1753687685.git.wqu@suse.com> <a5a3c2f37bbe0b32ffaa8a15a85515ab9f173a28.1753687685.git.wqu@suse.com>
Message-Id: <20250805063658.ED67.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.08 [en]

Hi,

> [BUG]
> There is a very low chance that DEBUG_WARN() inside
> btrfs_writepage_cow_fixup() can be triggered when
> CONFIG_BTRFS_EXPERIMENTAL is enabled.
> 
> This only happens after run_delalloc_nocow() failed.
> 
> Unfortunately I haven't hit it for a while thus no real world dmesg for
> now.
> 
> [CAUSE]
> There is a race window where after run_delalloc_nocow() failed, error
> handling can race with writeback thread.
> 
> Before we hit run_delalloc_nocow(), there is an inode with the following
> dirty pages: (4K page size, 4K block size, no large folio)
> 
>   0         4K          8K          12K          16K
>   |/////////|///////////|///////////|////////////|
> 
> The inode also have NODATACOW flag, and the above dirty range will go
> through different extents during run_delalloc_range():
> 
>   0         4K          8K          12K          16K
>   |  NOCOW  |    COW    |    COW    |   NOCOW    |
> 
> The race happen like this:
> 
>     writeback thread A            |        writeback thread B
> ----------------------------------+--------------------------------------
> Writeback for folio 0             |
> run_delalloc_nocow()              |
> |- nocow_one_range()              |
> |  For range [0, 4K), ret = 0     |
> |                                 |
> |- fallback_to_cow()              |
> |  For range [4K, 8K), ret = 0    |
> |  Folio 4K *UNLOCKED*            |
> |                                 | Writeback for folio 4K
> |- fallback_to_cow()              | extent_writepage()
> |  For range [8K, 12K), failure   | |- writepage_delalloc()
> |				  | |
> |- btrfs_cleanup_ordered_extents()| |
>    |- btrfs_folio_clear_ordered() | |
>    |  Folio 0 still locked, safe  | |
>    |                              | |  Ordered extent already allocated.
>    |                              | |  Nothing to do.
>    |                              | |- extent_writepage_io()
>    |                              |    |- btrfs_writepage_cow_fixup()
>    |- btrfs_folio_clear_ordered() |    |
>       Folio 4K hold by thread B,  |    |
>       UNSAFE!                     |    |- btrfs_test_ordered()
>                                   |    |  Cleared by thread A,
> 				  |    |
>                                   |    |- DEBUG_WARN();
> 
> This is only possible after run_delalloc_nocow() failure, as
> cow_file_range() will keep all folios and io tree range locked, until
> everything is finished or after error handling.
> 
> The root cause is we allow fallback_to_cow() and nocow_one_range() to
> unlock the folios after a successful run, so that during error handling
> we're no longer safe to use btrfs_cleanup_ordered_extents() as the
> folios are already unlocked.
> 
> [FIX]
> - Make fallback_to_cow() and nocow_one_range() to keep folios locked
>   after a successful run
> 
>   For fallback_to_cow() we can pass COW_FILE_RANGE_KEEP_LOCKED flag
>   into cow_file_range().
> 
>   For nocow_one_range() we have to remove the PAGE_UNLOCK flag from
>   extent_clear_unlock_delalloc().
> 
> - Unlock folios if everything is fine in run_delalloc_nocow()
> 
> - Use extent_clear_unlock_delalloc() to handle range [@start,
>   @cur_offset) inside run_delalloc_nocow()
>   Since folios are still locked, we do not need
>   cleanup_dirty_folios() to do the cleanup.
> 
>   extent_clear_unlock_delalloc() with "PAGE_START_WRIBACK |
>   PAGE_END_WRITEBACK" will clear the dirty flags.
> 
> - Remove cleanup_dirty_folios()
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

We need a 'Fix:' tag for kernel stable branch.

It seems that this problem does not happen (or less frequency) on  kernel
6.6.y/6.1.y.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2025/08/05



