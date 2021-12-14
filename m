Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13C0473B33
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Dec 2021 03:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbhLNC67 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Dec 2021 21:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbhLNC67 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Dec 2021 21:58:59 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDED4C061574
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Dec 2021 18:58:58 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id d10so43129812ybe.3
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Dec 2021 18:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=8wOgSr9OO19x2FW74yM80bEDS76iMANX+8wPPU/ISao=;
        b=pos7U7TMXJftQ91BmojVeOxviFGIGRC5C9XGhHvURTh+eEgq25t0Li+e5XVstlIc97
         UXnQhh3GfhQWfUXIOL2Jshcd5yfbcpjtrcjFb/oUMLD9Z36F/s+rNveMf7h/r4HrH5zS
         QmJ7W+h3NiWy/q3ruPsrt6TjiZc6Jvz33kKf5j3OV/4oCfotXWBW1QJegjV4EGt3ZHYK
         9AltKJwU5W+eFjdpTjWyvu6Ha9AJ6mFlm2K5pKlyRw9tgfhhZOQsUzfZfgQ75NC6VTaT
         m4wRVFfHKFMSMQ5Y8W7XoZYC2tCFP5GoZ/1l/bj8q326/wSSbOLcHMHEyG82Ph5A49I9
         BPrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=8wOgSr9OO19x2FW74yM80bEDS76iMANX+8wPPU/ISao=;
        b=AKeQr3jWN/flOMD7dObWvNHIlCS06cOfv1+34QfijHIrGledaVNJMUy9IyOGn6tEKH
         wYpyMJ9MxpqFH2e28gBpt4eivapNyohMAOZgvgtgnhzJjNmzQA9Ch8IZyHnxSYvma0gK
         diSWEd6FU8XHYlfx6AMvmsAaDRTJifrP/m5/ehGMwg6ZkJ5EwEGfzN1vY96aNNKR7efx
         NqBEa2TrRifIUMQeQwZIpYY7qhCk6rOIWmc3feYPJEX+5Rtamvg7vl0A28lehWPK93OV
         wmIdW8ukTIk+sZ8k4tMRZI7cxdtjO7xsXK/BbdODj4ZPGPfpgNHtHzWgWTtoBXj1XRPH
         Oy0A==
X-Gm-Message-State: AOAM532tNIUJkV9zZ54Q4wep/J34aGRS5zVrt02iOC0KPPilDgBF7Pcq
        9stasDdOLyfNT8UB8jaAsnrOji11vPABWLGzWrEOlaB07CSX7QbNsRo=
X-Google-Smtp-Source: ABdhPJxW0OoFaKaa6aXSdDzglmy/0pLR/uW5ae2J07nEDauE26crJ1c8qqcUWXZA8mk58EXB5z9GP4mubqrZzbBBkBQ=
X-Received: by 2002:a25:e057:: with SMTP id x84mr2639317ybg.385.1639450737336;
 Mon, 13 Dec 2021 18:58:57 -0800 (PST)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 13 Dec 2021 21:58:41 -0500
Message-ID: <CAJCQCtT+RSzpUjbMq+UfzNUMe1X5+1G+DnAGbHC=OZ=iRS24jg@mail.gmail.com>
Subject: 5.16.0-0.rc5, btrfs-transacti:9822 blocked, write time tree block
 corruption, parent transid verify failed, error in free_log_tree, forced ro
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a regression, I never encountered it running rc4, and running
rc5 for just about 5 hours ran into a hang after logging out of the
desktop and back in...

I let it hang for a while (few minutes) then dropped to a tty and did
a reboot. Fortunately journald did capture quite a lot more than I saw
before the reboot. Following reboot (used 5.15.7), btrfs has no
complaints. Mounts and boots fine, so the write time tree checker may
have prevented corruption.

Full dmesg here:
https://drive.google.com/file/d/1arn0_wVbbK0RiI1sKLnXuqpPjW2mHdFu/view?usp=sharing

Inline excerpted from the first blocked task messages...

Dec 13 21:42:47 kernel: INFO: task btrfs-transacti:9822 blocked for
more than 122 seconds.
Dec 13 21:42:47 kernel:       Tainted: G        W        --------- ---
 5.16.0-0.rc5.35.fc36.x86_64+debug #1
Dec 13 21:42:47 kernel: "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec 13 21:42:47 kernel: task:btrfs-transacti state:D stack:14920 pid:
9822 ppid:     2 flags:0x00004000
Dec 13 21:42:47 kernel: Call Trace:
Dec 13 21:42:47 kernel:  <TASK>
Dec 13 21:42:47 kernel:  __schedule+0x3f8/0x1500
Dec 13 21:42:47 kernel:  ? _raw_spin_unlock_irqrestore+0x2d/0x60
Dec 13 21:42:47 kernel:  ? lockdep_hardirqs_on+0x7e/0x100
Dec 13 21:42:47 kernel:  ? _raw_spin_unlock_irqrestore+0x3e/0x60
Dec 13 21:42:47 kernel:  schedule+0x4e/0xc0
Dec 13 21:42:47 kernel:  wait_current_trans+0xad/0x110
Dec 13 21:42:47 kernel:  ? do_wait_intr_irq+0xb0/0xb0
Dec 13 21:42:47 kernel:  start_transaction+0x365/0x6a0
Dec 13 21:42:47 kernel:  transaction_kthread+0xa7/0x1a0
Dec 13 21:42:47 kernel:  ? btrfs_cleanup_transaction.isra.0+0x640/0x640
Dec 13 21:42:47 kernel:  kthread+0x17a/0x1a0
Dec 13 21:42:47 kernel:  ? set_kthread_struct+0x40/0x40
Dec 13 21:42:47 kernel:  ret_from_fork+0x1f/0x30
Dec 13 21:42:47 kernel:  </TASK>
Dec 13 21:42:47 kernel: INFO: task Cache2 I/O:10810 blocked for more
than 122 seconds.
Dec 13 21:42:47 kernel:       Tainted: G        W        --------- ---
 5.16.0-0.rc5.35.fc36.x86_64+debug #1
Dec 13 21:42:47 kernel: "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec 13 21:42:47 kernel: task:Cache2 I/O      state:D stack:12680
pid:10810 ppid:  9889 flags:0x00000004
Dec 13 21:42:47 kernel: Call Trace:
Dec 13 21:42:47 kernel:  <TASK>
Dec 13 21:42:47 kernel:  __schedule+0x3f8/0x1500
Dec 13 21:42:47 kernel:  ? _raw_spin_unlock_irqrestore+0x2d/0x60
Dec 13 21:42:47 kernel:  ? lockdep_hardirqs_on+0x7e/0x100
Dec 13 21:42:47 kernel:  ? _raw_spin_unlock_irqrestore+0x3e/0x60
Dec 13 21:42:47 kernel:  schedule+0x4e/0xc0
Dec 13 21:42:47 kernel:  wait_current_trans+0xad/0x110
Dec 13 21:42:47 kernel:  ? do_wait_intr_irq+0xb0/0xb0
Dec 13 21:42:47 kernel:  start_transaction+0x3dc/0x6a0
Dec 13 21:42:47 kernel:  btrfs_unlink+0x32/0x110
Dec 13 21:42:47 kernel:  vfs_unlink+0x110/0x230
Dec 13 21:42:47 kernel:  do_unlinkat+0x18c/0x2b0
Dec 13 21:42:47 kernel:  __x64_sys_unlink+0x3e/0x60
Dec 13 21:42:47 kernel:  do_syscall_64+0x38/0x90
Dec 13 21:42:47 kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 13 21:42:47 kernel: RIP: 0033:0x7fbcb3df1fdb
Dec 13 21:42:47 kernel: RSP: 002b:00007fbc939748e8 EFLAGS: 00000206
ORIG_RAX: 0000000000000057
Dec 13 21:42:47 kernel: RAX: ffffffffffffffda RBX: 00007fbc6af4c500
RCX: 00007fbcb3df1fdb
Dec 13 21:42:47 kernel: RDX: 0000000000000000 RSI: 00007fbc6d144d08
RDI: 00007fbc6d144d08
Dec 13 21:42:47 kernel: RBP: 0000000000000000 R08: 0000000000000000
R09: 000000000000000a
Dec 13 21:42:47 kernel: R10: 0000000000000100 R11: 0000000000000206
R12: 0000000000000000
Dec 13 21:42:47 kernel: R13: 00007fbc6c8e78e0 R14: 00007fbc6c8e78e0
R15: 00007fbc6d1259c0
Dec 13 21:42:47 kernel:  </TASK>
Dec 13 21:42:47 kernel: INFO: task BgIOThr~Pool #1:10821 blocked for
more than 122 seconds.
Dec 13 21:42:47 kernel:       Tainted: G        W        --------- ---
 5.16.0-0.rc5.35.fc36.x86_64+debug #1
Dec 13 21:42:47 kernel: "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec 13 21:42:47 kernel: task:BgIOThr~Pool #1 state:D stack:11784
pid:10821 ppid:  9889 flags:0x00000004
Dec 13 21:42:47 kernel: Call Trace:
Dec 13 21:42:47 kernel:  <TASK>
Dec 13 21:42:47 kernel:  __schedule+0x3f8/0x1500
Dec 13 21:42:47 kernel:  ? _raw_spin_unlock_irqrestore+0x2d/0x60
Dec 13 21:42:47 kernel:  ? lockdep_hardirqs_on+0x7e/0x100
Dec 13 21:42:47 kernel:  ? _raw_spin_unlock_irqrestore+0x3e/0x60
Dec 13 21:42:47 kernel:  schedule+0x4e/0xc0
Dec 13 21:42:47 kernel:  wait_current_trans+0xad/0x110
Dec 13 21:42:47 kernel:  ? do_wait_intr_irq+0xb0/0xb0
Dec 13 21:42:47 kernel:  start_transaction+0x3dc/0x6a0
Dec 13 21:42:47 kernel:  btrfs_create+0x4c/0x200
Dec 13 21:42:47 kernel:  ? d_splice_alias+0x16e/0x490
Dec 13 21:42:47 kernel:  lookup_open.isra.0+0x534/0x670
Dec 13 21:42:47 kernel:  ? __wake_up_common_lock+0x52/0x90
Dec 13 21:42:47 kernel:  path_openat+0x2aa/0xa20
Dec 13 21:42:47 kernel:  do_filp_open+0x9f/0x130
Dec 13 21:42:47 kernel:  ? lock_release+0x151/0x460
Dec 13 21:42:47 kernel:  ? _raw_spin_unlock+0x29/0x40
Dec 13 21:42:47 kernel:  ? alloc_fd+0x12f/0x1f0
Dec 13 21:42:47 kernel:  do_sys_openat2+0x7a/0x140
Dec 13 21:42:47 kernel:  __x64_sys_openat+0x45/0x70
Dec 13 21:42:47 kernel:  do_syscall_64+0x38/0x90
Dec 13 21:42:47 kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 13 21:42:47 kernel: RIP: 0033:0x7fbcb3df0524
Dec 13 21:42:47 kernel: RSP: 002b:00007fbc92ebc130 EFLAGS: 00000293
ORIG_RAX: 0000000000000101
Dec 13 21:42:47 kernel: RAX: ffffffffffffffda RBX: 0000000000000008
RCX: 00007fbcb3df0524
Dec 13 21:42:47 kernel: RDX: 0000000000000241 RSI: 00007fbc6baaf608
RDI: 00000000ffffff9c
Dec 13 21:42:47 kernel: RBP: 00007fbc6baaf608 R08: 0000000000000000
R09: 0000000000000004
Dec 13 21:42:47 kernel: R10: 00000000000001b6 R11: 0000000000000293
R12: 0000000000000241
Dec 13 21:42:47 kernel: R13: 00000000000001b6 R14: 00007fbc92ebd580
R15: 00007fbc66a9a000
Dec 13 21:42:47 kernel:  </TASK>
Dec 13 21:42:47 kernel: INFO: task glean.dispatche:10872 blocked for
more than 122 seconds.
Dec 13 21:42:47 kernel:       Tainted: G        W        --------- ---
 5.16.0-0.rc5.35.fc36.x86_64+debug #1
Dec 13 21:42:47 kernel: "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec 13 21:42:47 kernel: task:glean.dispatche state:D stack:13032
pid:10872 ppid:  9889 flags:0x00000004
Dec 13 21:42:47 kernel: Call Trace:
Dec 13 21:42:47 kernel:  <TASK>
Dec 13 21:42:47 kernel:  __schedule+0x3f8/0x1500
Dec 13 21:42:47 kernel:  ? _raw_spin_unlock_irqrestore+0x2d/0x60
Dec 13 21:42:47 kernel:  ? lockdep_hardirqs_on+0x7e/0x100
Dec 13 21:42:47 kernel:  ? _raw_spin_unlock_irqrestore+0x3e/0x60
Dec 13 21:42:47 kernel:  schedule+0x4e/0xc0
Dec 13 21:42:47 kernel:  wait_current_trans+0xad/0x110
Dec 13 21:42:47 kernel:  ? do_wait_intr_irq+0xb0/0xb0
Dec 13 21:42:47 kernel:  start_transaction+0x3dc/0x6a0
Dec 13 21:42:47 kernel:  btrfs_setattr+0x165/0x6e0
Dec 13 21:42:47 kernel:  notify_change+0x346/0x4e0
Dec 13 21:42:47 kernel:  ? do_truncate+0x6d/0xb0
Dec 13 21:42:47 kernel:  do_truncate+0x6d/0xb0
Dec 13 21:42:47 kernel:  path_openat+0x8a8/0xa20
Dec 13 21:42:47 kernel:  do_filp_open+0x9f/0x130
Dec 13 21:42:47 kernel:  ? lock_release+0x151/0x460
Dec 13 21:42:47 kernel:  ? _raw_spin_unlock+0x29/0x40
Dec 13 21:42:47 kernel:  ? alloc_fd+0x12f/0x1f0
Dec 13 21:42:47 kernel:  do_sys_openat2+0x7a/0x140
Dec 13 21:42:47 kernel:  __x64_sys_openat+0x45/0x70
Dec 13 21:42:47 kernel:  do_syscall_64+0x38/0x90
Dec 13 21:42:47 kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 13 21:42:47 kernel: RIP: 0033:0x7fbcb3df0524
Dec 13 21:42:47 kernel: RSP: 002b:00007fbc7b9fe5d0 EFLAGS: 00000293
ORIG_RAX: 0000000000000101
Dec 13 21:42:47 kernel: RAX: ffffffffffffffda RBX: 00007fbc656beb00
RCX: 00007fbcb3df0524
Dec 13 21:42:47 kernel: RDX: 0000000000080241 RSI: 00007fbc656bebe0
RDI: 00000000ffffff9c
Dec 13 21:42:47 kernel: RBP: 00007fbc656bebe0 R08: 0000000000000000
R09: 06d4bfcacf505cb2
Dec 13 21:42:47 kernel: R10: 00000000000001b6 R11: 0000000000000293
R12: 0000000000080241
Dec 13 21:42:47 kernel: R13: 00007fbc7b9fe6f8 R14: 0000000000000000
R15: 00000000000001b6
Dec 13 21:42:47 kernel:  </TASK>
Dec 13 21:42:47 kernel: INFO: task QuotaManager IO:10873 blocked for
more than 122 seconds.
Dec 13 21:42:47 kernel:       Tainted: G        W        --------- ---
 5.16.0-0.rc5.35.fc36.x86_64+debug #1
Dec 13 21:42:47 kernel: "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec 13 21:42:47 kernel: task:QuotaManager IO state:D stack:12360
pid:10873 ppid:  9889 flags:0x00000004
Dec 13 21:42:47 kernel: Call Trace:
Dec 13 21:42:47 kernel:  <TASK>
Dec 13 21:42:47 kernel:  __schedule+0x3f8/0x1500
Dec 13 21:42:47 kernel:  ? mark_held_locks+0x50/0x80
Dec 13 21:42:47 kernel:  ? __down_read_common+0x168/0x4f0
Dec 13 21:42:47 kernel:  schedule+0x4e/0xc0
Dec 13 21:42:47 kernel:  __down_read_common+0x328/0x4f0
Dec 13 21:42:47 kernel:  ? down_read+0xbe/0x130
Dec 13 21:42:47 kernel:  down_read+0xbe/0x130
Dec 13 21:42:47 kernel:  walk_component+0x10c/0x190
Dec 13 21:42:47 kernel:  path_lookupat+0x6e/0x1c0
Dec 13 21:42:47 kernel:  filename_lookup+0xbc/0x1a0
Dec 13 21:42:47 kernel:  ? __check_object_size+0x152/0x190
Dec 13 21:42:47 kernel:  ? strncpy_from_user+0x53/0x180
Dec 13 21:42:47 kernel:  user_path_at_empty+0x3a/0x50
Dec 13 21:42:47 kernel:  do_faccessat+0x6e/0x260
Dec 13 21:42:47 kernel:  ? syscall_enter_from_user_mode+0x21/0x70
Dec 13 21:42:47 kernel:  do_syscall_64+0x38/0x90
Dec 13 21:42:47 kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 13 21:42:47 kernel: RIP: 0033:0x7fbcb3df08bb
Dec 13 21:42:47 kernel: RSP: 002b:00007fbc823fe618 EFLAGS: 00000246
ORIG_RAX: 0000000000000015
Dec 13 21:42:47 kernel: RAX: ffffffffffffffda RBX: 00007fbc6a8710e0
RCX: 00007fbcb3df08bb
Dec 13 21:42:47 kernel: RDX: 0000000000000139 RSI: 0000000000000000
RDI: 00007fbc6a824a88
Dec 13 21:42:47 kernel: RBP: 00007fbc823fe647 R08: 00007fbcb3b00258
R09: 0000000000000004
Dec 13 21:42:47 kernel: R10: 0000000000000038 R11: 0000000000000246
R12: 00007fbc823fe6a8
Dec 13 21:42:47 kernel: R13: 00007fbc823fe700 R14: 00007fbc823fe780
R15: 00007fbc6a8114b0
Dec 13 21:42:47 kernel:  </TASK>
Dec 13 21:42:47 kernel: INFO: task StreamTrans #5:10874 blocked for
more than 122 seconds.
Dec 13 21:42:47 kernel:       Tainted: G        W        --------- ---
 5.16.0-0.rc5.35.fc36.x86_64+debug #1
Dec 13 21:42:47 kernel: "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec 13 21:42:47 kernel: task:StreamTrans #5  state:D stack:13464
pid:10874 ppid:  9889 flags:0x00004004
Dec 13 21:42:47 kernel: Call Trace:
Dec 13 21:42:47 kernel:  <TASK>
Dec 13 21:42:47 kernel:  __schedule+0x3f8/0x1500
Dec 13 21:42:47 kernel:  ? lock_release+0x151/0x460
Dec 13 21:42:47 kernel:  schedule+0x4e/0xc0
Dec 13 21:42:47 kernel:  btrfs_sync_log+0x150/0xc20
Dec 13 21:42:47 kernel:  ? do_wait_intr_irq+0xb0/0xb0
Dec 13 21:42:47 kernel:  ? lock_is_held_type+0xea/0x140
Dec 13 21:42:47 kernel:  ? dput+0x20/0x480
Dec 13 21:42:47 kernel:  ? find_held_lock+0x32/0x90
Dec 13 21:42:47 kernel:  ? __lock_acquire+0x3b3/0x1e00
Dec 13 21:42:47 kernel:  ? reacquire_held_locks+0xe6/0x200
Dec 13 21:42:47 kernel:  ? btrfs_sync_file+0x327/0x5a0
Dec 13 21:42:47 kernel:  ? lock_is_held_type+0xea/0x140
Dec 13 21:42:47 kernel:  ? lock_release+0x151/0x460
Dec 13 21:42:47 kernel:  btrfs_sync_file+0x40c/0x5a0
Dec 13 21:42:47 kernel:  __x64_sys_fsync+0x33/0x60
Dec 13 21:42:47 kernel:  do_syscall_64+0x38/0x90
Dec 13 21:42:47 kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 13 21:42:47 kernel: RIP: 0033:0x7fbcb3df71db
Dec 13 21:42:47 kernel: RSP: 002b:00007fbc823bd7e0 EFLAGS: 00000293
ORIG_RAX: 000000000000004a
Dec 13 21:42:47 kernel: RAX: ffffffffffffffda RBX: 00007fbc736e5f20
RCX: 00007fbcb3df71db
Dec 13 21:42:47 kernel: RDX: 0000000000000000 RSI: 00007fbc6a8ab000
RDI: 0000000000000078
Dec 13 21:42:47 kernel: RBP: 00007fbc6a815430 R08: 0000000000000000
R09: fffffffffffffff0
Dec 13 21:42:47 kernel: R10: 0000000000000010 R11: 0000000000000293
R12: 00000000000000ca
Dec 13 21:42:47 kernel: R13: 00007fbcaeaafa78 R14: 00007fbcaeaafa48
R15: 00007fbc736f8bc8
Dec 13 21:42:47 kernel:  </TASK>
Dec 13 21:42:47 kernel: INFO: task DOM Worker:10876 blocked for more
than 122 seconds.
Dec 13 21:42:47 kernel:       Tainted: G        W        --------- ---
 5.16.0-0.rc5.35.fc36.x86_64+debug #1
Dec 13 21:42:47 kernel: "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec 13 21:42:47 kernel: task:DOM Worker      state:D stack:14416
pid:10876 ppid:  9889 flags:0x00000004
Dec 13 21:42:47 kernel: Call Trace:
Dec 13 21:42:47 kernel:  <TASK>
Dec 13 21:42:47 kernel:  __schedule+0x3f8/0x1500
Dec 13 21:42:47 kernel:  ? _raw_spin_unlock_irqrestore+0x2d/0x60
Dec 13 21:42:47 kernel:  ? lockdep_hardirqs_on+0x7e/0x100
Dec 13 21:42:47 kernel:  ? _raw_spin_unlock_irqrestore+0x3e/0x60
Dec 13 21:42:47 kernel:  schedule+0x4e/0xc0
Dec 13 21:42:47 kernel:  wait_current_trans+0xad/0x110
Dec 13 21:42:47 kernel:  ? do_wait_intr_irq+0xb0/0xb0
Dec 13 21:42:47 kernel:  start_transaction+0x3dc/0x6a0
Dec 13 21:42:47 kernel:  btrfs_create+0x4c/0x200
Dec 13 21:42:47 kernel:  ? d_splice_alias+0x16e/0x490
Dec 13 21:42:47 kernel:  lookup_open.isra.0+0x534/0x670
Dec 13 21:42:47 kernel:  ? __wake_up_common_lock+0x52/0x90
Dec 13 21:42:47 kernel:  path_openat+0x2aa/0xa20
Dec 13 21:42:47 kernel:  do_filp_open+0x9f/0x130
Dec 13 21:42:47 kernel:  ? lock_release+0x151/0x460
Dec 13 21:42:47 kernel:  ? _raw_spin_unlock+0x29/0x40
Dec 13 21:42:47 kernel:  ? alloc_fd+0x12f/0x1f0
Dec 13 21:42:47 kernel:  do_sys_openat2+0x7a/0x140
Dec 13 21:42:47 kernel:  __x64_sys_openat+0x45/0x70
Dec 13 21:42:47 kernel:  do_syscall_64+0x38/0x90
Dec 13 21:42:47 kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 13 21:42:47 kernel: RIP: 0033:0x7fbcb3df0524
Dec 13 21:42:47 kernel: RSP: 002b:00007fbc79afbd60 EFLAGS: 00000293
ORIG_RAX: 0000000000000101
Dec 13 21:42:47 kernel: RAX: ffffffffffffffda RBX: 00007fbc6c7ac200
RCX: 00007fbcb3df0524
Dec 13 21:42:47 kernel: RDX: 0000000000000641 RSI: 00007fbc6c7c7340
RDI: 00000000ffffff9c
Dec 13 21:42:47 kernel: RBP: 00007fbc6c7c7340 R08: 0000000000000000
R09: 00007fbc6c7c7340
Dec 13 21:42:47 kernel: R10: 0000000000000180 R11: 0000000000000293
R12: 0000000000000641
Dec 13 21:42:47 kernel: R13: 00007fbc79afbe80 R14: 00007fbc757c9a98
R15: 0000000000000003
Dec 13 21:42:47 kernel:  </TASK>
Dec 13 21:42:47 kernel: INFO: task IndexedDB #1:10877 blocked for more
than 122 seconds.
Dec 13 21:42:47 kernel:       Tainted: G        W        --------- ---
 5.16.0-0.rc5.35.fc36.x86_64+debug #1
Dec 13 21:42:47 kernel: "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec 13 21:42:47 kernel: task:IndexedDB #1    state:D stack:12344
pid:10877 ppid:  9889 flags:0x00000004
Dec 13 21:42:47 kernel: Call Trace:
Dec 13 21:42:47 kernel:  <TASK>
Dec 13 21:42:47 kernel:  __schedule+0x3f8/0x1500
Dec 13 21:42:47 kernel:  ? mark_held_locks+0x50/0x80
Dec 13 21:42:47 kernel:  schedule+0x4e/0xc0
Dec 13 21:42:47 kernel:  rwsem_down_write_slowpath+0x227/0x6b0
Dec 13 21:42:47 kernel:  down_write_nested+0xb3/0x120
Dec 13 21:42:47 kernel:  do_unlinkat+0x106/0x2b0
Dec 13 21:42:47 kernel:  __x64_sys_unlink+0x3e/0x60
Dec 13 21:42:47 kernel:  do_syscall_64+0x38/0x90
Dec 13 21:42:47 kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 13 21:42:47 kernel: RIP: 0033:0x7fbcb3df1fdb
Dec 13 21:42:47 kernel: RSP: 002b:00007fbc90a973e8 EFLAGS: 00000246
ORIG_RAX: 0000000000000057
Dec 13 21:42:47 kernel: RAX: ffffffffffffffda RBX: 0000000000000000
RCX: 00007fbcb3df1fdb
Dec 13 21:42:47 kernel: RDX: 0000000000000000 RSI: 00007fbc7cdf0b63
RDI: 00007fbc7cdf0b63
Dec 13 21:42:47 kernel: RBP: 00007fbc7cdf0b63 R08: 00007fbcb3b00418
R09: 0000000000000005
Dec 13 21:42:47 kernel: R10: 0000000000000037 R11: 0000000000000246
R12: 00007fbc7cdf0b63
Dec 13 21:42:47 kernel: R13: 0000000000000000 R14: 00007fbcb31fd7d8
R15: 0000000000000000
Dec 13 21:42:47 kernel:  </TASK>
Dec 13 21:42:47 kernel: INFO: task IndexedDB #3:10926 blocked for more
than 122 seconds.
Dec 13 21:42:47 kernel:       Tainted: G        W        --------- ---
 5.16.0-0.rc5.35.fc36.x86_64+debug #1
Dec 13 21:42:47 kernel: "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec 13 21:42:47 kernel: task:IndexedDB #3    state:D stack:14088
pid:10926 ppid:  9889 flags:0x00004004
Dec 13 21:42:47 kernel: Call Trace:
Dec 13 21:42:47 kernel:  <TASK>
Dec 13 21:42:47 kernel:  __schedule+0x3f8/0x1500
Dec 13 21:42:47 kernel:  ? mark_held_locks+0x50/0x80
Dec 13 21:42:47 kernel:  schedule+0x4e/0xc0
Dec 13 21:42:47 kernel:  rwsem_down_write_slowpath+0x227/0x6b0
Dec 13 21:42:47 kernel:  down_write_nested+0xb3/0x120
Dec 13 21:42:47 kernel:  do_unlinkat+0x106/0x2b0
Dec 13 21:42:47 kernel:  __x64_sys_unlink+0x3e/0x60
Dec 13 21:42:47 kernel:  do_syscall_64+0x38/0x90
Dec 13 21:42:47 kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 13 21:42:47 kernel: RIP: 0033:0x7fbcb3df1fdb
Dec 13 21:42:47 kernel: RSP: 002b:00007fbc774e43e8 EFLAGS: 00000246
ORIG_RAX: 0000000000000057
Dec 13 21:42:47 kernel: RAX: ffffffffffffffda RBX: 0000000000000000
RCX: 00007fbcb3df1fdb
Dec 13 21:42:47 kernel: RDX: 0000000000000000 RSI: 00007fbc75b05851
RDI: 00007fbc75b05851
Dec 13 21:42:47 kernel: RBP: 00007fbc75b05851 R08: 00007fbcb3b00418
R09: 0000000000000005
Dec 13 21:42:47 kernel: R10: 0000000000000037 R11: 0000000000000246
R12: 00007fbc75b05851
Dec 13 21:42:47 kernel: R13: 0000000000000000 R14: 00007fbcb31fd7d8
R15: 0000000000000000
Dec 13 21:42:47 kernel:  </TASK>
Dec 13 21:42:47 kernel: INFO: task IndexedDB #4:10927 blocked for more
than 122 seconds.
Dec 13 21:42:47 kernel:       Tainted: G        W        --------- ---
 5.16.0-0.rc5.35.fc36.x86_64+debug #1
Dec 13 21:42:47 kernel: "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec 13 21:42:47 kernel: task:IndexedDB #4    state:D stack:13928
pid:10927 ppid:  9889 flags:0x00004004
Dec 13 21:42:47 kernel: Call Trace:
Dec 13 21:42:47 kernel:  <TASK>
Dec 13 21:42:47 kernel:  __schedule+0x3f8/0x1500
Dec 13 21:42:47 kernel:  ? mark_held_locks+0x50/0x80
Dec 13 21:42:47 kernel:  schedule+0x4e/0xc0
Dec 13 21:42:47 kernel:  rwsem_down_write_slowpath+0x227/0x6b0
Dec 13 21:42:47 kernel:  down_write_nested+0xb3/0x120
Dec 13 21:42:47 kernel:  do_unlinkat+0x106/0x2b0
Dec 13 21:42:47 kernel:  __x64_sys_unlink+0x3e/0x60
Dec 13 21:42:47 kernel:  do_syscall_64+0x38/0x90
Dec 13 21:42:47 kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 13 21:42:47 kernel: RIP: 0033:0x7fbcb3df1fdb
Dec 13 21:42:47 kernel: RSP: 002b:00007fbc774a33e8 EFLAGS: 00000246
ORIG_RAX: 0000000000000057
Dec 13 21:42:47 kernel: RAX: ffffffffffffffda RBX: 0000000000000000
RCX: 00007fbcb3df1fdb
Dec 13 21:42:47 kernel: RDX: 0000000000000000 RSI: 00007fbc75b0676f
RDI: 00007fbc75b0676f
Dec 13 21:42:47 kernel: RBP: 00007fbc75b0676f R08: 00007fbcb3b00418
R09: 0000000000000005
Dec 13 21:42:47 kernel: R10: 0000000000000037 R11: 0000000000000246
R12: 00007fbc75b0676f
Dec 13 21:42:47 kernel: R13: 0000000000000000 R14: 00007fbcb31fd7d8
R15: 0000000000000000
Dec 13 21:42:47 kernel:  </TASK>
Dec 13 21:42:47 kernel:
                        Showing all locks held in the system:
Dec 13 21:42:47 kernel: 1 lock held by khungtaskd/56:
Dec 13 21:42:47 kernel:  #0: ffffffffa01915e0
(rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x15/0x16b
Dec 13 21:42:47 kernel: 4 locks held by systemd-journal/593:
Dec 13 21:42:47 kernel: 1 lock held by btrfs-transacti/9822:
Dec 13 21:42:47 kernel:  #0: ffff971463ab4840
(&fs_info->transaction_kthread_mutex){+.+.}-{3:3}, at:
transaction_kthread+0x56/0x1a0
Dec 13 21:42:47 kernel: 3 locks held by Permission/10806:
Dec 13 21:42:47 kernel:  #0: ffff971601d0f498
(sb_writers#14){.+.+}-{0:0}, at: path_openat+0x9fb/0xa20
Dec 13 21:42:47 kernel:  #1: ffff97156085e9d8
(&type->i_mutex_dir_key#6){++++}-{3:3}, at: path_openat+0x296/0xa20
Dec 13 21:42:47 kernel:  #2: ffff971601d0f6b8
(sb_internal){.+.+}-{0:0}, at: btrfs_create+0x4c/0x200
Dec 13 21:42:47 kernel: 4 locks held by Cache2 I/O/10810:
Dec 13 21:42:47 kernel:  #0: ffff971601d0f498
(sb_writers#14){.+.+}-{0:0}, at: do_unlinkat+0x95/0x2b0
Dec 13 21:42:47 kernel:  #1: ffff971561909068
(&type->i_mutex_dir_key#6/1){+.+.}-{3:3}, at: do_unlinkat+0x106/0x2b0
Dec 13 21:42:47 kernel:  #2: ffff971535328678
(&sb->s_type->i_mutex_key#14){++++}-{3:3}, at: vfs_unlink+0x48/0x230
Dec 13 21:42:47 kernel:  #3: ffff971601d0f6b8
(sb_internal){.+.+}-{0:0}, at: btrfs_unlink+0x32/0x110
Dec 13 21:42:47 kernel: 3 locks held by BgIOThr~Pool #1/10821:
Dec 13 21:42:47 kernel:  #0: ffff971601d0f498
(sb_writers#14){.+.+}-{0:0}, at: path_openat+0x9fb/0xa20
Dec 13 21:42:47 kernel:  #1: ffff97153534dfe8
(&type->i_mutex_dir_key#6){++++}-{3:3}, at: path_openat+0x296/0xa20
Dec 13 21:42:47 kernel:  #2: ffff971601d0f6b8
(sb_internal){.+.+}-{0:0}, at: btrfs_create+0x4c/0x200
Dec 13 21:42:47 kernel: 3 locks held by glean.dispatche/10872:
Dec 13 21:42:47 kernel:  #0: ffff971601d0f498
(sb_writers#14){.+.+}-{0:0}, at: path_openat+0x813/0xa20
Dec 13 21:42:47 kernel:  #1: ffff97144eed2448
(&sb->s_type->i_mutex_key#14){++++}-{3:3}, at: do_truncate+0x5d/0xb0
Dec 13 21:42:47 kernel:  #2: ffff971601d0f6b8
(sb_internal){.+.+}-{0:0}, at: btrfs_setattr+0x165/0x6e0
Dec 13 21:42:47 kernel: 1 lock held by QuotaManager IO/10873:
Dec 13 21:42:47 kernel:  #0: ffff9715d4d73828
(&type->i_mutex_dir_key#6){++++}-{3:3}, at: walk_component+0x10c/0x190
Dec 13 21:42:47 kernel: 1 lock held by StreamTrans #5/10874:
Dec 13 21:42:47 kernel:  #0: ffff971601d0f6b8
(sb_internal){.+.+}-{0:0}, at: btrfs_sync_file+0x327/0x5a0
Dec 13 21:42:47 kernel: 3 locks held by DOM Worker/10876:
Dec 13 21:42:47 kernel:  #0: ffff971601d0f498
(sb_writers#14){.+.+}-{0:0}, at: path_openat+0x9fb/0xa20
Dec 13 21:42:47 kernel:  #1: ffff97150121a448
(&type->i_mutex_dir_key#6){++++}-{3:3}, at: path_openat+0x296/0xa20
Dec 13 21:42:47 kernel:  #2: ffff971601d0f6b8
(sb_internal){.+.+}-{0:0}, at: btrfs_create+0x4c/0x200
Dec 13 21:42:47 kernel: 2 locks held by IndexedDB #1/10877:
Dec 13 21:42:47 kernel:  #0: ffff971601d0f498
(sb_writers#14){.+.+}-{0:0}, at: do_unlinkat+0x95/0x2b0
Dec 13 21:42:47 kernel:  #1: ffff9715d4d73828
(&type->i_mutex_dir_key#6/1){+.+.}-{3:3}, at: do_unlinkat+0x106/0x2b0
Dec 13 21:42:47 kernel: 4 locks held by IndexedDB #2/10878:
Dec 13 21:42:47 kernel: 2 locks held by IndexedDB #3/10926:
Dec 13 21:42:47 kernel:  #0: ffff971601d0f498
(sb_writers#14){.+.+}-{0:0}, at: do_unlinkat+0x95/0x2b0
Dec 13 21:42:47 kernel:  #1: ffff9715d4d73828
(&type->i_mutex_dir_key#6/1){+.+.}-{3:3}, at: do_unlinkat+0x106/0x2b0
Dec 13 21:42:47 kernel: 2 locks held by IndexedDB #4/10927:
Dec 13 21:42:47 kernel:  #0: ffff971601d0f498
(sb_writers#14){.+.+}-{0:0}, at: do_unlinkat+0x95/0x2b0
Dec 13 21:42:47 kernel:  #1: ffff9715d4d73828
(&type->i_mutex_dir_key#6/1){+.+.}-{3:3}, at: do_unlinkat+0x106/0x2b0
Dec 13 21:42:47 kernel: 4 locks held by Backgro~Pool #2/10932:
Dec 13 21:42:47 kernel:  #0: ffff971601d0f498
(sb_writers#14){.+.+}-{0:0}, at: do_unlinkat+0x95/0x2b0
Dec 13 21:42:47 kernel:  #1: ffff971506b34218
(&type->i_mutex_dir_key#6/1){+.+.}-{3:3}, at: do_unlinkat+0x106/0x2b0
Dec 13 21:42:47 kernel:  #2: ffff971506b35fe8
(&sb->s_type->i_mutex_key#14){++++}-{3:3}, at: vfs_unlink+0x48/0x230
Dec 13 21:42:47 kernel:  #3: ffff971601d0f6b8
(sb_internal){.+.+}-{0:0}, at: btrfs_unlink+0x32/0x110
Dec 13 21:42:47 kernel: 1 lock held by SaveScripts/11059:
Dec 13 21:42:47 kernel:  #0: ffff97153534dfe8
(&type->i_mutex_dir_key#6){++++}-{3:3}, at: walk_component+0x10c/0x190
Dec 13 21:42:47 kernel: 1 lock held by Classif~ Update/11066:
Dec 13 21:42:47 kernel:  #0: ffff971601d0f6b8
(sb_internal){.+.+}-{0:0}, at: btrfs_sync_file+0x327/0x5a0
Dec 13 21:42:47 kernel: 1 lock held by mozStorage #5/11358:
Dec 13 21:42:47 kernel:  #0: ffff97156085e9d8
(&type->i_mutex_dir_key#6){++++}-{3:3}, at: walk_component+0x10c/0x190
Dec 13 21:42:47 kernel: 3 locks held by gvfsd-metadata/11304:
Dec 13 21:42:47 kernel:  #0: ffff971601d0f498
(sb_writers#14){.+.+}-{0:0}, at: path_openat+0x9fb/0xa20
Dec 13 21:42:47 kernel:  #1: ffff97155e064c08
(&type->i_mutex_dir_key#6){++++}-{3:3}, at: path_openat+0x296/0xa20
Dec 13 21:42:47 kernel:  #2: ffff971601d0f6b8
(sb_internal){.+.+}-{0:0}, at: btrfs_create+0x4c/0x200
Dec 13 21:42:47 kernel:
Dec 13 21:42:47 kernel: =============================================
Dec 13 21:44:50 kernel: BTRFS critical (device dm-0): corrupt leaf:
root=18446744073709551610 block=118444032 slot=21, bad key order, prev
(704687 84 4146773349) current (704687 84 1063561078)
Dec 13 21:44:50 kernel: BTRFS info (device dm-0): leaf 118444032 gen
91449 total ptrs 39 free space 546 owner 18446744073709551610
Dec 13 21:44:50 kernel:         item 0 key (704687 1 0) itemoff 3835
itemsize 160
Dec 13 21:44:50 kernel:                 inode generation 35532 size
1026 mode 40755
Dec 13 21:44:50 kernel:         item 1 key (704687 12 704685) itemoff
3822 itemsize 13
Dec 13 21:44:50 kernel:         item 2 key (704687 24 3817753667)
itemoff 3736 itemsize 86
Dec 13 21:44:50 kernel:         item 3 key (704687 60 0) itemoff 3728 itemsize 8
Dec 13 21:44:50 kernel:         item 4 key (704687 72 0) itemoff 3720 itemsize 8
Dec 13 21:44:50 kernel:         item 5 key (704687 84 140445108)
itemoff 3666 itemsize 54
Dec 13 21:44:50 kernel:                 dir oid 704793 type 1
Dec 13 21:44:50 kernel:         item 6 key (704687 84 298800632)
itemoff 3599 itemsize 67
Dec 13 21:44:50 kernel:                 dir oid 707849 type 2
Dec 13 21:44:50 kernel:         item 7 key (704687 84 476147658)
itemoff 3532 itemsize 67
Dec 13 21:44:50 kernel:                 dir oid 707901 type 2
Dec 13 21:44:50 kernel:         item 8 key (704687 84 633818382)
itemoff 3471 itemsize 61
Dec 13 21:44:50 kernel:                 dir oid 704694 type 2
Dec 13 21:44:50 kernel:         item 9 key (704687 84 654256665)
itemoff 3403 itemsize 68
Dec 13 21:44:50 kernel:                 dir oid 707841 type 1
Dec 13 21:44:50 kernel:         item 10 key (704687 84 995843418)
itemoff 3331 itemsize 72
Dec 13 21:44:50 kernel:                 dir oid 2167736 type 1
Dec 13 21:44:50 kernel:         item 11 key (704687 84 1063561078)
itemoff 3278 itemsize 53
Dec 13 21:44:50 kernel:                 dir oid 704799 type 2
Dec 13 21:44:50 kernel:         item 12 key (704687 84 1101156010)
itemoff 3225 itemsize 53
Dec 13 21:44:50 kernel:                 dir oid 704696 type 1
Dec 13 21:44:50 kernel:         item 13 key (704687 84 2521936574)
itemoff 3173 itemsize 52
Dec 13 21:44:50 kernel:                 dir oid 704704 type 2
Dec 13 21:44:50 kernel:         item 14 key (704687 84 2618368432)
itemoff 3112 itemsize 61
Dec 13 21:44:50 kernel:                 dir oid 704738 type 1
Dec 13 21:44:50 kernel:         item 15 key (704687 84 2676316190)
itemoff 3046 itemsize 66
Dec 13 21:44:50 kernel:                 dir oid 2167729 type 1
Dec 13 21:44:50 kernel:         item 16 key (704687 84 3319104192)
itemoff 2986 itemsize 60
Dec 13 21:44:50 kernel:                 dir oid 704745 type 2
Dec 13 21:44:50 kernel:         item 17 key (704687 84 3908046265)
itemoff 2929 itemsize 57
Dec 13 21:44:50 kernel:                 dir oid 2167734 type 1
Dec 13 21:44:50 kernel:         item 18 key (704687 84 3945713089)
itemoff 2857 itemsize 72
Dec 13 21:44:50 kernel:                 dir oid 2167730 type 1
Dec 13 21:44:50 kernel:         item 19 key (704687 84 4077169308)
itemoff 2795 itemsize 62
Dec 13 21:44:50 kernel:                 dir oid 704688 type 1
Dec 13 21:44:50 kernel:         item 20 key (704687 84 4146773349)
itemoff 2727 itemsize 68
Dec 13 21:44:50 kernel:                 dir oid 707892 type 1
Dec 13 21:44:50 kernel:         item 21 key (704687 84 1063561078)
itemoff 2674 itemsize 53
Dec 13 21:44:50 kernel:                 dir oid 704799 type 2
Dec 13 21:44:50 kernel:         item 22 key (704687 96 2) itemoff 2612
itemsize 62
Dec 13 21:44:50 kernel:         item 23 key (704687 96 6) itemoff 2551
itemsize 61
Dec 13 21:44:50 kernel:         item 24 key (704687 96 7) itemoff 2498
itemsize 53
Dec 13 21:44:50 kernel:         item 25 key (704687 96 12) itemoff
2446 itemsize 52
Dec 13 21:44:50 kernel:         item 26 key (704687 96 14) itemoff
2385 itemsize 61
Dec 13 21:44:50 kernel:         item 27 key (704687 96 18) itemoff
2325 itemsize 60
Dec 13 21:44:50 kernel:         item 28 key (704687 96 24) itemoff
2271 itemsize 54
Dec 13 21:44:50 kernel:         item 29 key (704687 96 28) itemoff
2218 itemsize 53
Dec 13 21:44:50 kernel:         item 30 key (704687 96 62) itemoff
2150 itemsize 68
Dec 13 21:44:50 kernel:         item 31 key (704687 96 66) itemoff
2083 itemsize 67
Dec 13 21:44:50 kernel:         item 32 key (704687 96 75) itemoff
2015 itemsize 68
Dec 13 21:44:50 kernel:         item 33 key (704687 96 79) itemoff
1948 itemsize 67
Dec 13 21:44:50 kernel:         item 34 key (704687 96 82) itemoff
1882 itemsize 66
Dec 13 21:44:50 kernel:         item 35 key (704687 96 83) itemoff
1810 itemsize 72
Dec 13 21:44:50 kernel:         item 36 key (704687 96 85) itemoff
1753 itemsize 57
Dec 13 21:44:50 kernel:         item 37 key (704687 96 87) itemoff
1681 itemsize 72
Dec 13 21:44:50 kernel:         item 38 key (704694 1 0) itemoff 1521
itemsize 160
Dec 13 21:44:50 kernel:                 inode generation 35534 size 30
mode 40755
Dec 13 21:44:50 kernel: BTRFS error (device dm-0): block=118444032
write time tree block corruption detected
Dec 13 21:44:50 kernel: BTRFS error (device dm-0): parent transid
verify failed on 118444032 wanted 91449 found 91446
Dec 13 21:44:50 kernel: BTRFS error (device dm-0): parent transid
verify failed on 118444032 wanted 91449 found 91446
Dec 13 21:44:50 kernel: BTRFS: error (device dm-0) in
free_log_tree:3434: errno=-5 IO failure
Dec 13 21:44:50 kernel: BTRFS info (device dm-0): forced readonly
Dec 13 21:44:50 kernel: BTRFS warning (device dm-0): Skipping commit
of aborted transaction.
Dec 13 21:44:50 kernel: BTRFS: error (device dm-0) in
cleanup_transaction:1945: errno=-5 IO failure



-- 
Chris Murphy
