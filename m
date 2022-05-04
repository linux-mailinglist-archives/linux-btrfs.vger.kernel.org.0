Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED36951A402
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 May 2022 17:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349018AbiEDPar (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 May 2022 11:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352087AbiEDPad (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 May 2022 11:30:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2113C443C1
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 08:26:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D0CAF1F745;
        Wed,  4 May 2022 15:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651678015;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fnGtNOkQtNaE3PeHXPjrNFrd0aYZvDEpzSyhfbi2tGY=;
        b=GUOQu/avytZ1tBul71rUENp8fnlIDlXm9qZttjUlsSvhNKpVlX+vS3LViCTzJFBJFHkP3X
        JjFLqYZuZVarM9nA7TIK7JUim7e8oTW3MOQBX5lenXYHbJISobEMIQwOfwGedMm1FJfor7
        858+HHmUCfgaQC0QcBjmQ1E1DFk5dCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651678015;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fnGtNOkQtNaE3PeHXPjrNFrd0aYZvDEpzSyhfbi2tGY=;
        b=cty+92Q2A93fk/2LyPZMQnXf3lid6ajA7T/Z8HRkJK+JfX28OCGS+Z7FPxtMXUM+8XGv16
        ifCMKvSBHzaAEkAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A8E0E132C4;
        Wed,  4 May 2022 15:26:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id r5hIKD+bcmLsLwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 04 May 2022 15:26:55 +0000
Date:   Wed, 4 May 2022 17:22:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix assertion failure when logging directory key
 range item
Message-ID: <20220504152244.GP18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <fff3b4bac2270d6d4dba22d6b2c08ce315b8956b.1651573932.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fff3b4bac2270d6d4dba22d6b2c08ce315b8956b.1651573932.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 03, 2022 at 11:57:02AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When inserting a key range item (BTRFS_DIR_LOG_INDEX_KEY) while logging
> a directory, we don't expect the insertion to fail with -EEXIST, because
> we are holding the directory's log_mutex and we have dropped all existing
> BTRFS_DIR_LOG_INDEX_KEY keys from the log tree before we started to log
> the directory. However it's possible that during the logging we attempt
> to insert the same BTRFS_DIR_LOG_INDEX_KEY key twice, but for this to
> happen we need to race with insertions of items from other inodes in the
> subvolume's tree while we are logging a directory. Here's how this can
> happen:
> 
> 1) We are logging a directory with inode number 1000 that has its items
>    spread across 3 leaves in the subvolume's tree:
> 
>    leaf A - has index keys from the range 2 to 20 for example. The last
>    item in the leaf corresponds to a dir item for index number 20. All
>    these dir items were created in a past transaction.
> 
>    leaf B - has index keys from the range 22 to 100 for example. It has
>    no keys from other inodes, all its keys are dir index keys for our
>    directory inode number 1000. Its first key is for the dir item with
>    a sequence number of 22. All these dir items were also created in a
>    past transaction.
> 
>    leaf C - has index keys for our directory for the range 101 to 120 for
>    example. This leaf also has items from other inodes, and its first
>    item corresponds to the dir item for index number 101 for our directory
>    with inode number 1000;
> 
> 2) When we finish processing the items from leaf A at log_dir_items(),
>    we log a BTRFS_DIR_LOG_INDEX_KEY key with an offset of 21 and a last
>    offset of 21, meaning the log is authoritative for the index range
>    from 21 to 21 (a single sequence number). At this point leaf B was
>    not yet modified in the current transaction;
> 
> 3) When we return from log_dir_items() we have released our read lock on
>    leaf B, and have set *last_offset_ret to 21 (index number of the first
>    item on leaf B minus 1);
> 
> 4) Some other task inserts an item for other inode (inode number 1001 for
>    example) into leaf C. That resulted in pushing some items from leaf C
>    into leaf B, in order to make room for the new item, so now leaf B
>    has dir index keys for the sequence number range from 22 to 102 and
>    leaf C has the dir items for the sequence number range 103 to 120;
> 
> 5) At log_directory_changes() we call log_dir_items() again, passing it
>    a 'min_offset' / 'min_key' value of 22 (*last_offset_ret from step 3
>    plus 1, so 21 + 1). Then btrfs_search_forward() leaves us at slot 0
>    of leaf B, since leaf B was modified in the current transaction.
> 
>    We have also initialized 'last_old_dentry_offset' to 20 after calling
>    btrfs_previous_item() at log_dir_items(), as it left us at the last
>    item of leaf A, which refers to the dir item with sequence number 20;
> 
> 6) We then call process_dir_items_leaf() to process the dir items of
>    leaf B, and when we process the first item, corresponding to slot 0,
>    sequence number 22, we notice the dir item was created in a past
>    transaction and its sequence number is greater than the value of
>    *last_old_dentry_offset + 1 (20 + 1), so we decide to log again a
>    BTRFS_DIR_LOG_INDEX_KEY key with an offset of 21 and an end range
>    of 21 (key.offset - 1 == 22 - 1 == 21), which results in an -EEXIST
>    error from insert_dir_log_key(), as we have already inserted that
>    key at step 2, triggering the assertion at process_dir_items_leaf().
> 
> The trace produced in dmesg is like the following:
> 
> assertion failed: ret != -EEXIST, in fs/btrfs/tree-log.c:3857
> [198255.980839][ T7460] ------------[ cut here ]------------
> [198255.981666][ T7460] kernel BUG at fs/btrfs/ctree.h:3617!
> [198255.983141][ T7460] invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> [198255.984080][ T7460] CPU: 0 PID: 7460 Comm: repro-ghost-dir Not tainted 5.18.0-5314c78ac373-misc-next+
> [198255.986027][ T7460] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
> [198255.988600][ T7460] RIP: 0010:assertfail.constprop.0+0x1c/0x1e
> [198255.989465][ T7460] Code: 8b 4c 89 (...)
> [198255.992599][ T7460] RSP: 0018:ffffc90007387188 EFLAGS: 00010282
> [198255.993414][ T7460] RAX: 000000000000003d RBX: 0000000000000065 RCX: 0000000000000000
> [198255.996056][ T7460] RDX: 0000000000000001 RSI: ffffffff8b62b180 RDI: fffff52000e70e24
> [198255.997668][ T7460] RBP: ffffc90007387188 R08: 000000000000003d R09: ffff8881f0e16507
> [198255.999199][ T7460] R10: ffffed103e1c2ca0 R11: 0000000000000001 R12: 00000000ffffffef
> [198256.000683][ T7460] R13: ffff88813befc630 R14: ffff888116c16e70 R15: ffffc90007387358
> [198256.007082][ T7460] FS:  00007fc7f7c24640(0000) GS:ffff8881f0c00000(0000) knlGS:0000000000000000
> [198256.009939][ T7460] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [198256.014133][ T7460] CR2: 0000560bb16d0b78 CR3: 0000000140b34005 CR4: 0000000000170ef0
> [198256.015239][ T7460] Call Trace:
> [198256.015674][ T7460]  <TASK>
> [198256.016313][ T7460]  log_dir_items.cold+0x16/0x2c
> [198256.018858][ T7460]  ? replay_one_extent+0xbf0/0xbf0
> [198256.025932][ T7460]  ? release_extent_buffer+0x1d2/0x270
> [198256.029658][ T7460]  ? rcu_read_lock_sched_held+0x16/0x80
> [198256.031114][ T7460]  ? lock_acquired+0xbe/0x660
> [198256.032633][ T7460]  ? rcu_read_lock_sched_held+0x16/0x80
> [198256.034386][ T7460]  ? lock_release+0xcf/0x8a0
> [198256.036152][ T7460]  log_directory_changes+0xf9/0x170
> [198256.036993][ T7460]  ? log_dir_items+0xba0/0xba0
> [198256.037661][ T7460]  ? do_raw_write_unlock+0x7d/0xe0
> [198256.038680][ T7460]  btrfs_log_inode+0x233b/0x26d0
> [198256.041294][ T7460]  ? log_directory_changes+0x170/0x170
> [198256.042864][ T7460]  ? btrfs_attach_transaction_barrier+0x60/0x60
> [198256.045130][ T7460]  ? rcu_read_lock_sched_held+0x16/0x80
> [198256.046568][ T7460]  ? lock_release+0xcf/0x8a0
> [198256.047504][ T7460]  ? lock_downgrade+0x420/0x420
> [198256.048712][ T7460]  ? ilookup5_nowait+0x81/0xa0
> [198256.049747][ T7460]  ? lock_downgrade+0x420/0x420
> [198256.050652][ T7460]  ? do_raw_spin_unlock+0xa9/0x100
> [198256.051618][ T7460]  ? __might_resched+0x128/0x1c0
> [198256.052511][ T7460]  ? __might_sleep+0x66/0xc0
> [198256.053442][ T7460]  ? __kasan_check_read+0x11/0x20
> [198256.054251][ T7460]  ? iget5_locked+0xbd/0x150
> [198256.054986][ T7460]  ? run_delayed_iput_locked+0x110/0x110
> [198256.055929][ T7460]  ? btrfs_iget+0xc7/0x150
> [198256.056630][ T7460]  ? btrfs_orphan_cleanup+0x4a0/0x4a0
> [198256.057502][ T7460]  ? free_extent_buffer+0x13/0x20
> [198256.058322][ T7460]  btrfs_log_inode+0x2654/0x26d0
> [198256.059137][ T7460]  ? log_directory_changes+0x170/0x170
> [198256.060020][ T7460]  ? rcu_read_lock_sched_held+0x16/0x80
> [198256.060930][ T7460]  ? rcu_read_lock_sched_held+0x16/0x80
> [198256.061905][ T7460]  ? lock_contended+0x770/0x770
> [198256.062682][ T7460]  ? btrfs_log_inode_parent+0xd04/0x1750
> [198256.063582][ T7460]  ? lock_downgrade+0x420/0x420
> [198256.064432][ T7460]  ? preempt_count_sub+0x18/0xc0
> [198256.065550][ T7460]  ? __mutex_lock+0x580/0xdc0
> [198256.066654][ T7460]  ? stack_trace_save+0x94/0xc0
> [198256.068008][ T7460]  ? __kasan_check_write+0x14/0x20
> [198256.072149][ T7460]  ? __mutex_unlock_slowpath+0x12a/0x430
> [198256.073145][ T7460]  ? mutex_lock_io_nested+0xcd0/0xcd0
> [198256.074341][ T7460]  ? wait_for_completion_io_timeout+0x20/0x20
> [198256.075345][ T7460]  ? lock_downgrade+0x420/0x420
> [198256.076142][ T7460]  ? lock_contended+0x770/0x770
> [198256.076939][ T7460]  ? do_raw_spin_lock+0x1c0/0x1c0
> [198256.078401][ T7460]  ? btrfs_sync_file+0x5e6/0xa40
> [198256.080598][ T7460]  btrfs_log_inode_parent+0x523/0x1750
> [198256.081991][ T7460]  ? wait_current_trans+0xc8/0x240
> [198256.083320][ T7460]  ? lock_downgrade+0x420/0x420
> [198256.085450][ T7460]  ? btrfs_end_log_trans+0x70/0x70
> [198256.086362][ T7460]  ? rcu_read_lock_sched_held+0x16/0x80
> [198256.087544][ T7460]  ? lock_release+0xcf/0x8a0
> [198256.088305][ T7460]  ? lock_downgrade+0x420/0x420
> [198256.090375][ T7460]  ? dget_parent+0x8e/0x300
> [198256.093538][ T7460]  ? do_raw_spin_lock+0x1c0/0x1c0
> [198256.094918][ T7460]  ? lock_downgrade+0x420/0x420
> [198256.097815][ T7460]  ? do_raw_spin_unlock+0xa9/0x100
> [198256.101822][ T7460]  ? dget_parent+0xb7/0x300
> [198256.103345][ T7460]  btrfs_log_dentry_safe+0x48/0x60
> [198256.105052][ T7460]  btrfs_sync_file+0x629/0xa40
> [198256.106829][ T7460]  ? start_ordered_ops.constprop.0+0x120/0x120
> [198256.109655][ T7460]  ? __fget_files+0x161/0x230
> [198256.110760][ T7460]  vfs_fsync_range+0x6d/0x110
> [198256.111923][ T7460]  ? start_ordered_ops.constprop.0+0x120/0x120
> [198256.113556][ T7460]  __x64_sys_fsync+0x45/0x70
> [198256.114323][ T7460]  do_syscall_64+0x5c/0xc0
> [198256.115084][ T7460]  ? syscall_exit_to_user_mode+0x3b/0x50
> [198256.116030][ T7460]  ? do_syscall_64+0x69/0xc0
> [198256.116768][ T7460]  ? do_syscall_64+0x69/0xc0
> [198256.117555][ T7460]  ? do_syscall_64+0x69/0xc0
> [198256.118324][ T7460]  ? sysvec_call_function_single+0x57/0xc0
> [198256.119308][ T7460]  ? asm_sysvec_call_function_single+0xa/0x20
> [198256.120363][ T7460]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [198256.121334][ T7460] RIP: 0033:0x7fc7fe97b6ab
> [198256.122067][ T7460] Code: 0f 05 48 (...)
> [198256.125198][ T7460] RSP: 002b:00007fc7f7c23950 EFLAGS: 00000293 ORIG_RAX: 000000000000004a
> [198256.126568][ T7460] RAX: ffffffffffffffda RBX: 00007fc7f7c239f0 RCX: 00007fc7fe97b6ab
> [198256.127942][ T7460] RDX: 0000000000000002 RSI: 000056167536bcf0 RDI: 0000000000000004
> [198256.129302][ T7460] RBP: 0000000000000004 R08: 0000000000000000 R09: 000000007ffffeb8
> [198256.130670][ T7460] R10: 00000000000001ff R11: 0000000000000293 R12: 0000000000000001
> [198256.132046][ T7460] R13: 0000561674ca8140 R14: 00007fc7f7c239d0 R15: 000056167536dab8
> [198256.133403][ T7460]  </TASK>
> 
> Fix this by treating -EEXIST as expected at insert_dir_log_key() and have
> it update the item with an end offset corresponding to the maximum between
> the previously logged end offset and the new requested end offset. The end
> offsets may be different due to dir index key deletions that happened as
> part of unlink operations while we are logging a directory (triggered when
> fsyncing some other inode parented by the directory) or during renames
> which always attempt to log a single dir index deletion.
> 
> Reported-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
> Link: https://lore.kernel.org/linux-btrfs/YmyefE9mc2xl5ZMz@hungrycats.org/
> Fixes: 732d591a5d6c12 ("btrfs: stop copying old dir items when logging a directory")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
