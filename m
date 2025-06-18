Return-Path: <linux-btrfs+bounces-14774-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49021ADEEB9
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Jun 2025 16:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C43D47A7A25
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Jun 2025 14:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6E52EAB7B;
	Wed, 18 Jun 2025 14:02:35 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECCB2EA730
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Jun 2025 14:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750255355; cv=none; b=Y8o3FP2OwmOocsABdiU08b2cSIreOdiKrtk9FYwuNrohO6mGrUbSlmL0nZa53uwTxtc3qZHvPZWlBB/2J8lBYWhwpYya8xERavx3k/p6JfYn/fkA+iv3/F2LpkDDMEz2EkbJdvOoDnAvGqITWQgNYiaLYx4DJpbSy8iPlGuLu4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750255355; c=relaxed/simple;
	bh=KXhpU2Ve24eHXd8yTXpOiGpk3GQo6WAr9Q19U0MaolM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=padAey65AnDQc+TqkgN6LI69FN2oQS58eTNJx16FdAesuF3UJwRyh6vsHNWbe3OyvQbdmzxrlBJoj6yhG1+PTqL0AZxJwBztN73T5dyIfcksH6y73g4ldCxHMVUHfDob+6oqJtWu+oQQ87/HJ5GDf9sGc8VsTmQB3Ap8AIKIV08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-86cf89ff625so722014539f.0
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Jun 2025 07:02:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750255352; x=1750860152;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ntd9PxniXjDq4q0uA7Uyz7QC84lfb40IrderiEeEVv8=;
        b=lrbR5Q+l2GauSHcAU9aA1EPrkdYh4inQT1I0/zkFoIKvVc9mcmLjvX9jBgMXZ6aYPg
         Dv1vAxypYf5X/n2oHIbzTqEHaKlIK6r12V2j4KPN1fgpSwiRcxQfyNxJD98t9n2ZSEOS
         qSX3AM/C9mRE8LYdUYPmNGO9+K373TZp1ClrDb67bnxGRF0s2kLNFafQp86d1eC/bjz6
         jUvwVVu5VHg7y8XsEbwabInxKsAyMTcwDh2B61olhKmAd2rZsI6HZTB3ms4QeqjxhDGC
         4IMEnRXw86hFGKBUNztSkLIGyUah4hd7B8R6awsHaUMsynmQjPRYG5YEXfYr9YBVWImH
         xp4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWYRbBsU8eWjzigPGMSW4OjSFbeKa9EyVjK9b8pEBaMdLt4gah2+6FwegRjXX/jvw8MTp42m1j3LCrr7g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0JB7bT4vMKee3BsLAZ8jEZYaevJUJkyAfrHzaEr9MU5ADCYLL
	TmOJ7gKIfCSLc2MPLagVgzZX7PFBNvbpLhUZQqGl+sMxPI8+z5d42rLW2YBz+F6soPmanpESPBD
	sPlZcqhkcTFxhttOfVde22fn6zEZNBNEADDXRL9KRTnI4/SO2HYGGAM42fxw=
X-Google-Smtp-Source: AGHT+IEtQArsvNFrcA5xShXceXZ8Pau/kPKg0IsSHpswiw0M3EncMJitmEfmtNyBfEMo9Lrro7/wtq1OFfDeFK3FXG9EIa4HqSP5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180a:b0:3dd:dd41:d3dc with SMTP id
 e9e14a558f8ab-3de07c933cdmr195525115ab.1.1750255350150; Wed, 18 Jun 2025
 07:02:30 -0700 (PDT)
Date: Wed, 18 Jun 2025 07:02:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6852c6f6.050a0220.216029.0018.GAE@google.com>
Subject: [syzbot] [net?] [btrfs?] KASAN: slab-use-after-free Read in lane_ioctl
From: syzbot <syzbot+8b64dec3affaed7b3af5@syzkaller.appspotmail.com>
To: clm@fb.com, davem@davemloft.net, dsterba@suse.com, edumazet@google.com, 
	horms@kernel.org, josef@toxicpanda.com, kuba@kernel.org, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    08215f5486ec Merge tag 'kbuild-fixes-v6.16' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15cfe5d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3cbb3640332ed0b6
dashboard link: https://syzkaller.appspot.com/bug?extid=8b64dec3affaed7b3af5
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1217690c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7406a1c79f34/disk-08215f54.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8671cabd2e5d/vmlinux-08215f54.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b69b404c65fd/bzImage-08215f54.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/231e61dc6bc7/mount_4.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=16e0ee82580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8b64dec3affaed7b3af5@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in lecd_attach net/atm/lec.c:751 [inline]
BUG: KASAN: slab-use-after-free in lane_ioctl+0x2224/0x23e0 net/atm/lec.c:1008
Read of size 8 at addr ffff88807c7b8e68 by task syz.1.17/6142

CPU: 1 UID: 0 PID: 6142 Comm: syz.1.17 Not tainted 6.16.0-rc1-syzkaller-00239-g08215f5486ec #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xcd/0x680 mm/kasan/report.c:521
 kasan_report+0xe0/0x110 mm/kasan/report.c:634
 lecd_attach net/atm/lec.c:751 [inline]
 lane_ioctl+0x2224/0x23e0 net/atm/lec.c:1008
 do_vcc_ioctl+0x12c/0x930 net/atm/ioctl.c:159
 sock_do_ioctl+0x118/0x280 net/socket.c:1190
 sock_ioctl+0x227/0x6b0 net/socket.c:1311
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc55f38e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc56028f038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fc55f5b5fa0 RCX: 00007fc55f38e929
RDX: 0000000000000000 RSI: 00000000000061d0 RDI: 0000000000000005
RBP: 00007fc55f410b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fc55f5b5fa0 R15: 00007fff0ede2e48
 </TASK>

Allocated by task 6132:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4328 [inline]
 __kvmalloc_node_noprof+0x27b/0x620 mm/slub.c:5015
 alloc_netdev_mqs+0xd2/0x1570 net/core/dev.c:11711
 lecd_attach net/atm/lec.c:737 [inline]
 lane_ioctl+0x17db/0x23e0 net/atm/lec.c:1008
 do_vcc_ioctl+0x12c/0x930 net/atm/ioctl.c:159
 sock_do_ioctl+0x118/0x280 net/socket.c:1190
 sock_ioctl+0x227/0x6b0 net/socket.c:1311
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6132:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2381 [inline]
 slab_free mm/slub.c:4643 [inline]
 kfree+0x2b4/0x4d0 mm/slub.c:4842
 free_netdev+0x6c5/0x910 net/core/dev.c:11892
 lecd_attach net/atm/lec.c:744 [inline]
 lane_ioctl+0x1ce8/0x23e0 net/atm/lec.c:1008
 do_vcc_ioctl+0x12c/0x930 net/atm/ioctl.c:159
 sock_do_ioctl+0x118/0x280 net/socket.c:1190
 sock_ioctl+0x227/0x6b0 net/socket.c:1311
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88807c7b8000
 which belongs to the cache kmalloc-cg-4k of size 4096
The buggy address is located 3688 bytes inside of
 freed 4096-byte region [ffff88807c7b8000, ffff88807c7b9000)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88807c7be000 pfn:0x7c7b8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888077790a81
flags: 0xfff00000000240(workingset|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000240 ffff88801b84b500 ffffea00016b0210 ffffea0000a38c10
raw: ffff88807c7be000 0000000000040001 00000000f5000000 ffff888077790a81
head: 00fff00000000240 ffff88801b84b500 ffffea00016b0210 ffffea0000a38c10
head: ffff88807c7be000 0000000000040001 00000000f5000000 ffff888077790a81
head: 00fff00000000003 ffffea0001f1ee01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5876, tgid 5876 (syz-executor), ts 115146069114, free_ts 115116949410
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1c0/0x230 mm/page_alloc.c:1704
 prep_new_page mm/page_alloc.c:1712 [inline]
 get_page_from_freelist+0x1321/0x3890 mm/page_alloc.c:3669
 __alloc_frozen_pages_noprof+0x261/0x23f0 mm/page_alloc.c:4959
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2419
 alloc_slab_page mm/slub.c:2451 [inline]
 allocate_slab mm/slub.c:2619 [inline]
 new_slab+0x23b/0x330 mm/slub.c:2673
 ___slab_alloc+0xd9c/0x1940 mm/slub.c:3859
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3949
 __slab_alloc_node mm/slub.c:4024 [inline]
 slab_alloc_node mm/slub.c:4185 [inline]
 __do_kmalloc_node mm/slub.c:4327 [inline]
 __kmalloc_noprof+0x2f2/0x510 mm/slub.c:4340
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 __register_sysctl_table+0xb3/0x1900 fs/proc/proc_sysctl.c:1376
 __addrconf_sysctl_register+0x1a2/0x360 net/ipv6/addrconf.c:7248
 addrconf_sysctl_register net/ipv6/addrconf.c:7296 [inline]
 addrconf_sysctl_register+0x15f/0x1f0 net/ipv6/addrconf.c:7285
 ipv6_add_dev+0xb39/0x15f0 net/ipv6/addrconf.c:458
 addrconf_notify+0x53e/0x19e0 net/ipv6/addrconf.c:3654
 notifier_call_chain+0xbc/0x410 kernel/notifier.c:85
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:2230
 call_netdevice_notifiers_extack net/core/dev.c:2268 [inline]
 call_netdevice_notifiers net/core/dev.c:2282 [inline]
 register_netdevice+0x182e/0x2270 net/core/dev.c:11143
page last free pid 5880 tgid 5880 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1248 [inline]
 __free_frozen_pages+0x7fe/0x1180 mm/page_alloc.c:2706
 discard_slab mm/slub.c:2717 [inline]
 __put_partials+0x16d/0x1c0 mm/slub.c:3186
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4d/0x120 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4148 [inline]
 slab_alloc_node mm/slub.c:4197 [inline]
 __do_kmalloc_node mm/slub.c:4327 [inline]
 __kmalloc_noprof+0x1d4/0x510 mm/slub.c:4340
 kmalloc_noprof include/linux/slab.h:909 [inline]
 tomoyo_realpath_from_path+0xc2/0x6e0 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x274/0x460 security/tomoyo/file.c:822
 security_inode_getattr+0x116/0x290 security/security.c:2377
 vfs_getattr fs/stat.c:259 [inline]
 vfs_fstat+0x4b/0xe0 fs/stat.c:281
 __do_sys_newfstat+0x87/0x100 fs/stat.c:555
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88807c7b8d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807c7b8d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807c7b8e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                          ^
 ffff88807c7b8e80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807c7b8f00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
==================================================================
BUG: KASAN: slab-use-after-free in lec_arp_init net/atm/lec.c:1239 [inline]
BUG: KASAN: slab-use-after-free in lecd_attach net/atm/lec.c:754 [inline]
BUG: KASAN: slab-use-after-free in lane_ioctl+0x1d43/0x23e0 net/atm/lec.c:1008
Write of size 8 at addr ffff88807c7b8d90 by task syz.1.17/6142

CPU: 0 UID: 0 PID: 6142 Comm: syz.1.17 Tainted: G    B               6.16.0-rc1-syzkaller-00239-g08215f5486ec #0 PREEMPT(full) 
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xcd/0x680 mm/kasan/report.c:521
 kasan_report+0xe0/0x110 mm/kasan/report.c:634
 lec_arp_init net/atm/lec.c:1239 [inline]
 lecd_attach net/atm/lec.c:754 [inline]
 lane_ioctl+0x1d43/0x23e0 net/atm/lec.c:1008
 do_vcc_ioctl+0x12c/0x930 net/atm/ioctl.c:159
 sock_do_ioctl+0x118/0x280 net/socket.c:1190
 sock_ioctl+0x227/0x6b0 net/socket.c:1311
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc55f38e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc56028f038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fc55f5b5fa0 RCX: 00007fc55f38e929
RDX: 0000000000000000 RSI: 00000000000061d0 RDI: 0000000000000005
RBP: 00007fc55f410b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fc55f5b5fa0 R15: 00007fff0ede2e48
 </TASK>

Allocated by task 6132:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4328 [inline]
 __kvmalloc_node_noprof+0x27b/0x620 mm/slub.c:5015
 alloc_netdev_mqs+0xd2/0x1570 net/core/dev.c:11711
 lecd_attach net/atm/lec.c:737 [inline]
 lane_ioctl+0x17db/0x23e0 net/atm/lec.c:1008
 do_vcc_ioctl+0x12c/0x930 net/atm/ioctl.c:159
 sock_do_ioctl+0x118/0x280 net/socket.c:1190
 sock_ioctl+0x227/0x6b0 net/socket.c:1311
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6132:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2381 [inline]
 slab_free mm/slub.c:4643 [inline]
 kfree+0x2b4/0x4d0 mm/slub.c:4842
 free_netdev+0x6c5/0x910 net/core/dev.c:11892
 lecd_attach net/atm/lec.c:744 [inline]
 lane_ioctl+0x1ce8/0x23e0 net/atm/lec.c:1008
 do_vcc_ioctl+0x12c/0x930 net/atm/ioctl.c:159
 sock_do_ioctl+0x118/0x280 net/socket.c:1190
 sock_ioctl+0x227/0x6b0 net/socket.c:1311
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88807c7b8000
 which belongs to the cache kmalloc-cg-4k of size 4096
The buggy address is located 3472 bytes inside of
 freed 4096-byte region [ffff88807c7b8000, ffff88807c7b9000)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7c7b8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888077790a81
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b84b500 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000040004 00000000f5000000 ffff888077790a81
head: 00fff00000000040 ffff88801b84b500 0000000000000000 dead000000000001
head: 0000000000000000 0000000000040004 00000000f5000000 ffff888077790a81
head: 00fff00000000003 ffffea0001f1ee01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5876, tgid 5876 (syz-executor), ts 115146069114, free_ts 115116949410
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1c0/0x230 mm/page_alloc.c:1704
 prep_new_page mm/page_alloc.c:1712 [inline]
 get_page_from_freelist+0x1321/0x3890 mm/page_alloc.c:3669
 __alloc_frozen_pages_noprof+0x261/0x23f0 mm/page_alloc.c:4959
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2419
 alloc_slab_page mm/slub.c:2451 [inline]
 allocate_slab mm/slub.c:2619 [inline]
 new_slab+0x23b/0x330 mm/slub.c:2673
 ___slab_alloc+0xd9c/0x1940 mm/slub.c:3859
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3949
 __slab_alloc_node mm/slub.c:4024 [inline]
 slab_alloc_node mm/slub.c:4185 [inline]
 __do_kmalloc_node mm/slub.c:4327 [inline]
 __kmalloc_noprof+0x2f2/0x510 mm/slub.c:4340
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 __register_sysctl_table+0xb3/0x1900 fs/proc/proc_sysctl.c:1376
 __addrconf_sysctl_register+0x1a2/0x360 net/ipv6/addrconf.c:7248
 addrconf_sysctl_register net/ipv6/addrconf.c:7296 [inline]
 addrconf_sysctl_register+0x15f/0x1f0 net/ipv6/addrconf.c:7285
 ipv6_add_dev+0xb39/0x15f0 net/ipv6/addrconf.c:458
 addrconf_notify+0x53e/0x19e0 net/ipv6/addrconf.c:3654
 notifier_call_chain+0xbc/0x410 kernel/notifier.c:85
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:2230
 call_netdevice_notifiers_extack net/core/dev.c:2268 [inline]
 call_netdevice_notifiers net/core/dev.c:2282 [inline]
 register_netdevice+0x182e/0x2270 net/core/dev.c:11143
page last free pid 5880 tgid 5880 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1248 [inline]
 __free_frozen_pages+0x7fe/0x1180 mm/page_alloc.c:2706
 discard_slab mm/slub.c:2717 [inline]
 __put_partials+0x16d/0x1c0 mm/slub.c:3186
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4d/0x120 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4148 [inline]
 slab_alloc_node mm/slub.c:4197 [inline]
 __do_kmalloc_node mm/slub.c:4327 [inline]
 __kmalloc_noprof+0x1d4/0x510 mm/slub.c:4340
 kmalloc_noprof include/linux/slab.h:909 [inline]
 tomoyo_realpath_from_path+0xc2/0x6e0 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x274/0x460 security/tomoyo/file.c:822
 security_inode_getattr+0x116/0x290 security/security.c:2377
 vfs_getattr fs/stat.c:259 [inline]
 vfs_fstat+0x4b/0xe0 fs/stat.c:281
 __do_sys_newfstat+0x87/0x100 fs/stat.c:555
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88807c7b8c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807c7b8d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807c7b8d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff88807c7b8e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807c7b8e80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

