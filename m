Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B281897A91
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2019 15:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbfHUNT7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Aug 2019 09:19:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:44544 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726371AbfHUNT7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Aug 2019 09:19:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 95CE1AF23;
        Wed, 21 Aug 2019 13:19:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BE518DA7DB; Wed, 21 Aug 2019 15:20:22 +0200 (CEST)
Date:   Wed, 21 Aug 2019 15:20:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 0/2] Btrfs: workqueue cleanups
Message-ID: <20190821132021.GA18575@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1565717247.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1565717247.git.osandov@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 13, 2019 at 10:33:42AM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> This does some cleanups to the Btrfs workqueue code following my
> previous fix [1]. Changed since v1 [2]:
> 
> - Removed errant Fixes: tag in patch 1
> - Fixed a comment typo in patch 2
> - Added NB: to comments in patch 2
> - Added Nikolay and Filipe's reviewed-by tags
> 
> Thanks!
> 
> 1: https://lore.kernel.org/linux-btrfs/0bea516a54b26e4e1c42e6fe47548cb48cc4172b.1565112813.git.osandov@fb.com/
> 2: https://lore.kernel.org/linux-btrfs/cover.1565680721.git.osandov@fb.com/
> 
> Omar Sandoval (2):
>   Btrfs: get rid of unique workqueue helper functions
>   Btrfs: get rid of pointless wtag variable in async-thread.c

The patches seem to cause crashes inside the worques, happend several
times in random patches, sample stacktrace below. This blocks me from
testing so I'll move the patches out of misc-next for now and add back
once there's a fix.

btrfs/004               [18:00:37][   70.500719] run fstests btrfs/004 at 2019-08-20 18:00:37
[   70.866378] BTRFS info (device vda): disk space caching is enabled
[   70.868960] BTRFS info (device vda): has skinny extents
[   71.046922] BTRFS: device fsid e4a337ee-c8db-4be4-ac0f-6cd899f74fa8 devid 1 transid 5 /dev/vdb
[   71.065084] BTRFS info (device vdb): turning on discard
[   71.066812] BTRFS info (device vdb): disk space caching is enabled
[   71.068907] BTRFS info (device vdb): has skinny extents
[   71.070589] BTRFS info (device vdb): flagging fs with big metadata feature
[   71.078315] BTRFS info (device vdb): checking UUID tree
[   74.627999] BTRFS info (device vdb): turning on discard
[   74.630041] BTRFS info (device vdb): setting incompat feature flag for COMPRESS_LZO (0x8)
[   74.632869] BTRFS info (device vdb): use lzo compression, level 0
[   74.634472] BTRFS info (device vdb): disk space caching is enabled
[   74.636137] BTRFS info (device vdb): has skinny extents
[   75.038059] fsstress (21349) used greatest stack depth: 10912 bytes left
[   79.343639] BTRFS info (device vdb): turning on discard
[   79.345268] BTRFS info (device vdb): disk space caching is enabled
[   79.346866] BTRFS info (device vdb): has skinny extents
[   90.608845] general protection fault: 0000 [#1] SMP
[   90.611148] CPU: 2 PID: 21318 Comm: kworker/u8:8 Not tainted 5.3.0-rc5-default+ #699
[   90.613973] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58-prebuilt.qemu.org 04/01/2014
[   90.617179] Workqueue: btrfs-worker btrfs_work_helper [btrfs]
[   90.618740] RIP: 0010:__lock_acquire+0x815/0x1100
[   90.624107] RSP: 0018:ffffa5cb05f23cc0 EFLAGS: 00010002
[   90.625652] RAX: 0000000000000000 RBX: 0000000000000086 RCX: 0000000000000000
[   90.627804] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 6b6b6b6b6b6b6ba3
[   90.629171] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
[   90.631566] R10: 6b6b6b6b6b6b6ba3 R11: 0000000000000000 R12: 0000000000000001
[   90.632952] R13: 0000000000000000 R14: 0000000000000000 R15: ffffa0f49efed340
[   90.634019] FS:  0000000000000000(0000) GS:ffffa0f4bd800000(0000) knlGS:0000000000000000
[   90.635313] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   90.636293] CR2: 0000555f9a8d7538 CR3: 0000000072ac8000 CR4: 00000000000006e0
[   90.637987] Call Trace:
[   90.638620]  ? lockdep_hardirqs_on+0x103/0x190
[   90.639745]  ? trace_hardirqs_on_thunk+0x1a/0x20
[   90.640864]  lock_acquire+0x95/0x1a0
[   90.641783]  ? btrfs_work_helper+0x1ba/0x600 [btrfs]
[   90.642883]  _raw_spin_lock_irqsave+0x3c/0x80
[   90.643924]  ? btrfs_work_helper+0x1ba/0x600 [btrfs]
[   90.645129]  btrfs_work_helper+0x1ba/0x600 [btrfs]
[   90.646327]  process_one_work+0x22f/0x5b0
[   90.647325]  worker_thread+0x50/0x3b0
[   90.648228]  ? process_one_work+0x5b0/0x5b0
[   90.649243]  kthread+0x11a/0x130
[   90.649825]  ? kthread_create_worker_on_cpu+0x70/0x70
[   90.650633]  ret_from_fork+0x24/0x30
[   90.651256] Modules linked in: btrfs libcrc32c xor zstd_decompress zstd_compress xxhash raid6_pq loop
[   90.653126] ---[ end trace 5a9019a191ef1b98 ]---
[   90.654215] RIP: 0010:__lock_acquire+0x815/0x1100
[   90.658563] RSP: 0018:ffffa5cb05f23cc0 EFLAGS: 00010002
[   90.659392] RAX: 0000000000000000 RBX: 0000000000000086 RCX: 0000000000000000
[   90.660937] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 6b6b6b6b6b6b6ba3
[   90.662457] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
[   90.663524] R10: 6b6b6b6b6b6b6ba3 R11: 0000000000000000 R12: 0000000000000001
[   90.665197] R13: 0000000000000000 R14: 0000000000000000 R15: ffffa0f49efed340
[   90.667127] FS:  0000000000000000(0000) GS:ffffa0f4bd800000(0000) knlGS:0000000000000000
[   90.669365] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   90.670966] CR2: 0000555f9a8d7538 CR3: 0000000072ac8000 CR4: 00000000000006e0
[   90.672893] BUG: sleeping function called from invalid context at include/linux/cgroup-defs.h:760
[   90.675438] in_atomic(): 1, irqs_disabled(): 1, pid: 21318, name: kworker/u8:8
[   90.677531] INFO: lockdep is turned off.
[   90.678757] irq event stamp: 94362
[   90.679645] hardirqs last  enabled at (94361): [<ffffffff8e0029da>] trace_hardirqs_on_thunk+0x1a/0x20
[   90.681805] hardirqs last disabled at (94362): [<ffffffff8e73f8d6>] _raw_spin_lock_irqsave+0x16/0x80
[   90.683239] softirqs last  enabled at (94360): [<ffffffff8ea00358>] __do_softirq+0x358/0x52b
[   90.684920] softirqs last disabled at (94079): [<ffffffff8e088d6d>] irq_exit+0x9d/0xb0
[   90.686500] CPU: 2 PID: 21318 Comm: kworker/u8:8 Tainted: G      D           5.3.0-rc5-default+ #699
[   90.687962] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58-prebuilt.qemu.org 04/01/2014
[   90.690382] Workqueue: btrfs-worker btrfs_work_helper [btrfs]
[   90.691953] Call Trace:
[   90.692769]  dump_stack+0x67/0x90
[   90.693816]  ___might_sleep.cold+0x9f/0xf2
[   90.695033]  exit_signals+0x30/0x110
[   90.696030]  do_exit+0xb7/0x920
[   90.696902]  ? kthread+0x11a/0x130
[   90.697799]  rewind_stack_do_exit+0x17/0x20
[   90.699258] note: kworker/u8:8[21318] exited with preempt_count 1
