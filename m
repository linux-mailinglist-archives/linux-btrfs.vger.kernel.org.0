Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E63424C34
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Oct 2021 05:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbhJGDW2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Oct 2021 23:22:28 -0400
Received: from out20-27.mail.aliyun.com ([115.124.20.27]:34166 "EHLO
        out20-27.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbhJGDW1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Oct 2021 23:22:27 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04436282|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.175669-0.00400565-0.820325;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.LVC6giB_1633576832;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.LVC6giB_1633576832)
          by smtp.aliyun-inc.com(10.147.43.230);
          Thu, 07 Oct 2021 11:20:32 +0800
Date:   Thu, 07 Oct 2021 11:20:33 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Subject: xfstest/generic/650 trigger btrfs deadlock
Message-Id: <20211007112032.A50B.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

xfstest/generic/650 trigger btrfs deadlock.

Linux kernel: 5.15.0-rc4
	https://kojipkgs.fedoraproject.org/packages/kernel/5.15.0/0.rc4.33.eln112/

Reproduce frequency: about 50%

This is the first time that we tested xfstest/generic/650, and it is the
first time that we tested kernel 5.15.x too. so it maybe a known problem
of btrfs.

When the deadlock happen, /mnt/test is fully used.
/dev/sdb1               btrfs   14G   14G     0 100% /mnt/test

This is the output of 'sysrq -w'

[    0.000000] Linux version 5.15.0-0.rc4.33.el8.x86_64 (root@T7610) (gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1), GNU ld version 2.30-93.el8) #1 SMP Tue Oct 5 08:07:58 CST 2021
<...>
[ 1080.332475] sysrq: Show Blocked State
[ 1080.333413] task:fsstress        state:D stack:    0 pid: 3541 ppid:  3539 flags:0x00004000
[ 1080.333430] Call Trace:
[ 1080.333439]  __schedule+0x37c/0x7b0
[ 1080.333456]  schedule+0x3a/0xa0
[ 1080.333468]  __reserve_bytes+0x297/0x7d0 [btrfs]
[ 1080.333663]  ? finish_wait+0x80/0x80
[ 1080.333675]  btrfs_reserve_metadata_bytes+0x29/0xd0 [btrfs]
[ 1080.333812]  btrfs_block_rsv_add+0x1e/0x50 [btrfs]
[ 1080.333944]  start_transaction+0x305/0x590 [btrfs]
[ 1080.334048]  btrfs_replace_file_extents+0xfd/0x830 [btrfs]
[ 1080.334160]  ? btrfs_search_slot+0x8e9/0x900 [btrfs]
[ 1080.334248]  ? __raw_callee_save___native_queued_spin_unlock+0x11/0x1e
[ 1080.334262]  btrfs_clone+0x477/0x7f0 [btrfs]
[ 1080.334391]  ? lock_extent_bits+0x64/0x90 [btrfs]
[ 1080.334506]  btrfs_extent_same_range+0x66/0x90 [btrfs]
[ 1080.334651]  btrfs_remap_file_range+0x429/0x4a0 [btrfs]
[ 1080.334783]  vfs_dedupe_file_range_one+0x198/0x1a0
[ 1080.334796]  vfs_dedupe_file_range+0x17b/0x1f0
[ 1080.334805]  do_vfs_ioctl+0x740/0x7f0
[ 1080.334818]  ? __do_sys_newfstat+0x53/0x60
[ 1080.334830]  __x64_sys_ioctl+0x62/0xc0
[ 1080.334839]  do_syscall_64+0x37/0x80
[ 1080.334848]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 1080.334861] RIP: 0033:0x7f5191bb662b
[ 1080.334868] RSP: 002b:00007ffe7d11ba48 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[ 1080.334877] RAX: ffffffffffffffda RBX: 0000000000000073 RCX: 00007f5191bb662b
[ 1080.334883] RDX: 0000000001d0d340 RSI: 00000000c0189436 RDI: 0000000000000003
[ 1080.334888] RBP: 0000000001d067d0 R08: 0000000001d0ed90 R09: 00007ffe7d11b695
[ 1080.334895] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000001d14f10
[ 1080.334901] R13: 0000000001d0ed88 R14: 0000000000019000 R15: 0000000000000075

[ 1080.334914] task:fsstress        state:D stack:    0 pid: 3542 ppid:  3539 flags:0x00000000
[ 1080.334924] Call Trace:
[ 1080.334928]  __schedule+0x37c/0x7b0
[ 1080.334937]  schedule+0x3a/0xa0
[ 1080.334944]  schedule_preempt_disabled+0xa/0x10
[ 1080.334952]  __mutex_lock.isra.11+0x329/0x440
[ 1080.334961]  ? free_pcp_prepare+0x210/0x2d0
[ 1080.334971]  lock_rename+0x28/0xb0
[ 1080.334977]  do_renameat2+0x22b/0x4f0
[ 1080.334987]  ? strncpy_from_user+0x41/0x1a0
[ 1080.334996]  __x64_sys_renameat2+0x4b/0x60
[ 1080.335004]  do_syscall_64+0x37/0x80
[ 1080.335011]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 1080.335021] RIP: 0033:0x7f5191b315c5
[ 1080.335026] RSP: 002b:00007ffe7d11b7f8 EFLAGS: 00000202 ORIG_RAX: 000000000000013c
[ 1080.335034] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f5191b315c5
[ 1080.335040] RDX: 00000000ffffff9c RSI: 0000000001d3eff0 RDI: 00000000ffffff9c
[ 1080.335046] RBP: 0000000000000004 R08: 0000000000000004 R09: 0000000000000007
[ 1080.335051] R10: 0000000001cff9a0 R11: 0000000000000202 R12: 00007ffe7d11baa0
[ 1080.335056] R13: 00007ffe7d11bab0 R14: 00007ffe7d11bab0 R15: 0000000000005a06



[ 1080.340893] task:fsstress        state:D stack:    0 pid: 3548 ppid:  3539 flags:0x00000000
[ 1080.340901] Call Trace:
[ 1080.340905]  __schedule+0x37c/0x7b0
[ 1080.340913]  schedule+0x3a/0xa0
[ 1080.340920]  __reserve_bytes+0x297/0x7d0 [btrfs]
[ 1080.341051]  ? finish_wait+0x80/0x80
[ 1080.341059]  btrfs_reserve_metadata_bytes+0x29/0xd0 [btrfs]
[ 1080.341189]  btrfs_block_rsv_add+0x1e/0x50 [btrfs]
[ 1080.341318]  start_transaction+0x305/0x590 [btrfs]
[ 1080.341419]  btrfs_create+0x5d/0x200 [btrfs]
[ 1080.341523]  path_openat+0xe68/0x1090
[ 1080.341533]  do_filp_open+0xb4/0x120
[ 1080.341541]  ? btrfs_file_write_iter+0xb2/0x400 [btrfs]
[ 1080.341664]  ? getname_flags+0x4a/0x1e0
[ 1080.341673]  ? __check_object_size+0x15f/0x170
[ 1080.341682]  do_sys_openat2+0x242/0x310
[ 1080.341691]  do_sys_open+0x4b/0x80
[ 1080.341700]  do_syscall_64+0x37/0x80
[ 1080.341708]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 1080.341718] RIP: 0033:0x7f5191bb0e48
[ 1080.341723] RSP: 002b:00007ffe7d11b968 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
[ 1080.341730] RAX: ffffffffffffffda RBX: 000000000000014f RCX: 00007f5191bb0e48
[ 1080.341735] RDX: 0000000000000000 RSI: 00000000000001b6 RDI: 0000000001ce9160
[ 1080.341741] RBP: 00007ffe7d11bac0 R08: 00007f5191e82bc0 R09: 00007ffe7d11b5f5
[ 1080.341747] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000001b6
[ 1080.341752] R13: 0000000000405020 R14: 0000000000000000 R15: 0000000000000000


[ 1080.344462] task:fsstress        state:D stack:    0 pid: 3551 ppid:  3539 flags:0x00000000
[ 1080.344472] Call Trace:
[ 1080.344476]  __schedule+0x37c/0x7b0
[ 1080.344483]  schedule+0x3a/0xa0
[ 1080.344491]  __reserve_bytes+0x297/0x7d0 [btrfs]
[ 1080.344625]  ? finish_wait+0x80/0x80
[ 1080.344651]  btrfs_reserve_metadata_bytes+0x29/0xd0 [btrfs]
[ 1080.344785]  btrfs_delalloc_reserve_metadata+0x144/0x340 [btrfs]
[ 1080.344914]  btrfs_delalloc_reserve_space+0x2f/0x70 [btrfs]
[ 1080.345040]  btrfs_page_mkwrite+0xa0/0x5f0 [btrfs]
[ 1080.345148]  do_page_mkwrite+0x49/0xe0
[ 1080.345159]  do_fault+0x2d5/0x430
[ 1080.345169]  __handle_mm_fault+0x722/0x7b0
[ 1080.345181]  handle_mm_fault+0xbf/0x280
[ 1080.345190]  do_user_addr_fault+0x1b0/0x640
[ 1080.345199]  exc_page_fault+0x64/0x120
[ 1080.345210]  ? asm_exc_page_fault+0x8/0x30
[ 1080.345216]  asm_exc_page_fault+0x1e/0x30
[ 1080.345222] RIP: 0033:0x7f5191b67107
[ 1080.345227] RSP: 002b:00007ffe7d11b528 EFLAGS: 00010202
[ 1080.345234] RAX: 0000000000000062 RBX: 0000000000269000 RCX: 00000000000182b5
[ 1080.345239] RDX: 00007f5192290000 RSI: 0000000000000062 RDI: 00007f5192290000
[ 1080.345245] RBP: 00000000000030d4 R08: 0000000000000003 R09: 0000000000269000
[ 1080.345251] R10: 0000000000000008 R11: 0000000000000246 R12: 0000000051eb851f
[ 1080.345256] R13: 000000000040c1e0 R14: 00000000000182b5 R15: 0000000000000000


[ 1080.346600] task:fsstress        state:D stack:    0 pid: 3554 ppid:  3539 flags:0x00004000
[ 1080.346609] Call Trace:
[ 1080.346614]  __schedule+0x37c/0x7b0
[ 1080.346622]  schedule+0x3a/0xa0
[ 1080.346645]  __reserve_bytes+0x297/0x7d0 [btrfs]
[ 1080.346780]  ? finish_wait+0x80/0x80
[ 1080.346788]  btrfs_reserve_metadata_bytes+0x29/0xd0 [btrfs]
[ 1080.346916]  btrfs_block_rsv_add+0x1e/0x50 [btrfs]
[ 1080.347041]  start_transaction+0x305/0x590 [btrfs]
[ 1080.347143]  btrfs_replace_file_extents+0xfd/0x830 [btrfs]
[ 1080.347251]  ? btrfs_search_slot+0x8e9/0x900 [btrfs]
[ 1080.347339]  ? __raw_callee_save___native_queued_spin_unlock+0x11/0x1e
[ 1080.347352]  btrfs_clone+0x477/0x7f0 [btrfs]
[ 1080.347475]  ? lock_extent_bits+0x64/0x90 [btrfs]
[ 1080.347588]  btrfs_extent_same_range+0x66/0x90 [btrfs]
[ 1080.347729]  btrfs_remap_file_range+0x429/0x4a0 [btrfs]
[ 1080.347854]  vfs_dedupe_file_range_one+0x198/0x1a0
[ 1080.347864]  vfs_dedupe_file_range+0x17b/0x1f0
[ 1080.347872]  do_vfs_ioctl+0x740/0x7f0
[ 1080.347880]  ? __do_sys_newfstat+0x53/0x60
[ 1080.347890]  __x64_sys_ioctl+0x62/0xc0
[ 1080.347898]  do_syscall_64+0x37/0x80
[ 1080.347906]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 1080.347916] RIP: 0033:0x7f5191bb662b
[ 1080.347921] RSP: 002b:00007ffe7d11ba48 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[ 1080.347929] RAX: ffffffffffffffda RBX: 000000000000006b RCX: 00007f5191bb662b
[ 1080.347935] RDX: 0000000001cfe1f0 RSI: 00000000c0189436 RDI: 0000000000000003
[ 1080.347945] RBP: 0000000001d01440 R08: 0000000001cfd910 R09: 0000000000000007
[ 1080.347950] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000001d14b10
[ 1080.347957] R13: 0000000001cfd908 R14: 000000000000c000 R15: 000000000000006d

[ 1080.349313] task:fsstress        state:D stack:    0 pid: 3556 ppid:  3539 flags:0x00000000
[ 1080.349322] Call Trace:
[ 1080.349327]  __schedule+0x37c/0x7b0
[ 1080.349335]  schedule+0x3a/0xa0
[ 1080.349343]  __reserve_bytes+0x297/0x7d0 [btrfs]
[ 1080.349477]  ? finish_wait+0x80/0x80
[ 1080.349485]  btrfs_reserve_metadata_bytes+0x29/0xd0 [btrfs]
[ 1080.349612]  btrfs_delalloc_reserve_metadata+0x144/0x340 [btrfs]
[ 1080.349758]  btrfs_buffered_write+0x261/0x7f0 [btrfs]
[ 1080.349870]  btrfs_file_write_iter+0x81/0x400 [btrfs]
[ 1080.349979]  new_sync_write+0x11f/0x1b0
[ 1080.349991]  vfs_write+0x184/0x260
[ 1080.349998]  ksys_write+0x59/0xd0
[ 1080.350004]  do_syscall_64+0x37/0x80
[ 1080.350012]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 1080.350022] RIP: 0033:0x7f5191bb0648
[ 1080.350027] RSP: 002b:00007ffe7d11b608 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[ 1080.350034] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f5191bb0648
[ 1080.350040] RDX: 000000000000c000 RSI: 0000000001d15000 RDI: 0000000000000003
[ 1080.350045] RBP: 000000000003b000 R08: 0000000001cc1080 R09: 0000000000000007
[ 1080.350050] R10: 0000000000000009 R11: 0000000000000246 R12: 0000000000005858
[ 1080.350055] R13: 000000000000c000 R14: 0000000001d15000 R15: 0000000000000000




[ 1080.356266] task:fsstress        state:D stack:    0 pid: 3562 ppid:  3539 flags:0x00000000
[ 1080.356275] Call Trace:
[ 1080.356279]  __schedule+0x37c/0x7b0
[ 1080.356287]  schedule+0x3a/0xa0
[ 1080.356294]  __reserve_bytes+0x297/0x7d0 [btrfs]
[ 1080.356423]  ? finish_wait+0x80/0x80
[ 1080.356431]  btrfs_reserve_metadata_bytes+0x29/0xd0 [btrfs]
[ 1080.356561]  btrfs_block_rsv_add+0x1e/0x50 [btrfs]
[ 1080.356707]  start_transaction+0x305/0x590 [btrfs]
[ 1080.356811]  btrfs_rename+0x1a1/0xa50 [btrfs]
[ 1080.356916]  ? generic_permission+0x27/0x200
[ 1080.356926]  vfs_rename+0x795/0xcd0
[ 1080.356935]  ? do_renameat2+0x375/0x4f0
[ 1080.356943]  do_renameat2+0x375/0x4f0
[ 1080.356954]  __x64_sys_renameat2+0x4b/0x60
[ 1080.356962]  do_syscall_64+0x37/0x80
[ 1080.356970]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 1080.356980] RIP: 0033:0x7f5191b315c5
[ 1080.356985] RSP: 002b:00007ffe7d11b7f8 EFLAGS: 00000202 ORIG_RAX: 000000000000013c
[ 1080.356992] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f5191b315c5
[ 1080.356997] RDX: 00000000ffffff9c RSI: 0000000001de2c20 RDI: 00000000ffffff9c
[ 1080.357003] RBP: 0000000000000001 R08: 0000000000000001 R09: 00007ffe7d11b5b4
[ 1080.357008] R10: 0000000001e03df0 R11: 0000000000000202 R12: 00007ffe7d11baa0
[ 1080.357013] R13: 00007ffe7d11bab0 R14: 00007ffe7d11bab0 R15: 0000000000005ae5




[ 1080.362375] task:fsstress        state:D stack:    0 pid: 3567 ppid:  3539 flags:0x00000000
[ 1080.362383] Call Trace:
[ 1080.362387]  __schedule+0x37c/0x7b0
[ 1080.362395]  schedule+0x3a/0xa0
[ 1080.362402]  __reserve_bytes+0x297/0x7d0 [btrfs]
[ 1080.362529]  ? finish_wait+0x80/0x80
[ 1080.362537]  btrfs_reserve_metadata_bytes+0x29/0xd0 [btrfs]
[ 1080.362683]  btrfs_block_rsv_add+0x1e/0x50 [btrfs]
[ 1080.362811]  start_transaction+0x305/0x590 [btrfs]
[ 1080.362913]  btrfs_dirty_inode+0xaf/0xe0 [btrfs]
[ 1080.363016]  btrfs_setattr+0x2ee/0x6a0 [btrfs]
[ 1080.363120]  ? btrfs_getxattr+0xaa/0x120 [btrfs]
[ 1080.363231]  ? __vfs_getxattr+0x51/0x70
[ 1080.363240]  notify_change+0x32c/0x4c0
[ 1080.363250]  ? chown_common+0x11d/0x1d0
[ 1080.363258]  chown_common+0x11d/0x1d0
[ 1080.363268]  do_fchownat+0x8e/0xe0
[ 1080.363276]  __x64_sys_lchown+0x21/0x30
[ 1080.363285]  do_syscall_64+0x37/0x80
[ 1080.363293]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 1080.363304] RIP: 0033:0x7f5191bb182b
[ 1080.363308] RSP: 002b:00007ffe7d11b968 EFLAGS: 00000202 ORIG_RAX: 000000000000005e
[ 1080.363316] RAX: ffffffffffffffda RBX: 000000000000a5a0 RCX: 00007f5191bb182b
[ 1080.363321] RDX: 000000000000a5a0 RSI: 000000000003210a RDI: 0000000001d2b370
[ 1080.363326] RBP: 00007ffe7d11bac0 R08: 000000000000000d R09: 0000000000000006
[ 1080.363332] R10: 00007f5191e82bc0 R11: 0000000000000202 R12: 000000000003210a
[ 1080.363337] R13: 000000000000a5a0 R14: 0000000000000000 R15: 0000000000000000

[ 1080.364702] task:fsstress        state:D stack:    0 pid: 3569 ppid:  3539 flags:0x00000000
[ 1080.364711] Call Trace:
[ 1080.364715]  __schedule+0x37c/0x7b0
[ 1080.364723]  schedule+0x3a/0xa0
[ 1080.364730]  __reserve_bytes+0x297/0x7d0 [btrfs]
[ 1080.364859]  ? finish_wait+0x80/0x80
[ 1080.364867]  btrfs_reserve_metadata_bytes+0x29/0xd0 [btrfs]
[ 1080.364995]  btrfs_block_rsv_add+0x1e/0x50 [btrfs]
[ 1080.365121]  start_transaction+0x305/0x590 [btrfs]
[ 1080.365222]  btrfs_mknod+0x62/0x200 [btrfs]
[ 1080.365328]  vfs_mknod+0x194/0x270
[ 1080.365336]  do_mknodat+0x1c8/0x230
[ 1080.365345]  __x64_sys_mknod+0x2d/0x40
[ 1080.365352]  do_syscall_64+0x37/0x80
[ 1080.365360]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 1080.365370] RIP: 0033:0x7f5191bafed1
[ 1080.365374] RSP: 002b:00007ffe7d11b968 EFLAGS: 00000246 ORIG_RAX: 0000000000000085
[ 1080.365381] RAX: ffffffffffffffda RBX: 0000000000005724 RCX: 00007f5191bafed1
[ 1080.365387] RDX: 0000000000000000 RSI: 0000000000002124 RDI: 0000000001cf77b0
[ 1080.365392] RBP: 00007ffe7d11bad0 R08: 0000000001cf77b0 R09: 00007ffe7d11b605
[ 1080.365397] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000002124
[ 1080.365402] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000


[ 1080.369427] task:fsstress        state:D stack:    0 pid: 3573 ppid:  3539 flags:0x00004000
[ 1080.369435] Call Trace:
[ 1080.369439]  __schedule+0x37c/0x7b0
[ 1080.369447]  schedule+0x3a/0xa0
[ 1080.369455]  __reserve_bytes+0x297/0x7d0 [btrfs]
[ 1080.369583]  ? finish_wait+0x80/0x80
[ 1080.369591]  btrfs_reserve_metadata_bytes+0x29/0xd0 [btrfs]
[ 1080.369735]  btrfs_block_rsv_add+0x1e/0x50 [btrfs]
[ 1080.369862]  start_transaction+0x305/0x590 [btrfs]
[ 1080.369964]  btrfs_dirty_inode+0xaf/0xe0 [btrfs]
[ 1080.370066]  btrfs_setattr+0x2ee/0x6a0 [btrfs]
[ 1080.370171]  ? btrfs_getxattr+0xaa/0x120 [btrfs]
[ 1080.370282]  ? __vfs_getxattr+0x51/0x70
[ 1080.370291]  notify_change+0x32c/0x4c0
[ 1080.370299]  ? btrfs_fallocate+0x103/0x1240 [btrfs]
[ 1080.370407]  ? chown_common+0x11d/0x1d0
[ 1080.370416]  chown_common+0x11d/0x1d0
[ 1080.370426]  do_fchownat+0x8e/0xe0
[ 1080.370435]  __x64_sys_lchown+0x21/0x30
[ 1080.370443]  do_syscall_64+0x37/0x80
[ 1080.370451]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 1080.370461] RIP: 0033:0x7f5191bb182b
[ 1080.370466] RSP: 002b:00007ffe7d11b968 EFLAGS: 00000202 ORIG_RAX: 000000000000005e
[ 1080.370474] RAX: ffffffffffffffda RBX: 000000000000000a RCX: 00007f5191bb182b
[ 1080.370480] RDX: 000000000000000a RSI: 0000000000000016 RDI: 0000000001cea6f0
[ 1080.370485] RBP: 00007ffe7d11bac0 R08: 0000000000000079 R09: 00007ffe7d11b6f4
[ 1080.370490] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000016
[ 1080.370496] R13: 000000000000000a R14: 0000000000000000 R15: 0000000000000000


[ 1080.371865] task:fsstress        state:D stack:    0 pid: 3575 ppid:  3539 flags:0x00000000
[ 1080.371873] Call Trace:
[ 1080.371877]  __schedule+0x37c/0x7b0
[ 1080.371885]  schedule+0x3a/0xa0
[ 1080.371892]  __reserve_bytes+0x297/0x7d0 [btrfs]
[ 1080.372021]  ? finish_wait+0x80/0x80
[ 1080.372029]  btrfs_reserve_metadata_bytes+0x29/0xd0 [btrfs]
[ 1080.372155]  btrfs_block_rsv_add+0x1e/0x50 [btrfs]
[ 1080.372280]  start_transaction+0x305/0x590 [btrfs]
[ 1080.372382]  btrfs_unlink+0x2b/0xd0 [btrfs]
[ 1080.372486]  vfs_unlink+0x10a/0x1d0
[ 1080.372495]  do_unlinkat+0x215/0x2b0
[ 1080.372504]  __x64_sys_unlink+0x1f/0x30
[ 1080.372511]  do_syscall_64+0x37/0x80
[ 1080.372520]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 1080.372530] RIP: 0033:0x7f5191bb216b
[ 1080.372534] RSP: 002b:00007ffe7d11b978 EFLAGS: 00000202 ORIG_RAX: 0000000000000057
[ 1080.372541] RAX: ffffffffffffffda RBX: 0000000000005786 RCX: 00007f5191bb216b
[ 1080.372547] RDX: 0000000000000004 RSI: 00007ffe7d11b950 RDI: 0000000001cf0fe0
[ 1080.372552] RBP: 00007ffe7d11bad0 R08: 00007f5191e82bc0 R09: 00007ffe7d11b6f5
[ 1080.372557] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000051eb851f
[ 1080.372562] R13: 000000000040b3d0 R14: 0000000000000000 R15: 0000000000000000


[ 1080.376591] task:fsstress        state:D stack:    0 pid: 3579 ppid:  3539 flags:0x00000000
[ 1080.376599] Call Trace:
[ 1080.376603]  __schedule+0x37c/0x7b0
[ 1080.376611]  schedule+0x3a/0xa0
[ 1080.376618]  __reserve_bytes+0x297/0x7d0 [btrfs]
[ 1080.376768]  ? finish_wait+0x80/0x80
[ 1080.376777]  btrfs_reserve_data_bytes+0x4c/0xd0 [btrfs]
[ 1080.376906]  btrfs_check_data_free_space+0x4a/0xa0 [btrfs]
[ 1080.377031]  btrfs_buffered_write+0x1f3/0x7f0 [btrfs]
[ 1080.377140]  btrfs_file_write_iter+0x81/0x400 [btrfs]
[ 1080.377248]  ? iovec_from_user.part.26+0x173/0x1c0
[ 1080.377263]  ? __kmalloc+0x179/0x2d0
[ 1080.377276]  do_iter_readv_writev+0x160/0x1c0
[ 1080.377287]  do_iter_write+0x80/0x1c0
[ 1080.377296]  vfs_writev+0x84/0x140
[ 1080.377307]  ? btrfs_file_llseek+0x38/0x270 [btrfs]
[ 1080.377414]  do_writev+0x65/0x100
[ 1080.377424]  do_syscall_64+0x37/0x80
[ 1080.377432]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 1080.377443] RIP: 0033:0x7f5191bb6718
[ 1080.377449] RSP: 002b:00007ffe7d11b5f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
[ 1080.377456] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f5191bb6718
[ 1080.377461] RDX: 00000000000000aa RSI: 0000000001dd4450 RDI: 0000000000000003
[ 1080.377467] RBP: 0000000000005a8c R08: 0000000001d303fc R09: 0000000000000002
[ 1080.377472] R10: 0000000000000001 R11: 0000000000000246 R12: 0000000001dd4450
[ 1080.377477] R13: 0000000001d2a060 R14: 00000000000000aa R15: 0000000000000096


[ 1080.380200] task:kworker/u82:4   state:D stack:    0 pid: 3594 ppid:     2 flags:0x00004000
[ 1080.380211] Workqueue: events_unbound btrfs_async_reclaim_metadata_space [btrfs]
[ 1080.380342] Call Trace:
[ 1080.380346]  __schedule+0x37c/0x7b0
[ 1080.380355]  schedule+0x3a/0xa0
[ 1080.380363]  wait_for_commit+0x5d/0x90 [btrfs]
[ 1080.380463]  ? finish_wait+0x80/0x80
[ 1080.380471]  btrfs_commit_transaction+0x778/0xac0 [btrfs]
[ 1080.380572]  ? start_transaction+0xd3/0x590 [btrfs]
[ 1080.380696]  flush_space+0x4e2/0x560 [btrfs]
[ 1080.380826]  ? __raw_callee_save___native_queued_spin_unlock+0x11/0x1e
[ 1080.380838]  ? __raw_callee_save___native_queued_spin_unlock+0x11/0x1e
[ 1080.380848]  btrfs_async_reclaim_metadata_space+0x103/0x210 [btrfs]
[ 1080.380977]  process_one_work+0x1cb/0x370
[ 1080.380990]  worker_thread+0x30/0x380
[ 1080.380999]  ? process_one_work+0x370/0x370
[ 1080.381008]  kthread+0x118/0x140
[ 1080.381016]  ? set_kthread_struct+0x40/0x40
[ 1080.381024]  ret_from_fork+0x1f/0x30

[ 1080.669347] smpboot: CPU 32 is now offline
[ 1081.716833] smpboot: Booting Node 0 Processor 9 APIC 0x18
[ 1082.613918] smpboot: CPU 14 is now offline
[ 1083.187273] smpboot: CPU 27 is now offline
[ 1083.721817] smpboot: Booting Node 1 Processor 15 APIC 0x30
[ 1084.788775] smpboot: Booting Node 1 Processor 39 APIC 0x39
[ 1085.366271] smpboot: CPU 9 is now offline
[ 1087.917842] smpboot: Booting Node 0 Processor 28 APIC 0x17
[ 1088.481803] smpboot: Booting Node 1 Processor 14 APIC 0x28
[ 1089.052816] smpboot: Booting Node 0 Processor 27 APIC 0x15
[ 1089.613801] smpboot: Booting Node 1 Processor 30 APIC 0x21
[ 1090.179773] smpboot: Booting Node 1 Processor 13 APIC 0x26
[ 1090.773944] smpboot: CPU 34 is now offline
[ 1093.350376] smpboot: CPU 13 is now offline
[ 1093.890819] x86: Booting SMP configuration:
[ 1093.890841] smpboot: Booting Node 0 Processor 1 APIC 0x2


Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/10/07


