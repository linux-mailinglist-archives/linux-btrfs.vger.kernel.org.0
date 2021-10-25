Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 277C34392D0
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Oct 2021 11:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbhJYJo7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Oct 2021 05:44:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:56656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232825AbhJYJo2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Oct 2021 05:44:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E11B860241
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Oct 2021 09:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635154926;
        bh=FiTvi8hS6K1F/KfBC94Z59LntcX1d7aS5hUea6g0Zx8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NhKt+VQ8U1QmFg8rvJuPrGwfqCQQiPrs7YVkr50IOhv3sm6AmlKOwDd/0DDRifI7a
         DMe3Vtkuq9dWkpPvHmQgsNKVrCrAAvxcxrqbJR24DCqw0G7tec/gVVzzBtMMelKNdk
         cL3scAxlDCvpanq3ZJCXSr+EXoI/q9hp7dv2SbNQRBzFEwTEWwG5IYcUAGxG1FmDvG
         baBIVaVWzkZkdyIi/2oYeFk9tEhyjJEaDQ4+oXuiM6hiYHkyMR3COWZIAERWF1XPld
         o0yklsLQuax2Dmpygy7dYgJZN5YQczhUElAtAdO5XAolRwwmYLfZ8dFfLG2H4myCZ9
         rZEW8rRxU8l+g==
Received: by mail-qk1-f172.google.com with SMTP id h65so11360036qke.0
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Oct 2021 02:42:06 -0700 (PDT)
X-Gm-Message-State: AOAM532YlkFI2RZaUCvqllv3z3dyaOl7NBPd3sZaVgQGVZwkRqCo/dr1
        5kAjFQnz38tK+/R/nr7JLd0+VgqATxZc3VN3HHY=
X-Google-Smtp-Source: ABdhPJzjcx0CXGg9HOQRz7UC9rQzPn5Y9ygMVKzfYGbfAbs7qtrA1qYaQ+lUcjF2kKHEJTOH+JcFpT5VrP+romLgvsE=
X-Received: by 2002:a37:8287:: with SMTP id e129mr12718449qkd.415.1635154925980;
 Mon, 25 Oct 2021 02:42:05 -0700 (PDT)
MIME-Version: 1.0
References: <20211022201232.7830.409509F4@e16-tech.com> <CAL3q7H5t6mL8G8-8QuUBOZDR-oniSosPHZCNo81dFQTcZXigQw@mail.gmail.com>
 <20211023115852.2517.409509F4@e16-tech.com>
In-Reply-To: <20211023115852.2517.409509F4@e16-tech.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 25 Oct 2021 10:41:29 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5HAEcoZaALzeG5T0HNf_uJ1egbXWGePnihGpaOY7svJw@mail.gmail.com>
Message-ID: <CAL3q7H5HAEcoZaALzeG5T0HNf_uJ1egbXWGePnihGpaOY7svJw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix deadlock due to page faults during direct IO
 reads and writes
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Oct 23, 2021 at 4:58 AM Wang Yugui <wangyugui@e16-tech.com> wrote:
>
> hi,
>
> With this new patch, xfstest/generic/475 and xfstest/generic/650 works well.
>
> Thanks a lot.

Thanks for testing and reporting.
I'll integrate the patch into a v2.
Feel free to comment with a Tested-by tag on it if you want to.

>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2021/10/23
>
> > On Fri, Oct 22, 2021 at 1:12 PM Wang Yugui <wangyugui@e16-tech.com> wrote:
> > >
> > > Hi,
> > >
> > > > On Fri, Oct 22, 2021 at 6:59 AM Wang Yugui <wangyugui@e16-tech.com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > I noticed a infinite loop of fstests/generic/475 when I apply this patch
> > > > > and "[PATCH v9 00/17] gfs2: Fix mmap + page fault deadlocks"
> > > >
> > > > You mean v8? I can't find v9 anywhere.
> > >
> > > Yes. It is v8.
> > >
> > >
> > > > >
> > > > > reproduce frequency: about 50%.
> > > >
> > > > with v8, on top of current misc-next, I couldn't trigger any issues
> > > > after running g/475 for 50+ times.
> > > >
> > > > >
> > > > > Call Trace 1:
> > > > > Oct 22 06:13:06 T7610 kernel: task:fsstress        state:R  running task     stack:    0 pid:2652125 ppid:     1 flags:0x00004006
> > > > > Oct 22 06:13:06 T7610 kernel: Call Trace:
> > > > > Oct 22 06:13:06 T7610 kernel: ? iomap_dio_rw+0xa/0x30
> > > > > Oct 22 06:13:06 T7610 kernel: ? btrfs_file_read_iter+0x157/0x1c0 [btrfs]
> > > > > Oct 22 06:13:06 T7610 kernel: ? new_sync_read+0x118/0x1a0
> > > > > Oct 22 06:13:06 T7610 kernel: ? vfs_read+0xf1/0x190
> > > > > Oct 22 06:13:06 T7610 kernel: ? ksys_read+0x59/0xd0
> > > > > Oct 22 06:13:06 T7610 kernel: ? do_syscall_64+0x37/0x80
> > > > > Oct 22 06:13:06 T7610 kernel: ? entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > > >
> > > > >
> > > > > Call Trace 2:
> > > > > Oct 22 07:45:37 T7610 kernel: task:fsstress        state:R  running task     stack:    0 pid: 9584 ppid:     1 flags:0x00004006
> > > > > Oct 22 07:45:37 T7610 kernel: Call Trace:
> > > > > Oct 22 07:45:37 T7610 kernel: ? iomap_dio_complete+0x9e/0x140
> > > > > Oct 22 07:45:37 T7610 kernel: ? btrfs_file_read_iter+0x124/0x1c0 [btrfs]
> > > > > Oct 22 07:45:37 T7610 kernel: ? new_sync_read+0x118/0x1a0
> > > > > Oct 22 07:45:37 T7610 kernel: ? vfs_read+0xf1/0x190
> > > > > Oct 22 07:45:37 T7610 kernel: ? ksys_read+0x59/0xd0
> > > > > Oct 22 07:45:37 T7610 kernel: ? do_syscall_64+0x37/0x80
> > > > > Oct 22 07:45:37 T7610 kernel: ? entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > > >
> > > >
> > > > Are those the complete traces?
> > > > It looks like too little, and inexact (the prefix ?).
> > >
> > > Yes. these are complete traces.  I do not know the reason of 'the prefix ?'
> > >
> > > I run fstests/generic/475 2 times again.
> > > - failed to reproduce on SSD/SAS
> > > - sucessed to reproduce on SSD/NVMe
> > >
> > > Then I gathered 'sysrq -t' for 3 times.
> > >
> > > [  909.099550] task:fsstress        state:R  running task     stack:    0 pid: 9269 ppid:     1 flags:0x00004006
> > > [  909.100594] Call Trace:
> > > [  909.101633]  ? __clear_user+0x40/0x70
> > > [  909.102675]  ? lock_release+0x1c6/0x270
> > > [  909.103717]  ? alloc_extent_state+0xc1/0x190 [btrfs]
> > > [  909.104822]  ? fixup_exception+0x41/0x60
> > > [  909.105881]  ? rcu_read_lock_held_common+0xe/0x40
> > > [  909.106924]  ? rcu_read_lock_sched_held+0x23/0x80
> > > [  909.107947]  ? rcu_read_lock_sched_held+0x23/0x80
> > > [  909.108966]  ? slab_post_alloc_hook+0x50/0x340
> > > [  909.109993]  ? trace_hardirqs_on+0x1a/0xd0
> > > [  909.111039]  ? lock_extent_bits+0x64/0x90 [btrfs]
> > > [  909.112202]  ? __clear_extent_bit+0x37a/0x530 [btrfs]
> > > [  909.113366]  ? filemap_write_and_wait_range+0x87/0xd0
> > > [  909.114455]  ? clear_extent_bit+0x15/0x20 [btrfs]
> > > [  909.115628]  ? __iomap_dio_rw+0x284/0x830
> > > [  909.116741]  ? find_vma+0x32/0xb0
> > > [  909.117868]  ? __get_user_pages+0xba/0x740
> > > [  909.118971]  ? iomap_dio_rw+0xa/0x30
> > > [  909.120069]  ? btrfs_file_read_iter+0x157/0x1c0 [btrfs]
> > > [  909.121219]  ? new_sync_read+0x11b/0x1b0
> > > [  909.122301]  ? vfs_read+0xf7/0x190
> > > [  909.123373]  ? ksys_read+0x5f/0xe0
> > > [  909.124451]  ? do_syscall_64+0x37/0x80
> > > [  909.125556]  ? entry_SYSCALL_64_after_hwframe+0x44/0xae
> > >
> > > [ 1066.293028] task:fsstress        state:R  running task     stack:    0 pid: 9269 ppid:     1 flags:0x00004006
> > > [ 1066.294069] Call Trace:
> > > [ 1066.295111]  ? btrfs_file_read_iter+0x157/0x1c0 [btrfs]
> > > [ 1066.296213]  ? new_sync_read+0x11b/0x1b0
> > > [ 1066.297268]  ? vfs_read+0xf7/0x190
> > > [ 1066.298314]  ? ksys_read+0x5f/0xe0
> > > [ 1066.299359]  ? do_syscall_64+0x37/0x80
> > > [ 1066.300394]  ? entry_SYSCALL_64_after_hwframe+0x44/0xae
> > >
> > >
> > > [ 1201.027178] task:fsstress        state:R  running task     stack:    0 pid: 9269 ppid:     1 flags:0x00004006
> > > [ 1201.028233] Call Trace:
> > > [ 1201.029298]  ? iomap_dio_rw+0xa/0x30
> > > [ 1201.030352]  ? btrfs_file_read_iter+0x157/0x1c0 [btrfs]
> > > [ 1201.031465]  ? new_sync_read+0x11b/0x1b0
> > > [ 1201.032534]  ? vfs_read+0xf7/0x190
> > > [ 1201.033592]  ? ksys_read+0x5f/0xe0
> > > [ 1201.034633]  ? do_syscall_64+0x37/0x80
> > > [ 1201.035661]  ? entry_SYSCALL_64_after_hwframe+0x44/0xae
> > >
> > > By the way, I enable ' -O no-holes -R free-space-tree' for mkfs.btrfs by
> > > default.
> >
> > Those mkfs options/fs features should be irrelevant.
> >
> > Can you try with the attached patch applied on top of those patches?
> >
> > Thanks.
> >
> > >
> > >
> > > > >
> > > > > We noticed some  error in dmesg before this infinite loop.
> > > > > [15590.720909] BTRFS: error (device dm-0) in __btrfs_free_extent:3069: errno=-5 IO failure
> > > > > [15590.723014] BTRFS info (device dm-0): forced readonly
> > > > > [15590.725115] BTRFS: error (device dm-0) in btrfs_run_delayed_refs:2150: errno=-5 IO failure
> > > >
> > > > Yes, that's expected, the test intentionally triggers simulated IO
> > > > failures, which can happen anywhere, not just when running delayed
> > > > references.
> > >
> > > Best Regards
> > > Wang Yugui (wangyugui@e16-tech.com)
> > > 2021/10/22
> > >
> > >
>
>
