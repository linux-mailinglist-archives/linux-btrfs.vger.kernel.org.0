Return-Path: <linux-btrfs+bounces-8691-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED22996C9D
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 15:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD238283C6E
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 13:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F334919994A;
	Wed,  9 Oct 2024 13:48:27 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50491991C6
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 13:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728481707; cv=none; b=LKxgpXrR0QTPIGL3UsjVcXSjU4fHweAFcCGBPdtjEB6dS2DrOYJgU1owKwDfNsRLRiaPKwgMF3PQrtQoDh20YPk4j5gV6VIQdxT8HzG4zQ6iql6Aia9YB//AfpdUuu+K7tK6q2FQF1cJc3QeRguv9nlOfIHe8X1FTYATdr52Vtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728481707; c=relaxed/simple;
	bh=6enl91q7bgT05ijtZ5e8/GNmLtjyYGMDw8RvcA7oKyo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JWMQmW0c6Vn+WabZflKdY5h1gzcRSCqnIjwDOW8zQSW/oBohYtB/ToWLPpG6oZ6eUgkZbM6HKFBqZ/KjYL06jP6B9WxjcYP9LRjf3VlXNx8CSV+GjU5At4ELLRnL0n1j4bah3mHhyEPdyFD7LoD5YvXBMbvwKOpTFACBHZv6kAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a342e7e49cso97482865ab.0
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Oct 2024 06:48:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728481705; x=1729086505;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/CsXp0E02F45cKBqSioNNV12BfJpSVpd3ncN/t0kmRk=;
        b=YdNgZFXuPz7/3iuCR+XUnDUmfNrinMmLIGBlBASUO9KKFSdJkW9YbWA41yQ5QQ36Ub
         Le2aIGA7C1GYREtfZ4s+g0EaTEJd1dHRFguMAdOeHcfx6OAIfM5Crd2ZXUjkqGoHzvzK
         uMXf77YTOBqyPdaNehRxwGyAYknyjGWjwl9DSo8mwKd2UP/YP/LEgNA+HzOofJn84dwW
         unxXf3CCRWF5MyjCsJ1w/Mfq0yTLZ+TE2AyFSIgOMalbP1V8ds+uGW+of4KMSeXgXjgE
         I51RDpbryVBCzpW4KCljgc4aflsKoj+Kk48loElNhv9KK99XgYyFR06zeshDj9vNFE0O
         DcOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNQh7NOgG13I+PQXB0q9Fs8SXytsWWDbn15QN5BJvNw+GhIgqrhzuzZ/eOMDMUm2wfobUTEjpB5lm99g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3wj/+rSOvhgJB64in/KwNQd8PCk/H6pJu7VwEOBnjcz/gZprX
	AgHusuVOFX/qyYmAzdap/O3cFNBcuC3segrkqKrRfT+KlzR6ZH7fAI6j5TzjxaO975BqElVwdWR
	IEq7nP9xSpwrBjrdCtJ2W/kxfMdlvg6v+C5W1JTHOk79nGxPbiBYP4GY=
X-Google-Smtp-Source: AGHT+IEpWbToHcEU/to/iYP74kwcaUoX1RmAUHvA+R5IvVChNLej3YBwuwo9/LQc0H3DEz/Cf+b/g3U7RqwmCZwIYDA8Ni2EuVrS
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:198c:b0:39f:5d96:1fde with SMTP id
 e9e14a558f8ab-3a397cdb1ccmr20198125ab.3.1728481705023; Wed, 09 Oct 2024
 06:48:25 -0700 (PDT)
Date: Wed, 09 Oct 2024 06:48:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670689a8.050a0220.67064.0046.GAE@google.com>
Subject: [syzbot] [btrfs?] general protection fault in getname_kernel (2)
From: syzbot <syzbot+cee29f5a48caf10cd475@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    33ce24234fca Add linux-next specific files for 20241008
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10df97d0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4750ca93740b938d
dashboard link: https://syzkaller.appspot.com/bug?extid=cee29f5a48caf10cd475
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=160ce327980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15ea7707980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ee8dc2df0c57/disk-33ce2423.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dc473c0fa06e/vmlinux-33ce2423.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4671f1ca2e61/bzImage-33ce2423.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cee29f5a48caf10cd475@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 UID: 0 PID: 5235 Comm: syz-executor338 Not tainted 6.12.0-rc2-next-20241008-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:strlen+0x2c/0x70 lib/string.c:402
Code: 1e fa 41 57 41 56 41 54 53 49 89 fe 48 c7 c0 ff ff ff ff 49 bf 00 00 00 00 00 fc ff df 48 89 fb 49 89 c4 48 89 d8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 75 12 48 ff c3 49 8d 44 24 01 43 80 7c 26 01
RSP: 0018:ffffc90003b7f8a8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff88802c5cda00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff901d3f2f R09: 1ffffffff203a7e5
R10: dffffc0000000000 R11: fffffbfff203a7e6 R12: ffffffffffffffff
R13: ffff888028a7e000 R14: 0000000000000000 R15: dffffc0000000000
FS:  000055557da91380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200000c0 CR3: 000000004fdaa000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 getname_kernel+0x1d/0x2f0 fs/namei.c:232
 kern_path+0x1d/0x50 fs/namei.c:2716
 is_good_dev_path fs/btrfs/volumes.c:760 [inline]
 btrfs_scan_one_device+0x19e/0xd90 fs/btrfs/volumes.c:1484
 btrfs_get_tree_super fs/btrfs/super.c:1841 [inline]
 btrfs_get_tree+0x30e/0x1920 fs/btrfs/super.c:2114
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 fc_mount+0x1b/0xb0 fs/namespace.c:1231
 btrfs_get_tree_subvol fs/btrfs/super.c:2077 [inline]
 btrfs_get_tree+0x652/0x1920 fs/btrfs/super.c:2115
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 vfs_cmd_create+0xa0/0x1f0 fs/fsopen.c:225
 __do_sys_fsconfig fs/fsopen.c:472 [inline]
 __se_sys_fsconfig+0xa1f/0xf70 fs/fsopen.c:344
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe8c78542a9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd2c4992f8 EFLAGS: 00000246 ORIG_RAX: 00000000000001af
RAX: ffffffffffffffda RBX: 00007ffd2c4994c8 RCX: 00007fe8c78542a9
RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000003
RBP: 00007fe8c78c7610 R08: 0000000000000000 R09: 00007ffd2c4994c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffd2c4994b8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:strlen+0x2c/0x70 lib/string.c:402
Code: 1e fa 41 57 41 56 41 54 53 49 89 fe 48 c7 c0 ff ff ff ff 49 bf 00 00 00 00 00 fc ff df 48 89 fb 49 89 c4 48 89 d8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 75 12 48 ff c3 49 8d 44 24 01 43 80 7c 26 01
RSP: 0018:ffffc90003b7f8a8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff88802c5cda00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff901d3f2f R09: 1ffffffff203a7e5
R10: dffffc0000000000 R11: fffffbfff203a7e6 R12: ffffffffffffffff
R13: ffff888028a7e000 R14: 0000000000000000 R15: dffffc0000000000
FS:  000055557da91380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005606b6327058 CR3: 000000004fdaa000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	fa                   	cli
   1:	41 57                	push   %r15
   3:	41 56                	push   %r14
   5:	41 54                	push   %r12
   7:	53                   	push   %rbx
   8:	49 89 fe             	mov    %rdi,%r14
   b:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  12:	49 bf 00 00 00 00 00 	movabs $0xdffffc0000000000,%r15
  19:	fc ff df
  1c:	48 89 fb             	mov    %rdi,%rbx
  1f:	49 89 c4             	mov    %rax,%r12
  22:	48 89 d8             	mov    %rbx,%rax
  25:	48 c1 e8 03          	shr    $0x3,%rax
* 29:	42 0f b6 04 38       	movzbl (%rax,%r15,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	75 12                	jne    0x44
  32:	48 ff c3             	inc    %rbx
  35:	49 8d 44 24 01       	lea    0x1(%r12),%rax
  3a:	43                   	rex.XB
  3b:	80                   	.byte 0x80
  3c:	7c 26                	jl     0x64
  3e:	01                   	.byte 0x1


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

