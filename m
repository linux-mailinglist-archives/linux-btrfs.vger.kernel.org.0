Return-Path: <linux-btrfs+bounces-9186-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B34F99B1452
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Oct 2024 05:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 612BF2833C5
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Oct 2024 03:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DF914AD17;
	Sat, 26 Oct 2024 03:31:36 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61D8320F
	for <linux-btrfs@vger.kernel.org>; Sat, 26 Oct 2024 03:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729913495; cv=none; b=hH5Gu/HxmHeCg5yzwGy1GRtAKH7ODgvS4ujkcEuhSR61GuX2uos9naAEc7dDyxoJ6aSbYBOZjrQHeZXY5fmPEY0F14WSayFTKVTYeR0CUr865ODCjj7jkRXK5gaNFEyVnMwnqET5vujCzt1PbTf2G9r7q4YSfpiW7xJASXJqNE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729913495; c=relaxed/simple;
	bh=qlQfPFPo+vePr/b0TKDW2EhZ1fVTwb288l9jgggBAQQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mSjzCbbrliaASJFxCoXJsv9nwTVYp3fK/VBgnduVKhapIpywm/eI1VO8WJFssYXUPcSTvMYNf1S+RkgpMjVfpgehvXqYhdCFhJ6CF0xSV45dLX1DgahYfV1avldb5D895rFY7cTmdJOWfGtf1IPrvr7+h4KeySS1uJDDfF34cgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3a6afd01eso23964185ab.3
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Oct 2024 20:31:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729913493; x=1730518293;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jyx73Im/Ju5KcZDknso5u3jMErO6uN8xFHQNFeiAjyM=;
        b=JpaH5CX6r6IxpmA4tkcam5SwoZTA6DNWnlQLjJ0sA80ucAJ1JXgKj2ieb87Nk+ngbJ
         aKe3ib+vcoIdQXbpqJ8MJTW18b6tauPT83FM4iuj9BvOJj5uwmcPNsT2bqQCgp6EDgtj
         x6Y5vjpgiUaDOj3ceTeF3RXxXQaDYHNUNIBM1OmAZsd8/IRuYF4lwaBnLLU+K4LOsz2a
         oTsXDYklssx9I8womZ3wa9DAXwyps8K5kiis+Ayzh11CXRuDKvxwo5ApOUMA6rMWo52g
         Rc6I9fzJgwQJpSgo8C0eZqGlns7X1AYX3s2llk+z9a2Nxi8bL1XQ6DAUqHcAjUFMGQkG
         dryw==
X-Forwarded-Encrypted: i=1; AJvYcCXMDMIt0cMdk9tgND07K1UhkhgujvbtsCVK7EjJVnmr0eY9kYgnxOXHiB9bxh626qVGvgh+JRGZF2w/hg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxE1Ye/kE7JrwVGJBTcj1sGyxZWiOlSK1dquzgfMEyQqjjJS4P2
	PtsE2XsvmV7ZydVzR6CTAtd4ikacFEGU/jgIxida9OYtoudujGt/FvGonkEDd/qTDLUdQU73Ggo
	2wViSfzVqal5Dx6AMalsL7Yfrx0TOLNJxQBFZUwiiup1uiLvNzwVyKtQ=
X-Google-Smtp-Source: AGHT+IH8k/c4UTt/oxLgEFb8uW4wHRxI/DRYUMnRBFsCIrc513LNbm4B7mU2gNKqF4npcs/nSxDT9F1o7qVLE+0oO9f9E9BgVn8B
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2188:b0:3a4:ea4f:ac9e with SMTP id
 e9e14a558f8ab-3a4ed30fef7mr11494935ab.26.1729913492796; Fri, 25 Oct 2024
 20:31:32 -0700 (PDT)
Date: Fri, 25 Oct 2024 20:31:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671c6294.050a0220.2fdf0c.021f.GAE@google.com>
Subject: [syzbot] [btrfs?] WARNING in btrfs_create_uuid_tree
From: syzbot <syzbot+26d3fefc62ec33837e93@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c2ee9f594da8 KVM: selftests: Fix build on on non-x86 archi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17a290a7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc6f8ce8c5369043
dashboard link: https://syzkaller.appspot.com/bug?extid=26d3fefc62ec33837e93
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-c2ee9f59.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8a3541902b13/vmlinux-c2ee9f59.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a00efacc2604/bzImage-c2ee9f59.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+26d3fefc62ec33837e93@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
BTRFS: device fsid a6a605fc-d5f1-4e66-8595-3726e2b761d6 devid 1 transid 8 /dev/loop0 (7:0) scanned by syz.0.0 (5105)
BTRFS info (device loop0 state S): first mount of filesystem a6a605fc-d5f1-4e66-8595-3726e2b761d6
BTRFS info (device loop0 state S): using blake2b (blake2b-256-generic) checksum algorithm
BTRFS info (device loop0 state S): using free-space-tree
workqueue: max_active 32767 requested for btrfs-worker is out of range, clamping between 1 and 512
workqueue: max_active 32767 requested for btrfs-delalloc is out of range, clamping between 1 and 512
workqueue: max_active 32767 requested for btrfs-endio is out of range, clamping between 1 and 512
workqueue: max_active 32767 requested for btrfs-endio-meta is out of range, clamping between 1 and 512
workqueue: max_active 32767 requested for btrfs-rmw is out of range, clamping between 1 and 512
workqueue: max_active 32767 requested for btrfs-endio-write is out of range, clamping between 1 and 512
workqueue: max_active 32767 requested for btrfs-compressed-write is out of range, clamping between 1 and 512
BTRFS info (device loop0 state MCS): resize thread pool 32767 -> 3
BTRFS info (device loop0 state MCS): creating UUID tree
------------[ cut here ]------------
BTRFS: Transaction aborted (error -17)
WARNING: CPU: 0 PID: 5105 at fs/btrfs/uuid-tree.c:550 btrfs_create_uuid_tree+0x21b/0x230 fs/btrfs/uuid-tree.c:550
Modules linked in:
CPU: 0 UID: 0 PID: 5105 Comm: syz.0.0 Not tainted 6.12.0-rc4-syzkaller-00047-gc2ee9f594da8 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:btrfs_create_uuid_tree+0x21b/0x230 fs/btrfs/uuid-tree.c:550
Code: 5b 4e 8c e8 d7 87 eb 07 48 89 ef e8 3f b1 f6 07 e9 fa fe ff ff e8 55 53 bc fd 90 48 c7 c7 a0 5a 4e 8c 89 de e8 d6 4c 7d fd 90 <0f> 0b 90 90 eb 97 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 90
RSP: 0018:ffffc9000af47800 EFLAGS: 00010246
RAX: aa1d53389ee6ee00 RBX: ffffffffffffffef RCX: ffff8880002ba440
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffff88801fc55060 R08: ffffffff8155d402 R09: 1ffff11003f8519a
R10: dffffc0000000000 R11: ffffed1003f8519b R12: dffffc0000000000
R13: ffff88804c5e8001 R14: ffff88801fc55000 R15: 0000000000000000
FS:  00007fc0dfa126c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055a0b3b24338 CR3: 0000000040ab4000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_start_pre_rw_mount+0x116c/0x1300 fs/btrfs/disk-io.c:3085
 btrfs_remount_rw fs/btrfs/super.c:1309 [inline]
 btrfs_reconfigure+0xae6/0x2d40 fs/btrfs/super.c:1534
 btrfs_reconfigure_for_mount fs/btrfs/super.c:2020 [inline]
 btrfs_get_tree_subvol fs/btrfs/super.c:2079 [inline]
 btrfs_get_tree+0x918/0x1920 fs/btrfs/super.c:2115
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc0deb7dff9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc0dfa12038 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fc0ded36058 RCX: 00007fc0deb7dff9
RDX: 0000000020000280 RSI: 0000000020000180 RDI: 0000000020000100
RBP: 00007fc0debf0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fc0ded36058 R15: 00007ffe42d6cb28
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

