Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 820C7143E21
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2020 14:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAUNjI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jan 2020 08:39:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:45270 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728709AbgAUNjI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jan 2020 08:39:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8C9D9B3AA;
        Tue, 21 Jan 2020 13:39:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EC64CDA738; Tue, 21 Jan 2020 14:38:48 +0100 (CET)
Date:   Tue, 21 Jan 2020 14:38:48 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: do not do delalloc reservation under page lock
Message-ID: <20200121133848.GS3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200117184457.1343-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117184457.1343-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 17, 2020 at 01:44:57PM -0500, Josef Bacik wrote:
> We ran into a deadlock in production with the fixup worker.  The stack
> traces were as follows
> 
> Thread responsible for the writeout, waiting on the page lock
> 
> [<0>] io_schedule+0x12/0x40
> [<0>] __lock_page+0x109/0x1e0
> [<0>] extent_write_cache_pages+0x206/0x360
> [<0>] extent_writepages+0x40/0x60
> [<0>] do_writepages+0x31/0xb0
> [<0>] __writeback_single_inode+0x3d/0x350
> [<0>] writeback_sb_inodes+0x19d/0x3c0
> [<0>] __writeback_inodes_wb+0x5d/0xb0
> [<0>] wb_writeback+0x231/0x2c0
> [<0>] wb_workfn+0x308/0x3c0
> [<0>] process_one_work+0x1e0/0x390
> [<0>] worker_thread+0x2b/0x3c0
> [<0>] kthread+0x113/0x130
> [<0>] ret_from_fork+0x35/0x40
> [<0>] 0xffffffffffffffff
> 
> Thread of the fixup worker who is holding the page lock
> 
> [<0>] start_delalloc_inodes+0x241/0x2d0
> [<0>] btrfs_start_delalloc_roots+0x179/0x230
> [<0>] btrfs_alloc_data_chunk_ondemand+0x11b/0x2e0
> [<0>] btrfs_check_data_free_space+0x53/0xa0
> [<0>] btrfs_delalloc_reserve_space+0x20/0x70
> [<0>] btrfs_writepage_fixup_worker+0x1fc/0x2a0
> [<0>] normal_work_helper+0x11c/0x360
> [<0>] process_one_work+0x1e0/0x390
> [<0>] worker_thread+0x2b/0x3c0
> [<0>] kthread+0x113/0x130
> [<0>] ret_from_fork+0x35/0x40
> [<0>] 0xffffffffffffffff
> 
> Thankfully the stars have to align just right to hit this.  First you
> have to end up in the fixup worker, which is tricky by itself (my
> reproducer does DIO reads into a MMAP'ed region, so not a common
> operation).  Then you have to have less than a page size of free data
> space and 0 unallocated space so you go down the "commit the transaction
> to free up pinned space" path.  This was accomplished by a random
> balance that was running on the host.  Then you get this deadlock.
> 
> I'm still in the process of trying to force the deadlock to happen on
> demand, but I've hit other issues.  I can still trigger the fixup worker
> path itself so this patch has been tested in that regard, so the normal
> case is fine.
> 
> Fixes: 87826df0ec36 ("btrfs: delalloc for page dirtied out-of-band in fixup worker")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next, thanks.
