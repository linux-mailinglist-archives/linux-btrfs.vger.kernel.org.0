Return-Path: <linux-btrfs+bounces-19074-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6A3C6492D
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 15:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3009036391F
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 14:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82B433033A;
	Mon, 17 Nov 2025 14:02:38 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819E5233136
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 14:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763388158; cv=none; b=hvkI14WBKcw0AREQxM/O5KPa0D/wLMBKRbDu4sdI/ufrkh3KU83deY133wXFqLctVRbqc1XnoCdHhWbuhsoaUbGRn6WVuoGVZxSj0HeHoUQz3DVnwsNiBaB+RLFhQtIsVsTU4pB2bo/3Vru5vzIk98yMNB7KRBSWr3VBGE4yl/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763388158; c=relaxed/simple;
	bh=eUz5VuEfOpkHGethY98YlaW7IDk/UISZCE2B/m27BZs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YQ6vD6LGeTdktpLvMDgmfBJ/aozxeio3eGo06X46v1q5cbW5rvLsxYl+FCPt9CsuUFFwS+6GNOKfymDPh1NKaHsfiNwDB0esG6MkwFvJHvlVHxKIRcZojH+s6WAUJeRIdsAwLWaiB+E7pykr3/NnyWKfGDBguVQtjo7ZZGsqzmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-9490596dfb4so96834639f.1
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 06:02:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763388155; x=1763992955;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4jO8iQNbiGhaZCSrKoNesFowbNERTRkqd+V9OC/MzeM=;
        b=HNvuKsqjlOGfebvokSasUqEnP9+nBOkpzCjcNsSju9GPN17AFp6HxLut42sQqXt+uJ
         UQ4HMHT2vvzt57oLO0eT7oxX47xxsR75tHY/e3pMCEPr9nc9xpcc2488xLNQHQWvhIBu
         ZhMOP/AX8qi4zNJkwubFIX443CFdm9r5IsqjRe+bR7Xd7D/Vo/irLth5Hbhcwx0cExvO
         k1kGy36+zz9FC0KQKw3AOrS/DePBNG2dM25tqmkSSFeg2/HbcmjcZ/dLITQq+fomk2LO
         YS0Oh5MMyD1ZhB/+2f4x/mG0YV69K4iFkryRuRtaLmTug97m0NCw/0EwruHKHdUF35ft
         JcTw==
X-Forwarded-Encrypted: i=1; AJvYcCWh/wBcyWi1G6GDDwbgewXPhFAYowCs0eIWP+VwFWfIyFzZaFKY35lZvgdufgDBT7Q6AyBAR09MSB9IEA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFIkhFOLNZbCyVVfU4oxvAOjXUKw608NrWNoO1s080kRv+eoyj
	SuNAj4Cy389rTn9NSjANVzWLj6zU86R6LdVOpcGYqhX65lk4Ebh8n3EdhSPHlTL6PEKUkewGvDN
	FAveWM8G7+MXR0/4FRwP8tilJ+9iPDrsEo/L4CvYv4UnNd+SQ7NjEk4h1VD4=
X-Google-Smtp-Source: AGHT+IFw/Au7RQtbmRUTeReN6o0k+fexV/X/3mkxDaIx6kakoZJ3W/B8ZvPIjdkf3EqfJWEFLTOcZCo+l+SFkajuP1ryUzjHX0/W
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3a06:b0:433:8347:2e69 with SMTP id
 e9e14a558f8ab-4348c8dee08mr158509025ab.14.1763388155292; Mon, 17 Nov 2025
 06:02:35 -0800 (PST)
Date: Mon, 17 Nov 2025 06:02:35 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691b2afb.a70a0220.f6df1.000f.GAE@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in modify_free_space_bitmap
From: syzbot <syzbot+2b448e5301f0d29f3d39@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e927c520e1ba Merge tag 'loongarch-fixes-6.18-1' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=127f897c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=929790bc044e87d7
dashboard link: https://syzkaller.appspot.com/bug?extid=2b448e5301f0d29f3d39
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-e927c520.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/924fb782edf1/vmlinux-e927c520.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7e6af189c28e/bzImage-e927c520.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2b448e5301f0d29f3d39@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
BTRFS: device fsid 395ef67a-297e-477c-816d-cd80a5b93e5d devid 1 transid 8 /dev/loop0 (7:0) scanned by syz.0.0 (5332)
BTRFS info (device loop0): first mount of filesystem 395ef67a-297e-477c-816d-cd80a5b93e5d
BTRFS info (device loop0): using sha256 (sha256-lib) checksum algorithm
BTRFS info (device loop0): enabling ssd optimizations
BTRFS info (device loop0): turning on async discard
BTRFS info (device loop0): enabling free space tree
netlink: 830 bytes leftover after parsing attributes in process `syz.0.0'.
BTRFS info (device loop0 state M): rebuilding free space tree
assertion failed: key.type == BTRFS_FREE_SPACE_BITMAP_KEY :: 0, in fs/btrfs/free-space-tree.c:556
------------[ cut here ]------------
kernel BUG at fs/btrfs/free-space-tree.c:556!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5332 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:free_space_modify_bits fs/btrfs/free-space-tree.c:556 [inline]
RIP: 0010:modify_free_space_bitmap+0xbd6/0xc10 fs/btrfs/free-space-tree.c:665
Code: 0f 0b e8 5d 7c cf fd 48 c7 c7 e0 6e b0 8b 48 c7 c6 00 72 b0 8b 31 d2 48 c7 c1 40 6d b0 8b 41 b8 2c 02 00 00 e8 ab fa 36 fd 90 <0f> 0b e8 33 7c cf fd 48 c7 c7 e0 6e b0 8b 48 c7 c6 20 73 b0 8b 31
RSP: 0018:ffffc9000d43f5a0 EFLAGS: 00010246
RAX: 0000000000000061 RBX: 00000000000000c6 RCX: ab56fb4df2ad8d00
RDX: ffffc9000deea000 RSI: 0000000000002135 RDI: 0000000000002136
RBP: ffffc9000d43f770 R08: ffffc9000d43f2c7 R09: 1ffff92001a87e58
R10: dffffc0000000000 R11: fffff52001a87e59 R12: ffff888051083800
R13: dffffc0000000000 R14: 0000000000006000 R15: ffff888052afad10
FS:  00007f39159f26c0(0000) GS:ffff88808d730000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdf4c5d158 CR3: 0000000040118000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 populate_free_space_tree+0x38d/0x600 fs/btrfs/free-space-tree.c:1129
 btrfs_rebuild_free_space_tree+0x1ba/0x6d0 fs/btrfs/free-space-tree.c:1365
 btrfs_start_pre_rw_mount+0x128f/0x1bf0 fs/btrfs/disk-io.c:3062
 btrfs_remount_rw fs/btrfs/super.c:1334 [inline]
 btrfs_reconfigure+0xaed/0x2160 fs/btrfs/super.c:1559
 reconfigure_super+0x227/0x890 fs/super.c:1076
 do_remount fs/namespace.c:3279 [inline]
 path_mount+0xd1a/0xfe0 fs/namespace.c:4029
 do_mount fs/namespace.c:4050 [inline]
 __do_sys_mount fs/namespace.c:4238 [inline]
 __se_sys_mount+0x313/0x410 fs/namespace.c:4215
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3914b90e6a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f39159f1e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f39159f1ef0 RCX: 00007f3914b90e6a
RDX: 0000200000000180 RSI: 0000200000000100 RDI: 0000000000000000
RBP: 0000200000000180 R08: 00007f39159f1ef0 R09: 0000000000ad0c24
R10: 0000000000ad0c24 R11: 0000000000000246 R12: 0000200000000100
R13: 00007f39159f1eb0 R14: 0000000000000000 R15: 00002000000002c0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:free_space_modify_bits fs/btrfs/free-space-tree.c:556 [inline]
RIP: 0010:modify_free_space_bitmap+0xbd6/0xc10 fs/btrfs/free-space-tree.c:665
Code: 0f 0b e8 5d 7c cf fd 48 c7 c7 e0 6e b0 8b 48 c7 c6 00 72 b0 8b 31 d2 48 c7 c1 40 6d b0 8b 41 b8 2c 02 00 00 e8 ab fa 36 fd 90 <0f> 0b e8 33 7c cf fd 48 c7 c7 e0 6e b0 8b 48 c7 c6 20 73 b0 8b 31
RSP: 0018:ffffc9000d43f5a0 EFLAGS: 00010246
RAX: 0000000000000061 RBX: 00000000000000c6 RCX: ab56fb4df2ad8d00
RDX: ffffc9000deea000 RSI: 0000000000002135 RDI: 0000000000002136
RBP: ffffc9000d43f770 R08: ffffc9000d43f2c7 R09: 1ffff92001a87e58
R10: dffffc0000000000 R11: fffff52001a87e59 R12: ffff888051083800
R13: dffffc0000000000 R14: 0000000000006000 R15: ffff888052afad10
FS:  00007f39159f26c0(0000) GS:ffff88808d730000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdf4c5d158 CR3: 0000000040118000 CR4: 0000000000352ef0


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

