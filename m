Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A572D78A517
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Aug 2023 07:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjH1FI0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Aug 2023 01:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjH1FIJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Aug 2023 01:08:09 -0400
Received: from out28-79.mail.aliyun.com (out28-79.mail.aliyun.com [115.124.28.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362FCCC
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Aug 2023 22:08:05 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04436772|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0189875-0.000724597-0.980288;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.URQgWMM_1693199273;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.URQgWMM_1693199273)
          by smtp.aliyun-inc.com;
          Mon, 28 Aug 2023 13:07:57 +0800
Date:   Mon, 28 Aug 2023 13:07:58 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Subject: fstests(btrfs/100) triggered a dead-lock(of scrub?)
Message-Id: <20230828130753.30B3.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

fstests(btrfs/100) triggered a dead-lock(of scrub?).

frequency:
	It happened once only.
	yet not reproduced by 200 times.
	but it happened on a server with ECC memory.

kernel btrfs version: 6.2 with some update applied to 6.1.y.

sysrq(-w) result:

[12462.772983] sysrq: Show Blocked State
[12462.807604] task:btrfs-transacti state:D
[12462.851608]  stack:0     pid:435693 ppid:2      flags:0x00004000
[12462.851768] Call Trace:
[12462.851891]  <TASK>
[12462.852045]  __schedule+0x2cb/0x880
[12462.852200]  schedule+0x50/0xc0
[12462.852326]  btrfs_scrub_pause+0xa9/0x110 [btrfs]
[12463.066833]  ? enqueue_task_stop+0x90/0x90
[12463.066957]  btrfs_commit_transaction+0x1cf/0xbc0 [btrfs]
[12463.281494]  ? start_transaction+0xcf/0x610 [btrfs]
[12463.496014]  ? timers_update_migration+0x10/0x30
[12463.496142]  transaction_kthread+0x173/0x1c0 [btrfs]
[12463.496297]  ? btrfs_cleanup_transaction+0x5f0/0x5f0 [btrfs]
[12463.710824]  kthread+0xe3/0x110
[12463.710951]  ? kthread_complete_and_exit+0x20/0x20
[12463.711105]  ret_from_fork+0x1f/0x30
[12463.711258]  </TASK>
[12463.711391] task:btrfs           state:D
[12463.711536]  stack:0     pid:436523 ppid:435331 flags:0x00004002
[12463.711688] Call Trace:
[12463.711821]  <TASK>
[12463.714618]  __schedule+0x2cb/0x880
[12463.714756]  schedule+0x50/0xc0
[12463.714902]  scrub_simple_mirror+0x75b/0x820 [btrfs]
[12463.715057]  ? blk_mq_plug_issue_direct.constprop.91+0x85/0x120
[12463.715180]  ? enqueue_task_stop+0x90/0x90
[12463.715307]  ? __wake_up_common_lock+0x8e/0xd0
[12463.715432]  scrub_stripe+0x33b/0x670 [btrfs]
[12463.762911]  scrub_chunk+0xc9/0x130 [btrfs]
[12463.977412]  scrub_enumerate_chunks+0x2af/0x760 [btrfs]
[12464.191921]  ? enqueue_task_stop+0x90/0x90
[12464.192042]  btrfs_scrub_dev+0x25a/0x630 [btrfs]
[12464.406545]  ? start_transaction+0xcf/0x610 [btrfs]
[12464.621032]  btrfs_dev_replace_by_ioctl.cold.14+0x254/0x2fa [btrfs]
[12464.835507]  ? _copy_from_user+0x7f/0xa0
[12464.835631]  btrfs_ioctl+0x1e30/0x26f0 [btrfs]
[12464.908312]  ? __filemap_fdatawait_range+0x71/0x140
[12464.908437]  ? __x64_sys_ioctl+0x89/0xc0
[12464.908561]  __x64_sys_ioctl+0x89/0xc0
[12464.908687]  do_syscall_64+0x58/0x80
[12464.908848]  ? __x64_sys_rt_sigaction+0xc8/0x100
[12464.909002]  ? exit_to_user_mode_prepare+0x1af/0x1c0
[12464.909130]  ? syscall_exit_to_user_mode+0x22/0x40
[12464.909285]  ? do_syscall_64+0x67/0x80
[12464.909412]  ? do_syscall_64+0x67/0x80
[12464.909565]  ? syscall_exit_to_user_mode+0x22/0x40
[12464.909727]  ? do_syscall_64+0x67/0x80
[12464.909881]  ? exc_page_fault+0x64/0x140
[12464.910007]  entry_SYSCALL_64_after_hwframe+0x64/0xce
[12464.910134] RIP: 0033:0x7f499fc3ec6b
[12464.910286] RSP: 002b:00007ffd63629078 EFLAGS: 00000246
[12464.910369] BTRFS error (device sda3): bdev /dev/mapper/error-test errs: wr 22, rd 3091, flush 0, corrupt 0, gen 0
[12464.910412]  ORIG_RAX: 0000000000000010
[12464.910646] BTRFS error (device sda3): fixed up error at logical 3266019328 on dev /dev/mapper/error-test
[12465.124932] RAX: ffffffffffffffda RBX: 00007ffd636290e0 RCX: 00007f499fc3ec6b
[12465.154546] RDX: 00007ffd63629f10 RSI: 00000000ca289435 RDI: 0000000000000003
[12465.368963] RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000000000
[12465.369118] R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000003
[12465.369270] R13: 00007ffd6362b706 R14: 0000000000000000 R15: 0000562067f582e0
[12465.369400]  </TASK>

There are a lot of message: 
# Just 'root XXX' are different in these warn messages.
[12464.835561] BTRFS warning (device sda3): i/o error at logical 3266019328 on dev /dev/mapper/error-test, physical 1114341376, root 402, inode 294, offset 3936256, length 4096, links 1 (path: p7/d8/fa)
[12464.908196] BTRFS warning (device sda3): i/o error at logical 3266019328 on dev /dev/mapper/error-test, physical 1114341376, root 401, inode 294, offset 3936256, length 4096, links 1 (path: p7/d8/fa)
[12464.908209] BTRFS warning (device sda3): i/o error at logical 3266019328 on dev /dev/mapper/error-test, physical 1114341376, root 400, inode 294, offset 3936256, length 4096, links 1 (path: p7/d8/fa)
[12464.908227] BTRFS warning (device sda3): i/o error at logical 3266019328 on dev /dev/mapper/error-test, physical 1114341376, root 399, inode 294, offset 3936256, length 4096, links 1 (path: p7/d8/fa)
[12464.908235] BTRFS warning (device sda3): i/o error at logical 3266019328 on dev /dev/mapper/error-test, physical 1114341376, root 398, inode 294, offset 3936256, length 4096, links 1 (path: 
[12460.229783] BTRFS warning (device sda3): i/o error at logical 3266019328 on dev /dev/mapper/error-test, physical 1114341376, root 499, inode 294, offset 3936256, length 4096, links 1 (path: p7/d8/f16)

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/08/28


