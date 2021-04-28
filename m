Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA62536DED3
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 20:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243562AbhD1SLc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Apr 2021 14:11:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:43754 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243560AbhD1SLb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Apr 2021 14:11:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BBB59B1C5;
        Wed, 28 Apr 2021 18:10:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C234FDA783; Wed, 28 Apr 2021 20:08:22 +0200 (CEST)
Date:   Wed, 28 Apr 2021 20:08:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix deadlock when cloning inline extents and
 using qgroups
Message-ID: <20210428180822.GT7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <d098a031cc7d59823711dd37f3f5f4b4c56c04be.1619087885.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d098a031cc7d59823711dd37f3f5f4b4c56c04be.1619087885.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 22, 2021 at 12:08:05PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There are a few exceptional cases where cloning an inline extent needs to
> copy the inline extent data into a page of the destination inode.
> 
> When this happens, we end up starting a transaction while having a dirty
> page for the destination inode and while having the range locked in the
> destination's inode iotree too. Because when reserving metadata space
> for a transaction we may need to flush existing delalloc in case there is
> not enough free space, we have a mechanism in place to prevent a deadlock,
> which was introduced in commit 3d45f221ce627d ("btrfs: fix deadlock when
> cloning inline extent and low on free metadata space").
> 
> However when using qgroups, a transaction also reserves metadata qgroup
> space, which can also result in flushing delalloc in case there is not
> enough available space at the moment. When this happens we deadlock, since
> flushing delalloc requires locking the file range in the inode's iotree
> and the range was already locked at the very beginning of the clone
> operation, before attempting to start the transaction.
> 
> When this issue happens, stack traces like the following are reported:
> 
> [72747.556262] task:kworker/u81:9   state:D stack:    0 pid:  225 ppid:     2 flags:0x00004000
> [72747.556268] Workqueue: writeback wb_workfn (flush-btrfs-1142)
> [72747.556271] Call Trace:
> [72747.556273]  __schedule+0x296/0x760
> [72747.556277]  schedule+0x3c/0xa0
> [72747.556279]  io_schedule+0x12/0x40
> [72747.556284]  __lock_page+0x13c/0x280
> [72747.556287]  ? generic_file_readonly_mmap+0x70/0x70
> [72747.556325]  extent_write_cache_pages+0x22a/0x440 [btrfs]
> [72747.556331]  ? __set_page_dirty_nobuffers+0xe7/0x160
> [72747.556358]  ? set_extent_buffer_dirty+0x5e/0x80 [btrfs]
> [72747.556362]  ? update_group_capacity+0x25/0x210
> [72747.556366]  ? cpumask_next_and+0x1a/0x20
> [72747.556391]  extent_writepages+0x44/0xa0 [btrfs]
> [72747.556394]  do_writepages+0x41/0xd0
> [72747.556398]  __writeback_single_inode+0x39/0x2a0
> [72747.556403]  writeback_sb_inodes+0x1ea/0x440
> [72747.556407]  __writeback_inodes_wb+0x5f/0xc0
> [72747.556410]  wb_writeback+0x235/0x2b0
> [72747.556414]  ? get_nr_inodes+0x35/0x50
> [72747.556417]  wb_workfn+0x354/0x490
> [72747.556420]  ? newidle_balance+0x2c5/0x3e0
> [72747.556424]  process_one_work+0x1aa/0x340
> [72747.556426]  worker_thread+0x30/0x390
> [72747.556429]  ? create_worker+0x1a0/0x1a0
> [72747.556432]  kthread+0x116/0x130
> [72747.556435]  ? kthread_park+0x80/0x80
> [72747.556438]  ret_from_fork+0x1f/0x30
> 
> [72747.566958] Workqueue: btrfs-flush_delalloc btrfs_work_helper [btrfs]
> [72747.566961] Call Trace:
> [72747.566964]  __schedule+0x296/0x760
> [72747.566968]  ? finish_wait+0x80/0x80
> [72747.566970]  schedule+0x3c/0xa0
> [72747.566995]  wait_extent_bit.constprop.68+0x13b/0x1c0 [btrfs]
> [72747.566999]  ? finish_wait+0x80/0x80
> [72747.567024]  lock_extent_bits+0x37/0x90 [btrfs]
> [72747.567047]  btrfs_invalidatepage+0x299/0x2c0 [btrfs]
> [72747.567051]  ? find_get_pages_range_tag+0x2cd/0x380
> [72747.567076]  __extent_writepage+0x203/0x320 [btrfs]
> [72747.567102]  extent_write_cache_pages+0x2bb/0x440 [btrfs]
> [72747.567106]  ? update_load_avg+0x7e/0x5f0
> [72747.567109]  ? enqueue_entity+0xf4/0x6f0
> [72747.567134]  extent_writepages+0x44/0xa0 [btrfs]
> [72747.567137]  ? enqueue_task_fair+0x93/0x6f0
> [72747.567140]  do_writepages+0x41/0xd0
> [72747.567144]  __filemap_fdatawrite_range+0xc7/0x100
> [72747.567167]  btrfs_run_delalloc_work+0x17/0x40 [btrfs]
> [72747.567195]  btrfs_work_helper+0xc2/0x300 [btrfs]
> [72747.567200]  process_one_work+0x1aa/0x340
> [72747.567202]  worker_thread+0x30/0x390
> [72747.567205]  ? create_worker+0x1a0/0x1a0
> [72747.567208]  kthread+0x116/0x130
> [72747.567211]  ? kthread_park+0x80/0x80
> [72747.567214]  ret_from_fork+0x1f/0x30
> 
> [72747.569686] task:fsstress        state:D stack:    0 pid:841421 ppid:841417 flags:0x00000000
> [72747.569689] Call Trace:
> [72747.569691]  __schedule+0x296/0x760
> [72747.569694]  schedule+0x3c/0xa0
> [72747.569721]  try_flush_qgroup+0x95/0x140 [btrfs]
> [72747.569725]  ? finish_wait+0x80/0x80
> [72747.569753]  btrfs_qgroup_reserve_data+0x34/0x50 [btrfs]
> [72747.569781]  btrfs_check_data_free_space+0x5f/0xa0 [btrfs]
> [72747.569804]  btrfs_buffered_write+0x1f7/0x7f0 [btrfs]
> [72747.569810]  ? path_lookupat.isra.48+0x97/0x140
> [72747.569833]  btrfs_file_write_iter+0x81/0x410 [btrfs]
> [72747.569836]  ? __kmalloc+0x16a/0x2c0
> [72747.569839]  do_iter_readv_writev+0x160/0x1c0
> [72747.569843]  do_iter_write+0x80/0x1b0
> [72747.569847]  vfs_writev+0x84/0x140
> [72747.569869]  ? btrfs_file_llseek+0x38/0x270 [btrfs]
> [72747.569873]  do_writev+0x65/0x100
> [72747.569876]  do_syscall_64+0x33/0x40
> [72747.569879]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> [72747.569899] task:fsstress        state:D stack:    0 pid:841424 ppid:841417 flags:0x00004000
> [72747.569903] Call Trace:
> [72747.569906]  __schedule+0x296/0x760
> [72747.569909]  schedule+0x3c/0xa0
> [72747.569936]  try_flush_qgroup+0x95/0x140 [btrfs]
> [72747.569940]  ? finish_wait+0x80/0x80
> [72747.569967]  __btrfs_qgroup_reserve_meta+0x36/0x50 [btrfs]
> [72747.569989]  start_transaction+0x279/0x580 [btrfs]
> [72747.570014]  clone_copy_inline_extent+0x332/0x490 [btrfs]
> [72747.570041]  btrfs_clone+0x5b7/0x7a0 [btrfs]
> [72747.570068]  ? lock_extent_bits+0x64/0x90 [btrfs]
> [72747.570095]  btrfs_clone_files+0xfc/0x150 [btrfs]
> [72747.570122]  btrfs_remap_file_range+0x3d8/0x4a0 [btrfs]
> [72747.570126]  do_clone_file_range+0xed/0x200
> [72747.570131]  vfs_clone_file_range+0x37/0x110
> [72747.570134]  ioctl_file_clone+0x7d/0xb0
> [72747.570137]  do_vfs_ioctl+0x138/0x630
> [72747.570140]  __x64_sys_ioctl+0x62/0xc0
> [72747.570143]  do_syscall_64+0x33/0x40
> [72747.570146]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> So fix this by skipping the flush of delalloc for an inode that is
> flagged with BTRFS_INODE_NO_DELALLOC_FLUSH, meaning it is currently under
> such a special case of cloning an inline extent, when flushing delalloc
> during qgroup metadata reservation.
> 
> The special cases for cloning inline extents were added in kernel 5.7 by
> by commit 05a5a7621ce66c ("Btrfs: implement full reflink support for
> inline extents"), while having qgroup metadata space reservation flushing
> delalloc when low on space was added in kernel 5.9 by commit
> c53e9653605dbf ("btrfs: qgroup: try to flush qgroup space when we get
> -EDQUOT"). So use a "Fixes:" tag for the later commit to ease stable
> kernel backports.
> 
> Reported-by: Wang Yugui <wangyugui@e16-tech.com>
> Link: https://lore.kernel.org/linux-btrfs/20210421083137.31E3.409509F4@e16-tech.com/
> Fixes: c53e9653605dbf ("btrfs: qgroup: try to flush qgroup space when we get -EDQUOT")
> CC: stable@vger.kernel.org # 5.9+
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
