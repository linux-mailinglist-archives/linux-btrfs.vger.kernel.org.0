Return-Path: <linux-btrfs+bounces-10157-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 872AA9E9225
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2024 12:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 313202816A1
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2024 11:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A0D21A95F;
	Mon,  9 Dec 2024 11:27:21 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ACC21A949
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Dec 2024 11:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733743640; cv=none; b=V5W+Ky/3rywZsssfp1VkuInr8drEG/5YxPgLKU/G8oys0cmGkqzwiQd8soj89JsmXzMuF5uotjOMtUXXksPT62IHKvaBJpYAO1tGTNSK03lBScWK0G+oCMn4SK/9AcwKOHFjE4mlXzn5VLdibloU+l91xI3Do0r9LvMuSxiEYCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733743640; c=relaxed/simple;
	bh=LymESyap2Jr0IPdMbtWzAEqhhxWo56xbwD1jFWC+POU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VqsCL6UgXeYWtIGJrheywtxa6+/6lW7w2vGwXu845Dg5Up71uH9vrJ+JsrNhFVYkB5Z6liuqw9Og3KgXTz6vk43CAby7e4fmuTQLvzgpF1uswGIMuNx1Kpdbk3+V2kt7udrKDHXF8bHZis+H4IebLO0Crpwy9HP7LMHx+vE4vgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-841a4a82311so379231039f.2
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Dec 2024 03:27:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733743638; x=1734348438;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MosYc9NFJ7u0yHaCjqbNaiejO6U/Z7jIozFDMWSROLM=;
        b=nbmE25RJn3sZQcE5CUs/k5seVaXx53GQyiwi9ImmwFUA76oHA2PD1HO7A0ET3c33to
         KdGXSQHztSnwaFcVchg/PGcup8anZBnd4fHRDDGeTUElxCYKo8aQrk4asAjcl3s9Y+al
         vQOEbrvIm26WmsXys2UbphrN4cF7yFh9Enucq1UQdO/3OZVJE0tJROGDoD/xHTv1aD4a
         181LuPDtkUs82bUy7srolj0e8mJgebzNnnY9e42jX0PXESIB9rxNP2PfTVnVi3LuKDlU
         n2/c8Y3tyas9baMrn313GmcHiGs0s3a1Zf25+h28yFJOdQXfUKXDh5S2SASWyCbpX2VS
         M8DA==
X-Forwarded-Encrypted: i=1; AJvYcCVaQS+2EX0hjld+zpzMEcxytZakYCUwdDmAIlh2XuSNNqOhubsGQxu3zDfTy/hdqEAVTUnWg0/TDwFNhg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzntnJcQvxYHLIsiUIw9mGgEo+jcyaoXtDM6DmdsAM90Q8Frrop
	x+HXI/DEwi/nkmqsJoxpqiufxqWNOI+vGXYKz6sjF7zAPXbDnQTbeRAGYi9jEVvTL9/2WP9YXGS
	tHMeguOSB0KugsB133UnFIMC11jNoQhTwBJVIMOYQFRrv5/dBZZMXEQM=
X-Google-Smtp-Source: AGHT+IGUbC7wd6Labx1X1YH9LvRur9QfRf/qLrD07R08fdzQCAKMGe6vr+4cmVTyB+SyxWUh9pIG7o/eYUVydnCNQ0wDvtAgG6RA
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3cc:b0:841:a73b:a978 with SMTP id
 ca18e2360f4ac-844b519bf43mr18085439f.7.1733743638139; Mon, 09 Dec 2024
 03:27:18 -0800 (PST)
Date: Mon, 09 Dec 2024 03:27:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6756d416.050a0220.2477f.0041.GAE@google.com>
Subject: [syzbot] [btrfs?] general protection fault in prelim_ref_insert
From: syzbot <syzbot+af426748c95aef4f003e@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5076001689e4 Merge tag 'loongarch-fixes-6.13-1' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=129dade8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50c7a61469ce77e7
dashboard link: https://syzkaller.appspot.com/bug?extid=af426748c95aef4f003e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-50760016.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/76ef343a98c8/vmlinux-50760016.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e42b3235bcc3/bzImage-50760016.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+af426748c95aef4f003e@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
BTRFS: device fsid ed167579-eb65-4e76-9a50-61ac97e9b59d devid 1 transid 8 /dev/loop0 (7:0) scanned by syz.0.0 (5320)
BTRFS info (device loop0): first mount of filesystem ed167579-eb65-4e76-9a50-61ac97e9b59d
BTRFS info (device loop0): using sha256 (sha256-avx2) checksum algorithm
BTRFS info (device loop0): rebuilding free space tree
BTRFS info (device loop0): disabling free space tree
BTRFS info (device loop0): clearing compat-ro feature flag for FREE_SPACE_TREE (0x1)
BTRFS info (device loop0): clearing compat-ro feature flag for FREE_SPACE_TREE_VALID (0x2)
BTRFS info (device loop0): balance: start -d -m
BTRFS info (device loop0): relocating block group 6881280 flags data|metadata
BTRFS info (device loop0): relocating block group 5242880 flags data|metadata
BTRFS info (device loop0): found 9 extents, stage: move data extents
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 0 UID: 0 PID: 5320 Comm: syz.0.0 Not tainted 6.13.0-rc1-syzkaller-00036-g5076001689e4 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:do_perf_trace_btrfs__prelim_ref include/trace/events/btrfs.h:1926 [inline]
RIP: 0010:perf_trace_btrfs__prelim_ref+0x32d/0x7b0 include/trace/events/btrfs.h:1926
Code: fd e9 b3 02 00 00 e8 02 c1 e7 fd ba 10 00 00 00 48 89 df 31 f6 e8 93 ab 52 fe 4c 89 64 24 08 49 8d 5e 18 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 df e8 a4 a8 52 fe 4c 8b 23 49 8d 5d 18
RSP: 0018:ffffc9000d3dee00 EFLAGS: 00010206
RAX: 0000000000000003 RBX: 0000000000000018 RCX: ffffffff83b7b10d
RDX: 0000000000000010 RSI: ffff888045b0b000 RDI: ffffe8ffffc47ba0
RBP: ffffc9000d3def00 R08: 764e65eb797516ed R09: 9db5e997ac61509a
R10: 764e65eb797516ed R11: 9db5e997ac61509a R12: ffff88801fc376e0
R13: ffffe8ffffc47b98 R14: 0000000000000000 R15: dffffc0000000000
FS:  00007fef5110b6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055891b663b30 CR3: 00000000405ae000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 trace_btrfs_prelim_ref_insert include/trace/events/btrfs.h:1976 [inline]
 prelim_ref_insert+0x1064/0x1250 fs/btrfs/backref.c:327
 add_prelim_ref fs/btrfs/backref.c:414 [inline]
 add_direct_ref fs/btrfs/backref.c:424 [inline]
 add_inline_refs fs/btrfs/backref.c:1084 [inline]
 find_parent_nodes+0x5fb2/0x7bd0 fs/btrfs/backref.c:1485
 btrfs_find_all_leafs+0xca/0x2c0 fs/btrfs/backref.c:1709
 add_data_references+0x275/0x1330 fs/btrfs/relocation.c:3412
 relocate_block_group+0x6bb/0xd40 fs/btrfs/relocation.c:3669
 btrfs_relocate_block_group+0x77d/0xd90 fs/btrfs/relocation.c:4081
 btrfs_relocate_chunk+0x12c/0x3b0 fs/btrfs/volumes.c:3494
 __btrfs_balance+0x1b0f/0x26b0 fs/btrfs/volumes.c:4278
 btrfs_balance+0xbdc/0x10c0 fs/btrfs/volumes.c:4655
 btrfs_ioctl_balance+0x493/0x7c0 fs/btrfs/ioctl.c:3670
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fef5037ff19
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fef5110b058 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fef50545fa0 RCX: 00007fef5037ff19
RDX: 0000000020000180 RSI: 00000000c4009420 RDI: 0000000000000006
RBP: 00007fef503f3986 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fef50545fa0 R15: 00007fff11d5d158
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:do_perf_trace_btrfs__prelim_ref include/trace/events/btrfs.h:1926 [inline]
RIP: 0010:perf_trace_btrfs__prelim_ref+0x32d/0x7b0 include/trace/events/btrfs.h:1926
Code: fd e9 b3 02 00 00 e8 02 c1 e7 fd ba 10 00 00 00 48 89 df 31 f6 e8 93 ab 52 fe 4c 89 64 24 08 49 8d 5e 18 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 df e8 a4 a8 52 fe 4c 8b 23 49 8d 5d 18
RSP: 0018:ffffc9000d3dee00 EFLAGS: 00010206
RAX: 0000000000000003 RBX: 0000000000000018 RCX: ffffffff83b7b10d
RDX: 0000000000000010 RSI: ffff888045b0b000 RDI: ffffe8ffffc47ba0
RBP: ffffc9000d3def00 R08: 764e65eb797516ed R09: 9db5e997ac61509a
R10: 764e65eb797516ed R11: 9db5e997ac61509a R12: ffff88801fc376e0
R13: ffffe8ffffc47b98 R14: 0000000000000000 R15: dffffc0000000000
FS:  00007fef5110b6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055891b663b30 CR3: 00000000405ae000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	fd                   	std
   1:	e9 b3 02 00 00       	jmp    0x2b9
   6:	e8 02 c1 e7 fd       	call   0xfde7c10d
   b:	ba 10 00 00 00       	mov    $0x10,%edx
  10:	48 89 df             	mov    %rbx,%rdi
  13:	31 f6                	xor    %esi,%esi
  15:	e8 93 ab 52 fe       	call   0xfe52abad
  1a:	4c 89 64 24 08       	mov    %r12,0x8(%rsp)
  1f:	49 8d 5e 18          	lea    0x18(%r14),%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 a4 a8 52 fe       	call   0xfe52a8dd
  39:	4c 8b 23             	mov    (%rbx),%r12
  3c:	49 8d 5d 18          	lea    0x18(%r13),%rbx


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

