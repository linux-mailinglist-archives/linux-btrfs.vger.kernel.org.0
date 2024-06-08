Return-Path: <linux-btrfs+bounces-5576-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0F89013B2
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Jun 2024 23:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB4A81C20C62
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Jun 2024 21:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7389C25634;
	Sat,  8 Jun 2024 21:42:28 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0691CA9C
	for <linux-btrfs@vger.kernel.org>; Sat,  8 Jun 2024 21:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717882948; cv=none; b=ElBwhZ0XGKkbBiKdhR14jJbncaNNJCsSH/PFJtxZjWP0ILYNezlycwy8fjdtjQnqjlsuJo/e7YnumPv5owSWbxhbcw0ELOdVT8OPk0ifQBi6fBnwF43baa//xwx6h2FSf0tz2g8ZekjsxdkjZ72MFVAz5Ab7QJSmA7IL+boQ8d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717882948; c=relaxed/simple;
	bh=QrRoVn362RvLOnu1Jm5SrPMmamaUXY3DA+GQfPgAPI0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GgoMaa30AVV1fYnfa6L6UYtPyAQuNjfHDUejYRmoLzeqKfI6D7cp2WWyds9eBZE+UHmx3FZNrpqwBAYXtpnDnj57iUL/NE1pnSxRRry5LK03UkxcamiF7KZU0FIxVaCn+35mIvwczEqAnG5+O50yc+ortEq4T7HY6e+zDP4TiWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-36db3bbf931so36988475ab.0
        for <linux-btrfs@vger.kernel.org>; Sat, 08 Jun 2024 14:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717882945; x=1718487745;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k7y31Q2sjs6Z5BHxHAW2On4bfxC5J5GXH1wgyOHzTDU=;
        b=NE1zHeGLDK7sQyKYye1ui4wWd//tW2n/lZeXvmrdw2zOaDqqL5kJCfHeSwaKQWarCy
         1jT9ILNF4JCV654seEbv98cEQoItEDIXSh1ESfL7GVKoKJczu2szMIkJGXKxCN6bsJXq
         O1HCzd0cGES/8rVj17onnHo4bjO9JItIqhlbh3yJR4eiPMnUqFv2vPC0qy+NHMn9x+68
         7QDqpGCc4jo2Q+xuhRtv0PUe4xbGmhCEbj2MmWkyFRtxBcrOu4mCzm9qTdLjG9I19WDg
         5t+p3NkkSyVzhbxwG0CzdMSeaQ0CBTD/NdpTHQGhInKKbdHxzh7DWBs/MZccl66TgIxP
         Qgzg==
X-Forwarded-Encrypted: i=1; AJvYcCXRZYvH9XtrL7skYJShQlThO/erlKM7wTIh+IRonaY/MeR4o+6mTPjhdmrICHe19xupWyTOqikdsuPHAIKHS3ppVoeZulbGw/XZqts=
X-Gm-Message-State: AOJu0YyxlwTRZVKlYCpu8lMn+Hh2RRd6+y/mYvhagSCvdtfQlFGQQ543
	ssr1JNnbWE94lUS3KaJVLjdWnIGv4wJST2vuErxQvCaKSHtlyLOu+i9pn3UgZ2FXcpmKLajg/T2
	EYDajWlkWViyl74LfqkeD6acgS0ZpB3A5A8DbjroCtftf/SX8OpvEeu4=
X-Google-Smtp-Source: AGHT+IF2FmiI87GbAPaGWrGIgbfWbNs8XdumyRKjkl+bSgTXfML4q8Unn9B3OtqCt8WQF5Ze6XBt3bTT/uTF+pu+bCgahwPG4Tn2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca48:0:b0:374:a76b:2c76 with SMTP id
 e9e14a558f8ab-37580404e3emr4992815ab.5.1717882945537; Sat, 08 Jun 2024
 14:42:25 -0700 (PDT)
Date: Sat, 08 Jun 2024 14:42:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bc19ba061a67ca77@google.com>
Subject: [syzbot] [btrfs?] KASAN: slab-out-of-bounds Read in btrfs_qgroup_inherit
From: syzbot <syzbot+a0d1f7e26910be4dc171@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, fdmanana@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, wqu@suse.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2ab795141095 Merge tag 'cxl-fixes-6.10-rc3' of git://git.k..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10a189ba980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eb72437243175f22
dashboard link: https://syzkaller.appspot.com/bug?extid=a0d1f7e26910be4dc171
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d4179a980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e69a16980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ee6757748831/disk-2ab79514.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8169be68b124/vmlinux-2ab79514.xz
kernel image: https://storage.googleapis.com/syzbot-assets/023da2bf5a00/bzImage-2ab79514.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/ef7a34a3b3e5/mount_0.gz

The issue was bisected to:

commit b5357cb268c41b4e2b7383d2759fc562f5b58c33
Author: Qu Wenruo <wqu@suse.com>
Date:   Sat Apr 20 07:50:27 2024 +0000

    btrfs: qgroup: do not check qgroup inherit if qgroup is disabled

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12e282ce980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11e282ce980000
console output: https://syzkaller.appspot.com/x/log.txt?x=16e282ce980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a0d1f7e26910be4dc171@syzkaller.appspotmail.com
Fixes: b5357cb268c4 ("btrfs: qgroup: do not check qgroup inherit if qgroup is disabled")

==================================================================
BUG: KASAN: slab-out-of-bounds in btrfs_qgroup_inherit+0x42e/0x2e20 fs/btrfs/qgroup.c:3277
Read of size 8 at addr ffff88814628ca50 by task syz-executor318/5171

CPU: 0 PID: 5171 Comm: syz-executor318 Not tainted 6.10.0-rc2-syzkaller-00010-g2ab795141095 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 btrfs_qgroup_inherit+0x42e/0x2e20 fs/btrfs/qgroup.c:3277
 create_pending_snapshot+0x1359/0x29b0 fs/btrfs/transaction.c:1854
 create_pending_snapshots+0x195/0x1d0 fs/btrfs/transaction.c:1922
 btrfs_commit_transaction+0xf20/0x3740 fs/btrfs/transaction.c:2382
 create_snapshot+0x6a1/0x9e0 fs/btrfs/ioctl.c:875
 btrfs_mksubvol+0x58f/0x710 fs/btrfs/ioctl.c:1029
 btrfs_mksnapshot+0xb5/0xf0 fs/btrfs/ioctl.c:1075
 __btrfs_ioctl_snap_create+0x387/0x4b0 fs/btrfs/ioctl.c:1340
 btrfs_ioctl_snap_create_v2+0x1f2/0x3a0 fs/btrfs/ioctl.c:1422
 btrfs_ioctl+0x99e/0xc60
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcbf1992509
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fcbf1928218 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fcbf1a1f618 RCX: 00007fcbf1992509
RDX: 0000000020000280 RSI: 0000000050009417 RDI: 0000000000000003
RBP: 00007fcbf1a1f610 R08: 00007ffea1298e97 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fcbf19eb660
R13: 00000000200002b8 R14: 00007fcbf19e60c0 R15: 0030656c69662f2e
 </TASK>

Allocated by task 5171:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:4121 [inline]
 kmalloc_node_track_caller_noprof+0x225/0x440 mm/slub.c:4141
 memdup_user+0x2b/0xc0 mm/util.c:214
 btrfs_ioctl_snap_create_v2+0x2fd/0x3a0 fs/btrfs/ioctl.c:1411
 btrfs_ioctl+0x99e/0xc60
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88814628ca00
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 0 bytes to the right of
 allocated 80-byte region [ffff88814628ca00, ffff88814628ca50)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x14628c
flags: 0x57ff00000000000(node=1|zone=2|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 057ff00000000000 ffff888015041280 dead000000000100 dead000000000122
raw: 0000000000000000 0000000080200020 00000001ffffefff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x252800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP|__GFP_THISNODE), pid 1, tgid 1 (swapper/0), ts 7530129564, free_ts 7138110092
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1468
 prep_new_page mm/page_alloc.c:1476 [inline]
 get_page_from_freelist+0x2e2d/0x2ee0 mm/page_alloc.c:3402
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4660
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2264
 allocate_slab+0x5a/0x2e0 mm/slub.c:2427
 new_slab mm/slub.c:2480 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3666
 __slab_alloc+0x58/0xa0 mm/slub.c:3756
 __slab_alloc_node mm/slub.c:3809 [inline]
 slab_alloc_node mm/slub.c:3988 [inline]
 kmalloc_node_trace_noprof+0x20c/0x300 mm/slub.c:4160
 kmalloc_node_noprof include/linux/slab.h:677 [inline]
 alloc_node_nr_active kernel/workqueue.c:4833 [inline]
 alloc_workqueue+0x847/0x2060 kernel/workqueue.c:5713
 nvmet_init+0x8d/0x150 drivers/nvme/target/core.c:1698
 do_one_initcall+0x248/0x880 init/main.c:1267
 do_initcall_level+0x157/0x210 init/main.c:1329
 do_initcalls+0x3f/0x80 init/main.c:1345
 kernel_init_freeable+0x435/0x5d0 init/main.c:1578
 kernel_init+0x1d/0x2b0 init/main.c:1467
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1088 [inline]
 free_unref_page+0xd19/0xea0 mm/page_alloc.c:2565
 vfree+0x186/0x2e0 mm/vmalloc.c:3346
 free_partitions block/partitions/core.c:110 [inline]
 check_partition block/partitions/core.c:169 [inline]
 blk_add_partitions block/partitions/core.c:579 [inline]
 bdev_disk_changed+0x80e/0x13d0 block/partitions/core.c:683
 blkdev_get_whole+0x315/0x470 block/bdev.c:700
 bdev_open+0x2e9/0xc60 block/bdev.c:909
 bdev_file_open_by_dev+0x1b0/0x230 block/bdev.c:1011
 disk_scan_partitions+0x1be/0x2b0 block/genhd.c:367
 device_add_disk+0xca0/0xf90 block/genhd.c:510
 add_disk include/linux/blkdev.h:715 [inline]
 brd_alloc+0x503/0x770 drivers/block/brd.c:373
 brd_init+0xfd/0x1d0 drivers/block/brd.c:435
 do_one_initcall+0x248/0x880 init/main.c:1267
 do_initcall_level+0x157/0x210 init/main.c:1329
 do_initcalls+0x3f/0x80 init/main.c:1345
 kernel_init_freeable+0x435/0x5d0 init/main.c:1578
 kernel_init+0x1d/0x2b0 init/main.c:1467
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147

Memory state around the buggy address:
 ffff88814628c900: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff88814628c980: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>ffff88814628ca00: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
                                                 ^
 ffff88814628ca80: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff88814628cb00: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

