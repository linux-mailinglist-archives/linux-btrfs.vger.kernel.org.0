Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD332D33C4
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 21:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgLHUZS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 8 Dec 2020 15:25:18 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:44930 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgLHUZQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 15:25:16 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 9AF248E8A04; Tue,  8 Dec 2020 14:46:07 -0500 (EST)
Date:   Tue, 8 Dec 2020 14:46:07 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v6 00/52]
Message-ID: <20201208194607.GI31381@hungrycats.org>
References: <cover.1607444471.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 08, 2020 at 11:23:07AM -0500, Josef Bacik wrote:
> v5->v6:
> - Reworked "btrfs: handle errors from select_reloc_root()" because Zygo reported
>   hitting an ASSERT(ret != -ENOENT) during his testing.  This was because I
>   changed select_reloc_root() to return -ENOENT if we happened to race with
>   somebody else who failed to init the reloc root, however we had an ASSERT() to
>   check for this because it indicated corruption.  I modified that patch to move
>   the ASSERT() to where the problem actually is, so select_reloc_root() can
>   return whatever error and it'll pass it along.  I also removed Qu's
>   reviewed-by for the patch because of the change.

Now it KASAN's:

	[Tue Dec  8 13:18:56 2020] BTRFS info (device dm-0): balance: start -mlimit=1 -slimit=1
	[Tue Dec  8 13:18:56 2020] BTRFS debug (device dm-0): cleaner removing 2383
	[Tue Dec  8 13:18:57 2020] BTRFS info (device dm-0): relocating block group 3262427168768 flags metadata|raid1
	[Tue Dec  8 13:19:51 2020] BTRFS debug (device dm-0): cleaner removing 2384
	[Tue Dec  8 13:22:21 2020] avg_delayed_ref_runtime = 3894835, time = 750151098700, count = 192601
	[Tue Dec  8 13:22:32 2020] ==================================================================
	[Tue Dec  8 13:22:32 2020] BUG: KASAN: use-after-free in btrfs_backref_cleanup_node+0x18a/0x420
	[Tue Dec  8 13:22:32 2020] Read of size 8 at addr ffff888112402950 by task btrfs/28836

	[Tue Dec  8 13:22:32 2020] CPU: 0 PID: 28836 Comm: btrfs Tainted: G        W         5.10.0-e35f27394290-for-next+ #23
	[Tue Dec  8 13:22:32 2020] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
	[Tue Dec  8 13:22:32 2020] Call Trace:
	[Tue Dec  8 13:22:32 2020]  dump_stack+0xbc/0xf9
	[Tue Dec  8 13:22:32 2020]  ? btrfs_backref_cleanup_node+0x18a/0x420
	[Tue Dec  8 13:22:32 2020]  print_address_description.constprop.8+0x21/0x210
	[Tue Dec  8 13:22:32 2020]  ? record_print_text.cold.34+0x11/0x11
	[Tue Dec  8 13:22:32 2020]  ? btrfs_backref_cleanup_node+0x18a/0x420
	[Tue Dec  8 13:22:32 2020]  ? btrfs_backref_cleanup_node+0x18a/0x420
	[Tue Dec  8 13:22:32 2020]  kasan_report.cold.10+0x20/0x37
	[Tue Dec  8 13:22:32 2020]  ? btrfs_backref_cleanup_node+0x18a/0x420
	[Tue Dec  8 13:22:32 2020]  __asan_load8+0x69/0x90
	[Tue Dec  8 13:22:32 2020]  btrfs_backref_cleanup_node+0x18a/0x420
	[Tue Dec  8 13:22:32 2020]  btrfs_backref_release_cache+0x83/0x1b0
	[Tue Dec  8 13:22:32 2020]  relocate_block_group+0x394/0x780
	[Tue Dec  8 13:22:32 2020]  ? merge_reloc_roots+0x4a0/0x4a0
	[Tue Dec  8 13:22:32 2020]  btrfs_relocate_block_group+0x26e/0x4c0
	[Tue Dec  8 13:22:32 2020]  btrfs_relocate_chunk+0x52/0x120
	[Tue Dec  8 13:22:32 2020]  btrfs_balance+0xe2e/0x1900
	[Tue Dec  8 13:22:32 2020]  ? check_flags.part.50+0x6c/0x1e0
	[Tue Dec  8 13:22:32 2020]  ? btrfs_relocate_chunk+0x120/0x120
	[Tue Dec  8 13:22:32 2020]  ? kmem_cache_alloc_trace+0xa06/0xcb0
	[Tue Dec  8 13:22:32 2020]  ? _copy_from_user+0x83/0xc0
	[Tue Dec  8 13:22:32 2020]  btrfs_ioctl_balance+0x3a7/0x460
	[Tue Dec  8 13:22:32 2020]  btrfs_ioctl+0x24c8/0x4360
	[Tue Dec  8 13:22:32 2020]  ? __kasan_check_read+0x11/0x20
	[Tue Dec  8 13:22:32 2020]  ? check_chain_key+0x1f4/0x2f0
	[Tue Dec  8 13:22:32 2020]  ? __asan_loadN+0xf/0x20
	[Tue Dec  8 13:22:32 2020]  ? btrfs_ioctl_get_supported_features+0x30/0x30
	[Tue Dec  8 13:22:32 2020]  ? kvm_sched_clock_read+0x18/0x30
	[Tue Dec  8 13:22:32 2020]  ? check_chain_key+0x1f4/0x2f0
	[Tue Dec  8 13:22:32 2020]  ? lock_downgrade+0x3f0/0x3f0
	[Tue Dec  8 13:22:32 2020]  ? handle_mm_fault+0xad6/0x2150
	[Tue Dec  8 13:22:32 2020]  ? do_vfs_ioctl+0xfc/0x9d0
	[Tue Dec  8 13:22:32 2020]  ? ioctl_file_clone+0xe0/0xe0
	[Tue Dec  8 13:22:32 2020]  ? check_flags.part.50+0x6c/0x1e0
	[Tue Dec  8 13:22:32 2020]  ? check_flags.part.50+0x6c/0x1e0
	[Tue Dec  8 13:22:32 2020]  ? check_flags+0x26/0x30
	[Tue Dec  8 13:22:32 2020]  ? lock_is_held_type+0xc3/0xf0
	[Tue Dec  8 13:22:32 2020]  ? syscall_enter_from_user_mode+0x1b/0x60
	[Tue Dec  8 13:22:32 2020]  ? do_syscall_64+0x13/0x80
	[Tue Dec  8 13:22:32 2020]  ? rcu_read_lock_sched_held+0xa1/0xd0
	[Tue Dec  8 13:22:32 2020]  ? __kasan_check_read+0x11/0x20
	[Tue Dec  8 13:22:32 2020]  ? __fget_light+0xae/0x110
	[Tue Dec  8 13:22:32 2020]  __x64_sys_ioctl+0xc3/0x100
	[Tue Dec  8 13:22:32 2020]  do_syscall_64+0x37/0x80
	[Tue Dec  8 13:22:32 2020]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
	[Tue Dec  8 13:22:32 2020] RIP: 0033:0x7f4c4bdfe427
	[Tue Dec  8 13:22:32 2020] Code: 00 00 90 48 8b 05 69 aa 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 aa 0c 00 f7 d8 64 89 01 48
	[Tue Dec  8 13:22:32 2020] RSP: 002b:00007fff33ee6df8 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
	[Tue Dec  8 13:22:32 2020] RAX: ffffffffffffffda RBX: 00007fff33ee6e98 RCX: 00007f4c4bdfe427
	[Tue Dec  8 13:22:32 2020] RDX: 00007fff33ee6e98 RSI: 00000000c4009420 RDI: 0000000000000003
	[Tue Dec  8 13:22:32 2020] RBP: 0000000000000003 R08: 0000000000000003 R09: 0000000000000078
	[Tue Dec  8 13:22:32 2020] R10: fffffffffffff59d R11: 0000000000000202 R12: 0000000000000001
	[Tue Dec  8 13:22:32 2020] R13: 0000000000000000 R14: 00007fff33ee8a34 R15: 0000000000000001

	[Tue Dec  8 13:22:32 2020] Allocated by task 28836:
	[Tue Dec  8 13:22:32 2020]  kasan_save_stack+0x21/0x50
	[Tue Dec  8 13:22:32 2020]  __kasan_kmalloc.constprop.18+0xbe/0xd0
	[Tue Dec  8 13:22:32 2020]  kasan_kmalloc+0x9/0x10
	[Tue Dec  8 13:22:32 2020]  kmem_cache_alloc_trace+0x410/0xcb0
	[Tue Dec  8 13:22:32 2020]  btrfs_backref_alloc_node+0x46/0xf0
	[Tue Dec  8 13:22:32 2020]  btrfs_backref_add_tree_node+0x60d/0x11d0
	[Tue Dec  8 13:22:32 2020]  build_backref_tree+0xc5/0x700
	[Tue Dec  8 13:22:32 2020]  relocate_tree_blocks+0x2be/0xb90
	[Tue Dec  8 13:22:32 2020]  relocate_block_group+0x2eb/0x780
	[Tue Dec  8 13:22:32 2020]  btrfs_relocate_block_group+0x26e/0x4c0
	[Tue Dec  8 13:22:32 2020]  btrfs_relocate_chunk+0x52/0x120
	[Tue Dec  8 13:22:32 2020]  btrfs_balance+0xe2e/0x1900
	[Tue Dec  8 13:22:32 2020]  btrfs_ioctl_balance+0x3a7/0x460
	[Tue Dec  8 13:22:32 2020]  btrfs_ioctl+0x24c8/0x4360
	[Tue Dec  8 13:22:32 2020]  __x64_sys_ioctl+0xc3/0x100
	[Tue Dec  8 13:22:32 2020]  do_syscall_64+0x37/0x80
	[Tue Dec  8 13:22:32 2020]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

	[Tue Dec  8 13:22:32 2020] Freed by task 28836:
	[Tue Dec  8 13:22:32 2020]  kasan_save_stack+0x21/0x50
	[Tue Dec  8 13:22:32 2020]  kasan_set_track+0x20/0x30
	[Tue Dec  8 13:22:32 2020]  kasan_set_free_info+0x1f/0x30
	[Tue Dec  8 13:22:32 2020]  __kasan_slab_free+0xf3/0x140
	[Tue Dec  8 13:22:32 2020]  kasan_slab_free+0xe/0x10
	[Tue Dec  8 13:22:32 2020]  kfree+0xde/0x200
	[Tue Dec  8 13:22:32 2020]  btrfs_backref_error_cleanup+0x452/0x530
	[Tue Dec  8 13:22:32 2020]  build_backref_tree+0x1a5/0x700
	[Tue Dec  8 13:22:32 2020]  relocate_tree_blocks+0x2be/0xb90
	[Tue Dec  8 13:22:32 2020]  relocate_block_group+0x2eb/0x780
	[Tue Dec  8 13:22:32 2020]  btrfs_relocate_block_group+0x26e/0x4c0
	[Tue Dec  8 13:22:32 2020]  btrfs_relocate_chunk+0x52/0x120
	[Tue Dec  8 13:22:32 2020]  btrfs_balance+0xe2e/0x1900
	[Tue Dec  8 13:22:32 2020]  btrfs_ioctl_balance+0x3a7/0x460
	[Tue Dec  8 13:22:32 2020]  btrfs_ioctl+0x24c8/0x4360
	[Tue Dec  8 13:22:32 2020]  __x64_sys_ioctl+0xc3/0x100
	[Tue Dec  8 13:22:32 2020]  do_syscall_64+0x37/0x80
	[Tue Dec  8 13:22:32 2020]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

	[Tue Dec  8 13:22:32 2020] The buggy address belongs to the object at ffff888112402900
				    which belongs to the cache kmalloc-128 of size 128
	[Tue Dec  8 13:22:32 2020] The buggy address is located 80 bytes inside of
				    128-byte region [ffff888112402900, ffff888112402980)
	[Tue Dec  8 13:22:32 2020] The buggy address belongs to the page:
	[Tue Dec  8 13:22:32 2020] page:0000000028b1cd08 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888131c810c0 pfn:0x112402
	[Tue Dec  8 13:22:32 2020] flags: 0x17ffe0000000200(slab)
	[Tue Dec  8 13:22:32 2020] raw: 017ffe0000000200 ffffea000424f308 ffffea0007d572c8 ffff888100040440
	[Tue Dec  8 13:22:32 2020] raw: ffff888131c810c0 ffff888112402000 0000000100000009 0000000000000000
	[Tue Dec  8 13:22:32 2020] page dumped because: kasan: bad access detected

	[Tue Dec  8 13:22:32 2020] Memory state around the buggy address:
	[Tue Dec  8 13:22:32 2020]  ffff888112402800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
	[Tue Dec  8 13:22:32 2020]  ffff888112402880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
	[Tue Dec  8 13:22:32 2020] >ffff888112402900: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
	[Tue Dec  8 13:22:33 2020]                                                  ^
	[Tue Dec  8 13:22:33 2020]  ffff888112402980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
	[Tue Dec  8 13:22:33 2020]  ffff888112402a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
	[Tue Dec  8 13:22:33 2020] ==================================================================
	[Tue Dec  8 13:22:33 2020] Disabling lock debugging due to kernel taint

> v4->v5:
> - Dropped "btrfs: fix error handling in commit_fs_roots" as it was merged.
> - Fixed an ASSERT() that happened during relocation recovery that Zygo reported,
>   I moved the error condition out of another condition which broke recovery if
>   we had deleted subvols pending with relocation.
> 
> v3->v4:
> - Squashed the __add_reloc_root error handling patches in
>   btrfs_recover_relocation as they were small and in the same function.
> - Squashed the record_root_in_trans failure handling patches for
>   select_reloc_root as they were small and in the same function.
> - Added a new patch to address an existing error handling problem with subvol
>   creation.
> - Fixed up the various cases that Qu noticed where I got things wrong, cleaning
>   up a leaked root extent ref, a leaked inode item, and where I accidentally
>   stopped dealing with errors from btrfs_drop_subtree.
> - Reworked a bunch of the ASSERT()'s to do ASSERT(0) in their respective if
>   statements.
> - Added reviewed-bys.
> 
> v2->v3:
> - A lot of extra patches fixing various things that I encountered while
>   debugging the corruption problem that was uncovered by these patches.
> - Fixed the panic that Zygo was seeing and other issues.
> - Fixed up the comments from Nikolay and Filipe.
> 
> A slight note, the first set of patches could probably be taken now, and in fact
> 
>   btrfs: fix error handling in commit_fs_roots
> 
> Was sent earlier this week and is very important and needs to be reviewed and
> merged ASAP.  The following are safe and could be merged outside of the rest of
> this series
> 
>   btrfs: allow error injection for btrfs_search_slot and btrfs_cow_block
>   btrfs: fix lockdep splat in btrfs_recover_relocation
>   btrfs: keep track of the root owner for relocation reads
>   btrfs: noinline btrfs_should_cancel_balance
>   btrfs: do not cleanup upper nodes in btrfs_backref_cleanup_node
>   btrfs: pass down the tree block level through ref-verify
>   btrfs: make sure owner is set in ref-verify
>   btrfs: don't clear ret in btrfs_start_dirty_block_groups
> 
> The rest obviously are all around the actual error handling.
> 
> v1->v2:
> - fixed a bug where I accidentally dropped reading flags in relocate_block_group
>   when I dropped the extra checks that we handle in the tree checker.
> 
> --- Original message ---
> Hello,
> 
> Relocation is the last place that is not able to handle errors at all, which
> results in all sorts of lovely panics if you encounter corruptions or IO errors.
> I'm going to start cleaning up relocation, but before I move code around I want
> the error handling to be somewhat sane, so I'm not changing behavior and error
> handling at the same time.
> 
> These patches are purely about error handling, there is no behavior changing
> other than returning errors up the chain properly.  There is a lot of room for
> follow up cleanups, which will happen next.  However I wanted to get this series
> done today and out so we could get it merged ASAP, and then the follow up
> cleanups can happen later as they are less important and less critical.
> 
> The only exception to the above is the patch to add the error injection sites
> for btrfs_cow_block and btrfs_search_slot, and a lockdep fix that I discovered
> while running my tests, those are the first two patches in the series.
> 
> I tested this with my error injection stress test, where I keep track of all
> stack traces that have been tested and only inject errors when we have a new
> stack trace, which means I should have covered all of the various error
> conditions.  With this patchset I'm no longer panicing while stressing the error
> conditions.  Thanks,
> 
> Josef
> 
> Josef Bacik (52):
>   btrfs: allow error injection for btrfs_search_slot and btrfs_cow_block
>   btrfs: modify the new_root highest_objectid under a ref count
>   btrfs: fix lockdep splat in btrfs_recover_relocation
>   btrfs: keep track of the root owner for relocation reads
>   btrfs: noinline btrfs_should_cancel_balance
>   btrfs: do not cleanup upper nodes in btrfs_backref_cleanup_node
>   btrfs: pass down the tree block level through ref-verify
>   btrfs: make sure owner is set in ref-verify
>   btrfs: don't clear ret in btrfs_start_dirty_block_groups
>   btrfs: convert some BUG_ON()'s to ASSERT()'s in do_relocation
>   btrfs: convert BUG_ON()'s in relocate_tree_block
>   btrfs: return an error from btrfs_record_root_in_trans
>   btrfs: handle errors from select_reloc_root()
>   btrfs: convert BUG_ON()'s in select_reloc_root() to proper errors
>   btrfs: check record_root_in_trans related failures in
>     select_reloc_root
>   btrfs: do proper error handling in record_reloc_root_in_trans
>   btrfs: handle btrfs_record_root_in_trans failure in
>     btrfs_rename_exchange
>   btrfs: handle btrfs_record_root_in_trans failure in btrfs_rename
>   btrfs: handle btrfs_record_root_in_trans failure in
>     btrfs_delete_subvolume
>   btrfs: handle btrfs_record_root_in_trans failure in
>     btrfs_recover_log_trees
>   btrfs: handle btrfs_record_root_in_trans failure in create_subvol
>   btrfs: btrfs: handle btrfs_record_root_in_trans failure in
>     relocate_tree_block
>   btrfs: handle btrfs_record_root_in_trans failure in start_transaction
>   btrfs: handle record_root_in_trans failure in qgroup_account_snapshot
>   btrfs: handle record_root_in_trans failure in
>     btrfs_record_root_in_trans
>   btrfs: handle record_root_in_trans failure in create_pending_snapshot
>   btrfs: do not panic in __add_reloc_root
>   btrfs: have proper error handling in btrfs_init_reloc_root
>   btrfs: do proper error handling in create_reloc_root
>   btrfs: validate ->reloc_root after recording root in trans
>   btrfs: handle btrfs_update_reloc_root failure in commit_fs_roots
>   btrfs: change insert_dirty_subvol to return errors
>   btrfs: handle btrfs_update_reloc_root failure in insert_dirty_subvol
>   btrfs: handle btrfs_update_reloc_root failure in prepare_to_merge
>   btrfs: do proper error handling in btrfs_update_reloc_root
>   btrfs: convert logic BUG_ON()'s in replace_path to ASSERT()'s
>   btrfs: handle btrfs_cow_block errors in replace_path
>   btrfs: handle btrfs_search_slot failure in replace_path
>   btrfs: handle errors in reference count manipulation in replace_path
>   btrfs: handle extent reference errors in do_relocation
>   btrfs: check for BTRFS_BLOCK_FLAG_FULL_BACKREF being set improperly
>   btrfs: remove the extent item sanity checks in relocate_block_group
>   btrfs: do proper error handling in create_reloc_inode
>   btrfs: handle __add_reloc_root failures in btrfs_recover_relocation
>   btrfs: cleanup error handling in prepare_to_merge
>   btrfs: handle extent corruption with select_one_root properly
>   btrfs: do proper error handling in merge_reloc_roots
>   btrfs: check return value of btrfs_commit_transaction in relocation
>   btrfs: do not WARN_ON() if we can't find the reloc root
>   btrfs: print the actual offset in btrfs_root_name
>   btrfs: fix reloc root leak with 0 ref reloc roots on recovery
>   btrfs: splice remaining dirty_bg's onto the transaction dirty bg list
> 
>  fs/btrfs/backref.c      |   9 +-
>  fs/btrfs/block-group.c  |   6 +-
>  fs/btrfs/ctree.c        |   2 +
>  fs/btrfs/disk-io.c      |   2 +-
>  fs/btrfs/inode.c        |  20 +-
>  fs/btrfs/ioctl.c        |  17 +-
>  fs/btrfs/print-tree.c   |  10 +-
>  fs/btrfs/print-tree.h   |   2 +-
>  fs/btrfs/ref-verify.c   |  43 ++--
>  fs/btrfs/relocation.c   | 474 +++++++++++++++++++++++++++++++---------
>  fs/btrfs/transaction.c  |  37 +++-
>  fs/btrfs/tree-checker.c |   5 +
>  fs/btrfs/tree-log.c     |   8 +-
>  fs/btrfs/volumes.c      |   2 +
>  14 files changed, 477 insertions(+), 160 deletions(-)
> 
> -- 
> 2.26.2
> 
