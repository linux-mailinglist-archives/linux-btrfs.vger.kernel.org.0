Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3749F4CE7A2
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Mar 2022 00:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiCEXUX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 5 Mar 2022 18:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiCEXUW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 5 Mar 2022 18:20:22 -0500
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B1CE25EB5
        for <linux-btrfs@vger.kernel.org>; Sat,  5 Mar 2022 15:19:31 -0800 (PST)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id DC510235AAC; Sat,  5 Mar 2022 18:19:28 -0500 (EST)
Date:   Sat, 5 Mar 2022 18:19:28 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: avoid full commit due to race when logging dentry
 deletion
Message-ID: <YiPwAKbOEebtdc2i@hungrycats.org>
References: <78d0dffe5f48910e126886559d0c69194b32eab9.1646416779.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78d0dffe5f48910e126886559d0c69194b32eab9.1646416779.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 04, 2022 at 06:10:57PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> During a rename, when logging that a directory entry was deleted, we may
> race with another task that is logging the directory. Even though the
> directory is locked at the VFS level, its logging can be triggered when
> other task is logging some other inode that had, or still has, a dentry
> in the directory (because its last_unlink_trans matches the current
> transaction).
> 
> The chances are slim, and if the race happens, recording the deletion
> through insert_dir_log_key() can fail with -EEXIST and result in marking
> the log for a full transaction commit, which will make the next fsync
> fallback to a transaction commit. The opposite can also happen, we log the
> key before the other task attempts to insert the same key, in which case
> it fails with -EEXIST and fallsback to a transaction commit or trigger an
> assertion at process_dir_items_leaf() due to the unexpected -EEXIST error.

Nice!  I was just about to report this.  I had a test VM hit it a dozen
times running misc-next.

Does the stack trace look like this?

	[  324.007183][ T5981] assertion failed: ret != -EEXIST, in fs/btrfs/tree-log.c:3857
	[  324.014960][ T5981] ------------[ cut here ]------------
	[  324.020696][ T5981] kernel BUG at fs/btrfs/ctree.h:3553!
	[  324.026478][ T5981] invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
	[  324.032768][ T5981] CPU: 3 PID: 5981 Comm: repro-ghost-dir Not tainted 5.17.0-5d855cca4965-misc-next+ #154 0ccd294c521679ce6b41b39a0ab10e4adb946622
	[  324.046174][ T5981] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
	[  324.064520][ T5981] RIP: 0010:assertfail.constprop.0+0x1c/0x1e
	[  324.073000][ T5981] Code: b3 4c 89 ef e8 2e 28 ff ff e9 d4 22 df fe 55 89 f1 48 c7 c2 40 43 4e b3 48 89 fe 48 c7 c7 80 43 4e b3 48 89 e5 e8 ce 81 fd ff <0f> 0b e8 7c 14 9a fe be a7 0e 00 00 48 c7 c7 20 44 4e b3 e8 cc ff
	[  324.092521][ T5981] RSP: 0018:ffffc90005c1f198 EFLAGS: 00010282
	[  324.094666][ T5981] RAX: 000000000000003d RBX: 00000000000008e4 RCX: 0000000000000000
	[  324.099245][ T5981] RDX: 0000000000000001 RSI: ffffffffb36038e0 RDI: fffff52000b83e26
	[  324.104262][ T5981] RBP: ffffc90005c1f198 R08: 000000000000003d R09: ffff8881f7016507
	[  324.109447][ T5981] R10: ffffed103ee02ca0 R11: 0000000000000001 R12: 00000000ffffffef
	[  324.114318][ T5981] R13: ffff88812c4d17c8 R14: ffff8881da62e1f8 R15: ffffc90005c1f368
	[  324.119009][ T5981] FS:  00007f82dd62a640(0000) GS:ffff8881f6e00000(0000) knlGS:0000000000000000
	[  324.124619][ T5981] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	[  324.128796][ T5981] CR2: 000055a3e6285078 CR3: 0000000122b88005 CR4: 0000000000170ee0
	[  324.133953][ T5981] Call Trace:
	[  324.135883][ T5981]  <TASK>
	[  324.137797][ T5981]  log_dir_items.cold+0x16/0x2c
	[  324.140806][ T5981]  ? replay_one_extent+0xbe0/0xbe0
	[  324.144779][ T5981]  ? __asan_loadN+0xf/0x20
	[  324.147926][ T5981]  ? __kasan_check_read+0x11/0x20
	[  324.151339][ T5981]  ? check_chain_key+0x1ee/0x2e0
	[  324.154930][ T5981]  ? __this_cpu_preempt_check+0x13/0x20
	[  324.158814][ T5981]  log_directory_changes+0xf9/0x170
	[  324.162212][ T5981]  ? log_dir_items+0xba0/0xba0
	[  324.165276][ T5981]  ? do_raw_write_unlock+0x7d/0xe0
	[  324.168437][ T5981]  btrfs_log_inode+0x2345/0x26d0
	[  324.171480][ T5981]  ? __asan_loadN+0xf/0x20
	[  324.174221][ T5981]  ? log_directory_changes+0x170/0x170
	[  324.177464][ T5981]  ? __this_cpu_preempt_check+0x13/0x20
	[  324.180617][ T5981]  ? __this_cpu_preempt_check+0x13/0x20
	[  324.183851][ T5981]  ? __might_resched+0x129/0x1c0
	[  324.186715][ T5981]  ? __might_sleep+0x66/0xc0
	[  324.189432][ T5981]  ? __kasan_check_read+0x11/0x20
	[  324.192502][ T5981]  ? iget5_locked+0xbd/0x150
	[  324.195165][ T5981]  ? acls_after_inode_item+0x290/0x290
	[  324.199052][ T5981]  ? btrfs_iget+0xc7/0x150
	[  324.202206][ T5981]  ? btrfs_orphan_cleanup+0x4a0/0x4a0
	[  324.205589][ T5981]  ? free_extent_buffer+0x13/0x20
	[  324.208814][ T5981]  btrfs_log_inode+0x268b/0x26d0
	[  324.212339][ T5981]  ? log_directory_changes+0x170/0x170
	[  324.215788][ T5981]  ? __this_cpu_preempt_check+0x13/0x20
	[  324.219077][ T5981]  ? lock_downgrade+0x420/0x420
	[  324.222273][ T5981]  ? __mutex_lock+0x540/0xdc0
	[  324.225490][ T5981]  ? check_chain_key+0x1ee/0x2e0
	[  324.228805][ T5981]  ? __kasan_check_write+0x14/0x20
	[  324.232127][ T5981]  ? __mutex_unlock_slowpath+0x12a/0x430
	[  324.235852][ T5981]  ? mutex_lock_io_nested+0xcd0/0xcd0
	[  324.239247][ T5981]  ? wait_for_completion_io_timeout+0x20/0x20
	[  324.243062][ T5981]  ? lock_downgrade+0x420/0x420
	[  324.246695][ T5981]  ? lock_contended+0x770/0x770
	[  324.250187][ T5981]  btrfs_log_inode_parent+0x523/0x17c0
	[  324.253818][ T5981]  ? pvclock_clocksource_read+0xde/0x1a0
	[  324.258191][ T5981]  ? __asan_loadN+0xf/0x20
	[  324.261498][ T5981]  ? pvclock_clocksource_read+0xde/0x1a0
	[  324.265875][ T5981]  ? btrfs_end_log_trans+0x70/0x70
	[  324.270084][ T5981]  ? __this_cpu_preempt_check+0x13/0x20
	[  324.274520][ T5981]  ? lock_downgrade+0x420/0x420
	[  324.277936][ T5981]  ? do_raw_spin_unlock+0xad/0x110
	[  324.281957][ T5981]  ? dget_parent+0xb7/0x300
	[  324.285570][ T5981]  btrfs_log_dentry_safe+0x48/0x60
	[  324.289434][ T5981]  btrfs_sync_file+0x629/0xa40
	[  324.292954][ T5981]  ? start_ordered_ops.constprop.0+0x120/0x120
	[  324.297919][ T5981]  ? __fget_files+0x167/0x230
	[  324.301706][ T5981]  vfs_fsync_range+0x6d/0x110
	[  324.304831][ T5981]  ? start_ordered_ops.constprop.0+0x120/0x120
	[  324.309013][ T5981]  __x64_sys_fsync+0x45/0x70
	[  324.311898][ T5981]  do_syscall_64+0x5c/0xc0
	[  324.315064][ T5981]  ? lockdep_hardirqs_on+0xce/0x150
	[  324.318504][ T5981]  ? syscall_exit_to_user_mode+0x3b/0x50
	[  324.322046][ T5981]  ? do_syscall_64+0x69/0xc0
	[  324.325180][ T5981]  ? sysvec_call_function_single+0x57/0xc0
	[  324.329166][ T5981]  ? asm_sysvec_call_function_single+0xa/0x20
	[  324.332977][ T5981]  entry_SYSCALL_64_after_hwframe+0x44/0xae
	[  324.336984][ T5981] RIP: 0033:0x7f82e137b6ab
	[  324.339923][ T5981] Code: 0f 05 48 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8 53 f7 ff ff 8b 7c 24 0c 41 89 c0 b8 4a 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 b1 f7 ff ff 8b 44
	[  324.353145][ T5981] RSP: 002b:00007f82dd629950 EFLAGS: 00000293 ORIG_RAX: 000000000000004a
	[  324.357209][ T5981] RAX: ffffffffffffffda RBX: 00007f82dd6299f0 RCX: 00007f82e137b6ab
	[  324.363329][ T5981] RDX: 0000000000000002 RSI: 0000000000000000 RDI: 000000000000000c
	[  324.369064][ T5981] RBP: 000000000000000c R08: 0000000000000000 R09: 0000000000000000
	[  324.374926][ T5981] R10: 00000000000001ff R11: 0000000000000293 R12: 0000000000000001
	[  324.380237][ T5981] R13: 000055be30453140 R14: 00007f82dd6299d0 R15: 000055be31bfe098
	[  324.385736][ T5981]  </TASK>

> So make that code that records a dentry deletion to be inside a critical
> section delimited by the directory's log mutex.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
> 
> David, this can be optionally squashed into the following patch:
> 
>    "btrfs: avoid logging all directory changes during renames"
> 
> (misc-next only)
> 
>  fs/btrfs/tree-log.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 4f61b38bb186..571dae8ad65e 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -7015,6 +7015,17 @@ void btrfs_log_new_name(struct btrfs_trans_handle *trans,
>  			goto out;
>  		}
>  
> +		/*
> +		 * Other concurrent task might be logging the old directory,
> +		 * as it can be triggered when logging other inode that had or
> +		 * still has a dentry in the old directory. So take the old
> +		 * directory's log_mutex to prevent getting an -EEXIST when
> +		 * logging a key to record the deletion, or having that other
> +		 * task logging the old directory get an -EEXIST if it attempts
> +		 * to log the same key after we just did it. In both cases that
> +		 * would result in falling back to a transaction commit.
> +		 */
> +		mutex_lock(&old_dir->log_mutex);
>  		ret = del_logged_dentry(trans, log, path, btrfs_ino(old_dir),
>  					old_dentry->d_name.name,
>  					old_dentry->d_name.len, old_dir_index);
> @@ -7028,6 +7039,7 @@ void btrfs_log_new_name(struct btrfs_trans_handle *trans,
>  						 btrfs_ino(old_dir),
>  						 old_dir_index, old_dir_index);
>  		}
> +		mutex_unlock(&old_dir->log_mutex);
>  
>  		btrfs_free_path(path);
>  		if (ret < 0)
> -- 
> 2.33.0
> 
