Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB4938087D
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 May 2021 13:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhENLeY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 May 2021 07:34:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:57818 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhENLeX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 May 2021 07:34:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C5CF5AFF4;
        Fri, 14 May 2021 11:33:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 07FD4DA8EB; Fri, 14 May 2021 13:30:40 +0200 (CEST)
Date:   Fri, 14 May 2021 13:30:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [Patch v2 00/42] btrfs: add data write support for subpage
Message-ID: <20210514113040.GV7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210427230349.369603-1-wqu@suse.com>
 <20210512221821.GB7604@twin.jikos.cz>
 <de2c2a25-a8da-4d69-819e-847c4721b3f4@gmx.com>
 <36e94393-d6cf-cc3d-d710-79c517de4ecc@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36e94393-d6cf-cc3d-d710-79c517de4ecc@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 13, 2021 at 10:21:24AM +0800, Qu Wenruo wrote:
> > On 2021/5/13 上午6:18, David Sterba wrote:
> >> On Wed, Apr 28, 2021 at 07:03:07AM +0800, Qu Wenruo wrote:
> >>> === Patchset structure ===
> >>>
> >>> Patch 01~02:    hardcoded PAGE_SIZE related fixes
> >>> Patch 03~05:    submit_extent_page() refactor which will reduce overhead
> >>>         for write path.
> >>>         This should benefit 4K page the most. Although the
> >>>         primary objective is just to make the code easier to
> >>>         read.
> >>> Patch 06:    Cleanup for metadata writepath, to reduce the impact on
> >>>         regular sectorsize path.
> >>> Patch 07~13:    PagePrivate2 and ordered extent related refactor.
> >>>         Although it's still a refactor, the refactor is pretty
> >>>         important for subpage data write path, as for subpage we
> >>>         could have btrfs_writepage_endio_finish_ordered() call
> >>>         across several sectors, which may or may not have
> >>>         ordered extent for those sectors.
> >>>
> >>> ^^^ Above patches are all subpage data write preparation ^^^
> >>
> >> Do you think the patches 1-13 are safe to be merged independently? I've
> >> paged through the whole patchset and some of the patches are obviously
> >> preparatory stuff so they can go in without much risk.
> >
> > Yes. I believe they are OK for merge.
> >
> > I have run the full tests on x86 VM for the whole patchset, no new
> > regression.
> >
> > Especially patch 03~05 would benefit 4K page size the most, thus merging
> > them first would definitely help.
> >
> > Just let me to run the tests with patch 1~13 only, to see if there is
> > any special dependency missing.
> 
> Yep, patch 1~13 with the v5 read time repair patches are safe for x86.

All fine up to generic/521 that got stuck. It looks like some use after
free, check the 2nd line of the dump, there's the 0x6b6b signature

generic/521		[00:33:06][26901.358817] run fstests generic/521 at 2021-05-14 00:33:06
[27273.028163] general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b6a9b: 0000 [#1] PREEMPT SMP
[27273.030710] CPU: 0 PID: 20046 Comm: fsx Not tainted 5.13.0-rc1-default+ #1463
[27273.032295] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[27273.034731] RIP: 0010:btrfs_lookup_first_ordered_range+0x46/0x140 [btrfs]
[27273.040247] RSP: 0018:ffffb7ac06617b10 EFLAGS: 00010002
[27273.041365] RAX: 6b6b6b6b6b6b6b6b RBX: 6b6b6b6b6b6b6b6b RCX: ffffffffffffffff
[27273.042841] RDX: 6b6b6b6b6b6b6b6b RSI: ffffffffc01b3e09 RDI: ffff93c444e397d0
[27273.044388] RBP: 0000000000001000 R08: 0000000000000001 R09: 0000000000000000
[27273.045938] R10: ffffffffc01b3e09 R11: 0000000000000000 R12: 000000000002f000
[27273.047409] R13: ffff93c48ae79368 R14: ffff93c444e397b8 R15: 000000000002f000
[27273.048959] FS:  00007fb0f0a5e740(0000) GS:ffff93c4bd600000(0000) knlGS:0000000000000000
[27273.050674] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[27273.051971] CR2: 00007fb0f0936000 CR3: 0000000028bf4001 CR4: 0000000000170eb0
[27273.053548] Call Trace:
[27273.054145]  btrfs_invalidatepage+0xd3/0x390 [btrfs]
[27273.055276]  truncate_cleanup_page+0xda/0x170
[27273.056243]  truncate_inode_pages_range+0x131/0x5a0
[27273.057334]  ? trace_btrfs_space_reservation+0x33/0xf0 [btrfs]
[27273.058642]  ? lock_acquire+0xa0/0x150
[27273.059506]  ? unmap_mapping_pages+0x4d/0x130
[27273.060491]  ? do_raw_spin_unlock+0x4b/0xa0
[27273.061477]  ? unmap_mapping_pages+0x5e/0x130
[27273.062482]  btrfs_punch_hole_lock_range+0xc5/0x130 [btrfs]
[27273.063738]  btrfs_zero_range+0x1d7/0x4b0 [btrfs]
[27273.064833]  btrfs_fallocate+0x6b4/0x890 [btrfs]
[27273.065921]  ? __x64_sys_fallocate+0x3e/0x70
[27273.066920]  ? __do_sys_newfstatat+0x40/0x70
[27273.067875]  vfs_fallocate+0x12e/0x420
[27273.068738]  __x64_sys_fallocate+0x3e/0x70
[27273.069684]  do_syscall_64+0x3f/0xb0
[27273.070539]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[27273.071641] RIP: 0033:0x7fb0f0b5716a
[27273.076352] RSP: 002b:00007fff6503e0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
[27273.078019] RAX: ffffffffffffffda RBX: 0000000000007909 RCX: 00007fb0f0b5716a
[27273.079522] RDX: 000000000002956d RSI: 0000000000000010 RDI: 0000000000000003
[27273.081020] RBP: 000000000002956d R08: 0000000000007909 R09: 000000000002956d
[27273.082542] R10: 0000000000007909 R11: 0000000000000246 R12: 0000000000000000
[27273.083984] R13: 0000000000030e76 R14: 0000000000000010 R15: 000000000002956d
[27273.090924] ---[ end trace f729bc2baa232124 ]---
[27273.092000] RIP: 0010:btrfs_lookup_first_ordered_range+0x46/0x140 [btrfs]
[27273.097206] RSP: 0018:ffffb7ac06617b10 EFLAGS: 00010002
[27273.098338] RAX: 6b6b6b6b6b6b6b6b RBX: 6b6b6b6b6b6b6b6b RCX: ffffffffffffffff
[27273.099843] RDX: 6b6b6b6b6b6b6b6b RSI: ffffffffc01b3e09 RDI: ffff93c444e397d0
[27273.101302] RBP: 0000000000001000 R08: 0000000000000001 R09: 0000000000000000
[27273.102827] R10: ffffffffc01b3e09 R11: 0000000000000000 R12: 000000000002f000
[27273.104328] R13: ffff93c48ae79368 R14: ffff93c444e397b8 R15: 000000000002f000
[27273.105786] FS:  00007fb0f0a5e740(0000) GS:ffff93c4bd600000(0000) knlGS:0000000000000000
[27273.107478] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[27273.108672] CR2: 00007fb0f0936000 CR3: 0000000028bf4001 CR4: 0000000000170eb0
[27273.110157] note: fsx[20046] exited with preempt_count 1
[27273.111323] BUG: sleeping function called from invalid context at include/linux/percpu-rwsem.h:49
[27273.113204] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 20046, name: fsx
[27273.114784] INFO: lockdep is turned off.
[27273.115614] irq event stamp: 0
[27273.116355] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[27273.117657] hardirqs last disabled at (0): [<ffffffff9c0675a3>] copy_process+0x3f3/0x1550
[27273.119308] softirqs last  enabled at (0): [<ffffffff9c0675a3>] copy_process+0x3f3/0x1550
[27273.129243] softirqs last disabled at (0): [<0000000000000000>] 0x0
[27273.130557] CPU: 0 PID: 20046 Comm: fsx Tainted: G      D           5.13.0-rc1-default+ #1463
[27273.132460] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[27273.135049] Call Trace:
[27273.135710]  dump_stack+0x6d/0x89
[27273.136549]  ___might_sleep.cold+0xf2/0x132
[27273.137575]  exit_signals+0x1d/0x350
[27273.138451]  do_exit+0xa6/0x4a0
[27273.139238]  rewind_stack_do_exit+0x17/0x17
[27273.140270] RIP: 0033:0x7fb0f0b5716a
[27273.144797] RSP: 002b:00007fff6503e0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
[27273.146353] RAX: ffffffffffffffda RBX: 0000000000007909 RCX: 00007fb0f0b5716a
[27273.147736] RDX: 000000000002956d RSI: 0000000000000010 RDI: 0000000000000003
[27273.149157] RBP: 000000000002956d R08: 0000000000007909 R09: 000000000002956d
[27273.150620] R10: 0000000000007909 R11: 0000000000000246 R12: 0000000000000000
[27273.152094] R13: 0000000000030e76 R14: 0000000000000010 R15: 000000000002956d
