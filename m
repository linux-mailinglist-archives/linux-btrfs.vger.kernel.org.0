Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498DC4D40CF
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Mar 2022 06:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239596AbiCJFaJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Mar 2022 00:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbiCJFaI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Mar 2022 00:30:08 -0500
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7FF7F82D3B
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 21:29:07 -0800 (PST)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 7539F248F04; Thu, 10 Mar 2022 00:29:06 -0500 (EST)
Date:   Thu, 10 Mar 2022 00:29:06 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     linux-btrfs@vger.kernel.org
Subject: Re: misc-next e9a9bca06a61: kernel BUG at fs/btrfs/tree-mod-log.c:675
Message-ID: <YimMonyFtN0uAWga@hungrycats.org>
References: <YhkelND6qnp+KmIC@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhkelND6qnp+KmIC@hungrycats.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 25, 2022 at 01:23:16PM -0500, Zygo Blaxell wrote:
> This BUG has popped up at the top of the "reasons why the bees test VM
> crashes" list for recent misc-next kernels:

This hasn't happened on misc-next since February 24 (e9a9bca06a61
"btrfs: fix relocation crash due to premature return from
btrfs_commit_transaction()"), but it still happens on for-next
(77848115626f "Merge branch 'for-next-current-v5.16-20220308' into
for-next-20220308)").

Same stack trace give or take a few bytes.  Happens a few times a day.

> 	tree_mod_log_rewind at fs/btrfs/tree-mod-log.c:675 (discriminator 1)
> 	 670                     * the modification. As we're going backwards, we do the
> 	 671                     * opposite of each operation here.
> 	 672                     */
> 	 673                    switch (tm->op) {
> 	 674                    case BTRFS_MOD_LOG_KEY_REMOVE_WHILE_FREEING:
> 	>675<                           BUG_ON(tm->slot < n);
> 	 676                            fallthrough;
> 	 677                    case BTRFS_MOD_LOG_KEY_REMOVE_WHILE_MOVING:
> 	 678                    case BTRFS_MOD_LOG_KEY_REMOVE:
> 	 679                            btrfs_set_node_key(eb, &tm->key, tm->slot);
> 	 680                            btrfs_set_node_blockptr(eb, tm->slot, tm->blockptr);
> 
> 	[ 7416.656802][ T7997] ------------[ cut here ]------------
> 	[ 7416.657693][ T7997] kernel BUG at fs/btrfs/tree-mod-log.c:675!
> 	[ 7416.658650][ T7997] invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> 	[ 7416.666264][ T7997] CPU: 3 PID: 7997 Comm: task_consumer Not tainted 5.17.0-d1488a11d91d-misc-next+ #152 eb204dc08d2451c7ad8df3b8b5e78e07ac47b04e
> 	[ 7416.669261][ T7997] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
> 	[ 7416.671103][ T7997] RIP: 0010:tree_mod_log_rewind+0x3d8/0x3e0
> 	[ 7416.672150][ T7997] Code: ff e9 b1 fd ff ff 41 83 ee 01 e9 a8 fd ff ff 4d 8d 6c 24 2c 4c 89 ef e8 c6 7b b0 ff 49 63 44 24 2c 44 39 f0 0f 83 f1 fc ff ff <0f> 0b 0f 0b 0f 1f 40 00 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 4c
> 	[ 7416.675084][ T7997] RSP: 0018:ffffc90007b1f2b0 EFLAGS: 00010293
> 	[ 7416.675939][ T7997] RAX: 0000000000000000 RBX: ffff88813a353ae0 RCX: dffffc0000000000
> 	[ 7416.677060][ T7997] RDX: 0000000000000007 RSI: 0000000000000008 RDI: ffff88811988102c
> 	[ 7416.678199][ T7997] RBP: ffffc90007b1f300 R08: ffffffff99a7e72a R09: ffff88800b67b085
> 	[ 7416.679359][ T7997] R10: ffffed10016cf610 R11: 0000000000000001 R12: ffff888119881000
> 	[ 7416.680523][ T7997] R13: ffff88811988102c R14: 0000000000000002 R15: ffff8881b400cd18
> 	[ 7416.681652][ T7997] FS:  00007f324ae58640(0000) GS:ffff8881f6e00000(0000) knlGS:0000000000000000
> 	[ 7416.682920][ T7997] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 	[ 7416.683939][ T7997] CR2: 00007f72df25f2c0 CR3: 0000000124eb0001 CR4: 0000000000170ee0
> 	[ 7416.685136][ T7997] Call Trace:
> 	[ 7416.685600][ T7997]  <TASK>
> 	[ 7416.686020][ T7997]  btrfs_get_old_root+0x3d9/0x640
> 	[ 7416.686729][ T7997]  ? lock_downgrade+0x420/0x420
> 	[ 7416.687452][ T7997]  ? rcu_read_lock_sched_held+0x16/0x80
> 	[ 7416.688250][ T7997]  btrfs_search_old_slot+0x190/0x540
> 	[ 7416.689019][ T7997]  ? release_extent_buffer+0x1d2/0x290
> 	[ 7416.689794][ T7997]  ? btrfs_search_slot+0x1420/0x1420
> 	[ 7416.690522][ T7997]  ? free_extent_buffer.part.0+0xd3/0x140
> 	[ 7416.691476][ T7997]  ? free_extent_buffer+0x13/0x20
> 	[ 7416.692195][ T7997]  find_parent_nodes+0xcdd/0x2860
> 	[ 7416.692977][ T7997]  ? __stack_depot_save+0x36/0x490
> 	[ 7416.693697][ T7997]  ? kasan_save_stack+0x3a/0x50
> 	[ 7416.694379][ T7997]  ? add_prelim_ref.part.0+0x140/0x140
> 	[ 7416.696069][ T7997]  ? finish_task_switch.isra.0+0x251/0x580
> 	[ 7416.698276][ T7997]  ? entry_SYSCALL_64_after_hwframe+0x44/0xae
> 	[ 7416.699244][ T7997]  ? lock_release+0xcf/0x8b0
> 	[ 7416.701147][ T7997]  ? fs_reclaim_acquire+0x67/0xf0
> 	[ 7416.703322][ T7997]  ? lock_downgrade+0x420/0x420
> 	[ 7416.704034][ T7997]  ? io_schedule_timeout+0xd0/0xd0
> 	[ 7416.704778][ T7997]  ? __might_resched+0x129/0x1c0
> 	[ 7416.705516][ T7997]  ? trace_kmalloc+0x2e/0xd0
> 	[ 7416.706188][ T7997]  ? kmem_cache_alloc_trace+0x220/0x470
> 	[ 7416.707034][ T7997]  btrfs_find_all_roots_safe+0x14c/0x1f0
> 	[ 7416.707841][ T7997]  ? find_parent_nodes+0x2860/0x2860
> 	[ 7416.708619][ T7997]  ? ulist_free+0x95/0xb0
> 	[ 7416.709242][ T7997]  ? btrfs_flush_workqueue+0x60/0x60
> 	[ 7416.710008][ T7997]  iterate_extent_inodes+0x27e/0x450
> 	[ 7416.710782][ T7997]  ? tree_backref_for_extent+0x240/0x240
> 	[ 7416.711589][ T7997]  ? do_raw_spin_unlock+0xad/0x110
> 	[ 7416.712332][ T7997]  ? preempt_count_sub+0x18/0xc0
> 	[ 7416.713038][ T7997]  ? _raw_spin_unlock+0x2d/0x50
> 	[ 7416.713718][ T7997]  ? release_extent_buffer+0x1d2/0x290
> 	[ 7416.714499][ T7997]  ? free_extent_buffer.part.0+0x8d/0x140
> 	[ 7416.715308][ T7997]  ? free_extent_buffer+0x13/0x20
> 	[ 7416.716030][ T7997]  iterate_inodes_from_logical+0x12f/0x180
> 	[ 7416.716868][ T7997]  ? btrfs_flush_workqueue+0x60/0x60
> 	[ 7416.717613][ T7997]  ? iterate_extent_inodes+0x450/0x450
> 	[ 7416.718404][ T7997]  ? __vmalloc_node+0x91/0xa0
> 	[ 7416.719081][ T7997]  ? paths_from_inode+0x450/0x510
> 	[ 7416.719798][ T7997]  ? kvmalloc_node+0x73/0x80
> 	[ 7416.720461][ T7997]  btrfs_ioctl_logical_to_ino+0x1b1/0x240
> 	[ 7416.721281][ T7997]  btrfs_ioctl+0x2a96/0x3ed0
> 	[ 7416.721939][ T7997]  ? rcu_read_lock_sched_held+0x16/0x80
> 	[ 7416.722739][ T7997]  ? lock_release+0xcf/0x8b0
> 	[ 7416.723392][ T7997]  ? __might_fault+0x62/0xd0
> 	[ 7416.724053][ T7997]  ? btrfs_ioctl_get_supported_features+0x30/0x30
> 	[ 7416.725038][ T7997]  ? do_vfs_ioctl+0x5a8/0xcc0
> 	[ 7416.725698][ T7997]  ? vfs_fileattr_set+0x520/0x520
> 	[ 7416.726421][ T7997]  ? rcu_read_lock_sched_held+0x16/0x80
> 	[ 7416.727343][ T7997]  ? lock_release+0xcf/0x8b0
> 	[ 7416.728159][ T7997]  ? __fget_files+0x14f/0x230
> 	[ 7416.729011][ T7997]  ? lock_downgrade+0x420/0x420
> 	[ 7416.729914][ T7997]  ? getrusage+0xa00/0xa00
> 	[ 7416.730733][ T7997]  ? __fget_files+0x167/0x230
> 	[ 7416.731612][ T7997]  ? __fget_light+0x72/0x100
> 	[ 7416.732469][ T7997]  __x64_sys_ioctl+0xc3/0x100
> 	[ 7416.733166][ T7997]  do_syscall_64+0x5c/0xc0
> 	[ 7416.733796][ T7997]  ? do_syscall_64+0x69/0xc0
> 	[ 7416.734446][ T7997]  ? lockdep_hardirqs_on_prepare+0x13/0x240
> 	[ 7416.735289][ T7997]  ? syscall_exit_to_user_mode+0x20/0x50
> 	[ 7416.736093][ T7997]  ? do_syscall_64+0x69/0xc0
> 	[ 7416.736743][ T7997]  ? rcu_read_lock_sched_held+0x16/0x80
> 	[ 7416.737535][ T7997]  ? syscall_exit_to_user_mode+0x20/0x50
> 	[ 7416.738338][ T7997]  ? lockdep_hardirqs_on_prepare+0x13/0x240
> 	[ 7416.739181][ T7997]  ? syscall_exit_to_user_mode+0x3b/0x50
> 	[ 7416.739983][ T7997]  ? do_syscall_64+0x69/0xc0
> 	[ 7416.740633][ T7997]  ? sysvec_call_function_single+0x57/0xc0
> 	[ 7416.741510][ T7997]  ? asm_sysvec_call_function_single+0xa/0x20
> 	[ 7416.742382][ T7997]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 	[ 7416.743228][ T7997] RIP: 0033:0x7f324b755a97
> 	[ 7416.743862][ T7997] Code: 3c 1c e8 1c ff ff ff 85 c0 79 87 49 c7 c4 ff ff ff ff 5b 5d 4c 89 e0 41 5c c3 66 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a9 93 0c 00 f7 d8 64 89 01 48
> 	[ 7416.746656][ T7997] RSP: 002b:00007f324ae542f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> 	[ 7416.747861][ T7997] RAX: ffffffffffffffda RBX: 000055a4c3234dd0 RCX: 00007f324b755a97
> 	[ 7416.748997][ T7997] RDX: 00007f324ae54698 RSI: 00000000c038943b RDI: 0000000000000003
> 	[ 7416.750134][ T7997] RBP: 00007f324ae544d0 R08: 0000000000000000 R09: 00007f324ae54780
> 	[ 7416.751272][ T7997] R10: 00007f32381b6e10 R11: 0000000000000246 R12: 00007f324ae54690
> 	[ 7416.752411][ T7997] R13: 0000000000000003 R14: 00007f324ae54698 R15: 00007f324ae54538
> 	[ 7416.753555][ T7997]  </TASK>
> 	[ 7416.753988][ T7997] Modules linked in:
> 	[ 7416.754621][ T7997] ---[ end trace 0000000000000000 ]---
> 	[ 7416.755469][ T7997] RIP: 0010:tree_mod_log_rewind+0x3d8/0x3e0
> 	[ 7416.756333][ T7997] Code: ff e9 b1 fd ff ff 41 83 ee 01 e9 a8 fd ff ff 4d 8d 6c 24 2c 4c 89 ef e8 c6 7b b0 ff 49 63 44 24 2c 44 39 f0 0f 83 f1 fc ff ff <0f> 0b 0f 0b 0f 1f 40 00 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 4c
> 	[ 7416.759158][ T7997] RSP: 0018:ffffc90007b1f2b0 EFLAGS: 00010293
> 	[ 7416.760054][ T7997] RAX: 0000000000000000 RBX: ffff88813a353ae0 RCX: dffffc0000000000
> 	[ 7416.761209][ T7997] RDX: 0000000000000007 RSI: 0000000000000008 RDI: ffff88811988102c
> 	[ 7416.762393][ T7997] RBP: ffffc90007b1f300 R08: ffffffff99a7e72a R09: ffff88800b67b085
> 	[ 7416.763936][ T7997] R10: ffffed10016cf610 R11: 0000000000000001 R12: ffff888119881000
> 	[ 7416.765346][ T7997] R13: ffff88811988102c R14: 0000000000000002 R15: ffff8881b400cd18
> 	[ 7416.766568][ T7997] FS:  00007f324ae58640(0000) GS:ffff8881f6e00000(0000) knlGS:0000000000000000
> 	[ 7416.767923][ T7997] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 	[ 7416.768916][ T7997] CR2: 00007f72df25f2c0 CR3: 0000000124eb0001 CR4: 0000000000170ee0
> 
