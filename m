Return-Path: <linux-btrfs+bounces-20227-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F22E3D02E75
	for <lists+linux-btrfs@lfdr.de>; Thu, 08 Jan 2026 14:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B41B9304A100
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jan 2026 13:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920974CACF2;
	Thu,  8 Jan 2026 13:00:23 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oa1-f77.google.com (mail-oa1-f77.google.com [209.85.160.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9594A13A7
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Jan 2026 13:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767877223; cv=none; b=Gnhu5e4kHVvFYBTae0vPMWuhgUNR4z48fuDnAfElTmXckpAvdViWAhtFWX9Kc9rm2lAQ6elo6nzlEfqmgl/9CaOnCkkf62zaYRmKsxaDDdTqsq9Ys97kJsIhZ/V8KzGC4KzVAy8ZaiDMZcl9ozmsuwD8AqxcS/SOR4KrZnym3wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767877223; c=relaxed/simple;
	bh=1hk9MD7pXRJ/TTAwQPHJ1hHVzAFdMvWFsDr7UOqkPog=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MaRq17MjEZwKf82Yl1XfccEq4mYKAosjdSKYChfn8Yyrk3ekhVbskKcsUndb4yWKdLlMmXAGGX7w5DIiblxMQL6N774TgifQo6wBw/4SMIM8FB22BoNGUtmXLx4fcmGLcbykAT/LwXAMcRB/Ig8+48KoshdBSD7RZtc0yjfxILI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f77.google.com with SMTP id 586e51a60fabf-3fecd18ffa0so3112210fac.2
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Jan 2026 05:00:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767877220; x=1768482020;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XE9gGL8rvOJ8lyGl3XeJAAg4yrw1c8hPnG7pTwECVQs=;
        b=gvyyEF/hiUSxJ96xUS4LYCrQ0MF3ZqREggOdqsymaj3hSGR+irGgBaIwX3QIABhRcH
         /Rn3bqQckBOxSGCnRa5FolcC9L4ARFTAeJdQq+z2NS5QgtQ0f1eKeVtNZXI5MKDpiWhX
         ZMLeGoiG9d2zkm2RMq7KZQTbEutvoSkrC/W2RgibFJ5AOgj3y+u2VAMHtaIf3APwTVo3
         6Prr5d2UOOL359XWEByOMyPolUtcKN0T0lQXwfpiz86slxy1WB9kz8diqPzilbabdQuI
         MdBnGBWsQmyGifRF60S2w+Y+0g0XMxfzzO6nWjNe/TQNTW3VPlgykl2c6yT2MOHq2M1+
         XFdA==
X-Forwarded-Encrypted: i=1; AJvYcCWe9vTswApA4v60xPiWQkFz703ORqfo3FwqVePtuhebMUGR0vefDneqHSsK+4GnccHzMz6FtRHYEQnbbw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0S8dLsKedSn2hBPq2c2xv/wcde7jKIcy0vweqgJaMU0DZRJfG
	wj8b5I2eoGfWhBxXreBLCsRqaGSaNXJJ0UG5Ms9mbLoIpzNdvu07Xhcfc6j06pa1w4+KTiKONfC
	OSd9TMo2PnKDLDdzp/bVJqXGGN9RkgVU2CWnN1KZpepSyxGVo6eQ0A7VxogI=
X-Google-Smtp-Source: AGHT+IGRxtX5pL97erKgPG0byxMkLDMzhLrzmJbgqpkJfyvqd8oYYBQLMd8UOmCAczCVbdHQzkN9C/sqI8I5xv43dr1Mn8qcP3pT
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1613:b0:65e:d467:147c with SMTP id
 006d021491bc7-65f5507e8c0mr2540333eaf.71.1767877219485; Thu, 08 Jan 2026
 05:00:19 -0800 (PST)
Date: Thu, 08 Jan 2026 05:00:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <695faa63.050a0220.1c677c.039b.GAE@google.com>
Subject: [syzbot] [btrfs?] general protection fault in create_empty_buffers (5)
From: syzbot <syzbot+b4a2af3000eaa84d95d5@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f0b9d8eb98df Merge tag 'nfsd-6.19-3' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1311ef92580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a11e0f726bfb6765
dashboard link: https://syzkaller.appspot.com/bug?extid=b4a2af3000eaa84d95d5
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10663e9a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14936074580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-f0b9d8eb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d6eefae97e89/vmlinux-f0b9d8eb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a16fafcc4238/bzImage-f0b9d8eb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b4a2af3000eaa84d95d5@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 2 UID: 0 PID: 6261 Comm: syz.0.73 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:create_empty_buffers+0x4d/0x480 fs/buffer.c:1694
Code: ec 6d ff 48 89 de ba 40 8c 40 00 4c 89 ef e8 0a f6 ff ff 49 89 c6 48 89 c3 eb 03 48 89 c3 e8 ea eb 6d ff 48 89 d8 48 c1 e8 03 <80> 3c 28 00 0f 85 81 03 00 00 48 8d 7b 08 4c 09 23 48 89 f8 48 c1
RSP: 0018:ffffc9000408f870 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8250f7ec
RDX: ffff88802a4d8000 RSI: ffffffff8250fcc6 RDI: ffff88802a4d9680
RBP: dffffc0000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: ffff88802a4d8b30 R12: 0000000000000000
R13: ffffea0000a9e5c0 R14: 0000000000000000 R15: dffffc0000000000
FS:  00007f1ac84a46c0(0000) GS:ffff8880d6af5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1ac84a3f98 CR3: 000000002b14f000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 folio_create_buffers+0x109/0x150 fs/buffer.c:1802
 block_read_full_folio+0x14c/0x850 fs/buffer.c:2403
 filemap_read_folio+0xc8/0x2a0 mm/filemap.c:2496
 do_read_cache_folio+0x266/0x5c0 mm/filemap.c:4096
 do_read_cache_page mm/filemap.c:4162 [inline]
 read_cache_page_gfp+0x29/0x120 mm/filemap.c:4195
 btrfs_read_disk_super+0x192/0x500 fs/btrfs/volumes.c:1367
 btrfs_scan_one_device+0x109/0x820 fs/btrfs/volumes.c:1475
 btrfs_get_tree_super fs/btrfs/super.c:1860 [inline]
 btrfs_get_tree_subvol fs/btrfs/super.c:2089 [inline]
 btrfs_get_tree+0x5b3/0x2710 fs/btrfs/super.c:2123
 vfs_get_tree+0x8e/0x330 fs/super.c:1751
 fc_mount fs/namespace.c:1199 [inline]
 do_new_mount_fc fs/namespace.c:3636 [inline]
 do_new_mount fs/namespace.c:3712 [inline]
 path_mount+0x7bf/0x23a0 fs/namespace.c:4022
 do_mount fs/namespace.c:4035 [inline]
 __do_sys_mount fs/namespace.c:4224 [inline]
 __se_sys_mount fs/namespace.c:4201 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:4201
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1ac758f7c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1ac84a4038 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f1ac77e6090 RCX: 00007f1ac758f7c9
RDX: 00002000000000c0 RSI: 0000200000000080 RDI: 00002000000001c0
RBP: 00007f1ac7613f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000004418 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f1ac77e6128 R14: 00007f1ac77e6090 R15: 00007ffe5d1bb9d8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:create_empty_buffers+0x4d/0x480 fs/buffer.c:1694
Code: ec 6d ff 48 89 de ba 40 8c 40 00 4c 89 ef e8 0a f6 ff ff 49 89 c6 48 89 c3 eb 03 48 89 c3 e8 ea eb 6d ff 48 89 d8 48 c1 e8 03 <80> 3c 28 00 0f 85 81 03 00 00 48 8d 7b 08 4c 09 23 48 89 f8 48 c1
RSP: 0018:ffffc9000408f870 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8250f7ec
RDX: ffff88802a4d8000 RSI: ffffffff8250fcc6 RDI: ffff88802a4d9680
RBP: dffffc0000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: ffff88802a4d8b30 R12: 0000000000000000
R13: ffffea0000a9e5c0 R14: 0000000000000000 R15: dffffc0000000000
FS:  00007f1ac84a46c0(0000) GS:ffff8880d6af5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1ac84a3f98 CR3: 000000002b14f000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	ec                   	in     (%dx),%al
   1:	6d                   	insl   (%dx),%es:(%rdi)
   2:	ff 48 89             	decl   -0x77(%rax)
   5:	de ba 40 8c 40 00    	fidivrs 0x408c40(%rdx)
   b:	4c 89 ef             	mov    %r13,%rdi
   e:	e8 0a f6 ff ff       	call   0xfffff61d
  13:	49 89 c6             	mov    %rax,%r14
  16:	48 89 c3             	mov    %rax,%rbx
  19:	eb 03                	jmp    0x1e
  1b:	48 89 c3             	mov    %rax,%rbx
  1e:	e8 ea eb 6d ff       	call   0xff6dec0d
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 28 00          	cmpb   $0x0,(%rax,%rbp,1) <-- trapping instruction
  2e:	0f 85 81 03 00 00    	jne    0x3b5
  34:	48 8d 7b 08          	lea    0x8(%rbx),%rdi
  38:	4c 09 23             	or     %r12,(%rbx)
  3b:	48 89 f8             	mov    %rdi,%rax
  3e:	48                   	rex.W
  3f:	c1                   	.byte 0xc1


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

