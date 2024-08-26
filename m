Return-Path: <linux-btrfs+bounces-7502-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D6595F3E2
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 16:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75B9C1F2285B
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 14:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B86418BC01;
	Mon, 26 Aug 2024 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="CS3BIAt6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9DE188915
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2024 14:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724682611; cv=none; b=Cat7nrYf1O1Vh3XRbYv/Plz6vY4BvIWSobZ2DZ1U8SHiOgC+bA75g0SAzlU6GCKqAe8PKsc43kwPaYthZgp8HjdMYcFq5+OaOdpmGm/d30x1gUMPQ8dEy4EQQzrgeHbjntW6sumRzCMCSM/Gl8uBmD+veS2qegzfSQeL1J3vksc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724682611; c=relaxed/simple;
	bh=9T7Qq/TPtIdXmRgEeHsDL5zpB4HTfs9nDcnYvtDjP5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N69Z0vn9vowjbzWQSNW0MuW3yj3i22mjPZW0Uub/zPKjDQd9tJsEnr9KhDhuf/MYP6x80smUIGjyU3VPsWCbdxg+YJKUe9roLVFc6YZI8vLe/fuBqrYzquKynToQe7UwBQ/mLIFZc+XhIklP99NzLDd0FeiotsrBMKeROM7TAZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=CS3BIAt6; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-70942ebcc29so4041615a34.0
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2024 07:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724682608; x=1725287408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xECHmxlKJRkA3/PhWU3m3ixxQhnDal34dRju/8Em3Ps=;
        b=CS3BIAt66laOYqVlsgHB0Y7Uh6g8VvIQMSfIm+P8FvOd+nwk+khIxxXUV/9/cw6qKw
         nDGw3DOIPbobBHQrB5Qkj5UE29pkNcZp0zgQRf0CV/K9vBKzxUbyskws5ztPhitkAzJc
         Dz4GdCkZr6NHQaxI7j4f8duNkHtAc59z7JxhzHWZYoIjTyu4gFntnkb7aGBwPuiQASP4
         PIEwmAFgJXWLQAHPxFVAgcmnq5R4LePPPqANJD15D5cn/PPAybqg3fe8Zw7OpxxCkYBf
         w1BvZOfFqJePpHakeavaTajeYY7oc0sbQMBzpot2OuJdqr9roZ4SMeKVRwQj7XgH+uvM
         uRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724682608; x=1725287408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xECHmxlKJRkA3/PhWU3m3ixxQhnDal34dRju/8Em3Ps=;
        b=tIWagSsTdaxjdodwbwK+3QnjiwPlD7YaOPBYL/41+Mq0y0/ugh0AlHHDa0ZIC6Zz+E
         edrUH+5WyZHnna9hVqgmIR/TjF5D/6gBFEeR84lwVvf8Dxm/9RnpeJ0ihIdbTw8DIfSO
         jaERIiTFyxQACPHoybqCiVvRvbHktDW6f0II5sigUiA8aU7ER+dV0QLwkEHbQQ9u/SL6
         YOCQa1iirqQD4cNo0rJ+kDc5o3OEHuIiYS9a27U8d2oAlr68Q2N6e2N1n3y7+y+SLXCm
         14XKwWU+TK4CNVhe9fc0DIoPiyLoTBG2U6zO1mg+jh9UjWngsSqPh4Ub53KbBRIk1te+
         VJTg==
X-Gm-Message-State: AOJu0YzEKo8Q/LPZgPz1z8vPVc1IpkBaoaXidcI63Ijv9FhEE+0y2hMf
	52R+U2zBTwpVv84gmsxFSew2uUZAT0XyVc0v/RXWFCXnetn5kv1+SmFgqQATYZZ3/5d3mSbEkij
	h
X-Google-Smtp-Source: AGHT+IGbiK1pW7+j9ZgtMhCYzXqHhstrQEw8/K2Sme/4i7HSd0ozJri3OPQe59EiRL56yENNT9vQpg==
X-Received: by 2002:a05:6808:1717:b0:3d9:3649:906f with SMTP id 5614622812f47-3de2a8ecb27mr12717239b6e.37.1724682608061;
        Mon, 26 Aug 2024 07:30:08 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fe19a4fesm43635291cf.67.2024.08.26.07.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 07:30:07 -0700 (PDT)
Date: Mon, 26 Aug 2024 10:30:06 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH v4] btrfs: fix a use-after-free bug when hitting errors
 inside btrfs_submit_chunk()
Message-ID: <20240826143006.GC2393039@perftesting>
References: <f4f916352ddf3f80048567ec7d8cc64cb388dc09.1724493430.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4f916352ddf3f80048567ec7d8cc64cb388dc09.1724493430.git.wqu@suse.com>

On Sat, Aug 24, 2024 at 07:28:23PM +0930, Qu Wenruo wrote:
> [BUG]
> There is an internal report that KASAN is reporting use-after-free, with
> the following backtrace:
> 
>  ==================================================================
>  BUG: KASAN: slab-use-after-free in btrfs_check_read_bio+0xa68/0xb70 [btrfs]
>  Read of size 4 at addr ffff8881117cec28 by task kworker/u16:2/45
>  CPU: 1 UID: 0 PID: 45 Comm: kworker/u16:2 Not tainted 6.11.0-rc2-next-20240805-default+ #76
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
>  Workqueue: btrfs-endio btrfs_end_bio_work [btrfs]
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x61/0x80
>   print_address_description.constprop.0+0x5e/0x2f0
>   print_report+0x118/0x216
>   kasan_report+0x11d/0x1f0
>   btrfs_check_read_bio+0xa68/0xb70 [btrfs]
>   process_one_work+0xce0/0x12a0
>   worker_thread+0x717/0x1250
>   kthread+0x2e3/0x3c0
>   ret_from_fork+0x2d/0x70
>   ret_from_fork_asm+0x11/0x20
>   </TASK>
> 
>  Allocated by task 20917:
>   kasan_save_stack+0x37/0x60
>   kasan_save_track+0x10/0x30
>   __kasan_slab_alloc+0x7d/0x80
>   kmem_cache_alloc_noprof+0x16e/0x3e0
>   mempool_alloc_noprof+0x12e/0x310
>   bio_alloc_bioset+0x3f0/0x7a0
>   btrfs_bio_alloc+0x2e/0x50 [btrfs]
>   submit_extent_page+0x4d1/0xdb0 [btrfs]
>   btrfs_do_readpage+0x8b4/0x12a0 [btrfs]
>   btrfs_readahead+0x29a/0x430 [btrfs]
>   read_pages+0x1a7/0xc60
>   page_cache_ra_unbounded+0x2ad/0x560
>   filemap_get_pages+0x629/0xa20
>   filemap_read+0x335/0xbf0
>   vfs_read+0x790/0xcb0
>   ksys_read+0xfd/0x1d0
>   do_syscall_64+0x6d/0x140
>   entry_SYSCALL_64_after_hwframe+0x4b/0x53
> 
>  Freed by task 20917:
>   kasan_save_stack+0x37/0x60
>   kasan_save_track+0x10/0x30
>   kasan_save_free_info+0x37/0x50
>   __kasan_slab_free+0x4b/0x60
>   kmem_cache_free+0x214/0x5d0
>   bio_free+0xed/0x180
>   end_bbio_data_read+0x1cc/0x580 [btrfs]
>   btrfs_submit_chunk+0x98d/0x1880 [btrfs]
>   btrfs_submit_bio+0x33/0x70 [btrfs]
>   submit_one_bio+0xd4/0x130 [btrfs]
>   submit_extent_page+0x3ea/0xdb0 [btrfs]
>   btrfs_do_readpage+0x8b4/0x12a0 [btrfs]
>   btrfs_readahead+0x29a/0x430 [btrfs]
>   read_pages+0x1a7/0xc60
>   page_cache_ra_unbounded+0x2ad/0x560
>   filemap_get_pages+0x629/0xa20
>   filemap_read+0x335/0xbf0
>   vfs_read+0x790/0xcb0
>   ksys_read+0xfd/0x1d0
>   do_syscall_64+0x6d/0x140
>   entry_SYSCALL_64_after_hwframe+0x4b/0x53
> 
> [CAUSE]
> Although I can not reproduce the error, the report itself is good enough
> to pin down the cause.
> 
> The call trace is the regular endio workqueue context, but the
> free-by-task trace is showing that during btrfs_submit_chunk() we
> already hit a critical error, and is calling btrfs_bio_end_io() to error
> out.
> And the original endio function called bio_put() to free the whole bio.
> 
> This means a double freeing thus causing use-after-free, e.g:
> 
> 1. Enter btrfs_submit_bio() with a read bio
>    The read bio length is 128K, crossing two 64K stripes.
> 
> 2. The first run of btrfs_submit_chunk()
> 
> 2.1 Call btrfs_map_block(), which returns 64K
> 2.2 Call btrfs_split_bio()
>     Now there are two bios, one referring to the first 64K, the other
>     referring to the second 64K.
> 2.3 The first half is submitted.
> 
> 3. The second run of btrfs_submit_chunk()
> 
> 3.1 Call btrfs_map_block(), which by somehow failed
>     Now we call btrfs_bio_end_io() to handle the error
> 
> 3.2 btrfs_bio_end_io() calls the original endio function
>     Which is end_bbio_data_read(), and it calls bio_put() for the
>     original bio.
> 
>     Now the original bio is freed.
> 
> 4. The submitted first 64K bio finished
>    Now we call into btrfs_check_read_bio() and tries to advance the bio
>    iter.
>    But since the original bio (thus its iter) is already freed, we
>    trigger the above use-after free.
> 
>    And even if the memory is not poisoned/corrupted, we will later call
>    the original endio function, causing a double freeing.
> 
> [FIX]
> Instead of calling btrfs_bio_end_io(), call btrfs_orig_bbio_end_io(),
> which has the extra check on split bios and do the proper refcounting
> for cloned bios.
> 
> Furthermore there is already one extra btrfs_cleanup_bio() call, but
> that is duplicated to btrfs_orig_bbio_end_io() call, so remove that
> tag completely.
> 
> Reported-by: David Sterba <dsterba@suse.cz>
> Fixes: 852eee62d31a ("btrfs: allow btrfs_submit_bio to split bios")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

