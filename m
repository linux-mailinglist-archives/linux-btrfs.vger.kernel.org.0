Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF7F4D16F5
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Mar 2022 13:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346712AbiCHMNF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Mar 2022 07:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346711AbiCHMNE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Mar 2022 07:13:04 -0500
X-Greylist: delayed 403 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Mar 2022 04:12:02 PST
Received: from marozi.bezitopo.org (bezitopo.org [45.55.162.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 352133F88E
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Mar 2022 04:12:01 -0800 (PST)
Received: from puma (unknown [IPv6:2001:5b0:210b:8f48:791b:849d:7db1:84dd])
        by marozi.bezitopo.org (Postfix) with ESMTPA id 782565FF4C
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Mar 2022 07:04:45 -0500 (EST)
Received: from puma.localnet (localhost [127.0.0.1])
        by puma (Postfix) with ESMTP id 64610483C85
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Mar 2022 07:04:41 -0500 (EST)
From:   Pierre Abbat <phma@bezitopo.org>
To:     linux-btrfs@vger.kernel.org
Subject: Computer stalled, apparently from filesystem corruption
Date:   Tue, 08 Mar 2022 07:04:41 -0500
Message-ID: <2823742.e9J7NaK4W3@puma>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart3163476.aeNJFYEL58"
Content-Transfer-Encoding: 7Bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart3163476.aeNJFYEL58
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

My computer was up for several months. On Saturday I came home from church and 
found it unresponsive except that I could move the mouse cursor and make the 
keyboard lights blink. I tried to shell in from another computer; I got a 
connection, but not a login prompt. I rebooted it with the power button and 
copied the syslog file that contains the incident. I saw "btrfs" several times 
in the section of log.

This morning, I was rsyncing some files and the same thing happened, except 
that the screen was stuck in the middle of flipping through windows with alt-
tab and I was able to switch to a console, log in as root, and reboot. Again I 
found "btrfs" in syslog.

Running dmesg produces too much information. Here is the rest of the info:
root@puma:/home/phma# uname -a
Linux puma 5.15.15-76051515-generic #202201160435~1642693824~20.04~97db1bb-
Ubuntu SMP Fri Jan 21 14: x86_64 x86_64 x86_64 GNU/Linux
root@puma:/home/phma# btrfs --version
btrfs-progs v5.4.1 
root@puma:/home/phma# btrfs fi show
Label: none  uuid: d0137494-fe35-488f-b0da-fdbe075b8832
        Total devices 1 FS bytes used 72.88GiB
        devid    1 size 673.51GiB used 75.02GiB path /dev/mapper/concolor-big

Label: none  uuid: 174643ac-cb44-46a9-a5a4-5fb5e9a4e79f
        Total devices 1 FS bytes used 48.84GiB
        devid    1 size 100.00GiB used 57.02GiB path /dev/mapper/concolor-
rootcopy

Label: none  uuid: 155a20c7-2264-4923-b082-288a3c146384
        Total devices 1 FS bytes used 101.49GiB
        devid    1 size 158.00GiB used 134.02GiB path /dev/mapper/concolor-
cougar

Label: none  uuid: 10c61748-efe7-4b9c-b1f7-041dc45d894b
        Total devices 1 FS bytes used 39.38GiB
        devid    1 size 127.98GiB used 53.04GiB path /dev/mapper/cougar-crypt

Label: none  uuid: 1f5a6f23-a7ef-46c6-92b1-84fc2f684931
        Total devices 1 FS bytes used 92.58GiB
        devid    1 size 158.00GiB used 131.00GiB path /dev/mapper/puma-cougar

root@puma:/home/phma# btrfs fi df /big
Data, single: total=74.01GiB, used=72.78GiB
System, single: total=4.00MiB, used=16.00KiB
Metadata, single: total=1.01GiB, used=101.59MiB
GlobalReserve, single: total=92.41MiB, used=0.00B
root@puma:/home/phma# btrfs fi df /rootcopy
Data, single: total=55.01GiB, used=47.68GiB
System, single: total=4.00MiB, used=16.00KiB
Metadata, single: total=2.01GiB, used=1.16GiB
GlobalReserve, single: total=113.17MiB, used=0.00B
root@puma:/home/phma# btrfs fi df /home
Data, single: total=132.01GiB, used=100.23GiB
System, single: total=4.00MiB, used=16.00KiB
Metadata, single: total=2.01GiB, used=1.26GiB
GlobalReserve, single: total=321.31MiB, used=0.00B
root@puma:/home/phma# btrfs fi df /crypt
Data, single: total=52.01GiB, used=39.29GiB
System, single: total=32.00MiB, used=16.00KiB
Metadata, single: total=1.00GiB, used=91.14MiB
GlobalReserve, single: total=45.91MiB, used=0.00B
root@puma:/home/phma# btrfs fi df /olv
Data, single: total=52.01GiB, used=39.29GiB
System, single: total=32.00MiB, used=16.00KiB
Metadata, single: total=1.00GiB, used=91.14MiB
GlobalReserve, single: total=45.91MiB, used=0.00B
root@puma:/home/phma# btrfs fi df /backup
Data, single: total=52.01GiB, used=39.29GiB
System, single: total=32.00MiB, used=16.00KiB
Metadata, single: total=1.00GiB, used=91.14MiB
GlobalReserve, single: total=45.91MiB, used=0.00B

The kernel I was running on Saturday may be older.

Please copy me, I'm not on the mailing list.

Pierre
-- 
The gostak pelled at the fostin lutt for darfs for her martle plave.
The darfs had smibbed, the lutt was thale, and the pilter had nothing snave.

--nextPart3163476.aeNJFYEL58
Content-Disposition: attachment; filename="syslog-excerpts"
Content-Transfer-Encoding: 7Bit
Content-Type: multipart/mixed; boundary="nextPart3169531.44csPzL39Z"

--nextPart3169531.44csPzL39Z
Content-Type: multipart/mixed; boundary="nextPart1962993.oMNUckLgyt"
Content-Transfer-Encoding: 7Bit

--nextPart1962993.oMNUckLgyt
Content-Type: text/plain
Content-Transfer-Encoding: 7Bit

Mar  5 08:25:01 puma CRON[1182563]: (root) CMD (command -v debian-sa1 > /dev/null && debian-sa1 1 1)
Mar  5 08:30:52 puma pulseaudio[2302]: q overrun, queuing locally
Mar  5 08:31:52 puma kernel: [10359910.034733] INFO: task ThreadPoolForeg:1181536 blocked for more than 120 seconds.
Mar  5 08:31:52 puma kernel: [10359910.034762]       Tainted: P           OE     5.13.0-7614-generic #14~1631647151~20.04~930e87c-Ubuntu
Mar  5 08:31:52 puma kernel: [10359910.034766] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Mar  5 08:31:52 puma kernel: [10359910.034769] task:ThreadPoolForeg state:D stack:    0 pid:1181536 ppid:  5453 flags:0x00000000
Mar  5 08:31:52 puma kernel: [10359910.034778] Call Trace:
Mar  5 08:31:52 puma kernel: [10359910.034793]  __schedule+0x2ee/0x900
Mar  5 08:31:52 puma kernel: [10359910.034813]  schedule+0x4f/0xc0
Mar  5 08:31:52 puma kernel: [10359910.034816]  rwsem_down_write_slowpath+0x232/0x5f0
Mar  5 08:31:52 puma kernel: [10359910.034828]  down_write+0x41/0x50
Mar  5 08:31:52 puma kernel: [10359910.034834]  path_openat+0x278/0xc80
Mar  5 08:31:52 puma kernel: [10359910.034839]  ? __remove_hrtimer+0x3c/0x90
Mar  5 08:31:52 puma kernel: [10359910.034847]  ? hrtimer_try_to_cancel+0x85/0xf0
Mar  5 08:31:52 puma kernel: [10359910.034849]  ? hrtimer_cancel+0x15/0x20
Mar  5 08:31:52 puma kernel: [10359910.034851]  do_filp_open+0xa2/0x110
Mar  5 08:31:52 puma kernel: [10359910.034857]  ? __check_object_size+0x13f/0x150
Mar  5 08:31:52 puma kernel: [10359910.034865]  do_sys_openat2+0x241/0x310
Mar  5 08:31:52 puma kernel: [10359910.034870]  do_sys_open+0x46/0x80
Mar  5 08:31:52 puma kernel: [10359910.034873]  __x64_sys_openat+0x20/0x30
Mar  5 08:31:52 puma kernel: [10359910.034875]  do_syscall_64+0x61/0xb0
Mar  5 08:31:52 puma kernel: [10359910.034886]  ? syscall_exit_to_user_mode+0x27/0x50
Mar  5 08:31:52 puma kernel: [10359910.034891]  ? do_syscall_64+0x6e/0xb0
Mar  5 08:31:52 puma kernel: [10359910.034893]  ? syscall_exit_to_user_mode+0x27/0x50
Mar  5 08:31:52 puma kernel: [10359910.034896]  ? do_syscall_64+0x6e/0xb0
Mar  5 08:31:52 puma kernel: [10359910.034898]  ? asm_sysvec_apic_timer_interrupt+0xa/0x20
Mar  5 08:31:52 puma kernel: [10359910.034903]  entry_SYSCALL_64_after_hwframe+0x44/0xae
Mar  5 08:31:52 puma kernel: [10359910.034906] RIP: 0033:0x7f7a66acfad4
Mar  5 08:31:52 puma kernel: [10359910.034909] RSP: 002b:00007f7a52ffbfc0 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
Mar  5 08:31:52 puma kernel: [10359910.034915] RAX: ffffffffffffffda RBX: 00007f7a52ffc048 RCX: 00007f7a66acfad4
Mar  5 08:31:52 puma kernel: [10359910.034917] RDX: 00000000000000c2 RSI: 00007f7a580e6040 RDI: 00000000ffffff9c
Mar  5 08:31:52 puma kernel: [10359910.034918] RBP: 00007f7a580e6040 R08: 0000000000000000 R09: 00000000009e14ca
Mar  5 08:31:52 puma kernel: [10359910.034922] R10: 0000000000000180 R11: 0000000000000293 R12: 00000000000000c2
Mar  5 08:31:52 puma kernel: [10359910.034925] R13: 00007f7a52ffc100 R14: 00007f7a5818ef90 R15: 0000000000008062
Mar  5 08:31:52 puma kernel: [10359910.034932] INFO: task ThreadPoolForeg:1182879 blocked for more than 120 seconds.
Mar  5 08:31:52 puma kernel: [10359910.034936]       Tainted: P           OE     5.13.0-7614-generic #14~1631647151~20.04~930e87c-Ubuntu
Mar  5 08:31:52 puma kernel: [10359910.034938] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Mar  5 08:31:52 puma kernel: [10359910.034940] task:ThreadPoolForeg state:D stack:    0 pid:1182879 ppid:  5453 flags:0x00000000
Mar  5 08:31:52 puma kernel: [10359910.034945] Call Trace:
Mar  5 08:31:52 puma kernel: [10359910.034948]  __schedule+0x2ee/0x900
Mar  5 08:31:52 puma kernel: [10359910.034954]  schedule+0x4f/0xc0
Mar  5 08:31:52 puma kernel: [10359910.034956]  rwsem_down_write_slowpath+0x232/0x5f0
Mar  5 08:31:52 puma kernel: [10359910.034960]  down_write+0x41/0x50
Mar  5 08:31:52 puma kernel: [10359910.034962]  path_openat+0x278/0xc80
Mar  5 08:31:52 puma kernel: [10359910.034965]  ? enqueue_task_fair+0xfb/0x5c0
Mar  5 08:31:52 puma kernel: [10359910.034974]  ? check_preempt_curr+0x34/0x70
Mar  5 08:31:52 puma kernel: [10359910.034978]  do_filp_open+0xa2/0x110
Mar  5 08:31:52 puma kernel: [10359910.034981]  ? __check_object_size+0x13f/0x150
Mar  5 08:31:52 puma kernel: [10359910.034984]  do_sys_openat2+0x241/0x310
Mar  5 08:31:52 puma kernel: [10359910.034987]  do_sys_open+0x46/0x80
Mar  5 08:31:52 puma kernel: [10359910.034989]  __x64_sys_openat+0x20/0x30
Mar  5 08:31:52 puma kernel: [10359910.034992]  do_syscall_64+0x61/0xb0
Mar  5 08:31:52 puma kernel: [10359910.034995]  ? syscall_exit_to_user_mode+0x27/0x50
Mar  5 08:31:52 puma kernel: [10359910.034998]  entry_SYSCALL_64_after_hwframe+0x44/0xae
Mar  5 08:31:52 puma kernel: [10359910.035000] RIP: 0033:0x7f7a66acfad4
Mar  5 08:31:52 puma kernel: [10359910.035003] RSP: 002b:00007f7a61168fc0 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
Mar  5 08:31:52 puma kernel: [10359910.035006] RAX: ffffffffffffffda RBX: 00007f7a61169048 RCX: 00007f7a66acfad4
Mar  5 08:31:52 puma kernel: [10359910.035007] RDX: 00000000000000c2 RSI: 00007f7a280652e0 RDI: 00000000ffffff9c
Mar  5 08:31:52 puma kernel: [10359910.035010] RBP: 00007f7a280652e0 R08: 0000000000000000 R09: 00000000009e14cb
Mar  5 08:31:52 puma kernel: [10359910.035011] R10: 0000000000000180 R11: 0000000000000293 R12: 00000000000000c2
Mar  5 08:31:52 puma kernel: [10359910.035012] R13: 00007f7a61169100 R14: 00007f7a28129da0 R15: 0000000000008062
Mar  5 08:31:52 puma kernel: [10359910.035016] INFO: task ThreadPoolForeg:1182917 blocked for more than 120 seconds.
Mar  5 08:31:52 puma kernel: [10359910.035018]       Tainted: P           OE     5.13.0-7614-generic #14~1631647151~20.04~930e87c-Ubuntu
Mar  5 08:31:52 puma kernel: [10359910.035020] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Mar  5 08:31:52 puma kernel: [10359910.035023] task:ThreadPoolForeg state:D stack:    0 pid:1182917 ppid:  5453 flags:0x00000000
Mar  5 08:31:52 puma kernel: [10359910.035028] Call Trace:
Mar  5 08:31:52 puma kernel: [10359910.035032]  __schedule+0x2ee/0x900
Mar  5 08:31:52 puma kernel: [10359910.035036]  schedule+0x4f/0xc0
Mar  5 08:31:52 puma kernel: [10359910.035038]  rwsem_down_write_slowpath+0x232/0x5f0
Mar  5 08:31:52 puma kernel: [10359910.035042]  down_write+0x41/0x50
Mar  5 08:31:52 puma kernel: [10359910.035044]  path_openat+0x278/0xc80
Mar  5 08:31:52 puma kernel: [10359910.035048]  do_filp_open+0xa2/0x110
Mar  5 08:31:52 puma kernel: [10359910.035051]  ? __check_object_size+0x13f/0x150
Mar  5 08:31:52 puma kernel: [10359910.035053]  ? alloc_fd+0x58/0x190
Mar  5 08:31:52 puma kernel: [10359910.035061]  do_sys_openat2+0x241/0x310
Mar  5 08:31:52 puma kernel: [10359910.035064]  do_sys_open+0x46/0x80
Mar  5 08:31:52 puma kernel: [10359910.035066]  __x64_sys_openat+0x20/0x30
Mar  5 08:31:52 puma kernel: [10359910.035069]  do_syscall_64+0x61/0xb0
Mar  5 08:31:52 puma kernel: [10359910.035072]  ? do_syscall_64+0x6e/0xb0
Mar  5 08:31:52 puma kernel: [10359910.035075]  ? syscall_exit_to_user_mode+0x27/0x50
Mar  5 08:31:52 puma kernel: [10359910.035079]  ? __x64_sys_write+0x1a/0x20
Mar  5 08:31:52 puma kernel: [10359910.035082]  ? do_syscall_64+0x6e/0xb0
Mar  5 08:31:52 puma kernel: [10359910.035084]  ? irqentry_exit+0x19/0x30
Mar  5 08:31:52 puma kernel: [10359910.035087]  ? sysvec_apic_timer_interrupt+0x4e/0x90
Mar  5 08:31:52 puma kernel: [10359910.035089]  ? asm_sysvec_apic_timer_interrupt+0xa/0x20
Mar  5 08:31:52 puma kernel: [10359910.035093]  entry_SYSCALL_64_after_hwframe+0x44/0xae
Mar  5 08:31:52 puma kernel: [10359910.035095] RIP: 0033:0x7f7a66acfad4
Mar  5 08:31:52 puma kernel: [10359910.035096] RSP: 002b:00007f7a33ffdfc0 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
Mar  5 08:31:52 puma kernel: [10359910.035099] RAX: ffffffffffffffda RBX: 00007f7a33ffe048 RCX: 00007f7a66acfad4
Mar  5 08:31:52 puma kernel: [10359910.035100] RDX: 00000000000000c2 RSI: 00007f7a58219270 RDI: 00000000ffffff9c
Mar  5 08:31:52 puma kernel: [10359910.035102] RBP: 00007f7a58219270 R08: 0000000000000000 R09: 00000000009e14cd
Mar  5 08:31:52 puma kernel: [10359910.035102] R10: 0000000000000180 R11: 0000000000000293 R12: 00000000000000c2
Mar  5 08:31:52 puma kernel: [10359910.035103] R13: 00007f7a33ffe100 R14: 00007f7a3c25e5d0 R15: 0000000000008062
Mar  5 08:31:52 puma kernel: [10359910.035106] INFO: task ThreadPoolForeg:1182918 blocked for more than 120 seconds.
Mar  5 08:31:52 puma kernel: [10359910.035108]       Tainted: P           OE     5.13.0-7614-generic #14~1631647151~20.04~930e87c-Ubuntu
Mar  5 08:31:52 puma kernel: [10359910.035112] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Mar  5 08:31:52 puma kernel: [10359910.035114] task:ThreadPoolForeg state:D stack:    0 pid:1182918 ppid:  5453 flags:0x00000000
Mar  5 08:31:52 puma kernel: [10359910.035118] Call Trace:
Mar  5 08:31:52 puma kernel: [10359910.035120]  __schedule+0x2ee/0x900
Mar  5 08:31:52 puma kernel: [10359910.035123]  schedule+0x4f/0xc0
Mar  5 08:31:52 puma kernel: [10359910.035125]  rwsem_down_write_slowpath+0x232/0x5f0
Mar  5 08:31:52 puma kernel: [10359910.035129]  down_write+0x41/0x50
Mar  5 08:31:52 puma kernel: [10359910.035131]  path_openat+0x278/0xc80
Mar  5 08:31:52 puma kernel: [10359910.035135]  do_filp_open+0xa2/0x110
Mar  5 08:31:52 puma kernel: [10359910.035139]  ? __check_object_size+0x13f/0x150
Mar  5 08:31:52 puma kernel: [10359910.035141]  ? alloc_fd+0x58/0x190
Mar  5 08:31:52 puma kernel: [10359910.035145]  do_sys_openat2+0x241/0x310
Mar  5 08:31:52 puma kernel: [10359910.035148]  do_sys_open+0x46/0x80
Mar  5 08:31:52 puma kernel: [10359910.035151]  __x64_sys_openat+0x20/0x30
Mar  5 08:31:52 puma kernel: [10359910.035154]  do_syscall_64+0x61/0xb0
Mar  5 08:31:52 puma kernel: [10359910.035157]  ? exit_to_user_mode_prepare+0x3d/0x1c0
Mar  5 08:31:52 puma kernel: [10359910.035163]  ? syscall_exit_to_user_mode+0x27/0x50
Mar  5 08:31:52 puma kernel: [10359910.035165]  ? __x64_sys_clone+0x25/0x30
Mar  5 08:31:52 puma kernel: [10359910.035174]  ? do_syscall_64+0x6e/0xb0
Mar  5 08:31:52 puma kernel: [10359910.035176]  ? exc_page_fault+0x8f/0x170
Mar  5 08:31:52 puma kernel: [10359910.035178]  ? asm_exc_page_fault+0x8/0x30
Mar  5 08:31:52 puma kernel: [10359910.035180]  entry_SYSCALL_64_after_hwframe+0x44/0xae
Mar  5 08:31:52 puma kernel: [10359910.035182] RIP: 0033:0x7f7a66acfad4
Mar  5 08:31:52 puma kernel: [10359910.035183] RSP: 002b:00007f7a53ffdfc0 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
Mar  5 08:31:52 puma kernel: [10359910.035185] RAX: ffffffffffffffda RBX: 00007f7a53ffe048 RCX: 00007f7a66acfad4
Mar  5 08:31:52 puma kernel: [10359910.035186] RDX: 00000000000000c2 RSI: 00007f7a34027170 RDI: 00000000ffffff9c
Mar  5 08:31:52 puma kernel: [10359910.035188] RBP: 00007f7a34027170 R08: 0000000000000000 R09: 00000000009e14cd
Mar  5 08:31:52 puma kernel: [10359910.035189] R10: 0000000000000180 R11: 0000000000000293 R12: 00000000000000c2
Mar  5 08:31:52 puma kernel: [10359910.035190] R13: 00007f7a53ffe100 R14: 00007f7a341564b0 R15: 0000000000008062
Mar  5 08:31:52 puma kernel: [10359910.035192] INFO: task ThreadPoolForeg:1182921 blocked for more than 120 seconds.
Mar  5 08:31:52 puma kernel: [10359910.035196]       Tainted: P           OE     5.13.0-7614-generic #14~1631647151~20.04~930e87c-Ubuntu
Mar  5 08:31:52 puma kernel: [10359910.035197] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Mar  5 08:31:52 puma kernel: [10359910.035200] task:ThreadPoolForeg state:D stack:    0 pid:1182921 ppid:  5453 flags:0x00000000
Mar  5 08:31:52 puma kernel: [10359910.035204] Call Trace:
Mar  5 08:31:52 puma kernel: [10359910.035207]  __schedule+0x2ee/0x900
Mar  5 08:31:52 puma kernel: [10359910.035212]  schedule+0x4f/0xc0
Mar  5 08:31:52 puma kernel: [10359910.035214]  rwsem_down_write_slowpath+0x232/0x5f0
Mar  5 08:31:52 puma kernel: [10359910.035218]  down_write+0x41/0x50
Mar  5 08:31:52 puma kernel: [10359910.035221]  path_openat+0x278/0xc80
Mar  5 08:31:52 puma kernel: [10359910.035224]  do_filp_open+0xa2/0x110
Mar  5 08:31:52 puma kernel: [10359910.035227]  ? __check_object_size+0x13f/0x150
Mar  5 08:31:52 puma kernel: [10359910.035230]  ? alloc_fd+0x58/0x190
Mar  5 08:31:52 puma kernel: [10359910.035232]  do_sys_openat2+0x241/0x310
Mar  5 08:31:52 puma kernel: [10359910.035235]  do_sys_open+0x46/0x80
Mar  5 08:31:52 puma kernel: [10359910.035237]  __x64_sys_openat+0x20/0x30
Mar  5 08:31:52 puma kernel: [10359910.035239]  do_syscall_64+0x61/0xb0
Mar  5 08:31:52 puma kernel: [10359910.035242]  ? __do_sys_clone+0x5d/0x80
Mar  5 08:31:52 puma kernel: [10359910.035245]  ? exit_to_user_mode_prepare+0x3d/0x1c0
Mar  5 08:31:52 puma kernel: [10359910.035248]  ? syscall_exit_to_user_mode+0x27/0x50
Mar  5 08:31:52 puma kernel: [10359910.035250]  ? __x64_sys_clone+0x25/0x30
Mar  5 08:31:52 puma kernel: [10359910.035252]  ? do_syscall_64+0x6e/0xb0
Mar  5 08:31:52 puma kernel: [10359910.035254]  entry_SYSCALL_64_after_hwframe+0x44/0xae
Mar  5 08:31:52 puma kernel: [10359910.035256] RIP: 0033:0x7f7a66acfad4
Mar  5 08:31:52 puma kernel: [10359910.035257] RSP: 002b:00007f7a527fafc0 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
Mar  5 08:31:52 puma kernel: [10359910.035260] RAX: ffffffffffffffda RBX: 00007f7a527fb048 RCX: 00007f7a66acfad4
Mar  5 08:31:52 puma kernel: [10359910.035261] RDX: 00000000000000c2 RSI: 00007f7a2c0023e0 RDI: 00000000ffffff9c
Mar  5 08:31:52 puma kernel: [10359910.035263] RBP: 00007f7a2c0023e0 R08: 0000000000000000 R09: 00000000009e14ce
Mar  5 08:31:52 puma kernel: [10359910.035265] R10: 0000000000000180 R11: 0000000000000293 R12: 00000000000000c2
Mar  5 08:31:52 puma kernel: [10359910.035266] R13: 00007f7a527fb100 R14: 00007f7a2c001d20 R15: 0000000000008062
Mar  5 08:31:52 puma kernel: [10359910.035271] INFO: task ThreadPoolForeg:1182923 blocked for more than 120 seconds.
Mar  5 08:31:52 puma kernel: [10359910.035272]       Tainted: P           OE     5.13.0-7614-generic #14~1631647151~20.04~930e87c-Ubuntu
Mar  5 08:31:52 puma kernel: [10359910.035274] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Mar  5 08:31:52 puma kernel: [10359910.035276] task:ThreadPoolForeg state:D stack:    0 pid:1182923 ppid:  5453 flags:0x00000000
Mar  5 08:31:52 puma kernel: [10359910.035278] Call Trace:
Mar  5 08:31:52 puma kernel: [10359910.035281]  __schedule+0x2ee/0x900
Mar  5 08:31:52 puma kernel: [10359910.035284]  schedule+0x4f/0xc0
Mar  5 08:31:52 puma kernel: [10359910.035286]  rwsem_down_write_slowpath+0x232/0x5f0
Mar  5 08:31:52 puma kernel: [10359910.035290]  down_write+0x41/0x50
Mar  5 08:31:52 puma kernel: [10359910.035292]  path_openat+0x278/0xc80
Mar  5 08:31:52 puma kernel: [10359910.035297]  do_filp_open+0xa2/0x110
Mar  5 08:31:52 puma kernel: [10359910.035301]  ? __check_object_size+0x13f/0x150
Mar  5 08:31:52 puma kernel: [10359910.035303]  ? alloc_fd+0x58/0x190
Mar  5 08:31:52 puma kernel: [10359910.035307]  do_sys_openat2+0x241/0x310
Mar  5 08:31:52 puma kernel: [10359910.035310]  do_sys_open+0x46/0x80
Mar  5 08:31:52 puma kernel: [10359910.035312]  __x64_sys_openat+0x20/0x30
Mar  5 08:31:52 puma kernel: [10359910.035316]  do_syscall_64+0x61/0xb0
Mar  5 08:31:52 puma kernel: [10359910.035320]  ? exit_to_user_mode_prepare+0x3d/0x1c0
Mar  5 08:31:52 puma kernel: [10359910.035323]  ? syscall_exit_to_user_mode+0x27/0x50
Mar  5 08:31:52 puma kernel: [10359910.035326]  ? __x64_sys_clone+0x25/0x30
Mar  5 08:31:52 puma kernel: [10359910.035329]  ? do_syscall_64+0x6e/0xb0
Mar  5 08:31:52 puma kernel: [10359910.035332]  ? exit_to_user_mode_prepare+0x3d/0x1c0
Mar  5 08:31:52 puma kernel: [10359910.035335]  ? do_user_addr_fault+0x1d0/0x640
Mar  5 08:31:52 puma kernel: [10359910.035341]  ? irqentry_exit_to_user_mode+0x9/0x20
Mar  5 08:31:52 puma kernel: [10359910.035344]  ? irqentry_exit+0x19/0x30
Mar  5 08:31:52 puma kernel: [10359910.035347]  ? exc_page_fault+0x8f/0x170
Mar  5 08:31:52 puma kernel: [10359910.035349]  ? asm_exc_page_fault+0x8/0x30
Mar  5 08:31:52 puma kernel: [10359910.035352]  entry_SYSCALL_64_after_hwframe+0x44/0xae
Mar  5 08:31:52 puma kernel: [10359910.035355] RIP: 0033:0x7f7a66acfad4
Mar  5 08:31:52 puma kernel: [10359910.035357] RSP: 002b:00007f7a51ff9fc0 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
Mar  5 08:31:52 puma kernel: [10359910.035359] RAX: ffffffffffffffda RBX: 00007f7a51ffa048 RCX: 00007f7a66acfad4
Mar  5 08:31:52 puma kernel: [10359910.035360] RDX: 00000000000000c2 RSI: 00007f7a38270b20 RDI: 00000000ffffff9c
Mar  5 08:31:52 puma kernel: [10359910.035362] RBP: 00007f7a38270b20 R08: 0000000000000000 R09: 00000000009e14cf
Mar  5 08:31:52 puma kernel: [10359910.035363] R10: 0000000000000180 R11: 0000000000000293 R12: 00000000000000c2
Mar  5 08:31:52 puma kernel: [10359910.035364] R13: 00007f7a51ffa100 R14: 00007f7a3800a480 R15: 0000000000008062
Mar  5 08:31:52 puma kernel: [10359910.035369] INFO: task ThreadPoolForeg:1182925 blocked for more than 120 seconds.
Mar  5 08:31:52 puma kernel: [10359910.035371]       Tainted: P           OE     5.13.0-7614-generic #14~1631647151~20.04~930e87c-Ubuntu
Mar  5 08:31:52 puma kernel: [10359910.035373] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Mar  5 08:31:52 puma kernel: [10359910.035374] task:ThreadPoolForeg state:D stack:    0 pid:1182925 ppid:  5453 flags:0x00000000
Mar  5 08:31:52 puma kernel: [10359910.035377] Call Trace:
Mar  5 08:31:52 puma kernel: [10359910.035379]  __schedule+0x2ee/0x900
Mar  5 08:31:52 puma kernel: [10359910.035381]  schedule+0x4f/0xc0
Mar  5 08:31:52 puma kernel: [10359910.035384]  rwsem_down_write_slowpath+0x232/0x5f0
Mar  5 08:31:52 puma kernel: [10359910.035387]  down_write+0x41/0x50
Mar  5 08:31:52 puma kernel: [10359910.035390]  path_openat+0x278/0xc80
Mar  5 08:31:52 puma kernel: [10359910.035393]  do_filp_open+0xa2/0x110
Mar  5 08:31:52 puma kernel: [10359910.035396]  ? __check_object_size+0x13f/0x150
Mar  5 08:31:52 puma kernel: [10359910.035398]  ? alloc_fd+0x58/0x190
Mar  5 08:31:52 puma kernel: [10359910.035402]  do_sys_openat2+0x241/0x310
Mar  5 08:31:52 puma kernel: [10359910.035404]  do_sys_open+0x46/0x80
Mar  5 08:31:52 puma kernel: [10359910.035406]  __x64_sys_openat+0x20/0x30
Mar  5 08:31:52 puma kernel: [10359910.035408]  do_syscall_64+0x61/0xb0
Mar  5 08:31:52 puma kernel: [10359910.035412]  ? __do_sys_clone+0x5d/0x80
Mar  5 08:31:52 puma kernel: [10359910.035415]  ? exit_to_user_mode_prepare+0x3d/0x1c0
Mar  5 08:31:52 puma kernel: [10359910.035419]  ? syscall_exit_to_user_mode+0x27/0x50
Mar  5 08:31:52 puma kernel: [10359910.035421]  ? __x64_sys_clone+0x25/0x30
Mar  5 08:31:52 puma kernel: [10359910.035423]  ? do_syscall_64+0x6e/0xb0
Mar  5 08:31:52 puma kernel: [10359910.035425]  ? asm_exc_page_fault+0x8/0x30
Mar  5 08:31:52 puma kernel: [10359910.035427]  entry_SYSCALL_64_after_hwframe+0x44/0xae
Mar  5 08:31:52 puma kernel: [10359910.035430] RIP: 0033:0x7f7a66acfad4
Mar  5 08:31:52 puma kernel: [10359910.035431] RSP: 002b:00007f7a515f4fc0 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
Mar  5 08:31:52 puma kernel: [10359910.035432] RAX: ffffffffffffffda RBX: 00007f7a515f5048 RCX: 00007f7a66acfad4
Mar  5 08:31:52 puma kernel: [10359910.035434] RDX: 00000000000000c2 RSI: 00007f7a4816f710 RDI: 00000000ffffff9c
Mar  5 08:31:52 puma kernel: [10359910.035435] RBP: 00007f7a4816f710 R08: 0000000000000000 R09: 00000000009e14cf
Mar  5 08:31:52 puma kernel: [10359910.035436] R10: 0000000000000180 R11: 0000000000000293 R12: 00000000000000c2
Mar  5 08:31:52 puma kernel: [10359910.035437] R13: 00007f7a515f5100 R14: 00007f7a48126400 R15: 0000000000008062
Mar  5 08:31:52 puma kernel: [10359910.035891] INFO: task Indexed~ #56144:1182900 blocked for more than 120 seconds.
Mar  5 08:31:52 puma kernel: [10359910.035893]       Tainted: P           OE     5.13.0-7614-generic #14~1631647151~20.04~930e87c-Ubuntu
Mar  5 08:31:52 puma kernel: [10359910.035895] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Mar  5 08:31:52 puma kernel: [10359910.035896] task:Indexed~ #56144 state:D stack:    0 pid:1182900 ppid:     1 flags:0x00000000
Mar  5 08:31:52 puma kernel: [10359910.035898] Call Trace:
Mar  5 08:31:52 puma kernel: [10359910.035900]  __schedule+0x2ee/0x900
Mar  5 08:31:52 puma kernel: [10359910.035902]  schedule+0x4f/0xc0
Mar  5 08:31:52 puma kernel: [10359910.035904]  rwsem_down_write_slowpath+0x232/0x5f0
Mar  5 08:31:52 puma kernel: [10359910.035908]  down_write+0x41/0x50
Mar  5 08:31:52 puma kernel: [10359910.035911]  do_unlinkat+0x125/0x2d0
Mar  5 08:31:52 puma kernel: [10359910.035913]  __x64_sys_unlink+0x23/0x30
Mar  5 08:31:52 puma kernel: [10359910.035915]  do_syscall_64+0x61/0xb0
Mar  5 08:31:52 puma kernel: [10359910.035918]  ? __x64_sys_futex+0x7b/0x1b0
Mar  5 08:31:52 puma kernel: [10359910.035923]  ? exit_to_user_mode_prepare+0x3d/0x1c0
Mar  5 08:31:52 puma kernel: [10359910.035925]  ? syscall_exit_to_user_mode+0x27/0x50
Mar  5 08:31:52 puma kernel: [10359910.035928]  ? do_syscall_64+0x6e/0xb0
Mar  5 08:31:52 puma kernel: [10359910.035930]  ? do_syscall_64+0x6e/0xb0
Mar  5 08:31:52 puma kernel: [10359910.035932]  ? asm_sysvec_call_function+0xa/0x20
Mar  5 08:31:52 puma kernel: [10359910.035934]  entry_SYSCALL_64_after_hwframe+0x44/0xae
Mar  5 08:31:52 puma kernel: [10359910.035936] RIP: 0033:0x7fc30923de3b
Mar  5 08:31:52 puma kernel: [10359910.035937] RSP: 002b:00007fc2ba2794d8 EFLAGS: 00000202 ORIG_RAX: 0000000000000057
Mar  5 08:31:52 puma kernel: [10359910.035939] RAX: ffffffffffffffda RBX: 00007fc274449d73 RCX: 00007fc30923de3b
Mar  5 08:31:52 puma kernel: [10359910.035940] RDX: 0000000000000000 RSI: 00007fc274449d73 RDI: 00007fc274449d73
Mar  5 08:31:52 puma kernel: [10359910.035941] RBP: 0000000000000000 R08: 0000000000000000 R09: 00007fc272f01748
Mar  5 08:31:52 puma kernel: [10359910.035942] R10: 0000000000000000 R11: 0000000000000202 R12: 00007fc274449d73
Mar  5 08:31:52 puma kernel: [10359910.035943] R13: 00007fc2734b5600 R14: 0000000000000000 R15: 00007fc3085bd578
Mar  5 08:31:52 puma kernel: [10359910.035946] INFO: task Indexed~ #56145:1182901 blocked for more than 120 seconds.
Mar  5 08:31:52 puma kernel: [10359910.035948]       Tainted: P           OE     5.13.0-7614-generic #14~1631647151~20.04~930e87c-Ubuntu
Mar  5 08:31:52 puma kernel: [10359910.035949] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Mar  5 08:31:52 puma kernel: [10359910.035950] task:Indexed~ #56145 state:D stack:    0 pid:1182901 ppid:     1 flags:0x00000000
Mar  5 08:31:52 puma kernel: [10359910.035953] Call Trace:
Mar  5 08:31:52 puma kernel: [10359910.035954]  __schedule+0x2ee/0x900
Mar  5 08:31:52 puma kernel: [10359910.035956]  ? try_to_unlazy+0x55/0x90
Mar  5 08:31:52 puma kernel: [10359910.035959]  schedule+0x4f/0xc0
Mar  5 08:31:52 puma kernel: [10359910.035964]  wait_current_trans+0xd6/0x140 [btrfs]
Mar  5 08:31:52 puma kernel: [10359910.036043]  ? wait_woken+0x80/0x80
Mar  5 08:31:52 puma kernel: [10359910.036047]  start_transaction+0x4bb/0x5a0 [btrfs]
Mar  5 08:31:52 puma kernel: [10359910.036081]  btrfs_start_transaction_fallback_global_rsv+0x1b/0x20 [btrfs]
Mar  5 08:31:52 puma kernel: [10359910.036113]  btrfs_unlink+0x30/0xe0 [btrfs]
Mar  5 08:31:52 puma kernel: [10359910.036145]  vfs_unlink+0x114/0x200
Mar  5 08:31:52 puma kernel: [10359910.036147]  do_unlinkat+0x1a2/0x2d0
Mar  5 08:31:52 puma kernel: [10359910.036150]  __x64_sys_unlink+0x23/0x30
Mar  5 08:31:52 puma kernel: [10359910.036153]  do_syscall_64+0x61/0xb0
Mar  5 08:31:52 puma kernel: [10359910.036155]  ? do_syscall_64+0x6e/0xb0
Mar  5 08:31:52 puma kernel: [10359910.036157]  ? do_syscall_64+0x6e/0xb0
Mar  5 08:31:52 puma kernel: [10359910.036159]  ? do_syscall_64+0x6e/0xb0
Mar  5 08:31:52 puma kernel: [10359910.036160]  ? do_syscall_64+0x6e/0xb0
Mar  5 08:31:52 puma kernel: [10359910.036162]  ? do_syscall_64+0x6e/0xb0
Mar  5 08:31:52 puma kernel: [10359910.036164]  ? asm_sysvec_apic_timer_interrupt+0xa/0x20
Mar  5 08:31:52 puma kernel: [10359910.036166]  entry_SYSCALL_64_after_hwframe+0x44/0xae
Mar  5 08:31:52 puma kernel: [10359910.036167] RIP: 0033:0x7fc30923de3b
Mar  5 08:31:52 puma kernel: [10359910.036169] RSP: 002b:00007fc2c2bbd4d8 EFLAGS: 00000202 ORIG_RAX: 0000000000000057
Mar  5 08:31:52 puma kernel: [10359910.036170] RAX: ffffffffffffffda RBX: 00007fc274b75271 RCX: 00007fc30923de3b
Mar  5 08:31:52 puma kernel: [10359910.036171] RDX: 0000000000000000 RSI: 00007fc274b75271 RDI: 00007fc274b75271
Mar  5 08:31:52 puma kernel: [10359910.036173] RBP: 0000000000000000 R08: 0000000000000000 R09: 00007fc272f01748
Mar  5 08:31:52 puma kernel: [10359910.036174] R10: 0000000000000000 R11: 0000000000000202 R12: 00007fc274b75271
Mar  5 08:31:52 puma kernel: [10359910.036175] R13: 00007fc2734b4400 R14: 0000000000000000 R15: 00007fc3085bd578
Mar  5 08:31:52 puma kernel: [10359910.036511] INFO: task okular:3020312 blocked for more than 120 seconds.
Mar  5 08:31:52 puma kernel: [10359910.036513]       Tainted: P           OE     5.13.0-7614-generic #14~1631647151~20.04~930e87c-Ubuntu
Mar  5 08:31:52 puma kernel: [10359910.036514] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Mar  5 08:31:52 puma kernel: [10359910.036516] task:okular          state:D stack:    0 pid:3020312 ppid:     1 flags:0x00000000
Mar  5 08:31:52 puma kernel: [10359910.036518] Call Trace:
Mar  5 08:31:52 puma kernel: [10359910.036519]  __schedule+0x2ee/0x900
Mar  5 08:31:52 puma kernel: [10359910.036522]  ? pagevec_lookup_range_tag+0x28/0x30
Mar  5 08:31:52 puma kernel: [10359910.036527]  schedule+0x4f/0xc0
Mar  5 08:31:52 puma kernel: [10359910.036529]  wait_current_trans+0xd6/0x140 [btrfs]
Mar  5 08:31:52 puma kernel: [10359910.036561]  ? wait_woken+0x80/0x80
Mar  5 08:31:52 puma kernel: [10359910.036563]  start_transaction+0x4bb/0x5a0 [btrfs]
Mar  5 08:31:52 puma kernel: [10359910.036592]  btrfs_start_transaction+0x1e/0x20 [btrfs]
Mar  5 08:31:52 puma kernel: [10359910.036622]  btrfs_setsize.isra.0+0x1cb/0x550 [btrfs]
Mar  5 08:31:52 puma kernel: [10359910.036654]  btrfs_setattr+0x6d/0x100 [btrfs]
Mar  5 08:31:52 puma kernel: [10359910.036682]  notify_change+0x386/0x530
Mar  5 08:31:52 puma kernel: [10359910.036686]  do_truncate+0x80/0xd0
Mar  5 08:31:52 puma kernel: [10359910.036688]  ? do_truncate+0x80/0xd0
Mar  5 08:31:52 puma kernel: [10359910.036691]  do_open.isra.0+0x30d/0x420
Mar  5 08:31:52 puma kernel: [10359910.036693]  path_openat+0x18e/0xc80
Mar  5 08:31:52 puma kernel: [10359910.036695]  do_filp_open+0xa2/0x110
Mar  5 08:31:52 puma kernel: [10359910.036698]  ? __check_object_size+0x13f/0x150
Mar  5 08:31:52 puma kernel: [10359910.036701]  do_sys_openat2+0x241/0x310
Mar  5 08:31:52 puma kernel: [10359910.036703]  do_sys_open+0x46/0x80
Mar  5 08:31:52 puma kernel: [10359910.036705]  __x64_sys_openat+0x20/0x30
Mar  5 08:31:52 puma kernel: [10359910.036707]  do_syscall_64+0x61/0xb0
Mar  5 08:31:52 puma kernel: [10359910.036708]  ? do_syscall_64+0x6e/0xb0
Mar  5 08:31:52 puma kernel: [10359910.036710]  ? syscall_exit_to_user_mode+0x27/0x50
Mar  5 08:31:52 puma kernel: [10359910.036713]  ? do_syscall_64+0x6e/0xb0
Mar  5 08:31:52 puma kernel: [10359910.036715]  ? do_syscall_64+0x6e/0xb0
Mar  5 08:31:52 puma kernel: [10359910.036717]  ? syscall_exit_to_user_mode+0x27/0x50
Mar  5 08:31:52 puma kernel: [10359910.036719]  ? __x64_sys_newstat+0x16/0x20
Mar  5 08:31:52 puma kernel: [10359910.036722]  ? do_syscall_64+0x6e/0xb0
Mar  5 08:31:52 puma kernel: [10359910.036724]  ? do_syscall_64+0x6e/0xb0
Mar  5 08:31:52 puma kernel: [10359910.036726]  ? do_syscall_64+0x6e/0xb0
Mar  5 08:31:52 puma kernel: [10359910.036728]  ? asm_sysvec_call_function_single+0xa/0x20
Mar  5 08:31:52 puma kernel: [10359910.036730]  entry_SYSCALL_64_after_hwframe+0x44/0xae
Mar  5 08:31:52 puma kernel: [10359910.036732] RIP: 0033:0x7faf28a08f24
Mar  5 08:31:52 puma kernel: [10359910.036733] RSP: 002b:00007ffe7bd06470 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
Mar  5 08:31:52 puma kernel: [10359910.036735] RAX: ffffffffffffffda RBX: 0000562eaf35d408 RCX: 00007faf28a08f24
Mar  5 08:31:52 puma kernel: [10359910.036736] RDX: 0000000000080241 RSI: 0000562eaf35d408 RDI: 00000000ffffff9c
Mar  5 08:31:52 puma kernel: [10359910.036737] RBP: 0000562eaf35d408 R08: 0000000000000000 R09: 0000000000000080
Mar  5 08:31:52 puma kernel: [10359910.036738] R10: 00000000000001b6 R11: 0000000000000293 R12: 0000000000080241
Mar  5 08:31:52 puma kernel: [10359910.036739] R13: 00007ffe7bd06508 R14: 0000562eaf3938e0 R15: 00007faf29215e68
Mar  5 13:35:37 puma systemd-modules-load[556]: Inserted module 'lp'
Mar  5 13:35:37 puma systemd-modules-load[556]: Inserted module 'ppdev'
Mar  5 13:35:37 puma systemd-modules-load[556]: Inserted module 'parport_pc'
Mar  5 13:35:37 puma systemd-modules-load[556]: Inserted module 'msr'
Mar  5 13:35:37 puma systemd-sysctl[579]: Not setting net/ipv4/conf/all/promote_secondaries (explicit setting exists).

Mar  8 04:33:11 puma tracker-store[53434]: OK
Mar  8 04:33:11 puma systemd[3662]: tracker-store.service: Succeeded.
Mar  8 04:34:10 puma dbus-daemon[3680]: [session uid=1000 pid=3680] Activating via systemd: service name='org.freedesktop.Tracker1' unit='tracker-store.service' requested by ':1.1' (uid=1000 pid=3675 comm="/usr/libexec/tracker-miner-fs ")
Mar  8 04:36:29 puma kernel: [39151.885472] INFO: task tracker-store:53596 blocked for more than 120 seconds.
Mar  8 04:36:29 puma kernel: [39151.885492]       Tainted: G           OE     5.15.15-76051515-generic #202201160435~1642693824~20.04~97db1bb-Ubuntu
Mar  8 04:36:29 puma kernel: [39151.885494] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Mar  8 04:36:29 puma kernel: [39151.885496] task:tracker-store   state:D stack:    0 pid:53596 ppid:  3662 flags:0x00000000
Mar  8 04:36:29 puma kernel: [39151.885503] Call Trace:
Mar  8 04:36:29 puma kernel: [39151.885508]  <TASK>
Mar  8 04:36:29 puma kernel: [39151.885518]  __schedule+0x2cd/0x890
Mar  8 04:36:29 puma kernel: [39151.885530]  ? __cond_resched+0x19/0x30
Mar  8 04:36:29 puma kernel: [39151.885533]  schedule+0x4e/0xb0
Mar  8 04:36:29 puma kernel: [39151.885539]  btrfs_sync_log+0x178/0xef0 [btrfs]
Mar  8 04:36:29 puma kernel: [39151.885704]  ? __raw_callee_save___native_queued_spin_unlock+0x15/0x23
Mar  8 04:36:29 puma kernel: [39151.885717]  ? release_extent_buffer+0xbb/0xe0 [btrfs]
Mar  8 04:36:29 puma kernel: [39151.885753]  ? wait_woken+0x60/0x60
Mar  8 04:36:29 puma kernel: [39151.885758]  ? btrfs_free_path+0x27/0x30 [btrfs]
Mar  8 04:36:29 puma kernel: [39151.885787]  ? dput+0x62/0x320
Mar  8 04:36:29 puma kernel: [39151.885794]  ? log_all_new_ancestors+0x3bc/0x470 [btrfs]
Mar  8 04:36:29 puma kernel: [39151.885841]  ? btrfs_log_inode_parent+0x2db/0x890 [btrfs]
Mar  8 04:36:29 puma kernel: [39151.885872]  ? join_transaction+0x135/0x4c0 [btrfs]
Mar  8 04:36:29 puma kernel: [39151.885900]  ? start_transaction+0xd5/0x5b0 [btrfs]
Mar  8 04:36:29 puma kernel: [39151.885931]  ? dput+0x62/0x320
Mar  8 04:36:29 puma kernel: [39151.885933]  btrfs_sync_file+0x33f/0x460 [btrfs]
Mar  8 04:36:29 puma kernel: [39151.885961]  vfs_fsync_range+0x49/0x80
Mar  8 04:36:29 puma kernel: [39151.885965]  do_fsync+0x3d/0x70
Mar  8 04:36:29 puma kernel: [39151.885967]  __x64_sys_fsync+0x14/0x20
Mar  8 04:36:29 puma kernel: [39151.885968]  do_syscall_64+0x5c/0xc0
Mar  8 04:36:29 puma kernel: [39151.885971]  ? do_sys_openat2+0x1d3/0x320
Mar  8 04:36:29 puma kernel: [39151.885975]  ? exit_to_user_mode_prepare+0x3d/0x1c0
Mar  8 04:36:29 puma kernel: [39151.885980]  ? syscall_exit_to_user_mode+0x27/0x50
Mar  8 04:36:29 puma kernel: [39151.885983]  ? __x64_sys_openat+0x20/0x30
Mar  8 04:36:29 puma kernel: [39151.885986]  ? do_syscall_64+0x69/0xc0
Mar  8 04:36:29 puma kernel: [39151.885987]  ? do_syscall_64+0x69/0xc0
Mar  8 04:36:29 puma kernel: [39151.885988]  entry_SYSCALL_64_after_hwframe+0x44/0xae
Mar  8 04:36:29 puma kernel: [39151.885993] RIP: 0033:0x7f0eb970832b
Mar  8 04:36:29 puma kernel: [39151.885995] RSP: 002b:00007ffde79e29b0 EFLAGS: 00000293 ORIG_RAX: 000000000000004a
Mar  8 04:36:29 puma kernel: [39151.885997] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0eb970832b
Mar  8 04:36:29 puma kernel: [39151.885999] RDX: 0000000000101441 RSI: 0000564c61177b50 RDI: 0000000000000008
Mar  8 04:36:29 puma kernel: [39151.886000] RBP: 0000000000000008 R08: 0000000000000000 R09: 0000000000000001
Mar  8 04:36:29 puma kernel: [39151.886001] R10: 00000000000001b0 R11: 0000000000000293 R12: 0000564c61176e50
Mar  8 04:36:29 puma kernel: [39151.886002] R13: 00007ffde79e2a00 R14: 00007ffde79e2be4 R15: 0000000000000000
Mar  8 04:36:29 puma kernel: [39151.886005]  </TASK>
Mar  8 04:38:29 puma kernel: [39272.714478] INFO: task TaskSchedulerFo:53669 blocked for more than 120 seconds.
Mar  8 04:38:29 puma kernel: [39272.716026]       Tainted: G           OE     5.15.15-76051515-generic #202201160435~1642693824~20.04~97db1bb-Ubuntu
Mar  8 04:38:29 puma kernel: [39272.717550] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Mar  8 04:38:29 puma kernel: [39272.719248] task:TaskSchedulerFo state:D stack:    0 pid:53669 ppid:  3906 flags:0x00004000
Mar  8 04:38:29 puma kernel: [39272.719256] Call Trace:
Mar  8 04:38:29 puma kernel: [39272.719261]  <TASK>
Mar  8 04:38:29 puma kernel: [39272.719270]  __schedule+0x2cd/0x890
Mar  8 04:38:29 puma kernel: [39272.719284]  schedule+0x4e/0xb0
Mar  8 04:38:29 puma kernel: [39272.719290]  wait_current_trans+0xd6/0x140 [btrfs]
Mar  8 04:38:29 puma kernel: [39272.719483]  ? wait_woken+0x60/0x60
Mar  8 04:38:29 puma kernel: [39272.719490]  start_transaction+0x4c5/0x5b0 [btrfs]
Mar  8 04:38:29 puma kernel: [39272.719523]  btrfs_start_transaction+0x1e/0x20 [btrfs]
Mar  8 04:38:29 puma kernel: [39272.719554]  btrfs_sync_file+0x29d/0x460 [btrfs]
Mar  8 04:38:29 puma kernel: [39272.719590]  vfs_fsync_range+0x49/0x80
Mar  8 04:38:29 puma kernel: [39272.719595]  do_fsync+0x3d/0x70
Mar  8 04:38:29 puma kernel: [39272.719596]  ? __x64_sys_pread64+0x1e/0x20
Mar  8 04:38:29 puma kernel: [39272.719600]  __x64_sys_fdatasync+0x17/0x20
Mar  8 04:38:29 puma kernel: [39272.719602]  do_syscall_64+0x5c/0xc0
Mar  8 04:38:29 puma kernel: [39272.719605]  ? syscall_exit_to_user_mode+0x27/0x50
Mar  8 04:38:29 puma kernel: [39272.719609]  ? __x64_sys_pwrite64+0x1e/0x20
Mar  8 04:38:29 puma kernel: [39272.719610]  ? do_syscall_64+0x69/0xc0
Mar  8 04:38:29 puma kernel: [39272.719612]  ? irqentry_exit+0x19/0x30
Mar  8 04:38:29 puma kernel: [39272.719613]  ? exc_page_fault+0x89/0x160
Mar  8 04:38:29 puma kernel: [39272.719615]  ? asm_exc_page_fault+0x8/0x30
Mar  8 04:38:29 puma kernel: [39272.719622]  entry_SYSCALL_64_after_hwframe+0x44/0xae
Mar  8 04:38:29 puma kernel: [39272.719626] RIP: 0033:0x7f9e32d293eb
Mar  8 04:38:29 puma kernel: [39272.719629] RSP: 002b:00007f9c667faa10 EFLAGS: 00000293 ORIG_RAX: 000000000000004b
Mar  8 04:38:29 puma kernel: [39272.719632] RAX: ffffffffffffffda RBX: 00007f9d581368b0 RCX: 00007f9e32d293eb
Mar  8 04:38:29 puma kernel: [39272.719634] RDX: 0000000000000008 RSI: 0000000000000002 RDI: 0000000000000070
Mar  8 04:38:29 puma kernel: [39272.719635] RBP: 00007f9c667faa50 R08: 0000000000000000 R09: 0000000000000001
Mar  8 04:38:29 puma kernel: [39272.719637] R10: 0000000000004400 R11: 0000000000000293 R12: 0000000000000000
Mar  8 04:38:29 puma kernel: [39272.719638] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Mar  8 04:38:29 puma kernel: [39272.719642]  </TASK>
Mar  8 04:38:29 puma kernel: [39272.720295] INFO: task Backgro~ol #153:53250 blocked for more than 120 seconds.
Mar  8 04:38:29 puma kernel: [39272.721999]       Tainted: G           OE     5.15.15-76051515-generic #202201160435~1642693824~20.04~97db1bb-Ubuntu
Mar  8 04:38:29 puma kernel: [39272.723646] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Mar  8 04:38:29 puma kernel: [39272.725166] task:Backgro~ol #153 state:D stack:    0 pid:53250 ppid:  4014 flags:0x00000000
Mar  8 04:38:29 puma kernel: [39272.725172] Call Trace:
Mar  8 04:38:29 puma kernel: [39272.725175]  <TASK>
Mar  8 04:38:29 puma kernel: [39272.725182]  __schedule+0x2cd/0x890
Mar  8 04:38:29 puma kernel: [39272.725190]  ? pagevec_lookup_range_tag+0x28/0x30
Mar  8 04:38:29 puma kernel: [39272.725196]  schedule+0x4e/0xb0
Mar  8 04:38:29 puma kernel: [39272.725200]  wait_current_trans+0xd6/0x140 [btrfs]
Mar  8 04:38:29 puma kernel: [39272.725276]  ? wait_woken+0x60/0x60
Mar  8 04:38:29 puma kernel: [39272.725279]  start_transaction+0x4c5/0x5b0 [btrfs]
Mar  8 04:38:29 puma kernel: [39272.725308]  btrfs_start_transaction+0x1e/0x20 [btrfs]
Mar  8 04:38:29 puma kernel: [39272.725336]  btrfs_setsize.isra.0+0x1fb/0x570 [btrfs]
Mar  8 04:38:29 puma kernel: [39272.725368]  ? setattr_prepare+0x87/0x250
Mar  8 04:38:29 puma kernel: [39272.725373]  btrfs_setattr+0x6c/0x100 [btrfs]
Mar  8 04:38:29 puma kernel: [39272.725411]  notify_change+0x347/0x4d0
Mar  8 04:38:29 puma kernel: [39272.725413]  do_truncate+0x80/0xd0
Mar  8 04:38:29 puma kernel: [39272.725416]  ? do_truncate+0x80/0xd0
Mar  8 04:38:29 puma kernel: [39272.725419]  do_open.isra.0+0x2d9/0x3e0
Mar  8 04:38:29 puma kernel: [39272.725422]  path_openat+0x18e/0xcb0
Mar  8 04:38:29 puma kernel: [39272.725425]  do_filp_open+0xb2/0x120
Mar  8 04:38:29 puma kernel: [39272.725428]  ? __check_object_size+0x13f/0x150
Mar  8 04:38:29 puma kernel: [39272.725431]  ? alloc_fd+0x58/0x190
Mar  8 04:38:29 puma kernel: [39272.725434]  do_sys_openat2+0x245/0x320
Mar  8 04:38:29 puma kernel: [39272.725436]  do_sys_open+0x46/0x80
Mar  8 04:38:29 puma kernel: [39272.725438]  __x64_sys_openat+0x20/0x30
Mar  8 04:38:29 puma kernel: [39272.725440]  do_syscall_64+0x5c/0xc0
Mar  8 04:38:29 puma kernel: [39272.725442]  ? irqentry_exit_to_user_mode+0x9/0x20
Mar  8 04:38:29 puma kernel: [39272.725445]  ? irqentry_exit+0x19/0x30
Mar  8 04:38:29 puma kernel: [39272.725446]  ? sysvec_apic_timer_interrupt+0x4e/0x90
Mar  8 04:38:29 puma kernel: [39272.725448]  ? asm_sysvec_apic_timer_interrupt+0xa/0x20
Mar  8 04:38:29 puma kernel: [39272.725452]  entry_SYSCALL_64_after_hwframe+0x44/0xae
Mar  8 04:38:29 puma kernel: [39272.725454] RIP: 0033:0x7ff7a9beead4
Mar  8 04:38:29 puma kernel: [39272.725458] RSP: 002b:00007ff76477c750 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
Mar  8 04:38:29 puma kernel: [39272.725460] RAX: ffffffffffffffda RBX: 000000000000002a RCX: 00007ff7a9beead4
Mar  8 04:38:29 puma kernel: [39272.725462] RDX: 0000000000000241 RSI: 00007ff74ff62908 RDI: 00000000ffffff9c
Mar  8 04:38:29 puma kernel: [39272.725463] RBP: 00007ff74ff62908 R08: 0000000000000000 R09: 00007ff76477c7f0
Mar  8 04:38:29 puma kernel: [39272.725464] R10: 00000000000001b4 R11: 0000000000000293 R12: 0000000000000241
Mar  8 04:38:29 puma kernel: [39272.725465] R13: 000000000000002a R14: 00000000000001b4 R15: 00007ff74ff62908
Mar  8 04:38:29 puma kernel: [39272.725468]  </TASK>
Mar  8 04:38:29 puma kernel: [39272.725474] INFO: task IndexedDB #370:53653 blocked for more than 120 seconds.
Mar  8 04:38:29 puma kernel: [39272.727139]       Tainted: G           OE     5.15.15-76051515-generic #202201160435~1642693824~20.04~97db1bb-Ubuntu
Mar  8 04:38:29 puma kernel: [39272.728922] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Mar  8 04:38:29 puma kernel: [39272.730632] task:IndexedDB #370  state:D stack:    0 pid:53653 ppid:  4014 flags:0x00000000
Mar  8 04:38:29 puma kernel: [39272.730638] Call Trace:
Mar  8 04:38:29 puma kernel: [39272.730641]  <TASK>
Mar  8 04:38:29 puma kernel: [39272.730647]  __schedule+0x2cd/0x890
Mar  8 04:38:29 puma kernel: [39272.730658]  schedule+0x4e/0xb0
Mar  8 04:38:29 puma kernel: [39272.730661]  wait_current_trans+0xd6/0x140 [btrfs]
Mar  8 04:38:29 puma kernel: [39272.730791]  ? wait_woken+0x60/0x60
Mar  8 04:38:29 puma kernel: [39272.730797]  start_transaction+0x4c5/0x5b0 [btrfs]
Mar  8 04:38:29 puma kernel: [39272.730830]  btrfs_start_transaction+0x1e/0x20 [btrfs]
Mar  8 04:38:29 puma kernel: [39272.730854]  btrfs_create+0x5d/0x200 [btrfs]
Mar  8 04:38:29 puma kernel: [39272.730887]  path_openat+0xb59/0xcb0
Mar  8 04:38:29 puma kernel: [39272.730892]  ? path_lookupat.isra.0+0xa2/0x150
Mar  8 04:38:29 puma kernel: [39272.730894]  do_filp_open+0xb2/0x120
Mar  8 04:38:29 puma kernel: [39272.730896]  ? __check_object_size+0x13f/0x150
Mar  8 04:38:29 puma kernel: [39272.730899]  ? alloc_fd+0x58/0x190
Mar  8 04:38:29 puma kernel: [39272.730903]  do_sys_openat2+0x245/0x320
Mar  8 04:38:29 puma kernel: [39272.730906]  do_sys_open+0x46/0x80
Mar  8 04:38:29 puma kernel: [39272.730908]  __x64_sys_openat+0x20/0x30
Mar  8 04:38:29 puma kernel: [39272.730909]  do_syscall_64+0x5c/0xc0
Mar  8 04:38:29 puma kernel: [39272.730912]  ? exit_to_user_mode_prepare+0x3d/0x1c0
Mar  8 04:38:29 puma kernel: [39272.730916]  ? syscall_exit_to_user_mode+0x27/0x50
Mar  8 04:38:29 puma kernel: [39272.730920]  ? __x64_sys_newstat+0x16/0x20
Mar  8 04:38:29 puma kernel: [39272.730923]  ? do_syscall_64+0x69/0xc0
Mar  8 04:38:29 puma kernel: [39272.730925]  ? do_syscall_64+0x69/0xc0
Mar  8 04:38:29 puma kernel: [39272.730926]  ? syscall_exit_to_user_mode+0x27/0x50
Mar  8 04:38:29 puma kernel: [39272.730928]  entry_SYSCALL_64_after_hwframe+0x44/0xae
Mar  8 04:38:29 puma kernel: [39272.730931] RIP: 0033:0x7ff7a9beead4
Mar  8 04:38:29 puma kernel: [39272.730933] RSP: 002b:00007ff7616918b0 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
Mar  8 04:38:29 puma kernel: [39272.730935] RAX: ffffffffffffffda RBX: 00007ff758e7ea73 RCX: 00007ff7a9beead4
Mar  8 04:38:29 puma kernel: [39272.730937] RDX: 00000000000a0042 RSI: 00007ff758e7ea73 RDI: 00000000ffffff9c
Mar  8 04:38:29 puma kernel: [39272.730938] RBP: 00007ff758e7ea73 R08: 0000000000000000 R09: ffffffffffffffff
Mar  8 04:38:29 puma kernel: [39272.730940] R10: 00000000000001a4 R11: 0000000000000293 R12: 00000000000a0042
Mar  8 04:38:29 puma kernel: [39272.730941] R13: 00007ff7a8af984c R14: 00000000000001a4 R15: 00000000000a0042
Mar  8 04:38:29 puma kernel: [39272.730944]  </TASK>
Mar  8 04:38:29 puma kernel: [39272.730947] INFO: task IndexedDB #371:53654 blocked for more than 120 seconds.
Mar  8 04:38:29 puma kernel: [39272.732707]       Tainted: G           OE     5.15.15-76051515-generic #202201160435~1642693824~20.04~97db1bb-Ubuntu
Mar  8 04:38:29 puma kernel: [39272.734607] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Mar  8 04:38:29 puma kernel: [39272.736565] task:IndexedDB #371  state:D stack:    0 pid:53654 ppid:  4014 flags:0x00000000
Mar  8 04:38:29 puma kernel: [39272.736571] Call Trace:
Mar  8 04:38:29 puma kernel: [39272.736574]  <TASK>
Mar  8 04:38:29 puma kernel: [39272.736578]  __schedule+0x2cd/0x890
Mar  8 04:38:29 puma kernel: [39272.736585]  schedule+0x4e/0xb0
Mar  8 04:38:29 puma kernel: [39272.736586]  rwsem_down_write_slowpath+0x22a/0x520
Mar  8 04:38:29 puma kernel: [39272.736592]  ? __legitimize_path.isra.0+0x31/0x70
Mar  8 04:38:29 puma kernel: [39272.736596]  down_write+0x41/0x50
Mar  8 04:38:29 puma kernel: [39272.736598]  path_openat+0x278/0xcb0
Mar  8 04:38:29 puma kernel: [39272.736600]  ? terminate_walk+0x69/0xf0
Mar  8 04:38:29 puma kernel: [39272.736602]  ? path_lookupat.isra.0+0xa2/0x150
Mar  8 04:38:29 puma kernel: [39272.736604]  ? filename_lookup+0x10a/0x1a0
Mar  8 04:38:29 puma kernel: [39272.736606]  do_filp_open+0xb2/0x120
Mar  8 04:38:29 puma kernel: [39272.736609]  ? __check_object_size+0x13f/0x150
Mar  8 04:38:29 puma kernel: [39272.736613]  do_sys_openat2+0x245/0x320
Mar  8 04:38:29 puma kernel: [39272.736617]  do_sys_open+0x46/0x80
Mar  8 04:38:29 puma kernel: [39272.736619]  __x64_sys_openat+0x20/0x30
Mar  8 04:38:29 puma kernel: [39272.736622]  do_syscall_64+0x5c/0xc0
Mar  8 04:38:29 puma kernel: [39272.736624]  ? syscall_exit_to_user_mode+0x27/0x50
Mar  8 04:38:29 puma kernel: [39272.736627]  ? __x64_sys_newstat+0x16/0x20
Mar  8 04:38:29 puma kernel: [39272.736631]  ? do_syscall_64+0x69/0xc0
Mar  8 04:38:29 puma kernel: [39272.736633]  ? syscall_exit_to_user_mode+0x27/0x50
Mar  8 04:38:29 puma kernel: [39272.736635]  ? do_syscall_64+0x69/0xc0
Mar  8 04:38:29 puma kernel: [39272.736636]  ? syscall_exit_to_user_mode+0x27/0x50
Mar  8 04:38:29 puma kernel: [39272.736638]  entry_SYSCALL_64_after_hwframe+0x44/0xae
Mar  8 04:38:29 puma kernel: [39272.736642] RIP: 0033:0x7ff7a9beead4
Mar  8 04:38:29 puma kernel: [39272.736645] RSP: 002b:00007ff762380940 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
Mar  8 04:38:29 puma kernel: [39272.736648] RAX: ffffffffffffffda RBX: 00007ff758e79964 RCX: 00007ff7a9beead4
Mar  8 04:38:29 puma kernel: [39272.736649] RDX: 00000000000a0042 RSI: 00007ff758e79964 RDI: 00000000ffffff9c
Mar  8 04:38:29 puma kernel: [39272.736650] RBP: 00007ff758e79964 R08: 0000000000000000 R09: 0000000000000000
Mar  8 04:38:29 puma kernel: [39272.736652] R10: 00000000000001a4 R11: 0000000000000293 R12: 00000000000a0042
Mar  8 04:38:29 puma kernel: [39272.736654] R13: 00007ff7a8af984c R14: 0000000000000000 R15: 00000000000a0042
Mar  8 04:38:29 puma kernel: [39272.736657]  </TASK>
Mar  8 04:38:29 puma kernel: [39272.736660] INFO: task Classif~ Update:53752 blocked for more than 120 seconds.
Mar  8 04:38:29 puma kernel: [39272.738547]       Tainted: G           OE     5.15.15-76051515-generic #202201160435~1642693824~20.04~97db1bb-Ubuntu
Mar  8 04:38:29 puma kernel: [39272.740588] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Mar  8 04:38:29 puma kernel: [39272.742661] task:Classif~ Update state:D stack:    0 pid:53752 ppid:  4014 flags:0x00000000
Mar  8 04:38:29 puma kernel: [39272.742669] Call Trace:
Mar  8 04:38:29 puma kernel: [39272.742671]  <TASK>
Mar  8 04:38:29 puma kernel: [39272.742675]  __schedule+0x2cd/0x890
Mar  8 04:38:29 puma kernel: [39272.742685]  schedule+0x4e/0xb0
Mar  8 04:38:29 puma kernel: [39272.742690]  wait_current_trans+0xd6/0x140 [btrfs]
Mar  8 04:38:29 puma kernel: [39272.742804]  ? wait_woken+0x60/0x60
Mar  8 04:38:29 puma kernel: [39272.742809]  start_transaction+0x4c5/0x5b0 [btrfs]
Mar  8 04:38:29 puma kernel: [39272.742840]  btrfs_start_transaction+0x1e/0x20 [btrfs]
Mar  8 04:38:29 puma kernel: [39272.742867]  btrfs_mkdir+0x65/0x210 [btrfs]
Mar  8 04:38:29 puma kernel: [39272.742901]  vfs_mkdir+0x142/0x200
Mar  8 04:38:29 puma kernel: [39272.742906]  do_mkdirat+0xf5/0x120
Mar  8 04:38:29 puma kernel: [39272.742908]  __x64_sys_mkdir+0x2d/0x40
Mar  8 04:38:29 puma kernel: [39272.742911]  do_syscall_64+0x5c/0xc0
Mar  8 04:38:29 puma kernel: [39272.742913]  ? syscall_exit_to_user_mode+0x27/0x50
Mar  8 04:38:29 puma kernel: [39272.742916]  ? do_syscall_64+0x69/0xc0
Mar  8 04:38:29 puma kernel: [39272.742917]  ? do_syscall_64+0x69/0xc0
Mar  8 04:38:29 puma kernel: [39272.742919]  ? sysvec_reschedule_ipi+0x78/0xe0
Mar  8 04:38:29 puma kernel: [39272.742921]  ? asm_sysvec_reschedule_ipi+0xa/0x20
Mar  8 04:38:29 puma kernel: [39272.742925]  entry_SYSCALL_64_after_hwframe+0x44/0xae
Mar  8 04:38:29 puma kernel: [39272.742927] RIP: 0033:0x7ff7a97a6dcb
Mar  8 04:38:29 puma kernel: [39272.742929] RSP: 002b:00007ff75d0b85a8 EFLAGS: 00000202 ORIG_RAX: 0000000000000053
Mar  8 04:38:29 puma kernel: [39272.742932] RAX: ffffffffffffffda RBX: 00007ff750281758 RCX: 00007ff7a97a6dcb
Mar  8 04:38:29 puma kernel: [39272.742933] RDX: 0000000000000000 RSI: 00000000000001ed RDI: 00007ff750281708
Mar  8 04:38:29 puma kernel: [39272.742934] RBP: 00000000ffffffff R08: 0000000000000000 R09: 0000000000000000
Mar  8 04:38:29 puma kernel: [39272.742935] R10: 0000000000000058 R11: 0000000000000202 R12: 0000000000000011
Mar  8 04:38:29 puma kernel: [39272.742937] R13: 0000000000000011 R14: 00000000000001ed R15: 00007ff750281708
Mar  8 04:38:29 puma kernel: [39272.742940]  </TASK>
Mar  8 04:38:29 puma kernel: [39272.743018] INFO: task ThreadPoolSingl:12202 blocked for more than 120 seconds.
Mar  8 04:38:29 puma kernel: [39272.745060]       Tainted: G           OE     5.15.15-76051515-generic #202201160435~1642693824~20.04~97db1bb-Ubuntu
Mar  8 04:38:29 puma kernel: [39272.747250] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Mar  8 04:38:29 puma kernel: [39272.749488] task:ThreadPoolSingl state:D stack:    0 pid:12202 ppid:  4014 flags:0x00000000
Mar  8 04:38:29 puma kernel: [39272.749495] Call Trace:
Mar  8 04:38:29 puma kernel: [39272.749498]  <TASK>
Mar  8 04:38:29 puma kernel: [39272.749504]  __schedule+0x2cd/0x890
Mar  8 04:38:29 puma kernel: [39272.749513]  schedule+0x4e/0xb0
Mar  8 04:38:29 puma kernel: [39272.749516]  wait_current_trans+0xd6/0x140 [btrfs]
Mar  8 04:38:29 puma kernel: [39272.749624]  ? wait_woken+0x60/0x60
Mar  8 04:38:29 puma kernel: [39272.749630]  start_transaction+0x4c5/0x5b0 [btrfs]
Mar  8 04:38:29 puma kernel: [39272.749662]  btrfs_start_transaction+0x1e/0x20 [btrfs]
Mar  8 04:38:29 puma kernel: [39272.749694]  btrfs_create+0x5d/0x200 [btrfs]
Mar  8 04:38:29 puma kernel: [39272.749727]  path_openat+0xb59/0xcb0
Mar  8 04:38:29 puma kernel: [39272.749733]  do_filp_open+0xb2/0x120
Mar  8 04:38:29 puma kernel: [39272.749736]  ? __check_object_size+0x13f/0x150
Mar  8 04:38:29 puma kernel: [39272.749740]  do_sys_openat2+0x245/0x320
Mar  8 04:38:29 puma kernel: [39272.749743]  do_sys_open+0x46/0x80
Mar  8 04:38:29 puma kernel: [39272.749746]  __x64_sys_openat+0x20/0x30
Mar  8 04:38:29 puma kernel: [39272.749748]  do_syscall_64+0x5c/0xc0
Mar  8 04:38:29 puma kernel: [39272.749751]  ? exit_to_user_mode_prepare+0x3d/0x1c0
Mar  8 04:38:29 puma kernel: [39272.749755]  ? syscall_exit_to_user_mode+0x27/0x50
Mar  8 04:38:29 puma kernel: [39272.749757]  ? exit_to_user_mode_prepare+0x3d/0x1c0
Mar  8 04:38:29 puma kernel: [39272.749759]  ? syscall_exit_to_user_mode+0x27/0x50
Mar  8 04:38:29 puma kernel: [39272.749761]  ? __do_sys_getpid+0x1e/0x30
Mar  8 04:38:29 puma kernel: [39272.749766]  ? do_syscall_64+0x69/0xc0
Mar  8 04:38:29 puma kernel: [39272.749767]  ? do_syscall_64+0x69/0xc0
Mar  8 04:38:29 puma kernel: [39272.749768]  ? syscall_exit_to_user_mode+0x27/0x50
Mar  8 04:38:29 puma kernel: [39272.749770]  ? do_syscall_64+0x69/0xc0
Mar  8 04:38:29 puma kernel: [39272.749772]  ? sysvec_call_function_single+0x4e/0x90
Mar  8 04:38:29 puma kernel: [39272.749774]  ? asm_sysvec_call_function_single+0xa/0x20
Mar  8 04:38:29 puma kernel: [39272.749778]  entry_SYSCALL_64_after_hwframe+0x44/0xae
Mar  8 04:38:29 puma kernel: [39272.749780] RIP: 0033:0x7ff7b4369f24
Mar  8 04:38:29 puma kernel: [39272.749782] RSP: 002b:00007ff7a9780ca0 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
Mar  8 04:38:29 puma kernel: [39272.749785] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff7b4369f24
Mar  8 04:38:29 puma kernel: [39272.749786] RDX: 00000000000000c2 RSI: 00001ea408833680 RDI: 00000000ffffff9c
Mar  8 04:38:29 puma kernel: [39272.749787] RBP: 00001ea408833680 R08: 0000000000000000 R09: 00000000000098ca
Mar  8 04:38:29 puma kernel: [39272.749788] R10: 0000000000000180 R11: 0000000000000293 R12: 00000000000000c2
Mar  8 04:38:29 puma kernel: [39272.749789] R13: 00007ff7b4414100 R14: 00007ff7a9780d40 R15: 8421084210842109
Mar  8 04:38:29 puma kernel: [39272.749792]  </TASK>
Mar  8 04:38:29 puma kernel: [39272.749811] INFO: task ThreadPoolForeg:53617 blocked for more than 120 seconds.
Mar  8 04:38:29 puma kernel: [39272.752007]       Tainted: G           OE     5.15.15-76051515-generic #202201160435~1642693824~20.04~97db1bb-Ubuntu
Mar  8 04:38:29 puma kernel: [39272.754383] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Mar  8 04:38:29 puma kernel: [39272.756724] task:ThreadPoolForeg state:D stack:    0 pid:53617 ppid: 12209 flags:0x00004000
Mar  8 04:38:29 puma kernel: [39272.756731] Call Trace:
Mar  8 04:38:29 puma kernel: [39272.756734]  <TASK>
Mar  8 04:38:29 puma kernel: [39272.756739]  __schedule+0x2cd/0x890
Mar  8 04:38:29 puma kernel: [39272.756748]  schedule+0x4e/0xb0
Mar  8 04:38:29 puma kernel: [39272.756751]  wait_current_trans+0xd6/0x140 [btrfs]
Mar  8 04:38:29 puma kernel: [39272.756852]  ? wait_woken+0x60/0x60
Mar  8 04:38:29 puma kernel: [39272.756856]  start_transaction+0x4c5/0x5b0 [btrfs]
Mar  8 04:38:29 puma kernel: [39272.756890]  btrfs_start_transaction+0x1e/0x20 [btrfs]
Mar  8 04:38:29 puma kernel: [39272.756923]  btrfs_create+0x5d/0x200 [btrfs]
Mar  8 04:38:29 puma kernel: [39272.756954]  path_openat+0xb59/0xcb0
Mar  8 04:38:29 puma kernel: [39272.756959]  do_filp_open+0xb2/0x120
Mar  8 04:38:29 puma kernel: [39272.756961]  ? __check_object_size+0x13f/0x150
Mar  8 04:38:29 puma kernel: [39272.756965]  do_sys_openat2+0x245/0x320
Mar  8 04:38:29 puma kernel: [39272.756969]  do_sys_open+0x46/0x80
Mar  8 04:38:29 puma kernel: [39272.756971]  __x64_sys_openat+0x20/0x30
Mar  8 04:38:29 puma kernel: [39272.756974]  do_syscall_64+0x5c/0xc0
Mar  8 04:38:29 puma kernel: [39272.756976]  ? sysvec_apic_timer_interrupt+0x4e/0x90
Mar  8 04:38:29 puma kernel: [39272.756979]  ? asm_sysvec_apic_timer_interrupt+0xa/0x20
Mar  8 04:38:29 puma kernel: [39272.756983]  entry_SYSCALL_64_after_hwframe+0x44/0xae
Mar  8 04:38:29 puma kernel: [39272.756986] RIP: 0033:0x7f8d70b44ad4
Mar  8 04:38:29 puma kernel: [39272.756987] RSP: 002b:00007f8d68502f10 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
Mar  8 04:38:29 puma kernel: [39272.756990] RAX: ffffffffffffffda RBX: 00007f8d68502f90 RCX: 00007f8d70b44ad4
Mar  8 04:38:29 puma kernel: [39272.756991] RDX: 0000000000000241 RSI: 00002e5200645200 RDI: 00000000ffffff9c
Mar  8 04:38:29 puma kernel: [39272.756992] RBP: 00002e5200645200 R08: 0000000000000000 R09: 000000000000987d
Mar  8 04:38:29 puma kernel: [39272.756993] R10: 0000000000000180 R11: 0000000000000293 R12: 0000000000000241
Mar  8 04:38:29 puma kernel: [39272.756994] R13: 0000000000000241 R14: 00007f8d685030b0 R15: 0000000000008048
Mar  8 04:38:29 puma kernel: [39272.756997]  </TASK>
Mar  8 04:38:29 puma kernel: [39272.757232] INFO: task okular:50226 blocked for more than 120 seconds.
Mar  8 04:38:29 puma kernel: [39272.759559]       Tainted: G           OE     5.15.15-76051515-generic #202201160435~1642693824~20.04~97db1bb-Ubuntu
Mar  8 04:38:29 puma kernel: [39272.762105] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Mar  8 04:38:29 puma kernel: [39272.764566] task:okular          state:D stack:    0 pid:50226 ppid:  4603 flags:0x00000000
Mar  8 04:38:29 puma kernel: [39272.764576] Call Trace:
Mar  8 04:38:29 puma kernel: [39272.764578]  <TASK>
Mar  8 04:38:29 puma kernel: [39272.764582]  __schedule+0x2cd/0x890
Mar  8 04:38:29 puma kernel: [39272.764590]  ? pagevec_lookup_range_tag+0x28/0x30
Mar  8 04:38:29 puma kernel: [39272.764596]  schedule+0x4e/0xb0
Mar  8 04:38:29 puma kernel: [39272.764599]  wait_current_trans+0xd6/0x140 [btrfs]
Mar  8 04:38:29 puma kernel: [39272.764707]  ? wait_woken+0x60/0x60
Mar  8 04:38:29 puma kernel: [39272.764711]  start_transaction+0x4c5/0x5b0 [btrfs]
Mar  8 04:38:29 puma kernel: [39272.764740]  btrfs_start_transaction+0x1e/0x20 [btrfs]
Mar  8 04:38:29 puma kernel: [39272.764765]  btrfs_setsize.isra.0+0x1fb/0x570 [btrfs]
Mar  8 04:38:29 puma kernel: [39272.764798]  ? setattr_prepare+0x87/0x250
Mar  8 04:38:29 puma kernel: [39272.764802]  btrfs_setattr+0x6c/0x100 [btrfs]
Mar  8 04:38:29 puma kernel: [39272.764828]  notify_change+0x347/0x4d0
Mar  8 04:38:29 puma kernel: [39272.764831]  do_truncate+0x80/0xd0
Mar  8 04:38:29 puma kernel: [39272.764835]  ? do_truncate+0x80/0xd0
Mar  8 04:38:29 puma kernel: [39272.764838]  do_open.isra.0+0x2d9/0x3e0
Mar  8 04:38:29 puma kernel: [39272.764841]  path_openat+0x18e/0xcb0
Mar  8 04:38:29 puma kernel: [39272.764844]  do_filp_open+0xb2/0x120
Mar  8 04:38:29 puma kernel: [39272.764847]  ? __check_object_size+0x13f/0x150
Mar  8 04:38:29 puma kernel: [39272.764850]  do_sys_openat2+0x245/0x320
Mar  8 04:38:29 puma kernel: [39272.764852]  do_sys_open+0x46/0x80
Mar  8 04:38:29 puma kernel: [39272.764855]  __x64_sys_openat+0x20/0x30
Mar  8 04:38:29 puma kernel: [39272.764857]  do_syscall_64+0x5c/0xc0
Mar  8 04:38:29 puma kernel: [39272.764860]  ? do_syscall_64+0x69/0xc0
Mar  8 04:38:29 puma kernel: [39272.764861]  ? exit_to_user_mode_prepare+0x3d/0x1c0
Mar  8 04:38:29 puma kernel: [39272.764865]  ? syscall_exit_to_user_mode+0x27/0x50
Mar  8 04:38:29 puma kernel: [39272.764867]  ? __x64_sys_newstat+0x16/0x20
Mar  8 04:38:29 puma kernel: [39272.764870]  ? do_syscall_64+0x69/0xc0
Mar  8 04:38:29 puma kernel: [39272.764871]  ? syscall_exit_to_user_mode+0x27/0x50
Mar  8 04:38:29 puma kernel: [39272.764873]  ? __x64_sys_read+0x1a/0x20
Mar  8 04:38:29 puma kernel: [39272.764874]  ? do_syscall_64+0x69/0xc0
Mar  8 04:38:29 puma kernel: [39272.764875]  ? sysvec_call_function_single+0x4e/0x90
Mar  8 04:38:29 puma kernel: [39272.764877]  ? asm_sysvec_call_function_single+0xa/0x20
Mar  8 04:38:29 puma kernel: [39272.764881]  entry_SYSCALL_64_after_hwframe+0x44/0xae
Mar  8 04:38:29 puma kernel: [39272.764884] RIP: 0033:0x7f7e5bdcbf24
Mar  8 04:38:29 puma kernel: [39272.764886] RSP: 002b:00007fff6bd78600 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
Mar  8 04:38:29 puma kernel: [39272.764888] RAX: ffffffffffffffda RBX: 00007f7e50009978 RCX: 00007f7e5bdcbf24
Mar  8 04:38:29 puma kernel: [39272.764890] RDX: 0000000000080241 RSI: 00007f7e50009978 RDI: 00000000ffffff9c
Mar  8 04:38:29 puma kernel: [39272.764891] RBP: 00007f7e50009978 R08: 0000000000000000 R09: 0000000000000080
Mar  8 04:38:29 puma kernel: [39272.764892] R10: 00000000000001b6 R11: 0000000000000293 R12: 0000000000080241
Mar  8 04:38:29 puma kernel: [39272.764893] R13: 00007fff6bd78698 R14: 00005588de7f7050 R15: 00007f7e5c5d8c38
Mar  8 04:38:29 puma kernel: [39272.764896]  </TASK>
Mar  8 04:38:29 puma kernel: [39272.764905] INFO: task okular:50555 blocked for more than 120 seconds.
Mar  8 04:38:29 puma kernel: [39272.767442]       Tainted: G           OE     5.15.15-76051515-generic #202201160435~1642693824~20.04~97db1bb-Ubuntu
Mar  8 04:38:29 puma kernel: [39272.770133] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Mar  8 04:38:29 puma kernel: [39272.772812] task:okular          state:D stack:    0 pid:50555 ppid:  4577 flags:0x00000000
Mar  8 04:38:29 puma kernel: [39272.772824] Call Trace:
Mar  8 04:38:29 puma kernel: [39272.772827]  <TASK>
Mar  8 04:38:29 puma kernel: [39272.772833]  __schedule+0x2cd/0x890
Mar  8 04:38:29 puma kernel: [39272.772843]  ? pagevec_lookup_range_tag+0x28/0x30
Mar  8 04:38:29 puma kernel: [39272.772849]  schedule+0x4e/0xb0
Mar  8 04:38:29 puma kernel: [39272.772852]  wait_current_trans+0xd6/0x140 [btrfs]
Mar  8 04:38:29 puma kernel: [39272.772978]  ? wait_woken+0x60/0x60
Mar  8 04:38:29 puma kernel: [39272.772982]  start_transaction+0x4c5/0x5b0 [btrfs]
Mar  8 04:38:29 puma kernel: [39272.773013]  btrfs_start_transaction+0x1e/0x20 [btrfs]
Mar  8 04:38:29 puma kernel: [39272.773042]  btrfs_setsize.isra.0+0x1fb/0x570 [btrfs]
Mar  8 04:38:29 puma kernel: [39272.773071]  ? setattr_prepare+0x87/0x250
Mar  8 04:38:29 puma kernel: [39272.773075]  btrfs_setattr+0x6c/0x100 [btrfs]
Mar  8 04:38:29 puma kernel: [39272.773101]  notify_change+0x347/0x4d0
Mar  8 04:38:29 puma kernel: [39272.773104]  do_truncate+0x80/0xd0
Mar  8 04:38:29 puma kernel: [39272.773107]  ? do_truncate+0x80/0xd0
Mar  8 04:38:29 puma kernel: [39272.773110]  do_open.isra.0+0x2d9/0x3e0
Mar  8 04:38:29 puma kernel: [39272.773113]  path_openat+0x18e/0xcb0
Mar  8 04:38:29 puma kernel: [39272.773115]  do_filp_open+0xb2/0x120
Mar  8 04:38:29 puma kernel: [39272.773117]  ? __check_object_size+0x13f/0x150
Mar  8 04:38:29 puma kernel: [39272.773119]  ? alloc_fd+0x58/0x190
Mar  8 04:38:29 puma kernel: [39272.773122]  do_sys_openat2+0x245/0x320
Mar  8 04:38:29 puma kernel: [39272.773123]  do_sys_open+0x46/0x80
Mar  8 04:38:29 puma kernel: [39272.773126]  __x64_sys_openat+0x20/0x30
Mar  8 04:38:29 puma kernel: [39272.773128]  do_syscall_64+0x5c/0xc0
Mar  8 04:38:29 puma kernel: [39272.773132]  ? syscall_exit_to_user_mode+0x27/0x50
Mar  8 04:38:29 puma kernel: [39272.773135]  ? do_syscall_64+0x69/0xc0
Mar  8 04:38:29 puma kernel: [39272.773136]  ? syscall_exit_to_user_mode+0x27/0x50
Mar  8 04:38:29 puma kernel: [39272.773137]  ? do_syscall_64+0x69/0xc0
Mar  8 04:38:29 puma kernel: [39272.773139]  ? syscall_exit_to_user_mode+0x27/0x50
Mar  8 04:38:29 puma kernel: [39272.773140]  ? __x64_sys_read+0x1a/0x20
Mar  8 04:38:29 puma kernel: [39272.773145]  ? do_syscall_64+0x69/0xc0
Mar  8 04:38:29 puma kernel: [39272.773146]  ? syscall_exit_to_user_mode+0x27/0x50
Mar  8 04:38:29 puma kernel: [39272.773148]  ? __x64_sys_read+0x1a/0x20
Mar  8 04:38:29 puma kernel: [39272.773149]  ? do_syscall_64+0x69/0xc0
Mar  8 04:38:29 puma kernel: [39272.773150]  ? do_syscall_64+0x69/0xc0
Mar  8 04:38:29 puma kernel: [39272.773152]  ? asm_sysvec_call_function_single+0xa/0x20
Mar  8 04:38:29 puma kernel: [39272.773158]  entry_SYSCALL_64_after_hwframe+0x44/0xae
Mar  8 04:38:29 puma kernel: [39272.773160] RIP: 0033:0x7f95fffbcf24
Mar  8 04:38:29 puma kernel: [39272.773163] RSP: 002b:00007ffea495b7e0 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
Mar  8 04:38:29 puma kernel: [39272.773165] RAX: ffffffffffffffda RBX: 0000556ff1e5cc28 RCX: 00007f95fffbcf24
Mar  8 04:38:29 puma kernel: [39272.773167] RDX: 0000000000080241 RSI: 0000556ff1e5cc28 RDI: 00000000ffffff9c
Mar  8 04:38:29 puma kernel: [39272.773168] RBP: 0000556ff1e5cc28 R08: 0000000000000000 R09: 0000000000000080
Mar  8 04:38:29 puma kernel: [39272.773168] R10: 00000000000001b6 R11: 0000000000000293 R12: 0000000000080241
Mar  8 04:38:29 puma kernel: [39272.773169] R13: 00007ffea495b878 R14: 0000556ff1f6e430 R15: 00007f96007c9b10
Mar  8 04:38:29 puma kernel: [39272.773172]  </TASK>
Mar  8 04:47:45 puma kernel: [39828.147309] audit: type=1400 audit(1646732865.357:46): apparmor="ALLOWED" operation="signal" profile="libreoffice-oopslash" pid=49947 comm="oosplash" requested_mask="send" denied_mask="send" signal=kill peer="libreoffice-soffice"
Mar  8 04:47:45 puma kernel: [39828.147314] audit: type=1400 audit(1646732865.357:47): apparmor="ALLOWED" operation="signal" profile="libreoffice-soffice" pid=49947 comm="oosplash" requested_mask="receive" denied_mask="receive" signal=kill peer="libreoffice-oopslash"
Mar  8 04:47:45 puma systemd[3662]: Starting Tracker metadata database store and lookup manager...
Mar  8 04:47:45 puma dbus-daemon[3680]: [session uid=1000 pid=3680] Successfully activated service 'org.freedesktop.Tracker1'
Mar  8 04:47:45 puma org.kde.KScreen[4025]: The X11 connection broke (error 1). Did the X11 server die?

--nextPart1962993.oMNUckLgyt
Content-Type: application/octet-stream; name=""
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=""


--nextPart1962993.oMNUckLgyt--

--nextPart3169531.44csPzL39Z
Content-Type: application/octet-stream; name=""
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=""


--nextPart3169531.44csPzL39Z--

--nextPart3163476.aeNJFYEL58--



