Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CF45159CB
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Apr 2022 04:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382003AbiD3CbF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 22:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240220AbiD3CbF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 22:31:05 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 627668165B
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 19:27:44 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id B4446311967; Fri, 29 Apr 2022 22:27:08 -0400 (EDT)
Date:   Fri, 29 Apr 2022 22:27:08 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     linux-btrfs@vger.kernel.org
Subject: misc-next 6a43055c266e: assertion failed: ret != -EEXIST, in
 fs/btrfs/tree-log.c:3857
Message-ID: <YmyefE9mc2xl5ZMz@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Running my usual "run everything at once" test...

	assertion failed: ret != -EEXIST, in fs/btrfs/tree-log.c:3857
	[198255.980839][ T7460] ------------[ cut here ]------------
	[198255.981666][ T7460] kernel BUG at fs/btrfs/ctree.h:3617!
	[198255.983141][ T7460] invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
	[198255.984080][ T7460] CPU: 0 PID: 7460 Comm: repro-ghost-dir Not tainted 5.18.0-5314c78ac373-misc-next+ #159 9f66820f9a8b6f20d808b7fbd7aaeab2c04eefe1
	[198255.986027][ T7460] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
	[198255.988600][ T7460] RIP: 0010:assertfail.constprop.0+0x1c/0x1e
	[198255.989465][ T7460] Code: 8b 4c 89 ef e8 a7 26 ff ff e9 cf 79 dd fe 55 89 f1 48 c7 c2 40 a3 4f 8b 48 89 fe 48 c7 c7 80 a3 4f 8b 48 89 e5 e8 ec 7e fd ff <0f> 0b e8 47 88 96 fe be a7 0e 00 00 48 c7 c7 20 a4 4f 8b e8 cc ff
	[198255.992599][ T7460] RSP: 0018:ffffc90007387188 EFLAGS: 00010282
	[198255.993414][ T7460] RAX: 000000000000003d RBX: 0000000000000065 RCX: 0000000000000000
	[198255.996056][ T7460] RDX: 0000000000000001 RSI: ffffffff8b62b180 RDI: fffff52000e70e24
	[198255.997668][ T7460] RBP: ffffc90007387188 R08: 000000000000003d R09: ffff8881f0e16507
	[198255.999199][ T7460] R10: ffffed103e1c2ca0 R11: 0000000000000001 R12: 00000000ffffffef
	[198256.000683][ T7460] R13: ffff88813befc630 R14: ffff888116c16e70 R15: ffffc90007387358
	[198256.007082][ T7460] FS:  00007fc7f7c24640(0000) GS:ffff8881f0c00000(0000) knlGS:0000000000000000
	[198256.009939][ T7460] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	[198256.014133][ T7460] CR2: 0000560bb16d0b78 CR3: 0000000140b34005 CR4: 0000000000170ef0
	[198256.015239][ T7460] Call Trace:
	[198256.015674][ T7460]  <TASK>
	[198256.016313][ T7460]  log_dir_items.cold+0x16/0x2c
	[198256.018858][ T7460]  ? replay_one_extent+0xbf0/0xbf0
	[198256.025932][ T7460]  ? release_extent_buffer+0x1d2/0x270
	[198256.029658][ T7460]  ? rcu_read_lock_sched_held+0x16/0x80
	[198256.031114][ T7460]  ? lock_acquired+0xbe/0x660
	[198256.032633][ T7460]  ? rcu_read_lock_sched_held+0x16/0x80
	[198256.034386][ T7460]  ? lock_release+0xcf/0x8a0
	[198256.036152][ T7460]  log_directory_changes+0xf9/0x170
	[198256.036993][ T7460]  ? log_dir_items+0xba0/0xba0
	[198256.037661][ T7460]  ? do_raw_write_unlock+0x7d/0xe0
	[198256.038680][ T7460]  btrfs_log_inode+0x233b/0x26d0
	[198256.041294][ T7460]  ? log_directory_changes+0x170/0x170
	[198256.042864][ T7460]  ? btrfs_attach_transaction_barrier+0x60/0x60
	[198256.045130][ T7460]  ? rcu_read_lock_sched_held+0x16/0x80
	[198256.046568][ T7460]  ? lock_release+0xcf/0x8a0
	[198256.047504][ T7460]  ? lock_downgrade+0x420/0x420
	[198256.048712][ T7460]  ? ilookup5_nowait+0x81/0xa0
	[198256.049747][ T7460]  ? lock_downgrade+0x420/0x420
	[198256.050652][ T7460]  ? do_raw_spin_unlock+0xa9/0x100
	[198256.051618][ T7460]  ? __might_resched+0x128/0x1c0
	[198256.052511][ T7460]  ? __might_sleep+0x66/0xc0
	[198256.053442][ T7460]  ? __kasan_check_read+0x11/0x20
	[198256.054251][ T7460]  ? iget5_locked+0xbd/0x150
	[198256.054986][ T7460]  ? run_delayed_iput_locked+0x110/0x110
	[198256.055929][ T7460]  ? btrfs_iget+0xc7/0x150
	[198256.056630][ T7460]  ? btrfs_orphan_cleanup+0x4a0/0x4a0
	[198256.057502][ T7460]  ? free_extent_buffer+0x13/0x20
	[198256.058322][ T7460]  btrfs_log_inode+0x2654/0x26d0
	[198256.059137][ T7460]  ? log_directory_changes+0x170/0x170
	[198256.060020][ T7460]  ? rcu_read_lock_sched_held+0x16/0x80
	[198256.060930][ T7460]  ? rcu_read_lock_sched_held+0x16/0x80
	[198256.061905][ T7460]  ? lock_contended+0x770/0x770
	[198256.062682][ T7460]  ? btrfs_log_inode_parent+0xd04/0x1750
	[198256.063582][ T7460]  ? lock_downgrade+0x420/0x420
	[198256.064432][ T7460]  ? preempt_count_sub+0x18/0xc0
	[198256.065550][ T7460]  ? __mutex_lock+0x580/0xdc0
	[198256.066654][ T7460]  ? stack_trace_save+0x94/0xc0
	[198256.068008][ T7460]  ? __kasan_check_write+0x14/0x20
	[198256.072149][ T7460]  ? __mutex_unlock_slowpath+0x12a/0x430
	[198256.073145][ T7460]  ? mutex_lock_io_nested+0xcd0/0xcd0
	[198256.074341][ T7460]  ? wait_for_completion_io_timeout+0x20/0x20
	[198256.075345][ T7460]  ? lock_downgrade+0x420/0x420
	[198256.076142][ T7460]  ? lock_contended+0x770/0x770
	[198256.076939][ T7460]  ? do_raw_spin_lock+0x1c0/0x1c0
	[198256.078401][ T7460]  ? btrfs_sync_file+0x5e6/0xa40
	[198256.080598][ T7460]  btrfs_log_inode_parent+0x523/0x1750
	[198256.081991][ T7460]  ? wait_current_trans+0xc8/0x240
	[198256.083320][ T7460]  ? lock_downgrade+0x420/0x420
	[198256.085450][ T7460]  ? btrfs_end_log_trans+0x70/0x70
	[198256.086362][ T7460]  ? rcu_read_lock_sched_held+0x16/0x80
	[198256.087544][ T7460]  ? lock_release+0xcf/0x8a0
	[198256.088305][ T7460]  ? lock_downgrade+0x420/0x420
	[198256.090375][ T7460]  ? dget_parent+0x8e/0x300
	[198256.093538][ T7460]  ? do_raw_spin_lock+0x1c0/0x1c0
	[198256.094918][ T7460]  ? lock_downgrade+0x420/0x420
	[198256.097815][ T7460]  ? do_raw_spin_unlock+0xa9/0x100
	[198256.101822][ T7460]  ? dget_parent+0xb7/0x300
	[198256.103345][ T7460]  btrfs_log_dentry_safe+0x48/0x60
	[198256.105052][ T7460]  btrfs_sync_file+0x629/0xa40
	[198256.106829][ T7460]  ? start_ordered_ops.constprop.0+0x120/0x120
	[198256.109655][ T7460]  ? __fget_files+0x161/0x230
	[198256.110760][ T7460]  vfs_fsync_range+0x6d/0x110
	[198256.111923][ T7460]  ? start_ordered_ops.constprop.0+0x120/0x120
	[198256.113556][ T7460]  __x64_sys_fsync+0x45/0x70
	[198256.114323][ T7460]  do_syscall_64+0x5c/0xc0
	[198256.115084][ T7460]  ? syscall_exit_to_user_mode+0x3b/0x50
	[198256.116030][ T7460]  ? do_syscall_64+0x69/0xc0
	[198256.116768][ T7460]  ? do_syscall_64+0x69/0xc0
	[198256.117555][ T7460]  ? do_syscall_64+0x69/0xc0
	[198256.118324][ T7460]  ? sysvec_call_function_single+0x57/0xc0
	[198256.119308][ T7460]  ? asm_sysvec_call_function_single+0xa/0x20
	[198256.120363][ T7460]  entry_SYSCALL_64_after_hwframe+0x44/0xae
	[198256.121334][ T7460] RIP: 0033:0x7fc7fe97b6ab
	[198256.122067][ T7460] Code: 0f 05 48 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8 53 f7 ff ff 8b 7c 24 0c 41 89 c0 b8 4a 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 b1 f7 ff ff 8b 44
	[198256.125198][ T7460] RSP: 002b:00007fc7f7c23950 EFLAGS: 00000293 ORIG_RAX: 000000000000004a
	[198256.126568][ T7460] RAX: ffffffffffffffda RBX: 00007fc7f7c239f0 RCX: 00007fc7fe97b6ab
	[198256.127942][ T7460] RDX: 0000000000000002 RSI: 000056167536bcf0 RDI: 0000000000000004
	[198256.129302][ T7460] RBP: 0000000000000004 R08: 0000000000000000 R09: 000000007ffffeb8
	[198256.130670][ T7460] R10: 00000000000001ff R11: 0000000000000293 R12: 0000000000000001
	[198256.132046][ T7460] R13: 0000561674ca8140 R14: 00007fc7f7c239d0 R15: 000056167536dab8
	[198256.133403][ T7460]  </TASK>


   3847                         if (key.offset > *last_old_dentry_offset + 1) {
   3848                                 ret = insert_dir_log_key(trans, log, dst_path,
   3849                                                  ino, *last_old_dentry_offset + 1,
   3850                                                  key.offset - 1);
   3851                                 /*
   3852                                  * -EEXIST should never happen because when we
   3853                                  * log a directory in full mode (LOG_INODE_ALL)
   3854                                  * we drop all BTRFS_DIR_LOG_INDEX_KEY keys from
   3855                                  * the log tree.
   3856                                  */
  >3857<                                ASSERT(ret != -EEXIST);
   3858                                 if (ret < 0)
   3859                                         return ret;
   3860                         }

