Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8E14D6C1D
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Mar 2022 03:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiCLCtm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Mar 2022 21:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiCLCtl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Mar 2022 21:49:41 -0500
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 026E2114774
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 18:48:35 -0800 (PST)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 822612502C0; Fri, 11 Mar 2022 21:48:35 -0500 (EST)
Date:   Fri, 11 Mar 2022 21:48:35 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Pierre Abbat <phma@bezitopo.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Computer stalled, apparently from filesystem corruption
Message-ID: <YiwKA1LTrX56dd9T@hungrycats.org>
References: <12976593.dW097sEU6C@puma>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12976593.dW097sEU6C@puma>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 10, 2022 at 05:56:35AM -0500, Pierre Abbat wrote:
> Sending again, with less syslog. I wrote this on the 8th.
> 
> My computer was up for several months. On Saturday I came home from church and 
> found it unresponsive except that I could move the mouse cursor and make the 
> keyboard lights blink. I tried to shell in from another computer; I got a 
> connection, but not a login prompt. I rebooted it with the power button and 
> copied the syslog file that contains the incident. I saw "btrfs" several times 
> in the section of log.
> 
> This morning, I was rsyncing some files and the same thing happened, except 
> that the screen was stuck in the middle of flipping through windows with alt-
> tab and I was able to switch to a console, log in as root, and reboot. Again I 
> found "btrfs" in syslog.
> 
> Running dmesg produces too much information. Here is the rest of the info:
> root@puma:/home/phma# uname -a
> Linux puma 5.15.15-76051515-generic #202201160435~1642693824~20.04~97db1bb-
> Ubuntu SMP Fri Jan 21 14: x86_64 x86_64 x86_64 GNU/Linux
> root@puma:/home/phma# btrfs --version
> btrfs-progs v5.4.1 
> root@puma:/home/phma# btrfs fi show
> Label: none  uuid: d0137494-fe35-488f-b0da-fdbe075b8832
>         Total devices 1 FS bytes used 72.88GiB
>         devid    1 size 673.51GiB used 75.02GiB path /dev/mapper/concolor-big
> 
> Label: none  uuid: 174643ac-cb44-46a9-a5a4-5fb5e9a4e79f
>         Total devices 1 FS bytes used 48.84GiB
>         devid    1 size 100.00GiB used 57.02GiB path /dev/mapper/concolor-
> rootcopy
> 
> Label: none  uuid: 155a20c7-2264-4923-b082-288a3c146384
>         Total devices 1 FS bytes used 101.49GiB
>         devid    1 size 158.00GiB used 134.02GiB path /dev/mapper/concolor-
> cougar
> 
> Label: none  uuid: 10c61748-efe7-4b9c-b1f7-041dc45d894b
>         Total devices 1 FS bytes used 39.38GiB
>         devid    1 size 127.98GiB used 53.04GiB path /dev/mapper/cougar-crypt
> 
> Label: none  uuid: 1f5a6f23-a7ef-46c6-92b1-84fc2f684931
>         Total devices 1 FS bytes used 92.58GiB
>         devid    1 size 158.00GiB used 131.00GiB path /dev/mapper/puma-cougar
> 
> root@puma:/home/phma# btrfs fi df /big
> Data, single: total=74.01GiB, used=72.78GiB
> System, single: total=4.00MiB, used=16.00KiB
> Metadata, single: total=1.01GiB, used=101.59MiB
> GlobalReserve, single: total=92.41MiB, used=0.00B
> root@puma:/home/phma# btrfs fi df /rootcopy
> Data, single: total=55.01GiB, used=47.68GiB
> System, single: total=4.00MiB, used=16.00KiB
> Metadata, single: total=2.01GiB, used=1.16GiB
> GlobalReserve, single: total=113.17MiB, used=0.00B
> root@puma:/home/phma# btrfs fi df /home
> Data, single: total=132.01GiB, used=100.23GiB
> System, single: total=4.00MiB, used=16.00KiB
> Metadata, single: total=2.01GiB, used=1.26GiB
> GlobalReserve, single: total=321.31MiB, used=0.00B
> root@puma:/home/phma# btrfs fi df /crypt
> Data, single: total=52.01GiB, used=39.29GiB
> System, single: total=32.00MiB, used=16.00KiB
> Metadata, single: total=1.00GiB, used=91.14MiB
> GlobalReserve, single: total=45.91MiB, used=0.00B
> root@puma:/home/phma# btrfs fi df /olv
> Data, single: total=52.01GiB, used=39.29GiB
> System, single: total=32.00MiB, used=16.00KiB
> Metadata, single: total=1.00GiB, used=91.14MiB
> GlobalReserve, single: total=45.91MiB, used=0.00B
> root@puma:/home/phma# btrfs fi df /backup
> Data, single: total=52.01GiB, used=39.29GiB
> System, single: total=32.00MiB, used=16.00KiB
> Metadata, single: total=1.00GiB, used=91.14MiB
> GlobalReserve, single: total=45.91MiB, used=0.00B
> 
> The kernel I was running on Saturday may be older.
> 
> Here are some excerpts from syslog:
> Mar  5 08:31:52 puma kernel: [10359910.035946] INFO: task Indexed~ #56145:1182901 blocked for more than 120 seconds.
> Mar  5 08:31:52 puma kernel: [10359910.035948]       Tainted: P           OE     5.13.0-7614-generic #14~1631647151~20.04~930e87c-Ubuntu
> Mar  5 08:31:52 puma kernel: [10359910.035949] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> Mar  5 08:31:52 puma kernel: [10359910.035950] task:Indexed~ #56145 state:D stack:    0 pid:1182901 ppid:     1 flags:0x00000000
> Mar  5 08:31:52 puma kernel: [10359910.035953] Call Trace:
> Mar  5 08:31:52 puma kernel: [10359910.035954]  __schedule+0x2ee/0x900
> Mar  5 08:31:52 puma kernel: [10359910.035956]  ? try_to_unlazy+0x55/0x90
> Mar  5 08:31:52 puma kernel: [10359910.035959]  schedule+0x4f/0xc0
> Mar  5 08:31:52 puma kernel: [10359910.035964]  wait_current_trans+0xd6/0x140 [btrfs]
> Mar  5 08:31:52 puma kernel: [10359910.036043]  ? wait_woken+0x80/0x80
> Mar  5 08:31:52 puma kernel: [10359910.036047]  start_transaction+0x4bb/0x5a0 [btrfs]
> Mar  5 08:31:52 puma kernel: [10359910.036081]  btrfs_start_transaction_fallback_global_rsv+0x1b/0x20 [btrfs]
> Mar  5 08:31:52 puma kernel: [10359910.036113]  btrfs_unlink+0x30/0xe0 [btrfs]
> Mar  5 08:31:52 puma kernel: [10359910.036145]  vfs_unlink+0x114/0x200
> Mar  5 08:31:52 puma kernel: [10359910.036147]  do_unlinkat+0x1a2/0x2d0
> Mar  5 08:31:52 puma kernel: [10359910.036150]  __x64_sys_unlink+0x23/0x30
> Mar  5 08:31:52 puma kernel: [10359910.036153]  do_syscall_64+0x61/0xb0
> Mar  5 08:31:52 puma kernel: [10359910.036155]  ? do_syscall_64+0x6e/0xb0
> Mar  5 08:31:52 puma kernel: [10359910.036157]  ? do_syscall_64+0x6e/0xb0
> Mar  5 08:31:52 puma kernel: [10359910.036159]  ? do_syscall_64+0x6e/0xb0
> Mar  5 08:31:52 puma kernel: [10359910.036160]  ? do_syscall_64+0x6e/0xb0
> Mar  5 08:31:52 puma kernel: [10359910.036162]  ? do_syscall_64+0x6e/0xb0
> Mar  5 08:31:52 puma kernel: [10359910.036164]  ? asm_sysvec_apic_timer_interrupt+0xa/0x20
> Mar  5 08:31:52 puma kernel: [10359910.036166]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> Mar  5 08:31:52 puma kernel: [10359910.036167] RIP: 0033:0x7fc30923de3b
> Mar  5 08:31:52 puma kernel: [10359910.036169] RSP: 002b:00007fc2c2bbd4d8 EFLAGS: 00000202 ORIG_RAX: 0000000000000057
> Mar  5 08:31:52 puma kernel: [10359910.036170] RAX: ffffffffffffffda RBX: 00007fc274b75271 RCX: 00007fc30923de3b
> Mar  5 08:31:52 puma kernel: [10359910.036171] RDX: 0000000000000000 RSI: 00007fc274b75271 RDI: 00007fc274b75271
> Mar  5 08:31:52 puma kernel: [10359910.036173] RBP: 0000000000000000 R08: 0000000000000000 R09: 00007fc272f01748
> Mar  5 08:31:52 puma kernel: [10359910.036174] R10: 0000000000000000 R11: 0000000000000202 R12: 00007fc274b75271
> Mar  5 08:31:52 puma kernel: [10359910.036175] R13: 00007fc2734b4400 R14: 0000000000000000 R15: 00007fc3085bd578
> 
> Mar  8 04:36:29 puma kernel: [39151.885472] INFO: task tracker-store:53596 blocked for more than 120 seconds.
> Mar  8 04:36:29 puma kernel: [39151.885492]       Tainted: G           OE     5.15.15-76051515-generic #202201160435~1642693824~20.04~97db1bb-Ubuntu
> Mar  8 04:36:29 puma kernel: [39151.885494] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> Mar  8 04:36:29 puma kernel: [39151.885496] task:tracker-store   state:D stack:    0 pid:53596 ppid:  3662 flags:0x00000000
> Mar  8 04:36:29 puma kernel: [39151.885503] Call Trace:
> Mar  8 04:36:29 puma kernel: [39151.885508]  <TASK>
> Mar  8 04:36:29 puma kernel: [39151.885518]  __schedule+0x2cd/0x890
> Mar  8 04:36:29 puma kernel: [39151.885530]  ? __cond_resched+0x19/0x30
> Mar  8 04:36:29 puma kernel: [39151.885533]  schedule+0x4e/0xb0
> Mar  8 04:36:29 puma kernel: [39151.885539]  btrfs_sync_log+0x178/0xef0 [btrfs]
> Mar  8 04:36:29 puma kernel: [39151.885704]  ? __raw_callee_save___native_queued_spin_unlock+0x15/0x23
> Mar  8 04:36:29 puma kernel: [39151.885717]  ? release_extent_buffer+0xbb/0xe0 [btrfs]
> Mar  8 04:36:29 puma kernel: [39151.885753]  ? wait_woken+0x60/0x60
> Mar  8 04:36:29 puma kernel: [39151.885758]  ? btrfs_free_path+0x27/0x30 [btrfs]
> Mar  8 04:36:29 puma kernel: [39151.885787]  ? dput+0x62/0x320
> Mar  8 04:36:29 puma kernel: [39151.885794]  ? log_all_new_ancestors+0x3bc/0x470 [btrfs]
> Mar  8 04:36:29 puma kernel: [39151.885841]  ? btrfs_log_inode_parent+0x2db/0x890 [btrfs]
> Mar  8 04:36:29 puma kernel: [39151.885872]  ? join_transaction+0x135/0x4c0 [btrfs]
> Mar  8 04:36:29 puma kernel: [39151.885900]  ? start_transaction+0xd5/0x5b0 [btrfs]
> Mar  8 04:36:29 puma kernel: [39151.885931]  ? dput+0x62/0x320
> Mar  8 04:36:29 puma kernel: [39151.885933]  btrfs_sync_file+0x33f/0x460 [btrfs]
> Mar  8 04:36:29 puma kernel: [39151.885961]  vfs_fsync_range+0x49/0x80
> Mar  8 04:36:29 puma kernel: [39151.885965]  do_fsync+0x3d/0x70
> Mar  8 04:36:29 puma kernel: [39151.885967]  __x64_sys_fsync+0x14/0x20
> Mar  8 04:36:29 puma kernel: [39151.885968]  do_syscall_64+0x5c/0xc0
> Mar  8 04:36:29 puma kernel: [39151.885971]  ? do_sys_openat2+0x1d3/0x320
> Mar  8 04:36:29 puma kernel: [39151.885975]  ? exit_to_user_mode_prepare+0x3d/0x1c0
> Mar  8 04:36:29 puma kernel: [39151.885980]  ? syscall_exit_to_user_mode+0x27/0x50
> Mar  8 04:36:29 puma kernel: [39151.885983]  ? __x64_sys_openat+0x20/0x30
> Mar  8 04:36:29 puma kernel: [39151.885986]  ? do_syscall_64+0x69/0xc0
> Mar  8 04:36:29 puma kernel: [39151.885987]  ? do_syscall_64+0x69/0xc0
> Mar  8 04:36:29 puma kernel: [39151.885988]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> Mar  8 04:36:29 puma kernel: [39151.885993] RIP: 0033:0x7f0eb970832b
> Mar  8 04:36:29 puma kernel: [39151.885995] RSP: 002b:00007ffde79e29b0 EFLAGS: 00000293 ORIG_RAX: 000000000000004a
> Mar  8 04:36:29 puma kernel: [39151.885997] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0eb970832b
> Mar  8 04:36:29 puma kernel: [39151.885999] RDX: 0000000000101441 RSI: 0000564c61177b50 RDI: 0000000000000008
> Mar  8 04:36:29 puma kernel: [39151.886000] RBP: 0000000000000008 R08: 0000000000000000 R09: 0000000000000001
> Mar  8 04:36:29 puma kernel: [39151.886001] R10: 00000000000001b0 R11: 0000000000000293 R12: 0000564c61176e50
> Mar  8 04:36:29 puma kernel: [39151.886002] R13: 00007ffde79e2a00 R14: 00007ffde79e2be4 R15: 0000000000000000
> Mar  8 04:36:29 puma kernel: [39151.886005]  </TASK>
> 
> Please copy me, I'm not on the mailing list.

There's no indication of corruption in those logs.  Above the kernel
is complaining that it's taking too long to finish transactions, which
could be a btrfs problem, or a hardware problem, or even simply a large
filesystem running normally on very slow disks.  Not enough information
to tell.

When posting logs, extract all lines with 'btrfs' on them, plus context
lines, e.g.

	grep -B9 -i btrfs /var/log/kern.log

or

	dmesg | grep -B9 -i btrfs

If you can reproduce the hang, enable sysrq and do Alt-SysRq-W when it
hangs (or run

	echo w > /proc/sysrq-trigger

from a command line).  This will provide stack traces of all blocked
processes so we can see what the transaction is waiting for.

> Pierre
> -- 
> The gostak pelled at the fostin lutt for darfs for her martle plave.
> The darfs had smibbed, the lutt was thale, and the pilter had nothing snave.
> 
> 
> 
