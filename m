Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8BE87AD74
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2019 18:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfG3QXU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jul 2019 12:23:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:58910 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725793AbfG3QXU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jul 2019 12:23:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 34AE7AF21;
        Tue, 30 Jul 2019 16:23:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B861BDA808; Tue, 30 Jul 2019 18:23:52 +0200 (CEST)
Date:   Tue, 30 Jul 2019 18:23:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: fix deadlock between fiemap and transaction
 commits
Message-ID: <20190730162352.GC28208@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20190729083710.5680-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729083710.5680-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 29, 2019 at 09:37:10AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The fiemap handler locks a file range that can have unflushed delalloc,
> and after locking the range, it tries to attach to a running transaction.
> If the running transaction started its commit, that is, it is in state
> TRANS_STATE_COMMIT_START, and either the filesystem was mounted with the
> flushoncommit option or the transaction is creating a snapshot for the
> subvolume that contains the file that fiemap is operating on, we end up
> deadlocking. This happens because fiemap is blocked on the transaction,
> waiting for it to complete, and the transaction is waiting for the flushed
> dealloc to complete, which requires locking the file range that the fiemap
> task already locked. The following stack traces serve as an example of
> when this deadlock happens:
> 
>   (...)
>   [404571.515510] Workqueue: btrfs-endio-write btrfs_endio_write_helper [btrfs]
>   [404571.515956] Call Trace:
>   [404571.516360]  ? __schedule+0x3ae/0x7b0
>   [404571.516730]  schedule+0x3a/0xb0
>   [404571.517104]  lock_extent_bits+0x1ec/0x2a0 [btrfs]
>   [404571.517465]  ? remove_wait_queue+0x60/0x60
>   [404571.517832]  btrfs_finish_ordered_io+0x292/0x800 [btrfs]
>   [404571.518202]  normal_work_helper+0xea/0x530 [btrfs]
>   [404571.518566]  process_one_work+0x21e/0x5c0
>   [404571.518990]  worker_thread+0x4f/0x3b0
>   [404571.519413]  ? process_one_work+0x5c0/0x5c0
>   [404571.519829]  kthread+0x103/0x140
>   [404571.520191]  ? kthread_create_worker_on_cpu+0x70/0x70
>   [404571.520565]  ret_from_fork+0x3a/0x50
>   [404571.520915] kworker/u8:6    D    0 31651      2 0x80004000
>   [404571.521290] Workqueue: btrfs-flush_delalloc btrfs_flush_delalloc_helper [btrfs]
>   (...)
>   [404571.537000] fsstress        D    0 13117  13115 0x00004000
>   [404571.537263] Call Trace:
>   [404571.537524]  ? __schedule+0x3ae/0x7b0
>   [404571.537788]  schedule+0x3a/0xb0
>   [404571.538066]  wait_current_trans+0xc8/0x100 [btrfs]
>   [404571.538349]  ? remove_wait_queue+0x60/0x60
>   [404571.538680]  start_transaction+0x33c/0x500 [btrfs]
>   [404571.539076]  btrfs_check_shared+0xa3/0x1f0 [btrfs]
>   [404571.539513]  ? extent_fiemap+0x2ce/0x650 [btrfs]
>   [404571.539866]  extent_fiemap+0x2ce/0x650 [btrfs]
>   [404571.540170]  do_vfs_ioctl+0x526/0x6f0
>   [404571.540436]  ksys_ioctl+0x70/0x80
>   [404571.540734]  __x64_sys_ioctl+0x16/0x20
>   [404571.540997]  do_syscall_64+0x60/0x1d0
>   [404571.541279]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>   (...)
>   [404571.543729] btrfs           D    0 14210  14208 0x00004000
>   [404571.544023] Call Trace:
>   [404571.544275]  ? __schedule+0x3ae/0x7b0
>   [404571.544526]  ? wait_for_completion+0x112/0x1a0
>   [404571.544795]  schedule+0x3a/0xb0
>   [404571.545064]  schedule_timeout+0x1ff/0x390
>   [404571.545351]  ? lock_acquire+0xa6/0x190
>   [404571.545638]  ? wait_for_completion+0x49/0x1a0
>   [404571.545890]  ? wait_for_completion+0x112/0x1a0
>   [404571.546228]  wait_for_completion+0x131/0x1a0
>   [404571.546503]  ? wake_up_q+0x70/0x70
>   [404571.546775]  btrfs_wait_ordered_extents+0x27c/0x400 [btrfs]
>   [404571.547159]  btrfs_commit_transaction+0x3b0/0xae0 [btrfs]
>   [404571.547449]  ? btrfs_mksubvol+0x4a4/0x640 [btrfs]
>   [404571.547703]  ? remove_wait_queue+0x60/0x60
>   [404571.547969]  btrfs_mksubvol+0x605/0x640 [btrfs]
>   [404571.548226]  ? __sb_start_write+0xd4/0x1c0
>   [404571.548512]  ? mnt_want_write_file+0x24/0x50
>   [404571.548789]  btrfs_ioctl_snap_create_transid+0x169/0x1a0 [btrfs]
>   [404571.549048]  btrfs_ioctl_snap_create_v2+0x11d/0x170 [btrfs]
>   [404571.549307]  btrfs_ioctl+0x133f/0x3150 [btrfs]
>   [404571.549549]  ? mem_cgroup_charge_statistics+0x4c/0xd0
>   [404571.549792]  ? mem_cgroup_commit_charge+0x84/0x4b0
>   [404571.550064]  ? __handle_mm_fault+0xe3e/0x11f0
>   [404571.550306]  ? do_raw_spin_unlock+0x49/0xc0
>   [404571.550608]  ? _raw_spin_unlock+0x24/0x30
>   [404571.550976]  ? __handle_mm_fault+0xedf/0x11f0
>   [404571.551319]  ? do_vfs_ioctl+0xa2/0x6f0
>   [404571.551659]  ? btrfs_ioctl_get_supported_features+0x30/0x30 [btrfs]
>   [404571.552087]  do_vfs_ioctl+0xa2/0x6f0
>   [404571.552355]  ksys_ioctl+0x70/0x80
>   [404571.552621]  __x64_sys_ioctl+0x16/0x20
>   [404571.552864]  do_syscall_64+0x60/0x1d0
>   [404571.553104]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>   (...)
> 
> If we were joining the transaction instead of attaching to it, we would
> not risk a deadlock because a join only blocks if the transaction is in a
> state greater then or equals to TRANS_STATE_COMMIT_DOING, and the delalloc
> flush performed by a transaction is done before it reaches that state,
> when it is in the state TRANS_STATE_COMMIT_START. However a transaction
> join is intended for use cases where we do modify the filesystem, and
> fiemap only needs to peek at delayed references from the current
> transaction in order to determine if extents are shared, and, besides
> that, when there is no current transaction or when it blocks to wait for
> a current committing transaction to complete, it creates a new transaction
> without reserving any space. Such unnecessary transactions, besides doing
> unnecessary IO, can cause transaction aborts (-ENOSPC) and unnecessary
> rotation of the precious backup roots.
> 
> So fix this by adding a new transaction join variant, named join_nostart,
> which behaves like the regular join, but it does not create a transaction
> when none currently exists or after waiting for a committing transaction
> to complete.
> 
> Fixes: 03628cdbc64db6 ("Btrfs: do not start a transaction during fiemap")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Queued for 5.3, thanks.
