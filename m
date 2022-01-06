Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5B3486657
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jan 2022 15:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbiAFOxh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jan 2022 09:53:37 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:39386 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiAFOxg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jan 2022 09:53:36 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8851B1F385;
        Thu,  6 Jan 2022 14:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641480815;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=taRFPvVd7GTR1wgkj/SY0ycPXUzREP3LepPm2Rl3EB0=;
        b=wjAOBwp6CpsA3NMk/R3mfDaL8hX22f2h7aMeFyo5gJgNdNyYEZwwcjwvBU2xEKSV9AigvE
        Hmh6PiIqaJrEUj6+frTyiDJrhyrF0vG2u8YaEMwmrmSqG/bkpD2dcYdwAwuUhCFC/Vx2Dg
        ofHaO6dvhbER2xGa9Apd25ZvxXeH70Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641480815;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=taRFPvVd7GTR1wgkj/SY0ycPXUzREP3LepPm2Rl3EB0=;
        b=FS/5VRk8Wrr3sKBzO+Zu7Ro7Y96DRr4BMtc7XvMKlmZQPcEJkPvXNJo2ygoJE/eYFuud6I
        IFO5lGF0YYoVcuBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7F546A3B85;
        Thu,  6 Jan 2022 14:53:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 06204DA799; Thu,  6 Jan 2022 15:53:04 +0100 (CET)
Date:   Thu, 6 Jan 2022 15:53:04 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3] btrfs: fix log tree cleanup after a transaction abort
Message-ID: <20220106145304.GC14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <f0bed6300fc1dcad405c894640f7140b4a8e04f4.1639743512.git.fdmanana@suse.com>
 <3aae7c6728257c7ce2279d6660ee2797e5e34bbd.1641300250.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3aae7c6728257c7ce2279d6660ee2797e5e34bbd.1641300250.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 04, 2022 at 12:54:15PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> After the recent changes made by commit c2e39305299f01 ("btrfs: clear
> extent buffer uptodate when we fail to write it") and its followup fix,
> commit 651740a5024117 ("btrfs: check WRITE_ERR when trying to read an
> extent buffer"), we can now end up not cleaning up space reservations of
> log tree extent buffers after a transaction abort happens, as well as not
> cleaning up still dirty extent buffers.
> 
> This happens because if writeback for a log tree extent buffer failed,
> than we have cleared the EXTENT_BUFFER_UPTODATE from the extent buffer
> and we have also set the bit EXTENT_BUFFER_WRITE_ERR on it. Later on,
> when trying to free the log tree with free_log_tree(), which iterates
> over the tree, we can end up getting an -EIO error when trying to read
> a node or a leaf, since read_extent_buffer_pages() returns -EIO if an
> extent buffer does not have EXTENT_BUFFER_UPTODATE set and has the
> EXTENT_BUFFER_WRITE_ERR bit set. Getting that -EIO means that we return
> immediately as we can not iterate over the entire tree.
> 
> In that case we never update the reserved space for an extent buffer in
> the respective block group and space_info object, as well as for any other
> extent buffers that we not yet iterated over.
> 
> When this happens we get the following traces when unmounting the fs:
> 
> [174957.284509] BTRFS: error (device dm-0) in cleanup_transaction:1913: errno=-5 IO failure
> [174957.286497] BTRFS: error (device dm-0) in free_log_tree:3420: errno=-5 IO failure
> [174957.399379] ------------[ cut here ]------------
> [174957.402497] WARNING: CPU: 2 PID: 3206883 at fs/btrfs/block-group.c:127 btrfs_put_block_group+0x77/0xb0 [btrfs]
> [174957.407523] Modules linked in: btrfs overlay dm_zero (...)
> [174957.424917] CPU: 2 PID: 3206883 Comm: umount Tainted: G        W         5.16.0-rc5-btrfs-next-109 #1
> [174957.426689] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [174957.428716] RIP: 0010:btrfs_put_block_group+0x77/0xb0 [btrfs]
> [174957.429717] Code: 21 48 8b bd (...)
> [174957.432867] RSP: 0018:ffffb70d41cffdd0 EFLAGS: 00010206
> [174957.433632] RAX: 0000000000000001 RBX: ffff8b09c3848000 RCX: ffff8b0758edd1c8
> [174957.434689] RDX: 0000000000000001 RSI: ffffffffc0b467e7 RDI: ffff8b0758edd000
> [174957.436068] RBP: ffff8b0758edd000 R08: 0000000000000000 R09: 0000000000000000
> [174957.437114] R10: 0000000000000246 R11: 0000000000000000 R12: ffff8b09c3848148
> [174957.438140] R13: ffff8b09c3848198 R14: ffff8b0758edd188 R15: dead000000000100
> [174957.439317] FS:  00007f328fb82800(0000) GS:ffff8b0a2d200000(0000) knlGS:0000000000000000
> [174957.440402] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [174957.441164] CR2: 00007fff13563e98 CR3: 0000000404f4e005 CR4: 0000000000370ee0
> [174957.442117] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [174957.443076] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [174957.443948] Call Trace:
> [174957.444264]  <TASK>
> [174957.444538]  btrfs_free_block_groups+0x255/0x3c0 [btrfs]
> [174957.445238]  close_ctree+0x301/0x357 [btrfs]
> [174957.445803]  ? call_rcu+0x16c/0x290
> [174957.446250]  generic_shutdown_super+0x74/0x120
> [174957.446832]  kill_anon_super+0x14/0x30
> [174957.447305]  btrfs_kill_super+0x12/0x20 [btrfs]
> [174957.447890]  deactivate_locked_super+0x31/0xa0
> [174957.448440]  cleanup_mnt+0x147/0x1c0
> [174957.448888]  task_work_run+0x5c/0xa0
> [174957.449336]  exit_to_user_mode_prepare+0x1e5/0x1f0
> [174957.449934]  syscall_exit_to_user_mode+0x16/0x40
> [174957.450512]  do_syscall_64+0x48/0xc0
> [174957.450980]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [174957.451605] RIP: 0033:0x7f328fdc4a97
> [174957.452059] Code: 03 0c 00 f7 (...)
> [174957.454320] RSP: 002b:00007fff13564ec8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
> [174957.455262] RAX: 0000000000000000 RBX: 00007f328feea264 RCX: 00007f328fdc4a97
> [174957.456131] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000560b8ae51dd0
> [174957.457118] RBP: 0000560b8ae51ba0 R08: 0000000000000000 R09: 00007fff13563c40
> [174957.458005] R10: 00007f328fe49fc0 R11: 0000000000000246 R12: 0000000000000000
> [174957.459113] R13: 0000560b8ae51dd0 R14: 0000560b8ae51cb0 R15: 0000000000000000
> [174957.460193]  </TASK>
> [174957.460534] irq event stamp: 0
> [174957.461003] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [174957.461947] hardirqs last disabled at (0): [<ffffffffb0e94214>] copy_process+0x934/0x2040
> [174957.463147] softirqs last  enabled at (0): [<ffffffffb0e94214>] copy_process+0x934/0x2040
> [174957.465116] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [174957.466323] ---[ end trace bc7ee0c490bce3af ]---
> [174957.467282] ------------[ cut here ]------------
> [174957.468184] WARNING: CPU: 2 PID: 3206883 at fs/btrfs/block-group.c:3976 btrfs_free_block_groups+0x330/0x3c0 [btrfs]
> [174957.470066] Modules linked in: btrfs overlay dm_zero (...)
> [174957.483137] CPU: 2 PID: 3206883 Comm: umount Tainted: G        W         5.16.0-rc5-btrfs-next-109 #1
> [174957.484691] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [174957.486853] RIP: 0010:btrfs_free_block_groups+0x330/0x3c0 [btrfs]
> [174957.488050] Code: 00 00 00 ad de (...)
> [174957.491479] RSP: 0018:ffffb70d41cffde0 EFLAGS: 00010206
> [174957.492520] RAX: ffff8b08d79310b0 RBX: ffff8b09c3848000 RCX: 0000000000000000
> [174957.493868] RDX: 0000000000000001 RSI: fffff443055ee600 RDI: ffffffffb1131846
> [174957.495183] RBP: ffff8b08d79310b0 R08: 0000000000000000 R09: 0000000000000000
> [174957.496580] R10: 0000000000000001 R11: 0000000000000000 R12: ffff8b08d7931000
> [174957.498027] R13: ffff8b09c38492b0 R14: dead000000000122 R15: dead000000000100
> [174957.499438] FS:  00007f328fb82800(0000) GS:ffff8b0a2d200000(0000) knlGS:0000000000000000
> [174957.500990] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [174957.502117] CR2: 00007fff13563e98 CR3: 0000000404f4e005 CR4: 0000000000370ee0
> [174957.503513] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [174957.504864] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [174957.506167] Call Trace:
> [174957.506654]  <TASK>
> [174957.507047]  close_ctree+0x301/0x357 [btrfs]
> [174957.507867]  ? call_rcu+0x16c/0x290
> [174957.508567]  generic_shutdown_super+0x74/0x120
> [174957.509447]  kill_anon_super+0x14/0x30
> [174957.510194]  btrfs_kill_super+0x12/0x20 [btrfs]
> [174957.511123]  deactivate_locked_super+0x31/0xa0
> [174957.511976]  cleanup_mnt+0x147/0x1c0
> [174957.512610]  task_work_run+0x5c/0xa0
> [174957.513309]  exit_to_user_mode_prepare+0x1e5/0x1f0
> [174957.514231]  syscall_exit_to_user_mode+0x16/0x40
> [174957.515069]  do_syscall_64+0x48/0xc0
> [174957.515718]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [174957.516688] RIP: 0033:0x7f328fdc4a97
> [174957.517413] Code: 03 0c 00 f7 d8 (...)
> [174957.521052] RSP: 002b:00007fff13564ec8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
> [174957.522514] RAX: 0000000000000000 RBX: 00007f328feea264 RCX: 00007f328fdc4a97
> [174957.523950] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000560b8ae51dd0
> [174957.525375] RBP: 0000560b8ae51ba0 R08: 0000000000000000 R09: 00007fff13563c40
> [174957.526763] R10: 00007f328fe49fc0 R11: 0000000000000246 R12: 0000000000000000
> [174957.528058] R13: 0000560b8ae51dd0 R14: 0000560b8ae51cb0 R15: 0000000000000000
> [174957.529404]  </TASK>
> [174957.529843] irq event stamp: 0
> [174957.530256] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [174957.531061] hardirqs last disabled at (0): [<ffffffffb0e94214>] copy_process+0x934/0x2040
> [174957.532075] softirqs last  enabled at (0): [<ffffffffb0e94214>] copy_process+0x934/0x2040
> [174957.533083] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [174957.533865] ---[ end trace bc7ee0c490bce3b0 ]---
> [174957.534452] BTRFS info (device dm-0): space_info 4 has 1070841856 free, is not full
> [174957.535404] BTRFS info (device dm-0): space_info total=1073741824, used=2785280, pinned=0, reserved=49152, may_use=0, readonly=65536 zone_unusable=0
> [174957.537029] BTRFS info (device dm-0): global_block_rsv: size 0 reserved 0
> [174957.537859] BTRFS info (device dm-0): trans_block_rsv: size 0 reserved 0
> [174957.538697] BTRFS info (device dm-0): chunk_block_rsv: size 0 reserved 0
> [174957.539552] BTRFS info (device dm-0): delayed_block_rsv: size 0 reserved 0
> [174957.540403] BTRFS info (device dm-0): delayed_refs_rsv: size 0 reserved 0
> 
> This also means that in case we have log tree extent buffers that are
> still dirty, we can end up not cleaning them up in case we find an
> extent buffer with EXTENT_BUFFER_WRITE_ERR set on it, as in that case
> we have no way for iterating over the rest of the tree.
> 
> This issue is very often triggered with test cases generic/475 and
> generic/648 from fstests.
> 
> So instead of trying to iterate a log tree when freeing it after a
> transaction abort, iterate over the io tree that tracks the ranges of the
> log tree's extent buffers, and unaccount each extent buffer's range as
> well as clear any extent buffers that are still dirty. Also because when
> we trigger writeback of log tree extent buffers we clear their range from
> the ->dirty_log_pages io tree, we need to make sure the range is kept but
> with a different bit, so that we can find it if we ever run into a
> transaction abort - so when triggering the writeback, instead of clearing
> the range, convert it to the EXTENT_UPTODATE bit.
> 
> As a final note, while the commits mentioned above make this issue easy to
> trigger with tests that use the device mapper to simulate device errors,
> the issue could happen before, it was just much less likely. For example
> after writing an extent buffer of a log tree, it could be evicted from
> memory due to memory pressure, and then later during transaction commit
> while cleaning up the log tree through walk_log_tree() we get an -EIO when
> trying to read the extent buffer from disk - resulting in cleanup of the
> remaining log tree extent buffers not being made.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
> 
> V3: Renamed subject (was "btrfs: fix reserved space leak on log tree nodes after transaction abort").
>     Reworked the patch to take into account that after writeback is triggered through log syncing,
>     the range of the extent buffers is removed from the log dirty pages io tree. That was making
>     the mentioned test cases still fail often (just a bit less often however).
>     Also take into account that if fail during the cleanup, we stopped iterating over the tree
>     and leaving some extent buffers not being cleaned up - this was actually often triggered by
>     generic/648.

Added to misc-next, thanks.
