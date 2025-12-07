Return-Path: <linux-btrfs+bounces-19553-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25230CAB1B4
	for <lists+linux-btrfs@lfdr.de>; Sun, 07 Dec 2025 06:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89EEC30A42FD
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Dec 2025 05:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8308F2D9EDB;
	Sun,  7 Dec 2025 05:19:32 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7049B3FBA7
	for <linux-btrfs@vger.kernel.org>; Sun,  7 Dec 2025 05:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765084772; cv=none; b=g5+Vz9hQ6HHWqBzp76OVKJENQf4hwfH2zSuvjRlJin+kWhAQNJf6d6k4eCOStGF2mxPN+YsIUXtMX31+jDIvGP0R2ryZVSx6sSJWmVxavNvhsNKgclkzMiFTknh4bSVykPluRgE9xQ7x/+9ejL3EP+qh9mxpypTQBHzYqj5h+Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765084772; c=relaxed/simple;
	bh=mXNDRMTcUlQfcXcJAclcPTte8PL4updNbhwxGyrGltg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KC+mfGdAnOgmEXIOSvqRFbmExSePvJBWIhlMENEl5GZ6z1bdQDBvYHFrkJ+m3Y2To6F6vY01cVbFi1gK8pHk66gGg2JnT9+MU2oHVcuJP9OmP/XvBAhy0ILL73F2G87XLdB5FeM3YuSrcWD1nj3fH9+b6lQXt3AHaGZHlFSUIQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-7c7599be25cso6768263a34.2
        for <linux-btrfs@vger.kernel.org>; Sat, 06 Dec 2025 21:19:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765084769; x=1765689569;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1tIjoXT8Ah9yqkzT0nG3TLPHmWugjei4s0Gdzr2v/qg=;
        b=VFhLUz/FANxuNTiWIYxnqwoPpqgl9ZRq0wYnqAsLX2xYC+MLXhX8MiLL89H/HjFnXC
         cHrsH0ZAhTKYAEDck2g2EZIPKLTH5q0L75V7enoZaK5HmzUy+D8fsxOMF6nkEI8NTlRo
         D+cp/JCdFbT9zVVnFwhGtdN/OQFDj/XljY6GFcMMCJxFauYDL0MEGLRxxJf/8Yc9SqvE
         rpBpJwml5eaG8bvqMZImKvFLbvhWTBLwZ0lAn30BTxo+HOU+wdrgrybLJOtwCLOil+aw
         r5P/BkD2+RVT1qCVsYgFBo5csZnQIop1SG5LYgkkw+W7EBBQMkDOutGk0SZkb+OTRBQO
         LOmA==
X-Forwarded-Encrypted: i=1; AJvYcCUAovpvA0fC8mXTdWFDx01lX1zsc6QKkNq4V11MuA+5wRHtN82vUurLDMUEuOCTIy6bubccmuFQEmF0PA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSw9uog/yIZETee3fvihK02VJupS7qkHFmZQgGUvyI3XWGyBe6
	WRhYDi50hUiSjZHSfT/9axogBo8GSq+UdPUClH66g4UPQnNpVJ6qxNvmVYphgT17qs2kUrIWeDS
	lSCcDBibjywI+ljtY0DWR08F+BzZHkf77TqY6pa4ZxunsyIfU3C/beuLVv5U=
X-Google-Smtp-Source: AGHT+IF0HNA9NvUe2ELWoSn8Z1tSt2R9/IVVOavqQV0gdda0QqVN86WA19eMbCw8z/ps7jZfyXx422f6NFAyziVWcl5hUYWX1EGy
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:138e:b0:659:9a49:8f3c with SMTP id
 006d021491bc7-6599a98492emr1496744eaf.77.1765084769638; Sat, 06 Dec 2025
 21:19:29 -0800 (PST)
Date: Sat, 06 Dec 2025 21:19:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69350e61.a70a0220.38f243.0044.GAE@google.com>
Subject: [syzbot] [btrfs?] WARNING in btrfs_add_to_free_space_tree
From: syzbot <syzbot+fa6623c288cdedf3f41c@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    44fc84337b6e Merge tag 'arm64-upstream' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14ca94c2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e613d5a6bd72b912
dashboard link: https://syzkaller.appspot.com/bug?extid=fa6623c288cdedf3f41c
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-44fc8433.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/62d35c4f6e28/vmlinux-44fc8433.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b8d61aa183d4/bzImage-44fc8433.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fa6623c288cdedf3f41c@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
BTRFS: device fsid c9fe44da-de57-406a-8241-57ec7d4412cf devid 1 transid 8 /dev/loop0 (7:0) scanned by syz.0.0 (5338)
BTRFS info (device loop0): first mount of filesystem c9fe44da-de57-406a-8241-57ec7d4412cf
BTRFS info (device loop0): using crc32c (crc32c-lib) checksum algorithm
BTRFS info (device loop0): setting nodatasum
BTRFS info (device loop0): allowing degraded mounts
BTRFS info (device loop0): disabling tree log
BTRFS info (device loop0): turning on async discard
BTRFS info (device loop0): enabling free space tree
BTRFS info (device loop0): balance: start -d -m
BTRFS info (device loop0): relocating block group 6881280 flags data|metadata
BTRFS info (device loop0): relocating block group 5242880 flags data|metadata
------------[ cut here ]------------
BTRFS: Transaction aborted (error -28)
WARNING: fs/btrfs/free-space-tree.c:1051 at 0x0, CPU#0: syz.0.0/5338
Modules linked in:
CPU: 0 UID: 0 PID: 5338 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:btrfs_add_to_free_space_tree+0x4ad/0x580 fs/btrfs/free-space-tree.c:1051
Code: f7 cf fd e9 bd 00 00 00 e8 40 e7 b5 fd 84 c0 74 23 e8 17 f7 cf fd e9 aa 00 00 00 e8 0d f7 cf fd 48 8d 3d a6 5d 98 0b 44 89 e6 <67> 48 0f b9 3a e9 27 fd ff ff e8 c4 50 57 07 41 89 c6 31 ff 89 c6
RSP: 0018:ffffc9000d4deed0 EFLAGS: 00010287
RAX: ffffffff83f11723 RBX: ffff888000b5c800 RCX: 0000000000100000
RDX: ffffc90020001000 RSI: 00000000ffffffe4 RDI: ffffffff8f8974d0
RBP: ffff888019e099a0 R08: ffff888033ad0000 R09: 0000000000000003
R10: 00000000fffffffb R11: 0000000000000002 R12: 00000000ffffffe4
R13: 0000000000000000 R14: ffff888051710001 R15: 1ffff110033c1334
FS:  00007f3ba2c276c0(0000) GS:ffff88808d6b7000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555574ecd7c8 CR3: 00000000123e7000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 do_free_extent_accounting fs/btrfs/extent-tree.c:3003 [inline]
 __btrfs_free_extent+0x12f8/0x3f80 fs/btrfs/extent-tree.c:3372
 run_delayed_tree_ref fs/btrfs/extent-tree.c:1749 [inline]
 run_one_delayed_ref fs/btrfs/extent-tree.c:1775 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1972 [inline]
 __btrfs_run_delayed_refs+0xe38/0x40c0 fs/btrfs/extent-tree.c:2047
 btrfs_run_delayed_refs+0xe6/0x3a0 fs/btrfs/extent-tree.c:2159
 btrfs_commit_transaction+0x269/0x3950 fs/btrfs/transaction.c:2211
 prepare_to_relocate+0x39f/0x490 fs/btrfs/relocation.c:3489
 relocate_block_group+0x132/0xd70 fs/btrfs/relocation.c:3514
 btrfs_relocate_block_group+0x6bc/0xc60 fs/btrfs/relocation.c:3983
 btrfs_relocate_chunk+0x12f/0x5c0 fs/btrfs/volumes.c:3448
 __btrfs_balance+0x1860/0x23f0 fs/btrfs/volumes.c:4224
 btrfs_balance+0xac2/0x11b0 fs/btrfs/volumes.c:4601
 btrfs_ioctl_balance+0x3d3/0x610 fs/btrfs/ioctl.c:3560
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3ba1d8f7c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3ba2c27038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f3ba1fe5fa0 RCX: 00007f3ba1d8f7c9
RDX: 0000200000000180 RSI: 00000000c4009420 RDI: 0000000000000006
RBP: 00007f3ba1e13f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f3ba1fe6038 R14: 00007f3ba1fe5fa0 R15: 00007ffd7cf29928
 </TASK>
----------------
Code disassembly (best guess):
   0:	f7 cf fd e9 bd 00    	test   $0xbde9fd,%edi
   6:	00 00                	add    %al,(%rax)
   8:	e8 40 e7 b5 fd       	call   0xfdb5e74d
   d:	84 c0                	test   %al,%al
   f:	74 23                	je     0x34
  11:	e8 17 f7 cf fd       	call   0xfdcff72d
  16:	e9 aa 00 00 00       	jmp    0xc5
  1b:	e8 0d f7 cf fd       	call   0xfdcff72d
  20:	48 8d 3d a6 5d 98 0b 	lea    0xb985da6(%rip),%rdi        # 0xb985dcd
  27:	44 89 e6             	mov    %r12d,%esi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	e9 27 fd ff ff       	jmp    0xfffffd5b
  34:	e8 c4 50 57 07       	call   0x75750fd
  39:	41 89 c6             	mov    %eax,%r14d
  3c:	31 ff                	xor    %edi,%edi
  3e:	89 c6                	mov    %eax,%esi


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

