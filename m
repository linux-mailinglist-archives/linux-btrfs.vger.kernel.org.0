Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAE158D263
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Aug 2022 05:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbiHIDbU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Aug 2022 23:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbiHIDbQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Aug 2022 23:31:16 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B755D642D
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Aug 2022 20:31:13 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 7248348CBA9; Mon,  8 Aug 2022 23:31:11 -0400 (EDT)
Date:   Mon, 8 Aug 2022 23:31:10 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     linux-btrfs@vger.kernel.org
Subject: for-next: KCSAN failures on 6130a25681d4 (kdave/for-next) Merge
 branch 'for-next-next-v5.20-20220804' into for-next-20220804
Message-ID: <YvHU/vsXd7uz5V6j@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Some KCSAN complaints I found while testing for other things...

Here's one related to extent refs:

	[ 2799.504795][ T5562] ==================================================================
	[ 2799.507470][ T5562] BUG: KCSAN: data-race in btrfs_block_rsv_release / btrfs_update_delayed_refs_rsv
	[ 2799.509416][ T5562] 
	[ 2799.509699][ T5562] write to 0xffff9c80059504c8 of 1 bytes by task 104535 on cpu 1:
	[ 2799.510634][ T5562]  btrfs_update_delayed_refs_rsv+0xcf/0x110
	[ 2799.511422][ T5562]  btrfs_add_delayed_tree_ref+0x393/0x690
	[ 2799.513587][ T5562]  btrfs_inc_extent_ref+0x8e/0xa0
	[ 2799.515080][ T5562]  __btrfs_mod_ref+0x3ca/0x6f0
	[ 2799.516543][ T5562]  btrfs_inc_ref+0x3d/0x70
	[ 2799.517010][ T5562]  update_ref_for_cow+0x41a/0x530
	[ 2799.519588][ T5562]  __btrfs_cow_block+0x4a6/0xae0
	[ 2799.521443][ T5562]  btrfs_cow_block+0x1da/0x3f0
	[ 2799.523088][ T5562]  btrfs_search_slot+0xb52/0x1460
	[ 2799.524794][ T5562]  btrfs_lookup_inode+0x5f/0x190
	[ 2799.526496][ T5562]  __btrfs_update_delayed_inode+0xed/0x4b0
	[ 2799.528514][ T5562]  btrfs_commit_inode_delayed_inode+0x1d8/0x1e0
	[ 2799.530614][ T5562]  btrfs_evict_inode+0x5dc/0x800
	[ 2799.532280][ T5562]  evict+0x1ad/0x330
	[ 2799.533807][ T5562]  iput.part.0+0x2e3/0x410
	[ 2799.535296][ T5562]  iput+0x3c/0x50
	[ 2799.535771][ T5562]  dentry_unlink_inode+0x1f4/0x280
	[ 2799.536427][ T5562]  __dentry_kill+0x21f/0x330
	[ 2799.538323][ T5562]  dput+0x44e/0x810
	[ 2799.538810][ T5562]  do_renameat2+0x4d5/0x900
	[ 2799.539374][ T5562]  __x64_sys_rename+0x67/0x90
	[ 2799.541644][ T5562]  do_syscall_64+0x5f/0xd0
	[ 2799.543103][ T5562]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
	[ 2799.544831][ T5562] 
	[ 2799.545138][ T5562] INFO: lockdep is turned off.
	[ 2799.545732][ T5562] irq event stamp: 0
	[ 2799.546233][ T5562] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
	[ 2799.547133][ T5562] hardirqs last disabled at (0): [<ffffffffa1127cca>] copy_process+0xe6a/0x3760
	[ 2799.548295][ T5562] softirqs last  enabled at (0): [<ffffffffa1127cca>] copy_process+0xe6a/0x3760
	[ 2799.549457][ T5562] softirqs last disabled at (0): [<0000000000000000>] 0x0
	[ 2799.550353][ T5562] 
	[ 2799.550654][ T5562] read to 0xffff9c80059504c8 of 1 bytes by task 5562 on cpu 3:
	[ 2799.551641][ T5562]  btrfs_block_rsv_release+0x5b/0x3f0
	[ 2799.552369][ T5562]  btrfs_inode_rsv_release+0x78/0x120
	[ 2799.553100][ T5562]  btrfs_delalloc_release_metadata+0xc1/0xf0
	[ 2799.553901][ T5562]  btrfs_clear_delalloc_extent+0x1b3/0x4b0
	[ 2799.554684][ T5562]  clear_state_bit+0x273/0x2c0
	[ 2799.555335][ T5562]  __clear_extent_bit+0x2f7/0x630
	[ 2799.556028][ T5562]  clear_extent_bit+0x54/0x80
	[ 2799.556664][ T5562]  btrfs_dirty_pages+0xe6/0x1d0
	[ 2799.557438][ T5562]  btrfs_buffered_write+0x6d1/0xa90
	[ 2799.558333][ T5562]  btrfs_do_write_iter+0x464/0x8a0
	[ 2799.559223][ T5562]  btrfs_file_write_iter+0x29/0x50
	[ 2799.560184][ T5562]  new_sync_write+0x204/0x300
	[ 2799.561071][ T5562]  vfs_write+0x457/0x5c0
	[ 2799.561876][ T5562]  ksys_write+0xb2/0x150
	[ 2799.562622][ T5562]  __x64_sys_write+0x4b/0x70
	[ 2799.563516][ T5562]  do_syscall_64+0x5f/0xd0
	[ 2799.564315][ T5562]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
	[ 2799.565431][ T5562] 
	[ 2799.565826][ T5562] INFO: lockdep is turned off.
	[ 2799.566683][ T5562] irq event stamp: 1566656
	[ 2799.567447][ T5562] hardirqs last  enabled at (1566655): [<ffffffffa30ce51d>] _raw_spin_unlock_irqrestore+0x7d/0xa0
	[ 2799.569315][ T5562] hardirqs last disabled at (1566656): [<ffffffffa30bee38>] __schedule+0x9a8/0x18c0
	[ 2799.570991][ T5562] softirqs last  enabled at (1565224): [<ffffffffa113ad8f>] __irq_exit_rcu+0xef/0x160
	[ 2799.572340][ T5562] softirqs last disabled at (1565219): [<ffffffffa113ad8f>] __irq_exit_rcu+0xef/0x160
	[ 2799.573754][ T5562] 
	[ 2799.574131][ T5562] Reported by Kernel Concurrency Sanitizer on:
	[ 2799.574947][ T5562] CPU: 3 PID: 5562 Comm: tee Tainted: G      D           5.19.0-466d9d7ea677-for-next+ #85 89955463945a81b56a449b1f12383cf0d5e6b898
	[ 2799.576954][ T5562] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
	[ 2799.578369][ T5562] ==================================================================

Writer is:

	btrfs_update_delayed_refs_rsv+0xce/0x110:

	btrfs_update_delayed_refs_rsv at fs/btrfs/delayed-ref.c:135
	 130            if (btrfs_test_opt(fs_info, FREE_SPACE_TREE))
	 131                    num_bytes *= 2;
	 132    
	 133            spin_lock(&delayed_rsv->lock);
	 134            delayed_rsv->size += num_bytes;
	>135<           delayed_rsv->full = false;
	 136            spin_unlock(&delayed_rsv->lock);
	 137            trans->delayed_ref_updates = 0;
	 138    }
	 139    
	 140    /**

Reader is:

	btrfs_block_rsv_release+0x5b/0x3f0:

	btrfs_block_rsv_release at fs/btrfs/block-rsv.c:289 (discriminator 1)
	 284             * If we are the delayed_rsv then push to the global rsv, otherwise dump
	 285             * into the delayed rsv if it is not full.
	 286             */
	 287            if (block_rsv == delayed_rsv)
	 288                    target = global_rsv;
	>289<           else if (block_rsv != global_rsv && !delayed_rsv->full)
	 290                    target = delayed_rsv;
	 291    
	 292            if (target && block_rsv->space_info != target->space_info)
	 293                    target = NULL;
	 294    

Another, this time with btrfs_block_rsv_release racing with itself:

	[ 2785.914537][ T3379] ==================================================================
	[ 2785.916300][ T3379] BUG: KCSAN: data-race in btrfs_block_rsv_release / btrfs_block_rsv_release
	[ 2785.918215][ T3379] 
	[ 2785.918641][ T3379] read to 0xffff9c80059504c8 of 1 bytes by task 6169 on cpu 2:
	[ 2785.920426][ T3379]  btrfs_block_rsv_release+0x5b/0x3f0
	[ 2785.921671][ T3379]  btrfs_trans_release_metadata+0xae/0xe0
	[ 2785.956873][ T3379]  __btrfs_end_transaction+0x80/0x4f0
	[ 2785.958523][ T3379]  btrfs_end_transaction+0x21/0x40
	[ 2785.959223][ T3379]  btrfs_evict_inode+0x7e9/0x800
	[ 2785.959896][ T3379]  evict+0x1ad/0x330
	[ 2785.960430][ T3379]  iput.part.0+0x2e3/0x410
	[ 2785.964122][ T3379]  iput+0x3c/0x50
	[ 2785.967801][ T3379]  dentry_unlink_inode+0x1f4/0x280
	[ 2785.973195][ T3379]  __dentry_kill+0x21f/0x330
	[ 2785.978567][ T3379]  dput+0x44e/0x810
	[ 2785.983573][ T3379]  do_renameat2+0x4d5/0x900
	[ 2786.037153][ T3379]  __x64_sys_rename+0x67/0x90
	[ 2786.037717][ T3379]  do_syscall_64+0x5f/0xd0
	[ 2786.038242][ T3379]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
	[ 2786.038931][ T3379] 
	[ 2786.039208][ T3379] INFO: lockdep is turned off.
	[ 2786.039755][ T3379] irq event stamp: 3250759
	[ 2786.040333][ T3379] hardirqs last  enabled at (3250758): [<ffffffffa30ce452>] _raw_spin_unlock_irq+0x32/0x80
	[ 2786.041701][ T3379] hardirqs last disabled at (3250759): [<ffffffffa30bee38>] __schedule+0x9a8/0x18c0
	[ 2786.043073][ T3379] softirqs last  enabled at (3250361): [<ffffffffa113ad8f>] __irq_exit_rcu+0xef/0x160
	[ 2786.044221][ T3379] softirqs last disabled at (3250352): [<ffffffffa113ad8f>] __irq_exit_rcu+0xef/0x160
	[ 2786.045392][ T3379] 
	[ 2786.045712][ T3379] write to 0xffff9c80059504c8 of 1 bytes by task 3379 on cpu 0:
	[ 2786.046658][ T3379]  btrfs_block_rsv_release+0x23e/0x3f0
	[ 2786.047397][ T3379]  btrfs_delayed_refs_rsv_release+0x75/0xd0
	[ 2786.057504][ T3379]  btrfs_cleanup_ref_head_accounting+0x4f/0x140
	[ 2786.058314][ T3379]  __btrfs_run_delayed_refs+0x18c9/0x2080
	[ 2786.059279][ T3379]  btrfs_run_delayed_refs+0xcd/0x310
	[ 2786.061723][ T3379]  btrfs_commit_transaction+0x136/0x1800
	[ 2786.064101][ T3379]  transaction_kthread+0x24c/0x2d0
	[ 2786.066161][ T3379]  kthread+0x1ab/0x1e0
	[ 2786.067969][ T3379]  ret_from_fork+0x22/0x30
	[ 2786.070012][ T3379] 
	[ 2786.070391][ T3379] INFO: lockdep is turned off.
	[ 2786.073032][ T3379] irq event stamp: 5460863
	[ 2786.075562][ T3379] hardirqs last  enabled at (5460862): [<ffffffffa30ce51d>] _raw_spin_unlock_irqrestore+0x7d/0xa0
	[ 2786.079952][ T3379] hardirqs last disabled at (5460863): [<ffffffffa30bee38>] __schedule+0x9a8/0x18c0
	[ 2786.084111][ T3379] softirqs last  enabled at (5460221): [<ffffffffa113ad8f>] __irq_exit_rcu+0xef/0x160
	[ 2786.088033][ T3379] softirqs last disabled at (5460214): [<ffffffffa113ad8f>] __irq_exit_rcu+0xef/0x160
	[ 2786.091680][ T3379] 
	[ 2786.092464][ T3379] Reported by Kernel Concurrency Sanitizer on:
	[ 2786.095225][ T3379] CPU: 0 PID: 3379 Comm: btrfs-transacti Tainted: G      D           5.19.0-466d9d7ea677-for-next+ #85 89955463945a81b56a449b1f12383cf0d5e6b898
	[ 2786.100076][ T3379] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
	[ 2786.102614][ T3379] ==================================================================

	btrfs_block_rsv_release+0x23e/0x3f0:

	btrfs_block_rsv_release at fs/btrfs/block-rsv.c:121
	 116            }
	 117            block_rsv->size -= num_bytes;
	 118            if (block_rsv->reserved >= block_rsv->size) {
	 119                    num_bytes = block_rsv->reserved - block_rsv->size;
	 120                    block_rsv->reserved = block_rsv->size;
	>121<                   block_rsv->full = true;
	 122            } else {
	 123                    num_bytes = 0;
	 124            }
	 125            if (block_rsv->qgroup_rsv_reserved >= block_rsv->qgroup_rsv_size) {
	 126                    qgroup_to_release = block_rsv->qgroup_rsv_reserved -

There's another one in start_transaction.  It's basically everywhere, and
always looking at some struct's ->full member:

	start_transaction+0x8ce/0xa40:

	start_transaction at fs/btrfs/transaction.c:638 (discriminator 1)
	 633                     * worth of delayed refs updates in this trans handle, and
	 634                     * refill that amount for whatever is missing in the reserve.
	 635                     */
	 636                    num_bytes = btrfs_calc_insert_metadata_size(fs_info, num_items);
	 637                    if (flush == BTRFS_RESERVE_FLUSH_ALL &&
	>638<                       delayed_refs_rsv->full == 0) {
	 639                            delayed_refs_bytes = num_bytes;
	 640                            num_bytes <<= 1;
	 641                    }
	 642    
	 643                    /*

