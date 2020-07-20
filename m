Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045BA2262B0
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jul 2020 17:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgGTPB1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jul 2020 11:01:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:36640 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbgGTPBX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jul 2020 11:01:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 70F50AED7;
        Mon, 20 Jul 2020 15:01:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5005EDA781; Mon, 20 Jul 2020 17:00:57 +0200 (CEST)
Date:   Mon, 20 Jul 2020 17:00:57 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: qgroup: Fix data leakage caused by race
 between writeback and truncate
Message-ID: <20200720150057.GF3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200717071205.26027-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717071205.26027-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 17, 2020 at 03:12:05PM +0800, Qu Wenruo wrote:
> [BUG]
> When running tests like generic/013 on test device with btrfs quota
> enabled, it can normally lead to data leakage, detected at unmount time:
> 
>   BTRFS warning (device dm-3): qgroup 0/5 has unreleased space, type 0 rsv 4096
>   ------------[ cut here ]------------
>   WARNING: CPU: 11 PID: 16386 at fs/btrfs/disk-io.c:4142 close_ctree+0x1dc/0x323 [btrfs]
>   RIP: 0010:close_ctree+0x1dc/0x323 [btrfs]
>   Call Trace:
>    btrfs_put_super+0x15/0x17 [btrfs]
>    generic_shutdown_super+0x72/0x110
>    kill_anon_super+0x18/0x30
>    btrfs_kill_super+0x17/0x30 [btrfs]
>    deactivate_locked_super+0x3b/0xa0
>    deactivate_super+0x40/0x50
>    cleanup_mnt+0x135/0x190
>    __cleanup_mnt+0x12/0x20
>    task_work_run+0x64/0xb0
>    __prepare_exit_to_usermode+0x1bc/0x1c0
>    __syscall_return_slowpath+0x47/0x230
>    do_syscall_64+0x64/0xb0
>    entry_SYSCALL_64_after_hwframe+0x44/0xa9
>   ---[ end trace caf08beafeca2392 ]---
>   BTRFS error (device dm-3): qgroup reserved space leaked
> 
> [CAUSE]
> In the offending case, the offending operations are:
> 2/6: writev f2X[269 1 0 0 0 0] [1006997,67,288] 0
> 2/7: truncate f2X[269 1 0 0 48 1026293] 18388 0
> 
> The following sequence of events could happen after the writev():
> 	CPU1 (writeback)		|		CPU2 (truncate)
> -----------------------------------------------------------------
> btrfs_writepages()			|
> |- extent_write_cache_pages()		|
>    |- Got page for 1003520		|
>    |  1003520 is Dirty, no writeback	|
>    |  So (!clear_page_dirty_for_io())   |
>    |  gets called for it		|
>    |- Now page 1003520 is Clean.	|
>    |					| btrfs_setattr()
>    |					| |- btrfs_setsize()
>    |					|    |- truncate_setsize()
>    |					|       New i_size is 18388
>    |- __extent_writepage()		|
>    |  |- page_offset() > i_size		|
>       |- btrfs_invalidatepage()		|
> 	 |- Page is clean, so no qgroup |
> 	    callback executed
> 
> This means, the qgroup reserved data space is not properly released in
> btrfs_invalidatepage() as the page is Clean.
> 
> [FIX]
> Instead of checking the dirty bit of a page, call
> btrfs_qgroup_free_data() unconditionally in btrfs_invalidatepage().
> 
> As qgroup rsv are completely binded to the QGROUP_RESERVED bit of
> io_tree, not binded to page status, thus we won't cause double freeing
> anyway.
> 
> Fixes: 0b34c261e235 ("btrfs: qgroup: Prevent qgroup->reserved from going subzero")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.
