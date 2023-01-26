Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50E167C995
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jan 2023 12:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237222AbjAZLRQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Jan 2023 06:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236746AbjAZLRP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Jan 2023 06:17:15 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDDD4EF1;
        Thu, 26 Jan 2023 03:17:08 -0800 (PST)
Received: from [2a02:8108:963f:de38:4bc7:2566:28bd:b73c]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pL0Fd-0000bE-VJ; Thu, 26 Jan 2023 12:17:06 +0100
Message-ID: <0ca02b1f-ab00-9fa6-aecc-c2c46d624e49@leemhuis.info>
Date:   Thu, 26 Jan 2023 12:17:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   "Linux kernel regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Wyatt Childers <kernel.dbwta@haxing.ninja>
To:     David Sterba <dsterba@suse.com>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: [Regression] Bug 216961 - Severe IO scheduling starvation issues with
 btrfs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1674731828;befd3ec7;
X-HE-SMSGID: 1pL0Fd-0000bE-VJ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, this is your Linux kernel regression tracker.

I noticed a regression report in bugzilla.kernel.org. As many (most?)
kernel developer don't keep an eye on it, I decided to forward it by
mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=216961 :

>  Wyatt Childers 2023-01-23 17:44:13 UTC
> 
> There seems to be an issue with btrfs in Kernel 6 (first seen in at least 6.0.12-300.fc37.x86_64, possibly earlier) and still observed in 6.1 (6.1.5-200.fc37.x86_64).
> 
> This has manifested in prolonged user space hangs. I first noticed this in internal tooling for my employer where simple IO operations like a trivial cp commands that typically take under 100ms (when run with many other concurrent IO operations of a similar ilk) are observing "scheduling starvation" being stalled in a disk sleep state for nearly a minute.
> 
> This also seems to be manifesting in hangs to Kwin that correlate with btrfs usage and things as routine and trivial (even on high performance systems) as system updates https://bugs.kde.org/show_bug.cgi?id=463353
> 
> I would also not be surprised if this behavior is responsible for things like this reddit thread: https://www.reddit.com/r/btrfs/comments/102or0t/btrfs_on_luks_whole_system_freezing_under_high_io/
> 
> [reply] [−] Comment 1 Wyatt Childers 2023-01-23 17:57:47 UTC
> 
> As additional context, here are some sample kernel traces (echo w > /proc/sysrq-trigger):
> 
> Dec 16 14:10:02 localhost kernel: sysrq: Show Blocked State
> Dec 16 14:10:02 localhost kernel: task:kworker/u64:6   state:D stack:    0 pid:2673507 ppid:     2 flags:0x00004000
> Dec 16 14:10:02 localhost kernel: Workqueue: btrfs-worker btrfs_work_helper
> Dec 16 14:10:02 localhost kernel: Call Trace:
> Dec 16 14:10:02 localhost kernel:  <TASK>
> Dec 16 14:10:02 localhost kernel:  __schedule+0x332/0x12c0
> Dec 16 14:10:02 localhost kernel:  ? __sbitmap_get_word+0x37/0x80
> Dec 16 14:10:02 localhost kernel:  schedule+0x5d/0xe0
> Dec 16 14:10:02 localhost kernel:  io_schedule+0x42/0x70
> Dec 16 14:10:02 localhost kernel:  blk_mq_get_tag+0x10c/0x290
> Dec 16 14:10:02 localhost kernel:  ? dequeue_task_stop+0x70/0x70
> Dec 16 14:10:02 localhost kernel:  __blk_mq_alloc_requests+0x183/0x2b0
> Dec 16 14:10:02 localhost kernel:  blk_mq_submit_bio+0x2b7/0x5b0
> Dec 16 14:10:02 localhost kernel:  __submit_bio+0xf5/0x180
> Dec 16 14:10:02 localhost kernel:  submit_bio_noacct_nocheck+0x20d/0x2a0
> Dec 16 14:10:02 localhost kernel:  btrfs_submit_bio+0x17a/0x3d0
> Dec 16 14:10:02 localhost kernel:  btrfs_work_helper+0x14b/0x380
> Dec 16 14:10:02 localhost kernel:  process_one_work+0x1c7/0x380
> Dec 16 14:10:02 localhost kernel:  worker_thread+0x4d/0x380
> Dec 16 14:10:02 localhost kernel:  ? _raw_spin_lock_irqsave+0x23/0x50
> Dec 16 14:10:02 localhost kernel:  ? rescuer_thread+0x380/0x380
> Dec 16 14:10:02 localhost kernel:  kthread+0xe9/0x110
> Dec 16 14:10:02 localhost kernel:  ? kthread_complete_and_exit+0x20/0x20
> Dec 16 14:10:02 localhost kernel:  ret_from_fork+0x22/0x30
> Dec 16 14:10:02 localhost kernel:  </TASK>
> Dec 16 14:10:02 localhost kernel: task:cp              state:D stack:    0 pid:2422766 ppid:2410777 flags:0x00000002
> Dec 16 14:10:02 localhost kernel: Call Trace:
> Dec 16 14:10:02 localhost kernel:  <TASK>
> Dec 16 14:10:02 localhost kernel:  __schedule+0x332/0x12c0
> Dec 16 14:10:02 localhost kernel:  ? btrfs_delayed_update_inode+0x102/0x1f0
> Dec 16 14:10:02 localhost kernel:  schedule+0x5d/0xe0
> Dec 16 14:10:02 localhost kernel:  io_schedule+0x42/0x70
> Dec 16 14:10:02 localhost kernel:  folio_wait_bit_common+0x12d/0x3a0
> Dec 16 14:10:02 localhost kernel:  ? filemap_alloc_folio+0xc0/0xc0
> Dec 16 14:10:02 localhost kernel:  folio_wait_writeback+0x28/0x80
> Dec 16 14:10:02 localhost kernel:  __filemap_fdatawait_range+0x7f/0x100
> Dec 16 14:10:02 localhost kernel:  filemap_fdatawait_range+0xe/0x20
> Dec 16 14:10:02 localhost kernel:  btrfs_wait_ordered_range+0x7a/0x120
> Dec 16 14:10:02 localhost kernel:  btrfs_remap_file_range+0x139/0x550
> Dec 16 14:10:02 localhost kernel:  do_clone_file_range+0xe9/0x230
> Dec 16 14:10:02 localhost kernel:  vfs_clone_file_range+0x4d/0x140
> Dec 16 14:10:02 localhost kernel:  ovl_copyfile+0x15d/0x180 [overlay]
> Dec 16 14:10:02 localhost kernel:  ovl_remap_file_range+0x6e/0xa0 [overlay]
> Dec 16 14:10:02 localhost kernel:  do_clone_file_range+0xe9/0x230
> Dec 16 14:10:02 localhost kernel:  vfs_clone_file_range+0x4d/0x140
> Dec 16 14:10:02 localhost kernel:  ioctl_file_clone+0x49/0xb0
> Dec 16 14:10:02 localhost kernel:  do_vfs_ioctl+0x77/0x950
> Dec 16 14:10:02 localhost kernel:  ? security_file_ioctl+0x3c/0x60
> Dec 16 14:10:02 localhost kernel:  __x64_sys_ioctl+0x6e/0xd0
> Dec 16 14:10:02 localhost kernel:  do_syscall_64+0x5b/0x80
> Dec 16 14:10:02 localhost kernel:  ? syscall_exit_to_user_mode+0x17/0x40
> Dec 16 14:10:02 localhost kernel:  ? do_syscall_64+0x67/0x80
> Dec 16 14:10:02 localhost kernel:  ? syscall_exit_to_user_mode+0x17/0x40
> Dec 16 14:10:02 localhost kernel:  ? do_syscall_64+0x67/0x80
> Dec 16 14:10:02 localhost kernel:  ? do_user_addr_fault+0x1ef/0x690
> Dec 16 14:10:02 localhost kernel:  ? do_syscall_64+0x67/0x80
> Dec 16 14:10:02 localhost kernel:  ? exc_page_fault+0x70/0x170
> Dec 16 14:10:02 localhost kernel:  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> Dec 16 14:10:02 localhost kernel: RIP: 0033:0x7f07d2d7dbaf
> Dec 16 14:10:02 localhost kernel: RSP: 002b:00007ffc4ba5bf40 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> Dec 16 14:10:02 localhost kernel: RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f07d2d7dbaf
> Dec 16 14:10:02 localhost kernel: RDX: 0000000000000003 RSI: 0000000040049409 RDI: 0000000000000004
> Dec 16 14:10:02 localhost kernel: RBP: 00007ffc4ba5d8cc R08: 0000000000000001 R09: 00000000000001a4
> Dec 16 14:10:02 localhost kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc4ba5c3e0
> Dec 16 14:10:02 localhost kernel: R13: 0000000000000001 R14: 0000000000000014 R15: 00007ffc4ba5c7b0
> Dec 16 14:10:02 localhost kernel:  </TASK>
> Dec 16 14:10:02 localhost kernel: task:cp              state:D stack:    0 pid:2422815 ppid:2419287 flags:0x00000002
> Dec 16 14:10:02 localhost kernel: Call Trace:
> Dec 16 14:10:02 localhost kernel:  <TASK>
> Dec 16 14:10:02 localhost kernel:  __schedule+0x332/0x12c0
> Dec 16 14:10:02 localhost kernel:  ? btrfs_dirty_inode+0x91/0xe0
> Dec 16 14:10:02 localhost kernel:  schedule+0x5d/0xe0
> Dec 16 14:10:02 localhost kernel:  io_schedule+0x42/0x70
> Dec 16 14:10:02 localhost kernel:  folio_wait_bit_common+0x12d/0x3a0
> Dec 16 14:10:02 localhost kernel:  ? filemap_alloc_folio+0xc0/0xc0
> Dec 16 14:10:02 localhost kernel:  folio_wait_writeback+0x28/0x80
> Dec 16 14:10:02 localhost kernel:  __filemap_fdatawait_range+0x7f/0x100
> Dec 16 14:10:02 localhost kernel:  filemap_fdatawait_range+0xe/0x20
> Dec 16 14:10:02 localhost kernel:  btrfs_wait_ordered_range+0x7a/0x120
> Dec 16 14:10:02 localhost kernel:  btrfs_remap_file_range+0x139/0x550
> Dec 16 14:10:02 localhost kernel:  do_clone_file_range+0xe9/0x230
> Dec 16 14:10:02 localhost kernel:  vfs_clone_file_range+0x4d/0x140
> Dec 16 14:10:02 localhost kernel:  ovl_copyfile+0x15d/0x180 [overlay]
> Dec 16 14:10:02 localhost kernel:  ovl_remap_file_range+0x6e/0xa0 [overlay]
> Dec 16 14:10:02 localhost kernel:  do_clone_file_range+0xe9/0x230
> Dec 16 14:10:02 localhost kernel:  vfs_clone_file_range+0x4d/0x140
> Dec 16 14:10:02 localhost kernel:  ioctl_file_clone+0x49/0xb0
> Dec 16 14:10:02 localhost kernel:  do_vfs_ioctl+0x77/0x950
> Dec 16 14:10:02 localhost kernel:  __x64_sys_ioctl+0x6e/0xd0
> Dec 16 14:10:02 localhost kernel:  do_syscall_64+0x5b/0x80
> Dec 16 14:10:02 localhost kernel:  ? exc_page_fault+0x70/0x170
> Dec 16 14:10:02 localhost kernel:  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> Dec 16 14:10:02 localhost kernel: RIP: 0033:0x7f1e8dc22baf
> Dec 16 14:10:02 localhost kernel: RSP: 002b:00007ffd65479d50 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> Dec 16 14:10:02 localhost kernel: RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f1e8dc22baf
> Dec 16 14:10:02 localhost kernel: RDX: 0000000000000003 RSI: 0000000040049409 RDI: 0000000000000004
> Dec 16 14:10:02 localhost kernel: RBP: 00007ffd6547b8cc R08: 0000000000000001 R09: 00000000000001a4
> Dec 16 14:10:02 localhost kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd6547a1f0
> Dec 16 14:10:02 localhost kernel: R13: 0000000000000001 R14: 0000000000000014 R15: 00007ffd6547a5c0
> Dec 16 14:10:02 localhost kernel:  </TASK>
> Dec 16 14:10:02 localhost kernel: task:cp              state:D stack:    0 pid:2422818 ppid:2421995 flags:0x00000002
> Dec 16 14:10:02 localhost kernel: Call Trace:
> Dec 16 14:10:02 localhost kernel:  <TASK>
> Dec 16 14:10:02 localhost kernel:  __schedule+0x332/0x12c0
> Dec 16 14:10:02 localhost kernel:  schedule+0x5d/0xe0
> Dec 16 14:10:02 localhost kernel:  io_schedule+0x42/0x70
> Dec 16 14:10:02 localhost kernel:  folio_wait_bit_common+0x12d/0x3a0
> Dec 16 14:10:02 localhost kernel:  ? filemap_alloc_folio+0xc0/0xc0
> Dec 16 14:10:02 localhost kernel:  folio_wait_writeback+0x28/0x80
> Dec 16 14:10:02 localhost kernel:  __filemap_fdatawait_range+0x7f/0x100
> Dec 16 14:10:02 localhost kernel:  filemap_fdatawait_range+0xe/0x20
> Dec 16 14:10:02 localhost kernel:  btrfs_wait_ordered_range+0x7a/0x120
> Dec 16 14:10:02 localhost kernel:  btrfs_remap_file_range+0x139/0x550
> Dec 16 14:10:02 localhost kernel:  do_clone_file_range+0xe9/0x230
> Dec 16 14:10:02 localhost kernel:  vfs_clone_file_range+0x4d/0x140
> Dec 16 14:10:02 localhost kernel:  ovl_copyfile+0x15d/0x180 [overlay]
> Dec 16 14:10:02 localhost kernel:  ovl_remap_file_range+0x6e/0xa0 [overlay]
> Dec 16 14:10:02 localhost kernel:  do_clone_file_range+0xe9/0x230
> Dec 16 14:10:02 localhost kernel:  vfs_clone_file_range+0x4d/0x140
> Dec 16 14:10:02 localhost kernel:  ioctl_file_clone+0x49/0xb0
> Dec 16 14:10:02 localhost kernel:  do_vfs_ioctl+0x77/0x950
> Dec 16 14:10:02 localhost kernel:  __x64_sys_ioctl+0x6e/0xd0
> Dec 16 14:10:02 localhost kernel:  do_syscall_64+0x5b/0x80
> Dec 16 14:10:02 localhost kernel:  ? syscall_exit_to_user_mode+0x17/0x40
> Dec 16 14:10:02 localhost kernel:  ? do_syscall_64+0x67/0x80
> Dec 16 14:10:02 localhost kernel:  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> Dec 16 14:10:02 localhost kernel: RIP: 0033:0x7ffa2a678baf
> Dec 16 14:10:02 localhost kernel: RSP: 002b:00007ffe77c03de0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> Dec 16 14:10:02 localhost kernel: RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007ffa2a678baf
> Dec 16 14:10:02 localhost kernel: RDX: 0000000000000003 RSI: 0000000040049409 RDI: 0000000000000004
> Dec 16 14:10:02 localhost kernel: RBP: 00007ffe77c058cc R08: 0000000000000001 R09: 00000000000001a4
> Dec 16 14:10:02 localhost kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe77c04280
> Dec 16 14:10:02 localhost kernel: R13: 0000000000000001 R14: 0000000000000014 R15: 00007ffe77c04650
> Dec 16 14:10:02 localhost kernel:  </TASK>
> Dec 16 14:10:02 localhost kernel: task:cp              state:D stack:    0 pid:2422821 ppid:2420167 flags:0x00000002
> Dec 16 14:10:02 localhost kernel: Call Trace:
> Dec 16 14:10:02 localhost kernel:  <TASK>
> Dec 16 14:10:02 localhost kernel:  __schedule+0x332/0x12c0
> Dec 16 14:10:02 localhost kernel:  ? _raw_spin_unlock_irqrestore+0x23/0x40
> Dec 16 14:10:02 localhost kernel:  schedule+0x5d/0xe0
> Dec 16 14:10:02 localhost kernel:  io_schedule+0x42/0x70
> Dec 16 14:10:02 localhost kernel:  folio_wait_bit_common+0x12d/0x3a0
> Dec 16 14:10:02 localhost kernel:  ? filemap_alloc_folio+0xc0/0xc0
> Dec 16 14:10:02 localhost kernel:  folio_wait_writeback+0x28/0x80
> Dec 16 14:10:02 localhost kernel:  __filemap_fdatawait_range+0x7f/0x100
> Dec 16 14:10:02 localhost kernel:  filemap_fdatawait_range+0xe/0x20
> Dec 16 14:10:02 localhost kernel:  btrfs_wait_ordered_range+0x7a/0x120
> Dec 16 14:10:02 localhost kernel:  btrfs_remap_file_range+0x139/0x550
> Dec 16 14:10:02 localhost kernel:  do_clone_file_range+0xe9/0x230
> Dec 16 14:10:02 localhost kernel:  vfs_clone_file_range+0x4d/0x140
> Dec 16 14:10:02 localhost kernel:  ovl_copyfile+0x15d/0x180 [overlay]
> Dec 16 14:10:02 localhost kernel:  ovl_remap_file_range+0x6e/0xa0 [overlay]
> Dec 16 14:10:02 localhost kernel:  do_clone_file_range+0xe9/0x230
> Dec 16 14:10:02 localhost kernel:  vfs_clone_file_range+0x4d/0x140
> Dec 16 14:10:02 localhost kernel:  ioctl_file_clone+0x49/0xb0
> Dec 16 14:10:02 localhost kernel:  do_vfs_ioctl+0x77/0x950
> Dec 16 14:10:02 localhost kernel:  ? security_file_ioctl+0x3c/0x60
> Dec 16 14:10:02 localhost kernel:  __x64_sys_ioctl+0x6e/0xd0
> Dec 16 14:10:02 localhost kernel:  do_syscall_64+0x5b/0x80
> Dec 16 14:10:02 localhost kernel:  ? do_syscall_64+0x67/0x80
> Dec 16 14:10:02 localhost kernel:  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> Dec 16 14:10:02 localhost kernel: RIP: 0033:0x7fafe34febaf
> Dec 16 14:10:02 localhost kernel: RSP: 002b:00007fff79bee930 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> Dec 16 14:10:02 localhost kernel: RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fafe34febaf
> Dec 16 14:10:02 localhost kernel: RDX: 0000000000000003 RSI: 0000000040049409 RDI: 0000000000000004
> Dec 16 14:10:02 localhost kernel: RBP: 00007fff79bef8f6 R08: 0000000000000001 R09: 00000000000001a4
> Dec 16 14:10:02 localhost kernel: R10: 0000000000000004 R11: 0000000000000246 R12: 00007fff79beedd0
> Dec 16 14:10:02 localhost kernel: R13: 0000000000000001 R14: 0000000000000002 R15: 00007fff79bef1a0
> Dec 16 14:10:02 localhost kernel:  </TASK>
> Dec 16 14:10:02 localhost kernel: task:cp              state:D stack:    0 pid:2422911 ppid:2401445 flags:0x00000002
> Dec 16 14:10:02 localhost kernel: Call Trace:
> Dec 16 14:10:02 localhost kernel:  <TASK>
> Dec 16 14:10:02 localhost kernel:  __schedule+0x332/0x12c0
> Dec 16 14:10:02 localhost kernel:  ? __btrfs_end_transaction+0xf8/0x240
> Dec 16 14:10:02 localhost kernel:  schedule+0x5d/0xe0
> Dec 16 14:10:02 localhost kernel:  io_schedule+0x42/0x70
> Dec 16 14:10:02 localhost kernel:  folio_wait_bit_common+0x12d/0x3a0
> Dec 16 14:10:02 localhost kernel:  ? filemap_alloc_folio+0xc0/0xc0
> Dec 16 14:10:02 localhost kernel:  folio_wait_writeback+0x28/0x80
> Dec 16 14:10:02 localhost kernel:  __filemap_fdatawait_range+0x7f/0x100
> Dec 16 14:10:02 localhost kernel:  filemap_fdatawait_range+0xe/0x20
> Dec 16 14:10:02 localhost kernel:  btrfs_wait_ordered_range+0x7a/0x120
> Dec 16 14:10:02 localhost kernel:  btrfs_remap_file_range+0x139/0x550
> Dec 16 14:10:02 localhost kernel:  do_clone_file_range+0xe9/0x230
> Dec 16 14:10:02 localhost kernel:  vfs_clone_file_range+0x4d/0x140
> Dec 16 14:10:02 localhost kernel:  ovl_copyfile+0x15d/0x180 [overlay]
> Dec 16 14:10:02 localhost kernel:  ovl_remap_file_range+0x6e/0xa0 [overlay]
> Dec 16 14:10:02 localhost kernel:  do_clone_file_range+0xe9/0x230
> Dec 16 14:10:02 localhost kernel:  vfs_clone_file_range+0x4d/0x140
> Dec 16 14:10:02 localhost kernel:  ioctl_file_clone+0x49/0xb0
> Dec 16 14:10:02 localhost kernel:  do_vfs_ioctl+0x77/0x950
> Dec 16 14:10:02 localhost kernel:  __x64_sys_ioctl+0x6e/0xd0
> Dec 16 14:10:02 localhost kernel:  do_syscall_64+0x5b/0x80
> Dec 16 14:10:02 localhost kernel:  ? exc_page_fault+0x70/0x170
> Dec 16 14:10:02 localhost kernel:  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> Dec 16 14:10:02 localhost kernel: RIP: 0033:0x7ff280aeebaf
> Dec 16 14:10:02 localhost kernel: RSP: 002b:00007ffdbfa595c0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> Dec 16 14:10:02 localhost kernel: RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007ff280aeebaf
> Dec 16 14:10:02 localhost kernel: RDX: 0000000000000003 RSI: 0000000040049409 RDI: 0000000000000004
> Dec 16 14:10:02 localhost kernel: RBP: 00007ffdbfa5a8cc R08: 0000000000000001 R09: 00000000000001a4
> Dec 16 14:10:02 localhost kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffdbfa59a60
> Dec 16 14:10:02 localhost kernel: R13: 0000000000000001 R14: 0000000000000014 R15: 00007ffdbfa59e30
> Dec 16 14:10:02 localhost kernel:  </TASK>
See the ticket for more details.


[TLDR for the rest of this mail: I'm adding this report to the list of
tracked Linux kernel regressions; the text you find below is based on a
few templates paragraphs you might have encountered already in similar
form.]

BTW, let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks (I for now
assume it was introduced between v5.19..v6.0, even if I don't know for
sure ):

#regzbot introduced: v5.19..v6.0
https://bugzilla.kernel.org/show_bug.cgi?id=216961
#regzbot title: btrfs: severe IO scheduling starvation issues with btrfs
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (e.g. the buzgzilla ticket and maybe this mail as well, if
this thread sees some discussion). See page linked in footer for details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
