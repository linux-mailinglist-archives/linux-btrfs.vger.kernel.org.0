Return-Path: <linux-btrfs+bounces-11276-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A164A282D5
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 04:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BC073A033C
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 03:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF175213E98;
	Wed,  5 Feb 2025 03:31:24 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7830F2139CD
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Feb 2025 03:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738726284; cv=none; b=PpBXkmfLlv7mimvjwtA1jyakpW9/96wZ9PHS+cNTYQpIc21NGmheUfXh6bsouzJb/RgdqNUADwqYERzCgpqm0jGYYT42lhMjTwQBJu074t46goTcO72bsgkhSoAHUWU8xUipawIRuMD9ggDAhdylMvluI+bMpbuP1x3hiE8tpDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738726284; c=relaxed/simple;
	bh=JR+q5Qv76dY6OLc41/QVNXz1kJpQ6WF/SbfNQ4IqPRE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZBjVQR1RbStKYivckjE1ZdQwkPFC3wosyJAIugNUZubYzgwJDtv8eIDKlAu6zQMutgMzHyv7NgmIeim0KijPbjavkI2ZI06LwueoXv0x65fMefttmgkriVmImEMDGb2sbO6d+rfsy5sfRC/AAbKMlE2+PYLhlN6SU7ockMGfX9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3cfb3c4fc77so3637725ab.1
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Feb 2025 19:31:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738726281; x=1739331081;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FUaZXeNIm79Z2ts+NvxXvJZCLbvnILiJrvFpnwMCDtQ=;
        b=mYWtjUHDj6+/xEE5M5dfSQfUcs85q4S+H7uA0g+MBBY5HXHpXrlnvCJapNHZHEsEwI
         sFsKLAiLa8NlHE3AOeOb5xBt7fHUYMh+00aXiR6iw45XfX+GpiJLIuDlyos3YjRzzOjw
         PGya4zaOV9L1x5vfCtgO2wneOaHiq5g8+sTPxogU7Cy4ovGOVfEMM2R+tpxSD6G6sShv
         CjKwwUonXj8LmXSbuc6++9W1nmIt1G1ybDeViL8uluvtUWQxBFXsTBlZDvhui4uom8zn
         27QSG4Qq+akBGlhw2CO6T/LYrEDwcAWZfZJjus1SE37/5/RHHCzto5A0baMCnYvwudgp
         SxoA==
X-Forwarded-Encrypted: i=1; AJvYcCWUosE5ML7/2UZvd60th9JN0+GkU4yDlr8TfYTjBGoDOsbWp5n1/NWQroW14rh9YQTpnLBtnJ5gjzjKpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAbQWNc/TDOscol22typ41aWX+E7Y123kJQPx/TNzON9mGjt8u
	/9uJvI93uKKFap6rXFMJRkCCZnOg3/f0xwqfrEC2j04BMyOiqAxahE3iOty/weeX+CfAtlkgRaw
	+JuUAgJ9o4TJxJKtZCff9aiTQIDoW7bjuFN+UT3jm/1io71E7b5EeoGQ=
X-Google-Smtp-Source: AGHT+IEDMuvTYQ6Ma+IkSkNx2gcP+l0xyxdbN9YLST/XdwXIHLQN7Miiy3s8vG5Tk2qSX9iofJUzgahb6Eh8LTrgbzNSEEU7chIq
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:4a03:0:b0:3a9:cde3:2ecc with SMTP id
 e9e14a558f8ab-3d03f508538mr46122455ab.6.1738726281565; Tue, 04 Feb 2025
 19:31:21 -0800 (PST)
Date: Tue, 04 Feb 2025 19:31:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67a2db89.050a0220.50516.0008.GAE@google.com>
Subject: [syzbot] [btrfs?] WARNING in __btrfs_update_delayed_inode (2)
From: syzbot <syzbot+9864f9d3c5c14e151341@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    69e858e0b8b2 Merge tag 'uml-for-linus-6.14-rc1' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15c695f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d033b14aeef39158
dashboard link: https://syzkaller.appspot.com/bug?extid=9864f9d3c5c14e151341
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-69e858e0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a53b888c1f3f/vmlinux-69e858e0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6b5e17edafc0/bzImage-69e858e0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9864f9d3c5c14e151341@syzkaller.appspotmail.com

------------[ cut here ]------------
BTRFS: Transaction aborted (error -28)
WARNING: CPU: 0 PID: 5348 at fs/btrfs/delayed-inode.c:1090 __btrfs_update_delayed_inode+0xa02/0xbe0 fs/btrfs/delayed-inode.c:1090
Modules linked in:
CPU: 0 UID: 0 PID: 5348 Comm: syz.0.0 Not tainted 6.13.0-syzkaller-09760-g69e858e0b8b2 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__btrfs_update_delayed_inode+0xa02/0xbe0 fs/btrfs/delayed-inode.c:1090
Code: 8c 49 89 dd 44 89 ea e8 ac ac 32 fd e9 db fe ff ff e8 42 61 ca fd 90 48 c7 c7 a0 75 4d 8c 49 89 dd 44 89 ee e8 9f 19 8b fd 90 <0f> 0b 90 90 e9 b9 fe ff ff 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c
RSP: 0018:ffffc900019e6580 EFLAGS: 00010246
RAX: 54c9bccbc803ae00 RBX: 00000000ffffffe4 RCX: ffff888000764880
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc900019e66b0 R08: ffffffff818027c2 R09: 1ffff11003f8519a
R10: dffffc0000000000 R11: ffffed1003f8519b R12: 1ffff1100a618b59
R13: 00000000ffffffe4 R14: ffff8880530c5ac8 R15: 0000000000000000
FS:  00007f65596856c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7c6cc174a8 CR3: 0000000052c5e000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_update_delayed_inode fs/btrfs/delayed-inode.c:1108 [inline]
 __btrfs_commit_inode_delayed_items+0x2318/0x24a0 fs/btrfs/delayed-inode.c:1131
 __btrfs_run_delayed_items+0x20e/0x4b0 fs/btrfs/delayed-inode.c:1165
 btrfs_commit_transaction+0x89a/0x3760 fs/btrfs/transaction.c:2310
 btrfs_sync_file+0xdd7/0x11e0 fs/btrfs/file.c:1735
 generic_write_sync include/linux/fs.h:2958 [inline]
 btrfs_do_write_iter+0x5fc/0x7b0 fs/btrfs/file.c:1386
 __kernel_write_iter+0x433/0x950 fs/read_write.c:612
 __kernel_write+0x120/0x180 fs/read_write.c:632
 __dump_emit+0x237/0x360 fs/coredump.c:807
 elf_core_dump+0x31f4/0x4790 fs/binfmt_elf.c:2081
 do_coredump+0x244f/0x2f00 fs/coredump.c:758
 get_signal+0x140b/0x1750 kernel/signal.c:3021
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 irqentry_exit_to_user_mode+0x7e/0x250 kernel/entry/common.c:231
 exc_page_fault+0x590/0x8b0 arch/x86/mm/fault.c:1542
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7f655878cdb1
Code: 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 48 3d 01 f0 ff ff 73 01 <c3> 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f
RSP: 002b:ffffffffffffffe0 EFLAGS: 00010217
RAX: 0000000000000000 RBX: 00007f65589a6080 RCX: 00007f655878cda9
RDX: 0000000000000000 RSI: ffffffffffffffe0 RDI: 0000000004008011
RBP: 00007f655880e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f65589a6080 R15: 00007ffe6a01d078
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

