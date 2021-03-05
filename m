Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1046C32F456
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Mar 2021 21:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhCEUCn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 5 Mar 2021 15:02:43 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:33451 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhCEUC0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Mar 2021 15:02:26 -0500
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Mar 2021 15:02:26 EST
Received: from [192.168.177.174] ([91.56.91.134]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id 1N17gw-1lkH4j05Jy-012bRG
 for <linux-btrfs@vger.kernel.org>; Fri, 05 Mar 2021 20:57:23 +0100
From:   "Hendrik Friedel" <hendrik@friedels.name>
To:     linux-btrfs@vger.kernel.org
Subject: Code: Bad RIP value.
Date:   Fri, 05 Mar 2021 19:57:23 +0000
Message-Id: <em7cd07db3-30ce-479c-8c6b-063af06a2e69@desktop-g0r648m>
Reply-To: "Hendrik Friedel" <hendrik@friedels.name>
User-Agent: eM_Client/8.1.1054.0
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:75sW9EBDSoUAnR66Ok3K4QEsNSdIvhVoV27pfpZZMttmaQcKoos
 ZmfbMP4DZHB6XqpuMs11XghVYfEojEEXcNJZIIsjn2gtgL2OgtS1mjdNf2mYbfBPJubWMnP
 lrVw6/Ekr69CjdD+6n3QmNCzEQ2CW/sFK0+fqsi5LcE01o63V34k84XL4VaShlqXA8EhLnP
 WtPi1V+R9OfspqDwqEsiQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kWrz0pGpeVc=:0yf+v4x+aZvcXHyhnyN3nG
 8yoEINFi/yeqm2U31RtJsHal+tEbn3ewrkARNvSrzKtIekPbEeduv9yRvVTTR7LabePzZ15nE
 zDJQGWD6jzfvKaE3VgTB6ZwQCHVjPrSRF+eZGjRCPITQzelk0qFn/Wb3qZRLyIaGCiHQORRd6
 xn4SImQllB6J8serlYrS+IeYe/0C0fQd6FAvLYGi7wWZWACHHIuEfja9AYCCGrgaNhX6snVsg
 l2wioo/Wa28F3a5tesfNExCRTrwBFghYzXklQ+YPyLsv/7+7GKb/EWV2IBt74EXfp9gDLJkts
 rkuF6AcGDhJi8OPnPI8YWp8MO6Vkhv8yME58rdw7z8Gbq+83F5lOJvNy+8rdIsAi7lUdCBC9c
 lDLc3hJZlRmpc+/nrsSBBb5LDLdgbGtJXnrODLMk978HIaHOw+h1Jrm40gPniPpXEQXgxKlt4
 iA9kguXM2w==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I am using linux 5.9.1 and have experienced tracebacks in conjunction 
with btrfs and several filesystems:
btrfs fi show
Label: 'Daten'  uuid: c217331c-cf0c-49ae-86c7-48a67d1c346b
         Total devices 1 FS bytes used 54.69GiB
         devid    1 size 81.79GiB used 57.02GiB path /dev/sde2

Label: 'DockerImages'  uuid: 9b327a02-606e-4f2d-a137-27f53a5bcb03
         Total devices 1 FS bytes used 19.36GiB
         devid    1 size 29.62GiB used 19.52GiB path /dev/sdd2

Label: 'DataPool1'  uuid: c4a6a2c9-5cf0-49b8-812a-0784953f9ba3
         Total devices 2 FS bytes used 6.87TiB
         devid    1 size 7.28TiB used 6.92TiB path /dev/sda1
         devid    2 size 7.28TiB used 6.92TiB path /dev/sdi1

I have this bug several times now:

[So Feb 28 19:50:42 2021] Code: Bad RIP value.
[So Feb 28 19:50:42 2021] RSP: 002b:00007f6080e7bb70 EFLAGS: 00000293 
ORIG_RAX: 000000000000004a
[So Feb 28 19:50:42 2021] RAX: ffffffffffffffda RBX: 0000000000000028 
RCX: 00007f6087845a97
[So Feb 28 19:50:42 2021] RDX: 0000000000000000 RSI: 00007f60876bc6b6 
RDI: 0000000000000028
[So Feb 28 19:50:42 2021] RBP: 00007f6080e7bbe0 R08: 0000000000000000 
R09: 00000000ffffffff
[So Feb 28 19:50:42 2021] R10: 00007f6080e7bbe0 R11: 0000000000000293 
R12: 000055a70b3b9708
[So Feb 28 19:50:42 2021] R13: 000055a70b4b6990 R14: 00007f60869a2c00 
R15: 000055a70b3b96d0
[So Feb 28 19:50:42 2021] INFO: task smbd:459696 blocked for more than 
120 seconds.
[So Feb 28 19:50:42 2021]       Tainted: G            E     5.9.1 #1
[So Feb 28 19:50:42 2021] "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
[So Feb 28 19:50:42 2021] task:smbd            state:D stack:    0 
pid:459696 ppid:  8268 flags:0x00004004
[So Feb 28 19:50:42 2021] Call Trace:
[So Feb 28 19:50:42 2021]  __schedule+0x2b9/0x7c0
[So Feb 28 19:50:42 2021]  schedule+0x40/0xb0
[So Feb 28 19:50:42 2021]  wait_for_commit+0x58/0x80 [btrfs]
[So Feb 28 19:50:42 2021]  ? finish_wait+0x80/0x80
[So Feb 28 19:50:42 2021]  btrfs_commit_transaction+0x89c/0xa50 [btrfs]
[So Feb 28 19:50:42 2021]  ? dput.part.37+0xb5/0x2d0
[So Feb 28 19:50:42 2021]  ? btrfs_log_dentry_safe+0x54/0x70 [btrfs]
[So Feb 28 19:50:42 2021]  btrfs_sync_file+0x3bd/0x400 [btrfs]
[So Feb 28 19:50:42 2021]  do_fsync+0x38/0x70
[So Feb 28 19:50:42 2021]  __x64_sys_fsync+0x10/0x20
[So Feb 28 19:50:42 2021]  do_syscall_64+0x33/0x80
[So Feb 28 19:50:42 2021]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[So Feb 28 19:50:42 2021] RIP: 0033:0x7f6087845a97
[So Feb 28 19:50:42 2021] Code: Bad RIP value.


[Mo Mär  1 14:16:19 2021] INFO: task btrfs:651814 blocked for more than 
120 seconds.
[Mo Mär  1 14:16:19 2021]       Tainted: G            E     5.9.1 #1
[Mo Mär  1 14:16:19 2021] "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
[Mo Mär  1 14:16:19 2021] task:btrfs           state:D stack:    0 
pid:651814 ppid:     1 flags:0x00004000
[Mo Mär  1 14:16:19 2021] Call Trace:
[Mo Mär  1 14:16:19 2021]  __schedule+0x2b9/0x7c0
[Mo Mär  1 14:16:19 2021]  schedule+0x40/0xb0
[Mo Mär  1 14:16:19 2021]  wait_for_commit+0x58/0x80 [btrfs]
[Mo Mär  1 14:16:19 2021]  ? finish_wait+0x80/0x80
[Mo Mär  1 14:16:19 2021]  btrfs_wait_for_commit+0x96/0x190 [btrfs]
[Mo Mär  1 14:16:19 2021]  btrfs_inc_block_group_ro+0x53/0x170 [btrfs]
[Mo Mär  1 14:16:19 2021]  scrub_enumerate_chunks+0x1ed/0x560 [btrfs]
[Mo Mär  1 14:16:19 2021]  ? finish_wait+0x80/0x80
[Mo Mär  1 14:16:19 2021]  btrfs_scrub_dev+0x290/0x500 [btrfs]
[Mo Mär  1 14:16:19 2021]  ? _cond_resched+0x15/0x30
[Mo Mär  1 14:16:19 2021]  ? __kmalloc_track_caller+0x3fa/0x4a0
[Mo Mär  1 14:16:19 2021]  ? btrfs_ioctl+0xd31/0x2e80 [btrfs]
[Mo Mär  1 14:16:19 2021]  ? __check_object_size+0x162/0x173
[Mo Mär  1 14:16:19 2021]  btrfs_ioctl+0xd7b/0x2e80 [btrfs]
[Mo Mär  1 14:16:19 2021]  ? create_task_io_context+0x9b/0x100
[Mo Mär  1 14:16:19 2021]  ? get_task_io_context+0x43/0x80
[Mo Mär  1 14:16:19 2021]  ? __x64_sys_ioctl+0x84/0xc0
[Mo Mär  1 14:16:19 2021]  __x64_sys_ioctl+0x84/0xc0
[Mo Mär  1 14:16:19 2021]  do_syscall_64+0x33/0x80
[Mo Mär  1 14:16:19 2021]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[Mo Mär  1 14:16:19 2021] RIP: 0033:0x7f90f2ba8427
[Mo Mär  1 14:16:19 2021] Code: Bad RIP value.
[Mo Mär  1 14:16:19 2021] RSP: 002b:00007f90f22b2d48 EFLAGS: 00000246 
ORIG_RAX: 0000000000000010
[Mo Mär  1 14:16:19 2021] RAX: ffffffffffffffda RBX: 0000557ef3bd6930 
RCX: 00007f90f2ba8427
[Mo Mär  1 14:16:19 2021] RDX: 0000557ef3bd6930 RSI: 00000000c400941b 
RDI: 0000000000000003
[Mo Mär  1 14:16:19 2021] RBP: 0000000000000000 R08: 00007f90f22b3700 
R09: 0000000000000000
[Mo Mär  1 14:16:19 2021] R10: 00007f90f22b3700 R11: 0000000000000246 
R12: 00007ffe8308792e
[Mo Mär  1 14:16:19 2021] R13: 00007ffe8308792f R14: 00007f90f22b3700 
R15: 0000000000000000
[Mo Mär  1 16:02:45 2021] BTRFS info (device sda1): scrub: finished on 
devid 1 with status: 0

Is this a known bug?


I am happy to provide more information if needed.

Best regards,
Hendrik

