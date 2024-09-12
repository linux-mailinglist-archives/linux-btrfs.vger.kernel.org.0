Return-Path: <linux-btrfs+bounces-7964-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A00976566
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 11:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8530284EF1
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 09:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDF319ABA8;
	Thu, 12 Sep 2024 09:23:29 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF7D18FDCE
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2024 09:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726133009; cv=none; b=f1wKQIqth5BML+oebJCBvv+Nr37tleWwrn7DYBpAQl4nTEYvtR7VA7aenXDpDsitkNMHkx5LG0eMt6nksidCUy55FKR2u9PJBIy2khbpMKXgDB1IxpJRjRCIBYV5gF5beULmC6KXlF6WX0GS1J+xhdbHYmoB9+t/AEa4iWprooA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726133009; c=relaxed/simple;
	bh=5ekEo+3KlRC3cWnYigf3DXyOQdm7cUK159g0XgQKu5Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KCybTfUN4aZFE+G/mVO4v0D5v++42x2/xAJx/Bmpfg8dg+0+uoxMO7GPpSwSVxwLISQjJ5ryR36dZ9f6o7fAKkfHsLt+ya0k/Us0rUf+vCKIU/Esfdur7JVBQbeyiivNzV5Obkk6Mp/uaYrNzTD2YTb6lAJx8BCnrAvglqnMkCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a04bf03b1aso11164045ab.1
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2024 02:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726133007; x=1726737807;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lXLLrAPqwt0zV/0i0jzGPqpuWfKv8YhdSPVimCfPUXY=;
        b=YcZHrQmpIo2QWFP+2zaHAHC9w42clBApeb0kMEOOF+TKzPNfptQJZDh1coXH187vsB
         ikJvaQFXkb2BeIiR4jjezhzMlOIFymteKMajJnlJ+R99tMmHmL3bb7WRAINHyPrzu1Jb
         xi0ZZsSa5J+sHjEBtqDa5w2ZK5VjJRj1IojR+5JmfRlfX5qSwzS5xLffPM2BYGEpdifr
         GeZUBPRNCzenSMO8nhny6GTy06YSXJ/lxCaKPLlheeqH43bb68/2EHP9ftcdxd1aA2ib
         FXqJPfeASAPvYnj7p10G9XdxNLwOeduYBM9D2K/7iEBuf/2Xz+YyViXbNvjP10NQY/yp
         K4PA==
X-Forwarded-Encrypted: i=1; AJvYcCW8BAnOVKxqFHN5XNUiXztaAYT0lgDJdsztAuXYexKCtjRkTmUwpmVO7jzNj+4gxw2amz2b8mU/z0k2GQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuH4imop4NOMRY2J/iJBAti7Mx6wCMpNWU+nG5IpFpHxrAEJLz
	gbql31XGKJ6gICqryToS85ZV0lvxLOXRIkVUVJZgpKPiuK0n0KpxU6rAFaZGQf7vUr8OK2c5Y+q
	wVkyJpMn2McysRHILrQWR6WV3galEeW3v7nmly+SqoaymFeg5e/Mgdwg=
X-Google-Smtp-Source: AGHT+IFUT9QAXSbHNkUibNlLMGvEZVvGeOztCAwsBPKEGTHoYmyG3HK/CYBIdIteSPEwkXIbNFTy2GmGg2uikN9HQ5J713XXy4xs
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c4d:b0:3a0:54b4:ce77 with SMTP id
 e9e14a558f8ab-3a0848ec519mr23588735ab.2.1726133006938; Thu, 12 Sep 2024
 02:23:26 -0700 (PDT)
Date: Thu, 12 Sep 2024 02:23:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b6ca130621e8a872@google.com>
Subject: [syzbot] [btrfs?] general protection fault in btrfs_lookup_csums_list
From: syzbot <syzbot+d60477667a2941dfc89f@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b831f83e40a2 Merge tag 'bpf-6.11-rc7' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1135909f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=660f6eb11f9c7dc5
dashboard link: https://syzkaller.appspot.com/bug?extid=d60477667a2941dfc89f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-b831f83e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ab02bf22935d/vmlinux-b831f83e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c1101078451d/bzImage-b831f83e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d60477667a2941dfc89f@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
BTRFS: device fsid a6a605fc-d5f1-4e66-8595-3726e2b761d6 devid 1 transid 8 /dev/loop0 (7:0) scanned by syz.0.0 (5114)
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
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000041: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000208-0x000000000000020f]
CPU: 0 UID: 0 PID: 5114 Comm: syz.0.0 Not tainted 6.11.0-rc6-syzkaller-00183-gb831f83e40a2 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:btrfs_lookup_csums_list+0xb4/0x1670 fs/btrfs/file-item.c:470
Code: 29 48 89 4c 24 70 42 c7 44 29 08 f3 f3 f3 f3 e8 c2 87 e6 fd 48 89 9c 24 d0 00 00 00 48 81 c3 08 02 00 00 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 bd ce 4d fe 48 8b 03 48 89 44 24
RSP: 0018:ffffc90002e3e9a0 EFLAGS: 00010206
RAX: 0000000000000041 RBX: 0000000000000208 RCX: 0000000000040000
RDX: ffffc9000b549000 RSI: 000000000000a5b2 RDI: 000000000000a5b3
RBP: ffffc90002e3eb48 R08: 0000000000000000 R09: 1ffff11003fdd00d
R10: dffffc0000000000 R11: ffffed1003fdd00e R12: 0000000000000000
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff88804bd20208
FS:  00007faa9ecd06c0(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055be20731338 CR3: 0000000012478000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 can_nocow_file_extent+0x808/0xa40 fs/btrfs/inode.c:1967
 can_nocow_extent+0x5a0/0x940 fs/btrfs/inode.c:7066
 btrfs_get_blocks_direct_write+0x370/0xfa0 fs/btrfs/direct-io.c:239
 btrfs_dio_iomap_begin+0xadd/0x10e0 fs/btrfs/direct-io.c:513
 iomap_iter+0x691/0xf60 fs/iomap/iter.c:91
 __iomap_dio_rw+0xdec/0x2370 fs/iomap/direct-io.c:659
 btrfs_dio_write fs/btrfs/direct-io.c:756 [inline]
 btrfs_direct_write+0x61e/0xa80 fs/btrfs/direct-io.c:861
 btrfs_do_write_iter+0x2a1/0x760 fs/btrfs/file.c:1505
 iter_file_splice_write+0xbd7/0x14e0 fs/splice.c:743
 do_splice_from fs/splice.c:941 [inline]
 direct_splice_actor+0x11e/0x220 fs/splice.c:1164
 splice_direct_to_actor+0x58e/0xc90 fs/splice.c:1108
 do_splice_direct_actor fs/splice.c:1207 [inline]
 do_splice_direct+0x28c/0x3e0 fs/splice.c:1233
 do_sendfile+0x56d/0xe20 fs/read_write.c:1295
 __do_sys_sendfile64 fs/read_write.c:1362 [inline]
 __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1348
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7faa9df7cef9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007faa9ecd0038 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007faa9e135f80 RCX: 00007faa9df7cef9
RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000008
RBP: 00007faa9dfef01e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000800000009 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007faa9e135f80 R15: 00007ffedce9af88
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:btrfs_lookup_csums_list+0xb4/0x1670 fs/btrfs/file-item.c:470
Code: 29 48 89 4c 24 70 42 c7 44 29 08 f3 f3 f3 f3 e8 c2 87 e6 fd 48 89 9c 24 d0 00 00 00 48 81 c3 08 02 00 00 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 bd ce 4d fe 48 8b 03 48 89 44 24
RSP: 0018:ffffc90002e3e9a0 EFLAGS: 00010206
RAX: 0000000000000041 RBX: 0000000000000208 RCX: 0000000000040000
RDX: ffffc9000b549000 RSI: 000000000000a5b2 RDI: 000000000000a5b3
RBP: ffffc90002e3eb48 R08: 0000000000000000 R09: 1ffff11003fdd00d
R10: dffffc0000000000 R11: ffffed1003fdd00e R12: 0000000000000000
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff88804bd20208
FS:  00007faa9ecd06c0(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055716bdec748 CR3: 0000000012478000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	29 48 89             	sub    %ecx,-0x77(%rax)
   3:	4c 24 70             	rex.WR and $0x70,%al
   6:	42 c7 44 29 08 f3 f3 	movl   $0xf3f3f3f3,0x8(%rcx,%r13,1)
   d:	f3 f3
   f:	e8 c2 87 e6 fd       	call   0xfde687d6
  14:	48 89 9c 24 d0 00 00 	mov    %rbx,0xd0(%rsp)
  1b:	00
  1c:	48 81 c3 08 02 00 00 	add    $0x208,%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 bd ce 4d fe       	call   0xfe4dcef6
  39:	48 8b 03             	mov    (%rbx),%rax
  3c:	48                   	rex.W
  3d:	89                   	.byte 0x89
  3e:	44                   	rex.R
  3f:	24                   	.byte 0x24


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

