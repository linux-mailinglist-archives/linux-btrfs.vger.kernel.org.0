Return-Path: <linux-btrfs+bounces-7965-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8CF9765BE
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 11:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D706B23BAA
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 09:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAB219CC16;
	Thu, 12 Sep 2024 09:35:28 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9791118E043
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2024 09:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726133728; cv=none; b=A+WV1utQlTdMzLzmRNRtHeZnsLhkJrNcL5ksvSDrrUurUTppc2fy+sUXtIJaqIY6T/OVqaYeYxHFLFIZNMMXTVtzw2Fm7I0ZRg6UN9jUQioUW2yvIqW6+a3p6h8lZvgt67zgznxLXKJu0uWp3NjQeKFlC5Pigx6pOVOHwbbRUec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726133728; c=relaxed/simple;
	bh=2Pb+1qdyBRlYhUb3gAIRIDVPdu7sAaLz7e8j7xbWY4A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rgogkw1odXolkHda3W5Vqry8seXtvDrrLOOjf+a5fTG/6n/mY+LRUgclr6sxd7EkTlgC9bbrOqkF/WgXVfVRp+4zO+W6yMpUdofXERDFv4nzR7Y+Sq3XiJX/I8cjRdcO8mWyfJ4G2L+vyRc+k6nV98TyEnvn18aaam0tsM/kjmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39f510b3f81so24135345ab.0
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2024 02:35:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726133726; x=1726738526;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EvsVbk2tfqPiyiGs5RPZdw1iX6YznRXmuK6gNwuUJgo=;
        b=Rv6BWgI2JJIw1gyLJFCUpTcItwyJa1zYCosuwhV6vpkZ2YBYi5h+KbtcJdvZ7j0xeY
         Ywt/aJYp4Z0i/AoXPdYQRHDBlqn6AGOBS9BagNJIChd0tR4zBfZm2J+3MijJq9rnXw+m
         wM5Ka7EcCGyMs7kuPcm1B54mi4h8uNs2hZ1f0mDHUlte5kJ0MyDNxLISCd+nf/hYnNBe
         CuNZ4Ixjk+A4qEXEydnF1dMnde3WCPsN2H1+vZuxBTsCRBCu40Vnl2J9at5aj3LeNdl6
         1KeF0hj2+az/6LSQ4LELApI4Hb08LkHKFq9uzG9Y1BE9Ig9SWTnUDA5eeoK7Z6JknNnC
         K8LA==
X-Forwarded-Encrypted: i=1; AJvYcCUCmStEer5Rx+ePomr/MRmXqtnIxHBb6aQzRFRdNAPyGt8XNBAwbnMuvRsILvt8fzltnSOWE+dVLdq4qA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/UkZ7eu6c3QD8a7J/Xz9iiQCJpSDiJqGKr5p6WdXwfx1rsCPz
	jHo9InM1pbKRX/w2mTlS/jPJ3jZIpkU1IwKkPtvutmcGsuhnf0b8W5iqPpbjpFH4CH0QeGlgNCP
	Jo7H5Igw76yajinije0W242aXEXPVZDEAy0TfbgHRlC3qdx/ifGCarhM=
X-Google-Smtp-Source: AGHT+IH6w3R1tcY3hl7RTeHeAUFIPxt9DLwWQRQ2QECfiI8p9aN7JXHt3H6b2C+mY0LUhLNSMD6jfrvkDvYdY68Vza8XGUWbQdRe
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c5:b0:39f:325f:78e6 with SMTP id
 e9e14a558f8ab-3a0845a0d55mr16695925ab.0.1726133725753; Thu, 12 Sep 2024
 02:35:25 -0700 (PDT)
Date: Thu, 12 Sep 2024 02:35:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008f00ed0621e8d33c@google.com>
Subject: [syzbot] [btrfs?] WARNING in btrfs_destroy_inode (2)
From: syzbot <syzbot+3f149babf28b57cee242@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    89f5e14d05b4 Merge tag 'timers_urgent_for_v6.11_rc7' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14c39f29980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=58a85aa6925a8b78
dashboard link: https://syzkaller.appspot.com/bug?extid=3f149babf28b57cee242
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-89f5e14d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dfc310daee41/vmlinux-89f5e14d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a92f22c06568/bzImage-89f5e14d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3f149babf28b57cee242@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5121 at fs/btrfs/inode.c:7729 btrfs_destroy_inode+0x323/0x7d0 fs/btrfs/inode.c:7729
Modules linked in:
CPU: 0 UID: 0 PID: 5121 Comm: syz.0.0 Not tainted 6.11.0-rc6-syzkaller-00363-g89f5e14d05b4 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:btrfs_destroy_inode+0x323/0x7d0 fs/btrfs/inode.c:7729
Code: 0f 0b 90 e9 61 fe ff ff e8 aa 07 e1 fd 90 0f 0b 90 e9 d2 fe ff ff e8 9c 07 e1 fd 90 0f 0b 90 e9 fd fe ff ff e8 8e 07 e1 fd 90 <0f> 0b 90 48 85 ed 0f 85 2d ff ff ff e8 7c 07 e1 fd 49 8d 9c 24 98
RSP: 0018:ffffc90002f9efa8 EFLAGS: 00010283
RAX: ffffffff83b28522 RBX: ffffffffffffffff RCX: 0000000000040000
RDX: ffffc9000b53a000 RSI: 000000000002e363 RDI: 000000000002e364
RBP: ffff88803d78c000 R08: ffffffff83b28445 R09: 1ffffffff2030ee5
R10: dffffc0000000000 R11: ffffffff83b28200 R12: ffff88801310b790
R13: ffff88803d78c000 R14: ffff88801310b3f0 R15: dffffc0000000000
FS:  00007ff6855786c0(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000556646649f88 CR3: 0000000040dba000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 destroy_inode fs/inode.c:313 [inline]
 evict+0x809/0x950 fs/inode.c:729
 btrfs_iget_path+0x124f/0x17b0 fs/btrfs/inode.c:5605
 btrfs_iget_logging fs/btrfs/tree-log.c:154 [inline]
 add_conflicting_inode fs/btrfs/tree-log.c:5680 [inline]
 copy_inode_items_to_log fs/btrfs/tree-log.c:5950 [inline]
 btrfs_log_inode+0x22bb/0x4700 fs/btrfs/tree-log.c:6613
 btrfs_log_inode_parent+0xb3e/0x1160 fs/btrfs/tree-log.c:7106
 btrfs_log_dentry_safe+0x61/0x80 fs/btrfs/tree-log.c:7207
 btrfs_sync_file+0xb60/0x11c0 fs/btrfs/file.c:1778
 generic_write_sync include/linux/fs.h:2822 [inline]
 btrfs_do_write_iter+0x5e2/0x760 fs/btrfs/file.c:1515
 do_iter_readv_writev+0x60a/0x890
 vfs_writev+0x37c/0xbb0 fs/read_write.c:971
 do_pwritev fs/read_write.c:1072 [inline]
 __do_sys_pwritev2 fs/read_write.c:1131 [inline]
 __se_sys_pwritev2+0x1ca/0x2d0 fs/read_write.c:1122
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff68477cef9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff685578038 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
RAX: ffffffffffffffda RBX: 00007ff684936058 RCX: 00007ff68477cef9
RDX: 0000000000000001 RSI: 0000000020022e80 RDI: 0000000000000008
RBP: 00007ff6847ef046 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007ff684936058 R15: 00007fff28631528
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

