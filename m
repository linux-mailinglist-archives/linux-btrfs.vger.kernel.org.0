Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B242848D6C7
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jan 2022 12:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbiAMLmL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jan 2022 06:42:11 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:47582 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiAMLmK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jan 2022 06:42:10 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 79A871F3A5;
        Thu, 13 Jan 2022 11:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642074129;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pobcldfiKzzidq7eNkc5fHtd10cleHLVh2kt/J9MZd0=;
        b=arTVHODfURmvHzJqIupslnPNdo2eAUVO3J3+I7Qzp4Jk+VIELiZNbr9AFSQBrN8la2jeuP
        rVn4WrplMAGVsDH+Is5cGVXfzIDw7nA0LWc4KUVpe4rscWVqQIgNEIqNbRcpLccakpB4le
        8NBbp1PWggGaOVSZVKPRKYPNiNBzHjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642074129;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pobcldfiKzzidq7eNkc5fHtd10cleHLVh2kt/J9MZd0=;
        b=WBgUiC2LcnOrPYdzzvBtTJA8y1ZYEqYiP3+vN0mItDF3pVQAlqUqmpIQH/+GXvTNipks8e
        3QQgTnVfCIx40tAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 454B1A3B84;
        Thu, 13 Jan 2022 11:42:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 082ACDA799; Thu, 13 Jan 2022 12:41:34 +0100 (CET)
Date:   Thu, 13 Jan 2022 12:41:34 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH] btrfs: fix deadlock between quota disable and qgroup
 rescan worker
Message-ID: <20220113114134.GA14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <20220113104029.902200-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113104029.902200-1-shinichiro.kawasaki@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 13, 2022 at 07:40:29PM +0900, Shin'ichiro Kawasaki wrote:
> Quota disable ioctl starts a transaction before waiting for the qgroup
> rescan worker completes. However, this wait can be infinite and results
> in deadlock because of circular dependency among the quota disable
> ioctl, the qgroup rescan worker and the other task with transaction such
> as block group relocation task.
> 
> The deadlock happens with the steps following:
> 
> 1) Task A calls ioctl to disable quota. It starts a transaction and
>    waits for qgroup rescan worker completes.
> 2) Task B such as block group relocation task starts a transaction and
>    joins to the transaction that task A started. Then task B commits to
>    the transaction. In this commit, task B waits for a commit by task A.
> 3) Task C as the qgroup rescan worker starts its job and starts a
>    transaction. In this transaction start, task C waits for completion
>    of the transaction that task A started and task B committed.
> 
> This deadlock was found with fstests test case block/115 and a zoned
> null_blk device. The test case enables and disables quota, and the
> block group reclaim was triggered during the quota disable by chance.
> The deadlock was also observed by running quota enable and disable in
> parallel with 'btrfs balance' command on regular null_blk devices.
> 
> An example report of the deadlock:
> 
> [  372.469894] INFO: task kworker/u16:6:103 blocked for more than 122 seconds.
> [  372.479944]       Not tainted 5.16.0-rc8 #7
> [  372.485067] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  372.493898] task:kworker/u16:6   state:D stack:    0 pid:  103 ppid:     2 flags:0x00004000
> [  372.503285] Workqueue: btrfs-qgroup-rescan btrfs_work_helper [btrfs]
> [  372.510782] Call Trace:
> [  372.514092]  <TASK>
> [  372.521684]  __schedule+0xb56/0x4850
> [  372.530104]  ? io_schedule_timeout+0x190/0x190
> [  372.538842]  ? lockdep_hardirqs_on+0x7e/0x100
> [  372.547092]  ? _raw_spin_unlock_irqrestore+0x3e/0x60
> [  372.555591]  schedule+0xe0/0x270
> [  372.561894]  btrfs_commit_transaction+0x18bb/0x2610 [btrfs]
> [  372.570506]  ? btrfs_apply_pending_changes+0x50/0x50 [btrfs]
> [  372.578875]  ? free_unref_page+0x3f2/0x650
> [  372.585484]  ? finish_wait+0x270/0x270
> [  372.591594]  ? release_extent_buffer+0x224/0x420 [btrfs]
> [  372.599264]  btrfs_qgroup_rescan_worker+0xc13/0x10c0 [btrfs]
> [  372.607157]  ? lock_release+0x3a9/0x6d0
> [  372.613054]  ? btrfs_qgroup_account_extent+0xda0/0xda0 [btrfs]
> [  372.620960]  ? do_raw_spin_lock+0x11e/0x250
> [  372.627137]  ? rwlock_bug.part.0+0x90/0x90
> [  372.633215]  ? lock_is_held_type+0xe4/0x140
> [  372.639404]  btrfs_work_helper+0x1ae/0xa90 [btrfs]
> [  372.646268]  process_one_work+0x7e9/0x1320
> [  372.652321]  ? lock_release+0x6d0/0x6d0
> [  372.658081]  ? pwq_dec_nr_in_flight+0x230/0x230
> [  372.664513]  ? rwlock_bug.part.0+0x90/0x90
> [  372.670529]  worker_thread+0x59e/0xf90
> [  372.676172]  ? process_one_work+0x1320/0x1320
> [  372.682440]  kthread+0x3b9/0x490
> [  372.687550]  ? _raw_spin_unlock_irq+0x24/0x50
> [  372.693811]  ? set_kthread_struct+0x100/0x100
> [  372.700052]  ret_from_fork+0x22/0x30
> [  372.705517]  </TASK>
> [  372.709747] INFO: task btrfs-transacti:2347 blocked for more than 123 seconds.
> [  372.729827]       Not tainted 5.16.0-rc8 #7
> [  372.745907] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  372.767106] task:btrfs-transacti state:D stack:    0 pid: 2347 ppid:     2 flags:0x00004000
> [  372.787776] Call Trace:
> [  372.801652]  <TASK>
> [  372.812961]  __schedule+0xb56/0x4850
> [  372.830011]  ? io_schedule_timeout+0x190/0x190
> [  372.852547]  ? lockdep_hardirqs_on+0x7e/0x100
> [  372.871761]  ? _raw_spin_unlock_irqrestore+0x3e/0x60
> [  372.886792]  schedule+0xe0/0x270
> [  372.901685]  wait_current_trans+0x22c/0x310 [btrfs]
> [  372.919743]  ? btrfs_put_transaction+0x3d0/0x3d0 [btrfs]
> [  372.938923]  ? finish_wait+0x270/0x270
> [  372.959085]  ? join_transaction+0xc75/0xe30 [btrfs]
> [  372.977706]  start_transaction+0x938/0x10a0 [btrfs]
> [  372.997168]  transaction_kthread+0x19d/0x3c0 [btrfs]
> [  373.013021]  ? btrfs_cleanup_transaction.isra.0+0xfc0/0xfc0 [btrfs]
> [  373.031678]  kthread+0x3b9/0x490
> [  373.047420]  ? _raw_spin_unlock_irq+0x24/0x50
> [  373.064645]  ? set_kthread_struct+0x100/0x100
> [  373.078571]  ret_from_fork+0x22/0x30
> [  373.091197]  </TASK>
> [  373.105611] INFO: task btrfs:3145 blocked for more than 123 seconds.
> [  373.114147]       Not tainted 5.16.0-rc8 #7
> [  373.120401] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  373.130393] task:btrfs           state:D stack:    0 pid: 3145 ppid:  3141 flags:0x00004000
> [  373.140998] Call Trace:
> [  373.145501]  <TASK>
> [  373.149654]  __schedule+0xb56/0x4850
> [  373.155306]  ? io_schedule_timeout+0x190/0x190
> [  373.161965]  ? lockdep_hardirqs_on+0x7e/0x100
> [  373.168469]  ? _raw_spin_unlock_irqrestore+0x3e/0x60
> [  373.175468]  schedule+0xe0/0x270
> [  373.180814]  wait_for_commit+0x104/0x150 [btrfs]
> [  373.187643]  ? test_and_set_bit+0x20/0x20 [btrfs]
> [  373.194772]  ? kmem_cache_free+0x124/0x550
> [  373.201191]  ? btrfs_put_transaction+0x69/0x3d0 [btrfs]
> [  373.208738]  ? finish_wait+0x270/0x270
> [  373.214704]  ? __btrfs_end_transaction+0x347/0x7b0 [btrfs]
> [  373.222342]  btrfs_commit_transaction+0x44d/0x2610 [btrfs]
> [  373.230233]  ? join_transaction+0x255/0xe30 [btrfs]
> [  373.237334]  ? btrfs_record_root_in_trans+0x4d/0x170 [btrfs]
> [  373.245251]  ? btrfs_apply_pending_changes+0x50/0x50 [btrfs]
> [  373.253296]  relocate_block_group+0x105/0xc20 [btrfs]
> [  373.260533]  ? mutex_lock_io_nested+0x1270/0x1270
> [  373.267516]  ? btrfs_wait_nocow_writers+0x85/0x180 [btrfs]
> [  373.275155]  ? merge_reloc_roots+0x710/0x710 [btrfs]
> [  373.283602]  ? btrfs_wait_ordered_extents+0xd30/0xd30 [btrfs]
> [  373.291934]  ? kmem_cache_free+0x124/0x550
> [  373.298180]  btrfs_relocate_block_group+0x35c/0x930 [btrfs]
> [  373.306047]  btrfs_relocate_chunk+0x85/0x210 [btrfs]
> [  373.313229]  btrfs_balance+0x12f4/0x2d20 [btrfs]
> [  373.320227]  ? lock_release+0x3a9/0x6d0
> [  373.326206]  ? btrfs_relocate_chunk+0x210/0x210 [btrfs]
> [  373.333591]  ? lock_is_held_type+0xe4/0x140
> [  373.340031]  ? rcu_read_lock_sched_held+0x3f/0x70
> [  373.346910]  btrfs_ioctl_balance+0x548/0x700 [btrfs]
> [  373.354207]  btrfs_ioctl+0x7f2/0x71b0 [btrfs]
> [  373.360774]  ? lockdep_hardirqs_on_prepare+0x410/0x410
> [  373.367957]  ? lockdep_hardirqs_on_prepare+0x410/0x410
> [  373.375327]  ? btrfs_ioctl_get_supported_features+0x20/0x20 [btrfs]
> [  373.383841]  ? find_held_lock+0x2c/0x110
> [  373.389993]  ? lock_release+0x3a9/0x6d0
> [  373.395828]  ? mntput_no_expire+0xf7/0xad0
> [  373.402083]  ? lock_is_held_type+0xe4/0x140
> [  373.408249]  ? vfs_fileattr_set+0x9f0/0x9f0
> [  373.414486]  ? selinux_file_ioctl+0x349/0x4e0
> [  373.420938]  ? trace_raw_output_lock+0xb4/0xe0
> [  373.427442]  ? selinux_inode_getsecctx+0x80/0x80
> [  373.434224]  ? lockdep_hardirqs_on+0x7e/0x100
> [  373.440660]  ? force_qs_rnp+0x2a0/0x6b0
> [  373.446534]  ? lock_is_held_type+0x9b/0x140
> [  373.452763]  ? __blkcg_punt_bio_submit+0x1b0/0x1b0
> [  373.459732]  ? security_file_ioctl+0x50/0x90
> [  373.466089]  __x64_sys_ioctl+0x127/0x190
> [  373.472022]  do_syscall_64+0x3b/0x90
> [  373.477513]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  373.484823] RIP: 0033:0x7f8f4af7e2bb
> [  373.490493] RSP: 002b:00007ffcbf936178 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [  373.500197] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f8f4af7e2bb
> [  373.509451] RDX: 00007ffcbf936220 RSI: 00000000c4009420 RDI: 0000000000000003
> [  373.518659] RBP: 00007ffcbf93774a R08: 0000000000000013 R09: 00007f8f4b02d4e0
> [  373.527872] R10: 00007f8f4ae87740 R11: 0000000000000246 R12: 0000000000000001
> [  373.537222] R13: 00007ffcbf936220 R14: 0000000000000000 R15: 0000000000000002
> [  373.546506]  </TASK>
> [  373.550878] INFO: task btrfs:3146 blocked for more than 123 seconds.
> [  373.559383]       Not tainted 5.16.0-rc8 #7
> [  373.565748] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  373.575748] task:btrfs           state:D stack:    0 pid: 3146 ppid:  2168 flags:0x00000000
> [  373.586314] Call Trace:
> [  373.590846]  <TASK>
> [  373.595121]  __schedule+0xb56/0x4850
> [  373.600901]  ? __lock_acquire+0x23db/0x5030
> [  373.607176]  ? io_schedule_timeout+0x190/0x190
> [  373.613954]  schedule+0xe0/0x270
> [  373.619157]  schedule_timeout+0x168/0x220
> [  373.625170]  ? usleep_range_state+0x150/0x150
> [  373.631653]  ? mark_held_locks+0x9e/0xe0
> [  373.637767]  ? do_raw_spin_lock+0x11e/0x250
> [  373.643993]  ? lockdep_hardirqs_on_prepare+0x17b/0x410
> [  373.651267]  ? _raw_spin_unlock_irq+0x24/0x50
> [  373.657677]  ? lockdep_hardirqs_on+0x7e/0x100
> [  373.664103]  wait_for_completion+0x163/0x250
> [  373.670437]  ? bit_wait_timeout+0x160/0x160
> [  373.676585]  btrfs_quota_disable+0x176/0x9a0 [btrfs]
> [  373.683979]  ? btrfs_quota_enable+0x12f0/0x12f0 [btrfs]
> [  373.691340]  ? down_write+0xd0/0x130
> [  373.696880]  ? down_write_killable+0x150/0x150
> [  373.703352]  btrfs_ioctl+0x3945/0x71b0 [btrfs]
> [  373.710061]  ? find_held_lock+0x2c/0x110
> [  373.716192]  ? lock_release+0x3a9/0x6d0
> [  373.722047]  ? __handle_mm_fault+0x23cd/0x3050
> [  373.728486]  ? btrfs_ioctl_get_supported_features+0x20/0x20 [btrfs]
> [  373.737032]  ? set_pte+0x6a/0x90
> [  373.742271]  ? do_raw_spin_unlock+0x55/0x1f0
> [  373.748506]  ? lock_is_held_type+0xe4/0x140
> [  373.754792]  ? vfs_fileattr_set+0x9f0/0x9f0
> [  373.761083]  ? selinux_file_ioctl+0x349/0x4e0
> [  373.767521]  ? selinux_inode_getsecctx+0x80/0x80
> [  373.774247]  ? __up_read+0x182/0x6e0
> [  373.780026]  ? count_memcg_events.constprop.0+0x46/0x60
> [  373.787281]  ? up_write+0x460/0x460
> [  373.792932]  ? security_file_ioctl+0x50/0x90
> [  373.799232]  __x64_sys_ioctl+0x127/0x190
> [  373.805237]  do_syscall_64+0x3b/0x90
> [  373.810947]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  373.818102] RIP: 0033:0x7f1383ea02bb
> [  373.823847] RSP: 002b:00007fffeb4d71f8 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
> [  373.833641] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1383ea02bb
> [  373.842961] RDX: 00007fffeb4d7210 RSI: 00000000c0109428 RDI: 0000000000000003
> [  373.852179] RBP: 0000000000000003 R08: 0000000000000003 R09: 0000000000000078
> [  373.861408] R10: 00007f1383daec78 R11: 0000000000000202 R12: 00007fffeb4d874a
> [  373.870647] R13: 0000000000493099 R14: 0000000000000001 R15: 0000000000000000
> [  373.879838]  </TASK>
> [  373.884018]
>                Showing all locks held in the system:
> [  373.894250] 3 locks held by kworker/4:1/58:
> [  373.900356] 1 lock held by khungtaskd/63:
> [  373.906333]  #0: ffffffff8945ff60 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260
> [  373.917307] 3 locks held by kworker/u16:6/103:
> [  373.923938]  #0: ffff888127b4f138 ((wq_completion)btrfs-qgroup-rescan){+.+.}-{0:0}, at: process_one_work+0x712/0x1320
> [  373.936555]  #1: ffff88810b817dd8 ((work_completion)(&work->normal_work)){+.+.}-{0:0}, at: process_one_work+0x73f/0x1320
> [  373.951109]  #2: ffff888102dd4650 (sb_internal#2){.+.+}-{0:0}, at: btrfs_qgroup_rescan_worker+0x1f6/0x10c0 [btrfs]
> [  373.964027] 2 locks held by less/1803:
> [  373.969982]  #0: ffff88813ed56098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80
> [  373.981295]  #1: ffffc90000b3b2e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x9e2/0x1060
> [  373.992969] 1 lock held by btrfs-transacti/2347:
> [  373.999893]  #0: ffff88813d4887a8 (&fs_info->transaction_kthread_mutex){+.+.}-{3:3}, at: transaction_kthread+0xe3/0x3c0 [btrfs]
> [  374.015872] 3 locks held by btrfs/3145:
> [  374.022298]  #0: ffff888102dd4460 (sb_writers#18){.+.+}-{0:0}, at: btrfs_ioctl_balance+0xc3/0x700 [btrfs]
> [  374.034456]  #1: ffff88813d48a0a0 (&fs_info->reclaim_bgs_lock){+.+.}-{3:3}, at: btrfs_balance+0xfe5/0x2d20 [btrfs]
> [  374.047646]  #2: ffff88813d488838 (&fs_info->cleaner_mutex){+.+.}-{3:3}, at: btrfs_relocate_block_group+0x354/0x930 [btrfs]
> [  374.063295] 4 locks held by btrfs/3146:
> [  374.069647]  #0: ffff888102dd4460 (sb_writers#18){.+.+}-{0:0}, at: btrfs_ioctl+0x38b1/0x71b0 [btrfs]
> [  374.081601]  #1: ffff88813d488bb8 (&fs_info->subvol_sem){+.+.}-{3:3}, at: btrfs_ioctl+0x38fd/0x71b0 [btrfs]
> [  374.094283]  #2: ffff888102dd4650 (sb_internal#2){.+.+}-{0:0}, at: btrfs_quota_disable+0xc8/0x9a0 [btrfs]
> [  374.106885]  #3: ffff88813d489800 (&fs_info->qgroup_ioctl_lock){+.+.}-{3:3}, at: btrfs_quota_disable+0xd5/0x9a0 [btrfs]
> 
> [  374.126780] =============================================
> 
> To avoid the deadlock, wait for the qgroup rescan worker to complete
> before starting the transaction for the quota disable ioctl. With
> current implementation, BTRFS_FS_QUOTA_ENABLE flag is cleared to request
> the qgroup rescan worker to complete. However, this flag can not be
> cleared before the transaction for quota disable. Then add and use a new
> flag BTRFS_FS_STATE_QUOTA_DISABLING instead. To avoid another new qgroup
> rescan worker to start after the previous qgroup worker completed, check
> the BTRFS_FS_STATE_QUOTA_DISABLING flag in qgroup_rescan_init.
> 
> Suggested-by: Naohiro Aota <naohiro.aota@wdc.com>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  fs/btrfs/ctree.h  |  2 ++
>  fs/btrfs/qgroup.c | 20 ++++++++++++++++++--
>  2 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index b4a9b1c58d22..fe275697e3eb 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -145,6 +145,8 @@ enum {
>  	BTRFS_FS_STATE_DUMMY_FS_INFO,
>  
>  	BTRFS_FS_STATE_NO_CSUMS,
> +	/* Quota is in disabling process */
> +	BTRFS_FS_STATE_QUOTA_DISABLING,

We had that already in the past, two bits handling quota state,
c2faff790ccd11ea5be8e "btrfs: remove BTRFS_FS_QUOTA_DISABLING flag".
It's not exactly the same change but reintroducing similar logic makes
me wonder what's wrong with the thread synchronization.
