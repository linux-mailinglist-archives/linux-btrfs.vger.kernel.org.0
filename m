Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8070C260516
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Sep 2020 21:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbgIGTVx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Sep 2020 15:21:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:43126 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728879AbgIGTVx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Sep 2020 15:21:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 348F1AEC2;
        Mon,  7 Sep 2020 19:21:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 85D7DDA7CE; Mon,  7 Sep 2020 21:20:34 +0200 (CEST)
Date:   Mon, 7 Sep 2020 21:20:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix NULL pointer dereference after failure to
 create snapshot
Message-ID: <20200907192034.GC28318@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20200904162257.123893-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904162257.123893-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 04, 2020 at 05:22:57PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When trying to get a new fs root for a snapshot during the transaction
> at transaction.c:create_pending_snapshot(), if btrfs_get_new_fs_root()
> fails we leave "pending->snap" pointing to an error pointer, and then
> later at ioctl.c:create_snapshot() we dereference that pointer, resulting
> in a crash:
> 
> [12264.614689] BUG: kernel NULL pointer dereference, address: 00000000000007c4
> [12264.615650] #PF: supervisor write access in kernel mode
> [12264.616487] #PF: error_code(0x0002) - not-present page
> [12264.617436] PGD 0 P4D 0
> [12264.618328] Oops: 0002 [#1] PREEMPT SMP DEBUG_PAGEALLOC PTI
> [12264.619150] CPU: 0 PID: 2310635 Comm: fsstress Tainted: G        W         5.9.0-rc3-btrfs-next-67 #1
> [12264.619960] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> [12264.621769] RIP: 0010:btrfs_mksubvol+0x438/0x4a0 [btrfs]
> [12264.622528] Code: bc ef ff ff (...)
> [12264.624092] RSP: 0018:ffffaa6fc7277cd8 EFLAGS: 00010282
> [12264.624669] RAX: 00000000fffffff4 RBX: ffff9d3e8f151a60 RCX: 0000000000000000
> [12264.625249] RDX: 0000000000000001 RSI: ffffffff9d56c9be RDI: fffffffffffffff4
> [12264.625830] RBP: ffff9d3e8f151b48 R08: 0000000000000000 R09: 0000000000000000
> [12264.626413] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000fffffff4
> [12264.626994] R13: ffff9d3ede380538 R14: ffff9d3ede380500 R15: ffff9d3f61b2eeb8
> [12264.627582] FS:  00007f140d5d8200(0000) GS:ffff9d3fb5e00000(0000) knlGS:0000000000000000
> [12264.628176] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [12264.628773] CR2: 00000000000007c4 CR3: 000000020f8e8004 CR4: 00000000003706f0
> [12264.629379] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [12264.629994] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [12264.630594] Call Trace:
> [12264.631227]  btrfs_mksnapshot+0x7b/0xb0 [btrfs]
> [12264.631840]  __btrfs_ioctl_snap_create+0x16f/0x1a0 [btrfs]
> [12264.632458]  btrfs_ioctl_snap_create_v2+0xb0/0xf0 [btrfs]
> [12264.633078]  btrfs_ioctl+0x1864/0x3130 [btrfs]
> [12264.633689]  ? do_sys_openat2+0x1a7/0x2d0
> [12264.634295]  ? kmem_cache_free+0x147/0x3a0
> [12264.634899]  ? __x64_sys_ioctl+0x83/0xb0
> [12264.635488]  __x64_sys_ioctl+0x83/0xb0
> [12264.636058]  do_syscall_64+0x33/0x80
> [12264.636616]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> (gdb) list *(btrfs_mksubvol+0x438)
> 0x7c7b8 is in btrfs_mksubvol (fs/btrfs/ioctl.c:858).
> 853		ret = 0;
> 854		pending_snapshot->anon_dev = 0;
> 855	fail:
> 856		/* Prevent double freeing of anon_dev */
> 857		if (ret && pending_snapshot->snap)
> 858			pending_snapshot->snap->anon_dev = 0;
> 859		btrfs_put_root(pending_snapshot->snap);
> 860		btrfs_subvolume_release_metadata(root, &pending_snapshot->block_rsv);
> 861	free_pending:
> 862		if (pending_snapshot->anon_dev)
> 
> So fix this by setting "pending->snap" to NULL if we get an error from the
> call to btrfs_get_new_fs_root() at transaction.c:create_pending_snapshot().
> 
> Fixes: 2dfb1e43f57dd3 ("btrfs: preallocate anon block device at first phase of snapshot creation")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next and queued for 5.9-rc, thanks.
