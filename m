Return-Path: <linux-btrfs+bounces-18233-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E52C04340
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 05:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D9BC94F2F62
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 03:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E00225F99B;
	Fri, 24 Oct 2025 03:01:35 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC6F18E20
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 03:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761274895; cv=none; b=m9iCf5AaiO/XHufn9gGq5yldxR9u1HZdE4La2jcpF6Roq1q4eAzRivvFrjgn/NsqgS63HqDV3DoCkv42i1Ndpon4VSFiveeTFDXRQMweGRcP57fz8mk4GbGqnIXAMLbmTU48Ss9eklDNRJMYXf1x1ASaHxkfaKqHuua46DK9YDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761274895; c=relaxed/simple;
	bh=0GtS0kYFdaRd/BYgGUKH+CbvdlCdoAy7wqF4xeq60y0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XhjISNVsUl+zVCEYwvDyANzXMcLQMuUwSHsHhzIIVALq07bgYlHs1oOHMKpTsRK+pECI0eochJ6KiAJ6fo82vfyNiqgN2Fw5InQCv1jZ0CK1hXsy6SxGW43Lug19d7NiupW3pQkS4Ptby+MuVq64XMjTNKqkyaZlQ2wHFwPs63w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-9374627bb7eso342065139f.1
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 20:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761274892; x=1761879692;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I5iw4aQ39omYzXDLTOmbhxQhu49vi1eIRV0XiI0UZLU=;
        b=iNgV43r6/noVGAQqV8R9CU40nMXb462vPiz0SxwsOhvobvzgUjut1LnhFKJeJY4FMI
         HuX72dCDVUgDQI6viIRQnu+muU7YIxTlqnqSmXYUj5L3KIdEwnSCAU5xw7d3pY2ckmCe
         F0oQYodlFZ3LjdSzm6ZSJrYvr4zxhKChsAG6caVeDE3v8bRzFPbPhmhtmcdL1Ypz263m
         7qa3P7mFxTrjxqLe2SB5tmUuyfJlQa36wo58aHW/H2j0vjX05OJFJ5wAiLr/+EedmD0o
         6SJc5qOEC7x3OpmSFKrXRDFH8gKuFHCkTUgNL7YDKmXgjJK6UBj5MxUUuRp9/wH8bCWI
         0W4Q==
X-Forwarded-Encrypted: i=1; AJvYcCW29JMlNNVpslR0YqPvBYqQ8uuDp6zMI+jtNi0NoFbNH4QRtMtd3XG6IkARNGcwFxgv9XLwypCV+Qg/+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFtSgOuRxUgmN0ormGwcBa7BM0dv00gMn0fqO20VfSgiIGV8F2
	vg4LU+TnTF+gVh6dGNz0FaSJUkK8HylNhKqhvQEbVtaPqVQJXLu7uC9Z0UwNAp9kRcUKCTsCbKo
	R3IuHsw1XZQyR9rY4gYmAEKnfKodrQjLwhzXLGzQSlypMc+euo9Zh7nVytFc=
X-Google-Smtp-Source: AGHT+IH8pdKvw0Rcy3OhgQKAGZqf25evIEa5CEX825+VM0lIeIVsp0ykYtjuMv49QdSmtdytmdrwiqCLKw/EE3TDyCZjLK1rvMkX
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:220f:b0:431:d685:a32a with SMTP id
 e9e14a558f8ab-431eb624025mr15343615ab.6.1761274892550; Thu, 23 Oct 2025
 20:01:32 -0700 (PDT)
Date: Thu, 23 Oct 2025 20:01:32 -0700
In-Reply-To: <68f6a4c8.050a0220.1be48.0013.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68faec0c.a70a0220.3bf6c6.00ea.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] general protection fault in btrfs_evict_inode
From: syzbot <syzbot+d991fea1b4b23b1f6bf8@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, mssola@mssola.com, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    ab431bc39741 Merge tag 'net-6.18-rc3' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16acae7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df98b4d1d5944c56
dashboard link: https://syzkaller.appspot.com/bug?extid=d991fea1b4b23b1f6bf8
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11acae7c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=121e0be2580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-ab431bc3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1d39c25550bc/vmlinux-ab431bc3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5dafbb4c36ac/bzImage-ab431bc3.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/9c180a1c4631/mount_2.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=14407734580000)
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/54ad7c21e681/mount_6.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d991fea1b4b23b1f6bf8@syzkaller.appspotmail.com

BTRFS info (device loop0): enabling auto defrag
BTRFS info (device loop0): force zlib compression, level 3
BTRFS info (device loop0): max_inline set to 0
Oops: general protection fault, probably for non-canonical address 0xdffffc000000003e: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x00000000000001f0-0x00000000000001f7]
CPU: 0 UID: 0 PID: 5490 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:btrfs_root_id fs/btrfs/ctree.h:333 [inline]
RIP: 0010:do_perf_trace_btrfs__inode include/trace/events/btrfs.h:204 [inline]
RIP: 0010:perf_trace_btrfs__inode+0x44d/0x580 include/trace/events/btrfs.h:204
Code: c1 e8 03 42 80 3c 30 00 74 08 4c 89 ff e8 db 43 66 fe 4d 8b 2f 4d 8d bd f7 01 00 00 49 81 c5 fe 01 00 00 4c 89 f8 48 c1 e8 03 <42> 0f b6 04 30 84 c0 0f 85 e4 00 00 00 4c 89 e8 48 c1 e8 03 42 0f
RSP: 0018:ffffc90002b7f800 EFLAGS: 00010203
RAX: 000000000000003e RBX: ffffe8ffffc4ec68 RCX: ffffffff83c10ce7
RDX: 0000000000000010 RSI: ffff888058f38000 RDI: ffffe8ffffc4ec30
RBP: ffffc90002b7f8d0 R08: 7c477e297af65e39 R09: 5d3eb9a580cd6d81
R10: 7c477e297af65e39 R11: 5d3eb9a580cd6d81 R12: ffffe8ffffc4ec28
R13: 00000000000001fe R14: dffffc0000000000 R15: 00000000000001f7
FS:  000055557f4fd500(0000) GS:ffff88808d733000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000564f8ff39890 CR3: 0000000012254000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 __do_trace_btrfs_inode_evict include/trace/events/btrfs.h:255 [inline]
 trace_btrfs_inode_evict include/trace/events/btrfs.h:255 [inline]
 btrfs_evict_inode+0x107a/0x1110 fs/btrfs/inode.c:5480
 evict+0x504/0x9c0 fs/inode.c:810
 btrfs_create_common+0x1c9/0x230 fs/btrfs/inode.c:6800
 btrfs_mkdir+0xc7/0xf0 fs/btrfs/inode.c:6927
 vfs_mkdir+0x306/0x510 fs/namei.c:4453
 do_mkdirat+0x247/0x590 fs/namei.c:4486
 __do_sys_mkdirat fs/namei.c:4503 [inline]
 __se_sys_mkdirat fs/namei.c:4501 [inline]
 __x64_sys_mkdirat+0x87/0xa0 fs/namei.c:4501
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2decb8d717
Code: 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 02 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd6e980498 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007ffd6e980520 RCX: 00007f2decb8d717
RDX: 00000000000001ff RSI: 0000200000000140 RDI: 00000000ffffff9c
RBP: 0000200000000180 R08: 00002000000000c0 R09: 0000000000000000
R10: 0000200000000180 R11: 0000000000000246 R12: 0000200000000140
R13: 00007ffd6e9804e0 R14: 0000000000000000 R15: 0000200000000080
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:btrfs_root_id fs/btrfs/ctree.h:333 [inline]
RIP: 0010:do_perf_trace_btrfs__inode include/trace/events/btrfs.h:204 [inline]
RIP: 0010:perf_trace_btrfs__inode+0x44d/0x580 include/trace/events/btrfs.h:204
Code: c1 e8 03 42 80 3c 30 00 74 08 4c 89 ff e8 db 43 66 fe 4d 8b 2f 4d 8d bd f7 01 00 00 49 81 c5 fe 01 00 00 4c 89 f8 48 c1 e8 03 <42> 0f b6 04 30 84 c0 0f 85 e4 00 00 00 4c 89 e8 48 c1 e8 03 42 0f
RSP: 0018:ffffc90002b7f800 EFLAGS: 00010203
RAX: 000000000000003e RBX: ffffe8ffffc4ec68 RCX: ffffffff83c10ce7
RDX: 0000000000000010 RSI: ffff888058f38000 RDI: ffffe8ffffc4ec30
RBP: ffffc90002b7f8d0 R08: 7c477e297af65e39 R09: 5d3eb9a580cd6d81
R10: 7c477e297af65e39 R11: 5d3eb9a580cd6d81 R12: ffffe8ffffc4ec28
R13: 00000000000001fe R14: dffffc0000000000 R15: 00000000000001f7
FS:  000055557f4fd500(0000) GS:ffff88808d733000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000564f8ff39890 CR3: 0000000012254000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	c1 e8 03             	shr    $0x3,%eax
   3:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1)
   8:	74 08                	je     0x12
   a:	4c 89 ff             	mov    %r15,%rdi
   d:	e8 db 43 66 fe       	call   0xfe6643ed
  12:	4d 8b 2f             	mov    (%r15),%r13
  15:	4d 8d bd f7 01 00 00 	lea    0x1f7(%r13),%r15
  1c:	49 81 c5 fe 01 00 00 	add    $0x1fe,%r13
  23:	4c 89 f8             	mov    %r15,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 0f b6 04 30       	movzbl (%rax,%r14,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 e4 00 00 00    	jne    0x11b
  37:	4c 89 e8             	mov    %r13,%rax
  3a:	48 c1 e8 03          	shr    $0x3,%rax
  3e:	42                   	rex.X
  3f:	0f                   	.byte 0xf


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

