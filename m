Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC3043768F
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Oct 2021 14:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbhJVMOq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Oct 2021 08:14:46 -0400
Received: from out20-74.mail.aliyun.com ([115.124.20.74]:53594 "EHLO
        out20-74.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbhJVMOp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Oct 2021 08:14:45 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04437006|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.0193777-0.000144617-0.980478;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047199;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.Lg7jlZw_1634904746;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Lg7jlZw_1634904746)
          by smtp.aliyun-inc.com(10.147.41.199);
          Fri, 22 Oct 2021 20:12:26 +0800
Date:   Fri, 22 Oct 2021 20:12:33 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Filipe Manana <fdmanana@kernel.org>
Subject: Re: [PATCH] btrfs: fix deadlock due to page faults during direct IO reads and writes
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
In-Reply-To: <CAL3q7H4co70ByFqnDVArCQE9B1D7p6jf=jA+PRgJV2ijoS9vWg@mail.gmail.com>
References: <20211022135923.E369.409509F4@e16-tech.com> <CAL3q7H4co70ByFqnDVArCQE9B1D7p6jf=jA+PRgJV2ijoS9vWg@mail.gmail.com>
Message-Id: <20211022201232.7830.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> On Fri, Oct 22, 2021 at 6:59 AM Wang Yugui <wangyugui@e16-tech.com> wrote:
> >
> > Hi,
> >
> > I noticed a infinite loop of fstests/generic/475 when I apply this patch
> > and "[PATCH v9 00/17] gfs2: Fix mmap + page fault deadlocks"
> 
> You mean v8? I can't find v9 anywhere.

Yes. It is v8.


> >
> > reproduce frequency: about 50%.
> 
> with v8, on top of current misc-next, I couldn't trigger any issues
> after running g/475 for 50+ times.
> 
> >
> > Call Trace 1:
> > Oct 22 06:13:06 T7610 kernel: task:fsstress        state:R  running task     stack:    0 pid:2652125 ppid:     1 flags:0x00004006
> > Oct 22 06:13:06 T7610 kernel: Call Trace:
> > Oct 22 06:13:06 T7610 kernel: ? iomap_dio_rw+0xa/0x30
> > Oct 22 06:13:06 T7610 kernel: ? btrfs_file_read_iter+0x157/0x1c0 [btrfs]
> > Oct 22 06:13:06 T7610 kernel: ? new_sync_read+0x118/0x1a0
> > Oct 22 06:13:06 T7610 kernel: ? vfs_read+0xf1/0x190
> > Oct 22 06:13:06 T7610 kernel: ? ksys_read+0x59/0xd0
> > Oct 22 06:13:06 T7610 kernel: ? do_syscall_64+0x37/0x80
> > Oct 22 06:13:06 T7610 kernel: ? entry_SYSCALL_64_after_hwframe+0x44/0xae
> >
> >
> > Call Trace 2:
> > Oct 22 07:45:37 T7610 kernel: task:fsstress        state:R  running task     stack:    0 pid: 9584 ppid:     1 flags:0x00004006
> > Oct 22 07:45:37 T7610 kernel: Call Trace:
> > Oct 22 07:45:37 T7610 kernel: ? iomap_dio_complete+0x9e/0x140
> > Oct 22 07:45:37 T7610 kernel: ? btrfs_file_read_iter+0x124/0x1c0 [btrfs]
> > Oct 22 07:45:37 T7610 kernel: ? new_sync_read+0x118/0x1a0
> > Oct 22 07:45:37 T7610 kernel: ? vfs_read+0xf1/0x190
> > Oct 22 07:45:37 T7610 kernel: ? ksys_read+0x59/0xd0
> > Oct 22 07:45:37 T7610 kernel: ? do_syscall_64+0x37/0x80
> > Oct 22 07:45:37 T7610 kernel: ? entry_SYSCALL_64_after_hwframe+0x44/0xae
> >
> 
> Are those the complete traces?
> It looks like too little, and inexact (the prefix ?).

Yes. these are complete traces.  I do not know the reason of 'the prefix ?'

I run fstests/generic/475 2 times again.
- failed to reproduce on SSD/SAS
- sucessed to reproduce on SSD/NVMe

Then I gathered 'sysrq -t' for 3 times.

[  909.099550] task:fsstress        state:R  running task     stack:    0 pid: 9269 ppid:     1 flags:0x00004006
[  909.100594] Call Trace:
[  909.101633]  ? __clear_user+0x40/0x70
[  909.102675]  ? lock_release+0x1c6/0x270
[  909.103717]  ? alloc_extent_state+0xc1/0x190 [btrfs]
[  909.104822]  ? fixup_exception+0x41/0x60
[  909.105881]  ? rcu_read_lock_held_common+0xe/0x40
[  909.106924]  ? rcu_read_lock_sched_held+0x23/0x80
[  909.107947]  ? rcu_read_lock_sched_held+0x23/0x80
[  909.108966]  ? slab_post_alloc_hook+0x50/0x340
[  909.109993]  ? trace_hardirqs_on+0x1a/0xd0
[  909.111039]  ? lock_extent_bits+0x64/0x90 [btrfs]
[  909.112202]  ? __clear_extent_bit+0x37a/0x530 [btrfs]
[  909.113366]  ? filemap_write_and_wait_range+0x87/0xd0
[  909.114455]  ? clear_extent_bit+0x15/0x20 [btrfs]
[  909.115628]  ? __iomap_dio_rw+0x284/0x830
[  909.116741]  ? find_vma+0x32/0xb0
[  909.117868]  ? __get_user_pages+0xba/0x740
[  909.118971]  ? iomap_dio_rw+0xa/0x30
[  909.120069]  ? btrfs_file_read_iter+0x157/0x1c0 [btrfs]
[  909.121219]  ? new_sync_read+0x11b/0x1b0
[  909.122301]  ? vfs_read+0xf7/0x190
[  909.123373]  ? ksys_read+0x5f/0xe0
[  909.124451]  ? do_syscall_64+0x37/0x80
[  909.125556]  ? entry_SYSCALL_64_after_hwframe+0x44/0xae

[ 1066.293028] task:fsstress        state:R  running task     stack:    0 pid: 9269 ppid:     1 flags:0x00004006
[ 1066.294069] Call Trace:
[ 1066.295111]  ? btrfs_file_read_iter+0x157/0x1c0 [btrfs]
[ 1066.296213]  ? new_sync_read+0x11b/0x1b0
[ 1066.297268]  ? vfs_read+0xf7/0x190
[ 1066.298314]  ? ksys_read+0x5f/0xe0
[ 1066.299359]  ? do_syscall_64+0x37/0x80
[ 1066.300394]  ? entry_SYSCALL_64_after_hwframe+0x44/0xae


[ 1201.027178] task:fsstress        state:R  running task     stack:    0 pid: 9269 ppid:     1 flags:0x00004006
[ 1201.028233] Call Trace:
[ 1201.029298]  ? iomap_dio_rw+0xa/0x30
[ 1201.030352]  ? btrfs_file_read_iter+0x157/0x1c0 [btrfs]
[ 1201.031465]  ? new_sync_read+0x11b/0x1b0
[ 1201.032534]  ? vfs_read+0xf7/0x190
[ 1201.033592]  ? ksys_read+0x5f/0xe0
[ 1201.034633]  ? do_syscall_64+0x37/0x80
[ 1201.035661]  ? entry_SYSCALL_64_after_hwframe+0x44/0xae

By the way, I enable ' -O no-holes -R free-space-tree' for mkfs.btrfs by
default.


> >
> > We noticed some  error in dmesg before this infinite loop.
> > [15590.720909] BTRFS: error (device dm-0) in __btrfs_free_extent:3069: errno=-5 IO failure
> > [15590.723014] BTRFS info (device dm-0): forced readonly
> > [15590.725115] BTRFS: error (device dm-0) in btrfs_run_delayed_refs:2150: errno=-5 IO failure
> 
> Yes, that's expected, the test intentionally triggers simulated IO
> failures, which can happen anywhere, not just when running delayed
> references.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/10/22


