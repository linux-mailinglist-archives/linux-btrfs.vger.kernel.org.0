Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F422924A3CC
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Aug 2020 18:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgHSQLX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Aug 2020 12:11:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:54362 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726862AbgHSQLV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Aug 2020 12:11:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5CD88B6C8;
        Wed, 19 Aug 2020 16:11:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7B629DA703; Wed, 19 Aug 2020 18:10:14 +0200 (CEST)
Date:   Wed, 19 Aug 2020 18:10:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix space cache memory leak after transaction
 abort
Message-ID: <20200819161014.GR2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20200814100409.633527-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814100409.633527-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 14, 2020 at 11:04:09AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If a transaction aborts it can cause a memory leak of the pages array of
> a block group's io_ctl structure. The following steps explain how that can
> happen:
> 
> 1) Transaction N is committing, currently in state TRANS_STATE_UNBLOCKED
>    and it's about to start writing out dirty extent buffers;
> 
> 2) Transaction N + 1 already started and another task, task A, just called
>    btrfs_commit_transaction() on it;
> 
> 3) Block group B was dirtied (extents allocated from it) by transaction
>    N + 1, so when task A calls btrfs_start_dirty_block_groups(), at the
>    very beginning of the transaction commit, it starts writeback for the
>    block group's space cache by calling btrfs_write_out_cache(), which
>    allocates the pages array for the block group's io_ctl with a call to
>    io_ctl_init(). Block group A is added to the io_list of transaction
>    N + 1 by btrfs_start_dirty_block_groups();
> 
> 4) While transaction N's commit is writing out the extent buffers, it gets
>    an IO error and aborts transaction N, also setting the file system to
>    RO mode;
> 
> 5) Task A has already returned from btrfs_start_dirty_block_groups(), is at
>    btrfs_commit_transaction() and has set transaction N + 1 state to
>    TRANS_STATE_COMMIT_START. Immediately after that it checks that the
>    filesystem was turned to RO mode, due to transaction N's abort, and
>    jumps to the "cleanup_transaction" label. After that we end up at
>    btrfs_cleanup_one_transaction() which calls btrfs_cleanup_dirty_bgs().
>    That helper finds block group B in the transaction's io_list but it
>    never releases the pages array of the block group's io_ctl, resulting in
>    a memory leak.
> 
> In fact at the point when we are at btrfs_cleanup_dirty_bgs(), the pages
> array points to pages that were already released by us at
> __btrfs_write_out_cache() through the call to io_ctl_drop_pages(). We end
> up freeing the pages array only after waiting for the ordered extent to
> complete through btrfs_wait_cache_io(), which calls io_ctl_free() to do
> that. But in the transaction abort case we don't wait for the space cache's
> ordered extent to complete through a call to btrfs_wait_cache_io(), so
> that's why we end up with a memory leak - we wait for the ordered extent
> to complete indirectly by shutting down the work queues and waiting for
> any jobs in them to complete before returning from close_ctree().
> 
> We can solve the leak simply by freeing the pages array right after
> releasing the pages (with the call to io_ctl_drop_pages()) at
> __btrfs_write_out_cache(), since we will never use it anymore after that
> and the pages array points to already released pages at that point, which
> is currently not a problem since no one will use it after that, but not a
> good practice anyway since it can easily lead to use-after-free issues.
> 
> So fix this by freeing the pages array right after releasing the pages at
> __btrfs_write_out_cache().
> 
> This issue can often be reproduced with test case generic/475 from fstests
> and kmemleak can detect it and reports it with the following trace:
> 
> unreferenced object 0xffff9bbf009fa600 (size 512):
>   comm "fsstress", pid 38807, jiffies 4298504428 (age 22.028s)
>   hex dump (first 32 bytes):
>     00 a0 7c 4d 3d ed ff ff 40 a0 7c 4d 3d ed ff ff  ..|M=...@.|M=...
>     80 a0 7c 4d 3d ed ff ff c0 a0 7c 4d 3d ed ff ff  ..|M=.....|M=...
>   backtrace:
>     [<00000000f4b5cfe2>] __kmalloc+0x1a8/0x3e0
>     [<0000000028665e7f>] io_ctl_init+0xa7/0x120 [btrfs]
>     [<00000000a1f95b2d>] __btrfs_write_out_cache+0x86/0x4a0 [btrfs]
>     [<00000000207ea1b0>] btrfs_write_out_cache+0x7f/0xf0 [btrfs]
>     [<00000000af21f534>] btrfs_start_dirty_block_groups+0x27b/0x580 [btrfs]
>     [<00000000c3c23d44>] btrfs_commit_transaction+0xa6f/0xe70 [btrfs]
>     [<000000009588930c>] create_subvol+0x581/0x9a0 [btrfs]
>     [<000000009ef2fd7f>] btrfs_mksubvol+0x3fb/0x4a0 [btrfs]
>     [<00000000474e5187>] __btrfs_ioctl_snap_create+0x119/0x1a0 [btrfs]
>     [<00000000708ee349>] btrfs_ioctl_snap_create_v2+0xb0/0xf0 [btrfs]
>     [<00000000ea60106f>] btrfs_ioctl+0x12c/0x3130 [btrfs]
>     [<000000005c923d6d>] __x64_sys_ioctl+0x83/0xb0
>     [<0000000043ace2c9>] do_syscall_64+0x33/0x80
>     [<00000000904efbce>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
