Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF0623252D
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jul 2020 21:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgG2TP3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jul 2020 15:15:29 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:38380 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgG2TP2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jul 2020 15:15:28 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 850B6788F14; Wed, 29 Jul 2020 15:15:27 -0400 (EDT)
Date:   Wed, 29 Jul 2020 15:15:27 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     linux-btrfs@vger.kernel.org
Subject: kernel BUG at fs/btrfs/ctree.c:1253 - v5.4.53 -
 __tree_mod_log_rewind BUG_ON(tm->slot >= n)
Message-ID: <20200729191527.GC8346@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Seen while running LOGICAL_INO and a metadata balance at the same time.
I guess there are still more bugs in tree mod log?

	[22558.599128][ T3766] BTRFS info (device dm-0): relocating block group 11457684045824 flags system|raid1
	[22567.704875][ T3766] BTRFS info (device dm-0): found 11 extents, loops 1, stage: move data extents
	[22577.304087][ T3766] BTRFS info (device dm-0): relocating block group 11453288415232 flags metadata|raid1
	[22682.812684][ T4527] ------------[ cut here ]------------
	[22682.813842][ T4527] kernel BUG at fs/btrfs/ctree.c:1253!
	[22682.814910][ T4527] invalid opcode: 0000 [#1] SMP KASAN PTI
	[22682.815971][ T4527] CPU: 3 PID: 4527 Comm: crawl_28443 Tainted: G        W         5.4.53-348c36959e76+ #47
	[22682.817770][ T4527] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
	[22682.819382][ T4527] RIP: 0010:__tree_mod_log_rewind+0x38f/0x3a0
	[22682.820556][ T4527] Code: 8d 74 10 65 ba 19 00 00 00 e8 1d 49 07 00 e9 b8 fd ff ff 4c 8d 7b 2c 4c 89 ff e8 fc 53 cd ff 48 63 43 2c e9 a2 fe ff ff 0f 0b <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 0f 1f 44 00 00
	[22682.823884][ T4527] RSP: 0018:ffff8881c6b26ef8 EFLAGS: 00010206
	[22682.824915][ T4527] RAX: 0000000000000013 RBX: ffff8881484f2500 RCX: ffffffff9e8006a5
	[22682.826275][ T4527] RDX: 0000000000000007 RSI: dffffc0000000000 RDI: ffff8881484f252c
	[22682.827628][ T4527] RBP: ffff8881c6b26f48 R08: 1ffff1101464ea1c R09: ffff8881c6b26e40
	[22682.829018][ T4527] R10: ffffed101464ea1b R11: ffff8880a32750d8 R12: 0000000000000010
	[22682.830390][ T4527] R13: ffff88801846c620 R14: ffff8881393fad00 R15: ffff8881484f252c
	[22682.831702][ T4527] FS:  00007f44e5ffe700(0000) GS:ffff8881f6000000(0000) knlGS:0000000000000000
	[22682.833169][ T4527] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	[22682.834289][ T4527] CR2: 00007ffd709c7e40 CR3: 00000001e0a64003 CR4: 00000000001606e0
	[22682.835611][ T4527] Call Trace:
	[22682.836156][ T4527]  btrfs_search_old_slot+0x1e9/0xfd0
	[22682.837037][ T4527]  ? __kasan_check_read+0x11/0x20
	[22682.837895][ T4527]  ? match_held_lock+0x20/0x260
	[22682.838724][ T4527]  ? btrfs_search_slot+0x1180/0x1180
	[22682.839622][ T4527]  ? release_extent_buffer+0x13b/0x230
	[22682.840551][ T4527]  ? free_extent_buffer.part.46+0xd7/0x140
	[22682.841539][ T4527]  resolve_indirect_refs+0x411/0x10a0
	[22682.842464][ T4527]  ? add_inline_refs.isra.9+0x450/0x450
	[22682.843409][ T4527]  ? lock_downgrade+0x3d0/0x3d0
	[22682.844278][ T4527]  ? __kasan_check_read+0x11/0x20
	[22682.845132][ T4527]  ? match_held_lock+0x20/0x260
	[22682.845987][ T4527]  ? do_raw_spin_unlock+0xa8/0x140
	[22682.846906][ T4527]  ? _raw_spin_unlock+0x27/0x40
	[22682.847786][ T4527]  ? release_extent_buffer+0x13b/0x230
	[22682.848775][ T4527]  ? __kasan_check_write+0x14/0x20
	[22682.849697][ T4527]  ? free_extent_buffer.part.46+0x90/0x140
	[22682.850750][ T4527]  ? free_extent_buffer+0x13/0x20
	[22682.851657][ T4527]  find_parent_nodes+0x5d0/0x15a0
	[22682.852567][ T4527]  ? ksys_ioctl+0x67/0x90
	[22682.853347][ T4527]  ? __x64_sys_ioctl+0x43/0x50
	[22682.854214][ T4527]  ? resolve_indirect_refs+0x10a0/0x10a0
	[22682.855276][ T4527]  ? kvm_sched_clock_read+0x18/0x30
	[22682.856247][ T4527]  ? check_chain_key+0x1e6/0x2e0
	[22682.857172][ T4527]  ? sched_clock_cpu+0x1b/0x120
	[22682.858080][ T4527]  ? __kasan_check_read+0x11/0x20
	[22682.859021][ T4527]  ? rcu_read_lock_sched_held+0xa1/0xd0
	[22682.860057][ T4527]  ? debug_lockdep_rcu_enabled.part.18+0x1a/0x30
	[22682.861244][ T4527]  ? btrfs_inode_flags_to_xflags+0x50/0x50
	[22682.862332][ T4527]  iterate_extent_inodes+0x173/0x590
	[22682.863326][ T4527]  ? tree_backref_for_extent+0x230/0x230
	[22682.864359][ T4527]  ? lock_downgrade+0x3d0/0x3d0
	[22682.865233][ T4527]  ? __kasan_check_read+0x11/0x20
	[22682.866145][ T4527]  ? match_held_lock+0x20/0x260
	[22682.867025][ T4527]  ? do_raw_spin_unlock+0xa8/0x140
	[22682.867939][ T4527]  ? _raw_spin_unlock+0x27/0x40
	[22682.868801][ T4527]  ? release_extent_buffer+0x13b/0x230
	[22682.869773][ T4527]  iterate_inodes_from_logical+0x129/0x170
	[22682.870806][ T4527]  ? iterate_inodes_from_logical+0x129/0x170
	[22682.871872][ T4527]  ? btrfs_inode_flags_to_xflags+0x50/0x50
	[22682.872881][ T4527]  ? iterate_extent_inodes+0x590/0x590
	[22682.873865][ T4527]  ? init_data_container+0x34/0xb0
	[22682.874783][ T4527]  ? __vmalloc_node_flags_caller+0x88/0xa0
	[22682.875837][ T4527]  ? init_data_container+0x34/0xb0
	[22682.876748][ T4527]  ? kvmalloc_node+0x5b/0x80
	[22682.877592][ T4527]  btrfs_ioctl_logical_to_ino+0x139/0x1e0
	[22682.878667][ T4527]  btrfs_ioctl+0x2c43/0x4390
	[22682.879527][ T4527]  ? __asan_loadN+0xf/0x20
	[22682.880357][ T4527]  ? btrfs_ioctl_get_supported_features+0x30/0x30
	[22682.881549][ T4527]  ? kvm_sched_clock_read+0x18/0x30
	[22682.882538][ T4527]  ? check_chain_key+0x1e6/0x2e0
	[22682.883425][ T4527]  ? sched_clock_cpu+0x1b/0x120
	[22682.884308][ T4527]  ? check_flags.part.42+0x86/0x220
	[22682.885238][ T4527]  ? __asan_loadN+0xf/0x20
	[22682.886036][ T4527]  ? pvclock_clocksource_read+0xeb/0x190
	[22682.887051][ T4527]  ? __asan_loadN+0xf/0x20
	[22682.887844][ T4527]  ? pvclock_clocksource_read+0xeb/0x190
	[22682.888858][ T4527]  ? kvm_sched_clock_read+0x18/0x30
	[22682.889792][ T4527]  ? check_chain_key+0x1e6/0x2e0
	[22682.890685][ T4527]  ? sched_clock_cpu+0x1b/0x120
	[22682.891570][ T4527]  do_vfs_ioctl+0x13e/0xa80
	[22682.892380][ T4527]  ? rcu_read_lock_held+0xa1/0xb0
	[22682.893281][ T4527]  ? ioctl_preallocate+0x150/0x150
	[22682.894202][ T4527]  ? __fget+0x24c/0x350
	[22682.894964][ T4527]  ? do_dup2+0x2a0/0x2a0
	[22682.895737][ T4527]  ? lock_downgrade+0x3d0/0x3d0
	[22682.896622][ T4527]  ? __fget_light+0xeb/0x110
	[22682.897453][ T4527]  ? trace_hardirqs_on_thunk+0x1a/0x20
	[22682.898434][ T4527]  ksys_ioctl+0x67/0x90
	[22682.899178][ T4527]  __x64_sys_ioctl+0x43/0x50
	[22682.900008][ T4527]  do_syscall_64+0x77/0x2a0
	[22682.900825][ T4527]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
	[22682.901887][ T4527] RIP: 0033:0x7f44e88f9427
	[22682.902690][ T4527] Code: 00 00 90 48 8b 05 69 aa 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 aa 0c 00 f7 d8 64 89 01 48
	[22682.906133][ T4527] RSP: 002b:00007f44e5ffbca8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
	[22682.907610][ T4527] RAX: ffffffffffffffda RBX: 00007f44e5ffbee0 RCX: 00007f44e88f9427
	[22682.909027][ T4527] RDX: 00007f44e5ffbee8 RSI: 00000000c038943b RDI: 0000000000000004
	[22682.910473][ T4527] RBP: 0000000001000000 R08: 0000000000000000 R09: 00007f44e5ffc0c0
	[22682.911964][ T4527] R10: 000055e64ff6bc40 R11: 0000000000000246 R12: 0000000000000004
	[22682.913430][ T4527] R13: 00007f44e5ffbee8 R14: 00007f44e5ffbff0 R15: 00007f44e5ffbee0
	[22682.914913][ T4527] Modules linked in:
	[22682.915744][ T4527] ---[ end trace c002b37feb373f6b ]---
	[22682.916787][ T4527] RIP: 0010:__tree_mod_log_rewind+0x38f/0x3a0
	[22682.917940][ T4527] Code: 8d 74 10 65 ba 19 00 00 00 e8 1d 49 07 00 e9 b8 fd ff ff 4c 8d 7b 2c 4c 89 ff e8 fc 53 cd ff 48 63 43 2c e9 a2 fe ff ff 0f 0b <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 0f 1f 44 00 00
	[22682.921614][ T4527] RSP: 0018:ffff8881c6b26ef8 EFLAGS: 00010206
	[22682.922719][ T4527] RAX: 0000000000000013 RBX: ffff8881484f2500 RCX: ffffffff9e8006a5
	[22682.924170][ T4527] RDX: 0000000000000007 RSI: dffffc0000000000 RDI: ffff8881484f252c
	[22682.925634][ T4527] RBP: ffff8881c6b26f48 R08: 1ffff1101464ea1c R09: ffff8881c6b26e40
	[22682.927080][ T4527] R10: ffffed101464ea1b R11: ffff8880a32750d8 R12: 0000000000000010
	[22682.928550][ T4527] R13: ffff88801846c620 R14: ffff8881393fad00 R15: ffff8881484f252c
	[22682.930011][ T4527] FS:  00007f44e5ffe700(0000) GS:ffff8881f6000000(0000) knlGS:0000000000000000
	[22682.931633][ T4527] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	[22682.932835][ T4527] CR2: 00007ffd709c7e40 CR3: 00000001e0a64003 CR4: 00000000001606e0
	[22682.934298][ T4527] note: crawl_28443[4527] exited with preempt_count 2

	(gdb) l *(__tree_mod_log_rewind+0x38f)
	0xffffffff8180075f is in __tree_mod_log_rewind (fs/btrfs/ctree.c:1253).
	1248                            btrfs_set_node_ptr_generation(eb, tm->slot,
	1249                                                          tm->generation);
	1250                            n++;
	1251                            break;
	1252                    case MOD_LOG_KEY_REPLACE:
	1253                            BUG_ON(tm->slot >= n);
	1254                            btrfs_set_node_key(eb, &tm->key, tm->slot);
	1255                            btrfs_set_node_blockptr(eb, tm->slot, tm->blockptr);
	1256                            btrfs_set_node_ptr_generation(eb, tm->slot,
	1257                                                          tm->generation);

