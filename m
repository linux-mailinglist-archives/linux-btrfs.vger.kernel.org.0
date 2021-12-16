Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF154769A1
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Dec 2021 06:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhLPFdG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Dec 2021 00:33:06 -0500
Received: from drax.kayaks.hungrycats.org ([174.142.148.226]:48658 "EHLO
        drax.kayaks.hungrycats.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231372AbhLPFdG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Dec 2021 00:33:06 -0500
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 26A5CE9BA0; Thu, 16 Dec 2021 00:33:05 -0500 (EST)
Date:   Thu, 16 Dec 2021 00:33:05 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: bisected: btrfs dedupe regression in v5.11-rc1: 3078d85c9a10
 vfs: verify source area in vfs_dedupe_file_range_one()
Message-ID: <YbrPkZVC/MazdQdc@hungrycats.org>
References: <20211210183456.GP17148@hungrycats.org>
 <25f4d4fd-1727-1c9f-118a-150d9c263c93@suse.com>
 <YbfTYFQVGCU0Whce@hungrycats.org>
 <fc395aed-2cbd-f6e5-d167-632c14a07188@suse.com>
 <Ybj1jVYu3MrUzVTD@hungrycats.org>
 <c6125582-a1dc-1114-8211-48437dbf4976@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6125582-a1dc-1114-8211-48437dbf4976@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 15, 2021 at 12:25:04AM +0200, Nikolay Borisov wrote:
> Huhz, this means there is an open transaction handle somewhere o_O. I
> checked back the stacktraces in your original email but couldn't see
> where that might be coming from. I.e all processes are waiting on
> wait_current_trans and this happens _before_ the transaction handle is
> opened, hence num_extwriters can't have been incremented by them.
> 
> When an fs wedges, and you get again num_extwriters can you provde the
> output of "echo w > /proc/sysrq-trigger"

Here you go...

	# drgn -s vmlinux ~/bin/get-num-extwriters.py f79c1081-d81d-4abc-8b47-3b15bf2f93c5
	[f79c1081-d81d-4abc-8b47-3b15bf2f93c5] num_extwriters is: 1

	[30557.917447][ T3230] sysrq: Show Blocked State
	[30557.925266][ T3230] task:btrfs-transacti state:D stack:    0 pid:10552 ppid:     2 flags:0x00004000
	[30557.926479][ T3230] Call Trace:
	[30557.928165][ T3230]  __schedule+0x351/0xaa0
	[30557.928775][ T3230]  schedule+0x68/0xe0
	[30557.930092][ T3230]  btrfs_commit_transaction+0x814/0xbb0

	0xffffffff81576bf4 is in btrfs_commit_transaction (fs/btrfs/transaction.c:2164).
	2159
	2160            ret = btrfs_run_delayed_items(trans);
	2161            if (ret)
	2162                    goto cleanup_transaction;
	2163
	2164            wait_event(cur_trans->writer_wait,
	2165                       extwriter_counter_read(cur_trans) == 0);
	2166
	2167            /* some pending stuffs might be added after the previous flush. */
	2168            ret = btrfs_run_delayed_items(trans);

	[30557.930795][ T3230]  ? start_transaction+0xd5/0x6f0
	[30557.932200][ T3230]  ? add_wait_queue_exclusive+0x80/0x80
	[30557.932933][ T3230]  transaction_kthread+0x138/0x1b0
	[30557.933653][ T3230]  kthread+0x151/0x170
	[30557.934248][ T3230]  ? btrfs_cleanup_transaction.isra.0+0x620/0x620
	[30557.935096][ T3230]  ? kthread_create_worker_on_cpu+0x70/0x70
	[30557.935911][ T3230]  ret_from_fork+0x22/0x30
	[30557.936476][ T3230] task:crawl_5_263     state:D stack:    0 pid:10874 ppid: 10762 flags:0x00000000
	[30557.937707][ T3230] Call Trace:
	[30557.938180][ T3230]  __schedule+0x351/0xaa0
	[30557.938714][ T3230]  schedule+0x68/0xe0
	[30557.939224][ T3230]  wait_current_trans+0xed/0x150

	wait_current_trans at fs/btrfs/transaction.c:526 (discriminator 19)
	 521            cur_trans = fs_info->running_transaction;
	 522            if (cur_trans && is_transaction_blocked(cur_trans)) {
	 523                    refcount_inc(&cur_trans->use_count);
	 524                    spin_unlock(&fs_info->trans_lock);
	 525    
	>526<                   wait_event(fs_info->transaction_wait,
	 527                               cur_trans->state >= TRANS_STATE_UNBLOCKED ||
	 528                               TRANS_ABORTED(cur_trans));
	 529                    btrfs_put_transaction(cur_trans);
	 530            } else {
	 531                    spin_unlock(&fs_info->trans_lock);

	[30557.939834][ T3230]  ? add_wait_queue_exclusive+0x80/0x80
	[30557.940502][ T3230]  start_transaction+0x587/0x6f0
	[30557.941170][ T3230]  btrfs_start_transaction+0x1e/0x20
	[30557.941905][ T3230]  btrfs_replace_file_extents+0x12a/0x8d0
	[30557.942586][ T3230]  ? release_extent_buffer+0xae/0xf0
	[30557.943258][ T3230]  ? do_raw_spin_unlock+0x57/0xb0
	[30557.944211][ T3230]  btrfs_clone+0x7ea/0x880
	[30557.944857][ T3230]  btrfs_extent_same_range+0x75/0xa0
	[30557.945511][ T3230]  btrfs_remap_file_range+0x354/0x3c0
	[30557.946859][ T3230]  vfs_dedupe_file_range_one.part.0+0xc9/0x140
	[30557.947626][ T3230]  vfs_dedupe_file_range+0x186/0x210
	[30557.948434][ T3230]  do_vfs_ioctl+0x551/0x720
	[30557.949073][ T3230]  ? __fget_files+0x10c/0x1e0
	[30557.949636][ T3230]  __x64_sys_ioctl+0x6f/0xc0
	[30557.950382][ T3230]  do_syscall_64+0x38/0x90
	[30557.951024][ T3230]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
	[30557.951788][ T3230] RIP: 0033:0x7f0bd832ccc7
	[30557.952439][ T3230] RSP: 002b:00007f0bd5a26018 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
	[30557.953828][ T3230] RAX: ffffffffffffffda RBX: 00007f0bd5a26280 RCX: 00007f0bd832ccc7
	[30557.955254][ T3230] RDX: 00007f0bb401a920 RSI: 00000000c0189436 RDI: 000000000000000d
	[30557.956277][ T3230] RBP: 00007f0bb401a920 R08: 0000000000000000 R09: 00007f0bd5a26690
	[30557.957374][ T3230] R10: 00007ffd6836b080 R11: 0000000000000246 R12: 00007f0bb401a920
	[30557.958502][ T3230] R13: 00007f0bd5a26288 R14: 0000000000000000 R15: 00007f0bd5a262a8
	[30557.959603][ T3230] task:crawl_363_264   state:D stack:    0 pid:10876 ppid: 10762 flags:0x00000000
	[30557.960873][ T3230] Call Trace:
	[30557.961324][ T3230]  __schedule+0x351/0xaa0
	[30557.961947][ T3230]  schedule+0x68/0xe0
	[30557.962515][ T3230]  wait_current_trans+0xed/0x150
	[30557.963180][ T3230]  ? add_wait_queue_exclusive+0x80/0x80
	[30557.963884][ T3230]  start_transaction+0x37e/0x6f0
	[30557.964699][ T3230]  ? btrfs_inode_flags_to_xflags+0x50/0x50
	[30557.965469][ T3230]  btrfs_attach_transaction+0x1d/0x20
	[30557.966158][ T3230]  iterate_extent_inodes+0x7b/0x270
	[30557.966781][ T3230]  iterate_inodes_from_logical+0x9f/0xe0
	[30557.967568][ T3230]  ? btrfs_inode_flags_to_xflags+0x50/0x50
	[30557.968395][ T3230]  btrfs_ioctl_logical_to_ino+0x183/0x210
	[30557.969213][ T3230]  btrfs_ioctl+0xa81/0x2fb0
	[30557.970074][ T3230]  ? kvm_sched_clock_read+0x18/0x30
	[30557.971034][ T3230]  ? sched_clock+0x9/0x10
	[30557.971586][ T3230]  ? __fget_files+0xed/0x1e0
	[30557.972214][ T3230]  ? __fget_files+0x10c/0x1e0
	[30557.972929][ T3230]  __x64_sys_ioctl+0x91/0xc0
	[30557.973527][ T3230]  ? __x64_sys_ioctl+0x91/0xc0
	[30557.974147][ T3230]  do_syscall_64+0x38/0x90
	[30557.974689][ T3230]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
	[30557.975440][ T3230] RIP: 0033:0x7f0bd832ccc7
	[30557.976059][ T3230] RSP: 002b:00007f0bd4a24378 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
	[30557.977226][ T3230] RAX: ffffffffffffffda RBX: 000055ca79b80de0 RCX: 00007f0bd832ccc7
	[30557.978272][ T3230] RDX: 00007f0bd4a24718 RSI: 00000000c038943b RDI: 0000000000000003
	[30557.979266][ T3230] RBP: 00007f0bd4a24550 R08: 0000000000000000 R09: 00007f0bd4a24800
	[30557.980262][ T3230] R10: 0000071ac32defbe R11: 0000000000000246 R12: 00007f0bd4a24710
	[30557.981255][ T3230] R13: 0000000000000003 R14: 00007f0bd4a24718 R15: 00007f0bd4a24a58
	[30557.982262][ T3230] task:crawl_5_264     state:D stack:    0 pid:10878 ppid: 10762 flags:0x00000000
	[30557.983449][ T3230] Call Trace:
	[30557.983985][ T3230]  __schedule+0x351/0xaa0
	[30557.984522][ T3230]  ? rwsem_down_write_slowpath+0x254/0x510
	[30557.985336][ T3230]  schedule+0x68/0xe0
	[30557.985912][ T3230]  rwsem_down_write_slowpath+0x280/0x510
	[30557.986598][ T3230]  down_write+0xbd/0x120
	[30557.987132][ T3230]  lock_two_nondirectories+0x6b/0x70
	[30557.987786][ T3230]  btrfs_remap_file_range+0x54/0x3c0
	[30557.988452][ T3230]  vfs_dedupe_file_range_one.part.0+0xc9/0x140
	[30557.989231][ T3230]  vfs_dedupe_file_range+0x186/0x210
	[30557.989884][ T3230]  do_vfs_ioctl+0x551/0x720
	[30557.990452][ T3230]  ? __fget_files+0x10c/0x1e0
	[30557.991046][ T3230]  __x64_sys_ioctl+0x6f/0xc0
	[30557.991624][ T3230]  do_syscall_64+0x38/0x90
	[30557.992182][ T3230]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
	[30557.992933][ T3230] RIP: 0033:0x7f0bd832ccc7
	[30557.993455][ T3230] RSP: 002b:00007f0bd3a22018 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
	[30557.994531][ T3230] RAX: ffffffffffffffda RBX: 00007f0bd3a22280 RCX: 00007f0bd832ccc7
	[30557.995523][ T3230] RDX: 00007f0ba4454810 RSI: 00000000c0189436 RDI: 000000000000000d
	[30557.996500][ T3230] RBP: 00007f0ba4454810 R08: 0000000000000000 R09: 00007f0bd3a22690
	[30557.997492][ T3230] R10: 00007ffd6836b080 R11: 0000000000000246 R12: 00007f0ba4454810
	[30557.998465][ T3230] R13: 00007f0bd3a22288 R14: 0000000000000000 R15: 00007f0bd3a222a8
	[30557.999462][ T3230] task:crawl_362_264   state:D stack:    0 pid:10881 ppid: 10762 flags:0x00000000
	[30558.000568][ T3230] Call Trace:
	[30558.001025][ T3230]  __schedule+0x351/0xaa0
	[30558.001617][ T3230]  ? rwsem_down_write_slowpath+0x254/0x510
	[30558.002355][ T3230]  schedule+0x68/0xe0
	[30558.002887][ T3230]  rwsem_down_write_slowpath+0x280/0x510
	[30558.003589][ T3230]  down_write+0xbd/0x120
	[30558.004129][ T3230]  lock_two_nondirectories+0x6b/0x70
	[30558.004849][ T3230]  btrfs_remap_file_range+0x54/0x3c0
	[30558.005603][ T3230]  vfs_dedupe_file_range_one.part.0+0xc9/0x140
	[30558.006421][ T3230]  vfs_dedupe_file_range+0x186/0x210
	[30558.007126][ T3230]  do_vfs_ioctl+0x551/0x720
	[30558.007720][ T3230]  ? __fget_files+0x10c/0x1e0
	[30558.008371][ T3230]  __x64_sys_ioctl+0x6f/0xc0
	[30558.008977][ T3230]  do_syscall_64+0x38/0x90
	[30558.009507][ T3230]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
	[30558.010279][ T3230] RIP: 0033:0x7f0bd832ccc7
	[30558.010856][ T3230] RSP: 002b:00007f0bd2a20018 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
	[30558.011897][ T3230] RAX: ffffffffffffffda RBX: 00007f0bd2a20280 RCX: 00007f0bd832ccc7
	[30558.012897][ T3230] RDX: 00007f0b9c001630 RSI: 00000000c0189436 RDI: 000000000000000d
	[30558.013862][ T3230] RBP: 00007f0b9c001630 R08: 0000000000000000 R09: 00007f0bd2a20690
	[30558.014858][ T3230] R10: 00007ffd6836b080 R11: 0000000000000246 R12: 00007f0b9c001630
	[30558.015811][ T3230] R13: 00007f0bd2a20288 R14: 0000000000000000 R15: 00007f0bd2a202a8
	[30558.016794][ T3230] task:crawl_362_271   state:D stack:    0 pid:10882 ppid: 10762 flags:0x00000000
	[30558.017953][ T3230] Call Trace:
	[30558.018350][ T3230]  __schedule+0x351/0xaa0
	[30558.018913][ T3230]  schedule+0x68/0xe0
	[30558.019415][ T3230]  wait_current_trans+0xed/0x150
	[30558.020030][ T3230]  ? add_wait_queue_exclusive+0x80/0x80
	[30558.020717][ T3230]  start_transaction+0x587/0x6f0
	[30558.021345][ T3230]  btrfs_start_transaction+0x1e/0x20
	[30558.022018][ T3230]  btrfs_replace_file_extents+0x12a/0x8d0
	[30558.022698][ T3230]  ? release_extent_buffer+0xae/0xf0
	[30558.023351][ T3230]  ? do_raw_spin_unlock+0x57/0xb0
	[30558.024012][ T3230]  btrfs_clone+0x7ea/0x880
	[30558.024563][ T3230]  btrfs_extent_same_range+0x75/0xa0
	[30558.025231][ T3230]  btrfs_remap_file_range+0x354/0x3c0
	[30558.025935][ T3230]  vfs_dedupe_file_range_one.part.0+0xc9/0x140
	[30558.026670][ T3230]  vfs_dedupe_file_range+0x186/0x210
	[30558.027330][ T3230]  do_vfs_ioctl+0x551/0x720
	[30558.027916][ T3230]  ? __fget_files+0x10c/0x1e0
	[30558.028490][ T3230]  __x64_sys_ioctl+0x6f/0xc0
	[30558.029076][ T3230]  do_syscall_64+0x38/0x90
	[30558.029635][ T3230]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
	[30558.030379][ T3230] RIP: 0033:0x7f0bd832ccc7
	[30558.030960][ T3230] RSP: 002b:00007f0bd221f018 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
	[30558.031994][ T3230] RAX: ffffffffffffffda RBX: 00007f0bd221f280 RCX: 00007f0bd832ccc7
	[30558.032999][ T3230] RDX: 00007f0ba00d8e40 RSI: 00000000c0189436 RDI: 000000000000002b
	[30558.033992][ T3230] RBP: 00007f0ba00d8e40 R08: 0000000000000000 R09: 00007f0bd221f690
	[30558.035085][ T3230] R10: 00007ffd6836b080 R11: 0000000000000246 R12: 00007f0ba00d8e40
	[30558.036082][ T3230] R13: 00007f0bd221f288 R14: 0000000000000000 R15: 00007f0bd221f2a8
	[30560.726926][ T3230] sysrq: Show Locks Held
	[30560.727574][ T3230] 
	[30560.727574][ T3230] Showing all locks held in the system:
	[30560.728542][ T3230] 1 lock held by in:imklog/3104:
	[30560.729188][ T3230]  #0: ffff93d190807580 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x4e/0x60
	[30560.730302][ T3230] 1 lock held by dmesg/3228:
	[30560.730882][ T3230]  #0: ffff93d185b780e0 (&user->lock){+.+.}-{3:3}, at: devkmsg_read+0x4d/0x330
	[30560.731996][ T3230] 3 locks held by bash/3230:
	[30560.732557][ T3230]  #0: ffff93d1b2d73498 (sb_writers#4){.+.+}-{0:0}, at: ksys_write+0x70/0xf0
	[30560.733866][ T3230]  #1: ffffffffbcf189a0 (rcu_read_lock){....}-{1:2}, at: __handle_sysrq+0x5/0xa0
	[30560.735609][ T3230]  #2: ffffffffbcf189a0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x23/0x187
	[30560.737510][ T3230] 1 lock held by btrfs-transacti/10552:
	[30560.738261][ T3230]  #0: ffff93d195e94850 (&fs_info->transaction_kthread_mutex){+.+.}-{3:3}, at: transaction_kthread+0x5a/0x1b0
	[30560.740014][ T3230] 4 locks held by crawl_5_263/10874:
	[30560.740854][ T3230]  #0: ffff93d258223498 (sb_writers#12){.+.+}-{0:0}, at: vfs_dedupe_file_range+0x162/0x210
	[30560.742405][ T3230]  #1: ffff93d241751c88 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: lock_two_nondirectories+0x6b/0x70
	[30560.744153][ T3230]  #2: ffff93d2f3354988 (&sb->s_type->i_mutex_key#17/4){+.+.}-{3:3}, at: lock_two_nondirectories+0x59/0x70
	[30560.745953][ T3230]  #3: ffff93d2582236b8 (sb_internal#2){.+.+}-{0:0}, at: btrfs_start_transaction+0x1e/0x20
	[30560.747557][ T3230] 2 locks held by crawl_5_264/10878:
	[30560.748420][ T3230]  #0: ffff93d258223498 (sb_writers#12){.+.+}-{0:0}, at: vfs_dedupe_file_range+0x162/0x210
	[30560.750060][ T3230]  #1: ffff93d241751c88 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: lock_two_nondirectories+0x6b/0x70
	[30560.751892][ T3230] 2 locks held by crawl_362_264/10881:
	[30560.752761][ T3230]  #0: ffff93d258223498 (sb_writers#12){.+.+}-{0:0}, at: vfs_dedupe_file_range+0x162/0x210
	[30560.754424][ T3230]  #1: ffff93d241751c88 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: lock_two_nondirectories+0x6b/0x70
	[30560.756327][ T3230] 4 locks held by crawl_362_271/10882:
	[30560.757268][ T3230]  #0: ffff93d258223498 (sb_writers#12){.+.+}-{0:0}, at: vfs_dedupe_file_range+0x162/0x210
	[30560.758971][ T3230]  #1: ffff93d1159c5648 (&sb->s_type->i_mutex_key#17){+.+.}-{3:3}, at: lock_two_nondirectories+0x6b/0x70
	[30560.760890][ T3230]  #2: ffff93d1356ef688 (&sb->s_type->i_mutex_key#17/4){+.+.}-{3:3}, at: lock_two_nondirectories+0x59/0x70
	[30560.762839][ T3230]  #3: ffff93d2582236b8 (sb_internal#2){.+.+}-{0:0}, at: btrfs_start_transaction+0x1e/0x20
	[30560.764554][ T3230] 3 locks held by crawl_362_267/10883:

	[30560.765496][ T3230] 
	[30560.765893][ T3230] =============================================
	[30560.765893][ T3230] 

Again we have "3 locks held" but no list of locks.  WTF is 10883 doing?
Well, first of all it's using 100% CPU in the kernel.  Some samples of
kernel stacks:

	# cat /proc/*/task/10883/stack
	[<0>] down_read_nested+0x32/0x140
	[<0>] __btrfs_tree_read_lock+0x2d/0x110
	[<0>] btrfs_tree_read_lock+0x10/0x20
	[<0>] btrfs_search_old_slot+0x627/0x8a0
	[<0>] btrfs_next_old_leaf+0xcb/0x340
	[<0>] find_parent_nodes+0xcd7/0x1c40
	[<0>] btrfs_find_all_leafs+0x63/0xb0
	[<0>] iterate_extent_inodes+0xc8/0x270
	[<0>] iterate_inodes_from_logical+0x9f/0xe0
	[<0>] btrfs_ioctl_logical_to_ino+0x183/0x210
	[<0>] btrfs_ioctl+0xa81/0x2fb0
	[<0>] __x64_sys_ioctl+0x91/0xc0
	[<0>] do_syscall_64+0x38/0x90
	[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
	# cat /proc/*/task/10883/stack
	# cat /proc/*/task/10883/stack
	[<0>] __tree_mod_log_rewind+0x57/0x250
	# cat /proc/*/task/10883/stack
	[<0>] __tree_mod_log_rewind+0x57/0x250
	# cat /proc/*/task/10883/stack
	# cat /proc/*/task/10883/stack
	[<0>] __tree_mod_log_rewind+0x57/0x250
	# cat /proc/*/task/10883/stack
	[<0>] __tree_mod_log_rewind+0x57/0x250
	# cat /proc/*/task/10883/stack
	[<0>] __tree_mod_log_rewind+0x57/0x250
	# cat /proc/*/task/10883/stack
	[<0>] __tree_mod_log_rewind+0x57/0x250
	# cat /proc/*/task/10883/stack
	# cat /proc/*/task/10883/stack
	[<0>] __tree_mod_log_rewind+0x57/0x250
	# cat /proc/*/task/10883/stack
	# cat /proc/*/task/10883/stack
	[<0>] __tree_mod_log_rewind+0x57/0x250
	# cat /proc/*/task/10883/stack
	[<0>] __tree_mod_log_rewind+0x57/0x250
	# cat /proc/*/task/10883/stack
	# cat /proc/*/task/10883/stack
	# cat /proc/*/task/10883/stack
	[<0>] free_extent_buffer.part.0+0x51/0xa0
	# cat /proc/*/task/10883/stack
	[<0>] find_held_lock+0x38/0x90
	[<0>] kmem_cache_alloc+0x22d/0x360
	[<0>] __alloc_extent_buffer+0x2a/0xa0
	[<0>] btrfs_clone_extent_buffer+0x42/0x130
	[<0>] btrfs_search_old_slot+0x660/0x8a0
	[<0>] btrfs_next_old_leaf+0xcb/0x340
	[<0>] find_parent_nodes+0xcd7/0x1c40
	[<0>] btrfs_find_all_leafs+0x63/0xb0
	[<0>] iterate_extent_inodes+0xc8/0x270
	[<0>] iterate_inodes_from_logical+0x9f/0xe0
	[<0>] btrfs_ioctl_logical_to_ino+0x183/0x210
	[<0>] btrfs_ioctl+0xa81/0x2fb0
	[<0>] __x64_sys_ioctl+0x91/0xc0
	[<0>] do_syscall_64+0x38/0x90
	[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

So it looks like tree mod log is doing some infinite (or very large
finite) looping in the LOGICAL_INO ioctl.  That ioctl holds a transaction
open while it runs, but it's not blocked per se, so it doesn't show up
in SysRq-W output.
