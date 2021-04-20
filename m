Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84631365EA4
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Apr 2021 19:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbhDTRcO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Apr 2021 13:32:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:40440 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233473AbhDTRcB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Apr 2021 13:32:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 54EE8B2EA;
        Tue, 20 Apr 2021 17:31:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 77DAEDA83A; Tue, 20 Apr 2021 19:29:09 +0200 (CEST)
Date:   Tue, 20 Apr 2021 19:29:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org, ce3g8jdj@umail.furryterror.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: fix race when picking most recent mod log
 operation for an old root
Message-ID: <20210420172909.GX7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org, ce3g8jdj@umail.furryterror.org,
        Filipe Manana <fdmanana@suse.com>
References: <16bef575e4dcd7c80ce0e05bee6711f1c7b787c0.1618912326.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16bef575e4dcd7c80ce0e05bee6711f1c7b787c0.1618912326.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 20, 2021 at 10:55:44AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Commit dbcc7d57bffc0c ("btrfs: fix race when cloning extent buffer during
> rewind of an old root"), fixed a race when we need to rewind the extent
> buffer of an old root. It was caused by picking a new mod log operation
> for the extent buffer while getting a cloned extent buffer with an outdated
> number of items (off by -1), because we cloned the extent buffer without
> locking it first.
> 
> However there is still another similar race, but in the opposite direction.
> The cloned extent buffer has a number of items that does not match the
> number of tree mod log operations that are going to be replayed. This is
> because right after we got the last (most recent) tree mod log operation to
> replay and before locking and cloning the extent buffer, another task adds
> a new pointer to the extent buffer, which results in adding a new tree mod
> log operation and incrementing the number of items in the extent buffer.
> So after cloning we have mismatch between the number of items in the extent
> buffer and the number of mod log operations we are going to apply to it.
> This results in hitting a BUG_ON() that produces the following stack trace:
> 
>   [145427.689964][ T4811] ------------[ cut here ]------------
>   [145427.692498][ T4811] kernel BUG at fs/btrfs/tree-mod-log.c:675!
>   [145427.694668][ T4811] invalid opcode: 0000 [#1] SMP KASAN PTI
>   [145427.696379][ T4811] CPU: 3 PID: 4811 Comm: crawl_1215 Tainted: G        W         5.12.0-7d1efdf501f8-misc-next+ #99
>   [145427.700221][ T4811] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
>   [145427.703623][ T4811] RIP: 0010:tree_mod_log_rewind+0x3b1/0x3c0
>   [145427.706135][ T4811] Code: 05 48 8d 74 10 (...)
>   [145427.713034][ T4811] RSP: 0018:ffffc90001027090 EFLAGS: 00010293
>   [145427.714996][ T4811] RAX: 0000000000000000 RBX: ffff8880a8514600 RCX: ffffffffaa9e59b6
>   [145427.717158][ T4811] RDX: 0000000000000007 RSI: dffffc0000000000 RDI: ffff8880a851462c
>   [145427.720422][ T4811] RBP: ffffc900010270e0 R08: 00000000000000c0 R09: ffffed1004333417
>   [145427.723835][ T4811] R10: ffff88802199a0b7 R11: ffffed1004333416 R12: 000000000000000e
>   [145427.727695][ T4811] R13: ffff888135af8748 R14: ffff88818766ff00 R15: ffff8880a851462c
>   [145427.731636][ T4811] FS:  00007f29acf62700(0000) GS:ffff8881f2200000(0000) knlGS:0000000000000000
>   [145427.736305][ T4811] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   [145427.739587][ T4811] CR2: 00007f0e6013f718 CR3: 000000010d42e003 CR4: 0000000000170ee0
>   [145427.743573][ T4811] Call Trace:
>   [145427.745117][ T4811]  btrfs_get_old_root+0x16a/0x5c0
>   [145427.747686][ T4811]  ? lock_downgrade+0x400/0x400
>   [145427.754189][ T4811]  btrfs_search_old_slot+0x192/0x520
>   [145427.758023][ T4811]  ? btrfs_search_slot+0x1090/0x1090
>   [145427.761014][ T4811]  ? free_extent_buffer.part.61+0xd7/0x140
>   [145427.765208][ T4811]  ? free_extent_buffer+0x13/0x20
>   [145427.770042][ T4811]  resolve_indirect_refs+0x3e9/0xfc0
>   [145427.773633][ T4811]  ? lock_downgrade+0x400/0x400
>   [145427.777323][ T4811]  ? __kasan_check_read+0x11/0x20
>   [145427.780539][ T4811]  ? add_prelim_ref.part.11+0x150/0x150
>   [145427.785722][ T4811]  ? lock_downgrade+0x400/0x400
>   [145427.791086][ T4811]  ? __kasan_check_read+0x11/0x20
>   [145427.796266][ T4811]  ? lock_acquired+0xbb/0x620
>   [145427.798764][ T4811]  ? __kasan_check_write+0x14/0x20
>   [145427.801118][ T4811]  ? do_raw_spin_unlock+0xa8/0x140
>   [145427.804491][ T4811]  ? rb_insert_color+0x340/0x360
>   [145427.808066][ T4811]  ? prelim_ref_insert+0x12d/0x430
>   [145427.811889][ T4811]  find_parent_nodes+0x5c3/0x1830
>   [145427.815498][ T4811]  ? stack_trace_save+0x87/0xb0
>   [145427.819210][ T4811]  ? resolve_indirect_refs+0xfc0/0xfc0
>   [145427.823254][ T4811]  ? fs_reclaim_acquire+0x67/0xf0
>   [145427.827220][ T4811]  ? __kasan_check_read+0x11/0x20
>   [145427.829080][ T4811]  ? lockdep_hardirqs_on_prepare+0x210/0x210
>   [145427.831237][ T4811]  ? fs_reclaim_acquire+0x67/0xf0
>   [145427.835061][ T4811]  ? __kasan_check_read+0x11/0x20
>   [145427.836508][ T4811]  ? ___might_sleep+0x10f/0x1e0
>   [145427.841389][ T4811]  ? __kasan_kmalloc+0x9d/0xd0
>   [145427.843054][ T4811]  ? trace_hardirqs_on+0x55/0x120
>   [145427.845533][ T4811]  btrfs_find_all_roots_safe+0x142/0x1e0
>   [145427.847325][ T4811]  ? find_parent_nodes+0x1830/0x1830
>   [145427.849318][ T4811]  ? trace_hardirqs_on+0x55/0x120
>   [145427.851210][ T4811]  ? ulist_free+0x1f/0x30
>   [145427.852809][ T4811]  ? btrfs_inode_flags_to_xflags+0x50/0x50
>   [145427.854654][ T4811]  iterate_extent_inodes+0x20e/0x580
>   [145427.856429][ T4811]  ? tree_backref_for_extent+0x230/0x230
>   [145427.858552][ T4811]  ? release_extent_buffer+0x225/0x280
>   [145427.862789][ T4811]  ? read_extent_buffer+0xdd/0x110
>   [145427.865092][ T4811]  ? lock_downgrade+0x400/0x400
>   [145427.867069][ T4811]  ? __kasan_check_read+0x11/0x20
>   [145427.868585][ T4811]  ? lock_acquired+0xbb/0x620
>   [145427.872309][ T4811]  ? __kasan_check_write+0x14/0x20
>   [145427.873641][ T4811]  ? do_raw_spin_unlock+0xa8/0x140
>   [145427.878150][ T4811]  ? _raw_spin_unlock+0x22/0x30
>   [145427.879355][ T4811]  ? release_extent_buffer+0x225/0x280
>   [145427.881424][ T4811]  iterate_inodes_from_logical+0x129/0x170
>   [145427.884711][ T4811]  ? iterate_inodes_from_logical+0x129/0x170
>   [145427.888124][ T4811]  ? btrfs_inode_flags_to_xflags+0x50/0x50
>   [145427.891553][ T4811]  ? iterate_extent_inodes+0x580/0x580
>   [145427.894531][ T4811]  ? __vmalloc_node+0x92/0xb0
>   [145427.897439][ T4811]  ? init_data_container+0x34/0xb0
>   [145427.900518][ T4811]  ? init_data_container+0x34/0xb0
>   [145427.903705][ T4811]  ? kvmalloc_node+0x60/0x80
>   [145427.906538][ T4811]  btrfs_ioctl_logical_to_ino+0x158/0x230
>   [145427.910125][ T4811]  btrfs_ioctl+0x2038/0x4360
>   [145427.912430][ T4811]  ? __kasan_check_write+0x14/0x20
>   [145427.914061][ T4811]  ? mmput+0x3b/0x220
>   [145427.915380][ T4811]  ? btrfs_ioctl_get_supported_features+0x30/0x30
>   [145427.917512][ T4811]  ? __kasan_check_read+0x11/0x20
>   [145427.919110][ T4811]  ? __kasan_check_read+0x11/0x20
>   [145427.920845][ T4811]  ? lock_release+0xc8/0x650
>   [145427.922227][ T4811]  ? __might_fault+0x64/0xd0
>   [145427.923687][ T4811]  ? __kasan_check_read+0x11/0x20
>   [145427.925222][ T4811]  ? lock_downgrade+0x400/0x400
>   [145427.926729][ T4811]  ? lockdep_hardirqs_on_prepare+0x210/0x210
>   [145427.928496][ T4811]  ? lockdep_hardirqs_on_prepare+0x13/0x210
>   [145427.930396][ T4811]  ? _raw_spin_unlock_irqrestore+0x51/0x63
>   [145427.932123][ T4811]  ? __kasan_check_read+0x11/0x20
>   [145427.933910][ T4811]  ? do_vfs_ioctl+0xfc/0x9d0
>   [145427.935664][ T4811]  ? ioctl_file_clone+0xe0/0xe0
>   [145427.938147][ T4811]  ? lock_downgrade+0x400/0x400
>   [145427.940717][ T4811]  ? lockdep_hardirqs_on_prepare+0x210/0x210
>   [145427.943673][ T4811]  ? __kasan_check_read+0x11/0x20
>   [145427.946249][ T4811]  ? lock_release+0xc8/0x650
>   [145427.948509][ T4811]  ? __task_pid_nr_ns+0xd3/0x250
>   [145427.950946][ T4811]  ? __kasan_check_read+0x11/0x20
>   [145427.953415][ T4811]  ? __fget_files+0x160/0x230
>   [145427.955693][ T4811]  ? __fget_light+0xf2/0x110
>   [145427.957951][ T4811]  __x64_sys_ioctl+0xc3/0x100
>   [145427.961647][ T4811]  do_syscall_64+0x37/0x80
>   [145427.963112][ T4811]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>   [145427.971975][ T4811] RIP: 0033:0x7f29ae85b427
>   [145427.974101][ T4811] Code: 00 00 90 48 8b (...)
>   [145427.980483][ T4811] RSP: 002b:00007f29acf5fcf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>   [145427.983314][ T4811] RAX: ffffffffffffffda RBX: 00007f29acf5ff40 RCX: 00007f29ae85b427
>   [145427.985963][ T4811] RDX: 00007f29acf5ff48 RSI: 00000000c038943b RDI: 0000000000000003
>   [145427.988504][ T4811] RBP: 0000000001000000 R08: 0000000000000000 R09: 00007f29acf60120
>   [145427.991085][ T4811] R10: 00005640d5fc7b00 R11: 0000000000000246 R12: 0000000000000003
>   [145427.993662][ T4811] R13: 00007f29acf5ff48 R14: 00007f29acf5ff40 R15: 00007f29acf5fef8
>   [145427.996289][ T4811] Modules linked in:
>   [145427.997661][ T4811] ---[ end trace 85e5fce078dfbe04 ]---
> 
>   (gdb) l *(tree_mod_log_rewind+0x3b1)
>   0xffffffff819e5b21 is in tree_mod_log_rewind (fs/btrfs/tree-mod-log.c:675).
>   670                      * the modification. As we're going backwards, we do the
>   671                      * opposite of each operation here.
>   672                      */
>   673                     switch (tm->op) {
>   674                     case BTRFS_MOD_LOG_KEY_REMOVE_WHILE_FREEING:
>   675                             BUG_ON(tm->slot < n);
>   676                             fallthrough;
>   677                     case BTRFS_MOD_LOG_KEY_REMOVE_WHILE_MOVING:
>   678                     case BTRFS_MOD_LOG_KEY_REMOVE:
>   679                             btrfs_set_node_key(eb, &tm->key, tm->slot);
>   (gdb) quit
> 
> The following steps explain in more detail how it happens:
> 
> 1) We have one tree mod log user (through fiemap or the logical ino ioctl),
>    with a sequence number of 1, so we have fs_info->tree_mod_seq == 1.
>    This is task A;
> 
> 2) Another task is at ctree.c:balance_level() and we have eb X currently as
>    the root of the tree, and we promote its single child, eb Y, as the new
>    root.
> 
>    Then, at ctree.c:balance_level(), we call:
> 
>       ret = btrfs_tree_mod_log_insert_root(root->node, child, true);
> 
> 3) At btrfs_tree_mod_log_insert_root() we create a tree mod log operation
>    of type BTRFS_MOD_LOG_KEY_REMOVE_WHILE_FREEING, with a ->logical field
>    pointing to ebX->start. We only have one item in eb X, so we create
>    only one tree mod log operation, and store in the "tm_list" array;
> 
> 4) Then, still at btrfs_tree_mod_log_insert_root(), we create a tree mod
>    log element of operation type BTRFS_MOD_LOG_ROOT_REPLACE, ->logical set
>    to ebY->start, ->old_root.logical set to ebX->start, ->old_root.level
>    set to the level of eb X and ->generation set to the generation of eb X;
> 
> 5) Then btrfs_tree_mod_log_insert_root() calls tree_mod_log_free_eb() with
>    "tm_list" as argument. After that, tree_mod_log_free_eb() calls
>    tree_mod_log_insert(). This inserts the mod log operation of type
>    BTRFS_MOD_LOG_KEY_REMOVE_WHILE_FREEING from step 3 into the rbtree
>    with a sequence number of 2 (and fs_info->tree_mod_seq set to 2);
> 
> 6) Then, after inserting the "tm_list" single element into the tree mod
>    log rbtree, the BTRFS_MOD_LOG_ROOT_REPLACE element is inserted, which
>    gets the sequence number 3 (and fs_info->tree_mod_seq set to 3);
> 
> 7) Back to ctree.c:balance_level(), we free eb X by calling
>    btrfs_free_tree_block() on it. Because eb X was created in the current
>    transaction, has no other references and writeback did not happen for
>    it, we add it back to the free space cache/tree;
> 
> 8) Later some other task B allocates the metadata extent from eb X, since
>    it is marked as free space in the space cache/tree, and uses it as a
>    node for some other btree;
> 
> 9) The tree mod log user task calls btrfs_search_old_slot(), which calls
>    btrfs_get_old_root(), and finally that calls tree_mod_log_oldest_root()
>    with time_seq == 1 and eb_root == eb Y;
> 
> 10) The first iteration of the while loop finds the tree mod log element
>     with sequence number 3, for the logical address of eb Y and of type
>     BTRFS_MOD_LOG_ROOT_REPLACE;
> 
> 11) Because the operation type is BTRFS_MOD_LOG_ROOT_REPLACE, we don't
>     break out of the loop, and set root_logical to point to
>     tm->old_root.logical, which corresponds to the logical address of
>     eb X;
> 
> 12) On the next iteration of the while loop, the call to
>     tree_mod_log_search_oldest() returns the smallest tree mod log element
>     for the logical address of eb X, which has a sequence number of 2, an
>     operation type of BTRFS_MOD_LOG_KEY_REMOVE_WHILE_FREEING and
>     corresponds to the old slot 0 of eb X (eb X had only 1 item in it
>     before being freed at step 7);
> 
> 13) We then break out of the while loop and return the tree mod log
>     operation of type BTRFS_MOD_LOG_ROOT_REPLACE (eb Y), and not the one
>     for slot 0 of eb X, to btrfs_get_old_root();
> 
> 14) At btrfs_get_old_root(), we process the BTRFS_MOD_LOG_ROOT_REPLACE
>     operation and set "logical" to the logical address of eb X, which was
>     the old root. We then call tree_mod_log_search() passing it the logical
>     address of eb X and time_seq == 1;
> 
> 15) But before calling tree_mod_log_search(), task B locks eb X, adds a
>     key to eb X, which results in adding a tree mod log operation of type
>     BTRFS_MOD_LOG_KEY_ADD, with a sequence number of 4, to the tree mod
>     log, and increments the number of items in eb X from 0 to 1.
>     Now fs_info->tree_mod_seq has a value of 4;
> 
> 16) Task A then calls tree_mod_log_search(), which returns the most recent
>     tree mod log operation for eb X, which is the one just added by task B
>     at the previous step, with a sequence number of 4, a type of
>     BTRFS_MOD_LOG_KEY_ADD and for slot 0;
> 
> 17) Before task A locks and clones eb X, task A adds another key to eb X,
>     which results in adding a new BTRFS_MOD_LOG_KEY_ADD mod log operation,
>     with a sequence number of 5, for slot 1 of eb X, increments the
>     number of items in eb X from 1 to 2, and unlocks eb X.
>     Now fs_info->tree_mod_seq has a value of 5;
> 
> 18) Task A then locks eb X and clones it. The clone has a value of 2 for
>     the number of items and the pointer "tm" points to the tree mod log
>     operation with sequence number 4, not the most recent one with a
>     sequence number of 5, so there is mismatch between the number of
>     mod log operations that are going to be applied to the cloned version
>     of eb X and the number of items in the clone;
> 
> 19) Task A then calls tree_mod_log_rewind() with the clone of eb X, the
>     tree mod log operation with sequence number 4 and a type of
>     BTRFS_MOD_LOG_KEY_ADD, and time_seq == 1;
> 
> 20) At tree_mod_log_rewind(), we set the local varibale "n" with a value
>     of 2, which is the number of items in the clone of eb X.
> 
>     Then in the first iteration of the while loop, we process the mod log
>     operation with sequence number 4, which is targeted at slot 0 and has
>     a type of BTRFS_MOD_LOG_KEY_ADD. This results in decrementing "n" from
>     2 to 1.
> 
>     Then we pick the next tree mod log operation for eb X, which is the
>     tree mod log operation with a sequence number of 2, a type of
>     BTRFS_MOD_LOG_KEY_REMOVE_WHILE_FREEING and for slot 0, it is the one
>     added in step 5 to the tree mod log tree.
> 
>     We go back to the top of the loop to process this mod log operation,
>     and because its slot is 0 and "n" has a value of 1, we hit the BUG_ON:
> 
>         (...)
>         switch (tm->op) {
>         case BTRFS_MOD_LOG_KEY_REMOVE_WHILE_FREEING:
>                 BUG_ON(tm->slot < n);
>                 fallthrough;
> 	(...)
> 
> Fix this by checking for a more recent tree mod log operation after locking
> and cloning the extent buffer of the old root node, and use it as the first
> operation to apply to the cloned extent buffer when rewinding it.
> 
> Reported-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
> Link: https://lore.kernel.org/linux-btrfs/20210404040732.GZ32440@hungrycats.org/
> Fixes: 834328a8493079 ("Btrfs: tree mod log's old roots could still be part of the tree")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Thanks, added to misc-next.
