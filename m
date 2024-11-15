Return-Path: <linux-btrfs+bounces-9687-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED74C9CDDA2
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 12:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3026CB25695
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 11:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9298A1B81B8;
	Fri, 15 Nov 2024 11:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXYOHq4A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3AC1B6D0A
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 11:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731670999; cv=none; b=NUfw5Uztv2Fd2VkHpTEd9P3+8u2Qsyw5u8Ilmyj27SELnxqCohhQdEHCmrC0OpU1FyVkv0tJ8qiVJaqfL4+Vv4bKTuhq5gmOV3Dj7MOv4ikxcQ1OQH/x6DNqkvvDlGUazS8e0gdzE+eRbkdFnbG/GKBwrJ0k8rUJXlVflbIk5cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731670999; c=relaxed/simple;
	bh=ZCvvj05IPDXzBxRspRhXhIkVuEFi4MkzKIEbDhPGJ3Q=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=AGaaBwORThMjBLtB52jgMPrDAfyhgCrc2euac4VebaSthQ2NZSXSsyWCBSRTWZ+AyD3uV2AeDqApUKRyOqT4jthjX+Mo6bdNLREIznW5j25pfOFQlUy12N3sO40oy/FO3OszGGDbmtMgnR9wJ92j+xT3Dx9PEl+baUweiXv/KBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXYOHq4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4254C4CED4
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 11:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731670998;
	bh=ZCvvj05IPDXzBxRspRhXhIkVuEFi4MkzKIEbDhPGJ3Q=;
	h=From:To:Subject:Date:From;
	b=AXYOHq4Ae5a8J40P7aen6pGXmp9iTofbOxRCJbmwpL26JDPIKmZUhdId22OEdKuCl
	 MITFFXgydPrdWyuKGZiUMSkVVxiLVQR+rDLPdxjr43pC1PsA7v3PxvJ4jKkMnFtg/C
	 BVmG1NLHKUN7V0MhuQs5SHLIFCKFQnF20HtRi9Y/J0HNdGHNV56pWSKuGOqUGNRrD8
	 pDWkCTXFSwLLteQxCA8qw2Hp0N+CBSwnY3hGv4LIemk3RPKfTDQCw6yitMgKztpcOa
	 ymJR5VtjCBBNDmAx3twfRFpaADM0lr4kJfug8CP0qTSmAT0Sykayb9HWjJXEoKfncm
	 45JMsTP5bG/tg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: ref-verify: fix use-after-free after invalid ref action
Date: Fri, 15 Nov 2024 11:43:14 +0000
Message-Id: <445fecb5586ce0bbe3f1a42417858d1b3df6819b.1731670907.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At btrfs_ref_tree_mod() after we successfully inserted the new ref entry
(local variable 'ref') into the respective block entry's rbtree (local
variable 'be'), if we find an unexpected action of BTRFS_DROP_DELAYED_REF,
we error out and free the ref entry without removing it from the block
entry's rbtree. Then in the error path of btrfs_ref_tree_mod() we call
btrfs_free_ref_cache(), which iterates over all block entries and then
calls free_block_entry() for each one, and there we will trigger a
use-after-free when we are called against the block entry to which we
added the freed ref entry to its rbtree, since the rbtree still points
to the block entry, as we didn't remove it from the rbtree before freeing
it in the error path at btrfs_ref_tree_mod(). Fix this by removing the
new ref entry from the rbtree before freeing it.

Syzbot report this with the following stack traces:

   BTRFS error (device loop0 state EA):   Ref action 2, root 5, ref_root 0, parent 8564736, owner 0, offset 0, num_refs 18446744073709551615
      __btrfs_mod_ref+0x7dd/0xac0 fs/btrfs/extent-tree.c:2523
      update_ref_for_cow+0x9cd/0x11f0 fs/btrfs/ctree.c:512
      btrfs_force_cow_block+0x9f6/0x1da0 fs/btrfs/ctree.c:594
      btrfs_cow_block+0x35e/0xa40 fs/btrfs/ctree.c:754
      btrfs_search_slot+0xbdd/0x30d0 fs/btrfs/ctree.c:2116
      btrfs_insert_empty_items+0x9c/0x1a0 fs/btrfs/ctree.c:4314
      btrfs_insert_empty_item fs/btrfs/ctree.h:669 [inline]
      btrfs_insert_orphan_item+0x1f1/0x320 fs/btrfs/orphan.c:23
      btrfs_orphan_add+0x6d/0x1a0 fs/btrfs/inode.c:3482
      btrfs_unlink+0x267/0x350 fs/btrfs/inode.c:4293
      vfs_unlink+0x365/0x650 fs/namei.c:4469
      do_unlinkat+0x4ae/0x830 fs/namei.c:4533
      __do_sys_unlinkat fs/namei.c:4576 [inline]
      __se_sys_unlinkat fs/namei.c:4569 [inline]
      __x64_sys_unlinkat+0xcc/0xf0 fs/namei.c:4569
      do_syscall_x64 arch/x86/entry/common.c:52 [inline]
      do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
      entry_SYSCALL_64_after_hwframe+0x77/0x7f
   BTRFS error (device loop0 state EA):   Ref action 1, root 5, ref_root 5, parent 0, owner 260, offset 0, num_refs 1
      __btrfs_mod_ref+0x76b/0xac0 fs/btrfs/extent-tree.c:2521
      update_ref_for_cow+0x96a/0x11f0
      btrfs_force_cow_block+0x9f6/0x1da0 fs/btrfs/ctree.c:594
      btrfs_cow_block+0x35e/0xa40 fs/btrfs/ctree.c:754
      btrfs_search_slot+0xbdd/0x30d0 fs/btrfs/ctree.c:2116
      btrfs_lookup_inode+0xdc/0x480 fs/btrfs/inode-item.c:411
      __btrfs_update_delayed_inode+0x1e7/0xb90 fs/btrfs/delayed-inode.c:1030
      btrfs_update_delayed_inode fs/btrfs/delayed-inode.c:1114 [inline]
      __btrfs_commit_inode_delayed_items+0x2318/0x24a0 fs/btrfs/delayed-inode.c:1137
      __btrfs_run_delayed_items+0x213/0x490 fs/btrfs/delayed-inode.c:1171
      btrfs_commit_transaction+0x8a8/0x3740 fs/btrfs/transaction.c:2313
      prepare_to_relocate+0x3c4/0x4c0 fs/btrfs/relocation.c:3586
      relocate_block_group+0x16c/0xd40 fs/btrfs/relocation.c:3611
      btrfs_relocate_block_group+0x77d/0xd90 fs/btrfs/relocation.c:4081
      btrfs_relocate_chunk+0x12c/0x3b0 fs/btrfs/volumes.c:3377
      __btrfs_balance+0x1b0f/0x26b0 fs/btrfs/volumes.c:4161
      btrfs_balance+0xbdc/0x10c0 fs/btrfs/volumes.c:4538
   BTRFS error (device loop0 state EA):   Ref action 2, root 5, ref_root 0, parent 8564736, owner 0, offset 0, num_refs 18446744073709551615
      __btrfs_mod_ref+0x7dd/0xac0 fs/btrfs/extent-tree.c:2523
      update_ref_for_cow+0x9cd/0x11f0 fs/btrfs/ctree.c:512
      btrfs_force_cow_block+0x9f6/0x1da0 fs/btrfs/ctree.c:594
      btrfs_cow_block+0x35e/0xa40 fs/btrfs/ctree.c:754
      btrfs_search_slot+0xbdd/0x30d0 fs/btrfs/ctree.c:2116
      btrfs_lookup_inode+0xdc/0x480 fs/btrfs/inode-item.c:411
      __btrfs_update_delayed_inode+0x1e7/0xb90 fs/btrfs/delayed-inode.c:1030
      btrfs_update_delayed_inode fs/btrfs/delayed-inode.c:1114 [inline]
      __btrfs_commit_inode_delayed_items+0x2318/0x24a0 fs/btrfs/delayed-inode.c:1137
      __btrfs_run_delayed_items+0x213/0x490 fs/btrfs/delayed-inode.c:1171
      btrfs_commit_transaction+0x8a8/0x3740 fs/btrfs/transaction.c:2313
      prepare_to_relocate+0x3c4/0x4c0 fs/btrfs/relocation.c:3586
      relocate_block_group+0x16c/0xd40 fs/btrfs/relocation.c:3611
      btrfs_relocate_block_group+0x77d/0xd90 fs/btrfs/relocation.c:4081
      btrfs_relocate_chunk+0x12c/0x3b0 fs/btrfs/volumes.c:3377
      __btrfs_balance+0x1b0f/0x26b0 fs/btrfs/volumes.c:4161
      btrfs_balance+0xbdc/0x10c0 fs/btrfs/volumes.c:4538
   ==================================================================
   BUG: KASAN: slab-use-after-free in rb_first+0x69/0x70 lib/rbtree.c:473
   Read of size 8 at addr ffff888042d1af38 by task syz.0.0/5329

   CPU: 0 UID: 0 PID: 5329 Comm: syz.0.0 Not tainted 6.12.0-rc7-syzkaller #0
   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
   Call Trace:
    <TASK>
    __dump_stack lib/dump_stack.c:94 [inline]
    dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
    print_address_description mm/kasan/report.c:377 [inline]
    print_report+0x169/0x550 mm/kasan/report.c:488
    kasan_report+0x143/0x180 mm/kasan/report.c:601
    rb_first+0x69/0x70 lib/rbtree.c:473
    free_block_entry+0x78/0x230 fs/btrfs/ref-verify.c:248
    btrfs_free_ref_cache+0xa3/0x100 fs/btrfs/ref-verify.c:917
    btrfs_ref_tree_mod+0x139f/0x15e0 fs/btrfs/ref-verify.c:898
    btrfs_free_extent+0x33c/0x380 fs/btrfs/extent-tree.c:3544
    __btrfs_mod_ref+0x7dd/0xac0 fs/btrfs/extent-tree.c:2523
    update_ref_for_cow+0x9cd/0x11f0 fs/btrfs/ctree.c:512
    btrfs_force_cow_block+0x9f6/0x1da0 fs/btrfs/ctree.c:594
    btrfs_cow_block+0x35e/0xa40 fs/btrfs/ctree.c:754
    btrfs_search_slot+0xbdd/0x30d0 fs/btrfs/ctree.c:2116
    btrfs_lookup_inode+0xdc/0x480 fs/btrfs/inode-item.c:411
    __btrfs_update_delayed_inode+0x1e7/0xb90 fs/btrfs/delayed-inode.c:1030
    btrfs_update_delayed_inode fs/btrfs/delayed-inode.c:1114 [inline]
    __btrfs_commit_inode_delayed_items+0x2318/0x24a0 fs/btrfs/delayed-inode.c:1137
    __btrfs_run_delayed_items+0x213/0x490 fs/btrfs/delayed-inode.c:1171
    btrfs_commit_transaction+0x8a8/0x3740 fs/btrfs/transaction.c:2313
    prepare_to_relocate+0x3c4/0x4c0 fs/btrfs/relocation.c:3586
    relocate_block_group+0x16c/0xd40 fs/btrfs/relocation.c:3611
    btrfs_relocate_block_group+0x77d/0xd90 fs/btrfs/relocation.c:4081
    btrfs_relocate_chunk+0x12c/0x3b0 fs/btrfs/volumes.c:3377
    __btrfs_balance+0x1b0f/0x26b0 fs/btrfs/volumes.c:4161
    btrfs_balance+0xbdc/0x10c0 fs/btrfs/volumes.c:4538
    btrfs_ioctl_balance+0x493/0x7c0 fs/btrfs/ioctl.c:3673
    vfs_ioctl fs/ioctl.c:51 [inline]
    __do_sys_ioctl fs/ioctl.c:907 [inline]
    __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
    do_syscall_x64 arch/x86/entry/common.c:52 [inline]
    do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
    entry_SYSCALL_64_after_hwframe+0x77/0x7f
   RIP: 0033:0x7f996df7e719
   Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
   RSP: 002b:00007f996ede7038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
   RAX: ffffffffffffffda RBX: 00007f996e135f80 RCX: 00007f996df7e719
   RDX: 0000000020000180 RSI: 00000000c4009420 RDI: 0000000000000004
   RBP: 00007f996dff139e R08: 0000000000000000 R09: 0000000000000000
   R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
   R13: 0000000000000000 R14: 00007f996e135f80 R15: 00007fff79f32e68
    </TASK>

   Allocated by task 5329:
    kasan_save_stack mm/kasan/common.c:47 [inline]
    kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
    poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
    __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
    kasan_kmalloc include/linux/kasan.h:257 [inline]
    __kmalloc_cache_noprof+0x19c/0x2c0 mm/slub.c:4295
    kmalloc_noprof include/linux/slab.h:878 [inline]
    kzalloc_noprof include/linux/slab.h:1014 [inline]
    btrfs_ref_tree_mod+0x264/0x15e0 fs/btrfs/ref-verify.c:701
    btrfs_free_extent+0x33c/0x380 fs/btrfs/extent-tree.c:3544
    __btrfs_mod_ref+0x7dd/0xac0 fs/btrfs/extent-tree.c:2523
    update_ref_for_cow+0x9cd/0x11f0 fs/btrfs/ctree.c:512
    btrfs_force_cow_block+0x9f6/0x1da0 fs/btrfs/ctree.c:594
    btrfs_cow_block+0x35e/0xa40 fs/btrfs/ctree.c:754
    btrfs_search_slot+0xbdd/0x30d0 fs/btrfs/ctree.c:2116
    btrfs_lookup_inode+0xdc/0x480 fs/btrfs/inode-item.c:411
    __btrfs_update_delayed_inode+0x1e7/0xb90 fs/btrfs/delayed-inode.c:1030
    btrfs_update_delayed_inode fs/btrfs/delayed-inode.c:1114 [inline]
    __btrfs_commit_inode_delayed_items+0x2318/0x24a0 fs/btrfs/delayed-inode.c:1137
    __btrfs_run_delayed_items+0x213/0x490 fs/btrfs/delayed-inode.c:1171
    btrfs_commit_transaction+0x8a8/0x3740 fs/btrfs/transaction.c:2313
    prepare_to_relocate+0x3c4/0x4c0 fs/btrfs/relocation.c:3586
    relocate_block_group+0x16c/0xd40 fs/btrfs/relocation.c:3611
    btrfs_relocate_block_group+0x77d/0xd90 fs/btrfs/relocation.c:4081
    btrfs_relocate_chunk+0x12c/0x3b0 fs/btrfs/volumes.c:3377
    __btrfs_balance+0x1b0f/0x26b0 fs/btrfs/volumes.c:4161
    btrfs_balance+0xbdc/0x10c0 fs/btrfs/volumes.c:4538
    btrfs_ioctl_balance+0x493/0x7c0 fs/btrfs/ioctl.c:3673
    vfs_ioctl fs/ioctl.c:51 [inline]
    __do_sys_ioctl fs/ioctl.c:907 [inline]
    __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
    do_syscall_x64 arch/x86/entry/common.c:52 [inline]
    do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

   Freed by task 5329:
    kasan_save_stack mm/kasan/common.c:47 [inline]
    kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
    kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
    poison_slab_object mm/kasan/common.c:247 [inline]
    __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
    kasan_slab_free include/linux/kasan.h:230 [inline]
    slab_free_hook mm/slub.c:2342 [inline]
    slab_free mm/slub.c:4579 [inline]
    kfree+0x1a0/0x440 mm/slub.c:4727
    btrfs_ref_tree_mod+0x136c/0x15e0
    btrfs_free_extent+0x33c/0x380 fs/btrfs/extent-tree.c:3544
    __btrfs_mod_ref+0x7dd/0xac0 fs/btrfs/extent-tree.c:2523
    update_ref_for_cow+0x9cd/0x11f0 fs/btrfs/ctree.c:512
    btrfs_force_cow_block+0x9f6/0x1da0 fs/btrfs/ctree.c:594
    btrfs_cow_block+0x35e/0xa40 fs/btrfs/ctree.c:754
    btrfs_search_slot+0xbdd/0x30d0 fs/btrfs/ctree.c:2116
    btrfs_lookup_inode+0xdc/0x480 fs/btrfs/inode-item.c:411
    __btrfs_update_delayed_inode+0x1e7/0xb90 fs/btrfs/delayed-inode.c:1030
    btrfs_update_delayed_inode fs/btrfs/delayed-inode.c:1114 [inline]
    __btrfs_commit_inode_delayed_items+0x2318/0x24a0 fs/btrfs/delayed-inode.c:1137
    __btrfs_run_delayed_items+0x213/0x490 fs/btrfs/delayed-inode.c:1171
    btrfs_commit_transaction+0x8a8/0x3740 fs/btrfs/transaction.c:2313
    prepare_to_relocate+0x3c4/0x4c0 fs/btrfs/relocation.c:3586
    relocate_block_group+0x16c/0xd40 fs/btrfs/relocation.c:3611
    btrfs_relocate_block_group+0x77d/0xd90 fs/btrfs/relocation.c:4081
    btrfs_relocate_chunk+0x12c/0x3b0 fs/btrfs/volumes.c:3377
    __btrfs_balance+0x1b0f/0x26b0 fs/btrfs/volumes.c:4161
    btrfs_balance+0xbdc/0x10c0 fs/btrfs/volumes.c:4538
    btrfs_ioctl_balance+0x493/0x7c0 fs/btrfs/ioctl.c:3673
    vfs_ioctl fs/ioctl.c:51 [inline]
    __do_sys_ioctl fs/ioctl.c:907 [inline]
    __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
    do_syscall_x64 arch/x86/entry/common.c:52 [inline]
    do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

   The buggy address belongs to the object at ffff888042d1af00
    which belongs to the cache kmalloc-64 of size 64
   The buggy address is located 56 bytes inside of
    freed 64-byte region [ffff888042d1af00, ffff888042d1af40)

   The buggy address belongs to the physical page:
   page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x42d1a
   anon flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
   page_type: f5(slab)
   raw: 04fff00000000000 ffff88801ac418c0 0000000000000000 dead000000000001
   raw: 0000000000000000 0000000000200020 00000001f5000000 0000000000000000
   page dumped because: kasan: bad access detected
   page_owner tracks the page as allocated
   page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5055, tgid 5055 (dhcpcd-run-hook), ts 40377240074, free_ts 40376848335
    set_page_owner include/linux/page_owner.h:32 [inline]
    post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1541
    prep_new_page mm/page_alloc.c:1549 [inline]
    get_page_from_freelist+0x3649/0x3790 mm/page_alloc.c:3459
    __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4735
    alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
    alloc_slab_page+0x6a/0x140 mm/slub.c:2412
    allocate_slab+0x5a/0x2f0 mm/slub.c:2578
    new_slab mm/slub.c:2631 [inline]
    ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3818
    __slab_alloc+0x58/0xa0 mm/slub.c:3908
    __slab_alloc_node mm/slub.c:3961 [inline]
    slab_alloc_node mm/slub.c:4122 [inline]
    __do_kmalloc_node mm/slub.c:4263 [inline]
    __kmalloc_noprof+0x25a/0x400 mm/slub.c:4276
    kmalloc_noprof include/linux/slab.h:882 [inline]
    kzalloc_noprof include/linux/slab.h:1014 [inline]
    tomoyo_encode2 security/tomoyo/realpath.c:45 [inline]
    tomoyo_encode+0x26f/0x540 security/tomoyo/realpath.c:80
    tomoyo_realpath_from_path+0x59e/0x5e0 security/tomoyo/realpath.c:283
    tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
    tomoyo_check_open_permission+0x255/0x500 security/tomoyo/file.c:771
    security_file_open+0x777/0x990 security/security.c:3109
    do_dentry_open+0x369/0x1460 fs/open.c:945
    vfs_open+0x3e/0x330 fs/open.c:1088
    do_open fs/namei.c:3774 [inline]
    path_openat+0x2c84/0x3590 fs/namei.c:3933
   page last free pid 5055 tgid 5055 stack trace:
    reset_page_owner include/linux/page_owner.h:25 [inline]
    free_pages_prepare mm/page_alloc.c:1112 [inline]
    free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2642
    free_pipe_info+0x300/0x390 fs/pipe.c:860
    put_pipe_info fs/pipe.c:719 [inline]
    pipe_release+0x245/0x320 fs/pipe.c:742
    __fput+0x23f/0x880 fs/file_table.c:431
    __do_sys_close fs/open.c:1567 [inline]
    __se_sys_close fs/open.c:1552 [inline]
    __x64_sys_close+0x7f/0x110 fs/open.c:1552
    do_syscall_x64 arch/x86/entry/common.c:52 [inline]
    do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

   Memory state around the buggy address:
    ffff888042d1ae00: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
    ffff888042d1ae80: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
   >ffff888042d1af00: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                                           ^
    ffff888042d1af80: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
    ffff888042d1b000: 00 00 00 00 00 fc fc 00 00 00 00 00 fc fc 00 00
   ==================================================================

Reported-by: syzbot+7325f164162e200000c1@syzkaller.appspotmail.com
Fixes: fd708b81d972 ("Btrfs: add a extent ref verify tool")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ref-verify.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 9522a8b79d22..2928abf7eb82 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -857,6 +857,7 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
 "dropping a ref for a root that doesn't have a ref on the block");
 			dump_block_entry(fs_info, be);
 			dump_ref_action(fs_info, ra);
+			rb_erase(&ref->node, &be->refs);
 			kfree(ref);
 			kfree(ra);
 			goto out_unlock;
-- 
2.45.2


