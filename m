Return-Path: <linux-btrfs+bounces-7906-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E441972BFA
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2024 10:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06EF21F25ABA
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2024 08:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593B1188CB6;
	Tue, 10 Sep 2024 08:17:30 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B811188A09
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Sep 2024 08:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725956249; cv=none; b=Hh5zGeR/UPdMU3qUeicMiJIT17XYYMNz0du8IQ+fhCUkVBN+6hnq00vPdo020IjSBSujrTIxVkQ0V9jHBRZC9bDLo0R7IzaFRDwNGCvfOt8ldJkotOD+yQ2BT4aRzFaL+6S4Buggkv3m+jJ6G0OG2Y0ZW5EJM+dulOSmaDYFj7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725956249; c=relaxed/simple;
	bh=6FYgG1IvW/082napJZ+ehi9meAzlGAz93+hEpJ8Pxps=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NWKirQ90oDlikxau6dLq52GF0bE3ddc7gKD7lcJVXi+Pcotm7qf770sXQOs7FJXoHOCAbAZg1a2g4TxENrXIM7ekSDCz/+UoqPA9FWdAwyT8ff9z8f9HZjqRtBDVMZFQ4vSesmri3ziZ2BBNYiQTovUOvB9MWx0/sK3latm8Vso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39f37874297so98256605ab.3
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Sep 2024 01:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725956247; x=1726561047;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jew5OkVpcIS81fvOcA+7NjvaPli0TbzCp58akL7QRbY=;
        b=XakZ5yYARVf3+igUpI9eI7/uXFcwnEByLW/anUCrVXcwIkwuuOxOpXe5uMrgg5d4wQ
         L1/KvFNDqrSafJMlK+er16MI8BN0SJVMDSIwdYwQ+9QDFUe3g0NQkBGyCxY1UJ7Zjlzn
         sROhVDfkdyImEafGubCvEDsxXPY0bjVzh9PfdjydfBJOYELUOWAcI8RHBLj1LX1nLhYg
         O+bK2viIewLfIgRWsc7cXrRXL4yaVYFb5RnAnTH+wKxWOEgRL6ujqzw594t7aZ2rrq/C
         x0K/EiSklRrg45gOPLePrEf7oGDoRBvdUwSkMvmhe9mgd1xEeVz8HYMdLyTHQSVU4vpf
         Mrew==
X-Forwarded-Encrypted: i=1; AJvYcCXvDwvSlhRgJLfVnXsiMSN0xCjn+2cMmneY+VBn8rOZZKYMSAfagLCxKNJMihYq6BII5msWza1swPNkDA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk9BpFN6XzJpS8ZnLJeXMvBtxNuh63/bkeKASBTZq+xL4+b4K8
	RBw0I1R0QHsqVaMyqEBJcA/6yNzjWLOt374EOgGXQpVljKxpkFYNIVOgXRGGITil1S2H9JP5c/d
	sBZO2GKEy8AVx0/4FwustyzBTCs7SczURAjIv1+3+2e9s8sA0iP8AtAg=
X-Google-Smtp-Source: AGHT+IFjbu3GEeDpBBANB5vfEjO2gZOSflmR0Gl5BDAHLkygwXw+FWBzQT1qR9Nr5rrwYJTLy2gLlufOB8R8ZlKBq7gczmRzGPGJ
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4a:b0:39e:68f8:43e5 with SMTP id
 e9e14a558f8ab-3a04f0731fbmr150648235ab.9.1725956247177; Tue, 10 Sep 2024
 01:17:27 -0700 (PDT)
Date: Tue, 10 Sep 2024 01:17:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000002df770621bf81d9@google.com>
Subject: [syzbot] [btrfs?] [fbdev?] BUG: unable to handle kernel NULL pointer
 dereference in fbcon_putcs (3)
From: syzbot <syzbot+3d613ae53c031502687a@syzkaller.appspotmail.com>
To: clm@fb.com, daniel@ffwll.ch, deller@gmx.de, 
	dri-devel@lists.freedesktop.org, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    da3ea35007d0 Linux 6.11-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15662a8b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61d235cb8d15001c
dashboard link: https://syzkaller.appspot.com/bug?extid=3d613ae53c031502687a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12221420580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1133a797980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-da3ea350.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1ab780d224f6/vmlinux-da3ea350.xz
kernel image: https://storage.googleapis.com/syzbot-assets/834dde85c1c2/bzImage-da3ea350.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f56cd5277a08/mount_8.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3d613ae53c031502687a@syzkaller.appspotmail.com

BTRFS info (device loop0): disabling free space tree
BTRFS info (device loop0): clearing compat-ro feature flag for FREE_SPACE_TREE (0x1)
BTRFS info (device loop0): clearing compat-ro feature flag for FREE_SPACE_TREE_VALID (0x2)
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 357e5067 P4D 357e5067 PUD 3c1d6067 PMD 0 
Oops: Oops: 0010 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5093 Comm: syz-executor182 Not tainted 6.11.0-rc7-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc90002c5f6b8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff88801acc9000 RCX: 0000000000000001
RDX: ffff888033fd413e RSI: ffff88801f5cb000 RDI: ffff88801acc9000
RBP: 1ffff110067fa827 R08: 0000000000000000 R09: 000000000000009f
R10: 0000000000000002 R11: 0000000000000000 R12: ffff88801f5cb000
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff888033fd413e
FS:  0000555586260380(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 00000000409ee000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 fbcon_putcs+0x255/0x390 drivers/video/fbdev/core/fbcon.c:1288
 do_update_region+0x396/0x450 drivers/tty/vt/vt.c:619
 invert_screen+0x401/0xe50 drivers/tty/vt/vt.c:740
 highlight drivers/tty/vt/selection.c:57 [inline]
 clear_selection+0x59/0x80 drivers/tty/vt/selection.c:87
 vc_do_resize+0x6e6/0x17f0 drivers/tty/vt/vt.c:1187
 vc_resize include/linux/vt_kern.h:49 [inline]
 fbcon_set_disp+0xac9/0x11d0 drivers/video/fbdev/core/fbcon.c:1389
 con2fb_init_display drivers/video/fbdev/core/fbcon.c:794 [inline]
 set_con2fb_map+0xa6c/0x10a0 drivers/video/fbdev/core/fbcon.c:865
 fbcon_set_con2fb_map_ioctl+0x207/0x320 drivers/video/fbdev/core/fbcon.c:3092
 do_fb_ioctl+0x38f/0x7b0 drivers/video/fbdev/core/fb_chrdev.c:138
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7cf95f6fa9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdb38b4c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 7573617461646f6e RCX: 00007f7cf95f6fa9
RDX: 00000000200000c0 RSI: 0000000000004610 RDI: 0000000000000003
RBP: 00007f7cf96705f0 R08: 00005555862614c0 R09: 00005555862614c0
R10: 00005555862614c0 R11: 0000000000000246 R12: 00007ffdb38b4c80
R13: 00007ffdb38b4ea8 R14: 431bde82d7b634db R15: 00007f7cf964001d
 </TASK>
Modules linked in:
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc90002c5f6b8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff88801acc9000 RCX: 0000000000000001
RDX: ffff888033fd413e RSI: ffff88801f5cb000 RDI: ffff88801acc9000
RBP: 1ffff110067fa827 R08: 0000000000000000 R09: 000000000000009f
R10: 0000000000000002 R11: 0000000000000000 R12: ffff88801f5cb000
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff888033fd413e
FS:  0000555586260380(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 00000000409ee000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

