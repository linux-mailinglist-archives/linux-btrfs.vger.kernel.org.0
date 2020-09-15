Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2C326A011
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Sep 2020 09:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgIOHos (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 03:44:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:59902 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbgIOHoJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 03:44:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AB431AE87;
        Tue, 15 Sep 2020 07:44:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0505DDA7C7; Tue, 15 Sep 2020 09:42:54 +0200 (CEST)
Date:   Tue, 15 Sep 2020 09:42:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: reschedule if necessary when logging directory
 items
Message-ID: <20200915074254.GB1791@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <606910fad0a0c62d162acf92953d8f38c8537643.1600093362.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <606910fad0a0c62d162acf92953d8f38c8537643.1600093362.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 14, 2020 at 03:27:50PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Logging directories with many entries can take a significant amount of
> time, and in some cases monopolize a cpu/core for a long time if the
> logging task doesn't happen to block often enough.
> 
> Johannes and Lu Fengqi reported test case generic/041 triggering a soft
> lockup when the kernel has CONFIG_SOFTLOCKUP_DETECTOR=y. For this test
> case we log an inode with 3002 hard links, and because the test removed
> one hard link before fsyncing the file, the inode logging causes the
> parent directory do be logged as well, which has 6004 directory items to
> log (3002 BTRFS_DIR_ITEM_KEY items plus 3002 BTRFS_DIR_INDEX_KEY items),
> so it can take a significant amount of time and trigger the soft lockup.
> 
> So just make tree-log.c:log_dir_items() reschedule when necessary,
> releasing the current search path before doing so and then resume from
> where it was before the reschedule.
> 
> The stack trace produced when the soft lockup happens is the following:
> 
> [10480.277653] watchdog: BUG: soft lockup - CPU#2 stuck for 22s! [xfs_io:28172]
> [10480.279418] Modules linked in: dm_thin_pool dm_persistent_data (...)
> [10480.284915] irq event stamp: 29646366
> [10480.285987] hardirqs last  enabled at (29646365): [<ffffffff85249b66>] __slab_alloc.constprop.0+0x56/0x60
> [10480.288482] hardirqs last disabled at (29646366): [<ffffffff8579b00d>] irqentry_enter+0x1d/0x50
> [10480.290856] softirqs last  enabled at (4612): [<ffffffff85a00323>] __do_softirq+0x323/0x56c
> [10480.293615] softirqs last disabled at (4483): [<ffffffff85800dbf>] asm_call_on_stack+0xf/0x20
> [10480.296428] CPU: 2 PID: 28172 Comm: xfs_io Not tainted 5.9.0-rc4-default+ #1248
> [10480.298948] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
> [10480.302455] RIP: 0010:__slab_alloc.constprop.0+0x19/0x60
> [10480.304151] Code: 86 e8 31 75 21 00 66 66 2e 0f 1f 84 00 00 00 (...)
> [10480.309558] RSP: 0018:ffffadbe09397a58 EFLAGS: 00000282
> [10480.311179] RAX: ffff8a495ab92840 RBX: 0000000000000282 RCX: 0000000000000006
> [10480.313242] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff85249b66
> [10480.315260] RBP: ffff8a497d04b740 R08: 0000000000000001 R09: 0000000000000001
> [10480.317229] R10: ffff8a497d044800 R11: ffff8a495ab93c40 R12: 0000000000000000
> [10480.319169] R13: 0000000000000000 R14: 0000000000000c40 R15: ffffffffc01daf70
> [10480.321104] FS:  00007fa1dc5c0e40(0000) GS:ffff8a497da00000(0000) knlGS:0000000000000000
> [10480.323559] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [10480.325235] CR2: 00007fa1dc5befb8 CR3: 0000000004f8a006 CR4: 0000000000170ea0
> [10480.327259] Call Trace:
> [10480.328286]  ? overwrite_item+0x1f0/0x5a0 [btrfs]
> [10480.329784]  __kmalloc+0x831/0xa20
> [10480.331009]  ? btrfs_get_32+0xb0/0x1d0 [btrfs]
> [10480.332464]  overwrite_item+0x1f0/0x5a0 [btrfs]
> [10480.333948]  log_dir_items+0x2ee/0x570 [btrfs]
> [10480.335413]  log_directory_changes+0x82/0xd0 [btrfs]
> [10480.336926]  btrfs_log_inode+0xc9b/0xda0 [btrfs]
> [10480.338374]  ? init_once+0x20/0x20 [btrfs]
> [10480.339711]  btrfs_log_inode_parent+0x8d3/0xd10 [btrfs]
> [10480.341257]  ? dget_parent+0x97/0x2e0
> [10480.342480]  btrfs_log_dentry_safe+0x3a/0x50 [btrfs]
> [10480.343977]  btrfs_sync_file+0x24b/0x5e0 [btrfs]
> [10480.345381]  do_fsync+0x38/0x70
> [10480.346483]  __x64_sys_fsync+0x10/0x20
> [10480.347703]  do_syscall_64+0x2d/0x70
> [10480.348891]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [10480.350444] RIP: 0033:0x7fa1dc80970b
> [10480.351642] Code: 0f 05 48 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 (...)
> [10480.356952] RSP: 002b:00007fffb3d081d0 EFLAGS: 00000293 ORIG_RAX: 000000000000004a
> [10480.359458] RAX: ffffffffffffffda RBX: 0000562d93d45e40 RCX: 00007fa1dc80970b
> [10480.361426] RDX: 0000562d93d44ab0 RSI: 0000562d93d45e60 RDI: 0000000000000003
> [10480.363367] RBP: 0000000000000001 R08: 0000000000000000 R09: 00007fa1dc7b2a40
> [10480.365317] R10: 0000562d93d0e366 R11: 0000000000000293 R12: 0000000000000001
> [10480.367299] R13: 0000562d93d45290 R14: 0000562d93d45e40 R15: 0000562d93d45e60
> 
> Link: https://github.com/btrfs/fstests/issues/22
> Link: https://lore.kernel.org/linux-btrfs/20180713090216.GC575@fnst.localdomain/
> Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
