Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA046737A1
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jan 2023 12:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjASL6o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Jan 2023 06:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbjASL6X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Jan 2023 06:58:23 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F902114
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 03:57:33 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 17B005C827;
        Thu, 19 Jan 2023 11:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674129452;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x2R5W9wS0wu7yKHubvqE6dm5hLV7JxFzxrxraiembos=;
        b=dWAmIhdKcXgeHLYk0mCx3V2QJgwMvJ6dwsUIQWt+HjPA3UuT7fSbPUw94Be7iw3GQrzt1Z
        U371cjeUWeo7TRuEWVeAdJanREjX751PuMdVsBmvNjzxVt7AhOrO74gbXMyBO10qKJ9ups
        OnxpbH37Lrf4aCvycczntoxBQ551Bbo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674129452;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x2R5W9wS0wu7yKHubvqE6dm5hLV7JxFzxrxraiembos=;
        b=NJmSPKez+rlqgp7T0z2AdZgRVT0Xis0RwS0hegOVd8yFEBXpPUb03PhfakjP5511HeS4u9
        7F3vy5/dlYBOeDAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C33D7134F5;
        Thu, 19 Jan 2023 11:57:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Yn+0LiswyWOdTgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 19 Jan 2023 11:57:31 +0000
Date:   Thu, 19 Jan 2023 12:51:52 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] btrfs: hold block_group refcount during async discard
Message-ID: <20230119115152.GH11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <07df5461bf34cf138f2f4b281a6fa6a0b389ff68.1673568238.git.boris@bur.io>
 <930c95d4-c55d-cbb3-ce2b-73c4333795d2@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <930c95d4-c55d-cbb3-ce2b-73c4333795d2@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 19, 2023 at 08:21:42AM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/1/13 08:05, Boris Burkov wrote:
> > Async discard does not acquire the block group reference count while it
> > holds a reference on the discard list. This is generally OK, as the
> > paths which destroy block groups tend to try to synchronize on
> > cancelling async discard work. However, relying on cancelling work
> > requires careful analysis to be sure it is safe from races with
> > unpinning scheduling more work.
> > 
> > While I am unable to find a race with unpinning in the current code for
> > either the unused bgs or relocation paths, I believe we have one in an
> > older version of auto relocation in a Meta internal build. This suggests
> > that this is in fact an error prone model, and could be fragile to
> > future changes to these bg deletion paths.
> > 
> > To make this ownership more clear, add a refcount for async discard. If
> > work is queued for a block group, its refcount should be incremented,
> > and when work is completed or canceled, it should be decremented.
> > 
> > Signed-off-by: Boris Burkov <boris@bur.io>
> 
> It looks like the patch is causing btrfs/011 to panic with the following 
> ASSERT() failure:

I see that in btrfs/004 and there's a use after free in 005 that's also
attached, though it obviously depends on the former. This seems like a
race conditon, this was on an NVMe as backing storage, HDD VMs don't
reproduce that.

btrfs/004        [21:51:14][  153.471653] run fstests btrfs/004 at 2023-01-18 21:51:15
[  154.123838] BTRFS info (device vda): using crc32c (crc32c-intel) checksum algorithm
[  154.124856] BTRFS info (device vda): using free space tree
[  154.133918] BTRFS info (device vda): auto enabling async discard
[  154.846829] BTRFS: device fsid 7f589b0c-c7b5-44e5-bf6c-7635414513b2 devid 1 transid 6 /dev/vdb scanned by mkfs.btrfs (19201)
[  154.888485] BTRFS info (device vdb): using crc32c (crc32c-intel) checksum algorithm
[  154.889428] BTRFS info (device vdb): using free space tree
[  154.902184] BTRFS info (device vdb): auto enabling async discard
[  154.903864] BTRFS info (device vdb): checking UUID tree
[  159.653583] BTRFS info (device vdb): using crc32c (crc32c-intel) checksum algorithm
[  159.654524] BTRFS info (device vdb): setting incompat feature flag for COMPRESS_LZO (0x8)
[  159.655693] BTRFS info (device vdb): use lzo compression, level 0
[  159.656538] BTRFS info (device vdb): using free space tree
[  159.666609] BTRFS info (device vdb): auto enabling async discard
[  165.550875] BTRFS info (device vdb): using crc32c (crc32c-intel) checksum algorithm
[  165.551799] BTRFS info (device vdb): using free space tree
[  165.570278] BTRFS info (device vdb): auto enabling async discard
[  298.053804] perf: interrupt took too long (2549 > 2500), lowering kernel.perf_event_max_sample_rate to 78250
[  336.179737] assertion failed: refcount_read(&block_group->refs) == 1, in fs/btrfs/block-group.c:4259
[  336.180918] ------------[ cut here ]------------
[  336.181476] kernel BUG at fs/btrfs/messages.c:259!
[  336.182032] invalid opcode: 0000 [#1] PREEMPT SMP KASAN
[  336.182597] CPU: 0 PID: 18955 Comm: umount Not tainted 6.2.0-rc4-default+ #67
[  336.183368] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552-rebuilt.opensuse.org 04/01/2014
[  336.184529] RIP: 0010:btrfs_assertfail+0x19/0x1b [btrfs]
[  336.186947] RSP: 0018:ffff888108a97c20 EFLAGS: 00010282
[  336.187431] RAX: 0000000000000058 RBX: ffff88800320b998 RCX: 0000000000000000
[  336.188097] RDX: 0000000000000058 RSI: 0000000000000008 RDI: ffffed1021152f77
[  336.188832] RBP: ffff888103840000 R08: 0000000000000001 R09: ffff888108a9796f
[  336.189572] R10: ffffed1021152f2d R11: 0000000000000000 R12: ffff88800320b9c0
[  336.190307] R13: ffff88800320b800 R14: ffff888100ccd1b0 R15: ffff888109c3b5b8
[  336.191037] FS:  00007f4b4d984800(0000) GS:ffff88811a800000(0000) knlGS:0000000000000000
[  336.191880] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  336.192494] CR2: 00007f0ef124d31e CR3: 0000000100d02001 CR4: 00000000003706b0
[  336.193207] Call Trace:
[  336.193559]  <TASK>
[  336.193874]  btrfs_free_block_groups.cold+0x52/0xae [btrfs]
[  336.194643]  close_ctree+0x6c2/0x761 [btrfs]
[  336.195149]  ? __wait_for_common+0x2b8/0x360
[  336.195595]  ? btrfs_cleanup_one_transaction.cold+0x7a/0x7a [btrfs]
[  336.196235]  ? lockdep_unregister_key+0x214/0x3c0
[  336.196713]  ? mark_held_locks+0x6b/0x90
[  336.197114]  ? lockdep_hardirqs_on_prepare+0x13d/0x200
[  336.197706]  ? __call_rcu_common.constprop.0+0x1ea/0x3d0
[  336.198320]  ? trace_hardirqs_on+0x2d/0x110
[  336.198829]  ? __call_rcu_common.constprop.0+0x1ea/0x3d0
[  336.199440]  generic_shutdown_super+0xb0/0x1c0
[  336.199995]  kill_anon_super+0x1e/0x40
[  336.200455]  btrfs_kill_super+0x25/0x30 [btrfs]
[  336.201077]  deactivate_locked_super+0x4c/0xc0
[  336.201614]  cleanup_mnt+0x13d/0x1f0
[  336.202094]  task_work_run+0xf2/0x170
[  336.202591]  ? task_work_cancel+0x20/0x20
[  336.203084]  ? lockdep_hardirqs_on_prepare+0x13d/0x200
[  336.203719]  exit_to_user_mode_prepare+0x109/0x130
[  336.204292]  syscall_exit_to_user_mode+0x19/0x40
[  336.204843]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[  336.205436] RIP: 0033:0x7f4b4dbb410b
[  336.207563] RSP: 002b:00007ffc89ec2038 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
[  336.208558] RAX: 0000000000000000 RBX: 00005643b954f9f0 RCX: 00007f4b4dbb410b
[  336.209478] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00005643b9550c90
[  336.210390] RBP: 00005643b954fb00 R08: 0000000000000000 R09: 0000000000000073
[  336.211278] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[  336.211934] R13: 00005643b9550c90 R14: 00005643b954fc20 R15: 00007ffc89ec509e
[  336.212544]  </TASK>
[  336.212804] Modules linked in: btrfs blake2b_generic libcrc32c crc32c_intel xor lzo_compress lzo_decompress raid6_pq zstd_decompress zstd_compress xxhash zstd_common loop
[  336.214123] ---[ end trace 0000000000000000 ]---
[  336.214560] RIP: 0010:btrfs_assertfail+0x19/0x1b [btrfs]
[  336.216649] RSP: 0018:ffff888108a97c20 EFLAGS: 00010282
[  336.217141] RAX: 0000000000000058 RBX: ffff88800320b998 RCX: 0000000000000000
[  336.217754] RDX: 0000000000000058 RSI: 0000000000000008 RDI: ffffed1021152f77
[  336.218364] RBP: ffff888103840000 R08: 0000000000000001 R09: ffff888108a9796f
[  336.218972] R10: ffffed1021152f2d R11: 0000000000000000 R12: ffff88800320b9c0
[  336.219582] R13: ffff88800320b800 R14: ffff888100ccd1b0 R15: ffff888109c3b5b8
[  336.220194] FS:  00007f4b4d984800(0000) GS:ffff88811a800000(0000) knlGS:0000000000000000
[  336.220898] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  336.221587] CR2: 00007f0ef124d31e CR3: 0000000100d02001 CR4: 00000000003706b0
_check_btrfs_filesystem: filesystem on /dev/vdb is inconsistent
(see /tmp/fstests/results//btrfs/004.full for details)
_check_dmesg: something found in dmesg (see /tmp/fstests/results//btrfs/004.dmesg)
 [21:54:17]
btrfs/005        [21:54:17][  336.472919] run fstests btrfs/005 at 2023-01-18 21:54:18
[  336.919873] BTRFS info (device vda): using crc32c (crc32c-intel) checksum algorithm
[  336.920734] BTRFS info (device vda): using free space tree
[  336.927751] BTRFS info (device vda): auto enabling async discard
[  337.157673] ==================================================================
[  337.158514] BUG: KASAN: use-after-free in rwsem_down_write_slowpath+0xb3a/0xc50
[  337.159355] Read of size 4 at addr ffff88810aabb334 by task mount/19191
[  337.160087] 
[  337.160335] CPU: 0 PID: 19191 Comm: mount Tainted: G      D            6.2.0-rc4-default+ #67
[  337.161292] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552-rebuilt.opensuse.org 04/01/2014
[  337.162388] Call Trace:
[  337.162665]  <TASK>
[  337.162919]  dump_stack_lvl+0x4c/0x5f
[  337.163286]  print_report+0x196/0x48e
[  337.166960]  ? __virt_addr_valid+0xc3/0x100
[  337.167372]  ? kasan_addr_to_slab+0x9/0xb0
[  337.167773]  ? rwsem_down_write_slowpath+0xb3a/0xc50
[  337.168228]  kasan_report+0xbb/0xf0
[  337.168576]  ? rwsem_down_write_slowpath+0xb3a/0xc50
[  337.169027]  rwsem_down_write_slowpath+0xb3a/0xc50
[  337.169483]  ? memcmp+0x83/0xa0
[  337.169824]  ? down_timeout+0x70/0x70
[  337.170186]  ? lock_acquire+0xbd/0x3c0
[  337.170556]  ? lock_contended+0xb3/0x6d0
[  337.170950]  ? __down_write_trylock+0xb7/0x270
[  337.171382]  ? debug_check_no_locks_held+0x50/0x50
[  337.171835]  ? rcu_read_lock_sched_held+0x10/0x70
[  337.172280]  ? lock_release+0xb2/0x6c0
[  337.172649]  ? lock_acquire+0xbd/0x3c0
[  337.173018]  ? grab_super+0x34/0x100
[  337.173375]  down_write+0x1c9/0x1e0
[  337.173728]  ? down_write_killable_nested+0x200/0x200
[  337.174203]  ? lock_contended+0x6d0/0x6d0
[  337.174594]  grab_super+0x3c/0x100
[  337.174937]  ? __traceiter_raid56_scrub_read_recover+0x70/0x70 [btrfs]
[  337.175613]  sget+0x201/0x2c0
[  337.175982]  ? btrfs_kill_super+0x30/0x30 [btrfs]
[  337.176635]  btrfs_mount_root+0x396/0x610 [btrfs]
[  337.177244]  ? __bpf_trace_find_free_extent_search_loop+0xe0/0xe0 [btrfs]
[  337.178003]  ? legacy_parse_param+0x48/0x3a0
[  337.178503]  ? strcmp+0x2e/0x50
[  337.178927]  ? rcu_read_lock_sched_held+0x10/0x70
[  337.179437]  ? kfree+0x130/0x1b0
[  337.179870]  ? vfs_parse_fs_string+0xd4/0x120
[  337.180408]  ? vfs_parse_fs_param+0x180/0x180
[  337.180890]  ? kasan_set_track+0x21/0x30
[  337.181285]  ? __kasan_kmalloc+0x86/0x90
[  337.181670]  ? __bpf_trace_find_free_extent_search_loop+0xe0/0xe0 [btrfs]
[  337.182332]  legacy_get_tree+0x80/0xd0
[  337.182703]  vfs_get_tree+0x43/0xf0
[  337.183053]  vfs_kern_mount.part.0+0x73/0xd0
[  337.183521]  btrfs_mount+0x1b6/0x590 [btrfs]
[  337.184164]  ? vfs_parse_fs_string+0xac/0x120
[  337.184587]  ? entry_SYSCALL_64_after_hwframe+0x46/0xb0
[  337.185064]  ? btrfs_show_options+0x900/0x900 [btrfs]
[  337.185611]  ? kasan_unpoison+0x23/0x50
[  337.185994]  ? __kasan_slab_alloc+0x2f/0x70
[  337.186401]  ? strcmp+0x2e/0x50
[  337.186734]  ? vfs_parse_fs_param_source+0x5c/0xe0
[  337.187180]  ? legacy_parse_param+0x48/0x3a0
[  337.187620]  ? strcmp+0x2e/0x50
[  337.187952]  ? rcu_read_lock_sched_held+0x10/0x70
[  337.188385]  ? kfree+0x130/0x1b0
[  337.188718]  ? vfs_parse_fs_string+0xd4/0x120
[  337.189138]  ? vfs_parse_fs_param+0x180/0x180
[  337.189549]  ? kasan_set_track+0x21/0x30
[  337.189930]  ? btrfs_show_options+0x900/0x900 [btrfs]
[  337.190480]  legacy_get_tree+0x80/0xd0
[  337.190848]  vfs_get_tree+0x43/0xf0
[  337.191198]  path_mount+0x9b8/0xef0
[  337.191551]  ? lockdep_hardirqs_on_prepare+0xe/0x200
[  337.192010]  ? finish_automount+0x470/0x470
[  337.192406]  ? kasan_quarantine_put+0x76/0x1b0
[  337.192832]  ? user_path_at_empty+0x40/0x50
[  337.193249]  ? kmem_cache_free+0xf9/0x3f0
[  337.193640]  __x64_sys_mount+0x24c/0x2c0
[  337.194026]  ? copy_mnt_ns+0x5e0/0x5e0
[  337.194396]  ? getname_flags+0xa1/0x260
[  337.194771]  ? lockdep_hardirqs_on_prepare+0xe/0x200
[  337.195224]  ? syscall_enter_from_user_mode+0x1c/0x40
[  337.195683]  do_syscall_64+0x2b/0x50
[  337.196045]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[  337.196517] RIP: 0033:0x7f6b961da68e
[  337.198367] RSP: 002b:00007ffc8e3478e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
[  337.199038] RAX: ffffffffffffffda RBX: 0000563fcd6c39f0 RCX: 00007f6b961da68e
[  337.199647] RDX: 0000563fcd6c3c20 RSI: 0000563fcd6c3c60 RDI: 0000563fcd6c3c40
[  337.200279] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000073
[  337.200891] R10: 0000000000000000 R11: 0000000000000246 R12: 0000563fcd6c3c20
[  337.201522] R13: 0000563fcd6c3c40 R14: 0000000000000000 R15: 00007f6b96322076
[  337.202146]  </TASK>
[  337.202407] 
[  337.202620] Allocated by task 18950:
[  337.202977]  kasan_save_stack+0x1c/0x40
[  337.203356]  kasan_set_track+0x21/0x30
[  337.203747]  __kasan_slab_alloc+0x65/0x70
[  337.204162]  kmem_cache_alloc_node+0x10e/0x220
[  337.204666]  copy_process+0x30c/0x2d10
[  337.205098]  kernel_clone+0xf4/0x4e0
[  337.205484]  __do_sys_clone+0xb6/0xf0
[  337.205885]  do_syscall_64+0x2b/0x50
[  337.206250]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[  337.206740] 
[  337.206964] Freed by task 0:
[  337.207373]  kasan_save_stack+0x1c/0x40
[  337.207866]  kasan_set_track+0x21/0x30
[  337.208249]  kasan_save_free_info+0x2a/0x40
[  337.208656]  ____kasan_slab_free+0x1b7/0x210
[  337.209068]  kmem_cache_free+0xf9/0x3f0
[  337.209450]  rcu_core+0x529/0xd40
[  337.209794]  __do_softirq+0x105/0x69a
[  337.210168] 
[  337.210385] Last potentially related work creation:
[  337.210831]  kasan_save_stack+0x1c/0x40
[  337.211207]  __kasan_record_aux_stack+0x100/0x110
[  337.211652]  __call_rcu_common.constprop.0+0x47/0x3d0
[  337.212121]  wait_consider_task+0xa61/0x1760
[  337.212537]  do_wait+0x3bd/0x5b0
[  337.212872]  kernel_wait4+0xeb/0x1c0
[  337.213230]  __do_sys_wait4+0xf0/0x100
[  337.213601]  do_syscall_64+0x2b/0x50
[  337.213958]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[  337.214424] 
[  337.214635] Second to last potentially related work creation:
[  337.215141]  kasan_save_stack+0x1c/0x40
[  337.215517]  __kasan_record_aux_stack+0x100/0x110
[  337.215964]  __call_rcu_common.constprop.0+0x47/0x3d0
[  337.216431]  wait_consider_task+0xa61/0x1760
[  337.216840]  do_wait+0x3bd/0x5b0
[  337.217174]  kernel_wait4+0xeb/0x1c0
[  337.217532]  __do_sys_wait4+0xf0/0x100
[  337.217900]  do_syscall_64+0x2b/0x50
[  337.218257]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[  337.218722] 
[  337.218933] The buggy address belongs to the object at ffff88810aabb300
[  337.218933]  which belongs to the cache task_struct of size 12616
[  337.219953] The buggy address is located 52 bytes inside of
[  337.219953]  12616-byte region [ffff88810aabb300, ffff88810aabe448)
[  337.220930] 
[  337.221144] The buggy address belongs to the physical page:
[  337.221731] page:ffff88813f0aae00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10aab8
[  337.222586] head:ffff88813f0aae00 order:3 compound_mapcount:0 subpages_mapcount:0 compound_pincount:0
[  337.223574] flags: 0x4300000010200(slab|head|section=33|zone=2)
[  337.224209] raw: 0004300000010200 ffff8881000519c0 ffff88813efde410 ffff88813cc72810
[  337.225027] raw: 0000000000000000 0000000000020002 00000001ffffffff 0000000000000000
[  337.225834] page dumped because: kasan: bad access detected
[  337.226425] 
[  337.226663] Memory state around the buggy address:
[  337.227168]  ffff88810aabb200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  337.227936]  ffff88810aabb280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  337.228703] >ffff88810aabb300: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  337.229470]                                      ^
[  337.229997]  ffff88810aabb380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  337.230766]  ffff88810aabb400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  337.231534] ==================================================================
[  337.545046] EXT4-fs (sda): error count since last fsck: 63
[  337.547861] EXT4-fs (sda): initial error at time 1667566565: ext4_mb_generate_buddy:1095
[  337.550888] EXT4-fs (sda): last error at time 1674078512: ext4_mb_generate_buddy:1095
Connection closed by foreign host.
