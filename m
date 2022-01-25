Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4672249BA1B
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jan 2022 18:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1587673AbiAYRTJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jan 2022 12:19:09 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:51450 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242616AbiAYRPf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jan 2022 12:15:35 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AB0EE212CA;
        Tue, 25 Jan 2022 17:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643130933;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tD881diuNVsktS2i1HIo+HfdR7G+9aSDfrKEAMHV+6o=;
        b=VI9CuD0zL+Ql6Z/CV9VdFhpD2zF7wiYfCPkS3L1egFMxXMtK5wSdCRi/XZzVxyPyzO8THD
        oAXPUvkWKipsvIjORQVRhv0kZO98KASHfdrk2tDTPmiyfzZ7cEypIux4FHPWuz6RSb86XU
        yRJMe7T/tYL8Sy9p03OkA1Hk1FZDloQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643130933;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tD881diuNVsktS2i1HIo+HfdR7G+9aSDfrKEAMHV+6o=;
        b=TKLuuOrPVlHuqCLZs1nJooTetjW33OjfJ6bdHtV2UfQF8BH7F0a/+S87SQGdNtM3WYfL9L
        aOq2Yj7PSQqQEtAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A460AA3B81;
        Tue, 25 Jan 2022 17:15:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 46628DA7A9; Tue, 25 Jan 2022 18:14:53 +0100 (CET)
Date:   Tue, 25 Jan 2022 18:14:52 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: skip reserved bytes warning on unmount after log
 cleanup failure
Message-ID: <20220125171452.GU14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <abff8bb38826f30e65d26c4cb5535fe599fdfdf1.1642512596.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abff8bb38826f30e65d26c4cb5535fe599fdfdf1.1642512596.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 18, 2022 at 01:39:34PM +0000, fdmanana@kernel.org wrote:
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
> then we have cleared the bit EXTENT_BUFFER_UPTODATE from the extent buffer
> and we have also set the bit EXTENT_BUFFER_WRITE_ERR on it. Later on,
> when trying to free the log tree with free_log_tree(), which iterates
> over the tree, we can end up getting an -EIO error when trying to read
> a node or a leaf, since read_extent_buffer_pages() returns -EIO if an
> extent buffer does not have EXTENT_BUFFER_UPTODATE set and has the
> EXTENT_BUFFER_WRITE_ERR bit set. Getting that -EIO means that we return
> immediately as we can not iterate over the entire tree.
> 
> In that case we never update the reserved space for an extent buffer in
> the respective block group and space_info object.
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
> The issue could almost be fixed by iterating over the io tree attached to
> each log root which keeps tracks of the range of allocated extent buffers,
> log_root->dirty_log_pages, however that does not work and has some
> incovenients:
> 
> 1) After we sync the log, we clear the range of the extent buffers from
>    the io tree, so we can't find them after writeback. We could keep the
>    ranges in the io tree, with a separate bit to signal they represent
>    extent buffers already written, but that means we need to hold into
>    more memory until the transaction commits.
> 
>    How much more memory is used depends a lot on whether we are able to
>    allocate contiguous extent buffers on disk (and how often) for a log
>    tree - if we are able to, then a single extent state record can
>    represent multiple extent buffers, otherwise we need multiple extent
>    state record structures to track each extent buffer.
>    In fact, my ealier approach did that:
> 
>    https://lore.kernel.org/linux-btrfs/3aae7c6728257c7ce2279d6660ee2797e5e34bbd.1641300250.git.fdmanana@suse.com/
> 
>    However that can cause a very significant negative impact on
>    performance, not only due to the extra memory usage but also because
>    we get a larger and deeper dirty_log_pages io tree.
>    We got a report that, on beefy machines at least, we can get such
>    performance drop with fsmark for example:
> 
>    https://lore.kernel.org/linux-btrfs/20220117082426.GE32491@xsang-OptiPlex-9020/
> 
> 2) We would be doing it only to deal with an unexpected and exceptional
>    case, which is basically failure to read an extent buffer from disk
>    due to IO failures. On a healthy system we don't expect transaction
>    aborts to happen after all;
> 
> 3) Instead of relying on iterating the log tree or tracking the ranges
>    of extent buffers in the dirty_log_pages io tree, using the radix
>    tree that tracks extent buffers (fs_info->buffer_radix) to find all
>    log tree extent buffers is not reliable either, because after writeback
>    of an extent buffer it can be evicted from memory by the release page
>    callback of the btree inode (btree_releasepage()).
> 
> Since there's no way to be able to properly cleanup a log tree without
> being able to read its extent buffers from disk and without using more
> memory to track the logical ranges of the allocated extent buffers do
> the following:
> 
> 1) When we fail to cleanup a log tree, setup a flag that indicates that
>    failure;
> 
> 2) Trigger writeback of all log tree extent buffers that are still dirty,
>    and wait for the writeback to complete. This is just to cleanup their
>    state, page states, page leaks, etc;
> 
> 3) When unmounting the fs, ignore if the number of bytes reserved in a
>    block group and in a space_info is not 0 if, and only if, we failed to
>    cleanup a log tree. Also ignore only for metadata block groups and the
>    metadata space_info object.
> 
> This is far from a perfect solution, but it serves to silence test
> failures such as those from generic/475 and generic/648. However having
> a non-zero value for the reserved bytes counters on unmount after a
> transaction abort, is not such a terrible thing and it's completely
> harmless, it does not affect the filesystem integrity in any way.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
