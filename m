Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A488230B4F
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jul 2020 15:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbgG1NTw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jul 2020 09:19:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:56252 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729673AbgG1NTw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jul 2020 09:19:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 30191B680;
        Tue, 28 Jul 2020 13:20:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1BC8DDA701; Tue, 28 Jul 2020 15:19:20 +0200 (CEST)
Date:   Tue, 28 Jul 2020 15:19:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Luciano Chavez <chavez@us.ibm.com>
Subject: Re: [PATCH] btrfs: inode: Fix NULL pointer dereference if inode
 doesn't need compression
Message-ID: <20200728131920.GU3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Luciano Chavez <chavez@us.ibm.com>
References: <20200728083926.19518-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728083926.19518-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 28, 2020 at 04:39:26PM +0800, Qu Wenruo wrote:
> [BUG]
> There is a bug report of NULL pointer dereference caused in
> compress_file_extent():
> 
>   Oops: Kernel access of bad area, sig: 11 [#1]
>   LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=2048 NUMA pSeries
>   Workqueue: btrfs-delalloc btrfs_delalloc_helper [btrfs]
>   NIP [c008000006dd4d34] compress_file_range.constprop.41+0x75c/0x8a0 [btrfs]
>   LR [c008000006dd4d1c] compress_file_range.constprop.41+0x744/0x8a0 [btrfs]
>   Call Trace:
>   [c000000c69093b00] [c008000006dd4d1c] compress_file_range.constprop.41+0x744/0x8a0 [btrfs] (unreliable)
>   [c000000c69093bd0] [c008000006dd4ebc] async_cow_start+0x44/0xa0 [btrfs]
>   [c000000c69093c10] [c008000006e14824] normal_work_helper+0xdc/0x598 [btrfs]
>   [c000000c69093c80] [c0000000001608c0] process_one_work+0x2c0/0x5b0
>   [c000000c69093d10] [c000000000160c38] worker_thread+0x88/0x660
>   [c000000c69093db0] [c00000000016b55c] kthread+0x1ac/0x1c0
>   [c000000c69093e20] [c00000000000b660] ret_from_kernel_thread+0x5c/0x7c
>   ---[ end trace f16954aa20d822f6 ]---
> 
> [CAUSE]
> For the following execution route of compress_file_range(), it's
> possible to hit NULL pointer dereference:
> 
>  compress_file_extent()
>  |- pages = NULL;
>  |- start = async_chunk->start = 0;
>  |- end = async_chunk = 4095;
>  |- nr_pages = 1;
>  |- inode_need_compress() == false; <<< Possible, see later explanation
>  |  Now, we have nr_pages = 1, pages = NULL
>  |- cont:
>  |- 		ret = cow_file_range_inline();
>  |- 		if (ret <= 0) {
>  |-		for (i = 0; i < nr_pages; i++) {
>  |-			WARN_ON(pages[i]->mapping);	<<< Crash
> 
> To enter above call execution branch, we need the following race:
> 
>     Thread 1 (chattr)     |            Thread 2 (writeback)
> --------------------------+------------------------------
>                           | btrfs_run_delalloc_range
>                           | |- inode_need_compress = true
>                           | |- cow_file_range_async()
> btrfs_ioctl_set_flag()    |
> |- binode_flags |=        |
>    BTRFS_INODE_NOCOMPRESS |
>                           | compress_file_range()
>                           | |- inode_need_compress = false
>                           | |- nr_page = 1 while pages = NULL
>                           | |  Then hit the crash
> 
> [FIX]
> This patch will fix it by checking @pages before doing accessing it.
> This patch is only designed as a hot fix and easy to backport.
> 
> More elegant fix may make btrfs only check inode_need_compress() once to
> avoid such race, but that would be another story.

Yeah it gets mistakenly called twice.

> Fixes: 4d3a800ebb12 ("btrfs: merge nr_pages input and output parameter in compress_pages")

How does this patch cause the bug?
