Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56AC6445646
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Nov 2021 16:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhKDP05 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Nov 2021 11:26:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:40688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231312AbhKDP04 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Nov 2021 11:26:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 88489611C4
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Nov 2021 15:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636039457;
        bh=8tCvBAYqFN01IomVSizL1+3IRn5aDBs54Q3nVHxEps8=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=QlV4fRxGT5wWxrIGLo2LeRCS/iHA4h5ZzH/C/W3/zC/jT5EDdHxTs8nx3h0+2hQHn
         m1xTxlM6CS+mflNix6uOgCnKzc2qm/tmnglaVL+fembkpWeAH85AZGRln5Sqy/dry7
         nk59R+RJzBQRfPz2LV13l381aPFmcUnd1Tx3fAdaMi6yL1zeQoioIrLsX8y9liQdYF
         lBDW5JIuPCbKIw17QvBmXpO0bN3yWmUUVpzsyZEmskaV2RX9ubtULctsVxBeFkGdRt
         cThlctk2Q1ZjbcRREmOPTQz/ItqCi6wC6zhIuzWPExNmeSbFUKzwAnugPx7FNul0cU
         kAHuuI5J4i41Q==
Received: by mail-qt1-f174.google.com with SMTP id h16so4482418qtk.0
        for <linux-btrfs@vger.kernel.org>; Thu, 04 Nov 2021 08:24:17 -0700 (PDT)
X-Gm-Message-State: AOAM5313GrVXE/8RYDuqbewNJyfCEfAMNYYYBzpAjjEb3OYQIxRrGEn2
        tdx6XzoGkoHL/Vk/jRqXkBU1KNBwsnWgz1QSWWw=
X-Google-Smtp-Source: ABdhPJyinkjuwRKSkRnN/NHD84K0ZUmI3Zsa5L2OSwi4v3HbtSssoDw2qFV0RtkpHpCTdnGRAu6GJnenpOSXFwC44GE=
X-Received: by 2002:a05:622a:1810:: with SMTP id t16mr54211703qtc.29.1636039456633;
 Thu, 04 Nov 2021 08:24:16 -0700 (PDT)
MIME-Version: 1.0
References: <3df4731012ac6dc17f9f3a33c519735fbe89fc84.1635355240.git.fdmanana@suse.com>
 <20211104150015.GY20319@twin.jikos.cz>
In-Reply-To: <20211104150015.GY20319@twin.jikos.cz>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 4 Nov 2021 15:23:40 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4y1G8pBfGPXQ8ce=1Msq6SaEj_REbQyFuUONFxfpnoZg@mail.gmail.com>
Message-ID: <CAL3q7H4y1G8pBfGPXQ8ce=1Msq6SaEj_REbQyFuUONFxfpnoZg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix deadlock between quota enable and other quota operations
To:     David Sterba <dsterba@suse.cz>,
        Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 4, 2021 at 3:00 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Wed, Oct 27, 2021 at 06:30:25PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > When enabling quotas, we attempt to commit a transaction while holding the
> > mutex fs_info->qgroup_ioctl_lock. This can result on a deadlock with other
> > quota operations such as:
> >
> > - qgroup creation and deletion, ioctl BTRFS_IOC_QGROUP_CREATE;
> >
> > - adding and removing qgroup relations, ioctl BTRFS_IOC_QGROUP_ASSIGN.
> >
> > This is because these operations join a transaction and after that they
> > attempt to lock the mutex fs_info->qgroup_ioctl_lock. Acquiring that mutex
> > after joining or starting a transaction is a pattern followed everywhere
> > in qgroups, so the quota enablement operation is the one at fault here,
> > and should not commit a transaction while holding that mutex.
> >
> > Fix this by making the transaction commit while not holding the mutex.
> > We are safe from two concurrent tasks trying to enable quotas because
> > we are serialized by the rw semaphore fs_info->subvol_sem at
> > btrfs_ioctl_quota_ctl(), which is the only call site for enabling
> > quotas.
> >
> > When this deadlock happens, it produces a trace like the following:
> >
> >   INFO: task syz-executor:25604 blocked for more than 143 seconds.
> >   Not tainted 5.15.0-rc6 #4
> >   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >   task:syz-executor state:D stack:24800 pid:25604 ppid: 24873 flags:0x00004004
> >   Call Trace:
> >   context_switch kernel/sched/core.c:4940 [inline]
> >   __schedule+0xcd9/0x2530 kernel/sched/core.c:6287
> >   schedule+0xd3/0x270 kernel/sched/core.c:6366
> >   btrfs_commit_transaction+0x994/0x2e90 fs/btrfs/transaction.c:2201
> >   btrfs_quota_enable+0x95c/0x1790 fs/btrfs/qgroup.c:1120
> >   btrfs_ioctl_quota_ctl fs/btrfs/ioctl.c:4229 [inline]
> >   btrfs_ioctl+0x637e/0x7b70 fs/btrfs/ioctl.c:5010
> >   vfs_ioctl fs/ioctl.c:51 [inline]
> >   __do_sys_ioctl fs/ioctl.c:874 [inline]
> >   __se_sys_ioctl fs/ioctl.c:860 [inline]
> >   __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
> >   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >   entry_SYSCALL_64_after_hwframe+0x44/0xae
> >   RIP: 0033:0x7f86920b2c4d
> >   RSP: 002b:00007f868f61ac58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> >   RAX: ffffffffffffffda RBX: 00007f86921d90a0 RCX: 00007f86920b2c4d
> >   RDX: 0000000020005e40 RSI: 00000000c0109428 RDI: 0000000000000008
> >   RBP: 00007f869212bd80 R08: 0000000000000000 R09: 0000000000000000
> >   R10: 0000000000000000 R11: 0000000000000246 R12: 00007f86921d90a0
> >   R13: 00007fff6d233e4f R14: 00007fff6d233ff0 R15: 00007f868f61adc0
> >   INFO: task syz-executor:25628 blocked for more than 143 seconds.
> >   Not tainted 5.15.0-rc6 #4
> >   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >   task:syz-executor state:D stack:29080 pid:25628 ppid: 24873 flags:0x00004004
> >   Call Trace:
> >   context_switch kernel/sched/core.c:4940 [inline]
> >   __schedule+0xcd9/0x2530 kernel/sched/core.c:6287
> >   schedule+0xd3/0x270 kernel/sched/core.c:6366
> >   schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6425
> >   __mutex_lock_common kernel/locking/mutex.c:669 [inline]
> >   __mutex_lock+0xc96/0x1680 kernel/locking/mutex.c:729
> >   btrfs_remove_qgroup+0xb7/0x7d0 fs/btrfs/qgroup.c:1548
> >   btrfs_ioctl_qgroup_create fs/btrfs/ioctl.c:4333 [inline]
> >   btrfs_ioctl+0x683c/0x7b70 fs/btrfs/ioctl.c:5014
> >   vfs_ioctl fs/ioctl.c:51 [inline]
> >   __do_sys_ioctl fs/ioctl.c:874 [inline]
> >   __se_sys_ioctl fs/ioctl.c:860 [inline]
> >   __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
> >   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >   entry_SYSCALL_64_after_hwframe+0x44/0xae
> >
> > Reported-by: Hao Sun <sunhao.th@gmail.com>
> > Link: https://lore.kernel.org/linux-btrfs/CACkBjsZQF19bQ1C6=yetF3BvL10OSORpFUcWXTP6HErshDB4dQ@mail.gmail.com/
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> Added to misc-next, thanks.

Btw, I forgot to add the Fixes tag, the matching commit is
340f1aa27f367e ("btrfs: qgroups: Move transaction management inside
btrfs_quota_enable/disable").
It's from 2018, that's a bit old, not entirely sure if needed. If you
want it, feel free to add it.

Thanks.
