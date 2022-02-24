Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008134C2EE5
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Feb 2022 16:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235782AbiBXPEH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Feb 2022 10:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235692AbiBXPEF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Feb 2022 10:04:05 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFF31598C3
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Feb 2022 07:03:35 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2AD172114D;
        Thu, 24 Feb 2022 15:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645715014;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kDilMcJxBFu0AyE6LcBSddZQElOGnF7tRhSJbnVrAv8=;
        b=haRr6SpQNzYn7+fddRtaj0EcNmrek4bqbYB5qmisEFjMoUCktEBAoalJTN7PTQwLcf02Ar
        Qx/8+drbSoNx0v9hctG7tX98cTodnr8bPFN8WtaIJ4Mw4j8pmad7N8U2wZUGNE0rzabbTq
        xg/CNMK2rIT1uOtPwszrRzM2N2De80o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645715014;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kDilMcJxBFu0AyE6LcBSddZQElOGnF7tRhSJbnVrAv8=;
        b=y5gdw3hsvJ0/IA1dV3BA7DVEJAx8fk/tlNNdCLfeAdaDsf5FJyphBLyESpWbgo0Rahz6TA
        dne5I6FBWkvVAxAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1FD2EA3B90;
        Thu, 24 Feb 2022 15:03:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 03ED7DA818; Thu, 24 Feb 2022 15:59:44 +0100 (CET)
Date:   Thu, 24 Feb 2022 15:59:44 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: fix relocation crash due to premature return from
 btrfs_commit_transaction()
Message-ID: <20220224145944.GW12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Filipe Manana <fdmanana@suse.com>
References: <4ebf450a931e83b1d305d07fcc6db104b85c2627.1645139641.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ebf450a931e83b1d305d07fcc6db104b85c2627.1645139641.git.osandov@fb.com>
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

On Thu, Feb 17, 2022 at 03:14:43PM -0800, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> We are seeing crashes similar to the following trace:
> 
> [   38.968587] ------------[ cut here ]------------
> [   38.969182] WARNING: CPU: 20 PID: 2105 at fs/btrfs/relocation.c:4070 btrfs_relocate_block_group+0x2dc/0x340 [btrfs]
> [   38.970984] Modules linked in: btrfs blake2b_generic xor pata_acpi ata_piix libata raid6_pq scsi_mod libcrc32c virtio_net virtio_rng net_failover rng_core failover scsi_common
> [   38.973556] CPU: 20 PID: 2105 Comm: btrfs Not tainted 5.17.0-rc4 #54
> [   38.974580] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> [   38.976539] RIP: 0010:btrfs_relocate_block_group+0x2dc/0x340 [btrfs]
> [   38.977489] Code: fe ff ff ff e9 f0 fd ff ff 0f 0b e9 f1 fe ff ff 4c 89 e7 41 bd f4 ff ff ff e8 50 0e 03 00 e9 d6 fd ff ff 0f 0b e9 45 ff ff ff <0f> 0b e9 33 ff ff ff 48 8b 45 10 48 83 ca ff 31 f6 48 8b 78 30 e8

Please delete the long lines unless it's relevant for the report,
usually the Code and module list are not.

> [   38.980336] RSP: 0000:ffffb0dd42e03c20 EFLAGS: 00010206
> [   38.981218] RAX: ffff96cfc4ede800 RBX: ffff96cfc3ce0000 RCX: 000000000002ca14
> [   38.982560] RDX: 0000000000000000 RSI: 4cfd109a0bcb5d7f RDI: ffff96cfc3ce0360
> [   38.983619] RBP: ffff96cfc309c000 R08: 0000000000000000 R09: 0000000000000000
> [   38.984678] R10: ffff96cec0000001 R11: ffffe84c80000000 R12: ffff96cfc4ede800
> [   38.985735] R13: 0000000000000000 R14: 0000000000000000 R15: ffff96cfc3ce0360
> [   38.987146] FS:  00007f11c15218c0(0000) GS:ffff96d6dfb00000(0000) knlGS:0000000000000000
> [   38.988662] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   38.989398] CR2: 00007ffc922c8e60 CR3: 00000001147a6001 CR4: 0000000000370ee0
> [   38.990279] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   38.991219] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   38.992528] Call Trace:
> [   38.992854]  <TASK>
> [   38.993148]  btrfs_relocate_chunk+0x27/0xe0 [btrfs]
> [   38.993941]  btrfs_balance+0x78e/0xea0 [btrfs]
> [   38.994801]  ? vsnprintf+0x33c/0x520
> [   38.995368]  ? __kmalloc_track_caller+0x351/0x440
> [   38.996198]  btrfs_ioctl_balance+0x2b9/0x3a0 [btrfs]
> [   38.997084]  btrfs_ioctl+0x11b0/0x2da0 [btrfs]
> [   38.997867]  ? mod_objcg_state+0xee/0x340
> [   38.998552]  ? seq_release+0x24/0x30
> [   38.999184]  ? proc_nr_files+0x30/0x30
> [   38.999654]  ? call_rcu+0xc8/0x2f0
> [   39.000228]  ? __x64_sys_ioctl+0x84/0xc0
> [   39.000872]  ? btrfs_ioctl_get_supported_features+0x30/0x30 [btrfs]
> [   39.001973]  __x64_sys_ioctl+0x84/0xc0
> [   39.002566]  do_syscall_64+0x3a/0x80
> [   39.003011]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [   39.003735] RIP: 0033:0x7f11c166959b
> [   39.004302] Code: ff ff ff 85 c0 79 9b 49 c7 c4 ff ff ff ff 5b 5d 4c 89 e0 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a5 a8 0c 00 f7 d8 64 89 01 48
> [   39.007324] RSP: 002b:00007fff2543e998 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [   39.008521] RAX: ffffffffffffffda RBX: 00007f11c1521698 RCX: 00007f11c166959b
> [   39.009833] RDX: 00007fff2543ea40 RSI: 00000000c4009420 RDI: 0000000000000003
> [   39.011270] RBP: 0000000000000003 R08: 0000000000000013 R09: 00007f11c16f94e0
> [   39.012581] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff25440df3
> [   39.014046] R13: 0000000000000000 R14: 00007fff2543ea40 R15: 0000000000000001
> [   39.015040]  </TASK>
> [   39.015418] ---[ end trace 0000000000000000 ]---
> [   43.131559] ------------[ cut here ]------------
> [   43.132234] kernel BUG at fs/btrfs/extent-tree.c:2717!
> [   43.133031] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> [   43.133702] CPU: 1 PID: 1839 Comm: btrfs Tainted: G        W         5.17.0-rc4 #54
> [   43.134863] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> [   43.136426] RIP: 0010:unpin_extent_range+0x37a/0x4f0 [btrfs]
> [   43.137255] Code: fd ff ff 4d 8d b5 08 01 00 00 4c 89 f7 e8 de f2 49 ef 66 41 83 bd 0c 01 00 00 00 74 0f 4c 89 f7 e8 2b f3 49 ef e9 ed fe ff ff <0f> 0b 49 8b 85 f8 00 00 00 4d 8b 9d f0 00 00 00 49 29 c3 49 39 db
> [   43.139913] RSP: 0000:ffffb0dd4216bc70 EFLAGS: 00010246
> [   43.140629] RAX: 0000000000000000 RBX: ffff96cfc34490f8 RCX: 0000000000000001
> [   43.141604] RDX: 0000000080000001 RSI: 0000000051d00000 RDI: 00000000ffffffff
> [   43.142645] RBP: 0000000000000000 R08: 0000000000000000 R09: ffff96cfd07dca50
> [   43.143669] R10: ffff96cfc46e8a00 R11: fffffffffffec000 R12: 0000000041d00000
> [   43.144657] R13: ffff96cfc3ce0000 R14: ffffb0dd4216bd08 R15: 0000000000000000
> [   43.145686] FS:  00007f7657dd68c0(0000) GS:ffff96d6df640000(0000) knlGS:0000000000000000
> [   43.146808] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   43.147584] CR2: 00007f7fe81bf5b0 CR3: 00000001093ee004 CR4: 0000000000370ee0
> [   43.148589] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   43.149581] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   43.150559] Call Trace:
> [   43.150904]  <TASK>
> [   43.151253]  btrfs_finish_extent_commit+0x88/0x290 [btrfs]
> [   43.152127]  btrfs_commit_transaction+0x74f/0xaa0 [btrfs]
> [   43.152932]  ? btrfs_attach_transaction_barrier+0x1e/0x50 [btrfs]
> [   43.153786]  btrfs_ioctl+0x1edc/0x2da0 [btrfs]
> [   43.154475]  ? __check_object_size+0x150/0x170
> [   43.155170]  ? preempt_count_add+0x49/0xa0
> [   43.155753]  ? __x64_sys_ioctl+0x84/0xc0
> [   43.156437]  ? btrfs_ioctl_get_supported_features+0x30/0x30 [btrfs]
> [   43.157456]  __x64_sys_ioctl+0x84/0xc0
> [   43.157980]  do_syscall_64+0x3a/0x80
> [   43.158543]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [   43.159231] RIP: 0033:0x7f7657f1e59b
> [   43.159653] Code: ff ff ff 85 c0 79 9b 49 c7 c4 ff ff ff ff 5b 5d 4c 89 e0 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a5 a8 0c 00 f7 d8 64 89 01 48
> [   43.161819] RSP: 002b:00007ffda5cd1658 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [   43.162702] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f7657f1e59b
> [   43.163526] RDX: 0000000000000000 RSI: 0000000000009408 RDI: 0000000000000003
> [   43.164358] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
> [   43.165208] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> [   43.166029] R13: 00005621b91c3232 R14: 00005621b91ba580 R15: 00007ffda5cd1800
> [   43.166863]  </TASK>
> [   43.167125] Modules linked in: btrfs blake2b_generic xor pata_acpi ata_piix libata raid6_pq scsi_mod libcrc32c virtio_net virtio_rng net_failover rng_core failover scsi_common
> [   43.169552] ---[ end trace 0000000000000000 ]---
> [   43.171226] RIP: 0010:unpin_extent_range+0x37a/0x4f0 [btrfs]
> [   43.172356] Code: fd ff ff 4d 8d b5 08 01 00 00 4c 89 f7 e8 de f2 49 ef 66 41 83 bd 0c 01 00 00 00 74 0f 4c 89 f7 e8 2b f3 49 ef e9 ed fe ff ff <0f> 0b 49 8b 85 f8 00 00 00 4d 8b 9d f0 00 00 00 49 29 c3 49 39 db
> [   43.174767] RSP: 0000:ffffb0dd4216bc70 EFLAGS: 00010246
> [   43.175600] RAX: 0000000000000000 RBX: ffff96cfc34490f8 RCX: 0000000000000001
> [   43.176468] RDX: 0000000080000001 RSI: 0000000051d00000 RDI: 00000000ffffffff
> [   43.177357] RBP: 0000000000000000 R08: 0000000000000000 R09: ffff96cfd07dca50
> [   43.178271] R10: ffff96cfc46e8a00 R11: fffffffffffec000 R12: 0000000041d00000
> [   43.179178] R13: ffff96cfc3ce0000 R14: ffffb0dd4216bd08 R15: 0000000000000000
> [   43.180071] FS:  00007f7657dd68c0(0000) GS:ffff96d6df800000(0000) knlGS:0000000000000000
> [   43.181073] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   43.181808] CR2: 00007fe09905f010 CR3: 00000001093ee004 CR4: 0000000000370ee0
> [   43.182706] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   43.183591] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> We first hit the WARN_ON(rc->block_group->pinned > 0) in
> btrfs_relocate_block_group() and then the BUG_ON(!cache) in
> unpin_extent_range(). This tells us that we are exiting relocation and
> removing the block group with bytes still pinned for that block group.
> This is supposed to be impossible: the last thing relocate_block_group()
> does is commit the transaction to get rid of pinned extents.
> 
> Commit d0c2f4fa555e ("btrfs: make concurrent fsyncs wait less when
> waiting for a transaction commit") introduced an optimization so that
> commits from fsync don't have to wait for the previous commit to unpin
> extents. This was only intended to affect fsync, but it inadvertently
> made it possible for any commit to skip waiting for the previous commit
> to unpin. This is because if a call to btrfs_commit_transaction() finds
> that another thread is already committing the transaction, it waits for
> the other thread to complete the commit and then returns. If that other
> thread was in fsync, then it completes the commit without completing the
> previous commit. This makes the following sequence of events possible:
> 
> Thread 1____________________|Thread 2 (fsync)_____________________|Thread 3 (balance)___________________
> btrfs_commit_transaction(N) |                                     |
>   btrfs_run_delayed_refs    |                                     |
>     pin extents             |                                     |
>   ...                       |                                     |
>   state = UNBLOCKED         |btrfs_sync_file                      |
>                             |  btrfs_start_transaction(N + 1)     |relocate_block_group
>                             |                                     |  btrfs_join_transaction(N + 1)
>                             |  btrfs_commit_transaction(N + 1)    |
>   ...                       |  trans->state = COMMIT_START        |
>                             |                                     |  btrfs_commit_transaction(N + 1)
>                             |                                     |    wait_for_commit(N + 1, COMPLETED)
>                             |  wait_for_commit(N, SUPER_COMMITTED)|
>   state = SUPER_COMMITTED   |  ...                                |
>   btrfs_finish_extent_commit|                                     |
>     unpin_extent_range()    |  trans->state = COMPLETED           |
>                             |                                     |    return
>                             |                                     |
>     ...                     |                                     |Thread 1 isn't done, so pinned > 0
>                             |                                     |and we WARN
>                             |                                     |
>                             |                                     |btrfs_remove_block_group
>     unpin_extent_range()    |                                     |
>       Thread 3 removed the  |                                     |
>       block group, so we BUG|                                     |
> 
> There are other sequences involving SUPER_COMMITTED transactions that
> can cause a similar outcome.
> 
> We could fix this by making relocation explicitly wait for unpinning,
> but there may be other cases that need it. Josef mentioned ENOSPC
> flushing and the free space cache inode as other potential victims.
> Rather than playing whack-a-mole, this fix is conservative and makes all
> commits not in fsync wait for all previous transactions, which is what
> the optimization intended.
> 
> Fixes: d0c2f4fa555e ("btrfs: make concurrent fsyncs wait less when waiting for a transaction commit")
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Added to misc-next, thanks.
