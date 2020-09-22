Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F1A274037
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Sep 2020 12:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgIVK55 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Sep 2020 06:57:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:55890 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbgIVK55 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Sep 2020 06:57:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D7BE4AD85;
        Tue, 22 Sep 2020 10:58:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A5BCBDA6E9; Tue, 22 Sep 2020 12:56:39 +0200 (CEST)
Date:   Tue, 22 Sep 2020 12:56:38 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: reschedule when cloning lots of extents
Message-ID: <20200922105638.GX6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <42f05219ee6dfd612fe38f0ec6209d5a2c6c23dc.1600763203.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42f05219ee6dfd612fe38f0ec6209d5a2c6c23dc.1600763203.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 22, 2020 at 05:27:29PM +0900, Johannes Thumshirn wrote:
> We have several occurrences of a soft lockup from xfstest's generic/175
> test-case, which look more or less like this one:
> 
>  watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [xfs_io:10030]
>  Kernel panic - not syncing: softlockup: hung tasks
>  CPU: 0 PID: 10030 Comm: xfs_io Tainted: G             L    5.9.0-rc5+ #768
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4-rebuilt.opensuse.org 04/01/2014
>  Call Trace:
>   <IRQ>
>   dump_stack+0x77/0xa0
>   panic+0xfa/0x2cb
>   watchdog_timer_fn.cold+0x85/0xa5
>   ? lockup_detector_update_enable+0x50/0x50
>   __hrtimer_run_queues+0x99/0x4c0
>   ? recalibrate_cpu_khz+0x10/0x10
>   hrtimer_run_queues+0x9f/0xb0
>   update_process_times+0x28/0x80
>   tick_handle_periodic+0x1b/0x60
>   __sysvec_apic_timer_interrupt+0x76/0x210
>   asm_call_on_stack+0x12/0x20
>   </IRQ>
>   sysvec_apic_timer_interrupt+0x7f/0x90
>   asm_sysvec_apic_timer_interrupt+0x12/0x20
>  RIP: 0010:btrfs_tree_unlock+0x91/0x1a0 [btrfs]
>  Code: 85 1e 01 00 00 c7 83 84 00 00 00 00 00 00 00 f0 83 44 24 fc 00 48 8b 83 10 01 00 00 48 8d bb d0 00 00 00 48 81 c3 10 01 00 00 <48> 39 d8 74 63 5b 31 c9 5d ba 01 00 00 00 be 03 00 00 00 41 5c e9
>  RSP: 0018:ffffc90007123a58 EFLAGS: 00000282
>  RAX: ffff8881cea2fbe0 RBX: ffff8881cea2fbe0 RCX: 0000000000000000
>  RDX: ffff8881d23fd200 RSI: ffffffff82045220 RDI: ffff8881cea2fba0
>  RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000032
>  R10: 0000160000000000 R11: 0000000000001000 R12: 0000000000001000
>  R13: ffff8882357fd5b0 R14: ffff88816fa76e70 R15: ffff8881cea2fad0
>   ? btrfs_tree_unlock+0x15b/0x1a0 [btrfs]
>   btrfs_release_path+0x67/0x80 [btrfs]
>   btrfs_insert_replace_extent+0x177/0x2c0 [btrfs]
>   btrfs_replace_file_extents+0x472/0x7c0 [btrfs]
>   btrfs_clone+0x9ba/0xbd0 [btrfs]
>   btrfs_clone_files.isra.0+0xeb/0x140 [btrfs]
>   ? file_update_time+0xcd/0x120
>   btrfs_remap_file_range+0x322/0x3b0 [btrfs]
>   do_clone_file_range+0xb7/0x1e0
>   vfs_clone_file_range+0x30/0xa0
>   ioctl_file_clone+0x8a/0xc0
>   do_vfs_ioctl+0x5b2/0x6f0
>   __x64_sys_ioctl+0x37/0xa0
>   do_syscall_64+0x33/0x40
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
>  RIP: 0033:0x7f87977fc247
>  Code: 00 00 90 48 8b 05 49 8c 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 19 8c 0c 00 f7 d8 64 89 01 48
>  RSP: 002b:00007ffd51a2f6d8 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
>  RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f87977fc247
>  RDX: 00007ffd51a2f710 RSI: 000000004020940d RDI: 0000000000000003
>  RBP: 0000000000000004 R08: 00007ffd51a79080 R09: 0000000000000000
>  R10: 00005621f11352f2 R11: 0000000000000206 R12: 0000000000000000
>  R13: 0000000000000000 R14: 00005621f128b958 R15: 0000000080000000
>  Kernel Offset: disabled
>  ---[ end Kernel panic - not syncing: softlockup: hung tasks ]---
> 
> All of these lockup reports have the call chain btrfs_clone_files() ->
> btrfs_clone() in common. btrfs_clone_files() calls btrfs_clone() with
> both source and destination extents locked and loops over the source
> extent to create the clones.
> 
> Conditionally reschedule in the btrfs_clone() loop, to give some time back
> to other processes.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Added to misc-next, thanks.
