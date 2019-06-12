Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACC604280A
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2019 15:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439479AbfFLNwf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jun 2019 09:52:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:35594 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2436759AbfFLNwf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jun 2019 09:52:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A252BAFDA
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jun 2019 13:52:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 663B0DA88C; Wed, 12 Jun 2019 15:53:24 +0200 (CEST)
Date:   Wed, 12 Jun 2019 15:53:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH] btrfs: qgroup: Don't hold qgroup_ioctl_lock in
 btrfs_qgroup_inherit()
Message-ID: <20190612135324.GJ3563@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
References: <20190612075745.25024-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612075745.25024-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 12, 2019 at 03:57:45PM +0800, Qu Wenruo wrote:
> [BUG]
> Lockdep will report the following circular locking dependency:
> 
>   WARNING: possible circular locking dependency detected
>   5.2.0-rc2-custom #24 Tainted: G           O
>   ------------------------------------------------------
>   btrfs/8631 is trying to acquire lock:
>   000000002536438c (&fs_info->qgroup_ioctl_lock#2){+.+.}, at: btrfs_qgroup_inherit+0x40/0x620 [btrfs]
> 
>   but task is already holding lock:
>   000000003d52cc23 (&fs_info->tree_log_mutex){+.+.}, at: create_pending_snapshot+0x8b6/0xe60 [btrfs]
> 
>   which lock already depends on the new lock.
> 
>   the existing dependency chain (in reverse order) is:
> 
>   -> #2 (&fs_info->tree_log_mutex){+.+.}:
>          __mutex_lock+0x76/0x940
>          mutex_lock_nested+0x1b/0x20
>          btrfs_commit_transaction+0x475/0xa00 [btrfs]
>          btrfs_commit_super+0x71/0x80 [btrfs]
>          close_ctree+0x2bd/0x320 [btrfs]
>          btrfs_put_super+0x15/0x20 [btrfs]
>          generic_shutdown_super+0x72/0x110
>          kill_anon_super+0x18/0x30
>          btrfs_kill_super+0x16/0xa0 [btrfs]
>          deactivate_locked_super+0x3a/0x80
>          deactivate_super+0x51/0x60
>          cleanup_mnt+0x3f/0x80
>          __cleanup_mnt+0x12/0x20
>          task_work_run+0x94/0xb0
>          exit_to_usermode_loop+0xd8/0xe0
>          do_syscall_64+0x210/0x240
>          entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
>   -> #1 (&fs_info->reloc_mutex){+.+.}:
>          __mutex_lock+0x76/0x940
>          mutex_lock_nested+0x1b/0x20
>          btrfs_commit_transaction+0x40d/0xa00 [btrfs]
>          btrfs_quota_enable+0x2da/0x730 [btrfs]
>          btrfs_ioctl+0x2691/0x2b40 [btrfs]
>          do_vfs_ioctl+0xa9/0x6d0
>          ksys_ioctl+0x67/0x90
>          __x64_sys_ioctl+0x1a/0x20
>          do_syscall_64+0x65/0x240
>          entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
>   -> #0 (&fs_info->qgroup_ioctl_lock#2){+.+.}:
>          lock_acquire+0xa7/0x190
>          __mutex_lock+0x76/0x940
>          mutex_lock_nested+0x1b/0x20
>          btrfs_qgroup_inherit+0x40/0x620 [btrfs]
>          create_pending_snapshot+0x9d7/0xe60 [btrfs]
>          create_pending_snapshots+0x94/0xb0 [btrfs]
>          btrfs_commit_transaction+0x415/0xa00 [btrfs]
>          btrfs_mksubvol+0x496/0x4e0 [btrfs]
>          btrfs_ioctl_snap_create_transid+0x174/0x180 [btrfs]
>          btrfs_ioctl_snap_create_v2+0x11c/0x180 [btrfs]
>          btrfs_ioctl+0xa90/0x2b40 [btrfs]
>          do_vfs_ioctl+0xa9/0x6d0
>          ksys_ioctl+0x67/0x90
>          __x64_sys_ioctl+0x1a/0x20
>          do_syscall_64+0x65/0x240
>          entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
>   other info that might help us debug this:
> 
>   Chain exists of:
>     &fs_info->qgroup_ioctl_lock#2 --> &fs_info->reloc_mutex --> &fs_info->tree_log_mutex
> 
>    Possible unsafe locking scenario:
> 
>          CPU0                    CPU1
>          ----                    ----
>     lock(&fs_info->tree_log_mutex);
>                                  lock(&fs_info->reloc_mutex);
>                                  lock(&fs_info->tree_log_mutex);
>     lock(&fs_info->qgroup_ioctl_lock#2);
> 
>    *** DEADLOCK ***
> 
>   6 locks held by btrfs/8631:
>    #0: 00000000ed8f23f6 (sb_writers#12){.+.+}, at: mnt_want_write_file+0x28/0x60
>    #1: 000000009fb1597a (&type->i_mutex_dir_key#10/1){+.+.}, at: btrfs_mksubvol+0x70/0x4e0 [btrfs]
>    #2: 0000000088c5ad88 (&fs_info->subvol_sem){++++}, at: btrfs_mksubvol+0x128/0x4e0 [btrfs]
>    #3: 000000009606fc3e (sb_internal#2){.+.+}, at: start_transaction+0x37a/0x520 [btrfs]
>    #4: 00000000f82bbdf5 (&fs_info->reloc_mutex){+.+.}, at: btrfs_commit_transaction+0x40d/0xa00 [btrfs]
>    #5: 000000003d52cc23 (&fs_info->tree_log_mutex){+.+.}, at: create_pending_snapshot+0x8b6/0xe60 [btrfs]
> 
> [CAUSE]
> Due to the delayed subvolume creation, we need to call
> btrfs_qgroup_inherit() inside commit transaction code, with a lot of
> other mutex hold.
> This hell of lock chain can lead to above problem.
> 
> [FIX]
> On the other hand, we don't really need to hold qgroup_ioctl_lock if
> we're in the context of create_pending_snapshot().
> As in that context, we're the only one being able to modify qgroup.
> 
> All other qgroup functions which needs qgroup_ioctl_lock are either
> holding a transaction handle, or will start a new transaction:
>   Functions will start a new transaction():
>   * btrfs_quota_enable()
>   * btrfs_quota_disable()
>   Functions hold a transaction handler:
>   * btrfs_add_qgroup_relation()
>   * btrfs_del_qgroup_relation()
>   * btrfs_create_qgroup()
>   * btrfs_remove_qgroup()
>   * btrfs_limit_qgroup()
>   * btrfs_qgroup_inherit() call inside create_subvol()
> 
> So we have a higher level protection provided by transaction, thus we
> don't need to always hold qgroup_ioctl_lock in btrfs_qgroup_inherit().
> 
> Only the btrfs_qgroup_inherit() call in create_subvol() needs to hold
> qgroup_ioctl_lock, while the btrfs_qgroup_inherit() call in
> create_pending_snapshot() is already protected by transaction.
> 
> So the fix is to manually hold qgroup_ioctl_lock inside create_subvol()
> while skip the lock inside create_pending_snapshot.

Would it be possible to add that as a run-time assertion? Eg. check the
state of the transaction if it's inside commit, and if not then check
the locks?
