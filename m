Return-Path: <linux-btrfs+bounces-19711-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 21266CBB0DD
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Dec 2025 16:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0ACC030680E0
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Dec 2025 15:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE65B266B72;
	Sat, 13 Dec 2025 15:21:30 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oa1-f77.google.com (mail-oa1-f77.google.com [209.85.160.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D498261388
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Dec 2025 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765639290; cv=none; b=R11g2sr0fWSXl8raiNNeR9kc99N/ohz/AOF0v1eyZqGpIpb9FdCiEomICFGoj33nEEZZosY7Upa8d6fAPcMv+YPfXJQx2LCF6jBLkhRGYiEtb5WSzQzsAdliKvLx9Ch0hpCpiDZRFT/tMt+NGVnhg0l0OowPNb/ZZj53cVsYUs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765639290; c=relaxed/simple;
	bh=6nxnvIOCnFcUJH8y6lSNVoo0VQvAYg2pnef1EB0raC8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UorM0JddTZnbbEWCJW3Yt4p/M47IAS6QRswAsxtkwpnhy/5eB7SUf+eHuwFcAS5/AZj38BiEIUiQ7kDRZHnHvSehoPNGU1qXmGDI4JaWYNQIWWlJnlbTWmf1+L9HTVWigNJhNBeGGk/zeEE1TngllIhDjqIIKvHw5+WfZ+0jz08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f77.google.com with SMTP id 586e51a60fabf-3ec7afb4b7aso1367355fac.0
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Dec 2025 07:21:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765639287; x=1766244087;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v6646dTGt0wBfhjZHGVhd2o6KAEMbcTH+hoJ0/cqknA=;
        b=ISlVePSbUIYylbId4ELWgaFI2cf1iy2BsIQA+WFKMeLE/N61xfcisvJZSqL5FdbiVT
         bnNuAQ+FdzcCYcsTdp6Vj5jBolTr60uGSvmXFcH2IB1X6FFKx0awGfRpSHfvIwxsQJUA
         grkF2X2mJHeUl59jWUmPa2Z8GRPQsu7twXEINozfQXJMD44oHw2pY4ydfp0V0PDyQViz
         8jy9O457EJe7XRqxd0nMqHG+yhGLxXg9j0RbO2ttTmARmYvn6993a0VG50LkkYc1mBR+
         rRNYYVqrLk+01d80LSWbEpUsbA4wJmO0R8K/xCU4oIEXd4B1YTvkfnbUs2sxSll7XKjg
         zHNg==
X-Forwarded-Encrypted: i=1; AJvYcCWTSrWP4Ao8yj3DQT+EQS97RSpHgCTKdyqJtz7/MfmDLxgfllviNv22hWpKj60td3Uslz/Fyt6ebGbGGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfjdNfRd8yyMxy0e31k0FKF8swHSBStYXLdGDst2wsO4km9T4T
	Uz5DZ+EosozWvFQ+05Qme+E6+fqyE4AUvMk/5nmEMvKMqVPBUZ/7knjJK4MWJEzpnndZ03OxIsD
	ZDovGLQzpIcyxGBIyEBTGB+sd+uNeCzLMlJRhG9vJCEm3/E6+Qio2zzpw+mU=
X-Google-Smtp-Source: AGHT+IEnNBdSrPKcszOaOAbwSniBiOs1W/24IGnpaiD7mvlxkykqc9izbQ/GSpLnVzMwseiad1ih/tW9nwgsPMyRQKDj+U4vUC8a
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:16a3:b0:659:9a49:8e4b with SMTP id
 006d021491bc7-65b451b0c0emr2666485eaf.27.1765639287756; Sat, 13 Dec 2025
 07:21:27 -0800 (PST)
Date: Sat, 13 Dec 2025 07:21:27 -0800
In-Reply-To: <000000000000e93ea70620fe777a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <693d8477.050a0220.326d2b.0003.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in __btrfs_free_extent (3)
From: syzbot <syzbot+480676efc0c3a76b5214@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, nogikh@google.com, 
	quwenruo.btrfs@gmx.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    9551a26f17d9 Merge tag 'loongarch-6.19' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=104f1e1a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f315601b98a91c0b
dashboard link: https://syzkaller.appspot.com/bug?extid=480676efc0c3a76b5214
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=144f1e1a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1525f1c2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b23c812ec291/disk-9551a26f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8b0564ab1672/vmlinux-9551a26f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b8aac5f6fcdb/bzImage-9551a26f.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/a5ef4ee7676b/mount_0.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=11027592580000)
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/5770d00b6a18/mount_5.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=1125f1c2580000)
mounted in repro #3: https://storage.googleapis.com/syzbot-assets/3eefe4d56574/mount_9.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+480676efc0c3a76b5214@syzkaller.appspotmail.com

BTRFS info (device loop0): trying to use backup root at mount time
BTRFS info (device loop0): force zstd compression, level 3
BTRFS info (device loop0): balance: start -d -m
BTRFS info (device loop0): relocating block group 6881280 flags data|metadata
BTRFS info (device loop0): relocating block group 5242880 flags data|metadata
------------[ cut here ]------------
BTRFS: Transaction aborted (error -28)
WARNING: fs/btrfs/extent-tree.c:3235 at 0x0, CPU#0: syz.0.22/6065
Modules linked in:
CPU: 0 UID: 0 PID: 6065 Comm: syz.0.22 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:__btrfs_free_extent+0x1d84/0x3f40 fs/btrfs/extent-tree.c:3235
Code: ae 0b 00 00 e8 4d ef e3 fd 84 c0 0f 84 99 02 00 00 e8 80 16 fe fd e9 97 0b 00 00 e8 76 16 fe fd 48 8d 3d df 0f 21 0b 44 89 e6 <67> 48 0f b9 3a e9 87 e9 ff ff e8 2d dc 10 07 89 c3 31 ff 89 c6 e8
RSP: 0018:ffffc90003b66f40 EFLAGS: 00010293
RAX: ffffffff83c25bca RBX: 0000000000000000 RCX: ffff88802e535ac0
RDX: 0000000000000000 RSI: 00000000ffffffe4 RDI: ffffffff8ee36bb0
RBP: ffffc90003b670f0 R08: ffff88802e535ac0 R09: 0000000000000003
R10: 0000000000000100 R11: 00000000fffffffb R12: 00000000ffffffe4
R13: dffffc0000000000 R14: 00000000ffffffe4 R15: ffff888033d40001
FS:  00007f6ffbc8e6c0(0000) GS:ffff888126d06000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcfb92bce9c CR3: 0000000028020000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 run_one_delayed_ref fs/btrfs/extent-tree.c:-1 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1973 [inline]
 __btrfs_run_delayed_refs+0xe6a/0x3af0 fs/btrfs/extent-tree.c:2048
 btrfs_run_delayed_refs+0xe6/0x3a0 fs/btrfs/extent-tree.c:2160
 btrfs_commit_transaction+0x28b/0x3b10 fs/btrfs/transaction.c:2229
 prepare_to_relocate+0x3a1/0x490 fs/btrfs/relocation.c:3479
 relocate_block_group+0x132/0xd70 fs/btrfs/relocation.c:3504
 btrfs_relocate_block_group+0x580/0xba0 fs/btrfs/relocation.c:3966
 btrfs_relocate_chunk+0x12f/0x5d0 fs/btrfs/volumes.c:3424
 __btrfs_balance+0x190e/0x24f0 fs/btrfs/volumes.c:4197
 btrfs_balance+0xac2/0x11b0 fs/btrfs/volumes.c:4571
 btrfs_ioctl_balance+0x3d6/0x610 fs/btrfs/ioctl.c:3525
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xff/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6ffc61f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6ffbc8e038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f6ffc875fa0 RCX: 00007f6ffc61f749
RDX: 0000200000000180 RSI: 00000000c4009420 RDI: 0000000000000004
RBP: 00007f6ffc6a3f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f6ffc876038 R14: 00007f6ffc875fa0 R15: 00007ffc98ea0f28
 </TASK>
----------------
Code disassembly (best guess):
   0:	ae                   	scas   %es:(%rdi),%al
   1:	0b 00                	or     (%rax),%eax
   3:	00 e8                	add    %ch,%al
   5:	4d ef                	rex.WRB out %eax,(%dx)
   7:	e3 fd                	jrcxz  0x6
   9:	84 c0                	test   %al,%al
   b:	0f 84 99 02 00 00    	je     0x2aa
  11:	e8 80 16 fe fd       	call   0xfdfe1696
  16:	e9 97 0b 00 00       	jmp    0xbb2
  1b:	e8 76 16 fe fd       	call   0xfdfe1696
  20:	48 8d 3d df 0f 21 0b 	lea    0xb210fdf(%rip),%rdi        # 0xb211006
  27:	44 89 e6             	mov    %r12d,%esi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	e9 87 e9 ff ff       	jmp    0xffffe9bb
  34:	e8 2d dc 10 07       	call   0x710dc66
  39:	89 c3                	mov    %eax,%ebx
  3b:	31 ff                	xor    %edi,%edi
  3d:	89 c6                	mov    %eax,%esi
  3f:	e8                   	.byte 0xe8


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

