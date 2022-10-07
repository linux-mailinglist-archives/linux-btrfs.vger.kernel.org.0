Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8247A5F749F
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Oct 2022 09:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiJGHRH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Oct 2022 03:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJGHRG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Oct 2022 03:17:06 -0400
X-Greylist: delayed 418 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 07 Oct 2022 00:17:03 PDT
Received: from naboo.endor.pl (naboo.endor.pl [91.194.229.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35341754BF
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Oct 2022 00:17:02 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by naboo.endor.pl (Postfix) with ESMTP id AFA3FA87ED6
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Oct 2022 09:10:02 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at 
Received: from naboo.endor.pl ([91.194.229.15])
        by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wpMwvoVr4zg7 for <linux-btrfs@vger.kernel.org>;
        Fri,  7 Oct 2022 09:10:00 +0200 (CEST)
Received: from [192.168.18.35] (unknown [157.25.148.26])
        (Authenticated sender: leszek@dubiel.pl)
        by naboo.endor.pl (Postfix) with ESMTPSA id 7F137A87E8E
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Oct 2022 09:10:00 +0200 (CEST)
Message-ID: <c7cb6985-b216-ab9a-b7b2-c4a4449e3caa@dubiel.pl>
Date:   Fri, 7 Oct 2022 09:09:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
To:     linux-btrfs@vger.kernel.org
Content-Language: pl-PL
From:   Leszek Dubiel <leszek@dubiel.pl>
Subject: security.capability failed
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Standard backup command over network:

                   ssh remote    "btrfs send ..."    |     btrfs receive ./



Yesterday many errors like this:

ERROR: lremovexattr ...somefile.pdf    security.capability failed: No 
data available;
ERROR: empty stream is not considered valid



What could they mean?


Thank you.




PS.

Errors occur in a local network.
Computers are connected to the same switch.




# cat /etc/issue
Debian GNU/Linux 11 \n \l



# grep Linux.version /var/log/kern.log | tail -n1
Oct  6 23:04:41 delta kernel: [    0.000000] Linux version 
5.10.0-16-amd64 (debian-kernel@lists.debian.org) (gcc-10 (Debian 
10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2) #1 
SMP Debian 5.10.127-2 (2022-07-23)



# tail -n50 var/log/kern.log
Oct  7 03:05:57 delta kernel: [14501.843157]  ? __x64_sys_ioctl+0x83/0xb0
Oct  7 03:05:57 delta kernel: [14501.843161] __x64_sys_ioctl+0x83/0xb0
Oct  7 03:05:57 delta kernel: [14501.843165] do_syscall_64+0x33/0x80
Oct  7 03:05:57 delta kernel: [14501.843170] 
entry_SYSCALL_64_after_hwframe+0x44/0xa9
Oct  7 03:05:57 delta kernel: [14501.843173] RIP: 0033:0x7f51c8eadcc7
Oct  7 03:05:57 delta kernel: [14501.843175] RSP: 002b:00007ffc2fbf5ef8 
EFLAGS: 00000246 ORIG_RAX: 0000000000000010
Oct  7 03:05:57 delta kernel: [14501.843179] RAX: ffffffffffffffda RBX: 
00007ffc2fbf5f57 RCX: 00007f51c8eadcc7
Oct  7 03:05:57 delta kernel: [14501.843181] RDX: 00007ffc2fbf5f00 RSI: 
0000000080089419 RDI: 0000000000000003
Oct  7 03:05:57 delta kernel: [14501.843183] RBP: 0000000000000003 R08: 
0000000000000000 R09: 5f6e6f69726f2f33
Oct  7 03:05:57 delta kernel: [14501.843185] R10: 0000000000000000 R11: 
0000000000000246 R12: 0000000000000007
Oct  7 03:05:57 delta kernel: [14501.843187] R13: 00007ffc2fbf5f57 R14: 
0000000000000000 R15: 00007ffc2fbf7ea5
Oct  7 03:05:57 delta kernel: [14501.843193] INFO: task btrfs:61512 
blocked for more than 120 seconds.
Oct  7 03:05:57 delta kernel: [14501.843232]       Not tainted 
5.10.0-16-amd64 #1 Debian 5.10.127-2
Oct  7 03:05:57 delta kernel: [14501.843269] "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Oct  7 03:05:57 delta kernel: [14501.843310] task:btrfs state:D 
stack:    0 pid:61512 ppid: 61510 flags:0x00000000
Oct  7 03:05:57 delta kernel: [14501.843314] Call Trace:
Oct  7 03:05:57 delta kernel: [14501.843319]  __schedule+0x282/0x870
Oct  7 03:05:57 delta kernel: [14501.843323]  schedule+0x46/0xb0
Oct  7 03:05:57 delta kernel: [14501.843327] 
rwsem_down_read_slowpath+0x18e/0x500
Oct  7 03:05:57 delta kernel: [14501.843386] 
btrfs_ioctl_subvol_getflags.isra.0+0x64/0xd0 [btrfs]
Oct  7 03:05:57 delta kernel: [14501.843443] btrfs_ioctl+0x125d/0x3050 
[btrfs]
Oct  7 03:05:57 delta kernel: [14501.843449]  ? kmem_cache_free+0xff/0x410
Oct  7 03:05:57 delta kernel: [14501.843454]  ? __x64_sys_ioctl+0x83/0xb0
Oct  7 03:05:57 delta kernel: [14501.843458] __x64_sys_ioctl+0x83/0xb0
Oct  7 03:05:57 delta kernel: [14501.843462] do_syscall_64+0x33/0x80
Oct  7 03:05:57 delta kernel: [14501.843467] 
entry_SYSCALL_64_after_hwframe+0x44/0xa9
Oct  7 03:05:57 delta kernel: [14501.843470] RIP: 0033:0x7f5b053c5cc7
Oct  7 03:05:57 delta kernel: [14501.843472] RSP: 002b:00007ffca537eaf8 
EFLAGS: 00000246 ORIG_RAX: 0000000000000010
Oct  7 03:05:57 delta kernel: [14501.843475] RAX: ffffffffffffffda RBX: 
00007ffca537eb57 RCX: 00007f5b053c5cc7
Oct  7 03:05:57 delta kernel: [14501.843477] RDX: 00007ffca537eb00 RSI: 
0000000080089419 RDI: 0000000000000003
Oct  7 03:05:57 delta kernel: [14501.843480] RBP: 0000000000000003 R08: 
0000000000000000 R09: 5f6e6f69726f2f33
Oct  7 03:05:57 delta kernel: [14501.843482] R10: 0000000000000000 R11: 
0000000000000246 R12: 0000000000000007
Oct  7 03:05:57 delta kernel: [14501.843484] R13: 00007ffca537eb57 R14: 
0000000000000000 R15: 00007ffca5380ea5
Oct  7 03:34:08 delta kernel: [16193.573724] INFO: task 
btrfs-transacti:694 blocked for more than 120 seconds.
Oct  7 03:34:08 delta kernel: [16193.573774]       Not tainted 
5.10.0-16-amd64 #1 Debian 5.10.127-2
Oct  7 03:34:08 delta kernel: [16193.573812] "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Oct  7 03:34:08 delta kernel: [16193.573854] task:btrfs-transacti 
state:D stack:    0 pid:  694 ppid:     2 flags:0x00004000
Oct  7 03:34:08 delta kernel: [16193.573860] Call Trace:
Oct  7 03:34:08 delta kernel: [16193.573872]  __schedule+0x282/0x870
Oct  7 03:34:08 delta kernel: [16193.573879]  schedule+0x46/0xb0
Oct  7 03:34:08 delta kernel: [16193.573947] wait_for_commit+0x58/0x80 
[btrfs]
Oct  7 03:34:08 delta kernel: [16193.573955]  ? 
add_wait_queue_exclusive+0x70/0x70
Oct  7 03:34:08 delta kernel: [16193.574003] 
btrfs_commit_transaction+0x907/0xb40 [btrfs]
Oct  7 03:34:08 delta kernel: [16193.574053]  ? 
start_transaction+0xd2/0x580 [btrfs]
Oct  7 03:34:08 delta kernel: [16193.574057]  ? schedule_timeout+0x40/0x140
Oct  7 03:34:08 delta kernel: [16193.574106] 
transaction_kthread+0x14c/0x170 [btrfs]
Oct  7 03:34:08 delta kernel: [16193.574153]  ? 
btrfs_cleanup_transaction.isra.0+0x590/0x590 [btrfs]
Oct  7 03:34:08 delta kernel: [16193.574158]  kthread+0x11b/0x140
Oct  7 03:34:08 delta kernel: [16193.574161]  ? 
__kthread_bind_mask+0x60/0x60
Oct  7 03:34:08 delta kernel: [16193.574166] ret_from_fork+0x22/0x30



