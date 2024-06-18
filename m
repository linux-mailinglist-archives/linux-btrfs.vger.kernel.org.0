Return-Path: <linux-btrfs+bounces-5799-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0710A90DEA3
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 23:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E825D1C23480
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 21:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F201178CCD;
	Tue, 18 Jun 2024 21:43:24 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0861779A5
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2024 21:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718747003; cv=none; b=GxuPKks3C7+KI59XpWy/c1UjMwVXHEXgg3/n+8HIPjrHn10c7jVDqSbdvpuaNcuZBfebEh+LouAk5nlyl9/3PFPHk6jUzIiXvmcnRJEAic3PT6F4D6jaSDmHV6jc6OTqkHKnof+TnxsxLS05GWb1XihjMC1dEwsjp3u1MzR1ilY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718747003; c=relaxed/simple;
	bh=3VVHlOcF60rYJnvvbFTxHYeqO5l5R/y3doWXjt7aPYw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KpXuCErDEk/ntAwb5rPZ65O137sn78s41ZQSX5iyVCoradWR5V3pyAI+mUNCqBLeNFkYpFpTVdjZwxPFQ/6UW5HkjmzQYJCiGw2EoGUI653VzGhIjmZOjwHkVVweCsPelj2t4G+Ek9YiKIHvVSGnBTJFAHfwIfJwgrgJnfgRjP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7eb7e13522bso810341839f.1
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2024 14:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718747001; x=1719351801;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qiSTAgHkCtFBRjaZ7eREerJbYy2sDdDqnkwNqWdusAg=;
        b=cCDCusvKnvNdZm9V7PCSZw0Y7WjB//jrJtUzB/rE60OnHv0gRsJYKNniM3B2cLq+xo
         sNqMNigpSJ92Tgh89bMJx+UFiC75w8M1KUQ02R36KGZl07PaoZs5a/I1IlL9O4ZG2XFV
         FNQY5HxPQoVLe7x9ifd6VXH7Py/VzHgRw94E7Eef6428m/GYnHWfuAlQ65Wy6W9CFpP5
         9R18LjhSOokr6Fk25ux6zEVf8lKJ3b2H7TAzAPyUxyhtJpDvywrssxR2UMar1SCpc8dw
         9N+VhsxHgB33ZbwRPgrwj0+hj/x2xYmSvN5htz2XXoRWiybNSTTDJZm8Rh31/SfIPMRW
         3cSA==
X-Forwarded-Encrypted: i=1; AJvYcCWmu4/T5mZG7isduAyhhKqNX28SfdwZU+OwvRSA3Qgzg/CGKSJNkp/x+tQFJL4/hS3YIoJVkvO1IKa0FkkDrp1PiLUrFWa5Bjp11iU=
X-Gm-Message-State: AOJu0YzZO6XPAHjCQ94ou1rshPC4nODr2Ma8HdCER25u1zfxRXNekmPZ
	I3Zw9jog2VMtrhiBBbnXxCdiHQxnNdVRNrcaz9th50G07PJyHgR4vaiS2dK5hiUVxvAzcRVunqM
	VxLddOEW2ZxMJM3O0i/dsiNnRyNAqaSKKKedXucVXpyxPHewWH3clssM=
X-Google-Smtp-Source: AGHT+IHAKYUw6vmG7VLmCJDGOApBU7z9HuLyvf7J8iCR+Knz8pGzJfIbRdEd0UVObw3zt1wo1wNGVVh0Gae9tVG3UfTQ9dvCgVmP
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1486:b0:375:a3eb:bfb5 with SMTP id
 e9e14a558f8ab-3761d4daab0mr480485ab.0.1718747001227; Tue, 18 Jun 2024
 14:43:21 -0700 (PDT)
Date: Tue, 18 Jun 2024 14:43:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000077990d061b30f83c@google.com>
Subject: [syzbot] [btrfs?] BUG: spinlock bad magic in btrfs_stop_all_workers
From: syzbot <syzbot+9bf5c83263a4d4387899@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2ccbdf43d5e7 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10bf1a61980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=81c0d76ceef02b39
dashboard link: https://syzkaller.appspot.com/bug?extid=9bf5c83263a4d4387899
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-2ccbdf43.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/13cdb5bfbafa/vmlinux-2ccbdf43.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7a14f5d07f81/bzImage-2ccbdf43.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9bf5c83263a4d4387899@syzkaller.appspotmail.com

BTRFS info (device loop3): last unmount of filesystem 3a492a15-ac49-4ce6-945e-cef7a687c6c9
BUG: spinlock bad magic on CPU#0, syz-executor.3/7928
==================================================================
BUG: KASAN: slab-out-of-bounds in task_pid_nr include/linux/pid.h:232 [inline]
BUG: KASAN: slab-out-of-bounds in spin_dump kernel/locking/spinlock_debug.c:64 [inline]
BUG: KASAN: slab-out-of-bounds in spin_bug+0x17d/0x1d0 kernel/locking/spinlock_debug.c:78
Read of size 4 at addr ffff888028b23dd8 by task syz-executor.3/7928

CPU: 0 PID: 7928 Comm: syz-executor.3 Not tainted 6.10.0-rc3-syzkaller-00044-g2ccbdf43d5e7 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 task_pid_nr include/linux/pid.h:232 [inline]
 spin_dump kernel/locking/spinlock_debug.c:64 [inline]
 spin_bug+0x17d/0x1d0 kernel/locking/spinlock_debug.c:78
 debug_spin_lock_before kernel/locking/spinlock_debug.c:86 [inline]
 do_raw_spin_lock+0x225/0x2c0 kernel/locking/spinlock_debug.c:115
 put_pwq_unlocked kernel/workqueue.c:1662 [inline]
 put_pwq_unlocked kernel/workqueue.c:1655 [inline]
 destroy_workqueue+0x5df/0xaa0 kernel/workqueue.c:5851
 btrfs_stop_all_workers+0x10f/0x370 fs/btrfs/disk-io.c:1794
 close_ctree+0x4e3/0xf90 fs/btrfs/disk-io.c:4365
 generic_shutdown_super+0x159/0x3d0 fs/super.c:642
 kill_anon_super+0x3a/0x60 fs/super.c:1226
 btrfs_kill_super+0x3b/0x50 fs/btrfs/super.c:2096
 deactivate_locked_super+0xbe/0x1a0 fs/super.c:473
 deactivate_super+0xde/0x100 fs/super.c:506
 cleanup_mnt+0x222/0x450 fs/namespace.c:1267
 task_work_run+0x14e/0x250 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x278/0x2a0 kernel/entry/common.c:218
 __do_fast_syscall_32+0x80/0x120 arch/x86/entry/common.c:389
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf727f579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ffb86a58 EFLAGS: 00000292 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ffb86b00 RCX: 0000000000000009
RDX: 00000000f73d5ff4 RSI: 00000000f7326361 RDI: 00000000ffb87ba4
RBP: 00000000ffb86b00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 8951:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:4122 [inline]
 __kmalloc_noprof+0x1ec/0x420 mm/slub.c:4135
 kmalloc_noprof include/linux/slab.h:664 [inline]
 kzalloc_noprof include/linux/slab.h:778 [inline]
 alloc_workqueue+0xe02/0x1ca0 kernel/workqueue.c:5667
 btrfs_alloc_workqueue+0x21c/0x510 fs/btrfs/async-thread.c:112
 btrfs_init_workqueues fs/btrfs/disk-io.c:2007 [inline]
 open_ctree+0x158e/0x52e0 fs/btrfs/disk-io.c:3362
 btrfs_fill_super fs/btrfs/super.c:946 [inline]
 btrfs_get_tree_super fs/btrfs/super.c:1863 [inline]
 btrfs_get_tree+0x11e9/0x1b90 fs/btrfs/super.c:2089
 vfs_get_tree+0x8f/0x380 fs/super.c:1780
 fc_mount+0x16/0xc0 fs/namespace.c:1125
 btrfs_get_tree_subvol fs/btrfs/super.c:2052 [inline]
 btrfs_get_tree+0xa53/0x1b90 fs/btrfs/super.c:2090
 vfs_get_tree+0x8f/0x380 fs/super.c:1780
 do_new_mount fs/namespace.c:3352 [inline]
 path_mount+0x6e1/0x1f10 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount fs/namespace.c:3875 [inline]
 __ia32_sys_mount+0x295/0x320 fs/namespace.c:3875
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

The buggy address belongs to the object at ffff888028b23800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 960 bytes to the right of
 allocated 536-byte region [ffff888028b23800, ffff888028b23a18)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x28b20
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 00fff00000000040 ffff888015442dc0 ffffea0000adf200 dead000000000002
raw: 0000000000000000 0000000000100010 00000001ffffefff 0000000000000000
head: 00fff00000000040 ffff888015442dc0 ffffea0000adf200 dead000000000002
head: 0000000000000000 0000000000100010 00000001ffffefff 0000000000000000
head: 00fff00000000003 ffffea0000a2c801 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x152820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL), pid 1096, tgid 1096 (kworker/u32:9), ts 154103322344, free_ts 47027523951
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1468
 prep_new_page mm/page_alloc.c:1476 [inline]
 get_page_from_freelist+0x136a/0x2e50 mm/page_alloc.c:3420
 __alloc_pages_noprof+0x22b/0x2460 mm/page_alloc.c:4678
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x56/0x110 mm/slub.c:2265
 allocate_slab mm/slub.c:2428 [inline]
 new_slab+0x84/0x260 mm/slub.c:2481
 ___slab_alloc+0xdac/0x1870 mm/slub.c:3667
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3757
 __slab_alloc_node mm/slub.c:3810 [inline]
 slab_alloc_node mm/slub.c:3989 [inline]
 __do_kmalloc_node mm/slub.c:4121 [inline]
 __kmalloc_noprof+0x37f/0x420 mm/slub.c:4135
 kmalloc_noprof include/linux/slab.h:664 [inline]
 kzalloc_noprof include/linux/slab.h:778 [inline]
 ieee802_11_parse_elems_full+0xef/0x15b0 net/mac80211/parse.c:880
 ieee802_11_parse_elems_crc net/mac80211/ieee80211_i.h:2332 [inline]
 ieee802_11_parse_elems net/mac80211/ieee80211_i.h:2339 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1574 [inline]
 ieee80211_ibss_rx_queued_mgmt+0xc54/0x3030 net/mac80211/ibss.c:1605
 ieee80211_iface_process_skb net/mac80211/iface.c:1605 [inline]
 ieee80211_iface_work+0xc07/0xf00 net/mac80211/iface.c:1659
 cfg80211_wiphy_work+0x255/0x330 net/wireless/core.c:437
 process_one_work+0x958/0x1ad0 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
page last free pid 5221 tgid 5221 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1088 [inline]
 free_unref_page+0x64a/0xe40 mm/page_alloc.c:2583
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x192/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3941 [inline]
 slab_alloc_node mm/slub.c:4001 [inline]
 kmalloc_trace_noprof+0x11e/0x310 mm/slub.c:4148
 kmalloc_noprof include/linux/slab.h:660 [inline]
 kzalloc_noprof include/linux/slab.h:778 [inline]
 kobject_uevent_env+0x265/0x15f0 lib/kobject_uevent.c:525
 __kobject_del+0x168/0x1f0 lib/kobject.c:601
 kobject_cleanup lib/kobject.c:680 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x31c/0x5b0 lib/kobject.c:737
 netdev_queue_update_kobjects+0x4a2/0x640 net/core/net-sysfs.c:1854
 netif_set_real_num_tx_queues+0x168/0x880 net/core/dev.c:2940
 veth_init_queues+0xe1/0x190 drivers/net/veth.c:1755
 veth_newlink+0x627/0xa10 drivers/net/veth.c:1878
 rtnl_newlink_create net/core/rtnetlink.c:3510 [inline]
 __rtnl_newlink+0x119c/0x1960 net/core/rtnetlink.c:3730
 rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3743
 rtnetlink_rcv_msg+0x3c7/0xea0 net/core/rtnetlink.c:6635
 netlink_rcv_skb+0x165/0x410 net/netlink/af_netlink.c:2564

Memory state around the buggy address:
 ffff888028b23c80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888028b23d00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888028b23d80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                                    ^
 ffff888028b23e00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888028b23e80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

