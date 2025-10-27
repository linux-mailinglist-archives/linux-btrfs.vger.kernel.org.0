Return-Path: <linux-btrfs+bounces-18354-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A192BC0BC2F
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Oct 2025 04:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 420303BB6FA
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Oct 2025 03:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408F7227B8E;
	Mon, 27 Oct 2025 03:36:26 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303E619D07A
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Oct 2025 03:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761536185; cv=none; b=pDTNpzGZSxV1Gb9Wx8WdsP57dYXHTtwRdr98/uRT+97riPvSlAtQDa1yHdfwV4d0R1jWPJF4xZqqXsZ5jg80ib/51Ryte2mbSF1Rr1Ffhvr5beda7OmvD5j90fHVisR/gsl3qsS+209lsodoAHgH7FcB48LzXoXpQmpGRFgT4UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761536185; c=relaxed/simple;
	bh=3I+JgvpShmHX+ksk70/+RuVmhW2FA/MCK8zj+DbC2ig=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sFlKcrDYxcNeeopcGfLmLkqke2mks229OLs42V48jP2kpdOiLWh7tbvzL0EVpBsvBuQkApHFmugx6XkfkAV5NFdDJPDfnQWUKH6irCE6A2THSuiQTyVk7hKLXvuKm69EZkcEzD/mxEWriTyvnOoG/vbDKHghrRGwYeKDFUIR8qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-430d1adb32aso39814215ab.1
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Oct 2025 20:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761536183; x=1762140983;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zhznq594qzOA5y+bSzbjoM/YHyG5lp78QbrhgZdq+5I=;
        b=v4SzEO+RyL7cqPEl/6b/qutS5h618tpZ/mS0P62qy6jcEbtLiUTxbtk/EzTjhaj1HN
         vMETb3yuibr386X51VRqF23881bb8srfUc9ikrxsOg/NCBOTzk/cLvEVgXOSV2ogg3TF
         sWg4Syy2OWc24DBil9mP5n8OXVWWwGd746L10ekztaQv3YevNwJOasmofnygdOZ9XGI7
         0/HrdvuRUEJdJT5EsJ0Vagky+HmHyd0xSjKe5m27NERSukv5wHI49jUAcKwE7kUiVVMp
         MqAGXxCa6FVHr6TQY0cQSwOz5VSk3lIauxSF3BoxyDfRbWqSU8PTl6CxYOzJ6P3zOZ93
         hYGA==
X-Forwarded-Encrypted: i=1; AJvYcCW2IqgWV3L4Rf+XGec8oCKae4rjSS5VETTc836m5qGo448iGgfcszy1z50bfYD5o+o+O/VNdVs5na4AMA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy442drkdxyfqoJDaCwjprEYDjD97cl84NyDrm3Xlwae+YY0m/n
	dIilLF9BMNFK4Q0S7EZuIAPgyPoxMDDcP8goezn+ZHjkZUHTQ/OVOryKlm0kgVbhwGBjcCbS2+n
	Cjj7VkOyy1PdN1PKMD1+H5eUOBg3d9IrZCi3+vJ7fY/OQBE0kneVBt8Y3Scs=
X-Google-Smtp-Source: AGHT+IGd/HTv0k/oecKNYRuPIIoCOes9yXdok2+yo418o5hbHH+T66xCoKNFa3yRjDgVYuGD5l5RZTFHGR48F8MZJH2hjvneoChg
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9d:b0:42f:95a1:2e8 with SMTP id
 e9e14a558f8ab-430c52d5786mr461958875ab.24.1761536183346; Sun, 26 Oct 2025
 20:36:23 -0700 (PDT)
Date: Sun, 26 Oct 2025 20:36:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fee8b7.050a0220.32483.000f.GAE@google.com>
Subject: [syzbot] [btrfs?] WARNING in btrfs_add_delayed_iput (2)
From: syzbot <syzbot+e0babece4b4300d51e73@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6fab32bb6508 MAINTAINERS: add Mark Brown as a linux-next m..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17a68be2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb8e856ee40b632b
dashboard link: https://syzkaller.appspot.com/bug?extid=e0babece4b4300d51e73
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4d337be0cf04/disk-6fab32bb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f56ca33e777c/vmlinux-6fab32bb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d7a51e41c32b/bzImage-6fab32bb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e0babece4b4300d51e73@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 13187 at fs/btrfs/inode.c:3450 btrfs_add_delayed_iput+0x2e6/0x360 fs/btrfs/inode.c:3450
Modules linked in:
CPU: 1 UID: 0 PID: 13187 Comm: syz-executor Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:btrfs_add_delayed_iput+0x2e6/0x360 fs/btrfs/inode.c:3450
Code: b0 8b 5c fe 48 8b 3b 48 83 c4 20 5b 41 5c 41 5d 41 5e 41 5f 5d e9 aa ea cb fd e8 f5 d3 fa fd e9 f5 fd ff ff e8 eb d3 fa fd 90 <0f> 0b 90 e9 4f fe ff ff 44 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c 81
RSP: 0000:ffffc90004c5f400 EFLAGS: 00010246
RAX: ffffffff83c3e995 RBX: ffff8880231b8000 RCX: ffff88802c349e00
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000100
RBP: dffffc0000000000 R08: 0000000000000000 R09: 0000000000000100
R10: dffffc0000000000 R11: ffffed1004637471 R12: 0000000000000001
R13: dffffc0000000000 R14: ffff888066d7b3b8 R15: 0000000000000200
FS:  0000555559d1c500(0000) GS:ffff888126efc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdffda00000 CR3: 000000006b4be000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 btrfs_put_ordered_extent+0x19f/0x470 fs/btrfs/ordered-data.c:635
 blk_update_request+0x57e/0xe60 block/blk-mq.c:998
 blk_mq_end_request+0x3e/0x70 block/blk-mq.c:1160
 blk_complete_reqs block/blk-mq.c:1235 [inline]
 blk_done_softirq+0x10a/0x160 block/blk-mq.c:1240
 handle_softirqs+0x22f/0x710 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 __local_bh_enable_ip+0x1a0/0x2e0 kernel/softirq.c:302
 lock_sock include/net/sock.h:1679 [inline]
 netlink_insert+0xd3/0x1370 net/netlink/af_netlink.c:557
 __netlink_kernel_create+0x2b0/0x710 net/netlink/af_netlink.c:2038
 netlink_kernel_create include/linux/netlink.h:62 [inline]
 rdma_nl_net_init+0xcc/0x180 drivers/infiniband/core/netlink.c:318
 rdma_dev_init_net+0x95/0x270 drivers/infiniband/core/device.c:1201
 ops_init+0x35c/0x5c0 net/core/net_namespace.c:137
 setup_net+0xfe/0x320 net/core/net_namespace.c:445
 copy_net_ns+0x34e/0x4e0 net/core/net_namespace.c:580
 create_new_namespaces+0x3f3/0x720 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0x11c/0x170 kernel/nsproxy.c:218
 ksys_unshare+0x4c8/0x8c0 kernel/fork.c:3129
 __do_sys_unshare kernel/fork.c:3200 [inline]
 __se_sys_unshare kernel/fork.c:3198 [inline]
 __x64_sys_unshare+0x38/0x50 kernel/fork.c:3198
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1ba19707c7
Code: 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 10 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff95a532e8 EFLAGS: 00000206 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00007f1ba1bc5f40 RCX: 00007f1ba19707c7
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000040000000
RBP: 00007f1ba1bc67b8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000008
R13: 0000000000000003 R14: 0000000000000009 R15: 0000000000000000
 </TASK>


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

